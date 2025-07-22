-- Database Creation and Selection
CREATE DATABASE DBProject;
USE DBProject;

-- DROP TABLE Statements
/*
DROP TABLE IF EXISTS CrewAssignment;
DROP TABLE IF EXISTS Discount;
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Flights;
DROP TABLE IF EXISTS Aircraft;
DROP TABLE IF EXISTS Airport;
DROP TABLE IF EXISTS Airline;
DROP TABLE IF EXISTS Passenger;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS CrewMembers;
*/

-- Table Creation: Student
CREATE TABLE Student (
    StudentID VARCHAR(50) PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Phone_Number VARCHAR(15) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Nationality VARCHAR(50) NOT NULL,
    Passport_number INT(10) NOT NULL,
    Department VARCHAR(100) NOT NULL,
    College VARCHAR(30) NOT NULL,
    University VARCHAR(30) NOT NULL,
    Address VARCHAR(50) NOT NULL
);

-- Student Data Insertion and Description
describe Student;

INSERT INTO Student (StudentID, First_Name, Last_Name, Phone_Number, Email, Nationality, Passport_number, Department, College, University, Address)
VALUES
    ("1381/16", "Gemachis", "Tesfaye", "+251976601074", "gemachistesfaye36@gmail.com", "Ethiopian", 1232, "Information Science", "CCI", "Haramaya", "Adaama"),
    ("8109/16", "Fikru", "Hailu", "+251916033870", "fikruhailu65@gmail.com", "Ethiopian", 3248, "Software Engineering", "CCI", "Haramaya", "Arbaminch"),
    ("3678/15", "Daniel", "John", "+251956038671", "danjogn2024@gmail.com", "Kenyan", 4578, "Economics", "FBE", "Haramaya", "Nairobi"),
    ("0867/17", "Sisaay", "Tasew", "+251956038672", "sistasew398@gmail.com", "Ethiopian", 9675, "Statistics", "CCI", "Haramaya", "Bishoftu");

select* from Student;

-- Table Creation: Passenger
CREATE TABLE Passenger (
    passengerID INT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Phone_Number VARCHAR(15) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Address VARCHAR(50) NOT NULL,
    Nationality VARCHAR(50) NOT NULL,
    Passport_number INT(10) NOT NULL
);

-- Alter Passenger Table by Add StudentID and Foreign Key
ALTER TABLE Passenger
ADD COLUMN StudentID VARCHAR(50);

ALTER TABLE Passenger
ADD CONSTRAINT FK_Passenger_Student FOREIGN KEY (StudentID) REFERENCES Student(StudentID);

-- Update Passenger Data with StudentID 
UPDATE Passenger
SET StudentID = "1381/16"
WHERE passengerID = 1;

UPDATE Passenger
SET StudentID = "8109/16"
WHERE passengerID = 2;

describe Passenger;

-- Passenger Data Insertion
INSERT INTO Passenger (passengerID, First_Name, Last_Name, Phone_Number, Email, Address, Nationality, Passport_number)
VALUES
    (1, "Samuel", "Tilahun", "+251976601075", "sammy67@gmail.com", "Bishoftu", "Ethiopian", 1223),
    (2, "Hawi", "Desalegn", "+251916033807", "hawwy76@gmail.com", "Dukem", "Ethiopian", 3284),
    (3, "Bonsa", "Horsa", "+251956038617", "boniboni@gmail.com", "Ambo", "Ethiopian", 4587),
    (4, "Yeabsira", "Getachew", "+25195603827", "nard90@gmail.com", "Jimma", "Ethiopian", 9657);
    
select* from Passenger;

-- Table Creation of Airport
CREATE TABLE Airport (
    AirportID INT PRIMARY KEY,
    Airport_name VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL
);

describe Airport;

-- Airport Data Insertion
INSERT INTO Airport (AirportID, Airport_name, City, Country)
VALUES
    (201, "Bole International Airport", "Addis Ababa", "Ethiopia"),
    (202, "Hawassa International Airport", "Hawassa", "Ethiopia"),
    (203, "BahirDar International Airport", "BahirDar", "Ethiopia"),
    (204, "Jimma International Airport", "Jimma", "Ethiopia"),
    (205, "Arbaminch International Airport", "Arbaminch", "Ethiopia"),
    (206, "Jomo Kenyata International Airport", "Nairobi", "Kenya");

INSERT INTO Airport VALUES (207, "Dirre Dawa International Airport", "DireDawa", "Ethiopia");

select* from Airport;

-- Table Creation of Aircraft
CREATE TABLE Aircraft (
    AircraftID VARCHAR(10) PRIMARY KEY,
    Aircraft_name VARCHAR(50) NOT NULL,
    Aircraft_model VARCHAR(50) NOT NULL,
    Capacity INT(10) NOT NULL,
    AirportID INT,
    FOREIGN KEY (AirportID) REFERENCES Airport(AirportID)
);

describe Aircraft;

-- Aircraft Data Insertion
INSERT INTO Aircraft (AircraftID, Aircraft_name, Aircraft_model, Capacity, AirportID)
VALUES
    ("ET01", "Boeing", "737 MAX 8", 150, 201),
    ("ET02", "Boeing", "B787-9", 300, 202),
    ("ET03", "Boeing", "777-200LR", 300, 207),
    ("ET04", "Airbus", "A350-1000", 400, 207),
    ("ET05", "Boeing", "747-8", 400, 201),
    ("ET06", "Airbus", "A319-100", 125, 201),
    ("ET07", "Airbus", "A320neo", 180, 201),
    ("GR01", "Airbus", "A380", 500, 206),
    ("GR02", "Boeing", "737", 180, 206);

select* from Aircraft;

-- Table Creation of Airline
CREATE TABLE Airline (
    AirlineID INT PRIMARY KEY,
    Airline_Name VARCHAR(100) NOT NULL,
    Country VARCHAR(50)
);

describe Airline;

-- Airline Data Insertion
INSERT INTO Airline (AirlineID, Airline_Name, Country) VALUES
(111, "Ethiopian Airlines", "Ethiopia"),
(112, "Kenya Airways", "Kenya"),
(113, "Lufthansa", "Germany"),
(114, "Emirates", "UAE");

select* from Airline;

-- Table Creation of Flights
CREATE TABLE Flights (
    flightID INT PRIMARY KEY,
    flight_Number VARCHAR(10),
    airlineID INT,
    starting_airportID INT,
    arrival_airportID INT,
    aircraftID VARCHAR(10),
    starting_time TIME,
    arrival_time TIME,
    FOREIGN KEY (airlineID) REFERENCES Airline(AirlineID),
    FOREIGN KEY (starting_airportID) REFERENCES Airport(AirportID),
    FOREIGN KEY (arrival_airportID) REFERENCES Airport(AirportID),
    FOREIGN KEY (aircraftID) REFERENCES Aircraft(AircraftID)
);

describe Flights;

-- Alter Flights Table 
ALTER TABLE Flights
MODIFY COLUMN flight_Number VARCHAR(10) NOT NULL,
MODIFY COLUMN airlineID INT NOT NULL,
MODIFY COLUMN aircraftID VARCHAR(10) NOT NULL;

-- Flights Data Insertion
INSERT INTO Flights (flightID, flight_Number, airlineID, starting_airportID, arrival_airportID, aircraftID, starting_time, arrival_time)
VALUES
    (51, "ET 706", 111, 201, 206, "ET01", "06:30:00", "17:30:00"),
    (52, "ET 707", 114, 206, 201, "GR01", "14:00:00", "17:30:00"),
    (53, "ET 607", 111, 201, 202, "ET02", "08:10:00", "09:15:00"),
    (54, "ET 607", 111, 201, 203, "ET02", "08:30:00", "09:40:00"),
    (55, "ET 607", 111, 202, 203, "ET01", "16:45:00", "13:20:00"),
    (56, "LH 4000", 114, 206, 204, "GR02", "14:30:00", "17:40:00"),
    (57, "AT 800", 114, 207, 205, "GR02", "14:00:00", "17:45:00"),
    (58, "ET 607", 113, 206, 201, "ET03", "01:00:00", "12:45:00"),
    (59, "ET 607", 111, 201, 205, "ET03", "02:15:00", "04:00:00");

select* from Flights;

-- Table Creation of Bookings
CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    passengerID INT NOT NULL,
    flightID INT NOT NULL,
    BookingDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    SeatNumber VARCHAR(5) NOT NULL,
    BookingClass VARCHAR(50) NOT NULL,
    FOREIGN KEY (passengerID) REFERENCES Passenger(passengerID),
    FOREIGN KEY (flightID) REFERENCES Flights(flightID)
);

describe Bookings;

-- Bookings Data Insertion
INSERT INTO Bookings (BookingID, passengerID, flightID, SeatNumber, BookingClass)
VALUES
    (25001, 1, 51, "7F", "First"),
    (25002, 2, 55, "12D", "Business"),
    (25003, 3, 52, "F30", "First"),
    (25004, 4, 51, "12B", "Economy"),
    (25005, 1, 53, "17F", "First"),
    (25006, 2, 51, "23F", "First");

select* from Bookings;

-- Table Creation of  Discount
CREATE TABLE Discount (
    DiscountID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID VARCHAR(50) NOT NULL,
    DiscountPercentage DECIMAL(5,2) NOT NULL,
    EffectiveDate DATE NOT NULL,
    ExpiryDate DATE NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

describe Discount;

-- Discount Data Insertion
INSERT INTO Discount (StudentID, DiscountPercentage, EffectiveDate, ExpiryDate) VALUES
("1381/16", 15.00, "2024-01-01", "2025-12-31"),
("8109/16", 10.00, "2024-03-15", "2025-03-14"),
("3678/15", 20.00, "2023-11-01", "2024-10-31");

select* from Discount;

-- Table Creation of CrewMembers
CREATE TABLE CrewMembers (
    CrewID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    Phone_Number VARCHAR(15),
    Email VARCHAR(100) UNIQUE
);

describe CrewMembers;

-- CrewMembers Data Insertion
INSERT INTO CrewMembers (First_Name, Last_Name, Role, Phone_Number, Email) VALUES
("Aisha", "Ahmed", "Pilot", "+251911234567", "aisha.ahmed@example.com"),
("Bereket", "Tadesse", "Co-Pilot", "+251912345678", "bereket.tadesse@example.com"),
("Chaltu", "Kebede", "Flight Attendant", "+251913456789", "chaltu.kebede@example.com"),
("David", "Jones", "Flight Attendant", "+251914567890", "david.jones@example.com");

select* from CrewMembers;

-- Table Creation of CrewAssignment
CREATE TABLE CrewAssignment (
    AssignmentID INT PRIMARY KEY AUTO_INCREMENT,
    FlightID INT NOT NULL,
    CrewID INT NOT NULL,
    AssignmentDate DATE NOT NULL,
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID),
    FOREIGN KEY (CrewID) REFERENCES CrewMembers(CrewID)
);

describe CrewAssignment;

-- CrewAssignment Data Insertion
INSERT INTO CrewAssignment (FlightID, CrewID, AssignmentDate) VALUES
(51, 1, "2025-06-10"),
(51, 2, "2025-06-10"),
(51, 3, "2025-06-10"),
(53, 1, "2025-06-11"),
(53, 4, "2025-06-11"),
(55, 2, "2025-06-12");

select* from CrewAssignment;

-- ************************************************************
-- Some Advanced Queries
-- ************************************************************

-- Query 1 -> Student Bookings with Active Discounts
SELECT
    S.StudentID,
    S.First_Name AS StudentFirstName,
    S.Last_Name AS StudentLastName,
    S.Email AS StudentEmail,
    D.DiscountPercentage,
    D.EffectiveDate AS DiscountEffectiveDate,
    D.ExpiryDate AS DiscountExpiryDate,
    P.passengerID,
    P.First_Name AS PassengerFirstName,
    P.Last_Name AS PassengerLastName,
    B.BookingID,
    F.flight_Number,
    AL.Airline_Name,
    SA.City AS DepartureCity,
    AA.City AS ArrivalCity,
    F.starting_time,
    F.arrival_time,
    B.BookingDate,
    B.SeatNumber,
    B.BookingClass
FROM
    Student S
JOIN
    Discount D ON S.StudentID = D.StudentID
LEFT JOIN 
    Passenger P ON S.Passport_number = P.Passport_number
LEFT JOIN
    Bookings B ON P.passengerID = B.passengerID
LEFT JOIN
    Flights F ON B.flightID = F.flightID
LEFT JOIN
    Airline AL ON F.airlineID = AL.AirlineID
LEFT JOIN
    Airport SA ON F.starting_airportID = SA.AirportID
LEFT JOIN
    Airport AA ON F.arrival_airportID = AA.AirportID
WHERE
    CURRENT_DATE() BETWEEN D.EffectiveDate AND D.ExpiryDate
ORDER BY
    S.StudentID, B.BookingDate DESC;

-- Query 2 -> Flight Occupancy and Status
SELECT
    F.flightID,
    F.flight_Number,
    AL.Airline_Name,
    SA.City AS DepartureCity,
    AA.City AS ArrivalCity,
    AC.Aircraft_model,
    AC.Capacity AS AircraftCapacity,
    COALESCE(COUNT(B.BookingID), 0) AS TotalBookings,
    (COALESCE(COUNT(B.BookingID), 0) * 100.0 / AC.Capacity) AS OccupancyPercentage,
    CASE
        WHEN COALESCE(COUNT(B.BookingID), 0) = AC.Capacity THEN 'Full'
        WHEN (COALESCE(COUNT(B.BookingID), 0) * 100.0 / AC.Capacity) >= 80 THEN 'High'
        WHEN (COALESCE(COUNT(B.BookingID), 0) * 100.0 / AC.Capacity) >= 50 THEN 'Medium'
        ELSE 'Low'
    END AS OccupancyStatus
FROM
    Flights F
JOIN
    Airline AL ON F.airlineID = AL.AirlineID
JOIN
    Airport SA ON F.starting_airportID = SA.AirportID
JOIN
    Airport AA ON F.arrival_airportID = AA.AirportID
JOIN
    Aircraft AC ON F.aircraftID = AC.AircraftID
LEFT JOIN
    Bookings B ON F.flightID = B.flightID
GROUP BY
    F.flightID, F.flight_Number, AL.Airline_Name, SA.City, AA.City, AC.Aircraft_model, AC.Capacity
ORDER BY
    OccupancyPercentage DESC, F.flight_Number;

-- Query 3 -> Crew Schedules and Flight Times
SELECT
    CM.CrewID,
    CM.First_Name AS CrewFirstName,
    CM.Last_Name AS CrewLastName,
    CM.Role,
    CA.AssignmentDate,
    F.flight_Number,
    AL.Airline_Name,
    SA.City AS DepartureCity,
    AA.City AS ArrivalCity,
    F.starting_time,
    F.arrival_time,
    TRUNCATE(TIME_TO_SEC(TIMEDIFF(F.arrival_time, F.starting_time)) / 3600, 2) AS FlightDurationHours
FROM
    CrewMembers CM
JOIN
    CrewAssignment CA ON CM.CrewID = CA.CrewID
JOIN
    Flights F ON CA.FlightID = F.flightID
JOIN
    Airline AL ON F.airlineID = AL.AirlineID
JOIN
    Airport SA ON F.starting_airportID = SA.AirportID
JOIN
    Airport AA ON F.arrival_airportID = AA.AirportID
ORDER BY
    CM.Last_Name, CM.First_Name, CA.AssignmentDate, F.starting_time;

-- Query 4 -> Busiest Flight Routes
SELECT
    SA.City AS DepartureCity,
    AA.City AS ArrivalCity,
    COUNT(B.BookingID) AS TotalBookingsForRoute
FROM
    Bookings B
JOIN
    Flights F ON B.flightID = F.flightID
JOIN
    Airport SA ON F.starting_airportID = SA.AirportID
JOIN
    Airport AA ON F.arrival_airportID = AA.AirportID
GROUP BY
    SA.City, AA.City
ORDER BY
    TotalBookingsForRoute DESC
LIMIT 5;
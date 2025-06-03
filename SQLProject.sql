-- 1. Library Table
CREATE TABLE Library (
  LibraryID INT PRIMARY KEY IDENTITY,
  Name NVARCHAR(100) NOT NULL,
  Location NVARCHAR(100),
  ContactNumber VARCHAR(20),
  EstablishedYear INT CHECK (EstablishedYear > 1800)
);

-- 2. Book Table
CREATE TABLE Book (
  BookID INT PRIMARY KEY IDENTITY,
  ISBN VARCHAR(20) UNIQUE NOT NULL,
  Title NVARCHAR(200) NOT NULL,
  Genre VARCHAR(50) CHECK (Genre IN ('Fiction', 'Non-fiction', 'Reference', 'Children')),
  Price DECIMAL(6,2) CHECK (Price > 0),
  IsAvailable BIT DEFAULT 1,
  ShelfLocation NVARCHAR(50),
  LibraryID INT FOREIGN KEY REFERENCES Library(LibraryID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 3. Member Table
CREATE TABLE Member (
  MemberID INT PRIMARY KEY IDENTITY,
  FullName NVARCHAR(100),
  Email VARCHAR(100) UNIQUE,
  Phone VARCHAR(15),
  MembershipDate DATE
);

-- 4. Staff Table
CREATE TABLE Staff (
  StaffID INT PRIMARY KEY IDENTITY,
  FullName NVARCHAR(100),
  Position NVARCHAR(50),
  ContactNumber VARCHAR(15),
  LibraryID INT FOREIGN KEY REFERENCES Library(LibraryID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 5. Loan Table
CREATE TABLE Loan (
  LoanID INT PRIMARY KEY IDENTITY,
  BookID INT FOREIGN KEY REFERENCES Book(BookID) ON DELETE CASCADE,
  MemberID INT FOREIGN KEY REFERENCES Member(MemberID) ON DELETE CASCADE,
  LoanDate DATE,
  DueDate DATE,
  ReturnDate DATE,
  LoanStatus VARCHAR(20) DEFAULT 'Issued' CHECK (LoanStatus IN ('Issued', 'Returned', 'Overdue'))
);

-- 6. Payment Table
CREATE TABLE Payment (
  PaymentID INT PRIMARY KEY IDENTITY,
  LoanID INT FOREIGN KEY REFERENCES Loan(LoanID) ON DELETE CASCADE,
  PaymentDate DATE,
  Amount DECIMAL(6,2) CHECK (Amount > 0),
  PaymentMethod VARCHAR(50) NOT NULL
);

-- 7. Review Table
CREATE TABLE Review (
  ReviewID INT PRIMARY KEY IDENTITY,
  MemberID INT FOREIGN KEY REFERENCES Member(MemberID) ON DELETE CASCADE,
  BookID INT FOREIGN KEY REFERENCES Book(BookID) ON DELETE CASCADE,
  Rating INT CHECK (Rating BETWEEN 1 AND 5),
  ReviewComment NVARCHAR(500) DEFAULT 'No comments',
  ReviewDate DATE
);

-- Insert Libraries
INSERT INTO Library (Name, Location, ContactNumber, EstablishedYear) VALUES
('City Library', 'Downtown', '99887766', 1999),
('University Library', 'Campus Road', '88776655', 2005),
('Community Library', 'West End', '77665544', 2010);

-- Insert Members
INSERT INTO Member (FullName, Email, Phone, MembershipDate) VALUES
('Ali Al-Mahrooqi', 'ali@example.com', '91234567', '2023-01-15'),
('Maha Al-Farsi', 'maha@example.com', '92345678', '2022-12-10'),
('Yusuf Al-Harthy', 'yusuf@example.com', '93456789', '2023-03-05'),
('Fatma Al-Busaidi', 'fatma@example.com', '94567890', '2023-02-20'),
('Salim Al-Lawati', 'salim@example.com', '95678901', '2023-04-01'),
('Layla Al-Rawahi', 'layla@example.com', '96789012', '2023-01-01'),
( 'Amal Al-Raisi', 'amal@example.com', '97890123', '2024-01-10'),
( 'Nasser Al-Hinai', 'nasser@example.com', '98901234', '2024-02-14'),
( 'Sara Al-Azri', 'sara@example.com', '99012345', '2024-03-01');
SET IDENTITY_INSERT Member ON;
 


SET IDENTITY_INSERT Member OFF;

-- Insert Staff
INSERT INTO Staff (FullName, Position, ContactNumber, LibraryID) VALUES
('Khalid Al-Balushi', 'Manager', '98765432', 1),
('Huda Al-Kindi', 'Librarian', '97654321', 1),
('Ahmed Al-Ajmi', 'Assistant', '96543210', 2),
('Reem Al-Siyabi', 'Librarian', '95432109', 3);

-- Insert Books
INSERT INTO Book (ISBN, Title, Genre, Price, ShelfLocation, LibraryID) VALUES
('978-0-123456-47-2', 'The Silent Sea', 'Fiction', 5.99, 'F12', 1),
('978-0-123456-47-3', 'Data Structures', 'Reference', 12.00, 'R34', 1),
('978-0-123456-47-4', 'The Child’s Play', 'Children', 3.50, 'C10', 2),
('978-0-123456-47-5', 'World History', 'Non-fiction', 9.99, 'NF18', 2),
('978-0-123456-47-6', 'Learn SQL', 'Reference', 8.50, 'R10', 1),
('978-0-123456-47-7', 'Story Time', 'Children', 4.00, 'C15', 3),
('978-0-123456-47-8', 'Ethics in AI', 'Non-fiction', 11.50, 'NF22', 3),
('978-0-123456-47-9', 'Night Sky', 'Fiction', 6.75, 'F20', 1),
('978-0-123456-48-0', 'Omani Folktales', 'Fiction', 7.25, 'F08', 2),
('978-0-123456-48-1', 'Chemistry Basics', 'Reference', 10.00, 'R25', 2);

-- Insert Loans
INSERT INTO Loan (BookID, MemberID, LoanDate, DueDate, ReturnDate, LoanStatus) VALUES
(1, 1, '2024-05-01', '2024-05-15', NULL, 'Issued'),
(2, 2, '2024-04-01', '2024-04-15', '2024-04-14', 'Returned'),
(3, 1, '2024-03-01', '2024-03-15', '2024-03-16', 'Overdue'),
(4, 3, '2024-03-10', '2024-03-25', '2024-03-24', 'Returned'),
(5, 4, '2024-05-05', '2024-05-19', NULL, 'Issued'),
(6, 2, '2024-02-01', '2024-02-15', '2024-02-13', 'Returned'),
(7, 5, '2024-01-01', '2024-01-15', '2024-01-15', 'Returned'),
(8, 6, '2024-05-10', '2024-05-24', NULL, 'Issued'),
(9, 3, '2024-04-20', '2024-05-05', NULL, 'Issued'),
(10, 1, '2024-04-10', '2024-04-25', '2024-04-26', 'Overdue');

-- Insert Payments
INSERT INTO Payment (LoanID, PaymentDate, Amount, PaymentMethod) VALUES
(3, '2024-03-18', 2.00, 'Cash'),
(10, '2024-04-28', 1.50, 'Card'),
(7, '2024-01-16', 1.00, 'Cash'),
(6, '2024-02-14', 0.50, 'Online');

-- Insert Reviews
INSERT INTO Review (MemberID, BookID, Rating, ReviewComment, ReviewDate) VALUES
(1, 1, 5, 'Great book!', '2024-05-02'),
(2, 2, 4, 'Very informative.', '2024-04-05'),
(3, 3, 3, 'Good for kids.', '2024-03-05'),
(4, 4, 5, 'Amazing history insights.', '2024-05-06'),
(1, 2, 4, 'Helpful reference.', '2024-05-03'),
(2, 5, 2, 'Too technical.', '2024-04-02');
 INSERT INTO Review (MemberID, BookID, Rating, ReviewComment, ReviewDate)
VALUES 
(1, 2, 5, 'Excellent!', '2024-06-01'),
(2, 2, 5, 'Outstanding!', '2024-06-02'),
(3, 2, 5, 'Loved it!', '2024-06-03');


 

SELECT 
    S.FullName, 
    S.Position, 
    S.ContactNumber
FROM Staff S
JOIN Library L ON S.LibraryID = L.LibraryID
WHERE L.Name = 'City Library';

SELECT L.LoanID, L.BookID, L.LoanDate, L.DueDate, L.LoanStatus
FROM Loan L
JOIN Member M ON L.MemberID = M.MemberID
WHERE M.FullName = 'Ali Al-Mahrooqi';

-- Example: Mark LoanID 5 as returned today
UPDATE Loan
SET ReturnDate = GETDATE(),
    LoanStatus = 'Returned'
WHERE LoanID = 5;
-- Example: Set LoanID 9 to 'Overdue'
UPDATE Loan
SET LoanStatus = 'Overdue'
WHERE LoanID = 9;
-- Delete a review by ID
DELETE FROM Review
WHERE ReviewID = 3;
-- Delete a payment record by ID
DELETE FROM Payment
WHERE PaymentID = 2;

 --1. Delete a Member Who Has Loans
-- This should fail due to FK constraint (if ON DELETE RESTRICT or CASCADE is not used)
DELETE FROM Member
WHERE MemberID = 1;

-- 2. Delete a Member Who Has Reviews
-- Should also fail (same reason: review FK to member)
DELETE FROM Member
WHERE MemberID = 2;

--3. Delete a Book That’s On Loan
-- Try deleting BookID 1 which is currently issued
DELETE FROM Book
WHERE BookID = 1;

-- 4. Delete a Book That Has Reviews
-- Try deleting a book with multiple reviews (e.g., BookID 2)
DELETE FROM Book
WHERE BookID = 2;

-- 5. Insert a Loan for a Non-Existent Member
-- MemberID 999 does not exist
INSERT INTO Loan (BookID, MemberID, LoanDate, DueDate, LoanStatus)
VALUES (1, 999, '2024-06-01', '2024-06-15', 'Issued');

--6. Insert a Loan for a Non-Existent Book
-- BookID 999 does not exist
INSERT INTO Loan (BookID, MemberID, LoanDate, DueDate, LoanStatus)
VALUES (999, 1, '2024-06-01', '2024-06-15', 'Issued');
--7. Update Genre to an Invalid Value
-- 'Sci-Fi' not in CHECK constraint
UPDATE Book
SET Genre = 'Sci-Fi'
WHERE BookID = 1;
-- 8. Insert Payment with Zero or Negative Amount
-- Should violate CHECK (Amount > 0)
INSERT INTO Payment (LoanID, PaymentDate, Amount, PaymentMethod)
VALUES (1, '2024-06-01', -2.00, 'Cash');
--9. Insert Payment with Missing Method
-- Should fail due to NOT NULL constraint on PaymentMethod
INSERT INTO Payment (LoanID, PaymentDate, Amount, PaymentMethod)
VALUES (1, '2024-06-01', 2.00, NULL);
--10. Insert Review for Non-Existent Book or Member
-- BookID and MemberID do not exist
INSERT INTO Review (MemberID, BookID, Rating, ReviewComment, ReviewDate)
VALUES (999, 999, 4, 'Invalid entry', '2024-06-01');
-- 11. Update Foreign Key to Non-Existent Member
UPDATE Loan
SET MemberID = 999
WHERE LoanID = 1;

--SELECT Queries Simulating API Endpoints
 --1. GET /loans/overdue
SELECT 
    L.LoanID, M.FullName, B.Title, L.DueDate
FROM Loan L
JOIN Member M ON L.MemberID = M.MemberID
JOIN Book B ON L.BookID = B.BookID
WHERE L.LoanStatus = 'Overdue';

--2. GET /books/unavailable
UPDATE Book
SET IsAvailable = 0
WHERE BookID = 1;
--To sync availability with loan status :
UPDATE Book
SET IsAvailable = 0
WHERE BookID IN (
    SELECT BookID
    FROM Loan
    WHERE LoanStatus = 'Issued'
);
SELECT BookID, Title
FROM Book
WHERE IsAvailable = 0;

--3. GET /members/top-borrowers
SELECT M.FullName, COUNT(*) AS TotalLoans
FROM Member M
JOIN Loan L ON M.MemberID = L.MemberID
GROUP BY M.FullName;

--4. GET /books/:id/ratings (Example for BookID 4)
SELECT 
    R.ReviewID,
    M.FullName AS Reviewer,
    R.Rating,
    R.ReviewComment,
    R.ReviewDate
FROM Review R
JOIN Member M ON R.MemberID = M.MemberID
WHERE R.BookID = 4;
 
 -- 5. GET /libraries/:id/genres (e.g., LibraryID = 1)
SELECT Genre, COUNT(*) AS TotalBooks
FROM Book
WHERE LibraryID = 1
GROUP BY Genre;

--6. GET /members/inactive
SELECT M.FullName
FROM Member M
LEFT JOIN Loan L ON M.MemberID = L.MemberID
WHERE L.LoanID IS NULL;

--7. GET /payments/summary
SELECT M.FullName, SUM(P.Amount) AS TotalPaid
FROM Payment P
JOIN Loan L ON P.LoanID = L.LoanID
JOIN Member M ON L.MemberID = M.MemberID
GROUP BY M.FullName;

--8. GET /reviews
SELECT 
    R.ReviewID, 
    M.FullName AS Member, 
    B.Title AS Book, 
    R.Rating, 
    R.ReviewComment, 
    R.ReviewDate
FROM Review R
JOIN Member M ON R.MemberID = M.MemberID
JOIN Book B ON R.BookID = B.BookID;

--Part 2:
--1 GET/books/popular
SELECT TOP 3 B.Title, COUNT(L.LoanID) AS TimesLoaned
FROM Book B
JOIN Loan L ON B.BookID = L.BookID
GROUP BY B.Title
ORDER BY TimesLoaned DESC;

--2. GET /members/:id/history (example for MemberID = 4)
SELECT B.Title, L.LoanDate, L.ReturnDate
FROM Loan L
JOIN Book B ON L.BookID = B.BookID
WHERE L.MemberID = 4;

--4. GET /libraries/:id/staff (LibraryID = 1)
SELECT FullName, Position, ContactNumber
FROM Staff
WHERE LibraryID = 1;

--5. GET /books/price-range?min=5&max=15
SELECT Title, Price
FROM Book
WHERE Price BETWEEN 5 AND 15;

--6. GET /loans/active
SELECT M.FullName, B.Title, L.LoanDate
FROM Loan L
JOIN Member M ON L.MemberID = M.MemberID
JOIN Book B ON L.BookID = B.BookID
WHERE L.LoanStatus = 'Issued';

--7. GET /members/with-fines
SELECT DISTINCT M.FullName
FROM Payment P
JOIN Loan L ON P.LoanID = L.LoanID
JOIN Member M ON L.MemberID = M.MemberID;

--8. GET /books/never-reviewed
SELECT B.Title
FROM Book B
LEFT JOIN Review R ON B.BookID = R.BookID
WHERE R.ReviewID IS NULL;

--9. GET /members/:id/loan-history (MemberID = 3)
SELECT B.Title, L.LoanStatus
FROM Loan L
JOIN Book B ON L.BookID = B.BookID
WHERE L.MemberID = 3;

--10. GET /members/inactive
SELECT M.FullName
FROM Member M
LEFT JOIN Loan L ON M.MemberID = L.MemberID
WHERE L.LoanID IS NULL;

--11. GET /books/never-loaned
SELECT B.Title
FROM Book B
LEFT JOIN Loan L ON B.BookID = L.BookID
WHERE L.LoanID IS NULL;

--12. GET /payments
SELECT M.FullName, B.Title, P.Amount, P.PaymentDate
FROM Payment P
JOIN Loan L ON P.LoanID = L.LoanID
JOIN Member M ON L.MemberID = M.MemberID
JOIN Book B ON L.BookID = B.BookID;

--13. GET /loans/overdue
SELECT M.FullName, B.Title, L.DueDate
FROM Loan L
JOIN Member M ON L.MemberID = M.MemberID
JOIN Book B ON L.BookID = B.BookID
WHERE L.LoanStatus = 'Overdue';

--14. GET /books/:id/loan-count (BookID = 4)
SELECT COUNT(*) AS LoanCount
FROM Loan
WHERE BookID = 4;

--15. GET /members/:id/fines (MemberID = 1)
SELECT M.FullName, SUM(P.Amount) AS TotalFines
FROM Payment P
JOIN Loan L ON P.LoanID = L.LoanID
JOIN Member M ON L.MemberID = M.MemberID
WHERE M.MemberID = 4
GROUP BY M.FullName;

--16. GET /libraries/:id/book-stats (LibraryID = 1)
SELECT 
  COUNT(CASE WHEN IsAvailable = 1 THEN 1 END) AS AvailableBooks,
  COUNT(CASE WHEN IsAvailable = 0 THEN 1 END) AS UnavailableBooks
FROM Book
WHERE LibraryID = 1;

--17. GET /reviews/top-rated
SELECT B.Title, COUNT(*) AS ReviewCount, AVG(R.Rating) AS AvgRating
FROM Review R
JOIN Book B ON R.BookID = B.BookID
GROUP BY B.Title;

--Simple Views Practice
CREATE VIEW ViewAvailableBooks AS
SELECT BookID, Title, Price
FROM Book
WHERE IsAvailable = 1;

CREATE VIEW ViewActiveMembers AS
SELECT MemberID, FullName, MembershipDate
FROM Member
WHERE MembershipDate >= DATEADD(YEAR, -1, GETDATE());

CREATE VIEW ViewLibraryContacts AS
SELECT Name, ContactNumber
FROM Library;

SELECT * FROM ViewAvailableBooks;

--Transactions Simulation:
BEGIN TRANSACTION;

BEGIN TRY
    -- 1. Insert loan
    INSERT INTO Loan (BookID, MemberID, LoanDate, DueDate, LoanStatus)
    VALUES (1, 1, GETDATE(), DATEADD(DAY, 14, GETDATE()), 'Issued');

    -- 2. Get LoanID
    DECLARE @LoanID INT = SCOPE_IDENTITY();

    -- 3. Mark book as unavailable
    UPDATE Book
    SET IsAvailable = 0
    WHERE BookID = 1;

    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Transaction failed: ' + ERROR_MESSAGE();
END CATCH;

--Aggregation Queries (5 examples):
-- 1. Count total books per genre
SELECT Genre, COUNT(*) AS TotalBooks
FROM Book
GROUP BY Genre;

-- 2. Average rating per book
SELECT BookID, AVG(Rating) AS AvgRating
FROM Review
GROUP BY BookID;

-- 3. Total fine per member
SELECT M.FullName, SUM(P.Amount) AS TotalFine
FROM Payment P
JOIN Loan L ON P.LoanID = L.LoanID
JOIN Member M ON L.MemberID = M.MemberID
GROUP BY M.FullName;

-- 4. Highest payment ever made
SELECT MAX(Amount) AS HighestPayment
FROM Payment;

-- 5. Number of loans per member
SELECT MemberID, COUNT(*) AS LoanCount
FROM Loan
GROUP BY MemberID;

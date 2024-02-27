/* SELECT(조회)
 * 
 * - 지정된 테이블에서 원하는 데이터를 선택해서 조회하는 SQL
 * 
 * - 작성된 구문에 맞는 행, 열 데이터가 조회됨 
 *  -> 조회된 결과 행의 집합 == RESULT SET(결과 집합)
 * 
 * - RESULT SET은 0행 이상이 포함될 수 있다
 *  -> 조건에 맞는 행이 없을 수도 있기 때문에...
 * */


/* [SELECT 작성법 -1(기초)]
 * 
 * SELECT 컬럼명, 컬럼명, ...
 * FROM 테이블명;
 * 
 * -> 지정된 테이블 모든 행에서 
 * 	  컬럼명이 일치하는 컬럼 값 조회 
 * */


-- EMPLOYEE 테이블에서
-- 모든 행의 사번(EMP_ID), 이름(EMP_NAME), 급여(SALARY), 조회

SELECT EMP_ID, EMP_NAME, SALARY 
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서
-- 모든 행의 이름(EMP_NAME), 입사일(HIRE_DATE), 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;


-- EMPLOYEE 테이블의 모든 행, 모든 컬럼 조회
-- asterisk(*) : 모든, 포함하다를 나타내는 기호
SELECT *
FROM EMPLOYEE;


-- DEPARTMENT 테이블의 부서코드, 부서명 조회

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- DEPARTMENT 테이블의 모든 데이터 조회
SELECT * FROM DEPARTMENT;


---------------------------------------------------------------

/* 컬럼 값 산술 연산 */

-- 컬럼 값 : 행과 열이 교차되는 테이블의 한 칸에 작성된 값

-- SELECT문 작성 시
-- 컬럼명에 산술 연산을 직접 작성하면
-- 조회 결과(RESULT SET)에 연산 결과가 반영되어 조회된다!

-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 급여, 급여 + 100만 조회
SELECT EMP_NAME, SALARY, SALARY + 1000000
FROM EMPLOYEE;    

-- EMPLOYEE 테이블에서
-- 모든 사원의 사번, 이름, 연봉(급여 * 12)조회
SELECT EMP_ID, EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-----------------------------------------------------

/* SYSDATE, SYSTIMESTAMP */
-- (시스템이 나타내고 있는) 현재 시간

-- SYSDATE      : 현재 시간( 년,월,일,시,분,초 )조회
-- SYSTIMESTAMP : 현재 시간( 년,월,일,시,분,초,ms + 지역(local) ) 조회

/* DUAL(DUmmy tABLe) 테이블 : */
-- 가짜 테이블(임시 테이블)
-- 실존하는 테이블이 아님
-- 테이블 데이터가 아닌 단순 데이터 조회 시 사용

SELECT SYSDATE, SYSTIMESTAMP 
FROM DUAL;


/* 날짜 데이터 연산하기 (+, -만 가능! */
--> +1 == 1일 추가
--> -1 == 1일 감소
--> 일 단위로 계산

-- 어제, 현재 시간, 내일, 모레
SELECT SYSDATE -1, SYSDATE, SYSDATE +1, SYSDATE +2
FROM DUAL;


/* 알아 두면 도움 많이됨!! */
-- 현재 시간, 한 시간 후, 1분 후, 30초 후 조회
SELECT SYSDATE, 
		SYSDATE + 1/24,
		SYSDATE + 1/24/60,
		SYSDATE + 1/24/60/60 * 30
FROM DUAL;


/* 날짜 끼리 연산하기 */
-- 날짜 - 날짜 == 일 단위 숫자
-- 1 == 1일 차이, 1.5 == 1일 12시간 차이


-- TO_DATE('문자열', '패턴') : 
-- '문자열'을 '패턴' 형태로 해석해서 DATE 타입으로 변경하는 함수

-- '' : 문자열 리터널 표기법
SELECT '2024-02-26', TO_DATE('2024-02-26', 'YYYY-MM-DD')
FROM DUAL;

-- 오늘 - 어제 (24시간 차이) == 1
SELECT TO_DATE('2024-02-26', 'YYYY-MM-DD')
				- TO_DATE('2024-02-25', 'YYYY-MM-DD')
FROM DUAL;

-- 현재 시간 - 어제 0시 0분 -초 = 1.529525462
SELECT SYSDATE - TO_DATE('2024-02-25', 'YYYY-MM-DD')
FROM DUAL;
-- SYSDATE : 현재 시간을 반환해준다 

-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 입사일, 근무 일수(현재 시간 - 입사일)
SELECT EMP_NAME, HIRE_DATE 입사일, SYSDATE - HIRE_DATE "근무 일수"
FROM EMPLOYEE;

-- CEIL(숫자) : 올림 처리
-- 현재 시간 - 생년월일
SELECT  CEIL((SYSDATE - TO_DATE('2002-01-31', 'YYYY-MM-DD')) / 365)
FROM DUAL;


----------------------------------------------------------------

/* 컬럼명 별칭 지정하기 */

-- 별칭 지정 방법
-- 1) 컬럼명 AS 별칭   :  문자O, 띄어쓰기 X, 특수문자 X
-- 2) 컬럼명 AS "별칭" : 	문자O, 띄어쓰기 O, 특수문자 O
-- 3) 컬럼명 별칭      : 	문자O, 띄어쓰기 X, 특수문자 X
-- 4) 컬럼명 "별칭"    :  문자O, 띄어쓰기 O, 특수문자 O

-- "" 의미 ("" 사이 글자 그대로 인식)
-- 1) 대/소문자 구분
-- 2) 특수문자, 띄어쓰기 인식

--ORACLE에서 문자열은 ''


SELECT CEIL( (SYSDATE - TO_DATE('2002-01-31', 'YYYY-MM-DD')) / 365) AS 나이
FROM DUAL;


-- EMPLOYEE 테이블에서
-- 사번, 사원 이름, 급여, 연봉(급여*12) 조회 
-- 단, 컬럼명은 위에 작성된 그대로 조회
SELECT EMP_ID AS 사번, 
			EMP_NAME AS "사원 이름", 
			SALARY 급여,
			SALARY * 12 "연봉(급여*12)"
FROM EMPLOYEE;

----------------------------------------------------

/* 연결 연산자(||)*/
-- 문자열 이어쓰기 ( + 로 연결 x )

SELECT EMP_ID||EMP_NAME
FROM EMPLOYEE;

-----------------------------------------------------

/* 컬럼명 자리에 리터럴 직접 작성 */
-- 조회 결과(RESULT SET)의 모든 행에
-- 컬럼명 자리에 작성한 리터널 값이 추가된다!

SELECT EMP_NAME, SALARY, '원', 100, SYSDATE
FROM EMPLOYEE;


-----------------------------------------------------

/* DISTINCT(별개의, 전혀 다른) */
--> 중복 제거

-- 조회 결과 집합(RESULT SET)DP
-- 지정된 컬럼의 값이 중복되는 경우
-- 이를 한 번만 표시할 때 사용

-- EMPLOYEE 테이블에서
-- 모든 사원의 부서코드를 조회

SELECT DEPT_CODE
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서
-- 사원이 있는 부서 코드만 조회

-- SELECT * FROM DEPARTMENT;

SELECT DISTINCT DEPT_CODE 
FROM EMPLOYEE;


-- EMPLOYEE 테이블에 존재하는
-- 직급 코드의 종류 조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;


--------------------------------------------------


/******************/
/**** WHERE 절 ****/
/******************/

-- 테이블에서 조건을 충족하는 행을 조회할 때 사용
-- WHERE절에는 조건식(true/false)만 작성

-- 비교 연산자 : >, <, >=, <=, = (같다), !=, <> (같지 않다)
-- 논리 연산자 : AND, OR, NOT


/* [SELECT 작성법 - 2]
 * 
 * SELECT 컬럼명, 컬럼명, ...
 * FROM 테이블명;
 * WHERE 조건식;
 * 
 * -> 지정된 테이블 모든 행에서 
 *   컬럼명이 일치하는 컬럼 값 조회
 * */


-- EMPLOYEE 테이블에서
-- 급여가 300만원을 초과하는 사원의
-- 사번, 이름, 급여, 부서코드 조회

/*3*/ SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
/*1*/ FROM EMPLOYEE
/*2*/ WHERE SALARY > 30000000;

/* FROM절에 지정된 테이블에서 
 * WHERE절로 행을 먼저 추려내고, 추려진 결과 행들 중에서
 * SELECT절에 원하는 컬럼만 조회*/

-- EMPLOYEE 테이블에서 연봉이 5천만원 이하는 사원의
-- 사번, 이름 연봉 조회

SELECT EMP_ID, EMP_NAME, SALARY * 12 연봉
FROM EMPLOYEE
WHERE SALARY * 12 <= 50000000;


-- EMPLOYEE 테이블에서
-- 부서코드가 'D9'이 아닌 사원의
-- 이름, 부서코드, 전화번호 조회

SELECT EMP_NAME, DEPT_CODE , PHONE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D9';



---------------------
/* NULL 비교하기 */
---------------------
-- 컬럼명 = NULL / 컬럼명 != NULL    (X)
	--> =, !=, < 등의 비교 연산자는 값을 비교하는 연산자!!
	--> DB에서 NULL은 값 X, 저장된 값이 없다라는 의미!!!

-- 컬럼명 IS NULL, 컬럼명 IS NOT NULL (O)
	--> 컬럼 값이 존재하지 않는 경우 / 존재하는 경우


-- EMPLOYEE 테이블에서 DEPT_CODE가 없는 사원 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL; -- 2행

-- EMPLOYEE 테이블에서 DEPT_CODE가 있는 사원 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL; -- 21행


-------------------------------------------------

/* 논리 연산자 사용(AND, OR) */

-- EMPLOYEE 테이블에서 
-- 부서 코드가 'D6'인 사원 중
-- 급여가 300만을 초과하는 사원의
-- 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE , SALARY 
FROM   EMPLOYEE
WHERE  DEPT_CODE = 'D6' 
AND    SALARY > 3000000;

-- EMPLOYEE 테이블에서
-- 급여가 300만 이상, 500만 이하인 사원의
-- 사번, 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY 
FROM   EMPLOYEE
WHERE  SALARY >= 3000000 
AND    SALARY <= 5000000; -- 6행


-- EMPLOYEE 테이블에서
-- 급여가 300만 미만 또는 500만 초과인 사원의
-- 사번, 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM 	 EMPLOYEE
WHERE  SALARY < 3000000 
OR 		 SALARY > 5000000; -- 17행

/***************************/
/* 컬럼명 BETWEEN (A) AND (B)*/
/***************************/

-- 컬럼의 값이 A 이상 B 이하면 TRUE
SELECT EMP_ID, EMP_NAME, SALARY
FROM 	 EMPLOYEE
WHERE SALARY BETWEEN 3000000 AND 5000000;


/*******************************/
/* 컬럼명 NOT BETWEEN (A) AND (B)*/
/*******************************/

-- 컬럼의 값이 A 이상 B 이하면 FALSE
	--> A 미만 또는 B 초과 시 TRUE
SELECT EMP_ID, EMP_NAME, SALARY
FROM 	 EMPLOYEE
WHERE SALARY NOT BETWEEN 3000000 AND 5000000;


/* 날짜도 범위 비교 가능!!*/

-- EMPLOYEE 테이블에서
-- 입사일이 '2000-01-01' 부터 '2000-12-31' 사이인 사원의
-- 이름, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN 
  TO_DATE('2000-01-01', 'YYYY-MM-DD')
  AND
  TO_DATE('2000-12-31', 'YYYY-MM-DD');


----------------------------

 
-- EMPLOYEE 테이블에서
-- 부서코드가 'D5', 'D6', 'D9'인 사원의
-- 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
OR    DEPT_CODE = 'D6'
OR    DEPT_CODE = 'D9';


--------------------------------------


/****************************/
/* 컬럼명 IN (값1,값2,값3, ....)*/
/****************************/

-- 컬럼의 값이 () 내 값과 일치하면 TRUE

-- EMPLOYEE 테이블에서
-- 부서코드가 'D5', 'D6', 'D9'인 사원의
-- 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D9'); -- 12행



/********************************/
/* 컬럼명 NOT IN (값1,값2,값3, ....)*/
/********************************/

-- 컬럼의 값이 () 내 값과 일치하면 FALSE
	--> 컬럼의 값이 () 내 값과 일치하지 않으면 TRUE

-- EMPLOYEE 테이블에서
-- 부서코드가 'D5', 'D6', 'D9'인 아닌 사원의
-- 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D5','D6','D9'); -- 9행

--> DEPT_CODE NULL인 사원 2명 제외 
 

/* 위 예제에서 제외된 2명 결과에 추가하는 SQL */
SELECT EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D9')
OR DEPT_CODE IS NULL; -- 11행
 
 
 ----------------------------------------------------

/*  **** LIKE ****
 * 
 * - 비교하려는 값이 특정한 패턴을 만족 시키면(TRUE) 조회하는 연산자
 * 
 * [작성법]
 * WHERE 컬럼명 LIKE '패턴'
 * 
 * - LIKE 패턴( == 와일드 카드  ) 
 * 
 * '%' (포함)
 * - '%A' : 문자열이 앞은 어떤 문자든 포함되고 마지막은 A
 * 			-> A로 끝나는 문자열
 * - 'A%' : A로 시작하는 문자열
 * - '%A%' : A가 포함된 문자열
 *  
 * 
 * '_' (글자 수)
 * - 'A_' : A 뒤에 아무거나 한 글자만 있는 문자열
 *          (AB ,A1, AQ, A가)
 * 
 * - '___A' : A 앞에 아무거나 3글자만 있는 문자열
 */
 
 

-- EMPLOYEE 테이블에서 성이 '전' 씨인 사원의 사번, 이름 조회
SELECT EMP_ID, EMP_NAME 
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';


-- EMPLOYEE 테이블에서 이름이 '수' 로 끝나는 사원의 사번, 이름 조회
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%수';


-- EMPLOYEE 테이블에서 이름에 '하' 가 포함되는 사원의 사번, 이름 조회
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';


-- EMPLOYEE 테이블에서 이름이 '전' 시작, '돈' 끝나는 사원의 사번, 이름 조회
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%돈';


-- EMPLOYEE 테이블에서
-- 전화번호가 '010'으로 시작하는 사원의 이름, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
--WHERE PHONE LIKE '010%'; -- % 버전
WHERE PHONE LIKE '010________';

/*와일드 카드 _, % 같이 사용*/

-- EMPLOYEE 테이블에서
-- EMAIL의 아이디 (@ 앞의 글자)의 글자수가 5글자인 사원의
-- 이름, EMAIL 조회
SELECT EMP_NAME, EMAIL  
FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';

 

-- EMPLOYEE 테이블에서
-- 이메일의 아이디 중 '_' 앞 쪽 글자의 수가 3글자인 사원의
-- 사번, 이름, 이메일 조회
SELECT EMP_ID, EMP_NAME, EMAIL  
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';
 
-- 문제점 : 
-- 기준으로 삼은 문자 '_'와
-- LIKE의 와일드 카드 '_'의 표기범이 동일하여
-- 모든 '_'가 와일드 카드로 인식됨
 --> 앞에 4글자 있고 , 뒤에 아무거나
   -- == 4글자 이상
 
-- 해결 방법 :
-- LIKE의 ESCAPE 옵션 사용하기 
 
--> ESCAPE 옵션 : 와일드 카드의 의미를 벗어나 단순 문자열로 인식
-->   적용 범위 : 특수문자 뒤 한 글자

SELECT EMP_ID, EMP_NAME, EMAIL  
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';
 


------------------------------------------------------------

/* **** ORDER BY 절 ****
 * 
 * - SELECT문의 조회 결과(RESULT SET)를 정렬할 때 사용하는 구문
 * 
 * - *** SELECT구문에서 제일 마지막에 해석된다! ***
 * 
 * [작성법]
 * 3: SELECT 컬럼명 AS 별칭, 컬럼명, 컬럼명, ...
 * 1: FROM 테이블명
 * 2: WHERE 조건식
 * 4: ORDER BY 컬럼명 | 별칭 | 컬럼 순서 [오름/내림 차순] 
 * 	        [NULLS FIRST | LAST]
 * */


-- EMPLOYEE 테이블에서 
-- 모든 사원의 이름, 급여 조회
-- 단, 급여 오름차순으로 정렬
/*2*/SELECT EMP_NAME, SALARY 
/*1*/FROM EMPLOYEE
/*3*/ORDER BY SALARY ASC;  -- ASC(ascending) : 오름차순



-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 급여 조회
-- 단, 급여 내림차순으로 정렬
/*2*/SELECT EMP_NAME, SALARY
/*1*/FROM EMPLOYEE
/*3*/ORDER BY SALARY DESC;  -- DESC(descending) : 내림차순


-- EMPLOYEE 테이블에서
-- 부서코드가 'D5', 'D6', 'D9'인 사원의 
-- 사번, 이름, 부서코드를
-- 부서코드 오름차순으로 조회
SELECT EMP_ID , EMP_NAME , DEPT_CODE 
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D9');
ORDER BY DEPT_CODE; -- ASC 생략 가능(기본 값이다!!!)


/* 컬럼 순서를 이용해 정렬하기 */

-- EMPLOYEE 테이블에서
-- 급여가 300만 이상, 600만 이하인 사원의
-- 사번, 이름, 급여를 이름 내림차순으로 조회

SELECT EMP_ID, EMP_NAME, SALARY 
FROM EMPLOYEE
WHERE SALARY BETWEEN 3000000 AND 6000000
ORDER BY 2 DESC;


/* ORDER BY절에 수식 적용 */
-- EMPLOYEE 테이블에서 이름, 연봉을 연봉 내림차순으로 조회
SELECT EMP_NAME, SALARY * 12  
FROM EMPLOYEE
ORDER BY SALARY * 12 DESC;

-- ** 정렬 시 SELECT절에 작성된 컬럼을
--    그대로 따라 적는 경우가 많다!


/* ORDER BY절에서 별칭 사용 하기*/
--> SELECT절 해석 이후 ORDER BY절이 해석되기 때문에
-- SELECT절에서 해석된 별칭을 ORDER BY절에서 사용할 수 있다

-- EMPLOYEE 테이블에서 이름, 연봉을 연봉 내림차순으로 조회
SELECT EMP_NAME, SALARY * 12 연봉 
FROM EMPLOYEE
ORDER BY 연봉 * 12 DESC;


/* WHERE절 별칭 사용 불가 확인! */

SELECT EMP_NAME, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE 부서코드 = 'D6';
-- ORA-00904: "부서코드": 부적합한 식별자
 --> "부서코드" 컬럼이 존재하지 않음
 



 /* NULLS FIRST / LAST 옵션 적용하기 */

-- 모든 사원의 이름, 전화번호 조회

-- 오름차순 + NULLS FIRST (NULL인 경우 제일 위에)
SELECT EMP_NAME, PHONE FROM EMPLOYEE
ORDER BY PHONE NULLS FIRST;



-- 오름차순 + NULLS FIRST (NULL인 경우 제일 아래)
SELECT EMP_NAME, PHONE FROM EMPLOYEE
ORDER BY PHONE /*NULLS LAST*/; -- 기본 값


-- 내림차순 + NULLS FIRST (NULL인 경우 제일 위에)
SELECT EMP_NAME, PHONE FROM EMPLOYEE
ORDER BY PHONE DESC NULLS FIRST; -- 정렬 기준 -> NULL 위치 순서대로 해석



/**** 정렬 중첩 ****/
-- 먼저 작성된 정렬 기준을 깨지않고
-- 다음 작성된 정렬 기준을 적용


-- EMPOYEE 테이블에서
-- 이름, 부서코드, 급여를
-- 부서코드 오름차순, 급여 내림차순으로 조회
SELECT EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
ORDER BY DEPT_CODE, SALARY DESC;


-- EMPLOYEE 테이블에서
-- 이름, 부서코드, 직급코드(JOB_CODE)를
-- 부서코드 오름차순, 직급코드 내림 차순, 이름 오름차순으로 조회
SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
ORDER BY DEPT_CODE, JOB_CODE DESC, EMP_NAME












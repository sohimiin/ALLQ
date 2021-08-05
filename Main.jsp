<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>
<%!
String driver = "com.mysql.jdbc.Driver";
String DB_URL = "jdbc:mysql://localhost:3306/JSPDB";
String DB_USER = "root";
String DB_PASSWORD = "llhy18";
Connection conn = null;
Statement stmt;
ResultSet rs;
%>
<!DOCTYPE html>
<html>
        <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=0.8">
                <title>ALL Q</title>
                <style>
form {  
        margin-top: 15%;
        position: absolute;
        left: 50%; 
        transform: translate(-50%);
}

.div {
        height: 20%; /*40*/
        width: 112%; /*250*/
        border: 1px solid #6699FF;
        background: #ffffff;
        float: right;
}

input {
        font-size: 16px;
        width: 90%; /*220*/
        padding: 10px;
        border: 0px;
        outline: none;
        float: left;
}

button {
        width: 100%;
        height: 40px;
        border: 0px;
        background: #6699FF;
        color: #ffffff;
}

}

select {
        border: 1px solid #6699FF;
        width: 70%;
        height: 40px;
}

.cell {
        padding: 5%;
}

#pin {
        position : absolute;
}

        </style>
        </head>
        <body>
                <form>
                        <%
                        List<Integer> x = new ArrayList<Integer>();
                        List<Integer> y = new ArrayList<Integer>();
                        %>
                        <%
                        String category = request.getParameter("category");
                        String brand = request.getParameter("brand");

                        try{
      String query0 = "SELECT * FROM Product WHERE Category LIKE '%" + category + "%' AND (Brand LIKE '%" + brand + "%' OR Name LIKE '%" + brand + "%')";
                        String query1 = "SELECT * FROM Product WHERE (Brand LIKE '%" + brand + "%' OR Name LIKE '%" + brand + "%')";

                        Class.forName(driver);
                        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                        stmt = conn.createStatement();
                        if(category == null)
                                rs = stmt.executeQuery(query1);
                        if(category != null)
                                rs = stmt.executeQuery(query0);

                        while(rs.next()){
                                x.add(rs.getInt(4));
                                y.add(rs.getInt(5));
                        }

                        } catch(Exception e){
                                e.printStackTrace();
                        }
                        finally{

                                try{
                                        if(rs != null) rs.close();
                                        if(stmt != null) stmt.close();
                                        if(conn != null) conn.close();
                        }catch(Exception e2){
                                e2.printStackTrace();
                                }
                        }
                        %>
                                <table>
                                <tr>
                                        <td><select name="category">
                                                        <option value="" selected disabled hidden >카테고리</option>
                                                        <option value="Eye">Eye</option>
                                                        <option value="Lip">Lip</option>
                                                        <option value="Base">Base</option>
                                                        <option value="Body">Body</option>
                                                        <option value="Hair">Hair</option>
                                                        <option value="Make Up">Make Up</option>
                                                        <option value="Pad/Mask">Pad/Mask</option>
                                                        <option value="Cleansing">Cleansing</option>
                                                        <option value="Hand Cream">Hand Cream</option>
                                                        <option value="Facial Care">Facial Care</option>
                                                        <option value="Men''s Care">Men's Care</option>
                                                        <option value="Dental Care">Dental Care</option>
                                                        <option value="Health Care">Health Care</option>
                                                        <option value="Beauty Tools">Beauty Tools</option>
                                                        <option value="Snack">Snack</option>
                                                        <option value="향수">향수</option>
                                                        <option value="생리대">생리대</option>
                                                        <option value="피부건강">피부건강</option>
                                                </select></td>
                                                <td>
                                                        <div class="div">
                                                                <input type="text" name="brand" placeholder="브랜드나 상품명을 입력하세요.">
                                                        </div>
                                                </td>
                                                <td>
                                                        <button>검색</button>
                                                </td>
                                </tr>
                                <tr>
                                        <td class="cell"></td>
                                </tr>
                                <tr>
                                        <td id="add" colspan="3"><img src="image\floor_plan2.png" alt="도면">
                                                        <img id="pin">
                                                                <script>
                                                                      var x = <%= x%>;
                                                                      var y = <%= y%>;          
                                                                      //document.write(x + ", " + y);

                                                                      var pin;
                                                                      var img;
                                                                      var id = "pin";
                                                                      var i=0;
                                                                      
                                                                      while(i < x.length){                       
                                                                                pin = document.getElementById(id);

                                                                                if(x[270] == 0 && y[270] == 0)
                                                                                        pin.style.display = "none";
                                                                                
                                                                                else{
                                                                                        pin.setAttribute("src", "image/marker.png");
                                                                                        pin.style.left = x[i] + 'px';
                                                                                        pin.style.top = y[i] + 'px';
                                                                                        img = document.createElement("img");
                                                                                        img.style.position = "absolute";
                                                                                        if(i != x.length-1)
                                                                                                document.getElementById("add").append(img);
                                                                                        else
                                                                                                break;
                                                                                }       
                                                                                i++;
                                                                                id = "pin" + i;
                                                                                img.setAttribute("id", id);
                                                                        }
                                                </script>
                                        </td>
                                </tr>
                        </table>
                </form>
        </body>
</html>

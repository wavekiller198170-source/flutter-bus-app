import 'package:flutter/material.dart';

void main() {
  runApp(StudentBusApp());
}

class StudentBusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'باصات السلام',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Tajawal',
      ),
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationTitle;
  late Animation<double> _animationTrust;
  late Animation<double> _animationComfort;
  late Animation<double> _animationSafety;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _animationTitle = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    _animationTrust = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 0.5, curve: Curves.easeIn),
      ),
    );

    _animationComfort = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 0.7, curve: Curves.easeIn),
      ),
    );

    _animationSafety = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.7, 0.9, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegistrationScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _animationTitle,
              child: Column(
                children: [
                  Text(
                    'مرحباً بك في',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'باصات السلام',
                    style: TextStyle(
                      fontSize: 42,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildValueItem('ثقة', _animationTrust),
                SizedBox(width: 30),
                _buildValueItem('راحة', _animationComfort),
                SizedBox(width: 30),
                _buildValueItem('أمان', _animationSafety),
              ],
            ),

            SizedBox(height: 80),

            FadeTransition(
              opacity: _animationSafety,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValueItem(String text, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('تسجيل الدخول'),
        backgroundColor: Colors.blue[900],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              size: 80,
              color: Colors.blue[900],
            ),
            SizedBox(height: 30),
            Text(
              'اختر نوع حسابك',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 20),

            _buildRoleCard(
              'طالب',
              Icons.person,
              'شاهد الجداول وQR Code',
              Colors.green,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentHomeScreen(
                      studentName: 'أحمد محمد',
                      studentGrade: 'الصف العاشر',
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 15),

            _buildRoleCard(
              'سائق',
              Icons.drive_eta,
              'مسح QR Code وإدارة الرحلات',
              Colors.orange,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DriverHomeScreen(),
                  ),
                );
              },
            ),

            SizedBox(height: 15),

            _buildRoleCard(
              'إدارة',
              Icons.admin_panel_settings,
              'لوحة التحكم والإحصائيات',
              Colors.purple,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminHomeScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(String title, IconData icon, String subtitle, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, size: 40, color: color),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}

class StudentHomeScreen extends StatelessWidget {
  final String studentName;
  final String studentGrade;

  StudentHomeScreen({required this.studentName, required this.studentGrade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('باصات السلام - الطالب'),
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () {
              _showQRCodeDialog(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      child: Icon(Icons.person, color: Colors.blue[900]),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'مرحباً, $studentName',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'الصف: $studentGrade',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
            _buildSubscriptionStatus(),
            SizedBox(height: 20),

            Text(
              'جدول الرحلات الفصلي',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: _buildScheduleList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionStatus() {
    return Card(
      color: Colors.green[50],
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.verified, color: Colors.green, size: 30),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مشترك فصل دراسي',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  Text(
                    'صالح حتى: 30/06/2024',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleList() {
    List<Map<String, String>> schedule = [
      {'time': '07:00 ص', 'from': 'الموقف A', 'to': 'الجامعة', 'type': 'ذهاب'},
      {'time': '07:30 ص', 'from': 'الموقف B', 'to': 'الجامعة', 'type': 'ذهاب'},
      {'time': '02:00 م', 'from': 'الجامعة', 'to': 'الموقف A', 'type': 'إياب'},
      {'time': '02:30 م', 'from': 'الجامعة', 'to': 'الموقف B', 'type': 'إياب'},
      {'time': '04:00 م', 'from': 'الجامعة', 'to': 'الموقف A', 'type': 'إياب'},
    ];

    return ListView.builder(
      itemCount: schedule.length,
      itemBuilder: (context, index) {
        final trip = schedule[index];
        return Card(
          margin: EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: Icon(
              trip['type'] == 'ذهاب' ? Icons.school : Icons.home,
              color: trip['type'] == 'ذهاب' ? Colors.blue : Colors.orange,
            ),
            title: Text('${trip['from']} → ${trip['to']}'),
            subtitle: Text('الوقت: ${trip['time']}'),
            trailing: Chip(
              label: Text(
                trip['type']!,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: trip['type'] == 'ذهاب' ? Colors.blue : Colors.orange,
            ),
          ),
        );
      },
    );
  }

  void _showQRCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('QR Code الخاص بك'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Icon(Icons.qr_code, size: 100, color: Colors.green),
                    SizedBox(height: 10),
                    Text(
                      studentName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'الصف: $studentGrade',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '✅ مشترك فصل دراسي',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'اعرض هذا الكود للسائق عند الصعود',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }
}

class DriverHomeScreen extends StatefulWidget {
  @override
  _DriverHomeScreenState createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  List<Student> students = [
    Student(name: 'أحمد محمد', grade: 'الصف العاشر', paymentStatus: 'مدفوع', isPresent: false),
    Student(name: 'سارة خالد', grade: 'الصف الحادي عشر', paymentStatus: 'نقدي', isPresent: false),
    Student(name: 'محمد علي', grade: 'الصف العاشر', paymentStatus: 'مدفوع', isPresent: false),
    Student(name: 'فاطمة حسن', grade: 'الصف الثاني عشر', paymentStatus: 'نقدي', isPresent: false),
    Student(name: 'خالد إبراهيم', grade: 'الصف الحادي عشر', paymentStatus: 'متأخر', isPresent: false),
  ];

  int get presentCount => students.where((s) => s.isPresent).length;
  int get totalCount => students.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('باصات السلام - السائق'),
        backgroundColor: Colors.orange[800],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RegistrationScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: _startQRScan,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange[800]),
              child: Text(
                'قائمة السائق',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('قائمة الطلاب'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('الإعدادات'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('العودة'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(16),
            color: Colors.orange[50],
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('المجموع', '$totalCount', Icons.people),
                  _buildStatItem('الحاضرون', '$presentCount', Icons.check_circle),
                  _buildStatItem('النسبة', '${((presentCount / totalCount) * 100).toStringAsFixed(0)}%', Icons.percent),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'قائمة الطلاب',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[800],
                  ),
                ),
                Spacer(),
                Text(
                  'المسح: انقر على أي طالب',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return _buildStudentCard(student, index);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startQRScan,
        child: Icon(Icons.qr_code_scanner, size: 30),
        backgroundColor: Colors.orange[800],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.orange[800], size: 30),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange[800],
          ),
        ),
        Text(
          title,
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildStudentCard(Student student, int index) {
    Color statusColor = Colors.grey;
    IconData statusIcon = Icons.pending;

    if (student.paymentStatus == 'مدفوع') {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
    } else if (student.paymentStatus == 'نقدي') {
      statusColor = Colors.orange;
      statusIcon = Icons.attach_money;
    } else if (student.paymentStatus == 'متأخر') {
      statusColor = Colors.red;
      statusIcon = Icons.warning;
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: student.isPresent ? Colors.green : Colors.grey[300],
          child: Icon(
            student.isPresent ? Icons.check : Icons.person,
            color: student.isPresent ? Colors.white : Colors.grey[600],
          ),
        ),
        title: Text(student.name),
        subtitle: Text(student.grade),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(statusIcon, color: statusColor),
            SizedBox(width: 8),
            Text(
              student.paymentStatus,
              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        onTap: () {
          _simulateQRScan(student, index);
        },
      ),
    );
  }

  void _startQRScan() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('مسح QR Code'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.qr_code_scanner, size: 80, color: Colors.orange[800]),
              SizedBox(height: 20),
              Text(
                'ضع الكاميرا أمام QR Code الطالب',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'في النسخة التجريبية، انقر على اسم الطالب في القائمة',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }

  void _simulateQRScan(Student student, int index) {
    setState(() {
      students[index] = student.copyWith(isPresent: true);
    });

    // تأثير النجاح
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(Duration(milliseconds: 1500), () {
          Navigator.pop(context);
        });

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, size: 80, color: Colors.green),
                SizedBox(height: 20),
                Text(
                  'تم المسح بنجاح!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  student.name,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 5),
                Text(
                  'حالة الدفع: ${student.paymentStatus}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// شاشة الإدارة الرئيسية
class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('باصات السلام - الإدارة'),
        backgroundColor: Colors.purple[800],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RegistrationScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقة الإحصائيات السريعة
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'نظرة عامة',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[800],
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildAdminStatItem('الطلاب', '247', Icons.people, Colors.blue),
                        _buildAdminStatItem('السائقين', '15', Icons.drive_eta, Colors.green),
                        _buildAdminStatItem('الباصات', '12', Icons.directions_bus, Colors.orange),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildAdminStatItem('الرحلات', '38', Icons.route, Colors.red),
                        _buildAdminStatItem('الحضور', '94%', Icons.check_circle, Colors.teal),
                        _buildAdminStatItem('الإيرادات', 'ليرة 45,800', Icons.attach_money, Colors.purple),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            Text(
              'لوحة التحكم',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple[800],
              ),
            ),
            SizedBox(height: 10),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildAdminFeatureCard(
                    'إدارة الطلاب',
                    Icons.people,
                    Colors.blue,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminStudentsScreen()),
                      );
                    },
                  ),
                  _buildAdminFeatureCard(
                    'إدارة السائقين',
                    Icons.drive_eta,
                    Colors.green,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminDriversScreen()),
                      );
                    },
                  ),
                  _buildAdminFeatureCard(
                    'إدارة الباصات',
                    Icons.directions_bus,
                    Colors.orange,
                    () {
                      _showComingSoon(context);
                    },
                  ),
                  _buildAdminFeatureCard(
                    'جدول الرحلات',
                    Icons.schedule,
                    Colors.purple,
                    () {
                      _showComingSoon(context);
                    },
                  ),
                  _buildAdminFeatureCard(
                    'التقارير والإحصائيات',
                    Icons.analytics,
                    Colors.red,
                    () {
                      _showComingSoon(context);
                    },
                  ),
                  _buildAdminFeatureCard(
                    'الإشعارات',
                    Icons.notifications,
                    Colors.teal,
                    () {
                      _showComingSoon(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminStatItem(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 30),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildAdminFeatureCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('قريباً'),
          content: Text('هذه الميزة قيد التطوير وسيتم إضافتها قريباً.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('موافق'),
            ),
          ],
        );
      },
    );
  }
}

// شاشة إدارة الطلاب
class AdminStudentsScreen extends StatelessWidget {
  final List<Map<String, String>> students = [
    {'name': 'أحمد محمد', 'grade': 'الصف العاشر', 'subscription': 'مشترك', 'bus': 'باص ١'},
    {'name': 'سارة خالد', 'grade': 'الصف الحادي عشر', 'subscription': 'مشترك', 'bus': 'باص ٢'},
    {'name': 'محمد علي', 'grade': 'الصف العاشر', 'subscription': 'منتهي', 'bus': 'باص ١'},
    {'name': 'فاطمة حسن', 'grade': 'الصف الثاني عشر', 'subscription': 'مشترك', 'bus': 'باص ٣'},
    {'name': 'خالد إبراهيم', 'grade': 'الصف الحادي عشر', 'subscription': 'مشترك', 'bus': 'باص ٢'},
    {'name': 'نورة سالم', 'grade': 'الصف العاشر', 'subscription': 'غير مشترك', 'bus': '--'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('إدارة الطلاب'),
        backgroundColor: Colors.blue[800],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddStudentDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // حقل البحث
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ابحث عن طالب...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // قائمة الطلاب
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      child: Icon(Icons.person, color: Colors.blue[800]),
                    ),
                    title: Text(student['name']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('الصف: ${student['grade']}'),
                        Text('الباص: ${student['bus']}'),
                      ],
                    ),
                    trailing: Chip(
                      label: Text(
                        student['subscription']!,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      backgroundColor: student['subscription'] == 'مشترك' 
                          ? Colors.green 
                          : student['subscription'] == 'منتهي' 
                            ? Colors.orange 
                            : Colors.red,
                    ),
                    onTap: () {
                      _showStudentDetails(context, student);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddStudentDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[800],
      ),
    );
  }

  void _showStudentDetails(BuildContext context, Map<String, String> student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('تفاصيل الطالب'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('الاسم: ${student['name']}'),
              Text('الصف: ${student['grade']}'),
              Text('الباص: ${student['bus']}'),
              Text('حالة الاشتراك: ${student['subscription']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('إغلاق'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('تعديل'),
            ),
          ],
        );
      },
    );
  }

  void _showAddStudentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('إضافة طالب جديد'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'اسم الطالب',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'الصف',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'رقم الهاتف',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showSuccessMessage(context, 'تم إضافة الطالب بنجاح');
              },
              child: Text('حفظ'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// شاشة إدارة السائقين
class AdminDriversScreen extends StatelessWidget {
  final List<Map<String, String>> drivers = [
    {'name': 'علي أحمد', 'bus': 'باص ١', 'phone': '0551234567', 'status': 'نشط'},
    {'name': 'خالد محمد', 'bus': 'باص ٢', 'phone': '0557654321', 'status': 'نشط'},
    {'name': 'سعيد حسن', 'bus': 'باص ٣', 'phone': '0559876543', 'status': 'إجازة'},
    {'name': 'فهد سلمان', 'bus': 'باص ٤', 'phone': '0554567890', 'status': 'نشط'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('إدارة السائقين'),
        backgroundColor: Colors.green[800],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddDriverDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ابحث عن سائق...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: drivers.length,
              itemBuilder: (context, index) {
                final driver = drivers[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green[100],
                      child: Icon(Icons.drive_eta, color: Colors.green[800]),
                    ),
                    title: Text(driver['name']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('الباص: ${driver['bus']}'),
                        Text('الهاتف: ${driver['phone']}'),
                      ],
                    ),
                    trailing: Chip(
                      label: Text(
                        driver['status']!,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      backgroundColor: driver['status'] == 'نشط' ? Colors.green : Colors.orange,
                    ),
                    onTap: () {
                      _showDriverDetails(context, driver);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDriverDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green[800],
      ),
    );
  }

  void _showDriverDetails(BuildContext context, Map<String, String> driver) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('تفاصيل السائق'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('الاسم: ${driver['name']}'),
              Text('الباص: ${driver['bus']}'),
              Text('الهاتف: ${driver['phone']}'),
              Text('الحالة: ${driver['status']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('إغلاق'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('تعديل'),
            ),
          ],
        );
      },
    );
  }

  void _showAddDriverDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('إضافة سائق جديد'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'اسم السائق',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'رقم الهاتف',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'الباص المخصص',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showSuccessMessage(context, 'تم إضافة السائق بنجاح');
              },
              child: Text('حفظ'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class Student {
  final String name;
  final String grade;
  final String paymentStatus;
  final bool isPresent;

  Student({
    required this.name,
    required this.grade,
    required this.paymentStatus,
    required this.isPresent,
  });

  Student copyWith({
    String? name,
    String? grade,
    String? paymentStatus,
    bool? isPresent,
  }) {
    return Student(
      name: name ?? this.name,
      grade: grade ?? this.grade,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      isPresent: isPresent ?? this.isPresent,
    );
  }
}
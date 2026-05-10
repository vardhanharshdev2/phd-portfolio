import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

const backgroundColor = Color(0xFFF8FAFC);
const sectionColor = Color(0xFFFFFFFF);
const primaryColor = Color(0xFF0F172A);
const accentColor = Color(0xFF2563EB);
const secondaryText = Color(0xFF475569);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PhD Portfolio',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: accentColor, brightness: Brightness.light),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();

  bool showHeaderName = false;

  final aboutKey = GlobalKey();
  final researchKey = GlobalKey();
  final coursesKey = GlobalKey();
  final teachingKey = GlobalKey();
  final publicationsKey = GlobalKey();
  final achievementsKey = GlobalKey();
  final contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      final shouldShow = scrollController.offset > 250;

      if (shouldShow != showHeaderName) {
        setState(() {
          showHeaderName = shouldShow;
        });
      }
    });
  }

  Future<void> scrollToSection(GlobalKey key) async {
    final context = key.currentContext;

    if (context != null) {
      await Scrollable.ensureVisible(context, duration: const Duration(milliseconds: 700), curve: Curves.easeInOut);
    }
  }

  Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                const SizedBox(height: 90),

                // HERO SECTION
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile = constraints.maxWidth < 900;

                      if (isMobile) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heroImage(),

                            const SizedBox(height: 40),

                            const Text(
                              'Harsh',
                              style: TextStyle(fontSize: 52, fontWeight: FontWeight.bold, color: primaryColor),
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              'PhD Researcher at IIT Bombay',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: accentColor),
                            ),

                            const SizedBox(height: 28),

                            const Text(
                              'Robotics • Control Systems • Soft Robotics • Continuum Robotics',
                              style: TextStyle(fontSize: 18, height: 1.8, color: secondaryText),
                            ),

                            const SizedBox(height: 40),

                            Wrap(
                              spacing: 16,
                              runSpacing: 16,
                              children: [
                                FilledButton(
                                  onPressed: () => scrollToSection(publicationsKey),
                                  style: FilledButton.styleFrom(backgroundColor: accentColor),
                                  child: const Text('View Publications'),
                                ),

                                OutlinedButton(onPressed: () {}, child: const Text('Download CV')),
                              ],
                            ),
                          ],
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Harsh',
                                  style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: primaryColor),
                                ),

                                const SizedBox(height: 24),

                                const Text(
                                  'PhD Researcher at IIT Bombay',
                                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: accentColor),
                                ),

                                const SizedBox(height: 30),

                                const Text(
                                  'Researching nonlinear control, continuum robotics, '
                                  'Cosserat rod theory, robot dynamics, and soft robotic systems.',
                                  style: TextStyle(fontSize: 20, height: 1.9, color: secondaryText),
                                ),

                                const SizedBox(height: 50),

                                Wrap(
                                  spacing: 16,
                                  runSpacing: 16,
                                  children: [
                                    FilledButton(
                                      onPressed: () => scrollToSection(publicationsKey),
                                      style: FilledButton.styleFrom(
                                        backgroundColor: accentColor,
                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                                      ),
                                      child: const Text('View Publications'),
                                    ),

                                    OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                                      ),
                                      child: const Text('Download CV'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 50),

                          Expanded(flex: 2, child: heroImage()),
                        ],
                      );
                    },
                  ),
                ),

                sectionWrapper(
                  key: aboutKey,
                  title: 'About',
                  child: const Text(
                    'I am a PhD researcher at the Centre for Systems and Control, IIT Bombay. '
                    'My research focuses on continuum robotics, nonlinear control, '
                    'robot dynamics, and soft robotic systems.',
                    style: TextStyle(fontSize: 18, height: 1.9, color: secondaryText),
                  ),
                ),

                sectionWrapper(
                  key: researchKey,
                  title: 'Research Interests',
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      researchChip('Continuum Robotics'),
                      researchChip('Soft Robotics'),
                      researchChip('Nonlinear Control'),
                      researchChip('Cosserat Rod Theory'),
                      researchChip('Robot Dynamics'),
                      researchChip('Motion Planning'),
                      researchChip('AI for Robotics'),
                    ],
                  ),
                ),

                sectionWrapper(
                  key: coursesKey,
                  title: 'Courses Studied',
                  child: Column(
                    children: [
                      courseCard(
                        course: 'Advanced Control Systems',
                        semester: 'Autumn 2024',
                        description: 'Nonlinear systems, Lyapunov stability, optimal control, and MPC.',
                      ),

                      courseCard(
                        course: 'Robot Dynamics and Control',
                        semester: 'Spring 2024',
                        description: 'Kinematics, dynamics, trajectory planning, and robot control.',
                      ),

                      courseCard(
                        course: 'Machine Learning',
                        semester: 'Autumn 2023',
                        description: 'Deep learning, optimization, and statistical learning.',
                      ),
                    ],
                  ),
                ),

                sectionWrapper(
                  key: teachingKey,
                  title: 'Teaching Assistant Experience',
                  child: Column(
                    children: [
                      courseCard(
                        course: 'Control Systems',
                        semester: 'Spring 2025',
                        description: 'Conducted tutorials, graded assignments, and guided MATLAB simulations.',
                      ),

                      courseCard(
                        course: 'Robotics',
                        semester: 'Autumn 2024',
                        description: 'Assisted students in robot kinematics and dynamics laboratories.',
                      ),

                      courseCard(
                        course: 'Signals and Systems',
                        semester: 'Spring 2024',
                        description: 'Guided students in transforms and system analysis.',
                      ),
                    ],
                  ),
                ),

                sectionWrapper(
                  key: publicationsKey,
                  title: 'Publications',
                  child: Column(
                    children: [
                      publicationCard(
                        title: 'Nonlinear Modeling and Control of Continuum Robots Using Cosserat Theory',
                        venue: 'IEEE ICRA',
                        year: '2025',
                      ),

                      publicationCard(
                        title: 'Learning-Based Dynamics for Soft Robotic Manipulators',
                        venue: 'IEEE RA-L',
                        year: '2024',
                      ),

                      publicationCard(
                        title: 'Adaptive Control Strategies for Flexible Continuum Manipulators',
                        venue: 'ASME Journal',
                        year: '2024',
                      ),
                    ],
                  ),
                ),

                sectionWrapper(
                  key: achievementsKey,
                  title: 'Achievements',
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      achievementCard(title: 'Best Paper Award', subtitle: 'International Robotics Conference 2025'),

                      achievementCard(title: 'Research Fellowship', subtitle: 'Ministry of Education, India'),

                      achievementCard(title: 'Teaching Excellence Award', subtitle: 'IIT Bombay TA Award'),
                    ],
                  ),
                ),

                // CONTACT
                Container(
                  key: contactKey,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 90),
                  color: sectionColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Contact',
                        style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: primaryColor),
                      ),

                      const SizedBox(height: 30),

                      const Text('Email: harsh@example.com', style: TextStyle(fontSize: 18, color: secondaryText)),

                      const SizedBox(height: 16),

                      const Text('Phone: +91 9876543210', style: TextStyle(fontSize: 18, color: secondaryText)),

                      const SizedBox(height: 16),

                      const Text(
                        'Centre for Systems and Control, IIT Bombay',
                        style: TextStyle(fontSize: 18, color: secondaryText),
                      ),

                      const SizedBox(height: 30),

                      Wrap(
                        spacing: 20,
                        children: [
                          socialLink(title: 'Google Scholar', url: 'https://scholar.google.com'),

                          socialLink(title: 'GitHub', url: 'https://github.com'),

                          socialLink(title: 'LinkedIn', url: 'https://linkedin.com'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // FIXED HEADER
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 90,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.97),
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: showHeaderName ? 1 : 0,
                    child: const Text(
                      'Harsh',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                  ),

                  SizedBox(width: showHeaderName ? 30 : 0),

                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          navButton(title: 'About', onTap: () => scrollToSection(aboutKey)),

                          navButton(title: 'Research', onTap: () => scrollToSection(researchKey)),

                          navButton(title: 'Courses', onTap: () => scrollToSection(coursesKey)),

                          navButton(title: 'Teaching', onTap: () => scrollToSection(teachingKey)),

                          navButton(title: 'Publications', onTap: () => scrollToSection(publicationsKey)),

                          navButton(title: 'Achievements', onTap: () => scrollToSection(achievementsKey)),

                          navButton(title: 'Contact', onTap: () => scrollToSection(contactKey)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget socialLink({required String title, required String url}) {
    return InkWell(
      onTap: () => openUrl(url),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, color: accentColor, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget navButton({required String title, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: primaryColor),
        ),
      ),
    );
  }

  Widget sectionWrapper({required GlobalKey key, required String title, required Widget child}) {
    return Container(
      key: key,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 90),
      decoration: BoxDecoration(
        color: sectionColor,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: primaryColor),
          ),

          const SizedBox(height: 36),

          child,
        ],
      ),
    );
  }

  Widget heroImage() {
    return Container(
      height: 420,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 24, offset: const Offset(0, 10))],
        image: const DecorationImage(
          image: NetworkImage(
            'https://upload.wikimedia.org/wikipedia/commons/2/2e/IITBMainBuildingCROP.jpg?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=original',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget researchChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, color: primaryColor),
      ),
    );
  }

  Widget publicationCard({required String title, required String venue, required String year}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 16, offset: const Offset(0, 6))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.article_outlined, color: accentColor),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
                ),

                const SizedBox(height: 10),

                Text('$venue • $year', style: const TextStyle(color: secondaryText)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget courseCard({required String course, required String semester, required String description}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
          ),

          const SizedBox(height: 10),

          Text(
            semester,
            style: const TextStyle(color: accentColor, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 16),

          Text(description, style: const TextStyle(height: 1.7, color: secondaryText)),
        ],
      ),
    );
  }

  Widget achievementCard({required String title, required String subtitle}) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 16, offset: const Offset(0, 6))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.emoji_events_outlined, color: accentColor),

          const SizedBox(height: 18),

          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
          ),

          const SizedBox(height: 10),

          Text(subtitle, style: const TextStyle(color: secondaryText)),
        ],
      ),
    );
  }
}

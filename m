Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8025A78B146
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjH1NBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjH1NBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:01:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026AE12E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:01:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693227672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dS55/bQ5dKbHN1OhA1WYpdr7p8QVvwXXUTSe4DD/np4=;
        b=cYRqt7Q2GgdKP+rJ9VnTo0n/1reupBcvhpPkbI/QEy5EZgXhsaq9od2p9XoKBZ8uFLlQeC
        mrGt8RWDV5FW49Eu60a7RTkpR7cZyGxLH/W7fN0Lho0vO0MRYzNGuhaRVJ+N8JwvQm5m8b
        sPb4Jiuk3ISyGiTMXVHXcYEBqnY3Nob9b2HJiwxYLxjItcLvE+KebCUUF7psSnGq5/cpnT
        o/Dn8mcp6CcRfucS95hKtmKtpNK1EcxZqzI8qKVC7r83NNHrJFZHEeVkQ8F1++KNv327BS
        mv+Oy0lx5tBFARgj4wd+vu+Xq7DjdBEg5gooLCYEVp/Bcb1Qj2UWKKxnpIHZGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693227672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dS55/bQ5dKbHN1OhA1WYpdr7p8QVvwXXUTSe4DD/np4=;
        b=cvW7QvVLLDQ7q3nBG5xqKllQHthIsc5rWhHzmtWabMl0hQPhgCl3Z2Vz5xmzqaSxLLvzUn
        UYCVDLh5H1CbRWAg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/core for v6.6-rc1
References: <169322654636.420889.373907562030292433.tglx@xen13.tec.linutronix.de>
Message-ID: <169322654880.420889.9261217338657613439.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 28 Aug 2023 15:01:12 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2023-08=
-28

up to:  e0a99a839f04: Documentation: core-api/cpuhotplug: Fix state names


Updates for the CPU hotplug core:

  - Support partial SMT enablement.

    So far the sysfs SMT control only allows to toggle between SMT on and
    off. That's sufficient for x86 which usually has at max two threads
    except for the Xeon PHI platform which has four threads per core.

    Though PowerPC has up to 16 threads per core and so far it's only
    possible to control the number of enabled threads per core via a
    command line option. There is some way to control this at runtime, but
    that lacks enforcement and the usability is awkward.

    This update expands the sysfs interface and the core infrastructure to
    accept numerical values so PowerPC can build SMT runtime control for
    partial SMT enablement on top.

    The core support has also been provided to the PowerPC maintainers who
    added the PowerPC related changes on top.

  - Minor cleanups and documentation updates.

Thanks,

	tglx

------------------>
Anna-Maria Behnsen (1):
      Documentation: core-api/cpuhotplug: Fix state names

Laurent Dufour (2):
      cpu/hotplug: Remove dependancy against cpu_primary_thread_mask
      cpu/SMT: Remove topology_smt_supported()

Michael Ellerman (5):
      cpu/SMT: Move SMT prototypes into cpu_smt.h
      cpu/SMT: Move smt/control simple exit cases earlier
      cpu/SMT: Store the current/max number of threads
      cpu/SMT: Create topology_smt_thread_allowed()
      cpu/SMT: Allow enabling partial SMT states via sysfs

Yue Haibing (1):
      cpu/hotplug: Remove unused function declaration cpu_set_state_online()

Zhang Rui (1):
      cpu/SMT: Fix cpu_smt_possible() comment


 Documentation/ABI/testing/sysfs-devices-system-cpu |   1 +
 Documentation/core-api/cpu_hotplug.rst             |  10 +-
 arch/Kconfig                                       |   3 +
 arch/x86/include/asm/topology.h                    |   4 +-
 arch/x86/kernel/cpu/common.c                       |   2 +-
 arch/x86/kernel/smpboot.c                          |   8 --
 include/linux/cpu.h                                |  26 +---
 include/linux/cpu_smt.h                            |  33 +++++
 include/linux/cpuhotplug.h                         |   2 +-
 kernel/cpu.c                                       | 144 +++++++++++++++----=
--
 10 files changed, 152 insertions(+), 81 deletions(-)
 create mode 100644 include/linux/cpu_smt.h

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentati=
on/ABI/testing/sysfs-devices-system-cpu
index ecd585ca2d50..6dba65fb1956 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -555,6 +555,7 @@ Description:	Control Symmetric Multi Threading (SMT)
 			 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
 			 "on"		  SMT is enabled
 			 "off"		  SMT is disabled
+			 "<N>"		  SMT is enabled with N threads per core.
 			 "forceoff"	  SMT is force disabled. Cannot be changed.
 			 "notsupported"   SMT is not supported by the CPU
 			 "notimplemented" SMT runtime toggling is not
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/=
cpu_hotplug.rst
index e6f5bc39cf5c..b9ae591d0b18 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -395,8 +395,8 @@ multi-instance state the following function is available:
 * cpuhp_setup_state_multi(state, name, startup, teardown)
=20
 The @state argument is either a statically allocated state or one of the
-constants for dynamically allocated states - CPUHP_PREPARE_DYN,
-CPUHP_ONLINE_DYN - depending on the state section (PREPARE, ONLINE) for
+constants for dynamically allocated states - CPUHP_BP_PREPARE_DYN,
+CPUHP_AP_ONLINE_DYN - depending on the state section (PREPARE, ONLINE) for
 which a dynamic state should be allocated.
=20
 The @name argument is used for sysfs output and for instrumentation. The
@@ -588,7 +588,7 @@ notifications on online and offline operations::
 Setup and teardown a dynamically allocated state in the ONLINE section
 for notifications on offline operations::
=20
-   state =3D cpuhp_setup_state(CPUHP_ONLINE_DYN, "subsys:offline", NULL, sub=
sys_cpu_offline);
+   state =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "subsys:offline", NULL, =
subsys_cpu_offline);
    if (state < 0)
        return state;
    ....
@@ -597,7 +597,7 @@ for notifications on offline operations::
 Setup and teardown a dynamically allocated state in the ONLINE section
 for notifications on online operations without invoking the callbacks::
=20
-   state =3D cpuhp_setup_state_nocalls(CPUHP_ONLINE_DYN, "subsys:online", su=
bsys_cpu_online, NULL);
+   state =3D cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "subsys:online",=
 subsys_cpu_online, NULL);
    if (state < 0)
        return state;
    ....
@@ -606,7 +606,7 @@ for notifications on online operations without invoking t=
he callbacks::
 Setup, use and teardown a dynamically allocated multi-instance state in the
 ONLINE section for notifications on online and offline operation::
=20
-   state =3D cpuhp_setup_state_multi(CPUHP_ONLINE_DYN, "subsys:online", subs=
ys_cpu_online, subsys_cpu_offline);
+   state =3D cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "subsys:online", s=
ubsys_cpu_online, subsys_cpu_offline);
    if (state < 0)
        return state;
    ....
diff --git a/arch/Kconfig b/arch/Kconfig
index aff2746c8af2..63c5d6a2022b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -34,6 +34,9 @@ config ARCH_HAS_SUBPAGE_FAULTS
 config HOTPLUG_SMT
 	bool
=20
+config SMT_NUM_THREADS_DYNAMIC
+	bool
+
 # Selected by HOTPLUG_CORE_SYNC_DEAD or HOTPLUG_CORE_SYNC_FULL
 config HOTPLUG_CORE_SYNC
 	bool
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index caf41c4869a0..3235ba1e5b06 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -136,10 +136,11 @@ static inline int topology_max_smt_threads(void)
 	return __max_smt_threads;
 }
=20
+#include <linux/cpu_smt.h>
+
 int topology_update_package_map(unsigned int apicid, unsigned int cpu);
 int topology_update_die_map(unsigned int dieid, unsigned int cpu);
 int topology_phys_to_logical_pkg(unsigned int pkg);
-bool topology_smt_supported(void);
=20
 extern struct cpumask __cpu_primary_thread_mask;
 #define cpu_primary_thread_mask ((const struct cpumask *)&__cpu_primary_thre=
ad_mask)
@@ -162,7 +163,6 @@ static inline int topology_phys_to_logical_pkg(unsigned i=
nt pkg) { return 0; }
 static inline int topology_max_die_per_package(void) { return 1; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return tru=
e; }
-static inline bool topology_smt_supported(void) { return false; }
 #endif /* !CONFIG_SMP */
=20
 static inline void arch_fix_phys_package_id(int num, u32 slot)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 52683fddafaf..12a48a85da3d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2317,7 +2317,7 @@ void __init arch_cpu_finalize_init(void)
 	 * identify_boot_cpu() initialized SMT support information, let the
 	 * core code know.
 	 */
-	cpu_smt_check_topology();
+	cpu_smt_set_num_threads(smp_num_siblings, smp_num_siblings);
=20
 	if (!IS_ENABLED(CONFIG_SMP)) {
 		pr_info("CPU: ");
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index e1aa2cd7734b..d4e897b820c4 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -326,14 +326,6 @@ static void notrace start_secondary(void *unused)
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
=20
-/**
- * topology_smt_supported - Check whether SMT is supported by the CPUs
- */
-bool topology_smt_supported(void)
-{
-	return smp_num_siblings > 1;
-}
-
 /**
  * topology_phys_to_logical_pkg - Map a physical package id to a logical
  * @phys_pkg:	The physical package id to map
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 6e6e57ec69e8..ed56b2534500 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -18,6 +18,7 @@
 #include <linux/compiler.h>
 #include <linux/cpumask.h>
 #include <linux/cpuhotplug.h>
+#include <linux/cpu_smt.h>
=20
 struct device;
 struct device_node;
@@ -190,7 +191,6 @@ void arch_cpu_finalize_init(void);
 static inline void arch_cpu_finalize_init(void) { }
 #endif
=20
-void cpu_set_state_online(int cpu);
 void play_idle_precise(u64 duration_ns, u64 latency_ns);
=20
 static inline void play_idle(unsigned long duration_us)
@@ -204,30 +204,6 @@ void cpuhp_report_idle_dead(void);
 static inline void cpuhp_report_idle_dead(void) { }
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
=20
-enum cpuhp_smt_control {
-	CPU_SMT_ENABLED,
-	CPU_SMT_DISABLED,
-	CPU_SMT_FORCE_DISABLED,
-	CPU_SMT_NOT_SUPPORTED,
-	CPU_SMT_NOT_IMPLEMENTED,
-};
-
-#if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
-extern enum cpuhp_smt_control cpu_smt_control;
-extern void cpu_smt_disable(bool force);
-extern void cpu_smt_check_topology(void);
-extern bool cpu_smt_possible(void);
-extern int cpuhp_smt_enable(void);
-extern int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval);
-#else
-# define cpu_smt_control		(CPU_SMT_NOT_IMPLEMENTED)
-static inline void cpu_smt_disable(bool force) { }
-static inline void cpu_smt_check_topology(void) { }
-static inline bool cpu_smt_possible(void) { return false; }
-static inline int cpuhp_smt_enable(void) { return 0; }
-static inline int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval) { return=
 0; }
-#endif
-
 extern bool cpu_mitigations_off(void);
 extern bool cpu_mitigations_auto_nosmt(void);
=20
diff --git a/include/linux/cpu_smt.h b/include/linux/cpu_smt.h
new file mode 100644
index 000000000000..0c1664294b57
--- /dev/null
+++ b/include/linux/cpu_smt.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CPU_SMT_H_
+#define _LINUX_CPU_SMT_H_
+
+enum cpuhp_smt_control {
+	CPU_SMT_ENABLED,
+	CPU_SMT_DISABLED,
+	CPU_SMT_FORCE_DISABLED,
+	CPU_SMT_NOT_SUPPORTED,
+	CPU_SMT_NOT_IMPLEMENTED,
+};
+
+#if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
+extern enum cpuhp_smt_control cpu_smt_control;
+extern unsigned int cpu_smt_num_threads;
+extern void cpu_smt_disable(bool force);
+extern void cpu_smt_set_num_threads(unsigned int num_threads,
+				    unsigned int max_threads);
+extern bool cpu_smt_possible(void);
+extern int cpuhp_smt_enable(void);
+extern int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval);
+#else
+# define cpu_smt_control               (CPU_SMT_NOT_IMPLEMENTED)
+# define cpu_smt_num_threads 1
+static inline void cpu_smt_disable(bool force) { }
+static inline void cpu_smt_set_num_threads(unsigned int num_threads,
+					   unsigned int max_threads) { }
+static inline bool cpu_smt_possible(void) { return false; }
+static inline int cpuhp_smt_enable(void) { return 0; }
+static inline int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval) { return=
 0; }
+#endif
+
+#endif /* _LINUX_CPU_SMT_H_ */
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 25b6e6e6ba6b..06dda85f0424 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -48,7 +48,7 @@
  *    same section.
  *
  * If neither #1 nor #2 apply, please use the dynamic state space when
- * setting up a state by using CPUHP_PREPARE_DYN or CPUHP_PREPARE_ONLINE
+ * setting up a state by using CPUHP_BP_PREPARE_DYN or CPUHP_AP_ONLINE_DYN
  * for the @state argument of the setup function.
  *
  * See Documentation/core-api/cpu_hotplug.rst for further information and
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 88a7ede322bd..f6811c857102 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -592,7 +592,10 @@ static void lockdep_release_cpus_lock(void)
 void __weak arch_smt_update(void) { }
=20
 #ifdef CONFIG_HOTPLUG_SMT
+
 enum cpuhp_smt_control cpu_smt_control __read_mostly =3D CPU_SMT_ENABLED;
+static unsigned int cpu_smt_max_threads __ro_after_init;
+unsigned int cpu_smt_num_threads __read_mostly =3D UINT_MAX;
=20
 void __init cpu_smt_disable(bool force)
 {
@@ -606,16 +609,33 @@ void __init cpu_smt_disable(bool force)
 		pr_info("SMT: disabled\n");
 		cpu_smt_control =3D CPU_SMT_DISABLED;
 	}
+	cpu_smt_num_threads =3D 1;
 }
=20
 /*
  * The decision whether SMT is supported can only be done after the full
  * CPU identification. Called from architecture code.
  */
-void __init cpu_smt_check_topology(void)
+void __init cpu_smt_set_num_threads(unsigned int num_threads,
+				    unsigned int max_threads)
 {
-	if (!topology_smt_supported())
+	WARN_ON(!num_threads || (num_threads > max_threads));
+
+	if (max_threads =3D=3D 1)
 		cpu_smt_control =3D CPU_SMT_NOT_SUPPORTED;
+
+	cpu_smt_max_threads =3D max_threads;
+
+	/*
+	 * If SMT has been disabled via the kernel command line or SMT is
+	 * not supported, set cpu_smt_num_threads to 1 for consistency.
+	 * If enabled, take the architecture requested number of threads
+	 * to bring up into account.
+	 */
+	if (cpu_smt_control !=3D CPU_SMT_ENABLED)
+		cpu_smt_num_threads =3D 1;
+	else if (num_threads < cpu_smt_num_threads)
+		cpu_smt_num_threads =3D num_threads;
 }
=20
 static int __init smt_cmdline_disable(char *str)
@@ -625,9 +645,23 @@ static int __init smt_cmdline_disable(char *str)
 }
 early_param("nosmt", smt_cmdline_disable);
=20
+/*
+ * For Archicture supporting partial SMT states check if the thread is allow=
ed.
+ * Otherwise this has already been checked through cpu_smt_max_threads when
+ * setting the SMT level.
+ */
+static inline bool cpu_smt_thread_allowed(unsigned int cpu)
+{
+#ifdef CONFIG_SMT_NUM_THREADS_DYNAMIC
+	return topology_smt_thread_allowed(cpu);
+#else
+	return true;
+#endif
+}
+
 static inline bool cpu_smt_allowed(unsigned int cpu)
 {
-	if (cpu_smt_control =3D=3D CPU_SMT_ENABLED)
+	if (cpu_smt_control =3D=3D CPU_SMT_ENABLED && cpu_smt_thread_allowed(cpu))
 		return true;
=20
 	if (topology_is_primary_thread(cpu))
@@ -642,7 +676,7 @@ static inline bool cpu_smt_allowed(unsigned int cpu)
 	return !cpumask_test_cpu(cpu, &cpus_booted_once_mask);
 }
=20
-/* Returns true if SMT is not supported of forcefully (irreversibly) disable=
d */
+/* Returns true if SMT is supported and not forcefully (irreversibly) disabl=
ed */
 bool cpu_smt_possible(void)
 {
 	return cpu_smt_control !=3D CPU_SMT_FORCE_DISABLED &&
@@ -650,22 +684,8 @@ bool cpu_smt_possible(void)
 }
 EXPORT_SYMBOL_GPL(cpu_smt_possible);
=20
-static inline bool cpuhp_smt_aware(void)
-{
-	return topology_smt_supported();
-}
-
-static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
-{
-	return cpu_primary_thread_mask;
-}
 #else
 static inline bool cpu_smt_allowed(unsigned int cpu) { return true; }
-static inline bool cpuhp_smt_aware(void) { return false; }
-static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
-{
-	return cpu_present_mask;
-}
 #endif
=20
 static inline enum cpuhp_state
@@ -1793,6 +1813,16 @@ static int __init parallel_bringup_parse_param(char *a=
rg)
 }
 early_param("cpuhp.parallel", parallel_bringup_parse_param);
=20
+static inline bool cpuhp_smt_aware(void)
+{
+	return cpu_smt_max_threads > 1;
+}
+
+static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
+{
+	return cpu_primary_thread_mask;
+}
+
 /*
  * On architectures which have enabled parallel bringup this invokes all BP
  * prepare states for each of the to be onlined APs first. The last state
@@ -2626,6 +2656,12 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	for_each_online_cpu(cpu) {
 		if (topology_is_primary_thread(cpu))
 			continue;
+		/*
+		 * Disable can be called with CPU_SMT_ENABLED when changing
+		 * from a higher to lower number of SMT threads per core.
+		 */
+		if (ctrlval =3D=3D CPU_SMT_ENABLED && cpu_smt_thread_allowed(cpu))
+			continue;
 		ret =3D cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
 		if (ret)
 			break;
@@ -2660,6 +2696,8 @@ int cpuhp_smt_enable(void)
 		/* Skip online CPUs and CPUs on offline nodes */
 		if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
 			continue;
+		if (!cpu_smt_thread_allowed(cpu))
+			continue;
 		ret =3D _cpu_up(cpu, 0, CPUHP_ONLINE);
 		if (ret)
 			break;
@@ -2838,20 +2876,19 @@ static const struct attribute_group cpuhp_cpu_root_at=
tr_group =3D {
=20
 #ifdef CONFIG_HOTPLUG_SMT
=20
+static bool cpu_smt_num_threads_valid(unsigned int threads)
+{
+	if (IS_ENABLED(CONFIG_SMT_NUM_THREADS_DYNAMIC))
+		return threads >=3D 1 && threads <=3D cpu_smt_max_threads;
+	return threads =3D=3D 1 || threads =3D=3D cpu_smt_max_threads;
+}
+
 static ssize_t
 __store_smt_control(struct device *dev, struct device_attribute *attr,
 		    const char *buf, size_t count)
 {
-	int ctrlval, ret;
-
-	if (sysfs_streq(buf, "on"))
-		ctrlval =3D CPU_SMT_ENABLED;
-	else if (sysfs_streq(buf, "off"))
-		ctrlval =3D CPU_SMT_DISABLED;
-	else if (sysfs_streq(buf, "forceoff"))
-		ctrlval =3D CPU_SMT_FORCE_DISABLED;
-	else
-		return -EINVAL;
+	int ctrlval, ret, num_threads, orig_threads;
+	bool force_off;
=20
 	if (cpu_smt_control =3D=3D CPU_SMT_FORCE_DISABLED)
 		return -EPERM;
@@ -2859,21 +2896,39 @@ __store_smt_control(struct device *dev, struct device=
_attribute *attr,
 	if (cpu_smt_control =3D=3D CPU_SMT_NOT_SUPPORTED)
 		return -ENODEV;
=20
+	if (sysfs_streq(buf, "on")) {
+		ctrlval =3D CPU_SMT_ENABLED;
+		num_threads =3D cpu_smt_max_threads;
+	} else if (sysfs_streq(buf, "off")) {
+		ctrlval =3D CPU_SMT_DISABLED;
+		num_threads =3D 1;
+	} else if (sysfs_streq(buf, "forceoff")) {
+		ctrlval =3D CPU_SMT_FORCE_DISABLED;
+		num_threads =3D 1;
+	} else if (kstrtoint(buf, 10, &num_threads) =3D=3D 0) {
+		if (num_threads =3D=3D 1)
+			ctrlval =3D CPU_SMT_DISABLED;
+		else if (cpu_smt_num_threads_valid(num_threads))
+			ctrlval =3D CPU_SMT_ENABLED;
+		else
+			return -EINVAL;
+	} else {
+		return -EINVAL;
+	}
+
 	ret =3D lock_device_hotplug_sysfs();
 	if (ret)
 		return ret;
=20
-	if (ctrlval !=3D cpu_smt_control) {
-		switch (ctrlval) {
-		case CPU_SMT_ENABLED:
-			ret =3D cpuhp_smt_enable();
-			break;
-		case CPU_SMT_DISABLED:
-		case CPU_SMT_FORCE_DISABLED:
-			ret =3D cpuhp_smt_disable(ctrlval);
-			break;
-		}
-	}
+	orig_threads =3D cpu_smt_num_threads;
+	cpu_smt_num_threads =3D num_threads;
+
+	force_off =3D ctrlval !=3D cpu_smt_control && ctrlval =3D=3D CPU_SMT_FORCE_=
DISABLED;
+
+	if (num_threads > orig_threads)
+		ret =3D cpuhp_smt_enable();
+	else if (num_threads < orig_threads || force_off)
+		ret =3D cpuhp_smt_disable(ctrlval);
=20
 	unlock_device_hotplug();
 	return ret ? ret : count;
@@ -2901,6 +2956,17 @@ static ssize_t control_show(struct device *dev,
 {
 	const char *state =3D smt_states[cpu_smt_control];
=20
+#ifdef CONFIG_HOTPLUG_SMT
+	/*
+	 * If SMT is enabled but not all threads are enabled then show the
+	 * number of threads. If all threads are enabled show "on". Otherwise
+	 * show the state name.
+	 */
+	if (cpu_smt_control =3D=3D CPU_SMT_ENABLED &&
+	    cpu_smt_num_threads !=3D cpu_smt_max_threads)
+		return sysfs_emit(buf, "%d\n", cpu_smt_num_threads);
+#endif
+
 	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
 }
=20


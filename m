Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C277726BF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjHGNyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjHGNxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5E01BE3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:32 -0700 (PDT)
Message-ID: <20230807135028.328142041@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Zpdb7SGU6c8Ds83Kh6nglp1WOfJEA2K/h0y4EGVH3ck=;
        b=3zhhsKnjn1f06wB/Iddtt1yQ5sVtATuFc8l884JKT56Urekwm7qaex2ODQnyN7WGEt64DU
        L5dT2rAVBEsLfkEL0EEq6RjJ+ShazPtlMS5pDLzS1zjcp+ZbnbOzh9SKUxS5K/3m+8+qLu
        2wjCrF/tL5GHm8/QJdVSZFY2Xq0az/xSCVWA6GBVr/+8EQT5F2AAPdsn4wMPj2e2Mp2aey
        Ys2Sjc/WI7C3RK3NMVDbD9+xW1LGPIuVAFlqGbCdSHgn1vIy99ol9yEto++xbOAysRcm5s
        oVbDKBcbrkPVzs8I8bshalr41oGfOcjikfnSvLwadFvf0w1yYMo7EwhmPaTjfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Zpdb7SGU6c8Ds83Kh6nglp1WOfJEA2K/h0y4EGVH3ck=;
        b=bF90uPgwmU54yr4dJrHdYygvIBfMHG6REh98tNXOnnQQZjK1XiMOPwJ/MoqRYgbnrEqwJE
        xLGhx3MhWqDp1VAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: [patch 36/53] x86/cpu/topology: Rework possible CPU management
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:30 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Managing possible CPUs is an unreadable and uncomprehensible maze. Aside of
that it's backwards because it applies command line limits after
registering all APICs.

Rewrite it so that it:

  - Applies the command line limits upfront so that only the allowed amount
    of APIC IDs can be registered.

  - Applies eventual late restrictions in an understandable way

  - Uses simple min_t() calculations which are trivial to follow.

  - Provides a separate function for resetting to UP mode late in the
    bringup process.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h     |    5 +
 arch/x86/include/asm/topology.h |    4 
 arch/x86/kernel/cpu/topology.c  |  176 ++++++++++++++++++++++++----------------
 arch/x86/kernel/setup.c         |    9 --
 arch/x86/kernel/smpboot.c       |    6 -
 5 files changed, 120 insertions(+), 80 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -175,6 +175,9 @@ extern void topology_register_apic(u32 a
 extern void topology_register_boot_apic(u32 apic_id);
 extern int topology_hotplug_apic(u32 apic_id, u32 acpi_id);
 extern void topology_hotunplug_apic(unsigned int cpu);
+extern void topology_apply_cmdline_limits_early(void);
+extern void topology_init_possible_cpus(void);
+extern void topology_reset_possible_cpus_up(void);
 
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
@@ -190,6 +193,8 @@ static inline void apic_intr_mode_init(v
 static inline void lapic_assign_system_vectors(void) { }
 static inline void lapic_assign_legacy_vector(unsigned int i, bool r) { }
 static inline bool apic_needs_pit(void) { return true; }
+static inline void topology_apply_cmdline_limits_early(void) { }
+static inline void topology_init_possible_cpus(void) { }
 #endif /* !CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_X2APIC
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -190,6 +190,9 @@ static inline bool topology_is_primary_t
 {
 	return cpumask_test_cpu(cpu, cpu_primary_thread_mask);
 }
+
+void topology_apply_cmdline_limits_early(void);
+
 #else /* CONFIG_SMP */
 #define topology_max_packages()			(1)
 static inline int
@@ -202,6 +205,7 @@ static inline int topology_max_smt_threa
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
 static inline bool topology_smt_supported(void) { return false; }
 static inline unsigned int topology_amd_nodes_per_pkg(void) { return 0; };
+static inline void topology_apply_cmdline_limits_early(void) { }
 #endif /* !CONFIG_SMP */
 
 static inline void arch_fix_phys_package_id(int num, u32 slot)
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -5,6 +5,7 @@
 #include <xen/xen.h>
 
 #include <asm/apic.h>
+#include <asm/io_apic.h>
 #include <asm/mpspec.h>
 #include <asm/smp.h>
 
@@ -85,73 +86,6 @@ early_initcall(smp_init_primary_thread_m
 static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid) { }
 #endif
 
-static int __initdata setup_possible_cpus = -1;
-
-/*
- * cpu_possible_mask should be static, it cannot change as cpu's
- * are onlined, or offlined. The reason is per-cpu data-structures
- * are allocated by some modules at init time, and don't expect to
- * do this dynamically on cpu arrival/departure.
- * cpu_present_mask on the other hand can change dynamically.
- * In case when cpu_hotplug is not compiled, then we resort to current
- * behaviour, which is cpu_possible == cpu_present.
- * - Ashok Raj
- *
- * Three ways to find out the number of additional hotplug CPUs:
- * - If the BIOS specified disabled CPUs in ACPI/mptables use that.
- * - The user can overwrite it with possible_cpus=NUM
- * - Otherwise don't reserve additional CPUs.
- * We do this because additional CPUs waste a lot of memory.
- * -AK
- */
-__init void prefill_possible_map(void)
-{
-	unsigned int num_processors = topo_info.nr_assigned_cpus;
-	unsigned int disabled_cpus = topo_info.nr_disabled_cpus;
-	int i, possible;
-
-	i = setup_max_cpus ?: 1;
-	if (setup_possible_cpus == -1) {
-		possible = topo_info.nr_assigned_cpus;
-#ifdef CONFIG_HOTPLUG_CPU
-		if (setup_max_cpus)
-			possible += num_processors;
-#else
-		if (possible > i)
-			possible = i;
-#endif
-	} else
-		possible = setup_possible_cpus;
-
-	total_cpus = max_t(int, possible, num_processors + disabled_cpus);
-
-	/* nr_cpu_ids could be reduced via nr_cpus= */
-	if (possible > nr_cpu_ids) {
-		pr_warn("%d Processors exceeds NR_CPUS limit of %u\n",
-			possible, nr_cpu_ids);
-		possible = nr_cpu_ids;
-	}
-
-#ifdef CONFIG_HOTPLUG_CPU
-	if (!setup_max_cpus)
-#endif
-	if (possible > i) {
-		pr_warn("%d Processors exceeds max_cpus limit of %u\n",
-			possible, setup_max_cpus);
-		possible = i;
-	}
-
-	set_nr_cpu_ids(possible);
-
-	pr_info("Allowing %d CPUs, %d hotplug CPUs\n",
-		possible, max_t(int, possible - num_processors, 0));
-
-	reset_cpu_possible_mask();
-
-	for (i = 0; i < possible; i++)
-		set_cpu_possible(i, true);
-}
-
 static int topo_lookup_cpuid(u32 apic_id)
 {
 	int i;
@@ -294,12 +228,114 @@ void topology_hotunplug_apic(unsigned in
 }
 #endif
 
-static int __init _setup_possible_cpus(char *str)
+#ifdef CONFIG_SMP
+static unsigned int max_possible_cpus __initdata = NR_CPUS;
+
+/**
+ * topology_apply_cmdline_limits_early - Apply topology command line limits early
+ *
+ * Ensure that command line limits are in effect before firmware parsing
+ * takes place.
+ */
+void __init topology_apply_cmdline_limits_early(void)
+{
+	unsigned int possible = nr_cpu_ids;
+
+	/* 'maxcpus=0' 'nosmp' 'nolapic' 'disableapic' 'noapic' */
+	if (!setup_max_cpus || ioapic_is_disabled || apic_is_disabled)
+		possible = 1;
+
+	/* 'possible_cpus=N' */
+	possible = min_t(unsigned int, max_possible_cpus, possible);
+
+	if (possible < nr_cpu_ids) {
+		pr_info("Limiting to %u possible CPUs\n", possible);
+		set_nr_cpu_ids(possible);
+	}
+}
+
+static __init bool restrict_to_up(void)
+{
+	if (!smp_found_config || ioapic_is_disabled)
+		return true;
+	/*
+	 * XEN PV is special as it does not advertise the local APIC
+	 * properly, but provides a fake topology for it so that the
+	 * infrastructure works. So don't apply the restrictions vs. APIC
+	 * here.
+	 */
+	if (xen_pv_domain())
+		return false;
+
+	return apic_is_disabled;
+}
+
+void __init topology_init_possible_cpus(void)
+{
+	unsigned int assigned = topo_info.nr_assigned_cpus;
+	unsigned int disabled = topo_info.nr_disabled_cpus;
+	unsigned int total = assigned + disabled;
+	unsigned int cpu, allowed = 1;
+
+	if (!restrict_to_up()) {
+		if (WARN_ON_ONCE(assigned > nr_cpu_ids)) {
+			disabled += assigned - nr_cpu_ids;
+			assigned = nr_cpu_ids;
+		}
+		allowed = min_t(unsigned int, total, nr_cpu_ids);
+	}
+
+	if (total > allowed)
+		pr_warn("%u possible CPUs exceed the limit of %u\n", total, allowed);
+
+	assigned = min_t(unsigned int, allowed, assigned);
+	disabled = allowed - assigned;
+
+	topo_info.nr_assigned_cpus = assigned;
+	topo_info.nr_disabled_cpus = disabled;
+
+	total_cpus = allowed;
+	set_nr_cpu_ids(allowed);
+
+	pr_info("Allowing %u present CPUs plus %u hotplug CPUs\n", assigned, disabled);
+	if (topo_info.nr_rejected_cpus)
+		pr_info("Rejected CPUs %u\n", topo_info.nr_rejected_cpus);
+
+	init_cpu_present(cpumask_of(0));
+	init_cpu_possible(cpumask_of(0));
+
+	for (cpu = 0; cpu < allowed; cpu++) {
+		u32 apicid = cpuid_to_apicid[cpu];
+
+		set_cpu_possible(cpu, true);
+
+		if (apicid == BAD_APICID)
+			continue;
+
+		set_cpu_present(cpu, test_bit(apicid, phys_cpu_present_map));
+	}
+}
+
+/*
+ * Late SMP disable after sizing CPU masks when APIC/IOAPIC setup failed.
+ */
+void __init topology_reset_possible_cpus_up(void)
 {
-	get_option(&str, &setup_possible_cpus);
+	init_cpu_present(cpumask_of(0));
+	init_cpu_possible(cpumask_of(0));
+
+	bitmap_zero(phys_cpu_present_map, MAX_LOCAL_APIC);
+	if (topo_info.boot_cpu_apic_id != BAD_APICID)
+		set_bit(topo_info.boot_cpu_apic_id, phys_cpu_present_map);
+}
+
+static int __init setup_possible_cpus(char *str)
+{
+	get_option(&str, &max_possible_cpus);
 	return 0;
 }
-early_param("possible_cpus", _setup_possible_cpus);
+early_param("possible_cpus", setup_possible_cpus);
+#endif
 
 static int __init apic_set_disabled_cpu_apicid(char *arg)
 {
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1258,6 +1258,8 @@ void __init setup_arch(char **cmdline_p)
 
 	early_quirks();
 
+	topology_apply_cmdline_limits_early();
+
 	/*
 	 * Parse SMP configuration. Try ACPI first and then the platform
 	 * specific parser.
@@ -1265,13 +1267,10 @@ void __init setup_arch(char **cmdline_p)
 	acpi_boot_init();
 	x86_init.mpparse.parse_smp_cfg();
 
-	/*
-	 * Systems w/o ACPI and mptables might not have it mapped the local
-	 * APIC yet, but prefill_possible_map() might need to access it.
-	 */
+	/* Last opportunity to detect and map the local APIC */
 	init_apic_mappings();
 
-	prefill_possible_map();
+	topology_init_possible_cpus();
 
 	init_cpu_to_node();
 	init_gi_nodes();
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1156,11 +1156,7 @@ static __init void disable_smp(void)
 	pr_info("SMP disabled\n");
 
 	disable_ioapic_support();
-
-	init_cpu_present(cpumask_of(0));
-	init_cpu_possible(cpumask_of(0));
-
-	reset_phys_cpu_present_map(smp_found_config ? boot_cpu_physical_apicid : 0);
+	topology_reset_possible_cpus_up();
 
 	cpumask_set_cpu(0, topology_sibling_cpumask(0));
 	cpumask_set_cpu(0, topology_core_cpumask(0));


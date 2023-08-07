Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DBF7726B9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjHGNyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjHGNx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CD81990
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:23 -0700 (PDT)
Message-ID: <20230807135028.056840782@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5w2v+DcqfW564+MRIqjj5F099T2Sc0fxjubzsntwRSI=;
        b=Ye75ISXdxPbTL8S+YKYpZdMBn3JzPrxTwIfg+KtJEc/n820rVbvU189YqDKA2DreJllQ7r
        Or2LfuwWyD30SbikpTo5xBuwJ2zVOoWoOwBUfHdLlw+RZIyHQDE13/Q4bafGsGNgxGEN0b
        /oF4PMRuSHvrjxet/P74SFObjGC/i+AtuCXyf4z6RDc0oqEsU+izFurSjfV9eZPHG6cvci
        Iy66N8WGLO46cdWfkDO4HPy1zOCvDi8gjFFCan4g9b/RRuUhcSGiyL6ipkZRfuHVIQ0TU6
        Ri7aP2/f8E/tAW2uxrEFjv6t/sK7clzTf6bHt3wHFoRRdJBNCgXbUhrh5/TknA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5w2v+DcqfW564+MRIqjj5F099T2Sc0fxjubzsntwRSI=;
        b=Q/565WFP7XeevqcsudIPUkk5Tgiw2my4lE/gwp5m71VBbidnJngr1JqNfin+IU3+ZnbcLN
        YhyRi4Q/UGP03tCg==
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
Subject: [patch 31/53] x86/cpu/topology: Confine topology information
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:22 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all external fiddling with num_processors and disabled_cpus is
gone, move the last user prefill_possible_map() into the topology code too
and remove the global visibility of these variables.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/smp.h          |    3 -
 arch/x86/kernel/apic/apic.c         |    1 
 arch/x86/kernel/cpu/topology.c |   76 +++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/smpboot.c           |   72 ----------------------------------
 4 files changed, 74 insertions(+), 78 deletions(-)

--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -9,7 +9,6 @@
 #include <asm/thread_info.h>
 
 extern int smp_num_siblings;
-extern unsigned int num_processors;
 
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
@@ -178,8 +177,6 @@ static inline struct cpumask *cpu_llc_sh
 }
 #endif /* CONFIG_SMP */
 
-extern unsigned disabled_cpus;
-
 #ifdef CONFIG_DEBUG_NMI_SELFTEST
 extern void nmi_selftest(void);
 #else
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2054,7 +2054,6 @@ void __init init_apic_mappings(void)
 			pr_info("APIC: disable apic facility\n");
 			apic_disable();
 		}
-		num_processors = 1;
 	}
 }
 
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -29,8 +29,8 @@ u32 cpuid_to_apicid[] __read_mostly = {
  */
 static u32 disabled_cpu_apicid __ro_after_init = BAD_APICID;
 
-unsigned int num_processors;
-unsigned disabled_cpus;
+static unsigned int num_processors;
+static unsigned int disabled_cpus;
 
 /*
  * The number of allocated logical CPU IDs. Since logical CPU IDs are allocated
@@ -169,6 +169,71 @@ static int generic_processor_info(int ap
 	return cpu;
 }
 
+static int __initdata setup_possible_cpus = -1;
+
+/*
+ * cpu_possible_mask should be static, it cannot change as cpu's
+ * are onlined, or offlined. The reason is per-cpu data-structures
+ * are allocated by some modules at init time, and don't expect to
+ * do this dynamically on cpu arrival/departure.
+ * cpu_present_mask on the other hand can change dynamically.
+ * In case when cpu_hotplug is not compiled, then we resort to current
+ * behaviour, which is cpu_possible == cpu_present.
+ * - Ashok Raj
+ *
+ * Three ways to find out the number of additional hotplug CPUs:
+ * - If the BIOS specified disabled CPUs in ACPI/mptables use that.
+ * - The user can overwrite it with possible_cpus=NUM
+ * - Otherwise don't reserve additional CPUs.
+ * We do this because additional CPUs waste a lot of memory.
+ * -AK
+ */
+__init void prefill_possible_map(void)
+{
+	int i, possible;
+
+	i = setup_max_cpus ?: 1;
+	if (setup_possible_cpus == -1) {
+		possible = num_processors;
+#ifdef CONFIG_HOTPLUG_CPU
+		if (setup_max_cpus)
+			possible += disabled_cpus;
+#else
+		if (possible > i)
+			possible = i;
+#endif
+	} else
+		possible = setup_possible_cpus;
+
+	total_cpus = max_t(int, possible, num_processors + disabled_cpus);
+
+	/* nr_cpu_ids could be reduced via nr_cpus= */
+	if (possible > nr_cpu_ids) {
+		pr_warn("%d Processors exceeds NR_CPUS limit of %u\n",
+			possible, nr_cpu_ids);
+		possible = nr_cpu_ids;
+	}
+
+#ifdef CONFIG_HOTPLUG_CPU
+	if (!setup_max_cpus)
+#endif
+	if (possible > i) {
+		pr_warn("%d Processors exceeds max_cpus limit of %u\n",
+			possible, setup_max_cpus);
+		possible = i;
+	}
+
+	set_nr_cpu_ids(possible);
+
+	pr_info("Allowing %d CPUs, %d hotplug CPUs\n",
+		possible, max_t(int, possible - num_processors, 0));
+
+	reset_cpu_possible_mask();
+
+	for (i = 0; i < possible; i++)
+		set_cpu_possible(i, true);
+}
+
 /**
  * topology_register_apic - Register an APIC in early topology maps
  * @apic_id:	The APIC ID to set up
@@ -246,6 +311,13 @@ void topology_hotunplug_apic(unsigned in
 }
 #endif
 
+static int __init _setup_possible_cpus(char *str)
+{
+	get_option(&str, &setup_possible_cpus);
+	return 0;
+}
+early_param("possible_cpus", _setup_possible_cpus);
+
 static int __init apic_set_disabled_cpu_apicid(char *arg)
 {
 	if (!arg || !get_option(&arg, &disabled_cpu_apicid))
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1327,78 +1327,6 @@ void __init native_smp_cpus_done(unsigne
 	cache_aps_init();
 }
 
-static int __initdata setup_possible_cpus = -1;
-static int __init _setup_possible_cpus(char *str)
-{
-	get_option(&str, &setup_possible_cpus);
-	return 0;
-}
-early_param("possible_cpus", _setup_possible_cpus);
-
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
-	int i, possible;
-
-	i = setup_max_cpus ?: 1;
-	if (setup_possible_cpus == -1) {
-		possible = num_processors;
-#ifdef CONFIG_HOTPLUG_CPU
-		if (setup_max_cpus)
-			possible += disabled_cpus;
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
 /* correctly size the local cpu masks */
 void __init setup_cpu_local_masks(void)
 {


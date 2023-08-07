Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAF97726B0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbjHGNyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbjHGNxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7291724
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:11 -0700 (PDT)
Message-ID: <20230807135027.640774399@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gEhZQItEgYbVrFDRBJAD0RQQEUzfvs5vg3RCb3nTKps=;
        b=gI9afqNLKqN8rRWmcY8aiUriptc+lxJJ9MO3o4cNPjeqADsrGBk4ycNnw8wKVe7AJ+ajXt
        2iRzkNTnd9KPi90Ro0ZVYuAeMYR7zFEb2YkA057Vgu3qyI1wweZsXhMoJULmlKJG+tnHjF
        BO+kpmcE0/9kF8EePik2Zv87Vx8IfpEScuboJ6Qi1zbqhqAKWbHvfZ662fNefWzVM3yNW+
        JjZuUG+o8gnAZBDmuXpWKOVjTQhEV9aiAHDw2wyAXnirp1k0VSeuqyMn/YvksV4XOnxk3V
        UpSO0o2JhoSXzy8xzQNcyWboVuSVHhtniiMMFDJWSuqTNgaBoP8g7hfiOYWBHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gEhZQItEgYbVrFDRBJAD0RQQEUzfvs5vg3RCb3nTKps=;
        b=0ZhSjBb1mY7ZtLFtG8ub4Ntpeh/Bzya8cwOIHZVrb5/SOV9gWUGx6huUEHcXVGwfivmA0K
        vbs2UkCYkJYLdzDA==
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
Subject: [patch 23/53] x86/cpu/topology: Move registration out of APIC code
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:09 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The APIC/CPU registration sits in the middle of the APIC code. In fact this
is a topology evaluation function and has nothing to do with the inner
workings of the local APIC.

Move it out into a file which reflects what this is about.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h    |    2 
 arch/x86/kernel/apic/apic.c    |  185 -----------------------------------------
 arch/x86/kernel/cpu/Makefile   |   12 +-
 arch/x86/kernel/cpu/topology.c |  184 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 195 insertions(+), 188 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -171,6 +171,8 @@ extern bool apic_needs_pit(void);
 
 extern void apic_send_IPI_allbutself(unsigned int vector);
 
+extern void topology_register_boot_apic(u32 apic_id);
+
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
 #define local_apic_timer_c2_ok		1
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -68,26 +68,12 @@
 
 #include "local.h"
 
-unsigned int num_processors;
-
-unsigned disabled_cpus;
-
 /* Processor that is doing the boot up */
 u32 boot_cpu_physical_apicid __ro_after_init = BAD_APICID;
 EXPORT_SYMBOL_GPL(boot_cpu_physical_apicid);
 
 u8 boot_cpu_apic_version __ro_after_init;
 
-/* Bitmap of physically present CPUs. */
-DECLARE_BITMAP(phys_cpu_present_map, MAX_LOCAL_APIC);
-
-/*
- * Processor to be disabled specified by kernel parameter
- * disable_cpu_apicid=<int>, mostly used for the kdump 2nd kernel to
- * avoid undefined behaviour caused by sending INIT from AP to BSP.
- */
-static u32 disabled_cpu_apicid __ro_after_init = BAD_APICID;
-
 /*
  * This variable controls which CPUs receive external NMIs.  By default,
  * external NMIs are delivered only to the BSP.
@@ -107,14 +93,6 @@ static inline bool apic_accessible(void)
 	return x2apic_mode || apic_mmio_base;
 }
 
-/*
- * Map cpu index to physical APIC ID
- */
-DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_apicid, BAD_APICID);
-DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid, CPU_ACPIID_INVALID);
-EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_apicid);
-EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
-
 #ifdef CONFIG_X86_32
 /* Local APIC was disabled by the BIOS and enabled by the kernel */
 static int enabled_via_apicbase __ro_after_init;
@@ -1676,8 +1654,6 @@ void apic_ap_setup(void)
 	end_local_APIC_setup();
 }
 
-static __init void cpu_set_boot_apic(void);
-
 static __init void apic_read_boot_cpu_id(bool x2apic)
 {
 	/*
@@ -1692,7 +1668,8 @@ static __init void apic_read_boot_cpu_id
 		boot_cpu_physical_apicid = read_apic_id();
 		boot_cpu_apic_version = GET_APIC_VERSION(apic_read(APIC_LVR));
 	}
-	cpu_set_boot_apic();
+	topology_register_boot_apic(boot_cpu_physical_apicid);
+	x86_32_probe_bigsmp_early();
 }
 
 #ifdef CONFIG_X86_X2APIC
@@ -2291,155 +2268,6 @@ void disconnect_bsp_APIC(int virt_wire_s
 	apic_write(APIC_LVT1, value);
 }
 
-/*
- * The number of allocated logical CPU IDs. Since logical CPU IDs are allocated
- * contiguously, it equals to current allocated max logical CPU ID plus 1.
- * All allocated CPU IDs should be in the [0, nr_logical_cpuids) range,
- * so the maximum of nr_logical_cpuids is nr_cpu_ids.
- *
- * NOTE: Reserve 0 for BSP.
- */
-static int nr_logical_cpuids = 1;
-
-/*
- * Used to store mapping between logical CPU IDs and APIC IDs.
- */
-u32 cpuid_to_apicid[] = { [0 ... NR_CPUS - 1] = BAD_APICID, };
-
-bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
-{
-	return phys_id == (u64)cpuid_to_apicid[cpu];
-}
-
-#ifdef CONFIG_SMP
-static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
-{
-	/* Isolate the SMT bit(s) in the APICID and check for 0 */
-	u32 mask = (1U << (fls(smp_num_siblings) - 1)) - 1;
-
-	if (smp_num_siblings == 1 || !(apicid & mask))
-		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
-}
-
-/*
- * Due to the utter mess of CPUID evaluation smp_num_siblings is not valid
- * during early boot. Initialize the primary thread mask before SMP
- * bringup.
- */
-static int __init smp_init_primary_thread_mask(void)
-{
-	unsigned int cpu;
-
-	/*
-	 * XEN/PV provides either none or useless topology information.
-	 * Pretend that all vCPUs are primary threads.
-	 */
-	if (xen_pv_domain()) {
-		cpumask_copy(&__cpu_primary_thread_mask, cpu_possible_mask);
-		return 0;
-	}
-
-	for (cpu = 0; cpu < nr_logical_cpuids; cpu++)
-		cpu_mark_primary_thread(cpu, cpuid_to_apicid[cpu]);
-	return 0;
-}
-early_initcall(smp_init_primary_thread_mask);
-#else
-static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid) { }
-#endif
-
-/*
- * Should use this API to allocate logical CPU IDs to keep nr_logical_cpuids
- * and cpuid_to_apicid[] synchronized.
- */
-static int allocate_logical_cpuid(int apicid)
-{
-	int i;
-
-	/*
-	 * cpuid <-> apicid mapping is persistent, so when a cpu is up,
-	 * check if the kernel has allocated a cpuid for it.
-	 */
-	for (i = 0; i < nr_logical_cpuids; i++) {
-		if (cpuid_to_apicid[i] == apicid)
-			return i;
-	}
-
-	/* Allocate a new cpuid. */
-	if (nr_logical_cpuids >= nr_cpu_ids) {
-		WARN_ONCE(1, "APIC: NR_CPUS/possible_cpus limit of %u reached. "
-			     "Processor %d/0x%x and the rest are ignored.\n",
-			     nr_cpu_ids, nr_logical_cpuids, apicid);
-		return -EINVAL;
-	}
-
-	cpuid_to_apicid[nr_logical_cpuids] = apicid;
-	return nr_logical_cpuids++;
-}
-
-static void cpu_update_apic(int cpu, u32 apicid)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
-	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
-#endif
-	set_cpu_possible(cpu, true);
-	set_bit(apicid, phys_cpu_present_map);
-	set_cpu_present(cpu, true);
-	num_processors++;
-
-	if (system_state != SYSTEM_BOOTING)
-		cpu_mark_primary_thread(cpu, apicid);
-}
-
-static __init void cpu_set_boot_apic(void)
-{
-	cpuid_to_apicid[0] = boot_cpu_physical_apicid;
-	cpu_update_apic(0, boot_cpu_physical_apicid);
-	x86_32_probe_bigsmp_early();
-}
-
-int generic_processor_info(int apicid)
-{
-	int cpu, max = nr_cpu_ids;
-
-	/* The boot CPU must be set before MADT/MPTABLE parsing happens */
-	if (cpuid_to_apicid[0] == BAD_APICID)
-		panic("Boot CPU APIC not registered yet\n");
-
-	if (apicid == boot_cpu_physical_apicid)
-		return 0;
-
-	if (disabled_cpu_apicid == apicid) {
-		int thiscpu = num_processors + disabled_cpus;
-
-		pr_warn("APIC: Disabling requested cpu. Processor %d/0x%x ignored.\n",
-			thiscpu, apicid);
-
-		disabled_cpus++;
-		return -ENODEV;
-	}
-
-	if (num_processors >= nr_cpu_ids) {
-		int thiscpu = max + disabled_cpus;
-
-		pr_warn("APIC: NR_CPUS/possible_cpus limit of %i reached. "
-			"Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
-
-		disabled_cpus++;
-		return -EINVAL;
-	}
-
-	cpu = allocate_logical_cpuid(apicid);
-	if (cpu < 0) {
-		disabled_cpus++;
-		return -EINVAL;
-	}
-
-	cpu_update_apic(cpu, apicid);
-	return cpu;
-}
-
-
 void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
 			   bool dmar)
 {
@@ -2828,15 +2656,6 @@ static int __init lapic_insert_resource(
  */
 late_initcall(lapic_insert_resource);
 
-static int __init apic_set_disabled_cpu_apicid(char *arg)
-{
-	if (!arg || !get_option(&arg, &disabled_cpu_apicid))
-		return -EINVAL;
-
-	return 0;
-}
-early_param("disable_cpu_apicid", apic_set_disabled_cpu_apicid);
-
 static int __init apic_set_extnmi(char *arg)
 {
 	if (!arg)
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -26,14 +26,16 @@ obj-y			+= bugs.o
 obj-y			+= aperfmperf.o
 obj-y			+= cpuid-deps.o
 obj-y			+= umwait.o
+obj-y 			+= capflags.o powerflags.o
 
-obj-$(CONFIG_PROC_FS)	+= proc.o
-obj-y += capflags.o powerflags.o
+obj-$(CONFIG_X86_LOCAL_APIC)		+= topology.o
 
-obj-$(CONFIG_IA32_FEAT_CTL) += feat_ctl.o
+obj-$(CONFIG_PROC_FS)			+= proc.o
+
+obj-$(CONFIG_IA32_FEAT_CTL)		+= feat_ctl.o
 ifdef CONFIG_CPU_SUP_INTEL
-obj-y			+= intel.o intel_pconfig.o tsx.o
-obj-$(CONFIG_PM)	+= intel_epb.o
+obj-y					+= intel.o intel_pconfig.o tsx.o
+obj-$(CONFIG_PM)			+= intel_epb.o
 endif
 obj-$(CONFIG_CPU_SUP_AMD)		+= amd.o
 obj-$(CONFIG_CPU_SUP_HYGON)		+= hygon.o
--- /dev/null
+++ b/arch/x86/kernel/cpu/topology.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/cpu.h>
+
+#include <xen/xen.h>
+
+#include <asm/apic.h>
+#include <asm/mpspec.h>
+#include <asm/smp.h>
+
+/*
+ * Map cpu index to physical APIC ID
+ */
+DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_apicid, BAD_APICID);
+DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid, CPU_ACPIID_INVALID);
+EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_apicid);
+EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
+
+/* Bitmap of physically present CPUs. */
+DECLARE_BITMAP(phys_cpu_present_map, MAX_LOCAL_APIC) __read_mostly;
+
+/* Used for CPU number allocation and parallel CPU bringup */
+u32 cpuid_to_apicid[] __read_mostly = { [0 ... NR_CPUS - 1] = BAD_APICID, };
+
+/*
+ * Processor to be disabled specified by kernel parameter
+ * disable_cpu_apicid=<int>, mostly used for the kdump 2nd kernel to
+ * avoid undefined behaviour caused by sending INIT from AP to BSP.
+ */
+static u32 disabled_cpu_apicid __ro_after_init = BAD_APICID;
+
+unsigned int num_processors;
+unsigned disabled_cpus;
+
+/*
+ * The number of allocated logical CPU IDs. Since logical CPU IDs are allocated
+ * contiguously, it equals to current allocated max logical CPU ID plus 1.
+ * All allocated CPU IDs should be in the [0, nr_logical_cpuids) range,
+ * so the maximum of nr_logical_cpuids is nr_cpu_ids.
+ *
+ * NOTE: Reserve 0 for BSP.
+ */
+static int nr_logical_cpuids = 1;
+
+bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
+{
+	return phys_id == (u64)cpuid_to_apicid[cpu];
+}
+
+#ifdef CONFIG_SMP
+static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
+{
+	/* Isolate the SMT bit(s) in the APICID and check for 0 */
+	u32 mask = (1U << (fls(smp_num_siblings) - 1)) - 1;
+
+	if (smp_num_siblings == 1 || !(apicid & mask))
+		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
+}
+
+/*
+ * Due to the utter mess of CPUID evaluation smp_num_siblings is not valid
+ * during early boot. Initialize the primary thread mask before SMP
+ * bringup.
+ */
+static int __init smp_init_primary_thread_mask(void)
+{
+	unsigned int cpu;
+
+	/*
+	 * XEN/PV provides either none or useless topology information.
+	 * Pretend that all vCPUs are primary threads.
+	 */
+	if (xen_pv_domain()) {
+		cpumask_copy(&__cpu_primary_thread_mask, cpu_possible_mask);
+		return 0;
+	}
+
+	for (cpu = 0; cpu < nr_logical_cpuids; cpu++)
+		cpu_mark_primary_thread(cpu, cpuid_to_apicid[cpu]);
+	return 0;
+}
+early_initcall(smp_init_primary_thread_mask);
+#else
+static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid) { }
+#endif
+
+/*
+ * Should use this API to allocate logical CPU IDs to keep nr_logical_cpuids
+ * and cpuid_to_apicid[] synchronized.
+ */
+static int allocate_logical_cpuid(int apicid)
+{
+	int i;
+
+	/*
+	 * cpuid <-> apicid mapping is persistent, so when a cpu is up,
+	 * check if the kernel has allocated a cpuid for it.
+	 */
+	for (i = 0; i < nr_logical_cpuids; i++) {
+		if (cpuid_to_apicid[i] == apicid)
+			return i;
+	}
+
+	/* Allocate a new cpuid. */
+	if (nr_logical_cpuids >= nr_cpu_ids) {
+		WARN_ONCE(1, "APIC: NR_CPUS/possible_cpus limit of %u reached. "
+			     "Processor %d/0x%x and the rest are ignored.\n",
+			     nr_cpu_ids, nr_logical_cpuids, apicid);
+		return -EINVAL;
+	}
+
+	cpuid_to_apicid[nr_logical_cpuids] = apicid;
+	return nr_logical_cpuids++;
+}
+
+static void cpu_update_apic(int cpu, u32 apicid)
+{
+#if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
+	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
+#endif
+	set_cpu_possible(cpu, true);
+	set_bit(apicid, phys_cpu_present_map);
+	set_cpu_present(cpu, true);
+	num_processors++;
+
+	if (system_state != SYSTEM_BOOTING)
+		cpu_mark_primary_thread(cpu, apicid);
+}
+
+void __init topology_register_boot_apic(u32 apic_id)
+{
+	cpuid_to_apicid[0] = apic_id;
+	cpu_update_apic(0, apic_id);
+}
+
+int generic_processor_info(int apicid)
+{
+	int cpu, max = nr_cpu_ids;
+
+	/* The boot CPU must be set before MADT/MPTABLE parsing happens */
+	if (cpuid_to_apicid[0] == BAD_APICID)
+		panic("Boot CPU APIC not registered yet\n");
+
+	if (apicid == boot_cpu_physical_apicid)
+		return 0;
+
+	if (disabled_cpu_apicid == apicid) {
+		int thiscpu = num_processors + disabled_cpus;
+
+		pr_warn("APIC: Disabling requested cpu. Processor %d/0x%x ignored.\n",
+			thiscpu, apicid);
+
+		disabled_cpus++;
+		return -ENODEV;
+	}
+
+	if (num_processors >= nr_cpu_ids) {
+		int thiscpu = max + disabled_cpus;
+
+		pr_warn("APIC: NR_CPUS/possible_cpus limit of %i reached. "
+			"Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
+
+		disabled_cpus++;
+		return -EINVAL;
+	}
+
+	cpu = allocate_logical_cpuid(apicid);
+	if (cpu < 0) {
+		disabled_cpus++;
+		return -EINVAL;
+	}
+
+	cpu_update_apic(cpu, apicid);
+	return cpu;
+}
+
+static int __init apic_set_disabled_cpu_apicid(char *arg)
+{
+	if (!arg || !get_option(&arg, &disabled_cpu_apicid))
+		return -EINVAL;
+
+	return 0;
+}
+early_param("disable_cpu_apicid", apic_set_disabled_cpu_apicid);


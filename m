Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366697726BB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjHGNyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbjHGNxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F57919B5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:27 -0700 (PDT)
Message-ID: <20230807135028.161442319@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=v+176pp9ACIIPvLc6LDktKyoU9X9mReBTN4+zBUGjJ0=;
        b=3MJAVBOyeqWg+qSoumYYElftm3Sj3O9raM/01lyZenNB8+4NpMSykM4UoZv0bN8RFX/a1M
        vweOBTgXt91vD5pnnUGl7araPthxkzw7/oGD4Ti41s/GH5eIGNPWE/9FY9NZAuaQcCQCdY
        4XQWDmzjoqdo65zJrueUdBi2iBJRghqjsXNR0ybbDFBk36zyYRHAd21Bj4wX2IswkpKhKE
        SmSk4Wm++OlNU0Ci48xXcuMcQHyCafLbqHeyID1vmlOXbeIUDGncRvikpwnTSD0agD3KYs
        G2Wtm39HEQokotO2z5usTSVgH581qGkNffIeFieYsDqC/sytBpNc8vQaKDvr1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=v+176pp9ACIIPvLc6LDktKyoU9X9mReBTN4+zBUGjJ0=;
        b=/YrelmPGc4/3kKdLXjSqR4pk8rqpMbhIIEJ3nii5pjz+WTr7GDQKm2bRKegxKj29p2zFT5
        ZY6bN47weaoxzkAw==
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
Subject: [patch 33/53] x86/cpu/topology: Use a data structure for topology
 info
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:25 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put the processor accounting into a data structure, which will gain more
topology related information in the next steps, and sanitize the accounting.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/topology.c |   59 ++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -23,25 +23,24 @@ DECLARE_BITMAP(phys_cpu_present_map, MAX
 u32 cpuid_to_apicid[] __read_mostly = { [0 ... NR_CPUS - 1] = BAD_APICID, };
 
 /*
+ * Keep track of assigned, disabled and rejected CPUs. Present assigned
+ * with 1 as CPU #0 is reserved for the boot CPU.
+ */
+struct {
+	unsigned int		nr_assigned_cpus;
+	unsigned int		nr_disabled_cpus;
+	unsigned int		nr_rejected_cpus;
+} topo_info __read_mostly = {
+	.nr_assigned_cpus	= 1,
+};
+
+/*
  * Processor to be disabled specified by kernel parameter
  * disable_cpu_apicid=<int>, mostly used for the kdump 2nd kernel to
  * avoid undefined behaviour caused by sending INIT from AP to BSP.
  */
 static u32 disabled_cpu_apicid __ro_after_init = BAD_APICID;
 
-static unsigned int num_processors;
-static unsigned int disabled_cpus;
-
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
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 {
 	return phys_id == (u64)cpuid_to_apicid[cpu];
@@ -75,7 +74,7 @@ static int __init smp_init_primary_threa
 		return 0;
 	}
 
-	for (cpu = 0; cpu < nr_logical_cpuids; cpu++)
+	for (cpu = 0; cpu < topo_info.nr_assigned_cpus; cpu++)
 		cpu_mark_primary_thread(cpu, cpuid_to_apicid[cpu]);
 	return 0;
 }
@@ -89,7 +88,7 @@ static int topo_lookup_cpuid(u32 apic_id
 	int i;
 
 	/* CPU# to APICID mapping is persistent once it is established */
-	for (i = 0; i < nr_logical_cpuids; i++) {
+	for (i = 0; i < topo_info.nr_assigned_cpus; i++) {
 		if (cpuid_to_apicid[i] == apic_id)
 			return i;
 	}
@@ -107,22 +106,21 @@ static int allocate_logical_cpuid(u32 ap
 	if (cpu >= 0)
 		return cpu;
 
-	cpuid_to_apicid[nr_logical_cpuids] = apic_id;
-	return nr_logical_cpuids++;
+	return topo_info.nr_assigned_cpus++;
 }
 
-static void cpu_update_apic(int cpu, u32 apicid)
+static void cpu_update_apic(unsigned int cpu, u32 apic_id)
 {
 #if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
-	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
+	early_per_cpu(x86_cpu_to_apicid, cpu) = apic_id;
 #endif
+	cpuid_to_apicid[cpu] = apic_id;
 	set_cpu_possible(cpu, true);
-	set_bit(apicid, phys_cpu_present_map);
+	set_bit(apic_id, phys_cpu_present_map);
 	set_cpu_present(cpu, true);
-	num_processors++;
 
 	if (system_state != SYSTEM_BOOTING)
-		cpu_mark_primary_thread(cpu, apicid);
+		cpu_mark_primary_thread(cpu, apic_id);
 }
 
 static int generic_processor_info(int apicid)
@@ -137,18 +135,18 @@ static int generic_processor_info(int ap
 		return 0;
 
 	if (disabled_cpu_apicid == apicid) {
-		int thiscpu = num_processors + disabled_cpus;
+		int thiscpu = topo_info.nr_assigned_cpus + topo_info.nr_disabled_cpus;
 
 		pr_warn("APIC: Disabling requested cpu. Processor %d/0x%x ignored.\n",
 			thiscpu, apicid);
 
-		disabled_cpus++;
+		topo_info.nr_rejected_cpus++;
 		return -ENODEV;
 	}
 
-	if (num_processors >= nr_cpu_ids) {
+	if (topo_info.nr_assigned_cpus >= nr_cpu_ids) {
 		pr_warn_once("APIC: CPU limit of %d reached. Ignoring further CPUs\n", nr_cpu_ids);
-		disabled_cpus++;
+		topo_info.nr_rejected_cpus++;
 		return -ENOSPC;
 	}
 
@@ -178,14 +176,16 @@ static int __initdata setup_possible_cpu
  */
 __init void prefill_possible_map(void)
 {
+	unsigned int num_processors = topo_info.nr_assigned_cpus;
+	unsigned int disabled_cpus = topo_info.nr_disabled_cpus;
 	int i, possible;
 
 	i = setup_max_cpus ?: 1;
 	if (setup_possible_cpus == -1) {
-		possible = num_processors;
+		possible = topo_info.nr_assigned_cpus;
 #ifdef CONFIG_HOTPLUG_CPU
 		if (setup_max_cpus)
-			possible += disabled_cpus;
+			possible += num_processors;
 #else
 		if (possible > i)
 			possible = i;
@@ -238,7 +238,7 @@ void __init topology_register_apic(u32 a
 	}
 
 	if (!present) {
-		disabled_cpus++;
+		topo_info.nr_disabled_cpus++;
 		return;
 	}
 
@@ -295,7 +295,6 @@ void topology_hotunplug_apic(unsigned in
 	per_cpu(x86_cpu_to_apicid, cpu) = BAD_APICID;
 	clear_bit(apic_id, phys_cpu_present_map);
 	set_cpu_present(cpu, false);
-	num_processors--;
 }
 #endif
 


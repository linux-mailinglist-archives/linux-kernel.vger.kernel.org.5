Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B1A7726D6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjHGN5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjHGN4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:56:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6FF3AB9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:54:21 -0700 (PDT)
Message-ID: <20230807135029.061717423@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vq2LqKgDPaDhnlrBU4urRm/zoBPsw6UyhSpMosqqfTs=;
        b=2LMEqnSWJ88DG/xbwPK2/D8zRGGIDIMKG7vbcYXhn+Wb6eyTJpYCjg3Ci+25IRBstViGLd
        NSRdyQggrVb362Cf2Tuk3KczI8Y34GXrlLQ4LV8Pn/hz172+Cgqip//1Jcreqcotho152O
        e7D3L6QzosmBajJ4SklaxErB+DUC0oBESJJ/orOqVQ4MUJjzzd9/r06VncMtDd7zcd2PPR
        aumWruEG/huibXlfzAXznRCLI6oT68FgrcQOB3DXB1XlpHz93Q119JUUJXtu+THFY3N7lm
        rGzURS6OAVToStmULtTJkDohNVbK8EZF5vsQLSHpbJ9GFiKcotn3lTGE1YTEdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vq2LqKgDPaDhnlrBU4urRm/zoBPsw6UyhSpMosqqfTs=;
        b=iv5hFfUxtG6Oze3lXxizz8BN2fAYPck3cM0RnS9YRy9x9lKZAWlY252Q15kAEabfCk7580
        JIy+zgv1GLUG45AA==
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
Subject: [patch 50/53] x86/cpu/topology: Rename smp_num_siblings
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:52 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's really a non-intuitive name. Rename it to __max_threads_per_core which
is obvious.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/smp.h       |    2 --
 arch/x86/include/asm/topology.h  |    6 +++++-
 arch/x86/kernel/cpu/common.c     |    4 ++--
 arch/x86/kernel/cpu/debugfs.c    |    2 +-
 arch/x86/kernel/cpu/mce/inject.c |    2 +-
 arch/x86/kernel/cpu/topology.c   |    6 +++---
 arch/x86/kernel/smpboot.c        |    8 --------
 7 files changed, 12 insertions(+), 18 deletions(-)

--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -8,8 +8,6 @@
 #include <asm/current.h>
 #include <asm/thread_info.h>
 
-extern unsigned int smp_num_siblings;
-
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -145,6 +145,7 @@ extern const struct cpumask *cpu_cluster
 
 extern unsigned int __max_dies_per_package;
 extern unsigned int __max_logical_packages;
+extern unsigned int __max_threads_per_core;
 
 static inline unsigned int topology_max_packages(void)
 {
@@ -178,7 +179,10 @@ static inline int topology_max_smt_threa
 	return __max_smt_threads;
 }
 
-bool topology_smt_supported(void);
+static inline bool topology_smt_supported(void)
+{
+	return __max_threads_per_core > 1;
+}
 
 extern unsigned int __amd_nodes_per_pkg;
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -72,8 +72,8 @@
 u32 elf_hwcap2 __read_mostly;
 
 /* Number of siblings per CPU package */
-unsigned int smp_num_siblings __ro_after_init = 1;
-EXPORT_SYMBOL(smp_num_siblings);
+unsigned int __max_threads_per_core __ro_after_init = 1;
+EXPORT_SYMBOL(__max_threads_per_core);
 
 unsigned int __max_dies_per_package __ro_after_init = 1;
 EXPORT_SYMBOL(__max_dies_per_package);
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -30,7 +30,7 @@ static int cpu_debug_show(struct seq_fil
 	seq_printf(m, "amd_nodes_per_pkg:   %u\n", topology_amd_nodes_per_pkg());
 	seq_printf(m, "max_cores:           %u\n", c->x86_max_cores);
 	seq_printf(m, "max_dies_per_pkg:    %u\n", __max_dies_per_package);
-	seq_printf(m, "smp_num_siblings:    %u\n", smp_num_siblings);
+	seq_printf(m, "max_threads_per_core:%u\n", __max_threads_per_core);
 	return 0;
 }
 
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -433,7 +433,7 @@ static u32 get_nbc_for_node(int node_id)
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 	u32 cores_per_node;
 
-	cores_per_node = (c->x86_max_cores * smp_num_siblings) / topology_amd_nodes_per_pkg();
+	cores_per_node = (c->x86_max_cores * __max_threads_per_core) / topology_amd_nodes_per_pkg();
 	return cores_per_node * node_id;
 }
 
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -86,7 +86,7 @@ bool arch_match_cpu_phys_id(int cpu, u64
 #ifdef CONFIG_SMP
 static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
 {
-	if (!(apicid & (smp_num_siblings - 1)))
+	if (!(apicid & (__max_threads_per_core - 1)))
 		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
 }
 #else
@@ -427,8 +427,8 @@ void __init topology_init_possible_cpus(
 
 	cnta = domain_weight(TOPO_CORE_DOMAIN);
 	cntb = domain_weight(TOPO_SMT_DOMAIN);
-	smp_num_siblings = 1U << (get_count_order(cntb) - get_count_order(cnta));
-	pr_info("Max. threads per core: %3u\n", smp_num_siblings);
+	__max_threads_per_core = 1U << (get_count_order(cntb) - get_count_order(cnta));
+	pr_info("Max. threads per core: %3u\n", __max_threads_per_core);
 
 	pr_info("Allowing %u present CPUs plus %u hotplug CPUs\n", assigned, disabled);
 	if (topo_info.nr_rejected_cpus)
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -320,14 +320,6 @@ static void notrace start_secondary(void
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
-/**
- * topology_smt_supported - Check whether SMT is supported by the CPUs
- */
-bool topology_smt_supported(void)
-{
-	return smp_num_siblings > 1;
-}
-
 void __init smp_store_boot_cpu_info(void)
 {
 	struct cpuinfo_x86 *c = &cpu_data(0);


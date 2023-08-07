Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9AC7726D0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjHGN4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjHGN4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:56:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC6E30D6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:54:02 -0700 (PDT)
Message-ID: <20230807135028.905547409@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=j7OFjclpvkjeiv/gw2/Emcd71M9jz+vMU9xYSIvRiEo=;
        b=xqo9ZaM1LLCfF08ATvGnDcfpYmc4mAh21E6HXSz2Om+ipnlUgYwN5lmPluijLFLdM886kg
        qv/6chThN3AsZxYj8WBPuJMIU4j7g9X2MDcds2qTr0bhBe/364H0Yp+xVqesuciaKOc5ew
        s5Q5EOXD4NKqpbjtxg3KEpfbLNSJJgGt0WKNyNxdsw170KZXTaqXrksfvNWTfh3WPm/DwM
        XqrwbL5jqz1VpGLi4wLgDXimEn3rQJHVJQSxYxWFjkYeS59cohvC8ES0omJZwEealB8FjN
        42ZJJmiHs2kNvgE946Or/nSi7XMM30sm6S7ZC60UrMqYSg48QLQ60TozG2Lemg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=j7OFjclpvkjeiv/gw2/Emcd71M9jz+vMU9xYSIvRiEo=;
        b=ngJBZMNxfFt/IejW6lJIeykdXTMvumCez1aqyhbJURw4eDoqjrSC5ZCtUKcGnhPFy6mADo
        yln+WXBT8AGRNXAA==
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
Subject: [patch 47/53] x86/cpu/topology: Use topology logical mapping
 mechanism
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:47 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the logical package and die management functionality and retrieve
the logical IDs from the topology bitmaps.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/topology.h       |   13 +--
 arch/x86/kernel/cpu/common.c          |   13 ---
 arch/x86/kernel/cpu/topology_common.c |    4 +
 arch/x86/kernel/smpboot.c             |  111 ----------------------------------
 4 files changed, 11 insertions(+), 130 deletions(-)

--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -158,6 +158,12 @@ static inline unsigned int topology_max_
 
 int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level);
 
+static inline int topology_phys_to_logical_pkg(unsigned int pkg)
+{
+	return topology_get_logical_id(pkg << x86_topo_system.dom_shifts[TOPO_PKG_DOMAIN],
+				       TOPO_PKG_DOMAIN);
+}
+
 #ifdef CONFIG_SMP
 #define topology_cluster_id(cpu)		(cpu_data(cpu).topo.l2c_id)
 #define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
@@ -172,9 +178,6 @@ static inline int topology_max_smt_threa
 	return __max_smt_threads;
 }
 
-int topology_update_package_map(unsigned int apicid, unsigned int cpu);
-int topology_update_die_map(unsigned int dieid, unsigned int cpu);
-int topology_phys_to_logical_pkg(unsigned int pkg);
 bool topology_smt_supported(void);
 
 extern unsigned int __amd_nodes_per_pkg;
@@ -199,10 +202,6 @@ static inline bool topology_is_primary_t
 void topology_apply_cmdline_limits_early(void);
 
 #else /* CONFIG_SMP */
-static inline int
-topology_update_package_map(unsigned int apicid, unsigned int cpu) { return 0; }
-static inline int
-topology_update_die_map(unsigned int dieid, unsigned int cpu) { return 0; }
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1679,18 +1679,6 @@ static void generic_identify(struct cpui
 #endif
 }
 
-static void update_package_map(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	unsigned int cpu = smp_processor_id();
-
-	BUG_ON(topology_update_package_map(c->topo.pkg_id, cpu));
-	BUG_ON(topology_update_die_map(c->topo.die_id, cpu));
-#else
-	c->topo.logical_pkg_id = 0;
-#endif
-}
-
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
@@ -1868,7 +1856,6 @@ void identify_secondary_cpu(struct cpuin
 #ifdef CONFIG_X86_32
 	enable_sep_cpu();
 #endif
-	update_package_map(c);
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
 
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -10,6 +10,7 @@
 #include "cpu.h"
 
 struct x86_topology_system x86_topo_system __ro_after_init;
+EXPORT_SYMBOL_GPL(x86_topo_system);
 
 unsigned int __amd_nodes_per_pkg __ro_after_init;
 EXPORT_SYMBOL_GPL(__amd_nodes_per_pkg);
@@ -147,6 +148,9 @@ static void topo_set_ids(struct topo_sca
 	c->topo.pkg_id = topo_shift_apicid(apicid, TOPO_PKG_DOMAIN);
 	c->topo.die_id = topo_shift_apicid(apicid, TOPO_DIE_DOMAIN);
 
+	c->topo.logical_pkg_id = topology_get_logical_id(apicid, TOPO_PKG_DOMAIN);
+	c->topo.logical_die_id = topology_get_logical_id(apicid, TOPO_DIE_DOMAIN);
+
 	/* Relative core ID */
 	c->topo.core_id = topo_relative_domain_id(apicid, TOPO_CORE_DOMAIN);
 
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -124,23 +124,6 @@ struct mwait_cpu_dead {
  */
 static DEFINE_PER_CPU_ALIGNED(struct mwait_cpu_dead, mwait_cpu_dead);
 
-/* Logical package management. */
-struct logical_maps {
-	u32	phys_pkg_id;
-	u32	phys_die_id;
-	u32	logical_pkg_id;
-	u32	logical_die_id;
-};
-
-/* Temporary workaround until the full topology mechanics is in place */
-static DEFINE_PER_CPU_READ_MOSTLY(struct logical_maps, logical_maps) = {
-	.phys_pkg_id	= U32_MAX,
-	.phys_die_id	= U32_MAX,
-};
-
-static unsigned int logical_packages __read_mostly;
-static unsigned int logical_die __read_mostly;
-
 /* Maximum number of SMT threads on any online core */
 int __read_mostly __max_smt_threads = 1;
 
@@ -345,103 +328,11 @@ bool topology_smt_supported(void)
 	return smp_num_siblings > 1;
 }
 
-/**
- * topology_phys_to_logical_pkg - Map a physical package id to a logical
- * @phys_pkg:	The physical package id to map
- *
- * Returns logical package id or -1 if not found
- */
-int topology_phys_to_logical_pkg(unsigned int phys_pkg)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		if (per_cpu(logical_maps.phys_pkg_id, cpu) == phys_pkg)
-			return per_cpu(logical_maps.logical_pkg_id, cpu);
-	}
-	return -1;
-}
-EXPORT_SYMBOL(topology_phys_to_logical_pkg);
-
-/**
- * topology_phys_to_logical_die - Map a physical die id to logical
- * @die_id:	The physical die id to map
- * @cur_cpu:	The CPU for which the mapping is done
- *
- * Returns logical die id or -1 if not found
- */
-static int topology_phys_to_logical_die(unsigned int die_id, unsigned int cur_cpu)
-{
-	int cpu, proc_id = cpu_data(cur_cpu).topo.pkg_id;
-
-	for_each_possible_cpu(cpu) {
-		if (per_cpu(logical_maps.phys_pkg_id, cpu) == proc_id &&
-		    per_cpu(logical_maps.phys_die_id, cpu) == die_id)
-			return per_cpu(logical_maps.logical_die_id, cpu);
-	}
-	return -1;
-}
-
-/**
- * topology_update_package_map - Update the physical to logical package map
- * @pkg:	The physical package id as retrieved via CPUID
- * @cpu:	The cpu for which this is updated
- */
-int topology_update_package_map(unsigned int pkg, unsigned int cpu)
-{
-	int new;
-
-	/* Already available somewhere? */
-	new = topology_phys_to_logical_pkg(pkg);
-	if (new >= 0)
-		goto found;
-
-	new = logical_packages++;
-	if (new != pkg) {
-		pr_info("CPU %u Converting physical %u to logical package %u\n",
-			cpu, pkg, new);
-	}
-found:
-	per_cpu(logical_maps.phys_pkg_id, cpu) = pkg;
-	per_cpu(logical_maps.logical_pkg_id, cpu) = new;
-	cpu_data(cpu).topo.logical_pkg_id = new;
-	return 0;
-}
-/**
- * topology_update_die_map - Update the physical to logical die map
- * @die:	The die id as retrieved via CPUID
- * @cpu:	The cpu for which this is updated
- */
-int topology_update_die_map(unsigned int die, unsigned int cpu)
-{
-	int new;
-
-	/* Already available somewhere? */
-	new = topology_phys_to_logical_die(die, cpu);
-	if (new >= 0)
-		goto found;
-
-	new = logical_die++;
-	if (new != die) {
-		pr_info("CPU %u Converting physical %u to logical die %u\n",
-			cpu, die, new);
-	}
-found:
-	per_cpu(logical_maps.phys_die_id, cpu) = die;
-	per_cpu(logical_maps.logical_die_id, cpu) = new;
-	cpu_data(cpu).topo.logical_die_id = new;
-	return 0;
-}
-
 void __init smp_store_boot_cpu_info(void)
 {
-	int id = 0; /* CPU 0 */
-	struct cpuinfo_x86 *c = &cpu_data(id);
+	struct cpuinfo_x86 *c = &cpu_data(0);
 
 	*c = boot_cpu_data;
-	c->cpu_index = id;
-	topology_update_package_map(c->topo.pkg_id, id);
-	topology_update_die_map(c->topo.die_id, id);
 	c->initialized = true;
 }
 


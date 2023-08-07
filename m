Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921967726C6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjHGNzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjHGNx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4772B1FC8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:35 -0700 (PDT)
Message-ID: <20230807135028.433963067@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ItRqIV1rXpKFl7HGEZSaspnnBvb0OflCybv79tP0/ws=;
        b=eu9j6DQBjz4P89PvAEyCXsuLWYGIwX3vPS/CxmgpYI/XyU9kxJobcUIy5PF0/bmPP4uVBo
        MNk6gZFhhBRvEqLqSyQHHup7QzmnPwtcgMvpsbJ8OnCxePgFK6b9lWU926352O9P3pZI0I
        Dkl05Z3I1YlgJdKfynferXvjovUR6imnXxXOcCgCcCK60ugPnVcpUb08j7edGeG1gGzgOu
        ahD10ga6svYYj5DsGEEJLGpUvZhJnr2SKkg6a5dHs5tLZoZE+8F3puKgja1wyPKbzLpQeA
        pFouLnYwCL6L10CZuuT2kc11Xzkq26nPXQofQ2E4KZoGjYz49CsAYgU44ry/Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ItRqIV1rXpKFl7HGEZSaspnnBvb0OflCybv79tP0/ws=;
        b=zo1phJpb/gek4xNYSVXfBdKy/rsQvx8FyDQj9tGI8n3+YOFgCB+qDumRt/Mpx/IcBu7wo9
        AQ+tiYAJv8mMgBDQ==
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
Subject: [patch 38/53] x86/topology: Add a mechanism to track topology via
 APIC IDs
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:33 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Topology on X86 is determined by the registered APIC IDs and the
segmentation information retrieved from CPUID. Depending on the granularity
of the provided CPUID information the most fine grained scheme looks like
this according to Intel terminology:

   [PKG][DIE][TILE][MODULE][CORE][THREAD]

Not enumerated domain levels consume 0 bits in the APIC ID. This allows to
provide a consistent view at the topology and determine other information
precisely like the number of cores in a package on hybrid systems, where
the existing assumption that number or cores == number of threads / threads
per core does not hold.

Provide per domain level bitmaps which record the APIC ID split into the
domain levels to make later evaluation of domain level specific information
simple. This allows to calculate e.g. the logical IDs without any further
extra logic.

Contrary to the existing registration mechanism this records disabled CPUs,
which are subject to later hotplug as well. That's useful for boot time
sizing of package or die dependent allocations without using heuristics.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/debugfs.c  |    8 ----
 arch/x86/kernel/cpu/topology.c |   68 +++++++++++++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/topology.h |    2 +
 3 files changed, 67 insertions(+), 11 deletions(-)

--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -48,14 +48,6 @@ static const struct file_operations dfs_
 
 static int dom_debug_show(struct seq_file *m, void *p)
 {
-	static const char *domain_names[TOPO_ROOT_DOMAIN] = {
-		[TOPO_SMT_DOMAIN]	= "Thread",
-		[TOPO_CORE_DOMAIN]	= "Core",
-		[TOPO_MODULE_DOMAIN]	= "Module",
-		[TOPO_TILE_DOMAIN]	= "Tile",
-		[TOPO_DIE_DOMAIN]	= "Die",
-		[TOPO_PKG_DOMAIN]	= "Package",
-	};
 	unsigned int dom, nthreads = 1;
 
 	for (dom = 0; dom < TOPO_ROOT_DOMAIN; dom++) {
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -1,5 +1,27 @@
 // SPDX-License-Identifier: GPL-2.0-only
-
+/*
+ * CPU/APIC topology
+ *
+ * The APIC IDs describe the system topology in multiple domain levels.
+ * The CPUID topology parser provides the information which part of the
+ * APIC ID is associated to the individual levels:
+ *
+ * [ROOT][PACKAGE][DIE][TILE][MODULE][CORE][THREAD]
+ *
+ * The root space contains the package (socket) IDs.
+ *
+ * Not enumerated levels consume 0 bits space, but conceptually they are
+ * always represented. If e.g. only CORE and THREAD levels are enumerated
+ * then the DIE, MODULE and TILE have the same physical ID as the PACKAGE.
+ *
+ * If SMT is not supported, then the THREAD domain is still used. It then
+ * has the same physical ID as the CORE domain and is the only child of
+ * the core domain.
+ *
+ * This allows a unified view on the system independent of the enumerated
+ * domain levels without requiring any conditionals in the code.
+ */
+#define pr_fmt(fmt) "CPU topo: " fmt
 #include <linux/cpu.h>
 
 #include <xen/xen.h>
@@ -9,6 +31,8 @@
 #include <asm/mpspec.h>
 #include <asm/smp.h>
 
+#include "cpu.h"
+
 /*
  * Map cpu index to physical APIC ID
  */
@@ -23,6 +47,9 @@ DECLARE_BITMAP(phys_cpu_present_map, MAX
 /* Used for CPU number allocation and parallel CPU bringup */
 u32 cpuid_to_apicid[] __read_mostly = { [0 ... NR_CPUS - 1] = BAD_APICID, };
 
+/* Bitmaps to mark registered APICs at each topology domain */
+static struct { DECLARE_BITMAP(map, MAX_LOCAL_APIC); } apic_maps[TOPO_MAX_DOMAIN] __ro_after_init;
+
 /*
  * Keep track of assigned, disabled and rejected CPUs. Present assigned
  * with 1 as CPU #0 is reserved for the boot CPU.
@@ -39,6 +66,18 @@ struct {
 	.real_bsp_apic_id	= BAD_APICID,
 };
 
+const char *domain_names[TOPO_MAX_DOMAIN] = {
+	[TOPO_SMT_DOMAIN]	= "Thread",
+	[TOPO_CORE_DOMAIN]	= "Core",
+	[TOPO_MODULE_DOMAIN]	= "Module",
+	[TOPO_TILE_DOMAIN]	= "Tile",
+	[TOPO_DIE_DOMAIN]	= "Die",
+	[TOPO_PKG_DOMAIN]	= "Package",
+	[TOPO_ROOT_DOMAIN]	= "Root",
+};
+
+#define domain_weight(_dom)	bitmap_weight(apic_maps[_dom].map, MAX_LOCAL_APIC)
+
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 {
 	return phys_id == (u64)cpuid_to_apicid[cpu];
@@ -81,6 +120,17 @@ early_initcall(smp_init_primary_thread_m
 static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid) { }
 #endif
 
+/*
+ * Convert the APIC ID to a domain level ID by masking out the low bits
+ * including the domain level @dom.
+ */
+static inline u32 topo_apicid(u32 apicid, enum x86_topology_domains dom)
+{
+	if (dom == TOPO_SMT_DOMAIN)
+		return apicid;
+	return apicid & (UINT_MAX << x86_topo_system.dom_shifts[dom - 1]);
+}
+
 static int topo_lookup_cpuid(u32 apic_id)
 {
 	int i;
@@ -126,7 +176,7 @@ static void topo_set_cpuids(unsigned int
  */
 void __init topology_register_apic(u32 apic_id, u32 acpi_id, bool present)
 {
-	int cpu;
+	int cpu, dom;
 
 	if (apic_id >= MAX_LOCAL_APIC) {
 		pr_err_once("APIC ID %x exceeds kernel limit of: %x\n", apic_id, MAX_LOCAL_APIC - 1);
@@ -159,6 +209,10 @@ void __init topology_register_apic(u32 a
 	} else {
 		topo_info.nr_disabled_cpus++;
 	}
+
+	/* Register present and possible CPUs in the domain maps */
+	for (dom = TOPO_SMT_DOMAIN; dom < TOPO_ROOT_DOMAIN; dom++)
+		set_bit(topo_apicid(apic_id, dom), apic_maps[dom].map);
 }
 
 /**
@@ -281,6 +335,11 @@ static __init void check_for_kdump_kerne
 
 	topo_info.real_bsp_apic_id = bsp_apicid;
 	clear_bit(bsp_apicid, phys_cpu_present_map);
+	/*
+	 * Remove it from the SMT level, but no propagation as that would
+	 * corrupt the data set.
+	 */
+	clear_bit(bsp_apicid, apic_maps[TOPO_SMT_DOMAIN].map);
 }
 
 void __init topology_init_possible_cpus(void)
@@ -288,7 +347,7 @@ void __init topology_init_possible_cpus(
 	unsigned int assigned = topo_info.nr_assigned_cpus;
 	unsigned int disabled = topo_info.nr_disabled_cpus;
 	unsigned int total = assigned + disabled;
-	unsigned int cpu, allowed = 1;
+	unsigned int cpu, dom, allowed = 1;
 
 	if (!restrict_to_up()) {
 		if (total > 1)
@@ -318,6 +377,9 @@ void __init topology_init_possible_cpus(
 	if (topo_info.nr_rejected_cpus)
 		pr_info("Rejected CPUs %u\n", topo_info.nr_rejected_cpus);
 
+	for (dom = TOPO_SMT_DOMAIN; dom < TOPO_ROOT_DOMAIN; dom++)
+		pr_info("%-10s: %5u\n", domain_names[dom], domain_weight(dom));
+
 	init_cpu_present(cpumask_of(0));
 	init_cpu_possible(cpumask_of(0));
 
--- a/arch/x86/kernel/cpu/topology.h
+++ b/arch/x86/kernel/cpu/topology.h
@@ -48,4 +48,6 @@ static inline void topology_update_dom(s
 	tscan->dom_ncpus[dom] = ncpus;
 }
 
+extern const char *domain_names[TOPO_MAX_DOMAIN];
+
 #endif /* ARCH_X86_TOPOLOGY_H */


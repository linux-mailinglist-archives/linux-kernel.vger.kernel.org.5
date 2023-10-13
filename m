Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EF97C8255
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjJMJjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjJMJiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CC3D7;
        Fri, 13 Oct 2023 02:38:14 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:38:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697189892;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ve8HEEYe8/mfIWvuF7l5xbbginSDWqNtvx3fLwuXTbg=;
        b=rqQxL9FImgSh1yvG6344JjtNAnr/XW7f2B3Xq0y7t3TBpPOfZCI2I6UGt27iDEk1SuCJN7
        PIgZm2i0l98kx8etIDz/zEKumPLKOyZ+bWGre58+JHrrke3ESeoWd2TnQthoTPTSY3IOR2
        B+qFD3j3IaVLH4Fu7MePFqZGN6OaJji2R082jgKAr3NWgJntVDDO2pRC49kuH1oI0Dj1ht
        wRyL4vrBc3HhXnfd2QEOjHczihG1BL0LNnUCCTMnh+ZVZXEz3GNPeSeznqcVFbQ1qYOP6E
        DeFbvAm+1tQVHvmA4G+kXql+jAARH76GKqaZ5rJ7ZxfJNbbJ43wBBJGhjqsYRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697189892;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ve8HEEYe8/mfIWvuF7l5xbbginSDWqNtvx3fLwuXTbg=;
        b=90TaEbneBGDdrOoH5tjPle4c4DWImvkX2rUk+kfFUC5tJCxhXmNBhnaQ+0WGoH3v053d2+
        Y/66sln7oF2RqlAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu: Move phys_proc_id into topology info
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814085112.329006989@linutronix.de>
References: <20230814085112.329006989@linutronix.de>
MIME-Version: 1.0
Message-ID: <169718989203.3135.190632155678815019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     02fb601d27a7abf60d52b21bdf5b100a8d63da3f
Gitweb:        https://git.kernel.org/tip/02fb601d27a7abf60d52b21bdf5b100a8d63da3f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Aug 2023 10:18:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Oct 2023 14:38:17 +02:00

x86/cpu: Move phys_proc_id into topology info

Rename it to pkg_id which is the terminology used in the kernel.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230814085112.329006989@linutronix.de

---
 Documentation/arch/x86/topology.rst  |  2 +-
 arch/x86/include/asm/processor.h     |  5 +++--
 arch/x86/include/asm/topology.h      |  2 +-
 arch/x86/include/asm/x86_init.h      |  2 +-
 arch/x86/kernel/apic/apic_numachip.c |  2 +-
 arch/x86/kernel/cpu/amd.c            |  4 ++--
 arch/x86/kernel/cpu/cacheinfo.c      |  4 ++--
 arch/x86/kernel/cpu/common.c         |  6 +++---
 arch/x86/kernel/cpu/hygon.c          |  6 +++---
 arch/x86/kernel/cpu/mce/apei.c       |  2 +-
 arch/x86/kernel/cpu/mce/core.c       |  2 +-
 arch/x86/kernel/cpu/proc.c           |  2 +-
 arch/x86/kernel/cpu/topology.c       |  3 +--
 arch/x86/kernel/smpboot.c            | 16 ++++++++--------
 drivers/scsi/lpfc/lpfc_init.c        |  6 +-----
 15 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/Documentation/arch/x86/topology.rst b/Documentation/arch/x86/topology.rst
index 7f58010..0bfa1ed 100644
--- a/Documentation/arch/x86/topology.rst
+++ b/Documentation/arch/x86/topology.rst
@@ -59,7 +59,7 @@ Package-related topology information in the kernel:
 
     The physical ID of the die. This information is retrieved via CPUID.
 
-  - cpuinfo_x86.phys_proc_id:
+  - cpuinfo_x86.topo.pkg_id:
 
     The physical ID of the package. This information is retrieved via CPUID
     and deduced from the APIC IDs of the cores in the package.
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 6833962..a673199 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -83,6 +83,9 @@ struct cpuinfo_topology {
 	u32			apicid;
 	// The initial APIC ID provided by CPUID
 	u32			initial_apicid;
+
+	// Physical package ID
+	u32			pkg_id;
 };
 
 struct cpuinfo_x86 {
@@ -134,8 +137,6 @@ struct cpuinfo_x86 {
 	u16			x86_clflush_size;
 	/* number of cores as seen by the OS: */
 	u16			booted_cores;
-	/* Physical processor id: */
-	u16			phys_proc_id;
 	/* Logical processor id: */
 	u16			logical_proc_id;
 	/* Core id: */
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 3235ba1..666c82e 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -106,7 +106,7 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
-#define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
+#define topology_physical_package_id(cpu)	(cpu_data(cpu).topo.pkg_id)
 #define topology_logical_die_id(cpu)		(cpu_data(cpu).logical_die_id)
 #define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 5240d88..c878616 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -177,7 +177,7 @@ struct x86_init_ops {
  * struct x86_cpuinit_ops - platform specific cpu hotplug setups
  * @setup_percpu_clockev:	set up the per cpu clock event device
  * @early_percpu_clock_init:	early init of the per cpu clock event device
- * @fixup_cpu_id:		fixup function for cpuinfo_x86::phys_proc_id
+ * @fixup_cpu_id:		fixup function for cpuinfo_x86::topo.pkg_id
  * @parallel_bringup:		Parallel bringup control
  */
 struct x86_cpuinit_ops {
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 63f3d7b..578ded9 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -169,7 +169,7 @@ static void fixup_cpu_id(struct cpuinfo_x86 *c, int node)
 		nodes = ((val >> 3) & 7) + 1;
 	}
 
-	c->phys_proc_id = node / nodes;
+	c->topo.pkg_id = node / nodes;
 }
 
 static int __init numachip_system_init(void)
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 1406659..d23463f 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -461,9 +461,9 @@ static void amd_detect_cmp(struct cpuinfo_x86 *c)
 	/* Low order bits define the core id (index of core in socket) */
 	c->cpu_core_id = c->topo.initial_apicid & ((1 << bits)-1);
 	/* Convert the initial APIC ID into the socket ID */
-	c->phys_proc_id = c->topo.initial_apicid >> bits;
+	c->topo.pkg_id = c->topo.initial_apicid >> bits;
 	/* use socket ID also for last level cache */
-	per_cpu(cpu_llc_id, cpu) = c->cpu_die_id = c->phys_proc_id;
+	per_cpu(cpu_llc_id, cpu) = c->cpu_die_id = c->topo.pkg_id;
 }
 
 u32 amd_get_nodes_per_socket(void)
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index daa3542..fe583fd 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -875,10 +875,10 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 	 * turns means that the only possibility is SMT (as indicated in
 	 * cpuid1). Since cpuid2 doesn't specify shared caches, and we know
 	 * that SMT shares all caches, we can unconditionally set cpu_llc_id to
-	 * c->phys_proc_id.
+	 * c->topo.pkg_id.
 	 */
 	if (per_cpu(cpu_llc_id, cpu) == BAD_APICID)
-		per_cpu(cpu_llc_id, cpu) = c->phys_proc_id;
+		per_cpu(cpu_llc_id, cpu) = c->topo.pkg_id;
 #endif
 
 	c->x86_cache_size = l3 ? l3 : (l2 ? l2 : (l1i+l1d));
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c39e88e..77fc124 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -914,7 +914,7 @@ void detect_ht(struct cpuinfo_x86 *c)
 		return;
 
 	index_msb = get_count_order(smp_num_siblings);
-	c->phys_proc_id = apic->phys_pkg_id(c->topo.initial_apicid, index_msb);
+	c->topo.pkg_id = apic->phys_pkg_id(c->topo.initial_apicid, index_msb);
 
 	smp_num_siblings = smp_num_siblings / c->x86_max_cores;
 
@@ -1769,7 +1769,7 @@ static void generic_identify(struct cpuinfo_x86 *c)
 		c->topo.apicid = c->topo.initial_apicid;
 # endif
 #endif
-		c->phys_proc_id = c->topo.initial_apicid;
+		c->topo.pkg_id = c->topo.initial_apicid;
 	}
 
 	get_model_name(c); /* Default name */
@@ -1807,7 +1807,7 @@ static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
 		pr_err(FW_BUG "CPU%u: APIC id mismatch. Firmware: %x APIC: %x\n",
 		       cpu, apicid, c->topo.initial_apicid);
 	}
-	BUG_ON(topology_update_package_map(c->phys_proc_id, cpu));
+	BUG_ON(topology_update_package_map(c->topo.pkg_id, cpu));
 	BUG_ON(topology_update_die_map(c->cpu_die_id, cpu));
 #else
 	c->logical_proc_id = 0;
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 320d18d..5349735 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -92,7 +92,7 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 		 * when running on host.
 		 */
 		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) && c->x86_model <= 0x3)
-			c->phys_proc_id = c->topo.apicid >> APICID_SOCKET_ID_BIT;
+			c->topo.pkg_id = c->topo.apicid >> APICID_SOCKET_ID_BIT;
 
 		cacheinfo_hygon_init_llc_id(c, cpu);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
@@ -122,9 +122,9 @@ static void hygon_detect_cmp(struct cpuinfo_x86 *c)
 	/* Low order bits define the core id (index of core in socket) */
 	c->cpu_core_id = c->topo.initial_apicid & ((1 << bits)-1);
 	/* Convert the initial APIC ID into the socket ID */
-	c->phys_proc_id = c->topo.initial_apicid >> bits;
+	c->topo.pkg_id = c->topo.initial_apicid >> bits;
 	/* use socket ID also for last level cache */
-	per_cpu(cpu_llc_id, cpu) = c->cpu_die_id = c->phys_proc_id;
+	per_cpu(cpu_llc_id, cpu) = c->cpu_die_id = c->topo.pkg_id;
 }
 
 static void srat_detect_node(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index adb37b8..7f7309f 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -105,7 +105,7 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	for_each_possible_cpu(cpu) {
 		if (cpu_data(cpu).topo.initial_apicid == lapic_id) {
 			m.extcpu = cpu;
-			m.socketid = cpu_data(m.extcpu).phys_proc_id;
+			m.socketid = cpu_data(m.extcpu).topo.pkg_id;
 			break;
 		}
 	}
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b5e9288..8007526 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -123,7 +123,7 @@ void mce_setup(struct mce *m)
 	m->time = __ktime_get_real_seconds();
 	m->cpuvendor = boot_cpu_data.x86_vendor;
 	m->cpuid = cpuid_eax(1);
-	m->socketid = cpu_data(m->extcpu).phys_proc_id;
+	m->socketid = cpu_data(m->extcpu).topo.pkg_id;
 	m->apicid = cpu_data(m->extcpu).topo.initial_apicid;
 	m->mcgcap = __rdmsr(MSR_IA32_MCG_CAP);
 	m->ppin = cpu_data(m->extcpu).ppin;
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 91eb0bc..366af2e 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -20,7 +20,7 @@ static void show_cpuinfo_core(struct seq_file *m, struct cpuinfo_x86 *c,
 			      unsigned int cpu)
 {
 #ifdef CONFIG_SMP
-	seq_printf(m, "physical id\t: %d\n", c->phys_proc_id);
+	seq_printf(m, "physical id\t: %d\n", c->topo.pkg_id);
 	seq_printf(m, "siblings\t: %d\n",
 		   cpumask_weight(topology_core_cpumask(cpu)));
 	seq_printf(m, "core id\t\t: %d\n", c->cpu_core_id);
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 73c47a8..0da4755 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -154,8 +154,7 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 					core_plus_mask_width) & die_select_mask;
 	}
 
-	c->phys_proc_id = apic->phys_pkg_id(c->topo.initial_apicid,
-				pkg_mask_width);
+	c->topo.pkg_id = apic->phys_pkg_id(c->topo.initial_apicid, pkg_mask_width);
 	/*
 	 * Reinit the apicid, now that we have extended initial_apicid.
 	 */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 4e45ff4..c5f4abb 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -339,7 +339,7 @@ int topology_phys_to_logical_pkg(unsigned int phys_pkg)
 	for_each_possible_cpu(cpu) {
 		struct cpuinfo_x86 *c = &cpu_data(cpu);
 
-		if (c->initialized && c->phys_proc_id == phys_pkg)
+		if (c->initialized && c->topo.pkg_id == phys_pkg)
 			return c->logical_proc_id;
 	}
 	return -1;
@@ -355,13 +355,13 @@ EXPORT_SYMBOL(topology_phys_to_logical_pkg);
  */
 static int topology_phys_to_logical_die(unsigned int die_id, unsigned int cur_cpu)
 {
-	int cpu, proc_id = cpu_data(cur_cpu).phys_proc_id;
+	int cpu, proc_id = cpu_data(cur_cpu).topo.pkg_id;
 
 	for_each_possible_cpu(cpu) {
 		struct cpuinfo_x86 *c = &cpu_data(cpu);
 
 		if (c->initialized && c->cpu_die_id == die_id &&
-		    c->phys_proc_id == proc_id)
+		    c->topo.pkg_id == proc_id)
 			return c->logical_die_id;
 	}
 	return -1;
@@ -421,7 +421,7 @@ static void __init smp_store_boot_cpu_info(void)
 
 	*c = boot_cpu_data;
 	c->cpu_index = id;
-	topology_update_package_map(c->phys_proc_id, id);
+	topology_update_package_map(c->topo.pkg_id, id);
 	topology_update_die_map(c->cpu_die_id, id);
 	c->initialized = true;
 }
@@ -476,7 +476,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
 		int cpu1 = c->cpu_index, cpu2 = o->cpu_index;
 
-		if (c->phys_proc_id == o->phys_proc_id &&
+		if (c->topo.pkg_id == o->topo.pkg_id &&
 		    c->cpu_die_id == o->cpu_die_id &&
 		    per_cpu(cpu_llc_id, cpu1) == per_cpu(cpu_llc_id, cpu2)) {
 			if (c->cpu_core_id == o->cpu_core_id)
@@ -488,7 +488,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 				return topology_sane(c, o, "smt");
 		}
 
-	} else if (c->phys_proc_id == o->phys_proc_id &&
+	} else if (c->topo.pkg_id == o->topo.pkg_id &&
 		   c->cpu_die_id == o->cpu_die_id &&
 		   c->cpu_core_id == o->cpu_core_id) {
 		return topology_sane(c, o, "smt");
@@ -499,7 +499,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 
 static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
-	if (c->phys_proc_id == o->phys_proc_id &&
+	if (c->topo.pkg_id == o->topo.pkg_id &&
 	    c->cpu_die_id == o->cpu_die_id)
 		return true;
 	return false;
@@ -527,7 +527,7 @@ static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
  */
 static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
-	if (c->phys_proc_id == o->phys_proc_id)
+	if (c->topo.pkg_id == o->topo.pkg_id)
 		return true;
 	return false;
 }
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 9e59c05..3543772 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -12442,9 +12442,6 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 	int max_core_id, min_core_id;
 	struct lpfc_vector_map_info *cpup;
 	struct lpfc_vector_map_info *new_cpup;
-#ifdef CONFIG_X86
-	struct cpuinfo_x86 *cpuinfo;
-#endif
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	struct lpfc_hdwq_stat *c_stat;
 #endif
@@ -12458,8 +12455,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 	for_each_present_cpu(cpu) {
 		cpup = &phba->sli4_hba.cpu_map[cpu];
 #ifdef CONFIG_X86
-		cpuinfo = &cpu_data(cpu);
-		cpup->phys_id = cpuinfo->phys_proc_id;
+		cpup->phys_id = topology_physical_package_id(cpu);
 		cpup->core_id = cpuinfo->cpu_core_id;
 		if (lpfc_find_hyper(phba, cpu, cpup->phys_id, cpup->core_id))
 			cpup->flag |= LPFC_CPU_MAP_HYPER;

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC99A766CB0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbjG1MNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbjG1MMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:12:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB67268B;
        Fri, 28 Jul 2023 05:12:46 -0700 (PDT)
Message-ID: <20230728120929.778470356@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=I51FvGvV/xruMOQFpSsZxNsz8mCYiGuaQ5bmqM+I82Y=;
        b=shCtGBp54RgfNwMgK/zSxAri0088zWyln/116ufB+gBIUaEXmCHazpEtS6cL7g/bf2bVAT
        VOdsZJ0eoKj/ZIEP6pQ/SXjw2wJa1Pt4GDFmIzz/8asmRjhVDFDGfE3GaYsZlaoojxSuFY
        2DraHIH2ytyvJ3vFnIyw1jBcsu3aJPDoRjTS3x9u++xY3AZXiyMEhVsPvreZloaIP+yQCU
        NrOWl6e1YF73p0Z1/7hKG0H1jFLzIONOQrBfluWYSgCqFp4yo26A6Rtv1+xrLPSZqaFAyg
        La9CY1GMOKctBA06traH4z8WHs7xQFYWFw2lKzeNpzOC3NEO239h2v5d4YKanw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=I51FvGvV/xruMOQFpSsZxNsz8mCYiGuaQ5bmqM+I82Y=;
        b=/jSdtju8deI+4oeqdsZfotPeer8nnFqoo4nYwqX2ymKTciG4HqYWW9pVPok/1oFa404lBF
        YoQbLXSfnFgX/kBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch v2 02/38] x86/cpu: Move phys_proc_id into topology info
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:12:45 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename it to pkg_id which is the terminology used in the kernel.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/arch/x86/topology.rst  |    2 +-
 arch/x86/include/asm/processor.h     |    5 +++--
 arch/x86/include/asm/topology.h      |    2 +-
 arch/x86/include/asm/x86_init.h      |    2 +-
 arch/x86/kernel/apic/apic_numachip.c |    2 +-
 arch/x86/kernel/cpu/amd.c            |    4 ++--
 arch/x86/kernel/cpu/cacheinfo.c      |    4 ++--
 arch/x86/kernel/cpu/common.c         |    6 +++---
 arch/x86/kernel/cpu/hygon.c          |    6 +++---
 arch/x86/kernel/cpu/mce/apei.c       |    2 +-
 arch/x86/kernel/cpu/mce/core.c       |    2 +-
 arch/x86/kernel/cpu/proc.c           |    2 +-
 arch/x86/kernel/cpu/topology.c       |    3 +--
 arch/x86/kernel/smpboot.c            |   16 ++++++++--------
 drivers/scsi/lpfc/lpfc_init.c        |    6 +-----
 15 files changed, 30 insertions(+), 34 deletions(-)

--- a/Documentation/arch/x86/topology.rst
+++ b/Documentation/arch/x86/topology.rst
@@ -59,7 +59,7 @@ AMD nomenclature for package is 'Node'.
 
     The physical ID of the die. This information is retrieved via CPUID.
 
-  - cpuinfo_x86.phys_proc_id:
+  - cpuinfo_x86.topo.pkg_id:
 
     The physical ID of the package. This information is retrieved via CPUID
     and deduced from the APIC IDs of the cores in the package.
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -82,6 +82,9 @@ struct cpuinfo_topology {
 	u32			apicid;
 	// The initial APIC ID provided by CPUID
 	u32			initial_apicid;
+
+	// Physical package ID
+	u32			pkg_id;
 };
 
 struct cpuinfo_x86 {
@@ -133,8 +136,6 @@ struct cpuinfo_x86 {
 	u16			x86_clflush_size;
 	/* number of cores as seen by the OS: */
 	u16			booted_cores;
-	/* Physical processor id: */
-	u16			phys_proc_id;
 	/* Logical processor id: */
 	u16			logical_proc_id;
 	/* Core id: */
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -106,7 +106,7 @@ extern const struct cpumask *cpu_coregro
 extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
-#define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
+#define topology_physical_package_id(cpu)	(cpu_data(cpu).topo.pkg_id)
 #define topology_logical_die_id(cpu)		(cpu_data(cpu).logical_die_id)
 #define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
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
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -169,7 +169,7 @@ static void fixup_cpu_id(struct cpuinfo_
 		nodes = ((val >> 3) & 7) + 1;
 	}
 
-	c->phys_proc_id = node / nodes;
+	c->topo.pkg_id = node / nodes;
 }
 
 static int __init numachip_system_init(void)
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -389,9 +389,9 @@ static void amd_detect_cmp(struct cpuinf
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
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -875,10 +875,10 @@ void init_intel_cacheinfo(struct cpuinfo
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
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -899,7 +899,7 @@ void detect_ht(struct cpuinfo_x86 *c)
 		return;
 
 	index_msb = get_count_order(smp_num_siblings);
-	c->phys_proc_id = apic->phys_pkg_id(c->topo.initial_apicid, index_msb);
+	c->topo.pkg_id = apic->phys_pkg_id(c->topo.initial_apicid, index_msb);
 
 	smp_num_siblings = smp_num_siblings / c->x86_max_cores;
 
@@ -1729,7 +1729,7 @@ static void generic_identify(struct cpui
 		c->topo.apicid = c->topo.initial_apicid;
 # endif
 #endif
-		c->phys_proc_id = c->topo.initial_apicid;
+		c->topo.pkg_id = c->topo.initial_apicid;
 	}
 
 	get_model_name(c); /* Default name */
@@ -1767,7 +1767,7 @@ static void validate_apic_and_package_id
 		pr_err(FW_BUG "CPU%u: APIC id mismatch. Firmware: %x APIC: %x\n",
 		       cpu, apicid, c->topo.initial_apicid);
 	}
-	BUG_ON(topology_update_package_map(c->phys_proc_id, cpu));
+	BUG_ON(topology_update_package_map(c->topo.pkg_id, cpu));
 	BUG_ON(topology_update_die_map(c->cpu_die_id, cpu));
 #else
 	c->logical_proc_id = 0;
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -88,7 +88,7 @@ static void hygon_get_topology(struct cp
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
 		/* Socket ID is ApicId[6] for these processors. */
-		c->phys_proc_id = c->topo.apicid >> APICID_SOCKET_ID_BIT;
+		c->topo.pkg_id = c->topo.apicid >> APICID_SOCKET_ID_BIT;
 
 		cacheinfo_hygon_init_llc_id(c, cpu);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
@@ -118,9 +118,9 @@ static void hygon_detect_cmp(struct cpui
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
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -105,7 +105,7 @@ int apei_smca_report_x86_error(struct cp
 	for_each_possible_cpu(cpu) {
 		if (cpu_data(cpu).topo.initial_apicid == lapic_id) {
 			m.extcpu = cpu;
-			m.socketid = cpu_data(m.extcpu).phys_proc_id;
+			m.socketid = cpu_data(m.extcpu).topo.pkg_id;
 			break;
 		}
 	}
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
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -18,7 +18,7 @@ static void show_cpuinfo_core(struct seq
 			      unsigned int cpu)
 {
 #ifdef CONFIG_SMP
-	seq_printf(m, "physical id\t: %d\n", c->phys_proc_id);
+	seq_printf(m, "physical id\t: %d\n", c->topo.pkg_id);
 	seq_printf(m, "siblings\t: %d\n",
 		   cpumask_weight(topology_core_cpumask(cpu)));
 	seq_printf(m, "core id\t\t: %d\n", c->cpu_core_id);
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -154,8 +154,7 @@ int detect_extended_topology(struct cpui
 					core_plus_mask_width) & die_select_mask;
 	}
 
-	c->phys_proc_id = apic->phys_pkg_id(c->topo.initial_apicid,
-				pkg_mask_width);
+	c->topo.pkg_id = apic->phys_pkg_id(c->topo.initial_apicid, pkg_mask_width);
 	/*
 	 * Reinit the apicid, now that we have extended initial_apicid.
 	 */
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -347,7 +347,7 @@ int topology_phys_to_logical_pkg(unsigne
 	for_each_possible_cpu(cpu) {
 		struct cpuinfo_x86 *c = &cpu_data(cpu);
 
-		if (c->initialized && c->phys_proc_id == phys_pkg)
+		if (c->initialized && c->topo.pkg_id == phys_pkg)
 			return c->logical_proc_id;
 	}
 	return -1;
@@ -363,13 +363,13 @@ EXPORT_SYMBOL(topology_phys_to_logical_p
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
@@ -429,7 +429,7 @@ void __init smp_store_boot_cpu_info(void
 
 	*c = boot_cpu_data;
 	c->cpu_index = id;
-	topology_update_package_map(c->phys_proc_id, id);
+	topology_update_package_map(c->topo.pkg_id, id);
 	topology_update_die_map(c->cpu_die_id, id);
 	c->initialized = true;
 }
@@ -484,7 +484,7 @@ static bool match_smt(struct cpuinfo_x86
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
 		int cpu1 = c->cpu_index, cpu2 = o->cpu_index;
 
-		if (c->phys_proc_id == o->phys_proc_id &&
+		if (c->topo.pkg_id == o->topo.pkg_id &&
 		    c->cpu_die_id == o->cpu_die_id &&
 		    per_cpu(cpu_llc_id, cpu1) == per_cpu(cpu_llc_id, cpu2)) {
 			if (c->cpu_core_id == o->cpu_core_id)
@@ -496,7 +496,7 @@ static bool match_smt(struct cpuinfo_x86
 				return topology_sane(c, o, "smt");
 		}
 
-	} else if (c->phys_proc_id == o->phys_proc_id &&
+	} else if (c->topo.pkg_id == o->topo.pkg_id &&
 		   c->cpu_die_id == o->cpu_die_id &&
 		   c->cpu_core_id == o->cpu_core_id) {
 		return topology_sane(c, o, "smt");
@@ -507,7 +507,7 @@ static bool match_smt(struct cpuinfo_x86
 
 static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
-	if (c->phys_proc_id == o->phys_proc_id &&
+	if (c->topo.pkg_id == o->topo.pkg_id &&
 	    c->cpu_die_id == o->cpu_die_id)
 		return true;
 	return false;
@@ -535,7 +535,7 @@ static bool match_l2c(struct cpuinfo_x86
  */
 static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
-	if (c->phys_proc_id == o->phys_proc_id)
+	if (c->topo.pkg_id == o->topo.pkg_id)
 		return true;
 	return false;
 }
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -12428,9 +12428,6 @@ lpfc_cpu_affinity_check(struct lpfc_hba
 	int max_core_id, min_core_id;
 	struct lpfc_vector_map_info *cpup;
 	struct lpfc_vector_map_info *new_cpup;
-#ifdef CONFIG_X86
-	struct cpuinfo_x86 *cpuinfo;
-#endif
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	struct lpfc_hdwq_stat *c_stat;
 #endif
@@ -12444,8 +12441,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba
 	for_each_present_cpu(cpu) {
 		cpup = &phba->sli4_hba.cpu_map[cpu];
 #ifdef CONFIG_X86
-		cpuinfo = &cpu_data(cpu);
-		cpup->phys_id = cpuinfo->phys_proc_id;
+		cpup->phys_id = topology_physical_package_id(cpu);
 		cpup->core_id = cpuinfo->cpu_core_id;
 		if (lpfc_find_hyper(phba, cpu, cpup->phys_id, cpup->core_id))
 			cpup->flag |= LPFC_CPU_MAP_HYPER;


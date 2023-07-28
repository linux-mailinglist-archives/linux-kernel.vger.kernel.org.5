Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FCF766CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbjG1MNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbjG1MM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:12:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C7635A8;
        Fri, 28 Jul 2023 05:12:56 -0700 (PDT)
Message-ID: <20230728120930.224888914@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=THjcCsc2GGXII7qdrYLkqctLPB1i0Li4c4N8xoVrrCo=;
        b=EaoJHnavVzcDK+wH5NbFrxiPp5dAOZEvjCfg5UcyMgiI3u0welfFe5AU0hhfMWC/jZElGT
        Knbc1RtYa0xCYmQsFjVdEJFmnFwdoN9O2v2r3AWtJmUBMcMSpaERbhbU6JHZrJC44YM1nU
        0GMFLJOk71naSv9f+XvUn8GEwOtGQeBwHEBPQt6TinR9DHkeUrbkfHKESMLIMg1WwG3R3y
        JcG3qruVKbCHNacGCqTDMwBebSZ7iLwUi8tT0femiqMXeoTTcRgfOZgnndtBv6lcIIDYYC
        Q+rP9/j3+VqgKhNdEf7gz5OXfEg2Cpxu/2cgtSpKWpeEtlroKGmMX+OKntFboA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=THjcCsc2GGXII7qdrYLkqctLPB1i0Li4c4N8xoVrrCo=;
        b=sqFDG3/xB1n64u0/7dRDUB/5S5dqla8moh50VgAohgJyHdewnipie+3pJ3j7OPyQH+faxN
        ENp7AduQeL5v6cDQ==
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
Subject: [patch v2 10/38] x86/cpu: Move cpu_l[l2]c_id into topology info
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:12:55 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The topology IDs which identify the LLC and L2 domains clearly belong to
the per CPU topology information.

Move them into cpuinfo_x86::cpuinfo_topo and get rid of the extra per CPU
data and the related exports.

This also paves the way to do proper topology evaluation during early boot
because it removes the only per CPU dependency for that.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/arch/x86/topology.rst  |    4 +---
 arch/x86/events/amd/uncore.c         |    2 +-
 arch/x86/include/asm/cacheinfo.h     |    3 ---
 arch/x86/include/asm/processor.h     |   14 +++++++++++++-
 arch/x86/include/asm/smp.h           |    2 --
 arch/x86/include/asm/topology.h      |    2 +-
 arch/x86/kernel/apic/apic_numachip.c |    2 +-
 arch/x86/kernel/cpu/amd.c            |   12 ++++--------
 arch/x86/kernel/cpu/cacheinfo.c      |   33 ++++++++++++---------------------
 arch/x86/kernel/cpu/common.c         |   14 ++------------
 arch/x86/kernel/cpu/cpu.h            |    3 +++
 arch/x86/kernel/cpu/hygon.c          |   14 +++++---------
 arch/x86/kernel/smpboot.c            |   10 +++++-----
 13 files changed, 48 insertions(+), 67 deletions(-)

--- a/Documentation/arch/x86/topology.rst
+++ b/Documentation/arch/x86/topology.rst
@@ -79,9 +79,7 @@ AMD nomenclature for package is 'Node'.
     The maximum possible number of packages in the system. Helpful for per
     package facilities to preallocate per package information.
 
-  - cpu_llc_id:
-
-    A per-CPU variable containing:
+  - cpuinfo_x86.topo.llc_id:
 
       - On Intel, the first APIC ID of the list of CPUs sharing the Last Level
         Cache
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -537,7 +537,7 @@ static int amd_uncore_cpu_starting(unsig
 
 	if (amd_uncore_llc) {
 		uncore = *per_cpu_ptr(amd_uncore_llc, cpu);
-		uncore->id = get_llc_id(cpu);
+		uncore->id = per_cpu_llc_id(cpu);
 
 		uncore = amd_uncore_find_online_sibling(uncore, amd_uncore_llc);
 		*per_cpu_ptr(amd_uncore_llc, cpu) = uncore;
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -7,9 +7,6 @@ extern unsigned int memory_caching_contr
 #define CACHE_MTRR 0x01
 #define CACHE_PAT  0x02
 
-void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu);
-void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu);
-
 void cache_disable(void);
 void cache_enable(void);
 void set_cache_aps_delayed_init(bool val);
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -98,6 +98,10 @@ struct cpuinfo_topology {
 	// Logical ID mappings
 	u32			logical_pkg_id;
 	u32			logical_die_id;
+
+	// Cache level topology IDs
+	u32			llc_id;
+	u32			l2c_id;
 };
 
 struct cpuinfo_x86 {
@@ -687,7 +691,15 @@ extern int set_tsc_mode(unsigned int val
 
 DECLARE_PER_CPU(u64, msr_misc_features_shadow);
 
-extern u16 get_llc_id(unsigned int cpu);
+static inline u16 per_cpu_llc_id(unsigned int cpu)
+{
+	return per_cpu(cpu_info.topo.llc_id, cpu);
+}
+
+static inline u16 per_cpu_l2c_id(unsigned int cpu)
+{
+	return per_cpu(cpu_info.topo.l2c_id, cpu);
+}
 
 #ifdef CONFIG_CPU_SUP_AMD
 extern u32 amd_get_nodes_per_socket(void);
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -17,8 +17,6 @@ DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_
 /* cpus sharing the last level cache: */
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
-DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id);
-DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id);
 
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid);
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid);
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -115,7 +115,7 @@ extern const struct cpumask *cpu_cluster
 extern unsigned int __max_die_per_package;
 
 #ifdef CONFIG_SMP
-#define topology_cluster_id(cpu)		(per_cpu(cpu_l2c_id, cpu))
+#define topology_cluster_id(cpu)		(cpu_data(cpu).topo.l2c_id)
 #define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
 #define topology_cluster_cpumask(cpu)		(cpu_clustergroup_mask(cpu))
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -161,7 +161,7 @@ static void fixup_cpu_id(struct cpuinfo_
 	u64 val;
 	u32 nodes = 1;
 
-	this_cpu_write(cpu_llc_id, node);
+	c->topo.llc_id = node;
 
 	/* Account for nodes per socket in multi-core-module processors */
 	if (boot_cpu_has(X86_FEATURE_NODEID_MSR)) {
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -329,8 +329,6 @@ static void legacy_fixup_core_id(struct
  */
 static void amd_get_topology(struct cpuinfo_x86 *c)
 {
-	int cpu = smp_processor_id();
-
 	/* get information required for multi-node processors */
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
 		int err;
@@ -358,15 +356,14 @@ static void amd_get_topology(struct cpui
 		if (!err)
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
-		cacheinfo_amd_init_llc_id(c, cpu);
+		cacheinfo_amd_init_llc_id(c);
 
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
 
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
 		c->topo.die_id = value & 7;
-
-		per_cpu(cpu_llc_id, cpu) = c->topo.die_id;
+		c->topo.llc_id = c->topo.die_id;
 	} else
 		return;
 
@@ -383,7 +380,6 @@ static void amd_get_topology(struct cpui
 static void amd_detect_cmp(struct cpuinfo_x86 *c)
 {
 	unsigned bits;
-	int cpu = smp_processor_id();
 
 	bits = c->x86_coreid_bits;
 	/* Low order bits define the core id (index of core in socket) */
@@ -391,7 +387,7 @@ static void amd_detect_cmp(struct cpuinf
 	/* Convert the initial APIC ID into the socket ID */
 	c->topo.pkg_id = c->topo.initial_apicid >> bits;
 	/* use socket ID also for last level cache */
-	per_cpu(cpu_llc_id, cpu) = c->topo.die_id = c->topo.pkg_id;
+	c->topo.llc_id = c->topo.die_id = c->topo.pkg_id;
 }
 
 u32 amd_get_nodes_per_socket(void)
@@ -409,7 +405,7 @@ static void srat_detect_node(struct cpui
 
 	node = numa_cpu_node(cpu);
 	if (node == NUMA_NO_NODE)
-		node = get_llc_id(cpu);
+		node = per_cpu_llc_id(cpu);
 
 	/*
 	 * On multi-fabric platform (e.g. Numascale NumaChip) a
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -661,7 +661,7 @@ static int find_num_cache_leaves(struct
 	return i;
 }
 
-void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu)
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c)
 {
 	/*
 	 * We may have multiple LLCs if L3 caches exist, so check if we
@@ -672,13 +672,13 @@ void cacheinfo_amd_init_llc_id(struct cp
 
 	if (c->x86 < 0x17) {
 		/* LLC is at the node level. */
-		per_cpu(cpu_llc_id, cpu) = c->topo.die_id;
+		c->topo.llc_id = c->topo.die_id;
 	} else if (c->x86 == 0x17 && c->x86_model <= 0x1F) {
 		/*
 		 * LLC is at the core complex level.
 		 * Core complex ID is ApicId[3] for these processors.
 		 */
-		per_cpu(cpu_llc_id, cpu) = c->topo.apicid >> 3;
+		c->topo.llc_id = c->topo.apicid >> 3;
 	} else {
 		/*
 		 * LLC ID is calculated from the number of threads sharing the
@@ -694,12 +694,12 @@ void cacheinfo_amd_init_llc_id(struct cp
 		if (num_sharing_cache) {
 			int bits = get_count_order(num_sharing_cache);
 
-			per_cpu(cpu_llc_id, cpu) = c->topo.apicid >> bits;
+			c->topo.llc_id = c->topo.apicid >> bits;
 		}
 	}
 }
 
-void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu)
+void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c)
 {
 	/*
 	 * We may have multiple LLCs if L3 caches exist, so check if we
@@ -712,7 +712,7 @@ void cacheinfo_hygon_init_llc_id(struct
 	 * LLC is at the core complex level.
 	 * Core complex ID is ApicId[3] for these processors.
 	 */
-	per_cpu(cpu_llc_id, cpu) = c->topo.apicid >> 3;
+	c->topo.llc_id = c->topo.apicid >> 3;
 }
 
 void init_amd_cacheinfo(struct cpuinfo_x86 *c)
@@ -740,9 +740,6 @@ void init_intel_cacheinfo(struct cpuinfo
 	unsigned int new_l1d = 0, new_l1i = 0; /* Cache sizes from cpuid(4) */
 	unsigned int new_l2 = 0, new_l3 = 0, i; /* Cache sizes from cpuid(4) */
 	unsigned int l2_id = 0, l3_id = 0, num_threads_sharing, index_msb;
-#ifdef CONFIG_SMP
-	unsigned int cpu = c->cpu_index;
-#endif
 
 	if (c->cpuid_level > 3) {
 		static int is_initialized;
@@ -856,30 +853,24 @@ void init_intel_cacheinfo(struct cpuinfo
 
 	if (new_l2) {
 		l2 = new_l2;
-#ifdef CONFIG_SMP
-		per_cpu(cpu_llc_id, cpu) = l2_id;
-		per_cpu(cpu_l2c_id, cpu) = l2_id;
-#endif
+		c->topo.llc_id = l2_id;
+		c->topo.l2c_id = l2_id;
 	}
 
 	if (new_l3) {
 		l3 = new_l3;
-#ifdef CONFIG_SMP
-		per_cpu(cpu_llc_id, cpu) = l3_id;
-#endif
+		c->topo.llc_id = l3_id;
 	}
 
-#ifdef CONFIG_SMP
 	/*
-	 * If cpu_llc_id is not yet set, this means cpuid_level < 4 which in
+	 * If llc_id is not yet set, this means cpuid_level < 4 which in
 	 * turns means that the only possibility is SMT (as indicated in
 	 * cpuid1). Since cpuid2 doesn't specify shared caches, and we know
 	 * that SMT shares all caches, we can unconditionally set cpu_llc_id to
 	 * c->topo.pkg_id.
 	 */
-	if (per_cpu(cpu_llc_id, cpu) == BAD_APICID)
-		per_cpu(cpu_llc_id, cpu) = c->topo.pkg_id;
-#endif
+	if (c->topo.llc_id == BAD_APICID)
+		c->topo.llc_id = c->topo.pkg_id;
 
 	c->x86_cache_size = l3 ? l3 : (l2 ? l2 : (l1i+l1d));
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -75,18 +75,6 @@ u32 elf_hwcap2 __read_mostly;
 int smp_num_siblings = 1;
 EXPORT_SYMBOL(smp_num_siblings);
 
-/* Last level cache ID of each logical CPU */
-DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id) = BAD_APICID;
-
-u16 get_llc_id(unsigned int cpu)
-{
-	return per_cpu(cpu_llc_id, cpu);
-}
-EXPORT_SYMBOL_GPL(get_llc_id);
-
-/* L2 cache ID of each logical CPU */
-DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id) = BAD_APICID;
-
 static struct ppin_info {
 	int	feature;
 	int	msr_ppin_ctl;
@@ -1790,6 +1778,8 @@ static void identify_cpu(struct cpuinfo_
 	c->x86_max_cores = 1;
 	c->x86_coreid_bits = 0;
 	c->topo.cu_id = 0xff;
+	c->topo.llc_id = BAD_APICID;
+	c->topo.l2c_id = BAD_APICID;
 #ifdef CONFIG_X86_64
 	c->x86_clflush_size = 64;
 	c->x86_phys_bits = 36;
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -78,6 +78,9 @@ extern int detect_ht_early(struct cpuinf
 extern void detect_ht(struct cpuinfo_x86 *c);
 extern void check_null_seg_clears_base(struct cpuinfo_x86 *c);
 
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c);
+void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c);
+
 unsigned int aperfmperf_get_khz(int cpu);
 void cpu_select_mitigations(void);
 
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -63,8 +63,6 @@ static void hygon_get_topology_early(str
  */
 static void hygon_get_topology(struct cpuinfo_x86 *c)
 {
-	int cpu = smp_processor_id();
-
 	/* get information required for multi-node processors */
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
 		int err;
@@ -90,14 +88,13 @@ static void hygon_get_topology(struct cp
 		/* Socket ID is ApicId[6] for these processors. */
 		c->topo.pkg_id = c->topo.apicid >> APICID_SOCKET_ID_BIT;
 
-		cacheinfo_hygon_init_llc_id(c, cpu);
+		cacheinfo_hygon_init_llc_id(c);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
 
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
 		c->topo.die_id = value & 7;
-
-		per_cpu(cpu_llc_id, cpu) = c->topo.die_id;
+		c->topo.llc_id = c->topo.die_id;
 	} else
 		return;
 
@@ -112,15 +109,14 @@ static void hygon_get_topology(struct cp
 static void hygon_detect_cmp(struct cpuinfo_x86 *c)
 {
 	unsigned int bits;
-	int cpu = smp_processor_id();
 
 	bits = c->x86_coreid_bits;
 	/* Low order bits define the core id (index of core in socket) */
 	c->topo.core_id = c->topo.initial_apicid & ((1 << bits)-1);
 	/* Convert the initial APIC ID into the socket ID */
 	c->topo.pkg_id = c->topo.initial_apicid >> bits;
-	/* use socket ID also for last level cache */
-	per_cpu(cpu_llc_id, cpu) = c->topo.die_id = c->topo.pkg_id;
+	/* Use package ID also for last level cache */
+	c->topo.llc_id = c->topo.die_id = c->topo.pkg_id;
 }
 
 static void srat_detect_node(struct cpuinfo_x86 *c)
@@ -132,7 +128,7 @@ static void srat_detect_node(struct cpui
 
 	node = numa_cpu_node(cpu);
 	if (node == NUMA_NO_NODE)
-		node = per_cpu(cpu_llc_id, cpu);
+		node = c->topo.llc_id;
 
 	/*
 	 * On multi-fabric platform (e.g. Numascale NumaChip) a
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -486,7 +486,7 @@ static bool match_smt(struct cpuinfo_x86
 
 		if (c->topo.pkg_id == o->topo.pkg_id &&
 		    c->topo.die_id == o->topo.die_id &&
-		    per_cpu(cpu_llc_id, cpu1) == per_cpu(cpu_llc_id, cpu2)) {
+		    per_cpu_llc_id(cpu1) == per_cpu_llc_id(cpu2)) {
 			if (c->topo.core_id == o->topo.core_id)
 				return topology_sane(c, o, "smt");
 
@@ -518,11 +518,11 @@ static bool match_l2c(struct cpuinfo_x86
 	int cpu1 = c->cpu_index, cpu2 = o->cpu_index;
 
 	/* If the arch didn't set up l2c_id, fall back to SMT */
-	if (per_cpu(cpu_l2c_id, cpu1) == BAD_APICID)
+	if (per_cpu_l2c_id(cpu1) == BAD_APICID)
 		return match_smt(c, o);
 
 	/* Do not match if L2 cache id does not match: */
-	if (per_cpu(cpu_l2c_id, cpu1) != per_cpu(cpu_l2c_id, cpu2))
+	if (per_cpu_l2c_id(cpu1) != per_cpu_l2c_id(cpu2))
 		return false;
 
 	return topology_sane(c, o, "l2c");
@@ -568,11 +568,11 @@ static bool match_llc(struct cpuinfo_x86
 	bool intel_snc = id && id->driver_data;
 
 	/* Do not match if we do not have a valid APICID for cpu: */
-	if (per_cpu(cpu_llc_id, cpu1) == BAD_APICID)
+	if (per_cpu_llc_id(cpu1) == BAD_APICID)
 		return false;
 
 	/* Do not match if LLC id does not match: */
-	if (per_cpu(cpu_llc_id, cpu1) != per_cpu(cpu_llc_id, cpu2))
+	if (per_cpu_llc_id(cpu1) != per_cpu_llc_id(cpu2))
 		return false;
 
 	/*


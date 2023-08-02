Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6DB76CAD1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjHBKZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjHBKYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:24:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE113585
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:22:31 -0700 (PDT)
Message-ID: <20230802101934.365251186@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690971703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=2HJ6gKC8xKh7ZYiNVCch9OIndLCiZ8cyEEDMpJCZ4Vw=;
        b=D2ogqaTXRcxKevHJH7De736AgjuNSAePAHCq/0OuaEiFm4RqbbWDdPS2z3oMrKrPd51uic
        BmLCB/qmsvJVW54Nj/vgRnAGVRY5skFxVyl3zqRObFpZmBuEqr1JgGDbQZHiit0JR5abgw
        kCxui0B2GzTU3HUg9C5knU9KPR1lmtBtXnsgJ9D2TrupE+nOEEO0XH+2qpXUs+xycQ4Pio
        s6IeGX4DzuF8GD71JAGv1E3vMqgDp0sy++1Qv4cQZ8hhpuMWUrZxgVNmjsKwHT3cqFQXzt
        qfV+fW82/cK7yYk6DWtQHOxfJmt/ngeohvoKS4GEqXX2DGM3y8G4f3UyZz/ONQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690971703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=2HJ6gKC8xKh7ZYiNVCch9OIndLCiZ8cyEEDMpJCZ4Vw=;
        b=AMDX7xS2dT7jig1/0/6r7F0DuRvL0lATJxRl3Zn+Lsnf+c0Ndgp4bcnqPXydLDRgr74PER
        U729KKsXGaNp8tBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [patch V3 29/40] x86/cpu/amd: Provide a separate accessor for Node ID
References: <20230802101635.459108805@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  2 Aug 2023 12:21:43 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD (ab)uses topology_die_id() to store the Node ID information and
topology_max_dies_per_pkg to store the number of nodes per package.

This collides with the proper processor die level enumeration which is
coming on AMD with CPUID 8000_0026, unless there is a correlation between
the two. There is zero documentation about that.

So provide new storage and new accessors which for now still access die_id
and topology_max_dies_per_pkg. Will be mopped up after AMD and HYGON are
converted over.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/events/amd/core.c       |    2 +-
 arch/x86/include/asm/processor.h |    3 +++
 arch/x86/include/asm/topology.h  |    8 ++++++++
 arch/x86/kernel/amd_nb.c         |    4 ++--
 arch/x86/kernel/cpu/cacheinfo.c  |    2 +-
 arch/x86/kernel/cpu/mce/amd.c    |    4 ++--
 arch/x86/kernel/cpu/mce/inject.c |    4 ++--
 drivers/edac/amd64_edac.c        |    4 ++--
 drivers/edac/mce_amd.c           |    4 ++--
 9 files changed, 23 insertions(+), 12 deletions(-)

--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -574,7 +574,7 @@ static void amd_pmu_cpu_starting(int cpu
 	if (!x86_pmu.amd_nb_constraints)
 		return;
 
-	nb_id = topology_die_id(cpu);
+	nb_id = topology_amd_node_id(cpu);
 	WARN_ON_ONCE(nb_id == BAD_APICID);
 
 	for_each_online_cpu(i) {
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -99,6 +99,9 @@ struct cpuinfo_topology {
 	u32			logical_pkg_id;
 	u32			logical_die_id;
 
+	// AMD Node ID and Nodes per Package info
+	u32			amd_node_id;
+
 	// Cache level topology IDs
 	u32			llc_id;
 	u32			l2c_id;
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -131,6 +131,8 @@ extern const struct cpumask *cpu_cluster
 #define topology_core_id(cpu)			(cpu_data(cpu).topo.core_id)
 #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
 
+#define topology_amd_node_id(cpu)		(cpu_data(cpu).topo.die_id)
+
 extern unsigned int __max_die_per_package;
 
 #ifdef CONFIG_SMP
@@ -160,6 +162,11 @@ int topology_update_die_map(unsigned int
 int topology_phys_to_logical_pkg(unsigned int pkg);
 bool topology_smt_supported(void);
 
+static inline unsigned int topology_amd_nodes_per_pkg(void)
+{
+	return __max_die_per_package;
+}
+
 extern struct cpumask __cpu_primary_thread_mask;
 #define cpu_primary_thread_mask ((const struct cpumask *)&__cpu_primary_thread_mask)
 
@@ -182,6 +189,7 @@ static inline int topology_max_die_per_p
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
 static inline bool topology_smt_supported(void) { return false; }
+static inline unsigned int topology_amd_nodes_per_pkg(void) { return 0; };
 #endif /* !CONFIG_SMP */
 
 static inline void arch_fix_phys_package_id(int num, u32 slot)
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -370,7 +370,7 @@ struct resource *amd_get_mmconfig_range(
 
 int amd_get_subcaches(int cpu)
 {
-	struct pci_dev *link = node_to_amd_nb(topology_die_id(cpu))->link;
+	struct pci_dev *link = node_to_amd_nb(topology_amd_node_id(cpu))->link;
 	unsigned int mask;
 
 	if (!amd_nb_has_feature(AMD_NB_L3_PARTITIONING))
@@ -384,7 +384,7 @@ int amd_get_subcaches(int cpu)
 int amd_set_subcaches(int cpu, unsigned long mask)
 {
 	static unsigned int reset, ban;
-	struct amd_northbridge *nb = node_to_amd_nb(topology_die_id(cpu));
+	struct amd_northbridge *nb = node_to_amd_nb(topology_amd_node_id(cpu));
 	unsigned int reg;
 	int cuid;
 
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -595,7 +595,7 @@ static void amd_init_l3_cache(struct _cp
 	if (index < 3)
 		return;
 
-	node = topology_die_id(smp_processor_id());
+	node = topology_amd_node_id(smp_processor_id());
 	this_leaf->nb = node_to_amd_nb(node);
 	if (this_leaf->nb && !this_leaf->nb->l3_cache.indices)
 		amd_calc_l3_indices(this_leaf->nb);
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1181,7 +1181,7 @@ static int threshold_create_bank(struct
 		return -ENODEV;
 
 	if (is_shared_bank(bank)) {
-		nb = node_to_amd_nb(topology_die_id(cpu));
+		nb = node_to_amd_nb(topology_amd_node_id(cpu));
 
 		/* threshold descriptor already initialized on this node? */
 		if (nb && nb->bank4) {
@@ -1285,7 +1285,7 @@ static void threshold_remove_bank(struct
 		 * The last CPU on this node using the shared bank is going
 		 * away, remove that bank now.
 		 */
-		nb = node_to_amd_nb(topology_die_id(smp_processor_id()));
+		nb = node_to_amd_nb(topology_amd_node_id(smp_processor_id()));
 		nb->bank4 = NULL;
 	}
 
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -543,8 +543,8 @@ static void do_inject(void)
 	if (boot_cpu_has(X86_FEATURE_AMD_DCM) &&
 	    b == 4 &&
 	    boot_cpu_data.x86 < 0x17) {
-		toggle_nb_mca_mst_cpu(topology_die_id(cpu));
-		cpu = get_nbc_for_node(topology_die_id(cpu));
+		toggle_nb_mca_mst_cpu(topology_amd_node_id(cpu));
+		cpu = get_nbc_for_node(topology_amd_node_id(cpu));
 	}
 
 	cpus_read_lock();
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1907,7 +1907,7 @@ static void dct_determine_memory_type(st
 /* On F10h and later ErrAddr is MC4_ADDR[47:1] */
 static u64 get_error_address(struct amd64_pvt *pvt, struct mce *m)
 {
-	u16 mce_nid = topology_die_id(m->extcpu);
+	u16 mce_nid = topology_amd_node_id(m->extcpu);
 	struct mem_ctl_info *mci;
 	u8 start_bit = 1;
 	u8 end_bit   = 47;
@@ -3438,7 +3438,7 @@ static void get_cpus_on_this_dct_cpumask
 	int cpu;
 
 	for_each_online_cpu(cpu)
-		if (topology_die_id(cpu) == nid)
+		if (topology_amd_node_id(cpu) == nid)
 			cpumask_set_cpu(cpu, mask);
 }
 
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1060,7 +1060,7 @@ static void decode_mc3_mce(struct mce *m
 static void decode_mc4_mce(struct mce *m)
 {
 	unsigned int fam = x86_family(m->cpuid);
-	int node_id = topology_die_id(m->extcpu);
+	int node_id = topology_amd_node_id(m->extcpu);
 	u16 ec = EC(m->status);
 	u8 xec = XEC(m->status, 0x1f);
 	u8 offset = 0;
@@ -1188,7 +1188,7 @@ static void decode_smca_error(struct mce
 
 	if ((bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2) &&
 	    xec == 0 && decode_dram_ecc)
-		decode_dram_ecc(topology_die_id(m->extcpu), m);
+		decode_dram_ecc(topology_amd_node_id(m->extcpu), m);
 }
 
 static inline void amd_decode_err_code(u16 ec)


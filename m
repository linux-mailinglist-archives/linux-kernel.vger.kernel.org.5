Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1427C8252
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjJMJjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjJMJiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF81D8;
        Fri, 13 Oct 2023 02:38:14 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:38:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697189893;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o6qxcatrF58HXgcT9OEpCwQKSZzueiI9l3VkDgOpTjw=;
        b=youZkk/ZmxKAnU26LyFkfw9B6CbSpLBc7RmJUvldTLmYu9mo1au3eHxARijL9sTnxt+ycJ
        KurgY7IUoW0RKgyGOEN+yN79EY2iPEkv5PZkRb+VQvsxlRsT72Hsbuf1CF9lrgLLlF+I7R
        n703Oru1Cv0kLyjZNYZTco7KnCpmOfXvSkYzjtWUZIbGHXU7VZ9+8PUOCDDU/pmGj6tdbX
        jymbZG3DjXLiJQkU74IEzqOE1LnHfARImbaYfX0GAy3qRqimcgXCtgJLgLBzturo+rCSSN
        edZ85ut3FgBWTWMY6VuHQsPPo0yMXj/p1k3wv6nTAhUlFOP94f+FuQclky1X6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697189893;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o6qxcatrF58HXgcT9OEpCwQKSZzueiI9l3VkDgOpTjw=;
        b=hHj7QOpgEdiIyBmsbaS7ob8rAi4s72YYNKtcNsVdSW3M8qji2KRdcmHhE0q6ykvfqBWkRp
        u3c7W/t6NUYFOfBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu: Encapsulate topology information in cpuinfo_x86
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814085112.269787744@linutronix.de>
References: <20230814085112.269787744@linutronix.de>
MIME-Version: 1.0
Message-ID: <169718989257.3135.4940261358163975261.tip-bot2@tip-bot2>
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

Commit-ID:     b9655e702dc5d856e5e05ae414b71708ca98b30c
Gitweb:        https://git.kernel.org/tip/b9655e702dc5d856e5e05ae414b71708ca98b30c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Aug 2023 10:18:29 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Oct 2023 14:38:17 +02:00

x86/cpu: Encapsulate topology information in cpuinfo_x86

The topology related information is randomly scattered across cpuinfo_x86.

Create a new structure cpuinfo_topo and move in a first step initial_apicid
and apicid into it.

Aside of being better readable this is in preparation for replacing the
horribly fragile CPU topology evaluation code further down the road.

Consolidate APIC ID fields to u32 as that represents the hardware type.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230814085112.269787744@linutronix.de

---
 arch/x86/include/asm/processor.h          | 14 +++++++++-----
 arch/x86/kernel/cpu/amd.c                 | 10 +++++-----
 arch/x86/kernel/cpu/cacheinfo.c           | 20 ++++++++++----------
 arch/x86/kernel/cpu/common.c              | 18 +++++++++---------
 arch/x86/kernel/cpu/hygon.c               | 12 ++++++------
 arch/x86/kernel/cpu/mce/apei.c            |  2 +-
 arch/x86/kernel/cpu/mce/core.c            |  2 +-
 arch/x86/kernel/cpu/proc.c                |  4 ++--
 arch/x86/kernel/cpu/topology.c            | 12 ++++++------
 arch/x86/xen/apic.c                       |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  2 +-
 drivers/virt/acrn/hsm.c                   |  2 +-
 12 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 0086920..6833962 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -75,11 +75,16 @@ extern u16 __read_mostly tlb_lld_4m[NR_INFO];
 extern u16 __read_mostly tlb_lld_1g[NR_INFO];
 
 /*
- *  CPU type and hardware bug flags. Kept separately for each CPU.
- *  Members of this structure are referenced in head_32.S, so think twice
- *  before touching them. [mj]
+ * CPU type and hardware bug flags. Kept separately for each CPU.
  */
 
+struct cpuinfo_topology {
+	// Real APIC ID read from the local APIC
+	u32			apicid;
+	// The initial APIC ID provided by CPUID
+	u32			initial_apicid;
+};
+
 struct cpuinfo_x86 {
 	__u8			x86;		/* CPU family */
 	__u8			x86_vendor;	/* CPU vendor */
@@ -112,6 +117,7 @@ struct cpuinfo_x86 {
 	};
 	char			x86_vendor_id[16];
 	char			x86_model_id[64];
+	struct cpuinfo_topology	topo;
 	/* in KB - valid for CPUS which support this call: */
 	unsigned int		x86_cache_size;
 	int			x86_cache_alignment;	/* In bytes */
@@ -125,8 +131,6 @@ struct cpuinfo_x86 {
 	u64			ppin;
 	/* cpuid returned max cores value: */
 	u16			x86_max_cores;
-	u16			apicid;
-	u16			initial_apicid;
 	u16			x86_clflush_size;
 	/* number of cores as seen by the OS: */
 	u16			booted_cores;
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index dd8379d..1406659 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -459,9 +459,9 @@ static void amd_detect_cmp(struct cpuinfo_x86 *c)
 
 	bits = c->x86_coreid_bits;
 	/* Low order bits define the core id (index of core in socket) */
-	c->cpu_core_id = c->initial_apicid & ((1 << bits)-1);
+	c->cpu_core_id = c->topo.initial_apicid & ((1 << bits)-1);
 	/* Convert the initial APIC ID into the socket ID */
-	c->phys_proc_id = c->initial_apicid >> bits;
+	c->phys_proc_id = c->topo.initial_apicid >> bits;
 	/* use socket ID also for last level cache */
 	per_cpu(cpu_llc_id, cpu) = c->cpu_die_id = c->phys_proc_id;
 }
@@ -477,7 +477,7 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #ifdef CONFIG_NUMA
 	int cpu = smp_processor_id();
 	int node;
-	unsigned apicid = c->apicid;
+	unsigned apicid = c->topo.apicid;
 
 	node = numa_cpu_node(cpu);
 	if (node == NUMA_NO_NODE)
@@ -511,7 +511,7 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 		 * through CPU mapping may alter the outcome, directly
 		 * access __apicid_to_node[].
 		 */
-		int ht_nodeid = c->initial_apicid;
+		int ht_nodeid = c->topo.initial_apicid;
 
 		if (__apicid_to_node[ht_nodeid] != NUMA_NO_NODE)
 			node = __apicid_to_node[ht_nodeid];
@@ -1047,7 +1047,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 		set_cpu_cap(c, X86_FEATURE_FSRS);
 
 	/* get apicid instead of initial apic id from cpuid */
-	c->apicid = read_apic_id();
+	c->topo.apicid = read_apic_id();
 
 	/* K6s reports MCEs but don't actually have all the MSRs */
 	if (c->x86 < 6)
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 8f86eac..daa3542 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -678,7 +678,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu)
 		 * LLC is at the core complex level.
 		 * Core complex ID is ApicId[3] for these processors.
 		 */
-		per_cpu(cpu_llc_id, cpu) = c->apicid >> 3;
+		per_cpu(cpu_llc_id, cpu) = c->topo.apicid >> 3;
 	} else {
 		/*
 		 * LLC ID is calculated from the number of threads sharing the
@@ -694,7 +694,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu)
 		if (num_sharing_cache) {
 			int bits = get_count_order(num_sharing_cache);
 
-			per_cpu(cpu_llc_id, cpu) = c->apicid >> bits;
+			per_cpu(cpu_llc_id, cpu) = c->topo.apicid >> bits;
 		}
 	}
 }
@@ -712,7 +712,7 @@ void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu)
 	 * LLC is at the core complex level.
 	 * Core complex ID is ApicId[3] for these processors.
 	 */
-	per_cpu(cpu_llc_id, cpu) = c->apicid >> 3;
+	per_cpu(cpu_llc_id, cpu) = c->topo.apicid >> 3;
 }
 
 void init_amd_cacheinfo(struct cpuinfo_x86 *c)
@@ -776,13 +776,13 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 				new_l2 = this_leaf.size/1024;
 				num_threads_sharing = 1 + this_leaf.eax.split.num_threads_sharing;
 				index_msb = get_count_order(num_threads_sharing);
-				l2_id = c->apicid & ~((1 << index_msb) - 1);
+				l2_id = c->topo.apicid & ~((1 << index_msb) - 1);
 				break;
 			case 3:
 				new_l3 = this_leaf.size/1024;
 				num_threads_sharing = 1 + this_leaf.eax.split.num_threads_sharing;
 				index_msb = get_count_order(num_threads_sharing);
-				l3_id = c->apicid & ~((1 << index_msb) - 1);
+				l3_id = c->topo.apicid & ~((1 << index_msb) - 1);
 				break;
 			default:
 				break;
@@ -915,7 +915,7 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 		unsigned int apicid, nshared, first, last;
 
 		nshared = base->eax.split.num_threads_sharing + 1;
-		apicid = cpu_data(cpu).apicid;
+		apicid = cpu_data(cpu).topo.apicid;
 		first = apicid - (apicid % nshared);
 		last = first + nshared - 1;
 
@@ -924,14 +924,14 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 			if (!this_cpu_ci->info_list)
 				continue;
 
-			apicid = cpu_data(i).apicid;
+			apicid = cpu_data(i).topo.apicid;
 			if ((apicid < first) || (apicid > last))
 				continue;
 
 			this_leaf = this_cpu_ci->info_list + index;
 
 			for_each_online_cpu(sibling) {
-				apicid = cpu_data(sibling).apicid;
+				apicid = cpu_data(sibling).topo.apicid;
 				if ((apicid < first) || (apicid > last))
 					continue;
 				cpumask_set_cpu(sibling,
@@ -969,7 +969,7 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 	index_msb = get_count_order(num_threads_sharing);
 
 	for_each_online_cpu(i)
-		if (cpu_data(i).apicid >> index_msb == c->apicid >> index_msb) {
+		if (cpu_data(i).topo.apicid >> index_msb == c->topo.apicid >> index_msb) {
 			struct cpu_cacheinfo *sib_cpu_ci = get_cpu_cacheinfo(i);
 
 			if (i == cpu || !sib_cpu_ci->info_list)
@@ -1024,7 +1024,7 @@ static void get_cache_id(int cpu, struct _cpuid4_info_regs *id4_regs)
 
 	num_threads_sharing = 1 + id4_regs->eax.split.num_threads_sharing;
 	index_msb = get_count_order(num_threads_sharing);
-	id4_regs->id = c->apicid >> index_msb;
+	id4_regs->id = c->topo.apicid >> index_msb;
 }
 
 int populate_cache_leaves(unsigned int cpu)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 382d4e6..c39e88e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -914,7 +914,7 @@ void detect_ht(struct cpuinfo_x86 *c)
 		return;
 
 	index_msb = get_count_order(smp_num_siblings);
-	c->phys_proc_id = apic->phys_pkg_id(c->initial_apicid, index_msb);
+	c->phys_proc_id = apic->phys_pkg_id(c->topo.initial_apicid, index_msb);
 
 	smp_num_siblings = smp_num_siblings / c->x86_max_cores;
 
@@ -922,7 +922,7 @@ void detect_ht(struct cpuinfo_x86 *c)
 
 	core_bits = get_count_order(c->x86_max_cores);
 
-	c->cpu_core_id = apic->phys_pkg_id(c->initial_apicid, index_msb) &
+	c->cpu_core_id = apic->phys_pkg_id(c->topo.initial_apicid, index_msb) &
 				       ((1 << core_bits) - 1);
 #endif
 }
@@ -1761,15 +1761,15 @@ static void generic_identify(struct cpuinfo_x86 *c)
 	get_cpu_address_sizes(c);
 
 	if (c->cpuid_level >= 0x00000001) {
-		c->initial_apicid = (cpuid_ebx(1) >> 24) & 0xFF;
+		c->topo.initial_apicid = (cpuid_ebx(1) >> 24) & 0xFF;
 #ifdef CONFIG_X86_32
 # ifdef CONFIG_SMP
-		c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
+		c->topo.apicid = apic->phys_pkg_id(c->topo.initial_apicid, 0);
 # else
-		c->apicid = c->initial_apicid;
+		c->topo.apicid = c->topo.initial_apicid;
 # endif
 #endif
-		c->phys_proc_id = c->initial_apicid;
+		c->phys_proc_id = c->topo.initial_apicid;
 	}
 
 	get_model_name(c); /* Default name */
@@ -1803,9 +1803,9 @@ static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
 
 	apicid = apic->cpu_present_to_apicid(cpu);
 
-	if (apicid != c->apicid) {
+	if (apicid != c->topo.apicid) {
 		pr_err(FW_BUG "CPU%u: APIC id mismatch. Firmware: %x APIC: %x\n",
-		       cpu, apicid, c->initial_apicid);
+		       cpu, apicid, c->topo.initial_apicid);
 	}
 	BUG_ON(topology_update_package_map(c->phys_proc_id, cpu));
 	BUG_ON(topology_update_die_map(c->cpu_die_id, cpu));
@@ -1855,7 +1855,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	apply_forced_caps(c);
 
 #ifdef CONFIG_X86_64
-	c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
+	c->topo.apicid = apic->phys_pkg_id(c->topo.initial_apicid, 0);
 #endif
 
 	/*
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index a7b3ef4..320d18d 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -92,7 +92,7 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 		 * when running on host.
 		 */
 		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) && c->x86_model <= 0x3)
-			c->phys_proc_id = c->apicid >> APICID_SOCKET_ID_BIT;
+			c->phys_proc_id = c->topo.apicid >> APICID_SOCKET_ID_BIT;
 
 		cacheinfo_hygon_init_llc_id(c, cpu);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
@@ -120,9 +120,9 @@ static void hygon_detect_cmp(struct cpuinfo_x86 *c)
 
 	bits = c->x86_coreid_bits;
 	/* Low order bits define the core id (index of core in socket) */
-	c->cpu_core_id = c->initial_apicid & ((1 << bits)-1);
+	c->cpu_core_id = c->topo.initial_apicid & ((1 << bits)-1);
 	/* Convert the initial APIC ID into the socket ID */
-	c->phys_proc_id = c->initial_apicid >> bits;
+	c->phys_proc_id = c->topo.initial_apicid >> bits;
 	/* use socket ID also for last level cache */
 	per_cpu(cpu_llc_id, cpu) = c->cpu_die_id = c->phys_proc_id;
 }
@@ -132,7 +132,7 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #ifdef CONFIG_NUMA
 	int cpu = smp_processor_id();
 	int node;
-	unsigned int apicid = c->apicid;
+	unsigned int apicid = c->topo.apicid;
 
 	node = numa_cpu_node(cpu);
 	if (node == NUMA_NO_NODE)
@@ -165,7 +165,7 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 		 * through CPU mapping may alter the outcome, directly
 		 * access __apicid_to_node[].
 		 */
-		int ht_nodeid = c->initial_apicid;
+		int ht_nodeid = c->topo.initial_apicid;
 
 		if (__apicid_to_node[ht_nodeid] != NUMA_NO_NODE)
 			node = __apicid_to_node[ht_nodeid];
@@ -305,7 +305,7 @@ static void init_hygon(struct cpuinfo_x86 *c)
 	set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 
 	/* get apicid instead of initial apic id from cpuid */
-	c->apicid = read_apic_id();
+	c->topo.apicid = read_apic_id();
 
 	/*
 	 * XXX someone from Hygon needs to confirm this DTRT
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 8ed3417..adb37b8 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -103,7 +103,7 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	m.socketid = -1;
 
 	for_each_possible_cpu(cpu) {
-		if (cpu_data(cpu).initial_apicid == lapic_id) {
+		if (cpu_data(cpu).topo.initial_apicid == lapic_id) {
 			m.extcpu = cpu;
 			m.socketid = cpu_data(m.extcpu).phys_proc_id;
 			break;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6f35f72..b5e9288 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -124,7 +124,7 @@ void mce_setup(struct mce *m)
 	m->cpuvendor = boot_cpu_data.x86_vendor;
 	m->cpuid = cpuid_eax(1);
 	m->socketid = cpu_data(m->extcpu).phys_proc_id;
-	m->apicid = cpu_data(m->extcpu).initial_apicid;
+	m->apicid = cpu_data(m->extcpu).topo.initial_apicid;
 	m->mcgcap = __rdmsr(MSR_IA32_MCG_CAP);
 	m->ppin = cpu_data(m->extcpu).ppin;
 	m->microcode = boot_cpu_data.microcode;
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 31c0e68..91eb0bc 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -25,8 +25,8 @@ static void show_cpuinfo_core(struct seq_file *m, struct cpuinfo_x86 *c,
 		   cpumask_weight(topology_core_cpumask(cpu)));
 	seq_printf(m, "core id\t\t: %d\n", c->cpu_core_id);
 	seq_printf(m, "cpu cores\t: %d\n", c->booted_cores);
-	seq_printf(m, "apicid\t\t: %d\n", c->apicid);
-	seq_printf(m, "initial apicid\t: %d\n", c->initial_apicid);
+	seq_printf(m, "apicid\t\t: %d\n", c->topo.apicid);
+	seq_printf(m, "initial apicid\t: %d\n", c->topo.initial_apicid);
 #endif
 }
 
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 0270925..73c47a8 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -78,7 +78,7 @@ int detect_extended_topology_early(struct cpuinfo_x86 *c)
 	/*
 	 * initial apic id, which also represents 32-bit extended x2apic id.
 	 */
-	c->initial_apicid = edx;
+	c->topo.initial_apicid = edx;
 	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 #endif
 	return 0;
@@ -108,7 +108,7 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	 * Populate HT related information from sub-leaf level 0.
 	 */
 	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
-	c->initial_apicid = edx;
+	c->topo.initial_apicid = edx;
 	core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
 	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
@@ -146,20 +146,20 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	die_select_mask = (~(-1 << die_plus_mask_width)) >>
 				core_plus_mask_width;
 
-	c->cpu_core_id = apic->phys_pkg_id(c->initial_apicid,
+	c->cpu_core_id = apic->phys_pkg_id(c->topo.initial_apicid,
 				ht_mask_width) & core_select_mask;
 
 	if (die_level_present) {
-		c->cpu_die_id = apic->phys_pkg_id(c->initial_apicid,
+		c->cpu_die_id = apic->phys_pkg_id(c->topo.initial_apicid,
 					core_plus_mask_width) & die_select_mask;
 	}
 
-	c->phys_proc_id = apic->phys_pkg_id(c->initial_apicid,
+	c->phys_proc_id = apic->phys_pkg_id(c->topo.initial_apicid,
 				pkg_mask_width);
 	/*
 	 * Reinit the apicid, now that we have extended initial_apicid.
 	 */
-	c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
+	c->topo.apicid = apic->phys_pkg_id(c->topo.initial_apicid, 0);
 
 	c->x86_max_cores = (core_level_siblings / smp_num_siblings);
 	__max_die_per_package = (die_level_siblings / core_level_siblings);
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 7ad9122..958b747 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -118,7 +118,7 @@ static int xen_phys_pkg_id(int initial_apic_id, int index_msb)
 static int xen_cpu_present_to_apicid(int cpu)
 {
 	if (cpu_present(cpu))
-		return cpu_data(cpu).apicid;
+		return cpu_data(cpu).topo.apicid;
 	else
 		return BAD_APICID;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index ff98fde..70acfbb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2209,7 +2209,7 @@ static int kfd_cpumask_to_apic_id(const struct cpumask *cpumask)
 	if (first_cpu_of_numa_node >= nr_cpu_ids)
 		return -1;
 #ifdef CONFIG_X86_64
-	return cpu_data(first_cpu_of_numa_node).apicid;
+	return cpu_data(first_cpu_of_numa_node).topo.apicid;
 #else
 	return first_cpu_of_numa_node;
 #endif
diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index 423ea88..c24036c 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -447,7 +447,7 @@ static ssize_t remove_cpu_store(struct device *dev,
 	if (cpu_online(cpu))
 		remove_cpu(cpu);
 
-	lapicid = cpu_data(cpu).apicid;
+	lapicid = cpu_data(cpu).topo.apicid;
 	dev_dbg(dev, "Try to remove cpu %lld with lapicid %lld\n", cpu, lapicid);
 	ret = hcall_sos_remove_cpu(lapicid);
 	if (ret < 0) {

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C42766CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbjG1MQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjG1MP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:15:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8977830DC;
        Fri, 28 Jul 2023 05:13:23 -0700 (PDT)
Message-ID: <20230728120931.335390967@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yNNNqA4YmsDMwHMpycsoN40Z1ogmgffhWH84zvaD3i8=;
        b=EXlo5xhlHD3lPrnSXvLvoN+ve0JzPvTXRPojcdFCVw01PHAGj9cQv20XRzgYYKjpOCQfHX
        4ENkaPbwcMSuqPhTvEtX5PQzVVM/Rb0tO9+ealxte4Dqp53rzblJVHi8qN/bm1aW5woU8h
        yT0DQSz5m4pVQP9cONWaoWBF385pcnoXLGW7EUg0LVmTzkl8bXZMz4kyj6HoJB9Ty1UHkp
        PhU6NG0F09A1hqz+URXf40G2gw17ljERM0DRpjYE0qv+/8lGrFDtwsmQH/h7MzO9OrrnQg
        Obj/MdGKqZP2gMwmrh/aN4uEBplCFJhzqj2WJyk6RbmW1rYTZYkRzyBu2XyeQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yNNNqA4YmsDMwHMpycsoN40Z1ogmgffhWH84zvaD3i8=;
        b=cry/+3UOBJk73zkqqoxGZ6zQ6/H6NHFN7DyINX3p/DwkwgUGXVC375PduiJG9/CgibzorW
        d8HUYMJ4+7Ub/kDw==
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
Subject: [patch v2 30/38] x86/cpu: Use common topology code for AMD
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:13:20 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch it over to the new topology evaluation mechanism and remove the
random bits and pieces which are sprinkled all over the place.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h      |    2 
 arch/x86/include/asm/topology.h       |    5 +
 arch/x86/kernel/cpu/amd.c             |  146 ----------------------------------
 arch/x86/kernel/cpu/mce/inject.c      |    3 
 arch/x86/kernel/cpu/topology_common.c |    5 -
 5 files changed, 10 insertions(+), 151 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -703,10 +703,8 @@ static inline u16 per_cpu_l2c_id(unsigne
 }
 
 #ifdef CONFIG_CPU_SUP_AMD
-extern u32 amd_get_nodes_per_socket(void);
 extern u32 amd_get_highest_perf(void);
 #else
-static inline u32 amd_get_nodes_per_socket(void)	{ return 0; }
 static inline u32 amd_get_highest_perf(void)		{ return 0; }
 #endif
 
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -121,6 +121,11 @@ struct x86_topology_system {
 
 extern struct x86_topology_system x86_topo_system;
 
+static inline unsigned int topology_get_domain_size(enum x86_topology_domains dom)
+{
+	return x86_topo_system.dom_size[dom];
+}
+
 extern const struct cpumask *cpu_coregroup_mask(int cpu);
 extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -32,13 +32,6 @@ static const int amd_erratum_400[];
 static const int amd_erratum_1054[];
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum);
 
-/*
- * nodes_per_socket: Stores the number of nodes per socket.
- * Refer to Fam15h Models 00-0fh BKDG - CPUID Fn8000_001E_ECX
- * Node Identifiers[10:8]
- */
-static u32 nodes_per_socket = 1;
-
 static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
 {
 	u32 gprs[8] = { 0 };
@@ -305,97 +298,6 @@ static int nearby_node(int apicid)
 }
 #endif
 
-/*
- * Fix up topo::core_id for pre-F17h systems to be in the
- * [0 .. cores_per_node - 1] range. Not really needed but
- * kept so as not to break existing setups.
- */
-static void legacy_fixup_core_id(struct cpuinfo_x86 *c)
-{
-	u32 cus_per_node;
-
-	if (c->x86 >= 0x17)
-		return;
-
-	cus_per_node = c->x86_max_cores / nodes_per_socket;
-	c->topo.core_id %= cus_per_node;
-}
-
-/*
- * Fixup core topology information for
- * (1) AMD multi-node processors
- *     Assumption: Number of cores in each internal node is the same.
- * (2) AMD processors supporting compute units
- */
-static void amd_get_topology(struct cpuinfo_x86 *c)
-{
-	/* get information required for multi-node processors */
-	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
-		int err;
-		u32 eax, ebx, ecx, edx;
-
-		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
-
-		c->topo.die_id  = ecx & 0xff;
-
-		if (c->x86 == 0x15)
-			c->topo.cu_id = ebx & 0xff;
-
-		if (c->x86 >= 0x17) {
-			c->topo.core_id = ebx & 0xff;
-
-			if (smp_num_siblings > 1)
-				c->x86_max_cores /= smp_num_siblings;
-		}
-
-		/*
-		 * In case leaf B is available, use it to derive
-		 * topology information.
-		 */
-		err = detect_extended_topology(c);
-		if (!err)
-			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
-
-		cacheinfo_amd_init_llc_id(c, c->topo.die_id);
-
-	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
-		u64 value;
-
-		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		c->topo.die_id = value & 7;
-		c->topo.llc_id = c->topo.die_id;
-	} else
-		return;
-
-	if (nodes_per_socket > 1) {
-		set_cpu_cap(c, X86_FEATURE_AMD_DCM);
-		legacy_fixup_core_id(c);
-	}
-}
-
-/*
- * On a AMD dual core setup the lower bits of the APIC id distinguish the cores.
- * Assumes number of cores is a power of two.
- */
-static void amd_detect_cmp(struct cpuinfo_x86 *c)
-{
-	unsigned bits;
-
-	bits = c->x86_coreid_bits;
-	/* Low order bits define the core id (index of core in socket) */
-	c->topo.core_id = c->topo.initial_apicid & ((1 << bits)-1);
-	/* Convert the initial APIC ID into the socket ID */
-	c->topo.pkg_id = c->topo.initial_apicid >> bits;
-	/* use socket ID also for last level cache */
-	c->topo.llc_id = c->topo.die_id = c->topo.pkg_id;
-}
-
-u32 amd_get_nodes_per_socket(void)
-{
-	return nodes_per_socket;
-}
-EXPORT_SYMBOL_GPL(amd_get_nodes_per_socket);
-
 static void srat_detect_node(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_NUMA
@@ -447,32 +349,6 @@ static void srat_detect_node(struct cpui
 #endif
 }
 
-static void early_init_amd_mc(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	unsigned bits, ecx;
-
-	/* Multi core CPU? */
-	if (c->extended_cpuid_level < 0x80000008)
-		return;
-
-	ecx = cpuid_ecx(0x80000008);
-
-	c->x86_max_cores = (ecx & 0xff) + 1;
-
-	/* CPU telling us the core id bits shift? */
-	bits = (ecx >> 12) & 0xF;
-
-	/* Otherwise recompute */
-	if (bits == 0) {
-		while ((1 << bits) < c->x86_max_cores)
-			bits++;
-	}
-
-	c->x86_coreid_bits = bits;
-#endif
-}
-
 static void bsp_init_amd(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
@@ -505,18 +381,6 @@ static void bsp_init_amd(struct cpuinfo_
 	if (cpu_has(c, X86_FEATURE_MWAITX))
 		use_mwaitx_delay();
 
-	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
-		u32 ecx;
-
-		ecx = cpuid_ecx(0x8000001e);
-		__max_die_per_package = nodes_per_socket = ((ecx >> 8) & 7) + 1;
-	} else if (boot_cpu_has(X86_FEATURE_NODEID_MSR)) {
-		u64 value;
-
-		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		__max_die_per_package = nodes_per_socket = ((value >> 3) & 7) + 1;
-	}
-
 	if (!boot_cpu_has(X86_FEATURE_AMD_SSBD) &&
 	    !boot_cpu_has(X86_FEATURE_VIRT_SSBD) &&
 	    c->x86 >= 0x15 && c->x86 <= 0x17) {
@@ -598,8 +462,6 @@ static void early_init_amd(struct cpuinf
 	u64 value;
 	u32 dummy;
 
-	early_init_amd_mc(c);
-
 	if (c->x86 >= 0xf)
 		set_cpu_cap(c, X86_FEATURE_K8);
 
@@ -687,9 +549,6 @@ static void early_init_amd(struct cpuinf
 			}
 		}
 	}
-
-	if (cpu_has(c, X86_FEATURE_TOPOEXT))
-		smp_num_siblings = ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
 }
 
 static void init_amd_k8(struct cpuinfo_x86 *c)
@@ -929,9 +788,6 @@ static void init_amd(struct cpuinfo_x86
 	if (cpu_has(c, X86_FEATURE_FSRM))
 		set_cpu_cap(c, X86_FEATURE_FSRS);
 
-	/* get apicid instead of initial apic id from cpuid */
-	c->topo.apicid = read_apic_id();
-
 	/* K6s reports MCEs but don't actually have all the MSRs */
 	if (c->x86 < 6)
 		clear_cpu_cap(c, X86_FEATURE_MCE);
@@ -959,8 +815,6 @@ static void init_amd(struct cpuinfo_x86
 
 	cpu_detect_cache_sizes(c);
 
-	amd_detect_cmp(c);
-	amd_get_topology(c);
 	srat_detect_node(c);
 
 	init_amd_cacheinfo(c);
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -433,8 +433,7 @@ static u32 get_nbc_for_node(int node_id)
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 	u32 cores_per_node;
 
-	cores_per_node = (c->x86_max_cores * smp_num_siblings) / amd_get_nodes_per_socket();
-
+	cores_per_node = (c->x86_max_cores * smp_num_siblings) / topology_amd_nodes_per_pkg();
 	return cores_per_node * node_id;
 }
 
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -65,7 +65,6 @@ bool topo_is_converted(struct cpuinfo_x8
 {
 	/* Temporary until everything is converted over. */
 	switch (boot_cpu_data.x86_vendor) {
-	case X86_VENDOR_AMD:
 	case X86_VENDOR_HYGON:
 		return false;
 	default:
@@ -126,6 +125,10 @@ static void parse_topology(struct topo_s
 	tscan->ebx1_nproc_shift = get_count_order(ebx.nproc);
 
 	switch (c->x86_vendor) {
+	case X86_VENDOR_AMD:
+		if (IS_ENABLED(CONFIG_CPU_SUP_AMD))
+			cpu_parse_topology_amd(tscan);
+		break;
 	case X86_VENDOR_CENTAUR:
 	case X86_VENDOR_ZHAOXIN:
 		parse_legacy(tscan);


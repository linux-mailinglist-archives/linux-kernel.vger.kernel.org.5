Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99857766CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbjG1MQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbjG1MPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:15:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9DA3AB7;
        Fri, 28 Jul 2023 05:13:23 -0700 (PDT)
Message-ID: <20230728120931.389991894@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cKAYZyjPZyLQruSPE+euoA5SHlzUu7NxwCy0PweV3wQ=;
        b=Ez37EywE1ZklXFB145X3pS/b9UEj9QquxLGmck5ll35RLUBiDkc5M1UXvYgSxltWLsvxdA
        T/NGBWbP6TptEuVegwRKCJprcdv9lMrc8jWj6FhchH5f0qPN6lC7j67zQIdnbpF66aWmNw
        /48eshwkM0xSrLRtXtgvNmODIDWS+6Jl600vFRc4LYXF/WnTULB60hU1kBQVMtPfiJWgKQ
        leyuq1F/VRuifLYvMke+ynsos05a1W9KzU4Aujq9sJ00omp9KSh9ixnLS8Ok+InynyLX7K
        gjJDGgHa185D4IdblIjXW0F7uB4vvxxETY5J5rW2Rtw944nG8UKSGsokRZDhsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cKAYZyjPZyLQruSPE+euoA5SHlzUu7NxwCy0PweV3wQ=;
        b=P9bdI0zOh5LYFj0WtRefJYfg1TqFhpb0es8smjvOLjequKInRs1KsORzQRudeHpKDRWVLN
        cHq75iNi3fVJTyCw==
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
Subject: [patch v2 31/38] x86/cpu: Use common topology code for HYGON
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:13:21 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch it over to use the consolidated topology evaluation and remove the
temporary safe guards which are not longer needed.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/common.c          |    5 -
 arch/x86/kernel/cpu/cpu.h             |    1 
 arch/x86/kernel/cpu/hygon.c           |  123 ----------------------------------
 arch/x86/kernel/cpu/topology.h        |    1 
 arch/x86/kernel/cpu/topology_common.c |   22 +-----
 5 files changed, 4 insertions(+), 148 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1739,11 +1739,6 @@ static void identify_cpu(struct cpuinfo_
 	/* Clear/Set all flags overridden by options, after probe */
 	apply_forced_caps(c);
 
-#ifdef CONFIG_X86_64
-	if (!topo_is_converted(c))
-		c->topo.apicid = apic->phys_pkg_id(c->topo.initial_apicid, 0);
-#endif
-
 	/*
 	 * Vendor-specific initialization.  In this section we
 	 * canonicalize the feature flags, meaning if there are
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -76,7 +76,6 @@ extern void init_intel_cacheinfo(struct
 extern void init_amd_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_hygon_cacheinfo(struct cpuinfo_x86 *c);
 
-extern int detect_extended_topology(struct cpuinfo_x86 *c);
 extern void check_null_seg_clears_base(struct cpuinfo_x86 *c);
 
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id);
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -20,12 +20,6 @@
 
 #define APICID_SOCKET_ID_BIT 6
 
-/*
- * nodes_per_socket: Stores the number of nodes per socket.
- * Refer to CPUID Fn8000_001E_ECX Node Identifiers[10:8]
- */
-static u32 nodes_per_socket = 1;
-
 #ifdef CONFIG_NUMA
 /*
  * To workaround broken NUMA config.  Read the comment in
@@ -49,76 +43,6 @@ static int nearby_node(int apicid)
 }
 #endif
 
-static void hygon_get_topology_early(struct cpuinfo_x86 *c)
-{
-	if (cpu_has(c, X86_FEATURE_TOPOEXT))
-		smp_num_siblings = ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
-}
-
-/*
- * Fixup core topology information for
- * (1) Hygon multi-node processors
- *     Assumption: Number of cores in each internal node is the same.
- * (2) Hygon processors supporting compute units
- */
-static void hygon_get_topology(struct cpuinfo_x86 *c)
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
-		c->topo.core_id = ebx & 0xff;
-
-		if (smp_num_siblings > 1)
-			c->x86_max_cores /= smp_num_siblings;
-
-		/*
-		 * In case leaf B is available, use it to derive
-		 * topology information.
-		 */
-		err = detect_extended_topology(c);
-		if (!err)
-			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
-
-		/* Socket ID is ApicId[6] for these processors. */
-		c->topo.pkg_id = c->topo.apicid >> APICID_SOCKET_ID_BIT;
-
-		cacheinfo_hygon_init_llc_id(c);
-	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
-		u64 value;
-
-		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		c->topo.die_id = value & 7;
-		c->topo.llc_id = c->topo.die_id;
-	} else
-		return;
-
-	if (nodes_per_socket > 1)
-		set_cpu_cap(c, X86_FEATURE_AMD_DCM);
-}
-
-/*
- * On Hygon setup the lower bits of the APIC id distinguish the cores.
- * Assumes number of cores is a power of two.
- */
-static void hygon_detect_cmp(struct cpuinfo_x86 *c)
-{
-	unsigned int bits;
-
-	bits = c->x86_coreid_bits;
-	/* Low order bits define the core id (index of core in socket) */
-	c->topo.core_id = c->topo.initial_apicid & ((1 << bits)-1);
-	/* Convert the initial APIC ID into the socket ID */
-	c->topo.pkg_id = c->topo.initial_apicid >> bits;
-	/* Use package ID also for last level cache */
-	c->topo.llc_id = c->topo.die_id = c->topo.pkg_id;
-}
-
 static void srat_detect_node(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_NUMA
@@ -169,32 +93,6 @@ static void srat_detect_node(struct cpui
 #endif
 }
 
-static void early_init_hygon_mc(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	unsigned int bits, ecx;
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
 static void bsp_init_hygon(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
@@ -208,18 +106,6 @@ static void bsp_init_hygon(struct cpuinf
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
 	    !boot_cpu_has(X86_FEATURE_VIRT_SSBD)) {
 		/*
@@ -238,8 +124,6 @@ static void early_init_hygon(struct cpui
 {
 	u32 dummy;
 
-	early_init_hygon_mc(c);
-
 	set_cpu_cap(c, X86_FEATURE_K8);
 
 	rdmsr_safe(MSR_AMD64_PATCH_LEVEL, &c->microcode, &dummy);
@@ -280,8 +164,6 @@ static void early_init_hygon(struct cpui
 	 * we can set it unconditionally.
 	 */
 	set_cpu_cap(c, X86_FEATURE_VMMCALL);
-
-	hygon_get_topology_early(c);
 }
 
 static void init_hygon(struct cpuinfo_x86 *c)
@@ -296,9 +178,6 @@ static void init_hygon(struct cpuinfo_x8
 
 	set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 
-	/* get apicid instead of initial apic id from cpuid */
-	c->topo.apicid = read_apic_id();
-
 	/*
 	 * XXX someone from Hygon needs to confirm this DTRT
 	 *
@@ -310,8 +189,6 @@ static void init_hygon(struct cpuinfo_x8
 
 	cpu_detect_cache_sizes(c);
 
-	hygon_detect_cmp(c);
-	hygon_get_topology(c);
 	srat_detect_node(c);
 
 	init_hygon_cacheinfo(c);
--- a/arch/x86/kernel/cpu/topology.h
+++ b/arch/x86/kernel/cpu/topology.h
@@ -15,7 +15,6 @@ struct topo_scan {
 	u16			amd_node_id;
 };
 
-bool topo_is_converted(struct cpuinfo_x86 *c);
 void cpu_init_topology(struct cpuinfo_x86 *c);
 void cpu_parse_topology(struct cpuinfo_x86 *c);
 void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -61,18 +61,6 @@ static void parse_legacy(struct topo_sca
 	topology_set_dom(tscan, TOPO_CORE_DOMAIN, core_shift, cores >> smt_shift);
 }
 
-bool topo_is_converted(struct cpuinfo_x86 *c)
-{
-	/* Temporary until everything is converted over. */
-	switch (boot_cpu_data.x86_vendor) {
-	case X86_VENDOR_HYGON:
-		return false;
-	default:
-		/* Let all UP systems use the below */
-		return true;
-	}
-}
-
 static bool fake_topology(struct topo_scan *tscan)
 {
 	/*
@@ -137,6 +125,10 @@ static void parse_topology(struct topo_s
 		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
 			parse_legacy(tscan);
 		break;
+	case X86_VENDOR_HYGON:
+		if (IS_ENABLED(CONFIG_CPU_SUP_HYGON))
+			cpu_parse_topology_amd(tscan);
+		break;
 	}
 }
 
@@ -179,9 +171,6 @@ void cpu_parse_topology(struct cpuinfo_x
 
 	parse_topology(&tscan, false);
 
-	if (!topo_is_converted(c))
-		return;
-
 	for (dom = TOPO_SMT_DOMAIN; dom < TOPO_MAX_DOMAIN; dom++) {
 		if (tscan.dom_shifts[dom] == x86_topo_system.dom_shifts[dom])
 			continue;
@@ -210,9 +199,6 @@ void __init cpu_init_topology(struct cpu
 
 	parse_topology(&tscan, true);
 
-	if (!topo_is_converted(c))
-		return;
-
 	/* Copy the shift values and calculate the unit sizes. */
 	memcpy(x86_topo_system.dom_shifts, tscan.dom_shifts, sizeof(x86_topo_system.dom_shifts));
 


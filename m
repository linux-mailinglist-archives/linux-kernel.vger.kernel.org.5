Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7206076CAAB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjHBKV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjHBKVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:21:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D722137
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:21:07 -0700 (PDT)
Message-ID: <20230802101932.991285236@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690971666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=bc5Q0JSTqg9+ffQ7s8oKfLAz7DN9aGciy8PBD8PIdfE=;
        b=Tp1YyY0XMjMjjKqHa4yp1h48wSwgMQC3N6MrKLRbL8srMbfTpdCdKEkydHHqRbJI5NBbJP
        tKObadhXYQhs/7qDAaLlU2xVYPoJhri902xfYf2/+BbGdcLLVu02TIDz+lbX+VlrFkZonb
        8ZgEx04UmeLjFHb+z5O54ik6uS6Bk/9yfQixBqpL+ziuiNc8SZtsW1tbD8E75KCG9pjy+t
        Bf++9LCtsay7BxOyCDejeb5AthZq64erbQFUWZF9lkug1lczMF3nVYosdKNtCsuLZ/qmwM
        U+r8VdYJDXEvndBZdyX/jsl40+LiG+YTIec3/7Odm78Ygh6HrGgMGkP8+eBiOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690971666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=bc5Q0JSTqg9+ffQ7s8oKfLAz7DN9aGciy8PBD8PIdfE=;
        b=LmDAacLSzFA5vvTsOFguLNebBU9Su9ghUiGUVfT3yUjdgTmEzEFLnNYbly2dnJXg1U94DQ
        af2xauM8Jxj+t3Dw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [patch V3 05/40] x86/cpu: Move cpu_die_id into topology info
References: <20230802101635.459108805@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  2 Aug 2023 12:21:05 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the next member.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/arch/x86/topology.rst |    4 ++--
 arch/x86/include/asm/processor.h    |    4 +++-
 arch/x86/include/asm/topology.h     |    2 +-
 arch/x86/kernel/cpu/amd.c           |    8 ++++----
 arch/x86/kernel/cpu/cacheinfo.c     |    2 +-
 arch/x86/kernel/cpu/common.c        |    2 +-
 arch/x86/kernel/cpu/hygon.c         |    8 ++++----
 arch/x86/kernel/cpu/topology.c      |    2 +-
 arch/x86/kernel/smpboot.c           |   10 +++++-----
 9 files changed, 22 insertions(+), 20 deletions(-)

--- a/Documentation/arch/x86/topology.rst
+++ b/Documentation/arch/x86/topology.rst
@@ -55,7 +55,7 @@ AMD nomenclature for package is 'Node'.
 
     The number of dies in a package. This information is retrieved via CPUID.
 
-  - cpuinfo_x86.cpu_die_id:
+  - cpuinfo_x86.topo_die_id:
 
     The physical ID of the die. This information is retrieved via CPUID.
 
@@ -65,7 +65,7 @@ AMD nomenclature for package is 'Node'.
     and deduced from the APIC IDs of the cores in the package.
 
     Modern systems use this value for the socket. There may be multiple
-    packages within a socket. This value may differ from cpu_die_id.
+    packages within a socket. This value may differ from topo.die_id.
 
   - cpuinfo_x86.logical_proc_id:
 
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -85,6 +85,9 @@ struct cpuinfo_topology {
 
 	// Physical package ID
 	u32			pkg_id;
+
+	// Physical die ID on AMD, Relative on Intel
+	u32			die_id;
 };
 
 struct cpuinfo_x86 {
@@ -140,7 +143,6 @@ struct cpuinfo_x86 {
 	u16			logical_proc_id;
 	/* Core id: */
 	u16			cpu_core_id;
-	u16			cpu_die_id;
 	u16			logical_die_id;
 	/* Index into per_cpu list: */
 	u16			cpu_index;
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -108,7 +108,7 @@ extern const struct cpumask *cpu_cluster
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).topo.pkg_id)
 #define topology_logical_die_id(cpu)		(cpu_data(cpu).logical_die_id)
-#define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
+#define topology_die_id(cpu)			(cpu_data(cpu).topo.die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
 
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -338,7 +338,7 @@ static void amd_get_topology(struct cpui
 
 		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
 
-		c->cpu_die_id  = ecx & 0xff;
+		c->topo.die_id  = ecx & 0xff;
 
 		if (c->x86 == 0x15)
 			c->cu_id = ebx & 0xff;
@@ -364,9 +364,9 @@ static void amd_get_topology(struct cpui
 		u64 value;
 
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		c->cpu_die_id = value & 7;
+		c->topo.die_id = value & 7;
 
-		per_cpu(cpu_llc_id, cpu) = c->cpu_die_id;
+		per_cpu(cpu_llc_id, cpu) = c->topo.die_id;
 	} else
 		return;
 
@@ -391,7 +391,7 @@ static void amd_detect_cmp(struct cpuinf
 	/* Convert the initial APIC ID into the socket ID */
 	c->topo.pkg_id = c->topo.initial_apicid >> bits;
 	/* use socket ID also for last level cache */
-	per_cpu(cpu_llc_id, cpu) = c->cpu_die_id = c->topo.pkg_id;
+	per_cpu(cpu_llc_id, cpu) = c->topo.die_id = c->topo.pkg_id;
 }
 
 u32 amd_get_nodes_per_socket(void)
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -672,7 +672,7 @@ void cacheinfo_amd_init_llc_id(struct cp
 
 	if (c->x86 < 0x17) {
 		/* LLC is at the node level. */
-		per_cpu(cpu_llc_id, cpu) = c->cpu_die_id;
+		per_cpu(cpu_llc_id, cpu) = c->topo.die_id;
 	} else if (c->x86 == 0x17 && c->x86_model <= 0x1F) {
 		/*
 		 * LLC is at the core complex level.
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1768,7 +1768,7 @@ static void validate_apic_and_package_id
 		       cpu, apicid, c->topo.initial_apicid);
 	}
 	BUG_ON(topology_update_package_map(c->topo.pkg_id, cpu));
-	BUG_ON(topology_update_die_map(c->cpu_die_id, cpu));
+	BUG_ON(topology_update_die_map(c->topo.die_id, cpu));
 #else
 	c->logical_proc_id = 0;
 #endif
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -72,7 +72,7 @@ static void hygon_get_topology(struct cp
 
 		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
 
-		c->cpu_die_id  = ecx & 0xff;
+		c->topo.die_id  = ecx & 0xff;
 
 		c->cpu_core_id = ebx & 0xff;
 
@@ -95,9 +95,9 @@ static void hygon_get_topology(struct cp
 		u64 value;
 
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		c->cpu_die_id = value & 7;
+		c->topo.die_id = value & 7;
 
-		per_cpu(cpu_llc_id, cpu) = c->cpu_die_id;
+		per_cpu(cpu_llc_id, cpu) = c->topo.die_id;
 	} else
 		return;
 
@@ -120,7 +120,7 @@ static void hygon_detect_cmp(struct cpui
 	/* Convert the initial APIC ID into the socket ID */
 	c->topo.pkg_id = c->topo.initial_apicid >> bits;
 	/* use socket ID also for last level cache */
-	per_cpu(cpu_llc_id, cpu) = c->cpu_die_id = c->topo.pkg_id;
+	per_cpu(cpu_llc_id, cpu) = c->topo.die_id = c->topo.pkg_id;
 }
 
 static void srat_detect_node(struct cpuinfo_x86 *c)
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -150,7 +150,7 @@ int detect_extended_topology(struct cpui
 				ht_mask_width) & core_select_mask;
 
 	if (die_level_present) {
-		c->cpu_die_id = apic->phys_pkg_id(c->topo.initial_apicid,
+		c->topo.die_id = apic->phys_pkg_id(c->topo.initial_apicid,
 					core_plus_mask_width) & die_select_mask;
 	}
 
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -368,7 +368,7 @@ static int topology_phys_to_logical_die(
 	for_each_possible_cpu(cpu) {
 		struct cpuinfo_x86 *c = &cpu_data(cpu);
 
-		if (c->initialized && c->cpu_die_id == die_id &&
+		if (c->initialized && c->topo.die_id == die_id &&
 		    c->topo.pkg_id == proc_id)
 			return c->logical_die_id;
 	}
@@ -430,7 +430,7 @@ void __init smp_store_boot_cpu_info(void
 	*c = boot_cpu_data;
 	c->cpu_index = id;
 	topology_update_package_map(c->topo.pkg_id, id);
-	topology_update_die_map(c->cpu_die_id, id);
+	topology_update_die_map(c->topo.die_id, id);
 	c->initialized = true;
 }
 
@@ -485,7 +485,7 @@ static bool match_smt(struct cpuinfo_x86
 		int cpu1 = c->cpu_index, cpu2 = o->cpu_index;
 
 		if (c->topo.pkg_id == o->topo.pkg_id &&
-		    c->cpu_die_id == o->cpu_die_id &&
+		    c->topo.die_id == o->topo.die_id &&
 		    per_cpu(cpu_llc_id, cpu1) == per_cpu(cpu_llc_id, cpu2)) {
 			if (c->cpu_core_id == o->cpu_core_id)
 				return topology_sane(c, o, "smt");
@@ -497,7 +497,7 @@ static bool match_smt(struct cpuinfo_x86
 		}
 
 	} else if (c->topo.pkg_id == o->topo.pkg_id &&
-		   c->cpu_die_id == o->cpu_die_id &&
+		   c->topo.die_id == o->topo.die_id &&
 		   c->cpu_core_id == o->cpu_core_id) {
 		return topology_sane(c, o, "smt");
 	}
@@ -508,7 +508,7 @@ static bool match_smt(struct cpuinfo_x86
 static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
 	if (c->topo.pkg_id == o->topo.pkg_id &&
-	    c->cpu_die_id == o->cpu_die_id)
+	    c->topo.die_id == o->topo.die_id)
 		return true;
 	return false;
 }


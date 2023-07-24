Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477AE75FE17
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjGXRol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjGXRoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:44:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF3C173B;
        Mon, 24 Jul 2023 10:43:56 -0700 (PDT)
Message-ID: <20230724172843.873053855@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690220635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uSvFUQ8+sILw2192MaHROkpMHcXQmKI5Iaei7gYg9+0=;
        b=Y3NbEAYRvFpvZMnjsf1pS/nelje/Z+QUZ2PUAUVb/J8OCnYBlSDZ7nP2V5z698iOD+eN52
        JFrYeOHo8/xZp+cA4Rx8Ny47DWXeZVjbblKbZCLsE0UjWv2erf5eVim2yKWruwBnh/PpX8
        z/OzM3ajlf64iGLGcS0nMswA1GdzRVZ/dbG6CaSiaroaJ6h998GGe6kwmjBBn1WHCIj2Nn
        VsHm3no8HLlhPg7nZYfqSUrT82sRQBywQ5XwTOsn8wy5uIik0f1nea36h9FejmjEpBrket
        YCd7iRTJcV7KXSWyeBQVHGJz59IMV7uf8ZeOqkvxpQXiUgvj35HNC2I+NvCiNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690220635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uSvFUQ8+sILw2192MaHROkpMHcXQmKI5Iaei7gYg9+0=;
        b=YTtSyPRcF9lEPUEjBjtqw3BI+TLSBV5nxB6yPgncIp72nQLZLrP7H7AyLkgtLMY5iBrx5f
        FH34br5ugV8X90Bg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch 03/29] x86/cpu: Move cpu_die_id into topology info
References: <20230724155329.474037902@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 19:43:55 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 arch/x86/include/asm/processor.h    |    2 +-
 arch/x86/include/asm/topology.h     |    2 +-
 arch/x86/kernel/cpu/amd.c           |    8 ++++----
 arch/x86/kernel/cpu/cacheinfo.c     |    2 +-
 arch/x86/kernel/cpu/common.c        |    2 +-
 arch/x86/kernel/cpu/hygon.c         |    8 ++++----
 arch/x86/kernel/cpu/topology.c      |    2 +-
 arch/x86/kernel/smpboot.c           |   10 +++++-----
 9 files changed, 20 insertions(+), 20 deletions(-)

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
@@ -82,6 +82,7 @@ struct cpuinfo_topology {
 	u16			initial_apicid;
 
 	u16			pkg_id;
+	u16			die_id;
 };
 
 struct cpuinfo_x86 {
@@ -137,7 +138,6 @@ struct cpuinfo_x86 {
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


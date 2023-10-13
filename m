Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090FE7C824F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjJMJjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjJMJiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744EECF;
        Fri, 13 Oct 2023 02:38:13 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:38:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697189892;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ecjDm6SDTUaOsg0ItfP6Sg9sEh7mN/GAa1olL/2FhU=;
        b=4tyStDF5dV8+1EMgTnB/VKHhWS+Yxg8lJ5zUFu4dMBk5tn89bKyaAaUXetzl6u/1AE+9yy
        IYLpVLKa3VEfxhYdt9gyd50yZrEXYziMdupeZWc3RKrZWEjOexXb7ymxjKyOuB0VKprbPh
        945o7cjlxqzRN5pSIJv5nV0kCpNyXZGJyX6NGVvmJrj1fRpbs/INbyjC+RKP2KtVdCtV2n
        icoTG+qGXWCNEZR9/pJfMUkYOCgNgwT5WBdTnrPrEIHK3h7F1/08PPYtRV4ulQoRxPeEpC
        GcUAiDEoYhEZeAe6W9HGyj3Rl1Yoa/PGMWKzlzLUCKdASqwURewDNK4I006rFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697189892;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ecjDm6SDTUaOsg0ItfP6Sg9sEh7mN/GAa1olL/2FhU=;
        b=QtCM3c8mncR8VmbxNjnXB4JdZkzVgJ7HGz+9dwmZf33hEJ0xZ3pCObbAameEK3rGZUyhcK
        3JSfhR/05F/avDCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu: Move cpu_die_id into topology info
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814085112.388185134@linutronix.de>
References: <20230814085112.388185134@linutronix.de>
MIME-Version: 1.0
Message-ID: <169718989148.3135.5190508220079893073.tip-bot2@tip-bot2>
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

Commit-ID:     8a169ed40fcf6e0e7a2d900c7ab4408649488f40
Gitweb:        https://git.kernel.org/tip/8a169ed40fcf6e0e7a2d900c7ab4408649488f40
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Aug 2023 10:18:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Oct 2023 14:38:17 +02:00

x86/cpu: Move cpu_die_id into topology info

Move the next member.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230814085112.388185134@linutronix.de

---
 Documentation/arch/x86/topology.rst |  4 ++--
 arch/x86/include/asm/processor.h    |  4 +++-
 arch/x86/include/asm/topology.h     |  2 +-
 arch/x86/kernel/cpu/amd.c           |  8 ++++----
 arch/x86/kernel/cpu/cacheinfo.c     |  2 +-
 arch/x86/kernel/cpu/common.c        |  2 +-
 arch/x86/kernel/cpu/hygon.c         |  8 ++++----
 arch/x86/kernel/cpu/topology.c      |  2 +-
 arch/x86/kernel/smpboot.c           | 10 +++++-----
 9 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/Documentation/arch/x86/topology.rst b/Documentation/arch/x86/topology.rst
index 0bfa1ed..ff36e52 100644
--- a/Documentation/arch/x86/topology.rst
+++ b/Documentation/arch/x86/topology.rst
@@ -55,7 +55,7 @@ Package-related topology information in the kernel:
 
     The number of dies in a package. This information is retrieved via CPUID.
 
-  - cpuinfo_x86.cpu_die_id:
+  - cpuinfo_x86.topo.die_id:
 
     The physical ID of the die. This information is retrieved via CPUID.
 
@@ -65,7 +65,7 @@ Package-related topology information in the kernel:
     and deduced from the APIC IDs of the cores in the package.
 
     Modern systems use this value for the socket. There may be multiple
-    packages within a socket. This value may differ from cpu_die_id.
+    packages within a socket. This value may differ from topo.die_id.
 
   - cpuinfo_x86.logical_proc_id:
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a673199..662e973 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -86,6 +86,9 @@ struct cpuinfo_topology {
 
 	// Physical package ID
 	u32			pkg_id;
+
+	// Physical die ID on AMD, Relative on Intel
+	u32			die_id;
 };
 
 struct cpuinfo_x86 {
@@ -141,7 +144,6 @@ struct cpuinfo_x86 {
 	u16			logical_proc_id;
 	/* Core id: */
 	u16			cpu_core_id;
-	u16			cpu_die_id;
 	u16			logical_die_id;
 	/* Index into per_cpu list: */
 	u16			cpu_index;
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 666c82e..cf43b51 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -108,7 +108,7 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).topo.pkg_id)
 #define topology_logical_die_id(cpu)		(cpu_data(cpu).logical_die_id)
-#define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
+#define topology_die_id(cpu)			(cpu_data(cpu).topo.die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index d23463f..c10f5f7 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -410,7 +410,7 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 
 		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
 
-		c->cpu_die_id  = ecx & 0xff;
+		c->topo.die_id  = ecx & 0xff;
 
 		if (c->x86 == 0x15)
 			c->cu_id = ebx & 0xff;
@@ -436,9 +436,9 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 		u64 value;
 
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		c->cpu_die_id = value & 7;
+		c->topo.die_id = value & 7;
 
-		per_cpu(cpu_llc_id, cpu) = c->cpu_die_id;
+		per_cpu(cpu_llc_id, cpu) = c->topo.die_id;
 	} else
 		return;
 
@@ -463,7 +463,7 @@ static void amd_detect_cmp(struct cpuinfo_x86 *c)
 	/* Convert the initial APIC ID into the socket ID */
 	c->topo.pkg_id = c->topo.initial_apicid >> bits;
 	/* use socket ID also for last level cache */
-	per_cpu(cpu_llc_id, cpu) = c->cpu_die_id = c->topo.pkg_id;
+	per_cpu(cpu_llc_id, cpu) = c->topo.die_id = c->topo.pkg_id;
 }
 
 u32 amd_get_nodes_per_socket(void)
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index fe583fd..e253687 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -672,7 +672,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu)
 
 	if (c->x86 < 0x17) {
 		/* LLC is at the node level. */
-		per_cpu(cpu_llc_id, cpu) = c->cpu_die_id;
+		per_cpu(cpu_llc_id, cpu) = c->topo.die_id;
 	} else if (c->x86 == 0x17 && c->x86_model <= 0x1F) {
 		/*
 		 * LLC is at the core complex level.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 77fc124..8f60d55 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1808,7 +1808,7 @@ static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
 		       cpu, apicid, c->topo.initial_apicid);
 	}
 	BUG_ON(topology_update_package_map(c->topo.pkg_id, cpu));
-	BUG_ON(topology_update_die_map(c->cpu_die_id, cpu));
+	BUG_ON(topology_update_die_map(c->topo.die_id, cpu));
 #else
 	c->logical_proc_id = 0;
 #endif
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 5349735..9190be4 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -72,7 +72,7 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 
 		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
 
-		c->cpu_die_id  = ecx & 0xff;
+		c->topo.die_id  = ecx & 0xff;
 
 		c->cpu_core_id = ebx & 0xff;
 
@@ -99,9 +99,9 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 		u64 value;
 
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		c->cpu_die_id = value & 7;
+		c->topo.die_id = value & 7;
 
-		per_cpu(cpu_llc_id, cpu) = c->cpu_die_id;
+		per_cpu(cpu_llc_id, cpu) = c->topo.die_id;
 	} else
 		return;
 
@@ -124,7 +124,7 @@ static void hygon_detect_cmp(struct cpuinfo_x86 *c)
 	/* Convert the initial APIC ID into the socket ID */
 	c->topo.pkg_id = c->topo.initial_apicid >> bits;
 	/* use socket ID also for last level cache */
-	per_cpu(cpu_llc_id, cpu) = c->cpu_die_id = c->topo.pkg_id;
+	per_cpu(cpu_llc_id, cpu) = c->topo.die_id = c->topo.pkg_id;
 }
 
 static void srat_detect_node(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 0da4755..3b48bc3 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -150,7 +150,7 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 				ht_mask_width) & core_select_mask;
 
 	if (die_level_present) {
-		c->cpu_die_id = apic->phys_pkg_id(c->topo.initial_apicid,
+		c->topo.die_id = apic->phys_pkg_id(c->topo.initial_apicid,
 					core_plus_mask_width) & die_select_mask;
 	}
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c5f4abb..8df0296 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -360,7 +360,7 @@ static int topology_phys_to_logical_die(unsigned int die_id, unsigned int cur_cp
 	for_each_possible_cpu(cpu) {
 		struct cpuinfo_x86 *c = &cpu_data(cpu);
 
-		if (c->initialized && c->cpu_die_id == die_id &&
+		if (c->initialized && c->topo.die_id == die_id &&
 		    c->topo.pkg_id == proc_id)
 			return c->logical_die_id;
 	}
@@ -422,7 +422,7 @@ static void __init smp_store_boot_cpu_info(void)
 	*c = boot_cpu_data;
 	c->cpu_index = id;
 	topology_update_package_map(c->topo.pkg_id, id);
-	topology_update_die_map(c->cpu_die_id, id);
+	topology_update_die_map(c->topo.die_id, id);
 	c->initialized = true;
 }
 
@@ -477,7 +477,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 		int cpu1 = c->cpu_index, cpu2 = o->cpu_index;
 
 		if (c->topo.pkg_id == o->topo.pkg_id &&
-		    c->cpu_die_id == o->cpu_die_id &&
+		    c->topo.die_id == o->topo.die_id &&
 		    per_cpu(cpu_llc_id, cpu1) == per_cpu(cpu_llc_id, cpu2)) {
 			if (c->cpu_core_id == o->cpu_core_id)
 				return topology_sane(c, o, "smt");
@@ -489,7 +489,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 		}
 
 	} else if (c->topo.pkg_id == o->topo.pkg_id &&
-		   c->cpu_die_id == o->cpu_die_id &&
+		   c->topo.die_id == o->topo.die_id &&
 		   c->cpu_core_id == o->cpu_core_id) {
 		return topology_sane(c, o, "smt");
 	}
@@ -500,7 +500,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
 	if (c->topo.pkg_id == o->topo.pkg_id &&
-	    c->cpu_die_id == o->cpu_die_id)
+	    c->topo.die_id == o->topo.die_id)
 		return true;
 	return false;
 }

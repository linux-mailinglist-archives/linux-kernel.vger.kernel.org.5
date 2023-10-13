Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2D77C824A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjJMJiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjJMJiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8279B7;
        Fri, 13 Oct 2023 02:38:11 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:38:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697189890;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BRFV3y6Cs/acB+nb49U17h/RReVTGzeM8mapadhTKsg=;
        b=S2c7CwPu2b+QV4rY9bj1CzV2jHClq5qKhoCpgxcdzyHle/jy3S0S/9folxRyjuOt5EAG9k
        pRDG/6po1lZwybBsm6mREIUhE2MMNmWTufJJoaVvLYuOpSN28SUqOpyAgogofTISJNXg1w
        cXXMuAWqLRSbXjI0uImob+EZ2TuoQhkbKkMlASywcbfiAGzkbGjfWh6tIQh4OXXp+mApN+
        vDo8hSn2vU/obLMKL8dh6o9tp2e9dRhyHnKYSIlogvNTKz9a5nCG6lJGB83giWL0+NKnYy
        fm23EYTQbF0etHmwySIa1CuPROGyjRymsh7YGF/7ZzVZvhgjXYzCd+t0ycSp4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697189890;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BRFV3y6Cs/acB+nb49U17h/RReVTGzeM8mapadhTKsg=;
        b=I0RnWRupJ6LsqIy03TTnIL6C3htxAsCilb8CecRPb8iNPmi8BuJKEKJXAoxyFk9nLFoaQH
        mSAMH72RdBJjNSDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu: Move cpu_core_id into topology info
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814085112.566519388@linutronix.de>
References: <20230814085112.566519388@linutronix.de>
MIME-Version: 1.0
Message-ID: <169718988991.3135.15697531708618547110.tip-bot2@tip-bot2>
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

Commit-ID:     e95256335d45cc965cd12c423535002974313340
Gitweb:        https://git.kernel.org/tip/e95256335d45cc965cd12c423535002974313340
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Aug 2023 10:18:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Oct 2023 14:38:17 +02:00

x86/cpu: Move cpu_core_id into topology info

Rename it to core_id and stick it to the other ID fields.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230814085112.566519388@linutronix.de

---
 arch/x86/include/asm/processor.h | 4 +++-
 arch/x86/include/asm/topology.h  | 2 +-
 arch/x86/kernel/amd_nb.c         | 4 ++--
 arch/x86/kernel/cpu/amd.c        | 8 ++++----
 arch/x86/kernel/cpu/common.c     | 4 ++--
 arch/x86/kernel/cpu/hygon.c      | 4 ++--
 arch/x86/kernel/cpu/proc.c       | 2 +-
 arch/x86/kernel/cpu/topology.c   | 2 +-
 arch/x86/kernel/smpboot.c        | 6 +++---
 9 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 662e973..a637602 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -89,6 +89,9 @@ struct cpuinfo_topology {
 
 	// Physical die ID on AMD, Relative on Intel
 	u32			die_id;
+
+	// Core ID relative to the package
+	u32			core_id;
 };
 
 struct cpuinfo_x86 {
@@ -143,7 +146,6 @@ struct cpuinfo_x86 {
 	/* Logical processor id: */
 	u16			logical_proc_id;
 	/* Core id: */
-	u16			cpu_core_id;
 	u16			logical_die_id;
 	/* Index into per_cpu list: */
 	u16			cpu_index;
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index cf43b51..7fa567c 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -109,7 +109,7 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).topo.pkg_id)
 #define topology_logical_die_id(cpu)		(cpu_data(cpu).logical_die_id)
 #define topology_die_id(cpu)			(cpu_data(cpu).topo.die_id)
-#define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
+#define topology_core_id(cpu)			(cpu_data(cpu).topo.core_id)
 #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
 
 extern unsigned int __max_die_per_package;
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 356de95..75df3c8 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -386,7 +386,7 @@ int amd_get_subcaches(int cpu)
 
 	pci_read_config_dword(link, 0x1d4, &mask);
 
-	return (mask >> (4 * cpu_data(cpu).cpu_core_id)) & 0xf;
+	return (mask >> (4 * cpu_data(cpu).topo.core_id)) & 0xf;
 }
 
 int amd_set_subcaches(int cpu, unsigned long mask)
@@ -412,7 +412,7 @@ int amd_set_subcaches(int cpu, unsigned long mask)
 		pci_write_config_dword(nb->misc, 0x1b8, reg & ~0x180000);
 	}
 
-	cuid = cpu_data(cpu).cpu_core_id;
+	cuid = cpu_data(cpu).topo.core_id;
 	mask <<= 4 * cuid;
 	mask |= (0xf ^ (1 << cuid)) << 26;
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index c10f5f7..66bb929 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -378,7 +378,7 @@ static int nearby_node(int apicid)
 #endif
 
 /*
- * Fix up cpu_core_id for pre-F17h systems to be in the
+ * Fix up topo::core_id for pre-F17h systems to be in the
  * [0 .. cores_per_node - 1] range. Not really needed but
  * kept so as not to break existing setups.
  */
@@ -390,7 +390,7 @@ static void legacy_fixup_core_id(struct cpuinfo_x86 *c)
 		return;
 
 	cus_per_node = c->x86_max_cores / nodes_per_socket;
-	c->cpu_core_id %= cus_per_node;
+	c->topo.core_id %= cus_per_node;
 }
 
 /*
@@ -416,7 +416,7 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 			c->cu_id = ebx & 0xff;
 
 		if (c->x86 >= 0x17) {
-			c->cpu_core_id = ebx & 0xff;
+			c->topo.core_id = ebx & 0xff;
 
 			if (smp_num_siblings > 1)
 				c->x86_max_cores /= smp_num_siblings;
@@ -459,7 +459,7 @@ static void amd_detect_cmp(struct cpuinfo_x86 *c)
 
 	bits = c->x86_coreid_bits;
 	/* Low order bits define the core id (index of core in socket) */
-	c->cpu_core_id = c->topo.initial_apicid & ((1 << bits)-1);
+	c->topo.core_id = c->topo.initial_apicid & ((1 << bits)-1);
 	/* Convert the initial APIC ID into the socket ID */
 	c->topo.pkg_id = c->topo.initial_apicid >> bits;
 	/* use socket ID also for last level cache */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8f60d55..4147665 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -922,8 +922,8 @@ void detect_ht(struct cpuinfo_x86 *c)
 
 	core_bits = get_count_order(c->x86_max_cores);
 
-	c->cpu_core_id = apic->phys_pkg_id(c->topo.initial_apicid, index_msb) &
-				       ((1 << core_bits) - 1);
+	c->topo.core_id = apic->phys_pkg_id(c->topo.initial_apicid, index_msb) &
+		((1 << core_bits) - 1);
 #endif
 }
 
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 9190be4..f3898b5 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -74,7 +74,7 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 
 		c->topo.die_id  = ecx & 0xff;
 
-		c->cpu_core_id = ebx & 0xff;
+		c->topo.core_id = ebx & 0xff;
 
 		if (smp_num_siblings > 1)
 			c->x86_max_cores /= smp_num_siblings;
@@ -120,7 +120,7 @@ static void hygon_detect_cmp(struct cpuinfo_x86 *c)
 
 	bits = c->x86_coreid_bits;
 	/* Low order bits define the core id (index of core in socket) */
-	c->cpu_core_id = c->topo.initial_apicid & ((1 << bits)-1);
+	c->topo.core_id = c->topo.initial_apicid & ((1 << bits)-1);
 	/* Convert the initial APIC ID into the socket ID */
 	c->topo.pkg_id = c->topo.initial_apicid >> bits;
 	/* use socket ID also for last level cache */
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 366af2e..e65fae6 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -23,7 +23,7 @@ static void show_cpuinfo_core(struct seq_file *m, struct cpuinfo_x86 *c,
 	seq_printf(m, "physical id\t: %d\n", c->topo.pkg_id);
 	seq_printf(m, "siblings\t: %d\n",
 		   cpumask_weight(topology_core_cpumask(cpu)));
-	seq_printf(m, "core id\t\t: %d\n", c->cpu_core_id);
+	seq_printf(m, "core id\t\t: %d\n", c->topo.core_id);
 	seq_printf(m, "cpu cores\t: %d\n", c->booted_cores);
 	seq_printf(m, "apicid\t\t: %d\n", c->topo.apicid);
 	seq_printf(m, "initial apicid\t: %d\n", c->topo.initial_apicid);
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 3b48bc3..dc13670 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -146,7 +146,7 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	die_select_mask = (~(-1 << die_plus_mask_width)) >>
 				core_plus_mask_width;
 
-	c->cpu_core_id = apic->phys_pkg_id(c->topo.initial_apicid,
+	c->topo.core_id = apic->phys_pkg_id(c->topo.initial_apicid,
 				ht_mask_width) & core_select_mask;
 
 	if (die_level_present) {
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8df0296..7ab9224 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -479,7 +479,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 		if (c->topo.pkg_id == o->topo.pkg_id &&
 		    c->topo.die_id == o->topo.die_id &&
 		    per_cpu(cpu_llc_id, cpu1) == per_cpu(cpu_llc_id, cpu2)) {
-			if (c->cpu_core_id == o->cpu_core_id)
+			if (c->topo.core_id == o->topo.core_id)
 				return topology_sane(c, o, "smt");
 
 			if ((c->cu_id != 0xff) &&
@@ -490,7 +490,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 
 	} else if (c->topo.pkg_id == o->topo.pkg_id &&
 		   c->topo.die_id == o->topo.die_id &&
-		   c->cpu_core_id == o->cpu_core_id) {
+		   c->topo.core_id == o->topo.core_id) {
 		return topology_sane(c, o, "smt");
 	}
 
@@ -1426,7 +1426,7 @@ static void remove_siblinginfo(int cpu)
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
 	cpumask_clear(topology_die_cpumask(cpu));
-	c->cpu_core_id = 0;
+	c->topo.core_id = 0;
 	c->booted_cores = 0;
 	cpumask_clear_cpu(cpu, cpu_sibling_setup_mask);
 	recompute_smt_state();

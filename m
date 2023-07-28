Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B4E766CB4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbjG1MNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbjG1MMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:12:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF1C2686;
        Fri, 28 Jul 2023 05:12:51 -0700 (PDT)
Message-ID: <20230728120929.999999181@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=H/RRg/Ng7gVCWf1JKUraosEsbY2lA8TZJktDOeNxV1s=;
        b=3UrsRE4WRm4OOqhdx7LP7GiPPhAmxHzaaXw4MJSEvuWYy6IpN8iUDNvYHMVddR+u6YP7XN
        cVhaJQBVkOJ51fdWmqFBIyDOjYvZy1HxQ2hmHCzj+oBseZuziAo0P3xZhcTT+ZkNJzNAFQ
        MUPcfFngsLV37UugJJt3/hOM6xNQS9+qoHWsmrl+tmyZl7H0RaH+iTLXfMpVel0da5lFM3
        ez9wpaa7h1AEDa3zEWUNSjyP5KVVbpZOn+BXVKDHmEGkdUPwDG+SGeeT24GfcVGtMEyH90
        T0hTV5drWsyaR1kcVNbeCgweJ4YWllRazasql5jxAjusRzRQP1DqgxM52oKGEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=H/RRg/Ng7gVCWf1JKUraosEsbY2lA8TZJktDOeNxV1s=;
        b=MSA+oTRKgcWeg9fgLvntobCencHRr4d1dXLMkSiWbyOQ6TNIy12IcvOpnL68uCIOH/Rz/M
        s9eazTjHYE0j1OAQ==
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
Subject: [patch v2 06/38] x86/cpu: Move cpu_core_id into topology info
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:12:50 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename it to core_id and stick it to the other ID fields.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h |    4 +++-
 arch/x86/include/asm/topology.h  |    2 +-
 arch/x86/kernel/amd_nb.c         |    4 ++--
 arch/x86/kernel/cpu/amd.c        |    8 ++++----
 arch/x86/kernel/cpu/common.c     |    4 ++--
 arch/x86/kernel/cpu/hygon.c      |    4 ++--
 arch/x86/kernel/cpu/proc.c       |    2 +-
 arch/x86/kernel/cpu/topology.c   |    2 +-
 arch/x86/kernel/smpboot.c        |    6 +++---
 9 files changed, 19 insertions(+), 17 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -88,6 +88,9 @@ struct cpuinfo_topology {
 
 	// Physical die ID on AMD, Relative on Intel
 	u32			die_id;
+
+	// Core ID relative to the package
+	u32			core_id;
 };
 
 struct cpuinfo_x86 {
@@ -142,7 +145,6 @@ struct cpuinfo_x86 {
 	/* Logical processor id: */
 	u16			logical_proc_id;
 	/* Core id: */
-	u16			cpu_core_id;
 	u16			logical_die_id;
 	/* Index into per_cpu list: */
 	u16			cpu_index;
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -109,7 +109,7 @@ extern const struct cpumask *cpu_cluster
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).topo.pkg_id)
 #define topology_logical_die_id(cpu)		(cpu_data(cpu).logical_die_id)
 #define topology_die_id(cpu)			(cpu_data(cpu).topo.die_id)
-#define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
+#define topology_core_id(cpu)			(cpu_data(cpu).topo.core_id)
 #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
 
 extern unsigned int __max_die_per_package;
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -378,7 +378,7 @@ int amd_get_subcaches(int cpu)
 
 	pci_read_config_dword(link, 0x1d4, &mask);
 
-	return (mask >> (4 * cpu_data(cpu).cpu_core_id)) & 0xf;
+	return (mask >> (4 * cpu_data(cpu).topo.core_id)) & 0xf;
 }
 
 int amd_set_subcaches(int cpu, unsigned long mask)
@@ -404,7 +404,7 @@ int amd_set_subcaches(int cpu, unsigned
 		pci_write_config_dword(nb->misc, 0x1b8, reg & ~0x180000);
 	}
 
-	cuid = cpu_data(cpu).cpu_core_id;
+	cuid = cpu_data(cpu).topo.core_id;
 	mask <<= 4 * cuid;
 	mask |= (0xf ^ (1 << cuid)) << 26;
 
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -306,7 +306,7 @@ static int nearby_node(int apicid)
 #endif
 
 /*
- * Fix up cpu_core_id for pre-F17h systems to be in the
+ * Fix up topo::core_id for pre-F17h systems to be in the
  * [0 .. cores_per_node - 1] range. Not really needed but
  * kept so as not to break existing setups.
  */
@@ -318,7 +318,7 @@ static void legacy_fixup_core_id(struct
 		return;
 
 	cus_per_node = c->x86_max_cores / nodes_per_socket;
-	c->cpu_core_id %= cus_per_node;
+	c->topo.core_id %= cus_per_node;
 }
 
 /*
@@ -344,7 +344,7 @@ static void amd_get_topology(struct cpui
 			c->cu_id = ebx & 0xff;
 
 		if (c->x86 >= 0x17) {
-			c->cpu_core_id = ebx & 0xff;
+			c->topo.core_id = ebx & 0xff;
 
 			if (smp_num_siblings > 1)
 				c->x86_max_cores /= smp_num_siblings;
@@ -387,7 +387,7 @@ static void amd_detect_cmp(struct cpuinf
 
 	bits = c->x86_coreid_bits;
 	/* Low order bits define the core id (index of core in socket) */
-	c->cpu_core_id = c->topo.initial_apicid & ((1 << bits)-1);
+	c->topo.core_id = c->topo.initial_apicid & ((1 << bits)-1);
 	/* Convert the initial APIC ID into the socket ID */
 	c->topo.pkg_id = c->topo.initial_apicid >> bits;
 	/* use socket ID also for last level cache */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -907,8 +907,8 @@ void detect_ht(struct cpuinfo_x86 *c)
 
 	core_bits = get_count_order(c->x86_max_cores);
 
-	c->cpu_core_id = apic->phys_pkg_id(c->topo.initial_apicid, index_msb) &
-				       ((1 << core_bits) - 1);
+	c->topo.core_id = apic->phys_pkg_id(c->topo.initial_apicid, index_msb) &
+		((1 << core_bits) - 1);
 #endif
 }
 
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -74,7 +74,7 @@ static void hygon_get_topology(struct cp
 
 		c->topo.die_id  = ecx & 0xff;
 
-		c->cpu_core_id = ebx & 0xff;
+		c->topo.core_id = ebx & 0xff;
 
 		if (smp_num_siblings > 1)
 			c->x86_max_cores /= smp_num_siblings;
@@ -116,7 +116,7 @@ static void hygon_detect_cmp(struct cpui
 
 	bits = c->x86_coreid_bits;
 	/* Low order bits define the core id (index of core in socket) */
-	c->cpu_core_id = c->topo.initial_apicid & ((1 << bits)-1);
+	c->topo.core_id = c->topo.initial_apicid & ((1 << bits)-1);
 	/* Convert the initial APIC ID into the socket ID */
 	c->topo.pkg_id = c->topo.initial_apicid >> bits;
 	/* use socket ID also for last level cache */
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -21,7 +21,7 @@ static void show_cpuinfo_core(struct seq
 	seq_printf(m, "physical id\t: %d\n", c->topo.pkg_id);
 	seq_printf(m, "siblings\t: %d\n",
 		   cpumask_weight(topology_core_cpumask(cpu)));
-	seq_printf(m, "core id\t\t: %d\n", c->cpu_core_id);
+	seq_printf(m, "core id\t\t: %d\n", c->topo.core_id);
 	seq_printf(m, "cpu cores\t: %d\n", c->booted_cores);
 	seq_printf(m, "apicid\t\t: %d\n", c->topo.apicid);
 	seq_printf(m, "initial apicid\t: %d\n", c->topo.initial_apicid);
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -146,7 +146,7 @@ int detect_extended_topology(struct cpui
 	die_select_mask = (~(-1 << die_plus_mask_width)) >>
 				core_plus_mask_width;
 
-	c->cpu_core_id = apic->phys_pkg_id(c->topo.initial_apicid,
+	c->topo.core_id = apic->phys_pkg_id(c->topo.initial_apicid,
 				ht_mask_width) & core_select_mask;
 
 	if (die_level_present) {
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -487,7 +487,7 @@ static bool match_smt(struct cpuinfo_x86
 		if (c->topo.pkg_id == o->topo.pkg_id &&
 		    c->topo.die_id == o->topo.die_id &&
 		    per_cpu(cpu_llc_id, cpu1) == per_cpu(cpu_llc_id, cpu2)) {
-			if (c->cpu_core_id == o->cpu_core_id)
+			if (c->topo.core_id == o->topo.core_id)
 				return topology_sane(c, o, "smt");
 
 			if ((c->cu_id != 0xff) &&
@@ -498,7 +498,7 @@ static bool match_smt(struct cpuinfo_x86
 
 	} else if (c->topo.pkg_id == o->topo.pkg_id &&
 		   c->topo.die_id == o->topo.die_id &&
-		   c->cpu_core_id == o->cpu_core_id) {
+		   c->topo.core_id == o->topo.core_id) {
 		return topology_sane(c, o, "smt");
 	}
 
@@ -1439,7 +1439,7 @@ static void remove_siblinginfo(int cpu)
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
 	cpumask_clear(topology_die_cpumask(cpu));
-	c->cpu_core_id = 0;
+	c->topo.core_id = 0;
 	c->booted_cores = 0;
 	cpumask_clear_cpu(cpu, cpu_sibling_setup_mask);
 	recompute_smt_state();


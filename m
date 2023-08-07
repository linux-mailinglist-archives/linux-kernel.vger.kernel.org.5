Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4158F7726D8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjHGN5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjHGN5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:57:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35165448B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:54:34 -0700 (PDT)
Message-ID: <20230807135029.218547661@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WqgG4QEoiVjOabpVvy0BSbv+5bAKRRIBbAeySHAi/Gw=;
        b=jplEhKbdRKLpyID7HB7clAc+iF3FbHIl1alIVDPIN2RChzXEX6l1oQV1GRsabostqPKh/u
        U9yhz4fgWqHtOkLsyNQvX8fKB9QzzNbRpGW5/3UM5qEYCxfK5N85dg7RaVRZwc231Uopeg
        RBq6/SopVomP3bUj8VOS9cq97f382yabGVWwg5M0dbilqtB8kvk71+pnEWqZbJK2Q6YdvS
        MkEKr0e43LuC/7Byvp3wZWihy7gQhFqbEKCffPu04zVUaFmhbeb6nguCR/3eYilAA1bu9l
        FR+9OZy7acEhTd7t8+QunHs4NBkDhu76UyNLdpF1UljUvuctWl7+n6RClcR6LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WqgG4QEoiVjOabpVvy0BSbv+5bAKRRIBbAeySHAi/Gw=;
        b=SZvbr7iLmGg2ibPrgsxC4r+kOcvUHzL3r0BAAvhlMZbCE+zH8NJu/m7q8oylKBci3zlFGS
        gc1PSm+EsT8J4NDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: [patch 53/53] x86/cpu/topology: Get rid of cpuinfo::x86_max_cores
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:56 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that __num_cores_per_package and __num_threads_per_package are
available, cpuinfo::x86_max_cores and the related math all over the place
can be replaced with the ready to consume data.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/arch/x86/topology.rst              |   24 ++++++++---------------
 arch/x86/events/intel/uncore_nhmex.c             |    4 +--
 arch/x86/events/intel/uncore_snb.c               |    8 +++----
 arch/x86/events/intel/uncore_snbep.c             |   16 +++++++--------
 arch/x86/include/asm/processor.h                 |    2 -
 arch/x86/kernel/cpu/cacheinfo.c                  |    2 -
 arch/x86/kernel/cpu/common.c                     |    1 
 arch/x86/kernel/cpu/debugfs.c                    |    3 +-
 arch/x86/kernel/cpu/mce/inject.c                 |    3 --
 arch/x86/kernel/cpu/microcode/intel.c            |    4 +--
 arch/x86/kernel/cpu/topology_common.c            |    3 --
 arch/x86/kernel/smpboot.c                        |    2 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c |    2 -
 drivers/hwmon/fam15h_power.c                     |    2 -
 14 files changed, 32 insertions(+), 44 deletions(-)

--- a/Documentation/arch/x86/topology.rst
+++ b/Documentation/arch/x86/topology.rst
@@ -47,17 +47,21 @@ AMD nomenclature for package is 'Node'.
 
 Package-related topology information in the kernel:
 
-  - cpuinfo_x86.x86_max_cores:
+  - topology_num_threads_per_package()
 
-    The number of cores in a package. This information is retrieved via CPUID.
+    The number of threads in a package.
 
-  - cpuinfo_x86.x86_max_dies:
+  - topology_num_cores_per_package()
 
-    The number of dies in a package. This information is retrieved via CPUID.
+    The number of cores in a package.
+
+  - topology_max_dies_per_package()
+
+    The maximum number of dies in a package.
 
   - cpuinfo_x86.topo_die_id:
 
-    The physical ID of the die. This information is retrieved via CPUID.
+    The physical ID of the die.
 
   - cpuinfo_x86.topo.pkg_id:
 
@@ -96,16 +100,6 @@ are SMT- or CMT-type threads.
 AMDs nomenclature for a CMT core is "Compute Unit". The kernel always uses
 "core".
 
-Core-related topology information in the kernel:
-
-  - smp_num_siblings:
-
-    The number of threads in a core. The number of threads in a package can be
-    calculated by::
-
-	threads_per_package = cpuinfo_x86.x86_max_cores * smp_num_siblings
-
-
 Threads
 =======
 A thread is a single scheduling unit. It's the equivalent to a logical Linux
--- a/arch/x86/events/intel/uncore_nhmex.c
+++ b/arch/x86/events/intel/uncore_nhmex.c
@@ -1221,8 +1221,8 @@ void nhmex_uncore_cpu_init(void)
 		uncore_nhmex = true;
 	else
 		nhmex_uncore_mbox.event_descs = wsmex_uncore_mbox_events;
-	if (nhmex_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		nhmex_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
+	if (nhmex_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		nhmex_uncore_cbox.num_boxes = topology_num_cores_per_package();
 	uncore_msr_uncores = nhmex_msr_uncores;
 }
 /* end of Nehalem-EX uncore support */
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -364,8 +364,8 @@ static struct intel_uncore_type *snb_msr
 void snb_uncore_cpu_init(void)
 {
 	uncore_msr_uncores = snb_msr_uncores;
-	if (snb_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		snb_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
+	if (snb_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		snb_uncore_cbox.num_boxes = topology_num_cores_per_package();
 }
 
 static void skl_uncore_msr_init_box(struct intel_uncore_box *box)
@@ -428,8 +428,8 @@ static struct intel_uncore_type *skl_msr
 void skl_uncore_cpu_init(void)
 {
 	uncore_msr_uncores = skl_msr_uncores;
-	if (skl_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		skl_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
+	if (skl_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		skl_uncore_cbox.num_boxes = topology_num_cores_per_package();
 	snb_uncore_arb.ops = &skl_uncore_msr_ops;
 }
 
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1172,8 +1172,8 @@ static struct intel_uncore_type *snbep_m
 
 void snbep_uncore_cpu_init(void)
 {
-	if (snbep_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		snbep_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
+	if (snbep_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		snbep_uncore_cbox.num_boxes = topology_num_cores_per_package();
 	uncore_msr_uncores = snbep_msr_uncores;
 }
 
@@ -1837,8 +1837,8 @@ static struct intel_uncore_type *ivbep_m
 
 void ivbep_uncore_cpu_init(void)
 {
-	if (ivbep_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		ivbep_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
+	if (ivbep_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		ivbep_uncore_cbox.num_boxes = topology_num_cores_per_package();
 	uncore_msr_uncores = ivbep_msr_uncores;
 }
 
@@ -2909,8 +2909,8 @@ static bool hswep_has_limit_sbox(unsigne
 
 void hswep_uncore_cpu_init(void)
 {
-	if (hswep_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		hswep_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
+	if (hswep_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		hswep_uncore_cbox.num_boxes = topology_num_cores_per_package();
 
 	/* Detect 6-8 core systems with only two SBOXes */
 	if (hswep_has_limit_sbox(HSWEP_PCU_DID))
@@ -3272,8 +3272,8 @@ static struct event_constraint bdx_uncor
 
 void bdx_uncore_cpu_init(void)
 {
-	if (bdx_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		bdx_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
+	if (bdx_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		bdx_uncore_cbox.num_boxes = topology_num_cores_per_package();
 	uncore_msr_uncores = bdx_msr_uncores;
 
 	/* Detect systems with no SBOXes */
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -148,8 +148,6 @@ struct cpuinfo_x86 {
 	unsigned long		loops_per_jiffy;
 	/* protected processor identification number */
 	u64			ppin;
-	/* cpuid returned max cores value: */
-	u16			x86_max_cores;
 	u16			x86_clflush_size;
 	/* number of cores as seen by the OS: */
 	u16			booted_cores;
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -301,7 +301,7 @@ amd_cpuid4(int leaf, union _cpuid4_leaf_
 	eax->split.type = types[leaf];
 	eax->split.level = levels[leaf];
 	eax->split.num_threads_sharing = 0;
-	eax->split.num_cores_on_die = __this_cpu_read(cpu_info.x86_max_cores) - 1;
+	eax->split.num_cores_on_die = topology_num_cores_per_package();
 
 
 	if (assoc == 0xffff)
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1698,7 +1698,6 @@ static void identify_cpu(struct cpuinfo_
 	c->x86_model = c->x86_stepping = 0;	/* So far unknown... */
 	c->x86_vendor_id[0] = '\0'; /* Unset */
 	c->x86_model_id[0] = '\0';  /* Unset */
-	c->x86_max_cores = 1;
 #ifdef CONFIG_X86_64
 	c->x86_clflush_size = 64;
 	c->x86_phys_bits = 36;
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -28,7 +28,8 @@ static int cpu_debug_show(struct seq_fil
 	seq_printf(m, "l2c_id:              %u\n", c->topo.l2c_id);
 	seq_printf(m, "amd_node_id:         %u\n", c->topo.amd_node_id);
 	seq_printf(m, "amd_nodes_per_pkg:   %u\n", topology_amd_nodes_per_pkg());
-	seq_printf(m, "max_cores:           %u\n", c->x86_max_cores);
+	seq_printf(m, "num_threads:         %u\n", __num_threads_per_package);
+	seq_printf(m, "num_cores:           %u\n", __num_cores_per_package);
 	seq_printf(m, "max_dies_per_pkg:    %u\n", __max_dies_per_package);
 	seq_printf(m, "max_threads_per_core:%u\n", __max_threads_per_core);
 	return 0;
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -430,10 +430,9 @@ static void trigger_thr_int(void *info)
 
 static u32 get_nbc_for_node(int node_id)
 {
-	struct cpuinfo_x86 *c = &boot_cpu_data;
 	u32 cores_per_node;
 
-	cores_per_node = (c->x86_max_cores * __max_threads_per_core) / topology_amd_nodes_per_pkg();
+	cores_per_node = topology_num_threads_per_package() / topology_amd_nodes_per_pkg();
 	return cores_per_node * node_id;
 }
 
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -43,7 +43,7 @@ static const char ucode_path[] = "kernel
 static struct microcode_intel *intel_ucode_patch;
 
 /* last level cache size per core */
-static int llc_size_per_core;
+static unsigned long llc_size_per_core;
 
 /*
  * Returns 1 if update has been found, 0 otherwise.
@@ -777,7 +777,7 @@ static int __init calc_llc_size_per_core
 {
 	u64 llc_size = c->x86_cache_size * 1024ULL;
 
-	do_div(llc_size, c->x86_max_cores);
+	do_div(llc_size, topology_num_cores_per_package());
 
 	return (int)llc_size;
 }
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -154,9 +154,6 @@ static void topo_set_ids(struct topo_sca
 	/* Relative core ID */
 	c->topo.core_id = topo_relative_domain_id(apicid, TOPO_CORE_DOMAIN);
 
-	/* Maximum number of cores on this package */
-	c->x86_max_cores = topology_unit_count(apicid, TOPO_CORE_DOMAIN, TOPO_PKG_DOMAIN);
-
 	c->topo.amd_node_id = tscan->amd_node_id;
 
 	if (c->x86_vendor == X86_VENDOR_AMD)
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -566,7 +566,7 @@ static void __init build_sched_topology(
 void set_cpu_sibling_map(int cpu)
 {
 	bool has_smt = topology_smt_supported();
-	bool has_mp = has_smt || boot_cpu_data.x86_max_cores > 1;
+	bool has_mp = has_smt || topology_num_cores_per_package() > 1;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct cpuinfo_x86 *o;
 	int i, threads;
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -472,7 +472,7 @@ static int vangogh_init_smc_tables(struc
 
 #ifdef CONFIG_X86
 	/* AMD x86 APU only */
-	smu->cpu_core_num = boot_cpu_data.x86_max_cores;
+	smu->cpu_core_num = topology_num_cores_per_package();
 #else
 	smu->cpu_core_num = 4;
 #endif
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -209,7 +209,7 @@ static ssize_t power1_average_show(struc
 	 * With the new x86 topology modelling, x86_max_cores is the
 	 * compute unit number.
 	 */
-	cu_num = boot_cpu_data.x86_max_cores;
+	cu_num = topology_num_cores_per_package();
 
 	ret = read_registers(data);
 	if (ret)


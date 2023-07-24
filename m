Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328BB75FE46
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjGXRqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjGXRpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:45:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F88212E;
        Mon, 24 Jul 2023 10:44:21 -0700 (PDT)
Message-ID: <20230724172844.747476497@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690220659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=p65mQWv8H29KnMe5K45xZGy+aaWOHV3IVsn90I9aU0s=;
        b=D2YLBXZt0MEx8WNtEgczVJGcfHkqAidMhs5lD36GynG7xln+xL3IkcZlXtcaizzuv/Zurh
        QDqWlaijh27tmnRjT+1dZfrKPZ+K9h/oXZqUcGvVAtlI22Gh7CuOUQKhwoC+DuNWt76XPH
        enLCm1LEWxJG3FWI2h2ywTf6zW2ysFGTPslRv+4oJOrH8OYO3OmLHihgG4ykUpIQzCNA1Q
        mafLyvY7KzjrWL8YeLb/89W6iP+b0uAoxcPJC2MB+BDN9IaxAXBpHBlxLlBE/NPKG5Vj39
        rvx51h4ITVTIAavZhbBxuDoveufhtOzCf4Nm6cddzkQLu23I4ZJDzR+bsqbTSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690220659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=p65mQWv8H29KnMe5K45xZGy+aaWOHV3IVsn90I9aU0s=;
        b=EJEJkRk5una5/buPa+8TKXCU10z8RrXwDku4e4IH1E4hmwbzlk3aKut37tMHqAHYU0UVe8
        MAOr0lvaM0z53XAg==
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
Subject: [patch 18/29] x86/cpu: Use common topology code for Intel
References: <20230724155329.474037902@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 19:44:19 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel CPUs use either topology leaf 0xb/0x1f evaluation or the legacy
SMP/HT evaluation based on CPUID leaf 0x1/0x4.

Move it over to the consolidated topology code and remove the random
topology hacks which are sprinkled into the Intel and the common code.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/common.c          |   65 ----------------------------------
 arch/x86/kernel/cpu/cpu.h             |    4 --
 arch/x86/kernel/cpu/intel.c           |   25 -------------
 arch/x86/kernel/cpu/topology_common.c |    5 ++
 4 files changed, 4 insertions(+), 95 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -784,19 +784,6 @@ static void get_model_name(struct cpuinf
 	*(s + 1) = '\0';
 }
 
-void detect_num_cpu_cores(struct cpuinfo_x86 *c)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	c->x86_max_cores = 1;
-	if (!IS_ENABLED(CONFIG_SMP) || c->cpuid_level < 4)
-		return;
-
-	cpuid_count(4, 0, &eax, &ebx, &ecx, &edx);
-	if (eax & 0x1f)
-		c->x86_max_cores = (eax >> 26) + 1;
-}
-
 void cpu_detect_cache_sizes(struct cpuinfo_x86 *c)
 {
 	unsigned int n, dummy, ebx, ecx, edx, l2size;
@@ -858,54 +845,6 @@ static void cpu_detect_tlb(struct cpuinf
 		tlb_lld_4m[ENTRIES], tlb_lld_1g[ENTRIES]);
 }
 
-int detect_ht_early(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	u32 eax, ebx, ecx, edx;
-
-	if (!cpu_has(c, X86_FEATURE_HT))
-		return -1;
-
-	if (cpu_has(c, X86_FEATURE_CMP_LEGACY))
-		return -1;
-
-	if (cpu_has(c, X86_FEATURE_XTOPOLOGY))
-		return -1;
-
-	cpuid(1, &eax, &ebx, &ecx, &edx);
-
-	smp_num_siblings = (ebx & 0xff0000) >> 16;
-	if (smp_num_siblings == 1)
-		pr_info_once("CPU0: Hyper-Threading is disabled\n");
-#endif
-	return 0;
-}
-
-void detect_ht(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	int index_msb, core_bits;
-
-	if (topo_is_converted(c))
-		return;
-
-	if (detect_ht_early(c) < 0)
-		return;
-
-	index_msb = get_count_order(smp_num_siblings);
-	c->topo.pkg_id = apic->phys_pkg_id(c->topo.initial_apicid, index_msb);
-
-	smp_num_siblings = smp_num_siblings / c->x86_max_cores;
-
-	index_msb = get_count_order(smp_num_siblings);
-
-	core_bits = get_count_order(c->x86_max_cores);
-
-	c->topo.core_id = apic->phys_pkg_id(c->topo.initial_apicid, index_msb) &
-		((1 << core_bits) - 1);
-#endif
-}
-
 static void get_cpu_vendor(struct cpuinfo_x86 *c)
 {
 	char *v = c->x86_vendor_id;
@@ -1852,10 +1791,6 @@ static void identify_cpu(struct cpuinfo_
 				c->x86, c->x86_model);
 	}
 
-#ifdef CONFIG_X86_64
-	detect_ht(c);
-#endif
-
 	x86_init_rdrand(c);
 	setup_pku(c);
 	setup_cet(c);
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -76,11 +76,7 @@ extern void init_intel_cacheinfo(struct
 extern void init_amd_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_hygon_cacheinfo(struct cpuinfo_x86 *c);
 
-extern void detect_num_cpu_cores(struct cpuinfo_x86 *c);
-extern int detect_extended_topology_early(struct cpuinfo_x86 *c);
 extern int detect_extended_topology(struct cpuinfo_x86 *c);
-extern int detect_ht_early(struct cpuinfo_x86 *c);
-extern void detect_ht(struct cpuinfo_x86 *c);
 extern void check_null_seg_clears_base(struct cpuinfo_x86 *c);
 
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c);
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -489,13 +489,6 @@ static void early_init_intel(struct cpui
 	}
 
 	check_memory_type_self_snoop_errata(c);
-
-	/*
-	 * Get the number of SMT siblings early from the extended topology
-	 * leaf, if available. Otherwise try the legacy SMT detection.
-	 */
-	if (detect_extended_topology_early(c) < 0)
-		detect_ht_early(c);
 }
 
 static void bsp_init_intel(struct cpuinfo_x86 *c)
@@ -777,24 +770,6 @@ static void init_intel(struct cpuinfo_x8
 
 	intel_workarounds(c);
 
-	/*
-	 * Detect the extended topology information if available. This
-	 * will reinitialise the initial_apicid which will be used
-	 * in init_intel_cacheinfo()
-	 */
-	detect_extended_topology(c);
-
-	if (!cpu_has(c, X86_FEATURE_XTOPOLOGY)) {
-		/*
-		 * let's use the legacy cpuid vector 0x1 and 0x4 for topology
-		 * detection.
-		 */
-		detect_num_cpu_cores(c);
-#ifdef CONFIG_X86_32
-		detect_ht(c);
-#endif
-	}
-
 	init_intel_cacheinfo(c);
 
 	if (c->cpuid_level > 9) {
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -64,7 +64,6 @@ bool topo_is_converted(struct cpuinfo_x8
 	/* Temporary until everything is converted over. */
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
-	case X86_VENDOR_INTEL:
 	case X86_VENDOR_HYGON:
 		return false;
 	default:
@@ -129,6 +128,10 @@ static void parse_topology(struct topo_s
 	case X86_VENDOR_ZHAOXIN:
 		parse_legacy(tscan);
 		break;
+	case X86_VENDOR_INTEL:
+		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
+			parse_legacy(tscan);
+		break;
 	}
 }
 


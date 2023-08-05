Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CC4770D04
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 03:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjHEBWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 21:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjHEBWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 21:22:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA934EE2;
        Fri,  4 Aug 2023 18:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691198520; x=1722734520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Sq6LutmPEqTjZno0OkRl+pm8FZO01XfHP5rffjkVYOE=;
  b=YTpayVRKJL9GRoAMssXjQ+EDZzgtUMsA1xXiGAys15GvzSz818DHMQrP
   MZrISN3XOFL+CVLv0sSRhuypWPOb0Q/4APycEQILpb4nWp+J9B75d2Nfl
   ylbH3h2ma4E9Y1c1TJ0Sn4g8w9a7+1fS+DR+8PO9kNH96VpjxXAXX9Ht4
   fVJMVkeIQrS28MOykyp01CblLRY3n4Mpj52skI0h0iObUMe5zXaznKclP
   Eh9w/10yLrkyadBT0P2Mh69vFvBt+vz4eNbIkV5aXLeiKVP+fm6Dfh/z9
   /PhFSmnYnvSv4LFdifqqGXV+v+AFnyt7am5zhjPYsjONVJR0N089+CKOK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="367735769"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="367735769"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 18:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="844317622"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="844317622"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2023 18:21:58 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     x86@kernel.org
Cc:     Andreas Herrmann <aherrmann@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        Radu Rendec <rrendec@redhat.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Pu Wen <puwen@hygon.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        stable@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/3] x86/cacheinfo: Delete global num_cache_leaves
Date:   Fri,  4 Aug 2023 18:24:20 -0700
Message-Id: <20230805012421.7002-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com>
References: <20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux remembers cpu_cachinfo::num_leaves per CPU, but x86 initializes all
CPUs from the same global "num_cache_leaves".

This is erroneous on systems like Meteor Lake, which has different
num_leaves per CPU. Delete the global "num_cache_leaves" and initialize
num_leaves accurately on each CPU.

Cc: Andreas Herrmann <aherrmann@suse.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Radu Rendec <rrendec@redhat.com>
Cc: Pierre Gondois <Pierre.Gondois@arm.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Will Deacon <will@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
After this change, all CPUs will traverse CPUID leaf 0x4 when booted for
the first time. On systems with symmetric cache topologies this is
useless work.

Creating a list of processor models that have asymmetric cache topologies
was considered. The burden of maintaining such list would outweigh the
performance benefit of skipping this extra step.
---
Changes since v2:
 * None

Changes since v1:
 * Do not make num_cache_leaves a per-CPU variable. Instead, reuse the
   existing per-CPU ci_cpu_cacheinfo variable. (Dave Hansen)
---
 arch/x86/kernel/cpu/cacheinfo.c | 45 ++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 8f86eacf69f7..b4334c529231 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -178,7 +178,16 @@ struct _cpuid4_info_regs {
 	struct amd_northbridge *nb;
 };
 
-static unsigned short num_cache_leaves;
+static inline unsigned int get_num_cache_leaves(unsigned int cpu)
+{
+	return get_cpu_cacheinfo(cpu)->num_leaves;
+}
+
+static inline void
+set_num_cache_leaves(unsigned int nr_leaves, unsigned int cpu)
+{
+	get_cpu_cacheinfo(cpu)->num_leaves = nr_leaves;
+}
 
 /* AMD doesn't have CPUID4. Emulate it here to report the same
    information to the user.  This makes some assumptions about the machine:
@@ -718,19 +727,21 @@ void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu)
 void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 {
 
+	unsigned int cpu = c->cpu_index;
+
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
-		num_cache_leaves = find_num_cache_leaves(c);
+		set_num_cache_leaves(find_num_cache_leaves(c), cpu);
 	} else if (c->extended_cpuid_level >= 0x80000006) {
 		if (cpuid_edx(0x80000006) & 0xf000)
-			num_cache_leaves = 4;
+			set_num_cache_leaves(4, cpu);
 		else
-			num_cache_leaves = 3;
+			set_num_cache_leaves(3, cpu);
 	}
 }
 
 void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 {
-	num_cache_leaves = find_num_cache_leaves(c);
+	set_num_cache_leaves(find_num_cache_leaves(c), c->cpu_index);
 }
 
 void init_intel_cacheinfo(struct cpuinfo_x86 *c)
@@ -740,24 +751,21 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 	unsigned int new_l1d = 0, new_l1i = 0; /* Cache sizes from cpuid(4) */
 	unsigned int new_l2 = 0, new_l3 = 0, i; /* Cache sizes from cpuid(4) */
 	unsigned int l2_id = 0, l3_id = 0, num_threads_sharing, index_msb;
-#ifdef CONFIG_SMP
 	unsigned int cpu = c->cpu_index;
-#endif
 
 	if (c->cpuid_level > 3) {
-		static int is_initialized;
-
-		if (is_initialized == 0) {
-			/* Init num_cache_leaves from boot CPU */
-			num_cache_leaves = find_num_cache_leaves(c);
-			is_initialized++;
-		}
+		/*
+		 * There should be at least one leaf. A non-zero value means
+		 * that the number of leaves has been initialized.
+		 */
+		if (!get_num_cache_leaves(cpu))
+			set_num_cache_leaves(find_num_cache_leaves(c), cpu);
 
 		/*
 		 * Whenever possible use cpuid(4), deterministic cache
 		 * parameters cpuid leaf to find the cache details
 		 */
-		for (i = 0; i < num_cache_leaves; i++) {
+		for (i = 0; i < get_num_cache_leaves(cpu); i++) {
 			struct _cpuid4_info_regs this_leaf = {};
 			int retval;
 
@@ -793,14 +801,14 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 	 * Don't use cpuid2 if cpuid4 is supported. For P4, we use cpuid2 for
 	 * trace cache
 	 */
-	if ((num_cache_leaves == 0 || c->x86 == 15) && c->cpuid_level > 1) {
+	if ((!get_num_cache_leaves(cpu) || c->x86 == 15) && c->cpuid_level > 1) {
 		/* supports eax=2  call */
 		int j, n;
 		unsigned int regs[4];
 		unsigned char *dp = (unsigned char *)regs;
 		int only_trace = 0;
 
-		if (num_cache_leaves != 0 && c->x86 == 15)
+		if (get_num_cache_leaves(cpu) && c->x86 == 15)
 			only_trace = 1;
 
 		/* Number of times to iterate */
@@ -1002,12 +1010,9 @@ int init_cache_level(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 
-	if (!num_cache_leaves)
-		return -ENOENT;
 	if (!this_cpu_ci)
 		return -EINVAL;
 	this_cpu_ci->num_levels = 3;
-	this_cpu_ci->num_leaves = num_cache_leaves;
 	return 0;
 }
 
-- 
2.25.1


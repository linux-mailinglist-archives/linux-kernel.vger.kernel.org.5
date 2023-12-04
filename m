Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6586E803D97
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344380AbjLDSyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjLDSyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:54:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1CC113;
        Mon,  4 Dec 2023 10:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701716055; x=1733252055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F8qkqYcIenK7geazKeuWoVN0VD2XUhXS5EHeFC+0k6s=;
  b=I/k3cRRHH2TYpYDQ/YomiSjYilwgOvVftJV8dinu5b7siCXUIk3axpjI
   X7a2pT4g5ksF5STQ9j8GkXsFy5EKJjY10AOPvyi9S0mTGzZ1m3ENboe1A
   WP65ilWLh5zzaQEbO6/vCQyPboGwXx1g0FtlDkaiZbOd64AHpNWJIzv5/
   WroqC4N1ouXoOoW5YaATjCYKosc8dym1W4mu+gyjE/27E/B5Mxjmb5zSF
   zkuhyZVb6aBIDpwDifmSyI4qvwXabFOR16iDdnjnZ5bDFjQfMduyNa3jv
   pUQq3mxeMMGl7jO480TOghUkol2jP+kBAz4X5sVrEaU/+euzjMBq5IOp4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="838523"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="838523"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 10:54:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="836687204"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="836687204"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 10:54:07 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v13 6/8] x86/resctrl: Introduce snc_nodes_per_l3_cache
Date:   Mon,  4 Dec 2023 10:53:55 -0800
Message-ID: <20231204185357.120501-7-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231204185357.120501-1-tony.luck@intel.com>
References: <20231130003418.89964-1-tony.luck@intel.com>
 <20231204185357.120501-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Sub-NUMA Cluster (SNC) is a feature that subdivides the CPU cores
and memory controllers on a socket into two or more groups. These are
presented to the operating system as NUMA nodes.

This may enable some workloads to have slightly lower latency to memory
as the memory controller(s) in an SNC node are electrically closer to the
CPU cores on that SNC node. This cost may be offset by lower bandwidth
since the memory accesses for each core can only be interleaved between
the memory controllers on the same SNC node.

Resctrl monitoring on an Intel system depends upon attaching RMIDs to tasks
to track L3 cache occupancy and memory bandwidth. There is an MSR that
controls how the RMIDs are shared between SNC nodes.

The default mode divides them numerically. E.g. when there are two SNC
nodes on a socket the lower number half of the RMIDs are given to the
first node, the remainder to the second node. This would be difficult
to use with the Linux resctrl interface as specific RMID values assigned
to resctrl groups are not visible to users.

The other mode divides the RMIDs and renumbers the ones on the second
SNC node to start from zero.

Even with this renumbering SNC mode requires several changes in resctrl
behavior for correct operation.

Add a global integer "snc_nodes_per_l3_cache" that shows how many
SNC nodes share each L3 cache. When "snc_nodes_per_l3_cache" is "1",
SNC mode is either not implemented, or not enabled.

Update all places to take appropriate action when SNC mode is enabled:
1) The number of logical RMIDs per L3 cache available for use is the
   number of physical RMIDs divided by the number of SNC nodes.
2) Likewise the "mon_scale" value must be divided by the number of SNC
   nodes.
3) The RMID renumbering operates when using the value from the
   IA32_PQR_ASSOC MSR to count accesses by a task. When reading an RMID
   counter, adjust from the logical RMID to the physical
   RMID value for the SNC node that it wishes to read and load the
   adjusted value into the IA32_QM_EVTSEL MSR.
4) Divide the L3 cache between the SNC nodes. Divide the value
   reported in the resctrl "size" file by the number of SNC
   nodes because the effective amount of cache that can be allocated
   is reduced by that factor.
5) Disable the "-o mba_MBps" mount option in SNC mode
   because the monitoring is being done per SNC node, while the
   bandwidth allocation is still done at the L3 cache scope.
   Trying to use this feedback loop might result in contradictory
   changes to the throttling level coming from each of the SNC
   node bandwidth measurements.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/core.c     |  6 ++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 16 +++++++++++++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  5 +++--
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ce3a70657842..e7a75a439c16 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -446,6 +446,8 @@ DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 
 extern struct dentry *debugfs_resctrl;
 
+extern unsigned int snc_nodes_per_l3_cache;
+
 enum resctrl_res_level {
 	RDT_RESOURCE_L3,
 	RDT_RESOURCE_L2,
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index c9315ce8f7bd..cf5aba8a74bf 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -48,6 +48,12 @@ int max_name_width, max_data_width;
  */
 bool rdt_alloc_capable;
 
+/*
+ * Number of SNC nodes that share each L3 cache.  Default is 1 for
+ * systems that do not support SNC, or have SNC disabled.
+ */
+unsigned int snc_nodes_per_l3_cache = 1;
+
 static void
 mba_wrmsr_intel(struct rdt_ctrl_domain *d, struct msr_param *m,
 		struct rdt_resource *r);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 4e145f5620b0..30b7c3b9b517 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -148,8 +148,18 @@ static inline struct rmid_entry *__rmid_entry(u32 rmid)
 
 static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 {
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	int cpu = smp_processor_id();
+	int rmid_offset = 0;
 	u64 msr_val;
 
+	/*
+	 * When SNC mode is on, need to compute the offset to read the
+	 * physical RMID counter for the node to which this CPU belongs.
+	 */
+	if (snc_nodes_per_l3_cache > 1)
+		rmid_offset = (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->num_rmid;
+
 	/*
 	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
 	 * with a valid event code for supported resource type and the bits
@@ -158,7 +168,7 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
 	 * are error bits.
 	 */
-	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
+	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid + rmid_offset);
 	rdmsrl(MSR_IA32_QM_CTR, msr_val);
 
 	if (msr_val & RMID_VAL_ERROR)
@@ -783,8 +793,8 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	int ret;
 
 	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
-	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
-	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
+	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale / snc_nodes_per_l3_cache;
+	r->num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_cache;
 	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
 
 	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 21bbd832f3f2..79d57dade568 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1425,7 +1425,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 		}
 	}
 
-	return size;
+	return size / snc_nodes_per_l3_cache;
 }
 
 /*
@@ -2298,7 +2298,8 @@ static bool supports_mba_mbps(void)
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 
 	return (is_mbm_local_enabled() &&
-		r->alloc_capable && is_mba_linear());
+		r->alloc_capable && is_mba_linear() &&
+		snc_nodes_per_l3_cache == 1);
 }
 
 /*
-- 
2.41.0


Return-Path: <linux-kernel+bounces-121959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B759C88EFDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4161C20CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE331534E4;
	Wed, 27 Mar 2024 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KtktXxvn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F0153823
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569851; cv=none; b=rHXX84RqWXvK9LaxSG7fIag7j6CFXj0XbLHpm9ZOVsOIIbgs9DlurG1wZ22gpn09LtzfzBlRJYCO9AduvWLcZfZQnRGR9hNC3DjABT+ex4Cn3qsDj4ZF5qHDURrZ2b7jG6fmRlPmFho7AhGAYnaO8Qmkvr3zwIeBlVAMPdEPsSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569851; c=relaxed/simple;
	bh=jnjYRbh/fPxftA3RtGXzv9UpX5enrkyZvcYUhq10uNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOymHdHF6kcnbbAT6wY7GoxM4BL69lEZtdsPmnbwKnrY0lJqnTmswT0nLP39hM/r6N85D+wel6yA1oWh3aArDB8+YK5I7Ibzys/WQrzK1gTa1SauIPGEb5RdKEijX7Jv3R3X5HYIDnuo+xyTtywGDRqw8eYROWHqeg5E6siKj0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KtktXxvn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711569850; x=1743105850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jnjYRbh/fPxftA3RtGXzv9UpX5enrkyZvcYUhq10uNg=;
  b=KtktXxvnxwcv6XGt8VLiYSSI9Rvh4ShVWSnyzu+iuefD2n4NP70LPEOJ
   ZWkslgBwq96mBXu+DpYfgZb0/f/+jrshWYPv3nNJu3UrJl0ZLKGVoNGcn
   3K9H9H6sLJbm7aaHf2t6MpCirnSqu74PDHMCFrrTUwhNxWZ4RBLu7+KkZ
   JZ3pzpsb5BLyUPfetaFBsnhz4VlhIrhKoo1CM4+/ufl/Stl4N8sugtKJm
   3cTFtHZ33I5KUjhvdHjwe+IAdOX3MlsXucpCRl6QJOPz7G/aiLBytWjOF
   IBch43duRtiVepAUQCvJNGgqFYdhHBZmqIGXOUfbhj7IR1SxTF9Z0DJU5
   Q==;
X-CSE-ConnectionGUID: W8wRhlIrS0O910ukY8U+vQ==
X-CSE-MsgGUID: sxEC4Ze1Q6qH83+uwQe2mQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="18133030"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="18133030"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 13:04:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16246150"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 13:04:04 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH 10/10] x86/resctrl: Determine Sub-NUMA configuration
Date: Wed, 27 Mar 2024 13:03:52 -0700
Message-ID: <20240327200352.236835-11-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327200352.236835-1-tony.luck@intel.com>
References: <20240327200352.236835-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There isn't an explicit enumeration of Sub-NUMA cluster mode. Use
the ratio of the number of CPUs that share an L3 cache instance with
CPU 0 against the number of CPUs that share a node with CPU0.

When Sub-NUMA cluster mode is enabled, adjust the number of RMIDs,
the sclaing factor, and setup the parent/child pointers in the
L3 and SUBL3 rdt_resource structures, etc.

As each Sub-NUMA domain is brought online, update the MSR_RMID_SNC_CONFIG
to remap RMID counters.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 68 ++++++++++++++++++++++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 26 ++++++++++
 3 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 05956bd8bacf..b54c26016c93 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1158,6 +1158,7 @@
 #define MSR_IA32_QM_CTR			0xc8e
 #define MSR_IA32_PQR_ASSOC		0xc8f
 #define MSR_IA32_L3_CBM_BASE		0xc90
+#define MSR_RMID_SNC_CONFIG		0xca0
 #define MSR_IA32_L2_CBM_BASE		0xd10
 #define MSR_IA32_MBA_THRTL_BASE		0xd50
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 1ba40d5f5d77..757d475158a3 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -17,6 +17,7 @@
 
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/cacheinfo.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 
@@ -1051,16 +1052,59 @@ static void l3_mon_evt_init(struct rdt_resource *r)
 		list_add_tail(&mbm_local_event.list, &r->evt_list);
 }
 
+/* CPU models that support MSR_RMID_SNC_CONFIG */
+static const struct x86_cpu_id snc_cpu_ids[] __initconst = {
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, 0),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, 0),
+	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, 0),
+	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X, 0),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X, 0),
+	{}
+};
+
+static __init int snc_get_config(void)
+{
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(0);
+	cpumask_t *l3_cpumask = NULL;
+	const cpumask_t	*node0_cpumask;
+	int i;
+
+	if (!x86_match_cpu(snc_cpu_ids))
+		return 1;
+
+	for (i = 0; i < ci->num_leaves; i++) {
+		if (ci->info_list[i].level == 3) {
+			if (ci->info_list[i].attributes & CACHE_ID) {
+				l3_cpumask = &ci->info_list[i].shared_cpu_map;
+				break;
+			}
+		}
+	}
+	if (!l3_cpumask) {
+		pr_info("can't get CPU0 L3 mask\n");
+		return 1;
+	}
+
+	node0_cpumask = cpumask_of_node(cpu_to_node(0));
+
+	return bitmap_weight(cpumask_bits(l3_cpumask), nr_cpu_ids) /
+	       bitmap_weight(cpumask_bits(node0_cpumask), nr_cpu_ids);
+}
+
 int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	unsigned int threshold;
+	int snc_ways;
 	int ret;
 
+	snc_ways = snc_get_config();
+	if (snc_ways > 1)
+		pr_info("Sub-NUMA cluster detected with %d nodes per L3 cache\n", snc_ways);
 	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
-	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
-	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
+	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale / snc_ways;
+	r->num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_ways;
 	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
 
 	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
@@ -1084,8 +1128,23 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	 */
 	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(threshold);
 
-	r->num_siblings = 1;
-	rdt_l3_mon_resource = r;
+	if (snc_ways > 1) {
+		struct rdt_hw_resource *shw_res;
+
+		rdt_l3_mon_resource = &rdt_resources_all[RDT_RESOURCE_SUBL3].r_resctrl;
+		rdt_l3_mon_resource->num_rmid = r->num_rmid;
+		rdt_l3_mon_resource->num_siblings = snc_ways;
+
+		shw_res = resctrl_to_arch_res(rdt_l3_mon_resource);
+		shw_res->mon_scale = hw_res->mon_scale;
+		shw_res->mbm_width = hw_res->mbm_width;
+
+		r->child = rdt_l3_mon_resource;
+		rdt_l3_mon_resource->parent = r;
+	} else {
+		r->num_siblings = 1;
+		rdt_l3_mon_resource = r;
+	}
 
 	ret = dom_data_init(rdt_l3_mon_resource);
 	if (ret)
@@ -1110,6 +1169,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 
 	l3_mon_evt_init(rdt_l3_mon_resource);
 
+	r->mon_capable = true;
 	rdt_l3_mon_resource->mon_capable = true;
 	rdt_l3_mon_resource->mon_enabled = true;
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3e7f2e36b71e..b1f79fafa333 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4067,6 +4067,29 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
+/*
+ * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
+ * which indicates that RMIDs are configured in legacy mode.
+ * This mode is incompatible with Linux resctrl semantics
+ * as RMIDs are partitioned between SNC nodes, which requires
+ * a user to know which RMID is allocated to a task.
+ * Clearing bit 0 reconfigures the RMID counters for use
+ * in Sub NUMA Cluster mode. This mode is better for Linux.
+ * The RMID space is divided between all SNC nodes with the
+ * RMIDs renumbered to start from zero in each node when
+ * couning operations from tasks. Code to read the counters
+ * must adjust RMID counter numbers based on SNC node. See
+ * __rmid_read() for code that does this.
+ */
+static void snc_remap_rmids(void)
+{
+	u64 val;
+
+	rdmsrl(MSR_RMID_SNC_CONFIG, val);
+	val &= ~BIT_ULL(0);
+	wrmsrl(MSR_RMID_SNC_CONFIG, val);
+}
+
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 {
 	int err = 0;
@@ -4082,6 +4105,9 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 	if (!r->mon_enabled)
 		goto out_unlock;
 
+	if (r->num_siblings > 1)
+		snc_remap_rmids();
+
 	err = domain_setup_mon_state(r, d);
 	if (err)
 		goto out_unlock;
-- 
2.44.0



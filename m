Return-Path: <linux-kernel+bounces-121953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AF488EFD2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38018B228F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23C8153591;
	Wed, 27 Mar 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpqP3vir"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCA31534E4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569847; cv=none; b=Vl6ZFvQS0OCqetTypP3gRg4LrqNuNnVsnVx+VxhiMd2aNyZXF5U2950d055xPasmuV51r+loe3FTI6IbgNsvS0+mm3HdOHWGK4/bxwp5QWDRZaR8JglzLkFTuo+xpFvn0BpYsVhkDKwUrPK0KbxI1poVXbpiejFeBT5qJS3s2/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569847; c=relaxed/simple;
	bh=UAgoVYMozpNrZsRTA+xS7ef2Vl0uFY5WsmZWWJAct4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ers8Z8pi7wyGYHmtlZYP2OtlHeGnigvFvrnoPcIeP9Lb8aZ1HA6Qz0FYkhZ2dDSn/pgsJ9INbTIPfbUF3zLfD0k8fAW7OscxPPsFiV3ETYr64v2qaUQ0QL7ymSWuodDHjy+MpJ1ZWpJPYR7EakNqx8qSsbQBQAk3ol0ItNa11LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpqP3vir; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711569846; x=1743105846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UAgoVYMozpNrZsRTA+xS7ef2Vl0uFY5WsmZWWJAct4o=;
  b=IpqP3vir1n0myUR8bkMDAgCydRc0l5m3scLLrj9qm8TAQdYK6t/29Jos
   gt3+HhRWYS5bpqDCHnTONdOFIRPrUFkWEceK4WPGQjwltefXF5YzPRISQ
   p8tYJEig2UCiFQFUWW70p8YzpfknArZml/aFLfqtm0X0K35dD1j1UYwvR
   ILWqpGgXYxEhk6xqzrIrl/XWdFez9PuM8iKu8S9UlDjvjGpDsJQ/cTfry
   6C6dwvPx3irNdciotPM5GtnQe8Nf/1O3CpfFrWpEtaUjP7puj6ctwc4yr
   Us8dGlnj/LAxXFOe2Jj+r6cUZUAe+aLMwTn0iNq+GBj6JBXJHca5YTu6T
   A==;
X-CSE-ConnectionGUID: mI7vn1vrRWWdPiSRdQLv4Q==
X-CSE-MsgGUID: 57Sz/OgqR2Kx11eGzZCU+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="18132983"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="18132983"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 13:04:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16246118"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 13:04:02 -0700
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
Subject: [PATCH 04/10] x86/resctrl: Add pointer to enabled monitor resource
Date: Wed, 27 Mar 2024 13:03:46 -0700
Message-ID: <20240327200352.236835-5-tony.luck@intel.com>
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

Sub-NUMA cluster enabled systems do all monitoring using the SUBL3
resource. Others use the regular L3 resource.

Replace the hard-coded rdt_resources_all[RDT_RESOURCE_L3].r_resctrl
references with a new pointer "rdt_l3_mon_resource".

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/core.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 19 ++++++++++++-------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  7 +++----
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 5fcff861e185..21d81f51838f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -464,6 +464,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 extern struct mutex rdtgroup_mutex;
 
 extern struct rdt_hw_resource rdt_resources_all[];
+extern struct rdt_resource *rdt_l3_mon_resource;
 extern struct rdtgroup rdtgroup_default;
 extern struct dentry *debugfs_resctrl;
 
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index bfa179f20802..2fa04375da8c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -996,7 +996,7 @@ late_initcall(resctrl_late_init);
 
 static void __exit resctrl_exit(void)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_resource *r = rdt_l3_mon_resource;
 
 	cpuhp_remove_state(rdt_online);
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 84a2056190c8..95455cb187eb 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -78,6 +78,9 @@ static struct rmid_entry	*rmid_ptrs;
  */
 bool rdt_mon_capable;
 
+/* Resource (L3 or SUBL3) that is base for monitoring */
+struct rdt_resource *rdt_l3_mon_resource;
+
 /*
  * Global to indicate which monitoring events are enabled.
  */
@@ -321,7 +324,7 @@ static void limbo_release_entry(struct rmid_entry *entry)
  */
 void __check_limbo(struct rdt_domain *d, bool force_free)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_resource *r = rdt_l3_mon_resource;
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry;
 	u32 idx, cur_idx = 1;
@@ -467,7 +470,7 @@ int alloc_rmid(u32 closid)
 
 static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_resource *r = rdt_l3_mon_resource;
 	struct rdt_domain *d;
 	u32 idx;
 
@@ -839,7 +842,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	if (!resctrl_mounted || !resctrl_arch_mon_capable())
 		goto out_unlock;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	r = rdt_l3_mon_resource;
 	d = container_of(work, struct rdt_domain, mbm_over.work);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
@@ -1036,7 +1039,9 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	 */
 	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(threshold);
 
-	ret = dom_data_init(r);
+	rdt_l3_mon_resource = r;
+
+	ret = dom_data_init(rdt_l3_mon_resource);
 	if (ret)
 		return ret;
 
@@ -1057,10 +1062,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		}
 	}
 
-	l3_mon_evt_init(r);
+	l3_mon_evt_init(rdt_l3_mon_resource);
 
-	r->mon_capable = true;
-	r->mon_enabled = true;
+	rdt_l3_mon_resource->mon_capable = true;
+	rdt_l3_mon_resource->mon_enabled = true;
 
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ffcafe567b25..a2ebd7e051bb 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2703,7 +2703,7 @@ static int rdt_get_tree(struct fs_context *fc)
 		resctrl_mounted = true;
 
 	if (is_mbm_enabled()) {
-		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+		r = rdt_l3_mon_resource;
 		list_for_each_entry(dom, &r->domains, list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
 						   RESCTRL_PICK_ANY_CPU);
@@ -4062,7 +4062,6 @@ static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
 
 void resctrl_offline_cpu(unsigned int cpu)
 {
-	struct rdt_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	struct rdtgroup *rdtgrp;
 	struct rdt_domain *d;
 
@@ -4074,10 +4073,10 @@ void resctrl_offline_cpu(unsigned int cpu)
 		}
 	}
 
-	if (!l3->mon_enabled)
+	if (!rdt_l3_mon_resource->mon_enabled)
 		goto out_unlock;
 
-	d = get_domain_from_cpu(cpu, l3);
+	d = get_domain_from_cpu(cpu, rdt_l3_mon_resource);
 	if (d) {
 		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
 			cancel_delayed_work(&d->mbm_over);
-- 
2.44.0



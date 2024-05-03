Return-Path: <linux-kernel+bounces-168189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE8D8BB4E9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADCD8B24BBE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEB32744C;
	Fri,  3 May 2024 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="keJYIQyG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CC541C92
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768423; cv=none; b=hxrj2qXAvOOYdA6ReBgmijkGHXpjDFCtHn2N0S8ZzBVG2ttotgZgd7qJ04ASlixBzg+4+YCcFlItHufT+Rg7WZHdcaYHZY7ZbAQJrroorsAu3Zg1xUspGfKkZ7K/ZdExQ+jmUJEq205wRbgFevUgZHPeb8wD3JjZVNAWVnsxx+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768423; c=relaxed/simple;
	bh=vh7BCM5c+ji4+VaEdCUULuZjRKjO6FYtYYMNjhaAy8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRZtEfsHjVund5XtGyJuyAHpKsK612SKUSZLU/emqQpAyuaNe0dwdvtDaASxxDiGFdKLT35lug2BtoYjBNjh71SoLV0uoqLnyUaPtRH068jqabGgdP1RhrmULusnVzvO9RQy4S5UVXvnrGTkCXeoTo6SE6QDoSMh5hOzX+OrA+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=keJYIQyG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714768421; x=1746304421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vh7BCM5c+ji4+VaEdCUULuZjRKjO6FYtYYMNjhaAy8c=;
  b=keJYIQyGI3MqrGucxqay/DQyl7Gf45jcDAPg3OWQmZIBWZbamGp+74iW
   g9dsyErSa57NkKmjwFHbwwgPFcJK3auorJUBdl8cuGeYVGnYYumD9p/Vm
   o5x+DFT1DlK8RHmwgcYMcpxOO5yZ8/mdBcVSXc99ndswonjSbkZObxltT
   RAYWFmhQHLQVHwNHRHVKBZ4zHxHUP8lqBwrJC/1yqo8n2J+eWnmRXS+q4
   0KmV/bT1F3lcLGrG4xgRzxHOcvtb5sEoHyFFbSBf89/94zV4SIK/TGggA
   9i8ed89f0HzOia6HHZPM3CJ6vzYucuGE/fKxXaIAmyQu8srgQOcqpTAK1
   w==;
X-CSE-ConnectionGUID: Io8YaMgrTUGtza8wwIkltA==
X-CSE-MsgGUID: NduXn5tYRJaBS81XA8QXwQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="21274307"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="21274307"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 13:33:37 -0700
X-CSE-ConnectionGUID: q/p+KmKMTwKryskN5Le9SQ==
X-CSE-MsgGUID: HiOsTh3ERpyhT9+YiMb2Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27431826"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 13:33:36 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v17 7/9] x86/resctrl: Add new monitor files for Sub-NUMA cluster (SNC) monitoring
Date: Fri,  3 May 2024 13:33:23 -0700
Message-ID: <20240503203325.21512-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503203325.21512-1-tony.luck@intel.com>
References: <20240503203325.21512-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a field to the rdt_resource structure to track whether monitoring
resources are tracked by hardware at a different scope (NODE) from
the legacy L3 scope.

Add a field to the rdt_mon_domain structure to track the L3 cache id
which can be used to find all the domains that need resource counts
summed to provide accurate values in the legacy monitoring files.

When SNC is enabled create extra directories and files in each mon_data
directory to report per-SNC node counts.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                   |   4 +
 arch/x86/kernel/cpu/resctrl/internal.h    |   5 +-
 arch/x86/kernel/cpu/resctrl/core.c        |   2 +
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   1 +
 arch/x86/kernel/cpu/resctrl/monitor.c     |  52 +++++++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 115 +++++++++++++++++-----
 6 files changed, 137 insertions(+), 42 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5c7775343c3e..2f8ac925bc18 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -96,6 +96,7 @@ struct rdt_ctrl_domain {
 /**
  * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor resource
  * @hdr:		common header for different domain types
+ * @display_id:		shared id used to identify domains to be summed for display
  * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
  * @mbm_total:		saved state for MBM total bandwidth
  * @mbm_local:		saved state for MBM local bandwidth
@@ -106,6 +107,7 @@ struct rdt_ctrl_domain {
  */
 struct rdt_mon_domain {
 	struct rdt_domain_hdr		hdr;
+	int				display_id;
 	unsigned long			*rmid_busy_llc;
 	struct mbm_state		*mbm_total;
 	struct mbm_state		*mbm_local;
@@ -187,6 +189,7 @@ enum resctrl_scope {
  * @num_rmid:		Number of RMIDs available
  * @ctrl_scope:		Scope of this resource for control functions
  * @mon_scope:		Scope of this resource for monitor functions
+ * @mon_display_scope:	Scope for user reporting monitor functions
  * @cache:		Cache allocation related data
  * @membw:		If the component has bandwidth controls, their properties.
  * @ctrl_domains:	RCU list of all control domains for this resource
@@ -207,6 +210,7 @@ struct rdt_resource {
 	int			num_rmid;
 	enum resctrl_scope	ctrl_scope;
 	enum resctrl_scope	mon_scope;
+	enum resctrl_scope	mon_display_scope;
 	struct resctrl_cache	cache;
 	struct resctrl_membw	membw;
 	struct list_head	ctrl_domains;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 49440f194253..d41b388bb499 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -132,6 +132,7 @@ struct mon_evt {
  *                     as kernfs private data
  * @rid:               Resource id associated with the event file
  * @evtid:             Event id associated with the event file
+ * @sum:               Sum across domains with same display_id
  * @domid:             The domain to which the event file belongs
  * @u:                 Name of the bit fields struct
  */
@@ -139,7 +140,8 @@ union mon_data_bits {
 	void *priv;
 	struct {
 		unsigned int rid		: 10;
-		enum resctrl_event_id evtid	: 8;
+		enum resctrl_event_id evtid	: 7;
+		unsigned int sum		: 1;
 		unsigned int domid		: 14;
 	} u;
 };
@@ -150,6 +152,7 @@ struct rmid_read {
 	struct rdt_mon_domain	*d;
 	enum resctrl_event_id	evtid;
 	bool			first;
+	bool			sumdomains;
 	int			err;
 	u64			val;
 	void			*arch_mon_ctx;
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index cb181796f73b..a949e69308cd 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -71,6 +71,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.name			= "L3",
 			.ctrl_scope		= RESCTRL_L3_CACHE,
 			.mon_scope		= RESCTRL_L3_CACHE,
+			.mon_display_scope	= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L3),
 			.mon_domains		= mon_domain_init(RDT_RESOURCE_L3),
 			.parse_ctrlval		= parse_cbm,
@@ -613,6 +614,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 
 	d = &hw_dom->d_resctrl;
 	d->hdr.id = id;
+	d->display_id = get_domain_id_from_scope(cpu, r->mon_display_scope);
 	d->hdr.type = RESCTRL_MON_DOMAIN;
 	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
 
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 3b9383612c35..a4ead8ffbaf3 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -575,6 +575,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	resid = md.u.rid;
 	domid = md.u.domid;
 	evtid = md.u.evtid;
+	rr.sumdomains = md.u.sum;
 
 	r = &rdt_resources_all[resid].r_resctrl;
 	hdr = rdt_find_domain(&r->mon_domains, domid, NULL);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index d0bbeb410750..2e795b261b6f 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/cpu.h>
+#include <linux/cacheinfo.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -187,18 +188,8 @@ static inline struct rmid_entry *__rmid_entry(u32 idx)
 
 static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	int cpu = smp_processor_id();
-	int rmid_offset = 0;
 	u64 msr_val;
 
-	/*
-	 * When SNC mode is on, need to compute the offset to read the
-	 * physical RMID counter for the node to which this CPU belongs.
-	 */
-	if (snc_nodes_per_l3_cache > 1)
-		rmid_offset = (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->num_rmid;
-
 	/*
 	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
 	 * with a valid event code for supported resource type and the bits
@@ -207,7 +198,7 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
 	 * are error bits.
 	 */
-	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid + rmid_offset);
+	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
 	rdmsrl(MSR_IA32_QM_CTR, msr_val);
 
 	if (msr_val & RMID_VAL_ERROR)
@@ -291,7 +282,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 
 	resctrl_arch_rmid_read_context_check();
 
-	if (!cpumask_test_cpu(smp_processor_id(), &d->hdr.cpu_mask))
+	if (d->display_id != get_cpu_cacheinfo_id(smp_processor_id(), r->mon_display_scope))
 		return -EINVAL;
 
 	ret = __rmid_read(rmid, eventid, &msr_val);
@@ -556,7 +547,7 @@ static struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
 	}
 }
 
-static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
+static int ___mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr, u64 *rrval)
 {
 	struct mbm_state *m;
 	u64 tval = 0;
@@ -574,11 +565,44 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 	if (rr->err)
 		return rr->err;
 
-	rr->val += tval;
+	*rrval += tval;
 
 	return 0;
 }
 
+static u32 get_node_rmid(struct rdt_resource *r, struct rdt_mon_domain *d, u32 rmid)
+{
+	int cpu = cpumask_any(&d->hdr.cpu_mask);
+
+	return rmid + (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->num_rmid;
+}
+
+static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
+{
+	struct rdt_mon_domain *d;
+	struct rmid_read tmp;
+	u32 node_rmid;
+	int ret = 0;
+
+	if (!rr->sumdomains) {
+		node_rmid = get_node_rmid(rr->r, rr->d, rmid);
+		return ___mon_event_count(closid, node_rmid, rr, &rr->val);
+	}
+
+	tmp = *rr;
+	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
+		if (d->display_id == rr->d->display_id) {
+			tmp.d = d;
+			node_rmid = get_node_rmid(rr->r, d, rmid);
+			ret = ___mon_event_count(closid, node_rmid, &tmp, &rr->val);
+			if (ret)
+				break;
+		}
+	}
+
+	return ret;
+}
+
 /*
  * mbm_bw_count() - Update bw count from values previously read by
  *		    __mon_event_count().
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 0923492a8bd0..a56ae08ca255 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3011,57 +3011,118 @@ static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
  * and monitor groups with given domain id.
  */
 static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-					   unsigned int dom_id)
+					   struct rdt_mon_domain *d)
 {
 	struct rdtgroup *prgrp, *crgrp;
+	struct rdt_mon_domain *dom;
+	bool remove_all = true;
+	struct kernfs_node *kn;
+	char subname[32];
 	char name[32];
 
+	sprintf(name, "mon_%s_%02d", r->name, d->display_id);
+	if (r->mon_scope != r->mon_display_scope) {
+		int count = 0;
+
+		list_for_each_entry(dom, &r->mon_domains, hdr.list)
+			if (d->display_id == dom->display_id)
+				count++;
+		if (count > 1) {
+			remove_all = false;
+			sprintf(subname, "mon_sub_%s_%02d", r->name, d->hdr.id);
+		}
+	}
+
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		sprintf(name, "mon_%s_%02d", r->name, dom_id);
-		kernfs_remove_by_name(prgrp->mon.mon_data_kn, name);
+		if (remove_all) {
+			kernfs_remove_by_name(prgrp->mon.mon_data_kn, name);
+		} else {
+			kn = kernfs_find_and_get_ns(prgrp->mon.mon_data_kn, name, NULL);
+			if (kn)
+				kernfs_remove_by_name(kn, subname);
+		}
 
-		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
-			kernfs_remove_by_name(crgrp->mon.mon_data_kn, name);
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list) {
+			if (remove_all) {
+				kernfs_remove_by_name(crgrp->mon.mon_data_kn, name);
+			} else {
+				kn = kernfs_find_and_get_ns(prgrp->mon.mon_data_kn, name, NULL);
+				if (kn)
+					kernfs_remove_by_name(kn, subname);
+			}
+		}
 	}
 }
 
-static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
-				struct rdt_mon_domain *d,
-				struct rdt_resource *r, struct rdtgroup *prgrp)
+static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
+			     struct rdt_resource *r, struct rdtgroup *prgrp,
+			     bool do_sum)
 {
 	union mon_data_bits priv;
-	struct kernfs_node *kn;
 	struct mon_evt *mevt;
 	struct rmid_read rr;
-	char name[32];
 	int ret;
 
-	sprintf(name, "mon_%s_%02d", r->name, d->hdr.id);
-	/* create the directory */
-	kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
-	if (IS_ERR(kn))
-		return PTR_ERR(kn);
-
-	ret = rdtgroup_kn_set_ugid(kn);
-	if (ret)
-		goto out_destroy;
-
-	if (WARN_ON(list_empty(&r->evt_list))) {
-		ret = -EPERM;
-		goto out_destroy;
-	}
+	if (WARN_ON(list_empty(&r->evt_list)))
+		return -EPERM;
 
 	priv.u.rid = r->rid;
 	priv.u.domid = d->hdr.id;
+	priv.u.sum = do_sum;
 	list_for_each_entry(mevt, &r->evt_list, list) {
 		priv.u.evtid = mevt->evtid;
 		ret = mon_addfile(kn, mevt->name, priv.priv);
 		if (ret)
-			goto out_destroy;
+			return ret;
 
 		if (is_mbm_event(mevt->evtid))
 			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);
 	}
+
+	return 0;
+}
+
+static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
+				struct rdt_mon_domain *d,
+				struct rdt_resource *r, struct rdtgroup *prgrp)
+{
+	struct kernfs_node *kn, *ckn;
+	char name[32];
+	bool do_sum;
+	int ret;
+
+	do_sum = r->mon_scope != r->mon_display_scope;
+	sprintf(name, "mon_%s_%02d", r->name, d->display_id);
+	kn = kernfs_find_and_get_ns(parent_kn, name, NULL);
+	if (!kn) {
+		/* create the directory */
+		kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
+		if (IS_ERR(kn))
+			return PTR_ERR(kn);
+
+		ret = rdtgroup_kn_set_ugid(kn);
+		if (ret)
+			goto out_destroy;
+		ret = mon_add_all_files(kn, d, r, prgrp, do_sum);
+		if (ret)
+			goto out_destroy;
+	}
+
+	if (do_sum) {
+		sprintf(name, "mon_sub_%s_%02d", r->name, d->hdr.id);
+		ckn = kernfs_create_dir(kn, name, parent_kn->mode, prgrp);
+		if (IS_ERR(ckn))
+			goto out_destroy;
+
+		ret = rdtgroup_kn_set_ugid(ckn);
+		if (ret)
+			goto out_destroy;
+
+		ret = mon_add_all_files(ckn, d, r, prgrp, false);
+		if (ret)
+			goto out_destroy;
+	}
+
 	kernfs_activate(kn);
 	return 0;
 
@@ -3077,8 +3138,8 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 					   struct rdt_mon_domain *d)
 {
-	struct kernfs_node *parent_kn;
 	struct rdtgroup *prgrp, *crgrp;
+	struct kernfs_node *parent_kn;
 	struct list_head *head;
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
@@ -3950,7 +4011,7 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d
 	 * per domain monitor data directories.
 	 */
 	if (resctrl_mounted && resctrl_arch_mon_capable())
-		rmdir_mondata_subdir_allrdtgrp(r, d->hdr.id);
+		rmdir_mondata_subdir_allrdtgrp(r, d);
 
 	if (is_mbm_enabled())
 		cancel_delayed_work(&d->mbm_over);
-- 
2.44.0



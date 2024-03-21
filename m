Return-Path: <linux-kernel+bounces-110418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E7B885EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D381F22EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF87138499;
	Thu, 21 Mar 2024 16:51:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC32813848F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039899; cv=none; b=qHB8rd7ouyxb4LQ1eB0YECYsQU2STvNJejYj6vHN69UVjtDo5r9lD4sxKfD0MttwWWERSnL5vnR7aIjLyKcEss7ZDYiNDPpmkgWQgIFM9lWQancTRxoF9/AwjEt0w1pag1CvPXyWp6dRToUPOWmtqeGUIucCxjGejcFXXs8Gc5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039899; c=relaxed/simple;
	bh=Q/9+cexZaZ9RbRWovzQJExPGNP5UXGSnxxkCqwGXM5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nvaz7wOPtS1ZYu0emn4ipg+9JlwaKbimGruCJkU0krQeqT4pGAHqJGJKSMmk9BWHZzKFsVVwcdDD2qs8KSBl6qx1sAHCDy7wv+bDz+meBcXTXvLkiBE2RvkkH57Md0SGIAebnlmdhtYKkvhsjVFXcrNffZSQ+37aQ+LDuR6noNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DED71007;
	Thu, 21 Mar 2024 09:52:10 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFAD23F67D;
	Thu, 21 Mar 2024 09:51:32 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>
Subject: [PATCH v1 02/31] x86/resctrl: Add a helper to avoid reaching into the arch code resource list
Date: Thu, 21 Mar 2024 16:50:37 +0000
Message-Id: <20240321165106.31602-3-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240321165106.31602-1-james.morse@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resctrl occasionally wants to know something about a specific resource,
in these cases it reaches into the arch code's rdt_resources_all[]
array.

Once the filesystem parts of resctrl are moved to /fs/, this means it
will need visibility of the architecture specific struct
resctrl_hw_resource definition, and the array of all resources.
All architectures would also need a r_resctrl member in this struct.

Instead, abstract this via a helper to allow architectures to do
different things here. Move the level enum to the resctrl header and
add a helper to retrieve the struct rdt_resource by 'rid'.

resctrl_arch_get_resource() should not return NULL for any value in
the enum, it may instead return a dummy resource that is
!alloc_enabled && !mon_enabled.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c        | 10 +++++++++-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h    | 10 ----------
 arch/x86/kernel/cpu/resctrl/monitor.c     |  8 ++++----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 15 +++++++--------
 include/linux/resctrl.h                   | 17 +++++++++++++++++
 6 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 83e40341583e..b773b3bdebe3 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -122,6 +122,14 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 };
 
+struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
+{
+	if (l >= RDT_NUM_RESOURCES)
+		return NULL;
+
+	return &rdt_resources_all[l].r_resctrl;
+}
+
 /*
  * cache_alloc_hsw_probe() - Have to probe for Intel haswell server CPUs
  * as they do not have CPUID enumeration support for Cache allocation.
@@ -169,7 +177,7 @@ static inline void cache_alloc_hsw_probe(void)
 bool is_mba_sc(struct rdt_resource *r)
 {
 	if (!r)
-		return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.mba_sc;
+		r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 
 	/*
 	 * The software controller support is only applicable to MBA resource.
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 7997b47743a2..788ac0395645 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -599,7 +599,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	domid = md.u.domid;
 	evtid = md.u.evtid;
 
-	r = &rdt_resources_all[resid].r_resctrl;
+	r = resctrl_arch_get_resource(resid);
 	d = rdt_find_domain(r, domid, NULL);
 	if (IS_ERR_OR_NULL(d)) {
 		ret = -ENOENT;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c99f26ebe7a6..65990def6c79 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -466,16 +466,6 @@ extern struct rdt_hw_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 extern struct dentry *debugfs_resctrl;
 
-enum resctrl_res_level {
-	RDT_RESOURCE_L3,
-	RDT_RESOURCE_L2,
-	RDT_RESOURCE_MBA,
-	RDT_RESOURCE_SMBA,
-
-	/* Must be the last */
-	RDT_NUM_RESOURCES,
-};
-
 static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(res);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c34a35ec0f03..06565153ceb2 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -321,7 +321,7 @@ static void limbo_release_entry(struct rmid_entry *entry)
  */
 void __check_limbo(struct rdt_domain *d, bool force_free)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry;
 	u32 idx, cur_idx = 1;
@@ -467,7 +467,7 @@ int alloc_rmid(u32 closid)
 
 static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	struct rdt_domain *d;
 	u32 idx;
 
@@ -669,7 +669,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	if (!is_mbm_local_enabled())
 		return;
 
-	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+	r_mba = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
@@ -839,7 +839,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	if (!resctrl_mounted || !resctrl_arch_mon_capable())
 		goto out_unlock;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	d = container_of(work, struct rdt_domain, mbm_over.work);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1767c1affa60..45372b6a6215 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2253,7 +2253,7 @@ static void l2_qos_cfg_update(void *arg)
 
 static inline bool is_mba_linear(void)
 {
-	return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.delay_linear;
+	return resctrl_arch_get_resource(RDT_RESOURCE_MBA)->membw.delay_linear;
 }
 
 static int set_cache_qos_cfg(int level, bool enable)
@@ -2341,7 +2341,7 @@ static void mba_sc_domain_destroy(struct rdt_resource *r,
  */
 static bool supports_mba_mbps(void)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 
 	return (is_mbm_local_enabled() &&
 		r->alloc_capable && is_mba_linear());
@@ -2353,7 +2353,7 @@ static bool supports_mba_mbps(void)
  */
 static int set_mba_sc(bool mba_sc)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 	u32 num_closid = resctrl_arch_get_num_closid(r);
 	struct rdt_domain *d;
 	int i;
@@ -2625,10 +2625,10 @@ static void schemata_list_destroy(void)
 
 static int rdt_get_tree(struct fs_context *fc)
 {
+	struct rdt_resource *l3 = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
 	unsigned long flags = RFTYPE_CTRL_BASE;
 	struct rdt_domain *dom;
-	struct rdt_resource *r;
 	int ret;
 
 	cpus_read_lock();
@@ -2701,8 +2701,7 @@ static int rdt_get_tree(struct fs_context *fc)
 		resctrl_mounted = true;
 
 	if (is_mbm_enabled()) {
-		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-		list_for_each_entry(dom, &r->domains, list)
+		list_for_each_entry(dom, &l3->domains, list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
 						   RESCTRL_PICK_ANY_CPU);
 	}
@@ -3878,7 +3877,7 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
 		seq_puts(seq, ",cdpl2");
 
-	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
+	if (is_mba_sc(resctrl_arch_get_resource(RDT_RESOURCE_MBA)))
 		seq_puts(seq, ",mba_MBps");
 
 	if (resctrl_debug)
@@ -4068,7 +4067,7 @@ static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
 
 void resctrl_offline_cpu(unsigned int cpu)
 {
-	struct rdt_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_resource *l3 = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	struct rdtgroup *rdtgrp;
 	struct rdt_domain *d;
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index a365f67131ec..168cc9510069 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -36,6 +36,16 @@ enum resctrl_conf_type {
 	CDP_DATA,
 };
 
+enum resctrl_res_level {
+	RDT_RESOURCE_L3,
+	RDT_RESOURCE_L2,
+	RDT_RESOURCE_MBA,
+	RDT_RESOURCE_SMBA,
+
+	/* Must be the last */
+	RDT_NUM_RESOURCES,
+};
+
 #define CDP_NUM_TYPES	(CDP_DATA + 1)
 
 /*
@@ -190,6 +200,13 @@ struct rdt_resource {
 	bool			cdp_capable;
 };
 
+/*
+ * Get the resource that exists at this level. If the level is not supported
+ * a dummy/not-capable resource can be returned. Levels >= RDT_NUM_RESOURCES
+ * will return NULL.
+ */
+struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l);
+
 /**
  * struct resctrl_schema - configuration abilities of a resource presented to
  *			   user-space
-- 
2.39.2



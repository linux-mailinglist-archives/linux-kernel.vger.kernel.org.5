Return-Path: <linux-kernel+bounces-160218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B582B8B3AB0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF2A281611
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0927E149E00;
	Fri, 26 Apr 2024 15:09:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB2E1494CF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144160; cv=none; b=J/OkCfOZ+QOV0sWh7m9SQEx+6hPBRHv7NLeqxJwT3QQmZPKtr+wRr61B8VA6P1K8UGkQ7bGAHWerzuLJgYryCvtygy1FwmJ1mfmQIhk+hvLtV6bTGQZmSpEZtU5TJTqBDroOQB1hZF1DSyc8DYcD8iDPK1KlmoD7a1JPWch90/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144160; c=relaxed/simple;
	bh=+PATiQMZg3jfBfsEB846TxCO28spQZnhbrrvoFGY450=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TbLlEZZCseDS0/xl966mDtFF/Ixef4ouB7Ww+vvEX8XLF52s5dnV83rVukY4VBYdo2LN8/NPE4ta/CLO8qroLSqc2SczUIRJ7VfjEwMhtf/0tHoHtGKAJ0XCB3iklewS0ddb+nhdljx6PgzYysRTpVzex0Gonb61X1iQZDsRTsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D9AF15A1;
	Fri, 26 Apr 2024 08:09:46 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39C6D3F73F;
	Fri, 26 Apr 2024 08:09:15 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	Peter Newman <peternewman@google.com>,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH v2 02/35] x86/resctrl: Add a helper to avoid reaching into the arch code resource list
Date: Fri, 26 Apr 2024 16:08:31 +0100
Message-Id: <20240426150904.8854-2-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426150904.8854-1-Dave.Martin@arm.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
 <20240426150904.8854-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

Resctrl occasionally wants to know something about a specific resource,
in these cases it reaches into the arch code's rdt_resources_all[]
array.

Once the filesystem parts of resctrl are moved to /fs/, this means it
will need visibility of the architecture specific struct
rdt_hw_resource definition, and the array of all resources.  All
architectures would also need a r_resctrl member in this struct.

Instead, abstract this via a helper to allow architectures to do
different things here. Move the level enum to the resctrl header and
add a helper to retrieve the struct rdt_resource by 'rid'.

resctrl_arch_get_resource() should not return NULL for any value in
the enum, it may instead return a dummy resource that is
!alloc_enabled && !mon_enabled.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

FYI: David Hildenbrand <david@redhat.com>

 * Dropped your Reviewed-by due to changes in the patch.

   Are you happy for it to be reapplied?

Changes in v2:

 * Backed out non-functional renaming of "r" to "l3" in rdt_get_tree(),
   and unhoisted the assignment of r (as now is) back into the if ()
   where it started out.  There seem to be no uses of this variable
   outside this if().

 * [Commit message only] Typo fix:
   s/resctrl_hw_resource/rdt_hw_resource/g
---
 arch/x86/kernel/cpu/resctrl/core.c        | 10 +++++++++-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h    | 10 ----------
 arch/x86/kernel/cpu/resctrl/monitor.c     |  8 ++++----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 12 ++++++------
 include/linux/resctrl.h                   | 17 +++++++++++++++++
 6 files changed, 37 insertions(+), 22 deletions(-)

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
index 1767c1affa60..47234562a1dd 100644
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
@@ -2701,7 +2701,7 @@ static int rdt_get_tree(struct fs_context *fc)
 		resctrl_mounted = true;
 
 	if (is_mbm_enabled()) {
-		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+		r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 		list_for_each_entry(dom, &r->domains, list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
 						   RESCTRL_PICK_ANY_CPU);
@@ -3878,7 +3878,7 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
 		seq_puts(seq, ",cdpl2");
 
-	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
+	if (is_mba_sc(resctrl_arch_get_resource(RDT_RESOURCE_MBA)))
 		seq_puts(seq, ",mba_MBps");
 
 	if (resctrl_debug)
@@ -4068,7 +4068,7 @@ static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
 
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
2.34.1



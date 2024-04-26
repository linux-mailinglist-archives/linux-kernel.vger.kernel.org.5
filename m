Return-Path: <linux-kernel+bounces-160231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E868B3AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852AC281DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9191D14A4D6;
	Fri, 26 Apr 2024 15:09:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F62C15D5CF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144197; cv=none; b=RCA8fjQxJBTqxzVEaCDXZ508Wg9EtE3XIGfe4YIoHNsP3bwuWLZ5i8JgFAj4csbY34vkDLmgqn4X15xNzdOC+S/mtytxvdO+7XBheleFL2XM4Lvfi2BeecNFhsq/mp9KtaYKVy6auubI3SrBY4Wo1emY3EXQzgc+FwqmIBvyJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144197; c=relaxed/simple;
	bh=lngTacJCtCMXKjw2d2z4MV+NpYoPtftQtyULglSJbDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kO5Yfk783xWfE+xe2RFsp+V2aduBaaEtkdftiqO6/zyjP/rGb2mhw1tyMMV3qV8YwA5mLlOPfoQbLRiqxKXOjnVWVKW+M//PshLI1ibNvQb0fusZlu2sdxPCUl4hsk8Vs6TOyMiyYBSAf/86nnxdw52848kIKU0R0BrKurQC1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C4F71596;
	Fri, 26 Apr 2024 08:10:23 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E8D73F73F;
	Fri, 26 Apr 2024 08:09:52 -0700 (PDT)
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
Subject: [PATCH v2 14/35] x86/resctrl: Export the is_mbm_*_enabled() helpers to asm/resctrl.h
Date: Fri, 26 Apr 2024 16:08:43 +0100
Message-Id: <20240426150904.8854-14-Dave.Martin@arm.com>
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

The architecture specific parts of resctrl have helpers to hide accesses
to the rdt_mon_features bitmap.

Once the filesystem parts of resctrl are moved, these can no longer live
in internal.h. Once these are exposed to the wider kernel, they should
have a 'resctrl_arch_' prefix, to fit the rest of the arch<->fs interface.

Move and rename the helpers that touch rdt_mon_features directly.
is_mbm_event() and is_mbm_enabled() are only called from rdtgroup.c,
so can be moved into that file.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes in v2:

 * Realphabetise inserted #include (since the neighbouring #includes
   appear unrelated and unlikely to conflict).

   No functional change.
---
 arch/x86/include/asm/resctrl.h         | 17 +++++++++++
 arch/x86/kernel/cpu/resctrl/core.c     |  4 +--
 arch/x86/kernel/cpu/resctrl/internal.h | 27 -----------------
 arch/x86/kernel/cpu/resctrl/monitor.c  | 18 ++++++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 40 +++++++++++++++++---------
 5 files changed, 54 insertions(+), 52 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 5f6a5375bb4a..c69241447cc2 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -6,6 +6,7 @@
 
 #include <linux/jump_label.h>
 #include <linux/percpu.h>
+#include <linux/resctrl_types.h>
 #include <linux/sched.h>
 
 /*
@@ -43,6 +44,7 @@ DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
 
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
+extern unsigned int rdt_mon_features;
 
 DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
@@ -82,6 +84,21 @@ static inline void resctrl_arch_disable_mon(void)
 	static_branch_dec_cpuslocked(&rdt_enable_key);
 }
 
+static inline bool resctrl_arch_is_llc_occupancy_enabled(void)
+{
+	return (rdt_mon_features & (1 << QOS_L3_OCCUP_EVENT_ID));
+}
+
+static inline bool resctrl_arch_is_mbm_total_enabled(void)
+{
+	return (rdt_mon_features & (1 << QOS_L3_MBM_TOTAL_EVENT_ID));
+}
+
+static inline bool resctrl_arch_is_mbm_local_enabled(void)
+{
+	return (rdt_mon_features & (1 << QOS_L3_MBM_LOCAL_EVENT_ID));
+}
+
 /*
  * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
  *
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 9551ca4a6480..a4b5ade6e291 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -481,13 +481,13 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
 {
 	size_t tsize;
 
-	if (is_mbm_total_enabled()) {
+	if (resctrl_arch_is_mbm_total_enabled()) {
 		tsize = sizeof(*hw_dom->arch_mbm_total);
 		hw_dom->arch_mbm_total = kcalloc(num_rmid, tsize, GFP_KERNEL);
 		if (!hw_dom->arch_mbm_total)
 			return -ENOMEM;
 	}
-	if (is_mbm_local_enabled()) {
+	if (resctrl_arch_is_mbm_local_enabled()) {
 		tsize = sizeof(*hw_dom->arch_mbm_local);
 		hw_dom->arch_mbm_local = kcalloc(num_rmid, tsize, GFP_KERNEL);
 		if (!hw_dom->arch_mbm_local) {
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 01fcd4ef26ca..edbccc79246f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -130,7 +130,6 @@ struct rmid_read {
 	void			*arch_mon_ctx;
 };
 
-extern unsigned int rdt_mon_features;
 extern struct list_head resctrl_schema_all;
 extern bool resctrl_mounted;
 
@@ -360,32 +359,6 @@ struct msr_param {
 	u32			high;
 };
 
-static inline bool is_llc_occupancy_enabled(void)
-{
-	return (rdt_mon_features & (1 << QOS_L3_OCCUP_EVENT_ID));
-}
-
-static inline bool is_mbm_total_enabled(void)
-{
-	return (rdt_mon_features & (1 << QOS_L3_MBM_TOTAL_EVENT_ID));
-}
-
-static inline bool is_mbm_local_enabled(void)
-{
-	return (rdt_mon_features & (1 << QOS_L3_MBM_LOCAL_EVENT_ID));
-}
-
-static inline bool is_mbm_enabled(void)
-{
-	return (is_mbm_total_enabled() || is_mbm_local_enabled());
-}
-
-static inline bool is_mbm_event(int e)
-{
-	return (e >= QOS_L3_MBM_TOTAL_EVENT_ID &&
-		e <= QOS_L3_MBM_LOCAL_EVENT_ID);
-}
-
 /**
  * struct rdt_hw_resource - arch private attributes of a resctrl resource
  * @r_resctrl:		Attributes of the resource used directly by resctrl.
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c55d84d86013..f38e3590f860 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -251,11 +251,11 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d)
 {
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 
-	if (is_mbm_total_enabled())
+	if (resctrl_arch_is_mbm_total_enabled())
 		memset(hw_dom->arch_mbm_total, 0,
 		       sizeof(*hw_dom->arch_mbm_total) * r->num_rmid);
 
-	if (is_mbm_local_enabled())
+	if (resctrl_arch_is_mbm_local_enabled())
 		memset(hw_dom->arch_mbm_local, 0,
 		       sizeof(*hw_dom->arch_mbm_local) * r->num_rmid);
 }
@@ -514,7 +514,7 @@ void free_rmid(u32 closid, u32 rmid)
 
 	entry = __rmid_entry(idx);
 
-	if (is_llc_occupancy_enabled())
+	if (resctrl_arch_is_llc_occupancy_enabled())
 		add_rmid_to_limbo(entry);
 	else
 		list_add_tail(&entry->list, &rmid_free_lru);
@@ -666,7 +666,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	struct list_head *head;
 	struct rdtgroup *entry;
 
-	if (!is_mbm_local_enabled())
+	if (!resctrl_arch_is_mbm_local_enabled())
 		return;
 
 	r_mba = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
@@ -735,7 +735,7 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
 	 * This is protected from concurrent reads from user
 	 * as both the user and we hold the global mutex.
 	 */
-	if (is_mbm_total_enabled()) {
+	if (resctrl_arch_is_mbm_total_enabled()) {
 		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
 		rr.val = 0;
 		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
@@ -749,7 +749,7 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
 
 		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
 	}
-	if (is_mbm_local_enabled()) {
+	if (resctrl_arch_is_mbm_local_enabled()) {
 		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
 		rr.val = 0;
 		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
@@ -997,11 +997,11 @@ static void l3_mon_evt_init(struct rdt_resource *r)
 {
 	INIT_LIST_HEAD(&r->evt_list);
 
-	if (is_llc_occupancy_enabled())
+	if (resctrl_arch_is_llc_occupancy_enabled())
 		list_add_tail(&llc_occupancy_event.list, &r->evt_list);
-	if (is_mbm_total_enabled())
+	if (resctrl_arch_is_mbm_total_enabled())
 		list_add_tail(&mbm_total_event.list, &r->evt_list);
-	if (is_mbm_local_enabled())
+	if (resctrl_arch_is_mbm_local_enabled())
 		list_add_tail(&mbm_local_event.list, &r->evt_list);
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d678fe2a2142..60fcd5ca716f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -114,6 +114,18 @@ void rdt_staged_configs_clear(void)
 	}
 }
 
+static bool resctrl_is_mbm_enabled(void)
+{
+	return (resctrl_arch_is_mbm_total_enabled() ||
+		resctrl_arch_is_mbm_local_enabled());
+}
+
+static bool resctrl_is_mbm_event(int e)
+{
+	return (e >= QOS_L3_MBM_TOTAL_EVENT_ID &&
+		e <= QOS_L3_MBM_LOCAL_EVENT_ID);
+}
+
 /*
  * Trivial allocator for CLOSIDs. Since h/w only supports a small number,
  * we can keep a bitmap of free CLOSIDs in a single integer.
@@ -161,7 +173,7 @@ static int closid_alloc(void)
 	lockdep_assert_held(&rdtgroup_mutex);
 
 	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
-	    is_llc_occupancy_enabled()) {
+	    resctrl_arch_is_llc_occupancy_enabled()) {
 		cleanest_closid = resctrl_find_cleanest_closid();
 		if (cleanest_closid < 0)
 			return cleanest_closid;
@@ -2368,7 +2380,7 @@ static bool supports_mba_mbps(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 
-	return (is_mbm_local_enabled() &&
+	return (resctrl_arch_is_mbm_local_enabled() &&
 		r->alloc_capable && is_mba_linear());
 }
 
@@ -2736,7 +2748,7 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (resctrl_arch_alloc_capable() || resctrl_arch_mon_capable())
 		resctrl_mounted = true;
 
-	if (is_mbm_enabled()) {
+	if (resctrl_is_mbm_enabled()) {
 		r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 		list_for_each_entry(dom, &r->domains, list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
@@ -3106,7 +3118,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 		if (ret)
 			goto out_destroy;
 
-		if (is_mbm_event(mevt->evtid))
+		if (resctrl_is_mbm_event(mevt->evtid))
 			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);
 	}
 	kernfs_activate(kn);
@@ -4008,9 +4020,9 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 	if (resctrl_mounted && resctrl_arch_mon_capable())
 		rmdir_mondata_subdir_allrdtgrp(r, d->id);
 
-	if (is_mbm_enabled())
+	if (resctrl_is_mbm_enabled())
 		cancel_delayed_work(&d->mbm_over);
-	if (is_llc_occupancy_enabled() && has_busy_rmid(d)) {
+	if (resctrl_arch_is_llc_occupancy_enabled() && has_busy_rmid(d)) {
 		/*
 		 * When a package is going down, forcefully
 		 * decrement rmid->ebusy. There is no way to know
@@ -4034,12 +4046,12 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	size_t tsize;
 
-	if (is_llc_occupancy_enabled()) {
+	if (resctrl_arch_is_llc_occupancy_enabled()) {
 		d->rmid_busy_llc = bitmap_zalloc(idx_limit, GFP_KERNEL);
 		if (!d->rmid_busy_llc)
 			return -ENOMEM;
 	}
-	if (is_mbm_total_enabled()) {
+	if (resctrl_arch_is_mbm_total_enabled()) {
 		tsize = sizeof(*d->mbm_total);
 		d->mbm_total = kcalloc(idx_limit, tsize, GFP_KERNEL);
 		if (!d->mbm_total) {
@@ -4047,7 +4059,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 			return -ENOMEM;
 		}
 	}
-	if (is_mbm_local_enabled()) {
+	if (resctrl_arch_is_mbm_local_enabled()) {
 		tsize = sizeof(*d->mbm_local);
 		d->mbm_local = kcalloc(idx_limit, tsize, GFP_KERNEL);
 		if (!d->mbm_local) {
@@ -4079,13 +4091,13 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 	if (err)
 		goto out_unlock;
 
-	if (is_mbm_enabled()) {
+	if (resctrl_is_mbm_enabled()) {
 		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
 		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL,
 					   RESCTRL_PICK_ANY_CPU);
 	}
 
-	if (is_llc_occupancy_enabled())
+	if (resctrl_arch_is_llc_occupancy_enabled())
 		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
 
 	/*
@@ -4140,12 +4152,12 @@ void resctrl_offline_cpu(unsigned int cpu)
 
 	d = get_domain_from_cpu(cpu, l3);
 	if (d) {
-		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
+		if (resctrl_is_mbm_enabled() && cpu == d->mbm_work_cpu) {
 			cancel_delayed_work(&d->mbm_over);
 			mbm_setup_overflow_handler(d, 0, cpu);
 		}
-		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
-		    has_busy_rmid(d)) {
+		if (resctrl_arch_is_llc_occupancy_enabled() &&
+		    cpu == d->cqm_work_cpu && has_busy_rmid(d)) {
 			cancel_delayed_work(&d->cqm_limbo);
 			cqm_setup_limbo_handler(d, 0, cpu);
 		}
-- 
2.34.1



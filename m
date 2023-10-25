Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFB57D72DA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjJYSFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbjJYSFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:05:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F5349D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:05:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69FC2C15;
        Wed, 25 Oct 2023 11:05:41 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05E2A3F738;
        Wed, 25 Oct 2023 11:04:56 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
Subject: [PATCH v7 06/24] x86/resctrl: Access per-rmid structures by index
Date:   Wed, 25 Oct 2023 18:03:27 +0000
Message-Id: <20231025180345.28061-7-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231025180345.28061-1-james.morse@arm.com>
References: <20231025180345.28061-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 systems identify traffic using the CLOSID and RMID. The CLOSID is
used to lookup the control policy, the RMID is used for monitoring. For
x86 these are independent numbers.
Arm's MPAM has equivalent features PARTID and PMG, where the PARTID is
used to lookup the control policy. The PMG in contrast is a small number
of bits that are used to subdivide PARTID when monitoring. The
cache-occupancy monitors require the PARTID to be specified when
monitoring.

This means MPAM's PMG field is not unique. There are multiple PMG-0, one
per allocated CLOSID/PARTID. If PMG is treated as equivalent to RMID, it
cannot be allocated as an independent number. Bitmaps like rmid_busy_llc
need to be sized by the number of unique entries for this resource.

Treat the combined CLOSID and RMID as an index, and provide architecture
helpers to pack and unpack an index. This makes the MPAM values unique.
The domain's rmid_busy_llc and rmid_ptrs[] are then sized by index, as
are domain mbm_local[] and mbm_total[].

x86 can ignore the CLOSID field when packing and unpacking an index, and
report as many indexes as RMID.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Added X86_BAD_CLOSID macro to make it clear what this value means
 * Added second WARN_ON() for closid checking, and made both _ONCE()

Changes since v2:
 * Added RESCTRL_RESERVED_CLOSID
 * Removed a newline
 * Repharsed some comments
 * Renamed a variable 'ignore'd
 * Moved X86_RESCTRL_BAD_CLOSID to a previous patch

Changes since v3:
 * Changed a variable name
 * Fixed various typos

Changes since v4:
 * Removed resource parameter from has_busy_rmid()
 * Rewrote commit message

Changes since v5:
 * Used RESCTRL_RESERVED_RMID in clear_closid_rmid().
 * Added comment against free_rmid()s index comparison tricks.

Changes since v6:
 * Added a newline between some #includes.
 * Juggled some plurals in a comment.
---
 arch/x86/include/asm/resctrl.h         | 17 +++++
 arch/x86/kernel/cpu/resctrl/core.c     |  5 +-
 arch/x86/kernel/cpu/resctrl/internal.h |  4 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 96 ++++++++++++++++++--------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  9 +--
 5 files changed, 94 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index cc6e1bce7b1a..db4c84dde2d5 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -101,6 +101,23 @@ static inline void resctrl_sched_in(struct task_struct *tsk)
 		__resctrl_sched_in(tsk);
 }
 
+static inline u32 resctrl_arch_system_num_rmid_idx(void)
+{
+	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
+	return boot_cpu_data.x86_cache_max_rmid + 1;
+}
+
+static inline void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
+{
+	*rmid = idx;
+	*closid = X86_RESCTRL_EMPTY_CLOSID;
+}
+
+static inline u32 resctrl_arch_rmid_idx_encode(u32 ignored, u32 rmid)
+{
+	return rmid;
+}
+
 void resctrl_cpu_detect(struct cpuinfo_x86 *c);
 
 #else
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 0056c9962a44..fc70a2650729 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -589,7 +589,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 			mbm_setup_overflow_handler(d, 0);
 		}
 		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
-		    has_busy_rmid(r, d)) {
+		    has_busy_rmid(d)) {
 			cancel_delayed_work(&d->cqm_limbo);
 			cqm_setup_limbo_handler(d, 0);
 		}
@@ -604,7 +604,8 @@ static void clear_closid_rmid(int cpu)
 	state->default_rmid = 0;
 	state->cur_closid = 0;
 	state->cur_rmid = 0;
-	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
+	wrmsr(MSR_IA32_PQR_ASSOC, RESCTRL_RESERVED_RMID,
+	      RESCTRL_RESERVED_CLOSID);
 }
 
 static int resctrl_online_cpu(unsigned int cpu)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c836e3294e12..97ec24f91ac4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -8,6 +8,8 @@
 #include <linux/fs_context.h>
 #include <linux/jump_label.h>
 
+#include <asm/resctrl.h>
+
 #define L3_QOS_CDP_ENABLE		0x01ULL
 
 #define L2_QOS_CDP_ENABLE		0x01ULL
@@ -560,7 +562,7 @@ void __init intel_rdt_mbm_apply_quirk(void);
 bool is_mba_sc(struct rdt_resource *r);
 void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
-bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
+bool has_busy_rmid(struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init thread_throttle_mode_init(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 2a0233cd0bc9..c02cf32cd17c 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -149,12 +149,29 @@ static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
 	return val;
 }
 
-static inline struct rmid_entry *__rmid_entry(u32 closid, u32 rmid)
+/*
+ * x86 and arm64 differ in their handling of monitoring.
+ * x86's RMID are independent numbers, there is only one source of traffic
+ * with an RMID value of '1'.
+ * arm64's PMG extends the PARTID/CLOSID space, there are multiple sources of
+ * traffic with a PMG value of '1', one for each CLOSID, meaning the RMID
+ * value is no longer unique.
+ * To account for this, resctrl uses an index. On x86 this is just the RMID,
+ * on arm64 it encodes the CLOSID and RMID. This gives a unique number.
+ *
+ * The domain's rmid_busy_llc and rmid_ptrs[] are sized by index. The arch code
+ * must accept an attempt to read every index.
+ */
+static inline struct rmid_entry *__rmid_entry(u32 idx)
 {
 	struct rmid_entry *entry;
+	u32 closid, rmid;
 
-	entry = &rmid_ptrs[rmid];
-	WARN_ON(entry->rmid != rmid);
+	entry = &rmid_ptrs[idx];
+	resctrl_arch_rmid_idx_decode(idx, &closid, &rmid);
+
+	WARN_ON_ONCE(entry->closid != closid);
+	WARN_ON_ONCE(entry->rmid != rmid);
 
 	return entry;
 }
@@ -284,8 +301,9 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 void __check_limbo(struct rdt_domain *d, bool force_free)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry;
-	u32 crmid = 1, nrmid;
+	u32 idx, cur_idx = 1;
 	bool rmid_dirty;
 	u64 val = 0;
 
@@ -296,12 +314,11 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 	 * RMID and move it to the free list when the counter reaches 0.
 	 */
 	for (;;) {
-		nrmid = find_next_bit(d->rmid_busy_llc, r->num_rmid, crmid);
-		if (nrmid >= r->num_rmid)
+		idx = find_next_bit(d->rmid_busy_llc, idx_limit, cur_idx);
+		if (idx >= idx_limit)
 			break;
 
-		entry = __rmid_entry(X86_RESCTRL_EMPTY_CLOSID, nrmid);// temporary
-
+		entry = __rmid_entry(idx);
 		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
 					   QOS_L3_OCCUP_EVENT_ID, &val)) {
 			rmid_dirty = true;
@@ -310,19 +327,21 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 		}
 
 		if (force_free || !rmid_dirty) {
-			clear_bit(entry->rmid, d->rmid_busy_llc);
+			clear_bit(idx, d->rmid_busy_llc);
 			if (!--entry->busy) {
 				rmid_limbo_count--;
 				list_add_tail(&entry->list, &rmid_free_lru);
 			}
 		}
-		crmid = nrmid + 1;
+		cur_idx = idx + 1;
 	}
 }
 
-bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)
+bool has_busy_rmid(struct rdt_domain *d)
 {
-	return find_first_bit(d->rmid_busy_llc, r->num_rmid) != r->num_rmid;
+	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
+
+	return find_first_bit(d->rmid_busy_llc, idx_limit) != idx_limit;
 }
 
 /*
@@ -352,6 +371,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	struct rdt_domain *d;
 	int cpu, err;
 	u64 val = 0;
+	u32 idx;
+
+	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
 
 	entry->busy = 0;
 	cpu = get_cpu();
@@ -369,9 +391,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 		 * For the first limbo RMID in the domain,
 		 * setup up the limbo worker.
 		 */
-		if (!has_busy_rmid(r, d))
+		if (!has_busy_rmid(d))
 			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL);
-		set_bit(entry->rmid, d->rmid_busy_llc);
+		set_bit(idx, d->rmid_busy_llc);
 		entry->busy++;
 	}
 	put_cpu();
@@ -384,14 +406,21 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 
 void free_rmid(u32 closid, u32 rmid)
 {
+	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
 	struct rmid_entry *entry;
 
-	if (!rmid)
-		return;
-
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	entry = __rmid_entry(closid, rmid);
+	/*
+	 * Do not allow the default rmid to be free'd. Comparing by index
+	 * allows architectures that ignore the closid parameter to avoid an
+	 * unnecessary check.
+	 */
+	if (idx == resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
+						RESCTRL_RESERVED_RMID))
+		return;
+
+	entry = __rmid_entry(idx);
 
 	if (is_llc_occupancy_enabled())
 		add_rmid_to_limbo(entry);
@@ -402,11 +431,13 @@ void free_rmid(u32 closid, u32 rmid)
 static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 closid,
 				       u32 rmid, enum resctrl_event_id evtid)
 {
+	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
+
 	switch (evtid) {
 	case QOS_L3_MBM_TOTAL_EVENT_ID:
-		return &d->mbm_total[rmid];
+		return &d->mbm_total[idx];
 	case QOS_L3_MBM_LOCAL_EVENT_ID:
-		return &d->mbm_local[rmid];
+		return &d->mbm_local[idx];
 	default:
 		return NULL;
 	}
@@ -449,7 +480,8 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
  */
 static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
 {
-	struct mbm_state *m = &rr->d->mbm_local[rmid];
+	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
+	struct mbm_state *m = &rr->d->mbm_local[idx];
 	u64 cur_bw, bytes, cur_bytes;
 
 	cur_bytes = rr->val;
@@ -539,7 +571,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 {
 	u32 closid, rmid, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
-	u32 cur_bw, delta_bw, user_bw;
+	u32 cur_bw, delta_bw, user_bw, idx;
 	struct rdt_resource *r_mba;
 	struct rdt_domain *dom_mba;
 	struct list_head *head;
@@ -552,7 +584,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
-	pmbm_data = &dom_mbm->mbm_local[rmid];
+	idx = resctrl_arch_rmid_idx_encode(closid, rmid);
+	pmbm_data = &dom_mbm->mbm_local[idx];
 
 	dom_mba = get_domain_from_cpu(smp_processor_id(), r_mba);
 	if (!dom_mba) {
@@ -670,7 +703,7 @@ void cqm_handle_limbo(struct work_struct *work)
 
 	__check_limbo(d, false);
 
-	if (has_busy_rmid(r, d))
+	if (has_busy_rmid(d))
 		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
 
 	mutex_unlock(&rdtgroup_mutex);
@@ -735,19 +768,20 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
 
 static int dom_data_init(struct rdt_resource *r)
 {
+	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry = NULL;
-	int i, nr_rmids;
+	u32 idx;
+	int i;
 
-	nr_rmids = r->num_rmid;
-	rmid_ptrs = kcalloc(nr_rmids, sizeof(struct rmid_entry), GFP_KERNEL);
+	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
 	if (!rmid_ptrs)
 		return -ENOMEM;
 
-	for (i = 0; i < nr_rmids; i++) {
+	for (i = 0; i < idx_limit; i++) {
 		entry = &rmid_ptrs[i];
 		INIT_LIST_HEAD(&entry->list);
 
-		entry->rmid = i;
+		resctrl_arch_rmid_idx_decode(i, &entry->closid, &entry->rmid);
 		list_add_tail(&entry->list, &rmid_free_lru);
 	}
 
@@ -755,7 +789,9 @@ static int dom_data_init(struct rdt_resource *r)
 	* These are used for rdtgroup_default control group, which will be
 	* setup later in rdtgroup_init().
 	*/
-	entry = __rmid_entry(RESCTRL_RESERVED_CLOSID, RESCTRL_RESERVED_RMID);
+	idx = resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
+					   RESCTRL_RESERVED_RMID);
+	entry = __rmid_entry(idx);
 	list_del(&entry->list);
 
 	return 0;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f64c13fe22d7..22dbdfe569a1 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3894,7 +3894,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 
 	if (is_mbm_enabled())
 		cancel_delayed_work(&d->mbm_over);
-	if (is_llc_occupancy_enabled() && has_busy_rmid(r, d)) {
+	if (is_llc_occupancy_enabled() && has_busy_rmid(d)) {
 		/*
 		 * When a package is going down, forcefully
 		 * decrement rmid->ebusy. There is no way to know
@@ -3912,16 +3912,17 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 
 static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 {
+	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	size_t tsize;
 
 	if (is_llc_occupancy_enabled()) {
-		d->rmid_busy_llc = bitmap_zalloc(r->num_rmid, GFP_KERNEL);
+		d->rmid_busy_llc = bitmap_zalloc(idx_limit, GFP_KERNEL);
 		if (!d->rmid_busy_llc)
 			return -ENOMEM;
 	}
 	if (is_mbm_total_enabled()) {
 		tsize = sizeof(*d->mbm_total);
-		d->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
+		d->mbm_total = kcalloc(idx_limit, tsize, GFP_KERNEL);
 		if (!d->mbm_total) {
 			bitmap_free(d->rmid_busy_llc);
 			return -ENOMEM;
@@ -3929,7 +3930,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 	}
 	if (is_mbm_local_enabled()) {
 		tsize = sizeof(*d->mbm_local);
-		d->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
+		d->mbm_local = kcalloc(idx_limit, tsize, GFP_KERNEL);
 		if (!d->mbm_local) {
 			bitmap_free(d->rmid_busy_llc);
 			kfree(d->mbm_total);
-- 
2.39.2


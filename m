Return-Path: <linux-kernel+bounces-64096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AA7853A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE717B26008
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDBD171A5;
	Tue, 13 Feb 2024 18:45:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DA660B9C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849921; cv=none; b=hGL6DUTUfQfbSAKMcDKrI+8ymxF0YsyivutDXlQ5Dwod2FWiL14MtIaqEchzW1hBlXhuJ4LKarDTFH+3PG7SFfrWLnIg9FhTAJFg4E8Qe1h2dReAEfOcqK8CQWIP4tF3N1hhrkZ31oQhQGYJk6TDx7tIUQK8ZyFoFWPy9hyKgAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849921; c=relaxed/simple;
	bh=+cI0zo69QHig7B+XUzI4+SP7IUCyYfDOcVRw0taJjdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VUXpBRa0sjSmQ2hevmZYNLTRu+a1JRI7XsvN13m21ZcFR9xVNQDGh7xGtTZs6l7scq5cwQun1CkL9WyIazuWuoIHBhkrtg3F2fIIe3gUG+cm+1Txh0Qe2u9gGSHd9NhwdQxVFYcHJ9IEISouZuF3zvlefrlDLRQjkCOkXsAapD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED9AB143D;
	Tue, 13 Feb 2024 10:45:59 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76F643F766;
	Tue, 13 Feb 2024 10:45:15 -0800 (PST)
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
	Babu Moger <babu.moger@amd.com>
Subject: [PATCH v9 05/24] x86/resctrl: Track the closid with the rmid
Date: Tue, 13 Feb 2024 18:44:19 +0000
Message-Id: <20240213184438.16675-6-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240213184438.16675-1-james.morse@arm.com>
References: <20240213184438.16675-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86's RMID are independent of the CLOSID. An RMID can be allocated,
used and freed without considering the CLOSID.

MPAM's equivalent feature is PMG, which is not an independent number,
it extends the CLOSID/PARTID space. For MPAM, only PMG-bits worth of
'RMID' can be allocated for a single CLOSID.
i.e. if there is 1 bit of PMG space, then each CLOSID can have two
monitor groups.

To allow resctrl to disambiguate RMID values for different CLOSID,
everything in resctrl that keeps an RMID value needs to know the CLOSID
too. This will always be ignored on x86.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

---
Is there a better term for 'the unique identifier for a monitor group'.
Using RMID for that here may be confusing...

Changes since v1:
 * Added comment in struct rmid_entry

Changes since v2:
 * Moved X86_RESCTRL_BAD_CLOSID from a subsequent patch

Chances since v3:
 * Renamed X86_RESCTRL_BAD_CLOSID to EMPTY
 * Clarified a few comments and kernel-doc

Changes since v5:
 * Use entry->closid from the iterator, instead of the parent control group.
 * Move the reserved defines into this patch to reduce the churn.
 * Added some kernel doc.
 * Renamed some arch closid parameters as 'unused'.

Changes since v6:
 * Changes to comments.

Changes since v7:
 * Changes to comments.
---
 arch/x86/include/asm/resctrl.h            |  7 +++
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c     | 73 +++++++++++++++--------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 12 ++--
 include/linux/resctrl.h                   | 16 ++++-
 6 files changed, 77 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 255a78d9d906..cc6e1bce7b1a 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -7,6 +7,13 @@
 #include <linux/sched.h>
 #include <linux/jump_label.h>
 
+/*
+ * This value can never be a valid CLOSID, and is used when mapping a
+ * (closid, rmid) pair to an index and back. On x86 only the RMID is
+ * needed. The index is a software defined value.
+ */
+#define X86_RESCTRL_EMPTY_CLOSID         ((u32)~0)
+
 /**
  * struct resctrl_pqr_state - State cache for the PQR MSR
  * @cur_rmid:		The cached Resource Monitoring ID
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 61c763604fc9..ae0e3338abc4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -542,7 +542,7 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int closids_supported(void);
 void closid_free(int closid);
 int alloc_rmid(void);
-void free_rmid(u32 rmid);
+void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
 void __exit rdt_put_mon_l3_config(void);
 bool __init rdt_cpu_has(int flag);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 3a73db0579d8..3dad4134d2c9 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -24,7 +24,20 @@
 
 #include "internal.h"
 
+/**
+ * struct rmid_entry - dirty tracking for all RMID.
+ * @closid:	The CLOSID for this entry.
+ * @rmid:	The RMID for this entry.
+ * @busy:	The number of domains with cached data using this RMID.
+ * @list:	Member of the rmid_free_lru list when busy == 0.
+ *
+ * Depending on the architecture the correct monitor is accessed using
+ * both @closid and @rmid, or @rmid only.
+ *
+ * Take the rdtgroup_mutex when accessing.
+ */
 struct rmid_entry {
+	u32				closid;
 	u32				rmid;
 	int				busy;
 	struct list_head		list;
@@ -136,7 +149,7 @@ static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
 	return val;
 }
 
-static inline struct rmid_entry *__rmid_entry(u32 rmid)
+static inline struct rmid_entry *__rmid_entry(u32 closid, u32 rmid)
 {
 	struct rmid_entry *entry;
 
@@ -190,7 +203,8 @@ static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
 }
 
 void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
-			     u32 rmid, enum resctrl_event_id eventid)
+			     u32 unused, u32 rmid,
+			     enum resctrl_event_id eventid)
 {
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct arch_mbm_state *am;
@@ -230,7 +244,8 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 }
 
 int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
-			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
+			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
+			   u64 *val)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
@@ -285,9 +300,9 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 		if (nrmid >= r->num_rmid)
 			break;
 
-		entry = __rmid_entry(nrmid);
+		entry = __rmid_entry(X86_RESCTRL_EMPTY_CLOSID, nrmid);// temporary
 
-		if (resctrl_arch_rmid_read(r, d, entry->rmid,
+		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
 					   QOS_L3_OCCUP_EVENT_ID, &val)) {
 			rmid_dirty = true;
 		} else {
@@ -342,7 +357,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	cpu = get_cpu();
 	list_for_each_entry(d, &r->domains, list) {
 		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
-			err = resctrl_arch_rmid_read(r, d, entry->rmid,
+			err = resctrl_arch_rmid_read(r, d, entry->closid,
+						     entry->rmid,
 						     QOS_L3_OCCUP_EVENT_ID,
 						     &val);
 			if (err || val <= resctrl_rmid_realloc_threshold)
@@ -366,7 +382,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 		list_add_tail(&entry->list, &rmid_free_lru);
 }
 
-void free_rmid(u32 rmid)
+void free_rmid(u32 closid, u32 rmid)
 {
 	struct rmid_entry *entry;
 
@@ -375,7 +391,7 @@ void free_rmid(u32 rmid)
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	entry = __rmid_entry(rmid);
+	entry = __rmid_entry(closid, rmid);
 
 	if (is_llc_occupancy_enabled())
 		add_rmid_to_limbo(entry);
@@ -383,8 +399,8 @@ void free_rmid(u32 rmid)
 		list_add_tail(&entry->list, &rmid_free_lru);
 }
 
-static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 rmid,
-				       enum resctrl_event_id evtid)
+static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 closid,
+				       u32 rmid, enum resctrl_event_id evtid)
 {
 	switch (evtid) {
 	case QOS_L3_MBM_TOTAL_EVENT_ID:
@@ -396,20 +412,21 @@ static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 rmid,
 	}
 }
 
-static int __mon_event_count(u32 rmid, struct rmid_read *rr)
+static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 {
 	struct mbm_state *m;
 	u64 tval = 0;
 
 	if (rr->first) {
-		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
-		m = get_mbm_state(rr->d, rmid, rr->evtid);
+		resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
+		m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
 		if (m)
 			memset(m, 0, sizeof(struct mbm_state));
 		return 0;
 	}
 
-	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, rmid, rr->evtid, &tval);
+	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid, rr->evtid,
+					 &tval);
 	if (rr->err)
 		return rr->err;
 
@@ -421,6 +438,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 /*
  * mbm_bw_count() - Update bw count from values previously read by
  *		    __mon_event_count().
+ * @closid:	The closid used to identify the cached mbm_state.
  * @rmid:	The rmid used to identify the cached mbm_state.
  * @rr:		The struct rmid_read populated by __mon_event_count().
  *
@@ -429,7 +447,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
  * __mon_event_count() is compared with the chunks value from the previous
  * invocation. This must be called once per second to maintain values in MBps.
  */
-static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
+static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
 {
 	struct mbm_state *m = &rr->d->mbm_local[rmid];
 	u64 cur_bw, bytes, cur_bytes;
@@ -456,7 +474,7 @@ void mon_event_count(void *info)
 
 	rdtgrp = rr->rgrp;
 
-	ret = __mon_event_count(rdtgrp->mon.rmid, rr);
+	ret = __mon_event_count(rdtgrp->closid, rdtgrp->mon.rmid, rr);
 
 	/*
 	 * For Ctrl groups read data from child monitor groups and
@@ -467,7 +485,8 @@ void mon_event_count(void *info)
 
 	if (rdtgrp->type == RDTCTRL_GROUP) {
 		list_for_each_entry(entry, head, mon.crdtgrp_list) {
-			if (__mon_event_count(entry->mon.rmid, rr) == 0)
+			if (__mon_event_count(entry->closid, entry->mon.rmid,
+					      rr) == 0)
 				ret = 0;
 		}
 	}
@@ -578,7 +597,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	resctrl_arch_update_one(r_mba, dom_mba, closid, CDP_NONE, new_msr_val);
 }
 
-static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
+static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
+		       u32 closid, u32 rmid)
 {
 	struct rmid_read rr;
 
@@ -593,12 +613,12 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
 	if (is_mbm_total_enabled()) {
 		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
 		rr.val = 0;
-		__mon_event_count(rmid, &rr);
+		__mon_event_count(closid, rmid, &rr);
 	}
 	if (is_mbm_local_enabled()) {
 		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
 		rr.val = 0;
-		__mon_event_count(rmid, &rr);
+		__mon_event_count(closid, rmid, &rr);
 
 		/*
 		 * Call the MBA software controller only for the
@@ -606,7 +626,7 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
 		 * the software controller explicitly.
 		 */
 		if (is_mba_sc(NULL))
-			mbm_bw_count(rmid, &rr);
+			mbm_bw_count(closid, rmid, &rr);
 	}
 }
 
@@ -663,11 +683,11 @@ void mbm_handle_overflow(struct work_struct *work)
 	d = container_of(work, struct rdt_domain, mbm_over.work);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		mbm_update(r, d, prgrp->mon.rmid);
+		mbm_update(r, d, prgrp->closid, prgrp->mon.rmid);
 
 		head = &prgrp->mon.crdtgrp_list;
 		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
-			mbm_update(r, d, crgrp->mon.rmid);
+			mbm_update(r, d, crgrp->closid, crgrp->mon.rmid);
 
 		if (is_mba_sc(NULL))
 			update_mba_bw(prgrp, d);
@@ -710,10 +730,11 @@ static int dom_data_init(struct rdt_resource *r)
 	}
 
 	/*
-	 * RMID 0 is special and is always allocated. It's used for all
-	 * tasks that are not monitored.
+	 * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are special and
+	 * are always allocated. These are used for the rdtgroup_default
+	 * control group, which will be setup later in rdtgroup_init().
 	 */
-	entry = __rmid_entry(0);
+	entry = __rmid_entry(RESCTRL_RESERVED_CLOSID, RESCTRL_RESERVED_RMID);
 	list_del(&entry->list);
 
 	return 0;
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 8f559eeae08e..65bee6f11015 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -752,7 +752,7 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
 	 * anymore when this group would be used for pseudo-locking. This
 	 * is safe to call on platforms not capable of monitoring.
 	 */
-	free_rmid(rdtgrp->mon.rmid);
+	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 	ret = 0;
 	goto out;
@@ -787,7 +787,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
 
 	ret = rdtgroup_locksetup_user_restore(rdtgrp);
 	if (ret) {
-		free_rmid(rdtgrp->mon.rmid);
+		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 		return ret;
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f455a10b74ab..ad7da7254f4d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2837,7 +2837,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
 
 	head = &rdtgrp->mon.crdtgrp_list;
 	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
-		free_rmid(sentry->mon.rmid);
+		free_rmid(sentry->closid, sentry->mon.rmid);
 		list_del(&sentry->mon.crdtgrp_list);
 
 		if (atomic_read(&sentry->waitcount) != 0)
@@ -2877,7 +2877,7 @@ static void rmdir_all_sub(void)
 		cpumask_or(&rdtgroup_default.cpu_mask,
 			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
 
-		free_rmid(rdtgrp->mon.rmid);
+		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 		kernfs_remove(rdtgrp->kn);
 		list_del(&rdtgrp->rdtgroup_list);
@@ -3305,7 +3305,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
 	if (ret) {
 		rdt_last_cmd_puts("kernfs subdir error\n");
-		free_rmid(rdtgrp->mon.rmid);
+		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 		return ret;
 	}
 
@@ -3315,7 +3315,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
 {
 	if (rdt_mon_capable)
-		free_rmid(rgrp->mon.rmid);
+		free_rmid(rgrp->closid, rgrp->mon.rmid);
 }
 
 static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
@@ -3574,7 +3574,7 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	update_closid_rmid(tmpmask, NULL);
 
 	rdtgrp->flags = RDT_DELETED;
-	free_rmid(rdtgrp->mon.rmid);
+	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 	/*
 	 * Remove the rdtgrp from the parent ctrl_mon group's list
@@ -3620,8 +3620,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
 	update_closid_rmid(tmpmask, NULL);
 
+	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 	closid_free(rdtgrp->closid);
-	free_rmid(rdtgrp->mon.rmid);
 
 	rdtgroup_ctrl_remove(rdtgrp);
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 66942d7fba7f..bd4ec22b5a96 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -6,6 +6,10 @@
 #include <linux/list.h>
 #include <linux/pid.h>
 
+/* CLOSID, RMID value used by the default control group */
+#define RESCTRL_RESERVED_CLOSID		0
+#define RESCTRL_RESERVED_RMID		0
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 int proc_resctrl_show(struct seq_file *m,
@@ -225,6 +229,9 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
  *			      for this resource and domain.
  * @r:			resource that the counter should be read from.
  * @d:			domain that the counter should be read from.
+ * @closid:		closid that matches the rmid. Depending on the architecture, the
+ *			counter may match traffic of both @closid and @rmid, or @rmid
+ *			only.
  * @rmid:		rmid of the counter to read.
  * @eventid:		eventid to read, e.g. L3 occupancy.
  * @val:		result of the counter read in bytes.
@@ -235,20 +242,25 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
  * 0 on success, or -EIO, -EINVAL etc on error.
  */
 int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
-			   u32 rmid, enum resctrl_event_id eventid, u64 *val);
+			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
+			   u64 *val);
+
 
 /**
  * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
  *			       and eventid.
  * @r:		The domain's resource.
  * @d:		The rmid's domain.
+ * @closid:	closid that matches the rmid. Depending on the architecture, the
+ *		counter may match traffic of both @closid and @rmid, or @rmid only.
  * @rmid:	The rmid whose counter values should be reset.
  * @eventid:	The eventid whose counter values should be reset.
  *
  * This can be called from any CPU.
  */
 void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
-			     u32 rmid, enum resctrl_event_id eventid);
+			     u32 closid, u32 rmid,
+			     enum resctrl_event_id eventid);
 
 /**
  * resctrl_arch_reset_rmid_all() - Reset all private state associated with
-- 
2.39.2



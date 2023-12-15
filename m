Return-Path: <linux-kernel+bounces-1447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CE5814F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDDF1F25936
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF5C47F72;
	Fri, 15 Dec 2023 17:44:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F294777D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A2DB1650;
	Fri, 15 Dec 2023 09:45:12 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A2853F5A1;
	Fri, 15 Dec 2023 09:44:24 -0800 (PST)
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
	Babu Moger <babu.moger@amd.com>
Subject: [PATCH v8 08/24] x86/resctrl: Track the number of dirty RMID a CLOSID has
Date: Fri, 15 Dec 2023 17:43:27 +0000
Message-Id: <20231215174343.13872-9-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231215174343.13872-1-james.morse@arm.com>
References: <20231215174343.13872-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
used for different control groups.

This means once a CLOSID is allocated, all its monitoring ids may still be
dirty, and held in limbo.

Keep track of the number of RMID held in limbo each CLOSID has. This will
allow a future helper to find the 'cleanest' CLOSID when allocating.

The array is only needed when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is
defined. This will never be the case on x86.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since v4:
 * Moved closid_num_dirty_rmid[] update under entry->busy check
 * Take the mutex in dom_data_init() as the caller doesn't.

Changes since v5:
 * Added braces after an else.
 * Made closid_num_dirty_rmid an unsigned int.
 * Moved mutex_lock() in dom_data_init() to cover the whole function.

Changes since v6:
 * Made closid_num_dirty_rmid[] and associated tmp variables u32.

Changes since v7:
 * Clobber kfree()d variable with NULL.
 * Guard the use of closid_num_dirty_rmid with IS_ENABLED() so it can be
   optimised out on x86.
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 69 +++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 1f371b108a74..6dfc68c800c8 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -50,6 +50,13 @@ struct rmid_entry {
  */
 static LIST_HEAD(rmid_free_lru);
 
+/**
+ * @closid_num_dirty_rmid    The number of dirty RMID each CLOSID has.
+ *     Only allocated when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined.
+ *     Indexed by CLOSID. Protected by rdtgroup_mutex.
+ */
+static u32 *closid_num_dirty_rmid;
+
 /*
  * @rmid_limbo_count - count of currently unused but (potentially)
  *     dirty RMIDs.
@@ -292,6 +299,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	return 0;
 }
 
+static void limbo_release_entry(struct rmid_entry *entry)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	rmid_limbo_count--;
+	list_add_tail(&entry->list, &rmid_free_lru);
+
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
+		closid_num_dirty_rmid[entry->closid]--;
+}
+
 /*
  * Check the RMIDs that are marked as busy for this domain. If the
  * reported LLC occupancy is below the threshold clear the busy bit and
@@ -328,10 +346,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 
 		if (force_free || !rmid_dirty) {
 			clear_bit(idx, d->rmid_busy_llc);
-			if (!--entry->busy) {
-				rmid_limbo_count--;
-				list_add_tail(&entry->list, &rmid_free_lru);
-			}
+			if (!--entry->busy)
+				limbo_release_entry(entry);
 		}
 		cur_idx = idx + 1;
 	}
@@ -398,6 +414,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	u64 val = 0;
 	u32 idx;
 
+	lockdep_assert_held(&rdtgroup_mutex);
+
 	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
 
 	entry->busy = 0;
@@ -423,10 +441,13 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	}
 	put_cpu();
 
-	if (entry->busy)
+	if (entry->busy) {
 		rmid_limbo_count++;
-	else
+		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
+			closid_num_dirty_rmid[entry->closid]++;
+	} else {
 		list_add_tail(&entry->list, &rmid_free_lru);
+	}
 }
 
 void free_rmid(u32 closid, u32 rmid)
@@ -792,13 +813,33 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
 static int dom_data_init(struct rdt_resource *r)
 {
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
+	u32 num_closid = resctrl_arch_get_num_closid(r);
 	struct rmid_entry *entry = NULL;
+	int err = 0, i;
 	u32 idx;
-	int i;
+
+	mutex_lock(&rdtgroup_mutex);
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+		u32 *tmp;
+
+		tmp = kcalloc(num_closid, sizeof(*tmp), GFP_KERNEL);
+		if (!tmp) {
+			err = -ENOMEM;
+			goto out_unlock;
+		}
+
+		closid_num_dirty_rmid = tmp;
+	}
 
 	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
-	if (!rmid_ptrs)
-		return -ENOMEM;
+	if (!rmid_ptrs) {
+		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+			kfree(closid_num_dirty_rmid);
+			closid_num_dirty_rmid = NULL;
+		}
+		err = -ENOMEM;
+		goto out_unlock;
+	}
 
 	for (i = 0; i < idx_limit; i++) {
 		entry = &rmid_ptrs[i];
@@ -818,13 +859,21 @@ static int dom_data_init(struct rdt_resource *r)
 	entry = __rmid_entry(idx);
 	list_del(&entry->list);
 
-	return 0;
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+
+	return err;
 }
 
 static void __exit dom_data_exit(struct rdt_resource *r)
 {
 	mutex_lock(&rdtgroup_mutex);
 
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+		kfree(closid_num_dirty_rmid);
+		closid_num_dirty_rmid = NULL;
+	}
+
 	kfree(rmid_ptrs);
 	rmid_ptrs = NULL;
 
-- 
2.20.1



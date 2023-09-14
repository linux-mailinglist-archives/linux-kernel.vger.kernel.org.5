Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141507A0B81
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbjINRWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbjINRWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:22:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6FAF2695
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:22:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C250113D5;
        Thu, 14 Sep 2023 10:22:57 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C02383F5A1;
        Thu, 14 Sep 2023 10:22:17 -0700 (PDT)
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
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
Subject: [PATCH v6 08/24] x86/resctrl: Track the number of dirty RMID a CLOSID has
Date:   Thu, 14 Sep 2023 17:21:22 +0000
Message-Id: <20230914172138.11977-9-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230914172138.11977-1-james.morse@arm.com>
References: <20230914172138.11977-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
used for different control groups.

This means once a CLOSID is allocated, all its monitoring ids may still be
dirty, and held in limbo.

Keep track of the number of RMID held in limbo each CLOSID has. This will
allow a future helper to find the 'cleanest' CLOSID when allocating.

The array is only needed when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is
defined. This will never be the case on x86.

Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-By: Peter Newman <peternewman@google.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v4:
 * Moved closid_num_dirty_rmid[] update under entry->busy check
 * Take the mutex in dom_data_init() as the caller doesn't.

Changes since v5:
 * Added braces after an else.
 * Made closid_num_dirty_rmid an unsigned int.
 * Moved mutex_lock() in dom_data_init() to cover the whole function.
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 66 +++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index d286aba1ee63..0c783301d106 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -51,6 +51,13 @@ struct rmid_entry {
  */
 static LIST_HEAD(rmid_free_lru);
 
+/**
+ * @closid_num_dirty_rmid    The number of dirty RMID each CLOSID has.
+ *     Only allocated when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined.
+ *     Indexed by CLOSID. Protected by rdtgroup_mutex.
+ */
+static unsigned int *closid_num_dirty_rmid;
+
 /**
  * @rmid_limbo_count     count of currently unused but (potentially)
  *     dirty RMIDs.
@@ -293,6 +300,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
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
@@ -329,10 +347,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 
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
@@ -400,6 +416,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	u64 val = 0;
 	u32 idx;
 
+	lockdep_assert_held(&rdtgroup_mutex);
+
 	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
 
 	entry->busy = 0;
@@ -425,10 +443,13 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
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
@@ -796,13 +817,30 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
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
+		int *tmp;
+
+		tmp = kcalloc(num_closid, sizeof(int), GFP_KERNEL);
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
+		kfree(closid_num_dirty_rmid);
+		err = -ENOMEM;
+		goto out_unlock;
+	}
 
 	for (i = 0; i < idx_limit; i++) {
 		entry = &rmid_ptrs[i];
@@ -822,13 +860,21 @@ static int dom_data_init(struct rdt_resource *r)
 	entry = __rmid_entry(idx);
 	list_del(&entry->list);
 
-	return 0;
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+
+	return err;
 }
 
 void resctrl_exit_mon_l3_config(struct rdt_resource *r)
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
2.39.2


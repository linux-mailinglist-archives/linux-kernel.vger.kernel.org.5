Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A69E767247
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjG1Qoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbjG1Qnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:43:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37FB64208
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:43:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12542D75;
        Fri, 28 Jul 2023 09:44:19 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4624C3F67D;
        Fri, 28 Jul 2023 09:43:33 -0700 (PDT)
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
        dfustini@baylibre.com
Subject: [PATCH v5 06/24] x86/resctrl: Track the number of dirty RMID a CLOSID has
Date:   Fri, 28 Jul 2023 16:42:36 +0000
Message-Id: <20230728164254.27562-7-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230728164254.27562-1-james.morse@arm.com>
References: <20230728164254.27562-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v4:
 * Moved closid_num_dirty_rmid[] update under entry->busy check
 * Take the mutex in dom_data_init() as the caller doesn't.
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 49 +++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index de91ca781d9f..44addc0126fc 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -43,6 +43,13 @@ struct rmid_entry {
  */
 static LIST_HEAD(rmid_free_lru);
 
+/**
+ * @closid_num_dirty_rmid    The number of dirty RMID each CLOSID has.
+ * Only allocated when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined.
+ * Indexed by CLOSID. Protected by rdtgroup_mutex.
+ */
+static int *closid_num_dirty_rmid;
+
 /**
  * @rmid_limbo_count     count of currently unused but (potentially)
  *     dirty RMIDs.
@@ -285,6 +292,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
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
@@ -321,10 +339,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 
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
@@ -391,6 +407,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	u64 val = 0;
 	u32 idx;
 
+	lockdep_assert_held(&rdtgroup_mutex);
+
 	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
 
 	entry->busy = 0;
@@ -416,9 +434,11 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	}
 	put_cpu();
 
-	if (entry->busy)
+	if (entry->busy) {
 		rmid_limbo_count++;
-	else
+		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
+			closid_num_dirty_rmid[entry->closid]++;
+	} else
 		list_add_tail(&entry->list, &rmid_free_lru);
 }
 
@@ -782,13 +802,28 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
 static int dom_data_init(struct rdt_resource *r)
 {
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
+	u32 num_closid = resctrl_arch_get_num_closid(r);
 	struct rmid_entry *entry = NULL;
 	u32 idx;
 	int i;
 
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+		int *tmp;
+
+		tmp = kcalloc(num_closid, sizeof(int), GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+
+		mutex_lock(&rdtgroup_mutex);
+		closid_num_dirty_rmid = tmp;
+		mutex_unlock(&rdtgroup_mutex);
+	}
+
 	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
-	if (!rmid_ptrs)
+	if (!rmid_ptrs) {
+		kfree(closid_num_dirty_rmid);
 		return -ENOMEM;
+	}
 
 	for (i = 0; i < idx_limit; i++) {
 		entry = &rmid_ptrs[i];
-- 
2.39.2


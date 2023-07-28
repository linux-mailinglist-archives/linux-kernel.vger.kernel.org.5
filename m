Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFBC767254
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjG1Qqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjG1QqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:46:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60920421E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:44:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 955781655;
        Fri, 28 Jul 2023 09:44:42 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C87F73F67D;
        Fri, 28 Jul 2023 09:43:56 -0700 (PDT)
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
Subject: [PATCH v5 14/24] x86/resctrl: Allow resctrl_arch_rmid_read() to sleep
Date:   Fri, 28 Jul 2023 16:42:44 +0000
Message-Id: <20230728164254.27562-15-james.morse@arm.com>
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

MPAM's cache occupancy counters can take a little while to settle once
the monitor has been configured. The maximum settling time is described
to the driver via a firmware table. The value could be large enough
that it makes sense to sleep. To avoid exposing this to resctrl, it
should be hidden behind MPAM's resctrl_arch_rmid_read().

resctrl_arch_rmid_read() may be called via IPI meaning it is unable
to sleep. In this case resctrl_arch_rmid_read() should return an error
if it needs to sleep. This will only affect MPAM platforms where
the cache occupancy counter isn't available immediately, nohz_full is
in use, and there are there are no housekeeping CPUs in the necessary
domain.

There are three callers of resctrl_arch_rmid_read():
__mon_event_count() and __check_limbo() are both called from a
non-migrateable context. mon_event_read() invokes __mon_event_count()
using smp_call_on_cpu(), which adds work to the target CPUs workqueue.
rdtgroup_mutex() is held, meaning this cannot race with the resctrl
cpuhp callback. __check_limbo() is invoked via schedule_delayed_work_on()
also adds work to a per-cpu workqueue.

The remaining call is add_rmid_to_limbo() which is called in response
to a user-space syscall that frees an RMID. This opportunistically
reads the LLC occupancy counter on the current domain to see if the
RMID is over the dirty threshold. This has to disable preemption to
avoid reading the wrong domain's value. Disabling pre-emption here
prevents resctrl_arch_rmid_read() from sleeping.

add_rmid_to_limbo() walks each domain, but only reads the counter
on one domain. If the system has more than one domain, the RMID will
always be added to the limbo list. If the RMIDs usage was not over the
threshold, it will be removed from the list when __check_limbo() runs.
Make this the default behaviour. Free RMIDs are always added to the
limbo list for each domain.

The user visible effect of this is that a clean RMID is not available
for re-allocation immediately after 'rmdir()' completes, this behaviour
was never portable as it never happened on a machine with multiple
domains.

Removing this path allows resctrl_arch_rmid_read() to sleep if its called
with interrupts unmasked. Document this is the expected behaviour, and
add a might_sleep() annotation to catch changes that won't work on arm64.

Signed-off-by: James Morse <james.morse@arm.com>
---
The previous version allowed resctrl_arch_rmid_read() to be called on the
wrong CPUs, but now that this needs to take nohz_full and housekeeping into
account, its too complex.

Changes since v3:
 * Removed error handling for smp_call_function_any(), this can't race
   with the cpuhp callbacks as both hold rdtgroup_mutex.
 * Switched to the alternative of removing the counter read, this simplifies
   things dramatically.

Changes since v4:
 * Messed with capitalisation.
 * Removed some dead code now that entry->busy will never be zero in
   add_rmid_to_limbo().
 * Rephrased the comment above resctrl_arch_rmid_read_context_check().
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 24 +++++-------------------
 include/linux/resctrl.h               | 18 +++++++++++++++++-
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 32569354c4f1..08e3307863c3 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -283,6 +283,8 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	struct arch_mbm_state *am;
 	int ret = 0;
 
+	resctrl_arch_rmid_read_context_check();
+
 	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
 		return -EINVAL;
 
@@ -470,8 +472,6 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	struct rdt_domain *d;
-	int cpu, err;
-	u64 val = 0;
 	u32 idx;
 
 	lockdep_assert_held(&rdtgroup_mutex);
@@ -479,17 +479,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
 
 	entry->busy = 0;
-	cpu = get_cpu();
 	list_for_each_entry(d, &r->domains, list) {
-		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
-			err = resctrl_arch_rmid_read(r, d, entry->closid,
-						     entry->rmid,
-						     QOS_L3_OCCUP_EVENT_ID,
-						     &val);
-			if (err || val <= resctrl_rmid_realloc_threshold)
-				continue;
-		}
-
 		/*
 		 * For the first limbo RMID in the domain,
 		 * setup up the limbo worker.
@@ -499,14 +489,10 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 		set_bit(idx, d->rmid_busy_llc);
 		entry->busy++;
 	}
-	put_cpu();
 
-	if (entry->busy) {
-		rmid_limbo_count++;
-		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
-			closid_num_dirty_rmid[entry->closid]++;
-	} else
-		list_add_tail(&entry->list, &rmid_free_lru);
+	rmid_limbo_count++;
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
+		closid_num_dirty_rmid[entry->closid]++;
 }
 
 void free_rmid(u32 closid, u32 rmid)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 660752406174..f7311102e94c 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -236,7 +236,12 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
  * @eventid:		eventid to read, e.g. L3 occupancy.
  * @val:		result of the counter read in bytes.
  *
- * Call from process context on a CPU that belongs to domain @d.
+ * Some architectures need to sleep when first programming some of the counters.
+ * (specifically: arm64's MPAM cache occupancy counters can return 'not ready'
+ *  for a short period of time). Call from a non-migrateable process context on
+ * a CPU that belongs to domain @d. e.g. use smp_call_on_cpu() or
+ * schedule_work_on(). This function can be called with interrupts masked,
+ * e.g. using smp_call_function_any(), but may consistently return an error.
  *
  * Return:
  * 0 on success, or -EIO, -EINVAL etc on error.
@@ -245,6 +250,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
 			   u64 *val);
 
+/**
+ * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts
+ *
+ * When built with CONFIG_DEBUG_ATOMIC_SLEEP generate a warning when
+ * resctrl_arch_rmid_read() is called with preemption disabled.
+ */
+static inline void resctrl_arch_rmid_read_context_check(void)
+{
+	if (!irqs_disabled())
+		might_sleep();
+}
 
 /**
  * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
-- 
2.39.2


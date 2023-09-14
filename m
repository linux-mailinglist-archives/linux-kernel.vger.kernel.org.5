Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8F67A0B93
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbjINRYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240562AbjINRXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:23:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DAE630D2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:23:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68F4D143D;
        Thu, 14 Sep 2023 10:23:37 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 673393F5A1;
        Thu, 14 Sep 2023 10:22:57 -0700 (PDT)
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
Subject: [PATCH v6 21/24] x86/resctrl: Allow overflow/limbo handlers to be scheduled on any-but cpu
Date:   Thu, 14 Sep 2023 17:21:35 +0000
Message-Id: <20230914172138.11977-22-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230914172138.11977-1-james.morse@arm.com>
References: <20230914172138.11977-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a CPU is taken offline resctrl may need to move the overflow or
limbo handlers to run on a different CPU.

Once the offline callbacks have been split, cqm_setup_limbo_handler()
will be called while the CPU that is going offline is still present
in the cpu_mask.

Pass the CPU to exclude to cqm_setup_limbo_handler() and
mbm_setup_overflow_handler(). These functions can use a variant of
cpumask_any_but() when selecting the CPU. -1 is used to indicate no CPUs
need excluding.

A subsequent patch moves these calls to be before CPUs have been removed,
so this exclude_cpus behaviour is temporary.

Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-By: Peter Newman <peternewman@google.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * Rephrased a comment to avoid a two letter bad-word. (we)
 * Avoid assigning mbm_work_cpu if the domain is going to be free()d
 * Added cpumask_any_housekeeping_but(), I dislike the name

Changes since v3:
 * Marked an explanatory comment as temporary as the subsequent patch is
   no longer adjacent.

Changes since v4:
 * Check against RESCTRL_PICK_ANY_CPU instead of -1.
 * Leave cqm_work_cpu as nr_cpu_ids when no CPU is available.
 * Made cpumask_any_housekeeping_but() more readable.

Changes since v5:
 * Changes in captialisation, and a typo.
 * Merged cpumask helpers.
---
 arch/x86/kernel/cpu/resctrl/core.c        |  8 +++--
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h    | 19 +++++++++---
 arch/x86/kernel/cpu/resctrl/monitor.c     | 38 +++++++++++++++++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  6 ++--
 include/linux/resctrl.h                   |  2 ++
 6 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 5b4c719ac129..37aa124f1e4c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -582,12 +582,16 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
 		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
 			cancel_delayed_work(&d->mbm_over);
-			mbm_setup_overflow_handler(d, 0);
+			/*
+			 * temporary: exclude_cpu=-1 as this CPU has already
+			 * been removed by cpumask_clear_cpu()d
+			 */
+			mbm_setup_overflow_handler(d, 0, RESCTRL_PICK_ANY_CPU);
 		}
 		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
 		    has_busy_rmid(d)) {
 			cancel_delayed_work(&d->cqm_limbo);
-			cqm_setup_limbo_handler(d, 0);
+			cqm_setup_limbo_handler(d, 0, RESCTRL_PICK_ANY_CPU);
 		}
 	}
 }
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index ce4821ea111b..b4ed4e1b4938 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -552,7 +552,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		return;
 	}
 
-	cpu = cpumask_any_housekeeping(&d->cpu_mask);
+	cpu = cpumask_any_housekeeping(&d->cpu_mask, RESCTRL_PICK_ANY_CPU);
 
 	/*
 	 * cpumask_any_housekeeping() prefers housekeeping CPUs, but
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c54fa86e4ef9..bd7f60bf49fe 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -60,11 +60,15 @@
  * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
  *			        aren't marked nohz_full
  * @mask:	The mask to pick a CPU from.
+ * @exclude_cpu:The CPU to avoid picking.
  *
- * Returns a CPU in @mask. If there are housekeeping CPUs that don't use
- * nohz_full, these are preferred.
+ * Returns a CPU from @mask, but not @exclude_cpu. If there are housekeeping
+ * CPUs that don't use nohz_full, these are preferred. Pass
+ * RESCTRL_PICK_ANY_CPU to avoid excluding any CPUs.
+ * Returns >= nr_cpu_ids if no CPUs are available.
  */
-static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
+static inline unsigned int
+cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
 {
 	unsigned int cpu, hk_cpu;
 
@@ -73,6 +77,9 @@ static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
 		return cpu;
 
 	hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
+	if (hk_cpu == exclude_cpu)
+		hk_cpu = cpumask_nth_andnot(1, mask, tick_nohz_full_mask);
+
 	if (hk_cpu < nr_cpu_ids)
 		cpu = hk_cpu;
 
@@ -565,11 +572,13 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first);
 void mbm_setup_overflow_handler(struct rdt_domain *dom,
-				unsigned long delay_ms);
+				unsigned long delay_ms,
+				int exclude_cpu);
 void mbm_handle_overflow(struct work_struct *work);
 void __init intel_rdt_mbm_apply_quirk(void);
 bool is_mba_sc(struct rdt_resource *r);
-void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
+void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
+			     int exclude_cpu);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 9c6d4b0970e2..208e46ba7368 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -480,7 +480,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 		 * setup up the limbo worker.
 		 */
 		if (!has_busy_rmid(d))
-			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL);
+			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL,
+						RESCTRL_PICK_ANY_CPU);
 		set_bit(idx, d->rmid_busy_llc);
 		entry->busy++;
 	}
@@ -807,22 +808,31 @@ void cqm_handle_limbo(struct work_struct *work)
 	__check_limbo(d, false);
 
 	if (has_busy_rmid(d)) {
-		cpu = cpumask_any_housekeeping(&d->cpu_mask);
+		cpu = cpumask_any_housekeeping(&d->cpu_mask, RESCTRL_PICK_ANY_CPU);
 		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
 	}
 
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
+/**
+ * cqm_setup_limbo_handler() - Schedule the limbo handler to run for this
+ *                             domain.
+ * @delay_ms:      How far in the future the handler should run.
+ * @exclude_cpu:   Which CPU the handler should not run on,
+ *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
+ */
+void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
+			     int exclude_cpu)
 {
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
 
-	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
+	cpu = cpumask_any_housekeeping(&dom->cpu_mask, exclude_cpu);
 	dom->cqm_work_cpu = cpu;
 
-	schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
+	if (cpu < nr_cpu_ids)
+		schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
 }
 
 void mbm_handle_overflow(struct work_struct *work)
@@ -861,14 +871,22 @@ void mbm_handle_overflow(struct work_struct *work)
 	 * Re-check for housekeeping CPUs. This allows the overflow handler to
 	 * move off a nohz_full CPU quickly.
 	 */
-	cpu = cpumask_any_housekeeping(&d->cpu_mask);
+	cpu = cpumask_any_housekeeping(&d->cpu_mask, RESCTRL_PICK_ANY_CPU);
 	schedule_delayed_work_on(cpu, &d->mbm_over, delay);
 
 out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
+/**
+ * mbm_setup_overflow_handler() - Schedule the overflow handler to run for this
+ *                                domain.
+ * @delay_ms:      How far in the future the handler should run.
+ * @exclude_cpu:   Which CPU the handler should not run on,
+ *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
+ */
+void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms,
+				int exclude_cpu)
 {
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
@@ -879,9 +897,11 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
 	 */
 	if (!resctrl_mounted || !resctrl_arch_mon_capable())
 		return;
-	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
+	cpu = cpumask_any_housekeeping(&dom->cpu_mask, exclude_cpu);
 	dom->mbm_work_cpu = cpu;
-	schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
+
+	if (cpu < nr_cpu_ids)
+		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
 }
 
 static int dom_data_init(struct rdt_resource *r)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 0c609cdfe7e5..49f100c73838 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2552,7 +2552,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (is_mbm_enabled()) {
 		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 		list_for_each_entry(dom, &r->domains, list)
-			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
+			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
+						   RESCTRL_PICK_ANY_CPU);
 	}
 
 	goto out;
@@ -3850,7 +3851,8 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 
 	if (is_mbm_enabled()) {
 		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
-		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
+		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL,
+					   RESCTRL_PICK_ANY_CPU);
 	}
 
 	if (is_llc_occupancy_enabled())
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 9d5f75a4e192..0888d1975161 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -10,6 +10,8 @@
 #define RESCTRL_RESERVED_CLOSID		0
 #define RESCTRL_RESERVED_RMID		0
 
+#define RESCTRL_PICK_ANY_CPU		-1
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 int proc_resctrl_show(struct seq_file *m,
-- 
2.39.2


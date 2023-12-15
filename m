Return-Path: <linux-kernel+bounces-1460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE72814F29
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB401C24677
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1288966AB1;
	Fri, 15 Dec 2023 17:45:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4036F5F877
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0447C15;
	Fri, 15 Dec 2023 09:45:51 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE3413F5A1;
	Fri, 15 Dec 2023 09:45:03 -0800 (PST)
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
Subject: [PATCH v8 21/24] x86/resctrl: Allow overflow/limbo handlers to be scheduled on any-but cpu
Date: Fri, 15 Dec 2023 17:43:40 +0000
Message-Id: <20231215174343.13872-22-james.morse@arm.com>
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

When a CPU is taken offline resctrl may need to move the overflow or
limbo handlers to run on a different CPU.

Once the offline callbacks have been split, cqm_setup_limbo_handler()
will be called while the CPU that is going offline is still present
in the cpu_mask.

Pass the CPU to exclude to cqm_setup_limbo_handler() and
mbm_setup_overflow_handler(). These functions can use a variant of
cpumask_any_but() when selecting the CPU. -1 is used to indicate no CPUs
need excluding.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
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

Changes since v6:
 * Added the missing dom parameter to some kernel doc.
 * Re-added use of cpumask_any_but(),
 * Expanded comment above cpumask_any_housekeeping(),
 * Added some more comments for good measure.
 * Added explicit IS_ENABLED() check as gcc-12 doesn't seem to work this out.

Changes since v7:
 * Removed the paragraph with the badword 'subsequent'.
 * Reworded a comment with the badword 'we'.
 * Fixed a bounds checking bug in cpumask_any_housekeeping().
---
 arch/x86/kernel/cpu/resctrl/core.c        |  8 +++--
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h    | 33 ++++++++++++++----
 arch/x86/kernel/cpu/resctrl/monitor.c     | 42 ++++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  6 ++--
 include/linux/resctrl.h                   |  2 ++
 6 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 8ac89dbf4484..118ac7c28106 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -586,12 +586,16 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
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
index a033e8e32108..64db51455df3 100644
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
index c4c1e1909058..8091eb59b159 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -61,19 +61,36 @@
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
+ *
+ * When a CPU is excluded, returns >= nr_cpu_ids if no CPUs are available.
  */
-static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
+static inline unsigned int
+cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
 {
 	unsigned int cpu, hk_cpu;
 
-	cpu = cpumask_any(mask);
-	if (!tick_nohz_full_cpu(cpu))
+	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
+		cpu = cpumask_any(mask);
+	else
+		cpu = cpumask_any_but(mask, exclude_cpu);
+
+	if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
 		return cpu;
 
+	/* If the CPU picked isn't marked nohz_full nothing more needs doing. */
+	if (cpu < nr_cpu_ids && !tick_nohz_full_cpu(cpu))
+		return cpu;
+
+	/* Try to find a CPU that isn't nohz_full to use in preference */
 	hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
+	if (hk_cpu == exclude_cpu)
+		hk_cpu = cpumask_nth_andnot(1, mask, tick_nohz_full_mask);
+
 	if (hk_cpu < nr_cpu_ids)
 		cpu = hk_cpu;
 
@@ -575,11 +592,13 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
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
index 95020b113ee5..c78b51eb1256 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -481,7 +481,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 		 * setup up the limbo worker.
 		 */
 		if (!has_busy_rmid(d))
-			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL);
+			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL,
+						RESCTRL_PICK_ANY_CPU);
 		set_bit(idx, d->rmid_busy_llc);
 		entry->busy++;
 	}
@@ -806,7 +807,8 @@ void cqm_handle_limbo(struct work_struct *work)
 	__check_limbo(d, false);
 
 	if (has_busy_rmid(d)) {
-		d->cqm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask);
+		d->cqm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask,
+							   RESCTRL_PICK_ANY_CPU);
 		schedule_delayed_work_on(d->cqm_work_cpu, &d->cqm_limbo,
 					 delay);
 	}
@@ -814,15 +816,25 @@ void cqm_handle_limbo(struct work_struct *work)
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
+/**
+ * cqm_setup_limbo_handler() - Schedule the limbo handler to run for this
+ *                             domain.
+ * @dom:           The domain the limbo handler should run for.
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
@@ -860,14 +872,24 @@ void mbm_handle_overflow(struct work_struct *work)
 	 * Re-check for housekeeping CPUs. This allows the overflow handler to
 	 * move off a nohz_full CPU quickly.
 	 */
-	d->mbm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask);
+	d->mbm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask,
+						   RESCTRL_PICK_ANY_CPU);
 	schedule_delayed_work_on(d->mbm_work_cpu, &d->mbm_over, delay);
 
 out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
+/**
+ * mbm_setup_overflow_handler() - Schedule the overflow handler to run for this
+ *                                domain.
+ * @dom:           The domain the overflow handler should run for.
+ * @delay_ms:      How far in the future the handler should run.
+ * @exclude_cpu:   Which CPU the handler should not run on,
+ *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
+ */
+void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms,
+				int exclude_cpu)
 {
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
@@ -878,9 +900,11 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
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
index 76aa73c49fad..fc1b913e54bd 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2683,7 +2683,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (is_mbm_enabled()) {
 		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 		list_for_each_entry(dom, &r->domains, list)
-			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
+			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
+						   RESCTRL_PICK_ANY_CPU);
 	}
 
 	goto out;
@@ -3994,7 +3995,8 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 
 	if (is_mbm_enabled()) {
 		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
-		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
+		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL,
+					   RESCTRL_PICK_ANY_CPU);
 	}
 
 	if (is_llc_occupancy_enabled())
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 4c4bad3c34e4..ccbbbe5d18d3 100644
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
2.20.1



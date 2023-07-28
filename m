Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDDE76724F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjG1Qpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbjG1QpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:45:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9108A4EC3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:43:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4FD21570;
        Fri, 28 Jul 2023 09:44:33 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A62D3F67D;
        Fri, 28 Jul 2023 09:43:47 -0700 (PDT)
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
Subject: [PATCH v5 11/24] x86/resctrl: Add cpumask_any_housekeeping() for limbo/overflow
Date:   Fri, 28 Jul 2023 16:42:41 +0000
Message-Id: <20230728164254.27562-12-james.morse@arm.com>
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

The limbo and overflow code picks a CPU to use from the domain's list
of online CPUs. Work is then scheduled on these CPUs to maintain
the limbo list and any counters that may overflow.

cpumask_any() may pick a CPU that is marked nohz_full, which will
either penalise the work that CPU was dedicated to, or delay the
processing of limbo list or counters that may overflow. Perhaps
indefinitely. Delaying the overflow handling will skew the bandwidth
values calculated by mba_sc, which expects to be called once a second.

Add cpumask_any_housekeeping() as a replacement for cpumask_any()
that prefers housekeeping CPUs. This helper will still return
a nohz_full CPU if that is the only option. The CPU to use is
re-evaluated each time the limbo/overflow work runs. This ensures
the work will move off a nohz_full CPU once a housekeeping CPU is
available.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v3:
 * typos fixed

Changes since v4:
 * Made temporary variables unsigned
---
 arch/x86/kernel/cpu/resctrl/internal.h | 23 +++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 17 ++++++++++++-----
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 7c2a1c235480..a32d307292a1 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -7,6 +7,7 @@
 #include <linux/kernfs.h>
 #include <linux/fs_context.h>
 #include <linux/jump_label.h>
+#include <linux/tick.h>
 #include <asm/resctrl.h>
 
 #define L3_QOS_CDP_ENABLE		0x01ULL
@@ -55,6 +56,28 @@
 /* Max event bits supported */
 #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
 
+/**
+ * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
+ *			        aren't marked nohz_full
+ * @mask:	The mask to pick a CPU from.
+ *
+ * Returns a CPU in @mask. If there are housekeeping CPUs that don't use
+ * nohz_full, these are preferred.
+ */
+static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
+{
+	unsigned int cpu, hk_cpu;
+
+	cpu = cpumask_any(mask);
+	if (tick_nohz_full_cpu(cpu)) {
+		hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
+		if (hk_cpu < nr_cpu_ids)
+			cpu = hk_cpu;
+	}
+
+	return cpu;
+}
+
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c268aa5925c7..f0670795b446 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -767,9 +767,9 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
 void cqm_handle_limbo(struct work_struct *work)
 {
 	unsigned long delay = msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
-	int cpu = smp_processor_id();
 	struct rdt_resource *r;
 	struct rdt_domain *d;
+	int cpu;
 
 	mutex_lock(&rdtgroup_mutex);
 
@@ -778,8 +778,10 @@ void cqm_handle_limbo(struct work_struct *work)
 
 	__check_limbo(d, false);
 
-	if (has_busy_rmid(d))
+	if (has_busy_rmid(d)) {
+		cpu = cpumask_any_housekeeping(&d->cpu_mask);
 		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
+	}
 
 	mutex_unlock(&rdtgroup_mutex);
 }
@@ -789,7 +791,7 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
 
-	cpu = cpumask_any(&dom->cpu_mask);
+	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
 	dom->cqm_work_cpu = cpu;
 
 	schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
@@ -799,10 +801,10 @@ void mbm_handle_overflow(struct work_struct *work)
 {
 	unsigned long delay = msecs_to_jiffies(MBM_OVERFLOW_INTERVAL);
 	struct rdtgroup *prgrp, *crgrp;
-	int cpu = smp_processor_id();
 	struct list_head *head;
 	struct rdt_resource *r;
 	struct rdt_domain *d;
+	int cpu;
 
 	mutex_lock(&rdtgroup_mutex);
 
@@ -823,6 +825,11 @@ void mbm_handle_overflow(struct work_struct *work)
 			update_mba_bw(prgrp, d);
 	}
 
+	/*
+	 * Re-check for housekeeping CPUs. This allows the overflow handler to
+	 * move off a nohz_full CPU quickly.
+	 */
+	cpu = cpumask_any_housekeeping(&d->cpu_mask);
 	schedule_delayed_work_on(cpu, &d->mbm_over, delay);
 
 out_unlock:
@@ -836,7 +843,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
 
 	if (!static_branch_likely(&rdt_mon_enable_key))
 		return;
-	cpu = cpumask_any(&dom->cpu_mask);
+	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
 	dom->mbm_work_cpu = cpu;
 	schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
 }
-- 
2.39.2


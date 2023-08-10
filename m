Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47481777A19
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjHJOFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjHJOFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:05:46 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506A11B4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1691676343;
        bh=Kv40ZguXd3+QQqZyTcyvt3upXytmrK1Txk3YIAGwLy0=;
        h=From:To:Cc:Subject:Date:From;
        b=VPK3RCEBb6poYn1z03Zr4B4Osxh57RnWlN26RJxAIoL5pVneEMHtqsz3e92qMBcUx
         73RjA0aGHPs28/P1sYjDvIN6rTgN3W+U7quMsEjETNqR/5TWp1J/wevW0fOlB3askM
         Xagk/qrkPeZ/x459OhMdAjavk71+VY2CMF+SmR38Cb77eOGcFFAT1Hu4LUebQpQa0X
         iVDUpSQmAkgv0rFRWSiBrrto/1GkTAMVuX2IfBc8i052nUnAHztZhYOTkiGlOhvuT4
         L+4NRXDF293+087Dr+8jxxxllyrn5RCvBo/mGy21KYPjnoAd8pVyOtXk1zbVA3Ud06
         CXXshHSA1P3Lw==
Received: from thinkos.internal.efficios.com (unknown [107.159.1.132])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RM7xM0bvyz1KsJ;
        Thu, 10 Aug 2023 10:05:43 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org
Subject: [RFC PATCH 1/1] sched: Favor almost idle previously used CPUs for wake affine
Date:   Thu, 10 Aug 2023 10:06:35 -0400
Message-Id: <20230810140635.75296-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow select_task_rq to favor almost idle previously used CPU for wake
affine. This is achieved by using the CPU load of the previously used
CPU as "almost idle" criterion in wake_affine_idle(), and by passing the
target idleness state from wake_affine_idle() to select_idle_sibling()
so it does not need to be reevaluated.

This speeds up the following hackbench workload on a 192 cores AMD EPYC
9654 96-Core Processor (over 2 sockets):

hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100

from 49s to 34s. (30% speedup)

We can observe that the number of migrations is reduced significantly
(-68%) with this patch, which may explain the speedup.

Baseline:      115M cpu-migrations  (8.954 K/sec)
With patch:     36M cpu-migrations  (3.167 K/sec)

This was developed as part of the investigation into a weird regression
reported by AMD where adding a raw spinlock in the scheduler context
switch accelerated hackbench. It turned out that changing this raw
spinlock for a loop of 10000x cpu_relax within do_idle() had similar
benefits.

This patch achieves a similar effect without the busy-waiting by
allowing select_task_rq to favor almost idle previously used CPUs based
on the CPU load of that CPU. The threshold of "5" for almost idle CPU
load has been identified empirically using the hackbench workload.

This patch should be considered "food for thoughts", and I would be glad
to hear feedback on whether it causes improvement or regressions on
_other_ workloads, or helps speeding up hackbench on other hardware as
well.

Link: https://lore.kernel.org/r/09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com
Link: https://lore.kernel.org/lkml/20230725193048.124796-1-mathieu.desnoyers@efficios.com/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
Cc: Aaron Lu <aaron.lu@intel.com>
Cc: x86@kernel.org
---
 kernel/sched/fair.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4da5f3541762..0884e4f420ac 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -792,7 +792,7 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #include "pelt.h"
 #ifdef CONFIG_SMP
 
-static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
+static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu, int target_idle);
 static unsigned long task_h_load(struct task_struct *p);
 static unsigned long capacity_of(int cpu);
 
@@ -6599,6 +6599,12 @@ static int wake_wide(struct task_struct *p)
 	return 1;
 }
 
+static int
+almost_idle_cpu(int cpu, struct task_struct *p)
+{
+	return cpu_load_without(cpu_rq(cpu), p) <= 5;
+}
+
 /*
  * The purpose of wake_affine() is to quickly determine on which CPU we can run
  * soonest. For the purpose of speed we only consider the waking and previous
@@ -6612,7 +6618,8 @@ static int wake_wide(struct task_struct *p)
  *			  for the overloaded case.
  */
 static int
-wake_affine_idle(int this_cpu, int prev_cpu, int sync)
+wake_affine_idle(int this_cpu, int prev_cpu, int sync, int *target_idle,
+		 struct task_struct *p)
 {
 	/*
 	 * If this_cpu is idle, it implies the wakeup is from interrupt
@@ -6632,8 +6639,10 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	if (sync && cpu_rq(this_cpu)->nr_running == 1)
 		return this_cpu;
 
-	if (available_idle_cpu(prev_cpu))
+	if (available_idle_cpu(prev_cpu) || almost_idle_cpu(prev_cpu, p)) {
+		*target_idle = 1;
 		return prev_cpu;
+	}
 
 	return nr_cpumask_bits;
 }
@@ -6682,12 +6691,12 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 }
 
 static int wake_affine(struct sched_domain *sd, struct task_struct *p,
-		       int this_cpu, int prev_cpu, int sync)
+		       int this_cpu, int prev_cpu, int sync, int *target_idle)
 {
 	int target = nr_cpumask_bits;
 
 	if (sched_feat(WA_IDLE))
-		target = wake_affine_idle(this_cpu, prev_cpu, sync);
+		target = wake_affine_idle(this_cpu, prev_cpu, sync, target_idle, p);
 
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
@@ -7116,7 +7125,7 @@ static inline bool asym_fits_cpu(unsigned long util,
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
-static int select_idle_sibling(struct task_struct *p, int prev, int target)
+static int select_idle_sibling(struct task_struct *p, int prev, int target, int target_idle)
 {
 	bool has_idle_core = false;
 	struct sched_domain *sd;
@@ -7139,7 +7148,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	lockdep_assert_irqs_disabled();
 
-	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
+	if ((target_idle || available_idle_cpu(target) || sched_idle_cpu(target)) &&
 	    asym_fits_cpu(task_util, util_min, util_max, target))
 		return target;
 
@@ -7676,6 +7685,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	int want_affine = 0;
 	/* SD_flags and WF_flags share the first nibble */
 	int sd_flag = wake_flags & 0xF;
+	int target_idle = 0;
 
 	/*
 	 * required for stable ->cpus_allowed
@@ -7703,7 +7713,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
 		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
 			if (cpu != prev_cpu)
-				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync);
+				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync, &target_idle);
 
 			sd = NULL; /* Prefer wake_affine over balance flags */
 			break;
@@ -7725,7 +7735,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
 	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
-		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
+		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu, target_idle);
 	}
 	rcu_read_unlock();
 
-- 
2.39.2


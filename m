Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E7979A180
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjIKCuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjIKCui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:50:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0374F3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 19:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694400626; x=1725936626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7UTXt00q2zO6N1hMLhwPitz2z1cZ7tYEUrLvb5h/09g=;
  b=f5qjo8EHwMOytHwhIZECRpFUOt2iT4AQShwaO1Is7zS7EALaHIYgkB5F
   bpQtKtmQtYudKnq6VapaNf2EX1LIqT1EqDp3+dwluH3JPEiHjZ6h21NQ3
   dQUAgiNc17keVLSnK6Jt20erFV4AqeD9ygtbHRPVBqSf61kFWYJ+GCImc
   Rlhizmr+f8zrvtq+psknYtmomPMlYz7EWlqCQbET1SB1Gz6s6G+MLoZoo
   ykbpcwa2Ufurso0qXZbL9iY19SO5+NahUoAHS+6BWVhWE7h0h+mZFGxyo
   p3dG+tLIcCuS+UUcdxwsU3iNwVqsQUc4Y1dedO1V15Q1rBAuBWUiWby0Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="381781810"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="381781810"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 19:50:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="719848112"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="719848112"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orsmga006.jf.intel.com with ESMTP; 10 Sep 2023 19:50:22 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in select_idle_cpu()
Date:   Mon, 11 Sep 2023 10:50:00 +0800
Message-Id: <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1694397335.git.yu.c.chen@intel.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When task p is woken up, the scheduler leverages select_idle_sibling()
to find an idle CPU for it. p's previous CPU is usually a preference
because it can improve cache locality. However in many cases the
previous CPU has already been taken by other wakees, thus p has to
find another idle CPU.

Inspired by Mathieu's idea[1], consider the sleep time of the task.
If that task is a short sleeping one, keep p's previous CPU idle
for a short while. Later when p is woken up, it can choose its
previous CPU in select_idle_sibling(). When p's previous CPU is reserved,
other wakee is not allowed to choose this CPU in select_idle_idle().
The reservation period is set to the task's average sleep time. That
is to say, if p is a short sleeping task, there is no need to migrate
p to another idle CPU.

This does not break the work conservation of the scheduler,
because wakee will still try its best to find an idle CPU.
The difference is that, different idle CPUs might have different
priorities. On the other hand, in theory this extra check could
increase the failure ratio of select_idle_cpu(), but per the
initial test result, no regression is detected.

Baseline: tip/sched/core, on top of:
Commit 3f4feb58037a ("sched: Misc cleanups")

Benchmark results on Intel Sapphire Rapids, 112 CPUs/socket, 2 sockets.
cpufreq governor is performance, turbo boost is disabled, C-states deeper
than C1 are disabled, Numa balancing is disabled.

netperf
=======
case                    load            baseline(std%)  compare%( std%)
UDP_RR                  56-threads       1.00 (  1.34)   +1.05 (  1.04)
UDP_RR                  112-threads      1.00 (  7.94)   -0.68 ( 14.42)
UDP_RR                  168-threads      1.00 ( 33.17)  +49.63 (  5.96)
UDP_RR                  224-threads      1.00 ( 13.52)  +122.53 ( 18.50)

Noticeable improvements of netperf is observed in 168 and 224 threads
cases.

hackbench
=========
case                    load            baseline(std%)  compare%( std%)
process-pipe            1-groups         1.00 (  5.61)   -4.69 (  1.48)
process-pipe            2-groups         1.00 (  8.74)   -0.24 (  3.10)
process-pipe            4-groups         1.00 (  3.52)   +1.61 (  4.41)
process-sockets         1-groups         1.00 (  4.73)   +2.32 (  0.95)
process-sockets         2-groups         1.00 (  1.27)   -3.29 (  0.97)
process-sockets         4-groups         1.00 (  0.09)   +0.24 (  0.09)
threads-pipe            1-groups         1.00 ( 10.44)   -5.88 (  1.49)
threads-pipe            2-groups         1.00 ( 19.15)   +5.31 ( 12.90)
threads-pipe            4-groups         1.00 (  1.74)   -5.01 (  6.44)
threads-sockets         1-groups         1.00 (  1.58)   -1.79 (  0.43)
threads-sockets         2-groups         1.00 (  1.19)   -8.43 (  6.91)
threads-sockets         4-groups         1.00 (  0.10)   -0.09 (  0.07)

schbench(old)
========
case                    load            baseline(std%)  compare%( std%)
normal                  1-mthreads       1.00 (  0.63)   +1.28 (  0.37)
normal                  2-mthreads       1.00 (  8.33)   +1.58 (  2.83)
normal                  4-mthreads       1.00 (  2.48)   -2.98 (  3.28)
normal                  8-mthreads       1.00 (  3.97)   +5.01 (  1.28)

No much difference is observed in hackbench/schbench, due to the
run-to-run variance.

Link: https://lore.kernel.org/lkml/20230905171105.1005672-2-mathieu.desnoyers@efficios.com/ #1
Suggested-by: Tim Chen <tim.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++---
 kernel/sched/features.h |  1 +
 kernel/sched/sched.h    |  1 +
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e20f50726ab8..fe3b760c9654 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6629,6 +6629,21 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	hrtick_update(rq);
 	now = sched_clock_cpu(cpu_of(rq));
 	p->se.prev_sleep_time = task_sleep ? now : 0;
+#ifdef CONFIG_SMP
+	/*
+	 * If this rq will become idle, and dequeued task is
+	 * a short sleeping one, check if we can reserve
+	 * this idle CPU for that task for a short while.
+	 * During this reservation period, other wakees will
+	 * skip this 'idle' CPU in select_idle_cpu(), and this
+	 * short sleeping task can pick its previous CPU in
+	 * select_idle_sibling(), which brings better cache
+	 * locality.
+	 */
+	if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running &&
+	    p->se.sleep_avg && p->se.sleep_avg < sysctl_sched_migration_cost)
+		rq->cache_hot_timeout = now + p->se.sleep_avg;
+#endif
 }
 
 #ifdef CONFIG_SMP
@@ -6982,8 +6997,13 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 static inline int __select_idle_cpu(int cpu, struct task_struct *p)
 {
 	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
-	    sched_cpu_cookie_match(cpu_rq(cpu), p))
+	    sched_cpu_cookie_match(cpu_rq(cpu), p)) {
+		if (sched_feat(SIS_CACHE) &&
+		    sched_clock_cpu(cpu) < cpu_rq(cpu)->cache_hot_timeout)
+			return -1;
+
 		return cpu;
+	}
 
 	return -1;
 }
@@ -7052,10 +7072,14 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 	int cpu;
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
-		if (!available_idle_cpu(cpu)) {
+		bool cache_hot = sched_feat(SIS_CACHE) ?
+			sched_clock_cpu(cpu) < cpu_rq(cpu)->cache_hot_timeout : false;
+
+		if (!available_idle_cpu(cpu) || cache_hot) {
 			idle = false;
 			if (*idle_cpu == -1) {
-				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
+				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr) &&
+				    !cache_hot) {
 					*idle_cpu = cpu;
 					break;
 				}
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index f770168230ae..04ed9fcf67f8 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -51,6 +51,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
  */
 SCHED_FEAT(SIS_PROP, false)
 SCHED_FEAT(SIS_UTIL, true)
+SCHED_FEAT(SIS_CACHE, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 62013c49c451..7a2c12c3b6d0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1078,6 +1078,7 @@ struct rq {
 #endif
 	u64			idle_stamp;
 	u64			avg_idle;
+	u64			cache_hot_timeout;
 
 	unsigned long		wake_stamp;
 	u64			wake_avg_idle;
-- 
2.25.1


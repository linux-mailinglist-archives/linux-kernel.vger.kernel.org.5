Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2637A7AE4E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjIZFLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjIZFLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:11:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10696AF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 22:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695705088; x=1727241088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f8FE5OhC27HIq8rp8eMc8VPyEyGmG8RlWVvtp+f0/w4=;
  b=G6df2vjUo3S5p01SXE3Xkp/epsRFN9tBkU1CrFaFKz2BQKsJ/PdCtL3G
   BcxxAChGX7ja5v9hguKIf/zJmFPL0eGQDRXNzVFCoAw2vpgB62FHksmXt
   UCV5Wzb4qeR+pUvbv789m8OWHti6Vj8ak1XxvvKvw1Z2tq09tTGV5K9WM
   RVOys/hPFi+whRxZ6ArlcE6FvBI/XvoYAcsZUlggZ+ZHZIgTfoDk9rK8G
   L0ooyQIKOzvyOyotIuS0NjV0n5/Qt8if/34JvOHTpzaPAS2A3wlUtOdoV
   xqKGDPO5LrH+LFVVxum//mHbxHOxMuLopdm/o5+qp3lL1gkarI8DlDeGH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="366545754"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="366545754"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:11:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="872368088"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="872368088"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orsmga004.jf.intel.com with ESMTP; 25 Sep 2023 22:11:22 -0700
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
        linux-kernel@vger.kernel.org, Chen Yu <yu.chen.surf@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/2] sched/fair: skip the cache hot CPU in select_idle_cpu()
Date:   Tue, 26 Sep 2023 13:11:15 +0800
Message-Id: <4f2131940d43060eda55847a2affc8042179b4ee.1695704179.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1695704179.git.yu.c.chen@intel.com>
References: <cover.1695704179.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem statement:
When task p is woken up, the scheduler leverages select_idle_sibling()
to find an idle CPU for it. p's previous CPU is usually a preference
because it can improve cache locality. However in many cases, the
previous CPU has already been taken by other wakees, thus p has to
find another idle CPU.

Proposal:
Inspired by Mathieu's idea[1], introduce the SIS_CACHE. It considers
the sleep time of the task for better task placement. Based on the
task's short sleeping history, keep p's previous CPU idle for a short
while. Later when p is woken up, it can choose its previous CPU in
select_idle_sibling(). When p's previous CPU is reserved, another wakee
is not allowed to choose this CPU in select_idle_idle(). The reservation
period is set to the task's average short sleep time, AKA, se->sis_rsv_avg.

This does not break the work conservation of the scheduler, because
wakee will still try its best to find an idle CPU. The difference is that
different idle CPUs might have different priorities.

Prateek pointed out that, with SIS_CACHE enabled, if all idle CPUs are
cache-hot, select_idle_cpu() might have to choose a non-idle target CPU,
which brings task stacking. Mitigate this by returning the first cache-hot
idle CPU if no cache-cold CPU is found.

Benchmarks:
Tested on Intel Xeon Sapphire Rapids, 56C/112T x 2 sockets. CPU frequency
governor is set to performance, CPU C-state deeper than C1 are disabled.
There is noticeable improvement of netperf/tbench under 100% load.
0.7% improvement is observed on an OLTP (on-line transaction processing)
benchmark.

hackbench throughput
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	1-groups	 1.00 (  4.34)	 +8.43 ( 10.67)
process-pipe    	2-groups	 1.00 (  7.02)	 +0.48 (  6.66)
process-pipe    	4-groups	 1.00 (  1.69)	 +3.06 (  5.26)
process-sockets 	1-groups	 1.00 (  3.35)	 +0.51 (  0.99)
process-sockets 	2-groups	 1.00 (  3.56)	 +1.56 (  0.85)
process-sockets 	4-groups	 1.00 (  0.10)	 -0.10 (  0.07)
threads-pipe    	1-groups	 1.00 (  9.86)	 +8.21 (  0.46)
threads-pipe    	2-groups	 1.00 ( 12.26)	 +1.95 (  7.06)
threads-pipe    	4-groups	 1.00 (  8.33)	 -5.81 (  7.16)
threads-sockets 	1-groups	 1.00 (  1.77)	 +0.41 (  2.29)
threads-sockets 	2-groups	 1.00 (  5.26)	 -7.86 (  9.41)
threads-sockets 	4-groups	 1.00 (  0.04)	 +0.02 (  0.08)

netperf throughput
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	56-threads	 1.00 (  1.57)	 +0.08 (  1.23)
TCP_RR          	112-threads	 1.00 (  1.01)	 -0.41 (  0.28)
TCP_RR          	168-threads	 1.00 (  0.95)	 -1.00 (  0.70)
TCP_RR          	224-threads	 1.00 (  0.70)	+119.95 ( 34.26)
TCP_RR          	280-threads	 1.00 ( 16.77)	 -0.37 ( 17.40)
TCP_RR          	336-threads	 1.00 ( 20.37)	 -0.33 ( 22.35)
TCP_RR          	392-threads	 1.00 ( 28.30)	 -0.48 ( 31.66)
TCP_RR          	448-threads	 1.00 ( 39.48)	 -0.13 ( 38.72)
UDP_RR          	56-threads	 1.00 (  1.47)	 -0.09 (  1.57)
UDP_RR          	112-threads	 1.00 (  7.88)	 -0.05 (  9.98)
UDP_RR          	168-threads	 1.00 ( 10.48)	 -1.27 ( 16.89)
UDP_RR          	224-threads	 1.00 ( 15.08)	 -2.13 ( 23.49)
UDP_RR          	280-threads	 1.00 ( 21.16)	 +0.17 ( 23.05)
UDP_RR          	336-threads	 1.00 ( 24.41)	 +0.46 ( 22.11)
UDP_RR          	392-threads	 1.00 ( 27.58)	 +0.01 ( 29.47)
UDP_RR          	448-threads	 1.00 ( 37.33)	 +0.08 ( 56.11)

tbench throughput
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	56-threads	 1.00 (  1.87)	 -0.45 (  2.10)
loopback        	112-threads	 1.00 (  0.21)	 -0.86 (  0.12)
loopback        	168-threads	 1.00 (  0.08)	 -2.47 (  0.21)
loopback        	224-threads	 1.00 (  2.57)	+13.39 (  0.79)
loopback        	280-threads	 1.00 (  0.20)	 -0.07 (  0.39)
loopback        	336-threads	 1.00 (  0.14)	 +0.14 (  0.22)
loopback        	392-threads	 1.00 (  0.32)	 +0.25 (  0.23)
loopback        	448-threads	 1.00 (  0.87)	 +1.45 (  0.17)

schbench 99.0th latency
========
case            	load    	baseline(std%)	compare%( std%)
normal          	1-mthreads	 1.00 (  0.36)	 +1.02 (  0.63)
normal          	2-mthreads	 1.00 (  2.44)	 -3.74 (  3.92)
normal          	4-mthreads	 1.00 (  3.14)	 +4.17 (  3.87)

Analysis:
Gautham is interested in the reason why waking up the task on its previous
CPU brings benefits. The following digs into that.

Take netperf 224 case as an example, the reason why netperf improves a
lot is due to less task migration brings better cache locality. Described
as below.

bpftrace script to track the migration number within 10 seconds:
kretfunc:select_task_rq_fair
{
        $p = (struct task_struct *)args->p;
        if ($p->comm == "netperf") {
                if ($p->thread_info.cpu != retval) {
                        @wakeup_migrate_netperf = count();
                } else {
                        @wakeup_prev_netperf = count();
                }
        }
}

interval:s:10
{
        time("\n%H:%M:%S Wakeup statistics: \n");
        print(@wakeup_migrate_netperf);
        clear(@wakeup_migrate_netperf);
        print(@wakeup_prev_netperf);
        clear(@wakeup_prev_netperf);
}

NO_SIS_CACHE:
@wakeup_migrate_netperf: 48002669
@wakeup_prev_netperf:    14853103

SIS_CACHE:
@wakeup_migrate_netperf: 571
@wakeup_prev_netperf: 136620030

The ratio the task migration has been reduced a lot with SIS_CACHE.

perf topdown to track the PMU events, by running the following commands:
perf stat -M TopdownL1 -- sleep 10
perf stat -M tma_backend_bound_group -- sleep 10
perf stat -M tma_core_bound_group -- sleep 10
perf stat -M tma_ports_utilization_group -- sleep 10
perf stat -M tma_memory_bound_group -- sleep 10

NO_SIS_CACHE:
19.1 %  tma_backend_bound     <--------
        7.1 %  tma_core_bound
               0.2 %  tma_divider
               35.0 %  tma_ports_utilization
                       13.9 %  tma_ports_utilized_0
                       15.0 %  tma_ports_utilized_1
                       16.5 %  tma_ports_utilized_3m
        8.3 %  tma_memory_bound
               4.8 %  tma_dram_bound
               2.1 %  tma_l2_bound
14.4 %  tma_bad_speculation
43.0 %  tma_frontend_bound
23.4 %  tma_retiring

SIS_CACHE:
5.4 %   tma_backend_bound     <--------
        7.5 %  tma_core_bound
               0.2 %  tma_divider
               39.8 %  tma_ports_utilization
                       13.9 %  tma_ports_utilized_0
                       15.3 %  tma_ports_utilized_1
                       16.5 %  tma_ports_utilized_3m
        6.7 %  tma_memory_bound
               4.5 %  tma_dram_bound
               2.2 %  tma_l2_bound
16.6 %  tma_bad_speculation
44.7 %  tma_frontend_bound
33.3 %  tma_retiring

The tma_backend_bound ratio has been decreased a lot. Inside the backend
bound metrics, the tma_ports_utilized_x is the fraction of cycles CPU
executed x uops per cycle on all execution ports(on this platform it is
the Logical Processor cycles). It is the RESOURCE_STALLS cycles on this
Logical Processor. It reflects that waking up on its previous logical
CPU would reduce the cycle on uops execution. Meanwhile, the l2_bound
is also reduced due to higher L2 cache locality.

The reason why netperf has improvement on TCP_RR over UDP_RR might be
that, the TCP_RR has a shorter sleep time than UDP_RR(per the bpftrace
result), which could be easier to be detected and taken care of by
SIS_CACHE. TCP has to maintain a connection between the sender and
receiver, so the CPU needs to do more CPU work before falling asleep.
UDP is much faster to finish the package sending and enters sleep more
frequently.

Limitations:
As pointed out by Gautham, some other tasks could be woken up on that
reservation CPU due to:

  1) wake-affine choosing that CPU
  2) newidle-balance pulling the other task on that CPU
  3) !wake-affine && that CPU was also the other task's previous CPU

Currently, we do not deal with these cases and only propose a simple enough
method, later there could be some incremental optimizations.

Link: https://lore.kernel.org/lkml/20230905171105.1005672-2-mathieu.desnoyers@efficios.com/ #1
Suggested-by: Tim Chen <tim.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c     | 65 ++++++++++++++++++++++++++++++++++++++---
 kernel/sched/features.h |  1 +
 kernel/sched/sched.h    |  1 +
 3 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 297b9470829c..12a8b4594dff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6632,6 +6632,21 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	hrtick_update(rq);
 	now = sched_clock_cpu(cpu_of(rq));
 	p->se.prev_dequeue_time = task_sleep ? now : 0;
+#ifdef CONFIG_SMP
+	/*
+	 * If this rq will become idle, and if the dequeued
+	 * task is a short sleeping one, check if we can reserve
+	 * this idle CPU for that task for a short while.
+	 * During this reservation period, other wakees will
+	 * skip this 'idle' CPU in select_idle_cpu(), and this
+	 * short sleeping task can pick its previous CPU in
+	 * select_idle_sibling(), which brings better cache
+	 * locality.
+	 */
+	if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running &&
+	    p->se.sis_rsv_avg)
+		rq->cache_hot_timeout = max(rq->cache_hot_timeout, now + p->se.sis_rsv_avg);
+#endif
 }
 
 #ifdef CONFIG_SMP
@@ -6982,6 +6997,25 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 	return new_cpu;
 }
 
+/*
+ * If a short sleeping task has once run on this idle CPU
+ * not long ago, return 1 to indicate that the CPU is still
+ * cache-hot for that task, and no one except for that task
+ * should pick this cache-hot CPU during wakeup.
+ *
+ * The CPU is expected to be idle when invoking this function.
+ */
+static int cache_hot_cpu(int cpu)
+{
+	if (!sched_feat(SIS_CACHE))
+		return 0;
+
+	if (sched_clock_cpu(cpu) >= cpu_rq(cpu)->cache_hot_timeout)
+		return 0;
+
+	return 1;
+}
+
 static inline int __select_idle_cpu(int cpu, struct task_struct *p)
 {
 	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
@@ -7125,7 +7159,7 @@ static inline int select_idle_smt(struct task_struct *p, int target)
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
-	int i, cpu, idle_cpu = -1, nr = INT_MAX;
+	int i, cpu, idle_cpu = -1, nr = INT_MAX, first_hot_cpu = -1;
 	struct sched_domain_shared *sd_share;
 	struct rq *this_rq = this_rq();
 	int this = smp_processor_id();
@@ -7180,18 +7214,41 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
-			if ((unsigned int)i < nr_cpumask_bits)
+			/*
+			 * Only the cache-cold idle CPU is returned. If no
+			 * cache-cold CPU is found, choose the first idle cpu
+			 * stored in idle_cpu.
+			 */
+			if ((unsigned int)i < nr_cpumask_bits && !cache_hot_cpu(i))
 				return i;
 
 		} else {
 			if (!--nr)
 				return -1;
 			idle_cpu = __select_idle_cpu(cpu, p);
-			if ((unsigned int)idle_cpu < nr_cpumask_bits)
-				break;
+			if ((unsigned int)idle_cpu < nr_cpumask_bits) {
+				if (!cache_hot_cpu(idle_cpu)) {
+					first_hot_cpu = -1;
+					break;
+				}
+
+				/*
+				 * Record the first cache-hot idle CPU
+				 * as the last resort. This is to deal
+				 * with the case that, every CPU is
+				 * cache-hot, and we want to choose an
+				 * idle CPU over a non-idle target CPU.
+				 */
+				if (first_hot_cpu == -1)
+					first_hot_cpu = idle_cpu;
+			}
 		}
 	}
 
+	/* all idle CPUs are cache-hot, choose the first cache-hot one */
+	if (first_hot_cpu != -1)
+		idle_cpu = first_hot_cpu;
+
 	if (has_idle_core)
 		set_idle_cores(target, false);
 
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
index 887468c48ff6..7aa728289395 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1079,6 +1079,7 @@ struct rq {
 #endif
 	u64			idle_stamp;
 	u64			avg_idle;
+	u64			cache_hot_timeout;
 
 	unsigned long		wake_stamp;
 	u64			wake_avg_idle;
-- 
2.25.1


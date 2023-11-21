Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634D07F268A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjKUHlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjKUHlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:41:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA06110C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700552478; x=1732088478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rwOMzL38TQAcQogt+9N+0DIqcb4pS3AdZb0OQ+1utqQ=;
  b=Q43qAnClPHXpydnhHDAKJdJ1Xj5gB+bVGs62epE1F3dAWP/lRL/aLWhl
   FWycfQhrB+f0rlpzgAKQ6jNj+H+il861QvcMhJTn+JjdHGt9fqMYCIulo
   gTRDdYudTBlBRnwQLz/4IGmKVhuECwukzA0+eKy6IcSysWksrgTe8r0y9
   aqR1BNERI7uCIIHj8Q5Y5qWSwPql9VG7QPlIp2izTZGBxQZl8WTpQPMwL
   lBxKdaEAqBgQtB4MBAQam0/LrGoyxOiPO3jkLAQa3enYAkZfGzAmW++qH
   UlNsrEF5lUGygK56h0fyFzZm9TcvwZgC6kfvkFGSo98vCl9BDUO/4938V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4978292"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="4978292"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 23:41:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="836972502"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="836972502"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmsmga004.fm.intel.com with ESMTP; 20 Nov 2023 23:41:13 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v2 3/3] sched/fair: do not scribble cache-hot CPU in select_idle_cpu()
Date:   Tue, 21 Nov 2023 15:40:14 +0800
Message-Id: <35e612eb2851693a52f7ed1ff9be5bc24011136f.1700548379.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1700548379.git.yu.c.chen@intel.com>
References: <cover.1700548379.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
Introduce the SIS_CACHE. It considers the sleep time of the task for
better task placement. Based on the task's short sleeping history,
tag p's previous CPU as cache-hot. Later when p is woken up, it can
choose its previous CPU in select_idle_sibling(). When other task is
woken up, skip this cache-hot idle CPU when possible.

SIS_CACHE still prefers to choose an idle CPU during task wakeup,
the idea is to optimize the idle CPU scan sequence.

As pointed out by Prateek, this has the potential that all idle CPUs
are cache-hot and skipped. Mitigate this by returning the first
cache-hot idle CPU. Meanwhile, to reduce the time spend on scanning,
limit the max number of cache-hot CPU search depth to half of the number
suggested by SIS_UTIL.

Tested on Xeon 2 x 60C/120T platforms:

netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	60-threads	 1.00 (  1.37)	 +0.04 (  1.47)
TCP_RR          	120-threads	 1.00 (  1.77)	 -1.03 (  1.31)
TCP_RR          	180-threads	 1.00 (  2.03)	 +1.25 (  1.66)
TCP_RR          	240-threads	 1.00 ( 41.31)	+73.71 ( 22.02)
TCP_RR          	300-threads	 1.00 ( 12.79)	 -0.11 ( 15.84)

tbench
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	60-threads	 1.00 (  0.35)	 +0.40 (  0.31)
loopback        	120-threads	 1.00 (  1.94)	 -1.89 (  1.17)
loopback        	180-threads	 1.00 ( 13.59)	 +9.97 (  0.93)
loopback        	240-threads	 1.00 ( 11.68)	+42.85 (  7.28)
loopback        	300-threads	 1.00 (  4.47)	+15.12 (  1.40)

hackbench
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	1-groups	 1.00 (  9.21)	 -7.88 (  2.03)
process-pipe    	2-groups	 1.00 (  7.09)	 +5.47 (  9.02)
process-pipe    	4-groups	 1.00 (  1.60)	 +1.53 (  1.70)

schbench
========
case            	load    	baseline(std%)	compare%( std%)
normal          	1-mthreads	 1.00 (  0.98)	 +0.26 (  0.37)
normal          	2-mthreads	 1.00 (  3.99)	 -7.97 (  7.33)
normal          	4-mthreads	 1.00 (  3.07)	 -1.55 (  3.27)

Also did some experiments on the OLTP workload on a 112 core 2 socket
SPR machine. The OLTP workload have a mixture of threads handling
database updates on disks and handling transaction queries over network.
Around 0.7% improvement is observed with less than 0.2% run-to-run
variation.

Thanks Madadi for testing the SIS_CACHE on a power system with 96 CPUs.
The results showed a max of 29% improvements in hackbench, 13% improvements
in producer_consumer workload, and 2% improvements in real life workload
named Daytrader.

Thanks Prateek for running microbenchmarks on top of the latest patch on
a 3rd Generation EPYC System:
- 2 sockets each with 64C/128T
- NPS1 (Each socket is a NUMA node)
- C2 Disabled (POLL and C1(MWAIT) remained enabled)
No consistent regression was observed in v2 version.

Analysis:
The reason why waking up the task on its previous CPU brings benefits
is due to less task migration and higher local resource locality.

Take netperf 240 case as an example, run the following script
to track the migration number within 10 seconds. Use perf topdown
to track the PMU events. The task migration and stall cycles
have been reduced a lot with SIS_CACHE:

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

NO_SIS_CACHE:
@wakeup_migrate_netperf: 57473509
@wakeup_prev_netperf: 14935964
RESOURCE_STALLS: 19.1% * 7.1% * 35.0%

SIS_CACHE:
@wakeup_migrate_netperf: 799
@wakeup_prev_netperf: 132937436
RESOURCE_STALLS: 5.4% * 7.5% * 39.8%

Suggested-by: Tim Chen <tim.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c309b3d203c0..d149eca74fca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7360,7 +7360,7 @@ static inline int select_idle_smt(struct task_struct *p, int target)
  * Return true if the idle CPU is cache-hot for someone,
  * return false otherwise.
  */
-static __maybe_unused bool cache_hot_cpu(int cpu, int *hot_cpu)
+static bool cache_hot_cpu(int cpu, int *hot_cpu)
 {
 	if (!sched_feat(SIS_CACHE))
 		return false;
@@ -7383,7 +7383,7 @@ static __maybe_unused bool cache_hot_cpu(int cpu, int *hot_cpu)
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
-	int i, cpu, idle_cpu = -1, nr = INT_MAX;
+	int i, cpu, idle_cpu = -1, nr = INT_MAX, nr_hot = 0, hot_cpu = -1;
 	struct sched_domain_shared *sd_share;
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
@@ -7396,6 +7396,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 			/* overloaded LLC is unlikely to have idle cpu/core */
 			if (nr == 1)
 				return -1;
+
+			/* max number of cache-hot idle cpu check */
+			nr_hot = nr >> 1;
 		}
 	}
 
@@ -7426,18 +7429,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
-			if ((unsigned int)i < nr_cpumask_bits)
+			if ((unsigned int)i < nr_cpumask_bits) {
+				if (--nr_hot >= 0 && cache_hot_cpu(i, &hot_cpu))
+					continue;
+
 				return i;
+			}
 
 		} else {
 			if (--nr <= 0)
 				return -1;
 			idle_cpu = __select_idle_cpu(cpu, p);
-			if ((unsigned int)idle_cpu < nr_cpumask_bits)
+			if ((unsigned int)idle_cpu < nr_cpumask_bits) {
+				if (--nr_hot >= 0 && cache_hot_cpu(idle_cpu, &hot_cpu))
+					continue;
+
 				break;
+			}
 		}
 	}
 
+	/* pick the first cache-hot CPU as the last resort */
+	if (idle_cpu == -1 && hot_cpu != -1)
+		idle_cpu = hot_cpu;
+
 	if (has_idle_core)
 		set_idle_cores(target, false);
 
-- 
2.25.1


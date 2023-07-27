Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8D1764701
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjG0Gji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjG0Gjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:39:35 -0400
Received: from mgamail.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4D01FFC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690439967; x=1721975967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hP7V3JXYo3iPIjXM13Kdhb3K2U4aYRXUttqz2K7TE7g=;
  b=Y1Va/xU0wMdKNv/XcKgr94xeKXMR6Hk6HwHXcceFLp5y4yMHXF4h5/Q6
   2uJa0uroGVzcg3S7143J9x9t9CM40pj8AhR5S35ZjDYZcPUXdwE5J45Bf
   9lfOvoUVvdI96eZHD8EXqBru6zN0P66Hs94dUiSZ3H8KwAF+2o8aZyIMD
   gjFoUiQEf7fpuD1XtUz8zMfIi6TJN2hTbBshOv7rb6bm4YuZyEjTBbHlz
   q8Q6km2De72srt6Pt34CjizIpMZ0uC0srBcaeBlKWkIPx2YgBWF2omFJm
   dt8CdWwoZTXLAIuePBaEp/bX+zryHQN/z31rRsZxzrv1twXEEV4NmuiYx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="365681560"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="365681560"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 23:39:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="816993073"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="816993073"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jul 2023 23:39:22 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH 5/7] sched/fair: Adjust the busiest group scanning depth in idle load balance
Date:   Thu, 27 Jul 2023 22:35:13 +0800
Message-Id: <98e26a26832669b4293a50a701f9b3b8d44e4863.1690273854.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690273854.git.yu.c.chen@intel.com>
References: <cover.1690273854.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scanning the whole sched domain to find the busiest group is time costly
during newidle_balance(). And if a CPU becomes idle, it would be good
if this idle CPU pulls some tasks from other CPUs as quickly as possible.

Limit the scan depth of newidle_balance() to only scan for a limited number
of sched groups to find a relatively busy group, and pull from it.
In summary, the more spare time there is in the domain, the more time
each newidle balance can spend on scanning for a busy group. Although
the newidle balance has per domain max_newidle_lb_cost to decide
whether to launch the balance or not, the ILB_UTIL provides a smaller
granularity to decide how many groups each newidle balance can scan.

The scanning depth is calculated by the previous periodic load balance
based on its overall utilization.

Tested on top of v6.5-rc2, Sapphire Rapids with 2 x 56C/112T = 224 CPUs.
With cpufreq governor set to performance, and C6 disabled.

Firstly, tested on a extreme synthetic test[1], which launches 224
process. Each process is a loop of nanosleep(1 us), which is supposed
to trigger newidle balance as much as possible:

i=1;while [ $i -le "224" ]; do ./nano_sleep 1000 & i=$(($i+1)); done;

NO_ILB_UTIL + ILB_SNAPSHOT:
9.38%     0.45%  [kernel.kallsyms]   [k] newidle_balance
6.84%     5.32%  [kernel.kallsyms]   [k] update_sd_lb_stats.constprop.0

ILB_UTIL + ILB_SNAPSHOT:
3.35%     0.38%  [kernel.kallsyms]   [k] newidle_balance
2.30%     1.81%  [kernel.kallsyms]   [k] update_sd_lb_stats.constprop.0

With ILB_UTIL enabled, the total number of newidle_balance() and
update_sd_lb() drops. But the reason for why there are less newidle
balance has not been investigated. According to the low util_avg value
in /sys/kernel/debug/sched/debug, there should be no much impact
on the nanosleep stress test.

Test in a wider range:

[netperf]
Launches nr instances of:
netperf -4 -H 127.0.0.1 -t $work_mode -c -C -l 100 &

nr: 56, 112, 168, 224, 280, 336, 392, 448
work_mode: TCP_RR UDP_RR

throughput
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	56-threads	 1.00 (  5.15)	 -3.96 (  2.17)
TCP_RR          	112-threads	 1.00 (  2.84)	 -0.82 (  2.24)
TCP_RR          	168-threads	 1.00 (  2.11)	 -0.03 (  2.31)
TCP_RR          	224-threads	 1.00 (  1.76)	 +0.01 (  2.12)
TCP_RR          	280-threads	 1.00 ( 62.46)	+56.56 ( 56.91)
TCP_RR          	336-threads	 1.00 ( 19.81)	 +0.27 ( 17.90)
TCP_RR          	392-threads	 1.00 ( 30.85)	 +0.13 ( 29.09)
TCP_RR          	448-threads	 1.00 ( 39.71)	-18.82 ( 45.93)
UDP_RR          	56-threads	 1.00 (  2.08)	 -0.31 (  7.89)
UDP_RR          	112-threads	 1.00 (  3.22)	 -0.50 ( 15.19)
UDP_RR          	168-threads	 1.00 ( 11.77)	 +0.37 ( 10.30)
UDP_RR          	224-threads	 1.00 ( 14.03)	 +0.25 ( 12.88)
UDP_RR          	280-threads	 1.00 ( 16.83)	 -0.57 ( 15.34)
UDP_RR          	336-threads	 1.00 ( 22.57)	 +0.01 ( 24.68)
UDP_RR          	392-threads	 1.00 ( 33.89)	 +2.65 ( 33.89)
UDP_RR          	448-threads	 1.00 ( 44.18)	 +0.81 ( 41.28)

Considering the std%, there is no much difference to netperf.

[tbench]
tbench -t 100 $job 127.0.0.1
job: 56, 112, 168, 224, 280, 336, 392, 448

throughput
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	56-threads	 1.00 (  2.20)	 -0.09 (  2.05)
loopback        	112-threads	 1.00 (  0.29)	 -0.88 (  0.10)
loopback        	168-threads	 1.00 (  0.02)	+62.92 ( 54.57)
loopback        	224-threads	 1.00 (  0.05)	+234.30 (  1.81)
loopback        	280-threads	 1.00 (  0.08)	 -0.11 (  0.21)
loopback        	336-threads	 1.00 (  0.17)	 -0.17 (  0.08)
loopback        	392-threads	 1.00 (  0.14)	 -0.09 (  0.18)
loopback        	448-threads	 1.00 (  0.24)	 -0.53 (  0.55)

There are improvement of tbench in 224 threads case.

[hackbench]

hackbench -g $job --$work_type --pipe -l 200000 -s 100 -f 28
and
hackbench -g $job --$work_type -l 200000 -s 100 -f 28

job: 1, 2, 4, 8
work_type: process threads

throughput
==========
case                    load            baseline(std%)  compare%( std%)
process-pipe            1-groups         1.00 (  0.20)   +1.57 (  0.58)
process-pipe            2-groups         1.00 (  3.53)   +2.99 (  2.03)
process-pipe            4-groups         1.00 (  1.07)   +0.17 (  1.64)
process-sockets         1-groups         1.00 (  0.36)   -0.04 (  1.44)
process-sockets         2-groups         1.00 (  0.84)   +0.65 (  1.65)
process-sockets         4-groups         1.00 (  0.04)   +0.89 (  0.08)
threads-pipe            1-groups         1.00 (  3.62)   -0.53 (  1.67)
threads-pipe            2-groups         1.00 (  4.17)   -4.79 (  0.53)
threads-pipe            4-groups         1.00 (  5.30)   +5.06 (  1.95)
threads-sockets         1-groups         1.00 (  0.40)   +1.44 (  0.53)
threads-sockets         2-groups         1.00 (  2.54)   +2.21 (  2.51)
threads-sockets         4-groups         1.00 (  0.05)   +1.29 (  0.05)

No much difference of hackbench.

[schbench(old)]
schbench -m $job -t 56 -r 30
job: 1, 2, 4, 8
3 iterations

99.0th latency
========
case                    load            baseline(std%)  compare%( std%)
normal                  1-mthreads       1.00 (  0.56)   -0.91 (  0.32)
normal                  2-mthreads       1.00 (  0.95)   -4.05 (  3.63)
normal                  4-mthreads       1.00 (  4.04)   -0.30 (  2.35)

No much difference of schbench.

[Limitation]
In the previous version, Prateek reported a regression. That could be
due to the concurrent access across the Numa node, or ILB_UTIL did not
scan hard enough to pull from the busiest group. The former issue is
fixed by not enabling ILB_UTIL for Numa domain. If there is still
regression in this version, we can leverage the result of SIS_UTIL,
to provide a quadratic function rather than the linear function, to
scan harder when the system is idle.

Link: https://raw.githubusercontent.com/chen-yu-surf/tools/master/stress_nanosleep.c #1
Suggested-by: Tim Chen <tim.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6925813db59b..4e360ed16e14 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10195,7 +10195,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
 	unsigned long sum_util = 0;
-	int sg_status = 0;
+	int sg_status = 0, nr_sg_scan;
+	/* only newidle CPU can load the snapshot */
+	bool ilb_can_load = env->idle == CPU_NEWLY_IDLE &&
+			    sd_share && READ_ONCE(sd_share->total_capacity);
+
+	if (sched_feat(ILB_UTIL) && ilb_can_load)
+		nr_sg_scan = sd_share->nr_sg_scan;
 
 	do {
 		struct sg_lb_stats *sgs = &tmp_sgs;
@@ -10222,6 +10228,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 			sds->busiest_stat = *sgs;
 		}
 
+		if (sched_feat(ILB_UTIL) && ilb_can_load && --nr_sg_scan <= 0)
+			goto load_snapshot;
+
 next_group:
 		/* Now, start updating sd_lb_stats */
 		sds->total_load += sgs->group_load;
@@ -10231,6 +10240,15 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		sg = sg->next;
 	} while (sg != env->sd->groups);
 
+	ilb_can_load = false;
+
+load_snapshot:
+	if (ilb_can_load) {
+		/* borrow the statistic of previous periodic load balance */
+		sds->total_load = READ_ONCE(sd_share->total_load);
+		sds->total_capacity = READ_ONCE(sd_share->total_capacity);
+	}
+
 	/*
 	 * Indicate that the child domain of the busiest group prefers tasks
 	 * go to a child's sibling domains first. NB the flags of a sched group
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F85764705
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjG0Gj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjG0Gjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:39:41 -0400
Received: from mgamail.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF8026A4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690439979; x=1721975979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qlxopXTa2XESRuc0f7vj5sTVsk6dibKkwBX9ydkssyI=;
  b=X1p47Bdw0Xel/zgU8EPZeb8N74Ppt9zvbyQEk/HzW/oUIXAN93SGzla2
   dVgQ6Ua/8MAiB8Fa0vejwTf7lx5CkO0TtHKu+hX7CQ+6N2jxXrGwfbPMo
   b2SNO6blzLX0/LWGFIEFnefPhPJ2DNy6nUX+xvjU43TqPktu0xPGntpfi
   Emqboa1iZnkU/pbiz8E3mXWv7vHFSMfJcHefNvu5VoB+nE7XV6/DwgcRY
   9sV6aoWFdFjr9fhWtJvS+mT0GS1m2+TlziRRMhwyqCaiA8Mwat9IIvoTZ
   TRBpkolB5wRURxaMoZVwta5rJTgqiJRSuNBqEFTPwYaCFn7+QNNUHJmL3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="454589597"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="454589597"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 23:39:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="792191903"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="792191903"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2023 23:39:33 -0700
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
Subject: [RFC PATCH 6/7] sched/fair: Pull from a relatively busy group during newidle balance
Date:   Thu, 27 Jul 2023 22:35:24 +0800
Message-Id: <c2d22f41258c003f2d011867faae140f5d2f952f.1690273854.git.yu.c.chen@intel.com>
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

Scanning the whole sched domain to find the busiest group is time
costly during newidle_balance() on a high core count system.

Introduce ILB_FAST to lower the bar during the busiest group
scanning. If the target sched group is relatively busier than the
local group, terminate the scan and try to pull from that group
directly.

Compared between ILB_UTIL and ILB_FAST, the former inhibits the
sched group scan when the system is busy. While the latter
choose a compromised busy group when the system is not busy.
So they are complementary to each other and work independently.

Tested on top of v6.5-rc2,
Sapphire Rapids with 2 x 56C/112T = 224 CPUs.
With cpufreq governor set to performance, and C6 disabled.

Firstly, tested on an extreme synthetic test[1] borrowed from
Tianyou. It launches 224 process. Each process is a loop of
nanosleep(1 us), which is supposed to trigger newidle balance
frequently:

i=1;while [ $i -le "224" ]; do ./nano_sleep 1000 & i=$(($i+1)); done;

[ILB_SNAPSHOT + NO_ILB_UTIL + NO_ILB_FAST]
Check the /proc/schedstat delta on CPU8 within 5 seconds using
the following script[2] by running: schedstat.py -i 5 -c 8

Mon Jul 24 23:43:43 2023              cpu8
.domain0.CPU_IDLE.lb_balanced          843
.domain0.CPU_IDLE.lb_count             843
.domain0.CPU_IDLE.lb_nobusyg           843
.domain0.CPU_IDLE.lb_sg_scan           843
.domain0.CPU_NEWLY_IDLE.lb_balanced    836
.domain0.CPU_NEWLY_IDLE.lb_count       837
.domain0.CPU_NEWLY_IDLE.lb_gained       1
.domain0.CPU_NEWLY_IDLE.lb_imbalance    1
.domain0.CPU_NEWLY_IDLE.lb_nobusyg     836
.domain0.CPU_NEWLY_IDLE.lb_sg_scan     837
.domain1.CPU_IDLE.lb_balanced          41
.domain1.CPU_IDLE.lb_count             41
.domain1.CPU_IDLE.lb_nobusyg           39
.domain1.CPU_IDLE.lb_sg_scan          2145
.domain1.CPU_NEWLY_IDLE.lb_balanced    732     <-----
.domain1.CPU_NEWLY_IDLE.lb_count       822     <-----
.domain1.CPU_NEWLY_IDLE.lb_failed      90
.domain1.CPU_NEWLY_IDLE.lb_imbalance   90
.domain1.CPU_NEWLY_IDLE.lb_nobusyg     497
.domain1.CPU_NEWLY_IDLE.lb_nobusyq     235
.domain1.CPU_NEWLY_IDLE.lb_sg_scan    45210    <-----
.domain1.ttwu_wake_remote              626
.domain2.CPU_IDLE.lb_balanced          15
.domain2.CPU_IDLE.lb_count             15
.domain2.CPU_NEWLY_IDLE.lb_balanced    635
.domain2.CPU_NEWLY_IDLE.lb_count       655
.domain2.CPU_NEWLY_IDLE.lb_failed      20
.domain2.CPU_NEWLY_IDLE.lb_imbalance   40
.domain2.CPU_NEWLY_IDLE.lb_nobusyg     633
.domain2.CPU_NEWLY_IDLE.lb_nobusyq      2
.domain2.CPU_NEWLY_IDLE.lb_sg_scan     655
.stats.rq_cpu_time                   227910772
.stats.rq_sched_info.pcount           89393
.stats.rq_sched_info.run_delay       2145671
.stats.sched_count                   178783
.stats.sched_goidle                   89390
.stats.ttwu_count                     89392
.stats.ttwu_local                     88766

For domain1, there are 822 newidle balance attempt, and
the total number of groups scanned is 45210, thus each
balance would scan for 55 groups. During this 822 balance,
732 becomes(or are already) balanced, so the effect balance
success ratio is (822 - 732) / 822 = 10.94%

The perf:
9.38%     0.45%  [kernel.kallsyms]   [k] newidle_balance
6.84%     5.32%  [kernel.kallsyms]   [k] update_sd_lb_stats.constprop.0

[ILB_SNAPSHOT + NO_ILB_UTIL + ILB_FAST]
Mon Jul 24 23:43:50 2023              cpu8
.domain0.CPU_IDLE.lb_balanced          918
.domain0.CPU_IDLE.lb_count             918
.domain0.CPU_IDLE.lb_nobusyg           918
.domain0.CPU_IDLE.lb_sg_scan           918
.domain0.CPU_NEWLY_IDLE.lb_balanced   1536
.domain0.CPU_NEWLY_IDLE.lb_count      1545
.domain0.CPU_NEWLY_IDLE.lb_failed       1
.domain0.CPU_NEWLY_IDLE.lb_gained       8
.domain0.CPU_NEWLY_IDLE.lb_imbalance    9
.domain0.CPU_NEWLY_IDLE.lb_nobusyg    1536
.domain0.CPU_NEWLY_IDLE.lb_sg_scan    1545
.domain1.CPU_IDLE.lb_balanced          45
.domain1.CPU_IDLE.lb_count             45
.domain1.CPU_IDLE.lb_nobusyg           43
.domain1.CPU_IDLE.lb_sg_scan          2365
.domain1.CPU_NEWLY_IDLE.lb_balanced   1196     <------
.domain1.CPU_NEWLY_IDLE.lb_count      1496     <------
.domain1.CPU_NEWLY_IDLE.lb_failed      296
.domain1.CPU_NEWLY_IDLE.lb_gained       4
.domain1.CPU_NEWLY_IDLE.lb_imbalance   301
.domain1.CPU_NEWLY_IDLE.lb_nobusyg    1182
.domain1.CPU_NEWLY_IDLE.lb_nobusyq     14
.domain1.CPU_NEWLY_IDLE.lb_sg_scan    30127    <------
.domain1.ttwu_wake_remote             2688
.domain2.CPU_IDLE.lb_balanced          13
.domain2.CPU_IDLE.lb_count             13
.domain2.CPU_NEWLY_IDLE.lb_balanced    898
.domain2.CPU_NEWLY_IDLE.lb_count       904
.domain2.CPU_NEWLY_IDLE.lb_failed       6
.domain2.CPU_NEWLY_IDLE.lb_imbalance   11
.domain2.CPU_NEWLY_IDLE.lb_nobusyg     896
.domain2.CPU_NEWLY_IDLE.lb_nobusyq      2
.domain2.CPU_NEWLY_IDLE.lb_sg_scan     904
.stats.rq_cpu_time                   239830575
.stats.rq_sched_info.pcount           90879
.stats.rq_sched_info.run_delay       2436461
.stats.sched_count                   181732
.stats.sched_goidle                   90853
.stats.ttwu_count                     90880
.stats.ttwu_local                     88192

With ILB_FAST enabled, the CPU_NEWLY_IDLE in domain1 on CPU8
is 1496, and the total number of groups scanned is 30127. For
each load balance, it will scan for 20 groups, which is only
half of the 56 groups in a domain. During this 1496 balance,
1196 are balanced, so the effect balance success ratio
is (1496 - 1196) / 1496 = 20.95%, which is higher than 10.94%
when ILB_FAST is disabled.

perf profile:

2.95%     0.38%  [kernel.kallsyms]   [k] newidle_balance
2.00%     1.51%  [kernel.kallsyms]   [k] update_sd_lb_stats.constprop.0

With ILB_FAST enabled, the total update_sd_lb_stats() has dropped a lot.

More benchmark results are shown below.
Baseline is ILB_SNAPSHOT + NO_ILB_UTIL, to compare with
ILB_SNAPSHOT + NO_ILB_UTIL + ILB_FAST

[netperf]
Launches nr instances of:
netperf -4 -H 127.0.0.1 -t $work_mode -c -C -l 100 &

nr: 56, 112, 168, 224, 280, 336, 392, 448
work_mode: TCP_RR UDP_RR

throughput
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	56-threads	 1.00 (  1.83)	 +4.25 (  5.15)
TCP_RR          	112-threads	 1.00 (  2.19)	 +0.96 (  2.84)
TCP_RR          	168-threads	 1.00 (  1.92)	 -0.04 (  2.11)
TCP_RR          	224-threads	 1.00 (  1.98)	 -0.03 (  1.76)
TCP_RR          	280-threads	 1.00 ( 63.11)	 -7.59 ( 62.46)
TCP_RR          	336-threads	 1.00 ( 18.44)	 -0.45 ( 19.81)
TCP_RR          	392-threads	 1.00 ( 26.49)	 -0.09 ( 30.85)
TCP_RR          	448-threads	 1.00 ( 40.47)	 -0.28 ( 39.71)
UDP_RR          	56-threads	 1.00 (  1.83)	 -0.31 (  2.08)
UDP_RR          	112-threads	 1.00 ( 13.77)	 +3.58 (  3.22)
UDP_RR          	168-threads	 1.00 ( 10.97)	 -0.08 ( 11.77)
UDP_RR          	224-threads	 1.00 ( 12.83)	 -0.04 ( 14.03)
UDP_RR          	280-threads	 1.00 ( 13.89)	 +0.35 ( 16.83)
UDP_RR          	336-threads	 1.00 ( 24.91)	 +1.38 ( 22.57)
UDP_RR          	392-threads	 1.00 ( 34.86)	 -0.91 ( 33.89)
UDP_RR          	448-threads	 1.00 ( 40.63)	 +0.70 ( 44.18)

[tbench]
tbench -t 100 $job 127.0.0.1
job: 56, 112, 168, 224, 280, 336, 392, 448

throughput
======
case                    load            baseline(std%)  compare%( std%)
loopback                56-threads       1.00 (  0.89)   +1.51 (  2.20)
loopback                112-threads      1.00 (  0.03)   +1.15 (  0.29)
loopback                168-threads      1.00 ( 53.55)  -37.92 (  0.02)
loopback                224-threads      1.00 ( 61.24)  -43.18 (  0.01)
loopback                280-threads      1.00 (  0.04)   +0.33 (  0.08)
loopback                336-threads      1.00 (  0.35)   +0.40 (  0.17)
loopback                392-threads      1.00 (  0.61)   +0.49 (  0.14)
loopback                448-threads      1.00 (  0.08)   +0.01 (  0.24)

[schbench]
schbench -m $job -t 56 -r 30
job: 1, 2, 4, 8
3 iterations

99.0th latency
========
case                    load            baseline(std%)  compare%( std%)
normal                  1-mthreads       1.00 (  0.56)   -0.45 (  0.32)
normal                  2-mthreads       1.00 (  0.95)   +1.01 (  3.45)
normal                  4-mthreads       1.00 (  4.04)   -0.60 (  1.26)

[hackbench]
hackbench -g $job --$work_type --pipe -l 200000 -s 100 -f 28
and
hackbench -g $job --$work_type -l 200000 -s 100 -f 28

job: 1, 2, 4, 8
work_type: process threads

throughput
=========
case                    load            baseline(std%)  compare%( std%)
process-pipe            1-groups         1.00 (  0.20)   +2.30 (  0.26)
process-pipe            2-groups         1.00 (  3.53)   +6.14 (  2.45)
process-pipe            4-groups         1.00 (  1.07)   -4.58 (  2.58)
process-sockets         1-groups         1.00 (  0.36)   +0.75 (  1.22)
process-sockets         2-groups         1.00 (  0.84)   +1.26 (  1.11)
process-sockets         4-groups         1.00 (  0.04)   +0.97 (  0.11)
threads-pipe            1-groups         1.00 (  3.62)   +3.22 (  2.64)
threads-pipe            2-groups         1.00 (  4.17)   +5.85 (  7.53)
threads-pipe            4-groups         1.00 (  5.30)   -4.14 (  5.39)
threads-sockets         1-groups         1.00 (  0.40)   +3.50 (  3.13)
threads-sockets         2-groups         1.00 (  2.54)   +1.79 (  0.80)
threads-sockets         4-groups         1.00 (  0.05)   +1.33 (  0.03)

Considering the std%, there is no much score difference noticed.
It probably indicates that ILB_FAST has reduced the cost of newidle
balance without hurting the performance.

Link: https://raw.githubusercontent.com/chen-yu-surf/tools/master/stress_nanosleep.c #1
Link: https://raw.githubusercontent.com/chen-yu-surf/tools/master/schedstat.py #2
Suggested-by: Tim Chen <tim.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c     | 37 +++++++++++++++++++++++++++++++++++++
 kernel/sched/features.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4e360ed16e14..9af57b5a24dc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10182,6 +10182,36 @@ static void update_ilb_group_scan(struct lb_env *env,
 		WRITE_ONCE(sd_share->nr_sg_scan, (int)nr_scan);
 }
 
+static bool can_pull_busiest(struct sg_lb_stats *local,
+			     struct sg_lb_stats *busiest)
+{
+	/*
+	 * Check if the local group can pull from the 'busiest'
+	 * group directly. When reaching here, update_sd_pick_busiest()
+	 * has already filtered a candidate.
+	 * The scan in newidle load balance on high core count system
+	 * is costly, thus provide this shortcut to find a relative busy
+	 * group rather than the busiest one.
+	 *
+	 * Only enable this shortcut when the local group is quite
+	 * idle. This is because the total cost of newidle_balance()
+	 * becomes severe when multiple CPUs fall into idle and launch
+	 * newidle_balance() concurrently. And that usually indicates
+	 * a group_has_spare status.
+	 */
+	if (local->group_type != group_has_spare)
+		return false;
+
+	if (busiest->idle_cpus > local->idle_cpus)
+		return false;
+
+	if (busiest->idle_cpus == local->idle_cpus &&
+	    busiest->sum_nr_running <= local->sum_nr_running)
+		return false;
+
+	return true;
+}
+
 /**
  * update_sd_lb_stats - Update sched_domain's statistics for load balancing.
  * @env: The load balancing environment.
@@ -10226,6 +10256,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		if (update_sd_pick_busiest(env, sds, sg, sgs)) {
 			sds->busiest = sg;
 			sds->busiest_stat = *sgs;
+			/*
+			 * Check if this busiest group can be pulled by the
+			 * local group directly.
+			 */
+			if (sched_feat(ILB_FAST) && ilb_can_load &&
+			    can_pull_busiest(local, sgs))
+				goto load_snapshot;
 		}
 
 		if (sched_feat(ILB_UTIL) && ilb_can_load && --nr_sg_scan <= 0)
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 30f6d1a2f235..4d67e0abb78c 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -104,3 +104,4 @@ SCHED_FEAT(BASE_SLICE, true)
 
 SCHED_FEAT(ILB_SNAPSHOT, true)
 SCHED_FEAT(ILB_UTIL, true)
+SCHED_FEAT(ILB_FAST, true)
-- 
2.25.1


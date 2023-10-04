Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1E17B7B01
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241855AbjJDJF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjJDJFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:05:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27316A6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:05:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F97DDA7;
        Wed,  4 Oct 2023 02:05:57 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 260423F59C;
        Wed,  4 Oct 2023 02:05:17 -0700 (PDT)
From:   Hongyan Xia <Hongyan.Xia2@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org, Hongyan Xia <Hongyan.Xia2@arm.com>
Subject: [RFC PATCH 0/6] sched: uclamp sum aggregation
Date:   Wed,  4 Oct 2023 10:04:48 +0100
Message-Id: <cover.1696345700.git.Hongyan.Xia2@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation of uclamp leaves many things to be desired.
There are several problems:

1. Max aggregation is fragile. A single task with a high UCLAMP_MAX (or
   with the default value, which is 1024) can ruin the previous
   settings the moment it is enqueued, as shown in the uclamp frequency
   spike problem in Section 5.2 of
   Documentation/scheduler/sched-util-clamp.rst. Constantly running at
   1024 utilization implies that the CPU is driven at its max capacity.
   However, with UCLAMP_MAX, this assumption is no longer true. To
   mitigate this, one idea is to filter out uclamp values for
   short-running tasks. However, the effectiveness of this idea remains
   to be seen.

2. No way to differentiate between UCLAMP_MAX throttled CPU or a CPU
   running at its peak, as both show utilization of 1024. However, in
   certain cases it's important to tell the difference, as we still want
   to take the opportunity to enqueue tasks in the former case.

It's also debatable whether uclamp should be a frequency hint. An
example is a system with a mid CPU of capacity 500, and a little CPU
with capacity 100. If we have 10 tasks with UCLAMP_MIN of 101, then
util_fits_cpu() will schedule them on the mid CPU because feec()
thinks they don't fit on the little, even though we should use the
little core at some point instead of making the mid even more crowded.
Of course, this in reality doesn't happen because of other mechanisms
like load balancing, but it's also not good when other mechanisms can
cancel the effect of uclamp in feec(). A CPU running at capacity 500 for
1ms or for 1000ms gives completely different performance levels, so
trying to fit only the frequency does not give us any performance
guarantees. If we then talk about not only running at some frequency but
also for some amount of time, then what we really mean is a capacity
hint, not a frequency hint.

It's even worse when the tasks scheduled on the mid CPU also have
UCLAMP_MAX values. In the previous example, instead of running at 500, a
single UCLAMP_MAX, assuming it's 110, can make the mid CPU run at a much
lower frequency than 500, so it is then a really bad decision to honor
the UCLAMP_MIN frequency hint and place it on the mid CPU, instead of
running it on the little CPU which is less crowded, and has pretty much
the same capacity (100 vs 110) anyway.

This series attempts to solve these problems by tracking a
util_avg_uclamp signal in tasks and cfs_rq. At task level,
p->se.avg.util_avg_uclamp is basically tracking the normal util_avg, but
clamped within its uclamp min and max. At cfs_rq level, util_avg_uclamp
must always be the sum of all util_avg_uclamp of all the entities on
this cfs_rq. As a result, cfs_rq->avg.util_avg_uclamp is the sum
aggregation of all the clamped values, which indicates the frequency
this rq should run at and what the utilization is.

This idea solves Problem 1 by capping the utilization of an
always-running task throttled by UCLAMP_MAX. Although the task (denoted
by Task A) has no idle time, the util_avg_uclamp signal gives its
UCLAMP_MAX value instead of 1024, so even if another task (Task B) with
a UCLAMP_MAX value at 1024 joins the rq, the util_avg_uclamp is A's
UCLAMP_MAX plus B's utilization, instead of 1024 plus B's utilization,
which means we no longer have the frequency spike problem caused by B.
This should mean that we might completely avoid the need for uclamp
filtering.

It also solves Problem 2 by tracking the capped utilization of a rq.
Using util_avg_uclamp, we are able to differentiate between a CPU
throttled by UCLAMP_MAX and one that is actually running at its peak
capacity. An always-running rq with a task having UCLAMP_MAX at 300 will
report a cfs_rq util_avg_uclamp at 300, not 1024, which means task
placement sees spare capacity on this CPU and will allocate some tasks
to it, instead of treating it the same way as a CPU actually running at
the peak. This brings us closer to the benefits of Android's sum
aggregation (see code related to CONFIG_USE_GROUP_THROTTLE at
https://android.googlesource.com/kernel/gs/+/refs/heads/android-gs-raviole-5.10-android12-d1/drivers/soc/google/vh/kernel/sched/fair.c#510),
which shows energy benefits because we are able to schedule tasks on
smaller cores which are UCLAMP_MAX capped, instead of finding a fresh
big CPU. However, a major difference is that this series has an
amortized cost of O(1), instead of O(n) in cpu_util_next() in Android
kernels.

It avoids the shortcomings from uclamp-being-a-frequency-hint. Under sum
aggregation, the scheduler sees the sum aggregated util_avg_uclamp and
will avoid the problem of enqueueing too many tasks just to fit the
frequency, and will place tasks on little CPUs in the previous example.

Patch 2/6 tries to simulate PELT decay in the new util_avg_uclamp
signal, as this gives us gradual decay of utilization which avoids
premature CPU frequency drops. This is a major caveat of this series. We
should explore if there's a better way to integrate uclamp directly into
the util_avg signal, instead of introducing a new util_avg_uclamp and
then simulate PELT on it.

This new design significantly simplifies uclamp logic.
Patch 4/6 removes the tri-state return value of util_fits_cpu().
Patch 5/6 then completely removes uclamp buckets. Because the
util_avg_uclamp is already a clamped value propagated from bottom to
top, there's no need to clamp anything at the top level and we can just
use this value for frequency selection and spare capacity search.
Basically, the idea is that all uclamp logic happens inside
util_avg_uclamp, and other code using this new signal can just use it
like util_avg, without even knowing that uclamp exists. This drastically
reduces the complexity of uclamp and makes the code considering all the
uclamp corner cases unnecessary. At the end of the series, we remove 749
lines of code while adding a bit more than 300 (although once we update
Documentation.rst, it will be a bit more than that).

Note that this series is still considered RFC status. TODO items are:

1. Implement sum aggregation for RT tasks.
2. Improve handling of cpu_util(boost).

TESTING:

Initial test and benchmark results suggest that sum aggregation not only
is significantly simpler, but generally performs much better in
achieving what uclamp is supposed to do. Two notebooks are shared at

https://nbviewer.org/github/honxia02/sum_aggre_notebooks/blob/main/upstream.ipynb
https://nbviewer.org/github/honxia02/sum_aggre_notebooks/blob/main/sum.ipynb

The experiments done in notebooks are on Arm Juno r2 board. CPU0-3 are
little cores with capacity of 383. CPU4-5 are big cores. The rt-app
profiles used for these experiments are included in the notebooks.

Scenario 1: Scheduling 4 always-running tasks with UCLAMP_MAX at 200.

The scheduling decisions are plotted in Out[11] and Out[14]
respectively. Max aggregation fails to recognize the opportunity to run
all of them on the efficient little Power Domain (PD), whereas sum
aggregation runs all 4 on the little PD, leaving the big PD completely
powered off, satisfying uclamp requests while saving power.

Scenario 2: Scheduling 4 tasks with UCLAMP_MIN and UCLAMP_MAX at a value
slightly above the capacity of the little CPU.

Results are in Out[17] and Out[82]. The purpose is to use UCLAMP_MIN to
place tasks on the big core. Max aggregation is pretty much in an
overutilized state the entire time. Sum aggregation sees that the big
CPU can hold two such tasks (satisfying both UCLAMP_MIN and UCLAMP_MAX
requests for all 4 tasks) on each big CPU and quickly settles down, and
is still under EAS without overutilization.

Scenario 3: Task A is a task with a small utilization pinned to CPU4.
Task B is an always-running task pinned to CPU5, but UCLAMP_MAX capped
at 200. After a while, task A is then pinned to CPU5, joining B.

Results are in Out[23] and Out[95]. The blue util_avg signal is the
original root CFS util_avg. The yellow line is the root CFS utilization
after considering uclamp. Max aggregation sees a frequency
spike at 579.1s. When zoomed in, one can see square-wave-like
utilization values because of A periodically going to sleep. When A
wakes up, its default UCLAMP_MAX of 1024 will uncap B and reach the
highest CPU frequency. When A sleeps, B's UCLAMP_MAX will be in effect
and will reduce rq utilization to 200. This happens repeatedly, hence
the square wave. In contrast, sum aggregation sees a normal increase in
utilization when A joins B, at around 2507s, without any square-wave
behavior.

Scenario 4: 4 always-running tasks with UCLAMP_MAX of 120 pinned to the
little PD (CPU0-3). 4 same tasks pinned to the big PD (CPU4-5).
After a while, remove the CPU pinning of the 4 tasks on the big PD.

Results are in Out[29] and Out[101]. Max aggregation fails to identify
that all 8 tasks can be packed on the little PD, whereas sum
aggregation immediately moves the 4 tasks pinned to big PD to the
little PD the moment pinning is removed. Sum aggregation understands
that even when the rq seems to have utilization of 1024, this is because
of UCLAMP_MAX and there's still opportunity to pack 2 such tasks on each
little CPU, leaving the big PD untouched, saving power.

BENCHMARKS:

One TODO item is to handle cpu_util(boost) better. The current handling
of boost is far from ideal and is a known caveat. All below benchmarks
numbers are done without any boosting in cpu_util(), in both max and sum
aggregation.

Geekbench 6 (on Rock-5B board)
+-----+-------------+------------+
|     | Single-core | Multi-core |
+-----+-------------+------------+
| Max |      800.6  |     2977.0 |
| Sum |      801.2  |     2981.4 |
+-----+-------------+------------+

No regression is seen after switching to sum aggregation.

Jankbench (backporting sum aggregation to Android 5.18 mainline kernel)

+------+-----------------+-------+-----------+
|      |    variable     | value | perc_diff |
+------+-----------------+-------+-----------+
| main | jank_percentage |  1.1  |    0.00%  |
|  sum | jank_percentage |  0.5  |  -53.92%  |
+------+-----------------+-------+-----------+

+------------+--------+------+-------+-----------+
|            | metric |  tag | value | perc_diff |
+------------+--------+------+-------+-----------+
|    CPU     | gmean  | main | 166.1 |   0.00%   |
|  CPU-Big   | gmean  | main | 55.1  |   0.00%   |
| CPU-Little | gmean  | main | 91.7  |   0.00%   |
|  CPU-Mid   | gmean  | main | 19.2  |   0.00%   |
|    CPU     | gmean  |  sum | 161.3 |  -2.85%   |
|  CPU-Big   | gmean  |  sum | 52.9  |  -3.97%   |
| CPU-Little | gmean  |  sum | 86.7  |  -5.39%   |
|  CPU-Mid   | gmean  |  sum | 21.6  |  12.63%   |
+------------+--------+------+-------+-----------+

The TL;DR of Jankbench is that sum aggregation reduces jank by 54% while
with 2.85% less CPU power. Note that this benchmark on Pixel 6 by
default has some sort of uclamp feedback applied to it. When jank is
detected, certain display and benchmark threads are applied with a
UCLAMP_MIN value of 512 (any help in identifying where these UCLAMP_MIN
values come from in the mainline Android kernel is appreciated). In
contrast, we constantly apply a UCLAMP_MIN value of 60 to these threads
without any feedback loop. If a similar feedback loop is involved to
only apply UCLAMP_MIN when needed, power consumption can be expected to
be even lower.

Hongyan Xia (6):
  sched/uclamp: Track uclamped util_avg in sched_avg
  sched/uclamp: Simulate PELT decay in util_avg_uclamp
  sched/fair: Use CFS util_avg_uclamp for utilization and frequency
  sched/fair: Rewrite util_fits_cpu()
  sched/uclamp: Remove all uclamp bucket logic
  sched/uclamp: Simplify uclamp_eff_value()

 include/linux/sched.h            |  13 +-
 init/Kconfig                     |  32 ---
 kernel/sched/core.c              | 312 ++-------------------------
 kernel/sched/cpufreq_schedutil.c |  19 +-
 kernel/sched/fair.c              | 354 +++++++++----------------------
 kernel/sched/pelt.c              | 146 ++++++++++++-
 kernel/sched/rt.c                |   4 -
 kernel/sched/sched.h             | 208 ++++++------------
 8 files changed, 339 insertions(+), 749 deletions(-)

-- 
2.34.1


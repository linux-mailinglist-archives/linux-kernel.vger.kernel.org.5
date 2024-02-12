Return-Path: <linux-kernel+bounces-61776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F56A8516E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52754B278E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093E23F9FD;
	Mon, 12 Feb 2024 13:56:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B366FCB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746186; cv=none; b=Mi7JftbZ8fm+/CsGYCEj+WLHq2Dukzols24yA3wUylsoMYExgG67mSOqkErZ6z+riX88v+q61+VT0D25tlmfP7C6g2u5yY16c3l5Ne69wz09xb/zO5T5nxAPEPLNYn88AkwKYXr21gLGszA3b3WRcNe7txEgIFTNO3irvrHNv7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746186; c=relaxed/simple;
	bh=P/JSjupYpGxB/qnZNZFWrrKoAuVBWfdT+bX2uXUvn4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9P7oLYAJ5/bruzIJ9kYC9a5RajW1E7rb39EJDSBn7qZk2SK2DK5W3ZxQSCRHEYmwbzR98luA6Qp/NtJ2mG+EkqM3ZMLhwdAcjJPInWjaZ1qUUFvDBToCBRXC2RtebtV79CdsoBsSjHtFfANrgqQNCWaCwAtqTyHG/moLhImnZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81B2EDA7;
	Mon, 12 Feb 2024 05:57:04 -0800 (PST)
Received: from [10.57.10.26] (unknown [10.57.10.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2ADB3F7BD;
	Mon, 12 Feb 2024 05:56:21 -0800 (PST)
Message-ID: <b81a5b1c-14de-4232-bee9-ee647355dd8c@arm.com>
Date: Mon, 12 Feb 2024 13:56:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/7] uclamp sum aggregation
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Qais Yousef <qyousef@layalina.io>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Christian Loehle <christian.loehle@arm.com>, linux-kernel@vger.kernel.org,
 David Dai <davidai@google.com>, Saravana Kannan <saravanak@google.com>
References: <cover.1706792708.git.hongyan.xia2@arm.com>
 <CAKfTPtDN-Qq-qDKZSsMk3dg1RiameFRYe6L4c_OC7D1j0=Mrew@mail.gmail.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <CAKfTPtDN-Qq-qDKZSsMk3dg1RiameFRYe6L4c_OC7D1j0=Mrew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2024 09:16, Vincent Guittot wrote:
> On Thu, 1 Feb 2024 at 14:12, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>>
>> Current implementation of uclamp leaves many things to be desired.
>> There are three noteworthy problems:
>>
>> 1. Max aggregation only takes into account the max uclamp value. All
>>     other uclamp values are not in effect.
>> 2. Uclamp max aggregation gives UCLAMP_MIN and UCLAMP_MAX at the rq
>>     level, and whether that translates to the desired performance of a
>>     specific task is unknown, because it depends on other tasks on rq.
>> 3. Complexity. Uclamp max aggregation now sits at more than 750 lines of
>>     code and there is ongoing work to rework several interfaces to
>>     prepare for further uclamp changes. Uclamp max aggregation itself
>>     also needs future improvements in uclamp filtering and load balancing
>>
>> The first 2 points can manifest into the following symptoms,
>>
>> 1. High-rate OPP changes ("frequency spike" problem). An always-running
>>     task with a UCLAMP_MAX of 200 will drive the CPU at 200 even though
>>     its utilization is 1024. However, when a util_avg task of 300 but
>>     with default UCLAMP_MAX of 1024 joins the rq, the rq UCLAMP_MAX will
>>     be uncapped, and the UCLAMP_MAX of the first task is no longer in
>>     effect therefore driving the CPU at 1024, the highest OPP. When the
>>     second task sleeps, the OPP will be reduced to 200. This fast and
>>     sudden OPP switch every time the 2nd task wakes up or sleeps is
>>     unnecessary.
>> 2. Using UCLAMP_MIN to boost performance under max aggregation has been
>>     shown to have weaker effectiveness than "sum aggregated" approaches,
>>     including the util_guest proposal [1] and uclamp sum aggregation in
>>     this series. The performance level of UCLAMP_MIN for a task under max
>>     aggregation is unpredictable when there are more than 1 task runnable
>>     on the rq.
>>
>> This series solves these problems by tracking a
>> util_avg_uclamp signal in tasks and root cfs_rq. At task level,
>> p->se.avg.util_avg_uclamp is basically tracking the normal util_avg, but
>> clamped within its uclamp min and max. At cfs_rq level, util_avg_uclamp
>> must always be the sum of all util_avg_uclamp of all the entities on
>> this cfs_rq. As a result, rq->cfs.avg.util_avg_uclamp is the sum
>> aggregation of all the clamped values, which hints the frequency
>> this rq should run at and what the utilization is. This proposal has
>> some similarities to the util_guest series for VM workloads, in that it
>> brings the desired performance to the task that requested it, not to the
>> rq, in which the share of the task is unpredictable.
> 
> As I mentioned in your previous version, I don't want such mixed
> signals which are hard to maintain (as you then try to compensate for
> all side effects and compensate for some decaying as an example) and
> don't mean anything at the end. You must find another way if you want
> to go in that direction of sum aggregated.

The new style in v2 is following util_est and the old scheduler way of 
tracking root CFS. The old root CFS tracking was changed because we 
didn't want the cost of updating all the intermediate task group levels 
and this series brings back root CFS sum tracking, without the cost of 
task groups.

I'm not entirely certain that this new signal shouldn't exist and is 
hard to maintain, when it is proven to be more effective than max 
aggregation that is more than twice the amount of code (and still 
growing, to fix all the different cases), in which the bucket logic is 
fairly complicated to understand and maintain already. I also just 
learned that the math to decay the CFS sum in Patch 3/7 isn't what I 
invented but what CFS did.

>>
>> Note: This new signal does not change the existing PELT signal. The new
>> signal is only an extra hint to the scheduler to improve scheduling
>> decisions.
>>
>> TL;DR OF THIS SERIES:
>>
>> - Our evaluation shows significantly better effectiveness than max
>>    aggregation. UI benchmarks and VM workloads have improved latency and
>>    higher scores at the same or even reduced power consumption.
>> - For other benchmarks that do not involve uclamp, we have not observed
>>    any noticeable regressions.
>> - This series is the entirety of sum aggregation. No groundwork or
>>    refactoring in the scheduler is needed. The complexity of several
>>    existing uclamp-related functions is massively reduced and sum
>>    aggregation code is less than half of that in max aggregation (304+,
>>    701-). The complexity gap will be even greater with all the ongoing
>>    patches for max aggregation.
>>
>> DECOMPOSITION OF SUM AGGREGATION:
>>
>> - Patch 1 reverts some max aggregation code. Sum aggregation shows no
> 
> Sorry I don't get what you mean here by reverting some max aggregation
> code ? This is not really linked to max aggregation but how EAS and
> feec() try to compute energy

I agree. Strictly speaking this is EAS related and not directly related 
to max aggregation. I'll reword the message.

> 
> The code that is reverted here mainly highlights where your problem is
> and more generally speaking one of the problems of the current
> algorithm of EAS and feec() when it tries to estimate the energy cost.
> We don't take into account that an utilization becoming larger the cpu
> capacity means more running time. Such problem has been highlighted
> previously and is one root cause of the problems that you are trying
> to solve there

Under max aggregation, an always-running task capped at 200 on a CPU and 
10 such tasks on the same CPU have the same total running time and CPU 
frequency. I call this 'infinite tasks problem' because theoretically 
you can have an infinite number of such tasks on the same CPU, without 
max aggregation complaining.

This problem and the reverted patch both sound to me that, yes, we need 
to consider the time axis like you said. However, I must say I feel it 
is hacky when the uclamp implementation needs to take into account extra 
parameters to work well.

>>    such problems so mitigation patches are not necessary, and that
>>    patch has other undesirable side effects.
>> - Patch 2 and 3 introduce new sum aggregated signals to be a more
>>    effective hint to the scheduler. Patch 3 employs a math trick to make
>>    it significantly simpler to track on-rq and off-rq task utilization
>>    contributions.
>> - Patch 4, 5 and 6 start using the new signal while significantly
>>    simplifying existing uclamp code, including the total removal of
>>    uclamp buckets and max aggregation.
>> - Patch 7 and part of 6 remove the overhead of uclamp on task
>>    enqueue and dequeue, because uclamp values and buckets no longer need
>>    to be re-computed every time a uclamp'ed task joins or leaves the rq.
>>
>> TESTING:
>>
>> Sum aggregation generally performs better in tests. Two notebooks, max
>> vs. sum aggregation, are shared at
>>
>> https://nbviewer.org/github/honxia02/notebooks/blob/618de22a8da96205015fefabee203536683bd4e2/whitebox/max.ipynb
>> https://nbviewer.org/github/honxia02/notebooks/blob/618de22a8da96205015fefabee203536683bd4e2/whitebox/sum.ipynb
>>
>> The experiments done in notebooks are on Arm Juno r2 board. CPU0-3 are
>> little cores with capacity of 383. CPU4-5 are big cores. The rt-app
>> profiles used for these experiments are included in the notebooks.
>>
>> Scenario 1: Scheduling 4 always-running tasks with UCLAMP_MAX at 200.
>>
>> The scheduling decisions are plotted in Out[11]. Both max and sum
>> aggregation recognizes the UCLAMP_MAX hints and run all the threads
>> on the little Performance Domain (PD). However, max aggregation in the
>> test shows some randomness in task placement, and we see the 4 threads
>> are often not evenly distributed across the 4 little CPUs. This uneven
>> task placement is also the reason why we revert the patch:
>>
>> "sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0"
>>
>> When the spare capacity is 0, the reverted patch tends to gather many
>> tasks on the same CPU because its EM calculation is bogus and it thinks
>> this placement is more energy efficient.
> 
> So the problem is not max vs sum aggregation but fix feec()

Like in my previous comment, I agree, although I think max aggregation 
makes accurate feec() tricky when the whole rq can be capped and 
uncapped by one task and running time may need to be considered to work 
well.

>>
>> Scenario 2: Scheduling 4 tasks with UCLAMP_MIN and UCLAMP_MAX at a value
>> slightly above the capacity of the little CPU.
>>
>> Results are in Out[17]. The purpose is to use UCLAMP_MIN to place tasks
>> on the big core but not to run at the highest OPP. Both max and sum
>> aggregation accomplish this task successfully, running the two threads
>> at the big cluster while not driving the frequency at the max.
> 
> No problem here
> 
>>
>> Scenario 3: Task A is a task with a small utilization pinned to CPU4.
>> Task B is an always-running task pinned to CPU5, but UCLAMP_MAX capped
>> at 300. After a while, task A is then pinned to CPU5, joining B.
>>
>> Results are in Out[23]. The util_avg curve is the original root CFS
>> util_avg. The root_cfs_util_uclamp is the root CFS utilization after
>> considering uclamp. Max aggregation sees a frequency spike at 751.7s.
>> When zoomed in, one can see square-wave-like utilization and CPU
> 
> sidenote: there is no graph showed in your links so nothing to see or zoom

Hmm, I have confirmed with a couple of people that the graphs show up 
before sending out the series. This sometimes happens when you have ad 
or cookie blocker. Maybe disabling them or viewing in a private window 
helps. If it doesn't I'll try other ways of sharing the results.

>> frequency values because of task A periodically going to sleep. When A
>> wakes up, its default UCLAMP_MAX of 1024 will uncap B and reach the
>> highest CPU frequency. When A sleeps, B's UCLAMP_MAX will be in effect
>> and will reduce rq utilization to 300. This happens repeatedly, hence
>> the square wave. In contrast, sum aggregation sees a normal increase in
> 
> What do you mean by normal increase ?

Not having a frequency spike and not jumping between the highest and 
lowest OPP for every time slice.

>> utilization when A joins B, at around 430.64s, without any square-wave
>> behavior. The CPU frequency also stays stable while the two tasks are on
>> the same rq.
> 
> Difficult to make any comment as there is no graph to see in your link.
> 
> What should be the right frequency in such a case ?

A frequency high enough to satisfy util(A) and clamped(B).

>>
>> Scenario 4: 4 always-running tasks with UCLAMP_MAX of 120 pinned to the
>> little PD (CPU0-3). 4 same tasks pinned to the big PD (CPU4-5).
>> After a while, remove the CPU pinning of the 4 tasks on the big PD.
>>
>> Results are in Out[29]. Both max and sum aggregation understand that we
>> can move the 4 tasks from the big PD to the little PD to reduce power
>> because of the UCLAMP_MAX hints. However, max aggregation shows severely
>> unbalanced task placement, scheduling 5 tasks on CPU0 while 1 each on
>> CPU1-3. Sum aggregation schedules 2 tasks on each little CPU, honoring
>> UCLAMP_MAX while maintaining balanced task placement.
>>
>> Again, this unbalanced task placement is the reason why we reverted:
>>
>> "sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0"
> 
> So then it's not a matter a sum vs max aggregation but to fix the EAS
> policy to place tasks correctly
> 
>>
>> Scenario 5: 8 tasks with UCLAMP_MAX of 120.
>>
>> This test is similar to Scenario 4, shown in Out[35]. Both max and sum
>> aggregation understand the UCLAMP_MAX hints and schedule all tasks on
>> the 4 little CPUs. Max aggregation again shows unstable and unbalanced
>> task placement while sum aggregation schedules 2 tasks on each little
>> CPU, and the task placement remains stable. The total task residency is
>> shown in Out[36], showing how unbalanced max aggregation is.
> 
> same comment as previous test
> 
>>
>> BENCHMARKS:
>>
>> Geekbench 6, no uclamp (on Rock-5B board)
>> +-----+-------------+------------+
>> |     | Single-core | Multi-core |
>> +-----+-------------+------------+
>> | Max |      801.3  |     2976.8 |
>> | Sum |      802.8  |     2989.2 |
>> +-----+-------------+------------+
>>
>> No regression is seen after switching to sum aggregation.
>>
>> Jankbench (backporting sum aggregation to Pixel 6 Android 5.18 mainline kernel):
>>
>> Jank percentage:
>> +------+-------+-----------+
>> |      | value | perc_diff |
>> +------+-------+-----------+
>> | main |  1.1  |    0.00%  |
>> |  sum |  0.5  |  -53.92%  |
>> +------+-------+-----------+
>>
>> Average power:
>> +------------+------+-------+-----------+
>> |            |  tag | value | perc_diff |
>> +------------+------+-------+-----------+
>> |    CPU     |  max | 166.1 |   0.00%   |
>> |  CPU-Big   |  max | 55.1  |   0.00%   |
>> | CPU-Little |  max | 91.7  |   0.00%   |
>> |  CPU-Mid   |  max | 19.2  |   0.00%   |
>> |    CPU     |  sum | 161.3 |  -2.85%   |
>> |  CPU-Big   |  sum | 52.9  |  -3.97%   |
>> | CPU-Little |  sum | 86.7  |  -5.39%   |
>> |  CPU-Mid   |  sum | 21.6  |  12.63%   |
>> +------------+------+-------+-----------+
>>
>> UIBench (backporting sum aggregation to Pixel 6 Android 6.6 mainline kernel):
>>
>> Jank percentage:
>> +-------------+-------+-----------+
>> |      tag    | value | perc_diff |
>> +-------------+-------+-----------+
>> |   max_aggr  |  0.3  |    0.0    |
>> |   sum_aggr  |  0.26 |   -12.5   |
>> +-------------+-------+-----------+
>>
>> Average input latency:
>> +-------------+--------+-----------+
>> |      tag    | value  | perc_diff |
>> +-------------+--------+-----------+
>> |   max_aggr  | 107.39 |    0.0    |
>> |   sum_aggr  | 81.135 |   -24.5   |
>> +-------------+--------+-----------+
>>
>> Average power:
>> +------------+--------------+--------+-----------+
>> |  channel   |     tag      | value  | perc_diff |
>> +------------+--------------+--------+-----------+
>> |    CPU     |   max_aggr   | 209.85 |   0.0%    |
>> |  CPU-Big   |   max_aggr   |  89.8  |   0.0%    |
>> | CPU-Little |   max_aggr   |  94.45 |   0.0%    |
>> |  CPU-Mid   |   max_aggr   |  25.45 |   0.0%    |
>> |    GPU     |   max_aggr   |  22.9  |   0.0%    |
>> |   Total    |   max_aggr   | 232.75 |   0.0%    |
>> |    CPU     |   sum_aggr   | 206.05 |  -1.81%   |
>> |  CPU-Big   |   sum_aggr   |  84.7  |  -5.68%   |
>> | CPU-Little |   sum_aggr   |  94.9  |   0.48%   |
>> |  CPU-Mid   |   sum_aggr   |  26.3  |   3.34%   |
>> |    GPU     |   sum_aggr   |  22.45 |  -1.97%   |
>> |   Total    |   sum_aggr   | 228.5  |  -1.83%   |
>> +------------+--------------+--------+-----------+
>>
>> It should be noted that sum aggregation reduces jank and reduces input
>> latency while consuming less power.
>>
>> VM cpufreq hypercall driver [1], on Rock-5B board. Baseline indicates a
>> setup without the VM cpufreq driver:
>>
>> Geekbench 6 uncontended. No other host threads running.
>> +------+-------------+-----------+------------+-----------+
>> |      | Single-core | perc_diff | Multi-core | perc_diff |
>> +------+-------------+-----------+------------+-----------+
>> | base |      796.4  |         0 |     2947.0 |         0 |
>> |  max |      795.6  |     -0.10 |     2929.6 |     -0.59 |
>> |  sum |      794.6  |     -0.23 |     2935.6 |     -0.39 |
>> +------+-------------+-----------+------------+-----------+
>>
>> Geekbench 6 contended. Host CPUs each has a 50% duty-cycle task running.
>> +------+-------------+-----------+------------+-----------+
>> |      | Single-core | perc_diff | Multi-core | perc_diff |
>> +------+-------------+-----------+------------+-----------+
>> | base |      604.6  |         0 |     2330.2 |         0 |
>> |  max |      599.4  |     -0.86 |     2327.2 |     -0.13 |
>> |  sum |      645.8  |      6.81 |     2336.6 |      0.27 |
>> +------+-------------+-----------+------------+-----------+
>>
>> VM CPUfreq driver using sum aggregation outperforms max aggregation when
>> the host is contended. When the host has no contention (only the VM
>> vCPUs are running and each host CPU accommodates one guest vCPU), the
>> two aggregation methods are roughly the same, and a bit surprisingly,
>> offers no speed-up versus the baseline. This is probably because of the
>> overhead of hypercalls, and the fact that Geekbench is CPU intensive and
>> is not the best workload to show the effectiveness of VM cpufreq driver.
>> We will try to benchmark on more VM workloads.
>>
>> LIMITATIONS:
>>
>> 1. RT sum aggregation is not shown in the series.
>>
>> A proof-of-concept RT sum aggregation implementation is done and going
>> through testing, with < 50 lines of code, using the same ideas as in
>> CFS. They will be sent out separately if we can agree on CFS sum
>> aggregation and once the testing is done.
>>
>> 2. A heavily UCLAMP_MAX-throttled task may prevent the CFS rq from
>>     triggering over-utilization.
>>
>> For example, two always-running task each having utilization of 512. If
>> one of the task is severely UCLAMP_MAX restricted, say, with a
>> UCLAMP_MAX of 1, then the total CFS sum aggregation will be 512 + 1 =
>> 513, which won't trigger over-utilization even though the other task has
>> no UCLAMP_MAX and wants more performance.
> 
> But what if they are pinned to the same CPU or other cpus are already
> fully busy ? This is a blocking point because the uclamp of one task
> then impacts the cpu bandwidth of another not clamped task

True. This is a limitation I acknowledge. I'm working on a fix.

>>
>> I'm working on a fix for this problem. This at the moment can be solved
>> by either not giving long-running tasks ridiculously low UCLAMP_MAX
>> values, or adjusting the priority of UCLAMP_MAX tasks to make sure it
>> does not get a share of CPU run-time that vastly exceeds its UCLAMP_MAX.
>> However, my personal view is that maybe UCLAMP_MIN and UCLAMP_MAX just
>> don't belong together, and the proper way is to have a per-task
> 
> No this is a blocking point. We don't want to add dependency between
> nice priority and uclamp.

Actually in my testing I find the 'infinite tasks' problem to be a way 
bigger blocker than this problem. Under max aggregation, often 
uclamp_max tasks are placed on the same CPU because the energy 
calculation is bogus, just like in Scenario 4. I'm just saying that at 
least the under-utilized problem can be easily worked around with 
priorities when you use uclamp_max in sum aggregation.

>> bandwidth throttling mechanism and what we want as UCLAMP_MAX maybe
>> actually belongs to that mechanism.
>>
>> However, since the Android GROUP_THROTTLE feature [2] has the exact same
>> problem and has been used in actual products, we don't think this is a
>> big limitation in practice.
> 
> This is not because an out of tree patchset is ok to go with a wrong
> behavior that it makes this patchset acceptable

I completely agree.

I was not arguing that what somebody else does makes a limitation 
acceptable. I was saying that often one doesn't run into that 
limitation. It's rare in practice that one wants a task to run at normal 
or even higher priority but with a heavily throttled uclamp_max. In the 
testing and evaluation, one runs into the limitations of max aggregation 
more often than seeing this problem in sum aggregation. But, you are 
right, this problem should be fixed.

Finally, I may not have expressed this clearly in email threads, but I'm 
not strongly against max aggregation, it's just it has many drawbacks 
that need to be addressed, and we do not yet know how many more lines of 
code are needed and how well it will perform in the end. If we have a 
way forward and the effectiveness is shown by evaluation numbers, then I 
don't see why we can't go with the current uclamp implementation.

>>
>> [1]: https://lore.kernel.org/all/20230331014356.1033759-1-davidai@google.com/
>> [2]: https://android.googlesource.com/kernel/gs/+/refs/heads/android-gs-raviole-5.10-android12-d1/drivers/soc/google/vh/kernel/sched/fair.c#510
>>
>> ---
>> Changed in v2:
>> - Rework util_avg_uclamp to be closer to the style of util_est.
>> - Rewrite patch notes to reflect the new style.
>> - Add the discussion of the under-utilizated example in limitations,
>>    found by Vincent G.
>> - Remove task group uclamp to focus on tasks first.
>> - Fix several bugs in task migration.
>> - Add benchmark numbers from UIBench and VM cpufreq.
>> - Update python notebooks to reflect the latest max vs. sum aggregation.
>>
>> Hongyan Xia (7):
>>    Revert "sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is
>>      0"
>>    sched/uclamp: Track uclamped util_avg in sched_avg
>>    sched/uclamp: Introduce root_cfs_util_uclamp for rq
>>    sched/fair: Use CFS util_avg_uclamp for utilization and frequency
>>    sched/fair: Massively simplify util_fits_cpu()
>>    sched/uclamp: Remove all uclamp bucket logic
>>    sched/uclamp: Simplify uclamp_eff_value()
>>
>>   include/linux/sched.h            |   7 +-
>>   init/Kconfig                     |  32 ---
>>   kernel/sched/core.c              | 324 +++---------------------------
>>   kernel/sched/cpufreq_schedutil.c |  10 +-
>>   kernel/sched/fair.c              | 333 +++++++------------------------
>>   kernel/sched/pelt.c              | 144 ++++++++++++-
>>   kernel/sched/pelt.h              |   6 +-
>>   kernel/sched/rt.c                |   4 -
>>   kernel/sched/sched.h             | 145 ++++++--------
>>   9 files changed, 304 insertions(+), 701 deletions(-)
>>
>> --
>> 2.34.1
>>


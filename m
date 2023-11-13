Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9E17E98E0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjKMJ1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 04:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKMJ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:27:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4054B10DB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 01:26:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 347DAFEC;
        Mon, 13 Nov 2023 01:27:42 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27F4E3F6C4;
        Mon, 13 Nov 2023 01:26:54 -0800 (PST)
Message-ID: <5f905631-e94a-4fd7-9668-d910438fa7b9@arm.com>
Date:   Mon, 13 Nov 2023 10:26:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] sched: uclamp sum aggregation
Content-Language: en-US
To:     Hongyan Xia <hongyan.xia2@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
References: <cover.1696345700.git.Hongyan.Xia2@arm.com>
 <59505904-fdc4-42ec-808e-e4af011b22e8@arm.com>
 <05e658b9-3b0f-4606-8d67-05d1c32e7fdd@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <05e658b9-3b0f-4606-8d67-05d1c32e7fdd@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2023 12:19, Hongyan Xia wrote:
> On 30/10/2023 18:46, Dietmar Eggemann wrote:
>> On 04/10/2023 11:04, Hongyan Xia wrote:
>>> Current implementation of uclamp leaves many things to be desired.
>>> There are several problems:
>>>
>>> 1. Max aggregation is fragile. A single task with a high UCLAMP_MAX (or
>>>     with the default value, which is 1024) can ruin the previous
>>>     settings the moment it is enqueued, as shown in the uclamp frequency
>>>     spike problem in Section 5.2 of
>>>     Documentation/scheduler/sched-util-clamp.rst. Constantly running at
>>>     1024 utilization implies that the CPU is driven at its max capacity.
>>>     However, with UCLAMP_MAX, this assumption is no longer true. To
>>>     mitigate this, one idea is to filter out uclamp values for
>>>     short-running tasks. However, the effectiveness of this idea remains
>>>     to be seen.
>>
>> The difference is that we don't have to lift the uclamp_max cap of
>> runnable p1's uclamp_max (< 1024) when a short running p2 with
>> uclamp_max = 1024 becomes runnable? Since now, when this happens, we
>> would just add p2's util_avg_uclamp to cfs_rq's util_avg_uclamp which is
>> tiny compared to its uclamp_max = 1024.
> 
> Yes. That's a correct interpretation. I can add this version to the
> cover letter to make things clearer.

OK.

>>> 2. No way to differentiate between UCLAMP_MAX throttled CPU or a CPU
>>>     running at its peak, as both show utilization of 1024. However, in
>>>     certain cases it's important to tell the difference, as we still
>>> want
>>>     to take the opportunity to enqueue tasks in the former case.
>>
>> Is this related to the `best_fits/max_fits` logic in
>> find_energy_efficient_cpu() (feec()) and select_idle_capacity() (sic())
>> (commit e5ed0550c04c "sched/fair: unlink misfit task from cpu
>> overutilized")?
>> With your approach, having cfs_rq's `util_avg_uclamp` next to its
>> `util_avg` would allow to see those difference by comparing the two
>> signals?
> 
> Somewhat related. The usefulness is mostly around cpu_util(). Max
> aggregation will see cpu_util() of 1024 (spare capacity of 0) even when
> this is caused by UCLAMP_MAX, not by actually running the CPU at max
> capacity, whereas this series will have a util < 1024 if capped by
> UCLAMP_MAX.

I see. For me the main diff is:

cpu_util() (not considering util_est here) returns a completely
different signal with sum aggregation:

   $\sum_{runnable tasks p0}^{pN} clamp(p->se.avg.util_avg,          (1)
                                        p->uclamp[UCLAMP_MIN],
                                        p->uclamp[UCLAMP_MAX])

instead of max aggregation:

  rq->cfs.avg.util_avg

which then has to be clamped later in different places using cpu_util():

   clamp(rq->cfs.avg.util_avg, rq->uclamp[UCLAMP_MIN],               (2)
         rq->uclamp[UCLAMP_MIN])

with the clamp values dictated by the runnable tasks with the highest
uclamp values.

> This means the patch to consider 0 spare capacities (because under max
> aggregation 0 capacity doesn't mean the CPU is at max) is unnecessary:
> 
> 6b00a40147653c8ea748e8f4396510f252763364
> sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0

Yes, this patch makes sure we consider PDs with max_spare_cap = 0 for EM
calculations (eenv_pd_busy_time(), compute_energy).

I just asked about commit e5ed0550c04c since you removed the (best,max,
prev)_fits and the (best, prev)_thermal_cap logic from feec(). And if I
remember correctly this brought us an implementation of capacity
inversion handling.

[...]

>>> cancel the effect of uclamp in feec(). A CPU running at capacity 500 for
>>> 1ms or for 1000ms gives completely different performance levels, so
>>> trying to fit only the frequency does not give us any performance
>>> guarantees. If we then talk about not only running at some frequency but
>>> also for some amount of time, then what we really mean is a capacity
>>> hint, not a frequency hint.
>>
>> Isn't CPU frequency and capacity going in the same direction?
>>
>>   IPC * CPU frequency = Instruction per Second == Performance (Capacity).
>>
>> And in the scheduler, utilization is the portion of the Capacity
>> currently used.
>>
>> What sum aggregation does differently is that you can sum-up
>> individually clamped utilization contributions and compare them against
>> capacity rather then being forced to use the maximum value of a clamp
>> value of one (runnable) task to guide frequency. This avoids those
>> discontinuity-moments when a task with a high uclamp value switches
>> between runnable and sleeping state.
> 
> I guess what I was describing was a new metric:
> 
>     Work = Capacity * Time
> 
> Max aggregation aims to fit capacity, but if a task can be run at a high
> capacity but for only a very short period of time, then this scheduling
> is not particularly useful. Like in the above example, moving a task
> with UCLAMP_MIN of 101 to the mid CPU isn't helpful when there are
> already 10 tasks on the mid CPU, because Time is reduced.

Not sure I understand this.

Isn't the main difference between sum (1) and max (2) aggregation the
fact that in (1) a p->uclamp[UCLAMP_MAX] has only an effect when it's
really capping p->se.avg.util_avg?

This avoids what can happen under (2) namely that a tiny task with a
default uclamp_max = 1024 (not capped) can ruin the capping scenario for
the time its runnable.

I assume we understand (2) as a frequency hint (i.e. the currently
highest request of a runnable task towards the CPU capacity) and (1)
more as a capacity hint since of the summation of clamped
p->se.avg.util_avg over all runnable tasks on the CPU.

But with 'IPC * CPU frequency == Capacity' what's the actual difference
in this hinting strategies anyway?

[...]

>>> This idea solves Problem 1 by capping the utilization of an
>>> always-running task throttled by UCLAMP_MAX. Although the task (denoted
>>> by Task A) has no idle time, the util_avg_uclamp signal gives its
>>> UCLAMP_MAX value instead of 1024, so even if another task (Task B) with
>>> a UCLAMP_MAX value at 1024 joins the rq, the util_avg_uclamp is A's
>>> UCLAMP_MAX plus B's utilization, instead of 1024 plus B's utilization,
>>> which means we no longer have the frequency spike problem caused by B.
>>> This should mean that we might completely avoid the need for uclamp
>>> filtering.
>>
>> That would be very nice since I remember that this filtering approach
>> hat to figure out the actual runtime of the task and the implemention
>> couldn't be just in the sched class code but had to be done in core code
>> as well.
> 
> Yes. So far I don't see any need for filtering and runtime accounting in
> uclamp sum aggregation.

OK.

[...]

>> We should recall that this is all done because the current uclamp-max
>> max aggression isn't working for Androids use-cases.
>>
>> So to overcome this issue in mainline is key here.
> 
> Thanks for pointing me to the latest Pixel code.
> 
> The basic ideas of that and this series look very similar. Both sum up
> CFS utilization instead of directly tracking the root CFS utilization.
> This series so far has only implemented uclamp on tasks, but the same
> code can also be implemented on group sched_entities. Once I implement
> that, then it essentially does the same thing as GROUP_THROTTLE. I think
> if the current Pixel code works, then it's likely this series works too.
> 
> The big difference is that this series relies on
> CONFIG_FAIR_GROUP_SCHED. There seems to be complaints about it and I may
> need to know why it's not desirable for Android.

Looks like that Pixel8 also has uclamp filtering to exclude a
sufficiently short running task from influencing rq's uclamp_max
(uclamp_max filtering).

GROUP_THROTTLING/VENDOR_GROUP_UTIL was introduced since they couldn't
constrain on taskgroup level with the cpu.shares feature. And mainline
uclamp max (on taskgroup level) didn't give them this functionality either.

So it looks like with sum aggregation uclamp could provide both.

[...]

>>> Note that this series is still considered RFC status. TODO items are:
>>>
>>> 1. Implement sum aggregation for RT tasks.
>>> 2. Improve handling of cpu_util(boost).
>>
>> What about the integration with util_est here?
>>
>> In cpu_util(), &rq->cfs->avg.util_avg is replaced by
>> rq->root_cfs_util_uclamp
>>
>> and in
>>
>> task_util_est() (should be actually named task_util() to be in sync with
>> cpu_util(), i.e. returning max(util, util_est)), task_util(p) returns
>> p->se.avg.util_avg_uclamp.
>>
>> Are there use cases for the original avg.util_avg still in place?
> 
> We still need the original avg.util_avg for tasks because
> util_avg_uclamp is clamped from it, but other than that, at the moment
> there's no reason to use the normal util_avg.

OK. But it looks like that util_est escapes uclamp:

cpu_util()

  return min(max(util_uclamp, util_est), arch_scale_cpu_capacity(cpu))
                              ^^^^^^^^

[...]

>>> Scenario 1: Scheduling 4 always-running tasks with UCLAMP_MAX at 200.

[...]

>> Does `upstream` already contain the v6.7 fixes `Fix uclamp code corner
>> cases` ?
>>
>> https://lkml.kernel.org/r/20230916232955.2099394-1-qyousef@layalina.io
> 
> Unfortunately, no. These experiments were done before that patch. I
> quickly did a test and that patch did fix this issue. Now the four
> little tasks are scheduled on the small PD.
> 
> But I remember that you have another test indicating that the patch may
> expose some new issues?

I remember 2 tests:

   6 periodic tasks runtime/period=12/16ms uclamp_min/max=[0, M] on
   big.LITTLE (2 big, 4 little (arch_scale_cpu_capacity() = 675))

   test (1) M = 665
   test (2) M = 100

2 kernel:

   (A) tip sched/core w/ `Fix uclamp code corner cases`
   (B) uclamp sum aggregation

(A) managed to force all task to run on little CPUs for (1) but not for
(2). For (B) it was the other way around.

These tests show also the _sum_ aggregation aspect of uclamp_max. It's
important now to consider the actual uclamp-max value in case you want
to achieve packing on little.

I still have the ipython notebook for these tests.

>>> Scenario 2: Scheduling 4 tasks with UCLAMP_MIN and UCLAMP_MAX at a value

[...]

>> thread0-[0-3] uclamp_max = 309. So p->se.avg.util_avg_uclamp is
>> constrained by this value for all 4 tasks, letting 2 tasks fit on each
>> of the big CPUs. You have to zoom in into Out[82] to actually see this.
>>
>> And I guess for max aggregation cpu_overutilized() can't hold the clamp
>> continuously because of all the other short running uclamp_max = 1024
>> (default) tasks on the rq's.
> 
> Actually I'm not 100% sure about the reason why max aggregation under
> this experiment never stabilizes. I can investigate further.

OK.

>>> Scenario 3: Task A is a task with a small utilization pinned to CPU4.

[...]

>> Makes sense. But there shouldn't be a root_cfs_util_uclamp in main?
>> Which signal does the yellow line represent in Out[23]?
> 
> Ah, that can be confusing. For current upstream root_cfs_util_uclamp
> comes from uclamp_rq_util_with(rq, cfs_rq->avg.util_avg).

Topic is already pretty complicated so better use the correct naming.

[...]

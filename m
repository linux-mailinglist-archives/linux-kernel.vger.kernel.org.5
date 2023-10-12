Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFC57C71E5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344059AbjJLP4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjJLP43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:56:29 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B68BB8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1697126184;
        bh=36R7eZKaoJ+WPeFW9+rSFhb5np6/txGdnA+zHc945KA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Fog9+0WNETnnfcIUy9Pid2nXfGm36PNiCLRVZRbX9/ThNQ+qs+6EbBXD/3qGsp4VK
         F/XGXSTwJTDIqlkQ3hpFTNrgH5A6MLPnZJWOBNJjq2fI1UbuJAH/H1lhrKxSsj0rU+
         OeLyxTUFmJcTR5VBR/0TAwIXMm9dUlL58YsxtF+vQMPnxHqdPFKt4bdvMrDKU5LuUL
         Ga9j8Ix3hYm7UNayZ63D5lPux1qtjI3dJDM/3ZJ8tM4VqGPa+O/8QIf5883AEJl8mw
         +5DQ31S88/iP+Jszdtf2nFbtrRnSw/IlXiQpk1SOu3A5tpABWazkH3iW0v/Ir2uPV5
         Cskl0eDZZLZfQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4S5vQ015Ljz1X3P;
        Thu, 12 Oct 2023 11:56:24 -0400 (EDT)
Message-ID: <15be1d39-7901-4ffd-8f70-4be0e0f6339b@efficios.com>
Date:   Thu, 12 Oct 2023 11:56:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/fair: Bias runqueue selection towards almost
 idle prev CPU
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
References: <20230929183350.239721-1-mathieu.desnoyers@efficios.com>
 <ZRfKKxBzfu+kf0tM@chenyu5-mobl2.ccr.corp.intel.com>
 <0f3cfff3-0df4-3cb7-95cb-ea378517e13b@efficios.com>
 <ZSOMOhhkPIFmvz97@chenyu5-mobl2.ccr.corp.intel.com>
 <ebe4e40f-37df-40a9-9dfc-7f2a458151bd@efficios.com>
 <ZSZ2ERMysY7iEo+x@chenyu5-mobl2.ccr.corp.intel.com>
 <1ae6290c-843f-4e50-9c81-7146d3597ed3@efficios.com>
 <CAKfTPtA2cCy13DqL86PXcRh2P1xtSLWm1ap+uM0S8RnXc-fjRA@mail.gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAKfTPtA2cCy13DqL86PXcRh2P1xtSLWm1ap+uM0S8RnXc-fjRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-12 11:01, Vincent Guittot wrote:
> On Thu, 12 Oct 2023 at 16:33, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> On 2023-10-11 06:16, Chen Yu wrote:
>>> On 2023-10-10 at 09:49:54 -0400, Mathieu Desnoyers wrote:
>>>> On 2023-10-09 01:14, Chen Yu wrote:
>>>>> On 2023-09-30 at 07:45:38 -0400, Mathieu Desnoyers wrote:
>>>>>> On 9/30/23 03:11, Chen Yu wrote:
>>>>>>> Hi Mathieu,
>>>>>>>
>>>>>>> On 2023-09-29 at 14:33:50 -0400, Mathieu Desnoyers wrote:
>>>>>>>> Introduce the WAKEUP_BIAS_PREV_IDLE scheduler feature. It biases
>>>>>>>> select_task_rq towards the previous CPU if it was almost idle
>>>>>>>> (avg_load <= 0.1%).
>>>>>>>
>>>>>>> Yes, this is a promising direction IMO. One question is that,
>>>>>>> can cfs_rq->avg.load_avg be used for percentage comparison?
>>>>>>> If I understand correctly, load_avg reflects that more than
>>>>>>> 1 tasks could have been running this runqueue, and the
>>>>>>> load_avg is the direct proportion to the load_weight of that
>>>>>>> cfs_rq. Besides, LOAD_AVG_MAX seems to not be the max value
>>>>>>> that load_avg can reach, it is the sum of
>>>>>>> 1024 * (y + y^1 + y^2 ... )
>>>>>>>
>>>>>>> For example,
>>>>>>> taskset -c 1 nice -n -20 stress -c 1
>>>>>>> cat /sys/kernel/debug/sched/debug | grep 'cfs_rq\[1\]' -A 12 | grep "\.load_avg"
>>>>>>>       .load_avg                      : 88763
>>>>>>>       .load_avg                      : 1024
>>>>>>>
>>>>>>> 88763 is higher than LOAD_AVG_MAX=47742
>>>>>>
>>>>>> I would have expected the load_avg to be limited to LOAD_AVG_MAX somehow,
>>>>>> but it appears that it does not happen in practice.
>>>>>>
>>>>>> That being said, if the cutoff is really at 0.1% or 0.2% of the real max,
>>>>>> does it really matter ?
>>>>>>
>>>>>>> Maybe the util_avg can be used for precentage comparison I suppose?
>>>>>> [...]
>>>>>>> Or
>>>>>>> return cpu_util_without(cpu_rq(cpu), p) * 1000 <= capacity_orig_of(cpu) ?
>>>>>>
>>>>>> Unfortunately using util_avg does not seem to work based on my testing.
>>>>>> Even at utilization thresholds at 0.1%, 1% and 10%.
>>>>>>
>>>>>> Based on comments in fair.c:
>>>>>>
>>>>>>     * CPU utilization is the sum of running time of runnable tasks plus the
>>>>>>     * recent utilization of currently non-runnable tasks on that CPU.
>>>>>>
>>>>>> I think we don't want to include currently non-runnable tasks in the
>>>>>> statistics we use, because we are trying to figure out if the cpu is a
>>>>>> idle-enough target based on the tasks which are currently running, for the
>>>>>> purpose of runqueue selection when waking up a task which is considered at
>>>>>> that point in time a non-runnable task on that cpu, and which is about to
>>>>>> become runnable again.
>>>>>>
>>>>>
>>>>> Although LOAD_AVG_MAX is not the max possible load_avg, we still want to find
>>>>> a proper threshold to decide if the CPU is almost idle. The LOAD_AVG_MAX
>>>>> based threshold is modified a little bit:
>>>>>
>>>>> The theory is, if there is only 1 task on the CPU, and that task has a nice
>>>>> of 0, the task runs 50 us every 1000 us, then this CPU is regarded as almost
>>>>> idle.
>>>>>
>>>>> The load_sum of the task is:
>>>>> 50 * (1 + y + y^2 + ... + y^n)
>>>>> The corresponding avg_load of the task is approximately
>>>>> NICE_0_WEIGHT * load_sum / LOAD_AVG_MAX = 50.
>>>>> So:
>>>>>
>>>>> /* which is close to LOAD_AVG_MAX/1000 = 47 */
>>>>> #define ALMOST_IDLE_CPU_LOAD   50
>>>>
>>>> Sorry to be slow at understanding this concept, but this whole "load" value
>>>> is still somewhat magic to me.
>>>>
>>>> Should it vary based on CONFIG_HZ_{100,250,300,1000}, or is it independent ?
>>>> Where is it documented that the load is a value in "us" out of a window of
>>>> 1000 us ?
>>>>
>>>
>>> My understanding is that, the load_sum of a single task is a value in "us" out
>>> of a window of 1000 us, while the load_avg of the task will multiply the weight
>>> of the task. In this case a task with nice 0 is NICE_0_WEIGHT = 1024.
>>>
>>> __update_load_avg_se -> ___update_load_sum calculate the load_sum of a task(there
>>> is comments around ___update_load_sum to describe the pelt calculation),
>>> and ___update_load_avg() calculate the load_avg based on the task's weight.
>>
>> Thanks for your thorough explanation, now it makes sense.
>>
>> I understand as well that the cfs_rq->avg.load_sum is the result of summing
>> each task load_sum multiplied by their weight:
> 
> Please don't use load_sum but only *_avg.
> As already said, util_avg or runnable_avg are better metrics for you

I think I found out why using util_avg was not working for me.

Considering this comment from cpu_util():

  * CPU utilization is the sum of running time of runnable tasks plus the
  * recent utilization of currently non-runnable tasks on that CPU.

I don't want to include the recent utilization of currently non-runnable
tasks on that CPU in order to choose that CPU to do task placement in a
context where many tasks were recently running on that cpu (but are
currently blocked). I do not want those blocked tasks to be part of the
avg.

So I think the issue here is that I was using the cpu_util() (and
cpu_util_without()) helpers which are considering max(util, runnable),
rather than just "util".

Based on your comments, just doing this to match a rq util_avg <= 1% (10us of 1024us)
seems to work fine:

   return cpu_rq(cpu)->cfs.avg.util_avg <= 10 * capacity_of(cpu);

Is this approach acceptable ?

Thanks!

Mathieu

> 
>>
>> static inline void
>> enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
>> {
>>           cfs_rq->avg.load_avg += se->avg.load_avg;
>>           cfs_rq->avg.load_sum += se_weight(se) * se->avg.load_sum;
>> }
>>
>> Therefore I think we need to multiply the load_sum value we aim for by
>> get_pelt_divider(&cpu_rq(cpu)->cfs.avg) to compare it to a rq load_sum.
>>
>> I plan to compare the rq load sum to "10 * get_pelt_divider(&cpu_rq(cpu)->cfs.avg)"
>> to match runqueues which were previously idle (therefore with prior periods contribution
>> to the rq->load_sum being pretty much zero), and which have a current period rq load_sum
>> below or equal 10us per 1024us (<= 1%):
>>
>> static inline unsigned long cfs_rq_weighted_load_sum(struct cfs_rq *cfs_rq)
>> {
>>           return cfs_rq->avg.load_sum;
>> }
>>
>> static unsigned long cpu_weighted_load_sum(struct rq *rq)
>> {
>>           return cfs_rq_weighted_load_sum(&rq->cfs);
>> }
>>
>> /*
>>    * A runqueue is considered almost idle if:
>>    *
>>    *   cfs_rq->avg.load_sum / get_pelt_divider(&cfs_rq->avg) / 1024 <= 1%
>>    *
>>    * This inequality is transformed as follows to minimize arithmetic:
>>    *
>>    *   cfs_rq->avg.load_sum <= get_pelt_divider(&cfs_rq->avg) * 10
>>    */
>> static bool
>> almost_idle_cpu(int cpu, struct task_struct *p)
>> {
>>           if (!sched_feat(WAKEUP_BIAS_PREV_IDLE))
>>                   return false;
>>           return cpu_weighted_load_sum(cpu_rq(cpu)) <= 10 * get_pelt_divider(&cpu_rq(cpu)->cfs.avg);
>> }
>>
>> Does it make sense ?
>>
>> Thanks,
>>
>> Mathieu
>>
>>
>>>
>>>> And with this value "50", it would cover the case where there is only a
>>>> single task taking less than 50us per 1000us, and cases where the sum for
>>>> the set of tasks on the runqueue is taking less than 50us per 1000us
>>>> overall.
>>>>
>>>>>
>>>>> static bool
>>>>> almost_idle_cpu(int cpu, struct task_struct *p)
>>>>> {
>>>>>           if (!sched_feat(WAKEUP_BIAS_PREV_IDLE))
>>>>>                   return false;
>>>>>           return cpu_load_without(cpu_rq(cpu), p) <= ALMOST_IDLE_CPU_LOAD;
>>>>> }
>>>>>
>>>>> Tested this on Intel Xeon Platinum 8360Y, Ice Lake server, 36 core/package,
>>>>> total 72 core/144 CPUs. Slight improvement is observed in hackbench socket mode:
>>>>>
>>>>> socket mode:
>>>>> hackbench -g 16 -f 20 -l 480000 -s 100
>>>>>
>>>>> Before patch:
>>>>> Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
>>>>> Each sender will pass 480000 messages of 100 bytes
>>>>> Time: 81.084
>>>>>
>>>>> After patch:
>>>>> Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
>>>>> Each sender will pass 480000 messages of 100 bytes
>>>>> Time: 78.083
>>>>>
>>>>>
>>>>> pipe mode:
>>>>> hackbench -g 16 -f 20 --pipe  -l 480000 -s 100
>>>>>
>>>>> Before patch:
>>>>> Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
>>>>> Each sender will pass 480000 messages of 100 bytes
>>>>> Time: 38.219
>>>>>
>>>>> After patch:
>>>>> Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
>>>>> Each sender will pass 480000 messages of 100 bytes
>>>>> Time: 38.348
>>>>>
>>>>> It suggests that, if the workload has larger working-set/cache footprint, waking up
>>>>> the task on its previous CPU could get more benefit.
>>>>
>>>> In those tests, what is the average % of idleness of your cpus ?
>>>>
>>>
>>> For hackbench -g 16 -f 20 --pipe  -l 480000 -s 100, it is around 8~10% idle
>>> For hackbench -g 16 -f 20   -l 480000 -s 100, it is around 2~3% idle
>>>
>>> Then the CPUs in packge 1 are offlined to get stable result when the group number is low.
>>> hackbench -g 1 -f 20 --pipe  -l 480000 -s 100
>>> Some CPUs are busy, others are idle, and some are half-busy.
>>> Core  CPU     Busy%
>>> -     -       49.57
>>> 0     0       1.89
>>> 0     72      75.55
>>> 1     1       100.00
>>> 1     73      0.00
>>> 2     2       100.00
>>> 2     74      0.00
>>> 3     3       100.00
>>> 3     75      0.01
>>> 4     4       78.29
>>> 4     76      17.72
>>> 5     5       100.00
>>> 5     77      0.00
>>>
>>>
>>> hackbench -g 1 -f 20  -l 480000 -s 100
>>> Core  CPU     Busy%
>>> -     -       48.29
>>> 0     0       57.94
>>> 0     72      21.41
>>> 1     1       83.28
>>> 1     73      0.00
>>> 2     2       11.44
>>> 2     74      83.38
>>> 3     3       21.45
>>> 3     75      77.27
>>> 4     4       26.89
>>> 4     76      80.95
>>> 5     5       5.01
>>> 5     77      83.09
>>>
>>>
>>> echo NO_WAKEUP_BIAS_PREV_IDLE > /sys/kernel/debug/sched/features
>>> hackbench -g 1 -f 20 --pipe  -l 480000 -s 100
>>> Running in process mode with 1 groups using 40 file descriptors each (== 40 tasks)
>>> Each sender will pass 480000 messages of 100 bytes
>>> Time: 9.434
>>>
>>> echo WAKEUP_BIAS_PREV_IDLE > /sys/kernel/debug/sched/features
>>> hackbench -g 1 -f 20 --pipe  -l 480000 -s 100
>>> Running in process mode with 1 groups using 40 file descriptors each (== 40 tasks)
>>> Each sender will pass 480000 messages of 100 bytes
>>> Time: 9.373
>>>
>>> thanks,
>>> Chenyu
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


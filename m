Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8B07D5453
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343671AbjJXOtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjJXOtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:49:31 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74ABEA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698158963;
        bh=zGHCZniXdhqYV+3+xLYTXZ/N4NHxTm06+BqzMRnQ1RA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dHXbpumoAp5YTY0B1YAgdJb2ZnECFcqVvZH9GzqCF9vZtqA1Oqw4ysalOFRSs+IPW
         RV2Tuub3yyG3OXPEnc6QBJK2F7br58lLhCIRmr2YIo2c4x14XErV/647ZL7Nf2MDqU
         guWlJW9ySxEBiRYpHX/axz8KvievmaWbM9wUcLnMRAKMbA35eZq/tk1QD/wc924Uiq
         Z4E3IOEmTGQsaHG/UeB6zdw5/ct9gGznaC1lczMet7bk/1xnCrtt55xOUoxkhCw9kF
         /i/IOcAegN276saYKko6mykMRBo06OL42fvJTS4jeNxi4qQ222o0EQ/fxbczKgSwqh
         psv+dKNcW/w4w==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SFFM732BSz1Ypd;
        Tue, 24 Oct 2023 10:49:23 -0400 (EDT)
Message-ID: <ae8412cb-fd78-4e3e-b51a-ee290fd076bd@efficios.com>
Date:   Tue, 24 Oct 2023 10:49:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] sched/fair: Introduce UTIL_FITS_CAPACITY
 feature (v2)
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
 <20231019160523.1582101-2-mathieu.desnoyers@efficios.com>
 <f40522de-b71d-4848-8aa3-5b87d38bb847@arm.com>
 <c79ac631-61c7-4953-a657-74047a264029@efficios.com>
 <ZTdf0529DL51pj8m@chenyu5-mobl2.ccr.corp.intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZTdf0529DL51pj8m@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-24 02:10, Chen Yu wrote:
> On 2023-10-23 at 11:04:49 -0400, Mathieu Desnoyers wrote:
>> On 2023-10-23 10:11, Dietmar Eggemann wrote:
>>> On 19/10/2023 18:05, Mathieu Desnoyers wrote:
>>
>> [...]
>>>> +static unsigned long scale_rt_capacity(int cpu);
>>>> +
>>>> +/*
>>>> + * Returns true if adding the task utilization to the estimated
>>>> + * utilization of the runnable tasks on @cpu does not exceed the
>>>> + * capacity of @cpu.
>>>> + *
>>>> + * This considers only the utilization of _runnable_ tasks on the @cpu
>>>> + * runqueue, excluding blocked and sleeping tasks. This is achieved by
>>>> + * using the runqueue util_est.enqueued.
>>>> + */
>>>> +static inline bool task_fits_remaining_cpu_capacity(unsigned long task_util,
>>>> +						    int cpu)
>>>
>>> Or like find_energy_efficient_cpu() (feec(), used in
>>> Energy-Aware-Scheduling (EAS)) which uses cpu_util(cpu, p, cpu, 0) to get:
>>>
>>>     max(util_avg(CPU + p), util_est(CPU + p))
>>
>> I've tried using cpu_util(), but unfortunately anything that considers
>> blocked/sleeping tasks in its utilization total does not work for my
>> use-case.
>>
>>  From cpu_util():
>>
>>   * CPU utilization is the sum of running time of runnable tasks plus the
>>   * recent utilization of currently non-runnable tasks on that CPU.
>>
> 
> I thought cpu_util() indicates the utilization decay sum of task that was once
> "running" on this CPU, but will not sum up the "util/load" of the blocked/sleeping
> task?
> 
> accumulate_sum()
>      /* only the running task's util will be sum up */
>      if (running)
>         sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;
> 
> WRITE_ONCE(sa->util_avg, sa->util_sum / divider);

The accumulation into the cfs_rq->avg.util_sum indeed only happens when the task
is running, which means that the task does not actively contribute to increment
the util_sum when it is blocked/sleeping.

However, when the task is blocked/sleeping, the task is still attached to the
runqueue, and therefore its historic util_sum still contributes to the cfs_rq
util_sum/util_avg. This completely differs from what happens when the task is
migrated to a different runqueue, in which case its util_sum contribution is
entirely removed from the cfs_rq util_sum:

static void
enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
{
[...]
         update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH)
[...]

static void
dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
{
[...]
         if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
                 action |= DO_DETACH;
[...]

static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
{
[...]
         if (!se->avg.last_update_time && (flags & DO_ATTACH)) {

                 /*
                  * DO_ATTACH means we're here from enqueue_entity().
                  * !last_update_time means we've passed through
                  * migrate_task_rq_fair() indicating we migrated.
                  *
                  * IOW we're enqueueing a task on a new CPU.
                  */
                 attach_entity_load_avg(cfs_rq, se);
                 update_tg_load_avg(cfs_rq);

         } else if (flags & DO_DETACH) {
                 /*
                  * DO_DETACH means we're here from dequeue_entity()
                  * and we are migrating task out of the CPU.
                  */
                 detach_entity_load_avg(cfs_rq, se);
                 update_tg_load_avg(cfs_rq);
[...]

In comparison, util_est_enqueue()/util_est_dequeue() are called from enqueue_task_fair()
and dequeue_task_fair(), which include blocked/sleeping tasks scenarios. Therefore, util_est
only considers runnable tasks in its cfs_rq->avg.util_est.enqueued.

The current rq utilization total used for rq selection should not include historic
utilization of all blocked/sleeping tasks, because we are taking a decision to bring
back a recently blocked/sleeping task onto a runqueue at that point. Considering
the historic util_sum from the set of other blocked/sleeping tasks still attached to that
runqueue in the current utilization mistakenly makes the rq selection think that the rq is
busier than it really is.

I suspect that cpu_util_without() is an half-successful attempt at solving this by removing
the task p from the considered utilization, but it does not take into account scenarios where many
other tasks happen to be blocked/sleeping as well.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


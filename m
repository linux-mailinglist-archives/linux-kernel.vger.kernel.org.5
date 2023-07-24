Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9897600E5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjGXVLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGXVLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:11:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21D271BC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:11:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C96ECFEC;
        Mon, 24 Jul 2023 14:12:24 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C55063F67D;
        Mon, 24 Jul 2023 14:11:39 -0700 (PDT)
Message-ID: <cb0ddea0-2c85-f0ec-f726-14a29cf51fad@arm.com>
Date:   Mon, 24 Jul 2023 23:11:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] sched/fair: remove util_est boosting
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qyousef@layalina.io>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20230706135144.324311-1-vincent.guittot@linaro.org>
 <20230711154718.gudn32sru5opwvlw@airbuntu>
 <CAKfTPtC2NyZcVukzsYAEdhyxv__AURVuJ1JUoh8NGBmq0mL1hQ@mail.gmail.com>
 <39d63092-0e1d-2a0b-37e4-eea6789f8055@arm.com>
 <CAKfTPtB5VCLcKpmFpdq5Yq4ypAyoiv04t=ab6f2RnGodhNp5kA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtB5VCLcKpmFpdq5Yq4ypAyoiv04t=ab6f2RnGodhNp5kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 15:06, Vincent Guittot wrote:
> On Fri, 21 Jul 2023 at 18:09, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 12/07/2023 17:30, Vincent Guittot wrote:
>>> On Tue, 11 Jul 2023 at 17:47, Qais Yousef <qyousef@layalina.io> wrote:
>>>>
>>>> On 07/06/23 15:51, Vincent Guittot wrote:

[...]

>> -->
>>
>> I need the util_est = max(util_est, runnable) further down as well. Just
>> want to fetch runnable only once.
>>
>> util = 50, task_util = 5, util_est = 60, task_util_est = 10, runnable = 70
>>
>> max(70 + 5, 60 + 10) != max (70 + 5, 70 + 10) when dst_cpu == cpu
>>
> 
> Hmm, I don't get your point here. Why should they be equal ?
> 
> Below is a example to describe my problem:
> 
> task A with util_avg=200 util_est=300 runnable=200
> task A is attached to CPU0 so it contributes to CPU0's util_avg and
> runnable_avg.
> 
> In eenv_pd_max_util() we call cpu_util(cpu, p, dst_cpu, 1) to get the
> max utilization and the OPP to use to compute energy.
> 
> Let say that there is nothing else running on CPU0 and CPU1 and the
> both belong to the same performance domain so
> CPU0 util_avg= 200 util_est=0 runnable_avg=200
> CPU1 util_avg=0 util_est=0 runnable_avg=0
> 
> For CPU0, cpu_util(cpu, p, dst_cpu, 1) will return (200 + 300) = 500
> For CPU1, cpu_util(cpu, p, dst_cpu, 1) will return (0 + 300) = 300
> 
> If there is an OPP with a capacity between these 2 values, CPU1 will
> use a lower OPP than CPU0 and its computed energy will be lower.
> 
> The condition  if (max_spare_cap_cpu >= 0 && max_spare_cap >
> prev_spare_cap) filters some cases when CPU0 and CPU1 have the exact
> same spare capacity. But we often see a smaller spare capacity for
> CPU0 because of small side activities like cpufreq, timer, irq, rcu
> ... The difference is often only 1 but enough to bypass the condition
> above. task A will migrate to CPU1 whereas there is no need. Then it
> will move back to CPU0 once CPU1 will have a smaller spare capacity
> 
> I ran a test on snapdragon RB5 with the latest tip/sched/core. I start
> 3 tasks: 1 large enough to be on medium CPUs and 2 small enough to
> stay on little CPUs during 30 seconds
> With tip/sched/core, the 3 tasks are migrating around 3665
> With the patch, there is only 8 migration at the beginning of the test

I agree with this. The fact that cfs_rq->avg.runnable_avg contains
blocked contributions from task A makes it unsuitable for the util_est
(no blocked contributions) if condition (dst_cpu == cpu) since we don't
want to add A's util_est to util_est to simulate during wakeup that A is
enqueued.

>> <--
>>
>> But I assume your point is that:
>>
>> 7327       if (boost)
>> 7328           util_est = max(util_est, runnable);
>>
>> 7356       if (dst_cpu == cpu)                                   <-- (1)
>> 7357           util_est += _task_util_est(p);
>> 7358       else if (p && unlikely(task_on_rq_queued(p) || current == p))
>> 7359           lsub_positive(&util_est, _task_util_est(p));
>> 7360
>> 7361       util = max(util, util_est);
>>
>> --> (1) doesn't work anymore in case `util_est == runnable`.
>>
>> It will break the assumption for the if condition depicted in
>> cpu_util()'s comment:
> 
> exactly

OK.

>>
>> 7331  * During wake-up (2) @p isn't enqueued yet and doesn't contribute
>> 7332  * to any cpu_rq(cpu)->cfs.avg.util_est.enqueued.
>> 7333  * If @dst_cpu == @cpu add it to "simulate" cpu_util after @p
>> 7334  * has been enqueued.
>>
>> (2) eenv_pd_max_util() and find_energy_efficient_cpu() call-site.
>>
>> <---
>>
>> Rerunning Jankbench tests on Pix6 will tell if boosting util_avg instead
>> of both will still show the anticipated results. Likelihood is high that
>> it will since we do `util = max(util, util_est)` at the end of cpu_util().
> 
>  I think the same

Reran the Jankbench test with the patch (fix) on exactly the same
platform (Pixel6, Android 12) I used for v3 (base, runnable):

https://lkml.kernel.org/r/20230515115735.296329-1-dietmar.eggemann@arm.com

Max_frame_duration:
+-----------------+------------+
|     kernel      | value [ms] |
+-----------------+------------+
|      base       |   163.1    |
|    runnable     |   162.0    |
|       fix       |   157.1    |
+-----------------+------------+

Mean_frame_duration:
+-----------------+------------+----------+
|     kernel      | value [ms] | diff [%] |
+-----------------+------------+----------+
|      base       |    18.0    |    0.0   |
|    runnable     |    12.7    |  -29.43  |
|       fix       |    13.0    |  -27.78  |
+-----------------+------------+----------+

Jank percentage (Jank deadline 16ms):
+-----------------+------------+----------+
|     kernel      | value [%]  | diff [%] |
+-----------------+------------+----------+
|      base       |     3.6    |    0.0   |
|    runnable     |     1.0    |  -68.86  |
|       fix       |     1.0    |  -68.86  |
+-----------------+------------+----------+

Power usage [mW] (total - all CPUs):
+-----------------+------------+----------+
|     kernel      | value [mW] | diff [%] |
+-----------------+------------+----------+
|      base       |    129.5   |    0.0   |
|    runnable     |    134.3   |   3.71   |
|       fix       |    129.9   |   0.31   |
+-----------------+------------+----------+

Test results look good to me.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]






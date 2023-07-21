Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA9975CD43
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjGUQJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjGUQJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:09:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99D7630C4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:09:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C33972F4;
        Fri, 21 Jul 2023 09:10:06 -0700 (PDT)
Received: from [192.168.178.38] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 540863F738;
        Fri, 21 Jul 2023 09:09:21 -0700 (PDT)
Message-ID: <39d63092-0e1d-2a0b-37e4-eea6789f8055@arm.com>
Date:   Fri, 21 Jul 2023 18:09:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] sched/fair: remove util_est boosting
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qyousef@layalina.io>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20230706135144.324311-1-vincent.guittot@linaro.org>
 <20230711154718.gudn32sru5opwvlw@airbuntu>
 <CAKfTPtC2NyZcVukzsYAEdhyxv__AURVuJ1JUoh8NGBmq0mL1hQ@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtC2NyZcVukzsYAEdhyxv__AURVuJ1JUoh8NGBmq0mL1hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 17:30, Vincent Guittot wrote:
> On Tue, 11 Jul 2023 at 17:47, Qais Yousef <qyousef@layalina.io> wrote:
>>
>> On 07/06/23 15:51, Vincent Guittot wrote:
>>> There is no need to use runnable_avg when estimating util_est and that
>>> even generates wrong behavior because one includes blocked tasks whereas
>>> the other one doesn't. This can lead to accounting twice the waking task p,
>>> once with the blocked runnable_avg and another one when adding its
>>> util_est.

... and we don't have this issue for the util_avg case since we have:

7317         } else if (p && task_cpu(p) != cpu && dst_cpu == cpu)
                             ^^^^^^^^^^^^^^^^^^
7318                 util += task_util(p);

>>> cpu's runnable_avg is already used when computing util_avg which is then
>>> compared with util_est.

We discussed why I have to use max(X, runnable) for X=util and
X=util_est in v2:

https://lkml.kernel.org/r/251b524a-2c44-3892-1bae-03f879d6a64b@arm.com

-->

I need the util_est = max(util_est, runnable) further down as well. Just
want to fetch runnable only once.

util = 50, task_util = 5, util_est = 60, task_util_est = 10, runnable = 70

max(70 + 5, 60 + 10) != max (70 + 5, 70 + 10) when dst_cpu == cpu

<--

But I assume your point is that:

7327       if (boost)
7328           util_est = max(util_est, runnable);

7356       if (dst_cpu == cpu)                                   <-- (1)
7357           util_est += _task_util_est(p);
7358       else if (p && unlikely(task_on_rq_queued(p) || current == p))
7359           lsub_positive(&util_est, _task_util_est(p));
7360
7361       util = max(util, util_est);

--> (1) doesn't work anymore in case `util_est == runnable`.

It will break the assumption for the if condition depicted in
cpu_util()'s comment:

7331  * During wake-up (2) @p isn't enqueued yet and doesn't contribute
7332  * to any cpu_rq(cpu)->cfs.avg.util_est.enqueued.
7333  * If @dst_cpu == @cpu add it to "simulate" cpu_util after @p
7334  * has been enqueued.

(2) eenv_pd_max_util() and find_energy_efficient_cpu() call-site.

<---

Rerunning Jankbench tests on Pix6 will tell if boosting util_avg instead
of both will still show the anticipated results. Likelihood is high that
it will since we do `util = max(util, util_est)` at the end of cpu_util().

>>> In some situation, feec will not select prev_cpu but another one on the
>>> same performance domain because of higher max_util
>>>
>>> Fixes: 7d0583cf9ec7 ("sched/fair, cpufreq: Introduce 'runnable boosting'")
>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> ---
>>
>> Can we verify the numbers that introduced this magic boost are still valid
>> please?
> 
> TBH I don't expect it but I agree it's worth checking. Dietmar could
> you rerun your tests with this change ?

Could do. But first lets understand the issue properly.

>> Otherwise LGTM.
>>
>>
>> Thanks!
>>
>> --
>>
>> Qais Yousef
>>
>>>  kernel/sched/fair.c | 3 ---
>>>  1 file changed, 3 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index a80a73909dc2..77c9f5816c31 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -7289,9 +7289,6 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
>>>
>>>               util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
>>>
>>> -             if (boost)
>>> -                     util_est = max(util_est, runnable);
>>> -
>>>               /*
>>>                * During wake-up @p isn't enqueued yet and doesn't contribute
>>>                * to any cpu_rq(cpu)->cfs.avg.util_est.enqueued.
>>> --
>>> 2.34.1
>>>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC33576F3F8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjHCUUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHCUUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:20:47 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001453C31
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 13:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1691094045;
        bh=BwnJAGUwchCSnvzB/KGsSRuhJg4k+rsw5IMNlMkgsp8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RSNOnEaMWGmLsv9ODuWXm+7huUquqeLYyuv8Ga2nFPnJy7Fhl0CrrWK3bCkGftXI1
         gfVDtSRH5es1Da+1DYGyqegKMjsaXllX09j9IsyUFIaE82owtMJwriv3vbRWfcWKqi
         iFndSuMEqKnmtMKnOIulMQ0zmzfwnCrmlctsqYVB5H/0ez2grPvE5ejh4o+T8Lt+vk
         Flv6ZOIOGtbDiZpBh14TE2ZM8KjLpUp1xrhsHeaZ/a3dhvQBYV9T6CmwDUxruva6iE
         U4jVNmxgO9Ng/FHMpJxKzHqDCG4obmaV8s1gNTAvYAiHriK8LTEM2CpPxR7bhxoyIV
         3HfzKx+gxOnWw==
Received: from [IPV6:2605:59c8:2711:c800::c66] (unknown [IPv6:2605:59c8:2711:c800::c66])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RH0bJ0pyRz1KHD;
        Thu,  3 Aug 2023 16:20:44 -0400 (EDT)
Message-ID: <becdb227-cd7c-7724-f79e-f5ee70692e42@efficios.com>
Date:   Thu, 3 Aug 2023 16:21:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/1] sched: Extend cpu idle state for 1ms
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20230725193048.124796-1-mathieu.desnoyers@efficios.com>
 <69076f8e-191b-2e3e-d810-ea72d8ff18bb@linux.vnet.ibm.com>
 <79fa8a62-a74e-2623-9f03-1f1af85b6c07@efficios.com>
 <cab82676-27fd-b4e1-2cd8-3d8d26b44aa0@linux.vnet.ibm.com>
 <447f756c-9c79-f801-8257-a97cc8256efe@efficios.com>
 <20230801072403.GA20269@ziqianlu-dell>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230801072403.GA20269@ziqianlu-dell>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/23 03:24, Aaron Lu wrote:
> On Wed, Jul 26, 2023 at 02:56:19PM -0400, Mathieu Desnoyers wrote:
> 
> ... ...
> 
>> The updated patch:
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index a68d1276bab0..1c7d5bd2968b 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -7300,6 +7300,10 @@ int idle_cpu(int cpu)
>>   {
>>   	struct rq *rq = cpu_rq(cpu);
>> +	if (READ_ONCE(rq->nr_running) <= IDLE_CPU_DELAY_MAX_RUNNING &&
>> +	    sched_clock_cpu(cpu_of(rq)) < READ_ONCE(rq->clock_idle) + IDLE_CPU_DELAY_NS)
>> +		return 1;
>> +
>>   	if (rq->curr != rq->idle)
>>   		return 0;
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 81ac605b9cd5..57a49a5524f0 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -97,6 +97,9 @@
>>   # define SCHED_WARN_ON(x)      ({ (void)(x), 0; })
>>   #endif
>> +#define IDLE_CPU_DELAY_NS		1000000		/* 1ms */
>> +#define IDLE_CPU_DELAY_MAX_RUNNING	4
>> +
>>   struct rq;
>>   struct cpuidle_state;
>>
> 
> I gave this patch a run on Intel SPR(2 sockets/112cores/224cpus) and I
> also noticed huge improvement when running hackbench, especially for
> group=32/fds=20 case:
> 
> when group=10/fds=20(400 tasks):
>              time   wakeups/migration  tg->load_avg%
> base:        43s  27874246/13953871      25%
> this patch:  32s  33200766/244457         2%
> my patch:    37s  29186608/16307254       2%
> 
> when group=20/fds=20(800 tasks):
>              time   wakeups/migrations tg->load_avg%
> base:        65s  27108751/16238701      27%
> this patch:  45s  35718552/1691220        3%
> my patch:    48s  37506974/24797284       2%
> 
> when group=32/fds=20(1280 tasks):
>              time   wakeups/migrations tg->load_avg%
> base:       150s  36902527/16423914      36%
> this patch:  57s  30536830/6035346        6%
> my patch:    73s  45264605/21595791       3%
> 
> One thing I noticed is, after this patch, the migration on wakeup path
> has dramatically reduced(see above wakeups/migrations, the number were
> captured for 5s during the run). I think this makes sense because now a
> cpu is more likely to be considered idle so a wakeup task will more
> likely stay on its prev_cpu. And when migrations is reduced, the cost of
> accessing tg->load_avg is also reduced(tg->load_avg% is the sum of
> update_cfs_group()% + update_load_avg()% as reported by perf). I think
> this is part of the reason why performance improved on this machine.
> 
> Since I've been working on reducing the cost of accessing tg->load_avg[1],
> I also gave my patch a run. According to the result, even when the cost
> of accessing tg->load_avg is smaller for my patch, Mathieu's patch is
> still faster. It's not clear to me why, maybe it has something to do
> with cache reuse since my patch doesn't inhibit migration? I suppose ipc
> could reflect this?

I've also noticed a drastic reduction in the number of migrations with 
my patch. I have noticed that the behavior of select_task_rq changes 
drastically, but I have not figured out why yet.

I tried adding tons of schedstats counters within select_task_rq to try 
to compare the decisions taken in the baseline vs modified 
implementations of cpu_idle. I also tried to count how many times the 
target task rq changes (which implies a migration) with a breakdown by 
cause (which branch within select_task_rq cause it). I could not find a 
clear culprit yet though (and I am currently on vacation, so not working 
on this actively).

Thanks,

Mathieu


> 
> [1]: https://lore.kernel.org/lkml/20230718134120.81199-1-aaron.lu@intel.com/
> 
> Thanks,
> Aaron

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDB179AE88
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbjIKUte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242486AbjIKPmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:42:16 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BFDFB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1694446927;
        bh=Syxwlkf6fcLIusfWocvLL2xc5aA3N/sU1ARvjm858ek=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=A3myjJGlJMO03Evmb3XvNONALWrpqfbVu6kJjrrcIcgERtxHQI/hmlfpvmkLfuBUd
         FiwxviJej3FtobzTBgutOHBdM/GVRgGeDBWKs1O9ZL6JCTKMnTZiH5c5Ulb4FcoBhc
         +UUnzvLfcC6P4WF6X6ycz1VHtCjbwhacixAvyRZtBngGCkhXYvq9qgotW+WSTe8ZIc
         +GHOJmOW6II/p+38wmXhixL2zI2ssrgjUI2r/qwhiJo5OFLTFYNDDSZ8It2+g5vD+X
         eH1Kh5e3UxtssC7kQX8EiHH51ZeONSn+ccqSi6gOW/SC2Xzb024loz08kYP8fczda2
         IKdFdAFXCkydw==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RkrYq2Z0Sz1P8S;
        Mon, 11 Sep 2023 11:42:07 -0400 (EDT)
Message-ID: <db8fa2ae-317b-1c5a-e23f-9d3396165c45@efficios.com>
Date:   Mon, 11 Sep 2023 11:43:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <30a7ff14-3f48-e8cf-333f-cbb7499656e3@efficios.com>
In-Reply-To: <30a7ff14-3f48-e8cf-333f-cbb7499656e3@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 11:26, Mathieu Desnoyers wrote:
> On 9/10/23 22:50, Chen Yu wrote:
[...]
>> ---
>>   kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++---
>>   kernel/sched/features.h |  1 +
>>   kernel/sched/sched.h    |  1 +
>>   3 files changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e20f50726ab8..fe3b760c9654 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6629,6 +6629,21 @@ static void dequeue_task_fair(struct rq *rq, 
>> struct task_struct *p, int flags)
>>       hrtick_update(rq);
>>       now = sched_clock_cpu(cpu_of(rq));
>>       p->se.prev_sleep_time = task_sleep ? now : 0;
>> +#ifdef CONFIG_SMP
>> +    /*
>> +     * If this rq will become idle, and dequeued task is
>> +     * a short sleeping one, check if we can reserve
>> +     * this idle CPU for that task for a short while.
>> +     * During this reservation period, other wakees will
>> +     * skip this 'idle' CPU in select_idle_cpu(), and this
>> +     * short sleeping task can pick its previous CPU in
>> +     * select_idle_sibling(), which brings better cache
>> +     * locality.
>> +     */
>> +    if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running &&
>> +        p->se.sleep_avg && p->se.sleep_avg < 
>> sysctl_sched_migration_cost)
>> +        rq->cache_hot_timeout = now + p->se.sleep_avg;
> 
> This is really cool!
> 
> There is one scenario that worries me with this approach: workloads
> that sleep for a long time and then have short blocked periods.
> Those bursts will likely bring the average to values too high
> to stay below sysctl_sched_migration_cost.
> 
> I wonder if changing the code above for the following would help ?
> 
> if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running && 
> p->se.sleep_avg)
>      rq->cache_hot_timeout = now + min(sysctl_sched_migration_cost, 
> p->se.sleep_avg);
> 
> For tasks that have a large sleep_avg, it would activate this rq
> "appear as not idle for rq selection" scheme for a window of
> sysctl_sched_migration_cost. If the sleep ends up being a long one,
> preventing other tasks from being migrated to this rq for a tiny
> window should not matter performance-wise. I would expect that it
> could help workloads that come in bursts.

There is perhaps a better way to handle bursts:

When calculating the sleep_avg, we actually only really care about
the sleep time for short bursts, so we could use the sysctl_sched_migration_cost
to select which of the sleeps should be taken into account in the avg.

We could rename the field "sleep_avg" to "burst_sleep_avg", and have:

u64 now = sched_clock_cpu(task_cpu(p));

if ((flags & ENQUEUE_WAKEUP) && last_sleep && cpu_online(task_cpu(p)) &&
     now > last_sleep && now - last_sleep < sysctl_sched_migration_cost)
	update_avg(&p->se.burst_sleep_avg, now - last_sleep);

Then we can have this code is dequeue_task_fair:

if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running && p->se.busrt_sleep_avg)
	rq->cache_hot_timeout = now + p->se.burst_sleep_avg;

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


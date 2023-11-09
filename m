Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06027E6E32
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbjKIQFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbjKIQFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:05:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCAE719A5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:05:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC2151063;
        Thu,  9 Nov 2023 08:06:17 -0800 (PST)
Received: from [10.1.31.52] (e133649.arm.com [10.1.31.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C0D63F64C;
        Thu,  9 Nov 2023 08:05:31 -0800 (PST)
Message-ID: <cda9bff0-1fcb-4736-93e7-19659cac9a01@arm.com>
Date:   Thu, 9 Nov 2023 16:05:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] sched/uclamp: Track uclamped util_avg in
 sched_avg
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
References: <cover.1696345700.git.Hongyan.Xia2@arm.com>
 <5564fc23d5e6425d069c36b4cef48edbe77fe64d.1696345700.git.Hongyan.Xia2@arm.com>
 <d1b613d5-2207-45dd-8aa2-a276502ccaa1@arm.com>
Content-Language: en-US
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <d1b613d5-2207-45dd-8aa2-a276502ccaa1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2023 15:52, Dietmar Eggemann wrote:
> On 04/10/2023 11:04, Hongyan Xia wrote:
>> From: Hongyan Xia <hongyan.xia2@arm.com>
> 
> [...]
> 
>> @@ -6445,6 +6450,21 @@ static int sched_idle_cpu(int cpu)
>>   }
>>   #endif
>>   
>> +void ___update_util_avg_uclamp(struct sched_avg *avg, struct sched_entity *se);
> 
> IMHO, `struct sched_avg *avg` can only be the one of a cfs_rq. So
> passing a cfs_rq would eliminate the question whether this can be from
> another se.

At the moment, yes, the avg can only come from cfs_rq. The reason why I 
kept sched_avg is that once we have sum aggregation for RT tasks, it's 
very likely we will end up calling this function on rt_rq->avg, so 
having just sched_avg here will work for RT in the future.

>> +static void update_se_chain(struct task_struct *p)
>> +{
>> +#ifdef CONFIG_UCLAMP_TASK
>> +	struct sched_entity *se = &p->se;
>> +	struct rq *rq = task_rq(p);
>> +
>> +	for_each_sched_entity(se) {
>> +		struct cfs_rq *cfs_rq = cfs_rq_of(se);
>> +
>> +		___update_util_avg_uclamp(&cfs_rq->avg, se);
>> +	}
>> +#endif
>> +}
>>   /*
>>    * The enqueue_task method is called before nr_running is
>>    * increased. Here we update the fair scheduling stats and
>> @@ -6511,6 +6531,16 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>   			goto enqueue_throttle;
>>   	}
>>   
>> +	/*
>> +	 * Re-evaluate the se hierarchy now that on_rq is true. This is
>> +	 * important to enforce uclamp the moment a task with uclamp is
>> +	 * enqueued, rather than waiting a timer tick for uclamp to kick in.
>> +	 *
>> +	 * XXX: This duplicates some of the work already done in the above for
>> +	 * loops.
>> +	 */
>> +	update_se_chain(p);
> 
> I try to figure out why this is necessary here:
> 
> enqueue_task_fair()
>    for_each_sched_entity()
>      enqueue_entity()
>        update_load_avg()
>          __update_load_avg_se()
>            ___update_util_avg_uclamp()        <-- if se->on_rq,
>                                                   update p (se) if we
>                                                   cross PELT period (1)
>                                                   boundaries
>            ___decay_util_avg_uclamp_towards() <-- decay p (se)      (2)
> 
>        enqueue_util_avg_uclamp()          <-- enqueue p into cfs_rq (3)
> 
>        se->on_rq = 1                          <-- set p (se) on_rq  (4)
> 
>    for_each_sched_entity()
>      update_load_avg()                        <-- update all on_rq se's
>                                                   in the hierarchy  (5)
> 
>    update_se_chain()                          <-- update p (se) and its
>                                                   se hierarchy      (6)
> 
> (1) Skip p since it is !se->on_rq.
> 
> (2) Decay p->se->avg.util_avg_uclamp to 0 since it was sleeping.
> 
> (3) Attach p to its cfs_rq
> 
> ...
> 
> (6) Update all all se's and cfs_rq's involved in p's task_group
>      hierarchy (including propagation from se (level=x+1) to cfs_rq
>      (level=x))
> 
> Question for me is why can't you integrate the util_avg_uclamp signals
> for se's and cfs_rq's/rq's much closer into existing PELT functions?

So the problem is that when we enqueue the task (say UCLAMP_MIN of 200), 
at that exact moment se->on_rq is false, so we only decay and not 
enforce UCLAMP_MIN. Further up in the hierarchy we do update_load_avg(), 
but the se of the task has already been processed so UCLAMP_MIN has not 
taken any effect. To make sure UCLAMP_MIN is immediately effective, I 
just re-evaluate the whole hierarchy from bottom to top.

I probably didn't quite catch what you said here. Could you elaborate a 
bit on what 'much closer' means?

Hongyan

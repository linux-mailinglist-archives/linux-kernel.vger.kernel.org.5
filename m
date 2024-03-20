Return-Path: <linux-kernel+bounces-109095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 612BF881494
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9F02B22F06
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341CD524B7;
	Wed, 20 Mar 2024 15:28:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E444EB3A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948493; cv=none; b=WEWpIVJibT2olO4/FnN6IVnLf/EZeUlXb460GynrZckN+0RgV81QuCnCuxiR/XSdgXtTYlWsOyiS9U05ePa/kXH8ykA0kV8K6SELmshn2+a9JqJwmAgw2/bjWlg4YbFF6zXjAKg4bUOdjdOEYB+g5fmBBAmUpeE+qhk8WGU19EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948493; c=relaxed/simple;
	bh=cAR3SfpNl08BTR/d5eZGDCLnmxU4ySGeWy4abDSv4iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STyBFsNsLfj+EweKFStdf3NZiaQKL/u4/+Sfn/EGpX/5GF/cUz89GWhC8kPX6KCyxI97jRshysYG++IxWIE9MiqmNcD7PvSaUjDvxiQY9RPI3PcAA2OGvFGvonqjbFhXEuL1wkfYcMe7yZlKAN8WcXkLeYZm+bpRy4XCXNcecKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A1ED1007;
	Wed, 20 Mar 2024 08:28:44 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA0BB3F64C;
	Wed, 20 Mar 2024 08:28:05 -0700 (PDT)
Message-ID: <dab54fa0-be56-4438-9a1b-cd9e01fb1ba7@arm.com>
Date: Wed, 20 Mar 2024 16:27:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/7] sched/uclamp: Introduce root_cfs_util_uclamp
 for rq
Content-Language: en-US
To: Hongyan Xia <hongyan.xia2@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Christian Loehle <christian.loehle@arm.com>, linux-kernel@vger.kernel.org,
 David Dai <davidai@google.com>, Saravana Kannan <saravanak@google.com>
References: <cover.1706792708.git.hongyan.xia2@arm.com>
 <68fbd0c0bb7e2ef7a80e7359512672a235a963b1.1706792708.git.hongyan.xia2@arm.com>
 <169ae6a7-7bdd-4c54-8825-b3ad5ca1cf64@arm.com>
 <757cbe97-ba55-44b7-9b25-ad1581410147@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <757cbe97-ba55-44b7-9b25-ad1581410147@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/03/2024 12:50, Hongyan Xia wrote:
> On 18/03/2024 18:21, Dietmar Eggemann wrote:
>> On 01/02/2024 14:11, Hongyan Xia wrote:
>>
>> [...]
>>
>>>       /*
>>>        * The code below (indirectly) updates schedutil which looks at
>>> @@ -6769,6 +6770,10 @@ enqueue_task_fair(struct rq *rq, struct
>>> task_struct *p, int flags)
>>>   #ifdef CONFIG_UCLAMP_TASK
>>>       util_uclamp_enqueue(&rq->cfs.avg, p);
>>>       update_util_uclamp(0, 0, 0, &rq->cfs.avg, p);
>>> +    if (migrated)
>>
>> IMHO, you don't need 'bool __maybe_unused migrated'. You can use:
>>
>>    if (flags & ENQUEUE_MIGRATED)
> 
> I'm not sure if they are entirely equivalent. Both
> task_on_rq_migrating() and !task_on_rq_migrating() can have
> last_update_time == 0 but ENQUEUE_MIGRATED flag is only for the former.
> Maybe I'm missing something?

That's true. There are 2:

  (!task_on_rq_migrating() && !p->se.avg.last_update_time)

cases:

(1) wakeup migration: ENQUEUE_MIGRATED (0x40) set in ttwu_do_wakeup()

(2) new task: wake_up_new_task() -> activate_task(), ENQUEUE_MIGRATED is
    not set.

I assume you want to add the task's util_avg_uclamp to
rq->root_cfs_util_uclamp in (2) too? So:

    if (flags & ENQUEUE_MIGRATED || task_new)

[...]

>>>   /* avg must belong to the queue this se is on. */
>>> -void update_util_uclamp(struct sched_avg *avg, struct task_struct *p)
>>> +void update_util_uclamp(u64 now,
>>> +            u64 last_update_time,
>>> +            u32 period_contrib,
>>> +            struct sched_avg *avg,
>>> +            struct task_struct *p)
>>>   {
>>
>> I was wondering why you use such a long parameter list for this
>> function.
>>
>> IMHO
>>
>>    update_util_uclamp(u64 now, struct cfs_rq *cfs_rq, struct
>> sched_entity *se)
>>
>> would work as well. You could check whether se represents a task inside
>> update_util_uclamp() as well as get last_update_time and period_contrib.
>>
>> The only reason I see is that you want to use this function for the RT
>> class as well later, where you have to deal with 'struct rt_rq' and
>> 'struct sched_rt_entity'.
>>
>> IMHO, it's always better to keep the implementation to the minimum and
>> only introduce changes which are related to the functionality you
>> present. This would make reviewing so much easier.
> 
> Those parameters are necessary because of
> 
> if (___update_load_sum()) {
>     ___update_load_avg();
>     update_util_uclamp();
> }

So you need ___update_load_avg() happening for the `normal uclamp path`
and `last_uptade_time` and `period_contrib` for the `decay path` (1) of
update_util_uclamp()?

This is pretty hard to grasp. Isn't there a cleaner solution for this?

Why do you need the:

  if (!avg)
    return;

thing in update_util_uclamp()? __update_load_avg_blocked_se() calls
update_util_uclamp(..., avg = NULL, ...) but this should follow (1)?

> We have to cache last_update_time and period_contrib, because after
> ___update_load_sum() is done, both parameters in sched_avg have already
> been updated and overwritten and we lose the timestamp when the
> sched_avg was previously updated. update_util_uclamp() needs to know
> when sched_avg was previously updated.
> 
>>
>>>       unsigned int util, uclamp_min, uclamp_max;
>>>       int delta;
>>>   -    if (!p->se.on_rq)
>>> +    if (!p->se.on_rq) {
>>> +        ___update_util_uclamp_towards(now,
>>> +                          last_update_time,
>>> +                          period_contrib,
>>> +                          &p->se.avg.util_avg_uclamp,
>>> +                          0);
>>>           return;
>>> +    }
>>
>> You decay 'p->se.avg.util_avg_uclamp' which is not really related to
>> root_cfs_util_uclamp (patch header). IMHO, this would belong to 2/7.
> 
> I would say this still belongs to 3/7, because 2/7 only implements
> utilization for on_rq tasks. This patch implements utilization for both
> on_rq and !on_rq. For rq, we have rq->cfs.avg.util_avg_uclamp (for
> on_rq) and rq->root_cfs_util_uclamp (for on_rq plus !on_rq).

Looks like you maintain `rq->cfs.avg.util_avg_uclamp` (2) (consider all
runnable tasks) to be able to:

(a) set rq->root_cfs_util_uclamp (3) to max((3), (2))

(b) check that if 'rq->cfs.h_nr_running == 0' that (2) = 0 too.

uclamp is based on runnable tasks (so enqueue/dequeue) but you uclamp
around util_avg which has contributions from blocked tasks. And that's
why you have to maintain (3). And (3) only decays within
__update_load_avg_cfs_rq().
Can this be the reason why th implementation is so convoluted? It's
definitely more complicated than util_est with its easy layout:

  enqueue_task_fair()
    util_est_enqueue()

  dequeue_task_fair()
    util_est_dequeue()
    util_est_update()

> For tasks, we also have two utilization numbers, one is on_rq and the
> other is on_rq plus !on_rq. However, we know they do not have to be
> stored in separate variables and util_avg_uclamp can capture both.

Here you lost me. Which value does 'p->se.avg.util_avg_uclamp' store?
'runnable' or 'runnable + blocking'? I would say it's the latter one but
like in PELT we don't update the task signal when it's sleeping.

> Moving this to 2/7 might be fine, although then this would be the only
> !on_rq utilization in 2/7. I can add comments to clarify the situation.
> 
>> This is the util_avg_uclamp handling for a se (task):
>>
>> enqueue_task_fair()
>>
>>    util_uclamp_enqueue()
>>
>>    update_util_uclamp()                 (1)
>>
>>      if (!p->se.on_rq)                  (x)
>>        ___update_util_uclamp_towards()  (2)
>>
>> dequeue_task_fair()
>>
>>    util_uclamp_dequeue()
>>
>> __update_load_avg_blocked_se()
>>
>>    update_util_uclamp()
>>
>>      (x)
>>
>> __update_load_avg_se()
>>
>>    update_util_uclamp()
>>
>>      (x)
>>
>> Why is it so unbalanced? Why do you need (1) and (2)?
>>
>> Isn't this just an indication that the se util_avg_uclamp
>> is done at the wrong places?
>>
>> Is there an other way to provide a task/rq signal as the base
>> for uclamp sum aggregation?
> 
> (2) won't happen, because at that point p->se.on_rq must be 1.

I see.

> The sequence during enqueue_task_fair() is:
> 
> enqueue_task_fair(p)
>     enqueue_entity(se)
>         update_load_avg(se)
>             update_util_uclamp(p) (decay path)
>         p->se.on_rq = 1;
>     util_uclamp_enqueue(p)
>     update_util_uclamp(p) (update path)
> 
> The only reason why we want to issue update_util_uclamp() after seeing
> on_rq == 1 is that now it goes down the normal uclamp path and not the
> decay path. Otherwise, uclamp won't immediately engage during enqueue
> and has to wait a timer tick.

OK, I see, the task contribution should be visible immediately after the
enqueue.

> Ideally, we should:
> 
> enqueue_task_fair(p)
>     enqueue_entity(se)
>         update_load_avg(se)   
>             util_uclamp_enqueue(p)
>             update_util_uclamp(p) (force update path)
>         p->se.on_rq = 1;
> 
> This requires us to invent a new flag to update_util_uclamp() to force
> the update path even when p->se.on_rq is 0.

I guess you have to go this way to achieve a cleaner/easier integration
of 'util_avg_uclamp'.

> At the moment I'm treating util_avg_uclamp in the same way as util_est
> after the comments in v1, which is independent and has its own code
> path. We can go back to the old style, where util_avg_uclamp is closer
> to how we treat se rather than a separate thing like util_est.

Except that 'util_est' integration is much easier to understand. And
this is because of 'util_est' is clear runnable based only and is not
linked to any blocked part.

[...]



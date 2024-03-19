Return-Path: <linux-kernel+bounces-107484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA2A87FD2B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C0F0B21F58
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EAF7F474;
	Tue, 19 Mar 2024 11:50:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6397CF24
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849021; cv=none; b=pxCJLq+VJ9g1rUUxdmh4wticxjdzRUwvdtLdDzxvmC+J7wz4urZ1ZZ3tfxjmAocdb1Ky1ChO6Re+BV+wF4wfy0IjwEzCpMwH/w9hongMff47BEPlGTLf53q8jaXQQPGsEHglrzcHKeh+m1pEqztr9VpW7MZft7rN5HIdLXul9x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849021; c=relaxed/simple;
	bh=crDtbbvRcALSbqvPTIvtGs/O/QagU4FrULBy9omD+5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDMRmCqUwkEX4h9qhFvgVtgAOFVE0ucEK+nx+5zhT/iJ4tSh4GhOJenigsX5/3fVwIyXIuFpDm8c48KmC1iR5zhu6YQgosjbcV4XlbKi7B72rxTdsXa3aMu8PKQzo0jLAoFIcrhEzn6dqKKmMjQt4MvHHV/uC0NQ0jl26ZbbF5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5EB9153B;
	Tue, 19 Mar 2024 04:50:52 -0700 (PDT)
Received: from [10.1.36.47] (e133649.arm.com [10.1.36.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60D003F67D;
	Tue, 19 Mar 2024 04:50:15 -0700 (PDT)
Message-ID: <757cbe97-ba55-44b7-9b25-ad1581410147@arm.com>
Date: Tue, 19 Mar 2024 11:50:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/7] sched/uclamp: Introduce root_cfs_util_uclamp
 for rq
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <169ae6a7-7bdd-4c54-8825-b3ad5ca1cf64@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/03/2024 18:21, Dietmar Eggemann wrote:
> On 01/02/2024 14:11, Hongyan Xia wrote:
> 
> [...]
> 
>>   	/*
>>   	 * The code below (indirectly) updates schedutil which looks at
>> @@ -6769,6 +6770,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>   #ifdef CONFIG_UCLAMP_TASK
>>   	util_uclamp_enqueue(&rq->cfs.avg, p);
>>   	update_util_uclamp(0, 0, 0, &rq->cfs.avg, p);
>> +	if (migrated)
> 
> IMHO, you don't need 'bool __maybe_unused migrated'. You can use:
> 
>    if (flags & ENQUEUE_MIGRATED)

I'm not sure if they are entirely equivalent. Both 
task_on_rq_migrating() and !task_on_rq_migrating() can have 
last_update_time == 0 but ENQUEUE_MIGRATED flag is only for the former. 
Maybe I'm missing something?

>> +		rq->root_cfs_util_uclamp += p->se.avg.util_avg_uclamp;
>> +	rq->root_cfs_util_uclamp = max(rq->root_cfs_util_uclamp,
>> +				       rq->cfs.avg.util_avg_uclamp);
>>   	/* TODO: Better skip the frequency update in the for loop above. */
>>   	cpufreq_update_util(rq, 0);
>>   #endif
>> @@ -8252,6 +8257,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>>   		migrate_se_pelt_lag(se);
>>   	}
>>   
>> +	remove_root_cfs_util_uclamp(p);
> 
> You can't always do this here. In the '!task_on_rq_migrating()' case we
> don't hold the 'old' rq->lock.
> 
> Have a look into remove_entity_load_avg() for what we do for PELT in
> this case.
> 
> And:
> 
> 144d8487bc6e ("sched/fair: Implement synchonous PELT detach on load-balance migrate")
> e1f078f50478 ("sched/fair: Combine detach into dequeue when migrating task")
> 
> @@ -3081,6 +3081,8 @@ static inline void remove_root_cfs_util_uclamp(struct task_struct *p)
>          unsigned int root_util = READ_ONCE(rq->root_cfs_util_uclamp);
>          unsigned int p_util = READ_ONCE(p->se.avg.util_avg_uclamp), new_util;
>   
> +       lockdep_assert_rq_held(task_rq(p));
> +
>          new_util = (root_util > p_util) ? root_util - p_util : 0;
>          new_util = max(new_util, READ_ONCE(rq->cfs.avg.util_avg_uclamp));
>          WRITE_ONCE(rq->root_cfs_util_uclamp, new_util);

Ack. I saw the removed_* functions. I will change into that style.

> [...]
> 
>>   /* avg must belong to the queue this se is on. */
>> -void update_util_uclamp(struct sched_avg *avg, struct task_struct *p)
>> +void update_util_uclamp(u64 now,
>> +			u64 last_update_time,
>> +			u32 period_contrib,
>> +			struct sched_avg *avg,
>> +			struct task_struct *p)
>>   {
> 
> I was wondering why you use such a long parameter list for this
> function.
> 
> IMHO
> 
>    update_util_uclamp(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se)
> 
> would work as well. You could check whether se represents a task inside
> update_util_uclamp() as well as get last_update_time and period_contrib.
> 
> The only reason I see is that you want to use this function for the RT
> class as well later, where you have to deal with 'struct rt_rq' and
> 'struct sched_rt_entity'.
> 
> IMHO, it's always better to keep the implementation to the minimum and
> only introduce changes which are related to the functionality you
> present. This would make reviewing so much easier.

Those parameters are necessary because of

if (___update_load_sum()) {
     ___update_load_avg();
     update_util_uclamp();
}

We have to cache last_update_time and period_contrib, because after 
___update_load_sum() is done, both parameters in sched_avg have already 
been updated and overwritten and we lose the timestamp when the 
sched_avg was previously updated. update_util_uclamp() needs to know 
when sched_avg was previously updated.

> 
>>   	unsigned int util, uclamp_min, uclamp_max;
>>   	int delta;
>>   
>> -	if (!p->se.on_rq)
>> +	if (!p->se.on_rq) {
>> +		___update_util_uclamp_towards(now,
>> +					      last_update_time,
>> +					      period_contrib,
>> +					      &p->se.avg.util_avg_uclamp,
>> +					      0);
>>   		return;
>> +	}
> 
> You decay 'p->se.avg.util_avg_uclamp' which is not really related to
> root_cfs_util_uclamp (patch header). IMHO, this would belong to 2/7.

I would say this still belongs to 3/7, because 2/7 only implements 
utilization for on_rq tasks. This patch implements utilization for both 
on_rq and !on_rq. For rq, we have rq->cfs.avg.util_avg_uclamp (for 
on_rq) and rq->root_cfs_util_uclamp (for on_rq plus !on_rq).

For tasks, we also have two utilization numbers, one is on_rq and the 
other is on_rq plus !on_rq. However, we know they do not have to be 
stored in separate variables and util_avg_uclamp can capture both.

Moving this to 2/7 might be fine, although then this would be the only 
!on_rq utilization in 2/7. I can add comments to clarify the situation.

> This is the util_avg_uclamp handling for a se (task):
> 
> enqueue_task_fair()
> 
>    util_uclamp_enqueue()
> 
>    update_util_uclamp()                 (1)
> 
>      if (!p->se.on_rq)                  (x)
>        ___update_util_uclamp_towards()  (2)
> 
> dequeue_task_fair()
> 
>    util_uclamp_dequeue()
> 
> __update_load_avg_blocked_se()
> 
>    update_util_uclamp()
> 
>      (x)
> 
> __update_load_avg_se()
> 
>    update_util_uclamp()
> 
>      (x)
> 
> Why is it so unbalanced? Why do you need (1) and (2)?
> 
> Isn't this just an indication that the se util_avg_uclamp
> is done at the wrong places?
> 
> Is there an other way to provide a task/rq signal as the base
> for uclamp sum aggregation?

(2) won't happen, because at that point p->se.on_rq must be 1.

The sequence during enqueue_task_fair() is:

enqueue_task_fair(p)
	enqueue_entity(se)
		update_load_avg(se)
			update_util_uclamp(p) (decay path)
		p->se.on_rq = 1;
	util_uclamp_enqueue(p)
	update_util_uclamp(p) (update path)

The only reason why we want to issue update_util_uclamp() after seeing 
on_rq == 1 is that now it goes down the normal uclamp path and not the 
decay path. Otherwise, uclamp won't immediately engage during enqueue 
and has to wait a timer tick.

Ideally, we should:

enqueue_task_fair(p)
	enqueue_entity(se)
		update_load_avg(se)	
			util_uclamp_enqueue(p)
			update_util_uclamp(p) (force update path)
		p->se.on_rq = 1;

This requires us to invent a new flag to update_util_uclamp() to force 
the update path even when p->se.on_rq is 0.

At the moment I'm treating util_avg_uclamp in the same way as util_est 
after the comments in v1, which is independent and has its own code 
path. We can go back to the old style, where util_avg_uclamp is closer 
to how we treat se rather than a separate thing like util_est.

> [...]


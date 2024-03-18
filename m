Return-Path: <linux-kernel+bounces-106514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0466D87EFAD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847A628257A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B24555E6C;
	Mon, 18 Mar 2024 18:22:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B3C3A28B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710786119; cv=none; b=aLYR0Bd58ISfXYo2HYufUuhOFBp0ARhDsi6eNb0legw+VlinVyg+VvTUbbpZ6y8E3NjNqp0LYSZCxbjN6+X1zCDHX6QjNnzzOtFJS8N6ikTrqzEvNQr1UiZkOEH3r1+q16KvheEjC33EgckSGdL118P63/y+lwxzfFLQoJlEoFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710786119; c=relaxed/simple;
	bh=OiYZBJGXt3Jzp1dPgVCJDdjS5+ms63Kp7+uDK2T12tI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QF3ScHzH8Kzgp0d+LNMLsLFj8ZnmDP3IuaZkEG9PxJrz8cr6UP7CKgY+Z0FkQJkMwF3ZSR7BW620T1tBHsHxF8kgZdysddc2ip2Ky4baOxjNOPOnGwjunGTEQ0/PobeQOxx10uWYfllPJpJLuoxFYyhId0cgQTdynLLCU0iAkAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F4631FB;
	Mon, 18 Mar 2024 11:22:31 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5626E3F67D;
	Mon, 18 Mar 2024 11:21:53 -0700 (PDT)
Message-ID: <169ae6a7-7bdd-4c54-8825-b3ad5ca1cf64@arm.com>
Date: Mon, 18 Mar 2024 19:21:43 +0100
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
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <68fbd0c0bb7e2ef7a80e7359512672a235a963b1.1706792708.git.hongyan.xia2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 14:11, Hongyan Xia wrote:

[...]

>  	/*
>  	 * The code below (indirectly) updates schedutil which looks at
> @@ -6769,6 +6770,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  #ifdef CONFIG_UCLAMP_TASK
>  	util_uclamp_enqueue(&rq->cfs.avg, p);
>  	update_util_uclamp(0, 0, 0, &rq->cfs.avg, p);
> +	if (migrated)

IMHO, you don't need 'bool __maybe_unused migrated'. You can use:

  if (flags & ENQUEUE_MIGRATED)

> +		rq->root_cfs_util_uclamp += p->se.avg.util_avg_uclamp;
> +	rq->root_cfs_util_uclamp = max(rq->root_cfs_util_uclamp,
> +				       rq->cfs.avg.util_avg_uclamp);
>  	/* TODO: Better skip the frequency update in the for loop above. */
>  	cpufreq_update_util(rq, 0);
>  #endif
> @@ -8252,6 +8257,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  		migrate_se_pelt_lag(se);
>  	}
>  
> +	remove_root_cfs_util_uclamp(p);

You can't always do this here. In the '!task_on_rq_migrating()' case we
don't hold the 'old' rq->lock.

Have a look into remove_entity_load_avg() for what we do for PELT in
this case.

And:

144d8487bc6e ("sched/fair: Implement synchonous PELT detach on load-balance migrate")
e1f078f50478 ("sched/fair: Combine detach into dequeue when migrating task")

@@ -3081,6 +3081,8 @@ static inline void remove_root_cfs_util_uclamp(struct task_struct *p)
        unsigned int root_util = READ_ONCE(rq->root_cfs_util_uclamp);
        unsigned int p_util = READ_ONCE(p->se.avg.util_avg_uclamp), new_util;
 
+       lockdep_assert_rq_held(task_rq(p));
+
        new_util = (root_util > p_util) ? root_util - p_util : 0;
        new_util = max(new_util, READ_ONCE(rq->cfs.avg.util_avg_uclamp));
        WRITE_ONCE(rq->root_cfs_util_uclamp, new_util);

[...]

>  /* avg must belong to the queue this se is on. */
> -void update_util_uclamp(struct sched_avg *avg, struct task_struct *p)
> +void update_util_uclamp(u64 now,
> +			u64 last_update_time,
> +			u32 period_contrib,
> +			struct sched_avg *avg,
> +			struct task_struct *p)
>  {

I was wondering why you use such a long parameter list for this
function.

IMHO

  update_util_uclamp(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se)

would work as well. You could check whether se represents a task inside
update_util_uclamp() as well as get last_update_time and period_contrib.

The only reason I see is that you want to use this function for the RT
class as well later, where you have to deal with 'struct rt_rq' and
'struct sched_rt_entity'.

IMHO, it's always better to keep the implementation to the minimum and
only introduce changes which are related to the functionality you
present. This would make reviewing so much easier.


>  	unsigned int util, uclamp_min, uclamp_max;
>  	int delta;
>  
> -	if (!p->se.on_rq)
> +	if (!p->se.on_rq) {
> +		___update_util_uclamp_towards(now,
> +					      last_update_time,
> +					      period_contrib,
> +					      &p->se.avg.util_avg_uclamp,
> +					      0);
>  		return;
> +	}

You decay 'p->se.avg.util_avg_uclamp' which is not really related to
root_cfs_util_uclamp (patch header). IMHO, this would belong to 2/7.

This is the util_avg_uclamp handling for a se (task):

enqueue_task_fair()

  util_uclamp_enqueue()

  update_util_uclamp()                 (1)

    if (!p->se.on_rq)                  (x)
      ___update_util_uclamp_towards()  (2)

dequeue_task_fair()

  util_uclamp_dequeue()

__update_load_avg_blocked_se()

  update_util_uclamp()

    (x)

__update_load_avg_se()

  update_util_uclamp()

    (x)

Why is it so unbalanced? Why do you need (1) and (2)?

Isn't this just an indication that the se util_avg_uclamp
is done at the wrong places?

Is there an other way to provide a task/rq signal as the base
for uclamp sum aggregation?

[...]


Return-Path: <linux-kernel+bounces-62882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E0885276F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30FB1F265D2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776C3AD49;
	Tue, 13 Feb 2024 02:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vXROUoVV"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A25A92A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 02:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707790446; cv=none; b=sP7CUhmswa/sTyarBbkqWRqKyt4ykoof/khZf57JnZEJo4C4fiwjE+kcpkrz14o57c4xRf8EyuWJZYLy8bS868talutSbnTaYSDY7EpMWtnpYKsYjSXPryeB0jE6A4pn6n8TuBaBjwvj+CZGjPnvaCFbfjeaUHCtf3ChvavkBxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707790446; c=relaxed/simple;
	bh=0a7apLgsbpuZEV+dNZSA/koe5nIPDtmHooRo/aIzNV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzaAxBSKBiBqnmgvicB/f3GyDhpb8Xl4+Hlk5CWj6RPgrUDDYrwJ6NiEhqbVC+tJOunVn9aB5DU7qHcmkK3MJvNxAQfbBix868E/kNFNvP2Vx3QXQLZ+UXmKZPZdIozpEpVvMaTU1ozyPTh1V3Dr4TaL8AFVT19BYGPynhdbpuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=vXROUoVV; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d2e1a0337bso1841475241.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1707790442; x=1708395242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aY3FhJ8sUjXVIAVqNnWqGC74egRmSYRYK4Ik4AYL+5o=;
        b=vXROUoVVnF5DIa+7G/Kk1jrVAo+arIIAgCauS+KRqjOvxgVOwVeMgDSKSLp7HfgNs/
         VtLQa8qe7eD0u7/KasF1Jc2dCDR+4xKwrFhXXPt5Se9Cog5LRl0BAHH4YvZlbVPEbiDH
         ZqvJVW3PXmlEvvBB73p9Y7BLqZU6bTHL4IDeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707790442; x=1708395242;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aY3FhJ8sUjXVIAVqNnWqGC74egRmSYRYK4Ik4AYL+5o=;
        b=SudOimyYxTQpTwd/JtAvObXsBg3mmxkW1FVQvwHV1eUWO0dVQ0pODZ0XCfFepwAgrm
         BNZSvKum7lybYkcbDOsyFO/JAuR/07G6Lsj2Q/XUdWI2I4SnDpm/3f5dSdvx+v6bZM6l
         mg0LoxXMxd4fgTElNou6rtPs4mAsmeqn1NKpfRLJzZRI2WM8Kd5V8jrK4RkHTIvj/qKJ
         pmWVB2TdC/WUYAzJYsWaNOXeJOfNyG7RVluGpDE6d3+PAcbME1sZsvw4b//14FDgsxUN
         bPXiSfn14iQkoe/CY7Odr2MBNrzTpMCFCm3nNM5SZy96uy46T6gmmOrySZ7wOzgbefs6
         Xb8g==
X-Gm-Message-State: AOJu0YzmWxnsZt6SScz2snmz0ZR0fp7CIqUTtiXc8g0tuR+k13wiYjBO
	AX2ssQaXt7lnHoGe4Y9A5csIEKiVqv/bj+7BdVQ1jzSO60xrZY3af+GAYVclLa8=
X-Google-Smtp-Source: AGHT+IFHV/L1ORxjTFW1dPr+H/kJuIwUv9KAhvQ07f4dEFNz0ct+/Zvcg9hZypzI3g64BAdeE0KGZQ==
X-Received: by 2002:a05:6102:366a:b0:46d:75d2:6627 with SMTP id bg10-20020a056102366a00b0046d75d26627mr6551137vsb.31.1707790442563;
        Mon, 12 Feb 2024 18:14:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuIAdbNxRJyD+ESUdJZvLo9qOMwLuweo2HB5H0sX9mxFGo6hVtOUs/0JBZ/mXMOMEAs5lEml8JSsZwGHrM8dyed3yYSl3IUy79jfGKllzUJOedb6dMPJ+UBLa1UY4rEg11tR5bmSjj4ZRyudY9MeNY3LEYnYO/tIt7vdlm5F/hrv2B8PQ27FGSKYCMrWFdZKhxgAvZOt5aL3M1QsoLwXIK/v2TOhKdMG4NdOgphKUyb01pBvisuIpASQI9ogkcJeIYwmqHf3NnfZdSTeZxvFmSjzMWzD2XdUnaRV8nKIy1J/V2XKyU0yarh7m4w5E9vVvtCCFe4pqY1CQbBBDQ7uG+Ks1D50+eTD3LxgBn9yr2q3WIqc6pT83SonJUg2FrbyjbcFPbrfg9Tm121Hzt3amUqd3+32c9ywT6P/utcpSkTxu3bAUeVYlA6RENlL8BvRC392NujdQZTumlmVpCRhKaMhiPW5QS2MoUEY6kq/nJRwo96pgKVaFzo/I4xFtRcahNeW772XmExly8q6bQRMID9bK56NHTl/brIhDfW5cpb9GgsA==
Received: from [192.168.0.226] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id or32-20020a05621446a000b0068c9086c4d2sm796656qvb.10.2024.02.12.18.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 18:14:01 -0800 (PST)
Message-ID: <8cbf4bcd-431b-466f-b62d-ee03932e97f5@joelfernandes.org>
Date: Mon, 12 Feb 2024 21:13:56 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] sched/fair: Fair server interface
Content-Language: en-US
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>
References: <cover.1699095159.git.bristot@kernel.org>
 <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/2023 6:59 AM, Daniel Bristot de Oliveira wrote:
> Add an interface for fair server setup on debugfs.
> 
> Each rq have three files under /sys/kernel/debug/sched/rq/CPU{ID}:
> 
>  - fair_server_runtime: set runtime in ns
>  - fair_server_period: set period in ns
>  - fair_server_defer: on/off for the defer mechanism

Btw Daniel, there is an interesting side-effect of this interface having runtime
and period in 2 separate files :)

Say I want to set a CPU to 5ms / 10ms.

I cannot set either period or runtime to 5ms or 10ms directly.

I have to first set period to 100ms, then set runtime to 50ms, then set period
to 50ms, then set runtime to 5ms, then finally set period to 10ms.

The reason seems to be because otherwise runtime / period will not be
accomodated and will cause dl_overflow issues.

I'd suggest providing both runtime and period in the same interface to make it
more easier to use. However, for the testing I am going with what we have.

Also a request:

I was wondering if a new version of the last 3 patches could be posted to
LKML or shared in a tree somewhere. I am trying to sync to mainline and
rebase our latest fixes on top of that, however it is difficult to do because
these 3 patches are in bit of a flux (example the discussion between you and
Peter about update_curr()). What's the best way to move forward with rebasing
our fix contributions?  I am going with the sched/more in Peter's queue.git
unless you/Peter prefer something else. And I added your update_curr()
suggestion onto that, let me know if you disagree with it:

@@ -1173,6 +1171,8 @@ static void update_curr(struct cfs_rq *cfs_rq)

        if (entity_is_task(curr))
                update_curr_task(task_of(curr), delta_exec);
+       else
+               dl_server_update(&rq_of(cfs_rq)->fair_server, delta_exec);

        account_cfs_rq_runtime(cfs_rq, delta_exec);
 }

thanks,

 - Joel

> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  kernel/sched/deadline.c |  89 +++++++++++++++---
>  kernel/sched/debug.c    | 202 ++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/fair.c     |   6 --
>  kernel/sched/sched.h    |   2 +
>  4 files changed, 279 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 69ee1fbd60e4..1092ca8892e0 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -321,19 +321,12 @@ void sub_running_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
>  		__sub_running_bw(dl_se->dl_bw, dl_rq);
>  }
>  
> -static void dl_change_utilization(struct task_struct *p, u64 new_bw)
> +static void dl_rq_change_utilization(struct rq *rq, struct sched_dl_entity *dl_se, u64 new_bw)
>  {
> -	struct rq *rq;
> -
> -	WARN_ON_ONCE(p->dl.flags & SCHED_FLAG_SUGOV);
> -
> -	if (task_on_rq_queued(p))
> -		return;
> +	if (dl_se->dl_non_contending) {
> +		sub_running_bw(dl_se, &rq->dl);
> +		dl_se->dl_non_contending = 0;
>  
> -	rq = task_rq(p);
> -	if (p->dl.dl_non_contending) {
> -		sub_running_bw(&p->dl, &rq->dl);
> -		p->dl.dl_non_contending = 0;
>  		/*
>  		 * If the timer handler is currently running and the
>  		 * timer cannot be canceled, inactive_task_timer()
> @@ -341,13 +334,25 @@ static void dl_change_utilization(struct task_struct *p, u64 new_bw)
>  		 * will not touch the rq's active utilization,
>  		 * so we are still safe.
>  		 */
> -		if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
> -			put_task_struct(p);
> +		if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == 1) {
> +			if (!dl_server(dl_se))
> +				put_task_struct(dl_task_of(dl_se));
> +		}
>  	}
> -	__sub_rq_bw(p->dl.dl_bw, &rq->dl);
> +	__sub_rq_bw(dl_se->dl_bw, &rq->dl);
>  	__add_rq_bw(new_bw, &rq->dl);
>  }
>  
> +static void dl_change_utilization(struct task_struct *p, u64 new_bw)
> +{
> +	WARN_ON_ONCE(p->dl.flags & SCHED_FLAG_SUGOV);
> +
> +	if (task_on_rq_queued(p))
> +		return;
> +
> +	dl_rq_change_utilization(task_rq(p), &p->dl, new_bw);
> +}
> +
>  static void __dl_clear_params(struct sched_dl_entity *dl_se);
>  
>  /*
> @@ -1508,10 +1513,22 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
>  
>  void dl_server_start(struct sched_dl_entity *dl_se)
>  {
> +	/*
> +	 * XXX: the apply do not work fine at the init phase for the
> +	 * fair server because things are not yet set. We need to improve
> +	 * this before getting generic.
> +	 */
>  	if (!dl_server(dl_se)) {
> +		u64 runtime = 50 * NSEC_PER_MSEC;
> +		u64 period = 1000 * NSEC_PER_MSEC;
> +
> +		dl_server_apply_params(dl_se, runtime, period, 1);
> +
> +		dl_se->dl_zerolax = 1;
>  		dl_se->dl_server = 1;
>  		setup_new_dl_entity(dl_se);
>  	}
> +
>  	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
>  }
>  
> @@ -1532,6 +1549,50 @@ void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
>  	dl_se->server_pick = pick;
>  }
>  
> +int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 period, bool init)
> +{
> +	u64 old_bw = init ? 0 : to_ratio(dl_se->dl_period, dl_se->dl_runtime);
> +	u64 new_bw = to_ratio(period, runtime);
> +	struct rq *rq = dl_se->rq;
> +	int cpu = cpu_of(rq);
> +	struct dl_bw *dl_b;
> +	unsigned long cap;
> +	int retval = 0;
> +	int cpus;
> +
> +	dl_b = dl_bw_of(cpu);
> +	raw_spin_lock(&dl_b->lock);
> +	cpus = dl_bw_cpus(cpu);
> +	cap = dl_bw_capacity(cpu);
> +
> +	if (__dl_overflow(dl_b, cap, old_bw, new_bw)) {
> +		retval = -EBUSY;
> +		goto out;
> +	}
> +
> +	if (init) {
> +		__add_rq_bw(new_bw, &rq->dl);
> +		__dl_add(dl_b, new_bw, cpus);
> +	} else {
> +		__dl_sub(dl_b, dl_se->dl_bw, cpus);
> +		__dl_add(dl_b, new_bw, cpus);
> +
> +		dl_rq_change_utilization(rq, dl_se, new_bw);
> +	}
> +
> +	rq->fair_server.dl_runtime = runtime;
> +	rq->fair_server.dl_deadline  = period;
> +	rq->fair_server.dl_period  = period;
> +
> +	dl_se->dl_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
> +	dl_se->dl_density = to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
> +
> +out:
> +	raw_spin_unlock(&dl_b->lock);
> +
> +	return retval;
> +}
> +
>  /*
>   * Update the current task's runtime statistics (provided it is still
>   * a -deadline task and has not been removed from the dl_rq).
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 4580a450700e..bd7ad6b8d3de 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -333,8 +333,208 @@ static const struct file_operations sched_debug_fops = {
>  	.release	= seq_release,
>  };
>  
> +enum dl_param {
> +	DL_RUNTIME = 0,
> +	DL_PERIOD,
> +	DL_ZEROLAX
> +};
> +
> +static unsigned long fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */
> +static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
> +
> +static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubuf,
> +				       size_t cnt, loff_t *ppos, enum dl_param param)
> +{
> +	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
> +	u64 runtime, period, zerolax;
> +	struct rq *rq = cpu_rq(cpu);
> +	size_t err;
> +	int retval;
> +	u64 value;
> +
> +	err = kstrtoull_from_user(ubuf, cnt, 10, &value);
> +	if (err)
> +		return err;
> +
> +	scoped_guard (rq_lock_irqsave, rq) {
> +
> +		runtime  = rq->fair_server.dl_runtime;
> +		period = rq->fair_server.dl_period;
> +		zerolax = rq->fair_server.dl_zerolax;
> +
> +		switch (param) {
> +		case DL_RUNTIME:
> +			if (runtime == value)
> +				goto out;
> +			runtime = value;
> +			break;
> +		case DL_PERIOD:
> +			if (value == period)
> +				goto out;
> +			period = value;
> +			break;
> +		case DL_ZEROLAX:
> +			if (zerolax == value)
> +				goto out;
> +			zerolax = value;
> +			break;
> +		}
> +
> +		if (runtime > period
> +				|| period > fair_server_period_max
> +				|| period < fair_server_period_min
> +				|| zerolax > 1) {
> +			cnt = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (rq->cfs.h_nr_running) {
> +			update_rq_clock(rq);
> +			dl_server_stop(&rq->fair_server);
> +		}
> +
> +		/*
> +		 * The zerolax does not change utilization, so just
> +		 * setting it is enough.
> +		 */
> +		if (rq->fair_server.dl_zerolax != zerolax) {
> +			rq->fair_server.dl_zerolax = zerolax;
> +		} else {
> +			retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
> +			if (retval)
> +				cnt = retval;
> +		}
> +
> +		if (rq->cfs.h_nr_running)
> +			dl_server_start(&rq->fair_server);
> +	}
> +
> +out:
> +	*ppos += cnt;
> +	return cnt;
> +}
> +
> +static size_t sched_fair_server_show(struct seq_file *m, void *v, enum dl_param param)
> +{
> +	unsigned long cpu = (unsigned long) m->private;
> +	struct rq *rq = cpu_rq(cpu);
> +	u64 value;
> +
> +	switch (param) {
> +	case DL_RUNTIME:
> +		value = rq->fair_server.dl_runtime;
> +		break;
> +	case DL_PERIOD:
> +		value = rq->fair_server.dl_period;
> +		break;
> +	case DL_ZEROLAX:
> +		value = rq->fair_server.dl_zerolax;
> +	}
> +
> +	seq_printf(m, "%llu\n", value);
> +	return 0;
> +
> +}
> +
> +static ssize_t
> +sched_fair_server_runtime_write(struct file *filp, const char __user *ubuf,
> +				size_t cnt, loff_t *ppos)
> +{
> +	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_RUNTIME);
> +}
> +
> +static int sched_fair_server_runtime_show(struct seq_file *m, void *v)
> +{
> +	return sched_fair_server_show(m, v, DL_RUNTIME);
> +}
> +
> +static int sched_fair_server_runtime_open(struct inode *inode, struct file *filp)
> +{
> +	return single_open(filp, sched_fair_server_runtime_show, inode->i_private);
> +}
> +
> +static const struct file_operations fair_server_runtime_fops = {
> +	.open		= sched_fair_server_runtime_open,
> +	.write		= sched_fair_server_runtime_write,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +static ssize_t
> +sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
> +			       size_t cnt, loff_t *ppos)
> +{
> +	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_PERIOD);
> +}
> +
> +static int sched_fair_server_period_show(struct seq_file *m, void *v)
> +{
> +	return sched_fair_server_show(m, v, DL_PERIOD);
> +}
> +
> +static int sched_fair_server_period_open(struct inode *inode, struct file *filp)
> +{
> +	return single_open(filp, sched_fair_server_period_show, inode->i_private);
> +}
> +
> +static const struct file_operations fair_server_period_fops = {
> +	.open		= sched_fair_server_period_open,
> +	.write		= sched_fair_server_period_write,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +static ssize_t
> +sched_fair_server_defer_write(struct file *filp, const char __user *ubuf,
> +			      size_t cnt, loff_t *ppos)
> +{
> +	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_ZEROLAX);
> +}
> +
> +static int sched_fair_server_defer_show(struct seq_file *m, void *v)
> +{
> +	return sched_fair_server_show(m, v, DL_ZEROLAX);
> +}
> +
> +static int sched_fair_server_defer_open(struct inode *inode, struct file *filp)
> +{
> +	return single_open(filp, sched_fair_server_defer_show, inode->i_private);
> +}
> +
> +static const struct file_operations fair_server_defer_fops = {
> +	.open		= sched_fair_server_defer_open,
> +	.write		= sched_fair_server_defer_write,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
>  static struct dentry *debugfs_sched;
>  
> +static void debugfs_fair_server_init(void)
> +{
> +	long cpu;
> +	struct dentry *rq_dentry;
> +
> +	rq_dentry = debugfs_create_dir("rq", debugfs_sched);
> +	if (!rq_dentry)
> +		return;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct dentry *d_cpu;
> +		char buf[32];
> +
> +		snprintf(buf, sizeof(buf), "cpu%ld", cpu);
> +		d_cpu = debugfs_create_dir(buf, rq_dentry);
> +
> +		debugfs_create_file("fair_server_runtime", 0644, d_cpu, (void *) cpu, &fair_server_runtime_fops);
> +		debugfs_create_file("fair_server_period", 0644, d_cpu, (void *) cpu, &fair_server_period_fops);
> +		debugfs_create_file("fair_server_defer", 0644, d_cpu, (void *) cpu, &fair_server_defer_fops);
> +	}
> +}
> +
>  static __init int sched_init_debug(void)
>  {
>  	struct dentry __maybe_unused *numa;
> @@ -374,6 +574,8 @@ static __init int sched_init_debug(void)
>  
>  	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
>  
> +	debugfs_fair_server_init();
> +
>  	return 0;
>  }
>  late_initcall(sched_init_debug);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 399237cd9f59..5434c52f470d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8419,12 +8419,6 @@ void fair_server_init(struct rq *rq)
>  	struct sched_dl_entity *dl_se = &rq->fair_server;
>  
>  	init_dl_entity(dl_se);
> -
> -	dl_se->dl_runtime = 50 * NSEC_PER_MSEC;
> -	dl_se->dl_deadline = 1000 * NSEC_PER_MSEC;
> -	dl_se->dl_period = 1000 * NSEC_PER_MSEC;
> -	dl_se->dl_zerolax = 1;
> -
>  	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
>  }
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ec0e288c8e06..312b31df5860 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -341,6 +341,8 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
>  		    dl_server_pick_f pick);
>  
>  extern void fair_server_init(struct rq *);
> +extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
> +		    u64 runtime, u64 period, bool init);
>  
>  #ifdef CONFIG_CGROUP_SCHED
>  


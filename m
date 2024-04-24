Return-Path: <linux-kernel+bounces-156676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3276B8B06B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12D3283B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F32159573;
	Wed, 24 Apr 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oRkmQN9d"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FC7158D9A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952599; cv=none; b=kaDRvJRpo7tddPEyteg0g9qToJ2D/BLWjEdIyGed8OE+Sw69vIxCpwU0phn5+iR6satPbBSmoWzpTLKY3phXnyWsmaVt+5G0bwHVOnrf1rtAjzXGBxk3BZX6aVhpb2rYIlhls14kMChtAz5U1VlBnNp/D6593M+m88lYyuX3huw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952599; c=relaxed/simple;
	bh=3E8MjztnSkrTWEyHLP5cvRfLVl2S7Kr5oEE/JpJrfWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqHLuw7mkznBKAGshURFmyRBoZSmV4ZvqC/Tq3TR5Dr3ADMVmw6aHCAG8BfrKRuOtnlh9htjyd4zii1R5tlAwof+NRFk2mweE9H9ZW+LwIDfySMwBUXr4wC7hapSyCI45nKy+qUkDEzvpMgYVE0DdIvduE7rcROXhgdCRmCLS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oRkmQN9d; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VEqNIbL4SoeW4hVSCJPd6eJQtQ8Wlq3SXU81gNluTDk=; b=oRkmQN9dMm0Ykf+pLKBRlSbEl4
	tLJc5ZRt3ygdtUqfGHCLxvUqNbQxxDg0K8B7KXDKhPq9tXbH9CRoabYryM8nDRW6yPdjVw6DOc9ub
	Vag0eUYbdsXK2UAel06YsMOAreOEWVWvxLzk3PVZcMGguy3VtTBZVVfBHX2HtiVDx9jtldyFDDY0x
	RHAv10dzN37ESZvMAVuM0+7THhpjczK/XY0z65zUFLvi9DNXEdkVLLxKZk6VcM1rrlr3ePUNGpUHn
	X35CRl7g/o+J5EDzMKfrM4IplnsAewWRvxjiYhZcNNVMWZ525jXCnAZ7TaZTrd4WrcMueWmTFtI/M
	51QC1FxA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzZMh-0000000ELv2-2ld1;
	Wed, 24 Apr 2024 09:56:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5272330043E; Wed, 24 Apr 2024 11:56:35 +0200 (CEST)
Date: Wed, 24 Apr 2024 11:56:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 2/4] sched/core: change rq->nr_iowait type to
 atomic_long_t on 64-bit
Message-ID: <20240424095635.GU40213@noisy.programming.kicks-ass.net>
References: <20240416121526.67022-1-axboe@kernel.dk>
 <20240416121526.67022-3-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416121526.67022-3-axboe@kernel.dk>

On Tue, Apr 16, 2024 at 06:11:19AM -0600, Jens Axboe wrote:
> In preparation for storing two separate iowait states in there, bump the
> size from a 32-bit to a 64-bit size, for 64-bit kernels.
> 
> Note that on 32-bit, the number of tasks are limited to 0x8000, which
> fits just fine in even half of the existiing 32-bit atomic_t. For 64-bit,
> no such limit exists, hence play it safe and make it a 64-bit atomic.

We still have the tid limit, no? Anyway...

> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  kernel/sched/core.c  | 14 +++++++++++++-
>  kernel/sched/sched.h |  4 ++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 977bb08a33d2..6a6c985220b1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3723,17 +3723,29 @@ static inline cpumask_t *alloc_user_cpus_ptr(int node)
>  
>  static void task_iowait_inc(struct task_struct *p)
>  {
> +#ifdef CONFIG_64BIT
> +	atomic_long_inc(&task_rq(p)->nr_iowait);
> +#else
>  	atomic_inc(&task_rq(p)->nr_iowait);
> +#endif
>  }
>  
>  static void task_iowait_dec(struct task_struct *p)
>  {
> +#ifdef CONFIG_64BIT
> +	atomic_long_dec(&task_rq(p)->nr_iowait);
> +#else
>  	atomic_dec(&task_rq(p)->nr_iowait);
> +#endif
>  }
>  
>  int rq_iowait(struct rq *rq)
>  {
> +#ifdef CONFIG_64BIT
> +	return atomic_long_read(&rq->nr_iowait);
> +#else
>  	return atomic_read(&rq->nr_iowait);
> +#endif
>  }
>  
>  static void
> @@ -10065,7 +10077,7 @@ void __init sched_init(void)
>  #endif
>  #endif /* CONFIG_SMP */
>  		hrtick_rq_init(rq);
> -		atomic_set(&rq->nr_iowait, 0);
> +		atomic_long_set(&rq->nr_iowait, 0);
>  

This one site lacks the ifdeffery, which seems superfluous anyway, since
long is already 32bit / 64bit like you want. Hmm?

>  #ifdef CONFIG_SCHED_CORE
>  		rq->core = rq;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 387f67ddf18a..c2802d066615 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1049,7 +1049,11 @@ struct rq {
>  	u64			clock_idle_copy;
>  #endif
>  
> +#ifdef CONFIG_64BIT
> +	atomic_long_t		nr_iowait;
> +#else
>  	atomic_t		nr_iowait;
> +#endif
>  
>  #ifdef CONFIG_SCHED_DEBUG
>  	u64 last_seen_need_resched_ns;
> -- 
> 2.43.0
> 


Return-Path: <linux-kernel+bounces-135300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066AF89BE9D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671F6B21CC1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8546A335;
	Mon,  8 Apr 2024 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oehLVmri"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD4C65BAD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712577980; cv=none; b=GJVP+dp0R0xbVxqhLAkYfztMlPDtm12iFfXVpS+NbXwlcyjsq+gPu7clXre3PEmeHXQpfR8BWD6d7zedLSPk3pG5PD3QJv9Sfj+s38bh50BoRrolivFVIrL4On4oaoGDLrqiogX3dTINgFArPccRLqDB9pCrBJhSmahmNHjS95A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712577980; c=relaxed/simple;
	bh=8bVV+63vqQ9P40BJdt+++OV8CUysM3eTU59HDXX8rzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFaPxm6YF91gTtpKt1stnaYfsIkYRG745JGIaqLS5+K3kf/IKmEpBddhNZtBEIaXPTeh4GRopeVBIOsUlp97kDEK8AnuFPRcDemsTF1BUnftouuEkyCImAGGailwxKztoPbMi51KS4ZPLZP281b9vPc0FbuO/8UOYzzWtoR4Nuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oehLVmri; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fwQIKGGd8wdy0ScHZD/Dji7VSHEYb7CnE9Pt20DwgbA=; b=oehLVmrinACPapvBfVK0zoPQDW
	dkCreWuyZ6/BoBstt8LHLr83qd569H3ZUQE2+aw9LDWA8xZv6obVqRZWE0zJAoYnFsww5MqPii/Dy
	tcVGVrkSHpa0Aby20nI69pBr59P0IAiDR9fHQ3JTQ2DrxzSkwp8j8RpNqYI29ptE5HA6Vi/iWjxgL
	cl+0HC40FSYdkPig/KLHPXloEUcMi65JPj4jY9gxR391r/n68/IjHbHllb5z89j5jE0fwZJoITKja
	ewFafhBNL8Unc/wVsJvd0wwUzK71hAXmoNdY+flgJt9cScDi3WEglBScRbwNk+bwyUDR6gzjFqAm6
	cy71ktzg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtnlE-0000000HO1n-2XP7;
	Mon, 08 Apr 2024 12:06:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4778530046F; Mon,  8 Apr 2024 14:06:04 +0200 (CEST)
Date: Mon, 8 Apr 2024 14:06:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	wuyun.abel@bytedance.com, ke.wang@unisoc.com,
	xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/eevdf: Prevent vlag from exceeding the limit value
Message-ID: <20240408120604.GH21904@noisy.programming.kicks-ass.net>
References: <20240130080643.1828-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130080643.1828-1-xuewen.yan@unisoc.com>

On Tue, Jan 30, 2024 at 04:06:43PM +0800, Xuewen Yan wrote:
> There are some scenarios here that will cause vlag to
> exceed eevdf's limit.
> 
> 1. In set_next_entity, it will stash a copy of deadline
> at the point of pick in vlag, and if the task fork child,
> the child's vlag would inherit parent's vlag, as a result,
> the child's vlag is equal to the deadline. And then,
> when place_entity, because the se's vlag is wrong, it would
> cause vruntime and deadline update error.

But __sched_fork() clears it? Or am I missing something subtle?

> 2. When reweight_entity, the vlag would be recalculated,
> because the new weights are uncertain, and it may cause
> the vlag to exceed eevdf's limit.
> 
> In order to ensure that vlag does not exceed the limit,
> separate the calculation of limit from the update_entity_lag
> and create a new func limit_entity_lag. When the vlag is
> updated, use this func to prevent vlag from exceeding the limit.
> 
> And add check whether the se is forked in place_entity, and calc
> the curr's vlag to update the se's vlag.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/fair.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 533547e3c90a..3fc99b4b8b41 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -696,15 +696,22 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
>   *
>   * XXX could add max_slice to the augmented data to track this.
>   */
> +static s64 limit_entity_lag(struct sched_entity *se, s64 lag)
> +{
> +	s64 limit;
> +
> +	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
> +	return clamp(lag, -limit, limit);
> +}

I used to run with a trace_printk() in there to check how often this
trips, can you readily trigger these sites, or do you have to work hard
at it?


>  static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> -	s64 lag, limit;
> +	s64 lag;
>  
>  	SCHED_WARN_ON(!se->on_rq);
>  	lag = avg_vruntime(cfs_rq) - se->vruntime;
>  
> -	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
> -	se->vlag = clamp(lag, -limit, limit);
> +	se->vlag = limit_entity_lag(se, lag);
>  }
>  
>  /*
> @@ -3757,6 +3764,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
>  	if (avruntime != se->vruntime) {
>  		vlag = (s64)(avruntime - se->vruntime);
>  		vlag = div_s64(vlag * old_weight, weight);
> +		vlag = limit_entity_lag(se, vlag);
>  		se->vruntime = avruntime - vlag;
>  	}
>  
> @@ -3804,6 +3812,9 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>  
>  	update_load_set(&se->load, weight);
>  
> +	if (!se->on_rq)
> +		se-vlag = limit_entity_lag(se, se->vlag);
> +
>  #ifdef CONFIG_SMP
>  	do {
>  		u32 divider = get_pelt_divider(&se->avg);

> @@ -5237,6 +5258,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  		if (WARN_ON_ONCE(!load))
>  			load = 1;
>  		lag = div_s64(lag, load);
> +		lag = limit_entity_lag(se, lag);
>  	}
>  
>  	se->vruntime = vruntime - lag;
> -- 
> 2.25.1
> 


Return-Path: <linux-kernel+bounces-131032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E65898233
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BB428AFD8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738305B1F7;
	Thu,  4 Apr 2024 07:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pHjo73f9"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4E05A4C6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215687; cv=none; b=LpPFvEajbGKvOJO2LQYWRySORqTtioTtB1AO+cuT0r5lggott45JaLy5smoTKoEfoKZxoEQku0ptSPHrzePpulwe/pjSWwB1bd1yrwr182IWyM+zcjS7alRETM2CllR353lqmLDVZ2W/IKkeZ252//q+LCzjE3P8B32ik4oOLPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215687; c=relaxed/simple;
	bh=FuUPoYM2NVZrcOWscPGRH2OSb7fWaK6hQA7r7DyQ8GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9kykR7gBMZma0GR840ZkxoXNR8y02cs/O9ATEAUjtnw1Ver1b0S6S/sDEINaJCOmbYt0LY0UJLXpIHX0Otxe7nYewqmUkvXAElIHcIftk72NGGuyVMNqLv1+UVpa5fCuSFXJS9zJ3lAEGa7v+PK9jSLLozJl5cgwqUAsTF3KyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pHjo73f9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xO8ZMSdLxr9d0/gfay8+f+uA0aV7DZv0E1joQJT40kE=; b=pHjo73f9/aV3mNHtciDeJ/Pvto
	JKDg+CfB+nP9s4tQmmxHCH6ssgR4s36k9ABL47hjB2eXnrgveCnuuTz2I/ZEYuIh0Bm00ZVKyvbHh
	S+f68IYngM10iQ0Vx6TizlCErihR+4NRTH5Gufc7ZyZkEDTr6Xwml11BSV/x7rPtsB1keXUJPebwj
	drCKqp288eg9jJwLP5oN+ADCRr74PnIPJ5iejmiXD7Llvw8XfL6mKxU+VhqTcMFDyfYVzAikei+7k
	trIvOQ6o68pmXN/ZkiuDfkquEtyE0fHm80TwUCDkChEyBgoD3lP05UZod9+d2yPoMxqda6I4sBmKU
	g68kMjXA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsHVi-00000004nd9-0PRO;
	Thu, 04 Apr 2024 07:27:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B9E59300427; Thu,  4 Apr 2024 09:27:45 +0200 (CEST)
Date: Thu, 4 Apr 2024 09:27:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>,
	Rui Zhang <rui.zhang@intel.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 6/7] sched/fair: Remove on_null_domain() and redundant
 checks
Message-ID: <20240404072745.GA35684@noisy.programming.kicks-ass.net>
References: <20240403150543.2793354-1-pierre.gondois@arm.com>
 <20240403150543.2793354-7-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403150543.2793354-7-pierre.gondois@arm.com>

On Wed, Apr 03, 2024 at 05:05:38PM +0200, Pierre Gondois wrote:
> CPUs with a NULL sched domain are removed from the HKR_TYPE_SCHED
> isolation mask. The two following checks are equialent:
> - !housekeeping_runtime_test_cpu(cpu, HKR_TYPE_SCHED)
> - on_null_domain(rq)
> 
> Remove on_null_domain() and the redundant checks.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  kernel/sched/fair.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3e0f2a0f153f..9657c8f2176b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11830,11 +11830,6 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>  
>  }
>  
> -static inline int on_null_domain(struct rq *rq)
> -{
> -	return unlikely(!rcu_dereference_sched(rq->sd));
> -}
> -
>  #ifdef CONFIG_NO_HZ_COMMON
>  /*
>   * NOHZ idle load balancing (ILB) details:
> @@ -12040,7 +12035,7 @@ void nohz_balance_exit_idle(struct rq *rq)
>  	SCHED_WARN_ON(rq != this_rq());
>  
>  	/* If we're a completely isolated CPU, we don't play: */
> -	if (on_null_domain(rq))
> +	if (!housekeeping_runtime_test_cpu(cpu_of(rq), HKR_TYPE_SCHED))
>  		return;
>  
>  	if (likely(!rq->nohz_tick_stopped))

This seems broken, the whole null domain can happen with cpusets, but
this housekeeping nonsense is predicated on CPU_ISOLATION and none of
that is mandatory for CPUSETS.


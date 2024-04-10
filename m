Return-Path: <linux-kernel+bounces-139092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFC189FE6F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450A728B19B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B416B17F375;
	Wed, 10 Apr 2024 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tVfDauIE"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3217BB1B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769879; cv=none; b=mHmq4VG+U/HmcMA2gfV7pGYX9DPHo+BOvatfvwCvt+noTgwI5I9F5mQaeELoBvvyRnCzsRX2g/Oga8EG+dohw9xTfNazL7cBjwc4wGF1DMGqbeMzDXtaRFspEiRs3I5gYkYLP7x22J543M3wiYc8vXh28WhYBbIJ3x3+uECO/8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769879; c=relaxed/simple;
	bh=GvoGpP5iRxE/MGl9enmVRIj6DsHVys2Pmm7AGo9w2lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9Eg1mILTx85MMIt2G7PvyMNDeHYfF9o9Ysy0kzR9hwmDT/ohHtMZgJJCsjbgEoKx7vY0sfdjRor2wSJjQXkTtjt17LxHIAszyY2PlnclNTzhBbVF+W8s6HGSPu6d+hVZcSLXSbVID1Hq7gny6+RhiltUwMguDSxsaKHwP5dA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tVfDauIE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8u4nARNUQSWE7ExVuEJL/YhztdufOWcelQN9oZaKlV4=; b=tVfDauIEdsBGCun23CM5oxfEJh
	PGjs1bnMpDwc3U0djpTOtQvg240JoAbFvwRH3dMtLRWO6l/cbF2tdz8HV/C8UZrPzxYWDM7iA8S+y
	K1+g+r8+L2mDsyDasgkL62+91DhV9PIguW9PvBQJ/P2ImJueOQWBRb7SDHB3dGKV8ZRGYtfYfuDQj
	W6EXUqHTJ4nkkCE6bY+Q2ogMQoROF+imHt0KCmhbmfigO5vrQqNS8Ww9rBMXj3bOFa7HE6eokljQE
	xyxMqT2STJqJUgWKgz+bREP3/xjTEzYYA1j2j+cZOJGfiKNqIRaIcXhxPvuwioJJJR4R3LmI3JloO
	c5OZSEQw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rubgN-00000004wQ6-3LXO;
	Wed, 10 Apr 2024 17:24:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7826B3004D5; Wed, 10 Apr 2024 19:24:23 +0200 (CEST)
Date: Wed, 10 Apr 2024 19:24:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>
Subject: Re: [PATCH V6 1/6] sched/fair: Add trivial fair server
Message-ID: <20240410172423.GB30852@noisy.programming.kicks-ass.net>
References: <cover.1712337227.git.bristot@kernel.org>
 <d1e02419599172f4045a4711b9ff78081f568bb8.1712337227.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1e02419599172f4045a4711b9ff78081f568bb8.1712337227.git.bristot@kernel.org>

On Fri, Apr 05, 2024 at 07:28:00PM +0200, Daniel Bristot de Oliveira wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Use deadline servers to service fair tasks.
> 
> This patch adds a fair_server deadline entity which acts as a container
> for fair entities and can be used to fix starvation when higher priority
> (wrt fair) tasks are monopolizing CPU(s).
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  kernel/sched/core.c     | 24 ++++++++++++++++--------
>  kernel/sched/deadline.c | 23 +++++++++++++++++++++++
>  kernel/sched/fair.c     | 25 +++++++++++++++++++++++++
>  kernel/sched/sched.h    |  4 ++++
>  4 files changed, 68 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7019a40457a6..04e2270487b7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6007,6 +6007,14 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
>  #endif
>  
>  	put_prev_task(rq, prev);
> +
> +	/*
> +	 * We've updated @prev and no longer need the server link, clear it.
> +	 * Must be done before ->pick_next_task() because that can (re)set
> +	 * ->dl_server.
> +	 */
> +	if (prev->dl_server)
> +		prev->dl_server = NULL;
>  }
>  
>  /*
> @@ -6037,6 +6045,13 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  			p = pick_next_task_idle(rq);
>  		}
>  
> +		/*
> +		 * This is a normal CFS pick, but the previous could be a DL pick.
> +		 * Clear it as previous is no longer picked.
> +		 */
> +		if (prev->dl_server)
> +			prev->dl_server = NULL;
> +
>  		/*
>  		 * This is the fast path; it cannot be a DL server pick;
>  		 * therefore even if @p == @prev, ->dl_server must be NULL.
> @@ -6050,14 +6065,6 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  restart:
>  	put_prev_task_balance(rq, prev, rf);
>  
> -	/*
> -	 * We've updated @prev and no longer need the server link, clear it.
> -	 * Must be done before ->pick_next_task() because that can (re)set
> -	 * ->dl_server.
> -	 */
> -	if (prev->dl_server)
> -		prev->dl_server = NULL;
> -
>  	for_each_class(class) {
>  		p = class->pick_next_task(rq);
>  		if (p)

This bit seems like a fix for 63ba8422f876 ("sched/deadline: Introduce
deadline servers"), should it be a separate patch?


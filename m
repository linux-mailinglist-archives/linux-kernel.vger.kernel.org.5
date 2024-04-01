Return-Path: <linux-kernel+bounces-126478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA2089387A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601DB1C20D6C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325CB8C1E;
	Mon,  1 Apr 2024 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sj4bs0WX"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450758480
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711954003; cv=none; b=HJJ1CuMD/49Tg7s7WLIrbNp1y+8pkFISWZ5LqDFOcCfNzJlLD6QTiBGMHd5sR1gxZR9canJwKvDA+ESaZWvOkZPmeoanCJOA5Bix5bSBcJyf8ugWoOLsX1Q8YUInh9Rif2XHR1WSJw+INqf2E5AcUqIrb6etWCG/XcT8jb+vEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711954003; c=relaxed/simple;
	bh=z8P/dK3CsAyUtzukqd1O3VPqoqqqbnt3zGcfRXOcavg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9nmCQMeyQfipXyzUrelMBRohGPJgr6J/AmdhMvxkpL1zicWQ1J8w+Kw4Y4ABJMDeUhabTcM2FwSuR0G6e/QMsCOcdge8BcHfOJUkb2UQfDJ8WhSFB+ShpLA9m1sA3TfZofhvk/MviJPl9i07GvWrAraFZG5yJkF0LaMAtq7k/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sj4bs0WX; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4074167c-ae18-4376-b7aa-5ad0a8522183@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711953997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MM91hzCK4vPHixa9r3DKbTxOEt8q7Jiwn+iEwSXtp/k=;
	b=sj4bs0WXuHcclQmIKBHlU/05VazN5C2YyOI0NzLQ0ltTo3CLZtt31ljTw6fS74iRd96SFL
	8dvrgH7fd0mO03+eP5iFOwr/jIJ/ODrvrDjuHiYxDIBaGQumFSF0j3OWkMCeuiaiTq81Y4
	gvQ3r8nFdSPZ13xktjIuGg2WzGJyF7o=
Date: Mon, 1 Apr 2024 14:46:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] sched/psi: Optimise psi_group_change a bit
Content-Language: en-US
To: Tvrtko Ursulin <tursulin@igalia.com>, linux-kernel@vger.kernel.org
Cc: Tvrtko Ursulin <tursulin@ursulin.net>,
 Johannes Weiner <hannes@cmpxchg.org>, Suren Baghdasaryan
 <surenb@google.com>, Peter Ziljstra <peterz@infradead.org>,
 kernel-dev@igalia.com
References: <20240329160648.86999-1-tursulin@igalia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240329160648.86999-1-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/30 00:06, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tursulin@ursulin.net>
> 
> The current code loops over the psi_states only to call a helper which
> then resolves back to the action needed for each state using a switch
> statement. That is effectively creating a double indirection of a kind
> which, given how all the states need to be explicitly listed and handled
> anyway, we can simply remove. Both the for loop and the switch statement
> that is.
> 
> The benefit is both in the code size and CPU time spent in this function.
> YMMV but on my Steam Deck, while in a game, the patch makes the CPU usage
> go from ~2.4% down to ~1.2%. Text size at the same time went from 0x323 to
> 0x2c1.
> 
> Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Peter Ziljstra <peterz@infradead.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-dev@igalia.com

Nice!

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>  kernel/sched/psi.c | 54 +++++++++++++++++++++++-----------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 7b4aa5809c0f..55720ecf420e 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -218,28 +218,32 @@ void __init psi_init(void)
>  	group_init(&psi_system);
>  }
>  
> -static bool test_state(unsigned int *tasks, enum psi_states state, bool oncpu)
> +static u32 test_states(unsigned int *tasks, u32 state_mask)
>  {
> -	switch (state) {
> -	case PSI_IO_SOME:
> -		return unlikely(tasks[NR_IOWAIT]);
> -	case PSI_IO_FULL:
> -		return unlikely(tasks[NR_IOWAIT] && !tasks[NR_RUNNING]);
> -	case PSI_MEM_SOME:
> -		return unlikely(tasks[NR_MEMSTALL]);
> -	case PSI_MEM_FULL:
> -		return unlikely(tasks[NR_MEMSTALL] &&
> -			tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING]);
> -	case PSI_CPU_SOME:
> -		return unlikely(tasks[NR_RUNNING] > oncpu);
> -	case PSI_CPU_FULL:
> -		return unlikely(tasks[NR_RUNNING] && !oncpu);
> -	case PSI_NONIDLE:
> -		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
> -			tasks[NR_RUNNING];
> -	default:
> -		return false;
> +	const bool oncpu = state_mask & PSI_ONCPU;
> +
> +	if (tasks[NR_IOWAIT]) {
> +		state_mask |= BIT(PSI_IO_SOME);
> +		if (!tasks[NR_RUNNING])
> +			state_mask |= BIT(PSI_IO_FULL);
>  	}
> +
> +	if (tasks[NR_MEMSTALL]) {
> +		state_mask |= BIT(PSI_MEM_SOME);
> +		if (tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING])
> +			state_mask |= BIT(PSI_MEM_FULL);
> +	}
> +
> +	if (tasks[NR_RUNNING] > oncpu)
> +		state_mask |= BIT(PSI_CPU_SOME);
> +
> +	if (tasks[NR_RUNNING] && !oncpu)
> +		state_mask |= BIT(PSI_CPU_FULL);
> +
> +	if (tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] || tasks[NR_RUNNING])
> +		state_mask |= BIT(PSI_NONIDLE);
> +
> +	return state_mask;
>  }
>  
>  static void get_recent_times(struct psi_group *group, int cpu,
> @@ -770,7 +774,6 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  {
>  	struct psi_group_cpu *groupc;
>  	unsigned int t, m;
> -	enum psi_states s;
>  	u32 state_mask;
>  
>  	groupc = per_cpu_ptr(group->pcpu, cpu);
> @@ -841,10 +844,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  		return;
>  	}
>  
> -	for (s = 0; s < NR_PSI_STATES; s++) {
> -		if (test_state(groupc->tasks, s, state_mask & PSI_ONCPU))
> -			state_mask |= (1 << s);
> -	}
> +	state_mask = test_states(groupc->tasks, state_mask);
>  
>  	/*
>  	 * Since we care about lost potential, a memstall is FULL
> @@ -1194,7 +1194,7 @@ void psi_cgroup_restart(struct psi_group *group)
>  	/*
>  	 * After we disable psi_group->enabled, we don't actually
>  	 * stop percpu tasks accounting in each psi_group_cpu,
> -	 * instead only stop test_state() loop, record_times()
> +	 * instead only stop test_states() loop, record_times()
>  	 * and averaging worker, see psi_group_change() for details.
>  	 *
>  	 * When disable cgroup PSI, this function has nothing to sync
> @@ -1202,7 +1202,7 @@ void psi_cgroup_restart(struct psi_group *group)
>  	 * would see !psi_group->enabled and only do task accounting.
>  	 *
>  	 * When re-enable cgroup PSI, this function use psi_group_change()
> -	 * to get correct state mask from test_state() loop on tasks[],
> +	 * to get correct state mask from test_states() loop on tasks[],
>  	 * and restart groupc->state_start from now, use .clear = .set = 0
>  	 * here since no task status really changed.
>  	 */


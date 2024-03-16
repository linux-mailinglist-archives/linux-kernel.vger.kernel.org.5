Return-Path: <linux-kernel+bounces-105093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CF787D8FF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 06:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CBBBB213BA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 05:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D2AC2ED;
	Sat, 16 Mar 2024 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjvigbZd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CFE6AA1;
	Sat, 16 Mar 2024 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710567661; cv=none; b=d7VkeznXW6g+GxMKiatpSUE1VzFhEW/4mwXqyIFmWi0B9+iDbgT2vRDxU4mj9it8cGQNndOqohipFD1m37YC8KydzNAFAc9ucFUH+URvOW3ETOPBRMc60N/xSELI7ifUaE+sHX0hImDs3UoITb0VJPUwpFeCfboT3zx9ufA6oDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710567661; c=relaxed/simple;
	bh=zpFhiM3PAxX/JyJRkDpY9ZV+mL+lJb4usahl35U/Ujg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIMrc6muPQz+uFFwHGfI8FC95AwtE5hjOlPQD5LMoOs1yzFuOMQsVyVt3gqiCzPzc9tk0uUEgtzXhLGFC3Z8jXFFKCj1Wvq+mnUM7oczDR2SyUIsM4yg2QSVt3uCq4B85BbVUEeA9Vdp8LKJWM8srIrHPxNsfm0jqSrRjDb5iXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjvigbZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A28C433F1;
	Sat, 16 Mar 2024 05:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710567660;
	bh=zpFhiM3PAxX/JyJRkDpY9ZV+mL+lJb4usahl35U/Ujg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HjvigbZdMD0owzOJXTmHchrakQ4u/PHtXuAreEUfas8c7Eq4XwuMIZr3bAjk+cuEl
	 /Lx88pQFy1UQN0KcvNDkZv6Wv3lMzOuki0GRGL060d/YDdYIdURoKvImT5K3UiIfId
	 Ccj1dJ0p3DWvY3FPO8wh1SWvd3OiCDAGlc9jJq+FfGw1Rg6xzhreIwMnNkPW4g3pMN
	 Jp+1+0rtoFOjMg5UQnsFTUu6z6tNdPpeZMVeKtWRkOlNSwA9ziA654tikdsFQDQUrK
	 4nfNkjxQqo+SU3cKnfpgQN0RXAaFJBzsB8pfznYJKX6b+iQSLZSRumAvywJsGAnkWq
	 46/voqVzs0SbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8CBF0CE0D20; Fri, 15 Mar 2024 22:40:56 -0700 (PDT)
Date: Fri, 15 Mar 2024 22:40:56 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH v4 net 1/3] rcu: add a helper to report consolidated
 flavor QS
Message-ID: <790ce7e7-a8fd-4d28-aaf3-1b991a898be2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cover.1710525524.git.yan@cloudflare.com>
 <491d3af6c7d66dfb3b60b2f210f38e843dfe6ed2.1710525524.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <491d3af6c7d66dfb3b60b2f210f38e843dfe6ed2.1710525524.git.yan@cloudflare.com>

On Fri, Mar 15, 2024 at 12:55:03PM -0700, Yan Zhai wrote:
> There are several scenario in network processing that can run
> extensively under heavy traffic. In such situation, RCU synchronization
> might not observe desired quiescent states for indefinitely long period.
> Create a helper to safely raise the desired RCU quiescent states for
> such scenario.
> 
> Currently the frequency is locked at HZ/10, i.e. 100ms, which is
> sufficient to address existing problems around RCU tasks. It's unclear
> yet if there is any future scenario for it to be further tuned down.

I suggest something like the following for the commit log:

------------------------------------------------------------------------

When under heavy load, network processing can run CPU-bound for many tens
of seconds.  Even in preemptible kernels, this can block RCU Tasks grace
periods, which can cause trace-event removal to take more than a minute,
which is unacceptably long.

This commit therefore creates a new helper function that passes
through both RCU and RCU-Tasks quiescent states every 100 milliseconds.
This hard-coded value suffices for current workloads.

------------------------------------------------------------------------

> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
> v3->v4: comment fixup
> 
> ---
>  include/linux/rcupdate.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 0746b1b0b663..da224706323e 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -247,6 +247,30 @@ do { \
>  	cond_resched(); \
>  } while (0)
>  
> +/**
> + * rcu_softirq_qs_periodic - Periodically report consolidated quiescent states
> + * @old_ts: last jiffies when QS was reported. Might be modified in the macro.
> + *
> + * This helper is for network processing in non-RT kernels, where there could
> + * be busy polling threads that block RCU synchronization indefinitely.  In
> + * such context, simply calling cond_resched is insufficient, so give it a
> + * stronger push to eliminate all potential blockage of all RCU types.
> + *
> + * NOTE: unless absolutely sure, this helper should in general be called
> + * outside of bh lock section to avoid reporting a surprising QS to updaters,
> + * who could be expecting RCU read critical section to end at local_bh_enable().
> + */

How about something like this for the kernel-doc comment?

/**
 * rcu_softirq_qs_periodic - Report RCU and RCU-Tasks quiescent states
 * @old_ts: jiffies at start of processing.
 *
 * This helper is for long-running softirq handlers, such as those
 * in networking.  The caller should initialize the variable passed in
 * as @old_ts at the beginning of the softirq handler.  When invoked
 * frequently, this macro will invoke rcu_softirq_qs() every 100
 * milliseconds thereafter, which will provide both RCU and RCU-Tasks
 * quiescent states.  Note that this macro modifies its old_ts argument.
 *
 * Note that although cond_resched() provides RCU quiescent states,
 * it does not provide RCU-Tasks quiescent states.
 *
 * Because regions of code that have disabled softirq act as RCU
 * read-side critical sections, this macro should be invoked with softirq
 * (and preemption) enabled.
 *
 * This macro has no effect in CONFIG_PREEMPT_RT kernels.
 */

							Thanx, Paul

> +#define rcu_softirq_qs_periodic(old_ts) \
> +do { \
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && \
> +	    time_after(jiffies, (old_ts) + HZ / 10)) { \
> +		preempt_disable(); \
> +		rcu_softirq_qs(); \
> +		preempt_enable(); \
> +		(old_ts) = jiffies; \
> +	} \
> +} while (0)
> +
>  /*
>   * Infrastructure to implement the synchronize_() primitives in
>   * TREE_RCU and rcu_barrier_() primitives in TINY_RCU.
> -- 
> 2.30.2
> 
> 


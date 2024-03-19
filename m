Return-Path: <linux-kernel+bounces-108154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E8E8806C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027D92832C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DA1446DE;
	Tue, 19 Mar 2024 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNqxTTDm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4AF3FBBF;
	Tue, 19 Mar 2024 21:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883915; cv=none; b=iQyutkMj49GOMucjWH+yrNSqFjYHacUtjQh19w2k5/iAS9rw5OsChS+xktRaRiSarzo00EEHL28erlq5Z4RT1VM1PY9v2Pm8FylLTOel/AJvPTAGLjzuk5Rzj9Q5dYLf2X10UWahppbQq8+9AYwxYlBkcKnffPP3ZEcayf+k6N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883915; c=relaxed/simple;
	bh=fUaALyLJ2vU18yvgwRSHObW1ENVTzQxDLGlJ50YixzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZadhEQii6lTwC7fhxV0psnDELtKy7MWhQW4USh4o9WpK+dB/eCQYZoNqpQ7e5UqEX6jRXoqMzwu7R+mFrW9+sRGAHsdn0RXZrAz+N86Y5FbSMTNCoynduFrHrt+G2Rw4DgdUIxm+/+4Y6puYqRtjgDij0Kl7XywO/F1S6NXIo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNqxTTDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AF9C433C7;
	Tue, 19 Mar 2024 21:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710883914;
	bh=fUaALyLJ2vU18yvgwRSHObW1ENVTzQxDLGlJ50YixzU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gNqxTTDm2rAVbiV2JjEQ55WiDnbEqbvhFrgXjeSj/7E0j/hVfMyE15Ocidyef4VIc
	 Uat8d4qhOkfOolvFjBxsk54tqQCwgx6f0RTaAbSK4c4ecOMcT27iyEUkClsGEgvjIj
	 646ddwAbhWPhJssYtzGlEFr+W+F0nWEZL1fqBFay/o0WylnzGqblvFXqO3fRszR//F
	 eJ9a6cMUzdPWxGklY5H49oG7E5ePfQxOT5CQ8ZoS5+BocQHlYnfPViuwcG/QneJjIs
	 1RFl9YXQcruJvWSffyc0oiGBVn05ugJF8Fs3XpMK4FbM54WwLq1QErkmAP73TyugyR
	 Jaqe+J8eMr6gA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7D064CE16D7; Tue, 19 Mar 2024 14:31:51 -0700 (PDT)
Date: Tue, 19 Mar 2024 14:31:51 -0700
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
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v5 net 1/3] rcu: add a helper to report consolidated
 flavor QS
Message-ID: <6149ecfc-2a3b-4bea-a79f-ef5be0a36cd7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cover.1710877680.git.yan@cloudflare.com>
 <90431d46ee112d2b0af04dbfe936faaca11810a5.1710877680.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90431d46ee112d2b0af04dbfe936faaca11810a5.1710877680.git.yan@cloudflare.com>

On Tue, Mar 19, 2024 at 01:44:34PM -0700, Yan Zhai wrote:
> When under heavy load, network processing can run CPU-bound for many
> tens of seconds. Even in preemptible kernels (non-RT kernel), this can
> block RCU Tasks grace periods, which can cause trace-event removal to
> take more than a minute, which is unacceptably long.
> 
> This commit therefore creates a new helper function that passes through
> both RCU and RCU-Tasks quiescent states every 100 milliseconds. This
> hard-coded value suffices for current workloads.
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>

If you would like me to take this one via -rcu, I would be happy to take
it.  If it would be easier for you to push these as a group though
networking:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> v4->v5: adjusted kernel docs and commit message
> v3->v4: kernel docs error
> 
> ---
>  include/linux/rcupdate.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 16f519914415..17d7ed5f3ae6 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -247,6 +247,37 @@ do { \
>  	cond_resched(); \
>  } while (0)
>  
> +/**
> + * rcu_softirq_qs_periodic - Report RCU and RCU-Tasks quiescent states
> + * @old_ts: jiffies at start of processing.
> + *
> + * This helper is for long-running softirq handlers, such as NAPI threads in
> + * networking. The caller should initialize the variable passed in as @old_ts
> + * at the beginning of the softirq handler. When invoked frequently, this macro
> + * will invoke rcu_softirq_qs() every 100 milliseconds thereafter, which will
> + * provide both RCU and RCU-Tasks quiescent states. Note that this macro
> + * modifies its old_ts argument.
> + *
> + * Because regions of code that have disabled softirq act as RCU read-side
> + * critical sections, this macro should be invoked with softirq (and
> + * preemption) enabled.
> + *
> + * The macro is not needed when CONFIG_PREEMPT_RT is defined. RT kernels would
> + * have more chance to invoke schedule() calls and provide necessary quiescent
> + * states. As a contrast, calling cond_resched() only won't achieve the same
> + * effect because cond_resched() does not provide RCU-Tasks quiescent states.
> + */
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


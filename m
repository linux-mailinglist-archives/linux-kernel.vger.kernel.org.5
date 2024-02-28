Return-Path: <linux-kernel+bounces-85552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2231586B7A3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7DCDB21C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D964F71EC7;
	Wed, 28 Feb 2024 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqdIO8tH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251B871EAE;
	Wed, 28 Feb 2024 18:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146113; cv=none; b=kbYvDlikFsKxANcYqPln4bLNfh350NLb2/pJbUsN/XQ/fPIphFZCpRMLKQwE/LkWBSoOf3cFZoHNL5lCNCQkKpqH3ZmYUmrSY2i+c4A6tlXiUAG5NX3my0TToRvAkGRn6yQGAehNTUlNK2zj2GKbO2YwtxuV5Lh1auDvXpyXOCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146113; c=relaxed/simple;
	bh=I1FvYieTX2lMCO6HW6oRx/DgD5ZUO5pYflH+dqxQSng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVINBu1JoJQE/qU3jFuSoYD85mWlMq2ni8q9AnHp+ILzYJendatO3h+ZlH5yvVXfbT8u69/xNrrARxFDe1RADWpvv008gxgPd9CFNwNrGnr3MjEbF2dmE9gPXEoDAb+ZNFNDDfXIP7ZVLcHptMN53i4ImXpU1gH7PszPsXP8oeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqdIO8tH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A71CC433C7;
	Wed, 28 Feb 2024 18:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709146112;
	bh=I1FvYieTX2lMCO6HW6oRx/DgD5ZUO5pYflH+dqxQSng=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jqdIO8tHM3uGKe8pv5ysvLhoq4IOs9HFHDWQDhPTxG6BeA3vlZHY6OtcVIkA7VXbw
	 M89Fs7z6k9gNnYIoSlr4sOcu/VUw1pBGeG177PNsJqSQdluOFLVNhn3cr6rHRHrV9w
	 tTXazdvUHLxclGVvffSZfHqlCI35ScxuWDXorBj8gyC+CdQ/qcV76d21adR3hLSOc2
	 TI6WQZU1LafFB5d1wAc/dnIrzFct+CoTLEWSCmQlypP27eDS75ddSiTEDM0JTXukiS
	 HlmQmS73NFDLQniye+Vv8RbZHc7relEffN11zK1KrAiSxIZ+nA6Kkfmn1o0hC+BgLU
	 4CUAlX9bzLH2g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 13D5BCE0358; Wed, 28 Feb 2024 10:48:32 -0800 (PST)
Date: Wed, 28 Feb 2024 10:48:32 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tracepoints: Use WARN() and not WARN_ON() for warnings
Message-ID: <23ffccec-8fb5-4f44-a193-0d21eaf07d1b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240228133112.0d64fb1b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228133112.0d64fb1b@gandalf.local.home>

On Wed, Feb 28, 2024 at 01:31:12PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> There are two WARN_ON*() warnings in tracepoint.h that deal with RCU
> usage. But when they trigger, especially from using a TRACE_EVENT()
> macro, the information is not very helpful and is confusing:
> 
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 0 at include/trace/events/lock.h:24 lock_acquire+0x2b2/0x2d0
> 
> Where the above warning takes you to:
> 
>  TRACE_EVENT(lock_acquire,  <<<--- line 24 in lock.h
> 
> 	TP_PROTO(struct lockdep_map *lock, unsigned int subclass,
> 		int trylock, int read, int check,
> 		struct lockdep_map *next_lock, unsigned long ip),
> 	[..]
> 
> Change the WARN_ON_ONCE() to WARN_ONCE() and add a string that allows
> someone to search for exactly where the bug happened.
> 
> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/tracepoint.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 88c0ba623ee6..689b6d71590e 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -199,7 +199,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		if (!(cond))						\
>  			return;						\
>  									\
> -		if (WARN_ON_ONCE(RCUIDLE_COND(rcuidle)))		\
> +		if (WARN_ONCE(RCUIDLE_COND(rcuidle),			\
> +			      "Bad RCU usage for tracepoint"))		\
>  			return;						\
>  									\
>  		/* keep srcu and sched-rcu usage consistent */		\
> @@ -259,7 +260,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  				TP_ARGS(args),				\
>  				TP_CONDITION(cond), 0);			\
>  		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
> -			WARN_ON_ONCE(!rcu_is_watching());		\
> +			WARN_ONCE(!rcu_is_watching(),			\
> +				  "RCU not watching for tracepoint");	\
>  		}							\
>  	}								\
>  	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
> -- 
> 2.43.0
> 


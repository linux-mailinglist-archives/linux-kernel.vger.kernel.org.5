Return-Path: <linux-kernel+bounces-62542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3786852296
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595FDB23625
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339334F8AB;
	Mon, 12 Feb 2024 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FceIkvCk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7248C4F611;
	Mon, 12 Feb 2024 23:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780978; cv=none; b=IHVCINJtCsJHD+HZdC8Xf/H5WwHM7utNZJ+q6DgTHh0cm5gG3bxi1k0Mx/ncDcZAePMW6/00noLS3CQGZZTybXGVMyOjQnjip97V2xRCOAaj0QjuyPSZ+fuVjYM79NbpQABLe3Yyx5LIwFz4vMDy1rlycrlMzOQGYDD5peBTPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780978; c=relaxed/simple;
	bh=wDhcWRCmEINJ3bjI2gAhFxFaF9zFLEJA9Bnbfrz58rU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VDbT2CMjHtEYvYbxdeM4POxg45zTdWAmrb2YKx59SEV76Fjjqe44ubuFAKm1ADHezDai4kN+bqnOjPMSy/l1HyqIkUtBFAgG4YSykMgjdJIwG+/e89M71ffevDxafP1uUEoQIwaIxYcCE/D7nLD5RI08Qw6RrjqltFlnrzxhOPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FceIkvCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8E9C433F1;
	Mon, 12 Feb 2024 23:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707780978;
	bh=wDhcWRCmEINJ3bjI2gAhFxFaF9zFLEJA9Bnbfrz58rU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FceIkvCkZfBR1eVZ2W3IXtAEwIPYWgKiGc2uwItboGq0WDB99rK4iYaAH2SgQ+Mmk
	 yrc2eudriIYcZlbqlaG4PuzpxM8Mlqpd4Tx8kcEiKTyaicwNh/Oj9PHW++l90d/D4h
	 axhVRgiTJWQly8JHcHxGt+gs9oYd4lLOTovVOO+6SSaLYwO9cCzvQwpJITuA2YxK3+
	 xvVqmPQTyxop7UG8BFQ6pIsGRLwjf/ZiJ8TaAsaMGCD3nEVtSDEuYo4lmOtk9PWbjK
	 Ic6lDDwflWP8tluLU5EOSp7JO94Mx5N+tXwfwMe4PzV42JXkxEVAwclfbSxmvSkon6
	 gz+TPCjPUIIUw==
Date: Tue, 13 Feb 2024 08:36:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>,
 Vincent Donnefort <vdonnefort@google.com>, Sven Schnelle
 <svens@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>
Subject: Re: [PATCH] tracing: Have saved_cmdlines arrays all in one
 allocation
Message-Id: <20240213083613.dc8e7ad487988542a6890b2c@kernel.org>
In-Reply-To: <20240212180941.379c419b@gandalf.local.home>
References: <20240212180941.379c419b@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 18:09:41 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The saved_cmdlines have three arrays for mapping PIDs to COMMs:
> 
>  - map_pid_to_cmdline[]
>  - map_cmdline_to_pid[]
>  - saved_cmdlines
> 
> The map_pid_to_cmdline[] is PID_MAX_DEFAULT in size and holds the index
> into the other arrays. The map_cmdline_to_pid[] is a mapping back to the
> full pid as it can be larger than PID_MAX_DEFAULT. And the
> saved_cmdlines[] just holds the COMMs associated to the pids.
> 
> Currently the map_pid_to_cmdline[] and saved_cmdlines[] are allocated
> together (in reality the saved_cmdlines is just in the memory of the
> rounding of the allocation of the structure as it is always allocated in
> powers of two). The map_cmdline_to_pid[] array is allocated separately.
> 
> Since the rounding to a power of two is rather large (it allows for 8000
> elements in saved_cmdlines), also include the map_cmdline_to_pid[] array.
> (This drops it to 6000 by default, which is still plenty for most use
> cases). This saves even more memory as the map_cmdline_to_pid[] array
> doesn't need to be allocated.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20240212174011.068211d9@gandalf.local.home/
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_sched_switch.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
> index e4fbcc3bede5..210c74dcd016 100644
> --- a/kernel/trace/trace_sched_switch.c
> +++ b/kernel/trace/trace_sched_switch.c
> @@ -201,7 +201,7 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
>  	int order;
>  
>  	/* Figure out how much is needed to hold the given number of cmdlines */
> -	orig_size = sizeof(*s) + val * TASK_COMM_LEN;
> +	orig_size = sizeof(*s) + val * (TASK_COMM_LEN + sizeof(int));
>  	order = get_order(orig_size);
>  	size = 1 << (order + PAGE_SHIFT);
>  	page = alloc_pages(GFP_KERNEL, order);
> @@ -212,16 +212,11 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
>  	memset(s, 0, sizeof(*s));
>  
>  	/* Round up to actual allocation */
> -	val = (size - sizeof(*s)) / TASK_COMM_LEN;
> +	val = (size - sizeof(*s)) / (TASK_COMM_LEN + sizeof(int));
>  	s->cmdline_num = val;
>  
> -	s->map_cmdline_to_pid = kmalloc_array(val,
> -					      sizeof(*s->map_cmdline_to_pid),
> -					      GFP_KERNEL);
> -	if (!s->map_cmdline_to_pid) {
> -		free_saved_cmdlines_buffer(s);
> -		return NULL;
> -	}
> +	/* Place map_cmdline_to_pid array right after saved_cmdlines */
> +	s->map_cmdline_to_pid = (unsigned *)&s->saved_cmdlines[val * TASK_COMM_LEN];
>  
>  	s->cmdline_idx = 0;
>  	memset(&s->map_pid_to_cmdline, NO_CMDLINE_MAP,
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


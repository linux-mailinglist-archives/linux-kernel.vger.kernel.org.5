Return-Path: <linux-kernel+bounces-48395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66428845B64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21318288CF4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B9F5F48E;
	Thu,  1 Feb 2024 15:25:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6784D9E8;
	Thu,  1 Feb 2024 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801111; cv=none; b=MA8yhYepJ+ysMdzGng8NQh/rnnDjv7MvQy2K2dbxNuF+w6wor4sx/zA4Be8CCOxSNb+m/8mM0GYePtU+bBnFqmHYcBuWq79olVsbMGdROQ6yI8U1TJpLZI+c7iqreC9GicHNpbLVWb0dRL6NKgRkA20SOqCXTuVZ7YasBBjj8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801111; c=relaxed/simple;
	bh=zyF+oC0KhaCRJdYaOP/LR6wR/KKdYs6b1ilnbWMO22Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omQsL1BaCsw4lleyAcFRsWLmknU0F13qs4+18M6a0if4v4rC+9SNkjamRSM+rzmkldiaQWFFkgkhFTEjuHSSBnrYxbooKBrHDDj791q8P8bbOwBMnjgKaW+cHrmck22WaTMqr2SohK/+gOXYmuKxq/rv6qpUmAz6JPufi1jJA8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1049CC433C7;
	Thu,  1 Feb 2024 15:25:09 +0000 (UTC)
Date: Thu, 1 Feb 2024 10:25:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tracing/timerlat: Move hrtimer_init to timerlat_fd
 open()
Message-ID: <20240201102526.755de868@gandalf.local.home>
In-Reply-To: <7324dd3fc0035658c99b825204a66049389c56e3.1706798888.git.bristot@kernel.org>
References: <7324dd3fc0035658c99b825204a66049389c56e3.1706798888.git.bristot@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Feb 2024 16:13:39 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> Currently, the timerlat's hrtimer is initialized at the first read of
> timerlat_fd, and destroyed at close(). It works, but it causes an error
> if the user program open() and close() the file without reading.
> 
> Move hrtimer_init to timerlat_fd open() to avoid this problem.
> 
> No functional changes.

It can't be fixing something and not have any functional changes.

No functional changes means the code is restructured but the resulting
assembly would be the same.

Like moving functions around in a file so that you don't need extra
prototype declarations.

Please only add "No functional changes" if the function's assembly would be
the same.

> 
> Fixes: e88ed227f639 ("tracing/timerlat: Add user-space interface")

With a fixes tag, I'm assuming his should go into v6.8 with a Cc stable?

-- Steve


> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  kernel/trace/trace_osnoise.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index bd0d01d00fb9..a8e28f9b9271 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -2444,6 +2444,9 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
>  	tlat = this_cpu_tmr_var();
>  	tlat->count = 0;
>  
> +	hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
> +	tlat->timer.function = timerlat_irq;
> +
>  	migrate_enable();
>  	return 0;
>  };
> @@ -2526,9 +2529,6 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
>  		tlat->tracing_thread = false;
>  		tlat->kthread = current;
>  
> -		hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
> -		tlat->timer.function = timerlat_irq;
> -
>  		/* Annotate now to drift new period */
>  		tlat->abs_period = hrtimer_cb_get_time(&tlat->timer);
>  



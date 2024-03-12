Return-Path: <linux-kernel+bounces-100500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9188798B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D771F22F23
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A08E7D419;
	Tue, 12 Mar 2024 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ET3wvV0M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D94E7C6DE;
	Tue, 12 Mar 2024 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710260040; cv=none; b=Pd2j0saP3e5PwPuFAESCKIXTScyas/EUaffYUOVSiGVzykHk2sZ+xpMDRF1aDyM8thcjJf02lkYraD64L9p6YXr/pFy8rW6OZxu3/X2gwOVbP6xymVygpC/wrwb8WSePfMZTCyEGhOoNsvSGI9Y/rAUHFuqqXQcQivV3U6wHhzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710260040; c=relaxed/simple;
	bh=POYzrEHdQajIu9lkNDUq+dYvLkhAmYXGQT424dUgbDs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Cvhgm+KtUjXM1p509r03DaT4xWxYQg1XIhUaGaCkOWf9zDWmqyIEzqn/lgvS3n5HPnl5facoa3wyndUWU6rAAwwp3pQ1+5miK9Wszh3Hd6HjuDZig2VQvVxhbG5XKdXaLf3Dl19bWOL1rndVHJFHoDVjYVJz2TLkjsrUJsUNkyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ET3wvV0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CDEC43390;
	Tue, 12 Mar 2024 16:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710260040;
	bh=POYzrEHdQajIu9lkNDUq+dYvLkhAmYXGQT424dUgbDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ET3wvV0Mp7+ILFL8o5hLW8Y+dbekfxr6qwl6XfVnrFF5mj9M83/YrWGCxzJZWrv6r
	 /fvUKJ2irszA+7jIzRLpcO9v9kVDyMtGEOLwaFgGUBs+1r8y1b2oHVW+a9uJlTXPJX
	 wTWmf6X0WLUq2sClCgVhGUWIyNw8wftxTEv9k4pvCOylOFLOnm6s9wO1x5+mIKxOVt
	 2LLkI50pvYLmtA6gPJtGdjy/K8R6aTOfBr1yk2zXceqMWp6IGRZkXnlkLvRyCXyAXi
	 NFtKZzUgNkrajiXjTPpfyDneYJBY6i7SthLZVd7xNer4ovKR2ssqVf8zWmc0bpz04H
	 OZXiAHlMU7UrA==
Date: Wed, 13 Mar 2024 01:13:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Do not set shortest_full when full target
 is hit
Message-Id: <20240313011355.7cc65a601f8074c778e39d7d@kernel.org>
In-Reply-To: <20240312115641.6aa8ba08@gandalf.local.home>
References: <20240312115641.6aa8ba08@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 11:56:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The rb_watermark_hit() checks if the amount of data in the ring buffer is
> above the percentage level passed in by the "full" variable. If it is, it
> returns true.
> 
> But it also sets the "shortest_full" field of the cpu_buffer that informs
> writers that it needs to call the irq_work if the amount of data on the
> ring buffer is above the requested amount.
> 
> The rb_watermark_hit() always sets the shortest_full even if the amount in
> the ring buffer is what it wants. As it is not going to wait, because it
> has what it wants, there's no reason to set shortest_full.
> 

Yeah, it should avoid setting if !ret. Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Cc: stable@vger.kernel.org
> Fixes: 42fb0a1e84ff5 ("tracing/ring-buffer: Have polling block on watermark")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 9b887d44b8d9..350607cce869 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -834,9 +834,10 @@ static bool rb_watermark_hit(struct trace_buffer *buffer, int cpu, int full)
>  		pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
>  		ret = !pagebusy && full_hit(buffer, cpu, full);
>  
> -		if (!cpu_buffer->shortest_full ||
> -		    cpu_buffer->shortest_full > full)
> -			cpu_buffer->shortest_full = full;
> +		if (!ret && (!cpu_buffer->shortest_full ||
> +			     cpu_buffer->shortest_full > full)) {
> +		    cpu_buffer->shortest_full = full;
> +		}
>  		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>  	}
>  	return ret;
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


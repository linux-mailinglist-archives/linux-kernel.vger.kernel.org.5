Return-Path: <linux-kernel+bounces-100429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B59787976E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C9B1F2313F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5097C096;
	Tue, 12 Mar 2024 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5IQNKHp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAC17C099;
	Tue, 12 Mar 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256934; cv=none; b=i5w1OeAaxsnr+7Y5+ahGz/zrHIm2mB0FQ3moSgUfQbqIiUQPm5X2VsY9KBe9W8HsIA/Qg6dx4CzsItomPH2PVPkGeaZHmd4Cu0kH3su95mfj3x+Z3JXMB3lj7ADgNhCJqqEHfi26m8mOzZnL30FQNmXGmZkKfFc+Ys+QmMRnvhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256934; c=relaxed/simple;
	bh=MR5DHodX1dq6D6TC9p7fOu3i1TJ+/zPJQ7Lu7LaaNp8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kd7Hb3fAjNY9ZwLzqxrpqhwRftq7LAk4ZTWFd2ZygUCo/Ca+StgUX4ONAbQJnOz1I4J5g5vDkNWQY1FUC2pKwTDd6l29790yV3L4vpVi80YJttYRD8YWN2sCQB7iEC9SG4UL0gls8m8Wl1LnRmlkljffhA2EDSg9OJdX5HvvU9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5IQNKHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93845C433A6;
	Tue, 12 Mar 2024 15:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710256934;
	bh=MR5DHodX1dq6D6TC9p7fOu3i1TJ+/zPJQ7Lu7LaaNp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e5IQNKHpkqJib/tvoSrz2+UbQ3mVBHHycqLRxzHwBR0wxnqbAgX2Yi3ET0PzbKNwl
	 bQwOzxLar3wR5YXfPTOw1LIvCs50W5RAEugdfhgrYe3DhPTXv6jFRtHkY77391EA/z
	 X5Abz+jR665BXDv8yg1E5tpbApbknQ1uvQSjHBAMVPX86igFWYzMdDP4cgIeThbEaO
	 i3EtLPjRKR3O08JCUg3OAf3XVRPI01horu7T/laN9Q+nUoZKBvhRaY/ltq3a7CXXxw
	 3IFgtXuTcR81QFsbndal5rEro4176Ez4XxZx6faRos+tCxW6N1O+1WK1OOon8i89iG
	 sBeIVjTsI7+Vg==
Date: Wed, 13 Mar 2024 00:22:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ring-buffer: Fix full_waiters_pending in poll
Message-Id: <20240313002210.d89600218f78a4c55f56b998@kernel.org>
In-Reply-To: <20240312131952.630922155@goodmis.org>
References: <20240312131919.314231457@goodmis.org>
	<20240312131952.630922155@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 09:19:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> If a reader of the ring buffer is doing a poll, and waiting for the ring
> buffer to hit a specific watermark, there could be a case where it gets
> into an infinite ping-pong loop.
> 
> The poll code has:
> 
>   rbwork->full_waiters_pending = true;
>   if (!cpu_buffer->shortest_full ||
>       cpu_buffer->shortest_full > full)
>          cpu_buffer->shortest_full = full;
> 
> The writer will see full_waiters_pending and check if the ring buffer is
> filled over the percentage of the shortest_full value. If it is, it calls
> an irq_work to wake up all the waiters.
> 
> But the code could get into a circular loop:
> 
> 	CPU 0					CPU 1
> 	-----					-----
>  [ Poll ]
>    [ shortest_full = 0 ]
>    rbwork->full_waiters_pending = true;
> 					  if (rbwork->full_waiters_pending &&
> 					      [ buffer percent ] > shortest_full) {
> 					         rbwork->wakeup_full = true;
> 					         [ queue_irqwork ]

Oh, so `[ buffer percent ] > shortest_full` does not work because
if this happens in this order, shortest_full may be 0.

> 
>    cpu_buffer->shortest_full = full;
> 
> 					  [ IRQ work ]
> 					  if (rbwork->wakeup_full) {
> 					        cpu_buffer->shortest_full = 0;
> 					        wakeup poll waiters;
>   [woken]
>    if ([ buffer percent ] > full)
>       break;
>    rbwork->full_waiters_pending = true;
> 					  if (rbwork->full_waiters_pending &&
> 					      [ buffer percent ] > shortest_full) {
> 					         rbwork->wakeup_full = true;
> 					         [ queue_irqwork ]
> 
>    cpu_buffer->shortest_full = full;
> 
> 					  [ IRQ work ]
> 					  if (rbwork->wakeup_full) {
> 					        cpu_buffer->shortest_full = 0;
> 					        wakeup poll waiters;
>   [woken]
> 
>  [ Wash, rinse, repeat! ]
> 
> In the poll, the shortest_full needs to be set before the
> full_pending_waiters, as once that is set, the writer will compare the
> current shortest_full (which is incorrect) to decide to call the irq_work,
> which will reset the shortest_full (expecting the readers to update it).
> 
> Also move the setting of full_waiters_pending after the check if the ring
> buffer has the required percentage filled. There's no reason to tell the
> writer to wake up waiters if there are no waiters.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,


> Cc: stable@vger.kernel.org
> Fixes: 42fb0a1e84ff5 ("tracing/ring-buffer: Have polling block on watermark")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index aa332ace108b..adfe603a769b 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -964,16 +964,32 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
>  		poll_wait(filp, &rbwork->full_waiters, poll_table);
>  
>  		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> -		rbwork->full_waiters_pending = true;
>  		if (!cpu_buffer->shortest_full ||
>  		    cpu_buffer->shortest_full > full)
>  			cpu_buffer->shortest_full = full;
>  		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> -	} else {
> -		poll_wait(filp, &rbwork->waiters, poll_table);
> -		rbwork->waiters_pending = true;
> +		if (full_hit(buffer, cpu, full))
> +			return EPOLLIN | EPOLLRDNORM;
> +		/*
> +		 * Only allow full_waiters_pending update to be seen after
> +		 * the shortest_full is set. If the writer sees the
> +		 * full_waiters_pending flag set, it will compare the
> +		 * amount in the ring buffer to shortest_full. If the amount
> +		 * in the ring buffer is greater than the shortest_full
> +		 * percent, it will call the irq_work handler to wake up
> +		 * this list. The irq_handler will reset shortest_full
> +		 * back to zero. That's done under the reader_lock, but
> +		 * the below smp_mb() makes sure that the update to
> +		 * full_waiters_pending doesn't leak up into the above.
> +		 */
> +		smp_mb();
> +		rbwork->full_waiters_pending = true;
> +		return 0;
>  	}
>  
> +	poll_wait(filp, &rbwork->waiters, poll_table);
> +	rbwork->waiters_pending = true;
> +
>  	/*
>  	 * There's a tight race between setting the waiters_pending and
>  	 * checking if the ring buffer is empty.  Once the waiters_pending bit
> @@ -989,9 +1005,6 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
>  	 */
>  	smp_mb();
>  
> -	if (full)
> -		return full_hit(buffer, cpu, full) ? EPOLLIN | EPOLLRDNORM : 0;
> -
>  	if ((cpu == RING_BUFFER_ALL_CPUS && !ring_buffer_empty(buffer)) ||
>  	    (cpu != RING_BUFFER_ALL_CPUS && !ring_buffer_empty_cpu(buffer, cpu)))
>  		return EPOLLIN | EPOLLRDNORM;
> -- 
> 2.43.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


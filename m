Return-Path: <linux-kernel+bounces-13104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C6881FFBC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C562845BF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20F41171A;
	Fri, 29 Dec 2023 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCSywPDT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B31170A;
	Fri, 29 Dec 2023 13:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B637C433C7;
	Fri, 29 Dec 2023 13:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703857670;
	bh=SrW5nlX5snYhfbnE+gR5vFq2NPPUgdmttYN89+7fLdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HCSywPDTl/1kF7cj3SO5V9x7m5yilZKsE2G43DyYaFsIGUz+vbj2sTyEcmceZw16U
	 Do5yA/wD4ntVVytalS34DvgCLWMtYuBEMZpbBocyzAaRj/Wqqzopd6Lvztqw/kHzSS
	 g7hgSclvI1dLqcZKDxVHhm7fieG2KR4l6cg4ip+YKIVjMESfHxxRjmb7QMnvQVXQGy
	 t92SAJLiJ1ZOVGyy66FhY/Vz/WyyvYd6lx66JzMokjRgCjCIJONN2EC62FI+Ej28lC
	 Veas0pyzE8CLXzAKcBeczSmHJz62GABdpCC2OI80sURXHkt1TjgROUMFOeGz1wCeQZ
	 qA+RNDqXkmmTw==
Date: Fri, 29 Dec 2023 22:47:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Fix blocked reader of snapshot buffer
Message-Id: <20231229224746.6c55e4482a0dadf9d5a3c527@kernel.org>
In-Reply-To: <20231228095149.77f5b45d@gandalf.local.home>
References: <20231228095149.77f5b45d@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Dec 2023 09:51:49 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> If an application blocks on the snapshot or snapshot_raw files, expecting
> to be woken up when a snapshot occurs, it will not happen. Or it may
> happen with an unexpected result.
> 
> That result is that the application will be reading the main buffer
> instead of the snapshot buffer. That is because when the snapshot occurs,
> the main and snapshot buffers are swapped. But the reader has a descriptor
> still pointing to the buffer that it originally connected to.
> 
> This is fine for the main buffer readers, as they may be blocked waiting
> for a watermark to be hit, and when a snapshot occurs, the data that the
> main readers want is now on the snapshot buffer.
> 
> But for waiters of the snapshot buffer, they are waiting for an event to
> occur that will trigger the snapshot and they can then consume it quickly
> to save the snapshot before the next snapshot occurs. But to do this, they
> need to read the new snapshot buffer, not the old one that is now
> receiving new data.
> 
> Also, it does not make sense to have a watermark "buffer_percent" on the
> snapshot buffer, as the snapshot buffer is static and does not receive new
> data except all at once.

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> Cc: stable@vger.kernel.org
> Fixes: debdd57f5145f ("tracing: Make a snapshot feature available from userspace")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c |  3 ++-
>  kernel/trace/trace.c       | 20 +++++++++++++++++---
>  2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index e476d42c84c5..07dae67424a9 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -838,7 +838,8 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
>  	/* make sure the waiters see the new index */
>  	smp_wmb();
>  
> -	rb_wake_up_waiters(&rbwork->work);
> +	/* This can be called in any context */
> +	irq_work_queue(&rbwork->work);
>  }
>  
>  /**
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index cfeaf2cd204e..606787edae8c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1902,6 +1902,9 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
>  	__update_max_tr(tr, tsk, cpu);
>  
>  	arch_spin_unlock(&tr->max_lock);
> +
> +	/* Any waiters on the old snapshot buffer need to wake up */
> +	ring_buffer_wake_waiters(tr->array_buffer.buffer, RING_BUFFER_ALL_CPUS);
>  }
>  
>  /**
> @@ -1953,12 +1956,23 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
>  
>  static int wait_on_pipe(struct trace_iterator *iter, int full)
>  {
> +	int ret;
> +
>  	/* Iterators are static, they should be filled or empty */
>  	if (trace_buffer_iter(iter, iter->cpu_file))
>  		return 0;
>  
> -	return ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file,
> -				full);
> +	ret = ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file, full);
> +
> +#ifdef CONFIG_TRACER_MAX_TRACE
> +	/*
> +	 * Make sure this is still the snapshot buffer, as if a snapshot were
> +	 * to happen, this would now be the main buffer.
> +	 */
> +	if (iter->snapshot)
> +		iter->array_buffer = &iter->tr->max_buffer;
> +#endif
> +	return ret;
>  }
>  
>  #ifdef CONFIG_FTRACE_STARTUP_TEST
> @@ -8560,7 +8574,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
>  
>  		wait_index = READ_ONCE(iter->wait_index);
>  
> -		ret = wait_on_pipe(iter, iter->tr->buffer_percent);
> +		ret = wait_on_pipe(iter, iter->snapshot ? 0 : iter->tr->buffer_percent);
>  		if (ret)
>  			goto out;
>  
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


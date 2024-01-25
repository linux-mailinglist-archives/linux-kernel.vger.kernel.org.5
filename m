Return-Path: <linux-kernel+bounces-39260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5347083CDB5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4DC1F258C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC02137C59;
	Thu, 25 Jan 2024 20:44:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028741CFA8;
	Thu, 25 Jan 2024 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215474; cv=none; b=gydjqT4RlVE6TV0UOP/5PTuxYHE4HphzMRZxjQTUvCC70jIUeWZEPC7Wr+i8skhV02rLPGz+EJn44hhEV40mNFw1Rd18nkc4dwG4uFyfRcpsJOUT3LL9LZCTTVYOQsAN9BsnqoQ2riE+OuW6Meli94latk9OMfZcBqYt2tCqsa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215474; c=relaxed/simple;
	bh=FkHGNFhFuAD40JuWBR7T/asjbfsZiSRnbeBhW5PY+HM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u92AgPfPYMClWt7+LFWNggyZDBe3M6LKOxbqPwcUrGwZgODMkokC/5NHDwOUk+OpPISPZyhdGjW9kJymlaLLx9QSlpchGVycEMX5MSKMnm8rpHC4Lrm2mz8Lphe76xQRGrct2aLi7VhpZdgKvfECNDlOijQItxLE7ncfWH9zGCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA903C433C7;
	Thu, 25 Jan 2024 20:44:32 +0000 (UTC)
Date: Thu, 25 Jan 2024 15:44:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] tracing: initialize trace_seq buffers
Message-ID: <20240125154432.4ba9e997@gandalf.local.home>
In-Reply-To: <20240125201621.143968-4-ricardo@marliere.net>
References: <20240125201621.143968-1-ricardo@marliere.net>
	<20240125201621.143968-4-ricardo@marliere.net>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 17:16:21 -0300
"Ricardo B. Marliere" <ricardo@marliere.net> wrote:

> Now that trace_seq_reset have been created, correct the places where the
> buffers need to be initialized.

This patch would need to come first. You don't ever want to intentionally
create a broken kernel.

Also, the change log should be:

  In order to extend trace_seq into being dynamic, the struct trace_seq
  will no longer be valid if simply set to zero. Call trace_seq_init() for
  all trace_seq when they are first created.

> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  kernel/trace/trace.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

You also need to initialize iter.seq in ftrace_dump()

-- Steve

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d4c55d3e21c2..9827700d0164 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4889,6 +4889,9 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
>  
>  	mutex_unlock(&trace_types_lock);
>  
> +	trace_seq_init(&iter->seq);
> +	trace_seq_init(&iter->tmp_seq);
> +
>  	return iter;
>  
>   fail:
> @@ -6770,6 +6773,7 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
>  	}
>  
>  	trace_seq_init(&iter->seq);
> +	trace_seq_init(&iter->tmp_seq);
>  	iter->trace = tr->current_trace;
>  
>  	if (!alloc_cpumask_var(&iter->started, GFP_KERNEL)) {
> @@ -6947,6 +6951,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
>  	trace_iterator_reset(iter);
>  	cpumask_clear(iter->started);
>  	trace_seq_init(&iter->seq);
> +	trace_seq_init(&iter->tmp_seq);
>  
>  	trace_event_read_lock();
>  	trace_access_lock(iter->cpu_file);
> @@ -8277,6 +8282,9 @@ static int tracing_buffers_open(struct inode *inode, struct file *filp)
>  	if (ret < 0)
>  		trace_array_put(tr);
>  
> +	trace_seq_init(&info->iter.seq);
> +	trace_seq_init(&info->iter.tmp_seq);
> +
>  	return ret;
>  }
>  
> @@ -10300,6 +10308,9 @@ void trace_init_global_iter(struct trace_iterator *iter)
>  	iter->temp_size = STATIC_TEMP_BUF_SIZE;
>  	iter->fmt = static_fmt_buf;
>  	iter->fmt_size = STATIC_FMT_BUF_SIZE;
> +
> +	trace_seq_init(&iter->seq);
> +	trace_seq_init(&iter->tmp_seq);
>  }
>  
>  void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
> @@ -10712,6 +10723,9 @@ void __init early_trace_init(void)
>  			tracepoint_printk = 0;
>  		else
>  			static_key_enable(&tracepoint_printk_key.key);
> +
> +		trace_seq_init(&tracepoint_print_iter->seq);
> +		trace_seq_init(&tracepoint_print_iter->tmp_seq);
>  	}
>  	tracer_alloc_buffers();
>  



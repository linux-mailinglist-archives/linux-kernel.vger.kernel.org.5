Return-Path: <linux-kernel+bounces-34225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9378375D9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417E01F26EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D6A482FF;
	Mon, 22 Jan 2024 22:08:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D207482D6;
	Mon, 22 Jan 2024 22:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961337; cv=none; b=Y8uLlkU6oAhmVXtaOKPRj5h8rE0WkF1PMpTxq422gHyANYoT9W+iFZogUFRYKVRB8zq3oGjzs5RXpopzEkIXF+deh5OI/wtEaOoXYIxbf3rajVodZhLROJfk+rLTjVTN7ALzvTym1p6VPkxJO3j53tSXXq50kCmDfuhjvkpN0AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961337; c=relaxed/simple;
	bh=TbcPe1kiQsBe0ap6ckdE+nz3vqbuvrHgQn7Z537dpkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOIIYYxM/QaxZSPSVq/CTCCf/ZBQiTTWnq/lmY/S31q5YTcQyM3FsyGXGw4UgbKZbYEEu6VV32FXiZuGdJxjvDc4fVVt54VFmNIUdIIeMa9F3IZ/7gXWMEXqH2mgjECGGEeNANUKLfF2UCfvdndFtV3B82pAzxBLmbLu9UBLih0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330B7C433C7;
	Mon, 22 Jan 2024 22:08:56 +0000 (UTC)
Date: Mon, 22 Jan 2024 17:10:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: add trace_seq_reset function
Message-ID: <20240122171024.4a434c73@gandalf.local.home>
In-Reply-To: <20240122182225.69061-2-ricardo@marliere.net>
References: <20240122182225.69061-2-ricardo@marliere.net>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 15:22:25 -0300
"Ricardo B. Marliere" <ricardo@marliere.net> wrote:

> Currently, trace_seq_init may be called many times with the intent of
> resetting the buffer. Add a function trace_seq_reset that does that and
> replace the relevant occurrences to use it instead.
> 

Hi Ricardo!

It's also OK to add to the commit log that the goal of this is to later
extend trace_seq to be more flexible in the size of the buffer it holds. To
do that, we need to differentiate between initializing a trace_seq and just
resetting it.


> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  include/linux/trace_seq.h    | 8 ++++++++
>  include/trace/trace_events.h | 2 +-
>  kernel/trace/trace.c         | 8 ++++----
>  kernel/trace/trace_seq.c     | 2 +-
>  4 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
> index 9ec229dfddaa..c28e0ccb50bd 100644
> --- a/include/linux/trace_seq.h
> +++ b/include/linux/trace_seq.h
> @@ -29,6 +29,14 @@ trace_seq_init(struct trace_seq *s)
>  	s->readpos = 0;
>  }
>  
> +static inline void
> +trace_seq_reset(struct trace_seq *s)
> +{
> +	seq_buf_clear(&s->seq);
> +	s->full = 0;
> +	s->readpos = 0;
> +}
> +
>  /**
>   * trace_seq_used - amount of actual data written to buffer
>   * @s: trace sequence descriptor
> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> index c2f9cabf154d..2bc79998e5ab 100644
> --- a/include/trace/trace_events.h
> +++ b/include/trace/trace_events.h
> @@ -227,7 +227,7 @@ trace_raw_output_##call(struct trace_iterator *iter, int flags,		\
>  									\
>  	field = (typeof(field))entry;					\
>  									\
> -	trace_seq_init(p);						\
> +	trace_seq_reset(p);						\
>  	return trace_output_call(iter, #call, print);			\

Note, p = &iter->tmp_seq

where it has never been initialized. To do this, we need to add:

	trace_seq_init(&iter->tmp_seq);

where ever iter is created. You need to look at all the locations where
iter is created ("iter =") and differentiate where it is first used from
just passing pointers around.

The iter = kzalloc() will be easy, but for example, both seq and tmp_seq
need to be initialized in tracing_buffers_open().

Perhaps we need a:

	if (WARN_ON_ONCE(!s->seq.size))
		seq_buf_init(&s->seq, s->buffer, TRACE_SEQ_BUFFER_SIZE);
	else
		seq_buf_clear(&s->seq);


in the trace_seq_reset() to catch any place that doesn't have it
initialized yet.

-- Steve

>  }									\
>  static struct trace_event_functions trace_event_type_funcs_##call = {	\
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 46dbe22121e9..9147f3717b9a 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6946,7 +6946,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
>  	/* reset all but tr, trace, and overruns */
>  	trace_iterator_reset(iter);
>  	cpumask_clear(iter->started);
> -	trace_seq_init(&iter->seq);
> +	trace_seq_reset(&iter->seq);
>  
>  	trace_event_read_lock();
>  	trace_access_lock(iter->cpu_file);
> @@ -6993,7 +6993,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
>  	/* Now copy what we have to the user */
>  	sret = trace_seq_to_user(&iter->seq, ubuf, cnt);
>  	if (iter->seq.readpos >= trace_seq_used(&iter->seq))
> -		trace_seq_init(&iter->seq);
> +		trace_seq_reset(&iter->seq);
>  
>  	/*
>  	 * If there was nothing to send to user, in spite of consuming trace
> @@ -7125,7 +7125,7 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
>  		spd.partial[i].offset = 0;
>  		spd.partial[i].len = trace_seq_used(&iter->seq);
>  
> -		trace_seq_init(&iter->seq);
> +		trace_seq_reset(&iter->seq);
>  	}
>  
>  	trace_access_unlock(iter->cpu_file);
> @@ -10274,7 +10274,7 @@ trace_printk_seq(struct trace_seq *s)
>  
>  	printk(KERN_TRACE "%s", s->buffer);
>  
> -	trace_seq_init(s);
> +	trace_seq_reset(s);
>  }
>  
>  void trace_init_global_iter(struct trace_iterator *iter)
> diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
> index c158d65a8a88..741b2f3d76c0 100644
> --- a/kernel/trace/trace_seq.c
> +++ b/kernel/trace/trace_seq.c
> @@ -59,7 +59,7 @@ int trace_print_seq(struct seq_file *m, struct trace_seq *s)
>  	 * do something else with the contents.
>  	 */
>  	if (!ret)
> -		trace_seq_init(s);
> +		trace_seq_reset(s);
>  
>  	return ret;
>  }



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF117810652
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378117AbjLMAOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378052AbjLMAOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:14:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7CDD4F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:13:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32065C433CA;
        Wed, 13 Dec 2023 00:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702426431;
        bh=GYqLk/Fn0354QnjSq/ZSDJ2Jlg6bdmEDCGKNG64SWtM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DbhU6fxd763pI+y5gKo7NaPNZgB3UIXz7Jcdpt11YoRrrnBj8Qn0tH+/J43jiKCon
         YPGy/YjWvp7umzJyRRX5zzciqePJdei0+xCqlYnq9LgPP8GyfRBLlihJ+fHLjoEYFQ
         y1QJGLxsJsqZDcmt2hRL/IYXn3Dmu92FB0Km9INvaVXJKpVLPVvfl57KdI82JjL/Ah
         8QPCPgV4AjvgXD+uEfhTSGAlpXSti2FVtuN1pTOmKwhkQ5tfad3/Wx8PIPTmO6wRvQ
         n2c5IqDddSHaHDtKjTE3zRqWzu4d73mXw6eqg52di454VUrCPf14n/g41Oe1IOmx7s
         sTOxzl132/YPg==
Date:   Wed, 13 Dec 2023 09:13:46 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v4] tracing: Allow for max buffer data size trace_marker
 writes
Message-Id: <20231213091346.edf0b6561bf59d5779cbe415@kernel.org>
In-Reply-To: <20231212131901.5f501e72@gandalf.local.home>
References: <20231212131901.5f501e72@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 13:19:01 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Allow a trace write to be as big as the ring buffer tracing data will
> allow. Currently, it only allows writes of 1KB in size, but there's no
> reason that it cannot allow what the ring buffer can hold.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> ---
> Changes since v3: https://lore.kernel.org/linux-trace-kernel/20231212110332.6fca52c4@gandalf.local.home
> 
> - No greated cheese. (Mathieu Desnoyers)
> 
>  include/linux/ring_buffer.h |  1 +
>  kernel/trace/ring_buffer.c  | 15 +++++++++++++++
>  kernel/trace/trace.c        | 31 ++++++++++++++++++++++++-------
>  3 files changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index 782e14f62201..b1b03b2c0f08 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
> @@ -141,6 +141,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter);
>  bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter);
>  
>  unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu);
> +unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer);
>  
>  void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu);
>  void ring_buffer_reset_online_cpus(struct trace_buffer *buffer);
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 6b82c3398938..087f0f6b3409 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -5255,6 +5255,21 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_size);
>  
> +/**
> + * ring_buffer_max_event_size - return the max data size of an event
> + * @buffer: The ring buffer.
> + *
> + * Returns the maximum size an event can be.
> + */
> +unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer)
> +{
> +	/* If abs timestamp is requested, events have a timestamp too */
> +	if (ring_buffer_time_stamp_abs(buffer))
> +		return BUF_MAX_DATA_SIZE - RB_LEN_TIME_EXTEND;
> +	return BUF_MAX_DATA_SIZE;
> +}
> +EXPORT_SYMBOL_GPL(ring_buffer_max_event_size);
> +
>  static void rb_clear_buffer_page(struct buffer_page *page)
>  {
>  	local_set(&page->write, 0);
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index ef86379555e4..a359783fede8 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7272,8 +7272,9 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>  	enum event_trigger_type tt = ETT_NONE;
>  	struct trace_buffer *buffer;
>  	struct print_entry *entry;
> +	int meta_size;
>  	ssize_t written;
> -	int size;
> +	size_t size;
>  	int len;
>  
>  /* Used in tracing_mark_raw_write() as well */
> @@ -7286,12 +7287,12 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>  	if (!(tr->trace_flags & TRACE_ITER_MARKERS))
>  		return -EINVAL;
>  
> -	if (cnt > TRACE_BUF_SIZE)
> -		cnt = TRACE_BUF_SIZE;
> -
> -	BUILD_BUG_ON(TRACE_BUF_SIZE >= PAGE_SIZE);
> +	if ((ssize_t)cnt < 0)
> +		return -EINVAL;
>  
> -	size = sizeof(*entry) + cnt + 2; /* add '\0' and possible '\n' */
> +	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
> + again:
> +	size = cnt + meta_size;
>  
>  	/* If less than "<faulted>", then make sure we can still add that */
>  	if (cnt < FAULTED_SIZE)
> @@ -7300,9 +7301,25 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>  	buffer = tr->array_buffer.buffer;
>  	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
>  					    tracing_gen_ctx());
> -	if (unlikely(!event))
> +	if (unlikely(!event)) {
> +		/*
> +		 * If the size was greater than what was allowed, then
> +		 * make it smaller and try again.
> +		 */
> +		if (size > ring_buffer_max_event_size(buffer)) {
> +			/* cnt < FAULTED size should never be bigger than max */
> +			if (WARN_ON_ONCE(cnt < FAULTED_SIZE))
> +				return -EBADF;
> +			cnt = ring_buffer_max_event_size(buffer) - meta_size;
> +			/* The above should only happen once */
> +			if (WARN_ON_ONCE(cnt + meta_size == size))
> +				return -EBADF;
> +			goto again;
> +		}
> +
>  		/* Ring buffer disabled, return as if not open for write */
>  		return -EBADF;
> +	}
>  
>  	entry = ring_buffer_event_data(event);
>  	entry->ip = _THIS_IP_;
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

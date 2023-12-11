Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FE580CA1F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjLKMq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKMqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:46:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075EBB0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:46:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5ADEC433C7;
        Mon, 11 Dec 2023 12:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702298791;
        bh=JQ2o4bswOLI0VG1kbn//h0fFBpjxy8snq+Qxqqghh0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Syringvqd/XP6XWsNwRyFQTfhiFBvxhD9hHTce4bs4W53HSKyqeyBhiZ8U8vLTSgi
         7HMuSoh5JkyMEG48+MYby+085nLqTc60sxzo9MOZLzTssL7kiEqEIsGDdv1hURSwHP
         4D/k+r7i3vgVe7XioX8URQkE0m2SSNnXeOFOT0BMAqZY+cEYiM0SDjCpaUPe9E7ZTZ
         aVRsu5+jmw0qft9Jfcou9OJEe0n2gG0gpX72YfxKlQYmHlVO8kTirj8pBy60ha4xtn
         qjVBMzQFVgxkzks6KsD6CvApglj3h08xCm91G3dQqW8FjtH/N9zgEjV0Mkn5umEasj
         J4y/00m0kkagg==
Date:   Mon, 11 Dec 2023 21:46:27 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] trace_seq: Increase the buffer size to almost two pages
Message-Id: <20231211214627.cff4ecfead14029ef22cd3ef@kernel.org>
In-Reply-To: <20231209175220.19867af4@gandalf.local.home>
References: <20231209175220.19867af4@gandalf.local.home>
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

On Sat, 9 Dec 2023 17:52:20 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Now that trace_marker can hold more than 1KB string, and can write as much
> as the ring buffer can hold, the trace_seq is not big enough to hold
> writes:
> 
>  ~# a="1234567890"
>  ~# cnt=4080
>  ~# s=""
>  ~# while [ $cnt -gt 10 ]; do
>  ~#	s="${s}${a}"
>  ~#	cnt=$((cnt-10))
>  ~# done
>  ~# echo $s > trace_marker
>  ~# cat trace
>  # tracer: nop
>  #
>  # entries-in-buffer/entries-written: 2/2   #P:8
>  #
>  #                                _-----=> irqs-off/BH-disabled
>  #                               / _----=> need-resched
>  #                              | / _---=> hardirq/softirq
>  #                              || / _--=> preempt-depth
>  #                              ||| / _-=> migrate-disable
>  #                              |||| /     delay
>  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>  #              | |         |   |||||     |         |
>             <...>-860     [002] .....   105.543465: tracing_mark_write[LINE TOO BIG]
>             <...>-860     [002] .....   105.543496: tracing_mark_write: 789012345678901234567890
> 
> By increasing the trace_seq buffer to almost two pages, it can now print
> out the first line.
> 
> This also subtracts the rest of the trace_seq fields from the buffer, so
> that the entire trace_seq is now PAGE_SIZE aligned.

Ok, but I just a bit concern about the memory consumption.
Since this is very specific case, can we make it configurable later?

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/trace_seq.h | 9 ++++++---
>  kernel/trace/trace.c      | 6 +++---
>  kernel/trace/trace_seq.c  | 3 ---
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
> index 3691e0e76a1a..9ec229dfddaa 100644
> --- a/include/linux/trace_seq.h
> +++ b/include/linux/trace_seq.h
> @@ -8,11 +8,14 @@
>  
>  /*
>   * Trace sequences are used to allow a function to call several other functions
> - * to create a string of data to use (up to a max of PAGE_SIZE).
> + * to create a string of data to use.
>   */
>  
> +#define TRACE_SEQ_BUFFER_SIZE	(PAGE_SIZE * 2 - \
> +	(sizeof(struct seq_buf) + sizeof(size_t) + sizeof(int)))
> +
>  struct trace_seq {
> -	char			buffer[PAGE_SIZE];
> +	char			buffer[TRACE_SEQ_BUFFER_SIZE];
>  	struct seq_buf		seq;
>  	size_t			readpos;
>  	int			full;
> @@ -21,7 +24,7 @@ struct trace_seq {
>  static inline void
>  trace_seq_init(struct trace_seq *s)
>  {
> -	seq_buf_init(&s->seq, s->buffer, PAGE_SIZE);
> +	seq_buf_init(&s->seq, s->buffer, TRACE_SEQ_BUFFER_SIZE);
>  	s->full = 0;
>  	s->readpos = 0;
>  }
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 83393c65ec71..da837119a446 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3753,7 +3753,7 @@ static bool trace_safe_str(struct trace_iterator *iter, const char *str,
>  
>  	/* OK if part of the temp seq buffer */
>  	if ((addr >= (unsigned long)iter->tmp_seq.buffer) &&
> -	    (addr < (unsigned long)iter->tmp_seq.buffer + PAGE_SIZE))
> +	    (addr < (unsigned long)iter->tmp_seq.buffer + TRACE_SEQ_BUFFER_SIZE))
>  		return true;
>  
>  	/* Core rodata can not be freed */
> @@ -6926,8 +6926,8 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
>  		goto out;
>  	}
>  
> -	if (cnt >= PAGE_SIZE)
> -		cnt = PAGE_SIZE - 1;
> +	if (cnt >= TRACE_SEQ_BUFFER_SIZE)
> +		cnt = TRACE_SEQ_BUFFER_SIZE - 1;
>  
>  	/* reset all but tr, trace, and overruns */
>  	trace_iterator_reset(iter);
> diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
> index 7be97229ddf8..c158d65a8a88 100644
> --- a/kernel/trace/trace_seq.c
> +++ b/kernel/trace/trace_seq.c
> @@ -13,9 +13,6 @@
>   * trace_seq_init() more than once to reset the trace_seq to start
>   * from scratch.
>   * 
> - * The buffer size is currently PAGE_SIZE, although it may become dynamic
> - * in the future.
> - *
>   * A write to the buffer will either succeed or fail. That is, unlike
>   * sprintf() there will not be a partial write (well it may write into
>   * the buffer but it wont update the pointers). This allows users to
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

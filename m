Return-Path: <linux-kernel+bounces-6648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92117819BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C88B2557F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AB71F612;
	Wed, 20 Dec 2023 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAdQFac6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E395E1F5FF;
	Wed, 20 Dec 2023 09:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3166FC433C8;
	Wed, 20 Dec 2023 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703065728;
	bh=wJiQg+u749YBBw4wmY0qJj3zwBAd7kxmoLP3xzWnTMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aAdQFac69rgV1g//Rszj1gYUTlrhwYsrYR+0s7Nzt8odxsu0XcLGPn2jB/4KwO1eb
	 hykRs9n6dlquwNRSq466xQUFGNpkwK0eiNrhJOmon9tWp5XCEFG3IHzynh78XfE7T2
	 o7C/SUn7jMxx7C6JQGvP5yl6X/kpR/snQ6dGBLXM6bCYrb8TsFaRFF2yy6Jpdd5kQ9
	 zvFrRwtOYanlhGhtO9Dys5IKQMwxdBfA7WdycfMsRYgEhYGT1H82/trAzsus9pmcuM
	 SAGb5qX1DKsw71joZPRDn0RYbq9fwwzXdc254KWkjboslxzbt4gEeRUuE0jRrT/0n7
	 Yht4XiC229FnA==
Date: Wed, 20 Dec 2023 18:48:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>, Kent Overstreet
 <kent.overstreet@gmail.com>
Subject: Re: [PATCH v5 01/15] ring-buffer: Refactor ring buffer
 implementation
Message-Id: <20231220184843.163d60de46f82b7b4ee01d3d@kernel.org>
In-Reply-To: <20231219185627.723857541@goodmis.org>
References: <20231219185414.474197117@goodmis.org>
	<20231219185627.723857541@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 13:54:15 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
> 
> In order to introduce sub-buffer size per ring buffer, some internal
> refactoring is needed. As ring_buffer_print_page_header() will depend on
> the trace_buffer structure, it is moved after the structure definition.
> 
> Link: https://lore.kernel.org/linux-trace-devel/20211213094825.61876-2-tz.stoyanov@gmail.com
> 

OK, but the title is too generic. Something like 
"Move ring_buffer_print_page_header() after ring_buffer_iter"
will be preferable.

Thank you,


> Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 60 +++++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index f7dc74e45ebf..2400c8e68fd3 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -379,36 +379,6 @@ static inline bool test_time_stamp(u64 delta)
>  /* Max payload is BUF_PAGE_SIZE - header (8bytes) */
>  #define BUF_MAX_DATA_SIZE (BUF_PAGE_SIZE - (sizeof(u32) * 2))
>  
> -int ring_buffer_print_page_header(struct trace_seq *s)
> -{
> -	struct buffer_data_page field;
> -
> -	trace_seq_printf(s, "\tfield: u64 timestamp;\t"
> -			 "offset:0;\tsize:%u;\tsigned:%u;\n",
> -			 (unsigned int)sizeof(field.time_stamp),
> -			 (unsigned int)is_signed_type(u64));
> -
> -	trace_seq_printf(s, "\tfield: local_t commit;\t"
> -			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
> -			 (unsigned int)offsetof(typeof(field), commit),
> -			 (unsigned int)sizeof(field.commit),
> -			 (unsigned int)is_signed_type(long));
> -
> -	trace_seq_printf(s, "\tfield: int overwrite;\t"
> -			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
> -			 (unsigned int)offsetof(typeof(field), commit),
> -			 1,
> -			 (unsigned int)is_signed_type(long));
> -
> -	trace_seq_printf(s, "\tfield: char data;\t"
> -			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
> -			 (unsigned int)offsetof(typeof(field), data),
> -			 (unsigned int)BUF_PAGE_SIZE,
> -			 (unsigned int)is_signed_type(char));
> -
> -	return !trace_seq_has_overflowed(s);
> -}
> -
>  struct rb_irq_work {
>  	struct irq_work			work;
>  	wait_queue_head_t		waiters;
> @@ -556,6 +526,36 @@ struct ring_buffer_iter {
>  	int				missed_events;
>  };
>  
> +int ring_buffer_print_page_header(struct trace_seq *s)
> +{
> +	struct buffer_data_page field;
> +
> +	trace_seq_printf(s, "\tfield: u64 timestamp;\t"
> +			 "offset:0;\tsize:%u;\tsigned:%u;\n",
> +			 (unsigned int)sizeof(field.time_stamp),
> +			 (unsigned int)is_signed_type(u64));
> +
> +	trace_seq_printf(s, "\tfield: local_t commit;\t"
> +			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
> +			 (unsigned int)offsetof(typeof(field), commit),
> +			 (unsigned int)sizeof(field.commit),
> +			 (unsigned int)is_signed_type(long));
> +
> +	trace_seq_printf(s, "\tfield: int overwrite;\t"
> +			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
> +			 (unsigned int)offsetof(typeof(field), commit),
> +			 1,
> +			 (unsigned int)is_signed_type(long));
> +
> +	trace_seq_printf(s, "\tfield: char data;\t"
> +			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
> +			 (unsigned int)offsetof(typeof(field), data),
> +			 (unsigned int)BUF_PAGE_SIZE,
> +			 (unsigned int)is_signed_type(char));
> +
> +	return !trace_seq_has_overflowed(s);
> +}
> +
>  static inline void rb_time_read(rb_time_t *t, u64 *ret)
>  {
>  	*ret = local64_read(&t->time);
> -- 
> 2.42.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


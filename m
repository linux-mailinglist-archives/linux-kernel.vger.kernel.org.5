Return-Path: <linux-kernel+bounces-3832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4E581737E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64641C231EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9026C1D141;
	Mon, 18 Dec 2023 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fx6rk/Y8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7EE129EFB;
	Mon, 18 Dec 2023 14:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA25C433C8;
	Mon, 18 Dec 2023 14:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702909500;
	bh=SUEB88NGJGLKREuACm730d4dCH16uYesDGk4fSzM/pI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fx6rk/Y84L5VDkdCG25uAnfxUxGjEcOFVXTvOGMBCVS/6FOHNblv75dzsh5kQ0B3d
	 9d7tRccUF0l2vUl5jHiukNqelBSbN2uwowEfcAngwvLwsDVxoOGv0SNtidnjjKh7Vm
	 AooJ+1b1GALB9Uq9CIdoGnEhJC1Xw50ZBICpwBseGudCoDvc3UPgsl0HTfZ3VKL6t7
	 EGw0VNhhNHimWD/KiqGfKAekZ9msIZTf+5naPVywq+NnClHzinDEt8KEy3QIUeGHGk
	 9tilaN5KFJxpn/h1959jo/3Bzp5lZbwJqmRGi8X9f6mdposr3ud7Jxe5TQEuqoMsHR
	 oqstgebKZ++lQ==
Date: Mon, 18 Dec 2023 23:24:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] ring-buffer: Replace rb_time_cmpxchg() with
 rb_time_cmp_and_update()
Message-Id: <20231218232455.03aa6506f855109476e34212@kernel.org>
In-Reply-To: <20231215165628.096822746@goodmis.org>
References: <20231215165512.280088765@goodmis.org>
	<20231215165628.096822746@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 11:55:13 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> There's only one place that performs a 64-bit cmpxchg for the timestamp
> processing. The cmpxchg is only to set the write_stamp equal to the
> before_stamp, and if it doesn't get set, then the next event will simply
> be forced to add an absolute timestamp.
> 
> Given that 64-bit cmpxchg is expensive on 32-bit, and the current
> workaround uses 3 consecutive 32-bit cmpxchg doesn't make it any faster.
> It's best to just not do the cmpxchg as a simple compare works for the
> accuracy of the timestamp. The only thing that will happen without the
> cmpxchg is the prepended absolute timestamp on the next event which is not
> that big of a deal as the path where this happens is seldom hit because it
> requires an interrupt to happen between a few lines of code that also
> writes an event into the same buffer.
> 
> With this change, the 32-bit rb_time_t workaround can be removed.
> 

Hmm, but this patch itself is just moving rb_time_cmpxchg() in the new
rb_time_cmp_and_update() function. The actual change has been done
in the next patch. I think there is no reason to split this from the
second one...

Isn't this part actual change?

>  static bool rb_time_cmp_and_update(rb_time_t *t, u64 expect, u64 set)
>  {
> -	return rb_time_cmpxchg(t, expect, set);
> +#ifdef RB_TIME_32
> +	return expect == READ_ONCE(t->time);
> +#else
> +	return local64_try_cmpxchg(&t->time, &expect, set);
> +#endif
>  }

Thank you,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 1a26b3a1901f..c6842a4331a9 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -762,6 +762,15 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
>  }
>  #endif
>  
> +/*
> + * Returns true if t == expect, and if possible will update with set,
> + * but t is not guaranteed to be updated even if this returns true
> + */
> +static bool rb_time_cmp_and_update(rb_time_t *t, u64 expect, u64 set)
> +{
> +	return rb_time_cmpxchg(t, expect, set);
> +}
> +
>  /*
>   * Enable this to make sure that the event passed to
>   * ring_buffer_event_time_stamp() is not committed and also
> @@ -3622,9 +3631,17 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
>  		barrier();
>   /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
>  		    info->after < ts &&
> -		    rb_time_cmpxchg(&cpu_buffer->write_stamp,
> -				    info->after, ts)) {
> -			/* Nothing came after this event between C and E */
> +		    rb_time_cmp_and_update(&cpu_buffer->write_stamp,
> +					   info->after, ts)) {
> +			/*
> +			 * Nothing came after this event between C and E it is
> +			 * safe to use info->after for the delta.
> +			 * The above rb_time_cmp_and_update() may or may not
> +			 * have updated the write_stamp. If it did not then
> +			 * the next event will simply add an absolute timestamp
> +			 * as the write_stamp will be different than the
> +			 * before_stamp.
> +			 */
>  			info->delta = ts - info->after;
>  		} else {
>  			/*
> -- 
> 2.42.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


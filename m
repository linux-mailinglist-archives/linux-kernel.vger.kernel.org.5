Return-Path: <linux-kernel+bounces-89740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD09B86F4ED
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203A91F21112
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE4FC154;
	Sun,  3 Mar 2024 13:02:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847A3BE6B
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709470935; cv=none; b=FRZZ+Iw77u5OHUjmz8590Kpw9QRS65haPDbxThSV3hekyHXBcfhSYG+HloZ/TnCcN5sHNW1rkQ3J0ewFytECtTwRGmplRMqEHYcIti5ynlkTLzRrJkx6P7KTZQ2dfsUQdElNfYLawWvkwP3eN7i0pKijqbIVMAtM/MMzo51nMwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709470935; c=relaxed/simple;
	bh=fW7vH0k8JdCdLJCce0aUSYLj9NPTW/2Vau0mQPPcjUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSIEnT0ESWTc1fnFDE9r+lGOuTO5r+R1DQtNvJjVRkSsGO8M/nxwoNS6/+r+lWkwiGrLViFJqIV2I5/dSoFjX5p2KSoLoLzAUEC0WA+IELs1ngeglO2L6ODkKe7VrIVVq7yj40jVAUiI3wO/8VJgnTi6NP1Z7WchTtzW/J6mlBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB11C433F1;
	Sun,  3 Mar 2024 13:02:13 +0000 (UTC)
Date: Sun, 3 Mar 2024 08:02:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
Message-ID: <20240303080212.489b3232@rorschach.local.home>
In-Reply-To: <20240303075937.36fc6043@rorschach.local.home>
References: <20240302111244.3a1674be@gandalf.local.home>
	<CAHk-=wj376WMgZ24wKGEWDs_ojNtod-LDZBedPzDYRRcY60UYA@mail.gmail.com>
	<20240302145958.05aabdd2@rorschach.local.home>
	<CAHk-=wgjhdRj1V847NTF4veMN_tCbrySiEHXO8RO3n05cNeXeA@mail.gmail.com>
	<20240302154713.71e29402@rorschach.local.home>
	<CAHk-=wioeo5vyEWUZcGBKMsf3jnjrnnHc3uJiV=JjSKPdvZOEw@mail.gmail.com>
	<20240303075937.36fc6043@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 Mar 2024 07:59:37 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> 
> I believe I was trying to solve this wrong. The vsprintf() is called on
> reading of the ring buffer, and I was trying to fix it on the write
> side. I believe that the fix should be on the read side where the
> vsprintf() is called.

I prefer this patch, as I found other ways to add large strings into the
ring buffer that can trigger this issue again. This fixes it at the
location of the bug.

-- Steve


> 
> Sachin, can you try this patch.
> 
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 3e7fa44dc2b2..5c7962d612de 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -1588,11 +1588,20 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
>  	struct print_entry *field;
>  	struct trace_seq *s = &iter->seq;
>  	int max = iter->ent_size - offsetof(struct print_entry, buf);
> +	const char *p;
>  
>  	trace_assign_type(field, iter->ent);
>  
>  	seq_print_ip_sym(s, field->ip, flags);
> -	trace_seq_printf(s, ": %.*s", max, field->buf);
> +	trace_seq_puts(s, ": ");
> +	/* Write 1K chunks at a time */
> +	p = field->buf;
> +	do {
> +		int pre = max > 1024 ? 1024 : max;
> +		trace_seq_printf(s, "%.*s", pre, p);
> +		max -= pre;
> +		p += pre;
> +	} while (max > 0);
>  
>  	return trace_handle_return(s);
>  }
> @@ -1602,10 +1611,19 @@ static enum print_line_t trace_print_raw(struct trace_iterator *iter, int flags,
>  {
>  	struct print_entry *field;
>  	int max = iter->ent_size - offsetof(struct print_entry, buf);
> +	const char *p;
>  
>  	trace_assign_type(field, iter->ent);
>  
> -	trace_seq_printf(&iter->seq, "# %lx %.*s", field->ip, max, field->buf);
> +	trace_seq_printf(&iter->seq, "# %lx", field->ip);
> +	/* Write 1K chunks at a time */
> +	p = field->buf;
> +	do {
> +		int pre = max > 1024 ? 1024 : max;
> +		trace_seq_printf(&iter->seq, "%.*s", pre, p);
> +		max -= pre;
> +		p += pre;
> +	} while (max > 0);
>  
>  	return trace_handle_return(&iter->seq);
>  }



Return-Path: <linux-kernel+bounces-94176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C87C873AEE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26AF01F294AA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECF01353E2;
	Wed,  6 Mar 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHrnKv1h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC6C1350DE;
	Wed,  6 Mar 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739678; cv=none; b=hUr4zNHaeZltbz0RLspJkHPq5IAV6C4zZKUtCBxk0hRQBAqd+87axKiJjM+dgG/axCsPGAEpnjj62E3GPh5fkkM/bwtWKvacz1xa93/ZhsCAtyaZ0MP/SGLFUMRO5ucQbjtL5bosJx88QfTB/Z1DRSNSVWjhl0Antty1OP8bxu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739678; c=relaxed/simple;
	bh=WU7LTgl7ib+/Zzz8hPXucfF7yOkR9eYf40hf2eDXtwA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I+DeysbkcThlHfPTVIAW58nN7IMaAeCdJ3fSlr72kGDuwzqcgpMSVIcDM5VDvLrPe1UGRiUZNJfbl5MgPoL6bDXs85KNIgp5c99eSZaq8RSVehz2ZHzOcSjnDqgNqiVC+azVYWBwrshS+dtt3OHq4Ue45N1Jbo6DS8fruneixMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHrnKv1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43939C433C7;
	Wed,  6 Mar 2024 15:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709739678;
	bh=WU7LTgl7ib+/Zzz8hPXucfF7yOkR9eYf40hf2eDXtwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XHrnKv1hp8A+ykApqcbth+QUQ1ba/XO8DxAM2vQVfgwtAOZvyR+pjidJ70Cc05yS3
	 jSu1aQ3jQPt4maWXKNt2B8DBiBFTcnaR9FKEIWjsGV1sWLS46Ho/7xHhaeZ/iF6o2C
	 G1W4nf6wGx2NOhsV9kJC5yLOzBkOj8sbDkSIcPNYENLHoN+X/DlUr/aubPPMx5HLwa
	 3bpZXp4PnMzGX9GMAtKcNbKz1rXk10b2EJHz4U/aRwZL3nLCHfwEJWFAVZBe7G3FoF
	 JrkmNAmwEkvN0IYOOrwHjurJDmavbre+ATm9NtwWxGYiFWeuWdGETaEqSduaiT3D6Y
	 38G3IaSvGldSg==
Date: Thu, 7 Mar 2024 00:41:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Sachin Sant
 <sachinp@linux.ibm.com>
Subject: Re: [PATCH v2] tracing: Limit trace_marker writes to just 4K
Message-Id: <20240307004113.760ab8a999504523819e058e@kernel.org>
In-Reply-To: <20240304223433.4ba47dff@gandalf.local.home>
References: <20240304223433.4ba47dff@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 22:34:33 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Limit the max print event of trace_marker to just 4K string size. This must
> also be less than the amount that can be held by a trace_seq along with
> the text that is before the output (like the task name, PID, CPU, state,
> etc). As trace_seq is made to handle large events (some greater than 4K).
> Make the max size of a trace_marker write event be 4K which is guaranteed
> to fit in the trace_seq buffer.
> 
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> ---
> Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240304192710.4c99677c@gandalf.local.home/
> 
> - Just make the max limit 4K and not half of the trace_seq size.
>   The trace_seq is already made to handle events greater than 4k.
> 
>  kernel/trace/trace.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8198bfc54b58..d16b95ca58a7 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7293,6 +7293,8 @@ tracing_free_buffer_release(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> +#define TRACE_MARKER_MAX_SIZE		4096
> +
>  static ssize_t
>  tracing_mark_write(struct file *filp, const char __user *ubuf,
>  					size_t cnt, loff_t *fpos)
> @@ -7320,6 +7322,9 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>  	if ((ssize_t)cnt < 0)
>  		return -EINVAL;
>  
> +	if (cnt > TRACE_MARKER_MAX_SIZE)
> +		cnt = TRACE_MARKER_MAX_SIZE;
> +
>  	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
>   again:
>  	size = cnt + meta_size;
> @@ -7328,11 +7333,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>  	if (cnt < FAULTED_SIZE)
>  		size += FAULTED_SIZE - cnt;
>  
> -	if (size > TRACE_SEQ_BUFFER_SIZE) {
> -		cnt -= size - TRACE_SEQ_BUFFER_SIZE;
> -		goto again;
> -	}
> -
>  	buffer = tr->array_buffer.buffer;
>  	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
>  					    tracing_gen_ctx());
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


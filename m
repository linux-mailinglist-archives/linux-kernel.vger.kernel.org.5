Return-Path: <linux-kernel+bounces-139516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141368A03E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459D01C217EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC233A1CF;
	Wed, 10 Apr 2024 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AG7Kk66l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACF0383A5;
	Wed, 10 Apr 2024 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712790782; cv=none; b=ksp/SvHdFv5pg/EK8ha0531s9zM1RLmExSJ7+gkVEw16yzjWDHiRnuVb7q5BgY3nyEVMGS+8eLhYZGgAlZvwoFvDKfuZ9LpXSNkh7Sq9D1QTD6ARC8lEZl55IHtbB4xPfWR/g9yoDeQcWQiVyvoTk/rjBvL7Dumx7FvOyG+0obM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712790782; c=relaxed/simple;
	bh=2UedM3DOt9m9XbMolW+aivSPYMa4iJRU/kXBRm/Rzbo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ev4GfpLDUmUbv1wHeFqHS+tpvN5qmOm19GHulzgZeu2Qaqsjr1+kV2M3aQ4L+6/4sGV2k1qY8tgBqJH696rMxHgnkcwCPPNh4NZ4jyKp7iNjHiCalsiy3Evl+QKe5EVp+w2BLFsKj/WWQnexDtgwmE1KLG1lhHTRwcf51xDu2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AG7Kk66l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B53EC433C7;
	Wed, 10 Apr 2024 23:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712790782;
	bh=2UedM3DOt9m9XbMolW+aivSPYMa4iJRU/kXBRm/Rzbo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AG7Kk66lie7Ood2QYBMvYpCKQYJ6TCElUiKffRoGjWECMfuR0zzcY8rpitgZcVSet
	 kzmmNgo+x2sg+nCe7ZQavM8CihK3XYAB3F7oAA6Q4ZY/I2V+HINRL5Jm586pu32Lnx
	 +gdrhCOzBxs968ok+jopTfQkYFVosPzHsmX0faYmqm1lY8DTqAkSiONbn/JcYOv8Y6
	 F1qmJH96yQheMltIJh+I8ih4qMwE2cnDrf+0ieutfvTZj2FnCjpj6DHImnlXE6Q8qV
	 tvjlwP9RWku1u0GRRjyPtTqsaMM4ZuHUV/UiL9mexqiGB88knBJMbuCFI+ETTi+y+6
	 ABqzzOqGH+kcg==
Date: Thu, 11 Apr 2024 08:12:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Sachin Sant
 <sachinp@linux.ibm.com>
Subject: Re: [PATCH] tracing: Limit trace_seq size to just 8K and not depend
 on architecture PAGE_SIZE
Message-Id: <20240411081258.d96952359c857461278d6559@kernel.org>
In-Reply-To: <20240304191342.56fb1087@gandalf.local.home>
References: <20240304191342.56fb1087@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 19:13:42 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The trace_seq buffer is used to print out entire events. It's typically
> set to PAGE_SIZE * 2 as there's some events that can be quite large.
> 
> As a side effect, writes to trace_marker is limited by both the size of the
> trace_seq buffer as well as the ring buffer's sub-buffer size (which is a
> power of PAGE_SIZE). By limiting the trace_seq size, it also limits the
> size of the largest string written to trace_marker.
> 
> trace_seq does not need to be dependent on PAGE_SIZE like the ring buffer
> sub-buffers need to be. Hard code it to 8K which is PAGE_SIZE * 2 on most
> architectures. This will also limit the size of trace_marker on those
> architectures with greater than 4K PAGE_SIZE.
> 
> Link: https://lore.kernel.org/all/20240302111244.3a1674be@gandalf.local.home/
> 

8K is reasonably enough big. Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,


> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/trace_seq.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
> index 9ec229dfddaa..1ef95c0287f0 100644
> --- a/include/linux/trace_seq.h
> +++ b/include/linux/trace_seq.h
> @@ -9,9 +9,15 @@
>  /*
>   * Trace sequences are used to allow a function to call several other functions
>   * to create a string of data to use.
> + *
> + * Have the trace seq to be 8K which is typically PAGE_SIZE * 2 on
> + * most architectures. The TRACE_SEQ_BUFFER_SIZE (which is
> + * TRACE_SEQ_SIZE minus the other fields of trace_seq), is the
> + * max size the output of a trace event may be.
>   */
>  
> -#define TRACE_SEQ_BUFFER_SIZE	(PAGE_SIZE * 2 - \
> +#define TRACE_SEQ_SIZE		8192
> +#define TRACE_SEQ_BUFFER_SIZE	(TRACE_SEQ_SIZE - \
>  	(sizeof(struct seq_buf) + sizeof(size_t) + sizeof(int)))
>  
>  struct trace_seq {
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


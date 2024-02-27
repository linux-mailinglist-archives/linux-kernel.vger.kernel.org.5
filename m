Return-Path: <linux-kernel+bounces-84095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593B886A223
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63291F22099
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D991534F6;
	Tue, 27 Feb 2024 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQNGup5I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE97851009;
	Tue, 27 Feb 2024 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071582; cv=none; b=NQwNlaqxYo+znDStQ6QFbi3ORVq/uWm3JEHVOwtAk1qJh1mu07XIyo5hgD+gqeWPLgXLZ3ComF/C1UfIKeO7V3gjnIevuxVX7rPMkB4/nFKqQlDEMZHccfo3XZL2UNWSTa4FkSaHKhoKWhGeJyDZQbeFJKZJ0fTRNnyEUtn7LCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071582; c=relaxed/simple;
	bh=r7oa1/JIBUsgOWXPR2x0YTv8aY/rxmGWAs3NKv/T+V4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AEoNXbeD+wyFPPlrnyrcDhSSzMvmdYhfYZ2gTc/56w+IjYWtI1+8nzx2XxX874CajPa6xtNzrEp3hmPJnn32iwxUyyleSlW89edyuEhAXU0j8XsSxh3TfQvQBGcuZ1dhMaOmcSPI4dJtHhQYJB/TwChNCbvA4TY3zaCnebZSJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQNGup5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B78C433F1;
	Tue, 27 Feb 2024 22:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709071581;
	bh=r7oa1/JIBUsgOWXPR2x0YTv8aY/rxmGWAs3NKv/T+V4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CQNGup5IOpPNj/9KQP2EnUqZ2IL7tsD+u3JuBc103M7H4PcfYxbcx8j/fVnH3qb5T
	 1Kx8//f5m86CwITG9KhCLrEi6uVdvW0vZ7KzL25Iylg2YfGStOWhOIg2Sge8cIPDbA
	 Lqly99cPrdRWqsCJpOlzXdRiHnpqztmEe6DvM2zE5ePdKwhRKBUYeSWal9ympU1BJi
	 ZnRPNhRw7drCnOpaG1looPDkik0nUWmjJdhqv69HNpbQGP1Zm2SlwDe+AF13ABesQa
	 nfNTgz4N5gCeDKwTc3xnk8b86K7Ak8HREK2lw13XQlQZF7gWGtMaHq2bEhqs9rweOy
	 8Y1xeT0o0d6Rw==
Date: Wed, 28 Feb 2024 07:06:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] tracing: Prevent trace_marker being bigger than
 unsigned short
Message-Id: <20240228070617.ebf2408f0d9b35e356faf01b@kernel.org>
In-Reply-To: <20240227125706.04279ac2@gandalf.local.home>
References: <20240227125706.04279ac2@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 12:57:06 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The trace_marker write goes into the ring buffer. A test was added to
> write a string as big as the sub-buffer of the ring buffer to see if it
> would work. A sub-buffer is typically PAGE_SIZE in length.
> 
> On PowerPC architecture, the ftrace selftest for trace_marker started to
> fail. This was due to PowerPC having a PAGE_SIZE of 65536 and not 4096. It
> would try to write a string that was around 63000 bytes in size. This gave
> the following warning:
> 
> ------------[ cut here ]------------
> precision 63492 too large
> WARNING: CPU: 15 PID: 2538829 at lib/vsprintf.c:2721 set_precision+0x68/0xa4
> Modules linked in:
> CPU: 15 PID: 2538829 Comm: awk Tainted: G M O K 6.8.0-rc5-gfca7526b7d89 #1
> Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_018) hv:phyp pSeries
> NIP: c000000000f57c34 LR: c000000000f57c30 CTR: c000000000f5cdf0
> REGS: c000000a58e4f5f0 TRAP: 0700 Tainted: G M O K (6.8.0-rc5-gfca7526b7d89)
> MSR: 8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE> CR: 48000824 XER: 00000005
> CFAR: c00000000016154c IRQMASK: 0
> GPR00: c000000000f57c30 c000000a58e4f890 c000000001482800 0000000000000019
> GPR04: 0000000100011559 c000000a58e4f660 c000000a58e4f658 0000000000000027
> GPR08: c000000e84e37c10 0000000000000001 0000000000000027 c000000002a47e50
> GPR12: 0000000000000000 c000000e87bf7300 0000000000000000 0000000000000000
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> GPR20: c0000004a43ec590 0000000000400cc0 0000000000000003 c0000000012c3e65
> GPR24: c000000a58e4fa18 0000000000000025 0000000000000020 000000000001ff97
> GPR28: c0000001168a00dd c0000001168c0074 c000000a58e4f920 000000000000f804
> NIP [c000000000f57c34] set_precision+0x68/0xa4
> LR [c000000000f57c30] set_precision+0x64/0xa4
> Call Trace:
> [c000000a58e4f890] [c000000000f57c30] set_precision+0x64/0xa4 (unreliable)
> [c000000a58e4f900] [c000000000f5ccc4] vsnprintf+0x198/0x4c8
> [c000000a58e4f980] [c000000000f53228] seq_buf_vprintf+0x50/0xa0
> [c000000a58e4f9b0] [c00000000031cec0] trace_seq_printf+0x60/0xe0
> [c000000a58e4f9e0] [c00000000031b5f0] trace_print_print+0x78/0xa4
> [c000000a58e4fa60] [c0000000003133a4] print_trace_line+0x2ac/0x6d8
> [c000000a58e4fb20] [c0000000003145c0] s_show+0x58/0x2c0
> [c000000a58e4fba0] [c0000000005dfb2c] seq_read_iter+0x448/0x618
> [c000000a58e4fc70] [c0000000005dfe08] seq_read+0x10c/0x174
> [c000000a58e4fd10] [c00000000059a7e0] vfs_read+0xe0/0x39c
> [c000000a58e4fdc0] [c00000000059b59c] ksys_read+0x7c/0x140
> [c000000a58e4fe10] [c000000000035d74] system_call_exception+0x134/0x330
> [c000000a58e4fe50] [c00000000000d6a0] system_call_common+0x160/0x2e4
> 
> The problem was that in trace_print_print() that reads the trace_marker
> write data had the following code:
> 
> 	int max = iter->ent_size - offsetof(struct print_entry, buf);
> 
> 	[..]
> 	trace_seq_printf(s, ": %.*s", max, field->buf);
> 
> Where "max" was the size of the entry. Now that the write to trace_marker
> can be as big as what the sub-buffer can hold, and the sub-buffer for
> powerpc is 64K in size, the "max" value was: 63492, and that was passed to
> trace_seq_printf() which eventually calls vsnprintf() with the same format
> and parameters.
> 
> The max "precision" that "%.*s" can be is max signed short (32767) where
> 63492 happens to be greater than.
> 
> Prevent the max size written by trace_marker to be greater than what a
> signed short can hold.

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Link: https://lore.kernel.org/all/C7E7AF1A-D30F-4D18-B8E5-AF1EF58004F5@linux.ibm.com/
> 
> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
> Tested-by: Sachin Sant <sachinp@linux.ibm.com>
> Fixes: 8ec90be7f15f ("tracing: Allow for max buffer data size trace_marker writes")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8198bfc54b58..1606fa99367b 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7310,7 +7310,9 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>  /* Used in tracing_mark_raw_write() as well */
>  #define FAULTED_STR "<faulted>"
>  #define FAULTED_SIZE (sizeof(FAULTED_STR) - 1) /* '\0' is already accounted for */
> -
> +#ifndef SHORT_MAX
> +#define SHORT_MAX	((1<<15) - 1)
> +#endif
>  	if (tracing_disabled)
>  		return -EINVAL;
>  
> @@ -7328,6 +7330,16 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>  	if (cnt < FAULTED_SIZE)
>  		size += FAULTED_SIZE - cnt;
>  
> +	/*
> +	 * trace_print_print() uses vsprintf() to determine the size via
> +	 * the precision format "%.*s" which can not be greater than
> +	 * a signed short.
> +	 */
> +	if (size > SHORT_MAX) {
> +		cnt -= size - SHORT_MAX;
> +		goto again;
> +	}
> +
>  	if (size > TRACE_SEQ_BUFFER_SIZE) {
>  		cnt -= size - TRACE_SEQ_BUFFER_SIZE;
>  		goto again;
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


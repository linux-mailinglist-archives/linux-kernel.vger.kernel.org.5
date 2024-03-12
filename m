Return-Path: <linux-kernel+bounces-100458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306798797CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624661C21960
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C6E7D067;
	Tue, 12 Mar 2024 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEAdbJPD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECAE7CF23;
	Tue, 12 Mar 2024 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257927; cv=none; b=k7hdjEBI8Pk+tjkxqe7RL7SQA8Q4bStga6h409IafwLIq9/RltCleKaeOmWHujVSRq07PZVdKKoUyVyMksHuur/VIJCJaXgYou1Y7N9PSHosv9ogNX/6UHpOaEGkVM1CjgiD6fAznDv5+sipge92eF0ESUSnjSrAOtZTp6Kka48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257927; c=relaxed/simple;
	bh=KrjUr0fKLEMJXBr7/aqGGHUCFtbu9uuJVf+zBR7qhTk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NcceKAtn3Cf/k1dkEx0aas0B79fF2GjzidveGSo/8OSwPRMzLXSPF6P8HsST12qXtuAUBZ2HZ6L7K0SdwkO8SouZJEdux2WKE+c/DlWhmIlyKt3GsccFwhUp1dbs7VOT4TmWMscciXYBcmbRxEfOgb/d9nPI3k+zMaXx5kTt3Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEAdbJPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8119C433F1;
	Tue, 12 Mar 2024 15:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710257926;
	bh=KrjUr0fKLEMJXBr7/aqGGHUCFtbu9uuJVf+zBR7qhTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eEAdbJPD0or1tO0Pg1cVnQNEZw4hTcLP7UWtv3SQdbx/U5qjgqIwRHpZt87aU70uP
	 1S+7jTWMBmN9We2cbyzn8iiHoE8qdVN7slhrfmT7Z/NF5bsFse9vSTDGGVfQwbXA9m
	 Viwvad3EibOsXZveqpqIVgxhgXFuTqYFgZREfvyPfWP5CEPDmK41keFeyXUru266pA
	 FErtKyLsn0Kn3r8n/a+eSWtHmi657e+5MbK0otspcE8cvSkum4D5lZ6FCEkoTNgdpb
	 Bn/BkEHEn2/IuRGTN8ix0rbztH3qmuvtquZVR+xWe8Dz78tmXJfigPhY3t5tnOFMts
	 jD1RC+Yepao1w==
Date: Wed, 13 Mar 2024 00:38:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] ring-buffer: Reuse rb_watermark_hit() for the
 poll logic
Message-Id: <20240313003842.207e83107633bef0c4a798b4@kernel.org>
In-Reply-To: <20240312131952.802267543@goodmis.org>
References: <20240312131919.314231457@goodmis.org>
	<20240312131952.802267543@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 09:19:21 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The check for knowing if the poll should wait or not is basically the
> exact same logic as rb_watermark_hit(). The only difference is that
> rb_watermark_hit() also handles the !full case. But for the full case, the
> logic is the same. Just call that instead of duplicating the code in
> ring_buffer_poll_wait().
> 

This changes a bit (e.g. adding pagebusy check) but basically that should
be there. And new version appears to be consistent between ring_buffer_wait()
and ring_buffer_poll_wait(). So looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index adfe603a769b..857803e8cf07 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -959,25 +959,18 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
>  	}
>  
>  	if (full) {
> -		unsigned long flags;
> -
>  		poll_wait(filp, &rbwork->full_waiters, poll_table);
>  
> -		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> -		if (!cpu_buffer->shortest_full ||
> -		    cpu_buffer->shortest_full > full)
> -			cpu_buffer->shortest_full = full;
> -		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> -		if (full_hit(buffer, cpu, full))
> +		if (rb_watermark_hit(buffer, cpu, full))
>  			return EPOLLIN | EPOLLRDNORM;
>  		/*
>  		 * Only allow full_waiters_pending update to be seen after
> -		 * the shortest_full is set. If the writer sees the
> -		 * full_waiters_pending flag set, it will compare the
> -		 * amount in the ring buffer to shortest_full. If the amount
> -		 * in the ring buffer is greater than the shortest_full
> -		 * percent, it will call the irq_work handler to wake up
> -		 * this list. The irq_handler will reset shortest_full
> +		 * the shortest_full is set (in rb_watermark_hit). If the
> +		 * writer sees the full_waiters_pending flag set, it will
> +		 * compare the amount in the ring buffer to shortest_full.
> +		 * If the amount in the ring buffer is greater than the
> +		 * shortest_full percent, it will call the irq_work handler
> +		 * to wake up this list. The irq_handler will reset shortest_full
>  		 * back to zero. That's done under the reader_lock, but
>  		 * the below smp_mb() makes sure that the update to
>  		 * full_waiters_pending doesn't leak up into the above.
> -- 
> 2.43.0
> 
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


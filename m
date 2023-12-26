Return-Path: <linux-kernel+bounces-11716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1513E81EA6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 23:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0B91F21A72
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 22:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A425684;
	Tue, 26 Dec 2023 22:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRltgXlD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBCF525B;
	Tue, 26 Dec 2023 22:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1D5C433C7;
	Tue, 26 Dec 2023 22:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703631432;
	bh=RnHI3X+wfM4e7cmhsHvWFX3pGA94mnF30x/7yRkimHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CRltgXlDoUI8hv9A0mECylaPn77DijNXxzp5r38sNL/YDIivGYsTsGJiEcLwZKBr1
	 OguN7bY+eVVSiStni4qIBFecIabebPA9+Z7J6e+T7v5N946ltcD3wIIwLEg/RSEPF1
	 ZbD0Gg5hghNL6nf9tVx2h3zhA3ugGTqHUG+lbYgXQ2QETwIL6gNkvhu0Vw39cUoLls
	 9IxDZL+yk+0U3HqGNuUI74ZTgiKeTh8kRqPsGO5qzEm2kp/VqHfMXbHROZkc69SKd5
	 OpXljetGJ3PhPkSJwaaUIclJ8alSboZrBj3yneADZtHnox8fzzbUJ9+o8T6+rCq1ov
	 9rkbZ5WHxVP2Q==
Date: Wed, 27 Dec 2023 07:57:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Fix wake ups when buffer_percent is set to
 100
Message-Id: <20231227075708.008225fc3c04444aac193b39@kernel.org>
In-Reply-To: <20231226125902.4a057f1d@gandalf.local.home>
References: <20231226125902.4a057f1d@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Dec 2023 12:59:02 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The tracefs file "buffer_percent" is to allow user space to set a
> water-mark on how much of the tracing ring buffer needs to be filled in
> order to wake up a blocked reader.
> 
>  0 - is to wait until any data is in the buffer
>  1 - is to wait for 1% of the sub buffers to be filled
>  50 - would be half of the sub buffers are filled with data
>  100 - is not to wake the waiter until the ring buffer is completely full
> 
> Unfortunately the test for being full was:
> 
> 	dirty = ring_buffer_nr_dirty_pages(buffer, cpu);
> 	return (dirty * 100) > (full * nr_pages);
> 
> Where "full" is the value for "buffer_percent".
> 
> There is two issues with the above when full == 100.
> 
> 1. dirty * 100 > 100 * nr_pages will never be true
>    That is, the above is basically saying that if the user sets
>    buffer_percent to 100, more pages need to be dirty than exist in the
>    ring buffer!
> 
> 2. The page that the writer is on is never considered dirty, as dirty
>    pages are only those that are full. When the writer goes to a new
>    sub-buffer, it clears the contents of that sub-buffer.
> 
> That is, even if the check was ">=" it would still not be equal as the
> most pages that can be considered "dirty" is nr_pages - 1.
> 
> To fix this, add one to dirty and use ">=" in the compare.
> 
> Cc: stable@vger.kernel.org
> Fixes: 03329f9939781 ("tracing: Add tracefs file buffer_percentage")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 83eab547f1d1..32c0dd2fd1c3 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -881,9 +881,14 @@ static __always_inline bool full_hit(struct trace_buffer *buffer, int cpu, int f
>  	if (!nr_pages || !full)
>  		return true;
>  
> -	dirty = ring_buffer_nr_dirty_pages(buffer, cpu);
> +	/*
> +	 * Add one as dirty will never equal nr_pages, as the sub-buffer
> +	 * that the writer is on is not counted as dirty.
> +	 * This is needed if "buffer_percent" is set to 100.
> +	 */
> +	dirty = ring_buffer_nr_dirty_pages(buffer, cpu) + 1;

Is this "+ 1" required? If we have 200 pages and 1 buffer is dirty,
it is 0.5% dirty. Consider @full = 1%.

@dirty = 1 + 1 = 2 and @dirty * 100 == 200. but 
@full * @nr_pages = 1 * 200 = 200.
Thus it hits (200 >= 200 is true) even if dirty pages are 0.5%.

>  
> -	return (dirty * 100) > (full * nr_pages);
> +	return (dirty * 100) >= (full * nr_pages);

Thank you,

>  }
>  
>  /*
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


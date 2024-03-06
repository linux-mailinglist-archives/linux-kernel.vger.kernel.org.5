Return-Path: <linux-kernel+bounces-94013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9080D873849
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24BB1C227E9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10C8134CEF;
	Wed,  6 Mar 2024 14:04:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458C9131759;
	Wed,  6 Mar 2024 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733844; cv=none; b=OX1HCClnHAxdHWvBm0tdYdsk1cuhp8PvPzLZARmg98vEsjTBi2hB2tU/zms8MV32BT5F+gGLF1Tszw9Fo1KsYJav3tPtY0K3hm98ddDkKvzUbbAjzZH2ATSfv3ifWFHt8awh0FgWjptLJDyFcmFCqY+R6Iaik+eNTVzxWZgE3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733844; c=relaxed/simple;
	bh=ZL5UEHiy9sKgAhcnzVEkK56fqJjvEAVvWU7/2zX1N3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIAMK/gQybJ+IaN5trmz9bCcfRG97Cl9j7J4GMfKvDQ1N4mOPRWpSWi+XxqSj/SC1opId5egnl6iCXbxJ4i+zSAGO387YWB+0Csvamr4QPlAQRmb0p8a3UqPOnmAOgykcB5PUdb6t9/5Xp+fwig37GleqxFMaaypk1dUuw5RMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28ED3C43390;
	Wed,  6 Mar 2024 14:04:03 +0000 (UTC)
Date: Wed, 6 Mar 2024 09:05:55 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linke li <lilinke99@qq.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: mark racy accesses on work->wait_index
Message-ID: <20240306090555.4bdba89f@gandalf.local.home>
In-Reply-To: <tencent_BA1473492BC618B473864561EA3AB1418908@qq.com>
References: <tencent_BA1473492BC618B473864561EA3AB1418908@qq.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Mar 2024 10:55:34 +0800
linke li <lilinke99@qq.com> wrote:

> Mark data races to work->wait_index as benign using READ_ONCE and WRITE_ONCE. These accesses are expected to be racy.

Are we now to the point that every single access of a variable (long size
or less) needs a READ_ONCE/WRITE_ONCE even with all the necessary smp_r/wmb()s?


> 
> Signed-off-by: linke li <lilinke99@qq.com>
> ---
>  kernel/trace/ring_buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 0699027b4f4c..a47e9e9750cc 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -798,7 +798,7 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
>  		rbwork = &cpu_buffer->irq_work;
>  	}
>  
> -	rbwork->wait_index++;
> +	WRITE_ONCE(rbwork->wait_index, READ_ONCE(rbwork->wait_index) + 1);

I mean the above is really ugly. If this is the new thing to do, we need
better macros.

If anything, just convert it to an atomic_t.

-- Steve


>  	/* make sure the waiters see the new index */
>  	smp_wmb();
>  
> @@ -906,7 +906,7 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
>  
>  		/* Make sure to see the new wait index */
>  		smp_rmb();
> -		if (wait_index != work->wait_index)
> +		if (wait_index != READ_ONCE(work->wait_index))
>  			break;
>  	}
>  



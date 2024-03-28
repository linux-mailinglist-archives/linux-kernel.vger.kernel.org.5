Return-Path: <linux-kernel+bounces-123041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C6B89015F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B80DFB2369F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7791185649;
	Thu, 28 Mar 2024 14:11:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4E14294;
	Thu, 28 Mar 2024 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635101; cv=none; b=h/CXaKqMiEIC4p8e9QFveFjFkh2DGQ3IW/59qxLRygnzTLCxtLsI2XdDcGhz1ra8Ei5YCU3yLyus0MEobecnVUxYeDwHmmtsMgfXEO27EUrDUP+laxoIgJBT9bsZM4tXJN14lbCS00DHTD4VfIhWt77LQfS8xpmTEQsqpedEIkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635101; c=relaxed/simple;
	bh=tQsOJkvXX4/JlxEm1if34+dTH/cbHDaopNV04LTB0NI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcWre7txweTUCRZYY6k1CpE66f9Cd/EWhUacVFhgi8jLNve3yl4zye0SPkfaN6Y85hmj9fzhn8BDVQY4j7/6U0gH/hDKgI17VzFQ4V4jpVLcUCAC7MSI5OjgJdLND8ImWhI6DHYEXAHgb5xtrGvY8rkZjLniEdebyMyukKzldLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9488DC433F1;
	Thu, 28 Mar 2024 14:11:39 +0000 (UTC)
Date: Thu, 28 Mar 2024 10:14:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Masami
 Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-block@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] blktrace: convert strncpy() to strscpy_pad()
Message-ID: <20240328101422.37e1c4f0@gandalf.local.home>
In-Reply-To: <20240328140512.4148825-9-arnd@kernel.org>
References: <20240328140512.4148825-1-arnd@kernel.org>
	<20240328140512.4148825-9-arnd@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 15:04:52 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-9 warns about a possibly non-terminated string copy:
> 
> kernel/trace/blktrace.c: In function 'do_blk_trace_setup':
> kernel/trace/blktrace.c:527:2: error: 'strncpy' specified bound 32 equals destination size [-Werror=stringop-truncation]
> 
> Newer versions are fine here because they see the following explicit
> nul-termination. Using strscpy_pad() avoids the warning and
> simplifies the code a little. The padding helps  give a clean
> buffer to userspace.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/trace/blktrace.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index d5d94510afd3..95a00160d465 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -524,8 +524,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  	if (!buts->buf_size || !buts->buf_nr)
>  		return -EINVAL;
>  
> -	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
> -	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';
> +	strscpy(buts->name, name, BLKTRACE_BDEV_SIZE);

The commit message says "Using strscpy_pad()" but it doesn't do so in the
patch.

Rule 12 of debugging: "When the comment and the code do not match, they are
                       probably both wrong"

-- Steve


>  
>  	/*
>  	 * some device names have larger paths - convert the slashes



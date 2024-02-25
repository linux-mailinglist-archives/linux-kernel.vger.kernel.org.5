Return-Path: <linux-kernel+bounces-80322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9164862D69
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC831C20BD1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD571B978;
	Sun, 25 Feb 2024 22:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q53+PBEQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6211B951;
	Sun, 25 Feb 2024 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708899702; cv=none; b=bL6rU1K17YjfPfvzoCxe9I0tFRylbpm2abKACT0v06MEfF12a2wEjvwiI9VSfgjQyyBzYhFKPiN/3wT63kEVMpI0/rBHex84Vu4MVzMNzWLmSHJRcv6xvMTnJ4c+3Yp7rBd6Hty9wU1dzqLvV79i+4capa+RxwWn2Sc9hqpTtdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708899702; c=relaxed/simple;
	bh=2rMIg+Hl+/TCyHRlXHHI/JIqctZyl4ljHu9l1dfMqOQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nV8kMmP4YOJOuXrnFqWf6CTKSy98Mva1RgbAPD+Ez548HCRio95roZyUq2GATsevGOTBKf7NBtidHemtsfHu1JAadrKTJvcGhON4CDZbydmjToCpNDtAOD8Z0+RXw0g/caj9TDHfAnH9bJLdN1vbZXmMJOZE21vfAz4fcdjSEK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q53+PBEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE8EC433F1;
	Sun, 25 Feb 2024 22:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708899702;
	bh=2rMIg+Hl+/TCyHRlXHHI/JIqctZyl4ljHu9l1dfMqOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q53+PBEQmjWGHh/ZkfbNDHl4KdKn3K+mhvTZfd82oI/0uvrSWV6RK+yIH/BfoqkHq
	 uVoyraL1pkW2HUmoq8XnpsxvhtJf4+V7AhAxgxg+ry0Zkz2WvDrRsSHu4F1aSzGR6Y
	 WodeVCe+Dm94lgvRqjwhm6c2wkcwDLCLPYfnKFcRC1aqMZmf4Xhqw2nzS/MhgkQfsa
	 vMHXuT91b84YbEeJqU3+YxQujEd4N5RuTIasZmptczveAtUZNSBDdfug0V2IjTHVLq
	 N9kBrwW4KiLDZqyVwqMyKkRts5lBrr7NmHGOoz/dRat6eK7D1X3UBiTtv0Pu4fAztk
	 WxHhAnW+a9jGA==
Date: Mon, 26 Feb 2024 07:21:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Use div64_u64() instead of do_div()
Message-Id: <20240226072137.27e500b26ba2a7e1c42974f9@kernel.org>
In-Reply-To: <20240225164507.232942-2-thorsten.blum@toblux.com>
References: <20240225164507.232942-2-thorsten.blum@toblux.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Feb 2024 17:45:08 +0100
Thorsten Blum <thorsten.blum@toblux.com> wrote:

> Fixes Coccinelle/coccicheck warnings reported by do_div.cocci.
> 
> Compared to do_div(), div64_u64() does not implicitly cast the divisor and
> does not unnecessarily calculate the remainder.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  kernel/trace/trace_benchmark.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
> index 54d5fa35c90a..811b08439406 100644
> --- a/kernel/trace/trace_benchmark.c
> +++ b/kernel/trace/trace_benchmark.c
> @@ -92,7 +92,6 @@ static void trace_do_benchmark(void)
>  	bm_total += delta;
>  	bm_totalsq += delta * delta;
>  
> -
>  	if (bm_cnt > 1) {
>  		/*
>  		 * Apply Welford's method to calculate standard deviation:
> @@ -105,7 +104,7 @@ static void trace_do_benchmark(void)
>  		stddev = 0;
>  
>  	delta = bm_total;
> -	do_div(delta, bm_cnt);
> +	delta = div64_u64(delta, bm_cnt);
>  	avg = delta;
>  
>  	if (stddev > 0) {
> @@ -127,7 +126,7 @@ static void trace_do_benchmark(void)
>  			seed = stddev;
>  			if (!last_seed)
>  				break;
> -			do_div(seed, last_seed);
> +			seed = div64_u64(seed, last_seed);
>  			seed += last_seed;
>  			do_div(seed, 2);
>  		} while (i++ < 10 && last_seed != seed);
> -- 
> 2.43.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


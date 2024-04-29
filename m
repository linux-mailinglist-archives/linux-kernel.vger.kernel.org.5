Return-Path: <linux-kernel+bounces-162371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC2A8B59EB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11991F20F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B47C6CDBC;
	Mon, 29 Apr 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/zq4hR/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD042055;
	Mon, 29 Apr 2024 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397386; cv=none; b=nvOlUoutiYpeGmU1L+DdLjMAiYv0hBJhDpiZj/SwMgMgyAS8wUYh9aIhl26sxm3toZGoN28zj8+pv+4GeSjBvLV/9GvR6q/tOK4RdMkpg0SdE24cRL2n0lhyl8Jo+BqDjLpsrvNw/ff4k9H3PJieS3DyiO6SQ7FiW4kyk2OnoYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397386; c=relaxed/simple;
	bh=Kxu1E0Bn8QjLXrlB4tLuOInXoVo+nyGtr9YUAaoPRWI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UMpu2jxYe+U+9DQQw1VfH6A0pchiqTg7uCQyBcvOaeECYFI6bg+cfIfba0i8e76y7t3kiswNmMNALd2cg3JtqX/djl5kIH4SJF2tUM1NKZep40VHI7AY2wl3/XSM2FrL8xpewWMETeCaN6Sk/dyIViX9GwWvnFvszXV8UJW9zGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/zq4hR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4207CC113CD;
	Mon, 29 Apr 2024 13:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714397386;
	bh=Kxu1E0Bn8QjLXrlB4tLuOInXoVo+nyGtr9YUAaoPRWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q/zq4hR/PmLGNo3ogSS4jdb5W08EpP8k/4gOgG4dcpMii/LyCbFTTTHgxTaVfi1k7
	 tKb80RaPN4OcfK/as678HZsXCxEihhSksMHGW5GypsRBMdF7/Q0NxwEKRLWdSaiwf+
	 d7hLvtK+UpZfPiQtO6ZC3FpgClRFrW6BaFytK5ugODAGwe+WmT5NE7XclugrmBoP+G
	 qj41DcspcamTtJe3nvwHRdC9Swb6UisT/l6JG2Jri8lgtu25gjcH5r5zlFvD0TpW2c
	 ajPJxyYbgs9JkhxGROdZN/t7m8y0+maiczNhp/yijdU3mfhqJoNkd0T8cgUkARiexr
	 1sneGmDpJiI9w==
Date: Mon, 29 Apr 2024 22:29:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: lumingyindetect@126.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v3] tracing/probes: Fix memory leak in
 traceprobe_parse_probe_arg_body()
Message-Id: <20240429222941.12d3b774bebef484e605d095@kernel.org>
In-Reply-To: <20240427072347.1421053-1-lumingyindetect@126.com>
References: <20240427072347.1421053-1-lumingyindetect@126.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi LuMing,

On Sat, 27 Apr 2024 08:23:47 +0100
lumingyindetect@126.com wrote:

> From: LuMingYin <lumingyindetect@126.com>
> 
> If traceprobe_parse_probe_arg_body() failed to allocate 'parg->fmt',
> it jumps to the label 'out' instead of 'fail' by mistake.In the result,
> the buffer 'tmp' is not freed in this case and leaks its memory.
> 
> Thus jump to the label 'fail' in that error case.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


Thank you!

> Fixes: 032330abd08b ("tracing/probes: Cleanup probe argument parser")
> Signed-off-by: LuMingYin <lumingyindetect@126.com>
> ---
>  kernel/trace/trace_probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index c09fa6fc636e..81c319b92038 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1466,7 +1466,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
>  		parg->fmt = kmalloc(len, GFP_KERNEL);
>  		if (!parg->fmt) {
>  			ret = -ENOMEM;
> -			goto out;
> +			goto fail;
>  		}
>  		snprintf(parg->fmt, len, "%s[%d]", parg->type->fmttype,
>  			 parg->count);
> -- 
> 2.25.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


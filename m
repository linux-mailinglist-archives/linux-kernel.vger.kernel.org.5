Return-Path: <linux-kernel+bounces-35463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB8A839191
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6DF1C27584
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5F550277;
	Tue, 23 Jan 2024 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQ+tKRUF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475F4878F;
	Tue, 23 Jan 2024 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020817; cv=none; b=EW6On3aNdJxlT6xvVOmyFDbk213gAR9IwItzU9I8E13moAnRtVfl8QblmSChYofL7BZms8jJKUrnFVDNsF09+UXvoEx1W02oqLxVpeLARiCsB4C9G4Blw4cuLafnNbkl490m8ow7UQ2kHov3WixGSu4aP0hP/9ifOghcubqKd2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020817; c=relaxed/simple;
	bh=7OrEELPqwl1P/+/gYysQOWDUrrVY1g6F2G52cR4MOb8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hkbvhM9WUihs3X84RnwxTq1AUvqOoZ2XSsG96Drv7JWP/t7bSXuP/oaoyqZEgNdS+mzbZmjp8eRHe+ciqKSB7gvBbRjQfLz8X8sN2ACz8nL1fuXuboPtA2fg5U8shKk5lQiT8m7+mG5Y1inXbeNbCmUoXM9Qd9jXejtpiG3lKLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQ+tKRUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07282C43394;
	Tue, 23 Jan 2024 14:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706020817;
	bh=7OrEELPqwl1P/+/gYysQOWDUrrVY1g6F2G52cR4MOb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vQ+tKRUF54hRd0uRx9LGKJXikF5x23IHF5X9zUujFmtIFHVv+bbowa/dLUDMauDJD
	 o27P+MW0BuxpctPbvE5wZV9U+CDJXcUbnQUICamFxR/g7CIhK2d8ZksGHxUDljrQX4
	 kHK/7xaEe6b002yPwRc+REQEvMgKtIIwHEcZOVTP0lpl2j03xiD4aM3F0cojPyYKFv
	 /OQVy1S1AZLzkYCP3mcvioxzHy22Mswgl93hGXuqc0qgZeFNtVaZrLnXMy06aIj+Yj
	 C531TVsxcpk46Z0SgRCfx65arUDUTN66WDovMkPyiF4A+whLIVBKUpqxwAhGx0OQnP
	 AbSwEcWY+QKqw==
Date: Tue, 23 Jan 2024 23:40:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/7] tracing/probes: support '%pd' type for print
 struct dentry's name
Message-Id: <20240123234013.52b1834908da7be0272e7a73@kernel.org>
In-Reply-To: <20240123092139.3698375-4-yebin10@huawei.com>
References: <20240123092139.3698375-1-yebin10@huawei.com>
	<20240123092139.3698375-4-yebin10@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 17:21:35 +0800
Ye Bin <yebin10@huawei.com> wrote:

> Similar to '%pd' for printk, use '%pd' for print struct dentry's name.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  kernel/trace/trace_kprobe.c | 6 ++++++
>  kernel/trace/trace_probe.h  | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index c4c6e0e0068b..00b74530fbad 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -779,6 +779,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  	char buf[MAX_EVENT_NAME_LEN];
>  	char gbuf[MAX_EVENT_NAME_LEN];
>  	char abuf[MAX_BTF_ARGS_LEN];
> +	char dbuf[MAX_DENTRY_ARGS_LEN];

Hmm, no, I don't like to expand stack anymore. Please allocate it
from heap.

>  	struct traceprobe_parse_context ctx = { .flags = TPARG_FL_KERNEL };
>  
>  	switch (argv[0][0]) {
> @@ -930,6 +931,11 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  		argv = new_argv;
>  	}
>  
> +	ret = traceprobe_expand_dentry_args(argc, argv, dbuf,
> +					    MAX_DENTRY_ARGS_LEN);
> +	if (ret)
> +		goto out;

And calling this here will not cover the trace_fprobe. 

Could you call this from traceprobe_expand_meta_args() instead of
calling it directly from trace_kprobe? Then it can be used from
fprobe_event too.

Thank you,

> +
>  	/* setup a probe */
>  	tk = alloc_trace_kprobe(group, event, addr, symbol, offset, maxactive,
>  				argc, is_return);
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 553371a4e0b1..d9c053824975 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -34,6 +34,7 @@
>  #define MAX_ARRAY_LEN		64
>  #define MAX_ARG_NAME_LEN	32
>  #define MAX_BTF_ARGS_LEN	128
> +#define MAX_DENTRY_ARGS_LEN	256

Why do you think 

>  #define MAX_STRING_SIZE		PATH_MAX
>  #define MAX_ARG_BUF_LEN		(MAX_TRACE_ARGS * MAX_ARG_NAME_LEN)
>  
> -- 
> 2.31.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


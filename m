Return-Path: <linux-kernel+bounces-34665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1F08385E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9521C26F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B86E10F1;
	Tue, 23 Jan 2024 03:02:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79057F4;
	Tue, 23 Jan 2024 03:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978949; cv=none; b=bTj8Y9nSpQxaN5JWFMwn6JA8qvF6xZv5iF/VoxKeETIKNKFSa/DUHwnDhYReKruy81imsZagX2Oc1QcNFrmN0oo8iQ5se9d01m5QhNvltI/O41VwpByjOMB1iYpU4ND3y078Yn5Ezmi9b5FTSM/0oaoIgeZITsnVAyqqVmv5uys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978949; c=relaxed/simple;
	bh=1YZXRzB1sgHkwYQ7v2pY7Ix8LZx56eaxMd2LI5opJ4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DspX2kVt3GKq1Twsy3SKlXER9wwxcjTDPt4u9vvxQZVYiXma6Fd1Cs3qcmiJ0MBOCc0CKXYMmA94A9f+2Tze+q2PfDuA1OJXgs3NA4mm/XsPrRLYhB6DhQm3Xz+Wc9WyuML0lVxgDyDNGsoAjnTRA6BzrkCHkLOWP1UMVJ61Pl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608FFC433C7;
	Tue, 23 Jan 2024 03:02:28 +0000 (UTC)
Date: Mon, 22 Jan 2024 22:03:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] tracing/probes: support '%pD' type for print
 struct file's name
Message-ID: <20240122220357.0105e20b@gandalf.local.home>
In-Reply-To: <20240123025608.2370978-5-yebin10@huawei.com>
References: <20240123025608.2370978-1-yebin10@huawei.com>
	<20240123025608.2370978-5-yebin10@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 10:56:05 +0800
Ye Bin <yebin10@huawei.com> wrote:

> Similar to '%pD' for printk, use '%pD' for print struct file's name.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  kernel/trace/trace_probe.c | 41 ++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index cc8bd7ea5341..6215b9573793 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -12,6 +12,7 @@
>  #define pr_fmt(fmt)	"trace_probe: " fmt
>  
>  #include <linux/bpf.h>
> +#include <linux/fs.h>
>  #include "trace_btf.h"
>  
>  #include "trace_probe.h"
> @@ -1574,28 +1575,38 @@ int traceprobe_expand_dentry_args(int argc, const char *argv[], char *buf,
>  	for (i = 0; i < argc; i++) {
>  		size_t idx;
>  
> -		if (str_has_suffix(argv[i], ":%pd", &idx)) {
> -			char *tmp = kstrdup(argv[i], GFP_KERNEL);
> -			char *equal;
> +		if (!str_has_suffix(argv[i], ":%pd", &idx) &&
> +		    !str_has_suffix(argv[i], ":%pD", &idx))
> +			continue;
>  
> -			if (!tmp)
> -				return -ENOMEM;
> +		char *tmp = kstrdup(argv[i], GFP_KERNEL);
> +		char *equal;
> +
> +		if (!tmp)
> +			return -ENOMEM;
>  
> -			equal = strchr(tmp, '=');
> -			if (equal)
> -				*equal = '\0';
> -			tmp[idx] = '\0';
> +		equal = strchr(tmp, '=');
> +		if (equal)
> +			*equal = '\0';
> +		tmp[idx] = '\0';
> +		if (argv[i][strlen(argv[i]) - 1] == 'd')

You can use idx again here:

		if (argv[i][idx + 3] == 'd')

and save from doing the strlen(argv[i]);

idx will point to ':', and + 3 would point to either 'd' or 'D'

-- Steve

>  			ret = snprintf(buf + used, bufsize - used,
>  				       "%s%s+0x0(+0x%zx(%s)):string",
>  				       equal ? tmp : "", equal ? "=" : "",
>  				       offsetof(struct dentry, d_name.name),
>  				       equal ? equal + 1 : tmp);
> -			kfree(tmp);
> -			if (ret >= bufsize - used)
> -				return -ENOMEM;
> -			argv[i] = buf + used;
> -			used += ret + 1;
> -		}
> +		else
> +			ret = snprintf(buf + used, bufsize - used,
> +				       "%s%s+0x0(+0x%zx(+0x%zx(%s))):string",
> +				       equal ? tmp : "", equal ? "=" : "",
> +				       offsetof(struct dentry, d_name.name),
> +				       offsetof(struct file, f_path.dentry),
> +				       equal ? equal + 1 : tmp);
> +		kfree(tmp);
> +		if (ret >= bufsize - used)
> +			return -ENOMEM;
> +		argv[i] = buf + used;
> +		used += ret + 1;
>  	}
>  
>  	return 0;



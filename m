Return-Path: <linux-kernel+bounces-33664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F61836CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520BD1F27C30
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1454F884;
	Mon, 22 Jan 2024 16:11:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76B84F61C;
	Mon, 22 Jan 2024 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939899; cv=none; b=Tiw3fNbmlIH4bRlTizD1+wpMI6RsKk5Vj8QhfF0JXuPc+V/Jrvru+O+KYUx5f/BTHS0FaZbVcvS1Jm6UMphojwZUusV17LG3v4O5RMiMDUKLOiGwoStghwdd7b1DzbrmIOrdWfOc7kf3wsA+DavRmEtqdzNbEwtS6YzHor1KRng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939899; c=relaxed/simple;
	bh=xVjXRbwY8mo3Dvvjl8WT0u2qoQdRoh8qqox2bCQyV7U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7cWa/zfFtciCbNA6RXK1qx6oo12ObfoSdXnM/uKmoDddTmusTSNyB/y2U1f3Rv3PGxi+//Y17NulbyISjPnqhiL+HT8asghpy8g8YRtE6uQKbOIU7FY2zVa+elR4p1G/py05GdwZxCUXXQZr3etv5s/F4fHeCSxTCYysE6YJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88AAC433F1;
	Mon, 22 Jan 2024 16:11:37 +0000 (UTC)
Date: Mon, 22 Jan 2024 11:13:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] tracing/probes: support '%pD' type for print
 struct file's name
Message-ID: <20240122111306.4e0a29ab@gandalf.local.home>
In-Reply-To: <20240122074015.4042575-5-yebin10@huawei.com>
References: <20240122074015.4042575-1-yebin10@huawei.com>
	<20240122074015.4042575-5-yebin10@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 15:40:12 +0800
Ye Bin <yebin10@huawei.com> wrote:

> Similar to '%pD' for printk, use '%pD' for print struct file's name.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  kernel/trace/trace_probe.c | 41 ++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 1599c0c3e6b7..f9819625de58 100644
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
> @@ -1572,28 +1573,38 @@ int traceprobe_expand_dentry_args(int argc, const char *argv[], char *buf,
>  
>  	used = 0;
>  	for (i = 0; i < argc; i++) {
> -		if (str_has_suffix(argv[i], ":%pd")) {
> -			char *tmp = kstrdup(argv[i], GFP_KERNEL);
> -			char *equal;
> +		if (!str_has_suffix(argv[i], ":%pd") &&
> +		    !str_has_suffix(argv[i], ":%pD"))
> +			continue;

And here too:

		if (!str_has_suffix(argv[i], ":%pd", &idx) &&
		    !str_has_suffix(argv[i], ":%pD", &idx))
			continue;


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
> -			tmp[strlen(argv[i]) - 4] = '\0';
> +		equal = strchr(tmp, '=');
> +		if (equal)
> +			*equal = '\0';
> +		tmp[strlen(argv[i]) - 4] = '\0';

		tmp[idx] = '\0';

> +		if (argv[i][strlen(argv[i]) - 1] == 'd')

To avoid another strlen() call.

		if (tmp[idx + 3] == 'd')


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



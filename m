Return-Path: <linux-kernel+bounces-31295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 591F1832BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC315B24B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB90654FBE;
	Fri, 19 Jan 2024 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXRT9MRD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D54554FB0;
	Fri, 19 Jan 2024 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676231; cv=none; b=Mq/aRQ0YJQyuhZfTICHeho0D2m+4te0wIMuC0fHYsPhYepdyzdY73sOS/5IXqfvqAC6tlQwhzG1xf+lkf3hJdsNgRG8q/2RGcNA529cvnIwqLXNZU82QklM9H/4eHbiaY2a1dmGaxRtH6U5jyu5uleyYfYct9cmy5j3qP2BdhtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676231; c=relaxed/simple;
	bh=0+4OncppuBjBS1DVIfYJuQGGGGBFqfj/oxaz1paaCyQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UWi/YHeo2KPfh/rICxSPTprWuc3zopQOtCbUxWEM0WPrdUbWxORxUHV6hPhr2xqee9vJnP28kEn85z7jtD3bRwamyN5W/a6idTVEpqTSmir29VM8P7/qkgn19dzffIMxGNdAT97ZW1McocZMcrI16AiX3+Pq0IDp52AhVzmflqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXRT9MRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C39C433C7;
	Fri, 19 Jan 2024 14:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705676230;
	bh=0+4OncppuBjBS1DVIfYJuQGGGGBFqfj/oxaz1paaCyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QXRT9MRDy4dwtum2pdDyfttpjOhV+jaVO+YRpimt8H7Uu/VnpsEzWFFizHIz9K20b
	 gX79Xd4wDztLkTQxv3+MYHsmHfUFbiDYlMjryPsFSu9ZCtJFJbyki6ABESpIdQWA46
	 4XwBbGk+B1LwFC11+eCEBVbQHq10zQ9HzbTopW2K7Egq+ZBlV2Pk6wF53SGKVKmzgf
	 xpSa9NZUe0gR73S29Tff6ducCusnn53LBHS0TZ05ojq9fqXTu8cZhLgk8BBjwCZpmG
	 kBKj2zdqvmoILKR5bpi6LxpaFOOy4cUEc+ZuXywlrqqRoAGZ6fBmfn+lnMeAVoVPY8
	 aW+dNFttzTXAQ==
Date: Fri, 19 Jan 2024 23:57:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] tracing/probes: support '%pd' type for print struct
 dentry's name
Message-Id: <20240119235706.65ff7f6c9a7a6ad8a79934af@kernel.org>
In-Reply-To: <20240119013848.3111364-2-yebin10@huawei.com>
References: <20240119013848.3111364-1-yebin10@huawei.com>
	<20240119013848.3111364-2-yebin10@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 09:38:46 +0800
Ye Bin <yebin10@huawei.com> wrote:

> Similar to '%pd' for printk, use 'pd' for print struct dentry's name.

No, please use '%pd' as a type instead.

> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  kernel/trace/trace_probe.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 4dc74d73fc1d..460f98b85b1c 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -11,6 +11,7 @@
>   */
>  #define pr_fmt(fmt)	"trace_probe: " fmt
>  
> +#include <linux/dcache.h>
>  #include <linux/bpf.h>
>  #include "trace_btf.h"
>  
> @@ -86,6 +87,8 @@ static const struct fetch_type probe_fetch_types[] = {
>  			    "__data_loc char[]"),
>  	__ASSIGN_FETCH_TYPE("symstr", string, string, sizeof(u32), 1, 1,
>  			    "__data_loc char[]"),
> +	__ASSIGN_FETCH_TYPE("pd", string, string, sizeof(u32), 1, 1,
> +			    "__data_loc char[]"),

And you don't need to add a new type.
Similar to the preprocessor macro, this should be done before parsing the
args. See traceprobe_expand_meta_args(), you can scan the args and search
argument end with ':%pd'. If you find that, you can replace it with 
"+0x%lx(%s):string". Then, you don't need any of these complex fetch type.

Thank you,

>  	/* Basic types */
>  	ASSIGN_FETCH_TYPE(u8,  u8,  0),
>  	ASSIGN_FETCH_TYPE(u16, u16, 0),
> @@ -1090,6 +1093,25 @@ static int __parse_bitfield_probe_arg(const char *bf,
>  	return (BYTES_TO_BITS(t->size) < (bw + bo)) ? -EINVAL : 0;
>  }
>  
> +static char* traceprobe_expand_dentry(const char *argv)
> +{
> +	#define DENTRY_EXPAND_LEN 7  /* +0xXX() */
> +	char *new_argv;
> +	int len = strlen(argv) + 1 + DENTRY_EXPAND_LEN;
> +
> +	new_argv = kmalloc(len, GFP_KERNEL);
> +	if (!new_argv)
> +		return NULL;
> +
> +	if (snprintf(new_argv, len, "+0x%lx(%s)",
> +		     offsetof(struct dentry, d_name.name), argv) >= len) {
> +		kfree(new_argv);
> +		return NULL;
> +	}
> +
> +	return new_argv;
> +}
> +
>  /* String length checking wrapper */
>  static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
>  					   struct probe_arg *parg,
> @@ -1099,6 +1121,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
>  	char *t, *t2, *t3;
>  	int ret, len;
>  	char *arg;
> +	char *org_arg = NULL;
>  
>  	arg = kstrdup(argv, GFP_KERNEL);
>  	if (!arg)
> @@ -1182,6 +1205,16 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
>  			 parg->count);
>  	}
>  
> +	if (!strcmp("pd", parg->type->name)) {
> +		char *temp;
> +
> +		temp = traceprobe_expand_dentry(arg);
> +		if (!temp)
> +			goto out;
> +		org_arg = arg;
> +		arg = temp;
> +	}
> +
>  	code = tmp = kcalloc(FETCH_INSN_MAX, sizeof(*code), GFP_KERNEL);
>  	if (!code)
>  		goto out;
> @@ -1243,6 +1276,10 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
>  				goto fail;
>  			}
>  		}
> +
> +		if (!strcmp(parg->type->name, "pd"))
> +			code++;
> +
>  		/* If op == DEREF, replace it with STRING */
>  		if (!strcmp(parg->type->name, "ustring") ||
>  		    code->op == FETCH_OP_UDEREF)
> @@ -1321,6 +1358,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
>  	kfree(tmp);
>  out:
>  	kfree(arg);
> +	kfree(org_arg);
>  
>  	return ret;
>  }
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


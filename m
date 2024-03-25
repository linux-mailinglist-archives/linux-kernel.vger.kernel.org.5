Return-Path: <linux-kernel+bounces-116360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C72889601
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5447C1C2FC01
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A959171E56;
	Mon, 25 Mar 2024 04:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZI8QGt9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49DF71737;
	Mon, 25 Mar 2024 00:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711327257; cv=none; b=taCD/3kSIqNdP8wX4qt0XxfD5KH+8T1tnAby5ONCFYmmgIMUAxp1WTPXLhzGsV/DrY/JaZPlGsfqBxIaE22xAiSeBJ0G6H3P+g4Lj7eUwtfWrGuiDiqVLI3YPFBr9sWFQ/YWNaXv2GlWDsm4hW01oLq1xKu8gU8yr27aaIDz9dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711327257; c=relaxed/simple;
	bh=M/L5Chgaoc5SzuW+iGXB04VvB40IqnED9oCYtkTnsWE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZWH4kOIzJQC7fzK6pXpXy6kb3PmokKOcbky/bYBXBpdeInHnnHRFgDKCIQX3doIPV4L5W9om06qTFQqGJadp6J0XZrVlGqozq03PaHsHp0J2/KVtbMOPizlBZTZVy9AY4cwqw5y38Oppd4HStQzMBsOQmnvFZojCtGcC3e/VMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZI8QGt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56CBC433F1;
	Mon, 25 Mar 2024 00:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711327257;
	bh=M/L5Chgaoc5SzuW+iGXB04VvB40IqnED9oCYtkTnsWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PZI8QGt9M1Tw63EfjuVeN5MNpzbW3RiBZ7xs9MqJ+Um+vgge6CGYV6PgV2opUMBUY
	 IW8ylyljlbrKID5IWc4tDOJvaEE28wZRsJiFfwD8/u8UItAGmBq6i06cSuBe675AzE
	 AsxPnulwHpAooPgsZpBLTeSh20fqU39hkcj5aC4ZkCeAjDMpmH7ZwGDBhY+yk/ShlJ
	 IUPwlWSIEZjz0V9K4oWCue9IFdj3Sk60xNl83gdYMnjqgjXoQR6gXLn5u3y5cjDGxv
	 Ny8zVsHMs7S4ey/HKeSF1rHg9hEPt024FLS+0hSQkly85WjGMBw1KUt4ia/oocWEpr
	 lSuvgwGUVZnbA==
Date: Mon, 25 Mar 2024 09:40:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/5] tracing/probes: support '%pD' type for print
 struct file's name
Message-Id: <20240325094053.69865c5d6399b2b38cf6b424@kernel.org>
In-Reply-To: <20240322064308.284457-3-yebin10@huawei.com>
References: <20240322064308.284457-1-yebin10@huawei.com>
	<20240322064308.284457-3-yebin10@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 14:43:05 +0800
Ye Bin <yebin10@huawei.com> wrote:

> As like previous patch, this patch support print type '%pD' for print file's

nit: Note that "previous patch" is obscure after it is merged with other patches
in other trees/branches. So it should be "As like %pd".

Anyway, let me change it.

Thank you,


> name. For example "name=$arg1:%pD" casts the `$arg1` as (struct file*),
> dereferences the "file.f_path.dentry.d_name.name" field and stores it to
> "name" argument as a kernel string.
> Here is an example:
> [tracing]# echo 'p:testprobe vfs_read name=$arg1:%pD' > kprobe_event
> [tracing]# echo 1 > events/kprobes/testprobe/enable
> [tracing]# grep -q "1" events/kprobes/testprobe/enable
> [tracing]# echo 0 > events/kprobes/testprobe/enable
> [tracing]# grep "vfs_read" trace | grep "enable"
>             grep-15108   [003] .....  5228.328609: testprobe: (vfs_read+0x4/0xbb0) name="enable"
> 
> Note that this expects the given argument (e.g. $arg1) is an address of struct
> file. User must ensure it.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  kernel/trace/trace.c       |  2 +-
>  kernel/trace/trace_probe.c | 57 +++++++++++++++++++++++---------------
>  2 files changed, 36 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index ac26b8446337..831dfd0773a4 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5510,7 +5510,7 @@ static const char readme_msg[] =
>  	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
>  	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, char, string, symbol,\n"
>  	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
> -	"\t           symstr, %pd, <type>\\[<array-size>\\]\n"
> +	"\t           symstr, %pd/%pD, <type>\\[<array-size>\\]\n"
>  #ifdef CONFIG_HIST_TRIGGERS
>  	"\t    field: <stype> <name>;\n"
>  	"\t    stype: u8/u16/u32/u64, s8/s16/s32/s64, pid_t,\n"
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index a27567e16c36..7bfc6c0d5436 100644
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
> @@ -1581,35 +1582,47 @@ int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf)
>  
>  	used = 0;
>  	for (i = 0; i < argc; i++) {
> -		if (glob_match("*:%pd", argv[i])) {
> -			char *tmp;
> -			char *equal;
> -
> -			if (!tmpbuf) {
> -				tmpbuf = kmalloc(bufsize, GFP_KERNEL);
> -				if (!tmpbuf)
> -					return -ENOMEM;
> -			}
> +		char *tmp;
> +		char *equal;
> +		size_t arg_len;
>  
> -			tmp = kstrdup(argv[i], GFP_KERNEL);
> -			if (!tmp)
> -				goto nomem;
> +		if (!glob_match("*:%p[dD]", argv[i]))
> +			continue;
>  
> -			equal = strchr(tmp, '=');
> -			if (equal)
> -				*equal = '\0';
> -			tmp[strlen(argv[i]) - 4] = '\0';
> +		if (!tmpbuf) {
> +			tmpbuf = kmalloc(bufsize, GFP_KERNEL);
> +			if (!tmpbuf)
> +				return -ENOMEM;
> +		}
> +
> +		tmp = kstrdup(argv[i], GFP_KERNEL);
> +		if (!tmp)
> +			goto nomem;
> +
> +		equal = strchr(tmp, '=');
> +		if (equal)
> +			*equal = '\0';
> +		arg_len = strlen(argv[i]);
> +		tmp[arg_len - 4] = '\0';
> +		if (argv[i][arg_len - 1] == 'd')
>  			ret = snprintf(tmpbuf + used, bufsize - used,
>  				       "%s%s+0x0(+0x%zx(%s)):string",
>  				       equal ? tmp : "", equal ? "=" : "",
>  				       offsetof(struct dentry, d_name.name),
>  				       equal ? equal + 1 : tmp);
> -			kfree(tmp);
> -			if (ret >= bufsize - used)
> -				goto nomem;
> -			argv[i] = tmpbuf + used;
> -			used += ret + 1;
> -		}
> +		else
> +			ret = snprintf(tmpbuf + used, bufsize - used,
> +				       "%s%s+0x0(+0x%zx(+0x%zx(%s))):string",
> +				       equal ? tmp : "", equal ? "=" : "",
> +				       offsetof(struct dentry, d_name.name),
> +				       offsetof(struct file, f_path.dentry),
> +				       equal ? equal + 1 : tmp);
> +
> +		kfree(tmp);
> +		if (ret >= bufsize - used)
> +			goto nomem;
> +		argv[i] = tmpbuf + used;
> +		used += ret + 1;
>  	}
>  
>  	*buf = tmpbuf;
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


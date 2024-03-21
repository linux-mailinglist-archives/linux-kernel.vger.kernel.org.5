Return-Path: <linux-kernel+bounces-110128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEFC885A70
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E241C20FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC7784FD4;
	Thu, 21 Mar 2024 14:13:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B641C84A5A;
	Thu, 21 Mar 2024 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711030401; cv=none; b=L7F4efJwQvybyLQ1o+SrZr/4equKZXMmBzPFrAriG3f9Fc50/gCEKEov31lNjgQ2udI4HZqebkpPNcKoE8VtvBQoljliNb200rk5GLzZHsVpBvnBGfhEBes3RuMsw3NnbqeLCq5LhpULfWew2jvGUmF7ljtKO3VyIb93EyYtni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711030401; c=relaxed/simple;
	bh=5XWZpp84Md97q2RdzbDfViuKErGJMi5GiaAplCQD0Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bt52+XgTUbDrSR8Zpep1RhePhKjgltUtwPGx1z/bAwoU6XTxfy4JoETA3sWfEloryxdKbYOGJ9MiOM22zPWqRKDArlZ4eO2813WoElrgUpvIJ1SsiC3yT69IjcdiRNPfYs1VoHrhccZNiu4tANxjdyd5l5DRY+vg4hpV+v3qJlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3547C433F1;
	Thu, 21 Mar 2024 14:13:20 +0000 (UTC)
Date: Thu, 21 Mar 2024 10:15:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/5] tracing/probes: support '%pd' type for print
 struct dentry's name
Message-ID: <20240321101547.1f4e68ab@gandalf.local.home>
In-Reply-To: <20240320132924.2802187-2-yebin10@huawei.com>
References: <20240320132924.2802187-1-yebin10@huawei.com>
	<20240320132924.2802187-2-yebin10@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 21:29:20 +0800
Ye Bin <yebin10@huawei.com> wrote:

> Support print type '%pd' for print dentry's  name.
> 

The above is not a very detailed change log. A change log should state not
only what the change is doing, but also why.

Having examples of before and after would be useful in the change log.

> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  kernel/trace/trace.c        |  2 +-
>  kernel/trace/trace_fprobe.c |  6 +++++
>  kernel/trace/trace_kprobe.c |  6 +++++
>  kernel/trace/trace_probe.c  | 50 +++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_probe.h  |  2 ++
>  5 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index b12f8384a36a..ac26b8446337 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c


> +/* @buf: *buf must be equal to NULL. Caller must to free *buf */
> +int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf)
> +{
> +	int i, used, ret;
> +	const int bufsize = MAX_DENTRY_ARGS_LEN;
> +	char *tmpbuf = NULL;
> +
> +	if (*buf)
> +		return -EINVAL;
> +
> +	used = 0;
> +	for (i = 0; i < argc; i++) {
> +		if (glob_match("*:%pd", argv[i])) {
> +			char *tmp;
> +			char *equal;
> +
> +			if (!tmpbuf) {
> +				tmpbuf = kmalloc(bufsize, GFP_KERNEL);
> +				if (!tmpbuf)
> +					return -ENOMEM;
> +			}
> +
> +			tmp = kstrdup(argv[i], GFP_KERNEL);
> +			if (!tmp)
> +				goto nomem;
> +
> +			equal = strchr(tmp, '=');
> +			if (equal)
> +				*equal = '\0';
> +			tmp[strlen(argv[i]) - 4] = '\0';
> +			ret = snprintf(tmpbuf + used, bufsize - used,
> +				       "%s%s+0x0(+0x%zx(%s)):string",
> +				       equal ? tmp : "", equal ? "=" : "",
> +				       offsetof(struct dentry, d_name.name),
> +				       equal ? equal + 1 : tmp);

What would be really useful is if we had a way to expose BTF here. Something like:

 "%pB:<struct>:<field>"

The "%pB" would mean to look up the struct/field offsets and types via BTF,
and create the appropriate command to find and print it.

That would be much more flexible and useful as it would allow reading any
field from any structure without having to use gdb.

-- Steve


> +			kfree(tmp);
> +			if (ret >= bufsize - used)
> +				goto nomem;
> +			argv[i] = tmpbuf + used;
> +			used += ret + 1;
> +		}
> +	}
> +
> +	*buf = tmpbuf;
> +	return 0;
> +nomem:
> +	kfree(tmpbuf);
> +	return -ENOMEM;
> +}


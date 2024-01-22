Return-Path: <linux-kernel+bounces-33659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCBF836CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FD21F272E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4E24E1D1;
	Mon, 22 Jan 2024 16:07:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DFD3EA85;
	Mon, 22 Jan 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939643; cv=none; b=pxKpJFxMGmnwaxYq2MHfbWqVUXpt8OU7I6jC3IsOBqAVulJmotJCjGoPNXJQmQKU4j6Bim223BtcDucL0Qi9jc34N1/fqJpTLSzl0argAp9dYSGuTK2MGeXaEpWkA7xOEBBC8JHu5DPDP4e2wt6Rju4yAD2wYtySO3Mbe8quaUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939643; c=relaxed/simple;
	bh=Y0YnSaZ7rJJoYHHQKixkCTtvD+62+VNE4Ysym1ByEns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHABAz5PoBr4BEurcx+ljmp5HVrimzmD4pI+/N0XY04fqBlqzwOZuqKuQ7J2MSXvLXSgKVE3lw03w4sMbts3bI8mcBYu+FDnHYibf9x41Jmoe1uUa4oW5hYaNyRP4wgZcvbpEaJ2EFdydbfSFu3H3rUGzoNoIJ/E8Wsdkih7wJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFA5C433F1;
	Mon, 22 Jan 2024 16:07:22 +0000 (UTC)
Date: Mon, 22 Jan 2024 11:08:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] tracing/probes: add
 traceprobe_expand_dentry_args() helper
Message-ID: <20240122110850.4978f510@gandalf.local.home>
In-Reply-To: <20240122074015.4042575-3-yebin10@huawei.com>
References: <20240122074015.4042575-1-yebin10@huawei.com>
	<20240122074015.4042575-3-yebin10@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 15:40:10 +0800
Ye Bin <yebin10@huawei.com> wrote:

> Add traceprobe_expand_dentry_args() to expand dentry args. this API is
> prepare to support "%pd" print format for kprobe.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  kernel/trace/trace_probe.c | 34 ++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_probe.h |  2 ++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 4dc74d73fc1d..1599c0c3e6b7 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1565,6 +1565,40 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
>  	return ERR_PTR(ret);
>  }
>  
> +int traceprobe_expand_dentry_args(int argc, const char *argv[], char *buf,
> +				  int bufsize)
> +{
> +	int i, used, ret;

	size_t idx;

> +
> +	used = 0;
> +	for (i = 0; i < argc; i++) {
> +		if (str_has_suffix(argv[i], ":%pd")) {

If we were to update str_has_suffix() as I said in my reply to the previous
patch, then we could do:

		if (str_has_suffix(argv[i], ":%pd", &idx) {

> +			char *tmp = kstrdup(argv[i], GFP_KERNEL);
> +			char *equal;
> +
> +			if (!tmp)
> +				return -ENOMEM;
> +
> +			equal = strchr(tmp, '=');
> +			if (equal)
> +				*equal = '\0';
> +			tmp[strlen(argv[i]) - 4] = '\0';

			tmp[idx] = '\0';

-- Steve

> +			ret = snprintf(buf + used, bufsize - used,
> +				       "%s%s+0x0(+0x%zx(%s)):string",
> +				       equal ? tmp : "", equal ? "=" : "",
> +				       offsetof(struct dentry, d_name.name),
> +				       equal ? equal + 1 : tmp);
> +			kfree(tmp);
> +			if (ret >= bufsize - used)
> +				return -ENOMEM;
> +			argv[i] = buf + used;
> +			used += ret + 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  void traceprobe_finish_parse(struct traceprobe_parse_context *ctx)
>  {
>  	clear_btf_context(ctx);
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 850d9ecb6765..553371a4e0b1 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -402,6 +402,8 @@ extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
>  const char **traceprobe_expand_meta_args(int argc, const char *argv[],
>  					 int *new_argc, char *buf, int bufsize,
>  					 struct traceprobe_parse_context *ctx);
> +extern int traceprobe_expand_dentry_args(int argc, const char *argv[], char *buf,
> +					 int bufsize);
>  
>  extern int traceprobe_update_arg(struct probe_arg *arg);
>  extern void traceprobe_free_probe_arg(struct probe_arg *arg);



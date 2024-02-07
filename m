Return-Path: <linux-kernel+bounces-56625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E87D84CCCA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE8D1F22D8B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BEB7E592;
	Wed,  7 Feb 2024 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eu++iotz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FB57CF16;
	Wed,  7 Feb 2024 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316319; cv=none; b=mSk/Q5dDet+MrRf8/Q0n+NdXctrc5P+4Sclr99s/hmchVDuGxe/81hc7gNU9XyEqxPz7fh/Z0jJbup9h4LfYN4Mt2hmRBXjS6wqKZY46bBiW9maFzMohEG+fQdeRsmWe7h19F4hKbFC1qJM07nKWV7zm8V1d+HL5QcS43ICDgDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316319; c=relaxed/simple;
	bh=BruKfoYyY7uGBswpNK7x1dXk12it/S1keDjlolw+HpU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JV/0227xtqVbb1I9mipmfZNdyHp8VnLi7/JY+0lOV4+B4oCU+HIesi+mSWRFqVpSt9qBG3R0P82IkQuTiYM50S41kJ6hmoqF+slXEF+Cu7OK7omMMtKClg6AhBm698pr7SFSKq67Z22JjPCF57XJwFDxa2EQie40n9S8jsCuJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eu++iotz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA4DC433F1;
	Wed,  7 Feb 2024 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707316318;
	bh=BruKfoYyY7uGBswpNK7x1dXk12it/S1keDjlolw+HpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eu++iotzh8ZoOsnE5oECtw795jbt/pfDppxw/tQsMA37shxl6kw2q8zbKFIhBmCdi
	 rwFs13SfMyjorG1j0sSL8ddw7Wd4+vlxpPVucvXTUwCaJ036lyXHGr92IstO+pq2Kf
	 VhUAgxBkYzzXG4YXCU37DsebfL4jVHoUvw9WEwSXplAoKiE2qz1R0Xy8tjZK/1Dj+f
	 S8S/GW6rajbU7mjPXlXj05p8fOCu531kavN3jTY2pe9g1H7gk1P8mE2Rq97/mgCO2p
	 azmf+6ATsW0VAYJqrgkXWQopy0Ihzkl7HBtVl9zb6GjW1eJMIfmSPYEc0rNLXHMcLI
	 ek4WFiD0ffxvA==
Date: Wed, 7 Feb 2024 23:31:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/8] tracing/probes: support '%pd/%pD' type for
 fprobe
Message-Id: <20240207233154.cd38fd0bf4891d66807c4ed9@kernel.org>
In-Reply-To: <20240125073923.2252057-5-yebin10@huawei.com>
References: <20240125073923.2252057-1-yebin10@huawei.com>
	<20240125073923.2252057-5-yebin10@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 15:39:19 +0800
Ye Bin <yebin10@huawei.com> wrote:

> Support print type '%pd/%pD' for print dentry's or file's name.
> 

nit: Looks good to me. but the patch ordering seems a bit strange.
This should be next to [2/8].

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  kernel/trace/trace_fprobe.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index 7d2ddbcfa377..988d68e906ad 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -976,6 +976,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  	char gbuf[MAX_EVENT_NAME_LEN];
>  	char sbuf[KSYM_NAME_LEN];
>  	char abuf[MAX_BTF_ARGS_LEN];
> +	char *dbuf = NULL;
>  	bool is_tracepoint = false;
>  	struct tracepoint *tpoint = NULL;
>  	struct traceprobe_parse_context ctx = {
> @@ -1086,6 +1087,10 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  		argv = new_argv;
>  	}
>  
> +	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
> +	if (ret)
> +		goto out;
> +
>  	/* setup a probe */
>  	tf = alloc_trace_fprobe(group, event, symbol, tpoint, maxactive,
>  				argc, is_return);
> @@ -1131,6 +1136,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  	trace_probe_log_clear();
>  	kfree(new_argv);
>  	kfree(symbol);
> +	kfree(dbuf);
>  	return ret;
>  
>  parse_error:
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


Return-Path: <linux-kernel+bounces-40387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B08583DF59
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB99428D8B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BD91DFFC;
	Fri, 26 Jan 2024 16:58:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5C06AB8;
	Fri, 26 Jan 2024 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706288335; cv=none; b=j73BI82G7WlZxPP1H8rUd88HMdbk5dgZ2f4fhTQn9Z2wGjqKytoQuAfPRNrwzNtsGnnmoyRz0NUNQa9owv2bfl6nCcNTMO+IMmOPuQrJkZyBg6tOdH639eiNyq+ExrfYtqbGn01yRNak/yqHiWNb5JfmBa6LumnqKv7vOrQ43ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706288335; c=relaxed/simple;
	bh=tGTdIK79gYWJVyCe3WNR9g7OUuQ+QOfQOES6vlTFBz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8Fn7096tcSMQp/pEGQWLRjEqlVrRbJuiW1zWM1veJxba93LWh2tcoVjoZ4kUnqDitpW+RXCcKUqZX3IvfAFV03zSKNhSdhnix1+0rAtPmBke2q7Z7mSpYSvCfvC2e+s5tit+qdYDBJvKJ/mWYsAyP019cxtuZlqE86ZPeOd+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D894FC43394;
	Fri, 26 Jan 2024 16:58:53 +0000 (UTC)
Date: Fri, 26 Jan 2024 11:58:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH] tracing/trigger: Fix to return error if failed to alloc
 snapshot
Message-ID: <20240126115856.2884e889@gandalf.local.home>
In-Reply-To: <170622977792.270660.2789298642759362200.stgit@devnote2>
References: <ZbJ19CF2Zv4d0R_Z@google.com>
	<170622977792.270660.2789298642759362200.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 09:42:58 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix register_snapshot_trigger() to return error code if it failed to
> allocate a snapshot instead of 0 (success). Unless that, it will register
> snapshot trigger without an error.
> 
> Fixes: 0bbe7f719985 ("tracing: Fix the race between registering 'snapshot' event trigger and triggering 'snapshot' operation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks Masami, I'll apply this.

-- Steve

> ---
>  kernel/trace/trace_events_trigger.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 46439e3bcec4..b33c3861fbbb 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1470,8 +1470,10 @@ register_snapshot_trigger(char *glob,
>  			  struct event_trigger_data *data,
>  			  struct trace_event_file *file)
>  {
> -	if (tracing_alloc_snapshot_instance(file->tr) != 0)
> -		return 0;
> +	int ret = tracing_alloc_snapshot_instance(file->tr);
> +
> +	if (ret < 0)
> +		return ret;
>  
>  	return register_trigger(glob, data, file);
>  }



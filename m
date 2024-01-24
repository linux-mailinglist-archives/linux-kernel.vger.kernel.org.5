Return-Path: <linux-kernel+bounces-37222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3F583ACDA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6E81C23D62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FE9604B2;
	Wed, 24 Jan 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW6p4XCR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7BB17562;
	Wed, 24 Jan 2024 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109119; cv=none; b=bD0J18j/pDfEim7PM0OaKm6O6Z3VusD4whdohbB/J6tX9rhoPpbwZOwL1WeU+PCYAUXebdGkRiOE0PcBZDE7bN55+2VvYSbc9IsC8ThYM1UwNNAjY6VaLpdpI5Kh2pixaY4MlB7k0pgWgDVJxjOEKanFNs2LTFX7bOZOL8toWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109119; c=relaxed/simple;
	bh=R89RbMLDlTyyQD/EW+3r2qZaBZKEVWRsol+oOTF+Puo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n3svRxU7sAbjVPgy0RkNyhvW6vt1FJMvr6IwyV++IFrUqFOUVqCXGtpkmig1wg5OKJ99DebJ+Vdkwwp5HAJYFk5108P/3RbzXBUHogRB5ceMhRE4v50SuMcVWl8bXrz9fJU3SeiFlj2YgDEgTo+ilpHJDeCkHya8eT2hGYeTnVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW6p4XCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C012FC433C7;
	Wed, 24 Jan 2024 15:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706109118;
	bh=R89RbMLDlTyyQD/EW+3r2qZaBZKEVWRsol+oOTF+Puo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TW6p4XCR71WvsUtJAPzVLicpm72SL/R5SDZMWmzplbHW8PGdjRxsPF8cg+Js/a5o7
	 XcbOnnGhx0wYlF/N0e/pIBZ1e9oa1NUxRLerZg02RlgAjagm1iQgstlHb/HPQhqwUZ
	 52YDJoRbW0eGJ4LMts9YAfEmKMKN40jAyLbTEs3cTJp2XIRLl4W3WwHXJ9ge36wEJl
	 129d5iuzkYp9geKzVMrJQu7+BOynst7FkaXCrdj/iaIqUkkaV0achD57B+tRQj7S7X
	 +DvOkGiLzmtZScwyN0/Jk+HndIOPtPxxbWdo5bCd1Hsn7pR7g19hyvpwilYfL0oYfc
	 I6sWxyPi0+FIA==
Date: Thu, 25 Jan 2024 00:11:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v12 3/6] tracing: Add snapshot refcount
Message-Id: <20240125001149.364c0b08237e8b7f0a69bd56@kernel.org>
In-Reply-To: <20240123110757.3657908-4-vdonnefort@google.com>
References: <20240123110757.3657908-1-vdonnefort@google.com>
	<20240123110757.3657908-4-vdonnefort@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 11:07:54 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

[...]
> @@ -6592,8 +6641,11 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
>  
>  	if (t->init) {
>  		ret = tracer_init(t, tr);
> -		if (ret)
> +		if (ret) {
> +			if (t->use_max_tr)
> +				tracing_disarm_snapshot_locked(tr);

This part is out of CONFIG_TRACER_MAX_TRACE, so it may cause a compile error
if CONFIG_TRACER_MAX_TRACE is not set.

>  			goto out;
> +		}
>  	}
>  
>  	tr->current_trace = t;
[...]
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 46439e3bcec4..d41bf64741e2 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -597,20 +597,9 @@ static int register_trigger(char *glob,
>  	return ret;
>  }
>  
> -/**
> - * unregister_trigger - Generic event_command @unreg implementation
> - * @glob: The raw string used to register the trigger
> - * @test: Trigger-specific data used to find the trigger to remove
> - * @file: The trace_event_file associated with the event
> - *
> - * Common implementation for event trigger unregistration.
> - *
> - * Usually used directly as the @unreg method in event command
> - * implementations.
> - */
> -static void unregister_trigger(char *glob,
> -			       struct event_trigger_data *test,
> -			       struct trace_event_file *file)

OK, so __unregister_trigger returns true if data exists, but
unregister_trigger() ignores results. (I want some comment here)

> +static bool __unregister_trigger(char *glob,
> +				 struct event_trigger_data *test,
> +				 struct trace_event_file *file)
>  {
>  	struct event_trigger_data *data = NULL, *iter;
>  
> @@ -626,8 +615,32 @@ static void unregister_trigger(char *glob,
>  		}
>  	}
>  
> -	if (data && data->ops->free)
> -		data->ops->free(data);
> +	if (data) {
> +		if (data->ops->free)
> +			data->ops->free(data);
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * unregister_trigger - Generic event_command @unreg implementation
> + * @glob: The raw string used to register the trigger
> + * @test: Trigger-specific data used to find the trigger to remove
> + * @file: The trace_event_file associated with the event
> + *
> + * Common implementation for event trigger unregistration.
> + *
> + * Usually used directly as the @unreg method in event command
> + * implementations.
> + */
> +static void unregister_trigger(char *glob,
> +			       struct event_trigger_data *test,
> +			       struct trace_event_file *file)
> +{
> +	__unregister_trigger(glob, test, file);
>  }
>  
>  /*
> @@ -1470,12 +1483,20 @@ register_snapshot_trigger(char *glob,
>  			  struct event_trigger_data *data,
>  			  struct trace_event_file *file)
>  {
> -	if (tracing_alloc_snapshot_instance(file->tr) != 0)
> +	if (tracing_arm_snapshot(file->tr))
>  		return 0;

BTW, is this return value correct? It seems that the register_*_trigger()
will return error code when it fails.

Thanks,

>  
>  	return register_trigger(glob, data, file);
>  }
>  
> +static void unregister_snapshot_trigger(char *glob,
> +					struct event_trigger_data *data,
> +					struct trace_event_file *file)
> +{
> +	if (__unregister_trigger(glob, data, file))
> +		tracing_disarm_snapshot(file->tr);
> +}
> +
>  static int
>  snapshot_trigger_print(struct seq_file *m, struct event_trigger_data *data)
>  {
> @@ -1508,7 +1529,7 @@ static struct event_command trigger_snapshot_cmd = {
>  	.trigger_type		= ETT_SNAPSHOT,
>  	.parse			= event_trigger_parse,
>  	.reg			= register_snapshot_trigger,
> -	.unreg			= unregister_trigger,
> +	.unreg			= unregister_snapshot_trigger,
>  	.get_trigger_ops	= snapshot_get_trigger_ops,
>  	.set_filter		= set_trigger_filter,
>  };
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


Return-Path: <linux-kernel+bounces-96438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AB9875C17
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42FB282DDF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DEC2263A;
	Fri,  8 Mar 2024 01:48:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3142420B;
	Fri,  8 Mar 2024 01:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709862530; cv=none; b=F8X6ZiHyPQtH1PGGs1xMtgcrsQKdk8HxiIzEMTzuHONvWbc1Wa/SOu4kjTZT+JVSD8Oa24JPFfEpCBtGhvmtbprTBqhFgl/5YJ0UHuvh6WUzCmTsvJo5rmigFTbV9pMlsAvWLyYNMFo6L3IJk39ozn/m/AKrUbPawsRpzRZ1kWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709862530; c=relaxed/simple;
	bh=ofSIEp5CwaZZFkWkQrZ9LK1wrqP7l0qC/vb6L14yvhE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0talkvn9mxUeL4qeX8lbLrT20eHFQlwnVkF0BRIxJyLoTYk3iZ8hWvOYSlTL7+gKI8KravHiU/QqykSEbAtdN2yK+c8rLRJYIrqO+rzzGttUxH/kH9RRefaafZKKOrH+H2jj/JMStVivc5tiPeMTn8m7N9j+ftwLsFIlbpSqnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60945C433C7;
	Fri,  8 Mar 2024 01:48:49 +0000 (UTC)
Date: Thu, 7 Mar 2024 20:50:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kassey Li <quic_yingangl@quicinc.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: add function in event of
 workqueue_activate_work
Message-ID: <20240307205044.1caf9fe2@gandalf.local.home>
In-Reply-To: <20240308010929.1955339-1-quic_yingangl@quicinc.com>
References: <20240308010929.1955339-1-quic_yingangl@quicinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 09:09:29 +0800
Kassey Li <quic_yingangl@quicinc.com> wrote:

> The trace event "workqueue_activate_work" only print work struct.
> However, function is the region of interest in a full sequence of work.
> Current workqueue_activate_work trace event output:
> 
>     workqueue_activate_work: work struct ffffff88b4a0f450
> 
> With this change, workqueue_activate_work will print the function name,
> align with workqueue_queue_work/execute_start/execute_end event.
> 
> checkpatch.pl will report below error for the space:
> 
> 	ERROR: space prohibited after that open parenthesis '('
> 	#28: FILE: include/trace/events/workqueue.h:67:
> 	+               __field( void *,        function)
> 
> 	total: 1 errors, 0 warnings, 16 lines checked
> 
> fix this error.
> 
> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> ---
>  include/trace/events/workqueue.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
> index 262d52021c23..a42c1a293459 100644
> --- a/include/trace/events/workqueue.h
> +++ b/include/trace/events/workqueue.h
> @@ -63,14 +63,16 @@ TRACE_EVENT(workqueue_activate_work,
>  	TP_ARGS(work),
>  
>  	TP_STRUCT__entry(
> -		__field( void *,	work	)
> +		__field(void *,	work)
> +		__field(void *,	function)

Note, please do not follow checkpatch in TRACE_EVENT() macros. It simply
doesn't understand it. The above is supposed to be similar to structure
formatting.

ie:
	struct __entry {
		void		*work;
		void		*function;
	};

	TP_STRUCT__entry(
		__field( void *,	work		)
		__field( void *,	function	)
  	),

That looks much better.

-- Steve


>  
>  	TP_fast_assign(
>  		__entry->work		= work;
> +		__entry->function	= work->func;
>  	),
>  
> -	TP_printk("work struct %p", __entry->work)
> +	TP_printk("work struct %p function=%ps ", __entry->work, __entry->function)
>  );
>  
>  /**



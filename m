Return-Path: <linux-kernel+bounces-100420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF51879745
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37C61F23771
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6884D7C096;
	Tue, 12 Mar 2024 15:16:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026226997A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256582; cv=none; b=WEpxS+3DBQ7EtbDMV/HNad71t5iTNQKQsJlp9md5Cl43XohQJG54b8TfJHMFUtWWlHGHP75mtbjlEf8w14fWmAQWdeTmYBEb1y3dTMfoS4GluQVjOFDjtAh3Rldc6MBJ3bNYn9TjkCzckFR3BNTDRqEDPlBBT54JtR3EUHCjqi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256582; c=relaxed/simple;
	bh=2tcPIVSB5W57B2YzrkJQ5c17vXSl/d0ZRK/bKySpLsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fk983IqVQVjsshNvb2O+QdfTVS15yXPLJLfIP855cfOSy3cLY3KtHnoOF2MMbFWAPdPij9XQd0JiKowoTmUNm1ZrzVdjeUQVQjMOHHTLRJx6NAlBM0XESfK2EqrfSlA9tq5ejbaPDIfu9jVqyKXQUdmhgGz1Q1B9KZOxhGpIz58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B32C433F1;
	Tue, 12 Mar 2024 15:16:20 +0000 (UTC)
Date: Tue, 12 Mar 2024 11:18:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: wenyang.linux@foxmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar
 <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Mel Gorman
 <mgorman@techsingularity.net>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] exit: move trace_sched_process_exit earlier in
 do_exit()
Message-ID: <20240312111826.1b5bec27@gandalf.local.home>
In-Reply-To: <tencent_277EBFCF545587D4FD41EF932AE972CC6708@qq.com>
References: <tencent_277EBFCF545587D4FD41EF932AE972CC6708@qq.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Mar 2024 13:25:29 +0800
wenyang.linux@foxmail.com wrote:

> From: Wen Yang <wenyang.linux@foxmail.com>
> 
> Currently coredump_task_exit() takes some time to wait for the generation
> of the dump file. But if the user-space wants to receive a notification
> as soon as possible it maybe inconvenient.
> 
> Move trace_sched_process_exit() earlier in do_exit().
> This way a user-space monitor could detect the exits and
> potentially make some preparations in advance.
> 
> Oleg initially proposed this suggestion, and Steven further provided some
> detailed suggestions, and Mathieu carefully checked the historical code
> and said:
> : I've checked with Matthew Khouzam (maintainer of Trace Compass)
> : which care about this tracepoint, and we have not identified any
> : significant impact of moving it on its model of the scheduler, other
> : than slightly changing its timing.
> : I've also checked quickly in lttng-analyses and have not found
> : any code that care about its specific placement.
> : So I would say go ahead and move it earlier in do_exit(), it's
> : fine by me.
> 

I'm putting together last minute minor patches for this merge window. I can
take this if nobody has any objections.

-- Steve


> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/exit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 493647fd7c07..2cff6533cb39 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -826,6 +826,7 @@ void __noreturn do_exit(long code)
>  
>  	WARN_ON(tsk->plug);
>  
> +	trace_sched_process_exit(tsk);
>  	kcov_task_exit(tsk);
>  	kmsan_task_exit(tsk);
>  
> @@ -866,7 +867,6 @@ void __noreturn do_exit(long code)
>  
>  	if (group_dead)
>  		acct_process();
> -	trace_sched_process_exit(tsk);
>  
>  	exit_sem(tsk);
>  	exit_shm(tsk);



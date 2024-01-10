Return-Path: <linux-kernel+bounces-22162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A96F829A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49502B2335B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC828482C5;
	Wed, 10 Jan 2024 12:20:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DC53FB07;
	Wed, 10 Jan 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FEA22F4;
	Wed, 10 Jan 2024 04:21:16 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.87.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87AAE3F5A1;
	Wed, 10 Jan 2024 04:20:28 -0800 (PST)
Date: Wed, 10 Jan 2024 12:20:21 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florent Revest <revest@chromium.org>
Subject: Re: [PATCH] ftrace: Fix DIRECT_CALLS to use SAVE_REGS by default
Message-ID: <ZZ6LheR_rC2KrgFu@FVFF77S0Q05N>
References: <170484558617.178953.1590516949390270842.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170484558617.178953.1590516949390270842.stgit@devnote2>

On Wed, Jan 10, 2024 at 09:13:06AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> The commit 60c8971899f3 ("ftrace: Make DIRECT_CALLS work WITH_ARGS
> and !WITH_REGS") changed DIRECT_CALLS to use SAVE_ARGS when there
> are multiple ftrace_ops at the same function, but since the x86 only
> support to jump to direct_call from ftrace_regs_caller, when we set
> the function tracer on the same target function on x86, ftrace-direct
> does not work as below (this actually works on arm64.)
> 
> At first, insmod ftrace-direct.ko to put a direct_call on
> 'wake_up_process()'.
> 
>  # insmod kernel/samples/ftrace/ftrace-direct.ko
>  # less trace
> ...
>           <idle>-0       [006] ..s1.   564.686958: my_direct_func: waking up rcu_preempt-17
>           <idle>-0       [007] ..s1.   564.687836: my_direct_func: waking up kcompactd0-63
>           <idle>-0       [006] ..s1.   564.690926: my_direct_func: waking up rcu_preempt-17
>           <idle>-0       [006] ..s1.   564.696872: my_direct_func: waking up rcu_preempt-17
>           <idle>-0       [007] ..s1.   565.191982: my_direct_func: waking up kcompactd0-63
> 
> Setup a function filter to the 'wake_up_process' too, and enable it.
> 
>  # cd /sys/kernel/tracing/
>  # echo wake_up_process > set_ftrace_filter
>  # echo function > current_tracer
>  # less trace
> ...
>           <idle>-0       [006] ..s3.   686.180972: wake_up_process <-call_timer_fn
>           <idle>-0       [006] ..s3.   686.186919: wake_up_process <-call_timer_fn
>           <idle>-0       [002] ..s3.   686.264049: wake_up_process <-call_timer_fn
>           <idle>-0       [002] d.h6.   686.515216: wake_up_process <-kick_pool
>           <idle>-0       [002] d.h6.   686.691386: wake_up_process <-kick_pool
> 
> Then, only function tracer is shown on x86.
> But if you enable 'kprobe on ftrace' event (which uses SAVE_REGS flag)
> on the same function, it is shown again.
> 
>  # echo 'p wake_up_process' >> dynamic_events
>  # echo 1 > events/kprobes/p_wake_up_process_0/enable
>  # echo > trace
>  # less trace
> ...
>           <idle>-0       [006] ..s2.  2710.345919: p_wake_up_process_0: (wake_up_process+0x4/0x20)
>           <idle>-0       [006] ..s3.  2710.345923: wake_up_process <-call_timer_fn
>           <idle>-0       [006] ..s1.  2710.345928: my_direct_func: waking up rcu_preempt-17
>           <idle>-0       [006] ..s2.  2710.349931: p_wake_up_process_0: (wake_up_process+0x4/0x20)
>           <idle>-0       [006] ..s3.  2710.349934: wake_up_process <-call_timer_fn
>           <idle>-0       [006] ..s1.  2710.349937: my_direct_func: waking up rcu_preempt-17
> 
> To fix this issue, use SAVE_REGS flag for multiple ftrace_ops flag of
> direct_call by default.
> 
> Fixes: 60c8971899f3 ("ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sorry about this; I hadn't realised that x86 only supported direct calls when
SAVE_REGS was requested.

The patch looks good to me. I applied it atop v6.7 and double-checked that this
still works on arm64 as per your examples above, and everything looks good:

# mount -t tracefs none /sys/kernel/tracing/
# insmod ftrace-direct.ko 
# echo wake_up_process > /sys/kernel/tracing/set_ftrace_filter 
# echo function > /sys/kernel/tracing/current_tracer 
# less /sys/kernel/tracing/trace
..	
          <idle>-0       [007] ..s3.   172.932840: wake_up_process <-process_timeout
          <idle>-0       [007] ..s1.   172.932842: my_direct_func: waking up kcompactd0-62
          <idle>-0       [007] ..s3.   173.444836: wake_up_process <-process_timeout
          <idle>-0       [007] ..s1.   173.444838: my_direct_func: waking up kcompactd0-62
          <idle>-0       [001] d.h5.   173.471116: wake_up_process <-kick_pool
          <idle>-0       [001] d.h3.   173.471118: my_direct_func: waking up kworker/1:1-58

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]

Thanks,
Mark.

> ---
>  kernel/trace/ftrace.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index b01ae7d36021..c060d5b47910 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5325,7 +5325,17 @@ static LIST_HEAD(ftrace_direct_funcs);
>  
>  static int register_ftrace_function_nolock(struct ftrace_ops *ops);
>  
> +/*
> + * If there are multiple ftrace_ops, use SAVE_REGS by default, so that direct
> + * call will be jumped from ftrace_regs_caller. Only if the architecture does
> + * not support ftrace_regs_caller but direct_call, use SAVE_ARGS so that it
> + * jumps from ftrace_caller for multiple ftrace_ops.
> + */
> +#ifndef HAVE_DYNAMIC_FTRACE_WITH_REGS
>  #define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_ARGS)
> +#else
> +#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS)
> +#endif
>  
>  static int check_direct_multi(struct ftrace_ops *ops)
>  {
> 


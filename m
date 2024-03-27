Return-Path: <linux-kernel+bounces-121427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0346588E7C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970371F3402A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491181474B0;
	Wed, 27 Mar 2024 14:23:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D0614535D;
	Wed, 27 Mar 2024 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549434; cv=none; b=ngNwIiSdRROELj3XeEw5m0RtVeMsR+MWkrI/7alHmjRIm8NQ6aAFnhkrcr4FoZGnMutbKHq4+K4EkuqLg1ayf56IOQl4ZBf7qmt3gOu89aR8ELn/AR/U7vIy3h7ZLiL3YmUbT9ki0nDNoqLzElGxTB2pGM9tzrMmW4sHRDeNcQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549434; c=relaxed/simple;
	bh=BmZ4SjxSQBnkpuUFtgR3wQXxh1obJ6n5r0ucuS+Wj4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMilRaZRvlDVdNTUS4PBRb6kVK9YaZJw7FU98e/AntXHg7mp3CHt+isYZ1vPsZSTf20bZ776bpLK4BuozlIvKzM5nXYTNQP00LLfsHlbzSPTrzjkOrhH0uG3jloOo3M9GZJwMOa5Fu4mOw9gpKIMhlCuQdpFHHtpjJ3liFc5prM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8748DC433F1;
	Wed, 27 Mar 2024 14:23:53 +0000 (UTC)
Date: Wed, 27 Mar 2024 10:26:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tio Zhang <tiozhang@didiglobal.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <zyhtheonly@yeah.net>,
 <zyhtheonly@gmail.com>
Subject: Re: [PATCH] trace/sched: add tgid for sched_wakeup_template
Message-ID: <20240327102634.17013392@gandalf.local.home>
In-Reply-To: <20240327084948.GA28114@didi-ThinkCentre-M930t-N000>
References: <20240327084948.GA28114@didi-ThinkCentre-M930t-N000>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 16:50:57 +0800
Tio Zhang <tiozhang@didiglobal.com> wrote:

> By doing this, we are able to filter tasks by tgid while we are
> tracing wakeup events by ebpf or other methods.
> 
> For example, when we care about tracing a user space process (which has
> uncertain number of LWPs, i.e, pids) to monitor its wakeup latency,
> without tgid available in sched_wakeup tracepoints, we would struggle
> finding out all pids to trace, or we could use kprobe to achieve tgid
> tracing, which is less accurate and much less efficient than using
> tracepoint.

This is a very common trace event, and I really do not want to add more
data than necessary to it, as it increases the size of the event which
means less events can be recorded on a fixed size trace ring buffer.

Note, you are not modifying the "tracepoint", but you are actually
modifying a "trace event".

 "tracepoint" is the hook in the kernel code:

   trace_sched_wakeup()

 "trace event" is defined by TRACE_EVENT() macro (and friends) that defines
     what is exposed in the tracefs file system.

I thought ebpf could hook directly to the tracepoint which is:

	trace_sched_wakeup(p);

I believe you can have direct access to the 'p' before it is processed from ebpf.

There's also "trace probes" (I think we are lacking documentation on this,
as well as event probes :-p):

 $ gdb vmlinux
(gdb) p &((struct task_struct *)0)->tgid
$1 = (pid_t *) 0x56c
(gdb) p &((struct task_struct *)0)->pid
$2 = (pid_t *) 0x568

 # echo 't:wakeup sched_waking pid=+0x568($arg1):u32 tgid=+0x56c($arg1):u32' > /sys/kernel/tracing/dynamic_events

 # trace-cmd start -e wakeup
 # trace-cmd show
       trace-cmd-7307    [003] d..6. 599486.485762: wakeup: (__probestub_sched_waking+0x4/0x10) pid=845 tgid=845
            bash-845     [001] d.s4. 599486.486136: wakeup: (__probestub_sched_waking+0x4/0x10) pid=17 tgid=17
            bash-845     [001] d..4. 599486.486336: wakeup: (__probestub_sched_waking+0x4/0x10) pid=5516 tgid=5516
   kworker/u18:2-5516    [001] d..4. 599486.486445: wakeup: (__probestub_sched_waking+0x4/0x10) pid=818 tgid=818
          <idle>-0       [001] d.s4. 599486.491206: wakeup: (__probestub_sched_waking+0x4/0x10) pid=17 tgid=17
          <idle>-0       [001] d.s5. 599486.493218: wakeup: (__probestub_sched_waking+0x4/0x10) pid=17 tgid=17
          <idle>-0       [001] d.s4. 599486.497200: wakeup: (__probestub_sched_waking+0x4/0x10) pid=17 tgid=17
          <idle>-0       [003] d.s4. 599486.829209: wakeup: (__probestub_sched_waking+0x4/0x10) pid=70 tgid=70

The above attaches to the tracepoint and $arg1 is the 'struct task_struct *p'.

-- Steve


> 
> Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
> Signed-off-by: Dylane Chen <dylanechen@didiglobal.com>
> ---
>  include/trace/events/sched.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index dbb01b4b7451..ea7e525649e5 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -149,6 +149,7 @@ DECLARE_EVENT_CLASS(sched_wakeup_template,
>  		__field(	pid_t,	pid			)
>  		__field(	int,	prio			)
>  		__field(	int,	target_cpu		)
> +		__field(	pid_t,	tgid			)
>  	),
>  
>  	TP_fast_assign(
> @@ -156,11 +157,12 @@ DECLARE_EVENT_CLASS(sched_wakeup_template,
>  		__entry->pid		= p->pid;
>  		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
>  		__entry->target_cpu	= task_cpu(p);
> +		__entry->tgid		= p->tgid;
>  	),
>  
> -	TP_printk("comm=%s pid=%d prio=%d target_cpu=%03d",
> +	TP_printk("comm=%s pid=%d prio=%d target_cpu=%03d tgid=%d",
>  		  __entry->comm, __entry->pid, __entry->prio,
> -		  __entry->target_cpu)
> +		  __entry->target_cpu, __entry->tgid)
>  );
>  
>  /*



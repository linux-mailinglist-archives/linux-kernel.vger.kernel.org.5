Return-Path: <linux-kernel+bounces-76875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AABA85FDFF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1181C25765
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637821534F7;
	Thu, 22 Feb 2024 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="U380Pm1Q"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5A9151CF3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619149; cv=none; b=NWvXW80lFWKdzWQ7ZYc+CGA1905OKcN3UDwtcbgcvpxDqIPQLcmNifSUI8ek2xXEyWFvfhbZP9obodGn/0Qcda61LFtDWGIasVzfy0e0O/vhJm4ToTl/6q9/BhATzsYiAlA3YHwp3+3SspY3CqIpgmBSPZB15w5/1azbvWsUZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619149; c=relaxed/simple;
	bh=xI8c7R5FVGAN8wMc43qy4e84ldQjvtEyCbHUZkIpLIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWadUo9FavauwqMcHA6zZdgDQisWEwIJQnOXVBThOi+WbrnvxrE5fshecBXDudQvw9lNNJFu111C9XI2NngzquXXkTg0Ae8Cta6HMd8TeZhQNMtcqPbXewAx8XGWnoPb8h29HyvID86joRiYVxZLWAA7PmBCMh9HbIcFZ5Y421g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=U380Pm1Q; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1708619137;
	bh=xI8c7R5FVGAN8wMc43qy4e84ldQjvtEyCbHUZkIpLIU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U380Pm1Q6KPMQNXOd51fT6xFpNJ2kPyBc5J9yYeWnOvCr8lexvxAozkD65j/w9CHw
	 Z4BgxLFI7tuSISraqJtwhoA2LOod7y7By2eqFS/o8b5v/OO8MXHXpD3F+ocbWULJOD
	 GQ99vF4e2dH5pN85X+PeKSlzKisaMCSO37xiCg5L0/aQqcT3XzqXPE+UG/UD9hCBfI
	 D9YucIRUvZQFBLsv0v9JLrMLyh7vbVOhmjLqIeTYlA2Y3kuWKAGQwgjr95Xio0+M0b
	 zKVgfUf8ouryxnIg71qbPaq5LzxSKtTjZuqvaXprYvqqcdWVbcQGjbNN07uRBR1ZpU
	 TqACuGkL1BVhQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TgdmK1WQKzdPk;
	Thu, 22 Feb 2024 11:25:37 -0500 (EST)
Message-ID: <c411eda5-5378-4511-bea3-d1566174c8c7@efficios.com>
Date: Thu, 22 Feb 2024 11:25:36 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] exit: add a tracepoint for profiling a task that is
 starting to exit
Content-Language: en-US
To: wenyang.linux@foxmail.com, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Mel Gorman
 <mgorman@techsingularity.net>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org
References: <tencent_09CF49556CD442411A93D0E92ACC2B7E5D08@qq.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <tencent_09CF49556CD442411A93D0E92ACC2B7E5D08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-22 11:04, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
> 
> Currently coredump_task_exit() takes some time to wait for the generation
> of the dump file. But if the user-space wants to receive a notification
> as soon as possible it maybe inconvenient.
> 
> Commit 2d4bcf886e42 ("exit: Remove profile_task_exit & profile_munmap")
> simplified the code, but also removed profile_task_exit(), which may
> prevent third-party kernel modules from detecting process exits timely.
> 
> Add the new trace_sched_profile_task_exit() this way a user-space monitor
> could detect the exits and potentially make some preparations in advance.

I don't see any explanation justifying adding an extra tracepoint
rather than just moving trace_sched_process_exit() earlier in do_exit().

Why is moving trace_sched_process_exit() earlier in do_exit() an issue,
considering that any tracer interested in knowing the point where a task
is really reclaimed (from zombie state) is trace_sched_process_free()
called from delayed_put_task_struct() ?

Thanks,

Mathieu

> 
> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>   include/trace/events/sched.h | 28 ++++++++++++++++++++++++++++
>   kernel/exit.c                |  1 +
>   2 files changed, 29 insertions(+)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index dbb01b4b7451..750b2f0bdf69 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -341,6 +341,34 @@ DEFINE_EVENT(sched_process_template, sched_wait_task,
>   	TP_PROTO(struct task_struct *p),
>   	TP_ARGS(p));
>   
> +/*
> + * Tracepoint for profiling a task that is starting to exit:
> + */
> +TRACE_EVENT(sched_profile_task_exit,
> +
> +	TP_PROTO(struct task_struct *task, long code),
> +
> +	TP_ARGS(task, code),
> +
> +	TP_STRUCT__entry(
> +		__array(	char,	comm,	TASK_COMM_LEN	)
> +		__field(	pid_t,	pid			)
> +		__field(	int,	prio			)
> +		__field(	long,	code			)
> +	),
> +
> +	TP_fast_assign(
> +		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
> +		__entry->pid		= task->pid;
> +		__entry->prio		= task->prio;
> +		__entry->code		= code;
> +	),
> +
> +	TP_printk("comm=%s pid=%d prio=%d exit_code=0x%lx",
> +		  __entry->comm, __entry->pid, __entry->prio,
> +		  __entry->code)
> +);
> +
>   /*
>    * Tracepoint for a waiting task:
>    */
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 493647fd7c07..f675f879a1b2 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -826,6 +826,7 @@ void __noreturn do_exit(long code)
>   
>   	WARN_ON(tsk->plug);
>   
> +	trace_sched_profile_task_exit(tsk, code);
>   	kcov_task_exit(tsk);
>   	kmsan_task_exit(tsk);
>   

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com



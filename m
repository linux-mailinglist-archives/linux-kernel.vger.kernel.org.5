Return-Path: <linux-kernel+bounces-82265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5FB86815F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E0F286AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751A612FF82;
	Mon, 26 Feb 2024 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrSDcFM4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B060BA1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976763; cv=none; b=lwutWdlFl6FpIoD5SAOicwasnlb9nBb/Wmcdbs1zvGGIKQg1+pt2dEjXf0hiQaOFyWs1N/XoxerFffhZXcB+t64MagzrGLzZU33tMS2Opn35OdUhj09HJYpnDZcA+JAeAwZcHY631KsvXDWNHL+rj3JLisQsk6ZKme+v/xgFVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976763; c=relaxed/simple;
	bh=PRIi2ZULSVf7CQK4g6AhLe5g/jZELpR4BhlNwOtoOjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGHjjsNMxGx2iXwnNoQCziHLq0NW5HY2qXoC2uO6PquIQO4GR0GFivd26I2xfeUrP9UVZwdWcNiDWjWrbVng0NMwjcfG6B8C5GpzaQM06ZkXkhEdAroGEQoozCC16eSQPM58+d5aA7n4TS3ZHgPc7a0Kh8+xUnxud0g21NNXFeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZrSDcFM4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708976760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5i7BL5hCOxaRnKdA86IrwzpsGPN6Vv17A+A9wPGIjok=;
	b=ZrSDcFM4dkhB9bqBwmVggrqvCJKo5gkNm5HoTx3LYcR+fqj1p1rnhoh0pbiJgCwu4kt3jg
	964xryatqQEZDgq3ZA4ijsmy+7457UwjC1V1C4MeykWO42bfid8Grzik+daxOmkNpmXNBf
	MDhY1YoSUt9qt+mf9wdVFUVNzWk3TlE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-BQH8IQO6OxaTExHoz-2osw-1; Mon, 26 Feb 2024 14:45:58 -0500
X-MC-Unique: BQH8IQO6OxaTExHoz-2osw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69A6685A58B;
	Mon, 26 Feb 2024 19:45:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.85])
	by smtp.corp.redhat.com (Postfix) with SMTP id 7CFA22022AAA;
	Mon, 26 Feb 2024 19:45:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 26 Feb 2024 20:44:38 +0100 (CET)
Date: Mon, 26 Feb 2024 20:44:35 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: wenyang.linux@foxmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] exit: add exit_code to trace_sched_process_exit and
 move it earlier in do_exit()
Message-ID: <20240226194434.GC9510@redhat.com>
References: <tencent_20932DE952CC4B7E12CF2E5530D45641BF08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_20932DE952CC4B7E12CF2E5530D45641BF08@qq.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Well. since I have already participated in the previous discussions...

As I said, I can't ack this (user-visible) patch even if I tried to
suggest this from the very beginning, I leave it to the maintainers.

I see nothing wrong in this change, but let me ask: do we really need
to report the exit code? this makes this patch even more user-visible
and I have no idea if it can break the current users.

On 02/23, wenyang.linux@foxmail.com wrote:
>
> From: Wen Yang <wenyang.linux@foxmail.com>
> 
> Currently coredump_task_exit() takes some time to wait for the generation
> of the dump file. But if the user-space wants to receive a notification
> as soon as possible it maybe inconvenient.
> 
> Add exit_code to the TP trace_sched_process_exit() and move it earlier in
> do_exit(). This way a user-space monitor could detect the exits and
> potentially make some preparations in advance.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/trace/events/sched.h | 28 +++++++++++++++++++++++++---
>  kernel/exit.c                |  2 +-
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index dbb01b4b7451..c2e8655fd453 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -330,9 +330,31 @@ DEFINE_EVENT(sched_process_template, sched_process_free,
>  /*
>   * Tracepoint for a task exiting:
>   */
> -DEFINE_EVENT(sched_process_template, sched_process_exit,
> -	     TP_PROTO(struct task_struct *p),
> -	     TP_ARGS(p));
> +TRACE_EVENT(sched_process_exit,
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
>  
>  /*
>   * Tracepoint for waiting on task to unschedule:
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 493647fd7c07..48b6ed7f7760 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -826,6 +826,7 @@ void __noreturn do_exit(long code)
>  
>  	WARN_ON(tsk->plug);
>  
> +	trace_sched_process_exit(tsk, code);
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
> -- 
> 2.25.1
> 



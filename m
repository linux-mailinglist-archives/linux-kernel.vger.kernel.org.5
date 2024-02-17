Return-Path: <linux-kernel+bounces-69808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 669A5858ED0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5021F21E3A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750334F1F2;
	Sat, 17 Feb 2024 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7jp+vB5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F921D528
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708167052; cv=none; b=Ivm2fPd3f4hU3gdW0UyAhmm8Z0kE4xGmsoDb45MKsy0EprViagGO2n9ore6Tb9aIVTpAHU6BEKHyAGct6W7xDhDfXhucAmnw38RHDE6iQIw9Fek97dnELAbauuirw5uZe3he+r28OvfUCDs2y2dxHST21nouYRpTlgjSzootzbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708167052; c=relaxed/simple;
	bh=+3r//5NNKetdV6wouTiJuqUDA0HXb2eUQHcinkSbH0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQXDmXxbnuMXqnqS599Js65ukVquCS+7z6vv2SyhG97x8XGgrKM/Q93ehfm2D/nPwOYQMEmjNATE7D1212BAsXAmOVUSRSsq2mkXbA1/Q4n3EUXgweVGGqIuclk8jYHimeujdBWS1ddqTFaUQS7/YshHJU8tNbbtMrJvThCd7zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7jp+vB5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708167049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FBIpcYEDGFkbiTnS4+f+7Qg5aIeP/YB4iUatIpWRbDE=;
	b=I7jp+vB5lR415yX+s3ra1KOawqvw2u1KYyGXL26t0O3Aw6XP3KdCvGojnqiffxnZbP5+cy
	o3IEb4JIL3FVlspX9mHz6NQgHuZnuyqNEwaQ9y4N3HRJc1XcVRU1r5WwQwb8+Mz2YGwFUc
	kPW3KBpef7AMqKFcej7IOmc/fZNOf3A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-DCGClmD2NB66VU1m3iI7RA-1; Sat, 17 Feb 2024 05:50:45 -0500
X-MC-Unique: DCGClmD2NB66VU1m3iI7RA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E9B685A589;
	Sat, 17 Feb 2024 10:50:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.33])
	by smtp.corp.redhat.com (Postfix) with SMTP id 3221240C9444;
	Sat, 17 Feb 2024 10:50:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 17 Feb 2024 11:49:27 +0100 (CET)
Date: Sat, 17 Feb 2024 11:49:24 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: wenyang.linux@foxmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump debugging: add a tracepoint to report the
 coredumping
Message-ID: <20240217104924.GB10393@redhat.com>
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 02/17, wenyang.linux@foxmail.com wrote:
>
> From: Wen Yang <wenyang.linux@foxmail.com>
>
> Currently coredump_task_exit() takes some time to wait for the generation
> of the dump file. But if the user-space wants to receive a notification
> as soon as possible it maybe inconvenient.
>
> Add the new trace_sched_process_coredump() into coredump_task_exit(),
> this way a user-space monitor could easily wait for the exits and
> potentially make some preparations in advance.

Can't comment, I never know when the new tracepoint will make sense.

Stupid question. Can we simply shift trace_sched_process_exit() up
before coredump_task_exit() ?

Oleg.


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
>  include/trace/events/sched.h | 7 +++++++
>  kernel/exit.c                | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index dbb01b4b7451..ce7448065986 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -334,6 +334,13 @@ DEFINE_EVENT(sched_process_template, sched_process_exit,
>  	     TP_PROTO(struct task_struct *p),
>  	     TP_ARGS(p));
>
> +/*
> + * Tracepoint for a task coredumping:
> + */
> +DEFINE_EVENT(sched_process_template, sched_process_coredump,
> +	     TP_PROTO(struct task_struct *p),
> +	     TP_ARGS(p));
> +
>  /*
>   * Tracepoint for waiting on task to unschedule:
>   */
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 493647fd7c07..c11e12d73f4e 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -425,6 +425,7 @@ static void coredump_task_exit(struct task_struct *tsk)
>  			self.next = xchg(&core_state->dumper.next, &self);
>  		else
>  			self.task = NULL;
> +		trace_sched_process_coredump(tsk);
>  		/*
>  		 * Implies mb(), the result of xchg() must be visible
>  		 * to core_state->dumper.
> --
> 2.25.1
>



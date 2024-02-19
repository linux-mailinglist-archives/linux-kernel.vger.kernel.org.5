Return-Path: <linux-kernel+bounces-71680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF99885A8ED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1F4285351
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8A13FB35;
	Mon, 19 Feb 2024 16:27:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC983FB21
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360065; cv=none; b=LCk+Fj+MkFgBAJkfVq5DsJKrubrasykIIMa8EoKzHGp/s+blniaN07l9VgQc4/wZ0FRLcpIPETXttEy7dFd84mC0UKR2675BEZv8gLM8idFVbTCiJ9fyvh7j6JK11AglTWG/YpwJLr4J2+9ye8MsvTfaDnBTkgwyp8sd+/0bncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360065; c=relaxed/simple;
	bh=vP+nkCkoSWpm8hoXCJXsjMWPc8m8PUOzLDnzg748Fek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmWuCs/HP/m6tZbCVgs4ghAPyCIpHUV8mok1uCwLcWZ0W2c01xu2+YB+3FYs4QH/bhmCOk7QjLDkr68UJmzmnFoy/9XabxLO+KAC+wenlzET2aAO50ohMzYVdyGxi0puqn/Ss0wiW/phEpz9Y0Zco+3rbGQfPBDzlBHS/ZDK5qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7253AC433C7;
	Mon, 19 Feb 2024 16:27:43 +0000 (UTC)
Date: Mon, 19 Feb 2024 11:29:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: wenyang.linux@foxmail.com, Masami Hiramatsu <mhiramat@kernel.org>, Ingo
 Molnar <mingo@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@techsingularity.net>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump debugging: add a tracepoint to report the
 coredumping
Message-ID: <20240219112926.77ac16f8@gandalf.local.home>
In-Reply-To: <20240217104924.GB10393@redhat.com>
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
	<20240217104924.GB10393@redhat.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Feb 2024 11:49:24 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> On 02/17, wenyang.linux@foxmail.com wrote:
> >
> > From: Wen Yang <wenyang.linux@foxmail.com>
> >
> > Currently coredump_task_exit() takes some time to wait for the generation
> > of the dump file. But if the user-space wants to receive a notification
> > as soon as possible it maybe inconvenient.
> >
> > Add the new trace_sched_process_coredump() into coredump_task_exit(),
> > this way a user-space monitor could easily wait for the exits and
> > potentially make some preparations in advance.  
> 
> Can't comment, I never know when the new tracepoint will make sense.
> 
> Stupid question. Can we simply shift trace_sched_process_exit() up
> before coredump_task_exit() ?

Reading the rest of the thread and looking at the code, we do have this:

void __noreturn do_exit(long code)
{
	struct task_struct *tsk = current;
	int group_dead;

[...]
	acct_collect(code, group_dead);
	if (group_dead)
		tty_audit_exit();
	audit_free(tsk);

	tsk->exit_code = code;
	taskstats_exit(tsk, group_dead);

	exit_mm();

	if (group_dead)
		acct_process();
	trace_sched_process_exit(tsk);

There's a lot that happens before we trigger the above event. I could
imagine that there are users expecting those actions to have taken place by
the time the event triggered. Like the "exit_mm()" call, as well as many
others.

I would be leery of moving that tracepoint.

-- Steve


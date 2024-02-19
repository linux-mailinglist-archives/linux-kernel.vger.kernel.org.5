Return-Path: <linux-kernel+bounces-71755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA1985A9F5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4F31F223C4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECF04879C;
	Mon, 19 Feb 2024 17:26:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58032481C4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363604; cv=none; b=Qp3JLNigf1CQqGZ9y2Oarthbm694JDj1kErC71jP/qRnCuaI2h+5OgjdHUjk/JEHEkfsf8HSDmDcBrOKCYHzd41vIjha5pN7dAraMwDbP4e+gkMyQ3erm1GwL7b77nVdoxTL6Xy1xOLSuMlrwDjfTT7A4riuL5WtjT50cbiMuaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363604; c=relaxed/simple;
	bh=Q25xU1PMIcagmUfGS0YVSM4O2LLHesbt2AkQg2Pad6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHJZDA03pWmtkZ1xxiTcQPmiK/5QkIXEtjuA7kKGXIbzvD7ta/MlD6wxb6k52R8rNLzSoGnk1rrrynhDdBaQhzftYr1CUNjM1itm/xFAkpWS2L/4U8QIbK2a4B60cM1tmzrqKceQsWKer7j+iZAwF8vTD47e9/tlZsbTWaEqnUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DD3C43390;
	Mon, 19 Feb 2024 17:26:42 +0000 (UTC)
Date: Mon, 19 Feb 2024 12:28:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: wenyang.linux@foxmail.com, Masami Hiramatsu <mhiramat@kernel.org>, Ingo
 Molnar <mingo@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@techsingularity.net>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump debugging: add a tracepoint to report the
 coredumping
Message-ID: <20240219122825.31579a1e@gandalf.local.home>
In-Reply-To: <20240219170038.GA710@redhat.com>
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
	<20240217104924.GB10393@redhat.com>
	<20240219112926.77ac16f8@gandalf.local.home>
	<20240219170038.GA710@redhat.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 18:00:38 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> > void __noreturn do_exit(long code)
> > {
> > 	struct task_struct *tsk = current;
> > 	int group_dead;
> >
> > [...]
> > 	acct_collect(code, group_dead);
> > 	if (group_dead)
> > 		tty_audit_exit();
> > 	audit_free(tsk);
> >
> > 	tsk->exit_code = code;
> > 	taskstats_exit(tsk, group_dead);
> >
> > 	exit_mm();
> >
> > 	if (group_dead)
> > 		acct_process();
> > 	trace_sched_process_exit(tsk);
> >
> > There's a lot that happens before we trigger the above event.  
> 
> and a lot after.

True. There really isn't a meaningful location here is there?

I actually use this tracepoint in my pid tracing.

The set_ftrace_pid and set_event_pid from /sys/kernel/tracing will add and
remove PIDs if the options function-fork or event-fork are set respectively.

I hook to the sched_process_fork tracepoint to add new PIDs if the parent
pid is already in one of the files, and remove a PID via the
sched_process_exit function.

Honestly, if anything, it should probably be moved down right next to
perf_event_exit_task() (I never understood why perf needed its own hooks
and not just use tracepoints).

> 
> To me the current placement of trace_sched_process_exit() looks absolutely
> random.

Agreed.

> 
> > I could
> > imagine that there are users expecting those actions to have taken place by
> > the time the event triggered. Like the "exit_mm()" call, as well as many
> > others.
> >
> > I would be leery of moving that tracepoint.  
> 
> And I agree. I am always scared of every user-visible change, simply
> because it is user-visbible.
> 
> If it was not clear, I didn't try to nack this patch. I simply do not know
> how people use the tracepoints and for what. Apart from debugging.
> 
> But if we add the new one into coredump_task_exit(), then we probably want
> another one in ptrace_event(PTRACE_EVENT_EXIT) ? It too can "take some time"
> before the exiting task actually exits.
> 
> So I think this needs some discussion, and the changelog should probably say
> more.
> 
> In short: I am glad you are here, I leave this to you and Wen ;)

I still would like to have your input too ;-)

-- Steve


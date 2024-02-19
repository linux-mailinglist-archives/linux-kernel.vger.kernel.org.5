Return-Path: <linux-kernel+bounces-71723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CCA85A97F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B80B1C2146F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A35744388;
	Mon, 19 Feb 2024 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJkDPLq9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322F93A1CF
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362126; cv=none; b=ksCKQCyU3pQxKVFdyGQZonWrrlQpcpYP2h7Cs7Sh5P8ofxTZDbe88110tzenmz62eXVr91mHXxLD7ZtPEuY39vYuUdMPXeyzDrg/QSrMLQast/RWtJ4S9FNhYDX9oWAgF0TLEw0tk9kKdNsdlb7xb/sIRt01lng9fq8bSXKJOQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362126; c=relaxed/simple;
	bh=XwskK8tp8mLXccK2vSWNp6hKAb6yiu7cCwb03gvVb6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nd4n3yX724X5sqc79zrar5ESdS9yAXpeosevU4GpTN1Uw/UTk5CTnMgqkXwgYKUF2dzN8LXkFc8Cl1/obftmgJXP+qDBx942gXAbZ7MucROTY/SUU7VJnwuA3P5K90b/p+5OIyclxrG/TUIAouUqEa9jmIZX8PDgoWFpxLy9xcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJkDPLq9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708362124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g9IIyhQRI3J2WzdBlQ/GkJL8vUUHM+p+85WKFcoZUl4=;
	b=ZJkDPLq9ZY2Lud4cRrDtiF+gBetaLN/+/9pImr0v4e9ccSYtVq26Vbs66D9o9BsdMXouzS
	0zR1Q5l53xQLBSyEadf6BO4Vzndx2qLNUx+xtdLNWE3thNmygAwxcOxgdpu1EXbVaH0Lw4
	JABTmI89kjTFdInW3lrAA12Dx72gWak=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-7t2sWArJN5arSr375Eu9jg-1; Mon, 19 Feb 2024 12:02:00 -0500
X-MC-Unique: 7t2sWArJN5arSr375Eu9jg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0013835381;
	Mon, 19 Feb 2024 17:01:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.75])
	by smtp.corp.redhat.com (Postfix) with SMTP id 9087E8BCC;
	Mon, 19 Feb 2024 17:01:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 19 Feb 2024 18:00:41 +0100 (CET)
Date: Mon, 19 Feb 2024 18:00:38 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: wenyang.linux@foxmail.com, Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump debugging: add a tracepoint to report the
 coredumping
Message-ID: <20240219170038.GA710@redhat.com>
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
 <20240217104924.GB10393@redhat.com>
 <20240219112926.77ac16f8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219112926.77ac16f8@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 02/19, Steven Rostedt wrote:
>
> On Sat, 17 Feb 2024 11:49:24 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > On 02/17, wenyang.linux@foxmail.com wrote:
> > >
> > > From: Wen Yang <wenyang.linux@foxmail.com>
> > >
> > > Currently coredump_task_exit() takes some time to wait for the generation
> > > of the dump file. But if the user-space wants to receive a notification
> > > as soon as possible it maybe inconvenient.
> > >
> > > Add the new trace_sched_process_coredump() into coredump_task_exit(),
> > > this way a user-space monitor could easily wait for the exits and
> > > potentially make some preparations in advance.
> >
> > Can't comment, I never know when the new tracepoint will make sense.
> >
> > Stupid question. Can we simply shift trace_sched_process_exit() up
> > before coredump_task_exit() ?
>
> Reading the rest of the thread and looking at the code, we do have this:
>
> void __noreturn do_exit(long code)
> {
> 	struct task_struct *tsk = current;
> 	int group_dead;
>
> [...]
> 	acct_collect(code, group_dead);
> 	if (group_dead)
> 		tty_audit_exit();
> 	audit_free(tsk);
>
> 	tsk->exit_code = code;
> 	taskstats_exit(tsk, group_dead);
>
> 	exit_mm();
>
> 	if (group_dead)
> 		acct_process();
> 	trace_sched_process_exit(tsk);
>
> There's a lot that happens before we trigger the above event.

and a lot after.

To me the current placement of trace_sched_process_exit() looks absolutely
random.

> I could
> imagine that there are users expecting those actions to have taken place by
> the time the event triggered. Like the "exit_mm()" call, as well as many
> others.
>
> I would be leery of moving that tracepoint.

And I agree. I am always scared of every user-visible change, simply
because it is user-visbible.

If it was not clear, I didn't try to nack this patch. I simply do not know
how people use the tracepoints and for what. Apart from debugging.

But if we add the new one into coredump_task_exit(), then we probably want
another one in ptrace_event(PTRACE_EVENT_EXIT) ? It too can "take some time"
before the exiting task actually exits.

So I think this needs some discussion, and the changelog should probably say
more.

In short: I am glad you are here, I leave this to you and Wen ;)

Oleg.



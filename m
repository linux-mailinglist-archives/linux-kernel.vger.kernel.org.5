Return-Path: <linux-kernel+bounces-73993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE43C85CE98
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896CF28568D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDFF2E632;
	Wed, 21 Feb 2024 03:13:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE42F36
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708485236; cv=none; b=OdReVFh28tdozLt2IU0Nv1M7nAgC5PZUMDhehwxWpAM1ySuOYMyYck4MFr5gr9+C8cD8YLHrl3T5VJdCine2RZr/P6O7xUL6Saqui/zKnfXbpc+q86GLt96nXmp0No4Ykdkt4bjByteSjmEl2njj0EP1Cos996YW5ealSuQfGwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708485236; c=relaxed/simple;
	bh=ER9PlV7MmS7Eg/bll3Hmao7PrNdZ4fzjsKD7Nq5p9mo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxaOmREWiv5TsaDlrY0kEt1KAt5v6bQacn9d7YiyEHzUENZ5fiV2St7jzdlgPQqa255VshUbUgfMqYvDq8fgZJLDWifuotk4vsPDgyG1QczTVxxxTp8O3Gv0aokAwMFgYptUZNXCBpZLx4PitSL1JTnuUBHjL1AnAZP77UvCH7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101E1C433C7;
	Wed, 21 Feb 2024 03:13:54 +0000 (UTC)
Date: Tue, 20 Feb 2024 22:15:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
 <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/clock: Make local_clock() notrace
Message-ID: <20240220221541.263b4946@gandalf.local.home>
In-Reply-To: <20240220202524.2527c110@gandalf.local.home>
References: <20240220202002.38fec245@gandalf.local.home>
	<182553e4-a2e2-46f6-8c50-2de6f8effee7@efficios.com>
	<20240220202524.2527c110@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 20:25:24 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Yes. Debugging that was how I found it ;-) sort of.
> 
> I went back to another machine which triggered the cmpxchg issue as well,
> but when removing that code and going back to the old code, it then locked
> up completely. That was because the other config had more debugging enabled.
> That debugging lead to finding this.
> 
> I'm now going back to see if I can trigger that again with this update.

Actually, I take that back. I had reverted the patches, but the lockups
happened when I put them back in. The lock ups do not happen when I don't
have the cmpxchg code.

I see now that it goes into an infinite loop if the clock gets traced
(found another clock that has the same issue):

	w = local_read(&tail_page->write);
	[..]
 again:
	info->ts = rb_time_stamp(cpu_buffer->buffer);
	[..]
	if (!local_try_cmpxchg(&tail_page->write, &w, w + info->length))
		goto again;

The rb_time_stamp() causes a trace to happen which will move 'w' and the
try_cmpxchg() is guaranteed to fail. Each time! So the above turns into an
infinite loop.

I finally got the recursion logic to not lock up the machine when a timer
gets traced. And because we still trace interrupt code (specifically
irq_enter_rcu(), which I do still want to trace!) we need the "transition"
bit in the recursion test.

That is, because irq_enter_rcu() is called before the preempt_count gets
set to being an IRQ, it fails the recursion test. To handle this, the
recursion test allows a single iteration (a transition bit) otherwise it
considers it a recursion and drops the event.

But in this case, a single recursion will still cause it to fall into an
infinite loop.

-- Steve


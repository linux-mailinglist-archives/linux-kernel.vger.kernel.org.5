Return-Path: <linux-kernel+bounces-5456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80A8818ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96F21C21601
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064151CAAE;
	Tue, 19 Dec 2023 15:09:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333C1CA98;
	Tue, 19 Dec 2023 15:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C73CC433C8;
	Tue, 19 Dec 2023 15:09:29 +0000 (UTC)
Date: Tue, 19 Dec 2023 10:10:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ring-buffer: Fix slowpath of interrupted event
Message-ID: <20231219101027.349b7d19@gandalf.local.home>
In-Reply-To: <20231219233710.21b48850676e65da2a37fe22@kernel.org>
References: <20231218230712.3a76b081@gandalf.local.home>
	<20231219233710.21b48850676e65da2a37fe22@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 23:37:10 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Yeah the above works, but my question is, do we really need this
> really slow path? I mean;
> 
> > 	if (w == write - event length) {
> > 		/* Nothing interrupted between A and C */
> >  /*E*/		write_stamp = ts;
> > 		delta = ts - after  
> 
> 	} else {
> 		/*
> 		  Something interrupted between A and C, which should record
> 		  a new entry before this reserved entry with newer timestamp.
> 		  we reuse it.
> 		 */
> 	 	ts = after = write_stamp;
> 		delta = 0;
> 	}
> 
> Isn't this enough?

I really like to avoid: delta = 0 when possible. It's basically what I do
when I have no other options. Why?

Because let's just say you are looking at the time of interrupt events. If
you just trace the entry of the interrupt, and that interrupt interrupted
an event being written to, we have this:

Time starts at ts 1000, and we are able to calculate the delta of the
interrupted event. And the trace will have:

 1000 - interrupt event
 2000 - normal context event
 2100 - next normal context event

Where we see the delta between the interrupt event and the normal context
event was 1000. But if we just had it be delta = 0, it would be:

 1000 - interrupt event
 1000 - normal context event
 2100 - next normal context event

It will look like the time between the interrupt event and the normal
context event was instant, and the time between the normal context event
and the next normal context event was 1100 when in reality it was just 100.

The above scenario is rather common. Perhaps it happens 1% of the time. The
case where we currently have delta = 0 only happens when the same event
gets interrupted twice. That is, two separate interrupts came in, one
before it allocated its space on the buffer, and one after it allocated.
That's a much more race occurrence (0.01% possibly, or less). In fact my
traces seldom even show it. Most of the time, even when doing function
tracing, I have a hard time seeing this rare race.

So, if we can have delta=0 only 0.01% or less of the time, I rather do that
then have it be delta=0 1% of the time.

Thanks for the review!

-- Steve


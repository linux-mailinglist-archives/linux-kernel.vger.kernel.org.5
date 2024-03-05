Return-Path: <linux-kernel+bounces-91598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302C087141A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA48F1F231A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74B32942A;
	Tue,  5 Mar 2024 03:06:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7DD28E23;
	Tue,  5 Mar 2024 03:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709607967; cv=none; b=bio7mAbecqQyiWsspORaB+oWDsi0ugJWH3/VsFm+qC6xXJS159EZJKlKTtsUVZbxo70ltJb1w7sM6fvHzrswMixN6zcQO4Kk8rInIFtqLR6KrZaxxwAb1ri75BQDDB/+R/Qhuj+CYAppz2WT3TTjAS4Lu3w38TcH1PKQ3UK+Fmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709607967; c=relaxed/simple;
	bh=OSg9KgrWcCqYD+LVxjqxALYSgKaYs8OihzNp27f3IZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=seMB0B9ePI8wGjo2JY03+18K/8tccQqFfLpWNVjPb6ydd+dMRkt4PpFvo7FgBdDIp6Dy6ah5YgYlw+5zvATLBHsEbXYBPt8/mQMk9Qx6JgT8YFrIi21jZJeXdzZIaIXPNQnOn+XNRRSoElxIxUQopkNVgESQ16Y4/MebrUnK5rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16329C433C7;
	Tue,  5 Mar 2024 03:06:05 +0000 (UTC)
Date: Mon, 4 Mar 2024 22:07:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] tracing: Have trace_marker writes be just half of
 TRACE_SEQ_SIZE
Message-ID: <20240304220754.4fbe3f34@gandalf.local.home>
In-Reply-To: <c3051fd1-2aaa-485f-b23d-d98c3579e166@efficios.com>
References: <20240304192710.4c99677c@gandalf.local.home>
	<469d31a7-f358-4547-bb17-0979b3515924@efficios.com>
	<20240304203516.45b7a551@gandalf.local.home>
	<20240304204119.7503ab0b@gandalf.local.home>
	<91f27ba1-15a4-402d-8301-e2b9d23f64b0@efficios.com>
	<20240304205943.081bea96@gandalf.local.home>
	<cef0b07e-f90d-4759-ae54-0f091e87edab@efficios.com>
	<20240304213538.13fe1f3b@gandalf.local.home>
	<20240304213750.1baef01d@gandalf.local.home>
	<c3051fd1-2aaa-485f-b23d-d98c3579e166@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 21:48:44 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2024-03-04 21:37, Steven Rostedt wrote:
> > On Mon, 4 Mar 2024 21:35:38 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> >>> And it's not for debugging, it's for validation of assumptions
> >>> made about an upper bound limit defined for a compile-time
> >>> check, so as the code evolves issues are caught early.  
> >>
> >> validating is debugging.  
> > 
> > Did Linus put you up to this? To test me to see if I'm learning how to say "No" ;-)  
> 
> No, he did not. 

I was being facetious.

> I genuinely think that validating size limits like
> this either at compile time or, when they can vary at runtime like
> in this case, with a dynamic check, decreases the cognitive
> load on the reviewers. We can then assume that whatever limit
> was put in place is actually enforced and not just wishful
> thinking.

I'm for that too. But the purpose of trace_seq was to be able to safely
append strings on top of each other. It was written specifically for the
trace file output. It should be long enough to print the entire string. If
the trace_seq overflows, it will not add any more content. But this is
checked at the end to see if everything did fit.

I had the "half" size logic because it was still way more than enough to
hold the write and the header, where the header should never be that big.

It's not much different than vsnprintf() having a 32K precision field that
warns if you go over it. If a header is 128 bytes then it is really a
failure in output, as it will cause each line to overflow a normal 80
character terminal screen before it even gets to the content of the event.

Such a header is stupid and this is where I'm starting to understand Linus,
where we don't need to write a bunch of debug code to make sure we don't
have some huge header just because it may cause the content of the event
from being visible.

Oh! and yes, there are events that can be large (stack traces and such). If
a header is created to be that big, you will likely drop actual real
events that have nothing to do with trace_marker.

> 
> If the "header" size upper bound is not validated at runtime, there
> is not much point in adding the BUILD_BUG_ON() based on that value
> in the first place, and you should then just add a runtime check that
> you don't overflow the output buffer before writing the output to it.


OK, then I guess we don't need the checks. 4K for a trace_marker limit and
8K for the trace_seq that will eventually hold its content, is a pretty
simple concept. Do we need a bunch of logic to keep it from breaking?
Especially since trace_marker is used a lot in testing the tracing code
itself.

-- Steve



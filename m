Return-Path: <linux-kernel+bounces-39348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3CC83CF35
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1E11C246BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BCA13AA53;
	Thu, 25 Jan 2024 22:14:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E74B13AA27;
	Thu, 25 Jan 2024 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706220858; cv=none; b=mPqHXXK0ESVdtcXXc+Qf+SbTUaHvWaq2nfM9vzO6BE2r2UOYA4dO9Qm7TRPQM5AEI+azZ40I7etcVWxO/wOwowvEwbNqRPIvjHrZBBxh79d9eWfnZ09+NdOL5qwu6bjcX3R54lrKdEKtEecLRkIRdiHCv0slRigiF4Zusfh+DoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706220858; c=relaxed/simple;
	bh=R4np8ZsWZvit+NdkWvJhO+66XQ9QZXjcg6nrt984Bgs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9s4cEBuMyUYMt70SG7+FmUhOwy33IY8JaG7XsyaDIFu9kTG2lpyn+TXV0UCFDNwlkZraBhfxqGfG44HfTbv3v5+ZhFyt6/apY8NMRjnCOp6J5+aIgIyHU71u738nVaZWf8eER95HIdXlG3UkOAJPKaoS5gZ+O7tO2gFkSROs6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C255DC433C7;
	Thu, 25 Jan 2024 22:14:16 +0000 (UTC)
Date: Thu, 25 Jan 2024 17:14:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Philippe Proulx
 <pproulx@efficios.com>
Subject: Re: [PATCH] ring-buffer: Simplify reservation with try_cmpxchg()
 loop
Message-ID: <20240125171417.62986746@gandalf.local.home>
In-Reply-To: <88e9a728-9c9a-42d5-bba4-b9f3fbe61d53@efficios.com>
References: <20240118181206.4977da2f@gandalf.local.home>
	<504085e9-bf91-4948-a158-abae5dcb276a@efficios.com>
	<20240119103754.154dc009@gandalf.local.home>
	<cd3f37cc-31ba-4eb4-8d67-852d05570e7b@efficios.com>
	<20240119164252.54ccb654@gandalf.local.home>
	<5d323a65-8a04-4c73-8702-58869982a269@efficios.com>
	<20240120084713.6eb7aa52@rorschach.local.home>
	<88e9a728-9c9a-42d5-bba4-b9f3fbe61d53@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 16:18:37 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > 
> > This is how you are able to avoid the "before/after" logic I have, as
> > the race is automatically detected. The least significant bits of the
> > timestamp is ignored for the event delta calculation.  
> 
> Not quite, as I explained at the beginning of this email. All bits from the
> previous timestamp, including its low bits, are useful to know how many
> overflows happened since the last tsc.

Yes, but it still means updating that timestamp you will compare to doesn't
have the race I have. If the timestamp's upper bits are the same, or are
off by one and the lower bits are higher than the current timestamp, you
don't need to inject. But if the lower bits are higher than the timestamp
or the higehr bits are off by more than one then you do.

The lower bits are a delta against "0" of the current timestamp lower bits.
There's no race in updating those bits as long as the upper bits remain the
same or are off by one and the current timestamp lower bits are lower than
the saved time stamp.

In my case, because the delta is off of the entire timestamp, what I write
into the saved timestamp, all bits matter. And to handle that I need the
before/after timestamps to know if the currently saved timestamp didn't
have a race.

> 
> > And if a race
> > happens where the interrupting event saves a later timestamp and comes
> > back here, if the interrupted event writes the older timestamp, it just
> > causes that delta calculation to overflow again and you inject another
> > 64bit timestamp into the buffer.  
> 
> This part is correct: in the race you describe, we end up with the
> possibility of bringing the last_tsc backwards, which can only cause
> the tracer to use the full 64-bit timestamp when in fact it could use
> the compact representation. But it's rare and should not matter in
> practice.
> 
> And by the way this algorithm is designed to work with preemption/migration
> enabled as well, not just interrupts. So the race can come from a thread
> running concurrently on another CPU and it should work as well.
> 
> [...]
> 
> > 
> > Going through a transition of changing it could end up being just as
> > complex. I'm not sure the complexity in that transition is better than
> > the complexity of the current code, as this code has been there for 15
> > years, and I know of at least 2 other projects that depend on this
> > format as is.  
> 
> I agree with you that it's not clear-cut whether introducing this change
> would be a benefit at this stage considering the extra complexity of
> extending the ABI while keeping backward compatibility.
> 
> But it's something we can keep in mind if we ever have to do major ABI
> extensions for other reasons.

Yeah, it's something to think about if we want to use a different format
for something else.

Thanks for the review.

-- Steve


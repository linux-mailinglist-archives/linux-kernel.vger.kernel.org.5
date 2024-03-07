Return-Path: <linux-kernel+bounces-94863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE14F874618
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1AA21C21475
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2296863B8;
	Thu,  7 Mar 2024 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhAb5jRO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A002F50;
	Thu,  7 Mar 2024 02:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709778584; cv=none; b=isijpFu4S2z9aLWRfDS3HobOHLncSAXFfCprBh+PEF8ACK+iSqCPqYJ+fw3hSP66o3GZPxZF2aXJaPf3NlghToX8zytVVFS6AGL6VxeSLC6qjVkBUBLQ4i/uadW4TcFSULhsNYUmzKPlaSd3B7G1vusKXav32/lg/Duin9vew3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709778584; c=relaxed/simple;
	bh=BaFGRNMRxIHs+zpvZZ2RB8OMrkZdRNN5UBXN3tRYkcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9+GYHolPyLFj0XC8DEf5VZHDzJNlrgSs5/+8i2nxeN2VQmmJJzXFDliVs3u3RZZYzE1WqCdCHYtMefX+nRL47X4dQkCSNcAE85EXfegXVSn9esyMfVKl74voCwJDbeSp2NnY9HzTcRImyU8cEBVHRxfFh9+qYi4l8ZBBZYec/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhAb5jRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109A2C433C7;
	Thu,  7 Mar 2024 02:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709778584;
	bh=BaFGRNMRxIHs+zpvZZ2RB8OMrkZdRNN5UBXN3tRYkcE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HhAb5jRO7nf3nw2CtlWPL4xKdwMoDMxgHIjCgGn90e9k/3DUxY4ZxwDPu5kJT4dwh
	 hfRTkt3cNiQFLNwQRh1zA+mw3qAM4tKn049DbBaABqWAMnTfaJvTHysND4iTLNBe+M
	 veUJMdLKUEki412IM/k/lU+uBzARtajGWQVUP/uJpkdiVvKhLEIfnNd5M0opL0+8No
	 h9ckww35u7ZSkMfbDptH8jtoAPty7uPPk+BkA7tkWRRFfeXPVcu9/UFba3t9HBDwN3
	 6Bkr7gm/wykQo9AsVu7QWwVP7954zWhbJYvJtqxtEP+E8Y/UP53lGeQDRMOnZzEggK
	 xTKUxBuWyyNAw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A946FCE10B8; Wed,  6 Mar 2024 18:29:43 -0800 (PST)
Date: Wed, 6 Mar 2024 18:29:43 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linke li <lilinke99@qq.com>,
	joel@joelfernandes.org, boqun.feng@gmail.com, dave@stgolabs.net,
	frederic@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	qiang.zhang1211@gmail.com, quic_neeraju@quicinc.com,
	rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and concurrency
 bug
Message-ID: <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <tencent_9882B228F292088CDD68F10CF1C228742009@qq.com>
 <20240306103719.1d241b93@gandalf.local.home>
 <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop>
 <20240306130103.6da71ddf@gandalf.local.home>
 <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home>
 <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <20240306142738.7b66a716@rorschach.local.home>
 <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>

On Wed, Mar 06, 2024 at 11:46:10AM -0800, Linus Torvalds wrote:
> On Wed, 6 Mar 2024 at 11:27, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Note this has nothing to do with tracing. This thread is in RCU. I just
> > happen to receive the same patch "fix" for my code.
> 
> Ok, googling for rtort_pipe_count, I can only state that that code is
> complete garbage.

Well, you all do have to admit that I was right about something, namely
that Linus did not suffer in silence.  ;-)

TL;DR:  Those ->rtort_pipe_count increments cannot run concurrently
with each other or any other update of that field, so that update-side
READ_ONCE() call is unnecessary and the update-side plain C-language
read is OK.  The WRITE_ONCE() calls are there for the benefit of the
lockless read-side accesses to rtort_pipe_count.

Of course, I will fix.

> And no amount of READ_ONCE/WRITE_ONCE will fix it.
> 
> For one thing, we have this code:
> 
>         WRITE_ONCE(rp->rtort_pipe_count, i + 1);
>         if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
> 
> which is broken by design. The compiler is allowed to (and probably
> does) turn that into just
> 
>         WRITE_ONCE(rp->rtort_pipe_count, i + 1);
>         if (i + 1 >= RCU_TORTURE_PIPE_LEN) {
> 
> which only results in the question "Why didn't the source code do that
> obvious simplification itself?"

Oddly enough, we got a patch to this effect just yesterday evening,
Pacific Time:

https://lore.kernel.org/all/tencent_5D8919B7D1F21906868DE81406015360270A@qq.com/

But that of course only fixes one aspect of this mess.

> So that code is actively *STUPID*. It's randomly mixing READ_ONCE and
> regular reads in ways that just makes me go: "there's no saving this
> shit".
> 
> This needs fixing. Having tests that have random code in them only
> makes me doubt that the *TEST* itself is correct, rather than the code
> it is trying to actually test.

Huh.  There should only be one CPU updating ->rtort_pipe_count at at time.
Which to your point would make that READ_ONCE() call not only unnecessary,
but confusing as well.  Here is the intended uses of ->rtort_pipe_count:

1.	Zeroed when the item is first allocated.

2.	Incremented at the end of each subsequent grace period,
	so there is no concurrency with previous instances of
	this increment and also none with the zeroing.

	This happens in two different ways.  When testing things like
	call_rcu(), the RCU callback does the update, and if we have not
	yet reached the limit, passes that same callback to call_rcu().
	When testing other grace-period primitives (synchronize_rcu(),
	for example), we put the item on a list, and update each element
	of that list after each subsequent synchronous grace period.
	Once an element has pased through RCU_TORTURE_PIPE_LEN grace
	periods, it is removed from that list and freed.

	Either way, there is only ever one CPU incrementing a given
	->rtort_pipe_count at any given time.

3.	Freed, and not passed to another grace period, thus avoiding
	concurrency with a future #2.  Allocation and free is protected by
	a spinlock, so there is no concurrency with #1 above.  The same
	CPU that did the last increment does the free, so there is also
	no concurrency with the last #2.

I fired up a KCSAN run with added ASSERT_EXCLUSIVE_WRITER() calls, which
agrees with this analysis.  (And I will run longer runs to double-check.)

> And dammit, none of that makes sense anyway. This is not some
> performance-crticial code. Why is it not using proper atomics if there
> is an actual data race?
> 
> The reason to use READ_ONCE() and WRITE_ONCE() is that they can be a
> lot faster than atomics, or - more commonly - because you have some
> fundamental algorithm that doesn't do arithmetic, but cares about some
> "state at time X" (the RCU _pointer_ being one such obvious case, but
> doing an *increment* sure as hell isn't).

The only data race is between the one-at-a-time increment and the
lockless reads in the RCU readers.  So the RCU readers need READ_ONCE()
for ->rtort_pipe_count, but again the updater does not.

Which means that the compiler optimization that Linus pointed out above
really is an optimization for once because the compiler is for once
correct that nothing else is updating ->rtort_pipe_count.

> So using those READ_ONCE/WRITE_ONCE macros for that thing is
> fundamntally wrong to begin with.
> 
> The question should not be "should we add another READ_ONCE()". The
> question should be "what drugs were people on when writing this code"?

So what (if anything) was I thinking when I committed those update-side
READ_ONCE() calls?

202489101f2e6c ("rcutorture: Fix rcu_torture_one_read()/rcu_torture_writer() data race")

The commit log says the right thing, but I nevertheless added that
unnecessary READ_ONCE() call.  And here I was hoping to be able to blame
someone else!  ;-)

> People - please just stop writing garbage.
> 
> That 'rtort_pipe_count' should be an atomic_t, and the "add one and
> return the old value" should be an "atomic_inc_return()-1" (the "-1"
> is because "inc_return" returns the *new* value).
> 
> And feel free to add "_relaxed()" to that atomic op because this code
> doesn't care about ordering of that counter. It will help on some
> architectures, but as mentioned, this is not performance-crticial code
> to begin with.

There is no update-side concurrency, so there is no need for atomics.
I just need to get rid of that extraneous update-side READ_ONCE() call.

Athough I am not sure that I can credibly promise to never ever write
garbage, I most certainly can fix this particular instance.  :-/

							Thanx, Paul


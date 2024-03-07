Return-Path: <linux-kernel+bounces-95846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7202D8753F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F301F255E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BD912F5A8;
	Thu,  7 Mar 2024 16:10:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6F212D754;
	Thu,  7 Mar 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827835; cv=none; b=d3ogLbqWiYIEKOSNkhCoxWGf8p0lEcpvwxRZaNxKo4ofrX4H7VJuEhF6rnz7INC4QDLsne2E7mnQYX7oTv+6O2II2xqVejl62/5hXFv1AXpXe+tHIBqB4rmz0oCkmVnKKwWnmIP+4x7Mm/d3YzXLTRrpxthz6PtIt2p5VMnUTyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827835; c=relaxed/simple;
	bh=htAyT8nXO8DmvUhFcSoIUZka8padxYWn1A/mOZQOvzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3m1BHrzsNzlA12YeEoOZjZfzANOZfR3rBkz/uRFUnHkRXDMzVvw9TOv3J7tGbdXJMzgRuN5O0LodnwbUuwdKmRa04XSwM+9rYpXVaunYazlnCtjjInvzVIeFK9OdkmMJlniws3fJS8i4GFlA0kDIEb9ME+8utG/wvskqE/NYgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3A7C43390;
	Thu,  7 Mar 2024 16:10:33 +0000 (UTC)
Date: Thu, 7 Mar 2024 11:12:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linke li <lilinke99@qq.com>,
 joel@joelfernandes.org, boqun.feng@gmail.com, dave@stgolabs.net,
 frederic@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
 linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 qiang.zhang1211@gmail.com, quic_neeraju@quicinc.com, rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and
 concurrency bug
Message-ID: <20240307111228.499a5dfd@gandalf.local.home>
In-Reply-To: <20240307082059.1dc2582d@gandalf.local.home>
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
	<tencent_9882B228F292088CDD68F10CF1C228742009@qq.com>
	<20240306103719.1d241b93@gandalf.local.home>
	<27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop>
	<20240306130103.6da71ddf@gandalf.local.home>
	<CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
	<20240306135504.2b3872ef@gandalf.local.home>
	<CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
	<CAHk-=whvyzsbqLkw4kwEC-KzAMKFuy5VuMtJFn-mCerSYoRnqw@mail.gmail.com>
	<20240306144713.2e1709ad@gandalf.local.home>
	<CAHk-=whs5MdtNjzFkTyaUy=vHi=qwWgPi0JgTe6OYUYMNSRZfg@mail.gmail.com>
	<20240307082059.1dc2582d@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Mar 2024 08:20:59 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> When a write happens, it looks to see if the smallest watermark is hit,
> if so, calls irqwork to wakeup all the waiters.
> 
> The waiters will wake up, check to see if a signal is pending or if the
> ring buffer has hit the watermark the waiter was waiting for and exit the
> wait loop.
> 
> What the wait_index does, is just a way to force all waiters out of the wait
> loop regardless of the watermark the waiter is waiting for. Before a waiter
> goes into the wait loop, it saves the current wait_index. The waker will
> increment the wait_index and then call the same irq_work to wake up all the
> waiters.
> 
> After the wakeup happens, the waiter will test if the new wait_index
> matches what it was before it entered the loop, and if it is different, it
> falls out of the loop. Then the caller of the ring_buffer_wait() can
> re-evaluate if it needs to enter the wait again.
> 
> The wait_index loop exit was needed for when the file descriptor of a file
> that uses a ring buffer closes and it needs to wake up all the readers of
> that file descriptor to notify their tasks that the file closed.
> 
> So we can switch the:
> 
> 	rbwork->wait_index++;
> 	smp_wmb();
> 
> into just a:
> 
> 	(void)atomic_inc_return_release(&rbwork->wait_index);
> 
> and the:
> 
> 	smp_rmb()
> 	if (wait_index != work->wait_index)
> 
> into:
> 
> 	if (wait_index != atomic_read_acquire(&rb->wait_index))
> 
> I'll write up a patch.
> 
> Hmm, I have the same wait_index logic at the higher level doing basically
> the same thing (at the close of the file). I'll switch that over too.

Discussing this with Maitheu on IRC, we found two bugs with the current
implementation. One was a stupid bug with an easy fix, and the other is
actually a design flaw.

The first bug was the (wait_index != work->wait_index) check was done
*after* the schedule() call and not before it.

The second more fundamental bug is that there's still a race between the
first read of wait_index and the call to prepare_to_wait().

The ring_buffer code doesn't have enough context to know enough to loop or
not. If a file is being closed when another thread is just entering this
code, it could miss the wakeup.

As the callers of ring_buffer_wait() also do a loop, it's redundant to have
ring_buffer_wait() do a loop. It should just do a single wait, and then
exit and let the callers decide if it should loop again.

This will get rid of the need for the rbwork->wait_index and simplifies the
code.

Working on that patch now.

-- Steve


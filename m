Return-Path: <linux-kernel+bounces-95583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E20874FCC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0551F21C84
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68A212C550;
	Thu,  7 Mar 2024 13:19:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7548184FD5;
	Thu,  7 Mar 2024 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817547; cv=none; b=LVQdwHCnTO/nkTBjS65Z4Mh9QwF5PtaTZXmDZ+4wQTx+p7VMpwQOZv84qur0iHrGgFZW5WoUZ0jlREzLQMCHi8KRekFdwuBJE1FM7AtAAVY1oOSKQNnHyfu0bcIgDjNI/7rJ9RQTTh4PzEH1KSE0cOQX0e9Ie/BL3bmPuLcS/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817547; c=relaxed/simple;
	bh=32FNlvr62WRPZ4KinH/QcBoyS2NG2VDQhLVgPhvPXGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xgsl7mHwcatbNk+BbDQe8xpIXZDh4KPy+cY2cFfG7neJf7x4Yj2hAD9EVbQ6IgJ2PYBxnOaJDFlHaDkc/da9pZ4kDz69vvvLIxqXkd+PMOJuMxxku8Ul/ONstzj40ywEpHSB53cqG8g8M4LYmkKFLtwoEO79hK8qXsosl85iWp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E33FC433C7;
	Thu,  7 Mar 2024 13:19:05 +0000 (UTC)
Date: Thu, 7 Mar 2024 08:20:59 -0500
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
Message-ID: <20240307082059.1dc2582d@gandalf.local.home>
In-Reply-To: <CAHk-=whs5MdtNjzFkTyaUy=vHi=qwWgPi0JgTe6OYUYMNSRZfg@mail.gmail.com>
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
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 12:06:00 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 6 Mar 2024 at 11:45, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Here's the back story. I received the following patch:
> >
> >   https://lore.kernel.org/all/tencent_BA1473492BC618B473864561EA3AB1418908@qq.com/
> >
> > I didn't like it. My reply was:
> >  
> >         > -     rbwork->wait_index++;
> >         > +     WRITE_ONCE(rbwork->wait_index, READ_ONCE(rbwork->wait_index) + 1);  
> >
> >         I mean the above is really ugly. If this is the new thing to do, we need
> >         better macros.
> >
> >         If anything, just convert it to an atomic_t.  
> 
> The right thing is definitely to convert it to an atomic_t.

Agreed.

> 
> The memory barriers can probably also be turned into atomic ordering,
> although we don't always have all the variates.
> 
> But for example, that
> 
>                 /* Make sure to see the new wait index */
>                 smp_rmb();
>                 if (wait_index != work->wait_index)
>                         break;
> 
> looks odd, and should probably do an "atomic_read_acquire()" instead
> of a rmb and a (non-atomic and non-READ_ONCE thing).
> 
> The first READ_ONCE() should probably also be that atomic_read_acquire() op.
> 
> On the writing side, my gut feel is that the
> 
>         rbwork->wait_index++;
>         /* make sure the waiters see the new index */
>         smp_wmb();
> 
> should be an "atomic_inc_release(&rbwork->wait_index);" but we don't
> actually have that operation. We only have the "release" versions for
> things that return a value.
> 
> So it would probably need to be either
> 
>         atomic_inc(&rbwork->wait_index);
>         /* make sure the waiters see the new index */
>         smp_wmb();
> 
> or
> 
>         atomic_inc_return_release(&rbwork->wait_index);
> 
> or we'd need to add the "basic atomics with ordering semantics" (which
> we aren't going to do unless we end up with a lot more people who want
> them).
> 
> I dunno. I didn't look all *that* closely at the code. The above might
> be garbage too. Somebody who actually knows the code should think
> about what ordering they actually were looking for.
> 
> (And I note that 'wait_index' is of type 'long' in 'struct
> rb_irq_work', so I guess it should be "atomic_long_t" instead -  just
> shows how little attention I paid on the first read-through, which
> should make everybody go "I need to double-check Linus here")

It doesn't need to be long. I'm not even sure why I made it long. Probably
for natural alignment.

The code isn't that complex. You can have a list of waiters waiting for the
ring buffer to fill to various watermarks (in most cases, it's just one waiter).

When a write happens, it looks to see if the smallest watermark is hit,
if so, calls irqwork to wakeup all the waiters.

The waiters will wake up, check to see if a signal is pending or if the
ring buffer has hit the watermark the waiter was waiting for and exit the
wait loop.

What the wait_index does, is just a way to force all waiters out of the wait
loop regardless of the watermark the waiter is waiting for. Before a waiter
goes into the wait loop, it saves the current wait_index. The waker will
increment the wait_index and then call the same irq_work to wake up all the
waiters.

After the wakeup happens, the waiter will test if the new wait_index
matches what it was before it entered the loop, and if it is different, it
falls out of the loop. Then the caller of the ring_buffer_wait() can
re-evaluate if it needs to enter the wait again.

The wait_index loop exit was needed for when the file descriptor of a file
that uses a ring buffer closes and it needs to wake up all the readers of
that file descriptor to notify their tasks that the file closed.

So we can switch the:

	rbwork->wait_index++;
	smp_wmb();

into just a:

	(void)atomic_inc_return_release(&rbwork->wait_index);

and the:

	smp_rmb()
	if (wait_index != work->wait_index)

into:

	if (wait_index != atomic_read_acquire(&rb->wait_index))

I'll write up a patch.

Hmm, I have the same wait_index logic at the higher level doing basically
the same thing (at the close of the file). I'll switch that over too.

-- Steve


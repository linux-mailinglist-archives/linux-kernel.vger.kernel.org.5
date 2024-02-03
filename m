Return-Path: <linux-kernel+bounces-51186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3303184877D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D22128569B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060525F842;
	Sat,  3 Feb 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NItwncZ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378815E5BC;
	Sat,  3 Feb 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706978822; cv=none; b=VEZDxdvizWrZHXksB3M7lhU8rc5X9nYQYgNKLo1X2zZ4M0GDvJY7CiVB17RdNv52l9zfMezyHkMvlMjnCWowSM2tB+fXiAJj6VRgMQTZ2FylFFL08gEVhjvcpk0DwC28tPzGZ1Fig31seNhDcjMs1reQVZG8uZ3EF2+962IgZmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706978822; c=relaxed/simple;
	bh=VmBx6ehTLuOpKqQgN50mnKpaDr16oF6vA56/MJVwUag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDycc8Ebwl7HlNG0IxaH/Pfhr5lapF+sRf9J6zlVMToj4IC4krmElf0ZC906l3P4u58lgk5w0Z18pMa+IU7xjpVMr5EXQo+rMzY0v5AcDvvJJC2cQDA7VEaDBUHEItjWidn1fNwaDR9834GE0kFzUnMkiRf+YF6fXpkJyL5cp2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NItwncZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F650C433C7;
	Sat,  3 Feb 2024 16:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706978821;
	bh=VmBx6ehTLuOpKqQgN50mnKpaDr16oF6vA56/MJVwUag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NItwncZ7nKnjcEn68ISV4KLCWxschr4GhTevyzfk3XafiDnHFPXqUTsouJqVa5zTs
	 F8y9mp6bjKIuaumiwGjp35R5b4jG4bP+qqhjfw+Avn36Ro7TjGybswyNV0zW7ECZ3T
	 9+H4xzjofXg7ydVZaNsL0slPRd81lYj8b36lzl0nDNF+ah1VrmJaArwN2qWJDMiiby
	 1TmHjgmMpiZtbzU5kxmVLRW7fGE9VMC0T5RDpOAmcroBa+AjBebqgMzT8/6nIiBSnh
	 K2y3UwdGXz7vzNsEZN1mTWoaB6/r7dSm1qjSpj6PeO73u8Lzo3yTxr5Peh7S9ym2qp
	 gYdsPTvXDpLyQ==
Date: Sat, 3 Feb 2024 17:46:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pidfd_poll: report POLLHUP when pid_task() == NULL
Message-ID: <20240203-freuden-frucht-b598f8cca27d@brauner>
References: <20240202131147.GA25988@redhat.com>
 <20240202131226.GA26018@redhat.com>
 <20240202-arbeit-fruchtig-26880564a21a@brauner>
 <20240202160704.GA5850@redhat.com>
 <20240202-lackmantel-vervielfachen-4c0f0374219b@brauner>
 <20240202190529.GA28818@redhat.com>
 <20240203120425.GA30029@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240203120425.GA30029@redhat.com>

On Sat, Feb 03, 2024 at 01:04:26PM +0100, Oleg Nesterov wrote:
> Christian, I apologize for my terse and unclear emails yesterday,
> I was a bit busy.

Oh don't worry, I didn't take it badly in any way. That was all totally
ok me getting the keys api wrong is not your problem. ;)

> 
> On 02/02, Oleg Nesterov wrote:
> >
> > On 02/02, Christian Brauner wrote:
> > >
> > > > I think we need a simpler patch. I was going to send it as 4/4, but I'd
> > > > like to think more, _perhaps_ we can also discriminate the PIDFD_THREAD
> > > > and non-PIDFD_THREAD waiters. I'll try to make the patch(es) tomorrow or
> > >
> > > Right, I didn't go that far.
> 
> OK, so lets forget about the PIDFD_THREAD waiters for the moment.
> Then everything is trivial, please see below.
> 
> > > > 	1. we can't use wake_up_poll(), it passes nr_exclusive => 1
> > >
> > > Bah. So we need the same stuff we did for io_uring and use
> > > __wake_up() directly. Or we add wake_up_all_poll() and convert the other
> > > three callsites:
> >
> > ...
> >
> > > +#define wake_up_all_poll(x, m)                                                 \
> > > +       __wake_up(x, TASK_NORMAL, 0, poll_to_key(m))
> >
> > Agreed, but I think this + s/wake_up/wake_up_all_poll/ conversions
> > need a separate patch.
> 
> And if it was not clear I like this change! In fact I thought about
> the new helper too, but I didn't realize that it already have the
> users.
> 
> > > -void do_notify_pidfd(struct task_struct *task)
> > > +void pidfd_wake_up_poll(struct task_struct *task, bool dead)
> > >  {
> > > -	struct pid *pid;
> > > -
> > >  	WARN_ON(task->exit_state == 0);
> > > -	pid = task_pid(task);
> > > -	wake_up_all(&pid->wait_pidfd);
> > > +	WARN_ON(mask == 0);
> > > +	wake_up_all_poll(&task_pid(task)->wait_pidfd,
> > > +			 EPOLLIN | EPOLLRDNORM | dead ? EPOLLHUP : 0);
> >
> > No...
> >
> > This is still overcomplicated and is not right.
>                                 ^^^^^^^^^^^^^^^^
> Sorry, sorry, I misread your change, "dead" is always false so it has
> no effect and thus the change is correct.
> 
> But why do we need this arg? All we need is the trivial one-liner:
> 
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2025,7 +2025,8 @@ void do_notify_pidfd(struct task_struct *task)
>  
>  	WARN_ON(task->exit_state == 0);
>  	pid = task_pid(task);
> -	wake_up_all(&pid->wait_pidfd);
> +	__wake_up(&pid->wait_pidfd, TASK_NORMAL, 0,
> +		  poll_to_key(EPOLLIN | EPOLLRDNORM));

Ok, care to just send me a full patch for this?
Just paste it here and I'll pick it.

>  }
>  
>  /*
> 
> and I was going to send the patch above as 4/4, but then decided
> to delay it, see below.
> 
> We can rename do_notify_pidfd() if you wish, and of course the
> new wake_up_all_poll() helper you proposed makes sense, but this
> is another story.

If at all then absolutely a separate patch.

> 
> As for __change_pid(). In this case wake_up_all() is fine, we can
> change it to use wake_up_all_poll() too for consistency, but this
> is not strictly necessary and in fact "key = 0" makes a bit more
> sense imo.

Ok, I see.

> 
> And just in case... previously I said that (perhaps) it can use
> __wake_up_pollfree() but no, this would be obviously wrong.
> 
> ------------------------------------------------------------------
> Now let's recall about the PIDFD_THREAD waiters. exit_notify() does
> 		
> 	/*
> 	 * sub-thread or delay_group_leader(), wake up the
> 	 * PIDFD_THREAD waiters.
> 	 */
> 	if (!thread_group_empty(tsk))
> 		do_notify_pidfd(tsk);
> 
> and it would be nice to not wakeup the non-PIDFD_THREAD waiters.
> 
> I was thinking about something like the changes below but
> 
> 	- I am NOT sure it will work! I need to read the code
> 	  in fs/select.c
> 
> 	- in fact I am not sure this makes a lot of sense, and
> 	  the hack in pidfd_poll() doesn't look very nice even
> 	  _if_ it can work.

First, good idea to make this work. :)
Second, I agree that this looks ugly. ;/

So here's a very likely a stupid idea. To make that clean we essentially
need kernel private information that can't be set in userspace (Btw,
look at EPOLL_URING_WAKE which is similar in that it cannot be set from
userspace. It's not the same thing ofc but it is a private bit.). Which
is the gist of your proposal in a way.

So we would have to grab a new private bit in the epoll flag space. A
subsystem (e.g., pidfd, seccomp) could use that private bit to avoid
spurious wakeups such as this. I'm sure that this would be useful to
others?

It's not something we need to do right now but my point is that this
would be more palatable if this coulde be made generally useful.

The only thing that's ugly is that we'd raise that bit in ->poll() but
maybe that's acceptable through a helper? If we'd wanted to set it from
epoll itself we'd need a new fop most likely. :/

> 
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2081,6 +2081,13 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
>  	struct task_struct *task;
>  	__poll_t poll_flags = 0;
>  
> +	if (thread && pts && pts->_qproc) {
> +		// We are not registered yet. Update the key to mark
> +		// us a a PIDFD_THREAD waiter, __pollwait() will copy
> +		// this ->_key to poll_table_entry->key.
> +		if (pts->_key & EPOLLIN) // exclude the POLLHUP-only waiters
> +			pts->_key |= EPOLLMSG; // random flag
> +	}
>  	poll_wait(file, &pid->wait_pidfd, pts);
>  	/*
>  	 * Depending on PIDFD_THREAD, inform pollers when the thread
> 
> Now, do_notify_pidfd() can do
> 
> 	if (!thread_group_empty(tsk))
> 		mask = EPOLLMSG; // matches the hack in pidfd_poll
> 	else
> 		mask = EPOLLIN | EPOLLRDNORM;
> 
> 	__wake_up(..., poll_to_key(mask));
> 
> Yes, in this case it makes more sense to pass !thread_group_empty()
> as a "bool thread" argument.
> 
> ---------------------------------------------------------------------
> 
> What do you think?
> 
> I am starting to think that I shouldn't have delayed the 1st trivial
> change. Feel free to push it, with or without rename, with or without
> the new wake_up_all_poll() helper, I am fine either way. But please
> don't add the new "int dead" argument, afaics it makes no sense.

I would never go above your head, don't worry. :)


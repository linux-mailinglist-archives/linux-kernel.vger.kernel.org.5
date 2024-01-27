Return-Path: <linux-kernel+bounces-41213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B61A83ED7C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177AC1C2123F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A822563F;
	Sat, 27 Jan 2024 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUGLURXm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AED25614;
	Sat, 27 Jan 2024 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706365987; cv=none; b=nXNYxIeyPVm0mnCyooTUQ4Drx50X3M4JcbeqleaYzGpFGRF/gConckrDYxwN+TtYfHx9/JjdAOuyj5G8JFDli34uwHp29xL98JutE9gwAlNMLGDQCYyLXNfI00OtPXqxl6oLgtSnVYBimiNMUnTmTgntY7a5PjIckX2gItRlMTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706365987; c=relaxed/simple;
	bh=7yiYZJ1S3J1xZ/XaStLzzEMFrh8kHMHMD/9wg1lDgSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlBLDtI1CCj6fGXvPLqCkMh3TiZ75pmYP8hxnj0+i1SdsZ5/nNnA9nMMewkyASpDZarqV/86V1RNFmbMOSJPnLxBVgnpRl3epND/g6ok1i/GyEzq+HQC/MjkS1KFK/GEyZS3U7BGMbtGMNCP909R79Nehis24CYywv53pgmeQb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUGLURXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9EFC433C7;
	Sat, 27 Jan 2024 14:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706365986;
	bh=7yiYZJ1S3J1xZ/XaStLzzEMFrh8kHMHMD/9wg1lDgSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUGLURXmWsWtWrp67aRiQ61WnjKxdqUb76keJ8ogLYkTWpmDK1bGdFdWlxdSMR7Ux
	 P1Rj2ByY50mNoUGE1QEpYEFpUS5345753C8cCspO3i19s635qsjxSJZLddGdNVZzqn
	 DgEmi0xzntYp95oUI27tm2tYgqooZTst4U675aPFEd/9kMMcvi2nRZ6vUNC6jlZIMA
	 lrudB4JMBJCb4jMBsd07HKg6NkFW8TANMBD2BfqUwqv9gvCCBdFLpn1A8Fwg/bwsiA
	 ecfNe+W7q5o7EFab6ObFeKqYAucfEu4D/OB4d445mMTlWJwQWnsTEjoy4W5+FOPVE0
	 vkq2w4G0yJNaQ==
Date: Sat, 27 Jan 2024 15:33:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240127-anheben-unfehlbar-52b320b211aa@brauner>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <ZbQpPknTTCyiyxrP@tycho.pizza>
 <20240127105410.GA13787@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240127105410.GA13787@redhat.com>

On Sat, Jan 27, 2024 at 11:54:32AM +0100, Oleg Nesterov wrote:
> Hi Tycho,
> 
> On 01/26, Tycho Andersen wrote:
> >
> > On Thu, Jan 25, 2024 at 03:08:31PM +0100, Oleg Nesterov wrote:
> > > What do you think?
> >
> > Thank you, it passes all my tests.
> 
> Great, thanks!
> 
> OK, I'll make v2 on top of the recent
> "pidfd: cleanup the usage of __pidfd_prepare's flags"
> 
> but we need to finish our discussion with Christian about the
> usage of O_EXCL.

Just write the patch exactly like you want. If it's as a little a detail
as the uapi flag value we can just always change that when applying.
There's no reason to introduce artificial delays because of my
preference here..

> 
> As for clone(CLONE_PIDFD | CLONE_THREAD), this is trivial but
> I think this needs another discussion too, lets do this later.
> 
> > > +	/* unnecessary if do_notify_parent() was already called,
> > > +	   we can do better */
> > > +	do_notify_pidfd(tsk);
> >
> > "do better" here could be something like,
> >
> > [...snip...]
> 
> No, no, please see below.
> 
> For the moment, please forget about PIDFD_THREAD, lets discuss
> the current behaviour.
> 
> > but even with that, there's other calls in the tree to
> > do_notify_parent() that might double notify.
> 
> Yes, and we can't avoid this. Well, perhaps do_notify_parent()
> can do something like
> 
> 	if (ptrace_reparented())
> 		do_notify_pidfd();
> 
> so that only the "final" do_notify_parent() does do_notify_pidfd()
> but this needs another discussion and in fact I don't think this
> would be right or make much sense. Lets forget this for now.
> 
> Now. Even without PIDFD_THREAD, I think it makes sense to change
> do_notify_parent() to do
> 
> 	if (thread_group_empty(tsk))
> 		do_notify_pidfd(tsk);
> 
> thread_group_empty(tsk) can only be true if tsk is a group leader
> and it is the last thread. And this is exactly what pidfd_poll()
> currently needs.
> 
> In fact I'd even prefer to do this in a separate patch for the
> documentation purposes.
> 
> Now, PIDFD_THREAD can just add
> 
> 	if (!thread_group_empty(tsk))
> 		do_notify_pidfd(tsk);
> 
> right after "tsk->exit_state = EXIT_ZOMBIE", that is all.

Sounds good.

> 
> This also preserves the do_notify_pidfd/__wake_up_parent ordering.
> Not that I think this is important, just for consistency.
> 
> > This brings up another interesting behavior that I noticed while
> > testing this, if you do a poll() on pidfd, followed quickly by a
> > pidfd_getfd() on the same thread you just got an event on, you can
> > sometimes get an EBADF from __pidfd_fget() instead of the more
> > expected ESRCH higher up the stack.
> 
> exit_notify() is called after exit_files(). pidfd_getfd() returns
> ESRCH if the exiting thread completes release_task(), otherwise it
> returns EBADF because ->files == NULL. This too doesn't really
> depend on PIDFD_THREAD.
> 
> > I wonder if it makes sense to abuse ->f_flags to add a PIDFD_NOTIFIED?
> > Then we can refuse further pidfd syscall operations in a sane way, and
> 
> But how? We only have "struct pid *", how can we find all files
> "attached" to this pid?

We can't. There's some use-cases that would make this desirable but that
would mean we would need another data structure to track this. I once
toyed with a patch for this but never got so excited about it to
actually finish it.


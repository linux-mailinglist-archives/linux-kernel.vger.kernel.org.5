Return-Path: <linux-kernel+bounces-42971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC80840972
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA221F2417B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ACB153511;
	Mon, 29 Jan 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8zmKtt8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986281534FC;
	Mon, 29 Jan 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541274; cv=none; b=NB5lGFioET63vVyQnLYedKQrz+gy1j/wRMisADI58MGphpswhORAfcFuwEWSVrh/Tj2USNo0o9rAwW3ptRx9IymkxbbEGbiuAIuNKbQ6VVZESVzHvDEFbkiVicJ3QOim+gYtXnqqViZYVCIub7fIdkO8ozQjlnEdvqSIwuJ3efE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541274; c=relaxed/simple;
	bh=AQDzrA2EHtRyGDHRWwJhVOioutXaThI2sgVCDXaZxvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aotLFHWNZmjLZPWVITzHuzPI9J/r8Nsf40TpLUwTD/xHT36IcFUMwduTY1Xw7MkcP9AaB+quTqYPyO0C3qJZkQC0PpXc3WK7ZthT5sW1gRL6HBKW3e1+/DRLX/7kf/NGt9+itm8gVbrEP3q1iAjNs4XmxjwuN7nJMzAGnjMvH3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8zmKtt8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C7DC433F1;
	Mon, 29 Jan 2024 15:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706541274;
	bh=AQDzrA2EHtRyGDHRWwJhVOioutXaThI2sgVCDXaZxvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r8zmKtt8lW/obv/Usya0+bk7UUBloZ+dobiV5pMDR79mYucLHzwIE6oWSCsK06rlf
	 E7qs0pTaK5eSihonnhV1zhhgzhcN0wxsqI1BDhYLsgjmOl+P3L87EAwoHGvNCj+lQS
	 aeyN+rU2DSC/32GIygFfquvronbiwZVJnQ8D2HXlfXwsAgX9psJhbePsMQAoxbt1aK
	 QcUML5GM/9h6KdMyJjXfTtxLYCXcrM/s8t0mTgQmx9OgBWthwQ9k1b+nfD2AvuoVxM
	 tacPf0YKJYeDuDlFQKuxSQ5xaz5Fzt9KtR17eA5xPP+GfKeIFTCWTjj3vHH7W5s1jN
	 jaVCUalrtP6Yw==
Date: Mon, 29 Jan 2024 16:14:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC PATCH] pidfd: implement PIDFD_THREAD flag for pidfd_open()
Message-ID: <20240129-autark-spachtel-c37fd31383cc@brauner>
References: <20240127105410.GA13787@redhat.com>
 <ZbUngjQMg+YUBAME@tycho.pizza>
 <20240127163117.GB13787@redhat.com>
 <ZbU7d0dpTY08JgIl@tycho.pizza>
 <20240127193127.GC13787@redhat.com>
 <ZbVrRgIvudX242ZU@tycho.pizza>
 <20240127210634.GE13787@redhat.com>
 <20240129112313.GA11635@redhat.com>
 <20240129-plakat-einlud-4903633a5410@brauner>
 <Zbe2x+M8tDBotSNZ@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zbe2x+M8tDBotSNZ@tycho.pizza>

On Mon, Jan 29, 2024 at 07:31:35AM -0700, Tycho Andersen wrote:
> On Mon, Jan 29, 2024 at 02:41:11PM +0100, Christian Brauner wrote:
> > On Mon, Jan 29, 2024 at 12:23:15PM +0100, Oleg Nesterov wrote:
> > > --- a/kernel/signal.c
> > > +++ b/kernel/signal.c
> > > @@ -2051,7 +2051,8 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
> > >  	WARN_ON_ONCE(!tsk->ptrace &&
> > >  	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
> > >  	/*
> > > -	 * tsk is a group leader and has no threads, wake up the pidfd waiters.
> > > +	 * tsk is a group leader and has no threads, wake up the !PIDFD_THREAD
> > > +	 * waiters.
> > >  	 */
> > >  	if (thread_group_empty(tsk))
> > >  		do_notify_pidfd(tsk);
> > > @@ -3926,6 +3927,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
> > >  		prepare_kill_siginfo(sig, &kinfo);
> > >  	}
> > >  
> > > +	/* TODO: respect PIDFD_THREAD */
> > 
> > So I've been thinking about this at the end of last week. Do we need to
> > give userspace a way to send a thread-group wide signal even when a
> > PIDFD_THREAD pidfd is passed? Or should we just not worry about this
> > right now and wait until someone needs this?
> 
> I don't need it currently, but it would have been handy for some of
> the tests I wrote.
> 
> Should I fix those up and send them too on top of Oleg's v2?

Sure, I don't mind.


Return-Path: <linux-kernel+bounces-47031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CE184483B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D94828282C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B7A3D982;
	Wed, 31 Jan 2024 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP7pYgXv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1AB3EA72;
	Wed, 31 Jan 2024 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706730396; cv=none; b=hFIw6/qMThqoz2H20hwP0dmt+fpSqMm1RWLbZDT09DvDp37DkZaWv2AZ9Sx+JS3F9dtfHwRdRClgpjb1FcQOsjqM0swdvzSDzmZG61wP/11tp5kx90skqPtpu/dhAxzoX36wxwB/IADALYheFkuoAGG18Wye0MwopxylqXJPt90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706730396; c=relaxed/simple;
	bh=MrJVjOYmYy/bvNM6pJMukJuxN8ZA76HtMBBN2aLTuNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0f9PJTl/434tgdsQIUZdiYkkEeYkCMmTXI+8dHI6QlS4Z7vLdXS/1aQ53+BRB6VOhy26v3CdM8v/kjpPv/8/ETG4Nd4tH7oGkJunyNPUbtJ4N0AJaQPeOE7/Q41M+ghgKbryStyeqC2j4st78B02W7t+Y6YdOjG56LYZ9G5W/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP7pYgXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9432C433F1;
	Wed, 31 Jan 2024 19:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706730395;
	bh=MrJVjOYmYy/bvNM6pJMukJuxN8ZA76HtMBBN2aLTuNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eP7pYgXvNLON2ZMDUD7YVxiRKg3OZbC9wXEbLIryeh1UlqtGnjYpBjjfIeM8OAA9y
	 GoJdZ43z2dx6kkakHTCOpbjU6QHvY3n7rQxDv9jgV7RipLhA+V6d8wroIo4jZ8rYGM
	 +Rv9KIsM0ItOCgxZYpIhyuqlN15Iob3r2dDCMf5jtm2YmWYkcRqj9ADtcJTPHLfOUP
	 vtZ8o2XRtKnHsy9/oDVJQpyZyeE2noMgaQ3h9+4KC5jatIDd3aFER3+0imJBY+ykpw
	 teDGL/USynGhX8xS+6TaIllgVF+7puXFown9HvggEqchapfyuOd3+DrVEjN1ssBeGw
	 bYipWVYxbiAUw==
Date: Wed, 31 Jan 2024 20:46:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Oleg Nesterov <oleg@redhat.com>, Tycho Andersen <tycho@tycho.pizza>, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	Tycho Andersen <tandersen@netflix.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC PATCH] pidfd: implement PIDFD_THREAD flag for pidfd_open()
Message-ID: <20240131-kerngesund-baumhaus-17a428b4aacb@brauner>
References: <20240127163117.GB13787@redhat.com>
 <ZbU7d0dpTY08JgIl@tycho.pizza>
 <20240127193127.GC13787@redhat.com>
 <ZbVrRgIvudX242ZU@tycho.pizza>
 <20240127210634.GE13787@redhat.com>
 <20240129112313.GA11635@redhat.com>
 <CALCETrUFDkt+K9zG8mczxzAFy9t-6Mx5Cz-Sx+it6a4nt+O0pg@mail.gmail.com>
 <20240131184829.GE2609@redhat.com>
 <20240131191405.GF2609@redhat.com>
 <CALCETrXTHsyiR6Bav7bXCCHny0Z2Bn90fTUL9__KTftESQ9=7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrXTHsyiR6Bav7bXCCHny0Z2Bn90fTUL9__KTftESQ9=7w@mail.gmail.com>

On Wed, Jan 31, 2024 at 11:24:48AM -0800, Andy Lutomirski wrote:
> > On 01/31, Oleg Nesterov wrote:
> > >
> > > On 01/31, Andy Lutomirski wrote:
> > > Please note
> > >
> > >       /* TODO: respect PIDFD_THREAD */
> > >
> > > this patch adds into pidfd_send_signal().
> > >
> > > See also this part of discussion
> > >
> > >       > > +   /* TODO: respect PIDFD_THREAD */
> > >       >
> > >       > So I've been thinking about this at the end of last week. Do we need to
> > >       > give userspace a way to send a thread-group wide signal even when a
> > >       > PIDFD_THREAD pidfd is passed? Or should we just not worry about this
> > >       > right now and wait until someone needs this?
> > >
> > >       I don't know. I am fine either way, but I think this needs a separate
> > >       patch and another discussion in any case. Anyway should be trivial,
> > >       pidfd_send_signal() has the "flags" argument.
> > >
> > > with Christian in https://lore.kernel.org/all/20240130112126.GA26108@redhat.com/
> 
> I missed that.  Whoops.
> 
> On Wed, Jan 31, 2024 at 11:15 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Forgot to mention...
> >
> > And I agree that pidfd_send_signal(flags => PGID/SID) can make
> > some sense too.
> >
> > But this a) doesn't depend on PIDFD_THREAD, and b) needs another
> > patch/discussion.
> >
> > But again, I am not sure I understood you correctly.
> >
> 
> Hmm.
> 
> When one works with regular (non-fd) pids / pgids etc, one specifies
> the signal domain at the time that one sends the signal.  I don't know
> what pidfds should do.  It seems a bit inefficient for anything that
> wants a pidfd and might send a signal in a different mode in the
> future to have to hold on to multiple pidfds, so it probably should be
> a pidfd_send_signal flag.
> 
> Which leaves the question of what the default should be.  Should
> pidfd_send_signal with flags = 0 on a PIDFD_THREAD signal the process
> or the thread?  I guess there are two reasonable solutions:
> 
> 1. flags = 0 always means process.  And maybe there's a special flag
> to send a signal that matches the pidfd type, or maybe not.
> 
> 2. flags = 0 does what the pidfd seems to imply, and a new
> PIDFD_SIGNAL_PID flag overrides it to signal the whole PID even if the
> pidfd is PIDFD_THREAD.
> 
> Do any of you have actual use cases in mind where one choice is
> clearly better than the other choice?

So conceptually I think having the type of pidfd dictate the default
scope of the signal is the most elegant approach. And then very likely
we should just have:

PIDFD_SIGNAL_THREAD
PIDFD_SIGNAL_THREAD_GROUP
PIDFD_SIGNAL_PROCESS_GROUP

I think for userspace it doesn't really matter as long as we clearly
document what's going on.

Thoughts?


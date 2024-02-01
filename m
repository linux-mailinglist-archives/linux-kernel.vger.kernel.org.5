Return-Path: <linux-kernel+bounces-48236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068FF8458EB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B2E290028
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749AE53370;
	Thu,  1 Feb 2024 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtSKeA5W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78825337F;
	Thu,  1 Feb 2024 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794251; cv=none; b=AVfSvDoC34ZR702lCOarUrgqfs/UyubdnR2zglHKTpLF+aW9wRm69axlmSZ0FBZO+WQQDPpOYOPyV3ahJs7EtIcjC3A3m0kk2dm//9BioVdmU9JpCCQ4NC5ilitGuIoejq3U6p5ZIv5+VHIfxfgVFtuXpruISI+qBdEJcGpp2bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794251; c=relaxed/simple;
	bh=qSWP0UMygc1rVnTpe1xs8RbYvOTFDK0trl+lULO8Nlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ty53j33m11y1LCrySHSsH977EW40UgvZr0rEwNmC2MzN4x3oJ5VAMsz+PCLBq2hnsPLxge3dhc51goKI5ARPvUzyWiFenolAx58LXdb4zSWrjUFcG0g7SGPOzHSnlmckE+sLMai1dLkSinGLsYWvGPil4ECq+cZqWbVx/0MS/mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtSKeA5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B62C433F1;
	Thu,  1 Feb 2024 13:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706794251;
	bh=qSWP0UMygc1rVnTpe1xs8RbYvOTFDK0trl+lULO8Nlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DtSKeA5WajRoq+1mzW0zDJ2TtSw+hB24d67Zc4Z7K2xP8D011YpprJWOlxnht1DkN
	 s9usml9RX0Rxa2v6SSQ7h2eib8PrxHdj7XnBdFGTlXiXuvRzsG2+fdAsL3zFqZAl9v
	 ZGC6PZqfWR85cFrFYg/jmUhutJdxkVES+w+ajX5m7S5KqC0Leg5CDTtyIPo92HlDBy
	 a56NstcYS4esI4zSwNHIelIjXu6Zni7vLKCIVdwh0agsxYe9YwFkYuqPUpKUBmxiVc
	 llbH3hOa+vf6B5QnQK09OybQZqePIdI7ZX7jAQq/cubhsTHTbvv6rw+LetHPIRMkhu
	 8qXiAdiB3csMA==
Date: Thu, 1 Feb 2024 14:30:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Oleg Nesterov <oleg@redhat.com>, Tycho Andersen <tycho@tycho.pizza>, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	Tycho Andersen <tandersen@netflix.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC PATCH] pidfd: implement PIDFD_THREAD flag for pidfd_open()
Message-ID: <20240201-laufleistung-gesessen-068ff127834d@brauner>
References: <20240127193127.GC13787@redhat.com>
 <ZbVrRgIvudX242ZU@tycho.pizza>
 <20240127210634.GE13787@redhat.com>
 <20240129112313.GA11635@redhat.com>
 <CALCETrUFDkt+K9zG8mczxzAFy9t-6Mx5Cz-Sx+it6a4nt+O0pg@mail.gmail.com>
 <20240131184829.GE2609@redhat.com>
 <20240131191405.GF2609@redhat.com>
 <CALCETrXTHsyiR6Bav7bXCCHny0Z2Bn90fTUL9__KTftESQ9=7w@mail.gmail.com>
 <20240131-kerngesund-baumhaus-17a428b4aacb@brauner>
 <CALCETrUh-DJ28W-LYZd3mACb4z-rmi4kmeUCitHjyufiN7U0sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrUh-DJ28W-LYZd3mACb4z-rmi4kmeUCitHjyufiN7U0sQ@mail.gmail.com>

On Wed, Jan 31, 2024 at 11:50:23AM -0800, Andy Lutomirski wrote:
> On Wed, Jan 31, 2024 at 11:46 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Wed, Jan 31, 2024 at 11:24:48AM -0800, Andy Lutomirski wrote:
> > > > On 01/31, Oleg Nesterov wrote:
> > > > >
> > > > > On 01/31, Andy Lutomirski wrote:
> > > > > Please note
> > > > >
> > > > >       /* TODO: respect PIDFD_THREAD */
> > > > >
> > > > > this patch adds into pidfd_send_signal().
> > > > >
> > > > > See also this part of discussion
> > > > >
> > > > >       > > +   /* TODO: respect PIDFD_THREAD */
> > > > >       >
> > > > >       > So I've been thinking about this at the end of last week. Do we need to
> > > > >       > give userspace a way to send a thread-group wide signal even when a
> > > > >       > PIDFD_THREAD pidfd is passed? Or should we just not worry about this
> > > > >       > right now and wait until someone needs this?
> > > > >
> > > > >       I don't know. I am fine either way, but I think this needs a separate
> > > > >       patch and another discussion in any case. Anyway should be trivial,
> > > > >       pidfd_send_signal() has the "flags" argument.
> > > > >
> > > > > with Christian in https://lore.kernel.org/all/20240130112126.GA26108@redhat.com/
> > >
> > > I missed that.  Whoops.
> > >
> > > On Wed, Jan 31, 2024 at 11:15 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > > >
> > > > Forgot to mention...
> > > >
> > > > And I agree that pidfd_send_signal(flags => PGID/SID) can make
> > > > some sense too.
> > > >
> > > > But this a) doesn't depend on PIDFD_THREAD, and b) needs another
> > > > patch/discussion.
> > > >
> > > > But again, I am not sure I understood you correctly.
> > > >
> > >
> > > Hmm.
> > >
> > > When one works with regular (non-fd) pids / pgids etc, one specifies
> > > the signal domain at the time that one sends the signal.  I don't know
> > > what pidfds should do.  It seems a bit inefficient for anything that
> > > wants a pidfd and might send a signal in a different mode in the
> > > future to have to hold on to multiple pidfds, so it probably should be
> > > a pidfd_send_signal flag.
> > >
> > > Which leaves the question of what the default should be.  Should
> > > pidfd_send_signal with flags = 0 on a PIDFD_THREAD signal the process
> > > or the thread?  I guess there are two reasonable solutions:
> > >
> > > 1. flags = 0 always means process.  And maybe there's a special flag
> > > to send a signal that matches the pidfd type, or maybe not.
> > >
> > > 2. flags = 0 does what the pidfd seems to imply, and a new
> > > PIDFD_SIGNAL_PID flag overrides it to signal the whole PID even if the
> > > pidfd is PIDFD_THREAD.
> > >
> > > Do any of you have actual use cases in mind where one choice is
> > > clearly better than the other choice?
> >
> > So conceptually I think having the type of pidfd dictate the default
> > scope of the signal is the most elegant approach. And then very likely
> > we should just have:
> >
> > PIDFD_SIGNAL_THREAD
> > PIDFD_SIGNAL_THREAD_GROUP
> > PIDFD_SIGNAL_PROCESS_GROUP
> >
> > I think for userspace it doesn't really matter as long as we clearly
> > document what's going on.
> >
> 
> This seems reasonable unless we're likely to end up with a pidfd mode
> that doesn't actually make sense in a send_signal context.  But I'm
> not immediately seeing any reason that that would happen.

Yeah, I think that's very unlikely and we could reject it obased on api
design considerations.


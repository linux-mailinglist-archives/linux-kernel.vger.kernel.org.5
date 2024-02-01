Return-Path: <linux-kernel+bounces-48248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5737684591A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9434FB23625
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539EA5CDEB;
	Thu,  1 Feb 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaYaVXeU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1935CDDF;
	Thu,  1 Feb 2024 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794783; cv=none; b=POsIUwJ4NLQDTf28Z5ROB+vn+smdH2Hs3Rfr71n2nCnU5rkmBnlIXHZFJjAATuWPv4evi0YREfhvHxKCaFWoj8M/TSHDUfYhI6Fp2qRn1pS4syleBTnWzTSYjqWW8/lEO+QWaENgkEUKlG01vATSAdzL5fuuKD1zlW9z+O3HLBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794783; c=relaxed/simple;
	bh=BUkE/Xpzymhf97gyWTzOU0lzoCLr2KeP3XwTRm8ZRzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U15K4pvzVgpPH4KGzsEe3R4+8X/kUOPok3pp1yJsRzrYmiEzefGQAx9hfF9PbWL2wyDCKuHkJphGEDIJsrjdftP1NYIEnqp+QtB/5/9IDMOfuikNUE4jnCbqithD+3GTjsRlNAweRu/E7A6YV37MohUeqyrJY3+ceIw1xeSN2jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaYaVXeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B31C43390;
	Thu,  1 Feb 2024 13:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706794783;
	bh=BUkE/Xpzymhf97gyWTzOU0lzoCLr2KeP3XwTRm8ZRzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IaYaVXeU7p5Q0k/HLCbrouG7OlzpP3rh9ABm6TITfHuEZtf+5Jbu/TwGh7FkP5u4u
	 iVdV6dBxlQm38CjHt04sxlBdO3CWjNno2/SGfhFKqYzHozbOIJ6RG1ceZCn0bHhkuk
	 hC975/ZTotkb7bKJ4sAZAZfVioz/iohcKsbfukVHGeh8EKVjaOYyA7yzx6Eqbqs8u8
	 329moUtiF4SZ7z1hiXaLrBLiLBbUS8IXdby4Et6cQPxwEXbUW5Dtz57pC+iesb/Jap
	 f3M/NQl/XD/M51QKFOv4FaqMcrpgm5fnbVBhoywiLRksvHd3ETDye/hRqsFZynL7d3
	 VfoxFYr56d+pQ==
Date: Thu, 1 Feb 2024 14:39:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Oleg Nesterov <oleg@redhat.com>, Tycho Andersen <tycho@tycho.pizza>, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	Tycho Andersen <tandersen@netflix.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC PATCH] pidfd: implement PIDFD_THREAD flag for pidfd_open()
Message-ID: <20240201-flugzeit-modeschau-dab703fc8b6d@brauner>
References: <ZbVrRgIvudX242ZU@tycho.pizza>
 <20240127210634.GE13787@redhat.com>
 <20240129112313.GA11635@redhat.com>
 <CALCETrUFDkt+K9zG8mczxzAFy9t-6Mx5Cz-Sx+it6a4nt+O0pg@mail.gmail.com>
 <20240131184829.GE2609@redhat.com>
 <20240131191405.GF2609@redhat.com>
 <CALCETrXTHsyiR6Bav7bXCCHny0Z2Bn90fTUL9__KTftESQ9=7w@mail.gmail.com>
 <20240131-kerngesund-baumhaus-17a428b4aacb@brauner>
 <CALCETrUh-DJ28W-LYZd3mACb4z-rmi4kmeUCitHjyufiN7U0sQ@mail.gmail.com>
 <20240201-laufleistung-gesessen-068ff127834d@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240201-laufleistung-gesessen-068ff127834d@brauner>

On Thu, Feb 01, 2024 at 02:30:46PM +0100, Christian Brauner wrote:
> On Wed, Jan 31, 2024 at 11:50:23AM -0800, Andy Lutomirski wrote:
> > On Wed, Jan 31, 2024 at 11:46 AM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Wed, Jan 31, 2024 at 11:24:48AM -0800, Andy Lutomirski wrote:
> > > > > On 01/31, Oleg Nesterov wrote:
> > > > > >
> > > > > > On 01/31, Andy Lutomirski wrote:
> > > > > > Please note
> > > > > >
> > > > > >       /* TODO: respect PIDFD_THREAD */
> > > > > >
> > > > > > this patch adds into pidfd_send_signal().
> > > > > >
> > > > > > See also this part of discussion
> > > > > >
> > > > > >       > > +   /* TODO: respect PIDFD_THREAD */
> > > > > >       >
> > > > > >       > So I've been thinking about this at the end of last week. Do we need to
> > > > > >       > give userspace a way to send a thread-group wide signal even when a
> > > > > >       > PIDFD_THREAD pidfd is passed? Or should we just not worry about this
> > > > > >       > right now and wait until someone needs this?
> > > > > >
> > > > > >       I don't know. I am fine either way, but I think this needs a separate
> > > > > >       patch and another discussion in any case. Anyway should be trivial,
> > > > > >       pidfd_send_signal() has the "flags" argument.
> > > > > >
> > > > > > with Christian in https://lore.kernel.org/all/20240130112126.GA26108@redhat.com/
> > > >
> > > > I missed that.  Whoops.
> > > >
> > > > On Wed, Jan 31, 2024 at 11:15 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > > > >
> > > > > Forgot to mention...
> > > > >
> > > > > And I agree that pidfd_send_signal(flags => PGID/SID) can make
> > > > > some sense too.
> > > > >
> > > > > But this a) doesn't depend on PIDFD_THREAD, and b) needs another
> > > > > patch/discussion.
> > > > >
> > > > > But again, I am not sure I understood you correctly.
> > > > >
> > > >
> > > > Hmm.
> > > >
> > > > When one works with regular (non-fd) pids / pgids etc, one specifies
> > > > the signal domain at the time that one sends the signal.  I don't know
> > > > what pidfds should do.  It seems a bit inefficient for anything that
> > > > wants a pidfd and might send a signal in a different mode in the
> > > > future to have to hold on to multiple pidfds, so it probably should be
> > > > a pidfd_send_signal flag.
> > > >
> > > > Which leaves the question of what the default should be.  Should
> > > > pidfd_send_signal with flags = 0 on a PIDFD_THREAD signal the process
> > > > or the thread?  I guess there are two reasonable solutions:
> > > >
> > > > 1. flags = 0 always means process.  And maybe there's a special flag
> > > > to send a signal that matches the pidfd type, or maybe not.
> > > >
> > > > 2. flags = 0 does what the pidfd seems to imply, and a new
> > > > PIDFD_SIGNAL_PID flag overrides it to signal the whole PID even if the
> > > > pidfd is PIDFD_THREAD.
> > > >
> > > > Do any of you have actual use cases in mind where one choice is
> > > > clearly better than the other choice?
> > >
> > > So conceptually I think having the type of pidfd dictate the default
> > > scope of the signal is the most elegant approach. And then very likely
> > > we should just have:
> > >
> > > PIDFD_SIGNAL_THREAD
> > > PIDFD_SIGNAL_THREAD_GROUP
> > > PIDFD_SIGNAL_PROCESS_GROUP
> > >
> > > I think for userspace it doesn't really matter as long as we clearly
> > > document what's going on.
> > >
> > 
> > This seems reasonable unless we're likely to end up with a pidfd mode
> > that doesn't actually make sense in a send_signal context.  But I'm
> > not immediately seeing any reason that that would happen.
> 
> Yeah, I think that's very unlikely and we could reject it obased on api
> design considerations.

Ah, forgot to ask. Did you intend to send a patch for this?


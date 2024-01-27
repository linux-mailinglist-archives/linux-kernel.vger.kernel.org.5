Return-Path: <linux-kernel+bounces-41210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8747983ED75
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F2A1F228AC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D597325777;
	Sat, 27 Jan 2024 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAOvGxoZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF8249EB;
	Sat, 27 Jan 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706365603; cv=none; b=SOy8b6hPGWzPaLW/JxGbFKuAZCppz+sgDR/7IMccqG4I4a8TuqtKnsM6TjsP1/j5m45HN55tuIhf/X6Vk2jx8INCSjDQ6gbpaMROfol+1bs953WVfSKUqxBhNaj2pZX4Co+sJsE0Y6EFylWlc6JubFdOxwvqvJH/mrSFbC3Atdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706365603; c=relaxed/simple;
	bh=PKVZoCBbX+mtmDXwZZACj6MA0T7kPvdIGs08J1upc1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWfWiAbK4VCnLJ/7PoasSdgAbdi3PbD58AJJ8fOjzgxSv5sXP46eirXccSJD2n3RJMksle1C70M3mfx5B4TvAzfrZnNKLpIzLk0hAFcVkqG0nFn7Vb87dk6vuDm5GSQf8/2TF43dId2XAOUQ8ECEp1RQXOUHI0FuisJkSBBk6L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAOvGxoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E07C433F1;
	Sat, 27 Jan 2024 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706365602;
	bh=PKVZoCBbX+mtmDXwZZACj6MA0T7kPvdIGs08J1upc1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KAOvGxoZqyU13pxAyFcECYv8maEwBWtzAFflblt5D+C4l6SsDJlUDXmsttRgum4K+
	 BH1FYaL9fxgNDurNaMqlqetMikr/GDUPDenbMQIUK2+Gz40olqI194SyO/dAVz8UG0
	 FYHO4180v3m6lHhAUaHW4YwpLR3+PHM3uE84vlYqy9Orz6h/fkkXmZyvRo+RTSybh4
	 kN1DCXWhG5nySPLwjSlEs2kiyGv9uxretFJnZjxQWOO1Lm1zV6qY+uf2rk9trmaMPH
	 SUMIpG78GKBWUsTAKxg1yz8q8qDwJRBFyPe9lk9A7xr0w38xDG57s0wKJA6fMvVWBF
	 YQ9XHBGVI9yjQ==
Date: Sat, 27 Jan 2024 15:26:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240127-welpen-seitlich-cd8707e09d1a@brauner>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <20240126-kulinarisch-ausziehen-d2af51882d2f@brauner>
 <20240126143349.GD7386@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240126143349.GD7386@redhat.com>

On Fri, Jan 26, 2024 at 03:33:50PM +0100, Oleg Nesterov wrote:
> On 01/26, Christian Brauner wrote:
> >
> > > --- a/include/uapi/linux/pidfd.h
> > > +++ b/include/uapi/linux/pidfd.h
> > > @@ -7,6 +7,7 @@
> > >  #include <linux/fcntl.h>
> > >
> > >  /* Flags for pidfd_open().  */
> > > -#define PIDFD_NONBLOCK O_NONBLOCK
> > > +#define PIDFD_NONBLOCK	O_NONBLOCK
> > > +#define PIDFD_THREAD	O_EXCL	// or anything else not used by anon_inode's
> >
> > I like it!
> >
> > The only request I would have is to not alias O_EXCL and PIDFD_THREAD.
> > Because it doesn't map as clearly as NONBLOCK did.
> 
> But it would be nice to have PIDFD_THREAD in file->f_flags. Where else
> can we keep it?

No, I did just mean that the uapi value doesn't necessarily have to
reflect what we do internally. IOW, we can still raise O_EXCL internally
in ->f_flags but there's no need to expose it as O_EXCL to userspace. We
often have internal and external flag spaces. If you prefer it your way
I'm not going argue.

> I chose O_EXCL because it can only be used at open time, it can never
> be used or changed after anon_inode_getfile(), so we can safely do
> 
> 	pidfd_file->f_flags |= PIDFD_THREAD;
> 
> in __pidfd_prepare() and then check in pidfd_poll/pidfd_send_signal.
> 
> What do you suggest instead?

(Long-term and unrelated to this here, I think we will need to consider
not just stashing struct pid in pidfd_file->private_data but instead
struct pid with additional data because there's various functionality
that users would like that requires additional state to be stored and we
can't or don't want to do that in struct pid directly.)


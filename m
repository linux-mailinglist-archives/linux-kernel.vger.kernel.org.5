Return-Path: <linux-kernel+bounces-159348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0448B2D66
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429961C21231
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7D2155A5B;
	Thu, 25 Apr 2024 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LQzwav1f"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D48A21101
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 23:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714086139; cv=none; b=SxIvvg2njAcuM19prmNh0gQCUeMU2X6oSDJfwveRv/2LHX2532U1pNTBBbtGCsT5cDSxtDy0SE3wAFsOsMaY+UBDstm32j/iooelzdUtj4WaoYj9/HbKzoW6s4/qFe6E5gN7K9XoGGkZJ6Z4HZ1/xPt/S74THDtAwHYi2Rnhafc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714086139; c=relaxed/simple;
	bh=uxeztvRb3eyrZP9bERk3uZ+o+Kjfa0S++tnI3Se96Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mU5b86erxKh2vb9YANOJBE4rfTgfrjTfqzjcl200ekfOf4MAnvIyBwg/mt1ZnCLmoGKm8wtV1DorHr8G1nWU13AxxaNiC7DxkhoyK1JZAUS5Zjp5W+soYpWtsmYmR0hZOeK2LZB0MeTz0cDAo+iDfAM6yowyvX0PPZyC1Rbm784=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LQzwav1f; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Apr 2024 19:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714086135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LpJuczygft6uvJ+kYNy8tIrOLm/I4V/OfFghGJXmUzs=;
	b=LQzwav1fL9PD/8a5F5OK4YdA/1WGV37oPGjaeIagx/UcWmWYJHI6tFClAzGPd7XLZgc9h1
	6B4wXL4pMttVtzjuMT6PYu36DxMgw0y0IOHVrDSfWeNE9zKzur2UBVWiTeG1CCxfY7Vazr
	u6FJ3NL7tXgCbHLGrDbC/zj5zODZADg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <fofcw327c7cqa6vxlfiat6mrrjx6rgnhe6ylhqbfw4qngamhjg@6wkh6rcosqfp>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
 <ZirCbPR1XwX2WJSX@casper.infradead.org>
 <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
 <202404251532.F8860056AE@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404251532.F8860056AE@keescook>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 25, 2024 at 03:42:30PM -0700, Kees Cook wrote:
> On Thu, Apr 25, 2024 at 05:04:47PM -0400, Kent Overstreet wrote:
> > On Thu, Apr 25, 2024 at 09:51:56PM +0100, Matthew Wilcox wrote:
> > > On Thu, Apr 25, 2024 at 04:45:51PM -0400, Kent Overstreet wrote:
> > > > On Thu, Apr 25, 2024 at 01:08:50PM -0700, Kees Cook wrote:
> > > > > The /proc/allocinfo file exposes a tremendous about of information about
> > > > > kernel build details, memory allocations (obviously), and potentially
> > > > > even image layout (due to ordering). As this is intended to be consumed
> > > > > by system owners (like /proc/slabinfo), use the same file permissions as
> > > > > there: 0400.
> > > > 
> > > > Err...
> > > > 
> > > > The side effect of locking down more and more reporting interfaces is
> > > > that programs that consume those interfaces now have to run as root.
> > > 
> > > sudo cat /proc/allocinfo | analyse-that-fie
> > 
> > Even that is still an annoyance, but I'm thinking more about a future
> > daemon to collect this every n seconds - that really shouldn't need to
> > be root.
> 
> Open it once and rewind? But regardless, see the end about changing
> ownership/perms/etc.
> 
> > And the "lock everything down" approach really feels like paranoia gone
> > too far - what's next, /proc/cpuinfo? Do we really want to go the
> > Windows approach of UAC pop ups for everything? I'd rather be going the
> > opposite direction, of making it as easy as possible for users to see
> > what's going on with their machine.
> 
> Not unless there's something in /proc/cpuinfo that can't be extracted
> in other methods. :) Anyway, you're offering a slippery-slope argument,
> I just want to avoid new interfaces from having needlessly permissive
> default access permissions.

No, I'm asking where the line is and how we decide what we want to
restrict. I hope you agree that it shouldn't be everything?

I'm pushing hard for making things easier to debug, and making it easier
for normal users to poke around and see what their system is doing.
Simpler, easier to understand tools, tools that teach users how the
system works. In my book, anything that lowers that barrier to entry is
a good thing.

I've had a lot of positive, useful interactions from this, and by
talking with users about what they see (I'm _always_ on IRC, and my
channel is pretty active). I can't overstate how useful this sort of
thing is, because there's only so many of us developers and users will
notice things that we don't - sometimes quite significant things! and if
we focus on making the system easy to debug, often times they'll do a
lot of that debugging for us.

Feeding user's curiosity pays great dividends in the long run.

And on the usability side, we've done a lot over the years to nudge
people away from running as root; if we set things up so that prefixing
every command with 'sudo' becomes the default, then we really lose out
on much of the benefit of that.

> I expect this to be enabled by default in distros, etc, so I'd like
> to make sure it's not giving attackers more information than they
> had before. Even reporting how much has been allocated at a specific
> location means an attacker ends up with extremely accurate information
> when attempting heap grooming, etc. Even the low granularity of slabinfo
> is sufficient to improve attacks. (Which is why it's 0400 by default too.)

This is pretty esoteric stuff to me; what users should be remotely
concerned about heap grooming attacks on their personal machines?

When we let the memory-unsafety of C (as well as spectre/meltdown)
dominate system design, the result is... not good. Those are things that
need to be fixed at the root (and, thank Rust, _are_), so let's maybe
not go _too_ overboard otherwise it's going to take another couple
decades to unwind all the resulting stockholm syndrome.

> > Instead, why not a sysctl, like we already have for perf?
> 
> perf is a whole other beast, including syscalls, etc.

But semantically it's the exact same thing. With perf we've got a knob
to say "I'm not paranoid on this machine, I don't want users to have to
be able to root to do basic debugging" - why not lean into that?

Have a global knob that's more than just for perf, so single user and
desktop machines can probably leave it loose (or even expose it in the
distro installer) and servers can have it on.

Give users a way to say what they want.

> > The concern about leaking image layout could be addressed by sorting the
> > output before returning to userspace.
> 
> It's trivial to change permissions from the default 0400 at boot time.
> It can even have groups and ownership changed, etc. This is why we have
> per-mount-namespace /proc instances:
> 
> # chgrp sysmonitor /proc/allocinfo
> # chmod 0440 /proc/allocinfo
> 
> Poof, instant role-based access control. :)

The trouble is that the average user isn't going to know what reporting
interfaces it's safe to do that with; we don't want to encourage that
kind of mucking around by the unsuspecting. We really should have a
knob.


Return-Path: <linux-kernel+bounces-16667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2779182421D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABBE3B244E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EBA2232C;
	Thu,  4 Jan 2024 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="SZrSYppm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7DC22324;
	Thu,  4 Jan 2024 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1704372628; bh=2rIYho0tJC4fQVeP6/cBbLHX5whOI1hHP2hPbbpgze8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZrSYppmG8kRGCUnosr7aniaaMeadcFKNVy6SrMe0d79B4F/ByDaAeDIGTX/P8e7I
	 PJgo+r+eT2+uz3IsN65cwhk75HOmuguHYscVpN9fsAwoxjxS+WSto/KiQsIcRQHAfZ
	 6lX1MZG2Z5lNSpxrW28GC3VClCxPkEVO9z9FDqO/5StIj7zdcUjTMxAsvfQBJKq81q
	 ufyR0eMIKfjOXLtEWz6cLRQ8xdU2Zk+R7Ebg1Okla5Iy/gDbSxmYEQQlHb2k+MH6bp
	 xhOV1HF11uummEJ1SAyhW1W5aDsEK84tKOqMwC7Pg2qw+Dmi5g4BfvF4eP2a7lryxg
	 G5v0Fqb9AInFg==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 1760F1000FC; Thu,  4 Jan 2024 12:50:28 +0000 (GMT)
Date: Thu, 4 Jan 2024 12:50:28 +0000
From: Sean Young <sean@mess.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Flavio Suligoi <f.suligoi@asem.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: (subset) linux-next: build failure after merge of the pwm tree
Message-ID: <ZZaplFvjLADNz-2m@gofer.mess.org>
References: <20231221165805.0c4771c1@canb.auug.org.au>
 <170316329164.542553.8341559295114557258.b4-ty@kernel.org>
 <20231221125801.GG10102@google.com>
 <ZYSFUZf8NcK5vvLv@orome.fritz.box>
 <ZZaCQahr3t8CUumD@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZaCQahr3t8CUumD@archie.me>

On Thu, Jan 04, 2024 at 05:02:41PM +0700, Bagas Sanjaya wrote:
> [also add Jingoo (additional backlight maintainer) and Linus]
> 
> On Thu, Dec 21, 2023 at 07:34:57PM +0100, Thierry Reding wrote:
> > On Thu, Dec 21, 2023 at 12:58:01PM +0000, Lee Jones wrote:
> > > On Thu, 21 Dec 2023, Lee Jones wrote:
> > > 
> > > > On Thu, 21 Dec 2023 16:58:05 +1100, Stephen Rothwell wrote:
> > > > > After merging the backlight tree, today's linux-next build (x86_64
> > > > > allmodconfig) failed like this:
> > > > > 
> > > > > drivers/video/backlight/mp3309c.c: In function 'mp3309c_bl_update_status':
> > > > > drivers/video/backlight/mp3309c.c:134:23: error: implicit declaration of function 'pwm_apply_state'; did you mean 'pwm_apply_args'? [-Werror=implicit-function-declaration]
> > > > >   134 |                 ret = pwm_apply_state(chip->pwmd, &pwmstate);
> > > > >       |                       ^~~~~~~~~~~~~~~
> > > > >       |                       pwm_apply_args
> > > > > 
> > > > > [...]
> > > > 
> > > > Applied, thanks!
> > > > 
> > > > [1/1] linux-next: build failure after merge of the pwm tree
> > > >       commit: f7baa9ccef93ba1c36a8ecf58c2f4e86fb3181b9
> > > 
> > > Actually it's:
> > > 
> > >   f7baa9ccef93b ("backlight: mp3309c: Rename  pwm_apply_state() to pwm_apply_might_sleep()")
> > > 
> > > But don't bank on the commit ID staying the same.
> > 
> > This is likely going to break the build on your branch because
> > pwm_apply_might_sleep() is only available in the PWM tree right now. In
> > any case, I've now pushed a commit that adds pwm_apply_state() back as a
> > compatibility stub, so it should be okay for you to drop this if you
> > run into problems. It's always possible that somebody else wants to add
> > a new caller of pwm_apply_state() and in retrospect we should've
> > probably done this from the start, at least as a transitional measure
> > for one or two cycles.
> > 
> 
> Hi Lee and Thierry,
> 
> I know that we're still on New Year vibes, so some things are not up to full
> steam for now; but since we're close to v6.7 release and v6.8 merge window,
> hence allow me to ask:
> 
> Stephen Rothwell is still complaining about backlight tree build failure
> due to f7baa9ccef93b, yet it has not been fixed so far. Has the culprit
> been dropped/reverted as he requested? The worst case is the culprit slips
> through and become part of backlight PR and Linus will likely not happy
> with the build regression (maybe he had to fix by himself).

This should be fixed by 9a216587a03df, and on current linux-next I can't 
reproduce the problem any more (x86_64 allmodconfig).

Thanks,
Sean


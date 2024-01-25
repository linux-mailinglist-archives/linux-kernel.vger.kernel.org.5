Return-Path: <linux-kernel+bounces-38908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A297183C844
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC03B20DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203351292F6;
	Thu, 25 Jan 2024 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DO8PBK/6"
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D667CF13
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200755; cv=none; b=ayjxPYQXP9C00uLQikwlNd1I2Rr88ZYy3CEqooGOhTtiigv00dtYtqGDC1iiV3L8sSk9oCvDT2dd3IYJqM0A6EFQt2v744mbH7Ma15+qBuwI744XegcMUYCFNBOXVNeBB3qfQaU3I1jm2xZmhTZ1tNRvOsu6M3fwynJPwXQ1V/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200755; c=relaxed/simple;
	bh=du31PmGw/fTX+38J7um3nXoKGi9MdQjFP4Xk4imtbeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzt+7eiE2OBEiG9McdR+mH0MwsRP2+LfiZIImXAFmzxYseMPUKdQ0cTs6rNl4NqdUyJU/DbXA0Auguj+8fSVb6/sPaEE4x7oCXPMZrM1XUvlte6/fl1Eeh2pyuBRR3vRxIZMmPzsEvVaj7ZhknRbAoNivMWEXGshbo7EqTRJUhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DO8PBK/6; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TLRNh6dy5zMqbBv;
	Thu, 25 Jan 2024 17:39:00 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TLRNd3PKVz3f;
	Thu, 25 Jan 2024 17:38:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1706200740;
	bh=du31PmGw/fTX+38J7um3nXoKGi9MdQjFP4Xk4imtbeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DO8PBK/6IihpHWk1hJ0RnfwFUiEI5PVdOR0kOr5uSXu696eAYNVKL8OoG3hr3ZBqO
	 7NLJ7YfkSQETMHL9do9sD+BxXeEVD0vF42DMEasjGMEl5UxF22smEjqqzNtUjAU2ww
	 o3XlB60Dumm/C8JlxtzDsXde456a7Bm2+fmY5HgU=
Date: Thu, 25 Jan 2024 17:38:53 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Josh Triplett <josh@joshtriplett.org>, 
	Kevin Locke <kevin@kevinlocke.name>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Re: [PATCH] exec: Check __FMODE_EXEC instead of in_execve for
 LSMs
Message-ID: <20240125.bais0ieKahz7@digikod.net>
References: <20240124192228.work.788-kees@kernel.org>
 <CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com>
 <202401241206.031E2C75B@keescook>
 <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
 <202401241310.0A158998@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202401241310.0A158998@keescook>
X-Infomaniak-Routing: alpha

On Wed, Jan 24, 2024 at 01:32:02PM -0800, Kees Cook wrote:
> On Wed, Jan 24, 2024 at 12:47:34PM -0800, Linus Torvalds wrote:
> > On Wed, 24 Jan 2024 at 12:15, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Hmpf, and frustratingly Ubuntu (and Debian) still builds with
> > > CONFIG_USELIB, even though it was reported[2] to them almost 4 years ago.
> 
> For completeness, Fedora hasn't had CONFIG_USELIB for a while now.
> 
> > Well, we could just remove the __FMODE_EXEC from uselib.
> > 
> > It's kind of wrong anyway.
> 
> Yeah.
> 
> > So I think just removing __FMODE_EXEC would just do the
> > RightThing(tm), and changes nothing for any sane situation.
> 
> Agreed about these:
> 
> - fs/fcntl.c is just doing a bitfield sanity check.
> 
> - nfs_open_permission_mask(), as you say, is only checking for
>   unreadable case.
> 
> - fsnotify would also see uselib() as a read, but afaict,
>   that's what it would see for an mmap(), so this should
>   be functionally safe.
> 
> This one, though, I need some more time to examine:
> 
> - AppArmor, TOMOYO, and LandLock will see uselib() as an
>   open-for-read, so that might still be a problem? As you
>   say, it's more of a mmap() call, but that would mean
>   adding something a call like security_mmap_file() into
>   uselib()...

If user space can emulate uselib() without opening a file with
__FMODE_EXEC, then there is no security reason to keep __FMODE_EXEC for
uselib().

Removing __FMODE_EXEC from uselib() looks OK for Landlock.  We use
__FMODE_EXEC to infer if a file is being open for execution i.e., by
execve(2).

If __FMODE_EXEC is removed from uselib(), I think it should also be
backported to all stable kernels for consistency though.


> 
> The issue isn't an insane "support uselib() under AppArmor" case, but
> rather "Can uselib() be used to bypass exec/mmap checks?"
> 
> This totally untested patch might give appropriate coverage:
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index d179abb78a1c..0c9265312c8d 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -143,6 +143,10 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
>  	if (IS_ERR(file))
>  		goto out;
>  
> +	error = security_mmap_file(file, PROT_READ | PROT_EXEC, MAP_FIXED | MAP_SHARED);
> +	if (error)
> +		goto exit;
> +
>  	/*
>  	 * may_open() has already checked for this, so it should be
>  	 * impossible to trip now. But we need to be extra cautious
> 
> > Of course, as you say, not having CONFIG_USELIB enabled at all is the
> > _truly_ sane thing, but the only thing that used the FMODE_EXEC bit
> > were landlock and some special-case nfs stuff.
> 
> Do we want to attempt deprecation again? This was suggested last time:
> https://lore.kernel.org/lkml/20200518130251.zih2s32q2rxhxg6f@wittgenstein/
> 
> -Kees
> 
> -- 
> Kees Cook
> 


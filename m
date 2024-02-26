Return-Path: <linux-kernel+bounces-82038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46114867E11
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716471C2C9DA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B609712F370;
	Mon, 26 Feb 2024 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ByQIpJxH"
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2839512DD9B;
	Mon, 26 Feb 2024 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967785; cv=none; b=OYWbq0eefxvevwD/ad/IjcCxVCCNogezKBmu41Ig4rlamd2tM6dptBzO5tRfz5xGMtKSxzaBcFt/NJyfGqPjN0A0Vhte5qauD//gqA5vDeOtwoizqY8heI82C1v5TO8wMW6dNAkmh0PNBjy439HgtCe8ONXJxCGmSlP6i2RSeAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967785; c=relaxed/simple;
	bh=oE8hrpoUSR9N67ZJZXv3erGxT2tzDmf9YxuB+DY4Wss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBCwELn0zFcHWWfxc76+7F3kjX9TWx2c8IoaIm9E1lzybn3HV5iEmYGFxqSmu919hNPD/gh3pK1i1OHvuxaGA9/PZwUzAMDEabrW0NvGRpLZWuKy/gui0x5uDra+SLDUlNZ5KW8gLjrcWt1jtWYJMJFa998F1vVC++VyOBKKXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ByQIpJxH; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tk6hz36YLzMq1N3;
	Mon, 26 Feb 2024 18:16:19 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tk6hy5x0KzMpnPs;
	Mon, 26 Feb 2024 18:16:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708967779;
	bh=oE8hrpoUSR9N67ZJZXv3erGxT2tzDmf9YxuB+DY4Wss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ByQIpJxHSGgdthDGkZsHgkIajVMAPN9ctSDwfU4e9sd4231s+G/sTgW6XXXwu0C2a
	 nv524ywUOinsIC/TRRPPcIrN4c+EcCGNz2TxguG4qEYDgkRNC3W3r+5zwwT5J5JrLr
	 /3OrmT/Y5n1Dgmtf8zFBK0GmQmpMPXhbi4qYc/2s=
Date: Mon, 26 Feb 2024 18:16:10 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <keescook@chromium.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Shervin Oloumi <enlightened@chromium.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] landlock: Warn once if a Landlock action is requested
 while disabled
Message-ID: <20240226.wu2ageiPi6Ch@digikod.net>
References: <20240219191804.2978911-1-mic@digikod.net>
 <202402191304.ED03339B@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202402191304.ED03339B@keescook>
X-Infomaniak-Routing: alpha

On Mon, Feb 19, 2024 at 01:07:48PM -0800, Kees Cook wrote:
> On Mon, Feb 19, 2024 at 08:18:04PM +0100, Mickaël Salaün wrote:
> > Because sandboxing can be used as an opportunistic security measure,
> > user space may not log unsupported features.  Let the system
> > administrator know if an application tries to use Landlock but failed
> > because it isn't enabled at boot time.  This may be caused by bootloader
> > configurations with outdated "lsm" kernel's command-line parameter.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 265885daf3e5 ("landlock: Add syscall implementations")
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  security/landlock/syscalls.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> > index f0bc50003b46..b5b424819dee 100644
> > --- a/security/landlock/syscalls.c
> > +++ b/security/landlock/syscalls.c
> > @@ -33,6 +33,18 @@
> >  #include "ruleset.h"
> >  #include "setup.h"
> >  
> > +static bool is_not_initialized(void)
> > +{
> > +	if (likely(landlock_initialized))
> > +		return false;
> > +
> > +	pr_warn_once(
> > +		"Disabled but requested by user space. "
> > +		"You should enable Landlock at boot time: "
> > +		"https://docs.kernel.org/userspace-api/landlock.html#kernel-support\n");
> 
> Perhaps update this docs to be really explicit with a example, maybe...
> 
> If `landlock` is not present in `CONFIG_LSM`, you can add it. For
> example, if this was the current config::
> 
>   $ zgrep -h ^CONFIG_LSM= /boot/config-$(uname -r) /proc/config.gz 2>/dev/null
>   CONFIG_LSM="lockdown,yama,integrity,apparmor"
> 
> You can boot with::
> 
>   lsm=landlock,lockdown,yama,integrity,apparmor
> 

Indeed, I'll send a dedicated patch and update the link accordingly.

> 
> I *still* wish we had the "+" operator for lsm=. It would be SO much
> easier to say "boot with lsm=+landlock". *shrug*

I guess it's still possible and it would need to be backported to be
more useful.

> 
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> -- 
> Kees Cook
> 


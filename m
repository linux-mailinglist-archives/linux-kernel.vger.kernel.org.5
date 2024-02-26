Return-Path: <linux-kernel+bounces-82021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0122A867DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992DF28ABE0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F4160DC5;
	Mon, 26 Feb 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="J5hwbTHq"
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEFA12F366
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967154; cv=none; b=TMyjAJS0e0BSQrxxNQJn4ZhqsiuN55AASlAZjLTAZFxBRp+Q+wSwPWU5BX/1tZTCwgMGecx0aTI6XYllDEZ9aiDKiK0OMFpPSCuND/5moxNkBZmo8gnpJaj1s9oqyyc/8oQLvrFlwKmo+T5MXI1zgV4mIz/yXoITNBma9CaeKEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967154; c=relaxed/simple;
	bh=TEpQO8oVhWg12vbtVS68hwoIFoQZycElKAGrNEzuM9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu08EbTRR1f5T5i0TM5ro1EFmohg+DfamccSuBmWYBaGU21Mr9rvQFOSOef4S6Z4YB8NqQA2H92ZBXfxDDiq3P3WDJZzFffak3NEDn+6Vr81yl2WqSiuX6aanUDqRLr7kvcBOowXGVgRDIasu58rl8rYqBRubJtvJ3yXMWXEMuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=J5hwbTHq; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tk6Sk4MjfzQkL;
	Mon, 26 Feb 2024 18:05:42 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tk6Sj5blNz1sr;
	Mon, 26 Feb 2024 18:05:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708967142;
	bh=TEpQO8oVhWg12vbtVS68hwoIFoQZycElKAGrNEzuM9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5hwbTHqlvYD7XVRvMUl+1yLrl1IYNrSHFaPd8XOBjVbSlYpYstl5VbR9fB/ZR0zT
	 JMGK2lOQSwEMUYdDl7Dyk0mcgPxC3oA1Jqi097/QPKxFi0rLGPUkh6CUmXtp72Ifs7
	 JsByWA9GE4IGe2H/Z8jBwKANLAlE0JkMPCdJXydE=
Date: Mon, 26 Feb 2024 18:05:33 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Shervin Oloumi <enlightened@chromium.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] landlock: Warn once if a Landlock action is requested
 while disabled
Message-ID: <20240226.Ceemai4ahxei@digikod.net>
References: <20240219191804.2978911-1-mic@digikod.net>
 <20240221.b8dcd9590c37@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221.b8dcd9590c37@gnoack.org>
X-Infomaniak-Routing: alpha

On Wed, Feb 21, 2024 at 10:35:50PM +0100, Günther Noack wrote:
> Hello!
> 
> I think this is a good idea.
> Some minor implementation remarks below.
> 
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
> 
> Optional stylistic remark; I try to avoid predicate functions which
> have a "negated" meaning, because double negations are slightly more
> error prone.  (We return false here, so Landlock is not not
> initialized.)

I agree, I was also bothered about this double negation. I'll send a v2
with the same behavior but an is_initialized() helper instead.

> 
> > +
> > +	pr_warn_once(
> > +		"Disabled but requested by user space. "
> > +		"You should enable Landlock at boot time: "
> > +		"https://docs.kernel.org/userspace-api/landlock.html#kernel-support\n");
> > +	return true;
> > +}
> > +
> >  /**
> >   * copy_min_struct_from_user - Safe future-proof argument copying
> >   *
> > @@ -173,7 +185,7 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
> >  	/* Build-time checks. */
> >  	build_check_abi();
> >  
> > -	if (!landlock_initialized)
> > +	if (is_not_initialized())
> >  		return -EOPNOTSUPP;
> 
> Technically, any Landlock user needs to go through the
> landlock_create_ruleset() system call anyway; it might be enough to
> just add it in that place and leave the other system calls as they
> were.  Then you could also omit the special function.

True, but we never know. I prefer to cover all entry points the same
way.  It makes things more consistent and easier to review.

> 
> Reviewed-by: Günther Noack <gnoack3000@gmail.com>
> 
> –Günther
> 


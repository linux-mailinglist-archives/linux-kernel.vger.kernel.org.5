Return-Path: <linux-kernel+bounces-85044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A5186AF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2976D1C2432A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD41D146015;
	Wed, 28 Feb 2024 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1a8zvToH"
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B19145B27
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124853; cv=none; b=OdZB+j4QoXojGj1Af4EWoG1nCklTSoxD5mTzrwmMnv94MFJoJBeYeCPAiA+oLvRyxvfD2owq1V+H0y/JXAiSRLWKBQQxia0pm8+sf/I4UCLqOs6KIrJlo+tGEEpQxQAaYp8vcCUZK+ObqZxQOKlk1vxqZZrPkp84i7lsbf76OVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124853; c=relaxed/simple;
	bh=V0Wu/+VTiNjbmF7GguEv6L2WS2ghRGPZ/G5cRniKxG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbVK7Xojxh00uqSISJxkxtQfdsvPIDvwkYovkoZvdHzN8DdjfVZvfN6MvCxIjDLQ/HKUzHNL1x971xvdwyqxM0gJbV+PC26Sri5tgirtpT4pXj7S6QQW1ATqpPguBrxLX6gMAZIRxsujAmPRb7j7hy0jZJG5b/L/kMbc2WxaeMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1a8zvToH; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TlDnN1M7FzWGr;
	Wed, 28 Feb 2024 13:54:00 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TlDnM0D2lzMprLN;
	Wed, 28 Feb 2024 13:53:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709124840;
	bh=V0Wu/+VTiNjbmF7GguEv6L2WS2ghRGPZ/G5cRniKxG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1a8zvToHqfl9+MEmyAhJmDNVttx5z44Yz6eTRwuZj2eA2ZQbCw5Zr8ESyTAoJF6Q3
	 b9GHEHRZNZCMtqCZNIA6u7qWe/M0N0waqTV9yZWn2dPSsqHeZEcdT6657QH96gdFFX
	 pEG24/X6jBNjhnWQpldiXVUneQ26JrS/3q3ueQwA=
Date: Wed, 28 Feb 2024 13:53:42 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] AppArmor: Fix lsm_get_self_attr()
Message-ID: <20240228.iuBae3aiS6oo@digikod.net>
References: <20240223190546.3329966-1-mic@digikod.net>
 <20240223190546.3329966-2-mic@digikod.net>
 <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com>
 <CAHC9VhTUux1j9awg8pBhHv_4-ZZH0_txnEp5jQuiRpAcZy79uQ@mail.gmail.com>
 <CAHC9VhQHpZZDOoPcCqRQJeDc_DOh8XGvhFF3M2wZse4ygCXZJA@mail.gmail.com>
 <CAHC9VhQL9REbeyP6Lp=0HT=0LryPnAOKAbBF4gH9c=cBbJxaFg@mail.gmail.com>
 <CAHC9VhR2=bzVqHtcPH7-cSQRBnfphzzBQ4n9agXWMtasK9wh7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR2=bzVqHtcPH7-cSQRBnfphzzBQ4n9agXWMtasK9wh7Q@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Feb 27, 2024 at 05:13:58PM -0500, Paul Moore wrote:
> On Tue, Feb 27, 2024 at 5:09 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Feb 27, 2024 at 11:01 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Mon, Feb 26, 2024 at 2:59 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Fri, Feb 23, 2024 at 4:07 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > On Fri, Feb 23, 2024 at 2:06 PM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > >
> > > > > > aa_getprocattr() may not initialize the value's pointer in some case.
> > > > > > As for proc_pid_attr_read(), initialize this pointer to NULL in
> > > > > > apparmor_getselfattr() to avoid an UAF in the kfree() call.
> > > > > >
> > > > > > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > > > > > Cc: John Johansen <john.johansen@canonical.com>
> > > > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Fixes: 223981db9baf ("AppArmor: Add selfattr hooks")
> > > > > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > > > > ---
> > > > > >  security/apparmor/lsm.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > If you like John, I can send this up to Linus with the related SELinux
> > > > > fix, I would just need an ACK from you.
> > > >
> > > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > > >
> > > > This patch looks good to me, and while we've still got at least two
> > > > (maybe three?) more weeks before v6.8 is tagged, I think it would be
> > > > good to get this up to Linus ASAP.  I'll hold off for another day, but
> > > > if we don't see any comment from John I'll go ahead and merge this and
> > > > send it up to Linus with the SELinux fix; I'm sure John wouldn't be
> > > > happy if v6.8 went out the door without this fix.
> > >
> > > I just merged this into lsm/stable-6.8 and once the automated
> > > build/test has done it's thing and come back clean I'll send this,
> > > along with the associated SELinux fix, up to Linus.  Thanks all.
> >
> > In off-list discussions with Mickaël today it was noted that this
> > patch also needs a fixup to the commit description so I've replaced it
> > with the following:
> >
> >   "In apparmor_getselfattr() when an invalid AppArmor
> >    attribute is requested, or a value hasn't been explicitly
> >    set for the requested attribute, the label passed to
> >    aa_put_label() is not properly initialized which can cause
> >    problems when the pointer value is non-NULL and AppArmor
> >    attempts to drop a reference on the bogus label object."
> >
> > I've updated the commit in lsm/stable-6.8 and I'll be sending it to
> > Linus shortly.
> >
> > > John, if this commit is problematic please let me know and I'll send a
> > > fix or a revert.
> 
> I also just realized that both this patch and the SELinux have the
> stable kernel marking which shouldn't be necessary as the LSM syscalls
> are only present in the v6.8-rcX kernels.  I'm going to drop the
> stable tagging, but leave the 'Fixes:' tag of course.

Looks good, thanks!

> 
> -- 
> paul-moore.com
> 


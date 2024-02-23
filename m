Return-Path: <linux-kernel+bounces-79233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AE8861F51
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDCD21C229F1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6637C14CAC1;
	Fri, 23 Feb 2024 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Hz++FGzn"
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C555F14CAA7
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708725828; cv=none; b=Cq4Hu3UD++Sexy7sfvoTFma18crucrCVEeDOrQt0xbRTAp1QX/obCvILmQQ0eQuRzBXunl9XF8FLTpBvjGLFzaugrYaXPhoMYQLPY/i8udqbWNsh2KwKAsyzKRRNI5kVXpx87ILby/LSmIlGngBt5rSI97/gzyWsN76RoFlJ+hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708725828; c=relaxed/simple;
	bh=es1a7/Jx7I4y7wvmf+og2jZ8waD2Y9vlkAkSgE79mA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtFHKYjfHV4UeIkRcxLIA/WE8s3d511DavTmwYdd1+FryKHHyHgmKwjAGAcTc7XzLciPv1r9a0Bq+2LttrSUCOak3S3IO3ZfwthwLuaB8o1aQx0271A5wEJTSCQEooZkTMs605SDhiA0sW9962A+lz+HdKbhgaDJZHzhUGZt8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Hz++FGzn; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ThPCs1Rf8zZRj;
	Fri, 23 Feb 2024 23:03:37 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ThPCr0vQCzMpnPg;
	Fri, 23 Feb 2024 23:03:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708725817;
	bh=es1a7/Jx7I4y7wvmf+og2jZ8waD2Y9vlkAkSgE79mA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hz++FGznJqTL3Js2fp1GXoxxXyLcT+3A5NeL2RF7uNhRSpuXH8YS7+2ZyYwm4eXAA
	 7CjszwGhQaeSBrRtnbKCvpbipBzSrRs6egBGG6j5QT07UiCupqJbfCBIMepCa1qrHq
	 JGGwhlftxpHF4X8Ff0i7nSEzJoPIp5hkb+gXOPNo=
Date: Fri, 23 Feb 2024 23:03:27 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 1/2] SELinux: Fix lsm_get_self_attr()
Message-ID: <20240223.goo9Xei0xa9S@digikod.net>
References: <20240223190546.3329966-1-mic@digikod.net>
 <20240223.ieSh2aegurig@digikod.net>
 <20240223.eij0Oudai0Ia@digikod.net>
 <CAHC9VhRdRK3FztE-Th=3M+0ZjCZQJ+5sTiXPwfK6xXX_=SFHhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRdRK3FztE-Th=3M+0ZjCZQJ+5sTiXPwfK6xXX_=SFHhA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Feb 23, 2024 at 04:05:16PM -0500, Paul Moore wrote:
> On Fri, Feb 23, 2024 at 3:04 PM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > On Fri, Feb 23, 2024 at 08:59:34PM +0100, Mickaël Salaün wrote:
> > > On Fri, Feb 23, 2024 at 08:05:45PM +0100, Mickaël Salaün wrote:
> > > > selinux_lsm_getattr() may not initialize the value's pointer in some
> > > > case.  As for proc_pid_attr_read(), initialize this pointer to NULL in
> > > > selinux_getselfattr() to avoid an UAF in the kfree() call.
> > >
> > > Not UAF but NULL pointer dereference (both patches)...
> >
> > Well, that may be the result (as observed with the kfree() call), but
> > the cause is obviously an uninitialized pointer.
> 
> Adding the SELinux list to the CC line; SELinux folks the original post is here:
> 
> * https://lore.kernel.org/all/20240223190546.3329966-1-mic@digikod.net
> 
> Thanks for finding this and testing the patch, based on our off-list
> discussion, do you mind if I add a Suggested-by?  Looking at this a

Sure! I was in a hurry and didn't give it the attention it needed...

> bit more I think we'll want to make a few changes to
> selinux_lsm_getattr() later, but this patch is a good one for stable
> as it not only fixes the bug, but it is a trivial one-liner with very
> low risk.
> 
> I do think we need to tweak the commit description a bit, what do you
> think of the following?
> 
>   "selinux_getselfattr() doesn't properly initialize the string
>    pointer it passes to selinux_lsm_getattr() which can cause a
>    problem when an attribute hasn't been explicitly set;
>    selinux_lsm_getattr() returns 0/success, but does not set or
>    initialize the string label/attribute.  Failure to properly
>    initialize the string causes problems later in
>    selinux_getselfattr() when the function attempts to kfree()
>    the string."

Much better!


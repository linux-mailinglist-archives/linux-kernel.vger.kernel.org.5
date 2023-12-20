Return-Path: <linux-kernel+bounces-6468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A94819960
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F2E287ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB68168D1;
	Wed, 20 Dec 2023 07:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J9tY0CrL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2B2168C3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE96CC433C7;
	Wed, 20 Dec 2023 07:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703057060;
	bh=02WAEjZxXiuUFxvRqN4ekwAW7zo4t9NtuU0rypyWqEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9tY0CrL0Lvo95rvkS5dFBhk3h8JDQQ6FyWUQRF0N+O3Kw8Qjt2f478BcDrRfhNZ0
	 nPsA6Wgsv0F0KRbciMlWNpY2haw/IhLg+ffR2eUdJolMYdA4lI/ttLn69bKcRs1bSO
	 NqoKwPlSVsMJ4+swsHeV/7T4MY0RGeSJw4BzFVFc=
Date: Wed, 20 Dec 2023 08:24:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] [ARM] locomo: make locomo_bus_type constant and static
Message-ID: <2023122020-tastiness-counting-788f@gregkh>
References: <2023121905-idiom-opossum-1ba3@gregkh>
 <amnspbf2euablvmtl2bpng423cnkbjkvtsf7dhqmoyrzbgtpwb@3rgazgmuqjcx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amnspbf2euablvmtl2bpng423cnkbjkvtsf7dhqmoyrzbgtpwb@3rgazgmuqjcx>

On Tue, Dec 19, 2023 at 10:21:20PM +0100, Uwe Kleine-König wrote:
> On Tue, Dec 19, 2023 at 07:33:06PM +0100, Greg Kroah-Hartman wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the locomo_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> > 
> > It's also never used outside of arch/arm/common/locomo.c so make it
> > static and don't export it as no one is using it.
> > 
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  arch/arm/common/locomo.c               | 4 +++-
> >  arch/arm/include/asm/hardware/locomo.h | 2 --
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
> > index 70480dd9e96d..6d0c9f7268ba 100644
> > --- a/arch/arm/common/locomo.c
> > +++ b/arch/arm/common/locomo.c
> > @@ -68,6 +68,8 @@ struct locomo {
> >  #endif
> >  };
> >  
> > +static const struct bus_type locomo_bus_type;
> > +
> 
> If you move up locomo_bus_type together with its three callbacks before
> locomo_init_one_child, you don't need the extra declaration here.

I was trying to go for "least intrusive and most obvious change
possible" here, given that this file hasn't been touched in over a
decade by anyone else for anything other than api changes.  And even
then, it was just a tiny fix, this is a very old driver, what's the odds
that it's even used anymore?

thanks,

greg k-h


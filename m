Return-Path: <linux-kernel+bounces-157056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E708B0C49
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B701C23C48
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A79A15E5C9;
	Wed, 24 Apr 2024 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tZmCkLNn"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E001E4A9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968218; cv=none; b=JAQxZCb3O3A7K5g+8XXCTg0Zv6xE8FnDUabR3RsLC6MBCV7F5gqVk8tDYpyskqj1n+hn8kxq/GBQyfDH80Suo9szP1t1cwB4wkhvflWavjrDbaQo0Pr2lYq9yzZVqwiayKdO7FGtMzKknGNroXBgZ3EQHB2FWJwh/dEKLE6rujU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968218; c=relaxed/simple;
	bh=PTc6F7MA3fpvjx7TJrZQuQdnDqnC/L8l324q+un2Hyg=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLDinz5bDHUBfxnQS3hG0eFw6NMstQ4h9ZUdExQlTjJ8zE40JHeV9BLGhZZedYOUBDDnYD4CaYrA9tr4p6M3qiWk1g/wvYuTj9p7tggtqDblIz0s6oHKrA0sML5oO+O1UYasAqbgGyGiBnjuGJYB/eezVSNlyjDt4yC2S6/p1SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tZmCkLNn; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EB6CB3FB77
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713968214;
	bh=kJNCU9zhbbaFpDd41XCS9Fc/M34kxsFFT1gbausG2gE=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=tZmCkLNnIFFn2nfYIcORvBakRerGO54gOp6OI3Y9QFpeD0uBFAj+RPwjJenzZ7dpQ
	 lr6peeFzkBaMVtuL5PmNUYKkkzSGE0LQRCXKgiS0zHE7sb66MWX3TCuUF/XU39m1m5
	 atXow7jYW03V4b/QO1uLDoJkOo3OkR+E/2PwNJgbv7tSFV+4DIL7w87NtvbAN+sAeP
	 t5FPUV4MFXXox13U+Ae9IqxlWFO03dmJSkzdwhZc1vGm0zsFq7sOH5kXIluNiU4A9d
	 ukv2KNZ6onTD5eCDPXkJkIyM+ZEJcqNwDfNAKPEh6Gf6ZLTYAdTnu2JYaa13bX6CZa
	 l+5V8HhXQBqbQ==
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c82c701f5dso3482041b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713968212; x=1714573012;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kJNCU9zhbbaFpDd41XCS9Fc/M34kxsFFT1gbausG2gE=;
        b=UMMH70aI+JFT7j+h2TwysWUb4Ll4tATHEJ0CV/vRQXZ+VPAp+37yGfd1Gkfr7HOVLk
         Os0415OKjQGdqI2X38n4bPH2uC+ExfK2q+lj9JPb0/XOBVl6j+TtbJtldKqBvjHrbi0g
         2OIgodnN6FIk6tLVc2vGNz1jsftGsPvezEwIxLTv51UR7tIC7pxsEyNBubO2ML1OOgkz
         7nF0iRxDku2VUQfW+3waOm8n463M406NxPgA3g3JRIoTf9bRSKOBI/MegK9ne+u0rqGk
         hwtvGGGZ9AmdRZpey8uw9UhmsXe5l3692SF29DVYCPjoZSN1AQvbbZun7bAuI2Lfll/e
         OeBA==
X-Forwarded-Encrypted: i=1; AJvYcCXj8h4PWz16gWFNWCw0f9Nvw4/mKD4X7f+WIOMwGbq75/Hsd/xwWs2mH6gPYJ4cP3khiAeVP1vhI6CO0muag7+Clot5CVI4IqQGirjH
X-Gm-Message-State: AOJu0YxORGeYfJTbLZEz6gEMkr2YrM+Ov7tybfAwLQkoBH7IR2rzkOqP
	RSveXq6TPt2snjk+9oWG8V7RQi7XxeKAdHJAMCwQPw21RpaHkEi3QC5BGeOu/49YIRbvB8WSUpi
	ywRZYAQ6b7G1O+B2I0yk1ujgVgjvaxDoS0PX/tRJol/k5J/Rl0seXCW69lNY2ZgYDgFymgmHaYc
	LL8jK0RsTWwbaCVgU6FAydY2qVMSevoMsvObeJimHe7row0DV/SaPV
X-Received: by 2002:a05:6808:1710:b0:3c3:ddef:cbfb with SMTP id bc16-20020a056808171000b003c3ddefcbfbmr2761525oib.44.1713968211994;
        Wed, 24 Apr 2024 07:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmMI1QSebm1GMJUjaFXp6rpbt/+pc9Dt550W0+5oifIVAEgjReyIZIP4B46bcuH+K6tI2YRKNhPnJnltpk6+0=
X-Received: by 2002:a05:6808:1710:b0:3c3:ddef:cbfb with SMTP id
 bc16-20020a056808171000b003c3ddefcbfbmr2761500oib.44.1713968211677; Wed, 24
 Apr 2024 07:16:51 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Apr 2024 07:16:51 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <SH0PR01MB0841F8C45091E4A08020ADF2F910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20240424075856.145850-1-joshua.yeong@starfivetech.com>
 <20240424075856.145850-2-joshua.yeong@starfivetech.com> <CAJM55Z-C7XkFo4STk3rdLG4kvPfed-AfrHB1QJ-Tzt1LDoKw9w@mail.gmail.com>
 <SH0PR01MB0841F8C45091E4A08020ADF2F910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 24 Apr 2024 07:16:51 -0700
Message-ID: <CAJM55Z9NAeRb_3ZBJksXt+4fJMdcYw55bfAs0EpSnM8VWBKQag@mail.gmail.com>
Subject: RE: [PATCH v3 1/2] cache: Add StarFive StarLink cache management for
 StarFive JH8100
To: Joshua Yeong <joshua.yeong@starfivetech.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"conor@kernel.org" <conor@kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	Leyfoon Tan <leyfoon.tan@starfivetech.com>, JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Joshua Yeong wrote:
> Emil Renner Berthing wrote:
> > Joshua Yeong wrote:
> > > Add StarFive Starlink cache management driver for
> > > JH8100 SoC. This driver enables RISC-V non-standard cache operation o=
n
> > > JH8100 that does not support Zicbom extension instructions.
> > >
> > > Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> > > ---
> > >  drivers/cache/Kconfig                   |   9 ++
> > >  drivers/cache/Makefile                  |   5 +-
> > >  drivers/cache/starfive_starlink_cache.c | 135
> > > ++++++++++++++++++++++++
> > >  3 files changed, 147 insertions(+), 2 deletions(-)  create mode
> > > 100644 drivers/cache/starfive_starlink_cache.c
> > >
> > > diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig index
> > > 9345ce4976d7..9181cd391f53 100644
> > > --- a/drivers/cache/Kconfig
> > > +++ b/drivers/cache/Kconfig
> > > @@ -14,4 +14,13 @@ config SIFIVE_CCACHE
> > >  	help
> > >  	  Support for the composable cache controller on SiFive platforms.
> > >
> > > +config STARFIVE_STARLINK_CACHE
> > > +	bool "StarFive StarLink Cache controller"
> > > +	depends on RISCV
> > > +	depends on ARCH_STARFIVE
> > > +	select RISCV_DMA_NONCOHERENT
> > > +	select RISCV_NONSTANDARD_CACHE_OPS
> > > +	help
> > > +	  Support for the StarLink cache controller on StarFive platforms.
> >
> > This is a bit misleading. The JH71x0s don't have this. It's only on the=
 JH8100 so
> > far, and hopefully later SoCs will just implement RISC-V standards for =
this.
> > So maybe something like
> >
> > "Support for the StarLink cache controller on the StarFive JH8100 SoC."
> >
>
> Hi Emil,
>
> The StarLink-500 cache controller is not designed exclusively for JH8100 =
SoC.
> While it is true that it currently exists on the StarFive platform, CPU/S=
oC
> that does not come with Zicbom extensions supported would need to rely
> on this cache drive to do cache management operations. I think we don=E2=
=80=99t need
> to mentioned 'JH8100 SoC' here.

Wait, in the previous mail you said that future designs will implement Zicb=
om
and not need this work-around, but here you're talking about other SoCs tha=
t
do need it. So which is it?


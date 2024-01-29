Return-Path: <linux-kernel+bounces-43523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E53F841527
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97871C232A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619191586DA;
	Mon, 29 Jan 2024 21:26:48 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FED4CB24;
	Mon, 29 Jan 2024 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563608; cv=none; b=kQoAiigHH/W41bk+n2kwUeAFJ7Sjtx694nm/H36mEqhNTUS+A/S9LUvArmJU4tsdNEB9cNNO88F+bVzHkwMMnHg9LDLnX88HhL0yPFCP++MAtVN9cUdpjGl/KZ3bRKLz7u+3lzHT+paYRV+/1oyttYsJoFep+gi3O7GqUdnXeGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563608; c=relaxed/simple;
	bh=t66fD1xG9ic8vzKSKwKoS55kq9k4luC0lr5RlT1LbJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxLSLA9oAyZEtgXE/5O0FDnugyGuYgNT3BHFWke+LFuBOPgYDd+Of2fZppdtI4lDHz+ne7iNxtIxf7j9vtqxBb3ZeDjjZFZPwW/P9UpRzNaSctGXSPoQcFaI13T0nZU2ihgOToY5TNtIxRvc285ZaSKM2yc/VXVYHsin0HK87vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.96)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1rUZ8y-000pa2-30;
	Mon, 29 Jan 2024 22:26:16 +0100
Date: Mon, 29 Jan 2024 22:26:16 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Peng Fan <peng.fan@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] gpio: vf610: allow disabling the vf610 driver
Message-ID: <ZbgX-HGjM5fdftCG@v2202401214221251712.nicesrv.de>
References: <20240124205900.14791-1-martin@kaiser.cx>
 <20240124205900.14791-2-martin@kaiser.cx>
 <20240126122719.GA13659@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126122719.GA13659@francesco-nb>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Thus wrote Francesco Dolcini (francesco@dolcini.it):

> On Wed, Jan 24, 2024 at 09:58:57PM +0100, Martin Kaiser wrote:
> > The vf610 gpio driver is enabled by default for all i.MX machines,
> > without any option to disable it in a board-specific config file.

> > Most i.MX chipsets have no hardware for this driver. Change the default
> > to enable GPIO_VF610 for SOC_VF610 and disable it otherwise.

> > Add a text description after the bool type, this makes the driver
> > selectable by make config etc.

> > Fixes: 30a35c07d9e9 ("gpio: vf610: drop the SOC_VF610 dependency for GPIO_VF610")
> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > ---
> > v4:
> >  - add a new patch to enable COMPILE_TEST

> > v3:
> >  - split the changes into three patches

> > v2:
> >  - enable the vf610 gpio driver in the defconfig files for arm_v7
> >    (i.MX7ULP) and arm64 (i.MX8QM, DXL, ULP and i.MX93)

> >  drivers/gpio/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)

> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index 1301cec94f12..353af1a4d0ac 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -711,7 +711,8 @@ config GPIO_UNIPHIER
> >  	  Say yes here to support UniPhier GPIOs.

> >  config GPIO_VF610
> > -	def_bool y
> > +	bool "VF610 GPIO support"
> > +	default y if SOC_VF610

> any reason for having this default y for SOC_VF610, but not for the
> other SOC that uses the same variant (i.MX7ULP, ... ?).

Ok, it's probably not as consistent as it could be.

It seems that there are three categories

* Vybrid SoCs

According to the reference manual, they all have the gpio-vf610 hardware.
Defaulting to y for SOC_VF610 makes sense. It's now possible to disable the
driver if a board doesn't need it.

There's a bunch of defconfigs, not sure which ones would have to enable
gpio-vf610 if it weren't on by default.

* imx7ulp

The devicetrees show that all imx7ulp have gpio-vf610 hardware. You're right,
we should use the same approach, i.e.
   default y if SOC_IMX7ULP
and get rid of the imx_v6_v7_defconfig change.

* imx8, imx9

For arm64, there are no SOC_... defines and there's only one defconfig. The
devicetrees don't show clearly which chip has gpio-vf610. We're on the safe
side if we enable gpio-vf610 in defconfig.

Does this make sense?

   Martin


Return-Path: <linux-kernel+bounces-66614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE1A855F04
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30561F21407
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB30067E85;
	Thu, 15 Feb 2024 10:19:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18406350A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992366; cv=none; b=rvLjD2D1wjtSHtvqRgJpB96qD/L63522h4sAhMbhADY74aGVkpZV/HCW2/jfa21bMajoIwUlk5IYuCMFef/XN+3+RavsDPnwCFEESvLutx7/UwHvYYLxhZ91iJRDTt/yG2RRe/kHXxWhmZk2axOitkfNI8JPashhk7vGmVuFPaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992366; c=relaxed/simple;
	bh=u3rr8q+SLGsobq+2sOE/JWMdQphGfdS+OP4Y4ErJR1o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lUUi9obnFdP9xBKBAbakF6JeAshpMB8xJaWPui/D2ERhORXM7nUcTVVTpBaX4skDdAYav9ZrDgUbgZkiJn+xkl6dDokn2Z/4CIRfOFv1GTS/Wk+B7foBiDL8Tw+cPySbstYRjoi45+yqs2wLXVZn6bsbnMEqg2c0laBYxMG0vYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1raYpm-0006ML-Vw; Thu, 15 Feb 2024 11:19:15 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1raYpm-000reV-AH; Thu, 15 Feb 2024 11:19:14 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1raYpm-00041o-0n;
	Thu, 15 Feb 2024 11:19:14 +0100
Message-ID: <d51dbac55d3677031bfab8bfe959f7b556b1c373.camel@pengutronix.de>
Subject: Re: [PATCH 19/23] gpio: nomadik: grab optional reset control and
 deassert it at probe
From: Philipp Zabel <p.zabel@pengutronix.de>
To: =?ISO-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Date: Thu, 15 Feb 2024 11:19:14 +0100
In-Reply-To: <20240214-mbly-gpio-v1-19-f88c0ccf372b@bootlin.com>
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
	 <20240214-mbly-gpio-v1-19-f88c0ccf372b@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mi, 2024-02-14 at 17:24 +0100, Th=C3=A9o Lebrun wrote:
> Fetch a reference to the optional shared reset control and deassert it
> if it exists.
>=20
> Optional because not all platforms that use this driver have a reset
> attached to the reset block. Shared because some platforms that use the
> reset (at least Mobileye EyeQ5) share the reset across banks.
>=20
> Do not keep a reference to the reset control as it is not needed
> afterwards; the driver does not handle suspend, does not use runtime PM
> and does not register a remove callback.

I suppose you don't care that the reset is only ever deasserted once
and never asserted again on this hardware, but for shared reset
controls the expectation is that deassert/assert calls are balanced:

https://docs.kernel.org/driver-api/reset.html?highlight=3Dbalanced#assertio=
n-and-deassertion

So maybe this warrants a comment in the code. Or do you mean to
suppress unbind via suppress_bind_attrs to explain away any missing
cleanup?

> The operation is done in nmk_gpio_populate_chip(). This function is
> called by either gpio-nomadik or pinctrl-nomadik, whoever comes first.
> This is here for historic reasons and could probably be removed now; it
> seems gpio-ranges enforces the ordering to be pinctrl-first. It is not
> the topic of the present patch however.
>=20
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/gpio/gpio-nomadik.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
> index 21bb6d6363fc..b623c093b54d 100644
> --- a/drivers/gpio/gpio-nomadik.c
> +++ b/drivers/gpio/gpio-nomadik.c
> @@ -513,12 +513,14 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct=
 device_node *np,
>  {
>  	struct nmk_gpio_chip *nmk_chip;
>  	struct platform_device *gpio_pdev;
> +	struct reset_control *reset;
>  	struct gpio_chip *chip;
>  	struct resource *res;
>  	struct clk *clk;
>  	void __iomem *base;
>  	uintptr_t flags;
>  	u32 id, ngpio;
> +	int ret;
> =20
>  	gpio_pdev =3D of_find_device_by_node(np);
>  	if (!gpio_pdev) {
> @@ -576,6 +578,19 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct =
device_node *np,
>  	clk_prepare(clk);
>  	nmk_chip->clk =3D clk;
> =20
> +	reset =3D devm_reset_control_get_optional_shared(&gpio_pdev->dev, NULL)=
;
> +	if (IS_ERR(reset)) {
> +		dev_err(&pdev->dev, "failed getting reset control: %ld\n",
> +			PTR_ERR(reset));
> +		return ERR_CAST(reset);

Consider using dev_err_probe() here.

regards
Philipp


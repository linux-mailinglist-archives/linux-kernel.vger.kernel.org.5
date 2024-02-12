Return-Path: <linux-kernel+bounces-62511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFF185222D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAC81F2377E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B712F4F891;
	Mon, 12 Feb 2024 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4J0/cuQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0198D51C21;
	Mon, 12 Feb 2024 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778819; cv=none; b=jiVMl+djj/hZ7FTS6koEcIQhnCeZ76X8QnXEaUC0Q7weS3UvB8igXUFJybRsHbmXtponDvHbblG12/i6X+2vRcsPtABuX1FP8m7/sWuDApeAOW5vbvOqrGBLr8xTvHIKZkpFXq1qQFguGf4/AqKEszZNgWaCp6cooQxpnLf693c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778819; c=relaxed/simple;
	bh=jZpc+jpwI8JbN6GWK7eGKpI9q/rxuDmvkjAcn+AKPCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk/zMKNGhqKY9+3msuwNa9Wyf2ctv7uoqnHZR39aGwakxK7Lf+rHB+EwoBQcSRzybTECyVjsojNRkBBlrHy1iwSrO4tQ+kvEdeug+VD+0+q90JFiOKWVONh7m9TjeJ7Bs/sPJKH4wTaWDB93tT1Bis6oJ2LoP5xCn6NsH66wU1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4J0/cuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34407C433F1;
	Mon, 12 Feb 2024 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707778818;
	bh=jZpc+jpwI8JbN6GWK7eGKpI9q/rxuDmvkjAcn+AKPCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4J0/cuQRWgYA/y0VLvLAzsILeQ1usA/v5oj4022qQx8yWjum0KNB9rVZ5REDVOMX
	 iuqDuYYpYgQnkC57kvWptf3XrhHrFfBGHec/ZvYNIJBtsBZOsJiqAitaaV+tE3pgsr
	 HFq8tNq0ylJWRjJS2VFi/MvWIjNhm8cGQ6velKKxZHIAAE9BQoGEHFJm5aSCWAguU0
	 ou++v/rX99EAPALjKePLNsts5FznbZO4/bhnaRX3uH0dIN/2efzSJN/4d6W0qUq3rp
	 C1xC4HTP0zmd09RdiFW2a1rGvpH5h3wEae5knGn+j2VsDbOQ0hjRSamzZ5W3PGt7Hy
	 uxeUrBWMVH72g==
Received: by mercury (Postfix, from userid 1000)
	id 73990106A041; Tue, 13 Feb 2024 00:00:15 +0100 (CET)
Date: Tue, 13 Feb 2024 00:00:15 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	NXP Linux Team <linux-imx@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 14/14] ARM: dts: imx6ull-uti260b: Add board
Message-ID: <56eb2fnpmaya5rwfk5jvluvsidokzpoujeatihgrbxlytbzx5x@ozco7pbgkugp>
References: <20240210012114.489102-1-sre@kernel.org>
 <20240210012114.489102-15-sre@kernel.org>
 <c38e7c68-e725-4174-aa0a-0594a55c8d56@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c38e7c68-e725-4174-aa0a-0594a55c8d56@gmx.net>

Hi Stefan,

On Mon, Feb 12, 2024 at 07:28:36PM +0100, Stefan Wahren wrote:
> > +	reg_vsd: regulator-vsd {
> i think the node name should be just "regulator"
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "VSD_3V3";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +	};
> > +
> > +	reg_vref: regulator-vref-4v2 {
> dito

The nodename must be unique. So just "regulator" does not work. In
the past this was sometimes solved by adding something like @0,
which is part of the nodename. But that is not ok, since there is no
reg property.

> > +&ecspi3 {
> > +	cs-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mux_spi3>, <&mux_spi3_cs>;
> > +	status = "okay";
> > +
> > +	panel@0 {
> > +		compatible = "inanbo,t28cp45tn89-v17";
> > +		reg = <0>;
> > +		backlight = <&panel_backlight>;
> > +		power-supply = <&reg_vsd>;
> > +		spi-cpha;
> > +		spi-cpol;
> > +		spi-max-frequency = <100000>;
>
> This seems slow to me. Is this a limitation of the display?

I just used something slow, which should definitely work. I will try
to increase to 1MHz. Note, that the display is not driven via SPI.
SPI is just used for the configuration.

Thanks for the review,

-- Sebastian


Return-Path: <linux-kernel+bounces-27126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3816782EADC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77301F240BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A6911CA9;
	Tue, 16 Jan 2024 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="KAVU3mtA"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDC1125A3;
	Tue, 16 Jan 2024 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1705393686; bh=atc+5+ojRvm8ThjhjD7yUzq2b3yJt/kmV+ymWWi8EQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KAVU3mtAAmNdfm2lPlBc3yrxcepLBsM0BAxgkupmPr3o0C/hI4SsBcW6N3deojhSZ
	 SwLgxJMXS7055SAA9oYxM9fSTUvPnOc+IQj+mRgVanuOTLMOgOPqs1Hs5HIV2DrqvC
	 aoP1cHxPpN+msTzz9K9jk4LnMp3vGX2Iz736rrM4qTdFhXq6UN5ShVEF2R8nYTuz2d
	 2TFH6KM4XhNENO1/crKT1TzF5bB3yy2XWjxbas56EArRXrHtXyiXj1RkoiYigdEj7H
	 nOxyKKG8aqDbAkRJwG3GmPhrKovXYzIBYZyd84ajXRY/7oJXl/E5a+x0Yhzib5ML5U
	 Ag/yfhu6xOnxA==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id D212A1000C2; Tue, 16 Jan 2024 08:28:06 +0000 (GMT)
Date: Tue, 16 Jan 2024 08:28:06 +0000
From: Sean Young <sean@mess.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
	nuno.sa@analog.com, devicetree@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Subject: Re: [PATCH 2/2] pwm: Add driver for AXI PWM generator
Message-ID: <ZaY-FjeRV2qPL0wz@gofer.mess.org>
References: <20240115201222.1423626-1-tgamblin@baylibre.com>
 <20240115201222.1423626-3-tgamblin@baylibre.com>
 <gbessnmierg5gvdguhwauoe2mxr3krwcfk2afhazrqvz45md64@itbchezepncg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gbessnmierg5gvdguhwauoe2mxr3krwcfk2afhazrqvz45md64@itbchezepncg>

On Mon, Jan 15, 2024 at 10:18:04PM +0100, Uwe Kleine-König wrote:
> On Mon, Jan 15, 2024 at 03:12:21PM -0500, Trevor Gamblin wrote:
> > +static int axi_pwmgen_probe(struct platform_device *pdev)
> > +{
> > +	struct axi_pwmgen *pwm;
> > +	void __iomem *io_base;
> > +	int ret;
> > +
> > +	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> > +	if (!pwm)
> > +		return -ENOMEM;
> > +
> > +	io_base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(io_base))
> > +		return PTR_ERR(io_base);
> > +
> > +	pwm->regmap = devm_regmap_init_mmio(&pdev->dev, io_base, &axi_pwm_regmap_config);
> > +	if (IS_ERR(pwm->regmap))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->regmap),
> > +				     "failed to init register map\n");
> > +
> > +	pwm->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> > +	if (IS_ERR(pwm->clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->clk), "failed to get clock\n");
> 
> Please call clk_rate_exclusive_get() on pwm->clk and cache the rate in
> struct axi_pwmgen.
> 
> > +	pwm->chip.dev = &pdev->dev;
> > +	pwm->chip.ops = &axi_pwmgen_pwm_ops;

In that case pwm->chip.atomic = true; can be set too (although this should
be tested with CONFIG_DEBUG_ATOMIC_SLEEP and CONFIG_PWM_DEBUG).

Thanks,

Sean


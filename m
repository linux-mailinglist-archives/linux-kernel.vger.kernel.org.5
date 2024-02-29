Return-Path: <linux-kernel+bounces-87617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A9886D693
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991B6284623
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F266B74BE1;
	Thu, 29 Feb 2024 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ex91U2FX"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5775E2FC35;
	Thu, 29 Feb 2024 22:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244488; cv=none; b=tAYc6sqJYKcrVDeRMQOfuwxT4jfR5jDeYqC0qwXNiJBcu6XiH38UKTiiofwIpK+5ePn0tKsMl/2F/XTmQI5CHnCYCTsOHDNjhL9943Nr3ahZ4ReWm5Q1btsIItkNCyCs4PzF5mle7qdSWzZGjuMhuZpG8Ix2Hy1XE7jvhPG9Pfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244488; c=relaxed/simple;
	bh=uY0SdBM/VL4JmHHpdHpZrHSim56nTzaGwt5Kz9E62dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4B/cIZ33EEngZHEqUytWpSjYzjDovT5jeRt2Fq4BjZw68KQ7or2AQV30DfEFeKPt43Nvg7OOLZsVA7NQVDIvXaWuA2HY2kJi5p7/fzwTvzqh3iTdhFnIikMXSQJNM25JkxlFpaX5vF+Hj0xS2Yx8mYw7S/SXTjpr2DzmLh0xhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ex91U2FX; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 14D6B40003;
	Thu, 29 Feb 2024 22:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709244483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lxqQl5JTSihBQCaBo7S//KD0ZOrQomn+RcL0KtFjsNA=;
	b=ex91U2FX0jOv717asqGerNnjDv8U2tCTG4E+jk1iseh7/OnPOIckArxVkitEyHGy1vjeEw
	QFwQfHjtjAvW1lOqt1m4Xf17gwNSGK+HUU7LsDjQ9g3WO9pBaC9+Sy5yZm9P4pYd1nCgKt
	Blxnv6hlTUlvor3ff1S8aNawNJwMzL6r/V5w1AJMKHJCU30B/POs4672vC4vildRRtQoZ7
	dtSkryTNdVn4oNnqUTjlPJWioBAI45kS8VQng1J/1a0vfw7GVA8yUjnasE9Kx9PZ9vQkeH
	DDH76pcdRotIDH2JlrLEJfK8eUVzkIJ1sniuGyxToOalKv1h2lsIIuWMvdebrQ==
Date: Thu, 29 Feb 2024 23:08:02 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-rtc@vger.kernel.org,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf85063: do a SW reset after rtc power fail
Message-ID: <2024022922080217cbe165@mail.local>
References: <20240227131436.3342807-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227131436.3342807-1-alexander.sverdlin@siemens.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 27/02/2024 14:14:32+0100, A. Sverdlin wrote:
> From: Lukas Stockmann <lukas.stockmann@siemens.com>
> 
> From PCF85063A datasheet, section "Software reset":
> 
> "There is a low probability that some devices will have corruption of the
> registers after the automatic power-on reset if the device is powered up
> with a residual VDD level. It is required that the VDD starts at zero volts
> at power up or upon power cycling to ensure that there is no corruption of
> the registers. If this is not possible, a reset must be initiated after
> power-up (i.e. when power is stable) with the software reset command"
> 
> Trigger SW reset if a power loss is detected.
> 
> Link: https://www.nxp.com/docs/en/data-sheet/PCF85063A.pdf
> Signed-off-by: Lukas Stockmann <lukas.stockmann@siemens.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  drivers/rtc/rtc-pcf85063.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
> index fdbc07f14036..edfd75d18e19 100644
> --- a/drivers/rtc/rtc-pcf85063.c
> +++ b/drivers/rtc/rtc-pcf85063.c
> @@ -35,6 +35,7 @@
>  #define PCF85063_REG_CTRL1_CAP_SEL	BIT(0)
>  #define PCF85063_REG_CTRL1_STOP		BIT(5)
>  #define PCF85063_REG_CTRL1_EXT_TEST	BIT(7)
> +#define PCF85063_REG_CTRL1_SWR		0x58
>  
>  #define PCF85063_REG_CTRL2		0x01
>  #define PCF85063_CTRL2_AF		BIT(6)
> @@ -580,7 +581,7 @@ static int pcf85063_probe(struct i2c_client *client)
>  
>  	i2c_set_clientdata(client, pcf85063);
>  
> -	err = regmap_read(pcf85063->regmap, PCF85063_REG_CTRL1, &tmp);
> +	err = regmap_read(pcf85063->regmap, PCF85063_REG_SC, &tmp);
>  	if (err) {
>  		dev_err(&client->dev, "RTC chip is not present\n");
>  		return err;
> @@ -590,6 +591,22 @@ static int pcf85063_probe(struct i2c_client *client)
>  	if (IS_ERR(pcf85063->rtc))
>  		return PTR_ERR(pcf85063->rtc);
>  
> +	/*
> +	 * If a Power loss is detected, SW reset the device.
> +	 * From PCF85063A datasheet:
> +	 * There is a low probability that some devices will have corruption
> +	 * of the registers after the automatic power-on reset...
> +	 */
> +	if (tmp & PCF85063_REG_SC_OS) {
> +		dev_warn(&client->dev,
> +			 "Power loss detected, send a SW reset to the device\n");
> +		err = regmap_write(pcf85063->regmap, PCF85063_REG_CTRL1,
> +				PCF85063_REG_CTRL1_SWR);
> +		if (err < 0)
> +			dev_err(&client->dev,
> +				"SW reset failed, trying to continue\n");
> +	}

Doing this in probe is putting a band-aid on a wooden leg as you are not
guaranteed you will have a probe to catch this case. This should be
rather done in pcf85063_rtc_set_time but it comes with its own set of
issues because this probably requires to reconfigure most of the chip
which is conveniently done in probe. And then it will introduce varance
in the time taken to set_time which is generally bad if you care about
sub second precision.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


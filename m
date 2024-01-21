Return-Path: <linux-kernel+bounces-32104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7670A835681
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D709281DE2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FBD37703;
	Sun, 21 Jan 2024 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQWPmWOR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEAA376E2;
	Sun, 21 Jan 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705852260; cv=none; b=lEW1tZ87Ceym1e2neV/hCb/pGUM7a4VhE7yfz+2Jvd//HV4QCLzTl7zPCgn0KaUxdD7ECFV+ZRV4AQz9CKc2gv0MHC/V77YfScAZIChRyhB/Q0fMOgmdxukLeixD21w1h1Ub7+h/zhD6xFtLYN1wp5WUiP/VCR0Frx0aMOn0aJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705852260; c=relaxed/simple;
	bh=m7HC1AJf4lC007wsALDSYwzESPJy1H9H/qWpdRD1HeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afB42G9kym8tzvadIPGdbtiw7C5p9G1spfmRYjIZC6nunvapZI/uBKpfeVjKtJ5PkyVX4ak1zdZymEaZ7IhTlbvz0Bnvo25iHIxU8NWZCb2abpfNAU5UoGyXsT/bixn3DjHM0wCTAo1JhdBzUbYeYs7AR1tEmF49olSaRCUUVP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQWPmWOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3BEC433C7;
	Sun, 21 Jan 2024 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705852259;
	bh=m7HC1AJf4lC007wsALDSYwzESPJy1H9H/qWpdRD1HeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KQWPmWORh39g0L5LGb7nbuomiZVA678SA6uaElGVr2QbTpyEj0lZ6T2uBF+wdiKUm
	 zjateRZIyx4x5yT4s06XqvXm+oWTR9tIkSSRuLMI0kOkJjl5VIlrb6zudwL5X2QJUn
	 cg+UipVg9zEUDjy3A5/xFOTE3SKkdGJK5pMnRfrehE4qpB06ZrzGqNLOorCTook0ng
	 qFWpnjfEo74IppYZHI9kVPUwET6GgLj20eD10jULi3F/xKptKEedn3Sf8AajRb1jne
	 WUebZpEuya303UoILZI72nzH0U5HWpC4oneJlJx0TDQpGd54i+T1PgdnQLXpEy4oYv
	 V/fuY6RHs19Hw==
Date: Sun, 21 Jan 2024 15:50:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
 linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Michael Walle <michael@walle.cc>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu
 <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, Mike Looijmans
 <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, David Lechner <dlechner@baylibre.com>, Ceclan
 Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <20240121155041.3fc1a85d@jic23-huawei>
In-Reply-To: <20240118125001.12809-2-mitrutzceclan@gmail.com>
References: <20240118125001.12809-1-mitrutzceclan@gmail.com>
	<20240118125001.12809-2-mitrutzceclan@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jan 2024 14:49:23 +0200
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Reviewed-by: Michael Walle <michael@walle.cc> # for gpio-regmap
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>

One comment following through from adding the named irq support to the
binding.  The driver needs to check that it has the right one
as perhaps only the error one is wired, or it is the first one specified
in the binding.


> +static int ad7173_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct ad7173_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->info = spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -ENODEV;
> +
> +	ida_init(&st->cfg_slots_status);
> +	ret = devm_add_action_or_reset(dev, ad7173_ida_destroy, st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->info->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ad7173_info;
> +
> +	spi->mode = SPI_MODE_3;
> +
> +	ad7173_sigma_delta_info.num_slots = st->info->num_configs;
> +	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7173_sigma_delta_info);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7173_fw_parse_channel_config(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_ad_sd_setup_buffer_and_trigger(dev, indio_dev);

If the error interrupt is provided either first, or as the only interrupt
this is going to use the wrong one.

Probably need to have a variant of that which takes an explicit irq so that
figuring out which irq is relevant becomes a driver problem rather than the
library having a go based on spi->irq.


> +	if (ret)
> +		return ret;
> +
> +	ret = ad7173_setup(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	if (IS_ENABLED(CONFIG_GPIOLIB))
> +		return ad7173_gpio_init(st);
> +
> +	return 0;
> +}


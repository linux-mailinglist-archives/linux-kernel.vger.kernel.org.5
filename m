Return-Path: <linux-kernel+bounces-89816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325C286F60C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73823B23253
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA86F6BFB1;
	Sun,  3 Mar 2024 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7z3tnNg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B256FD1;
	Sun,  3 Mar 2024 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709483002; cv=none; b=SF5S5LhjH9JqOE4YZHlvCv6k0MxCGDeecWW02xhWU1rrYyr4+8HOhiDUb5eOspx/xcKRvSZ7/08UP2psytU+ahPn94yE/OezmeJS/mu8FakaSJVWCpCjyO1b7S6aT0oZptWrrZfGlOOtz2gs2Y+iJf06lCSpO+/5AJS+cr4R4WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709483002; c=relaxed/simple;
	bh=ccLhOeCw63kO5+CZbFFUdM1Ipgk7yJPFonmL/Hkemm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUV4gwbtQi0aJZNDmmmM2wOog2xHjcCrTKsQ53y1kU+Wo2/1H1C8Y/OfiP+vTphEbDSyNuBKyg7h88+rhdFfPStt9VI5H+p2ohPqTF3pQmpRrRZezupYDjTVsmcVEBnDfb/ixfJNpCHVOkM1qWl+WcsM6o2zUYrdV11Xl4dts4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7z3tnNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D096C433F1;
	Sun,  3 Mar 2024 16:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709483001;
	bh=ccLhOeCw63kO5+CZbFFUdM1Ipgk7yJPFonmL/Hkemm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i7z3tnNgOhxmB37+92kFhOew3WuN23ILppFzZETM/639M26TqbDdsxnqChefUFmYH
	 wJzLcbhn7kXDNyElc66x2gQDvlI0VueD/gF7ogoTK7e174G/WvDxbVuB39CX43r7iV
	 j3N9hAKrL2RsjLRd31mI6py9/eGH0qqqdKA09ddD8PySQKoZloUW5U8yhEq6CngdZw
	 FVef2+V+vJ1rXEY5PG7ozCyFYFQG116ZOXxP+jsABRuYPma3xPWZehgIBGb8yZSYZF
	 us2jJJPikM/L07p9wHZ2tHM2WmuxC1BQj7cyitwdgzAVmW5t93b9uPN+JBvKA/18Kw
	 Qqo1l6Mwvg5bA==
Date: Sun, 3 Mar 2024 16:22:32 +0000
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 3/3] iio: adc: ad7173: add AD7173 driver
Message-ID: <20240303162148.3ad91aa2@jic23-huawei>
In-Reply-To: <20240228110622.25114-3-mitrutzceclan@gmail.com>
References: <20240228110622.25114-1-mitrutzceclan@gmail.com>
	<20240228110622.25114-3-mitrutzceclan@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 13:06:20 +0200
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
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Link: https://lore.kernel.org/r/20240223133758.9787-3-mitrutzceclan@gmail.com
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Err. I guess you pulled this down from the tree where we got build errors.
If you do that make sure to drop the Link and sign off from next version
as those reflect the path upstream so need to be done afresh for v16.

I fixed it up.

Anyhow, I'm think there are a few cleanups that would be ideally done here
but lets do those after it's merged.

Applied to the togreg-normal branch of iio.git.

Note that I'm not yet sure if I'll be able to squeeze in another pull
request this cycle, so this may be waiting for a while.

Jonathan


> +
> +static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	struct device *dev = indio_dev->dev.parent;
> +	unsigned int num_channels;
> +	int ret;
> +
> +	st->regulators[0].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF];
> +	st->regulators[1].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF2];
> +	st->regulators[2].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_AVDD1_AVSS];
> +
> +	/*
> +	 * If a regulator is not available, it will be set to a dummy regulator.
> +	 * Each channel reference is checked with regulator_get_voltage() before
> +	 * setting attributes so if any channel uses a dummy supply the driver
> +	 * probe will fail.
> +	 */
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(st->regulators),
> +				      st->regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(st->regulators), st->regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
> +
> +	ret = devm_add_action_or_reset(dev, ad7173_disable_regulators, st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to add regulators disable action\n");
> +
> +	ret = device_property_match_property_string(dev, "clock-names",
> +						    ad7173_clk_sel,
> +						    ARRAY_SIZE(ad7173_clk_sel));
> +	if (ret < 0) {
> +		st->adc_mode |= FIELD_PREP(AD7173_ADC_MODE_CLOCKSEL_MASK,
> +					   AD7173_ADC_MODE_CLOCKSEL_INT);
> +		ad7173_register_clk_provider(indio_dev);
> +	} else {
> +		st->adc_mode |= FIELD_PREP(AD7173_ADC_MODE_CLOCKSEL_MASK,
> +					   AD7173_ADC_MODE_CLOCKSEL_EXT + ret);
> +		st->ext_clk = devm_clk_get(dev, ad7173_clk_sel[ret]);
> +		if (IS_ERR(st->ext_clk))
> +			return dev_err_probe(dev, PTR_ERR(st->ext_clk),
> +					     "Failed to get external clock\n");
> +
> +		ret = clk_prepare_enable(st->ext_clk);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to enable external clock\n");
> +
> +		ret = devm_add_action_or_reset(dev, ad7173_clk_disable_unprepare,
> +					       st->ext_clk);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = fwnode_irq_get_byname(dev_fwnode(dev), "rdy");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Interrupt 'rdy' is required\n");
> +
> +	ad7173_sigma_delta_info.irq_line = ret;
> +
> +	num_channels = device_get_child_node_count(dev);
> +
> +	if (st->info->has_temp)
> +		num_channels++;
> +
> +	if (num_channels == 0)
> +		return dev_err_probe(dev, -ENODATA, "No channels specified\n");
> +	indio_dev->num_channels = num_channels;
> +	st->num_channels = num_channels;

I'm not seeing benefit of duplication here really and logically it feels like
a lot of this last chunk would sit better in ad7173_fw_parse_channel_config()

Perhaps that's a job for a future tidying up patch.

> +
> +	return ad7173_fw_parse_channel_config(indio_dev);
> +}

..



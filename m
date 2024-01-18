Return-Path: <linux-kernel+bounces-30393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D43C5831E20
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B881283BFF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625D12C844;
	Thu, 18 Jan 2024 17:06:17 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C862C6AC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597577; cv=none; b=TQfCXIGFnfvYG1bEYPPPnzabFDsKJMHCmUg0/mbhYBpe1kRohmZ/eV9fl6APcYnWcReE4mkguQYbwRlrAR9j0QyN75UXcBOYt1lb/f4MFfzgIapCND5MVGhG+nK0h6ig7CQjnM3XtxlpG9YIAaU7VxMRQEfjXscmzgq7dP9OBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597577; c=relaxed/simple;
	bh=zwlAmsr3jy9o0CUfZAf7n0+dthoLludbuSbP800F6PU=;
	h=Received:From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=mf2ayu0LoStm4c3hI88/hu2tIVv7wMZTmq479OWFuwYetx2p7iylMKiPkZxMbztxcDQcjxdDBseBS1hKFyIltKQ8/XPGPMCB4C61gksUmm2/e6zpnbIHrvtgZGTpXYOkPNUSSjsCxrbL6lYFl1SjSgvA0NZzhG/5Gx+D1m5BR7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-108.elisa-laajakaista.fi [88.113.24.108])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id e241a668-b623-11ee-b3cf-005056bd6ce9;
	Thu, 18 Jan 2024 19:06:13 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Thu, 18 Jan 2024 19:06:13 +0200
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linus.walleij@linaro.org, vkoul@kernel.org, lgirdwood@gmail.com,
	yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
	pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/6] spi: cs42l43: Add SPI controller support
Message-ID: <ZalahZkCrBm-BXwz@surfacebook.localdomain>
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <20230804104602.395892-6-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804104602.395892-6-ckeepax@opensource.cirrus.com>

Fri, Aug 04, 2023 at 11:46:01AM +0100, Charles Keepax kirjoitti:
> From: Lucas Tanure <tanureal@opensource.cirrus.com>
> 
> The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> for portable applications. It provides a high dynamic range, stereo
> DAC for headphone output, two integrated Class D amplifiers for
> loudspeakers, and two ADCs for wired headset microphone input or
> stereo line input. PDM inputs are provided for digital microphones.
> 
> The SPI component incorporates a SPI controller interface for
> communication with other peripheral components.

..

> +		while (buf < block) {
> +			const u8 *word = min(buf + sizeof(u32), block);
> +			int pad = (buf + sizeof(u32)) - word;
> +
> +			while (buf < word) {
> +				val >>= BITS_PER_BYTE;
> +				val |= FIELD_PREP(GENMASK(31, 24), *buf);
> +
> +				buf++;
> +			}

Is this a reinvented way of get_unaligned_*() APIs?

> +			val >>= pad * BITS_PER_BYTE;
> +
> +			regmap_write(regmap, CS42L43_TX_DATA, val);
> +		}

..

> +			while (buf < word) {
> +				*buf = FIELD_GET(GENMASK(7, 0), val);
> +
> +				val >>= BITS_PER_BYTE;
> +				buf++;
> +			}

put_unaligned_*() ?

..

> +	/* select another internal CS, which doesn't exist, so CS 0 is not used */
> +	if (spi_get_csgpiod(spi, 0))
> +		spi_config1 |= 1 << CS42L43_SPI_SS_SEL_SHIFT;

BIT() ?

> +	if (spi->mode & SPI_CPOL)
> +		spi_config1 |= CS42L43_SPI_CPOL_MASK;
> +	if (spi->mode & SPI_CPHA)
> +		spi_config1 |= CS42L43_SPI_CPHA_MASK;
> +	if (spi->mode & SPI_3WIRE)
> +		spi_config1 |= CS42L43_SPI_THREE_WIRE_MASK;

..

> +	if (is_of_node(fwnode))
> +		fwnode = fwnode_get_named_child_node(fwnode, "spi");

You can actually drop these is_of_node() tests and use another variable. In
ACPI there can't be child node in small letters.

But main problem here (and in another driver where the similar is used) that
you bumped reference count for fwnode. I haven't seen where you drop it back.
Have you tested rmmod/modprobe in a loop?

..

> +	devm_pm_runtime_enable(priv->dev);

No error check? Why?

..

> +	ret = devm_spi_register_controller(priv->dev, priv->ctlr);
> +	if (ret) {
> +		pm_runtime_disable(priv->dev);

Ah! Are you sure you properly simulated faults when testing this code?

> +		dev_err(priv->dev, "Failed to register SPI controller: %d\n", ret);
> +	}
> +
> +	return ret;

-- 
With Best Regards,
Andy Shevchenko




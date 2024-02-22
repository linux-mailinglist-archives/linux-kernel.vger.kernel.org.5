Return-Path: <linux-kernel+bounces-76658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 960DF85FAAD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481411F2830E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3451353E1;
	Thu, 22 Feb 2024 14:02:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE6D137C29;
	Thu, 22 Feb 2024 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610543; cv=none; b=OlgeQhHtOArxf6MgasqfaSalVKuoQJmeVw9+xFHyXuCoPhhQyszWJcEhPVHtz0wKkD3M8HEg1yJmxlIixeWP/jB8kJuxTP1cziQd/2IeUO6TsU6qXmL/ReX6kRYjWIRGP+ZSBxJb6hf51L7h2zTVIGblFco4dpCKLjR+KN5m6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610543; c=relaxed/simple;
	bh=0Ca7pcaxdTC94QZGuqXAmtVUf+PPMCRljrZfstySUqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7E9F3c3keu+bWbIo3dN47QxnFZ5/kdRi8sm/ONy2PP9hXgyIZFN8lCv/BupZjoF0M2jJ/J4UVvMPhyBVijvRtUCdlfFiIke35JWcA038SrzQYLyQswTxZf1DUyohRcGgY2e/fLDJzVniIS3p2bn+1KPiH3KdlptV5G8uNZy+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="6613447"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="6613447"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 06:02:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936853609"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="936853609"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 06:02:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rd9eN-00000006e1a-1QX8;
	Thu, 22 Feb 2024 16:02:11 +0200
Date: Thu, 22 Feb 2024 16:02:10 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>, Arnd Bergmann <arnd@arndb.de>,
	ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Haibo Chen <haibo.chen@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	David Lechner <dlechner@baylibre.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v14 3/3] iio: adc: ad7173: add AD7173 driver
Message-ID: <ZddT4mmxf3W55ea8@smile.fi.intel.com>
References: <20240222110817.29670-1-mitrutzceclan@gmail.com>
 <20240222110817.29670-3-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222110817.29670-3-mitrutzceclan@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 01:07:43PM +0200, Dumitru Ceclan wrote:
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.

A couple more comments which Jonathan might address when applying,
up to him.

..

With

	struct device *dev = &st->sd.spi->dev;

the below will be neater.


> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	u8 buf[AD7173_RESET_LENGTH];
> +	unsigned int id;
> +	int ret;

..

> +	if (id != st->info->id)
> +		dev_warn(&st->sd.spi->dev,
> +			 "Unexpected device id: 0x%04X, expected: 0x%04X\n",
> +			 id, st->info->id);

(like here)

..

> +	st->config_usage_counter = 0;
> +	st->config_cnts = devm_kcalloc(&st->sd.spi->dev, st->info->num_configs,
> +				       sizeof(u64), GFP_KERNEL);

sizeof(*st->config_cnts) ?

(or here)

> +	if (!st->config_cnts)
> +		return -ENOMEM;

..

> +	ret = fwnode_property_match_property_string(dev_fwnode(dev),


device_property_match_property_string()

> +						    "clock-names",
> +						    ad7173_clk_sel,
> +						    ARRAY_SIZE(ad7173_clk_sel));

..

> +	if (num_channels == 0)
> +		return dev_err_probe(dev, -EINVAL, "No channels specified\n");

-ENODATA?

-- 
With Best Regards,
Andy Shevchenko




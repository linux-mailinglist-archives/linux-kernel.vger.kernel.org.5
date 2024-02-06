Return-Path: <linux-kernel+bounces-54974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D95BF84B5BB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 445C8B24131
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB44512B17E;
	Tue,  6 Feb 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuMwlY82"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B912D15B;
	Tue,  6 Feb 2024 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224261; cv=none; b=eS3ZAfHdiaM+hmz3975NZj8RJ6A+qfXhWApB2WJ/4j8raUM5HOlS95Bg8T7W4335Ew9WjfrHNFN3XdALMxrwUEHA3UReCpsxXtX+LM/w++tkofSPa6DBFMYLYyiQZejIEKzY2IOMDaEiE22eBXLET7wlKKOeoYa+AC1iLQK1y0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224261; c=relaxed/simple;
	bh=gFFnQRKNPHoY4PPOgve57JXjMNKhFHA4PS5BolvjP5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQYLFyPEJgM90AWuGH0LKkVZYT2th9855MxdyujdyUYyEUiYDmY/+ORo0AOGH/dE70fPWaOO5B2fLHPAAULxXbX8JDoCTkYG7bMF4FSJiBGyj21UAhLT/N+jnSk6AuJWdwUq4arCpbU3XjfUAFksOoC/qxPGuy07oV1N8NGhbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuMwlY82; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707224258; x=1738760258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gFFnQRKNPHoY4PPOgve57JXjMNKhFHA4PS5BolvjP5k=;
  b=iuMwlY82mhoRwCNTx0U0BOjqzMJH/yHH8EEMMx8jQO+7BF4ZvgpGYHGS
   h5+h2roUxN3VHLPTtpNGvxV0aWZSmguopiXeso2p973rHjXFtU1/MIIYU
   lkfWXm1wseDGR9+4LVk6m/47zjAGk01U9KtF70tZ46QAGMjvFRXRrklEk
   W7cu5lQETi7vdABzJKsC7vpUFlCIWiTygA1zPzFKdKk9uKGKVZ9Uzq5KF
   dkvQhKVnDswcmOj7NzioEqtc9lwUobLe1WurFKL6QWikw/663ARh3fF96
   /nFKzlkhjcQqhTxyBaEf+wSxQ8FhPU31fIjhqp+pp4+KCwaBA860kY+Es
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="26182837"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="26182837"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:57:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="909631008"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="909631008"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:57:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXL10-00000002LJD-2VrR;
	Tue, 06 Feb 2024 14:57:30 +0200
Date: Tue, 6 Feb 2024 14:57:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Beguin <liambeguin@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Okan Sahin <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <ZcIsuiuisQjTIxJv@smile.fi.intel.com>
References: <20240206065818.2016910-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.fd628a1a-a926-426e-a239-bfd8c9858b94@emailsignatures365.codetwo.com>
 <20240206065818.2016910-2-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206065818.2016910-2-mike.looijmans@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 06, 2024 at 07:58:18AM +0100, Mike Looijmans wrote:
> Skeleton driver for the TI ADS1298 medical ADC. This device is
> typically used for ECG and similar measurements. Supports data
> acquisition at configurable scale and sampling frequency.

Thanks for an update, I have only a few style comments and a single one about
comparison (see below). If you are going to address them as suggested, feel
free to add

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

to the next version.

..

> +/* Registers */
> +#define ADS1298_REG_ID		0x00
> +#define ADS1298_MASK_ID_FAMILY			GENMASK(7, 3)
> +#define ADS1298_MASK_ID_CHANNELS		GENMASK(2, 0)
> +#define ADS1298_ID_FAMILY_ADS129X		0x90
> +#define ADS1298_ID_FAMILY_ADS129XR		0xd0

+ Blank line? (And so on for all registers that have bitfields defined)

> +#define ADS1298_REG_CONFIG1	0x01
> +#define ADS1298_MASK_CONFIG1_HR			BIT(7)
> +#define ADS1298_MASK_CONFIG1_DR			GENMASK(2, 0)
> +#define ADS1298_SHIFT_DR_HR			6
> +#define ADS1298_SHIFT_DR_LP			7
> +#define ADS1298_LOWEST_DR			0x06

..

> +	factor = (rate >> ADS1298_SHIFT_DR_HR) / val;
> +	if (factor >= 128)

I just realized that this comparison is probably better in a form

	if (factor >= ADS1298_MASK_CONFIG1_HR)

as it points out why this is a special case in comparison to 'if (factor)'
below. What do you think?

> +		cfg = ADS1298_LOWEST_DR;
> +	else if (factor)
> +		cfg = ADS1298_MASK_CONFIG1_HR | ilog2(factor); /* Use HR mode */
> +	else
> +		cfg = ADS1298_MASK_CONFIG1_HR; /* Fastest possible */

..

> +		*val = (16 << (*val & ADS1298_MASK_CONFIG1_DR));

Outer parentheses are redundant.

..

> +	wasbusy = --priv->rdata_xfer_busy;

Why preincrement? How would it be different from postincrement?

> +	if (wasbusy) {

To me more robust code would look like

	if (wasbusy < 1)
		return;
	...
	if (wasbusy > 1)
		...

> +		/*
> +		 * DRDY interrupt occurred before SPI completion. Start a new
> +		 * SPI transaction now to retrieve the data that wasn't latched
> +		 * into the ADS1298 chip's transfer buffer yet.
> +		 */
> +		spi_async(priv->spi, &priv->rdata_msg);
> +		/*
> +		 * If more than one DRDY took place, there was an overrun. Since
> +		 * the sample is already lost, reset the counter to 1 so that
> +		 * we will wait for a DRDY interrupt after this SPI transaction.
> +		 */
> +		if (wasbusy > 1)
> +			priv->rdata_xfer_busy = 1;
> +	}

..

> +		/*
> +		 * for a single transfer mode we're kept in direct_mode until

For

> +		 * completion, avoiding a race with buffered IO.
> +		 */

..

> +	wasbusy = priv->rdata_xfer_busy++;

So, it starts from negative?

> +	/* When no SPI transfer in transit, start one now */
> +	if (!wasbusy)

To be compatible with above perhaps

	if (wasbusy < 1)

also makes it more robust (all negative numbers will be considered the same.

> +		spi_async(priv->spi, &priv->rdata_msg);

..

> +	struct device *dev = &priv->spi->dev;
> +	int ret;
> +	unsigned int val;

Better ordering is so called reversed xmas tree (longest lines first):

	struct device *dev = &priv->spi->dev;
	unsigned int val;
	int ret;

..

> +	/* Device initializes into RDATAC mode, which we don't want. */

No period at the end of one-line comments (be consistent in the style over
comments of the same class).

..

> +	dev_dbg(dev, "Found %s, %u channels\n", ads1298_family_name(val),
> +		(unsigned int)(4 + 2 * (val & ADS1298_MASK_ID_CHANNELS)));

Castings in printf() is a big red flag usually (it's rarely we need them).
Why is it here?

..

> +	/* VREF can be supplied externally. Otherwise use internal reference */

Better to use comma as it's one-line comment. Or make it multi-line with
respective periods.

..

> +		ret = devm_add_action_or_reset(dev, ads1298_reg_disable,
> +					       priv->reg_vref);

Can be one line.

> +		if (ret)
> +			return ret;

..

> +	ret = devm_add_action_or_reset(dev, ads1298_reg_disable,
> +				       priv->reg_avdd);

One line.

> +	if (ret)
> +		return ret;

..

> +	if (reset_gpio) {
> +		/* Minimum reset pulsewidth is 2 clock cycles */
> +		udelay(ADS1298_CLOCKS_TO_USECS(2));
> +		gpiod_set_value(reset_gpio, 0);

I would rewrite it as

		/* Minimum reset pulsewidth is 2 clock cycles */
		gpiod_set_value(reset_gpio, 1);
		udelay(ADS1298_CLOCKS_TO_USECS(2));
		gpiod_set_value(reset_gpio, 0);

to be sure we have a reset done correctly, and the comment will make more
sense.

> +	} else {
> +		ret = ads1298_write_cmd(priv, ADS1298_CMD_RESET);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "RESET failed\n");
> +	}
> +	/* Wait 18 clock cycles for reset command to complete */
> +	udelay(ADS1298_CLOCKS_TO_USECS(18));

-- 
With Best Regards,
Andy Shevchenko




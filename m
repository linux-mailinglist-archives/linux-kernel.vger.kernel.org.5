Return-Path: <linux-kernel+bounces-52759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FB3849C60
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8B61C234CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5CC2C684;
	Mon,  5 Feb 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5w8M4kW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE3628E26;
	Mon,  5 Feb 2024 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141363; cv=none; b=mwdyUpvSQuxcCLDE90xjKsyXgeQV7LaJHo4328syV1NJjqL+M2ywtc8XaZqiWYV8DEXa3Yv3V7Mj7K9dmMXSu9GzGqSVIwdSkmTloUOY4U+PYow9chpoGBKRMQoN7SH5GkpugHGI++/fHa1hkt9PMFV9ipGhf4J14DLjW3sLio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141363; c=relaxed/simple;
	bh=Qe4U6GsgQoExV2IgmrdDmT/fxptbE/yKztioM3Ub000=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Em2IncBFIgOdaWjlumwD3FTVE0Jj/aLvsKZmIV3AwuO18z8l3CMoxQhLvkwUP6mdIY5EXtyB1DZR9LerTfVb1OQPUJ9/UXF1Cmd3DnV3Eepdjd0CJHQeJsO7Mcu/N/Y2YVdyZqle5rMu0jNgkwZvHv4CdsY25+kotXvCfYZJCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5w8M4kW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707141361; x=1738677361;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qe4U6GsgQoExV2IgmrdDmT/fxptbE/yKztioM3Ub000=;
  b=M5w8M4kW92UDE2bvmLW6Ua5RM1O7WWJxAYewACK1QdjrlCPnuZ7l68O0
   mahLuqMhZ7t6N6mHe/x9yVbg0TH8NnXZaaQ+alWPXJuDg/JoYlC3nkzcC
   Vwle+x7XK2VcnLKfw1ZlFBdDAPIDH7Ah3l+11jQHubl+F1NbE637B++UW
   TT/q7ZBRTlW40k4DZHElNUuoxz0DvEuIgQNwUZlMvdGai8MG8vW3SoAxa
   0DofuoF+hlFFPDJeEg1ICq4fFeaBvBerL+oJJI01Sten1v/uWDBfc1maG
   ZZ8Mr6ra4N9GjAIApCkUgXV6OtZ12TOxSSAHo0M9U6TbN6DFEawFLHMxp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="431973"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="431973"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:56:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="909301177"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909301177"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:55:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rWzRy-000000025x2-09QZ;
	Mon, 05 Feb 2024 15:55:54 +0200
Date: Mon, 5 Feb 2024 15:55:53 +0200
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
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <ZcDo6QvoE_e5s_f1@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo


On Fri, Feb 02, 2024 at 04:28:07PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 02, 2024 at 11:59:01AM +0100, Mike Looijmans wrote:

Hit "Send" by a mistake, here is the full review.

..

Why this can't be the part of drivers/iio/adc/ti-ads124s08.c?
Seems to me the command list is the same, registers are different though.
Broadly the Q is have you checked other existing drivers if they can
be used as a base. If not, perhaps a word in the cover letter is good to have
(sorry if I asked this already).

..

> > +#define ADS1298_WAKEUP  0x02
> > +#define ADS1298_STANDBY 0x04
> > +#define ADS1298_RESET   0x06
> > +#define ADS1298_START   0x08
> > +#define ADS1298_STOP    0x0A
> > +#define ADS1298_RDATAC  0x10
> > +#define ADS1298_SDATAC  0x11
> > +#define ADS1298_RDATA   0x12
> 
> Leftovers.

..

> > +#define ADS1298_CLOCKS_TO_USECS(x) \
> > +		(DIV_ROUND_UP((x * MICROHZ_PER_HZ), ADS1298_CLK_RATE_HZ))
> 
> Wrong place of parentheses, should be "(x) * ...".
> Don't you need to include math.h?


..

> > +#define ADS1298_MASK_CONFIG1_DR             0x07

GENMASK() ?

..

> > +struct ads1298_private {
> > +	const struct ads1298_chip_info *chip_info;
> > +	struct spi_device *spi;
> > +	struct regulator *reg_avdd;
> > +	struct regulator *reg_vref;
> > +	struct clk *clk;
> > +	struct regmap *regmap;
> > +	struct completion completion;
> > +	struct iio_trigger *trig;

> > +	struct spi_transfer rdata_xfer;
> > +	struct spi_message rdata_msg;

Do you use this outside of the ->probe()? I just ask since I removed some
context already...

> > +	spinlock_t irq_busy_lock; /* Handshake between SPI and DRDY irqs */
> > +	int rdata_xfer_busy;
> > +
> > +	/* Temporary storage for demuxing data after SPI transfer */
> > +	u32 bounce_buffer[ADS1298_MAX_CHANNELS];
> > +
> > +	/* For synchronous SPI exchanges (read/write registers) */
> > +	u8 cmd_buffer[ADS1298_SPI_CMD_BUFFER_SIZE] __aligned(IIO_DMA_MINALIGN);
> > +
> > +	/* Buffer used for incoming SPI data */
> > +	u8 rx_buffer[ADS1298_SPI_RDATA_BUFFER_SIZE];

Cacheline aligned?
I see the cmd_buffer, but shouldn't this be also aligned?

> > +	/* Contains the RDATA command and zeroes to clock out */
> > +	u8 tx_buffer[ADS1298_SPI_RDATA_BUFFER_SIZE];
> > +};

..

> > +static int ads1298_write_cmd(struct ads1298_private *priv, u8 command)
> > +{
> > +	struct spi_transfer cmd_xfer = {

I would use xfer[]...

> > +		.tx_buf = priv->cmd_buffer,
> > +		.rx_buf = priv->cmd_buffer,

> > +		.len = sizeof(command),

In other cases you use plain number, perhaps 1 is okay here for consistency's
sake?

> > +		.speed_hz = ADS1298_SPI_BUS_SPEED_SLOW,
> > +		.delay = {
> > +			.value = 2,
> > +			.unit = SPI_DELAY_UNIT_USECS,
> > +		},
> > +	};
> > +
> > +	priv->cmd_buffer[0] = command;
> > +
> > +	return spi_sync_transfer(priv->spi, &cmd_xfer, 1);

..and ARRAY_SIZE(), but either way I'm fine, i.o.w. this is also okay.

> > +}

..

> > +	/* Enable the channel  */

Too many spaces before */.

..

> > +	/* Cannot take longer than 40ms (250Hz) */
> > +	ret = wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(50));
> > +	if (!ret)
> > +		return -ETIMEDOUT;
> > +
> > +	return 0;

Can be other way around

	if (ret)
		return 0;

	return -ETIMEDOUT;

But the original is also okay.

> > +}

..

> > +	if (priv->clk)
> > +		rate = clk_get_rate(priv->clk);

> > +	else
> > +		rate = ADS1298_CLK_RATE_HZ;

Dead code (here and elsewhere). You probably wanted _optional clk APIs
in the probe.

> > +	if (!rate)
> > +		return -EINVAL;

..

> > +	factor = (rate >> ADS1298_SHIFT_DR_HR) / val;
> > +	if (factor >= 128) {
> > +		cfg = ADS1298_LOWEST_DR;
> > +	} else if (factor <= 1) {
> > +		cfg = ADS1298_MASK_CONFIG1_HR; /* Fastest possible */
> > +	} else {
> > +		cfg = fls(factor) - 1;
> > +		cfg |= ADS1298_MASK_CONFIG1_HR; /* Use HR mode */
> > +	}

What about:

	factor = (rate >> ADS1298_SHIFT_DR_HR) / val;
	if (factor >= 128)
		cfg = ADS1298_LOWEST_DR;
	else if (factor)
		cfg = ADS1298_MASK_CONFIG1_HR | ilog2(factor); /* Use HR mode */
	else
		cfg = ADS1298_MASK_CONFIG1_HR; /* Fastest possible */

(will need log2.h to be included)

..

> > +		*val = ret / 1000; /* Convert to millivolts */

MILLI ?

..

> > +		*val = sign_extend32(get_unaligned_be24(priv->rx_buffer + chan->address),
> > +				     23);

Second time magic 23, can you define a constant and use it everywhere?

..

> > +static int ads1298_reg_write(void *context, unsigned int reg, unsigned int val)
> > +{
> > +	struct ads1298_private *priv = context;
> > +	struct spi_transfer reg_write_xfer = {
> > +		.tx_buf = priv->cmd_buffer,
> > +		.rx_buf = priv->cmd_buffer,
> > +		.len = 3,
> > +		.speed_hz = ADS1298_SPI_BUS_SPEED_SLOW,
> > +		.delay = {
> > +			.value = 2,
> > +			.unit = SPI_DELAY_UNIT_USECS,
> > +		},
> > +	};
> > +
> > +	priv->cmd_buffer[0] = ADS1298_CMD_WREG | reg;

> > +	priv->cmd_buffer[1] = 0x0;
> > +	priv->cmd_buffer[2] = val;

Sounds to me like put_unaligned_be16().

> > +
> > +	return spi_sync_transfer(priv->spi, &reg_write_xfer, 1);
> > +}

..

> > +	priv->cmd_buffer[0] = ADS1298_CMD_RREG | reg;
> > +	priv->cmd_buffer[1] = 0x0;
> > +	priv->cmd_buffer[2] = 0;

Ditto.

> > +	ret = spi_sync_transfer(priv->spi, &reg_read_xfer, 1);
> > +	if (ret)
> > +		return ret;

..

> > +	*val = priv->cmd_buffer[2];

Just wondering if the above is correct assumption, this probably needs to be
get_unaligned_be16().


..

> > +	unsigned long flags;
> > +
> > +	/* Notify we're no longer waiting for the SPI transfer to complete */
> > +	spin_lock_irqsave(&priv->irq_busy_lock, flags);
> > +	priv->rdata_xfer_busy = 0;
> > +	spin_unlock_irqrestore(&priv->irq_busy_lock, flags);

Use cleanup.h?

..

> > +static int ads1298_update_scan_mode(struct iio_dev *indio_dev,
> > +				    const unsigned long *scan_mask)
> > +{
> > +	struct ads1298_private *priv = iio_priv(indio_dev);
> > +	unsigned int val;
> > +	int ret;
> > +	int i;
> > +
> > +	/* Make the interrupt routines start with a clean slate */
> > +	ads1298_rdata_unmark_busy(priv);
> > +
> > +	/* Power down channels that aren't in use */

This comment does not describe why you need to write to _all_ channels.

> > +	for (i = 0; i < ADS1298_MAX_CHANNELS; i++) {
> > +		val = test_bit(i, scan_mask) ? 0 : ADS1298_MASK_CH_PD;

With above in mind, this perhaps needs to be one of for_each_set_bit(scan_mask) /
for_each_clear_bit(scan_mask).

> > +		ret = regmap_update_bits(priv->regmap, ADS1298_REG_CHnSET(i),
> > +					 ADS1298_MASK_CH_PD, val);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}

..

> > +	unsigned long flags;

cleanup.h

> > +	int wasbusy;
> > +
> > +	spin_lock_irqsave(&priv->irq_busy_lock, flags);
> > +
> > +	wasbusy = --priv->rdata_xfer_busy;
> > +	if (wasbusy) {
> > +		/*
> > +		 * DRDY interrupt occurred before SPI completion. Start a new
> > +		 * SPI transaction now to retrieve the data that wasn't latched
> > +		 * into the ADS1298 chip's transfer buffer yet.
> > +		 */
> > +		spi_async(priv->spi, &priv->rdata_msg);
> > +		/*
> > +		 * If more than one DRDY took place, there was an overrun. Since
> > +		 * the sample is already lost, reset the counter to 1 so that
> > +		 * we will wait for a DRDY interrupt after this SPI transaction.
> > +		 */
> > +		if (wasbusy > 1)
> > +			priv->rdata_xfer_busy = 1;
> > +	}
> > +
> > +	spin_unlock_irqrestore(&priv->irq_busy_lock, flags);

..

> > +static irqreturn_t ads1298_interrupt(int irq, void *dev_id)

Ditto.

..

> > +	.cache_type = REGCACHE_RBTREE,

Why not MAPPLE TREE?

..

> > +static const char *ads1298_family_name(unsigned int id)
> > +{
> > +	switch (id & ADS1298_MASK_ID_FAMILY) {
> > +	case ADS1298_ID_FAMILY_ADS129X:
> > +		return "ADS129x";
> > +	case ADS1298_ID_FAMILY_ADS129XR:
> > +		return "ADS129xR";
> > +	default:
> > +		return "(unknown)";

Hmm... Maybe "" is enough? What is the practice in IIO for this? Jonathan?

> > +	}
> > +}

..

> > +	dev_info(dev, "Found %s, %u channels\n", ads1298_family_name(val),
> > +		 4 + 2 * (val & ADS1298_MASK_ID_CHANNELS));

How is this useful? Can't sysfs already give an answer to these Q:s?

..

> > +	if (IS_ERR(priv->reg_vref)) {
> > +		if (PTR_ERR(priv->reg_vref) == -ENODEV)
> > +			priv->reg_vref = NULL;

> > +		else

Redundant if you check for an error cases first.

> > +			return dev_err_probe(dev, PTR_ERR(priv->reg_avdd),
> > +					     "Failed to get vref regulator\n");
> > +	} else {
> > +		ret = regulator_enable(priv->reg_vref);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = devm_add_action_or_reset(dev, ads1298_reg_disable,
> > +					       priv->reg_vref);
> > +		if (ret)
> > +			return ret;
> > +	}

..

> > +	priv->clk = devm_clk_get_enabled(dev, "clk");

_optional? See above.

> > +	if (IS_ERR(priv->clk))

> > +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> > +				     "Failed to get clk\n");

One line? (Even in strict, i.e. 80 limit, mode checkpatch won't complain on it)

..

> > +	priv->regmap = devm_regmap_init(dev, NULL, priv,
> > +					&ads1298_regmap_config);

One line? (It's 81, which we may very well tolerate)

> > +	if (IS_ERR(priv->regmap))
> > +		return PTR_ERR(priv->regmap);

..

> > +	if (reset_gpio) {

> > +		udelay(ADS1298_CLOCKS_TO_USECS(2));

Why this delay (the after one is explained, though)?

> > +		gpiod_set_value(reset_gpio, 0);
> > +	} else {
> > +		ret = ads1298_write_cmd(priv, ADS1298_CMD_RESET);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret, "RESET failed\n");
> > +	}
> > +	/* Wait 18 clock cycles for reset command to complete */
> > +	udelay(ADS1298_CLOCKS_TO_USECS(18));

-- 
With Best Regards,
Andy Shevchenko




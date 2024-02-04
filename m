Return-Path: <linux-kernel+bounces-51762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC997848F09
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EFA928319A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEF022618;
	Sun,  4 Feb 2024 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr2o/PQt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E920224FB;
	Sun,  4 Feb 2024 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707062078; cv=none; b=T0Z5ZoDtnSPUijSVd+SjHqe9H+qzsVqojOd3uhDo0h14fnN+SptVbIZHRystboq3Vs7xTJjhMEPj+tFd5BHY6GkJaQmof7hyh8J9IFM4poVkt8rQL/UlsIQzpiKItAE4+7WYGbT/ZOtF+Dlyl9xhcLZQ6cLL/Grkc7+hJkBxngI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707062078; c=relaxed/simple;
	bh=YKFk0fhw1yKmiLgnS6+duQR/LC6Nzpfu5Y1k0cwgcx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kp1OD8nkVjztFLYcKYKusrKzLHpplrqeuYlvy8QNkYQg8Z90e45dGe/7wOoCO0NUQQRC8Dk7g0vgKp8HEeTAciaFQh87QHKSUJbqo5JiaNuTaxrgHav0NtMgjOsvbUuTCQg/wNfkT4w8yPBttbOsbxr6PL86/1ckchDmN8hNc9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr2o/PQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F468C433F1;
	Sun,  4 Feb 2024 15:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707062078;
	bh=YKFk0fhw1yKmiLgnS6+duQR/LC6Nzpfu5Y1k0cwgcx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kr2o/PQtO+6cKZ+/I+Z5dnrgYRXvoUE54ciPpbZEiH5dw9Ucfw4iX1rBKeGL05c1G
	 twyQiP3ESA7m5FGOzApClwNbMIaLRShn7UP9J+NTaRSmYFFRcqd1c4f43hhiEqflP9
	 PF0NEC3CR8g59QTWiuEGmEeLwrfDwX89MH+nlzak/BTrZcZsD0JKpIOydupNU6hIHQ
	 Ztew9WJYhNjcA6+BYxDkJkBP5EirA7lOlFCFURgr2fENY4HDWB9N2YSw5gEpoSprE/
	 qyrn0WKwNYEfVRswhBUV5ndUDqqZmw5Upn0CguluGQFUUwqD1dibZVCIU2zuJgn8Tw
	 BOafPnxYnUcHQ==
Date: Sun, 4 Feb 2024 15:54:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Liam Beguin <liambeguin@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Maksim Kiselev <bigunclemax@gmail.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Marius Cristea
 <marius.cristea@microchip.com>, Mark Brown <broonie@kernel.org>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Okan Sahin <okan.sahin@analog.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <20240204155422.5ae03e4c@jic23-huawei>
In-Reply-To: <20240202105901.925875-2-mike.looijmans@topic.nl>
References: <20240202105901.925875-1-mike.looijmans@topic.nl>
	<1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.6274d473-fd3f-439a-bf61-89eea8028afa@emailsignatures365.codetwo.com>
	<20240202105901.925875-2-mike.looijmans@topic.nl>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Feb 2024 11:59:01 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> Skeleton driver for the TI ADS1298 medical ADC. This device is
> typically used for ECG and similar measurements. Supports data
> acquisition at configurable scale and sampling frequency.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
Hi Mike,

A few minor things I'd missed before.

I'm still interested in why more standard interrupt handling isn't
good enough here (see reply to v1 thread) but if we can't get to the bottom
of that (or do figure it out and we can't fix it) then this doesn't look
too bad so I'll accept the complex handling.

J

> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> new file mode 100644
> index 000000000000..539598b9f3fa
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1298.c
> @@ -0,0 +1,769 @@

> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>

I don't see any custom ABI, so shouldn't need this.

> +
> +#include <asm/unaligned.h>
> +



> +static int ads1298_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct ads1298_private *priv = context;
> +	struct spi_transfer reg_read_xfer = {
> +		.tx_buf = priv->cmd_buffer,
> +		.rx_buf = priv->cmd_buffer,
> +		.len = 3,
> +		.speed_hz = ADS1298_SPI_BUS_SPEED_SLOW,
> +		.delay = {
> +			.value = 2,
> +			.unit = SPI_DELAY_UNIT_USECS,
> +		},
> +	};
> +	int ret;
> +
> +	priv->cmd_buffer[0] = ADS1298_CMD_RREG | reg;
> +	priv->cmd_buffer[1] = 0x0;

Why mix of hex and decimal? Doesn't matter but looks odd


> +	priv->cmd_buffer[2] = 0;
> +
> +	ret = spi_sync_transfer(priv->spi, &reg_read_xfer, 1);
> +	if (ret)
> +		return ret;
> +
> +	*val = priv->cmd_buffer[2];
> +
> +	return 0;
> +}

> +
> +/* Called from SPI completion interrupt handler */
> +static void ads1298_rdata_complete(void *context)
> +{
> +	struct iio_dev *indio_dev = context;
> +	struct ads1298_private *priv = iio_priv(indio_dev);
> +	int scan_index;
> +	u32 *bounce = priv->bounce_buffer;
> +
> +	if (!iio_buffer_enabled(indio_dev)) {

Good to add a comment here on why this can't race as we are holding
the device in direct mode until after the completion.

iio_buffer_enabled() checks tend to expose races so I prefer people
to explicitly say why there isn't one.



> +		/* Happens when running in single transfer mode */
> +		ads1298_rdata_unmark_busy(priv);
> +		complete(&priv->completion);
> +		return;
> +	}
> +
> +	/* Demux the channel data into our bounce buffer */
> +	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		const struct iio_chan_spec *scan_chan =
> +					&indio_dev->channels[scan_index];
> +		const u8 *data = priv->rx_buffer + scan_chan->address;
> +
> +		*bounce++ = get_unaligned_be24(data);
> +	}
> +
> +	/* rx_buffer can be overwritten from this point on */
> +	ads1298_rdata_release_busy_or_restart(priv);
> +
> +	iio_push_to_buffers(indio_dev, priv->bounce_buffer);
> +}

> +
> +static const char *ads1298_family_name(unsigned int id)
> +{
> +	switch (id & ADS1298_MASK_ID_FAMILY) {
> +	case ADS1298_ID_FAMILY_ADS129X:
> +		return "ADS129x";
> +	case ADS1298_ID_FAMILY_ADS129XR:
> +		return "ADS129xR";
> +	default:
> +		return "(unknown)";
> +	}
> +}
> +
> +static int ads1298_init(struct ads1298_private *priv)
> +{
> +	struct device *dev = &priv->spi->dev;
> +	int ret;
> +	unsigned int val;
> +
> +	/* Device initializes into RDATAC mode, which we don't want. */
> +	ret = ads1298_write_cmd(priv, ADS1298_CMD_SDATAC);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(priv->regmap, ADS1298_REG_ID, &val);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(dev, "Found %s, %u channels\n", ads1298_family_name(val),
> +		 4 + 2 * (val & ADS1298_MASK_ID_CHANNELS));
Noise for the log that is easy to figure out anyway (assuming successful
probe) Make that dev_dbg()

> +
> +	/* Enable internal test signal, double amplitude, double frequency */
> +	ret = regmap_write(priv->regmap, ADS1298_REG_CONFIG2,
> +		ADS1298_MASK_CONFIG2_RESERVED |
> +		ADS1298_MASK_CONFIG2_INT_TEST |
> +		ADS1298_MASK_CONFIG2_TEST_AMP |
> +		ADS1298_MASK_CONFIG2_TEST_FREQ_FAST);

Unless lines are very long, parameters should align just after (


> +	if (ret)
> +		return ret;
> +
> +	val = ADS1298_MASK_CONFIG3_RESERVED; /* Must write 1 always */
> +	if (!priv->reg_vref) {
> +		/* Enable internal reference */
> +		val |= ADS1298_MASK_CONFIG3_PWR_REFBUF;
> +		/* Use 4V VREF when power supply is at least 4.4V */
> +		if (regulator_get_voltage(priv->reg_avdd) >= 4400000)
> +			val |= ADS1298_MASK_CONFIG3_VREF_4V;
> +	}
> +	return regmap_write(priv->regmap, ADS1298_REG_CONFIG3, val);
> +}
> +
> +static int ads1298_probe(struct spi_device *spi)
> +{

..

> +	ret = devm_request_irq(dev, spi->irq, &ads1298_interrupt,
> +			       IRQF_TRIGGER_FALLING, indio_dev->name,
I missed this before (and we've gotten it wrong a bunch of times in the past
so plenty of bad examples to copy that we can't fix without possible
regressions) but we generally now leave irq direction to the firmware description.
People have an annoying habit of putting not gates and similar in the path
to interrupt pins.  Fine to have the binding state the expected form though
(as you do).  So basically not flags here.

I'm still curious to understand more of where the delays that lead to
needing to do this complex handling came from, but I guess it's not too bad
if we can't get to the bottom of that so I'll take the driver anyway
(after a little more time on list for others to review!)

> +			       indio_dev);



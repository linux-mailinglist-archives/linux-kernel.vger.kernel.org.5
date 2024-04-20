Return-Path: <linux-kernel+bounces-152265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 143E38ABB9C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 14:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 640EFB21309
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 12:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BC517C72;
	Sat, 20 Apr 2024 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE1vyDIl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231C61427B;
	Sat, 20 Apr 2024 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713617689; cv=none; b=DlbuW0pyMytUvI6CKxmNzOoHHs83tUOfji3vUCzFIisAEQRmYaYRFiw32yyDdCUAxyzN2rML7gl8YPBKGWr0twD9yiMG/VPt3NgSuzIDnqa5lKOQRE0V9rQPleMYODozpaMv94GexidOVOjAQD576DnesrGuzL+qI0bsF9BkqSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713617689; c=relaxed/simple;
	bh=OAyWRoQh13wEVCJKYZEg0+Lj87BgD6LQIY3Tdf0+2dY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJB/y8mkVD65UmELyZXI9X/QfBeKLJYpWsF+p1t6BkcgKQJpg5bPHlt2Qa3ZzJ112Cc5DcHIIKtb088+7i2W3JLXc7h9M1RvOTi3b0B9h5kPQA5lm9c4KBQcm9R6GhAaJO8gxCArYeFbAqrWB4oF6iTFVVgkKqmq9W6lhxSR7Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE1vyDIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F90C072AA;
	Sat, 20 Apr 2024 12:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713617688;
	bh=OAyWRoQh13wEVCJKYZEg0+Lj87BgD6LQIY3Tdf0+2dY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nE1vyDIldkY2a+8NuZOJbfbZ2ugSqNNGZ0j7i40Fs7ZAJcTW2JFVdhVMrMAwZ7nCA
	 59SE3CtN3tpSNAk/EPHgmw+uhoqEjOE7+c0xkV76z5lQZXaorCOnHreYoJ97QqL3Qj
	 iquSSB86bapvQLWjHR++sFZvUYxDJcVc6ievvRw9DtoR27LPOzCxpLMznGY31ZBqjb
	 EURqXZIOaA+tdIRr8ikAo1hrz90xw7ePQRU1BtVT+VPoPuqdJbdo9M1sDRkgE8kxIZ
	 pIzBvmHvbHaEdbKSpmU5PmTiLGY4QNxPcrfctAcStm6KD3mou/NXSBTBoWlf3VpUb1
	 gEUyIJssbAnAw==
Date: Sat, 20 Apr 2024 13:54:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Paul Geurts <paul_geurts@live.nl>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl345: Added buffered read support
Message-ID: <20240420135438.03f17072@jic23-huawei>
In-Reply-To: <AM0PR09MB26757E9F7575A2357E318C50950F2@AM0PR09MB2675.eurprd09.prod.outlook.com>
References: <AM0PR09MB26757E9F7575A2357E318C50950F2@AM0PR09MB2675.eurprd09.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 10:28:34 +0200
Paul Geurts <paul_geurts@live.nl> wrote:

Hi Paul, various comments inline.


> This implements buffered reads for the accelerometer data. A buffered
> IIO device is created containing 3 channels. The device FIFO is used for
> sample buffering to reduce the IRQ load on the host system.
> 
> Reading of the device is triggered by a FIFO waterlevel interrupt. The
> waterlevel settings are dependent on the sampling frequency to leverage
> IRQ load against responsiveness.

I'm unconvinced that trade off belongs in the driver. Until now we
have exposed all the relevant controls to userspace via bufferX/watermark.
Set that to 0 or 1 if you don't want a fifo and appropriate level for whatever
responsiveness is needed for a particular application.

The need to manually disable / enable interrupts is also normally something
that needs a close look. Very very occasionally this is necessary but for most
devices IRQF_ONESHOT should provide suitable masking.

It's also not clear that a trigger is appropriate here. For FIFO equipped devices
like this, the trigger abstraction often doesn't work as we don't have one interrupt
per 'scan' of data.  In these cases it is not necessary to use a trigger at all
and that can simplify things considerably.

Jonathan

> 
> Signed-off-by: Paul Geurts <paul_geurts@live.nl>

> ---
>  drivers/iio/accel/adxl345.h      |   2 +-
>  drivers/iio/accel/adxl345_core.c | 387 ++++++++++++++++++++++++++++---
>  drivers/iio/accel/adxl345_i2c.c  |   2 +-
>  drivers/iio/accel/adxl345_spi.c  |   2 +-
>  4 files changed, 363 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index 284bd387ce69..269ce69517ce 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -28,6 +28,6 @@ struct adxl345_chip_info {
>  	int uscale;
>  };
>  
> -int adxl345_core_probe(struct device *dev, struct regmap *regmap);
> +int adxl345_core_probe(struct device *dev, struct regmap *regmap, int irq);
>  
>  #endif /* _ADXL345_H_ */
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 8bd30a23ed3b..1f38d2287783 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -11,28 +11,50 @@
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/units.h>
> +#include <linux/irq.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #include "adxl345.h"
>  
>  #define ADXL345_REG_DEVID		0x00
> +#define ADXL345_REG_THRESH_TAP 0x1D
>  #define ADXL345_REG_OFSX		0x1e
>  #define ADXL345_REG_OFSY		0x1f
>  #define ADXL345_REG_OFSZ		0x20
>  #define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
>  #define ADXL345_REG_BW_RATE		0x2C
>  #define ADXL345_REG_POWER_CTL		0x2D
> +#define ADXL345_REG_INT_ENABLE   0x2E
> +#define ADXL345_REG_INT_SOURCE   0x30
>  #define ADXL345_REG_DATA_FORMAT		0x31
>  #define ADXL345_REG_DATAX0		0x32
>  #define ADXL345_REG_DATAY0		0x34
>  #define ADXL345_REG_DATAZ0		0x36
>  #define ADXL345_REG_DATA_AXIS(index)	\
>  	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
> +#define ADXL345_REG_FIFO_CTL		0x38
> +#define ADXL345_REG_FIFO_STATUS		0x39
>  
>  #define ADXL345_BW_RATE			GENMASK(3, 0)
>  #define ADXL345_BASE_RATE_NANO_HZ	97656250LL
> +#define ADXL345_MAX_RATE_NANO_HZ	(3200LL * NANOHZ_PER_HZ)
> +#define ADXL345_MAX_BUFFERED_RATE	400L
> +#define ADXL345_DEFAULT_RATE		(100LL * NANOHZ_PER_HZ)
> +
> +#define ADXL345_INT_DATA_READY	BIT(7)
> +#define ADXL345_INT_SINGLE_TAP	BIT(6)
> +#define ADXL345_INT_DOUBLE_TAP	BIT(5)
> +#define ADXL345_INT_ACTIVITY	BIT(4)
> +#define ADXL345_INT_INACTIVITY	BIT(3)
> +#define ADXL345_INT_FREE_FALL	BIT(2)
> +#define ADXL345_INT_WATERMARK	BIT(1)
> +#define ADXL345_INT_OVERRUN	BIT(0)
>  
>  #define ADXL345_POWER_CTL_MEASURE	BIT(3)
>  #define ADXL345_POWER_CTL_STANDBY	0x00
> @@ -43,12 +65,30 @@
>  #define ADXL345_DATA_FORMAT_8G		2
>  #define ADXL345_DATA_FORMAT_16G		3
>  
> -#define ADXL345_DEVID			0xE5
> +#define ADXL345_FIFO_CTL_MODE_FIFO		BIT(6)
> +#define ADXL345_FIFO_CTL_MODE_STREAM		BIT(7)
> +#define ADXL345_FIFO_CTL_MODE_TRIGGER		(BIT(6) | BIT(7))
> +#define ADXL345_FIFO_CTL_SAMPLES_MASK		GENMASK(4, 0)
> +#define ADXL345_FIFO_CTL_SAMPLES(n)		((n) & ADXL345_FIFO_CTL_SAMPLES_MASK)
> +#define ADXL345_FIFO_MAX_FREQ_WATERLEVEL	20
> +
> +#define ADXL345_DEVID	0xE5

No obvious reason to realign this so put it back as it was before.

> +
> +#define ADXL345_SCAN_SIZE	(sizeof(__le16) * 3)
>  
>  struct adxl345_data {
>  	const struct adxl345_chip_info *info;
>  	struct regmap *regmap;
> -	u8 data_range;
> +	int irq;
> +
> +	struct iio_trigger *drdy_trig;
> +	/*
> +	 * This lock is for protecting the consistency of series of i2c operations, that is, to
> +	 * make sure a measurement process will not be interrupted by a set frequency operation,
> +	 * which should be taken where a series of i2c or SPI operations start, released where the

Wrap at 80 chars.

Also can probably just say "protects internal device state during a measurement."

> +	 * operation ends.
> +	 */
> +	struct mutex lock;
>  };

> +
> +/* Trigger handling */
> +static irqreturn_t adxl345_irq_handler(int irq, void *d)
> +{
> +	struct iio_dev *indio_dev = d;
> +	struct adxl345_data *data = iio_priv(indio_dev);
> +	int regval, ret;
> +
> +	ret = regmap_read(data->regmap, ADXL345_REG_INT_SOURCE, &regval);
> +	if (ret < 0) {
> +		dev_err(indio_dev->dev.parent, "Broken IRQ!\n");

It's a comms error, nothing necessarily wrong with the IRQ.
So perhaps just log that you couldn't read the int source regsiter.

> +		return IRQ_HANDLED;
> +	}
> +
> +	if (regval & ADXL345_INT_OVERRUN)
> +		dev_err(indio_dev->dev.parent, "FIFO overrun detected! Data lost\n");

Probably best to use a rate limited print here. Otherwise far too easy to fill
the whole kernel log with these.

> +
> +	if (regval & ADXL345_INT_WATERMARK)
> +		iio_trigger_poll_nested(data->drdy_trig);

As below - if it isn't useful to present a trigger to userspace, don't have one.
It's fine to have fifo equiped devices with buffers register the buffer directly
and fill it directly from the watermark interrupt.  Several other drivers do this
because the trigger model isn't a good fit for them.

> +	else
> +		dev_err(indio_dev->dev.parent, "Unexpected IRQ! Source: 0x%02X\n", regval);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int adxl345_get_sampling_freq(struct adxl345_data *data, s64 *freq_nhz)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	mutex_lock(&data->lock);
> +	ret = regmap_read(data->regmap, ADXL345_REG_BW_RATE, &regval);

Add a comment on why the lock is needed for this register read. If the device is
unable to cope with interleaving reads with other activity that is unusual
and we might need to think about how to enforce that more generally.

> +	mutex_unlock(&data->lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	*freq_nhz = ADXL345_BASE_RATE_NANO_HZ <<
> +			(regval & ADXL345_BW_RATE);
> +
> +	return IIO_VAL_INT_PLUS_NANO;
It doesn't. It returns a value that is then acted on to make this true.
Return 0 from this function on success and only return this at the caller
after doing more maths.

> +}
> +
> +static int adxl345_set_sampling_freq(struct adxl345_data *data, s64 freq_nhz)
> +{
> +	int ret, waterlevel;
> +	s64 n;
> +
> +	/* Only allow valid sampling rates */
> +	if (freq_nhz < ADXL345_BASE_RATE_NANO_HZ || freq_nhz > ADXL345_MAX_RATE_NANO_HZ)
> +		return -EINVAL;
> +
> +	/*
> +	 * Trade-off the number of IRQs to the responsiveness on lower sample rates.
> +	 * sample rates < 100Hz don't use the FIFO

This feels like a userspace problem.
If userspace sets the watermark to 0 or 1, don't use the fifo, otherwise do
so. In driver handling is complex and the correct answers depend on the hardware
platform.

There is ABI to let userspace control the watermark directly.


> +	 * 100<>1600Hz issue 100 IRQs per second
> +	 * 3200Hz issues 160 IRQs per second
> +	 */
> +	if (freq_nhz < ADXL345_DEFAULT_RATE)
> +		waterlevel = 0;
> +	else if (freq_nhz < ADXL345_MAX_RATE_NANO_HZ)
> +		waterlevel = (freq_nhz / ADXL345_DEFAULT_RATE);
> +	else
> +		waterlevel = ADXL345_FIFO_MAX_FREQ_WATERLEVEL;
> +
> +	n = div_s64(freq_nhz, ADXL345_BASE_RATE_NANO_HZ);
> +
> +	/* Disable the IRQ before claiming the mutex to prevent deadlocks */
What is the deadlock? I can see some races with values, but not an obvious
deadlock.

Also can we do what most drivers do which is just prevent updating the sampling
frequency (and similar parameter) whilst in buffered mode?
iio_device_claim_direct_mode() is there to provide a race free way to do this
sort of thing.

It's fine to make userspace stop a buffer, update settings and restart it.

> +	if (data->irq)
> +		disable_irq(data->irq);
> +
> +	mutex_lock(&data->lock);
> +	ret = regmap_update_bits(data->regmap, ADXL345_REG_BW_RATE,
> +				 ADXL345_BW_RATE, clamp_val(ilog2(n), 0, ADXL345_BW_RATE));
> +	if (ret < 0)
> +		goto out;
> +	ret = regmap_update_bits(data->regmap, ADXL345_REG_FIFO_CTL,
> +				 ADXL345_FIFO_CTL_SAMPLES_MASK,
> +				 ADXL345_FIFO_CTL_SAMPLES(waterlevel));
> +
> +out:
> +	mutex_unlock(&data->lock);
> +	if (data->irq)
> +		enable_irq(data->irq);
> +	return ret;
> +}
> +
> +/* Direct mode functions */
>  static int adxl345_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
> @@ -80,26 +219,35 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret < 0)
> +			return ret;
>  		/*
>  		 * Data is stored in adjacent registers:
>  		 * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte
>  		 * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte
>  		 */
> +		mutex_lock(&data->lock);
>  		ret = regmap_bulk_read(data->regmap,
>  				       ADXL345_REG_DATA_AXIS(chan->address),
>  				       &accel, sizeof(accel));
> +		mutex_unlock(&data->lock);
>  		if (ret < 0)
>  			return ret;
>  
>  		*val = sign_extend32(le16_to_cpu(accel), 12);
> +
> +		iio_device_release_direct_mode(indio_dev);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 0;
>  		*val2 = data->info->uscale;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> +		mutex_lock(&data->lock);
>  		ret = regmap_read(data->regmap,
>  				  ADXL345_REG_OFS_AXIS(chan->address), &regval);
> +		mutex_unlock(&data->lock);

If we always need to take the lock because reads can interrupt fifo read out (seems
that might be the case from a quick look at the datasheet, then
set regmap to not use it's internal locking and wrap these calls up locally
with the lock.

Do that in a precursor patch with a comment to say why it is necessary later
in the series.

>  		if (ret < 0)
>  			return ret;
>  		/*
> @@ -110,15 +258,10 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		ret = regmap_read(data->regmap, ADXL345_REG_BW_RATE, &regval);
> -		if (ret < 0)
> -			return ret;
> -
> -		samp_freq_nhz = ADXL345_BASE_RATE_NANO_HZ <<
> -				(regval & ADXL345_BW_RATE);
> +		ret =  adxl345_get_sampling_freq(data, &samp_freq_nhz);

Data may be invalid, so don't carry on to do maths if it is.

>  		*val = div_s64_rem(samp_freq_nhz, NANOHZ_PER_HZ, val2);

as above,the value is not IIO_VAL_INT_PLUS_NANO until after this maths
so not appropriate to have the get_sampling_freq() function return
a value that implies this maths is not needed.
>  
> -		return IIO_VAL_INT_PLUS_NANO;
> +		return ret;
 
>  	}
>  
>  	return -EINVAL;
> @@ -129,7 +272,7 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
>  			     int val, int val2, long mask)
>  {
>  	struct adxl345_data *data = iio_priv(indio_dev);
> -	s64 n;
> +	int ret = -EINVAL;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_CALIBBIAS:
> @@ -137,20 +280,17 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
>  		 * 8-bit resolution at +/- 2g, that is 4x accel data scale
>  		 * factor
>  		 */
> -		return regmap_write(data->regmap,
> -				    ADXL345_REG_OFS_AXIS(chan->address),
> -				    val / 4);
> +		mutex_lock(&data->lock);
> +		ret = regmap_write(data->regmap,
> +				   ADXL345_REG_OFS_AXIS(chan->address), val / 4);
> +		mutex_unlock(&data->lock);
> +		break;
		return ret;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		n = div_s64(val * NANOHZ_PER_HZ + val2,
> -			    ADXL345_BASE_RATE_NANO_HZ);
> -
> -		return regmap_update_bits(data->regmap, ADXL345_REG_BW_RATE,
> -					  ADXL345_BW_RATE,
> -					  clamp_val(ilog2(n), 0,
> -						    ADXL345_BW_RATE));
> +		ret = adxl345_set_sampling_freq(data, (s64)(val * NANOHZ_PER_HZ + val2));
> +		break;
		return adxl345...

We do direct returns for a reason, don't change it without a strong
argument (more on this below).

>  	}
>  
> -	return -EINVAL;
> +	return ret;
You could push this into a default: statement in the switch, but definitely
don't make all paths now return down here. That makes the code harder
to review.

>  }
>  
>  static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
> @@ -197,7 +337,149 @@ static void adxl345_powerdown(void *regmap)
>  	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
>  }
>  
> -int adxl345_core_probe(struct device *dev, struct regmap *regmap)
> +static int adxl345_flush_fifo(struct regmap *map)
> +{
> +	__le16 axis_data[3];
> +	int ret, regval;
> +
> +	/* Clear the sample FIFO */
> +	ret = regmap_read(map, ADXL345_REG_INT_SOURCE, &regval);

Why not use the FIFO_STATUS register and read out whatever that tells us is
in the FIFO? Can at least read that many before having to check if there are
more. 

> +	if (ret < 0)
> +		goto out;
return ret;
> +	while (regval & ADXL345_INT_DATA_READY) {
> +		ret = regmap_bulk_read(map, ADXL345_REG_DATA_AXIS(0), &axis_data,
> +				       sizeof(axis_data));
> +		if (ret < 0)
> +			goto out;
The datasheet puts a timing requirement on repeat reads that you need to enforce..
5 usec.

return ret;
> +		ret = regmap_read(map, ADXL345_REG_INT_SOURCE, &regval);
> +		if (ret < 0)
> +			goto out;

return directly - going to a label that does nothing makes a reviewer
following code paths have to go see that nothing happens.

			return ret;

> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +static int adxl345_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct adxl345_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	/* Disable measurement mode to setup everything */
> +	ret = regmap_clear_bits(data->regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_MEASURE);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = adxl345_flush_fifo(data->regmap);
> +	if (ret < 0)
> +		goto out_enable;
> +
> +	/*
> +	 * Set the FIFO up in streaming mode so the chip keeps sampling.
> +	 * Waterlevel is set by the sample frequency functions as it is dynamic

This I don't follow.  Why is it dynamic?  It's fixed for a given run at a given
frequency. I can sort of see a true dynamic adjustment might make sense, but that
would be complex and isn't obviously a problem for the kernel.

I'd prefer to see this done like the majority of other fifo handling drivers:
Make setting the watermark vs frequency a userspace problem.

> +	 */
> +	ret = regmap_update_bits(data->regmap, ADXL345_REG_FIFO_CTL,
> +				 (int)~(ADXL345_FIFO_CTL_SAMPLES_MASK),
> +				 ADXL345_FIFO_CTL_MODE_STREAM);
> +	if (ret < 0)
> +		goto out_enable;
> +
> +	/* Enable the Watermark and Overrun interrupt */
> +	ret = regmap_write(data->regmap, ADXL345_REG_INT_ENABLE, (ADXL345_INT_WATERMARK |
> +			   ADXL345_INT_OVERRUN));
> +	if (ret < 0)
> +		goto out_enable;
> +
> +	/* Re-enable measurement mode */
> +	ret = regmap_set_bits(data->regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_MEASURE);
> +	goto out;
Don't do this as it makes for messy control flow to review

	if (ret)
		goto out_enabled;

	mutex_unlock(&data->lock)
	return 0;

out_enable:
..
Can use guard(mutex)(&data->lock) to avoid need to unlock manually and allow at least
some paths to return directly.

> +
> +out_enable:
> +	dev_err(indio_dev->dev.parent, "Error %d Setting up device\n", ret);
> +	/* Re-enable measurement mode */
> +	regmap_set_bits(data->regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_MEASURE);
> +out:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +static int adxl345_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct adxl345_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->lock);
> +	/* Disable measurement mode and interrupts*/
> +	regmap_clear_bits(data->regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_MEASURE);

Check errors on all these accesses.

> +	regmap_write(data->regmap, ADXL345_REG_INT_ENABLE, 0x00);
> +
> +	/* Clear the FIFO and disable FIFO mode */
> +	adxl345_flush_fifo(data->regmap);
> +	regmap_update_bits(data->regmap, ADXL345_REG_FIFO_CTL,
> +			   (int)~(ADXL345_FIFO_CTL_SAMPLES_MASK), 0x00);
> +
> +	/* re-enable measurement mode for direct reads */
> +	regmap_set_bits(data->regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_MEASURE);
> +	mutex_unlock(&data->lock);
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
> +	.preenable = adxl345_buffer_preenable,
> +	.postdisable = adxl345_buffer_postdisable,
> +};
> +
> +static irqreturn_t adxl345_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adxl345_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +	u8 buffer[ADXL345_SCAN_SIZE] __aligned(8);
Not necessary to align - that's only need if there is a timestmap.
However, given this driver supports spi and regmap doesn't make any
guarantees on whether dma safe buffers are needed, this should be
DMA safe.   Easiest option is to put an __aligned(IIO_DMA_MINALIGN) 
buffer at the end of your iio_priv structure.
I'll note that you probably won't ever see the result of not doing
this as I believe regmap happens to always copy the buffers today
but in earlier discussions we concluded that it was better to always
use it as if it didn't make those copies (as there are optimizatons
that would get rid of them.)  If you can find docs that say otherwise
then let me know!

I'll note there is already one bulk read in the driver that would suffer
from the same problem and should be fixed.

> +	int ret, data_available;
> +
> +	mutex_lock(&data->lock);
> +
> +	/* Disable the IRQ before reading the FIFO */

This needs a lot more explanation.  Disabling interrupts like
this can be very expensive and can be hard to reason about
+ it's not necessary most of the time because of IRQF_ONESHOT.

I'm not 100% sure there is a good reason for this driver to expose
at trigger - normally we only do that if it will support non fifo
buffered modes - even then if it's a fifo interrupt we often
switch to that mode explicitly by enabling the buffer _without_
a trigger set (to indicate that one doesn't make sense).

In that case this would be directly called from an interrupt thread
so it oneshot should protect it against additional IRQs until done
without the need for explicit handling.


> +	if (data->irq)
> +		disable_irq_nosync(data->irq);
> +
> +	ret = regmap_read(regmap, ADXL345_REG_INT_SOURCE, &data_available);
I'd rename this to reflect it contains a lot of other things int_source
seems sensible.

> +	if (ret < 0) {
> +		dev_err(indio_dev->dev.parent, "Could not read available data (%d)\n", ret);
> +		goto done;
> +	}
> +
> +	while (data_available & ADXL345_INT_DATA_READY) {

As for the flush above, read the FIFO_STATUS register to get an initial number of samples,
and read those without rechecking INT_SOURCE.  


> +		/* Read all axis data to make sure the IRQ flag is cleared. */
> +		ret = regmap_bulk_read(regmap, ADXL345_REG_DATA_AXIS(0),
> +				       &buffer, (sizeof(buffer)));
> +		if (ret < 0) {
> +			dev_err(indio_dev->dev.parent, "Could not read device FIFO (%d)\n", ret);
> +			goto done;
> +		}
> +		iio_push_to_buffers(indio_dev, buffer);
> +		ret = regmap_read(regmap, ADXL345_REG_INT_SOURCE, &data_available);
> +		if (ret < 0) {
> +			dev_err(indio_dev->dev.parent, "Could not push data to buffers (%d)\n",
> +				ret);
> +			goto done;
> +		}
> +	}
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	/* Re-enable the IRQ */
> +	if (data->irq)
> +		enable_irq(data->irq);
> +
> +	mutex_unlock(&data->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +int adxl345_core_probe(struct device *dev, struct regmap *regmap, int irq)
>  {
>  	struct adxl345_data *data;
>  	struct iio_dev *indio_dev;
> @@ -218,22 +500,29 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
>  
>  	data = iio_priv(indio_dev);
>  	data->regmap = regmap;
> -	/* Enable full-resolution mode */
> -	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
>  	data->info = device_get_match_data(dev);
>  	if (!data->info)
>  		return -ENODEV;
>  
> +	/* Enable full-resolution mode */
>  	ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
> -			   data->data_range);
> +			   ADXL345_DATA_FORMAT_FULL_RES);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to set data range\n");
>  
> +	/* Set the default sampling frequency */
> +	ret = adxl345_set_sampling_freq(data, ADXL345_DEFAULT_RATE);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to set sampling rate: %d\n", ret);

return dev_err_probe() This should not happen, if it does, why does it
make sense to continue>?

> +
> +	mutex_init(&data->lock);
> +
>  	indio_dev->name = data->info->name;
>  	indio_dev->info = &adxl345_info;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;

No need as INDIO_BUFFER_TRIGGERED is set when you register the buffer.

>  	indio_dev->channels = adxl345_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
> +	indio_dev->available_scan_masks = adxl345_available_scan_masks;
>  
>  	/* Enable measurement mode */
>  	ret = adxl345_powerup(data->regmap);
> @@ -244,7 +533,51 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
>  	if (ret < 0)
>  		return ret;
>  
> -	return devm_iio_device_register(dev, indio_dev);
> +	if (irq) {
> +		/* Setup the data ready trigger */
> +		ret = devm_request_threaded_irq(dev, irq, NULL, adxl345_irq_handler,
> +						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
Given the possibility of inverters in the interrupt line that aren't represented
explicitly in DT, we tend to leave interrupt polarity as something documented
in the bindings and set from them not in the driver.

We used to do this wrong so there is plenty of legacy we can't remove
because boards may be relying on it.

> +						indio_dev->name, indio_dev);
> +		if (ret < 0) {
> +			dev_err(dev, "request irq line failed.\n");
> +			return ret;
> +		}
> +		data->irq = irq;
> +
> +		data->drdy_trig = devm_iio_trigger_alloc(dev, "%s-drdy%d",
> +							 indio_dev->name, iio_device_id(indio_dev));

Line getting long.  Wrap it after name,
For IIO aim for sub 80 chars unless readability is much better with a 80-100 char line.


> +		if (!data->drdy_trig) {
> +			dev_err(dev, "Could not allocate drdy trigger\n");

dev_err_probe() preferred for all errors in probe.


> +			return -ENOMEM;
> +		}
> +		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
> +		ret = devm_iio_trigger_register(dev, data->drdy_trig);
> +		if (ret < 0) {
> +			dev_err(dev, "Could not register drdy trigger\n");
return dev_err_probe(dev, ret, "Could not...")
> +			return ret;
> +		}
> +		/* Set the new trigger as the current trigger for this device */
> +		indio_dev->trig = iio_trigger_get(data->drdy_trig);
> +	} else {
> +		dev_info(dev, "Not registering IIO trigger as no IRQ has been specified\n");

dev_dbg() or not all.  The absence of a trigger will make this obvious.

> +	}
> +
> +	/* Setup the triggered buffer */
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      NULL,
> +					      adxl345_trigger_handler,
> +					      &adxl345_buffer_ops);
> +	if (ret < 0) {
> +		dev_err(dev, "Error setting up the triggered buffer\n");

dev_err_probe()

> +		return ret;
> +	}
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		dev_err(dev, "Error registering IIO device: %d\n", ret);
> +	else
> +		dev_info(dev, "Registered IIO device\n");

dev_dbg at most.  There are many ways to find out if a device is registered
and the kernel boot log is far too noisy already!

> +	return ret;
>  }
>  EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);
>  
> diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
> index a3084b0a8f78..b90d58a7a73c 100644
> --- a/drivers/iio/accel/adxl345_i2c.c
> +++ b/drivers/iio/accel/adxl345_i2c.c
> @@ -27,7 +27,7 @@ static int adxl345_i2c_probe(struct i2c_client *client)
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
>  
> -	return adxl345_core_probe(&client->dev, regmap);
> +	return adxl345_core_probe(&client->dev, regmap, client->irq);
>  }
>  
>  static const struct adxl345_chip_info adxl345_i2c_info = {
> diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
> index 93ca349f1780..ea9a8438b540 100644
> --- a/drivers/iio/accel/adxl345_spi.c
> +++ b/drivers/iio/accel/adxl345_spi.c
> @@ -33,7 +33,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
>  
> -	return adxl345_core_probe(&spi->dev, regmap);
> +	return adxl345_core_probe(&spi->dev, regmap, spi->irq);

Device has two interrupt lines so you'll need to work out which one this is
(normally via interrupt-names in DT.  Binding needs fixing as well to reflect that.
We can document in there that for backwards compatibility that the default
is that that if one interrupt is provided with no interrupt names then it is
INT1.
 
Jonathan


>  }
>  
>  static const struct adxl345_chip_info adxl345_spi_info = {



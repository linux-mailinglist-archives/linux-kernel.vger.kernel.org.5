Return-Path: <linux-kernel+bounces-51717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F95A848E8E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A56B2833BB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA3F20309;
	Sun,  4 Feb 2024 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaSCi87U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A25225A9;
	Sun,  4 Feb 2024 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707057838; cv=none; b=V5/fokJEbZBLU8+35T0b0GSyIVTrXu7/D2tanGmQfnRD0nDuQHjLnEV5hmkeLu6FJj75/ai+GOtowxw29mDXOXsy6KZoDByTGBvG7UBCmmzKzUFcRZ8eMQGmd+2hJILTt3d4YFHC/ZHXJvJ+vAKLsFT19Q6ijqtGvrK28k30sUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707057838; c=relaxed/simple;
	bh=hKrCxzGzcSmp/RN6leX8vJUhL94x9Paiqyn5biZb9Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJyD28ZEsmViB65sU9NL6hvaV6mslQ+ztkRQFyG1eH6GgBhyF4v9n6UT5nDA8H4dZ2kz2E/VVKmxwvqBBdlYcxO/O9LQ+ak30tvDQtxYSMytB42x6cpidPQXFxVUElzMJAmV2WkeRXiG51iudNyMS/eIqzMBvpo1zwFH/ZiumpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaSCi87U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2858C433F1;
	Sun,  4 Feb 2024 14:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707057838;
	bh=hKrCxzGzcSmp/RN6leX8vJUhL94x9Paiqyn5biZb9Wg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WaSCi87UGa/3ai/aJVq6uLyqu0uxtqg/hT4xzVjxksfYWVWsfOpseTU9SdrXlze0u
	 fC8TlXSMExUjv3XoFiC/sxbsTAEqG30AYvUTE0YoQf+9n7B1m7RN/oyM+x6byJihZ+
	 kmYJvvRnliANoIlH7BWgW1ZCcj1IPvGhdqXhRArUv58zhv+3ykAHGLE3miI/LbX4qT
	 dm6u4xpKk+2p/57lB1OBJUPQAg1oNll8qtcYaLcJQXOTxzr/B32y8/2a4tm0NU2RZz
	 OQ782LD90ki10f52D+mpIsd2QSG42jjg5y6K6AJQc5tb5duZJoL+bMzuiDRg+zUemg
	 lF77ZT0Rh3jtA==
Date: Sun, 4 Feb 2024 14:43:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Li peiyu
 <579lpy@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: humidity: hdc3020: add threshold events support
Message-ID: <20240204144347.7f0eb822@jic23-huawei>
In-Reply-To: <20240204103710.19212-1-dima.fedrau@gmail.com>
References: <20240204103710.19212-1-dima.fedrau@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun,  4 Feb 2024 11:37:10 +0100
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> Add threshold events support for temperature and relative humidity. To
> enable them the higher and lower threshold registers must be programmed
> and the higher threshold must be greater then or equal to the lower
> threshold. Otherwise the event is disabled. Invalid hysteresis values
> are ignored by the device. There is no further configuration possible.
>=20
> Tested by setting thresholds/hysteresis and turning the heater on/off.
> Used iio_event_monitor in tools/iio to catch events while constantly
> displaying temperature and humidity values.
> Threshold and hysteresis values are cached in the driver, used i2c-tools
> to read the threshold and hysteresis values from the device and make
> sure cached values are consistent to values written to the device.
>=20
> Based on Fix:
> a69eeaad093d "iio: humidity: hdc3020: fix temperature offset" in branch
> fixes-togreg
Move this below the ---
as we don't want to keep that info in the log long term.

It's good to have it for now though as helps me know when I can apply the p=
atch.

>=20
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
> Changes in V2:
>   - Fix alphabetical order of includes(Christophe)
>   - Fix typo: change varibale name "HDC3020_R_R_RH_THRESH_LOW_CLR" to
>     HDC3020_R_T_RH_THRESH_LOW_CLR to match variable name pattern
>     (Christophe)
>   - Add constants HDC3020_MIN_TEMP and HDC3020_MAX_TEMP for min/max
>     threshold inputs (Christophe)
>   - Change HDC3020_MIN_TEMP to -40, as stated in the datasheet(Javier)
>   - Fix shadowing of global variable "hdc3020_id" in probe function,
>     rename variable in probe function to "dev_id"(Javier)
> ---
>  drivers/iio/humidity/hdc3020.c | 342 +++++++++++++++++++++++++++++++++
>  1 file changed, 342 insertions(+)
>=20
> diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc302=
0.c
> index ed70415512f6..80cfb343c92d 100644
> --- a/drivers/iio/humidity/hdc3020.c
> +++ b/drivers/iio/humidity/hdc3020.c
> @@ -14,11 +14,13 @@
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> =20
>  #include <asm/unaligned.h>
> =20
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
> =20
>  #define HDC3020_HEATER_CMD_MSB		0x30 /* shared by all heater commands */
> @@ -26,21 +28,47 @@
>  #define HDC3020_HEATER_DISABLE		0x66
>  #define HDC3020_HEATER_CONFIG		0x6E
> =20
> +#define HDC3020_THRESH_TEMP_MASK	GENMASK(8, 0)
> +#define HDC3020_THRESH_TEMP_SHIFT	7

This is odd.  Normally a mask and shift pair like this is about
a register field.  Here that's not true.  So don't use the common
naming and instead use something like TRUNCATED_BITS.
Define that for both fields, then use
FIELD_PREP() to set them, even though that will meant shifting
the humidity values down and up again by the same amount.



> +#define HDC3020_THRESH_HUM_MASK		GENMASK(15, 9)
> +
> +#define HDC3020_STATUS_T_LOW_ALERT	BIT(6)
> +#define HDC3020_STATUS_T_HIGH_ALERT	BIT(7)
> +#define HDC3020_STATUS_RH_LOW_ALERT	BIT(8)
> +#define HDC3020_STATUS_RH_HIGH_ALERT	BIT(9)
> +
>  #define HDC3020_READ_RETRY_TIMES	10
>  #define HDC3020_BUSY_DELAY_MS		10
> =20
>  #define HDC3020_CRC8_POLYNOMIAL		0x31
> =20
> +#define HDC3020_MIN_TEMP		-40
> +#define HDC3020_MAX_TEMP		125
> +
>  static const u8 HDC3020_S_AUTO_10HZ_MOD0[2] =3D { 0x27, 0x37 };
> =20
> +static const u8 HDC3020_S_STATUS[2] =3D { 0x30, 0x41 };
> +
>  static const u8 HDC3020_EXIT_AUTO[2] =3D { 0x30, 0x93 };
> =20
> +static const u8 HDC3020_S_T_RH_THRESH_LOW[2] =3D { 0x61, 0x00 };

Ah. missed this in original driver, but this use of capitals for
non #defines is really confusing and we should aim to clean that
up.

As I mention below, I'm unconvinced that it makes sense to handle
these as pairs.


> +static const u8 HDC3020_S_T_RH_THRESH_LOW_CLR[2] =3D { 0x61, 0x0B };
> +static const u8 HDC3020_S_T_RH_THRESH_HIGH_CLR[2] =3D { 0x61, 0x16 };
> +static const u8 HDC3020_S_T_RH_THRESH_HIGH[2] =3D { 0x61, 0x1D };
> +
>  static const u8 HDC3020_R_T_RH_AUTO[2] =3D { 0xE0, 0x00 };
>  static const u8 HDC3020_R_T_LOW_AUTO[2] =3D { 0xE0, 0x02 };
>  static const u8 HDC3020_R_T_HIGH_AUTO[2] =3D { 0xE0, 0x03 };
>  static const u8 HDC3020_R_RH_LOW_AUTO[2] =3D { 0xE0, 0x04 };
>  static const u8 HDC3020_R_RH_HIGH_AUTO[2] =3D { 0xE0, 0x05 };
> =20
> +static const u8 HDC3020_R_T_RH_THRESH_LOW[2] =3D { 0xE1, 0x02 };
> +static const u8 HDC3020_R_T_RH_THRESH_LOW_CLR[2] =3D { 0xE1, 0x09 };
> +static const u8 HDC3020_R_T_RH_THRESH_HIGH_CLR[2] =3D { 0xE1, 0x14 };
> +static const u8 HDC3020_R_T_RH_THRESH_HIGH[2] =3D { 0xE1, 0x1F };
> +
> +static const u8 HDC3020_R_STATUS[2] =3D { 0xF3, 0x2D };
> +
>  struct hdc3020_data {
>  	struct i2c_client *client;
>  	/*
> @@ -50,22 +78,54 @@ struct hdc3020_data {
>  	 * if the device does not respond).
>  	 */
>  	struct mutex lock;
> +	/*
> +	 * Temperature and humidity thresholds are packed together into a single
> +	 * 16 bit value. Each threshold is represented by a truncated 16 bit
> +	 * value. The 7 MSBs of a relative humidity threshold are concatenated
> +	 * with the 9 MSBs of a temperature threshold, where the temperature
> +	 * threshold resides in the 7 LSBs. Due to the truncated representation,
> +	 * there is a resolution loss of 0.5 degree celsius in temperature and a
> +	 * 1% resolution loss in relative humidity.
> +	 */
> +	u16 t_rh_thresh_low;
> +	u16 t_rh_thresh_high;
> +	u16 t_rh_thresh_low_clr;
> +	u16 t_rh_thresh_high_clr;
>  };
> =20
>  static const int hdc3020_heater_vals[] =3D {0, 1, 0x3FFF};
> =20
> +static const struct iio_event_spec hdc3020_t_rh_event[] =3D {
> +	{
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_RISING,
> +		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
> +		BIT(IIO_EV_INFO_HYSTERESIS),
> +	},
> +	{
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_FALLING,
> +		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
> +		BIT(IIO_EV_INFO_HYSTERESIS),
> +	},
> +};
> +
>  static const struct iio_chan_spec hdc3020_channels[] =3D {
>  	{
>  		.type =3D IIO_TEMP,
>  		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
>  		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_PEAK) |
>  		BIT(IIO_CHAN_INFO_TROUGH) | BIT(IIO_CHAN_INFO_OFFSET),
> +		.event_spec =3D hdc3020_t_rh_event,
> +		.num_event_specs =3D ARRAY_SIZE(hdc3020_t_rh_event),
>  	},
>  	{
>  		.type =3D IIO_HUMIDITYRELATIVE,
>  		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
>  		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_PEAK) |
>  		BIT(IIO_CHAN_INFO_TROUGH),
> +		.event_spec =3D hdc3020_t_rh_event,
> +		.num_event_specs =3D ARRAY_SIZE(hdc3020_t_rh_event),
>  	},
>  	{
>  		/*
> @@ -389,10 +449,241 @@ static int hdc3020_write_raw(struct iio_dev *indio=
_dev,
>  	return -EINVAL;
>  }
> =20
> +static int hdc3020_write_thresh(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int val, int val2)
> +{
> +	struct hdc3020_data *data =3D iio_priv(indio_dev);
> +	u16 *thresh;
> +	u8 buf[5];
> +	int ret;
> +
> +	/* Supported temperature range is from =E2=80=9340 to 125 degree celsiu=
s */
> +	if (val < HDC3020_MIN_TEMP || val > HDC3020_MAX_TEMP)
> +		return -EINVAL;
> +
> +	/* Select threshold and associated register */
> +	if (info =3D=3D IIO_EV_INFO_VALUE) {
> +		if (dir =3D=3D IIO_EV_DIR_RISING) {
> +			thresh =3D &data->t_rh_thresh_high;
> +			memcpy(buf, HDC3020_S_T_RH_THRESH_HIGH, 2);
> +		} else {
> +			thresh =3D &data->t_rh_thresh_low;
> +			memcpy(buf, HDC3020_S_T_RH_THRESH_LOW, 2);
First value of buf is always 0x61 - so just set that above
u8 buf[5] =3D { 0x61, };
and here just write buf[1] with appropriate value.

> +		}
> +	} else {
> +		if (dir =3D=3D IIO_EV_DIR_RISING) {
> +			thresh =3D &data->t_rh_thresh_high_clr;
> +			memcpy(buf, HDC3020_S_T_RH_THRESH_HIGH_CLR, 2);
> +		} else {
> +			thresh =3D &data->t_rh_thresh_low_clr;
> +			memcpy(buf, HDC3020_S_T_RH_THRESH_LOW_CLR, 2);
> +		}
> +	}
> +
> +	guard(mutex)(&data->lock);
> +	switch (chan->type) {
> +	case IIO_TEMP:
> +		/*
> +		 * Store truncated temperature threshold into 9 LSBs while
> +		 * keeping the old humidity threshold in the 7 MSBs.
> +		 */
> +		val =3D (((val + 45) * 65535 / 175) >> HDC3020_THRESH_TEMP_SHIFT);

This almost looks like FIELD_PREP() but is really a division then a store?
Perhaps rename TEMP_SHIFT TEMP_TRUNCATED_BITS or something like that to avo=
id
the currently confusing naming.

> +		val &=3D HDC3020_THRESH_TEMP_MASK;
> +		val |=3D (*thresh & HDC3020_THRESH_HUM_MASK);
> +		break;
> +	case IIO_HUMIDITYRELATIVE:
> +		/*
> +		 * Store truncated humidity threshold into 7 MSBs while
> +		 * keeping the old temperature threshold in the 9 LSBs.
> +		 */
> +		val =3D ((val * 65535 / 100) & HDC3020_THRESH_HUM_MASK);
> +		val |=3D (*thresh & HDC3020_THRESH_TEMP_MASK);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	put_unaligned_be16(val, &buf[2]);
> +	buf[4] =3D crc8(hdc3020_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
> +	ret =3D hdc3020_write_bytes(data, buf, 5);
> +	if (ret)
> +		return ret;
> +
> +	/* Update threshold */
> +	*thresh =3D val;
> +
> +	return 0;
> +}
> +
> +static int _hdc3020_read_thresh(struct hdc3020_data *data,

Relationship of this function to the following one not clear from
naming.  Rename it to make the two different cases easier to follow.
Mind you, threshold checking isn't usually a fast path - so
it's unusual to cache the thresholds in the driver explicitly
(as opposed to getting them cached for free via regmap which doesn't
add driver complexity).


> +				enum iio_event_info info,
> +				enum iio_event_direction dir, u16 *thresh)
> +{
> +	u8 crc, buf[3];
> +	const u8 *cmd;
> +	int ret;
> +
> +	if (info =3D=3D IIO_EV_INFO_VALUE) {
> +		if (dir =3D=3D IIO_EV_DIR_RISING)

As you only use these in the initial readback, maybe just pass the
cmd directly into each call.  No need to use general interfaces.

> +			cmd =3D HDC3020_R_T_RH_THRESH_HIGH;
> +		else
> +			cmd =3D HDC3020_R_T_RH_THRESH_LOW;
> +	} else {
> +		if (dir =3D=3D IIO_EV_DIR_RISING)
> +			cmd =3D HDC3020_R_T_RH_THRESH_HIGH_CLR;
> +		else
> +			cmd =3D HDC3020_R_T_RH_THRESH_LOW_CLR;
> +	}
> +
> +	ret =3D hdc3020_read_bytes(data, cmd, buf, 3);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* CRC check of the threshold */
> +	crc =3D crc8(hdc3020_crc8_table, buf, 2, CRC8_INIT_VALUE);
> +	if (crc !=3D buf[2])
> +		return -EINVAL;

> +
> +	*thresh =3D get_unaligned_be16(buf);

This 3 byte read, crc check and be16 extraction is common in this diver
maybe - just add a helper function for this rather than adding
yet another copy of the same code?

int hdc3020_read_be16_reg(struct iio_dev *indio_dev, u8 cmd)
{...

	return get_unaligned_be16(buf);

> +
> +	return 0;
> +}
> +
> +static int hdc3020_read_thresh(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info,
> +			       int *val, int *val2)
> +{
> +	struct hdc3020_data *data =3D iio_priv(indio_dev);
> +	u16 *thresh;
> +
> +	/* Select threshold */
> +	if (info =3D=3D IIO_EV_INFO_VALUE) {
> +		if (dir =3D=3D IIO_EV_DIR_RISING)
> +			thresh =3D &data->t_rh_thresh_high;
> +		else
> +			thresh =3D &data->t_rh_thresh_low;
> +	} else {
> +		if (dir =3D=3D IIO_EV_DIR_RISING)
> +			thresh =3D &data->t_rh_thresh_high_clr;
> +		else
> +			thresh =3D &data->t_rh_thresh_low_clr;
> +	}
> +
> +	guard(mutex)(&data->lock);

Why take the lock here?

you are relying on a single value that is already cached.


> +	switch (chan->type) {
> +	case IIO_TEMP:
> +		/* Get the truncated temperature threshold from 9 LSBs,
> +		 * shift them and calculate the threshold according to the
> +		 * formula in the datasheet.
> +		 */
> +		*val =3D ((*thresh) & HDC3020_THRESH_TEMP_MASK) <<
> +			HDC3020_THRESH_TEMP_SHIFT;
> +		*val =3D -2949075 + (175 * (*val));
> +		*val2 =3D 65535;
> +		break;
		return here.  Gives easier to review code as no need for
a reader to check if anything else happens in this path.

> +	case IIO_HUMIDITYRELATIVE:
> +		/* Get the truncated humidity threshold from 7 MSBs, and
> +		 * calculate the threshold according to the formula in the
> +		 * datasheet.
> +		 */
> +		*val =3D 100 * ((*thresh) & HDC3020_THRESH_HUM_MASK);
> +		*val2 =3D 65535;
> +		break;
return here
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return IIO_VAL_FRACTIONAL;
Drop this as will have returned above.
> +}

> +
> +static irqreturn_t hdc3020_interrupt_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev =3D private;
> +	struct hdc3020_data *data;
> +	u16 stat;
> +	int ret;
> +
> +	data =3D iio_priv(indio_dev);
> +	ret =3D hdc3020_read_status(data, &stat);
> +	if (ret)
> +		return IRQ_NONE;
Hmm. In cases where we get a read back failure on an interrupt it is always
messy to decide if it's spurious or not.  If this actually happens you may
find you want to return IRQ_HANDLED; even though it wasn't.
> +
> +	if (!(stat & (HDC3020_STATUS_T_HIGH_ALERT | HDC3020_STATUS_T_LOW_ALERT |
> +		HDC3020_STATUS_RH_HIGH_ALERT | HDC3020_STATUS_RH_LOW_ALERT)))
> +		return IRQ_NONE;

This one is fine as you know it is spurious.

> +
> +	if (stat & HDC3020_STATUS_T_HIGH_ALERT)
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
> +						  IIO_NO_MOD,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_RISING),
> +						  iio_get_time_ns(indio_dev));
If you happen to get more than one, you probably want the timestamp to matc=
h.
I'd take the timestamp first into a local variable then use it in each of t=
hese.

> +
> +	if (stat & HDC3020_STATUS_T_LOW_ALERT)
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
> +						  IIO_NO_MOD,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_FALLING),
> +						  iio_get_time_ns(indio_dev));
> +
> +	if (stat & HDC3020_STATUS_RH_HIGH_ALERT)
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_HUMIDITYRELATIVE, 0,
> +						  IIO_NO_MOD,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_RISING),
> +						  iio_get_time_ns(indio_dev));
> +
> +	if (stat & HDC3020_STATUS_RH_LOW_ALERT)
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_HUMIDITYRELATIVE, 0,
> +						  IIO_NO_MOD,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_FALLING),
> +						  iio_get_time_ns(indio_dev));
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static const struct iio_info hdc3020_info =3D {
>  	.read_raw =3D hdc3020_read_raw,
>  	.write_raw =3D hdc3020_write_raw,
>  	.read_avail =3D hdc3020_read_available,
> +	.read_event_value =3D hdc3020_read_thresh,
> +	.write_event_value =3D hdc3020_write_thresh,
>  };
> =20
>  static void hdc3020_stop(void *data)
> @@ -402,6 +693,7 @@ static void hdc3020_stop(void *data)
> =20
>  static int hdc3020_probe(struct i2c_client *client)
>  {
> +	const struct i2c_device_id *dev_id;
>  	struct iio_dev *indio_dev;
>  	struct hdc3020_data *data;
>  	int ret;
> @@ -413,6 +705,8 @@ static int hdc3020_probe(struct i2c_client *client)
>  	if (!indio_dev)
>  		return -ENOMEM;
> =20
> +	dev_id =3D i2c_client_get_device_id(client);
> +
>  	data =3D iio_priv(indio_dev);
>  	data->client =3D client;
>  	mutex_init(&data->lock);
> @@ -425,6 +719,54 @@ static int hdc3020_probe(struct i2c_client *client)
>  	indio_dev->channels =3D hdc3020_channels;
>  	indio_dev->num_channels =3D ARRAY_SIZE(hdc3020_channels);
> =20
> +	/* Read out upper and lower thresholds and hysteresis, which can be the

As below - comment syntax wrong for IIO drivers (only net and a few other
corners of the kernel prefer this one for historical reasons).

> +	 * default values or values programmed into non-volatile memory.
> +	 */
> +	ret =3D _hdc3020_read_thresh(data, IIO_EV_INFO_VALUE, IIO_EV_DIR_FALLIN=
G,
> +				   &data->t_rh_thresh_low);
As above, it feels to me like you can just use the registers directly into
a be16 readback function.

	ret =3D hdc3020_read_be16_reg(indio_dev, HDC3020_R_T_RH_THRESH_LOW)
	if (ret < 0)
		return ...

	data->t_rh_thresh_low =3D ret;
etc

> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Unable to get low thresholds\n");
> +
> +	ret =3D _hdc3020_read_thresh(data, IIO_EV_INFO_VALUE, IIO_EV_DIR_RISING,
> +				   &data->t_rh_thresh_high);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Unable to get high thresholds\n");
> +
> +	ret =3D _hdc3020_read_thresh(data, IIO_EV_INFO_HYSTERESIS,
> +				   IIO_EV_DIR_FALLING,
> +				   &data->t_rh_thresh_low_clr);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Unable to get low hysteresis\n");
> +
> +	ret =3D _hdc3020_read_thresh(data, IIO_EV_INFO_HYSTERESIS,
> +				   IIO_EV_DIR_RISING,
> +				   &data->t_rh_thresh_high_clr);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Unable to get high hysteresis\n");
> +
> +	if (client->irq) {
Comment syntax in IIO (and most of the kernel) is
		/*
		 * The alert....

> +		/* The alert output is activated by default upon power up, hardware
> +		 * reset, and soft reset. Clear the status register before enabling
> +		 * the interrupt.
That's a bit nasty. Ah well.  Ordering not critical though as you are regis=
tering
a rising trigger.  However...
> +		 */
> +		ret =3D hdc3020_clear_status(data);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
> +						NULL, hdc3020_interrupt_handler,
> +						IRQF_TRIGGER_RISING |

These days (we got this wrong a lot in the past) we tend to leave the inter=
rupt
polarity to the firmware to configure (DT or similar) as people have an ann=
oying
habit of using not gates in interrupt wiring.   So Just pass IRQF_ONESHOT b=
ut
make sure the DT binding example sets this right.

> +						IRQF_ONESHOT,
> +						dev_id->name, indio_dev);

dev_id->name is annoyingly unstable depending on the probe path and whether
the various firmware match tables align perfectly with the i2c_device_id
table. I'd just use a fixed value here for the driver in question and
not worry about it too much.  hdc3020 is fine.  If you really care about
it add a device specific structure and put a string for the name in there.
That can then be referenced from all the firmware tables (safely) and
i2c_get_match_data() used to get it from which ever one is available.

> +		if (ret)
> +			return dev_err_probe(&client->dev, ret,
> +					     "Failed to request IRQ\n");
> +	}
> +
>  	ret =3D hdc3020_write_bytes(data, HDC3020_S_AUTO_10HZ_MOD0, 2);
>  	if (ret)
>  		return dev_err_probe(&client->dev, ret,



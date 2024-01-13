Return-Path: <linux-kernel+bounces-25326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 298F682CD92
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C800B224FD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536B8257A;
	Sat, 13 Jan 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg53TLV7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837721C20;
	Sat, 13 Jan 2024 15:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30D2C433F1;
	Sat, 13 Jan 2024 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705160710;
	bh=IuecItSeyezhNWASH/hdrohslX++dQOtS+98Cl5wjoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eg53TLV7cO6CanwV5tcGiZQOsMNwHHMMaBEks7JIrOpib2h0U7rydhRUKqOUUdrCb
	 nfrhVF/bFTd6x7uSJyqxanyaEVLs0RsucZ3k2EBzhDT2sBqSqniQHsjIIl0ySb7qyD
	 o3lxJvQRLaFkkjXWHNAE0M9uPTXb2MDVOkovPu7YO+h9hmey1SpFa2eKwyXidk45Pj
	 OG8wuSCcxycGAxC4JI2F4mczTLbr3n9Pfp6jNDbQpUCUNzLZ3c9EkW7qKun1G9vP2F
	 PhErfJcXzbwM15zAtSormTlMGX49Z29ytOtFyyxvPWWFN4Piiu4KACLQgzkGr9ltX6
	 /MP4D5sIeNrXQ==
Date: Sat, 13 Jan 2024 15:45:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ceclan Dumitru
 <dumitru.ceclan@analog.com>
Subject: Re: [PATCH v2 4/4] iio: amplifiers: hmc425a: add support for
 LTC6373 Instrumentation Amplifier
Message-ID: <20240113154503.7f9c0ef6@jic23-huawei>
In-Reply-To: <20240110153757.5754-5-mitrutzceclan@gmail.com>
References: <20240110153757.5754-1-mitrutzceclan@gmail.com>
	<20240110153757.5754-5-mitrutzceclan@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 17:37:12 +0200
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> This adds support for LTC6373 36 V Fully-Differential Programmable-Gain
> Instrumentation Amplifier with 25 pA Input Bias Current.
> The user can program the gain to one of seven available settings through
> a 3-bit parallel interface (A2 to A0).
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
Some formatting comments inline.

Ideally I'd like this driver to move to not using device ids in the match
table but instead use pointers to the chip_info structures + all the
remaining chip specific stuff being moved into those.
Given that's a non trivial change I'm not insisting on it for this series
but might get grumpy if you add more devices to this driver without tidying
that up.  It always ends up being easier to extend in the long run!

Jonathan


> ---
>  drivers/iio/amplifiers/hmc425a.c | 104 ++++++++++++++++++++++++++++++-
>  1 file changed, 102 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
> index b5fd19403d15..2048bf9e0343 100644
> --- a/drivers/iio/amplifiers/hmc425a.c
> +++ b/drivers/iio/amplifiers/hmc425a.c
> @@ -2,9 +2,10 @@
>  /*
>   * HMC425A and similar Gain Amplifiers
>   *
> - * Copyright 2020 Analog Devices Inc.
> + * Copyright 2020, 2023 Analog Devices Inc.
>   */
>  
> +#include <linux/bits.h>
>  #include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> @@ -20,10 +21,24 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/sysfs.h>
>  
> +/*
> + * The LTC6373 amplifier supports configuring gain using GPIO's with the following
> + *  values (OUTPUT_V / INPUT_V): 0(shutdown), 0.25, 0.5, 1, 2, 4, 8, 16
> + *
> + * Except for the shutdown value, all can be converted to dB using 20 * log10(x)
> + * From here, it is observed that all values are multiples of the '2' gain setting,
> + *  with the correspondent of 6.020dB.
> + */
> +#define LTC6373_CONVERSION_CONSTANT	6020
> +#define LTC6373_MIN_GAIN_CODE		0x6
> +#define LTC6373_CONVERSION_MASK		GENMASK(2, 0)
> +#define LTC6373_SHUTDOWN		GENMASK(2, 0)
> +
>  enum hmc425a_type {
>  	ID_HMC425A,
>  	ID_HMC540S,
> -	ID_ADRF5740
> +	ID_ADRF5740,
> +	ID_LTC6373,
>  };
>  
>  struct hmc425a_chip_info {
> @@ -42,6 +57,7 @@ struct hmc425a_state {
>  	struct	gpio_descs *gpios;
>  	enum	hmc425a_type type;
>  	u32	gain;
> +	bool	powerdown;
>  };
>  
>  static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
> @@ -80,6 +96,17 @@ static int hmc425a_gain_dB_to_code(struct hmc425a_state *st, int val, int val2,
>  		temp = (abs(gain) / 2000) & 0xF;
>  		*code = temp & BIT(3) ? temp | BIT(2) : temp;
>  		break;
> +	case ID_LTC6373:
> +		if (st->powerdown)
> +			return -EPERM;
> +
> +		/* add half of the value for rounding */
> +		temp = LTC6373_CONVERSION_CONSTANT / 2;
> +		if (val < 0)
> +			temp *= -1;
> +		*code = ~((gain + temp) / LTC6373_CONVERSION_CONSTANT + 3)
> +			& LTC6373_CONVERSION_MASK;
> +		break;
>  	}
>  	return 0;

Didn't notice this in previous patch but direct returns instead of breaks in the switch case
statements would simplify this function a little.


>  }
> @@ -100,6 +127,12 @@ static int hmc425a_code_to_gain_dB(struct hmc425a_state *st, int *val, int *val2
>  		code = code & BIT(3) ? code & ~BIT(2) : code;
>  		gain = code * -2000;
>  		break;
> +	case ID_LTC6373:
> +		if (st->powerdown)
> +			return -EPERM;
> +		gain = ((~code & LTC6373_CONVERSION_MASK) - 3) *
> +		       LTC6373_CONVERSION_CONSTANT;
> +		break;
>  	}
>  
>  	*val = gain / 1000;
> @@ -172,6 +205,44 @@ static const struct iio_info hmc425a_info = {
>  	.write_raw_get_fmt = &hmc425a_write_raw_get_fmt,
>  };
>  
> +static ssize_t ltc6373_read_powerdown(struct iio_dev *indio_dev,
> +	uintptr_t private, const struct iio_chan_spec *chan, char *buf)

The existing code looks to stick to kernel style conventions with respect
to aligning parameters just after the (

Please do that for new functions as well.


> +{
> +	struct hmc425a_state *st = iio_priv(indio_dev);
> +
> +	return sysfs_emit(buf, "%d\n", st->powerdown);
> +}
> +
> +static ssize_t ltc6373_write_powerdown(struct iio_dev *indio_dev,
> +	 uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
> +	 size_t len)
> +{
> +	struct hmc425a_state *st = iio_priv(indio_dev);
> +	bool powerdown;
> +	int code, ret;
> +
> +	ret = kstrtobool(buf, &powerdown);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&st->lock);
> +	st->powerdown = powerdown;
> +	code = (powerdown) ? LTC6373_SHUTDOWN : st->gain;
> +	ret = hmc425a_write(indio_dev, code);
> +	mutex_unlock(&st->lock);
> +	return len;
> +}
> +
> +static const struct iio_chan_spec_ext_info ltc6373_ext_info[] = {
> +	{
> +		.name = "powerdown",
> +		.read = ltc6373_read_powerdown,
> +		.write = ltc6373_write_powerdown,
> +		.shared = IIO_SEPARATE,
> +	},
> +	{},
> +};
> +
>  #define HMC425A_CHAN(_channel)						\
>  {									\
>  	.type = IIO_VOLTAGE,						\
> @@ -181,15 +252,30 @@ static const struct iio_info hmc425a_info = {
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
>  }
>  
> +#define LTC6373_CHAN(_channel)						\
> +{									\
> +	.type = IIO_VOLTAGE,						\
> +	.output = 1,							\
> +	.indexed = 1,							\
> +	.channel = _channel,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
> +	.ext_info = ltc6373_ext_info,					\
> +}
> +
>  static const struct iio_chan_spec hmc425a_channels[] = {
>  	HMC425A_CHAN(0),
>  };
>  
> +static const struct iio_chan_spec ltc6373_channels[] = {
> +	LTC6373_CHAN(0),
> +};
> +
>  /* Match table for of_platform binding */
>  static const struct of_device_id hmc425a_of_match[] = {
>  	{ .compatible = "adi,hmc425a", .data = (void *)ID_HMC425A },
>  	{ .compatible = "adi,hmc540s", .data = (void *)ID_HMC540S },
>  	{ .compatible = "adi,adrf5740", .data = (void *)ID_ADRF5740 },
> +	{ .compatible = "adi,ltc6373", .data = (void *)ID_LTC6373 },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, hmc425a_of_match);
> @@ -222,6 +308,15 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
>  		.gain_max = 0,
>  		.default_gain = 0xF, /* set default gain -22.0db*/
>  	},
> +	[ID_LTC6373] = {
> +		.name = "ltc6373",
> +		.channels = ltc6373_channels,
> +		.num_channels = ARRAY_SIZE(ltc6373_channels),
> +		.num_gpios = 3,
> +		.gain_min = -12041, /* gain setting x0.25*/
> +		.gain_max = 24082,  /* gain setting x16  */
> +		.default_gain = LTC6373_SHUTDOWN,
> +	},
>  };
>  
>  static int hmc425a_probe(struct platform_device *pdev)
> @@ -266,6 +361,11 @@ static int hmc425a_probe(struct platform_device *pdev)
>  	/* Set default gain */
>  	hmc425a_write(indio_dev, st->gain);
>  
> +	if (st->type == ID_LTC6373) {
> +		st->powerdown = true;
> +		st->gain = LTC6373_MIN_GAIN_CODE;

Better to put this lot in chip info so all the device specific
settings are in one place.

> +	}
> +
>  	return devm_iio_device_register(&pdev->dev, indio_dev);
>  }
>  



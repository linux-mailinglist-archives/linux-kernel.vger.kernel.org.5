Return-Path: <linux-kernel+bounces-8841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6780981BCFA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD091C244AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A808A62813;
	Thu, 21 Dec 2023 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvR/kOHA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53F159908;
	Thu, 21 Dec 2023 17:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE08C433C8;
	Thu, 21 Dec 2023 17:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703179240;
	bh=NQK3RBAPAfpqBEjUUEqoDrpg5TUjACITSjDO7hq1ug8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RvR/kOHAtBZFRTdLS+iKYs0Vp73zHNL53SVNvTNoUvl5nhthcVkeUnDHQGcMBYXgN
	 6WnPKE9Q4I3f7vD5Xsuy/bIe//KTt0cCcJfwNVZ34ox5PW3/LMhZzkNoNcl7Nqwnph
	 1vYYds2kVTW84WuvPdEIb5JbHNCAKxiz7qdHbSqt+Lt/S42MX6WfU75AEV481WOJP4
	 T5svhxukUcCIuX8cOYSyO/nIv6TNupxGMRMvO/5Hwgzz+1xudHxSsY0toUg10MiA+i
	 niKrgpjZ5MQFmLy7eXQah7ZVlmPC+Y5Q9UXSnDNQnoGzucm7725qNgeHwRXkNkIsIH
	 kUinzaQcWKckg==
Date: Thu, 21 Dec 2023 17:20:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ceclan Dumitru
 <dumitru.ceclan@analog.com>
Subject: Re: [PATCH 3/3] iio: amplifiers: hmc425a: add support for LTC6373
 Instrumentation Amplifier
Message-ID: <20231221172025.40465cf5@jic23-huawei>
In-Reply-To: <20231221113842.25957-4-mitrutzceclan@gmail.com>
References: <20231221113842.25957-1-mitrutzceclan@gmail.com>
	<20231221113842.25957-4-mitrutzceclan@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 13:38:40 +0200
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> This adds support for LTC6373 36 V Fully-Differential Programmable-Gain
> Instrumentation Amplifier with 25 pA Input Bias Current.
> The user can program the gain to one of seven available settings through
> a 3-bit parallel interface (A2 to A0).
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
One trivial comment inline.

The use of IIO_INFO_ENABLE is unusual. So far the only documented uses of
that are

What:		/sys/.../iio:deviceX/in_energy_en
What:		/sys/.../iio:deviceX/in_distance_en
What:		/sys/.../iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_en
What:		/sys/.../iio:deviceX/in_steps_en
KernelVersion:	3.19
Contact:	linux-iio@vger.kernel.org
Description:
		Activates a device feature that runs in firmware/hardware.
		E.g. for steps: the pedometer saves power while not used;
		when activated, it will count the steps taken by the user in
		firmware and export them through in_steps_input.

And this doesn't match up with these sort of 'counting' or 'cumulative' measures.

I wonder treating it like a DAC output and instead using _powerdown
instead?

 ---
>  drivers/iio/amplifiers/hmc425a.c | 78 +++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
> index b5fd19403d15..27fdc32a0457 100644
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
> @@ -20,10 +21,23 @@
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
> @@ -42,6 +56,8 @@ struct hmc425a_state {
>  	struct	gpio_descs *gpios;
>  	enum	hmc425a_type type;
>  	u32	gain;
> +	bool	enabled;
> +
>  };
>  
>  static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
> @@ -80,6 +96,17 @@ static int hmc425a_gain_dB_to_code(struct hmc425a_state *st, int val, int val2,
>  		temp = (abs(gain) / 2000) & 0xF;
>  		*code = temp & BIT(3) ? temp | BIT(2) : temp;
>  		break;
> +	case ID_LTC6373:
> +		if (!st->enabled)
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
>  }
> @@ -100,6 +127,12 @@ static int hmc425a_code_to_gain_dB(struct hmc425a_state *st, int *val, int *val2
>  		code = code & BIT(3) ? code & ~BIT(2) : code;
>  		gain = code * -2000;
>  		break;
> +	case ID_LTC6373:
> +		if (!st->enabled)
> +			return -EPERM;
> +		gain = ((~code & LTC6373_CONVERSION_MASK) - 3) *
> +		       LTC6373_CONVERSION_CONSTANT;
> +		break;
>  	}
>  
>  	*val = gain / 1000;
> @@ -122,6 +155,10 @@ static int hmc425a_read_raw(struct iio_dev *indio_dev,
>  			break;
>  		ret = IIO_VAL_INT_PLUS_MICRO_DB;
>  		break;
> +	case IIO_CHAN_INFO_ENABLE:
> +		*val = st->enabled;
> +		ret = IIO_VAL_INT;
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -146,6 +183,17 @@ static int hmc425a_write_raw(struct iio_dev *indio_dev,
>  		st->gain = code;
>  		ret = hmc425a_write(indio_dev, st->gain);
>  		break;
> +	case IIO_CHAN_INFO_ENABLE:
> +		switch (st->type) {
> +		case ID_LTC6373:
> +			code = (val) ? st->gain : LTC6373_SHUTDOWN;
> +			st->enabled = val;
> +			ret = hmc425a_write(indio_dev, code);
> +			break;
> +		default:
> +			ret = -EINVAL;
> +		}
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -161,6 +209,8 @@ static int hmc425a_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_HARDWAREGAIN:
>  		return IIO_VAL_INT_PLUS_MICRO_DB;
> +	case IIO_CHAN_INFO_ENABLE:
> +		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -181,15 +231,30 @@ static const struct iio_info hmc425a_info = {
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
>  }
>  
> +#define LTC6373_CHAN(_channel)						\
> +{									\
> +	.type = IIO_VOLTAGE,						\
> +	.output = 1,							\
> +	.indexed = 1,							\
> +	.channel = _channel,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN) |		\
> +			      BIT(IIO_CHAN_INFO_ENABLE),		\
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
> @@ -222,6 +287,15 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
>  		.gain_max = 0,
>  		.default_gain = 0xF, /* set default gain -22.0db*/
>  	},
> +		[ID_LTC6373] = {

Looks to be one tab too far indented.

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



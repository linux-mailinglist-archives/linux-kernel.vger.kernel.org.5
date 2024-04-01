Return-Path: <linux-kernel+bounces-127004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 842018945A6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFAE3B20FDD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A0E537EE;
	Mon,  1 Apr 2024 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H1jW30UK"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7584B42056
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000744; cv=none; b=ecpaideVpY3lKBTkXc6sNCURfyA8HEDGz1RJDS9yaI/P72U6YeezHiE486oFtsvpFLylj+nxbqWoewCa9AT0z/eylt4NgcgUOrxBhMjhrLXYZSkgGrRg7ZNGdwfZjeh02Ux5ap14Q1XC+4lxjMDDV5FLBwRjwculgaOrNvWi7Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000744; c=relaxed/simple;
	bh=aEa4k7G3fJGjUq8vmXCDBIN9SDuEuR0HVLb+yY3Z7ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDLpaQpm4ARIy4fz12KM4MjympVy3ttPWI9yFK/1xV0Pjpob6gW496eR/skxpws4JoWOo/moQjQlrYs6HHSHA3F4hREAeZu2HM3p3Tma05KAOlNgnYSA40x0p4vmpGuqJDfGXme16mZbxba9huEj4bbqYylLi2XNekEu4qOk8rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=H1jW30UK; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d23114b19dso59933331fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712000740; x=1712605540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJmtqlMjE5SUgjYL9bUlwwkAd3K9/J9pKmt5XyNg60Q=;
        b=H1jW30UKmoaVM4xnTkAu3vYySBDih+5iyl3nMOeJhf3pcPjCj/Ewfo/4ZVHIv8dB6O
         OOKi95V3Nf0tyPGyWsMrT0CMyer5yCmXVOI3AbXpweCmMwVzPpb1rE5bJV+K2DSY4kNk
         8hkZ70zpzQvIv3cAb648kZYnuqqoNyAIrO75qpsKGjVAwAU4l8J8sZ3nj3pHQZhxTRMb
         NhOuQXKtx2qIHveVyB3CG9KnHaPV22M0+vo7hdT0efNfaTdH6srKHBPENxNH8WvjCRDw
         9m+OccOhRiEeRuC9qpGnxCbKHiZVczUkJw7OuEbY6ZA0x0/BrkzEKDDeVtJYnPJJpDIn
         XErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000740; x=1712605540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJmtqlMjE5SUgjYL9bUlwwkAd3K9/J9pKmt5XyNg60Q=;
        b=h1+dIdTq/NxdB22oBwQXW5I8a63AOIGBMOJzwHuQ9KJVg3kfetnzNmla8h9K1OUG55
         bhkIi1j6UYODDmnWGqXG2H3DBvqLOE4kUVy341zZTgELVK/W6QuX2obF01uM48yrcOAu
         t+KX4Cx00RYkjc39+Qn36x+ZhT9Xz69ysR5ly0+6aJFkqBQKWw09iN5UB81Z1jYjTY6c
         UJi3Ei8y1OIQ8PF1jo1B7iPUDYG2RtMWgHws3xhZEZIQJvm9Sjl4Tpkf8ZGo35Jf5+V5
         a7l79OSkmInaDBO7DolVe4nl2t+/nyqc6axPdQA+v7FXpdveE/cK9ojQeQJuQWvFOEc1
         krbA==
X-Forwarded-Encrypted: i=1; AJvYcCUHtJu1kNbT53SfQhfwJJlC0MFHUVHxYriG5Gkj2a7OFVVNVNbzb8/0zOX1AaFQbf0XPDa5ubsUzD8M5izLHzApNdhJbPkARnT3rXhP
X-Gm-Message-State: AOJu0YyIclNu4P+Db7DbtAqifPfX2JiEsKP2iUj6DEuvysj2VXtYSHGi
	Ub7AViRM3+ouVLUDIE6J5ZsQaArTD+8bhct+wYCeSO6QTQhPtxvBPSikbo8yMboQ2kha//QwSmx
	ed8YHdY0rVxl2H6+Yq4jEQRLUK11yZvy9zO7JueCOocGoUP6l
X-Google-Smtp-Source: AGHT+IEopb+j0jsGEfSe+nJLN6CZ3Y/h9foWVYnPYzfYU/eC8s50RSWct7c4rPaYk+7uiGy9PNa0oLrlbcnkm0GlQwY=
X-Received: by 2002:a2e:a786:0:b0:2d8:2480:de83 with SMTP id
 c6-20020a2ea786000000b002d82480de83mr1183402ljf.10.1712000739435; Mon, 01 Apr
 2024 12:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-6-34618a9cc502@analog.com>
In-Reply-To: <20240401-ad4111-v1-6-34618a9cc502@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 1 Apr 2024 14:45:28 -0500
Message-ID: <CAMknhBFdtv84E_S4wa4UW0pO2yiUEk9=jn=_i4F=b8VHdR6v+w@mail.gmail.com>
Subject: Re: [PATCH 6/6] iio: adc: ad7173: Add support for AD411x devices
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
<devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>
> Add support for AD4111/AD4112/AD4114/AD4115/AD4116.
>
> The AD411X family encompasses a series of low power, low noise, 24-bit,
> sigma-delta analog-to-digital converters that offer a versatile range of
> specifications.
>
> This family of ADCs integrates an analog front end suitable for processin=
g
> both fully differential and single-ended, bipolar voltage inputs
> addressing a wide array of industrial and instrumentation requirements.
>
> - All ADCs have inputs with a precision voltage divider with a division
>   ratio of 10.
> - AD4116 has 5 low level inputs without a voltage divider.
> - AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
>   shunt resistor.
>
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---
>  drivers/iio/adc/ad7173.c | 224 +++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 210 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 9526585e6929..ac32bd7dbd1e 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -1,8 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * AD717x family SPI ADC driver
> + * AD717x and AD411x family SPI ADC driver
>   *
>   * Supported devices:
> + *  AD4111/AD4112/AD4114/AD4115/AD4116
>   *  AD7172-2/AD7172-4/AD7173-8/AD7175-2
>   *  AD7175-8/AD7176-2/AD7177-2
>   *
> @@ -72,6 +73,11 @@
>  #define AD7175_2_ID                    0x0cd0
>  #define AD7172_4_ID                    0x2050
>  #define AD7173_ID                      0x30d0
> +#define AD4111_ID                      0x30d0
> +#define AD4112_ID                      0x30d0
> +#define AD4114_ID                      0x30d0

It might make it a bit more obvious that not all chips have a unique
ID if we rename AD7173_ID to AD7173_AD4111_AD4112_AD4114_ID rather
than introducing multiple macros with the same value.

Or leave it as AD7173_ID to keep it short and add a comment where it
is used with 411x chips in ad7173_device_info[].

> +#define AD4116_ID                      0x34d0
> +#define AD4115_ID                      0x38d0
>  #define AD7175_8_ID                    0x3cd0
>  #define AD7177_ID                      0x4fd0
>  #define AD7173_ID_MASK                 GENMASK(15, 4)
> @@ -120,11 +126,20 @@
>  #define AD7173_VOLTAGE_INT_REF_uV      2500000
>  #define AD7173_TEMP_SENSIIVITY_uV_per_C        477
>  #define AD7177_ODR_START_VALUE         0x07
> +#define AD4111_SHUNT_RESISTOR_OHM      50
> +#define AD4111_DIVIDER_RATIO           10
> +#define AD411X_VCOM_INPUT              0X10
> +#define AD4111_CURRENT_CHAN_CUTOFF     16
>
>  #define AD7173_FILTER_ODR0_MASK                GENMASK(5, 0)
>  #define AD7173_MAX_CONFIGS             8
>
>  enum ad7173_ids {
> +       ID_AD4111,
> +       ID_AD4112,
> +       ID_AD4114,
> +       ID_AD4115,
> +       ID_AD4116,
>         ID_AD7172_2,
>         ID_AD7172_4,
>         ID_AD7173_8,
> @@ -134,16 +149,26 @@ enum ad7173_ids {
>         ID_AD7177_2,
>  };
>
> +enum ad4111_current_channels {
> +       AD4111_CURRENT_IN0P_IN0N,
> +       AD4111_CURRENT_IN1P_IN1N,
> +       AD4111_CURRENT_IN2P_IN2N,
> +       AD4111_CURRENT_IN3P_IN3N,
> +};
> +
>  struct ad7173_device_info {
>         const unsigned int *sinc5_data_rates;
>         unsigned int num_sinc5_data_rates;
>         unsigned int odr_start_value;
> +       unsigned int num_inputs_with_divider;
>         unsigned int num_channels;
>         unsigned int num_configs;
>         unsigned int num_inputs;

Probably a good idea to change num_inputs to num_voltage_inputs so it
isn't confused with the total number of inputs.

Similarly num_voltage_inputs_with_divider instead of num_inputs_with_divide=
r.

Also could use a comment to make it clear if num_voltage_inputs
includes num_voltage_inputs_with_divider or not. And that it doesn't
include VINCOM.

Probably also need some flag here to differentiate ADCINxx voltage
inputs on AD4116.

>         unsigned int clock;
>         unsigned int id;
>         char *name;
> +       bool has_current_inputs;

Maybe more future-proof to have num_current_inputs instead of bool?

> +       bool has_vcom;

For consistency: has_vcom_input

>         bool has_temp;
>         bool has_input_buf;
>         bool has_int_ref;
> @@ -189,6 +214,24 @@ struct ad7173_state {
>  #endif
>  };
>
> +static unsigned int ad4115_sinc5_data_rates[] =3D {
> +       24845000, 24845000, 20725000, 20725000, /*  0-3  */
> +       15564000, 13841000, 10390000, 10390000, /*  4-7  */
> +       4994000,  2499000,  1000000,  500000,   /*  8-11 */
> +       395500,   200000,   100000,   59890,    /* 12-15 */
> +       49920,    20000,    16660,    10000,    /* 16-19 */
> +       5000,     2500,     2500,               /* 20-22 */
> +};
> +
> +static unsigned int ad4116_sinc5_data_rates[] =3D {
> +       12422360, 12422360, 12422360, 12422360, /*  0-3  */
> +       10362690, 10362690, 7782100,  6290530,  /*  4-7  */
> +       5194800,  2496900,  1007600,  499900,   /*  8-11 */
> +       390600,   200300,   100000,   59750,    /* 12-15 */
> +       49840,    20000,    16650,    10000,    /* 16-19 */
> +       5000,     2500,     1250,               /* 20-22 */
> +};
> +
>  static const unsigned int ad7173_sinc5_data_rates[] =3D {
>         6211000, 6211000, 6211000, 6211000, 6211000, 6211000, 5181000, 44=
44000, /*  0-7  */
>         3115000, 2597000, 1007000, 503800,  381000,  200300,  100500,  59=
520,   /*  8-15 */
> @@ -204,7 +247,91 @@ static const unsigned int ad7175_sinc5_data_rates[] =
=3D {
>         5000,                                   /* 20    */
>  };
>
> +static unsigned int ad4111_current_channel_config[] =3D {
> +       [AD4111_CURRENT_IN0P_IN0N] =3D 0x1E8,
> +       [AD4111_CURRENT_IN1P_IN1N] =3D 0x1C9,
> +       [AD4111_CURRENT_IN2P_IN2N] =3D 0x1AA,
> +       [AD4111_CURRENT_IN3P_IN3N] =3D 0x18B,
> +};

As mentioned in the DT bindings review, it would make more sense to
just use the datasheet numbers for the current input channels in the
diff-channels DT property, then we don't need this lookup table.

> +
>  static const struct ad7173_device_info ad7173_device_info[] =3D {
> +       [ID_AD4111] =3D {
> +               .id =3D AD4111_ID,
> +               .num_inputs_with_divider =3D 8,
> +               .num_channels =3D 16,
> +               .num_configs =3D 8,
> +               .num_inputs =3D 8,
> +               .num_gpios =3D 2,
> +               .has_temp =3D true,
> +               .has_vcom =3D true,
> +               .has_input_buf =3D true,
> +               .has_current_inputs =3D true,
> +               .has_int_ref =3D true,
> +               .clock =3D 2 * HZ_PER_MHZ,
> +               .sinc5_data_rates =3D ad7173_sinc5_data_rates,
> +               .num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_ra=
tes),
> +       },
> +       [ID_AD4112] =3D {
> +               .id =3D AD4112_ID,
> +               .num_inputs_with_divider =3D 8,
> +               .num_channels =3D 16,
> +               .num_configs =3D 8,
> +               .num_inputs =3D 8,
> +               .num_gpios =3D 2,
> +               .has_vcom =3D true,
> +               .has_temp =3D true,
> +               .has_input_buf =3D true,
> +               .has_current_inputs =3D true,
> +               .has_int_ref =3D true,
> +               .clock =3D 2 * HZ_PER_MHZ,
> +               .sinc5_data_rates =3D ad7173_sinc5_data_rates,
> +               .num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_ra=
tes),
> +       },
> +       [ID_AD4114] =3D {
> +               .id =3D AD4114_ID,
> +               .num_inputs_with_divider =3D 16,
> +               .num_channels =3D 16,
> +               .num_configs =3D 8,
> +               .num_inputs =3D 16,
> +               .num_gpios =3D 4,
> +               .has_vcom =3D true,
> +               .has_temp =3D true,
> +               .has_input_buf =3D true,
> +               .has_int_ref =3D true,
> +               .clock =3D 2 * HZ_PER_MHZ,
> +               .sinc5_data_rates =3D ad7173_sinc5_data_rates,
> +               .num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_ra=
tes),
> +       },
> +       [ID_AD4115] =3D {
> +               .id =3D AD4115_ID,
> +               .num_inputs_with_divider =3D 16,
> +               .num_channels =3D 16,
> +               .num_configs =3D 8,
> +               .num_inputs =3D 16,
> +               .num_gpios =3D 4,
> +               .has_vcom =3D true,
> +               .has_temp =3D true,
> +               .has_input_buf =3D true,
> +               .has_int_ref =3D true,
> +               .clock =3D 8 * HZ_PER_MHZ,
> +               .sinc5_data_rates =3D ad4115_sinc5_data_rates,
> +               .num_sinc5_data_rates =3D ARRAY_SIZE(ad4115_sinc5_data_ra=
tes),
> +       },
> +       [ID_AD4116] =3D {
> +               .id =3D AD4116_ID,
> +               .num_inputs_with_divider =3D 11,
> +               .num_channels =3D 16,
> +               .num_configs =3D 8,
> +               .num_inputs =3D 16,
> +               .num_gpios =3D 4,
> +               .has_vcom =3D true,
> +               .has_temp =3D true,
> +               .has_input_buf =3D true,
> +               .has_int_ref =3D true,
> +               .clock =3D 4 * HZ_PER_MHZ,
> +               .sinc5_data_rates =3D ad4116_sinc5_data_rates,
> +               .num_sinc5_data_rates =3D ARRAY_SIZE(ad4116_sinc5_data_ra=
tes),
> +       },
>         [ID_AD7172_2] =3D {
>                 .name =3D "ad7172-2",
>                 .id =3D AD7172_2_ID,
> @@ -670,18 +797,34 @@ static int ad7173_read_raw(struct iio_dev *indio_de=
v,
>
>                 return IIO_VAL_INT;
>         case IIO_CHAN_INFO_SCALE:
> -               if (chan->type =3D=3D IIO_TEMP) {
> +
> +               switch (chan->type) {
> +               case IIO_TEMP:
>                         temp =3D AD7173_VOLTAGE_INT_REF_uV * MILLI;
>                         temp /=3D AD7173_TEMP_SENSIIVITY_uV_per_C;
>                         *val =3D temp;
>                         *val2 =3D chan->scan_type.realbits;
> -               } else {
> +                       break;

can we just return here instead of break?

> +               case IIO_VOLTAGE:
>                         *val =3D ad7173_get_ref_voltage_milli(st, ch->cfg=
ref_sel);
>                         *val2 =3D chan->scan_type.realbits - !!(ch->cfg.b=
ipolar);
> +
> +                       if (chan->channel < st->info->num_inputs_with_div=
ider)
> +                               *val *=3D AD4111_DIVIDER_RATIO;
> +                       break;

same: return here

> +               case IIO_CURRENT:
> +                       *val =3D ad7173_get_ref_voltage_milli(st, ch->cfg=
ref_sel);
> +                       *val /=3D AD4111_SHUNT_RESISTOR_OHM;
> +                       *val2 =3D chan->scan_type.realbits - !!(ch->cfg.b=
ipolar);

Static analysis tools like to complain about using bool as int.
Probably more clear to write it as (ch->cfg.bipolar ? 1 : 0) anyway.

> +                       break;

return here


> +               default:
> +                       return -EINVAL;
>                 }
>                 return IIO_VAL_FRACTIONAL_LOG2;
>         case IIO_CHAN_INFO_OFFSET:
> -               if (chan->type =3D=3D IIO_TEMP) {
> +
> +               switch (chan->type) {
> +               case IIO_TEMP:
>                         /* 0 Kelvin -> raw sample */
>                         temp   =3D -ABSOLUTE_ZERO_MILLICELSIUS;
>                         temp  *=3D AD7173_TEMP_SENSIIVITY_uV_per_C;
> @@ -690,8 +833,13 @@ static int ad7173_read_raw(struct iio_dev *indio_dev=
,
>                                                        AD7173_VOLTAGE_INT=
_REF_uV *
>                                                        MILLI);
>                         *val   =3D -temp;
> -               } else {
> +                       break;

return ...

> +               case IIO_VOLTAGE:
> +               case IIO_CURRENT:
>                         *val =3D -BIT(chan->scan_type.realbits - 1);

Expecting a special case here, at least when ADCIN15 is configured for
pseudo-differential inputs.

> +                       break;

return ...

> +               default:
> +                       return -EINVAL;
>                 }
>                 return IIO_VAL_INT;
>         case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -909,6 +1057,24 @@ static int ad7173_register_clk_provider(struct iio_=
dev *indio_dev)
>                                            &st->int_clk_hw);
>  }
>
> +static int ad4111_validate_current_ain(struct ad7173_state *st,
> +                                      unsigned int ain[2])
> +{
> +       struct device *dev =3D &st->sd.spi->dev;
> +
> +       if (!st->info->has_current_inputs)
> +               return dev_err_probe(dev, -EINVAL,
> +                       "Reg values equal to or higher than %d are restri=
cted to models with current channels.\n",
> +                       AD4111_CURRENT_CHAN_CUTOFF);
> +
> +       if (ain[1] !=3D 0 && ain[0] >=3D ARRAY_SIZE(ad4111_current_channe=
l_config))
> +               return dev_err_probe(dev, -EINVAL,
> +                       "For current channel diff-channels must be <[0-%d=
],0>\n",
> +                       ARRAY_SIZE(ad4111_current_channel_config) - 1);
> +
> +       return 0;
> +}
> +
>  static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
>                                               unsigned int ain[2])
>  {
> @@ -951,7 +1117,7 @@ static int ad7173_fw_parse_channel_config(struct iio=
_dev *indio_dev)
>         struct device *dev =3D indio_dev->dev.parent;
>         struct iio_chan_spec *chan_arr, *chan;
>         unsigned int ain[2], chan_index =3D 0;
> -       int ref_sel, ret, num_channels;
> +       int ref_sel, ret, reg, num_channels;
>
>         num_channels =3D device_get_child_node_count(dev);
>
> @@ -1004,10 +1170,20 @@ static int ad7173_fw_parse_channel_config(struct =
iio_dev *indio_dev)
>                 if (ret)
>                         return ret;
>
> -               ret =3D ad7173_validate_voltage_ain_inputs(st, ain);
> +               ret =3D fwnode_property_read_u32(child, "reg", &reg);
>                 if (ret)
>                         return ret;
>
> +               if (reg >=3D AD4111_CURRENT_CHAN_CUTOFF) {

As mentioned in the DT bindings review, using reg to determine if an a
channel is a current input or voltage input seems wrong/fragile. We
should be able to use the has_current_inputs flag and the input
numbers instead to determine the type of input.

> +                       ret =3D ad4111_validate_current_ain(st, ain);
> +                       if (ret)
> +                               return ret;
> +               } else {
> +                       ret =3D ad7173_validate_voltage_ain_inputs(st, ai=
n);
> +                       if (ret)
> +                               return ret;
> +               }
> +
>                 ret =3D fwnode_property_match_property_string(child,
>                                                             "adi,referenc=
e-select",
>                                                             ad7173_ref_se=
l_str,
> @@ -1028,15 +1204,22 @@ static int ad7173_fw_parse_channel_config(struct =
iio_dev *indio_dev)
>                 *chan =3D ad7173_channel_template;
>                 chan->address =3D chan_index;
>                 chan->scan_index =3D chan_index;
> -               chan->channel =3D ain[0];
> -               chan->channel2 =3D ain[1];
> -               chan->differential =3D true;
>
> -               chan_st_priv->ain =3D AD7173_CH_ADDRESS(ain[0], ain[1]);
> +               if (reg >=3D AD4111_CURRENT_CHAN_CUTOFF) {
> +                       chan->type =3D IIO_CURRENT;
> +                       chan->channel =3D ain[0];
> +                       chan_st_priv->ain =3D ad4111_current_channel_conf=
ig[ain[0]];
> +               } else {
> +                       chan->channel =3D ain[0];
> +                       chan->channel2 =3D ain[1];
> +                       chan->differential =3D true;

Expecting chan->differential =3D false when ADCIN15 is configured for
pseudo-differential inputs.

Also, perhaps missed in previous reviews, I would expect
chan->differential =3D false when channels are used as single-ended.


> +
> +                       chan_st_priv->ain =3D AD7173_CH_ADDRESS(ain[0], a=
in[1]);
> +                       chan_st_priv->cfg.input_buf =3D st->info->has_inp=
ut_buf;
> +               }
> +
>                 chan_st_priv->chan_reg =3D chan_index;
> -               chan_st_priv->cfg.input_buf =3D st->info->has_input_buf;
>                 chan_st_priv->cfg.odr =3D 0;
> -
>                 chan_st_priv->cfg.bipolar =3D fwnode_property_read_bool(c=
hild, "bipolar");
>                 if (chan_st_priv->cfg.bipolar)
>                         chan->info_mask_separate |=3D BIT(IIO_CHAN_INFO_O=
FFSET);
> @@ -1167,6 +1350,14 @@ static int ad7173_probe(struct spi_device *spi)
>  }
>
>  static const struct of_device_id ad7173_of_match[] =3D {
> +       { .compatible =3D "ad4111",
> +         .data =3D &ad7173_device_info[ID_AD4111]},
> +       { .compatible =3D "ad4112",
> +         .data =3D &ad7173_device_info[ID_AD4112]},
> +       { .compatible =3D "ad4114",
> +         .data =3D &ad7173_device_info[ID_AD4114]},
> +       { .compatible =3D "ad4115",
> +         .data =3D &ad7173_device_info[ID_AD4115]},
>         { .compatible =3D "adi,ad7172-2",
>           .data =3D &ad7173_device_info[ID_AD7172_2]},
>         { .compatible =3D "adi,ad7172-4",
> @@ -1186,6 +1377,11 @@ static const struct of_device_id ad7173_of_match[]=
 =3D {
>  MODULE_DEVICE_TABLE(of, ad7173_of_match);
>
>  static const struct spi_device_id ad7173_id_table[] =3D {
> +       { "ad4111", (kernel_ulong_t)&ad7173_device_info[ID_AD4111]},
> +       { "ad4112", (kernel_ulong_t)&ad7173_device_info[ID_AD4112]},
> +       { "ad4114", (kernel_ulong_t)&ad7173_device_info[ID_AD4114]},
> +       { "ad4115", (kernel_ulong_t)&ad7173_device_info[ID_AD4115]},
> +       { "ad4116", (kernel_ulong_t)&ad7173_device_info[ID_AD4116]},
>         { "ad7172-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7172_2]},
>         { "ad7172-4", (kernel_ulong_t)&ad7173_device_info[ID_AD7172_4]},
>         { "ad7173-8", (kernel_ulong_t)&ad7173_device_info[ID_AD7173_8]},
> @@ -1210,5 +1406,5 @@ module_spi_driver(ad7173_driver);
>  MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
>  MODULE_AUTHOR("Lars-Peter Clausen <lars@metafo.de>");
>  MODULE_AUTHOR("Dumitru Ceclan <dumitru.ceclan@analog.com>");
> -MODULE_DESCRIPTION("Analog Devices AD7172/AD7173/AD7175/AD7176 ADC drive=
r");
> +MODULE_DESCRIPTION("Analog Devices AD717x and AD411x ADC driver");
>  MODULE_LICENSE("GPL");
>
> --
> 2.43.0
>
>


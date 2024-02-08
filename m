Return-Path: <linux-kernel+bounces-58173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D825C84E249
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E141F23C57
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767DE76C61;
	Thu,  8 Feb 2024 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ln3xPjUz"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0735E1E4A7
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400216; cv=none; b=sDsDlDV3bixELC6fkv76WiBRWDjlQqPkQm0nTxDuVsWw8IntwvYMdNwOq9GaEZIGs2QuxL1wdY4KS4mM9R9qQTIT54KIY80eEe7ZsirWsFH9dYNI7PS+PdeRautwzryNrorH8wy/Xqzfh1ppxwudS3dq9AI7jIsxb12srXsMpEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400216; c=relaxed/simple;
	bh=9gAdSuJG7ll4wDkEISOYrYELGLQO3ANrYTYHR4YzXBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMRvuSnG3ToDWBU4Hz2lWjVh7WBkYbNGb7sQjrE5iYWv9cM9YAfQhvYlOjWaalupuJEc+apeHzdXrx0Cygwf6GfwTpQRGm//XkzzJyxrSP/qfQdWk3q0dM4gnJVVWB2Yu7myArg9jF08eHw63is6qqs7nHI6FGoJpYxfsUTZRH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ln3xPjUz; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60492a2593fso17791257b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707400213; x=1708005013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8rv2FGqqH3Onu+RJkGpczbdGvcX/zAuBsaMPhut3Hk=;
        b=ln3xPjUzQzmLtlz4kRpbhWQfRxoAB2n9DnpEMB+RkuUb+muUxQj1z/sI5d2tayiXRf
         c5lD+QOZLQXsMkrRbhF7yyuQxPHO+0QKP6XDVGp3jYuyWgwVpXNltWk6nvB5m3vbGyyA
         Nndf6uwfy8He31ZCQ1wfoQMmQAKDFAaS5co0Wr2d2q3SIIrCMViWyK2frmGrj3I7mVkY
         bK/OpzPX2q+gR3AsxQ/f6Vd8SDVCPde2Gmwj1HnIWFaWTImVBbA0CZ7EDlk3ogh5LGZG
         Nw5qw9EIMPW2+5v6SKQXqqAZY9h2TrtXvbtGDOt/PQHFiojpa5YFVQI2OxDzD/t84bFa
         9rVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400213; x=1708005013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8rv2FGqqH3Onu+RJkGpczbdGvcX/zAuBsaMPhut3Hk=;
        b=dF6Y7OSIrMqGH/wkZEDjaCd/4umBX2RHd+htXh3/q+E04SWK2Gmp24Dzz+Ih8nk4lr
         dq19ZeLFjui+OS2rfWrlPIOWEfLtb2p6GAyzwn6PzbrFEI5v27ni3KhC3UdYKYfTv8j3
         akOQ6wL1H9qcBSOH+8QSW49vTZ5Kw4RcqQTgZYAJSUNiQdwsMuD9W5zIE5btyf1Y8CZ7
         HuIgAV0FsarSWp7OeydjBH9YlETXonZIppa6Mb/9O0F+w+s4HILcPXIkW4++RFkbJLxX
         vRsI15J9O0B4LtIzNNlq6IMT+QhSV1KltTpHPEDt0+ZvSUY4t/KqgIgKMIa5EzgHYHer
         AqtQ==
X-Gm-Message-State: AOJu0YwpIeu3S5+LDtUrwFPyY4wVha9NPWhHtdvp3AZUFEEVrNzloL9z
	4lL0ZOI0kQfMIT44beyMNRhualDCUXqzyE2JLvCgN4Ug8vvwxJonRRiSigzIok9OEybvhf3wEwr
	1GpvN4SYrdC/0L7Q2DY2W71P/jePbT8fFzo1QgQ==
X-Google-Smtp-Source: AGHT+IHMM4yVaU3TqRpnkhc7F/Sh8UbviIbbZP42w3VZ6hkJCh7cFN9scNEfSasYSRLTsoZaSO1kfnUrTX9i+njT8Co=
X-Received: by 2002:a81:99ca:0:b0:5ff:85f4:27ee with SMTP id
 q193-20020a8199ca000000b005ff85f427eemr7700269ywg.10.1707400212877; Thu, 08
 Feb 2024 05:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208092134.1207267-1-bhargav.r@ltts.com>
In-Reply-To: <20240208092134.1207267-1-bhargav.r@ltts.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 8 Feb 2024 14:50:01 +0100
Message-ID: <CACRpkdZ+fhwQSsZCAgh=70jA7Vo858XYzinTK1tO1NWJza-22g@mail.gmail.com>
Subject: Re: [PATCH v1 12/13] pinctrl: pinctrl-tps6594: Add TPS65224 PMIC
 pinctrl and GPIO
To: Bhargav Raviprakash <bhargav.r@ltts.com>, Esteban Blanc <eblanc@baylibre.com>
Cc: linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Top posting for context to new people.

I'd like Esteban to look at this, because he wrote the driver.

Yours,
Linus Walleij

On Thu, Feb 8, 2024 at 10:21=E2=80=AFAM Bhargav Raviprakash <bhargav.r@ltts=
com> wrote:

> From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
>
> Add support for TPS65224 pinctrl and GPIOs to TPS6594 driver as they
> have significant functional overlap.
> TPS65224 PMIC has 6 GPIOS which can be configured as GPIO or other
> dedicated device functions.
>
> Signed-off-by: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> ---
>  drivers/pinctrl/pinctrl-tps6594.c | 287 +++++++++++++++++++++++++-----
>  1 file changed, 246 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-tps6594.c b/drivers/pinctrl/pinctrl-=
tps6594.c
> index 66985e54b..5da21aa14 100644
> --- a/drivers/pinctrl/pinctrl-tps6594.c
> +++ b/drivers/pinctrl/pinctrl-tps6594.c
> @@ -14,8 +14,6 @@
>
>  #include <linux/mfd/tps6594.h>
>
> -#define TPS6594_PINCTRL_PINS_NB 11
> -
>  #define TPS6594_PINCTRL_GPIO_FUNCTION 0
>  #define TPS6594_PINCTRL_SCL_I2C2_CS_SPI_FUNCTION 1
>  #define TPS6594_PINCTRL_TRIG_WDOG_FUNCTION 1
> @@ -40,17 +38,40 @@
>  #define TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION_GPIO8 3
>  #define TPS6594_PINCTRL_CLK32KOUT_FUNCTION_GPIO9 3
>
> +/* TPS65224 pin muxval */
> +#define TPS65224_PINCTRL_SDA_I2C2_SDO_SPI_FUNCTION 1
> +#define TPS65224_PINCTRL_SCL_I2C2_CS_SPI_FUNCTION 1
> +#define TPS65224_PINCTRL_VMON1_FUNCTION 1
> +#define TPS65224_PINCTRL_VMON2_FUNCTION 1
> +#define TPS65224_PINCTRL_WKUP_FUNCTION 1
> +#define TPS65224_PINCTRL_NSLEEP2_FUNCTION 2
> +#define TPS65224_PINCTRL_NSLEEP1_FUNCTION 2
> +#define TPS65224_PINCTRL_SYNCCLKIN_FUNCTION 2
> +#define TPS65224_PINCTRL_NERR_MCU_FUNCTION 2
> +#define TPS65224_PINCTRL_NINT_FUNCTION 3
> +#define TPS65224_PINCTRL_TRIG_WDOG_FUNCTION 3
> +#define TPS65224_PINCTRL_PB_FUNCTION 3
> +#define TPS65224_PINCTRL_ADC_IN_FUNCTION 3
> +
> +/* TPS65224 Special muxval for recalcitrant pins */
> +#define TPS65224_PINCTRL_NSLEEP2_FUNCTION_GPIO5 1
> +#define TPS65224_PINCTRL_WKUP_FUNCTION_GPIO5 4
> +#define TPS65224_PINCTRL_SYNCCLKIN_FUNCTION_GPIO5 3
> +
>  #define TPS6594_OFFSET_GPIO_SEL 5
>
> -#define FUNCTION(fname, v)                                              =
                       \
> +#define TPS65224_NGPIO_PER_REG 6
> +#define TPS6594_NGPIO_PER_REG  8
> +
> +#define FUNCTION(dev_name, fname, v)                                    =
               \
>  {                                                                       =
               \
>         .pinfunction =3D PINCTRL_PINFUNCTION(#fname,                     =
                 \
> -                                       tps6594_##fname##_func_group_name=
s,             \
> -                                       ARRAY_SIZE(tps6594_##fname##_func=
_group_names)),\
> +                                       dev_name##_##fname##_func_group_n=
ames,          \
> +                                       ARRAY_SIZE(dev_name##_##fname##_f=
unc_group_names)),\
>         .muxval =3D v,                                                   =
                 \
>  }
>
> -static const struct pinctrl_pin_desc tps6594_pins[TPS6594_PINCTRL_PINS_N=
B] =3D {
> +static const struct pinctrl_pin_desc tps6594_pins[] =3D {
>         PINCTRL_PIN(0, "GPIO0"),   PINCTRL_PIN(1, "GPIO1"),
>         PINCTRL_PIN(2, "GPIO2"),   PINCTRL_PIN(3, "GPIO3"),
>         PINCTRL_PIN(4, "GPIO4"),   PINCTRL_PIN(5, "GPIO5"),
> @@ -143,30 +164,127 @@ static const char *const tps6594_syncclkin_func_gr=
oup_names[] =3D {
>         "GPIO9",
>  };
>
> +static const struct pinctrl_pin_desc tps65224_pins[] =3D {
> +       PINCTRL_PIN(0, "GPIO0"),   PINCTRL_PIN(1, "GPIO1"),
> +       PINCTRL_PIN(2, "GPIO2"),   PINCTRL_PIN(3, "GPIO3"),
> +       PINCTRL_PIN(4, "GPIO4"),   PINCTRL_PIN(5, "GPIO5"),
> +};
> +
> +static const char *const tps65224_gpio_func_group_names[] =3D {
> +       "GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5",
> +};
> +
> +static const char *const tps65224_sda_i2c2_sdo_spi_func_group_names[] =
=3D {
> +       "GPIO0",
> +};
> +
> +static const char *const tps65224_nsleep2_func_group_names[] =3D {
> +       "GPIO0", "GPIO5",
> +};
> +
> +static const char *const tps65224_nint_func_group_names[] =3D {
> +       "GPIO0",
> +};
> +
> +static const char *const tps65224_scl_i2c2_cs_spi_func_group_names[] =3D=
 {
> +       "GPIO1",
> +};
> +
> +static const char *const tps65224_nsleep1_func_group_names[] =3D {
> +       "GPIO1", "GPIO2", "GPIO3",
> +};
> +
> +static const char *const tps65224_trig_wdog_func_group_names[] =3D {
> +       "GPIO1",
> +};
> +
> +static const char *const tps65224_vmon1_func_group_names[] =3D {
> +       "GPIO2",
> +};
> +
> +static const char *const tps65224_pb_func_group_names[] =3D {
> +       "GPIO2",
> +};
> +
> +static const char *const tps65224_vmon2_func_group_names[] =3D {
> +       "GPIO3",
> +};
> +
> +static const char *const tps65224_adc_in_func_group_names[] =3D {
> +       "GPIO3", "GPIO4",
> +};
> +
> +static const char *const tps65224_wkup_func_group_names[] =3D {
> +       "GPIO4", "GPIO5",
> +};
> +
> +static const char *const tps65224_syncclkin_func_group_names[] =3D {
> +       "GPIO4", "GPIO5",
> +};
> +
> +static const char *const tps65224_nerr_mcu_func_group_names[] =3D {
> +       "GPIO5",
> +};
> +
>  struct tps6594_pinctrl_function {
>         struct pinfunction pinfunction;
>         u8 muxval;
>  };
>
> +struct muxval_remap {
> +       unsigned int group;
> +       u8 muxval;
> +       u8 remap;
> +};
> +
> +struct muxval_remap tps65224_muxval_remap[] =3D {
> +       {5, TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION, TPS65224_PINCTRL_WKUP_=
FUNCTION_GPIO5},
> +       {5, TPS65224_PINCTRL_SYNCCLKIN_FUNCTION, TPS65224_PINCTRL_SYNCCLK=
IN_FUNCTION_GPIO5},
> +       {5, TPS65224_PINCTRL_NSLEEP2_FUNCTION, TPS65224_PINCTRL_NSLEEP2_F=
UNCTION_GPIO5},
> +};
> +
> +struct muxval_remap tps6594_muxval_remap[] =3D {
> +       {8, TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION, TPS6594_PINCTRL_DISABL=
E_WDOG_FUNCTION_GPIO8},
> +       {8, TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION, TPS6594_PINCTRL_SYNCCLKO=
UT_FUNCTION_GPIO8},
> +       {9, TPS6594_PINCTRL_CLK32KOUT_FUNCTION, TPS6594_PINCTRL_CLK32KOUT=
_FUNCTION_GPIO9},
> +};
> +
>  static const struct tps6594_pinctrl_function pinctrl_functions[] =3D {
> -       FUNCTION(gpio, TPS6594_PINCTRL_GPIO_FUNCTION),
> -       FUNCTION(nsleep1, TPS6594_PINCTRL_NSLEEP1_FUNCTION),
> -       FUNCTION(nsleep2, TPS6594_PINCTRL_NSLEEP2_FUNCTION),
> -       FUNCTION(wkup1, TPS6594_PINCTRL_WKUP1_FUNCTION),
> -       FUNCTION(wkup2, TPS6594_PINCTRL_WKUP2_FUNCTION),
> -       FUNCTION(scl_i2c2_cs_spi, TPS6594_PINCTRL_SCL_I2C2_CS_SPI_FUNCTIO=
N),
> -       FUNCTION(nrstout_soc, TPS6594_PINCTRL_NRSTOUT_SOC_FUNCTION),
> -       FUNCTION(trig_wdog, TPS6594_PINCTRL_TRIG_WDOG_FUNCTION),
> -       FUNCTION(sda_i2c2_sdo_spi, TPS6594_PINCTRL_SDA_I2C2_SDO_SPI_FUNCT=
ION),
> -       FUNCTION(clk32kout, TPS6594_PINCTRL_CLK32KOUT_FUNCTION),
> -       FUNCTION(nerr_soc, TPS6594_PINCTRL_NERR_SOC_FUNCTION),
> -       FUNCTION(sclk_spmi, TPS6594_PINCTRL_SCLK_SPMI_FUNCTION),
> -       FUNCTION(sdata_spmi, TPS6594_PINCTRL_SDATA_SPMI_FUNCTION),
> -       FUNCTION(nerr_mcu, TPS6594_PINCTRL_NERR_MCU_FUNCTION),
> -       FUNCTION(syncclkout, TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION),
> -       FUNCTION(disable_wdog, TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION),
> -       FUNCTION(pdog, TPS6594_PINCTRL_PDOG_FUNCTION),
> -       FUNCTION(syncclkin, TPS6594_PINCTRL_SYNCCLKIN_FUNCTION),
> +       FUNCTION(tps6594, gpio, TPS6594_PINCTRL_GPIO_FUNCTION),
> +       FUNCTION(tps6594, nsleep1, TPS6594_PINCTRL_NSLEEP1_FUNCTION),
> +       FUNCTION(tps6594, nsleep2, TPS6594_PINCTRL_NSLEEP2_FUNCTION),
> +       FUNCTION(tps6594, wkup1, TPS6594_PINCTRL_WKUP1_FUNCTION),
> +       FUNCTION(tps6594, wkup2, TPS6594_PINCTRL_WKUP2_FUNCTION),
> +       FUNCTION(tps6594, scl_i2c2_cs_spi, TPS6594_PINCTRL_SCL_I2C2_CS_SP=
I_FUNCTION),
> +       FUNCTION(tps6594, nrstout_soc, TPS6594_PINCTRL_NRSTOUT_SOC_FUNCTI=
ON),
> +       FUNCTION(tps6594, trig_wdog, TPS6594_PINCTRL_TRIG_WDOG_FUNCTION),
> +       FUNCTION(tps6594, sda_i2c2_sdo_spi, TPS6594_PINCTRL_SDA_I2C2_SDO_=
SPI_FUNCTION),
> +       FUNCTION(tps6594, clk32kout, TPS6594_PINCTRL_CLK32KOUT_FUNCTION),
> +       FUNCTION(tps6594, nerr_soc, TPS6594_PINCTRL_NERR_SOC_FUNCTION),
> +       FUNCTION(tps6594, sclk_spmi, TPS6594_PINCTRL_SCLK_SPMI_FUNCTION),
> +       FUNCTION(tps6594, sdata_spmi, TPS6594_PINCTRL_SDATA_SPMI_FUNCTION=
),
> +       FUNCTION(tps6594, nerr_mcu, TPS6594_PINCTRL_NERR_MCU_FUNCTION),
> +       FUNCTION(tps6594, syncclkout, TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION=
),
> +       FUNCTION(tps6594, disable_wdog, TPS6594_PINCTRL_DISABLE_WDOG_FUNC=
TION),
> +       FUNCTION(tps6594, pdog, TPS6594_PINCTRL_PDOG_FUNCTION),
> +       FUNCTION(tps6594, syncclkin, TPS6594_PINCTRL_SYNCCLKIN_FUNCTION),
> +};
> +
> +static const struct tps6594_pinctrl_function tps65224_pinctrl_functions[=
] =3D {
> +       FUNCTION(tps65224, gpio, TPS6594_PINCTRL_GPIO_FUNCTION),
> +       FUNCTION(tps65224, sda_i2c2_sdo_spi, TPS65224_PINCTRL_SDA_I2C2_SD=
O_SPI_FUNCTION),
> +       FUNCTION(tps65224, nsleep2, TPS65224_PINCTRL_NSLEEP2_FUNCTION),
> +       FUNCTION(tps65224, nint, TPS65224_PINCTRL_NINT_FUNCTION),
> +       FUNCTION(tps65224, scl_i2c2_cs_spi, TPS65224_PINCTRL_SCL_I2C2_CS_=
SPI_FUNCTION),
> +       FUNCTION(tps65224, nsleep1, TPS65224_PINCTRL_NSLEEP1_FUNCTION),
> +       FUNCTION(tps65224, trig_wdog, TPS65224_PINCTRL_TRIG_WDOG_FUNCTION=
),
> +       FUNCTION(tps65224, vmon1, TPS65224_PINCTRL_VMON1_FUNCTION),
> +       FUNCTION(tps65224, pb, TPS65224_PINCTRL_PB_FUNCTION),
> +       FUNCTION(tps65224, vmon2, TPS65224_PINCTRL_VMON2_FUNCTION),
> +       FUNCTION(tps65224, adc_in, TPS65224_PINCTRL_ADC_IN_FUNCTION),
> +       FUNCTION(tps65224, wkup, TPS65224_PINCTRL_WKUP_FUNCTION),
> +       FUNCTION(tps65224, syncclkin, TPS65224_PINCTRL_SYNCCLKIN_FUNCTION=
),
> +       FUNCTION(tps65224, nerr_mcu, TPS65224_PINCTRL_NERR_MCU_FUNCTION),
>  };
>
>  struct tps6594_pinctrl {
> @@ -201,7 +319,21 @@ static int tps6594_gpio_regmap_xlate(struct gpio_reg=
map *gpio,
>
>  static int tps6594_pmx_func_cnt(struct pinctrl_dev *pctldev)
>  {
> -       return ARRAY_SIZE(pinctrl_functions);
> +       struct tps6594_pinctrl *pinctrl =3D pinctrl_dev_get_drvdata(pctld=
ev);
> +       int func_cnt =3D 0;
> +
> +       switch (pinctrl->tps->chip_id) {
> +       case TPS65224:
> +               func_cnt =3D ARRAY_SIZE(tps65224_pinctrl_functions);
> +               break;
> +       case TPS6594:
> +               func_cnt =3D ARRAY_SIZE(pinctrl_functions);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return func_cnt;
>  }
>
>  static const char *tps6594_pmx_func_name(struct pinctrl_dev *pctldev,
> @@ -229,10 +361,26 @@ static int tps6594_pmx_set(struct tps6594_pinctrl *=
pinctrl, unsigned int pin,
>                            u8 muxval)
>  {
>         u8 mux_sel_val =3D muxval << TPS6594_OFFSET_GPIO_SEL;
> +       u8 mux_sel_mask =3D 0;
> +
> +       switch (pinctrl->tps->chip_id) {
> +       case TPS65224:
> +               mux_sel_mask =3D TPS65224_MASK_GPIO_SEL;
> +               /* GPIO6 has a different mask in TPS65224*/
> +               if (pin =3D=3D 5)
> +                       mux_sel_mask =3D TPS65224_MASK_GPIO_SEL_GPIO6;
> +               mux_sel_mask =3D TPS6594_MASK_GPIO_SEL;
> +               break;
> +       case TPS6594:
> +               mux_sel_mask =3D TPS6594_MASK_GPIO_SEL;
> +               break;
> +       default:
> +               break;
> +       }
>
>         return regmap_update_bits(pinctrl->tps->regmap,
>                                   TPS6594_REG_GPIOX_CONF(pin),
> -                                 TPS6594_MASK_GPIO_SEL, mux_sel_val);
> +                                 mux_sel_mask, mux_sel_val);
>  }
>
>  static int tps6594_pmx_set_mux(struct pinctrl_dev *pctldev,
> @@ -240,16 +388,28 @@ static int tps6594_pmx_set_mux(struct pinctrl_dev *=
pctldev,
>  {
>         struct tps6594_pinctrl *pinctrl =3D pinctrl_dev_get_drvdata(pctld=
ev);
>         u8 muxval =3D pinctrl->funcs[function].muxval;
> +       unsigned int remap_cnt =3D 0;
> +       struct muxval_remap *remap;
>
>         /* Some pins don't have the same muxval for the same function... =
*/
> -       if (group =3D=3D 8) {
> -               if (muxval =3D=3D TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION)
> -                       muxval =3D TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION_=
GPIO8;
> -               else if (muxval =3D=3D TPS6594_PINCTRL_SYNCCLKOUT_FUNCTIO=
N)
> -                       muxval =3D TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION_GP=
IO8;
> -       } else if (group =3D=3D 9) {
> -               if (muxval =3D=3D TPS6594_PINCTRL_CLK32KOUT_FUNCTION)
> -                       muxval =3D TPS6594_PINCTRL_CLK32KOUT_FUNCTION_GPI=
O9;
> +       switch (pinctrl->tps->chip_id) {
> +       case TPS65224:
> +               remap =3D tps65224_muxval_remap;
> +               remap_cnt =3D ARRAY_SIZE(tps65224_muxval_remap);
> +               break;
> +       case TPS6594:
> +               remap =3D tps6594_muxval_remap;
> +               remap_cnt =3D ARRAY_SIZE(tps6594_muxval_remap);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       for (unsigned int i =3D 0; i < remap_cnt; i++) {
> +               if (group =3D=3D remap[i].group && muxval =3D=3D remap[i]=
muxval) {
> +                       muxval =3D remap[i].remap;
> +                       break;
> +               }
>         }
>
>         return tps6594_pmx_set(pinctrl, group, muxval);
> @@ -276,7 +436,21 @@ static const struct pinmux_ops tps6594_pmx_ops =3D {
>
>  static int tps6594_groups_cnt(struct pinctrl_dev *pctldev)
>  {
> -       return ARRAY_SIZE(tps6594_pins);
> +       struct tps6594_pinctrl *pinctrl =3D pinctrl_dev_get_drvdata(pctld=
ev);
> +       int num_pins =3D 0;
> +
> +       switch (pinctrl->tps->chip_id) {
> +       case TPS65224:
> +               num_pins =3D ARRAY_SIZE(tps65224_pins);
> +               break;
> +       case TPS6594:
> +               num_pins =3D ARRAY_SIZE(tps6594_pins);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return num_pins;
>  }
>
>  static int tps6594_group_pins(struct pinctrl_dev *pctldev,
> @@ -320,8 +494,18 @@ static int tps6594_pinctrl_probe(struct platform_dev=
ice *pdev)
>                 return -ENOMEM;
>         pctrl_desc->name =3D dev_name(dev);
>         pctrl_desc->owner =3D THIS_MODULE;
> -       pctrl_desc->pins =3D tps6594_pins;
> -       pctrl_desc->npins =3D ARRAY_SIZE(tps6594_pins);
> +       switch (tps->chip_id) {
> +       case TPS65224:
> +               pctrl_desc->pins =3D tps65224_pins;
> +               pctrl_desc->npins =3D ARRAY_SIZE(tps65224_pins);
> +               break;
> +       case TPS6594:
> +               pctrl_desc->pins =3D tps6594_pins;
> +               pctrl_desc->npins =3D ARRAY_SIZE(tps6594_pins);
> +               break;
> +       default:
> +               break;
> +       }
>         pctrl_desc->pctlops =3D &tps6594_pctrl_ops;
>         pctrl_desc->pmxops =3D &tps6594_pmx_ops;
>
> @@ -329,8 +513,18 @@ static int tps6594_pinctrl_probe(struct platform_dev=
ice *pdev)
>         if (!pinctrl)
>                 return -ENOMEM;
>         pinctrl->tps =3D dev_get_drvdata(dev->parent);
> -       pinctrl->funcs =3D pinctrl_functions;
> -       pinctrl->pins =3D tps6594_pins;
> +       switch (pinctrl->tps->chip_id) {
> +       case TPS65224:
> +               pinctrl->funcs =3D tps65224_pinctrl_functions;
> +               pinctrl->pins =3D tps65224_pins;
> +               break;
> +       case TPS6594:
> +               pinctrl->funcs =3D pinctrl_functions;
> +               pinctrl->pins =3D tps6594_pins;
> +               break;
> +       default:
> +               break;
> +       }
>         pinctrl->pctl_dev =3D devm_pinctrl_register(dev, pctrl_desc, pinc=
trl);
>         if (IS_ERR(pinctrl->pctl_dev))
>                 return dev_err_probe(dev, PTR_ERR(pinctrl->pctl_dev),
> @@ -338,8 +532,18 @@ static int tps6594_pinctrl_probe(struct platform_dev=
ice *pdev)
>
>         config.parent =3D tps->dev;
>         config.regmap =3D tps->regmap;
> -       config.ngpio =3D TPS6594_PINCTRL_PINS_NB;
> -       config.ngpio_per_reg =3D 8;
> +       switch (pinctrl->tps->chip_id) {
> +       case TPS65224:
> +               config.ngpio =3D ARRAY_SIZE(tps65224_gpio_func_group_name=
s);
> +               config.ngpio_per_reg =3D TPS65224_NGPIO_PER_REG;
> +               break;
> +       case TPS6594:
> +               config.ngpio =3D ARRAY_SIZE(tps6594_gpio_func_group_names=
);
> +               config.ngpio_per_reg =3D TPS6594_NGPIO_PER_REG;
> +               break;
> +       default:
> +               break;
> +       }
>         config.reg_dat_base =3D TPS6594_REG_GPIO_IN_1;
>         config.reg_set_base =3D TPS6594_REG_GPIO_OUT_1;
>         config.reg_dir_out_base =3D TPS6594_REG_GPIOX_CONF(0);
> @@ -369,5 +573,6 @@ static struct platform_driver tps6594_pinctrl_driver =
=3D {
>  module_platform_driver(tps6594_pinctrl_driver);
>
>  MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");
> +MODULE_AUTHOR("Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>");
>  MODULE_DESCRIPTION("TPS6594 pinctrl and GPIO driver");
>  MODULE_LICENSE("GPL");
> --
> 2.25.1
>


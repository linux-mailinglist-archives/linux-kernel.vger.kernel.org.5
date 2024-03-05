Return-Path: <linux-kernel+bounces-91987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D701287196C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0659E1C2251D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DA250A69;
	Tue,  5 Mar 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRoi4h6u"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2996B52F9A;
	Tue,  5 Mar 2024 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630389; cv=none; b=RtJyr7/znuavookWI0B8Abm65S0S3kM1XBZWfDtbVcgmSUg6IIANNCXvAeROfwXKQQmTbb7gSf6avVt+SKwFI57eIDfFidU9IjEpD0jJJFvmkMi11RAw1Rbi+PVsk5C0HYYiMXxlhOnwpcANaJy3Nv3KLtUuaqNSwItytvmjT0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630389; c=relaxed/simple;
	bh=eev7GnbVv/qDn4S1pxBTDgkO1GfK+TChNdpLax/Zfcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOgftflLij9cYyNQlEMp/uMp6oNJn0jg8so4xaKZG5biR6GR9qmdDu1AnkhVwDmAjsyxjk8r1DPVlK5HJuc5+gOwWG+fUtWfZL/jatoJjkFE1GZhgUX1JSNFdogqSgP4LpqdHTiJx8LgWr2jVABuo7PC7LpXglmgcjyvg0Zxb6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRoi4h6u; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e45ef83c54so3933383a34.2;
        Tue, 05 Mar 2024 01:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709630386; x=1710235186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qx8RVKeks5xoFF+dC3FM2hRTh0FAVy4/kFdS1epGby4=;
        b=KRoi4h6uT4tiR4LEa8XSffXfaMzM07IbgQz5wND1aXm01z54ElWrLBOdThLe8/DZ05
         qjxP3ByQX7/L1KVJU23vdod+4/II+CgpS67yfsO0HHFlbTYqiXxwLYlHqpzVCM1rYL00
         jIOvRfWvaIilNdApG+QEwSdI7rf/LWb1kxb/g4EL+dlM/fLRZe/jqITvQO5nZX4oOseg
         7ZlFrhIB4FyQy6Q+gwlw5NsvIHhVdtGO9EC9ZfDD3kj58+F+A68Pc5J5l8YxUyVcM40X
         37gDWpwLXWE5mqX3huZIqI8qB1SL/T6WTK1haI76BXTbHSWY+VNBzErx6iIzmVHdi4m9
         BuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709630386; x=1710235186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qx8RVKeks5xoFF+dC3FM2hRTh0FAVy4/kFdS1epGby4=;
        b=K8Y+t1HAV7XQj7W4bYWy2UAA4s0IX9yzWu3mjRO70WhxN4xCClFPlhPkgRFjfDvh0/
         dF7IvuBG5iFbqtJfPC3cYlrdtiSh/DCsRhqYr0BaLk0HkJlHtM6bnAX2xJ9VKXcco/7e
         3cpI75YlBVBNozRqRZrMC1KQryts/WsQ2wxivtyRRG4ecJ9z4D0C+9e7WvEiBnJBHnlq
         PKNoI+u6PYeP/CIKgpc3auvjjXchd0a6vtQ84BAEhfTwLLLbjoR7spSKiz5N9ZLvVNVE
         U95GbFxdo6fz9l5g4nLldkTJ1ghiAKQdIvO9w9ZDurrYG5n+QgYUGzqcCDro813QXVeg
         4UfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoZw/xKywH+3NCCYYvJNI+CjOWiyr97EU4nvNeJnxPqMDMAGRKr84w+fKCdu4rsaihb7XuvFHx6jq4suQ+KqqlOm1XGIjlAgOTFQQ1LMzvc2hjbl9Rfi5pirjjuJV2tCXMy+j8ckbCeQOgfkaOxBBOoRL3vtHzRLzj3eNdqaStHKS96A==
X-Gm-Message-State: AOJu0Yyj/f5Cpi4k7HxtTo4pJuLygNeEd4kF/TEHizrqJqD6mz6AFVPa
	DlgqB0/DNMUuJ/6OgBGHDjN7inAvlhGmzpKZQcmVB98STGQ6IjeY6boxPJs7eV4zCkiPT1nqO6k
	r7eL2vWnyAQzXQntf7HLOy1wpk/Q=
X-Google-Smtp-Source: AGHT+IEBKrsFaa3UU1orjl1o6zifI+FTyC25Vv6DaMsLue2yC9hYZhdkoWcD4yk0mSsUmKxUsGwKQUhX9RdP9qyG2gM=
X-Received: by 2002:a05:6870:8194:b0:21f:df18:349b with SMTP id
 k20-20020a056870819400b0021fdf18349bmr1082678oae.35.1709630385840; Tue, 05
 Mar 2024 01:19:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304085933.1246964-1-qiujingbao.dlmu@gmail.com>
 <20240304090248.1247215-1-qiujingbao.dlmu@gmail.com> <twzx4abuhduos5s32txeugqr2yyca6ey7adcontsnapthwqaxa@dscea3ybrlym>
In-Reply-To: <twzx4abuhduos5s32txeugqr2yyca6ey7adcontsnapthwqaxa@dscea3ybrlym>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Tue, 5 Mar 2024 17:19:34 +0800
Message-ID: <CAJRtX8T3GD-zu43-+U_rGQugqzGQQ-QbjHATV1NRdEMWevSUGw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Mon, Mar 4, 2024 at 11:37=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> thanks for your patch.
>
> On Mon, Mar 04, 2024 at 05:02:48PM +0800, Jingbao Qiu wrote:
> > Implement the PWM driver for CV1800.
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> >  drivers/pwm/Kconfig      |  10 ++
> >  drivers/pwm/Makefile     |   1 +
> >  drivers/pwm/pwm-cv1800.c | 314 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 325 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-cv1800.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 4b956d661755..455f07af94f7 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -186,6 +186,16 @@ config PWM_CROS_EC
> >         PWM driver for exposing a PWM attached to the ChromeOS Embedded
> >         Controller.
> >
> > +config PWM_CV1800
> > +     tristate "Sophgo CV1800 PWM driver"
> > +     depends on ARCH_SOPHGO || COMPILE_TEST
> > +     help
> > +       Generic PWM framework driver for the Sophgo CV1800 series
> > +       SoCs.
> > +
> > +       To compile this driver as a module, build the dependecies
> > +       as modules, this will be called pwm-cv1800.
> > +
> >  config PWM_DWC_CORE
> >       tristate
> >       depends on HAS_IOMEM
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index c5ec9e168ee7..6c3c4a07a316 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLK)               +=3D pwm-clk.o
> >  obj-$(CONFIG_PWM_CLPS711X)   +=3D pwm-clps711x.o
> >  obj-$(CONFIG_PWM_CRC)                +=3D pwm-crc.o
> >  obj-$(CONFIG_PWM_CROS_EC)    +=3D pwm-cros-ec.o
> > +obj-$(CONFIG_PWM_CV1800)     +=3D pwm-cv1800.o
> >  obj-$(CONFIG_PWM_DWC_CORE)   +=3D pwm-dwc-core.o
> >  obj-$(CONFIG_PWM_DWC)                +=3D pwm-dwc.o
> >  obj-$(CONFIG_PWM_EP93XX)     +=3D pwm-ep93xx.o
> > diff --git a/drivers/pwm/pwm-cv1800.c b/drivers/pwm/pwm-cv1800.c
> > new file mode 100644
> > index 000000000000..d5b31a2b7787
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-cv1800.c
> > @@ -0,0 +1,314 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * pwm-cv1800.c: PWM driver for Sophgo cv1800
>
> Mentioning the filename in the file isn't very helpful. It's obvious
> information.

I will drop this line.

>
> > + * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > + *
> > + * Limitations:
> > + * - It output low when PWM channel disabled.
> > + * - This pwm device supports dynamic loading of PWM parameters. When =
PWMSTART
> > + *   is written from 0 to 1, the register value (HLPERIODn, PERIODn) w=
ill be
> > + *   temporarily stored inside the PWM. If you want to dynamically cha=
nge the
> > + *   waveform during PWM output, after writing the new value to HLPERI=
ODn and
> > + *   PERIODn, write 1 and then 0 to PWMUPDATE[n] to make the new value=
 effective.
> > + * - Supports up to Rate/2 output, and the lowest is about Rate/(2^30-=
1).
> > + * - By setting HLPERIODn to 0, can produce 100% duty cycle.
> > + * - This hardware could support inverted polarity. By default, the va=
lue of the
> > + *   POLARITY register is 0x0. This means that HLPERIOD represents the=
 number
> > + *   of low level beats.
> > + * - This hardware supports input mode and output mode, implemented th=
rough the
> > + *   Output-Enable/OE register. However, this driver has not yet imple=
mented
> > + *   capture callback.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +
> > +#define PWM_CV1800_HLPERIOD_BASE     0x00
> > +#define PWM_CV1800_PERIOD_BASE       0x04
> > +#define PWM_CV1800_POLARITY          0x40
> > +#define PWM_CV1800_START             0x44
> > +#define PWM_CV1800_DONE              0x48
> > +#define PWM_CV1800_UPDATE            0x4c
> > +#define PWM_CV1800_OE                0xd0
> > +
> > +#define PWM_CV1800_HLPERIOD(n)       (PWM_CV1800_HLPERIOD_BASE + ((n) =
* 0x08))
> > +#define PWM_CV1800_PERIOD(n)         (PWM_CV1800_PERIOD_BASE + ((n) * =
0x08))
> > +
> > +#define PWM_CV1800_UPDATE_MASK(n)    (BIT(0) << (n))
> > +#define PWM_CV1800_OE_MASK(n)        (BIT(0) << (n))
> > +#define PWM_CV1800_START_MASK(n)     (BIT(0) << (n))
> > +#define PWM_CV1800_POLARITY_MASK(n)  (BIT(0) << (n))
> > +
> > +#define PWM_CV1800_OE_INPUT          0x00U
> > +#define PWM_CV1800_OE_OUTPUT(n)      (BIT(0) << (n))
> > +#define PWM_CV1800_MAXPERIOD         (BIT(30) - 1)
> > +#define PWM_CV1800_MINPERIOD         BIT(1)
>
> These are minimal and maximal values. I'd do
>
> #define PWM_CV1800_MAXPERIOD         0x3fffffff
> #define PWM_CV1800_MINPERIOD         2
>

I will fix it.

> > +#define PWM_CV1800_PERIOD_RESET      BIT(1)
> > +#define PWM_CV1800_HLPERIOD_RESET    BIT(0)
> > +#define PWM_CV1800_REG_DISABLE       0x00U
> > +#define PWM_CV1800_REG_ENABLE(n)     (BIT(0) << (n))
> > +#define PWM_CV1800_CHANNELS          4
> > +
> > +struct cv1800_pwm {
> > +     struct regmap *map;
> > +     struct clk *clk;
> > +     unsigned long clk_rate;
> > +};
> > +
> > +static inline struct cv1800_pwm *to_cv1800_pwm_dev(struct pwm_chip *ch=
ip)
> > +{
> > +     return pwmchip_get_drvdata(chip);
> > +}
> > +
> > +static const struct regmap_config cv1800_pwm_regmap_config =3D {
> > +     .reg_bits =3D 32,
> > +     .val_bits =3D 32,
> > +     .reg_stride =3D 4,
> > +};
> > +
> > +static int cv1800_pwm_enable(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > +                          bool enable)
> > +{
> > +     struct cv1800_pwm *priv =3D to_cv1800_pwm_dev(chip);
> > +     u32 pwm_enable;
> > +
> > +     regmap_read(priv->map, PWM_CV1800_START, &pwm_enable);
> > +     pwm_enable &=3D PWM_CV1800_START_MASK(pwm->hwpwm);
> > +
> > +     /*
> > +      * If the parameters are changed during runtime, Register needs
> > +      * to be updated to take effect.
> > +      */
> > +     if (pwm_enable && enable) {
> > +             regmap_update_bits(priv->map, PWM_CV1800_UPDATE,
> > +                                PWM_CV1800_UPDATE_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> > +             regmap_update_bits(priv->map, PWM_CV1800_UPDATE,
> > +                                PWM_CV1800_UPDATE_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_DISABLE);
> > +     } else if (!pwm_enable && enable) {
> > +             regmap_update_bits(priv->map, PWM_CV1800_START,
> > +                                PWM_CV1800_START_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> > +     } else if (pwm_enable && !enable) {
> > +             regmap_update_bits(priv->map, PWM_CV1800_START,
> > +                                PWM_CV1800_START_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_DISABLE);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void cv1800_pwm_set_polarity(struct pwm_chip *chip,
> > +                                 struct pwm_device *pwm,
> > +                                 enum pwm_polarity polarity)
> > +{
> > +     struct cv1800_pwm *priv =3D to_cv1800_pwm_dev(chip);
> > +
> > +     if (pwm->state.enabled)
> > +             cv1800_pwm_enable(chip, pwm, !pwm->state.enabled);
> > +
> > +     if (polarity =3D=3D PWM_POLARITY_INVERSED)
> > +             regmap_update_bits(priv->map, PWM_CV1800_POLARITY,
> > +                                PWM_CV1800_POLARITY_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> > +     else
> > +             regmap_update_bits(priv->map, PWM_CV1800_POLARITY,
> > +                                PWM_CV1800_POLARITY_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_DISABLE);
>
> Wouldn't it be more natural to make this read:
>
>         if (polarity =3D=3D PWM_POLARITY_INVERSED)
>                 regmap_update_bits(priv->map, PWM_CV1800_POLARITY,
>                                    PWM_CV1800_POLARITY_MASK(pwm->hwpwm),
>                                    PWM_CV1800_POLARITY_MASK(pwm->hwpwm));
>         else
>                 regmap_update_bits(priv->map, PWM_CV1800_POLARITY,
>                                    PWM_CV1800_POLARITY_MASK(pwm->hwpwm),
>                                    0);
>
> or even:
>
>         u32 polarity =3D 0;
>
>         if (polarity =3D=3D PWM_POLARITY_INVERSED)
>                 polarity =3D PWM_CV1800_POLARITY_MASK(pwm->hwpwm);
>
>         regmap_update_bits(priv->map, PWM_CV1800_POLARITY,
>                            PWM_CV1800_POLARITY_MASK(pwm->hwpwm),
>                            polarity);
>
> ?
>

Good idea.  My code looks so bloated. I will fix it.

> > +}
> > +
> > +static void cv1800_pwm_set_oe(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> > +                           u32 mode)
> > +{
> > +     struct cv1800_pwm *priv =3D to_cv1800_pwm_dev(chip);
> > +     u32 state;
> > +
> > +     regmap_read(priv->map, PWM_CV1800_OE, &state);
> > +     state &=3D PWM_CV1800_OE_MASK(pwm->hwpwm);
> > +
> > +     if (state =3D=3D mode)
> > +             return;
> > +
> > +     cv1800_pwm_enable(chip, pwm, false);
> > +
> > +     if (mode =3D=3D PWM_CV1800_OE_INPUT)
> > +             regmap_update_bits(priv->map, PWM_CV1800_OE,
> > +                                PWM_CV1800_OE_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_DISABLE);
> > +     else if (mode =3D=3D PWM_CV1800_OE_OUTPUT(pwm->hwpwm))
> > +             regmap_update_bits(priv->map, PWM_CV1800_OE,
> > +                                PWM_CV1800_OE_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> > +}
>
> What does this function do? A comment describing that would be good. I
> wonder about it being called unconditionally in .apply() below.

I will add a comment for this function.

>
> > +
> > +static int cv1800_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> > +                         const struct pwm_state *state)
> > +{
> > +     struct cv1800_pwm *priv =3D to_cv1800_pwm_dev(chip);
> > +     u32 period_val, hlperiod_val;
> > +     u64 tem;
> > +
> > +     cv1800_pwm_set_oe(chip, pwm, PWM_CV1800_OE_OUTPUT(pwm->hwpwm));
> > +
> > +     if (state->polarity !=3D pwm->state.polarity)
> > +             cv1800_pwm_set_polarity(chip, pwm, state->polarity);
> > +
> > +     /*
> > +      * This hardware use PERIOD and HLPERIOD registers to represent P=
WM waves.
> > +      *
> > +      * The meaning of PERIOD is how many clock cycles (from the clock=
 source)
> > +      * are used to represent PWM waves.
> > +      * PERIOD =3D rate(MHz) / target(MHz)
> > +      * PERIOD =3D period(ns) * rate(Hz) / NSEC_PER_SEC
> > +      */
> > +     tem =3D mul_u64_u64_div_u64(state->period, priv->clk_rate, NSEC_P=
ER_SEC);
>
> What does "tem" stand for? Maybe "ticks" is a better name?

"ticks" looks better. I will use it.

>
> > +     if (tem < PWM_CV1800_MINPERIOD)
> > +             return -EINVAL;
> > +
> > +     if (tem > PWM_CV1800_MAXPERIOD)
> > +             tem =3D PWM_CV1800_MAXPERIOD;
> > +
> > +     period_val =3D (u32)tem;
> > +
> > +     /*
> > +      * The meaning of HLPERIOD is the number of beats in the low or h=
igh level
> > +      * of the PERIOD. When the value of the POLARITY register is 0, H=
LPERIOD
> > +      * represents a low level.
> > +      * HLPERIOD =3D period_val - rate(MHz) / duty(MHz)
> > +      * HLPERIOD =3D period_val - duty(ns) * rate(Hz) / NSEC_PER_SEC
>
> So HLPERIOD defines the second part of each period, right? This isn't
> considered in .get_state().

I am so sorry about this. I made a mess of the duty cycle.
According to the PWM_DEBUG, it can be inferred that configure the
biggest duty_cycle not
bigger than the requested value, so in .apply duty_cycle should round down =
and
in .get_state duty_cycle should round up. However, when the polarity is nor=
mal,
This hardware requires a low-level beat count. So the corrected code
is as follows.

in .apply()

ticks =3D mul_u64_u64_div_u64(state->duty_cycle , priv->clk_rate,NSEC_PER_S=
EC);
..
hlperiod_val =3Dperiod_val- (u32)ticks;

in .get_state()

u32 hlperiod_val=3D0;

period_ns =3D DIV_ROUND_UP_ULL(period_val * NSEC_PER_SEC,priv->clk_rate);
duty_ns =3D DIV_ROUND_UP_ULL(hlperiod_val * period_ns, period_val);
hlperiod_val =3D period_ns - duty_ns;

I tested this code with PWM_DEBUG. no warning output. What do you
think about this?


>
> > +      */
> > +     tem =3D mul_u64_u64_div_u64(state->duty_cycle, priv->clk_rate,
> > +                               NSEC_PER_SEC);
> > +     if (tem > period_val)
> > +             return -EINVAL;
>
> if (tem > period_val)
>         tem =3D period_val;
>
> > +     hlperiod_val =3D period_val - (u32)tem;
>
> Wrong rounding I think. Did you test your driver with PWM_DEBUG enabled?

ditto.

>
> > +     regmap_write(priv->map, PWM_CV1800_PERIOD(pwm->hwpwm), period_val=
);
> > +     regmap_write(priv->map, PWM_CV1800_HLPERIOD(pwm->hwpwm), hlperiod=
_val);
> > +
> > +     cv1800_pwm_enable(chip, pwm, state->enabled);
> > +
> > +     return 0;
> > +}
> > +
> > +static int cv1800_pwm_get_state(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> > +                             struct pwm_state *state)
> > +{
> > +     struct cv1800_pwm *priv =3D to_cv1800_pwm_dev(chip);
> > +     u32 period_val, hlperiod_val;
> > +     u64 period_ns =3D 0;
> > +     u64 duty_ns =3D 0;
> > +     u32 enable =3D 0;
> > +     u32 polarity =3D 0;
> > +
> > +     regmap_read(priv->map, PWM_CV1800_PERIOD(pwm->hwpwm), &period_val=
);
> > +     regmap_read(priv->map, PWM_CV1800_HLPERIOD(pwm->hwpwm), &hlperiod=
_val);
> > +
> > +     if (period_val !=3D PWM_CV1800_PERIOD_RESET ||
> > +         hlperiod_val !=3D PWM_CV1800_HLPERIOD_RESET) {
> > +             period_ns =3D DIV_ROUND_UP_ULL(period_val * NSEC_PER_SEC,
> > +                                          priv->clk_rate);
> > +             duty_ns =3D DIV_ROUND_UP_ULL(hlperiod_val * period_ns, pe=
riod_val);
> > +
> > +             regmap_read(priv->map, PWM_CV1800_START, &enable);
> > +             enable &=3D PWM_CV1800_START_MASK(pwm->hwpwm);
> > +
> > +             regmap_read(priv->map, PWM_CV1800_POLARITY, &polarity);
> > +             polarity &=3D PWM_CV1800_POLARITY_MASK(pwm->hwpwm);
> > +     }
> > +
> > +     state->period =3D period_ns;
> > +     state->duty_cycle =3D duty_ns;
> > +     state->enabled =3D enable;
> > +     state->polarity =3D polarity ? PWM_POLARITY_INVERSED : PWM_POLARI=
TY_NORMAL;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct pwm_ops cv1800_pwm_ops =3D {
> > +     .apply =3D cv1800_pwm_apply,
> > +     .get_state =3D cv1800_pwm_get_state,
> > +};
> > +
> > +static void devm_clk_rate_exclusive_put(void *data)
> > +{
> > +     struct clk *clk =3D data;
> > +
> > +     clk_rate_exclusive_put(clk);
> > +}
> > +
> > +static int cv1800_pwm_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct cv1800_pwm *priv;
> > +     struct pwm_chip *chip;
> > +     void __iomem *base;
> > +     int ret;
> > +
> > +     chip =3D devm_pwmchip_alloc(dev, PWM_CV1800_CHANNELS, sizeof(*pri=
v));
> > +     if (!chip)
> > +             return PTR_ERR(chip);
> > +     priv =3D to_cv1800_pwm_dev(chip);
> > +
> > +     base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(base))
> > +             return PTR_ERR(base);
> > +
> > +     priv->map =3D devm_regmap_init_mmio(&pdev->dev, base,
> > +                                       &cv1800_pwm_regmap_config);
> > +     if (IS_ERR(priv->map))
> > +             return PTR_ERR(priv->map);
> > +
> > +     priv->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> > +     if (IS_ERR(priv->clk))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk),
> > +                                  "clk not found\n");
> > +
> > +     ret =3D clk_rate_exclusive_get(priv->clk);
>
> There is a devm_clk_rate_exclusive_get() in next. Please make use of it.
> (See commit b0cde62e4c54)

I will use this branch.

>
> > +     if (ret)
> > +             return dev_err_probe(&pdev->dev, ret,
> > +                                  "failed to get exclusive rate\n");> =
> +
> > +     ret =3D devm_add_action_or_reset(&pdev->dev, devm_clk_rate_exclus=
ive_put,
> > +                                    priv->clk);
> > +     if (ret) {
> > +             clk_rate_exclusive_put(priv->clk);
> > +             return ret;
> > +     }
> > +
> > +     priv->clk_rate =3D clk_get_rate(priv->clk);
> > +     if (!priv->clk_rate)
> > +             return dev_err_probe(&pdev->dev, -EINVAL,
> > +                                  "Invalid clock rate: %lu\n",
> > +                                  priv->clk_rate);
> > +
> > +     chip->ops =3D &cv1800_pwm_ops;
> > +
> > +     return devm_pwmchip_add(dev, chip);
>
> Error message if devm_pwmchip_add() fails, please.

I will fix it.

Thank you for your reply.

Best regards
Jingbao Qiu


Return-Path: <linux-kernel+bounces-82710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD4C868869
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C304B1F24728
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA86651C23;
	Tue, 27 Feb 2024 04:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvHQPQS+"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31F44CDE5;
	Tue, 27 Feb 2024 04:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709009521; cv=none; b=HVOzlqaOs6MIbxE7yMHbSchWPWCchRu7af+7KeD5b4y8n0gJ8La50BwE2YdZrrTrXoWeDbtsCOtBVHPA0gCpLOomqVAsXkdAXvmufAUQHD4NF4mIjgz0oGtNEfrQaHngxKqpU8prsPiWlF1l1sgB18ED7kEY/zq8bmsQLjcT65g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709009521; c=relaxed/simple;
	bh=bb7IDBvYnYTLXVdfoQsTNaHEQp6t8xhwLjC4EJP9Tjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aot7A79q6+8az5zf9U3fhUsBdo0JvUpzOLNsJnN64VT1Opj8RRYMd01R6RWbpHF2E0H9EXQhzrESHLtXSbb0uew1j+TOh/EQyFsGupGE9rki4zKzCkJ3WxlJsxBv7ElOd4eQQ+b7Hp7wANBYfTGgW11nFzrQAxYr/XJ9MOBlI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvHQPQS+; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-595aa5b1fe0so2634764eaf.2;
        Mon, 26 Feb 2024 20:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709009519; x=1709614319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zE5mwUY2kxnMy1ce6X1e9LPutT5zaNbvOrLFJUpCu+w=;
        b=WvHQPQS+mrfoIKy3K0BEI21tQEHYLIwKxyrbPbRwNrwiQgJQaePNHH1m77gW3X4VQX
         WBcg3Wn+nt5h2qbAYvMli5LbORZya0EdpmymJazjJKF2INW1aHrL1ZTWUdAHL/s+vOCs
         PTMBj+iKAtx810SZKwuTWS4Xi/Zxl5Xs12xll6u2jYeNH+AmCt8qzD/lBRhTLy3AuDoo
         nmJIqMpahoH7TYn3FoDfj3f3JHBoPg2MHU6De2euxKb7mrhSWQDrxGiZD4CDZt/hWZrm
         IpJ7mf+AIUTgHHTTEtiUHxVUMIGb51bnNsWNVbfgim91x4w/j7lTRHKI8n87+Zr9XphN
         Q4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709009519; x=1709614319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zE5mwUY2kxnMy1ce6X1e9LPutT5zaNbvOrLFJUpCu+w=;
        b=BSiRrVX5irEXv0UVJlkEwbekMpTymGabQHSTv9SgK4e0RwlkwONSWGAHAKdTMLeS60
         AhqEqnuG1gqo+n/aMpwzfRzisvCnTlwHCIj+jXLymG8kUzPAaYvCi+nO07nn4f7Mb+mH
         klVSlMcUGEot/PBPQzhn9gs/i4MgidE5U3ycyL54Obmu4qyHp+hHwxtPJ3+1jaQjFM5M
         v6jUx4r5KujjOFj+Hxy3el1jHqN6J9kJYRQfc4ch10G8xebQV1JC5ZnvaGWmcSyR8qvy
         fOD/1VGQQCuODblC7dvA4ZgfQhDkAoZr/Fx1eVJfdUR0qPljzqNz21fKtHVwH7gt/Lka
         f1qw==
X-Forwarded-Encrypted: i=1; AJvYcCVIraOrbJ+5x0uUH3RoThxBDeYZ1yLbhufMmbfqxd6zrBiV1kPQOk1s/P3cMDx4pXdBq3MYHSG/afCfJt1z6l12uEl+QhrkViRd/O5Bapy7PfinnF+/rLVfB1nZ8FMUsvVFZ9idG3Cy8nMbgsMsjmNmmMATRbxkBYlC+UKkIDXGIzEvkw==
X-Gm-Message-State: AOJu0Yxqz2lCu+dVtQL/YMQt8ZGH5SjUIk7XuySb1VDUbixAdq5M+caY
	kGrkXSOgkKGef+r6w3zrKAPGBrHBYo3Z7Bz2fSkKRF+2582XpQUKLj5ttjHDsrvyLLNVZhYTfU3
	3LUpLtQbK1nbJEQMJ/Kn5PgtMzWg=
X-Google-Smtp-Source: AGHT+IGDbMqkEgW6bRiZYuQLHcudPV4PGzgFn2nuJmexyQMX13jBuWZlteFtSEXn5R3zyobW2zUWfFFgX5OgvfgEkBI=
X-Received: by 2002:a4a:3c5a:0:b0:5a0:b06a:ce10 with SMTP id
 p26-20020a4a3c5a000000b005a0b06ace10mr561599oof.0.1709009518818; Mon, 26 Feb
 2024 20:51:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223082014.109385-1-qiujingbao.dlmu@gmail.com>
 <20240223082632.109767-1-qiujingbao.dlmu@gmail.com> <ZdyZ8SvqbpllDDeY@xhacker>
In-Reply-To: <ZdyZ8SvqbpllDDeY@xhacker>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Tue, 27 Feb 2024 12:51:47 +0800
Message-ID: <CAJRtX8TmGWWh1yPzOB5im=r3GYxrfzwiEo1jr2=t4LosrckV0g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
To: Jisheng Zhang <jszhang@kernel.org>
Cc: u.kleine-koenig@pengutronix.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 10:15=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org>=
 wrote:
>
> On Fri, Feb 23, 2024 at 04:26:32PM +0800, Jingbao Qiu wrote:
> > Implement the PWM driver for CV1800.
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> >  drivers/pwm/Kconfig      |  10 ++
> >  drivers/pwm/Makefile     |   1 +
> >  drivers/pwm/pwm-cv1800.c | 259 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 270 insertions(+)
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
> > index 000000000000..da1309dc0091
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-cv1800.c
> > @@ -0,0 +1,259 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * pwm-cv1800.c: PWM driver for Sophgo cv1800
> > + *
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
> > +#define PWM_CV1800_HLPERIOD_BASE 0x00
> > +#define PWM_CV1800_PERIOD_BASE 0x04
> > +#define PWM_CV1800_PWM_CV1800_POLARITY 0x40
> > +#define PWM_CV1800_START 0x44
> > +#define PWM_CV1800_DONE 0x48
> > +#define PWM_CV1800_UPDATE 0x4c
> > +#define PWM_CV1800_OE 0xd0
> > +
> > +#define PWM_CV1800_HLPERIOD(n) (PWM_CV1800_HLPERIOD_BASE + ((n) * 0x08=
))
> > +#define PWM_CV1800_PERIOD(n) (PWM_CV1800_PERIOD_BASE + ((n) * 0x08))
> > +
> > +#define PWM_CV1800_UPDATE_MASK(n) (BIT(0) << (n))
> > +#define PWM_CV1800_OE_MASK(n) (BIT(0) << (n))
> > +#define PWM_CV1800_START_MASK(n) (BIT(0) << (n))
> > +
> > +#define PWM_CV1800_MAXPERIOD (BIT(30) - 1)
> > +#define PWM_CV1800_MINPERIOD BIT(1)
> > +#define PWM_CV1800_MINHLPERIOD BIT(0)
> > +#define PWM_CV1800_PERIOD_RESET BIT(1)
> > +#define PWM_CV1800_HLPERIOD_RESET BIT(0)
> > +#define PWM_CV1800_REG_DISABLE 0x0U
> > +#define PWM_CV1800_REG_ENABLE(n) (BIT(0) << (n))
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
>
> what's the reason of using regmap?

This hardware has 4 channels, which means there may be
multiple PWM channels working simultaneously. These PWM
channels  share some registers, such as PWMSTART, POLARITY.
So I use regmap.

>
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
> > +             regmap_update_bits(priv->map, PWM_CV1800_OE,
>
> I believe this isn't correct.
> TRM says setting OE as 1 means output enable, while 0 means input.
> So I guess the controller may support pwm capture, but I didn't
> get too much information about pwm capture of the controller from
> the TRM, so can you please check and implement the .capture hook
> if it's supported?

you're right, the value of the OE register in the. apply function is always=
 1.
I need to modify the value of the PWMSTART register and check the OE
register value. In addition, I will contact the hardware designers regardin=
g
the input mode of PWM hardware and will add support for the .capture
feature after submitting this version

>
> > +                                PWM_CV1800_OE_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> > +             regmap_update_bits(priv->map, PWM_CV1800_START,
> > +                                PWM_CV1800_START_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> > +     } else if (pwm_enable && !enable) {
> > +             regmap_update_bits(priv->map, PWM_CV1800_OE,
>
> ditto
>
> > +                                PWM_CV1800_OE_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_DISABLE);
> > +             regmap_update_bits(priv->map, PWM_CV1800_START,
> > +                                PWM_CV1800_START_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_DISABLE);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int cv1800_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> > +                         const struct pwm_state *state)
> > +{
> > +     struct cv1800_pwm *priv =3D to_cv1800_pwm_dev(chip);
> > +     u32 period_val, hlperiod_val;
> > +     u64 tem;
> > +
> > +     if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +             return -EINVAL;
>
> This is wrong. Per the TRM, The POLARITY(offset 0x040) reg can set the
> polarity, so both PWM_POLARITY_NORMAL and PWM_POLARITY_INVERSED are suppo=
rted.
>

you're right, because POLARITY defaults to low-level output, HLPERIOD
represents the
number of low-level beats, which has been taken into account in the.
apply calculation
process. For the sake of simplicity, I simply believe that he is
PWM-POLARITY-NORMAL.
 I will add support for polarity in the next version.

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
> > +      * The meaning of HLPERIOD is the number of low-level cycles in P=
ERIOD.
> > +      * HLPERIOD =3D PERIOD - rate(MHz) / duty(MHz)
> > +      * HLPERIOD =3D PERIOD - (duty(ns) * rate(Hz) / NSEC_PER_SEC)
> > +      */
> > +     tem =3D mul_u64_u64_div_u64(state->period, priv->clk_rate, NSEC_P=
ER_SEC);
> > +     if (tem < PWM_CV1800_MINPERIOD)
> > +             return -EINVAL;
> > +
> > +     if (tem > PWM_CV1800_MAXPERIOD)
> > +             tem =3D PWM_CV1800_MAXPERIOD;
> > +
> > +     period_val =3D (u32)tem;
> > +
> > +     tem =3D mul_u64_u64_div_u64(state->duty_cycle, priv->clk_rate,
> > +                               NSEC_PER_SEC);
> > +     if (tem > period_val)
> > +             return -EINVAL;
> > +     hlperiod_val =3D period_val - (u32)tem;
> > +
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
> > +
> > +     regmap_read(priv->map, PWM_CV1800_PERIOD(pwm->hwpwm), &period_val=
);
> > +     regmap_read(priv->map, PWM_CV1800_HLPERIOD(pwm->hwpwm), &hlperiod=
_val);
> > +
> > +     if (period_val !=3D PWM_CV1800_PERIOD_RESET ||
> > +         hlperiod_val !=3D PWM_CV1800_HLPERIOD_RESET) {
> > +             period_ns =3D DIV_ROUND_UP_ULL(period_val * NSEC_PER_SEC,=
 priv->clk_rate);
> > +             duty_ns =3D DIV_ROUND_UP_ULL(hlperiod_val * period_ns, pe=
riod_val);
> > +
> > +             regmap_read(priv->map, PWM_CV1800_START, &enable);
> > +
> > +             enable &=3D PWM_CV1800_START_MASK(pwm->hwpwm);
> > +     }
> > +
> > +     state->period =3D period_ns;
> > +     state->duty_cycle =3D duty_ns;
> > +     state->enabled =3D enable;
> > +     state->polarity =3D PWM_POLARITY_NORMAL;
>
> This is not correct, see above.
>
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
> > +     chip =3D devm_pwmchip_alloc(dev, 4, sizeof(*priv));
>
> it's better to replace magic "4" with proper macro.

Yes, that's a good idea.

Best regards
Jingbao Qiu


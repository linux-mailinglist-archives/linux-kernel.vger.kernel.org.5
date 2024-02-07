Return-Path: <linux-kernel+bounces-56157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 035A184C6C7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283FC1C21E94
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF9720B04;
	Wed,  7 Feb 2024 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4U7p3gC"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC1A208D4;
	Wed,  7 Feb 2024 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296373; cv=none; b=dAOECu7ov9xA4K1mfBUwuc1RHsSWgvArYG8kYmkjsTTUzEUXgyzyKFh6PH3pHwTWvgANtOgFOEa9LPniHK6ztNgQgsCeu6t+LvLd+q/HJv6I4PK6116+zuEiAsUOLRO/qGnoCe3jqYi+WFPm9rjqFaIEKurokSTnUTHJRRqVDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296373; c=relaxed/simple;
	bh=CSQ/u77doQW2qekHRrcEyQeA4CFKX/Sm36zUsJY4x+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vB5qZT43Gm20EFConpytnx329qRUfjEvmd9CMQEKK1ydkuidcxb4rVhMo4c0TMS31LzZfVzjTjoqefVyWY0vqkACXvyDf4kNoZisA13oAZbY7rUDb6EAKZLYObzazMo4KEiqT/IqG5EI/uTszMrsjlgNDV8JD6K517XNZg2T9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4U7p3gC; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-595aa5b1fe0so219482eaf.2;
        Wed, 07 Feb 2024 00:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707296370; x=1707901170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3a5nyWObsVej84nV0Ic98sQxQ/BTjNnRYeXCAhBsoM=;
        b=k4U7p3gCeE41f+8XXqiAetGMXfAO0OCFqbMQ5GAQZibaSFT2/QwGrJhwTS9KU8mHno
         v/3coqvJQnNiA9Snh82zK6tLyMeW8wc1/TquHNfL7lva7Qgwl2XBMUDM9PIvN8pFxtQY
         6+xXWnzxSYsATHm47C2g8JU6HqswmCJTiMzZmGrZH7j5k/4WRcYbnIZESzdsjNj1rLdf
         Y2WdJbl/YcqVC+chr3a/NG3A/+DVA0QZeCvBA4zWFdCcmK4UcMF7d0kcoEEPE4QaFbK7
         7sj3OKZWpYFOImZG3SGOhDGYl/0NwkMTVz95/pZfcR/N/irzsa+868kVW6/xsTcVMAAz
         H3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707296370; x=1707901170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3a5nyWObsVej84nV0Ic98sQxQ/BTjNnRYeXCAhBsoM=;
        b=CCi08nTNO6K+4hu+F+Ny1FLKgSf+EiJ1eEX6YhfYP/04KAUdHALO7eemHv4d6gTpK/
         jdy9kgW+I3tlxi8t5bVVUPoMCNrDbmnMjVKHxl6Lg0j+Qy9LBi+VKPPleRukZjFYO2fC
         k1uIAMd9nqaU4oBobBzjA622GdGt1cGCizQYyrtNucqrRiHMJx8ZlXqAklLRIgL5QYps
         uAt7Drfv6Csf5TSl8UF7D2s1uGmZ9beDaWYn2gM7/ySbZiZ8Qnz7pggr9vS0E8qk6T5A
         ES8AZiziuCDYzdZJDUIAEWb7vfcvBPYatNsjLLym9UzTwGNCHeVxI/Uph2gKz7p2DO84
         F6zg==
X-Gm-Message-State: AOJu0YxZlR6rAyvqigjvpI22G4Ne/AuNggSAH4hpwM0+dKa/qgtnvV3N
	05yHU/iNSrKWAzsF7ebfdi6HU4y8wBR09VtFabs22o6WRNDtmztSEw+HVEiGWdO6TeKp8Z+wWuG
	LaWo2JemxDcYA2pkK4q13cMCoGtQ=
X-Google-Smtp-Source: AGHT+IG+c1XyKmfQroAsVGsV8n/I+1C6DF3dvFIBkMwBesVdm7jA2z/Ef8KaZYt5+nDRHbVpk4AK+xwEpLJ0s3jEHZE=
X-Received: by 2002:a4a:300e:0:b0:59c:2ab:511d with SMTP id
 q14-20020a4a300e000000b0059c02ab511dmr1141479oof.2.1707296369694; Wed, 07 Feb
 2024 00:59:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207055856.672184-1-qiujingbao.dlmu@gmail.com>
 <20240207060913.672554-1-qiujingbao.dlmu@gmail.com> <sgdzjoyabi7jf6h6lzrx6evl5g625ccczqgnyseeh24zauvqgp@dhad3txonq6a>
In-Reply-To: <sgdzjoyabi7jf6h6lzrx6evl5g625ccczqgnyseeh24zauvqgp@dhad3txonq6a>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Wed, 7 Feb 2024 16:59:18 +0800
Message-ID: <CAJRtX8TvoqWBg4qpQL+dnY_TqoaMZdnmYXVNwcASK+Zs4f0kNQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 4:39=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Jingbao,
>
> On Wed, Feb 07, 2024 at 02:09:13PM +0800, Jingbao Qiu wrote:
> > Implement the PWM driver for CV1800.
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> >  drivers/pwm/Kconfig      |  10 ++
> >  drivers/pwm/Makefile     |   1 +
> >  drivers/pwm/pwm-cv1800.c | 218 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 229 insertions(+)
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
> > index 000000000000..4d4f233c9087
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-cv1800.c
> > @@ -0,0 +1,218 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * rtc-cv1800.c: PWM driver for Sophgo cv1800 RTC
> > + *
> > + * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
>
> Please document the behaviour of the PWM here at the top of the driver.
> Things to mention are:
>
>  - How does the hardware behave on disable? (Usual behaviours include:
>    output of inactive state; freeze where it just happens to be; high-z)
>
>  - If you reconfigure the hardware, does it complete the previously
>    running period before emitting the new wave form?
>
>  - Are there possible glitches in .apply()? (i.e. can it happen, that
>    for a short moment a wave form is emitted that has the new period but
>    the old duty_cycle?)
>

Thanks, I will do that.

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
> > +#define HLPERIOD_BASE  0x00
> > +#define PERIOD_BASE    0x04
> > +#define POLARITY       0x040
> > +#define PWMSTART       0x044
> > +#define PWMDONE        0x048
> > +#define PWMUPDATE      0x4c
> > +#define PWM_OE         0xd0
> > +#define HLPERIOD_SHIFT 0x08
> > +#define PERIOD_SHIFT   0x08
> > +
> > +#define HLPERIOD(n)    (HLPERIOD_BASE + ((n) * HLPERIOD_SHIFT))
> > +#define PERIOD(n)      (PERIOD_BASE + ((n) * PERIOD_SHIFT))
> > +#define UPDATE(n)      (BIT(0) << (n))
> > +#define OE_MASK(n)     (BIT(0) << (n))
> > +#define START_MASK(n)  (BIT(0) << (n))
> > +
> > +#define PERIOD_RESET   0x02
> > +#define HLPERIOD_RESET 0x1
> > +#define REG_DISABLE    0x0U
> > +#define REG_ENABLE     BIT(0)
>
> Please use a driver specific prefix for all these defines.
>

I will do that.

> > +struct soc_info {
> > +     unsigned int num_pwms;
> > +};
> > +
> > +struct cv1800_pwm {
> > +     struct pwm_chip chip;
> > +     struct regmap *map;
> > +     struct clk *clk;
> > +};
> > +
> > +static inline struct cv1800_pwm *to_cv1800_pwm_dev(struct pwm_chip *ch=
ip)
> > +{
> > +     return container_of(chip, struct cv1800_pwm, chip);
> > +}
> > +
> > +static int cv1800_pwm_enable(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > +                          u32 enable)
>
> This is called with the enable parameter set to state->enabled which is
> a bool. Please use a bool here, too, instead of a u32.
>

Thanks, I will use bool instead of a u32.

> > +{
> > +     struct cv1800_pwm *priv =3D to_cv1800_pwm_dev(chip);
> > +     u32 pwm_enable;
> > +
> > +     regmap_read(priv->map, PWMSTART, &pwm_enable);
> > +     pwm_enable >>=3D pwm->hwpwm;
>
> I don't understand why this value is shifted here. I guess this misses a
> mask?

The nth bit of this register represents the running state, so a shift
representation is required.
I will use macro definitions to represent masks.

>
> > +     if (enable)
> > +             clk_prepare_enable(priv->clk);
> > +     else
> > +             clk_disable_unprepare(priv->clk);
>
> This is broken. It might well happen that the first call to .apply() has
> state->enabled =3D false. Please make sure to properly balance clk
> enabling.
>

I will fix it.

> > +     /*
> > +      * If the parameters are changed during runtime, Register needs
> > +      * to be updated to take effect.
> > +      */
> > +     if (pwm_enable) {
> > +             regmap_update_bits(priv->map, PWMUPDATE, UPDATE(pwm->hwpw=
m),
> > +                                REG_ENABLE << pwm->hwpwm);
> > +             regmap_update_bits(priv->map, PWMUPDATE, UPDATE(pwm->hwpw=
m),
> > +                                REG_DISABLE << pwm->hwpwm);
>
> REG_DISABLE is zero. Why is this shifted? Very strange.

The data manual states that for dynamic updates, for the nth bit of
this register
write one first and then write 0.
you're right, just 0 or BIT(n) is ok.

>
> > +     } else {
> > +             regmap_update_bits(priv->map, PWM_OE, OE_MASK(pwm->hwpwm)=
,
> > +                                enable << pwm->hwpwm);
> > +             regmap_update_bits(priv->map, PWMSTART, START_MASK(pwm->h=
wpwm),
> > +                                enable << pwm->hwpwm);
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
> > +     u64 period_ns, duty_ns;
> > +     u32 period_val, hlperiod_val;
> > +     unsigned long long rate, div;
> > +
> > +     period_ns =3D state->period;
> > +     duty_ns =3D state->duty_cycle;
> > +
> > +     rate =3D (unsigned long long)clk_get_rate(priv->clk);
>
> This cast has no effect, so please drop it. To prevent that the clock
> changes rate while the PWM is running, please use
> clk_rate_exclusive_get().

I will fix it.

>
> > +     div =3D rate * period_ns;
>
> This might overflow. Please use mul_u64_u64_div_u64() or one of its
> variants and error out on rate > NSEC_PER_SEC. (There are other pwm
> drivers that make it right, took a look into these if this is unclear.)
>

Thanks, I will do that.

> > +     do_div(div, NSEC_PER_SEC);
> > +     period_val =3D div;
> > +
> > +     div =3D rate * (period_ns - duty_ns);
> > +     do_div(div, NSEC_PER_SEC);
> > +     hlperiod_val =3D div;
>
> I think it can happen here, that div it too big to fit into this u32.

you're right, I will fix it.

>
> > +     regmap_write(priv->map, PERIOD(pwm->hwpwm), period_val);
> > +     regmap_write(priv->map, HLPERIOD(pwm->hwpwm), hlperiod_val);
> > +
> > +     cv1800_pwm_enable(chip, pwm, state->enabled);
> > +
> > +     return 0;
> > +}
> > +
> > +static int cv1800_pwm_get_state(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> > +                              struct pwm_state *state)
> > +{
> > +     struct cv1800_pwm *priv =3D to_cv1800_pwm_dev(chip);
> > +     u32 period_val, hlperiod_val, tem;
> > +     u64 rate;
> > +     u64 period_ns =3D 0;
> > +     u64 duty_ns =3D 0;
> > +     u32 enable =3D 0;
> > +
> > +     regmap_read(priv->map, PERIOD(pwm->hwpwm), &period_val);
> > +     regmap_read(priv->map, HLPERIOD(pwm->hwpwm), &hlperiod_val);
> > +
> > +     if (period_val !=3D PERIOD_RESET || hlperiod_val !=3D HLPERIOD_RE=
SET) {
> > +             rate =3D (u64)clk_get_rate(priv->clk);
> > +
> > +             tem =3D NSEC_PER_SEC * period_val;
>
> This might overflow.

I will fix it.

>
> > +             do_div(tem, rate);
> > +             period_ns =3D tem;
>
> This uses wrong rounding. If you enabled PWM_DEBUG during your tests,
> this should be catched and logged.

I will fix it.

>
> > +
> > +             tem =3D period_val * period_ns;
> > +             do_div(tem, hlperiod_val);
> > +             duty_ns =3D tem;
> > +
> > +             regmap_read(priv->map, PWMSTART, &enable);
> > +             enable >>=3D pwm->hwpwm;
>
> Again a missing mask??

Yes, I will use a mask.

>
> > +     }
> > +
> > +     state->period =3D period_ns;
> > +     state->duty_cycle =3D duty_ns;
> > +     state->enabled =3D enable;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct pwm_ops cv1800_pwm_ops =3D {
> > +     .apply =3D cv1800_pwm_apply,
> > +     .get_state =3D cv1800_pwm_get_state,
> > +};
> > +
> > +static const struct regmap_config cv1800_pwm_regmap_config =3D {
> > +     .reg_bits =3D 32,
> > +     .val_bits =3D 32,
> > +     .reg_stride =3D 4,
> > +};
> > +
> > +static int cv1800_pwm_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct cv1800_pwm *cv_pwm;
>
> Please pick always the same name for your driver private variable. In
> the other functions it is called "priv".

I will fix it.

>
> > +     void __iomem *base;
> > +     const struct soc_info *info;
> > +
> > +     info =3D device_get_match_data(dev);
> > +     if (!info)
>
> error message please.

I will fix it.

>
> > +             return -EINVAL;
> > +
> > +     cv_pwm =3D devm_kzalloc(dev, sizeof(*cv_pwm), GFP_KERNEL);
> > +     if (!cv_pwm)
> > +             return -ENOMEM;
> > +
> > +     base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(base))
> > +             return PTR_ERR(base);
> > +
> > +     cv_pwm->map =3D devm_regmap_init_mmio(&pdev->dev, base,
> > +                                         &cv1800_pwm_regmap_config);
> > +     if (IS_ERR(cv_pwm->map))
> > +             return PTR_ERR(cv_pwm->map);
> > +
> > +     cv_pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +     if (IS_ERR(cv_pwm->clk))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(cv_pwm->clk),
> > +                                  "clk not found\n");
> > +
> > +     cv_pwm->chip.dev =3D dev;
> > +     cv_pwm->chip.ops =3D &cv1800_pwm_ops;
> > +     cv_pwm->chip.npwm =3D info->num_pwms;
>
> Missing clk handling here. Please all clk_prepare_enable once for each
> running channel.

I will fix it.

>
> > +     return devm_pwmchip_add(dev, &cv_pwm->chip);
> > +}
> > +
> > +static const struct soc_info cv1800b_soc_info =3D {
> > +     .num_pwms =3D 4,
> > +};
>
> Until you support more variants, I suggest to just hardcode npwm to
> four.

I will do that.

>
> > +static const struct of_device_id cv1800_pwm_dt_ids[] =3D {
> > +     { .compatible =3D "sophgo,cv1800-pwm", .data =3D &cv1800b_soc_inf=
o },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, cv1800_pwm_dt_ids);
> > +
> > +static struct platform_driver cv1800_pwm_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "cv1800-pwm",
> > +             .of_match_table =3D cv1800_pwm_dt_ids,
> > +     },
> > +     .probe =3D cv1800_pwm_probe,
> > +};
> > +module_platform_driver(cv1800_pwm_driver);
> > +
> > +MODULE_ALIAS("platform:cv1800-pwm");
>
> I'm with Krzysztof here, this shouldn't be needed.

I will drop it.

>
> > +MODULE_AUTHOR("Jingbao Qiu");
> > +MODULE_DESCRIPTION("Sophgo cv1800 RTC Driver");
> > +MODULE_LICENSE("GPL");
>

Best regards
Jingbao Qiu


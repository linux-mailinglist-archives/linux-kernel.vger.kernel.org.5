Return-Path: <linux-kernel+bounces-50240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7740684762B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A89284DAA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C72814A4FF;
	Fri,  2 Feb 2024 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3/SbndH"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22D014A4D7;
	Fri,  2 Feb 2024 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895146; cv=none; b=NcFqcrXSvo5u1qntBW5je4cag2UgVknYJ1oBAJEENEXnIxFpt0o34H1dyu/gJwp32ir/HLBfH3QtW1gy426j2EZAcvV4ZqUNgNpl1LWTyzjVy/jRAq3vVLOwa7H2MUV93dM4B+wEEy3ijnO45Dfc32YutSZ7+w50PK+bLiDxu0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895146; c=relaxed/simple;
	bh=hCuJY8JbZYMLQId+jf9w+DWlURO1hCfAJLAdqizCnVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ktEXxOWhKb4+oVcQRXXda2Btux443/fNQUvMMYK7riQMdWP2BAX8e8iVSevH88wdJ+XENxabNAVWkcP3BVSa+lE6f/vsXl5INxTN6W+rAPDJmoXWfiLyayToiRk75AmH+BJ4wvKBV0LwpxnUxW0vNAkRANbGpnYvEChgS8H9/d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3/SbndH; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so3199494a12.0;
        Fri, 02 Feb 2024 09:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706895143; x=1707499943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCuJY8JbZYMLQId+jf9w+DWlURO1hCfAJLAdqizCnVM=;
        b=a3/SbndHx4s2vS66vbiBswnpjgtAZaK1YKVhFsOS/lgfeUu65IU5eYViUTTc5KrIxY
         L8cjtyG7eH6JoY88BoCjhRJiH2/KpRG3jSJOBEYVVZfBmNO1UKEdw4WznuQCvF1FS+7b
         MXa6EMg66RjD8lAkhrk4mCzXIKNsw+HZ5Q1VVIsz6MHp1GHxaiu7xIpxe0zATvVzmdYG
         Rt4q9meFkfx5yn3Q2q32excCckOL6gx7xsS3q7I8pVKVBBXmLVwmV/BJNBJgdtzoN8Dw
         2t2sdwc1WyPzQgdJR78vLHjEKx7KG8sDQ+T9T1mR6etBQio9d7kmMK63j6X5Umc5qYsl
         wPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895143; x=1707499943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCuJY8JbZYMLQId+jf9w+DWlURO1hCfAJLAdqizCnVM=;
        b=pAaq6AZMOVQHs/NkpWRfVqVsFY72sa4HnTjYsbm7LHyqmKigq5cedkiX8NEGgucQTE
         +raMGJTBHUHyQjTxNG6ByndOyftWhRePH/teKIC7rr85zBqa54O+/vUr28sEACQ01ZiY
         4zlZemI+VOaJL5wAUNSsKGItzHeb/CHzU/Ej+aY/HUGFidZzvrLQaolOaNSih2Ofleg7
         Z1Q1306oBtj/0wfYYyb7Ayu20jtLovThdgfZ9YxpjqmFRxbo4yTdwrq2cjOOALWOkO7L
         S+AMHSESjuH091WlchL64uUOrZSi5ORzylcAaxHVbBvpBkyE8VzcCjLfh4VjHKohHw+v
         HtVg==
X-Gm-Message-State: AOJu0YxGBZyAt5yhrFbbKtTG3XSo31jFzBXrZ9x3g+zmQMwEHawom6Ft
	OsX1eo6QywSLWbjafTIkuWmZ47fH+zuXHY3gS8+814syVMwEBxmO
X-Google-Smtp-Source: AGHT+IFtyRLBfZV+uWVH6iHqj3/XqfutBo0nPCLJ5UMNsLGPgcsFp21obzxxFm+Lz0KYhQytdxOgTQ==
X-Received: by 2002:a17:906:e246:b0:a36:598b:e291 with SMTP id gq6-20020a170906e24600b00a36598be291mr6387969ejb.26.1706895142983;
        Fri, 02 Feb 2024 09:32:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUhjFYs0/6tnnBIWwWeMIWHNsUdBtWYrqrABkSHq7Ko6SYOD8Wf2PlaIY+492XsxIKsvnKd7DAtW/BTSRXX5Rnz+xZ+hOh4PsUC+sbfNFaXUHhx6+DKZJOQljy4705fcHr57QOABSOo/qoMvTBgOExl75PC4D3YxnG8wo5wamnNUtz/T7bRAvz1A5DWIsMsP9oGbHcuKzPaV4MKTm9HQyPk1LqKL6bWvIdx77qX0FrH0jATlLgYSAsmkxmHQADMy6rsWoXK1emsy45isaQQsw4UbgX+daXL/emFlm/8PKou5y+OcJIGR+GaHpVehKMVzpnVI9pytTVyg/PpIk1HyflUgVAELKaDIswkihqMaj58i+LgH5DyCBbHfTPWQSoImoLUfzE9aHCGJC+NzvKYqgU/bni/t4zQ3/YJVSIwbgtiSrzEc9uyRkQD7dXmfPGzcQXflSRLjcSDL64OqAnrziWnt4EfOc9Cz73Ox/FrOMA9arIr+VJcyOPiwNBcFBpUPffryZ8FNFUQk2ZFTTbzTSzLpAGuKjTmZitLfTY62vXSr34NcTSW6PE8v3hSguU6SseSjSuHTaS041ncXFcMg+r+JhSrkk9aT9YTfJEsnE6udK8lMYJjVnrVDjbCbg+6seV8MhDvk0ByJqHz5t492G7sVAFbTN+hBPJdGpaAirGrhQmDTli/uCG3ZkXeY4lG1L0Fj5hxnba+E/z45WFkU+qqts814ardiAGqreKUWcH2Ljfzlcb1sJfx+pYnB/4DadJWqaVBv49gbA==
Received: from localhost.localdomain ([154.72.163.111])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906180c00b00a356c0fdd2csm1076487eje.26.2024.02.02.09.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:32:22 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: u.kleine-koenig@pengutronix.de
Cc: aou@eecs.berkeley.edu,
	bigunclemax@gmail.com,
	conor+dt@kernel.org,
	contact@jookia.org,
	cristian.ciocaltea@collabora.com,
	devicetree@vger.kernel.org,
	fusibrandon13@gmail.com,
	jernej.skrabec@gmail.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	mkl@pengutronix.de,
	p.zabel@pengutronix.de,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	privatesub2@gmail.com,
	robh+dt@kernel.org,
	samuel@sholland.org,
	wens@csie.org
Subject: Re: [PATCH v8 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
Date: Fri,  2 Feb 2024 18:32:01 +0100
Message-Id: <20240202173201.2564726-1-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <eynkbikmzcffid2jft3b6pmjfcbvda6mpzu7l5mefrw3za3iwh@ctgn57kb7ard>
References: <eynkbikmzcffid2jft3b6pmjfcbvda6mpzu7l5mefrw3za3iwh@ctgn57kb7ard>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Feb 1, 2024 at 9:49 AM Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
>
> hello Aleksandr,
>
> On Wed, Jan 31, 2024 at 03:59:15PM +0300, Aleksandr Shubin wrote:
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
>
> Some time ago there was some effort by Rob Herring to detangle the
> headers platform_device.h, of_device.h and of.h. See for example commit
> 87e51b76c9db8c29cde573af0faf5a3e13e23960. I think you should use
> linux/of.h instead of linux/of_device.h.
>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/reset.h>
> > +
> > +#define SUN20I_PWM_CLK_CFG(chan)             (0x20 + (((chan) >> 1) * 0x4))
> > +#define SUN20I_PWM_CLK_CFG_SRC                       GENMASK(8, 7)
> > +#define SUN20I_PWM_CLK_CFG_DIV_M             GENMASK(3, 0)
> > +#define SUN20I_PWM_CLK_DIV_M_MAX             8
>
> SUN20I_PWM_CLK_CFG_DIV_M_MAX?
>

Yes. The manuals mark [0x9, 0xF] as reserved

> > +#define SUN20I_PWM_CLK_GATE                  0x40
> > +#define SUN20I_PWM_CLK_GATE_BYPASS(chan)     BIT((chan) + 16)
> > +#define SUN20I_PWM_CLK_GATE_GATING(chan)     BIT(chan)
> > +
> > +#define SUN20I_PWM_ENABLE                    0x80
> > +#define SUN20I_PWM_ENABLE_EN(chan)           BIT(chan)
> > +
> > +#define SUN20I_PWM_CTL(chan)                 (0x100 + (chan) * 0x20)
> > +#define SUN20I_PWM_CTL_ACT_STA                       BIT(8)
> > +#define UN20I_PWM_CTL_PRESCAL_K              GENMASK(7, 0)
> > +#define SUN20I_PWM_CTL_PRESCAL_K_MAX         0xff
>
> This matches the theoretical maximum for GENMASK(7,0), so you could make
> use of field_max(SUN20I_PWM_CTL_PRESCAL_K) here.
>
> > +#define SUN20I_PWM_PERIOD(chan)                      (0x104 + (chan) * 0x20)
> > +#define SUN20I_PWM_PERIOD_ENTIRE_CYCLE               GENMASK(31, 16)
> > +#define SUN20I_PWM_PERIOD_ACT_CYCLE          GENMASK(15, 0)
> > +
> > +#define SUN20I_PWM_PCNTR_SIZE                        BIT(16)
> > +
> > +/**
> > + * SUN20I_PWM_MAGIC is used to quickly compute the values of the clock dividers
> > + * div_m (SUN20I_PWM_CLK_CFG_DIV_M) & prescale_k (SUN20I_PWM_CTL_PRESCAL_K)
> > + * without using a loop. These dividers limit the # of cycles in a period
> > + * to SUN20I_PWM_PCNTR_SIZE by applying a scaling factor of
> > + * 1/(div_m * (prescale_k + 1)) to the clock source.
> > + *
> > + * SUN20I_PWM_MAGIC is derived by solving for div_m and prescale_k
> > + * such that for a given requested period,
> > + *
> > + * i) div_m is minimized for any prescale_k ≤ SUN20I_PWM_CTL_PRESCAL_K_MAX,
> > + * ii) prescale_k is minimized.
> > + *
> > + * The derivation proceeds as follows, with val = # of cycles for reqested
>
> s/reqested/requested/

Nice catch.

> > + * period:
> > + *
> > + * for a given value of div_m we want the smallest prescale_k such that
> > + *
> > + * (val >> div_m) // (prescale_k + 1) ≤ 65536 (SUN20I_PWM_PCNTR_SIZE)
> > + *
> > + * This is equivalent to:
> > + *
> > + * (val >> div_m) ≤ 65536 * (prescale_k + 1) + prescale_k
> > + * ⟺ (val >> div_m) ≤ 65537 * prescale_k + 65536
> > + * ⟺ (val >> div_m) - 65536 ≤ 65537 * prescale_k
> > + * ⟺ ((val >> div_m) - 65536) / 65537 ≤ prescale_k
> > + *
> > + * As prescale_k is integer, this becomes
> > + *
> > + * ((val >> div_m) - 65536) // 65537 ≤ prescale_k
> > + *
> > + * And is minimized at
> > + *
> > + * ((val >> div_m) - 65536) // 65537
> > + *
> > + * Now we pick the smallest div_m that satifies prescale_k ≤ 255
> > + * (i.e SUN20I_PWM_CTL_PRESCAL_K_MAX),
> > + *
> > + * ((val >> div_m) - 65536) // 65537 ≤ 255
> > + * ⟺ (val >> div_m) - 65536 ≤ 255 * 65537 + 65536
> > + * ⟺ val >> div_m ≤ 255 * 65537 + 2 * 65536
> > + * ⟺ val >> div_m < (255 * 65537 + 2 * 65536 + 1)
> > + * ⟺ div_m = fls((val) / (255 * 65537 + 2 * 65536 + 1))
> > + *
> > + * Suggested by Uwe Kleine-König
>
> Good man, I assume this is all sane then :-)

Credit should be given where it is due :-)

> > + */
> > +#define SUN20I_PWM_MAGIC                     (255 * 65537 + 2 * 65536 + 1)
> > +
> > +struct sun20i_pwm_chip {
> > +     struct clk *clk_bus, *clk_hosc, *clk_apb0;
> > +     struct reset_control *rst;
> > +     struct pwm_chip chip;
> > +     void __iomem *base;
> > +     /* Mutex to protect pwm apply state */
> > +     struct mutex mutex;
> > +};
> > +
> > +static inline struct sun20i_pwm_chip *to_sun20i_pwm_chip(struct pwm_chip *chip)
> > +{
> > +     return container_of(chip, struct sun20i_pwm_chip, chip);
> > +}
> > +
> > +static inline u32 sun20i_pwm_readl(struct sun20i_pwm_chip *chip,
> > +                                unsigned long offset)
> > +{
> > +     return readl(chip->base + offset);
> > +}
> > +
> > +static inline void sun20i_pwm_writel(struct sun20i_pwm_chip *chip,
> > +                                  u32 val, unsigned long offset)
> > +{
> > +     writel(val, chip->base + offset);
> > +}
> > +
> > +static int sun20i_pwm_get_state(struct pwm_chip *chip,
> > +                             struct pwm_device *pwm,
> > +                             struct pwm_state *state)
> > +{
> > +     struct sun20i_pwm_chip *sun20i_chip = to_sun20i_pwm_chip(chip);
> > +     u16 ent_cycle, act_cycle, prescale_k;
> > +     u64 clk_rate, tmp;
> > +     u8 div_m;
> > +     u32 val;
> > +
> > +     mutex_lock(&sun20i_chip->mutex);
> > +
> > +     val = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_CFG(pwm->hwpwm));
> > +     div_m = FIELD_GET(SUN20I_PWM_CLK_CFG_DIV_M, val);
> > +     if (div_m > SUN20I_PWM_CLK_DIV_M_MAX)
> > +             div_m = SUN20I_PWM_CLK_DIV_M_MAX;
> > +
> > +     if (FIELD_GET(SUN20I_PWM_CLK_CFG_SRC, val) == 0)
> > +             clk_rate = clk_get_rate(sun20i_chip->clk_hosc);
> > +     else
> > +             clk_rate = clk_get_rate(sun20i_chip->clk_apb0);
> > +
> > +     val = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CTL(pwm->hwpwm));
> > +     state->polarity = (SUN20I_PWM_CTL_ACT_STA & val) ?
> > +                        PWM_POLARITY_NORMAL : PWM_POLARITY_INVERSED;
> > +
> > +     prescale_k = FIELD_GET(SUN20I_PWM_CTL_PRESCAL_K, val) + 1;
> > +
> > +     val = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_ENABLE);
> > +     state->enabled = (SUN20I_PWM_ENABLE_EN(pwm->hwpwm) & val) ? true : false;
> > +
> > +     val = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_PERIOD(pwm->hwpwm));
> > +
> > +     mutex_unlock(&sun20i_chip->mutex);
> > +
> > +     act_cycle = FIELD_GET(SUN20I_PWM_PERIOD_ACT_CYCLE, val);
> > +     ent_cycle = FIELD_GET(SUN20I_PWM_PERIOD_ENTIRE_CYCLE, val);
> > +
> > +     /*
> > +      * The duration of the active phase should not be longer
> > +      * than the duration of the period
> > +      */
> > +     if (act_cycle > ent_cycle)
> > +             act_cycle = ent_cycle;
> > +
> > +     tmp = ((u64)(act_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
> > +     state->duty_cycle = DIV_ROUND_UP_ULL(tmp, clk_rate);
> > +     tmp = ((u64)(ent_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
> > +     state->period = DIV_ROUND_UP_ULL(tmp, clk_rate);
>
> Please add a comment above this block that justifies assuming that the
> multiplication doesn't overflow. Something like:
>
>         We have act_cycle <= ent_cycle <= 0xffff, prescale_k <= 0x100,
>         div_m <= 8. So the multiplication fits into an u64 without
>         overflow.
>
> > +
> > +     return 0;
> > +}
> > +
> > +static int sun20i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +                         const struct pwm_state *state)
> > +{
> > +...
> > +}
>
> I didn't recheck all the logic in .apply in detail and will assume it is
> sane for this round.

Please do recheck. This thing is already on v8 and we want to make sure
everyone is happy with v9.

> > +static const struct pwm_ops sun20i_pwm_ops = {
> > +     .apply = sun20i_pwm_apply,
> > +     .get_state = sun20i_pwm_get_state,
> > +};
> > +
> > +static const struct of_device_id sun20i_pwm_dt_ids[] = {
> > +     { .compatible = "allwinner,sun20i-d1-pwm" },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(of, sun20i_pwm_dt_ids);
> > +
> > +static int sun20i_pwm_probe(struct platform_device *pdev)
> > +{
> > +     struct sun20i_pwm_chip *sun20i_chip;
> > +     int ret;
> > +
> > +     sun20i_chip = devm_kzalloc(&pdev->dev, sizeof(*sun20i_chip), GFP_KERNEL);
> > +     if (!sun20i_chip)
> > +             return -ENOMEM;
> > +
> > +     sun20i_chip->base = devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(sun20i_chip->base))
> > +             return PTR_ERR(sun20i_chip->base);
> > +
> > +     sun20i_chip->clk_bus = devm_clk_get_enabled(&pdev->dev, "bus");
> > +     if (IS_ERR(sun20i_chip->clk_bus))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_bus),
> > +                                  "failed to get bus clock\n");
> > +
> > +     sun20i_chip->clk_hosc = devm_clk_get_enabled(&pdev->dev, "hosc");
> > +     if (IS_ERR(sun20i_chip->clk_hosc))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_hosc),
> > +                                  "failed to get hosc clock\n");
> > +
> > +     sun20i_chip->clk_apb0 = devm_clk_get_enabled(&pdev->dev, "apb0");
> > +     if (IS_ERR(sun20i_chip->clk_apb0))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_apb0),
> > +                                  "failed to get apb0 clock\n");
> > +
> > +     sun20i_chip->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> > +     if (IS_ERR(sun20i_chip->rst))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->rst),
> > +                                  "failed to get bus reset\n");
> > +
> > +     ret = of_property_read_u32(pdev->dev.of_node, "allwinner,pwm-channels",
> > +                                &sun20i_chip->chip.npwm);
> > +     if (ret)
> > +             sun20i_chip->chip.npwm = 8;
> > +
> > +     if (sun20i_chip->chip.npwm > 16)
> > +             sun20i_chip->chip.npwm = 16;
>
> Is it worth to emit an error message here? Something like:
>
>         Limiting number of PWM lines from %u to 16
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |

Brandon.


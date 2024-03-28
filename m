Return-Path: <linux-kernel+bounces-122640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CE488FACD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21EDC1C2D2D2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13575F876;
	Thu, 28 Mar 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwxLd6NP"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD53EA7B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617046; cv=none; b=BFWmomVf9hPkxBd9IBfGK3zs/UA2K11GhcFoJpgGMg4Xhn3y9j5a3dO2bdwDIzsWTKySU352XljmLEO8SgQd2EkwbQK0d/bgS22FJiK7zGg0Rcx8wXtEQp6T3ufctH4BCgXBr0uBSCOJYw7hDlbRgSo4P3MCbOyPH19fP3XN+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617046; c=relaxed/simple;
	bh=zs1W41ONFASJqBRMmOeY3SJDp6Omt2dZKibNGDwafio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2e0HRDnLnPqzhPrP3dGIEFPPVXHMqlPy/W61EZYoO0R2GMSmxcIHdR8MK6u8RNNB+ob0HcUmr83t7vLkrcR8815tkPeDngPIURvfN2XMgPQM0ruCfCJiCiuwl4RGso1eNfyMfHceKP4DcQW1fQJHTY4BUZPmdK6/DGv8RmvOiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cwxLd6NP; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso597234276.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711617044; x=1712221844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KhmQXbbvltdCLYtd5UE/LLG4WE9XPPqX5yUaWcDs3Y=;
        b=cwxLd6NPI1eNzGiErfL1Q+YGBlrXLxHbmXr7q40B7o7s1K9F6dxP1vdxqijjATRvWE
         LBTvRHCKbiDti29VEwrYppEzu0/JS/rUmi9t6ef1ALLXGnwOkdOZjTpWN3UQHj+AHelN
         /SmboOk6pKD5MX8l5vKB16rFjfEKkIP9QJa04q0mlGhmOTuPClAKyFcPGmTn5wQi21vY
         Rbtpxoqvo2MK92ebPtTSgK/0sQJQI2htqiWOQ1d49X4B/FZawk1TDxyXY1AQuXqLhjKg
         36AzJA5Hvs6F9sqygkwl97MX28etdOojdjz8PryOHi9fBFWQZ7UUXyxhra61ljTTKPdU
         l57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711617044; x=1712221844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KhmQXbbvltdCLYtd5UE/LLG4WE9XPPqX5yUaWcDs3Y=;
        b=WN0g8o0iyhQ2W3XcsG1DzfxKZqrN7U9p7KSd0I1JgDQBtpIq9nF4uxDqReYpdxcwWk
         PEBJX90UWpnFxAntcl5fNDF+9wT3eDZV7dsKJ8CUlR8I74V2yDiY8rERK4h/ajN0JsJv
         EmlNjaviwiXp3tKus0tvCnnS/f68hhH2f9rBEwo+bK3dhsit5schhTxXA3PgjrUutW3S
         3BXT7lHugX4T1UJlcVVjZIciU/l1KiBkTdAdLFomdm66TlwoyhV+eJ9XoOGhgl3kMHUB
         0I+IUULoo/Z5ZRgkpwZnfjQFdWq08AAye+22z64kb/PSZ1AbFGcXgp0Gl3hiNaXZnikt
         Uthw==
X-Forwarded-Encrypted: i=1; AJvYcCU8ylxIR03+rVZTsJUY9UTyGg2UKYIi1uIRNprKUlpIbPVYnh4LtJ6bJoTrepu4chMc74tx3dD2pA4RE6Vt8OUW6smjOVNYQmZzVfkM
X-Gm-Message-State: AOJu0YwUAuY163xnSQaX/tPUK+gDn9wjDyCNaxYB7nBgqTNsKei1yGCt
	k+bCZBPX3X+5vj8xmLQwUGM+wzHrP1XwJXDNlq8x3t2mOFj+ngVXHoQsMbdBNNLJf7hHOSeqatB
	m5jBNz6ZBz2XV5fRGYbXUo+Q5dkGY2JljEc1ehA==
X-Google-Smtp-Source: AGHT+IE/An0AbYWd/vynrRp8DTmGveyGGpQEeSo55JBojQnvTdoXVkDFJynntDgoXapBblKZSyiQw6tIneF8Q5a7YVE=
X-Received: by 2002:a25:6c54:0:b0:dc7:140:8c0c with SMTP id
 h81-20020a256c54000000b00dc701408c0cmr2153996ybc.23.1711617043928; Thu, 28
 Mar 2024 02:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313035719.768469-1-ychuang570808@gmail.com> <20240313035719.768469-4-ychuang570808@gmail.com>
In-Reply-To: <20240313035719.768469-4-ychuang570808@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Mar 2024 10:10:33 +0100
Message-ID: <CACRpkdYnG+SgrgAWW8+qdiBwO5d+nE8g_31Evyw0pA2dXz3BPw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver
To: Jacky Huang <ychuang570808@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, j.neuschaefer@gmx.net, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ychuang3@nuvoton.com, schung@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jacky,

overall this looks very good.

On Wed, Mar 13, 2024 at 4:57=E2=80=AFAM Jacky Huang <ychuang570808@gmail.co=
m> wrote:


> From: Jacky Huang <ychuang3@nuvoton.com>
>
> Add common pinctrl and GPIO driver for Nuvoton MA35 series SoC, and
> add support for ma35d1 pinctrl.
>
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
(...)
> +static int ma35_pinmux_set_mux(struct pinctrl_dev *pctldev, unsigned int=
 selector,
> +                              unsigned int group)
> +{
> +       struct ma35_pinctrl *npctl =3D pinctrl_dev_get_drvdata(pctldev);
> +       struct ma35_pin_group *grp =3D &npctl->groups[group];
> +       struct ma35_pin_setting *setting =3D grp->settings;
> +       u32 i, regval;
> +
> +       dev_dbg(npctl->dev, "enable function %s group %s\n",
> +               npctl->functions[selector].name, npctl->groups[group].nam=
e);
> +
> +       for (i =3D 0; i < grp->npins; i++) {
> +               regmap_read(npctl->regmap, setting->offset, &regval);
> +               regval &=3D ~GENMASK(setting->shift + 3, setting->shift);

Add a comment explaining why you add +3

> +static int ma35_gpio_core_direction_in(struct gpio_chip *gc, unsigned in=
t gpio)
> +{
> +       struct ma35_pin_bank *bank =3D gpiochip_get_data(gc);
> +       void __iomem *reg_mode =3D bank->reg_base + MA35_GP_REG_MODE;
> +       unsigned long flags;
> +       unsigned int regval;
> +
> +       spin_lock_irqsave(&bank->lock, flags);
> +
> +       regval =3D readl(reg_mode);
> +       regval &=3D ~GENMASK(gpio * 2 + 1, gpio * 2);
> +       regval |=3D MA35_GP_MODE_INPUT << gpio * 2;

Here the first time you do this magic explain in a comment why you
use *2+1 and *2 overall (I guess two bits per line).

> +static int ma35_gpio_core_get(struct gpio_chip *gc, unsigned int gpio)
> +{
> +       struct ma35_pin_bank *bank =3D gpiochip_get_data(gc);
> +
> +       return readl(bank->reg_base + MA35_PIN_MAP_BASE + gpio * 4);

Here add a comment explaining the *4
I guess one 32-bit register per pin?

> +static int ma35_irq_irqtype(struct irq_data *d, unsigned int type)
> +{
> +       struct ma35_pin_bank *bank =3D gpiochip_get_data(irq_data_get_irq=
_chip_data(d));
> +       void __iomem *reg_itype =3D bank->reg_base + MA35_GP_REG_INTTYPE;
> +       void __iomem *reg_ien =3D bank->reg_base + MA35_GP_REG_INTEN;
> +       unsigned int num =3D (d->hwirq);
> +
> +       if (type =3D=3D IRQ_TYPE_PROBE) {
> +               writel(readl(reg_itype) & ~BIT(num), reg_itype);
> +               writel(readl(reg_ien) | BIT(num) | BIT(num + 16), reg_ien=
);
> +               bank->irqtype &=3D ~BIT(num);
> +               bank->irqinten |=3D BIT(num) | BIT(num + 16);
> +               return 0;
> +       }
> +
> +       if (type & IRQ_TYPE_LEVEL_MASK) {
> +               writel(readl(reg_itype) | BIT(num), reg_itype);
> +               writel(readl(reg_ien) & ~(BIT(num) | BIT(num + 16)), reg_=
ien);
> +               bank->irqtype |=3D BIT(num);
> +               bank->irqinten &=3D ~(BIT(num) | BIT(num + 16));
> +               if (type =3D=3D IRQ_TYPE_LEVEL_HIGH) {
> +                       writel(readl(reg_ien) | BIT(num + 16), reg_ien);
> +                       bank->irqinten |=3D BIT(num + 16);
> +                       return 0;
> +               }
> +
> +               if (type =3D=3D IRQ_TYPE_LEVEL_LOW) {
> +                       writel(readl(reg_ien) | BIT(num), reg_ien);
> +                       bank->irqinten |=3D BIT(num);
> +                       return 0;
> +               }
> +
> +       } else {
> +               writel(readl(reg_itype) & ~BIT(num), reg_itype);
> +               bank->irqtype &=3D ~BIT(num);
> +
> +               if (type & IRQ_TYPE_EDGE_RISING) {
> +                       writel(readl(reg_ien) | BIT(num + 16), reg_ien);
> +                       bank->irqinten |=3D BIT(num + 16);
> +
> +               } else {
> +                       writel(readl(reg_ien) & ~BIT(num + 16), reg_ien);
> +                       bank->irqinten &=3D ~BIT(num + 16);
> +               }
> +
> +               if (type & IRQ_TYPE_EDGE_FALLING) {
> +                       writel(readl(reg_ien) | BIT(num), reg_ien);
> +                       bank->irqinten |=3D BIT(num);
> +
> +               } else {
> +                       writel(readl(reg_ien) & ~BIT(num), reg_ien);
> +                       bank->irqinten &=3D ~BIT(num);
> +               }
> +       }
> +       return 0;
> +}

I don't understand why you don't set the irq_handler:
irq_set_handler_locked(d, handle_edge_irq);
irq_set_handler_locked(d, handle_level_irq);

It seems you are not handling IRQ_TYPE_EDGE_BOTH?
What happens if both rising and falling is specified simultaneously?

The if/else nesting is hard to read.
switch (type) {
        case IRQ_TYPE_EDGE_BOTH:
(...)
        case IRQ_TYPE_EDGE_RISING:
(...)

See drivers/gpio/gpio-ftgpio010.c for an example.

Have you checked that handling edge and level IRQs really work
as expected?

> +static int ma35_gpiolib_register(struct platform_device *pdev, struct ma=
35_pinctrl *npctl)
> +{
> +       struct ma35_pin_ctrl *ctrl =3D npctl->ctrl;
> +       struct ma35_pin_bank *bank =3D ctrl->pin_banks;
> +       int ret;
> +       int i;
> +
> +       for (i =3D 0; i < ctrl->nr_banks; ++i, ++bank) {
> +               if (!bank->valid) {
> +                       dev_warn(&pdev->dev, "bank %s is not valid\n",
> +                                bank->np->name);
> +                       continue;
> +               }
> +               bank->irqtype =3D 0;
> +               bank->irqinten =3D 0;
> +               bank->chip.label =3D bank->name;
> +               bank->chip.of_gpio_n_cells =3D 2;
> +               bank->chip.parent =3D &pdev->dev;
> +               bank->chip.request =3D ma35_gpio_core_to_request;
> +               bank->chip.direction_input =3D ma35_gpio_core_direction_i=
n;
> +               bank->chip.direction_output =3D ma35_gpio_core_direction_=
out;
> +               bank->chip.get =3D ma35_gpio_core_get;
> +               bank->chip.set =3D ma35_gpio_core_set;
> +               bank->chip.base =3D -1;
> +               bank->chip.ngpio =3D bank->nr_pins;
> +               bank->chip.can_sleep =3D false;
> +               spin_lock_init(&bank->lock);
> +
> +               if (bank->irq > 0) {
> +                       struct gpio_irq_chip *girq;
> +
> +                       girq =3D &bank->chip.irq;
> +                       gpio_irq_chip_set_chip(girq, &ma35_gpio_irqchip);
> +                       girq->parent_handler =3D ma35_irq_demux_intgroup;
> +                       girq->num_parents =3D 1;
> +
> +                       girq->parents =3D devm_kcalloc(&pdev->dev, 1, siz=
eof(*girq->parents),
> +                                                    GFP_KERNEL);
> +                       if (!girq->parents)
> +                               return -ENOMEM;
> +
> +                       girq->parents[0] =3D bank->irq;
> +                       girq->default_type =3D IRQ_TYPE_NONE;
> +                       girq->handler =3D handle_level_irq;

Does this really work for the edge IRQs?

I recommend setting this to handle_bad_irq and assign the right
handler in .set_type().

Yours,
Linus Walleij


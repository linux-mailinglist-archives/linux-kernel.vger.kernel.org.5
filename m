Return-Path: <linux-kernel+bounces-123525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AFA890A56
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D97298AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247D413B2B2;
	Thu, 28 Mar 2024 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpD/cHVN"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA4A13A240;
	Thu, 28 Mar 2024 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655583; cv=none; b=uL8K4JsC/OvmaMKP2ABlM+C06t15cWOQnf5c+Y3/23RMuuxZwVq36mpMdZGN5IDnaeO/M/+2jDPrFdJRwXeu/sZwaflb5iU2a9d9lkL84Cc5XucgmWCoB0MuJ/btKaSzW1DZiR/pjb1mfjtfa9+6miaOps/a2U+nb1aYmyVTmec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655583; c=relaxed/simple;
	bh=I3CyfHyxYRSB1OhUmLaDVJxwNsOSs0Ryn4RFazu4dIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvhbq08a2wwSCloq6KCScPC5QGV7n1ESX//fGkIokq8UPEonjJshSudL+lCqicoxEHiH2ahGGELMlnd7oBai0wwO2rQ6fjIDGXM6jUpnxdz/DNXZHrhfWsVQi9QxKpUXJSiuhIX0wD3Ns1SCZzz49V0HD75dnUq6jhuqlicroog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpD/cHVN; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4d4404fbdf5so508665e0c.0;
        Thu, 28 Mar 2024 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711655579; x=1712260379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUzwAPkG8d1fPsMXTjjGp2IOrUnCgMssObvH6aKPzQ8=;
        b=BpD/cHVN4tNawijC2joRnXCLQ/hpANUBAoh5foDvWEHsA9QIC0ll63QlkGMQRXku/A
         85YVETPjWAeOYv1AKGPUDjVQNYJTnFU9QvmCYy5zcy/3kCw9mtiKrK3XXzO3PHW6EJzS
         a4Wz9FpnczD33WNGsQSkJwKTZkwf97n6/7QQCNteU9zCnl+yJRmqaWKhguNTBPfS/UoU
         39K4nCcspGXHn8puluFr2gsWgbtAgiCoQkaFlMOxCo/nCmLBz4gdyw9b+bdsQpYDvo1a
         hotg8Hp6YlbXXBpn6KfZCxwElOFa5cBLYUsHWaE8+EPNDOXxXKoFW/VwE90rGK+67QQ/
         P12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711655579; x=1712260379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUzwAPkG8d1fPsMXTjjGp2IOrUnCgMssObvH6aKPzQ8=;
        b=t2reWTOeEHNfhYDW6zYDIr5zxPR+ufc41fBC3c5BCX28aA92+0nyLBy9eC7B04Bgms
         /pWZR2tPZtJEWuSkZa9SbVGnLrq5KNZb+u8A6O0YkOyeJgPP9SLn2n/txTYNAZ3KroLp
         Et4///QeEenD0uF7Tqnrk4YqXlnTAXPhfq6EsPPYF6EMNbf2i892aHtljwXBGrGUn9TT
         /1nJMx8m7A+2cLyYPUp0Qde2Q/z26WPPBRQb+03SRhwvjm2adRTIjTvTkXufCOZ2iB9u
         yyQ4x9QDzTP/q7sks6l2qUvtNl2dCEv6ioEEtA7FMEFQGG9t41PuGJ4W0a7O7ZvXRO4D
         bwig==
X-Forwarded-Encrypted: i=1; AJvYcCXYZDXFzz5zvjhxMx/qqoEkeioM0CtEz7zo1PtJYia5gT1yeWMMJkfGzgCOCjZ79+0OVRE/5phwDyh8o7AGtisXuxt48bSVkNmL2kF/3+SmAas6fLFMiWZmnpk14gbMqJIxoxvbmo7BO7EStVTSsM3bq0c8Bzm8b+HFO2desTwGkP8dJICuT7yh30bvAlrrwaHDbkANU/1Jw1HMWMO5ii3K8x/v+Q93zw==
X-Gm-Message-State: AOJu0YxZZURjGglZsu3gMyYuNZyTcsMfZT/sV2WPBaiLlCuvAUYzcNiX
	moAXGtmcqXRKtGeGIMYUjWnLDDh1uWnMO1HXHlJuwPriCRLb7vhppc3DNkOqzvNfIFYdK8Mr5UB
	wwmi7e598+DaqQVzXSEBUDc5Dvis=
X-Google-Smtp-Source: AGHT+IEAfrXoISJBJ+OZlnUPknP3xw5RLWlSJt5XP0/Vx67e/1qTuFZBU8w1UR49eKCaXGu7fCO9iZwa/pgCpYW6hQw=
X-Received: by 2002:a1f:738d:0:b0:4ca:80c5:753d with SMTP id
 o135-20020a1f738d000000b004ca80c5753dmr365204vkc.4.1711655579543; Thu, 28 Mar
 2024 12:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240326222844.1422948-14-prabhakar.mahadev-lad.rj@bp.renesas.com> <25bc9ceb-c5cb-40a2-8c3d-d9666b88546c@tuxon.dev>
In-Reply-To: <25bc9ceb-c5cb-40a2-8c3d-d9666b88546c@tuxon.dev>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 28 Mar 2024 19:51:15 +0000
Message-ID: <CA+V-a8uegButH84aUY1N+0GzZx2LkRBTxNtg7y1Y-cUvvFfJpw@mail.gmail.com>
Subject: Re: [RFC PATCH 13/13] pinctrl: renesas: pinctrl-rzg2l: Add support
 for RZ/V2H SoC
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

Thank you for the review.

On Thu, Mar 28, 2024 at 8:04=E2=80=AFAM claudiu beznea <claudiu.beznea@tuxo=
n.dev> wrote:
>
> Hi, Prabhakar,
>
> On 27.03.2024 00:28, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add pinctrl driver support for RZ/V2H(P) SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 483 +++++++++++++++++++++++-
> >  1 file changed, 481 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/=
renesas/pinctrl-rzg2l.c
> > index 6f0c85bb97a8..716c11ca5a8f 100644
> > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -59,6 +59,13 @@
> >  #define PIN_CFG_OEN                  BIT(15)
> >  #define PIN_CFG_VARIABLE             BIT(16)
> >  #define PIN_CFG_NOGPIO_INT           BIT(17)
> > +#define PIN_CFG_OPEN_DRAIN           BIT(18)
> > +#define PIN_CFG_SCHMIT_CTRL          BIT(19)
> > +#define PIN_CFG_ELC                  BIT(20)
> > +#define PIN_CFG_IOLH_1                       BIT(21)
> > +#define PIN_CFG_IOLH_2                       BIT(22)
> > +#define PIN_CFG_IOLH_3                       BIT(23)
> > +#define PIN_CFG_IOLH_4                       BIT(24)
> >
> >  #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
> >                                       (PIN_CFG_IOLH_##group | \
> > @@ -70,6 +77,10 @@
> >  #define RZG2L_MPXED_PIN_FUNCS                (RZG2L_MPXED_COMMON_PIN_F=
UNCS(A) | \
> >                                        PIN_CFG_SR)
> >
> > +#define RZV2H_MPXED_PIN_FUNCS(group) (RZG2L_MPXED_COMMON_PIN_FUNCS(gro=
up) | \
> > +                                      PIN_CFG_OPEN_DRAIN | \
> > +                                      PIN_CFG_SR)
> > +
> >  #define RZG3S_MPXED_PIN_FUNCS(group) (RZG2L_MPXED_COMMON_PIN_FUNCS(gro=
up) | \
> >                                        PIN_CFG_SOFT_PS)
> >
> > @@ -133,6 +144,8 @@
> >
> >  #define PWPR_B0WI            BIT(7)  /* Bit Write Disable */
> >  #define PWPR_PFCWE           BIT(6)  /* PFC Register Write Enable */
> > +#define PWPR_REGWE_A         BIT(6)  /* PFC and PMC Register Write Ena=
ble */
> > +#define PWPR_REGWE_B         BIT(5)  /* OEN Register Write Enable */
> >
> >  #define PM_MASK                      0x03
> >  #define PFC_MASK             0x07
> > @@ -149,6 +162,19 @@
> >  #define RZG2L_TINT_IRQ_START_INDEX   9
> >  #define RZG2L_PACK_HWIRQ(t, i)               (((t) << 16) | (i))
> >
> > +/* Custom pinconf parameters */
> > +#define RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE    (PIN_CONFIG_END +=
 1)
> > +
> > +static const struct pinconf_generic_params renesas_rzv2h_custom_bindin=
gs[] =3D {
> > +     { "renesas-rzv2h,output-impedance", RENESAS_RZV2H_PIN_CONFIG_OUTP=
UT_IMPEDANCE, 1 },
> > +};
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +static const struct pin_config_item renesas_rzv2h_conf_items[] =3D {
> > +     PCONFDUMP(RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE, "output-impe=
dance", "x", true),
> > +};
> > +#endif
> > +
> >  /* Read/write 8 bits register */
> >  #define RZG2L_PCTRL_REG_ACCESS8(_read, _addr, _val)  \
> >       do {                                            \
> > @@ -324,6 +350,8 @@ struct rzg2l_pinctrl {
> >       spinlock_t                      lock; /* lock read/write register=
s */
> >       struct mutex                    mutex; /* serialize adding groups=
 and functions */
> >
> > +     raw_spinlock_t                  pwpr_lock; /* serialize PWPR regi=
ster access */
> > +
> >       struct rzg2l_pinctrl_pin_settings *settings;
> >       struct rzg2l_pinctrl_reg_cache  *cache;
> >       struct rzg2l_pinctrl_reg_cache  *dedicated_cache;
> > @@ -348,6 +376,79 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(stru=
ct rzg2l_pinctrl *pctrl,
> >       return 0;
> >  }
> >
> > +static const struct rzg2l_variable_pin_cfg r9a09g057_variable_pin_cfg[=
] =3D {
> > +     {
> > +             .port =3D 9,
> > +             .pin =3D 0,
> > +             .cfg =3D RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL,
> > +     },
> > +     {
> > +             .port =3D 9,
> > +             .pin =3D 1,
> > +             .cfg =3D RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL,
> > +     },
> > +     {
> > +             .port =3D 9,
> > +             .pin =3D 2,
> > +             .cfg =3D RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL,
> > +     },
> > +     {
> > +             .port =3D 9,
> > +             .pin =3D 3,
> > +             .cfg =3D RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL,
> > +     },
> > +     {
> > +             .port =3D 9,
> > +             .pin =3D 4,
> > +             .cfg =3D RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL,
> > +     },
> > +     {
> > +             .port =3D 9,
> > +             .pin =3D 5,
> > +             .cfg =3D RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL,
> > +     },
> > +     {
> > +             .port =3D 9,
> > +             .pin =3D 6,
> > +             .cfg =3D RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL,
> > +     },
> > +     {
> > +             .port =3D 9,
> > +             .pin =3D 7,
> > +             .cfg =3D RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL,
> > +     },
> > +     {
> > +             .port =3D 11,
> > +             .pin =3D 0,
> > +             .cfg =3D RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL,
> > +     },
> > +     {
> > +             .port =3D 11,
> > +             .pin =3D 1,
> > +             .cfg =3D RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL |=
 PIN_CFG_IEN,
> > +     },
> > +     {
> > +             .port =3D 11,
> > +             .pin =3D 2,
> > +             .cfg =3D RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL |=
 PIN_CFG_IEN,
> > +     },
> > +     {
> > +             .port =3D 11,
> > +             .pin =3D 3,
> > +             .cfg =3D RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL |=
 PIN_CFG_IEN,
> > +     },
> > +     {
> > +             .port =3D 11,
> > +             .pin =3D 4,
> > +             .cfg =3D RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL |=
 PIN_CFG_IEN,
> > +     },
> > +     {
> > +             .port =3D 11,
> > +             .pin =3D 5,
> > +             .cfg =3D RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL |=
 PIN_CFG_IEN,
> > +     },
> > +};
> > +
> >  #ifdef CONFIG_RISCV
> >  static const struct rzg2l_variable_pin_cfg r9a07g043f_variable_pin_cfg=
[] =3D {
> >       {
> > @@ -474,6 +575,19 @@ static void rzg2l_pmc_writeb(struct rzg2l_pinctrl =
*pctrl, u8 val, void __iomem *
> >       writeb(val, addr);
> >  }
> >
> > +static void rzv2h_pmc_writeb(struct rzg2l_pinctrl *pctrl, u8 val, void=
 __iomem *addr)
> > +{
> > +     const struct rzg2l_register_offsets *regs =3D &pctrl->data->hwcfg=
->regs;
> > +     u8 pwpr;
> > +
> > +     raw_spin_lock(&pctrl->pwpr_lock);
> > +     pwpr =3D readb(pctrl->base + regs->pwpr);
> > +     writeb(pwpr | PWPR_REGWE_A, pctrl->base + regs->pwpr);
>
> What about having a device specific function that locks/unlocks the PWPR,
> this part ^ being the lock.
>
>
OK, ill have SoC specific function to lock/unlock.
>
> > +     writeb(val, addr);
>
> And this starting here:
>
> > +     writeb(pwpr & ~PWPR_REGWE_A, pctrl->base + regs->pwpr);
> > +     raw_spin_unlock(&pctrl->pwpr_lock);
>
> ending here: the unlock function. It should generate les diffs at least i=
n
> this patch.
>
> And you can add, were needed:
>
> if (pctrl->pwpr_lock_function)
>         pctrl->pwpr_lock_function();
>
> write(val, addr);
>
> if (pctrl->pwpr_unlock_function)
>         pctrl->pwpr_unlock_function();
>
>
> With this you can avoid adding rzv2h_pinctrl_set_pfc_mode() which is alom=
st
> identical w/ rzg2l_pinctrl_set_pfc_mode(), or adding
> rzv2h_pinctrl_pm_setup_pfc() almost identical with
> rzg2l_pinctrl_pm_setup_pfc().
>
Agreed.

> > +}
> > +
> >  static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
> >                                      u8 pin, u8 off, u8 func)
> >  {
> > @@ -512,6 +626,47 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2=
l_pinctrl *pctrl,
> >       spin_unlock_irqrestore(&pctrl->lock, flags);
> >  };
> >
> > +static void rzv2h_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
> > +                                    u8 pin, u8 off, u8 func)
> > +{
> > +     const struct rzg2l_register_offsets *regs =3D &pctrl->data->hwcfg=
->regs;
> > +     unsigned long flags;
> > +     u32 reg;
> > +     u8 pwpr;
> > +
> > +     spin_lock_irqsave(&pctrl->lock, flags);
> > +
> > +     /* Set pin to 'Non-use (Hi-Z input protection)'  */
> > +     reg =3D readw(pctrl->base + PM(off));
> > +     reg &=3D ~(PM_MASK << (pin * 2));
> > +     writew(reg, pctrl->base + PM(off));
> > +
> > +     /* Set the PWPR register to allow PFC and PMC register to write *=
/
> > +     raw_spin_lock(&pctrl->pwpr_lock);
> > +     pwpr =3D readb(pctrl->base + regs->pwpr);
> > +     writeb(PWPR_PFCWE | pwpr, pctrl->base + regs->pwpr);
> > +
> > +     /* Temporarily switch to GPIO mode with PMC register */
> > +     reg =3D readb(pctrl->base + PMC(off));
> > +     writeb(reg & ~BIT(pin), pctrl->base + PMC(off));
> > +
> > +     /* Select Pin function mode with PFC register */
> > +     reg =3D readl(pctrl->base + PFC(off));
> > +     reg &=3D ~(PFC_MASK << (pin * 4));
> > +     writel(reg | (func << (pin * 4)), pctrl->base + PFC(off));
> > +
> > +     /* Switch to Peripheral pin function with PMC register */
> > +     reg =3D readb(pctrl->base + PMC(off));
> > +     writeb(reg | BIT(pin), pctrl->base + PMC(off));
> > +
> > +     /* Set the PWPR register to be write-protected */
> > +     pwpr =3D readb(pctrl->base + regs->pwpr);
> > +     writeb(pwpr & ~PWPR_PFCWE, pctrl->base + regs->pwpr);
> > +     raw_spin_unlock(&pctrl->pwpr_lock);
> > +
> > +     spin_unlock_irqrestore(&pctrl->lock, flags);
> > +};
> > +
> >  static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
> >                                unsigned int func_selector,
> >                                unsigned int group_selector)
> > @@ -1087,14 +1242,26 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl=
 *pctrl, u32 caps, u32 offset, u8
> >       return 0;
> >  }
> >
> > +static u32 rzv2h_read_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 o=
ffset, u8 pin)
> > +{
> > +     /* stub */
> > +     return 0;
> > +}
> > +
> > +static int rzv2h_write_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 =
offset, u8 pin, u8 oen)
> > +{
> > +     /* stub */
> > +     return -EINVAL;
> > +}
> > +
>
> What about chekcing:
> if (pctrl->data->read_oen)
>         ret =3D pctrl->data->read_oen()
>
> if (pctrl->data->write_oen)
>         ret =3D pctrl->data->write_oen()
>
> Accross the driver. This will avoid adding stubs each time suppor for a n=
ew
> IP is added.
>
I plan to fill this up in a non-rfc series.

> >  static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
> >                                    unsigned int _pin,
> >                                    unsigned long *config)
> >  {
> >       struct rzg2l_pinctrl *pctrl =3D pinctrl_dev_get_drvdata(pctldev);
> > -     enum pin_config_param param =3D pinconf_to_config_param(*config);
> >       const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
> >       const struct pinctrl_pin_desc *pin =3D &pctrl->desc.pins[_pin];
> > +     u32 param =3D pinconf_to_config_param(*config);
> >       u64 *pin_data =3D pin->drv_data;
> >       unsigned int arg =3D 0;
> >       u32 off, cfg;
> > @@ -1180,6 +1347,30 @@ static int rzg2l_pinctrl_pinconf_get(struct pinc=
trl_dev *pctldev,
> >               break;
> >       }
> >
> > +     case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE: {
> > +             u8 val;
> > +
> > +             if (!(cfg & (PIN_CFG_IOLH_1 | PIN_CFG_IOLH_2 | PIN_CFG_IO=
LH_3 | PIN_CFG_IOLH_4)))
> > +                     return -EINVAL;
> > +
> > +             val =3D rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH=
_MASK);
> > +             switch (val) {
> > +             case 0:
> > +                     arg =3D 1;
> > +                     break;
> > +             case 1:
> > +                     arg =3D 2;
> > +                     break;
> > +             case 2:
> > +                     arg =3D 4;
> > +                     break;
> > +             default:
> > +                     arg =3D 6;
> > +                     break;
> > +             }
> > +             break;
> > +     }
> > +
> >       default:
> >               return -ENOTSUPP;
> >       }
> > @@ -1199,9 +1390,9 @@ static int rzg2l_pinctrl_pinconf_set(struct pinct=
rl_dev *pctldev,
> >       const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
> >       struct rzg2l_pinctrl_pin_settings settings =3D pctrl->settings[_p=
in];
> >       u64 *pin_data =3D pin->drv_data;
> > -     enum pin_config_param param;
> >       unsigned int i, arg, index;
> >       u32 cfg, off;
> > +     u32 param;
> >       int ret;
> >       u8 bit;
> >
> > @@ -1283,6 +1474,32 @@ static int rzg2l_pinctrl_pinconf_set(struct pinc=
trl_dev *pctldev,
> >                       rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_=
MASK, index);
> >                       break;
> >
> > +             case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
> > +                     arg =3D pinconf_to_config_argument(_configs[i]);
> > +
> > +                     if (!(cfg & (PIN_CFG_IOLH_1 | PIN_CFG_IOLH_2 |
> > +                                  PIN_CFG_IOLH_3 | PIN_CFG_IOLH_4)))
> > +                             return -EINVAL;
> > +
> > +                     switch (arg) {
> > +                     case 1:
> > +                             index =3D 0;
> > +                             break;
> > +                     case 2:
> > +                             index =3D 1;
> > +                             break;
> > +                     case 4:
> > +                             index =3D 2;
> > +                             break;
> > +                     case 6:
> > +                             index =3D 3;
> > +                             break;
> > +                     default:
> > +                             return -EINVAL;
> > +                     }
> > +                     rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_=
MASK, index);
> > +                     break;
> > +
> >               default:
> >                       return -EOPNOTSUPP;
> >               }
> > @@ -1730,6 +1947,38 @@ static const u64 r9a08g045_gpio_configs[] =3D {
> >       RZG2L_GPIO_PORT_PACK(6, 0x2a, RZG3S_MPXED_PIN_FUNCS(A)),         =
               /* P18 */
> >  };
> >
> > +static const char * const rzv2h_gpio_names[] =3D {
> > +     "P00", "P01", "P02", "P03", "P04", "P05", "P06", "P07",
> > +     "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17",
> > +     "P20", "P21", "P22", "P23", "P24", "P25", "P26", "P27",
> > +     "P30", "P31", "P32", "P33", "P34", "P35", "P36", "P37",
> > +     "P40", "P41", "P42", "P43", "P44", "P45", "P46", "P47",
> > +     "P50", "P51", "P52", "P53", "P54", "P55", "P56", "P57",
> > +     "P60", "P61", "P62", "P63", "P64", "P65", "P66", "P67",
> > +     "P70", "P71", "P72", "P73", "P74", "P75", "P76", "P77",
> > +     "P80", "P81", "P82", "P83", "P84", "P85", "P86", "P87",
> > +     "P90", "P91", "P92", "P93", "P94", "P95", "P96", "P97",
> > +     "PA0", "PA1", "PA2", "PA3", "PA4", "PA5", "PA6", "PA7",
> > +     "PB0", "PB1", "PB2", "PB3", "PB4", "PB5", "PB6", "PB7",
> > +};
> > +
> > +static const u64 r9a09g057_gpio_configs[] =3D {
> > +     RZG2L_GPIO_PORT_PACK(8, 0x20, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_=
SCHMIT_CTRL),  /* P0 */
> > +     RZG2L_GPIO_PORT_PACK(6, 0x21, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_=
SCHMIT_CTRL),  /* P1 */
> > +     RZG2L_GPIO_PORT_PACK(2, 0x22, RZV2H_MPXED_PIN_FUNCS(4)),         =
               /* P2 */
> > +     RZG2L_GPIO_PORT_PACK(8, 0x23, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_=
SCHMIT_CTRL),  /* P3 */
> > +     RZG2L_GPIO_PORT_PACK(8, 0x24, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_=
SCHMIT_CTRL),  /* P4 */
> > +     RZG2L_GPIO_PORT_PACK(8, 0x25, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_=
SCHMIT_CTRL),  /* P5 */
> > +     RZG2L_GPIO_PORT_PACK(8, 0x26, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_=
SCHMIT_CTRL |
> > +                          PIN_CFG_ELC),                               =
               /* P6 */
> > +     RZG2L_GPIO_PORT_PACK(8, 0x27, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_=
SCHMIT_CTRL),  /* P7 */
> > +     RZG2L_GPIO_PORT_PACK(8, 0x28, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_=
SCHMIT_CTRL |
> > +                         PIN_CFG_ELC),                                =
               /* P8 */
> > +     RZG2L_GPIO_PORT_PACK(8, 0x29, PIN_CFG_VARIABLE),                 =
               /* P9 */
> > +     RZG2L_GPIO_PORT_PACK(8, 0x2a, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_=
SCHMIT_CTRL),  /* PA */
> > +     RZG2L_GPIO_PORT_PACK(6, 0x2b, PIN_CFG_VARIABLE),                 =
               /* PB */
> > +};
> > +
> >  static const struct {
> >       struct rzg2l_dedicated_configs common[35];
> >       struct rzg2l_dedicated_configs rzg2l_pins[7];
> > @@ -1856,6 +2105,139 @@ static const struct rzg2l_dedicated_configs rzg=
3s_dedicated_pins[] =3D {
> >                                                      PIN_CFG_IO_VMC_SD1=
)) },
> >  };
> >
> > +static struct rzg2l_dedicated_configs rzv2h_dedicated_pins[] =3D {
> > +     { "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0, (PIN_CFG_FILONOFF | PIN_CF=
G_FILNUM |
> > +                                             PIN_CFG_FILCLKSEL)) },
> > +     { "TMS_SWDIO", RZG2L_SINGLE_PIN_PACK(0x3, 0, (PIN_CFG_IOLH_1 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_IEN)) },
> > +     { "TDO", RZG2L_SINGLE_PIN_PACK(0x3, 2, (PIN_CFG_IOLH_1 | PIN_CFG_=
SR)) },
> > +     { "WDTUDFCA", RZG2L_SINGLE_PIN_PACK(0x5, 0, (PIN_CFG_IOLH_1 | PIN=
_CFG_SR |
> > +                                                  PIN_CFG_PUPD)) },
> > +     { "WDTUDFCM", RZG2L_SINGLE_PIN_PACK(0x5, 1, (PIN_CFG_IOLH_1 | PIN=
_CFG_SR |
> > +                                                  PIN_CFG_PUPD)) },
> > +     { "SCIF_RXD", RZG2L_SINGLE_PIN_PACK(0x6, 0, (PIN_CFG_IOLH_1 | PIN=
_CFG_SR |
> > +                                                  PIN_CFG_PUPD)) },
> > +     { "SCIF_TXD", RZG2L_SINGLE_PIN_PACK(0x6, 1, (PIN_CFG_IOLH_1 | PIN=
_CFG_SR |
> > +                                                  PIN_CFG_PUPD)) },
> > +     { "XSPI0_CKP", RZG2L_SINGLE_PIN_PACK(0x7, 0, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD | PIN_=
CFG_OEN)) },
> > +     { "XSPI0_CKN", RZG2L_SINGLE_PIN_PACK(0x7, 1, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD | PIN_=
CFG_OEN)) },
> > +     { "XSPI0_CS0N", RZG2L_SINGLE_PIN_PACK(0x7, 2, (PIN_CFG_IOLH_1 | P=
IN_CFG_SR |
> > +                                                    PIN_CFG_PUPD | PIN=
_CFG_OEN)) },
> > +     { "XSPI0_DS", RZG2L_SINGLE_PIN_PACK(0x7, 3, (PIN_CFG_IOLH_2 | PIN=
_CFG_SR |
> > +                                                  PIN_CFG_PUPD)) },
> > +     { "XSPI0_RESET0N", RZG2L_SINGLE_PIN_PACK(0x7, 4, (PIN_CFG_IOLH_1 =
| PIN_CFG_SR |
> > +                                                       PIN_CFG_PUPD | =
PIN_CFG_OEN)) },
> > +     { "XSPI0_RSTO0N", RZG2L_SINGLE_PIN_PACK(0x7, 5, (PIN_CFG_PUPD)) }=
,
> > +     { "XSPI0_INT0N", RZG2L_SINGLE_PIN_PACK(0x7, 6, (PIN_CFG_PUPD)) },
> > +     { "XSPI0_ECS0N", RZG2L_SINGLE_PIN_PACK(0x7, 7, (PIN_CFG_PUPD)) },
> > +     { "XSPI0_IO0", RZG2L_SINGLE_PIN_PACK(0x8, 0, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD)) },
> > +     { "XSPI0_IO1", RZG2L_SINGLE_PIN_PACK(0x8, 1, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD)) },
> > +     { "XSPI0_IO2", RZG2L_SINGLE_PIN_PACK(0x8, 2, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD)) },
> > +     { "XSPI0_IO3", RZG2L_SINGLE_PIN_PACK(0x8, 3, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD)) },
> > +     { "XSPI0_IO4", RZG2L_SINGLE_PIN_PACK(0x8, 4, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD)) },
> > +     { "XSPI0_IO5", RZG2L_SINGLE_PIN_PACK(0x8, 5, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD)) },
> > +     { "XSPI0_IO6", RZG2L_SINGLE_PIN_PACK(0x8, 6, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD)) },
> > +     { "XSPI0_IO7", RZG2L_SINGLE_PIN_PACK(0x8, 7, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD)) },
> > +     { "SD0CLK", RZG2L_SINGLE_PIN_PACK(0x9, 0, (PIN_CFG_IOLH_2 | PIN_C=
FG_SR)) },
> > +     { "SD0CMD", RZG2L_SINGLE_PIN_PACK(0x9, 1, (PIN_CFG_IOLH_2 | PIN_C=
FG_SR)) },
> > +     { "SD0RSTN", RZG2L_SINGLE_PIN_PACK(0x9, 2, (PIN_CFG_IOLH_2 | PIN_=
CFG_SR |
> > +                                                 PIN_CFG_IEN | PIN_CFG=
_PUPD)) },
> > +     { "SD0DAT0", RZG2L_SINGLE_PIN_PACK(0xa, 0, (PIN_CFG_IOLH_2 | PIN_=
CFG_SR |
> > +                                                 PIN_CFG_IEN | PIN_CFG=
_PUPD)) },
> > +     { "SD0DAT1", RZG2L_SINGLE_PIN_PACK(0xa, 1, (PIN_CFG_IOLH_2 | PIN_=
CFG_SR |
> > +                                                 PIN_CFG_IEN | PIN_CFG=
_PUPD)) },
> > +     { "SD0DAT2", RZG2L_SINGLE_PIN_PACK(0xa, 2, (PIN_CFG_IOLH_2 | PIN_=
CFG_SR |
> > +                                                 PIN_CFG_IEN | PIN_CFG=
_PUPD)) },
> > +     { "SD0DAT3", RZG2L_SINGLE_PIN_PACK(0xa, 3, (PIN_CFG_IOLH_2 | PIN_=
CFG_SR |
> > +                                                 PIN_CFG_IEN | PIN_CFG=
_PUPD)) },
> > +     { "SD0DAT4", RZG2L_SINGLE_PIN_PACK(0xa, 4, (PIN_CFG_IOLH_2 | PIN_=
CFG_SR |
> > +                                                 PIN_CFG_IEN | PIN_CFG=
_PUPD)) },
> > +     { "SD0DAT5", RZG2L_SINGLE_PIN_PACK(0xa, 5, (PIN_CFG_IOLH_2 | PIN_=
CFG_SR |
> > +                                                 PIN_CFG_IEN | PIN_CFG=
_PUPD)) },
> > +     { "SD0DAT6", RZG2L_SINGLE_PIN_PACK(0xa, 6, (PIN_CFG_IOLH_2 | PIN_=
CFG_SR |
> > +                                                 PIN_CFG_IOLH_2 | PIN_=
CFG_PUPD)) },
> > +     { "SD0DAT7", RZG2L_SINGLE_PIN_PACK(0xa, 7, (PIN_CFG_IOLH_2 | PIN_=
CFG_SR |
> > +                                                 PIN_CFG_IEN | PIN_CFG=
_PUPD)) },
> > +     { "SD1_CLK", RZG2L_SINGLE_PIN_PACK(0xb, 0, (PIN_CFG_IOLH_2 | PIN_=
CFG_SR)) },
> > +     { "SD1_CMD", RZG2L_SINGLE_PIN_PACK(0xb, 1, (PIN_CFG_IOLH_2 | PIN_=
CFG_SR |
> > +                                                 PIN_CFG_IEN | PIN_CFG=
_PUPD)) },
> > +     { "SD1_DAT0", RZG2L_SINGLE_PIN_PACK(0xc, 0, (PIN_CFG_IOLH_2 | PIN=
_CFG_SR |
> > +                                                  PIN_CFG_IEN | PIN_CF=
G_PUPD)) },
> > +     { "SD1_DAT1", RZG2L_SINGLE_PIN_PACK(0xc, 1, (PIN_CFG_IOLH_2 | PIN=
_CFG_SR |
> > +                                                  PIN_CFG_IEN | PIN_CF=
G_PUPD)) },
> > +     { "SD1_DAT2", RZG2L_SINGLE_PIN_PACK(0xc, 2, (PIN_CFG_IOLH_2 | PIN=
_CFG_SR |
> > +                                                  PIN_CFG_IEN | PIN_CF=
G_PUPD)) },
> > +     { "SD1_DAT3", RZG2L_SINGLE_PIN_PACK(0xc, 3, (PIN_CFG_IOLH_2 | PIN=
_CFG_SR |
> > +                                                  PIN_CFG_IEN | PIN_CF=
G_PUPD)) },
> > +     { "PCIE0_RSTOUTB", RZG2L_SINGLE_PIN_PACK(0xe, 0, (PIN_CFG_IOLH_1 =
| PIN_CFG_SR)) },
> > +     { "PCIE1_RSTOUTB", RZG2L_SINGLE_PIN_PACK(0xe, 1, (PIN_CFG_IOLH_1 =
| PIN_CFG_SR)) },
> > +     { "ET0_MDIO", RZG2L_SINGLE_PIN_PACK(0xf, 0, (PIN_CFG_IOLH_2 | PIN=
_CFG_SR |
> > +                                                  PIN_CFG_IEN | PIN_CF=
G_PUPD)) },
> > +     { "ET0_MDC", RZG2L_SINGLE_PIN_PACK(0xf, 1, (PIN_CFG_IOLH_2 | PIN_=
CFG_SR |
> > +                                                 PIN_CFG_PUPD)) },
> > +     { "ET0_RXCTL_RXDV", RZG2L_SINGLE_PIN_PACK(0x10, 0, (PIN_CFG_PUPD)=
) },
> > +     { "ET0_TXCTL_TXEN", RZG2L_SINGLE_PIN_PACK(0x10, 1, (PIN_CFG_IOLH_=
2 | PIN_CFG_SR |
> > +                                                         PIN_CFG_PUPD)=
) },
> > +     { "ET0_TXER", RZG2L_SINGLE_PIN_PACK(0x10, 2, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD)) },
> > +     { "ET0_RXER", RZG2L_SINGLE_PIN_PACK(0x10, 3, (PIN_CFG_PUPD)) },
> > +     { "ET0_RXC_RXCLK", RZG2L_SINGLE_PIN_PACK(0x10, 4, (PIN_CFG_PUPD))=
 },
> > +     { "ET0_TXC_TXCLK", RZG2L_SINGLE_PIN_PACK(0x10, 5, (PIN_CFG_IOLH_2=
 | PIN_CFG_SR |
> > +                                                        PIN_CFG_PUPD |=
 PIN_CFG_OEN)) },
> > +     { "ET0_CRS", RZG2L_SINGLE_PIN_PACK(0x10, 6, (PIN_CFG_PUPD)) },
> > +     { "ET0_COL", RZG2L_SINGLE_PIN_PACK(0x10, 7, (PIN_CFG_PUPD)) },
> > +     { "ET0_TXD0", RZG2L_SINGLE_PIN_PACK(0x11, 0, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD)) },
> > +     { "ET0_TXD1", RZG2L_SINGLE_PIN_PACK(0x11, 1, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD)) },
> > +     { "ET0_TXD2", RZG2L_SINGLE_PIN_PACK(0x11, 2, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD)) },
> > +     { "ET0_TXD3", RZG2L_SINGLE_PIN_PACK(0x11, 3, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD)) },
> > +     { "ET0_RXD0", RZG2L_SINGLE_PIN_PACK(0x11, 4, (PIN_CFG_PUPD)) },
> > +     { "ET0_RXD1", RZG2L_SINGLE_PIN_PACK(0x11, 5, (PIN_CFG_PUPD)) },
> > +     { "ET0_RXD2", RZG2L_SINGLE_PIN_PACK(0x11, 6, (PIN_CFG_PUPD)) },
> > +     { "ET0_RXD3", RZG2L_SINGLE_PIN_PACK(0x11, 7, (PIN_CFG_PUPD)) },
> > +     { "ET1_MDIO", RZG2L_SINGLE_PIN_PACK(0x12, 0, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_SR | PIN_CF=
G_IEN |
> > +                                                   PIN_CFG_PUPD)) },
> > +     { "ET1_MDC", RZG2L_SINGLE_PIN_PACK(0x12, 1, (PIN_CFG_IOLH_2 | PIN=
_CFG_SR |
> > +                                                  PIN_CFG_PUPD)) },
> > +     { "ET1_RXCTL_RXDV", RZG2L_SINGLE_PIN_PACK(0x13, 0, (PIN_CFG_PUPD)=
) },
> > +     { "ET1_TXCTL_TXEN", RZG2L_SINGLE_PIN_PACK(0x13, 1, (PIN_CFG_IOLH_=
2 | PIN_CFG_SR |
> > +                                                         PIN_CFG_PUPD)=
) },
> > +     { "ET1_TXER", RZG2L_SINGLE_PIN_PACK(0x13, 2, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                    PIN_CFG_PUPD)) },
> > +     { "ET1_RXER", RZG2L_SINGLE_PIN_PACK(0x13, 3, (PIN_CFG_PUPD)) },
> > +     { "ET1_RXC_RXCLK", RZG2L_SINGLE_PIN_PACK(0x13, 4, (PIN_CFG_PUPD))=
 },
> > +     { "ET1_TXC_TXCLK", RZG2L_SINGLE_PIN_PACK(0x13, 5, (PIN_CFG_IOLH_2=
 | PIN_CFG_SR |
> > +                                                        PIN_CFG_PUPD |=
 PIN_CFG_OEN)) },
> > +     { "ET1_CRS", RZG2L_SINGLE_PIN_PACK(0x13, 6, (PIN_CFG_PUPD)) },
> > +     { "ET1_COL", RZG2L_SINGLE_PIN_PACK(0x13, 7, (PIN_CFG_PUPD)) },
> > +     { "ET1_TXD0", RZG2L_SINGLE_PIN_PACK(0x14, 0, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD)) },
> > +     { "ET1_TXD1", RZG2L_SINGLE_PIN_PACK(0x14, 1, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD)) },
> > +     { "ET1_TXD2", RZG2L_SINGLE_PIN_PACK(0x14, 2, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD)) },
> > +     { "ET1_TXD3", RZG2L_SINGLE_PIN_PACK(0x14, 3, (PIN_CFG_IOLH_2 | PI=
N_CFG_SR |
> > +                                                   PIN_CFG_PUPD)) },
> > +     { "ET1_RXD0", RZG2L_SINGLE_PIN_PACK(0x14, 4, (PIN_CFG_PUPD)) },
> > +     { "ET1_RXD1", RZG2L_SINGLE_PIN_PACK(0x14, 5, (PIN_CFG_PUPD)) },
> > +     { "ET1_RXD2", RZG2L_SINGLE_PIN_PACK(0x14, 6, (PIN_CFG_PUPD)) },
> > +     { "ET1_RXD3", RZG2L_SINGLE_PIN_PACK(0x14, 7, (PIN_CFG_PUPD)) },
> > +};
> > +
> >  static int rzg2l_gpio_get_gpioint(unsigned int virq, struct rzg2l_pinc=
trl *pctrl)
> >  {
> >       const struct pinctrl_pin_desc *pin_desc =3D &pctrl->desc.pins[vir=
q];
> > @@ -2380,6 +2762,9 @@ static int rzg2l_pinctrl_probe(struct platform_de=
vice *pdev)
> >       BUILD_BUG_ON(ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_=
PORT >
> >                    ARRAY_SIZE(rzg2l_gpio_names));
> >
> > +     BUILD_BUG_ON(ARRAY_SIZE(r9a09g057_gpio_configs) * RZG2L_PINS_PER_=
PORT >
> > +                  ARRAY_SIZE(rzv2h_gpio_names));
> > +
> >       pctrl =3D devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
> >       if (!pctrl)
> >               return -ENOMEM;
> > @@ -2402,6 +2787,7 @@ static int rzg2l_pinctrl_probe(struct platform_de=
vice *pdev)
> >
> >       spin_lock_init(&pctrl->lock);
> >       spin_lock_init(&pctrl->bitmap_lock);
> > +     raw_spin_lock_init(&pctrl->pwpr_lock);
> >       mutex_init(&pctrl->mutex);
> >       atomic_set(&pctrl->wakeup_path, 0);
> >
> > @@ -2578,6 +2964,65 @@ static void rzg2l_pinctrl_pm_setup_pfc(struct rz=
g2l_pinctrl *pctrl)
> >       writel(PWPR_B0WI, pctrl->base + regs->pwpr);    /* B0WI=3D1, PFCW=
E=3D0 */
> >  }
> >
> > +static void rzv2h_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
>
> Have you managed to test this?
>
No S2R isn't tested and is just added for completeness, I wonder if we
should have a SoC specific flag "pm_supported" for this, as apart from
RZ/G3S  nothing has been tested I believe?

Cheers,
Prabhakar


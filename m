Return-Path: <linux-kernel+bounces-46973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E6484473C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2131C224CB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84F51D684;
	Wed, 31 Jan 2024 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0rUv+Y6"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9534118AFB;
	Wed, 31 Jan 2024 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726217; cv=none; b=gKzsmFaC2kq/UgYHFbfclPzj0lj0sWzXxayygtEU2umulyUclJvy1f0e61DoxfMty5/Az3WGZJDBvlmls1GSIC38UX0yPbxyXWvGsdebz6iktxkvg97hO1B7P33lfKbJXPC9hLTWiWMCwMkl/7eZ1mm2IM5W8/BgrQp0udt5kc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726217; c=relaxed/simple;
	bh=eb+VOK77YTif17liq1RxZojiKrVECAtAYhvihr2dNWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHWiA5lkZUhsNHLncv6B5mhZ10GXQZ6e3hyJbJZ0qNoJ+ipc3wYi2wYIvf4dEYKQdke0OOleTWVVui3y3WjBjEUQ5o1JIwVxCgA7F9fUfiQi0SZo0z3cHdPLIiqRWgEliGI3F2B+qqWpFKAnPKsMQIh0N0AEpIuSPHSfJ4pC14Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0rUv+Y6; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4bda1df7e35so39418e0c.3;
        Wed, 31 Jan 2024 10:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706726214; x=1707331014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md+5piiWXmKjN01VJwfPkduOvpzQsk5Gbc1LCAGZCHM=;
        b=I0rUv+Y6qhcg4NkiHwOHf6LusZf4W5WmRtjdOBzlXjKRl5EVZLsbb4xIL37LEdwcPR
         Bi4/uG/dBhpvidTIw2nPV9k1ciss0EYqvfmu/wSJiOxKo52dhpfxSNzy5VhRpYdXm7BY
         mp+RY5lfSwPEuy9KUe8cwsTiIjITYe2chYVm17kP38XDtT80ZfHkaDeK622xXqCsR0VP
         pjLiAVXx0a40y/lANIFpRS14Zgupt05i41IuysWz3L7HFNw06WCCWiP2Y5jrCfQKN/T4
         JHNj3+jGkxz36dyyO2AqmzBL0zlX6oECzkhbqfY188Sfk5seiHDI+XrTbNKizz6eKfum
         3vLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706726214; x=1707331014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=md+5piiWXmKjN01VJwfPkduOvpzQsk5Gbc1LCAGZCHM=;
        b=ZkepSvjK/wflNPWTfUUMdWphNNxr/U+TtSBPOA+k/pVTsNcgQoW3Q9h8sfeAiahh46
         rcxK6C27fPJEuh50J61zfiPTl/aOsVHI5h1VQFKTLzyWHSXGsLNMBhZ+5NjkLE5DzBMT
         lN0l7QePySigUTRxUiPT7IofYwVWSdK9FVLDFdvLoXbqwFH3H6Edkj3RAcg0ntbC4DP7
         AuV9iK4D6QwtrB+Nsyo6Qyt2hMckTWoWSFwv4JHwKLRuT7l1oF92X4oMN90YlfEniQrR
         CUcLfpzyWZbD4uTAXnFDf/ingNZhb0N/q0GXo84RTzn8VM+SA8UN7yHN9KSrq38cNV9H
         SUBQ==
X-Gm-Message-State: AOJu0YyG0Oyu1YKJ9rp1YTcZEL5t6iuoqoM2u5+WnSkxseuC/3gt7Rrt
	tIZjGfrPhhkVkwUIwrb1LTUIFP2YZwCidb3UHoCsMaTR/fDiRF0sVvj+2jVkZ8LK5PP8voQEadR
	W6JXeH6llxWUgzb2D5GDWxnw0sAo=
X-Google-Smtp-Source: AGHT+IEnW38T9BQmWMOcc/tVl3EFzSGPQf9woPnBE3HaaWWQoeX0PopBSjevHvFAvfx+3jXs6OflFORZ8k7PxaXoMY4=
X-Received: by 2002:a05:6122:1818:b0:4bd:b44c:24c1 with SMTP id
 ay24-20020a056122181800b004bdb44c24c1mr2595166vkb.11.1706726214233; Wed, 31
 Jan 2024 10:36:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240129151618.90922-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdV7Q4kMv1pFVNBf5oYF=_W_snp=5GKLpr9+OxeqxywhBw@mail.gmail.com>
In-Reply-To: <CAMuHMdV7Q4kMv1pFVNBf5oYF=_W_snp=5GKLpr9+OxeqxywhBw@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 31 Jan 2024 18:36:20 +0000
Message-ID: <CA+V-a8spFYvOo2=9CwM-1EyMA3Xrc_rggUgxDZwZan2ou4SG1A@mail.gmail.com>
Subject: Re: [PATCH 2/5] irqchip/renesas-rzg2l: Add support for RZ/Five SoC
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Tue, Jan 30, 2024 at 11:38=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Jan 29, 2024 at 4:16=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The IX45 block has additional mask registers (NMSK/IMSK/TMSK) as compar=
ed
> > to the RZ/G2L (family) SoC.
> >
> > Introduce masking/unmasking support for IRQ and TINT interrupts in IRQC
> > controller driver. Two new registers, IMSK and TMSK, are defined to
> > handle masking on RZ/Five SoC. The implementation utilizes a new data
> > structure, `struct rzg2l_irqc_data`, to determine mask support for a
> > specific controller instance.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/irqchip/irq-renesas-rzg2l.c
> > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > @@ -66,15 +68,25 @@ struct rzg2l_irqc_reg_cache {
> >         u32     titsr[2];
> >  };
> >
> > +/**
> > + * struct rzg2l_irqc_data - OF data structure
> > + * @mask_supported: Indicates if mask registers are available
> > + */
> > +struct rzg2l_irqc_data {
>
> This structure has the same name as the single static struct
> rzg2l_irqc_priv instance, which is confusing.
>
Agreed, I will rename it to rzg2l_irqc_of_data

> > +       bool    mask_supported;
> > +};
> > +
> >  /**
> >   * struct rzg2l_irqc_priv - IRQ controller private data structure
> >   * @base:      Controller's base address
> > + * @data:      OF data pointer
> >   * @fwspec:    IRQ firmware specific data
> >   * @lock:      Lock to serialize access to hardware registers
> >   * @cache:     Registers cache for suspend/resume
> >   */
> >  static struct rzg2l_irqc_priv {
> >         void __iomem                    *base;
> > +       const struct rzg2l_irqc_data    *data;
>
> Replacing this by a bool would avoid a pointer dereference in each user,
> and allows you to make rzg2l_irqc_data etc. __initconst.
>
Do you mean just add "bool mask_supported" here and get rid of struct
rzg2l_irqc_data ? Can you please elaborate here..

> >         struct irq_fwspec               fwspec[IRQC_NUM_IRQ];
> >         raw_spinlock_t                  lock;
> >         struct rzg2l_irqc_reg_cache     cache;
>
> > @@ -371,9 +475,23 @@ static int rzg2l_irqc_parse_interrupts(struct rzg2=
l_irqc_priv *priv,
> >         return 0;
> >  }
> >
> > +static const struct rzg2l_irqc_data rzfive_irqc_data =3D {
> > +       .mask_supported =3D true,
> > +};
> > +
> > +static const struct rzg2l_irqc_data rzg2l_irqc_default_data =3D {
> > +       .mask_supported =3D false,
> > +};
> > +
> > +static const struct of_device_id rzg2l_irqc_matches[] =3D {
> > +       { .compatible =3D "renesas,r9a07g043f-irqc", .data =3D &rzfive_=
irqc_data },
> > +       { }
> > +};
> > +
> >  static int rzg2l_irqc_init(struct device_node *node, struct device_nod=
e *parent)
> >  {
> >         struct irq_domain *irq_domain, *parent_domain;
> > +       const struct of_device_id *match;
> >         struct platform_device *pdev;
> >         struct reset_control *resetn;
> >         int ret;
> > @@ -392,6 +510,12 @@ static int rzg2l_irqc_init(struct device_node *nod=
e, struct device_node *parent)
> >         if (!rzg2l_irqc_data)
> >                 return -ENOMEM;
> >
> > +       match =3D of_match_node(rzg2l_irqc_matches, node);
> > +       if (match)
> > +               rzg2l_irqc_data->data =3D match->data;
> > +       else
> > +               rzg2l_irqc_data->data =3D &rzg2l_irqc_default_data;
>
> Instead of matching a second time, I'd rather add a second
> IRQCHIP_MATCH() entry with a different init function, passing the
> actual rzg2l_irqc_data pointer.
>
OK, or rather just pass true/false instead of rzg2l_irqc_of_data pointer.?

Cheers,
Prabhakar


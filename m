Return-Path: <linux-kernel+bounces-48187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 026E384586A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7523C1C27AC6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753485336C;
	Thu,  1 Feb 2024 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAYl/XeZ"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAF953368;
	Thu,  1 Feb 2024 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792742; cv=none; b=P8geGcUx51S3kYwRelNftax2W5yHCqe1PeiSvgQZels1Cehf4yIiPynULIWuIEXfE5Z9sZDIr1XK65O4Nz69+rg8sxoFNrSn8pstJcZVAZnaSy8b7U7Ohdj6D5KVurA9e3bqxyzV9UPkBHgU9/Diwwez9DEXDub1aCa5tuMPKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792742; c=relaxed/simple;
	bh=KJO/0kGqXXfwHQPG1WWgO9x4FSPuJhXDewinnrE/U4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hes43j0sQIptKRg2nhS9mUvhWafC5zCYLRvSjmzz2GzDUyiM5ymEMFhK840MaPKcdn83Bn2hlUKbk3QM0AEmUVys7YDqr6OxyJijUS15yHkwDQWBtXkVO8eHmtHE8e2/FLBpj4n4Az0WA0a1UBfOqTQjuLMzXbtYqVPifRgC/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAYl/XeZ; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d5c514944fso1109055241.1;
        Thu, 01 Feb 2024 05:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706792739; x=1707397539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fdnwK8iaaWfuANgz2bEov8b83FWFpe1U9HGTL70t+I=;
        b=HAYl/XeZhCSl7GP1m7NUkqfw3BRmvJGPuww6lsXlpsjMSiVElAwObc2OcbdUCCoY4J
         2rtlPYmNixQO5qtN+g8jFz4vhNuZpBfv5Vp9oaqlZ5RdaKMk873+EOKvLo3c+YAS0Wfu
         CsQtjgnda3ePV+ZGH9t2Sw5m0NZnqfWNenVKSB89v1TEsXBHl4LBDLjyZ9sy/fJny0tQ
         ArmHZPz0U5nCPY+r4koqER9EKUZksZoLD+5hTWRAHP+cV6mXw1B/LqAfaCUNGqqnG+i6
         W5pO1ERAzTtLlP/DTQep5uYFaLEYvskua1Ax39y3vJI1IaQmSbRG+NXRl/lMrN/YjiTD
         iPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706792739; x=1707397539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fdnwK8iaaWfuANgz2bEov8b83FWFpe1U9HGTL70t+I=;
        b=sNJPqjSzRqYCdmNVOG4ifb9gIG3yWflH8qGtZXRR1tnhRL4h2uHEcLXdeMWkoFEwfX
         g5gv2dSu9P+HCcqaX1QFKE0J95VaQEPEQB9/SZocmSmx6FYQQ77exXntq8QOsT4vAGfU
         IbddDF71i1M5Mta1vX6gK8QMNC/XJpld7udmJtjTYGxDEQnmMnjakAfn98dy8R1AVB8t
         qPG8DTh8/NqHk0g/lDJOiIyHV5ZZZvZ4DK51U8r2+JHy7qy1E03LHf9aUa+Iz5BW9jtA
         ftx72yUms3e+GaxlsCNZ3EN+B12uNIhOl+EDUQ7HQ7EXmXMnCuYUVRoEpewVz6akEGvy
         Vhng==
X-Gm-Message-State: AOJu0YwAhjDmRRWmnmtOgli7CcW8n8bMK38Zxnktvf1klS/L+0l5Y86t
	NOP2e1hX53TsWr2U0lLegQBolwsSHevXBdOov0TDMMkpJEQWE6wne/lHS9Ke8xzC5+ihvEeqY75
	f/ffOSaAOPR3FKFNj6HC1I4Gmh4k=
X-Google-Smtp-Source: AGHT+IFigfduTRWsVmPlC+0JRfAbL46rAzX8asmlX4/T+JbyargMaUcC1tcGZu/+10b2CLWwTtcY1LRuKIsCJEiZcSk=
X-Received: by 2002:a05:6122:e6b:b0:4b7:3c54:357e with SMTP id
 bj43-20020a0561220e6b00b004b73c54357emr3297980vkb.1.1706792739290; Thu, 01
 Feb 2024 05:05:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240129151618.90922-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV7Q4kMv1pFVNBf5oYF=_W_snp=5GKLpr9+OxeqxywhBw@mail.gmail.com>
 <CA+V-a8spFYvOo2=9CwM-1EyMA3Xrc_rggUgxDZwZan2ou4SG1A@mail.gmail.com> <CAMuHMdUFZ6pRtZv4QLGhTz_gG575-8-LvaFprNuP2-1HGS8r+A@mail.gmail.com>
In-Reply-To: <CAMuHMdUFZ6pRtZv4QLGhTz_gG575-8-LvaFprNuP2-1HGS8r+A@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 1 Feb 2024 13:05:05 +0000
Message-ID: <CA+V-a8tQRr96q6SJfCgPa7Zte4UhRHE+83hXNzN8-=rRX5EH0Q@mail.gmail.com>
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

On Thu, Feb 1, 2024 at 8:34=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68k=
org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Jan 31, 2024 at 7:36=E2=80=AFPM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Tue, Jan 30, 2024 at 11:38=E2=80=AFAM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Mon, Jan 29, 2024 at 4:16=E2=80=AFPM Prabhakar <prabhakar.csengg@g=
mail.com> wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > The IX45 block has additional mask registers (NMSK/IMSK/TMSK) as co=
mpared
> > > > to the RZ/G2L (family) SoC.
> > > >
> > > > Introduce masking/unmasking support for IRQ and TINT interrupts in =
IRQC
> > > > controller driver. Two new registers, IMSK and TMSK, are defined to
> > > > handle masking on RZ/Five SoC. The implementation utilizes a new da=
ta
> > > > structure, `struct rzg2l_irqc_data`, to determine mask support for =
a
> > > > specific controller instance.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
> > >
> > > > --- a/drivers/irqchip/irq-renesas-rzg2l.c
> > > > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > > > @@ -66,15 +68,25 @@ struct rzg2l_irqc_reg_cache {
> > > >         u32     titsr[2];
> > > >  };
> > > >
> > > > +/**
> > > > + * struct rzg2l_irqc_data - OF data structure
> > > > + * @mask_supported: Indicates if mask registers are available
> > > > + */
> > > > +struct rzg2l_irqc_data {
> > >
> > > This structure has the same name as the single static struct
> > > rzg2l_irqc_priv instance, which is confusing.
> > >
> > Agreed, I will rename it to rzg2l_irqc_of_data
> >
> > > > +       bool    mask_supported;
> > > > +};
> > > > +
> > > >  /**
> > > >   * struct rzg2l_irqc_priv - IRQ controller private data structure
> > > >   * @base:      Controller's base address
> > > > + * @data:      OF data pointer
> > > >   * @fwspec:    IRQ firmware specific data
> > > >   * @lock:      Lock to serialize access to hardware registers
> > > >   * @cache:     Registers cache for suspend/resume
> > > >   */
> > > >  static struct rzg2l_irqc_priv {
> > > >         void __iomem                    *base;
> > > > +       const struct rzg2l_irqc_data    *data;
> > >
> > > Replacing this by a bool would avoid a pointer dereference in each us=
er,
> > > and allows you to make rzg2l_irqc_data etc. __initconst.
> > >
> > Do you mean just add "bool mask_supported" here and get rid of struct
> > rzg2l_irqc_data ? Can you please elaborate here..
>
> Either add "bool mask_supported" here, or add a copy of the full
> struct rzg2l_irqc_data (see below).
>
OK, i'll keep a copy of struct rzg2l_irqc_data here...
> >
> > > >         struct irq_fwspec               fwspec[IRQC_NUM_IRQ];
> > > >         raw_spinlock_t                  lock;
> > > >         struct rzg2l_irqc_reg_cache     cache;
> > >
> > > > @@ -371,9 +475,23 @@ static int rzg2l_irqc_parse_interrupts(struct =
rzg2l_irqc_priv *priv,
> > > >         return 0;
> > > >  }
> > > >
> > > > +static const struct rzg2l_irqc_data rzfive_irqc_data =3D {
> > > > +       .mask_supported =3D true,
> > > > +};
> > > > +
> > > > +static const struct rzg2l_irqc_data rzg2l_irqc_default_data =3D {
> > > > +       .mask_supported =3D false,
> > > > +};
> > > > +
> > > > +static const struct of_device_id rzg2l_irqc_matches[] =3D {
> > > > +       { .compatible =3D "renesas,r9a07g043f-irqc", .data =3D &rzf=
ive_irqc_data },
> > > > +       { }
> > > > +};
> > > > +
> > > >  static int rzg2l_irqc_init(struct device_node *node, struct device=
_node *parent)
> > > >  {
> > > >         struct irq_domain *irq_domain, *parent_domain;
> > > > +       const struct of_device_id *match;
> > > >         struct platform_device *pdev;
> > > >         struct reset_control *resetn;
> > > >         int ret;
> > > > @@ -392,6 +510,12 @@ static int rzg2l_irqc_init(struct device_node =
*node, struct device_node *parent)
> > > >         if (!rzg2l_irqc_data)
> > > >                 return -ENOMEM;
> > > >
> > > > +       match =3D of_match_node(rzg2l_irqc_matches, node);
> > > > +       if (match)
> > > > +               rzg2l_irqc_data->data =3D match->data;
> > > > +       else
> > > > +               rzg2l_irqc_data->data =3D &rzg2l_irqc_default_data;
> > >
> > > Instead of matching a second time, I'd rather add a second
> > > IRQCHIP_MATCH() entry with a different init function, passing the
> > > actual rzg2l_irqc_data pointer.
> > >
> > OK, or rather just pass true/false instead of rzg2l_irqc_of_data pointe=
r.?
>
> Yes, that would be fine for me, too.
> It all depends on whether you plan to add, or see a need for adding,
> more flags or other fields in the future (and even for flags, you could
> combine them in an unsigned long).
>
I'll keep the bool flag for now and update it  as  and when it grows.
I see future SoCs with a lot of other interrupts being supported by
this block.

Cheers,
Prabhakar

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds


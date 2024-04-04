Return-Path: <linux-kernel+bounces-131509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25D28988DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5926928C6CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB48128362;
	Thu,  4 Apr 2024 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNX4k0ej"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324AC8613E;
	Thu,  4 Apr 2024 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237709; cv=none; b=kU7jXMGzFPps9gsmlBOI7Gb+hnmsz+qWDhuhHKgt616ZhC1iUhcqNRUlwn7hA/NwdLDlR7Uklrv3z4vFN2j9MAZb9NbzjT28Cxw+rMuIWs7VJFzFR4hSWo3MHOMrGNDvuaJETpZDFNd6AdCE2YL2VXUc0ap4aNz47oObLU6NRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237709; c=relaxed/simple;
	bh=YfyzMeF6cXpeiNvp249LcMAU4DwRm9i3zFbC0zXRdLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7ZV4VNk2E2K8thZJVspvaJJtzAI0J5ieencWOHNsRs216/ZO/9PHbjSG0obPsb6cdHNPL2fHR2C7dqc5jESpYo/fr1YnxknQfuFPIUC9NGo2TNRGhHiPb0JfDOhx80P/kiECLmQtOP5nZbPHnt8VB9DQxPDdtTgjvmV/eg0Vd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNX4k0ej; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-479cc1791bfso210096137.3;
        Thu, 04 Apr 2024 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712237706; x=1712842506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFKCNlBFBmvvJg8tbNOd+dvwn4RRHL754vXI+45uAlI=;
        b=SNX4k0ej7Q9XVrTqGuH/RWG9Vm/VdG78YHjOC3gdgb31LVoeBkOHoL78ocEjZw8KFK
         JnfVmIFVtAVOaGpEwPNO/OZm7NGOB9fg+IrZB0GGIuzwX2/80JCdoVWpWU9fS6H/w3J7
         0/C09NlEGP+Pc/U91w4HPExXhJKO5eLQI1YI62GE7oLNLe5OW1OhLA1LJxDEvKWcY88D
         7NYF9ffMywtQsP3QrDi2+c+acu4ggr/zU00mNRnTCs1TOpuIjyzqHLeeeeYp2SIWERip
         7y3/JvXv+PmLhRv9ALYwp0/EoKshzBuD/diNNNYusp1YRqzlApV2ClELfAZYId5AOrkF
         N/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712237706; x=1712842506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFKCNlBFBmvvJg8tbNOd+dvwn4RRHL754vXI+45uAlI=;
        b=WjC4n+CGZzExitcpAvoWRLDuNdZZAYbE5nx6VgaA3/OQqXNXnIIYnntEVM8O4wVDpd
         O+USC195z/+k6oOIbPTg7AgFfJWixIg76BzLujn3siSyZw3fCKCqCxWAAamEhZQb1SYY
         ZgpV7bMG3KXzJv70c1fR9/1SvORtwdFqgNMUzKDO9Fktpzftlfp1eeT5LQOVL5vs5mNy
         TEMAsfEuTskOAwW+SrwscJHjoqHVxgkZ+7UEyOLNZ49/Gd+lBOA+rjThLPYclFG2hJxz
         Zw0pvy5MODXKuOXtGaW9KKAT4IvCZd74B+//wOSWitnWshxhpPHXr0KwEPkU33l+aICq
         yH0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjoVHtYIo7Do8GUbyWKZgLIn9Xxcn22pwkbndTdTX27pFMBomKDhGhvlil2G6RIzwf7hidvIalmJWO/P5XRJoRY7w/3Eoeiu0VsHM+GfrMtOkBTJwm6b9JnNQZ4n/btYFpdjnJ0WjDnu78ca29g4EPZ6iPigLwV2ndCdRrbbXc50sLfRgZe6XF52c9
X-Gm-Message-State: AOJu0YyBOU0gCbX6kGq2ptnfByC0Y588D/oIs5nSQsUmQGNtYPq4WWBz
	tEEgvuDqr34fKPzK9S4UWOFsNkhfjXmmoV/mllfvkvSRqvxY/MighMEKjvyH/uqDVWf7usct954
	6mUHg8ub1TQTvYmF9rpIgNKbwlaU=
X-Google-Smtp-Source: AGHT+IHxijyUV1tt95o6QXEOZgm8gs7pq3/V0IbiiDujjNbDN0XvONN6co6X4+U+1QRcVai+xwZuZ0zTvqSDZSgS3fY=
X-Received: by 2002:a1f:fc06:0:b0:4d8:797b:94d5 with SMTP id
 a6-20020a1ffc06000000b004d8797b94d5mr1817963vki.3.1712237706051; Thu, 04 Apr
 2024 06:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240403203503.634465-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OSAPR01MB1587ED05696A111612424CF6863C2@OSAPR01MB1587.jpnprd01.prod.outlook.com>
 <CA+V-a8s94e9PLuLipQo+rGZ8g7UHxZJJAZZgvL3PQ4b8PKR2Xw@mail.gmail.com> <OSAPR01MB15878C2C2EE7905D33182CFF863C2@OSAPR01MB1587.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB15878C2C2EE7905D33182CFF863C2@OSAPR01MB1587.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 4 Apr 2024 14:34:39 +0100
Message-ID: <CA+V-a8vjB-A+BRSpxk-dsu6XMvpG1y2f8g+LYcWV+gh2cx+6+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] irqchip/renesas-rzg2l: Add support for RZ/Five SoC
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 2:31=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.com=
> wrote:
>
> Hi Lad, Prabhakar,
>
> > -----Original Message-----
> > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: Thursday, April 4, 2024 2:27 PM
> > Subject: Re: [PATCH v2 2/5] irqchip/renesas-rzg2l: Add support for RZ/F=
ive SoC
> >
> > Hi Biju,
> >
> > Thank you for the review.
> >
> > On Thu, Apr 4, 2024 at 8:44=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas=
com> wrote:
> > >
> > > Hi Prabhakar,
> > >
> > > Thanks for the patch.
> > >
> > > > -----Original Message-----
> > > > From: Prabhakar <prabhakar.csengg@gmail.com>
> > > > Sent: Wednesday, April 3, 2024 9:35 PM
> > > > Subject: [PATCH v2 2/5] irqchip/renesas-rzg2l: Add support for
> > > > RZ/Five SoC
> > > >
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > The IX45 block has additional mask registers (NMSK/IMSK/TMSK) as
> > > > compared to the RZ/G2L (family) SoC.
> > > >
> > > > Introduce masking/unmasking support for IRQ and TINT interrupts in
> > > > IRQC controller driver. Two new registers, IMSK and TMSK, are
> > > > defined to handle masking on RZ/Five SoC. The implementation
> > > > utilizes a new data structure, `struct rzg2l_irqc_data`, to determi=
ne mask support for a
> > specific controller instance.
> > > >
> > > > Signed-off-by: Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > > v1->v2
> > > > - Added IRQCHIP_MATCH() for RZ/Five
> > > > - Retaining a copy of OF data in priv
> > > > - Rebased the changes
> > > > ---
> > > >  drivers/irqchip/irq-renesas-rzg2l.c | 137
> > > > +++++++++++++++++++++++++++-
> > > >  1 file changed, 132 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/irqchip/irq-renesas-rzg2l.c
> > > > b/drivers/irqchip/irq-renesas-rzg2l.c
> > > > index f6484bf15e0b..6fa8d65605dc 100644
> > > > --- a/drivers/irqchip/irq-renesas-rzg2l.c
> > > > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > > > @@ -37,6 +37,8 @@
> > > >  #define TSSEL_SHIFT(n)                       (8 * (n))
> > > >  #define TSSEL_MASK                   GENMASK(7, 0)
> > > >  #define IRQ_MASK                     0x3
> > > > +#define IMSK                         0x10010
> > > > +#define TMSK                         0x10020
> > > >
> > > >  #define TSSR_OFFSET(n)                       ((n) % 4)
> > > >  #define TSSR_INDEX(n)                        ((n) / 4)
> > > > @@ -66,15 +68,25 @@ struct rzg2l_irqc_reg_cache {
> > > >       u32     titsr[2];
> > > >  };
> > > >
> > > > +/**
> > > > + * struct rzg2l_irqc_of_data - OF data structure
> > > > + * @mask_supported: Indicates if mask registers are available  */
> > > > +struct rzg2l_irqc_of_data {
> > > > +     bool    mask_supported;
> > > > +};
> > > > +
> > > >  /**
> > > >   * struct rzg2l_irqc_priv - IRQ controller private data structure
> > > >   * @base:    Controller's base address
> > > > + * @data:    OF data pointer
> > > >   * @fwspec:  IRQ firmware specific data
> > > >   * @lock:    Lock to serialize access to hardware registers
> > > >   * @cache:   Registers cache for suspend/resume
> > > >   */
> > > >  static struct rzg2l_irqc_priv {
> > > >       void __iomem                    *base;
> > > > +     const struct rzg2l_irqc_of_data *data;
> > > >       struct irq_fwspec               fwspec[IRQC_NUM_IRQ];
> > > >       raw_spinlock_t                  lock;
> > > >       struct rzg2l_irqc_reg_cache     cache;
> > > > @@ -138,18 +150,102 @@ static void rzg2l_irqc_eoi(struct irq_data *=
d)
> > > >       irq_chip_eoi_parent(d);
> > > >  }
> > > >
> > > > +static void rzg2l_irqc_mask_irq_interrupt(struct rzg2l_irqc_priv *=
priv,
> > > > +                                       unsigned int hwirq) {
> > > > +     u32 imsk =3D readl_relaxed(priv->base + IMSK);
> > > > +     u32 bit =3D BIT(hwirq - IRQC_IRQ_START);
> > > > +
> > > > +     writel_relaxed(imsk | bit, priv->base + IMSK); }
> > > > +
> > > > +static void rzg2l_irqc_unmask_irq_interrupt(struct rzg2l_irqc_priv=
 *priv,
> > > > +                                         unsigned int hwirq) {
> > > > +     u32 imsk =3D readl_relaxed(priv->base + IMSK);
> > > > +     u32 bit =3D BIT(hwirq - IRQC_IRQ_START);
> > > > +
> > > > +     writel_relaxed(imsk & ~bit, priv->base + IMSK); }
> > > > +
> > > > +static void rzg2l_irqc_mask_tint_interrupt(struct rzg2l_irqc_priv =
*priv,
> > > > +                                        unsigned int hwirq) {
> > > > +     u32 tmsk =3D readl_relaxed(priv->base + TMSK);
> > > > +     u32 bit =3D BIT(hwirq - IRQC_TINT_START);
> > > > +
> > > > +     writel_relaxed(tmsk | bit, priv->base + TMSK); }
> > > > +
> > > > +static void rzg2l_irqc_unmask_tint_interrupt(struct rzg2l_irqc_pri=
v *priv,
> > > > +                                          unsigned int hwirq) {
> > > > +     u32 tmsk =3D readl_relaxed(priv->base + TMSK);
> > > > +     u32 bit =3D BIT(hwirq - IRQC_TINT_START);
> > > > +
> > > > +     writel_relaxed(tmsk & ~bit, priv->base + TMSK); }
> > > > +
> > > > +/* Must be called while priv->lock is held */ static void
> > > > +rzg2l_irqc_mask_once(struct rzg2l_irqc_priv *priv, unsigned int
> > > > +hwirq) {
> > > > +     if (!priv->data->mask_supported)
> > > > +             return;
> > > > +
> > > > +     if (hwirq >=3D IRQC_IRQ_START && hwirq <=3D IRQC_IRQ_COUNT)
> > > > +             rzg2l_irqc_mask_irq_interrupt(priv, hwirq);
> > > > +     else if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
> > > > +             rzg2l_irqc_mask_tint_interrupt(priv, hwirq); }
> > > > +
> > > > +static void rzg2l_irqc_mask(struct irq_data *d) {
> > > > +     struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > > > +
> > > > +     raw_spin_lock(&priv->lock);
> > > > +     rzg2l_irqc_mask_once(priv, irqd_to_hwirq(d));
> > > > +     raw_spin_unlock(&priv->lock);
> > > > +     irq_chip_mask_parent(d);
> > > > +}
> > > > +
> > > > +/* Must be called while priv->lock is held */ static void
> > > > +rzg2l_irqc_unmask_once(struct rzg2l_irqc_priv *priv, unsigned int
> > > > +hwirq) {
> > > > +     if (!priv->data->mask_supported)
> > > > +             return;
> > > > +
> > > > +     if (hwirq >=3D IRQC_IRQ_START && hwirq <=3D IRQC_IRQ_COUNT)
> > > > +             rzg2l_irqc_unmask_irq_interrupt(priv, hwirq);
> > > > +     else if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
> > > > +             rzg2l_irqc_unmask_tint_interrupt(priv, hwirq); }
> > > > +
> > > > +static void rzg2l_irqc_unmask(struct irq_data *d) {
> > > > +     struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > > > +
> > > > +     raw_spin_lock(&priv->lock);
> > > > +     rzg2l_irqc_unmask_once(priv, irqd_to_hwirq(d));
> > > > +     raw_spin_unlock(&priv->lock);
> > > > +     irq_chip_unmask_parent(d);
> > > > +}
> > > > +
> > > >  static void rzg2l_tint_irq_endisable(struct irq_data *d, bool
> > > > enable)  {
> > > > +     struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > > >       unsigned int hw_irq =3D irqd_to_hwirq(d);
> > > >
> > > >       if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
> > > > -             struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > > >               u32 offset =3D hw_irq - IRQC_TINT_START;
> > > >               u32 tssr_offset =3D TSSR_OFFSET(offset);
> > > >               u8 tssr_index =3D TSSR_INDEX(offset);
> > > >               u32 reg;
> > > >
> > > >               raw_spin_lock(&priv->lock);
> > > > +             if (enable)
> > > > +                     rzg2l_irqc_unmask_once(priv, hw_irq);
> > > > +             else
> > > > +                     rzg2l_irqc_mask_once(priv, hw_irq);
> > > >               reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
> > > >               if (enable)
> > > >                       reg |=3D TIEN << TSSEL_SHIFT(tssr_offset); @@
> > > > -157,6 +253,13 @@ static void rzg2l_tint_irq_endisable(struct irq_d=
ata *d, bool enable)
> > > >                       reg &=3D ~(TIEN << TSSEL_SHIFT(tssr_offset));
> > > >               writel_relaxed(reg, priv->base + TSSR(tssr_index));
> > > >               raw_spin_unlock(&priv->lock);
> > > > +     } else {
> > > > +             raw_spin_lock(&priv->lock);
> > > > +             if (enable)
> > > > +                     rzg2l_irqc_unmask_once(priv, hw_irq);
> > > > +             else
> > > > +                     rzg2l_irqc_mask_once(priv, hw_irq);
> > > > +             raw_spin_unlock(&priv->lock);
> > > >       }
> > > >  }
> > > >
> > > > @@ -324,8 +427,8 @@ static struct syscore_ops rzg2l_irqc_syscore_op=
s
> > > > =3D {  static const struct irq_chip irqc_chip =3D {
> > > >       .name                   =3D "rzg2l-irqc",
> > > >       .irq_eoi                =3D rzg2l_irqc_eoi,
> > > > -     .irq_mask               =3D irq_chip_mask_parent,
> > > > -     .irq_unmask             =3D irq_chip_unmask_parent,
> > > > +     .irq_mask               =3D rzg2l_irqc_mask,
> > > > +     .irq_unmask             =3D rzg2l_irqc_unmask,
> > >
> > > I feel this will be clean, if we have
> > >
> > > static const struct irq_chip rzg2l_irqc_chip =3D {
> > >         .name                   =3D "rzg2l-irqc",
> > >         ...
> > >         .irq_mask               =3D irq_chip_mask_parent,
> > >         .irq_unmask             =3D irq_chip_unmask_parent,
> > >         ....
> > > };
> > >
> > > static const struct irq_chip rzfive_irqc_chip =3D {
> > >         .name                   =3D "rzfive-irqc",
> > >         ...
> > >         .irq_mask               =3D rzfive_irqc_mask,
> > >         .irq_unmask             =3D rzfive_irqc_unmask,
> > >         ....
> > > };
> > >
> > > And passing this in rzg2l_irqc_init() and rzfive_irqc_init(), see
> > > below
> > >
> > > return rzg2l_irqc_init_helper(node, parent, & rzg2l_irqc_chip); retur=
n
> > > rzg2l_irqc_init_helper(node, parent, & rzfive_irqc_chip);
> > >
> > If we do the above we are stuck with "struct irq_chip" as data, for fur=
ther upcoming SoCs (for
> > example RZ/V2H) which have more features we need to pass custom data to=
 handle these features.
>
> That time device data can be extended like below
>
> struct rz_g2l_irq_chip {
>         struct irq_chip;
>         void *data; /* custom data */
> }
>
Ok, but i'll wait for Geert to come back on this as Geert suggested to
me to do it this way.

Cheers,
Prabhakar


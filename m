Return-Path: <linux-kernel+bounces-151091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9518AA8F8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0A81C2140D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0703F8F0;
	Fri, 19 Apr 2024 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi5PkCly"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A97D2E405;
	Fri, 19 Apr 2024 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510991; cv=none; b=DLSUTy2ecI1l9J7B0BlwUpNElF+Fp4qsfJ/DZ++kZ9y2JPggVehGnPvL/vd3vFDLTcDFqn/uRnjHzFd6z+d3LVK5OcKLhejvOG4kpeGR4ol9Mu9IIpWwTGOIVMUPdCPARdZ94WQNAThd/ssJ8GOQ68MZcS7cr7FIB07KnYMAN5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510991; c=relaxed/simple;
	bh=Y85GufN267M5q3vQNMugb4n4VfHedf2h/40lVzl2ngs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jz9e0c1BuS21r+hpyV0l/tIjFrCs9i99pQ/BNtmsmWY2e6ODfVq04rvHSnGpg4cJni2VWwLnAIxplAhxTbLNPD3Dy70fmAPLjDkUnBQdc6iqJ6lXQFZzt7SCdsHt2yaLeLfUSK8SfJn4XUPEBP2g3j6z4bNrfvKUIM05+WKjEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vi5PkCly; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-47a404c6decso550658137.3;
        Fri, 19 Apr 2024 00:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713510988; x=1714115788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HD6JFxJi0lpTHFJezgcfrmkM6oZDtRzUteVmU4chqDg=;
        b=Vi5PkClyfQHAqvc4oTQs3BEUE/SyTnu7rlqlPX98ztLbmQt6qMjzSyLVRQBqMoMzP2
         +GxmFmnxWqxRVubZTW3VQpy5sesOkDt5lnONFfBWmWyludonQc+oGHd59B84T5jTD2n2
         pDazZhmb8+bPgy33rjKzkhm3WkrtnKxsFru4B7ZwVeeMUj4seSj9Kn0UyE+0FwXn0MtZ
         WXeDc0Iz3uzrar9JyxJjZtw8HpLp0jhAKqu8RrSM7Yc4JDtTstf7NIov1V4Y9oLtKmui
         zosmh7cnfaQ1nep8hO7QQ6O7zJoywxfTL32/rsaQic8YV1I5FlvzxXPpciU2JmxLQDge
         FfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713510988; x=1714115788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HD6JFxJi0lpTHFJezgcfrmkM6oZDtRzUteVmU4chqDg=;
        b=N0lJOWgwAvcWsjrHZQ/9IlJEO6z8U5Ylb2sJy4WrRLgN5bf+dI+WZCmpQV8TSeTkKd
         t8SmBrNp5MF/DW88Ok+33nSGD/ukCR5/Sf0X2lFz61BGa3RQZlXgpnmQ5VEPZe5oxWiP
         dp/Q9zIHBaapFk4P9yKtNk6RWh0SSTY2pUCRVAvnJiEV0XvmCDmNfvnxyGrCDOdy0Ic2
         zu2Xb7wLgMSBhTPftkOFsFMKaoPGr0N5ya17oag+2wn6CJQt2nXvPXjaBBcy6zqebrVT
         ufUA8L6dXxwpvqKWXd7ZrKgaHJLxcdQz2eznBceE9qVluMHwBVd9jZMC7LRBFP5i9xMO
         ZQMg==
X-Forwarded-Encrypted: i=1; AJvYcCVUCw/4mphq/djWLEcihvX/4U2haEbYk2/7uPUxTnbq8Jyqqa8eSf6zMxnoIu1mI2iw29/jGTHjCrGeN/3mo3bBGpT8TJmOX7pXhoDZ2I/M6Bk3tQ5FkEkBGuy1/pqcVETXauOAd4V2NFOoVMEQTosLRH9VSfsenwmqe7rBhh64Ic3VzRkHLuEzWlTL
X-Gm-Message-State: AOJu0YxGm9iO1ghxvfzzYiNuJEGj356EM0p0oVzK7y3HN369fmyHgrX3
	HVbd7MDvfXtD0XbQtQOqikjUH+XLTFPblDLNgbT48s+jpfXKGXz0ZRljwrLeD/V30G6rwifHzlA
	LMfyqG6uzRpIHl4gEjRbQxt7x5l8=
X-Google-Smtp-Source: AGHT+IGCndvmseb3p3MnXDo+/i1gnW8qSw8y/flWDyPAF3EV3E87oR2svUTx8sF9W6z+xTG79i01GN3f+u1zvxe0yGc=
X-Received: by 2002:a05:6122:1da0:b0:4d4:ef9:71b0 with SMTP id
 gg32-20020a0561221da000b004d40ef971b0mr1031044vkb.7.1713510988185; Fri, 19
 Apr 2024 00:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240403203503.634465-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OSAPR01MB1587ED05696A111612424CF6863C2@OSAPR01MB1587.jpnprd01.prod.outlook.com>
 <CA+V-a8s94e9PLuLipQo+rGZ8g7UHxZJJAZZgvL3PQ4b8PKR2Xw@mail.gmail.com>
 <OSAPR01MB15878C2C2EE7905D33182CFF863C2@OSAPR01MB1587.jpnprd01.prod.outlook.com>
 <CA+V-a8vjB-A+BRSpxk-dsu6XMvpG1y2f8g+LYcWV+gh2cx+6+g@mail.gmail.com> <CAMuHMdV37mtC9FpY8wAFdG-NQWdvZ=qq9egVVukGhc=5ZrOTtg@mail.gmail.com>
In-Reply-To: <CAMuHMdV37mtC9FpY8wAFdG-NQWdvZ=qq9egVVukGhc=5ZrOTtg@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 19 Apr 2024 08:16:01 +0100
Message-ID: <CA+V-a8vA_7hJWBO3Lr4akZAoVS1V1qB8xZ1n8Sgs1EzXQpgReg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] irqchip/renesas-rzg2l: Add support for RZ/Five SoC
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Gleixner <tglx@linutronix.de>, 
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

Hi Geert,

On Thu, Apr 18, 2024 at 4:13=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Apr 4, 2024 at 3:35=E2=80=AFPM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Thu, Apr 4, 2024 at 2:31=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas=
com> wrote:
> > > > -----Original Message-----
> > > > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > > > On Thu, Apr 4, 2024 at 8:44=E2=80=AFAM Biju Das <biju.das.jz@bp.ren=
esas.com> wrote:
> > > > > > -----Original Message-----
> > > > > > From: Prabhakar <prabhakar.csengg@gmail.com>
> > > > > > The IX45 block has additional mask registers (NMSK/IMSK/TMSK) a=
s
> > > > > > compared to the RZ/G2L (family) SoC.
> > > > > >
> > > > > > Introduce masking/unmasking support for IRQ and TINT interrupts=
 in
> > > > > > IRQC controller driver. Two new registers, IMSK and TMSK, are
> > > > > > defined to handle masking on RZ/Five SoC. The implementation
> > > > > > utilizes a new data structure, `struct rzg2l_irqc_data`, to det=
ermine mask support for a
> > > > specific controller instance.
> > > > > >
> > > > > > Signed-off-by: Lad Prabhakar
> > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > ---
> > > > > > v1->v2
> > > > > > - Added IRQCHIP_MATCH() for RZ/Five
> > > > > > - Retaining a copy of OF data in priv
> > > > > > - Rebased the changes
> > > > > > ---
> > > > > >  drivers/irqchip/irq-renesas-rzg2l.c | 137
> > > > > > +++++++++++++++++++++++++++-
> > > > > >  1 file changed, 132 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/irqchip/irq-renesas-rzg2l.c
> > > > > > b/drivers/irqchip/irq-renesas-rzg2l.c
> > > > > > index f6484bf15e0b..6fa8d65605dc 100644
> > > > > > --- a/drivers/irqchip/irq-renesas-rzg2l.c
> > > > > > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > > > > > @@ -37,6 +37,8 @@
> > > > > >  #define TSSEL_SHIFT(n)                       (8 * (n))
> > > > > >  #define TSSEL_MASK                   GENMASK(7, 0)
> > > > > >  #define IRQ_MASK                     0x3
> > > > > > +#define IMSK                         0x10010
> > > > > > +#define TMSK                         0x10020
> > > > > >
> > > > > >  #define TSSR_OFFSET(n)                       ((n) % 4)
> > > > > >  #define TSSR_INDEX(n)                        ((n) / 4)
> > > > > > @@ -66,15 +68,25 @@ struct rzg2l_irqc_reg_cache {
> > > > > >       u32     titsr[2];
> > > > > >  };
> > > > > >
> > > > > > +/**
> > > > > > + * struct rzg2l_irqc_of_data - OF data structure
> > > > > > + * @mask_supported: Indicates if mask registers are available =
 */
> > > > > > +struct rzg2l_irqc_of_data {
> > > > > > +     bool    mask_supported;
> > > > > > +};
> > > > > > +
> > > > > >  /**
> > > > > >   * struct rzg2l_irqc_priv - IRQ controller private data struct=
ure
> > > > > >   * @base:    Controller's base address
> > > > > > + * @data:    OF data pointer
> > > > > >   * @fwspec:  IRQ firmware specific data
> > > > > >   * @lock:    Lock to serialize access to hardware registers
> > > > > >   * @cache:   Registers cache for suspend/resume
> > > > > >   */
> > > > > >  static struct rzg2l_irqc_priv {
> > > > > >       void __iomem                    *base;
> > > > > > +     const struct rzg2l_irqc_of_data *data;
> > > > > >       struct irq_fwspec               fwspec[IRQC_NUM_IRQ];
> > > > > >       raw_spinlock_t                  lock;
> > > > > >       struct rzg2l_irqc_reg_cache     cache;
> > > > > > @@ -138,18 +150,102 @@ static void rzg2l_irqc_eoi(struct irq_da=
ta *d)
> > > > > >       irq_chip_eoi_parent(d);
> > > > > >  }
> > > > > >
> > > > > > +static void rzg2l_irqc_mask_irq_interrupt(struct rzg2l_irqc_pr=
iv *priv,
> > > > > > +                                       unsigned int hwirq) {
> > > > > > +     u32 imsk =3D readl_relaxed(priv->base + IMSK);
> > > > > > +     u32 bit =3D BIT(hwirq - IRQC_IRQ_START);
> > > > > > +
> > > > > > +     writel_relaxed(imsk | bit, priv->base + IMSK); }
> > > > > > +
> > > > > > +static void rzg2l_irqc_unmask_irq_interrupt(struct rzg2l_irqc_=
priv *priv,
> > > > > > +                                         unsigned int hwirq) {
> > > > > > +     u32 imsk =3D readl_relaxed(priv->base + IMSK);
> > > > > > +     u32 bit =3D BIT(hwirq - IRQC_IRQ_START);
> > > > > > +
> > > > > > +     writel_relaxed(imsk & ~bit, priv->base + IMSK); }
> > > > > > +
> > > > > > +static void rzg2l_irqc_mask_tint_interrupt(struct rzg2l_irqc_p=
riv *priv,
> > > > > > +                                        unsigned int hwirq) {
> > > > > > +     u32 tmsk =3D readl_relaxed(priv->base + TMSK);
> > > > > > +     u32 bit =3D BIT(hwirq - IRQC_TINT_START);
> > > > > > +
> > > > > > +     writel_relaxed(tmsk | bit, priv->base + TMSK); }
> > > > > > +
> > > > > > +static void rzg2l_irqc_unmask_tint_interrupt(struct rzg2l_irqc=
_priv *priv,
> > > > > > +                                          unsigned int hwirq) =
{
> > > > > > +     u32 tmsk =3D readl_relaxed(priv->base + TMSK);
> > > > > > +     u32 bit =3D BIT(hwirq - IRQC_TINT_START);
> > > > > > +
> > > > > > +     writel_relaxed(tmsk & ~bit, priv->base + TMSK); }
> > > > > > +
> > > > > > +/* Must be called while priv->lock is held */ static void
> > > > > > +rzg2l_irqc_mask_once(struct rzg2l_irqc_priv *priv, unsigned in=
t
> > > > > > +hwirq) {
> > > > > > +     if (!priv->data->mask_supported)
> > > > > > +             return;
> > > > > > +
> > > > > > +     if (hwirq >=3D IRQC_IRQ_START && hwirq <=3D IRQC_IRQ_COUN=
T)
> > > > > > +             rzg2l_irqc_mask_irq_interrupt(priv, hwirq);
> > > > > > +     else if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_I=
RQ)
> > > > > > +             rzg2l_irqc_mask_tint_interrupt(priv, hwirq); }
> > > > > > +
> > > > > > +static void rzg2l_irqc_mask(struct irq_data *d) {
> > > > > > +     struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > > > > > +
> > > > > > +     raw_spin_lock(&priv->lock);
> > > > > > +     rzg2l_irqc_mask_once(priv, irqd_to_hwirq(d));
> > > > > > +     raw_spin_unlock(&priv->lock);
> > > > > > +     irq_chip_mask_parent(d);
> > > > > > +}
> > > > > > +
> > > > > > +/* Must be called while priv->lock is held */ static void
> > > > > > +rzg2l_irqc_unmask_once(struct rzg2l_irqc_priv *priv, unsigned =
int
> > > > > > +hwirq) {
> > > > > > +     if (!priv->data->mask_supported)
> > > > > > +             return;
> > > > > > +
> > > > > > +     if (hwirq >=3D IRQC_IRQ_START && hwirq <=3D IRQC_IRQ_COUN=
T)
> > > > > > +             rzg2l_irqc_unmask_irq_interrupt(priv, hwirq);
> > > > > > +     else if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_I=
RQ)
> > > > > > +             rzg2l_irqc_unmask_tint_interrupt(priv, hwirq); }
> > > > > > +
> > > > > > +static void rzg2l_irqc_unmask(struct irq_data *d) {
> > > > > > +     struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > > > > > +
> > > > > > +     raw_spin_lock(&priv->lock);
> > > > > > +     rzg2l_irqc_unmask_once(priv, irqd_to_hwirq(d));
> > > > > > +     raw_spin_unlock(&priv->lock);
> > > > > > +     irq_chip_unmask_parent(d);
> > > > > > +}
> > > > > > +
> > > > > >  static void rzg2l_tint_irq_endisable(struct irq_data *d, bool
> > > > > > enable)  {
> > > > > > +     struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > > > > >       unsigned int hw_irq =3D irqd_to_hwirq(d);
> > > > > >
> > > > > >       if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)=
 {
> > > > > > -             struct rzg2l_irqc_priv *priv =3D irq_data_to_priv=
(d);
> > > > > >               u32 offset =3D hw_irq - IRQC_TINT_START;
> > > > > >               u32 tssr_offset =3D TSSR_OFFSET(offset);
> > > > > >               u8 tssr_index =3D TSSR_INDEX(offset);
> > > > > >               u32 reg;
> > > > > >
> > > > > >               raw_spin_lock(&priv->lock);
> > > > > > +             if (enable)
> > > > > > +                     rzg2l_irqc_unmask_once(priv, hw_irq);
> > > > > > +             else
> > > > > > +                     rzg2l_irqc_mask_once(priv, hw_irq);
> > > > > >               reg =3D readl_relaxed(priv->base + TSSR(tssr_inde=
x));
> > > > > >               if (enable)
> > > > > >                       reg |=3D TIEN << TSSEL_SHIFT(tssr_offset)=
; @@
> > > > > > -157,6 +253,13 @@ static void rzg2l_tint_irq_endisable(struct i=
rq_data *d, bool enable)
> > > > > >                       reg &=3D ~(TIEN << TSSEL_SHIFT(tssr_offse=
t));
> > > > > >               writel_relaxed(reg, priv->base + TSSR(tssr_index)=
);
> > > > > >               raw_spin_unlock(&priv->lock);
> > > > > > +     } else {
> > > > > > +             raw_spin_lock(&priv->lock);
> > > > > > +             if (enable)
> > > > > > +                     rzg2l_irqc_unmask_once(priv, hw_irq);
> > > > > > +             else
> > > > > > +                     rzg2l_irqc_mask_once(priv, hw_irq);
> > > > > > +             raw_spin_unlock(&priv->lock);
> > > > > >       }
> > > > > >  }
> > > > > >
> > > > > > @@ -324,8 +427,8 @@ static struct syscore_ops rzg2l_irqc_syscor=
e_ops
> > > > > > =3D {  static const struct irq_chip irqc_chip =3D {
> > > > > >       .name                   =3D "rzg2l-irqc",
> > > > > >       .irq_eoi                =3D rzg2l_irqc_eoi,
> > > > > > -     .irq_mask               =3D irq_chip_mask_parent,
> > > > > > -     .irq_unmask             =3D irq_chip_unmask_parent,
> > > > > > +     .irq_mask               =3D rzg2l_irqc_mask,
> > > > > > +     .irq_unmask             =3D rzg2l_irqc_unmask,
> > > > >
> > > > > I feel this will be clean, if we have
> > > > >
> > > > > static const struct irq_chip rzg2l_irqc_chip =3D {
> > > > >         .name                   =3D "rzg2l-irqc",
> > > > >         ...
> > > > >         .irq_mask               =3D irq_chip_mask_parent,
> > > > >         .irq_unmask             =3D irq_chip_unmask_parent,
> > > > >         ....
> > > > > };
> > > > >
> > > > > static const struct irq_chip rzfive_irqc_chip =3D {
> > > > >         .name                   =3D "rzfive-irqc",
> > > > >         ...
> > > > >         .irq_mask               =3D rzfive_irqc_mask,
> > > > >         .irq_unmask             =3D rzfive_irqc_unmask,
> > > > >         ....
> > > > > };
> > > > >
> > > > > And passing this in rzg2l_irqc_init() and rzfive_irqc_init(), see
> > > > > below
> > > > >
> > > > > return rzg2l_irqc_init_helper(node, parent, & rzg2l_irqc_chip); r=
eturn
> > > > > rzg2l_irqc_init_helper(node, parent, & rzfive_irqc_chip);
> > > > >
> > > > If we do the above we are stuck with "struct irq_chip" as data, for=
 further upcoming SoCs (for
> > > > example RZ/V2H) which have more features we need to pass custom dat=
a to handle these features.
> > >
> > > That time device data can be extended like below
> > >
> > > struct rz_g2l_irq_chip {
> > >         struct irq_chip;
> > >         void *data; /* custom data */
> > > }
> > >
> > Ok, but i'll wait for Geert to come back on this as Geert suggested to
> > me to do it this way.
>
> I agree with Biju.
>
> Having separate irq_chips lets us avoid taking the spinlock on RZ/G2L.
>
Agreed, I will add separate irq_chips.

Cheers,
Prabhakar


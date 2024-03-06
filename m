Return-Path: <linux-kernel+bounces-93393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8016B872F06
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3E11F272E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016755BAEA;
	Wed,  6 Mar 2024 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="I2lBLQ+3"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FB15BAD5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709707979; cv=none; b=G/wClovd37G1wXBJzvU9c9UwFLlozwiQyG4ST78oVInOzaVP/E/1gwn1YZ+TznrRqTuW9PG+Br1JUrVBSsz16jRszvJwsfnV5rhy+EyAEmLklVqhIkosRZ3+OZUGHyVhRnkVfFERLmat9tAB7LlGiGmSOapZLiKmDQFVskmj4sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709707979; c=relaxed/simple;
	bh=BFX6/hyhphclh8Y40wiqNq2vAHZEiCMUjxI1lJHccTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZL/xeYYz/LowcubBOym6XglUDLBNLG+v0EQshJ+G9rl9gGfUs5u5OzgIfG2NKGStXRBYG9NClnK1YnFqcecrV/MZmUDF3sYmopWOo+FGc9NT15bSN+Y5kGew/IKcoAvRVYm7HiWPUSazW6bqX87Puoodl3gQafcUxtDOoG0fNck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=I2lBLQ+3; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7c871f86be2so41560839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 22:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1709707977; x=1710312777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNgbJZkNG5ga0f2uBfkLwM+7vHkiEu8X6WIn4AnVpJE=;
        b=I2lBLQ+3ldgZBubMleGymx+219Ww62L9QyOKBrXb5LLmaCUcSNXSzy5Sztoks5PpJq
         zCEnJ11Be5LrOvMfDpMloWdmK2BJ2CdgngwyQJ2BZERVpj3EUWatpjRoRuJXSj9tTQRp
         uEK0kYLi/GvrJNdlDUlzdbjwQ7QRTnlAfQ2pusOY/mIj+Cs3gXQ6eKfOTfHRBefaYBGj
         V07JkEWeNF0hrm/DDA1m9YM0/+dS8qcW6/BpJHTgqoRbraFGLLmjwSJ2xHDT1VWUOe+7
         PooXjUwHBeZv0WAJ3Il7KrvhQL47T7UdkM7Ir5n+2JECpYiiuT5xccMaUkejxY6RLY0A
         PxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709707977; x=1710312777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNgbJZkNG5ga0f2uBfkLwM+7vHkiEu8X6WIn4AnVpJE=;
        b=Kyxbu+Sjyx8dZJpEyHJ8ZKpq+Ef5XrI+yWn4b+i+9hyPS6BDzYbnicLw1CyxkbbKT8
         1TYZzSrfHAN4b0GdT0qTqSUoQ//C0BDUBR8FNIkyADpo0FWsIqJYz8JQvY07kTWl4WER
         UuNmIOaZFvX3jPyOegFMb3DCrqAsa9jBLh4InF+a7FW1BKIWpL0iyjtE+dxa1gQPpvPY
         Qis8vfzlwMUZe9ICxWTItocU0nn67lXfr+Pmcbqo9e5dHnFJsuBP7zdx6bnRgeTkvR3u
         SXcOJe5XATPebTo/ycVk9ol5VlneDrHMndxP4M4niKnEB0eqYfQU/0mBcX9wfiUtgfaU
         2X7w==
X-Forwarded-Encrypted: i=1; AJvYcCXTk6fRcoMy96wfRmu4IAtMVZ0NTKo11mKmMYz7z+u8uQDqq53l5dQEt/wSnqzlBKnoUX5rixCuq4yXOMtEETeqe6ynlQEORM7ItE35
X-Gm-Message-State: AOJu0YyrwMZMHp+ybi8mMxrUX1UlhPneXHjHHiMn9YAyGP0iwusFheGe
	9G65fjl0iun/+QseJ229IPo4/82CJyQR0/JkLBP7oTTnj7XoMZjYlv7tRLpznQ64zjuPBzLZ2Bt
	cMt7cYdn4NeYb6ORz7jw6XESI6QvW79ZCQehlPw==
X-Google-Smtp-Source: AGHT+IGAyK0wcF6zeeg67A+TYJYKNi/u5Qx+fxssY9cdDT20xO52J5Vr4LCLRSOOXqYuxTAEtxVLwNigFsNQbg2xwWM=
X-Received: by 2002:a05:6e02:1d13:b0:365:75b2:a330 with SMTP id
 i19-20020a056e021d1300b0036575b2a330mr18642509ila.13.1709707976635; Tue, 05
 Mar 2024 22:52:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226040746.1396416-1-apatel@ventanamicro.com>
 <20240226040746.1396416-9-apatel@ventanamicro.com> <8a0c321a-6b61-40d0-98d4-6c2c868da45e@sifive.com>
In-Reply-To: <8a0c321a-6b61-40d0-98d4-6c2c868da45e@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 6 Mar 2024 12:22:44 +0530
Message-ID: <CAAhSdy1PjSLZ5rTeQdN5NDW+9HO4dF-Sh8XjO72UZKNj+ROU2A@mail.gmail.com>
Subject: Re: [PATCH v15 08/10] irqchip/riscv-aplic: Add support for MSI-mode
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 11:13=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Anup,
>
> On 2024-02-25 10:07 PM, Anup Patel wrote:
> > The RISC-V advanced platform-level interrupt controller (APLIC) has
> > two modes of operation: 1) Direct mode and 2) MSI mode.
> > (For more details, refer https://github.com/riscv/riscv-aia)
> >
> > In APLIC MSI-mode, wired interrupts are forwared as message signaled
> > interrupts (MSIs) to CPUs via IMSIC.
> >
> > Extend the existing APLIC irqchip driver to support MSI-mode for
> > RISC-V platforms having both wired interrupts and MSIs.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/irqchip/Kconfig                |   6 +
> >  drivers/irqchip/Makefile               |   1 +
> >  drivers/irqchip/irq-riscv-aplic-main.c |   2 +-
> >  drivers/irqchip/irq-riscv-aplic-main.h |   8 +
> >  drivers/irqchip/irq-riscv-aplic-msi.c  | 263 +++++++++++++++++++++++++
> >  5 files changed, 279 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/irqchip/irq-riscv-aplic-msi.c
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index dbc8811d3764..806b5fccb3e8 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -551,6 +551,12 @@ config RISCV_APLIC
> >       depends on RISCV
> >       select IRQ_DOMAIN_HIERARCHY
> >
> > +config RISCV_APLIC_MSI
> > +     bool
> > +     depends on RISCV_APLIC
> > +     select GENERIC_MSI_IRQ
> > +     default RISCV_APLIC
> > +
> >  config RISCV_IMSIC
> >       bool
> >       depends on RISCV
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index 7f8289790ed8..47995fdb2c60 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -96,6 +96,7 @@ obj-$(CONFIG_CSKY_MPINTC)           +=3D irq-csky-mpi=
ntc.o
> >  obj-$(CONFIG_CSKY_APB_INTC)          +=3D irq-csky-apb-intc.o
> >  obj-$(CONFIG_RISCV_INTC)             +=3D irq-riscv-intc.o
> >  obj-$(CONFIG_RISCV_APLIC)            +=3D irq-riscv-aplic-main.o irq-r=
iscv-aplic-direct.o
> > +obj-$(CONFIG_RISCV_APLIC_MSI)                +=3D irq-riscv-aplic-msi.=
o
> >  obj-$(CONFIG_RISCV_IMSIC)            +=3D irq-riscv-imsic-state.o irq-=
riscv-imsic-early.o irq-riscv-imsic-platform.o
> >  obj-$(CONFIG_SIFIVE_PLIC)            +=3D irq-sifive-plic.o
> >  obj-$(CONFIG_IMX_IRQSTEER)           +=3D irq-imx-irqsteer.o
> > diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/i=
rq-riscv-aplic-main.c
> > index 160ff99d6979..774a0c97fdab 100644
> > --- a/drivers/irqchip/irq-riscv-aplic-main.c
> > +++ b/drivers/irqchip/irq-riscv-aplic-main.c
> > @@ -187,7 +187,7 @@ static int aplic_probe(struct platform_device *pdev=
)
> >       if (is_of_node(dev->fwnode))
> >               msi_mode =3D of_property_present(to_of_node(dev->fwnode),=
 "msi-parent");
> >       if (msi_mode)
> > -             rc =3D -ENODEV;
> > +             rc =3D aplic_msi_setup(dev, regs);
> >       else
> >               rc =3D aplic_direct_setup(dev, regs);
> >       if (rc)
> > diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/i=
rq-riscv-aplic-main.h
> > index 4cfbadf37ddc..4393927d8c80 100644
> > --- a/drivers/irqchip/irq-riscv-aplic-main.h
> > +++ b/drivers/irqchip/irq-riscv-aplic-main.h
> > @@ -40,5 +40,13 @@ int aplic_irqdomain_translate(struct irq_fwspec *fws=
pec, u32 gsi_base,
> >  void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode);
> >  int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void=
 __iomem *regs);
> >  int aplic_direct_setup(struct device *dev, void __iomem *regs);
> > +#ifdef CONFIG_RISCV_APLIC_MSI
> > +int aplic_msi_setup(struct device *dev, void __iomem *regs);
> > +#else
> > +static inline int aplic_msi_setup(struct device *dev, void __iomem *re=
gs)
> > +{
> > +     return -ENODEV;
> > +}
> > +#endif
> >
> >  #endif
> > diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/ir=
q-riscv-aplic-msi.c
> > new file mode 100644
> > index 000000000000..b2a25e011bb2
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-riscv-aplic-msi.c
> > @@ -0,0 +1,263 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + * Copyright (C) 2022 Ventana Micro Systems Inc.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/cpu.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqchip/riscv-aplic.h>
> > +#include <linux/irqchip/riscv-imsic.h>
> > +#include <linux/module.h>
> > +#include <linux/msi.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/printk.h>
> > +#include <linux/smp.h>
> > +
> > +#include "irq-riscv-aplic-main.h"
> > +
> > +static void aplic_msi_irq_unmask(struct irq_data *d)
> > +{
> > +     aplic_irq_unmask(d);
> > +     irq_chip_unmask_parent(d);
> > +}
> > +
> > +static void aplic_msi_irq_mask(struct irq_data *d)
> > +{
> > +     irq_chip_mask_parent(d);
> > +     aplic_irq_mask(d);
>
> Surely it's not necessary to mask an interrupt at both the APLIC and the
> receiver of the MSI. This ends up with __imsic_local_sync() in the hot pa=
th,
> which adds significant overhead.

It's necessary to mask at both places because __imsic_local_sync()
may happen on another CPU allowing another MSI to sneak-in. Also,
we are doing the exact same thing for PCI devices as well.

>
> I would suggest the following:
>
>         .irq_mask       =3D aplic_irq_mask,
>         .irq_unmask     =3D aplic_irq_unmask,
>         .irq_enable     =3D irq_chip_enable_parent,
>         .irq_disable    =3D irq_chip_disable_parent,

The x86 and ARM drivers don't do it this way so I am not sure why
we should.

>
> > +}
> > +
> > +static void aplic_msi_irq_eoi(struct irq_data *d)
> > +{
> > +     struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +     u32 reg_off, reg_mask;
> > +
> > +     /*
> > +      * EOI handling is required only for level-triggered interrupts
> > +      * when APLIC is in MSI mode.
> > +      */
> > +
> > +     reg_off =3D APLIC_CLRIP_BASE + ((d->hwirq / APLIC_IRQBITS_PER_REG=
) * 4);
> > +     reg_mask =3D BIT(d->hwirq % APLIC_IRQBITS_PER_REG);
> > +     switch (irqd_get_trigger_type(d)) {
> > +     case IRQ_TYPE_LEVEL_LOW:
> > +             /*
> > +              * If the rectified input value of the source is still lo=
w
> > +              * then set the interrupt pending bit so that interrupt i=
s
> > +              * re-triggered via MSI.
> > +              */
> > +             if (!(readl(priv->regs + reg_off) & reg_mask))
> > +                     writel(d->hwirq, priv->regs + APLIC_SETIPNUM_LE);
>
> When a level-low interrupt is active, the rectified input value is high, =
so this
> case can be combined with the level-high case below.
>
> In fact, there's no need to check the input value at all. The AIA spec me=
ntions
> this interrupt flow explicitly (section 4.9.2, see also section 4.7):
>
> "A second option is for the interrupt service routine to write the APLIC=
=E2=80=99s
> source identity number for the interrupt to the domain=E2=80=99s setipnum=
 register just
> before exiting. This will cause the interrupt=E2=80=99s pending bit to be=
 set to one
> again if the source is still asserting an interrupt, but not if the sourc=
e is
> not asserting an interrupt."

Ahh, good catch. I will update it in the next revision.

This would certainly help reduce one MMIO-trap for KVM RISC-V since
we trap-n-emulate APLIC.

>
> Unfortunately, QEMU currently gets this wrong, so the input value check i=
s
> necessary for testing this series until QEMU is fixed.

I will send the QEMU patch as well.

>
> > +             break;
> > +     case IRQ_TYPE_LEVEL_HIGH:
> > +             /*
> > +              * If the rectified input value of the source is still hi=
gh
> > +              * then set the interrupt pending bit so that interrupt i=
s
> > +              * re-triggered via MSI.
> > +              */
> > +             if (readl(priv->regs + reg_off) & reg_mask)
> > +                     writel(d->hwirq, priv->regs + APLIC_SETIPNUM_LE);
> > +             break;
> > +     }
> > +}
> > +
> > +static void aplic_msi_write_msg(struct irq_data *d, struct msi_msg *ms=
g)
> > +{
> > +     unsigned int group_index, hart_index, guest_index, val;
> > +     struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +     struct aplic_msicfg *mc =3D &priv->msicfg;
> > +     phys_addr_t tppn, tbppn, msg_addr;
> > +     void __iomem *target;
> > +
> > +     /* For zeroed MSI, simply write zero into the target register */
> > +     if (!msg->address_hi && !msg->address_lo && !msg->data) {
> > +             target =3D priv->regs + APLIC_TARGET_BASE;
> > +             target +=3D (d->hwirq - 1) * sizeof(u32);
> > +             writel(0, target);
> > +             return;
> > +     }
> > +
> > +     /* Sanity check on message data */
> > +     WARN_ON(msg->data > APLIC_TARGET_EIID_MASK);
> > +
> > +     /* Compute target MSI address */
> > +     msg_addr =3D (((u64)msg->address_hi) << 32) | msg->address_lo;
> > +     tppn =3D msg_addr >> APLIC_xMSICFGADDR_PPN_SHIFT;
> > +
> > +     /* Compute target HART Base PPN */
> > +     tbppn =3D tppn;
> > +     tbppn &=3D ~APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
> > +     tbppn &=3D ~APLIC_xMSICFGADDR_PPN_LHX(mc->lhxw, mc->lhxs);
> > +     tbppn &=3D ~APLIC_xMSICFGADDR_PPN_HHX(mc->hhxw, mc->hhxs);
> > +     WARN_ON(tbppn !=3D mc->base_ppn);
> > +
> > +     /* Compute target group and hart indexes */
> > +     group_index =3D (tppn >> APLIC_xMSICFGADDR_PPN_HHX_SHIFT(mc->hhxs=
)) &
> > +                  APLIC_xMSICFGADDR_PPN_HHX_MASK(mc->hhxw);
> > +     hart_index =3D (tppn >> APLIC_xMSICFGADDR_PPN_LHX_SHIFT(mc->lhxs)=
) &
> > +                  APLIC_xMSICFGADDR_PPN_LHX_MASK(mc->lhxw);
> > +     hart_index |=3D (group_index << mc->lhxw);
> > +     WARN_ON(hart_index > APLIC_TARGET_HART_IDX_MASK);
> > +
> > +     /* Compute target guest index */
> > +     guest_index =3D tppn & APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
> > +     WARN_ON(guest_index > APLIC_TARGET_GUEST_IDX_MASK);
> > +
> > +     /* Update IRQ TARGET register */
> > +     target =3D priv->regs + APLIC_TARGET_BASE;
> > +     target +=3D (d->hwirq - 1) * sizeof(u32);
> > +     val =3D FIELD_PREP(APLIC_TARGET_HART_IDX, hart_index);
> > +     val |=3D FIELD_PREP(APLIC_TARGET_GUEST_IDX, guest_index);
> > +     val |=3D FIELD_PREP(APLIC_TARGET_EIID, msg->data);
> > +     writel(val, target);
> > +}
> > +
> > +static void aplic_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc =
*desc)
> > +{
> > +     arg->desc =3D desc;
> > +     arg->hwirq =3D (u32)desc->data.icookie.value;
> > +}
> > +
> > +static int aplic_msi_translate(struct irq_domain *d, struct irq_fwspec=
 *fwspec,
> > +                            unsigned long *hwirq, unsigned int *type)
> > +{
> > +     struct msi_domain_info *info =3D d->host_data;
> > +     struct aplic_priv *priv =3D info->data;
> > +
> > +     return aplic_irqdomain_translate(fwspec, priv->gsi_base, hwirq, t=
ype);
> > +}
> > +
> > +static const struct msi_domain_template aplic_msi_template =3D {
> > +     .chip =3D {
> > +             .name                   =3D "APLIC-MSI",
> > +             .irq_mask               =3D aplic_msi_irq_mask,
> > +             .irq_unmask             =3D aplic_msi_irq_unmask,
> > +             .irq_set_type           =3D aplic_irq_set_type,
> > +             .irq_eoi                =3D aplic_msi_irq_eoi,
> > +#ifdef CONFIG_SMP
> > +             .irq_set_affinity       =3D irq_chip_set_affinity_parent,
> > +#endif
> > +             .irq_write_msi_msg      =3D aplic_msi_write_msg,
> > +             .flags                  =3D IRQCHIP_SET_TYPE_MASKED |
> > +                                       IRQCHIP_SKIP_SET_WAKE |
> > +                                       IRQCHIP_MASK_ON_SUSPEND,
> > +     },
> > +
> > +     .ops =3D {
> > +             .set_desc               =3D aplic_msi_set_desc,
> > +             .msi_translate          =3D aplic_msi_translate,
> > +     },
> > +
> > +     .info =3D {
> > +             .bus_token              =3D DOMAIN_BUS_WIRED_TO_MSI,
> > +             .flags                  =3D MSI_FLAG_USE_DEV_FWNODE,
> > +             .handler                =3D handle_fasteoi_irq,
>
> msi_domain_ops_init() requires .handler_name to be set, or .handler is ig=
nored.
> Either that needs to be changed, or .handler_name needs to be provided he=
re.
> Since the handler is not set, currently the EOI logic for level interrupt=
s is
> never run.

That's right, I will update in the next revision.

Regards,
Anup

>
> Regards,
> Samuel
>
> > +     },
> > +};
> > +
> > +int aplic_msi_setup(struct device *dev, void __iomem *regs)
> > +{
> > +     const struct imsic_global_config *imsic_global;
> > +     struct aplic_priv *priv;
> > +     struct aplic_msicfg *mc;
> > +     phys_addr_t pa;
> > +     int rc;
> > +
> > +     priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     rc =3D aplic_setup_priv(priv, dev, regs);
> > +     if (rc) {
> > +             dev_err(dev, "failed to create APLIC context\n");
> > +             return rc;
> > +     }
> > +     mc =3D &priv->msicfg;
> > +
> > +     /*
> > +      * The APLIC outgoing MSI config registers assume target MSI
> > +      * controller to be RISC-V AIA IMSIC controller.
> > +      */
> > +     imsic_global =3D imsic_get_global_config();
> > +     if (!imsic_global) {
> > +             dev_err(dev, "IMSIC global config not found\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     /* Find number of guest index bits (LHXS) */
> > +     mc->lhxs =3D imsic_global->guest_index_bits;
> > +     if (APLIC_xMSICFGADDRH_LHXS_MASK < mc->lhxs) {
> > +             dev_err(dev, "IMSIC guest index bits big for APLIC LHXS\n=
");
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Find number of HART index bits (LHXW) */
> > +     mc->lhxw =3D imsic_global->hart_index_bits;
> > +     if (APLIC_xMSICFGADDRH_LHXW_MASK < mc->lhxw) {
> > +             dev_err(dev, "IMSIC hart index bits big for APLIC LHXW\n"=
);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Find number of group index bits (HHXW) */
> > +     mc->hhxw =3D imsic_global->group_index_bits;
> > +     if (APLIC_xMSICFGADDRH_HHXW_MASK < mc->hhxw) {
> > +             dev_err(dev, "IMSIC group index bits big for APLIC HHXW\n=
");
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Find first bit position of group index (HHXS) */
> > +     mc->hhxs =3D imsic_global->group_index_shift;
> > +     if (mc->hhxs < (2 * APLIC_xMSICFGADDR_PPN_SHIFT)) {
> > +             dev_err(dev, "IMSIC group index shift should be >=3D %d\n=
",
> > +                     (2 * APLIC_xMSICFGADDR_PPN_SHIFT));
> > +             return -EINVAL;
> > +     }
> > +     mc->hhxs -=3D (2 * APLIC_xMSICFGADDR_PPN_SHIFT);
> > +     if (APLIC_xMSICFGADDRH_HHXS_MASK < mc->hhxs) {
> > +             dev_err(dev, "IMSIC group index shift big for APLIC HHXS\=
n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Compute PPN base */
> > +     mc->base_ppn =3D imsic_global->base_addr >> APLIC_xMSICFGADDR_PPN=
_SHIFT;
> > +     mc->base_ppn &=3D ~APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
> > +     mc->base_ppn &=3D ~APLIC_xMSICFGADDR_PPN_LHX(mc->lhxw, mc->lhxs);
> > +     mc->base_ppn &=3D ~APLIC_xMSICFGADDR_PPN_HHX(mc->hhxw, mc->hhxs);
> > +
> > +     /* Setup global config and interrupt delivery */
> > +     aplic_init_hw_global(priv, true);
> > +
> > +     /* Set the APLIC device MSI domain if not available */
> > +     if (!dev_get_msi_domain(dev)) {
> > +             /*
> > +              * The device MSI domain for OF devices is only set at th=
e
> > +              * time of populating/creating OF device. If the device M=
SI
> > +              * domain is discovered later after the OF device is crea=
ted
> > +              * then we need to set it explicitly before using any pla=
tform
> > +              * MSI functions.
> > +              *
> > +              * In case of APLIC device, the parent MSI domain is alwa=
ys
> > +              * IMSIC and the IMSIC MSI domains are created later thro=
ugh
> > +              * the platform driver probing so we set it explicitly he=
re.
> > +              */
> > +             if (is_of_node(dev->fwnode))
> > +                     of_msi_configure(dev, to_of_node(dev->fwnode));
> > +     }
> > +
> > +     if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, &aplic=
_msi_template,
> > +                                       priv->nr_irqs + 1, priv, priv))=
 {
> > +             dev_err(dev, "failed to create MSI irq domain\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     /* Advertise the interrupt controller */
> > +     pa =3D priv->msicfg.base_ppn << APLIC_xMSICFGADDR_PPN_SHIFT;
> > +     dev_info(dev, "%d interrupts forwared to MSI base %pa\n", priv->n=
r_irqs, &pa);
> > +
> > +     return 0;
> > +}
>


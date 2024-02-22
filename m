Return-Path: <linux-kernel+bounces-76672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5065E85FAC1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42791F2635F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234AD14F9D2;
	Thu, 22 Feb 2024 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIWgfYuU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640221482F7;
	Thu, 22 Feb 2024 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610745; cv=none; b=IrMxD3XOXlqHptKebO+wOMK8FBYaIM8V0I68fGfuj8y9ULnebZ5LxC7Sz5GPhpdrDHuPeKQbKW5AzzolVGMd6H9TfgYq1xfZbp+uuBR2GkqQvbMmBqNiD3mzVk9H0fYwaPWufQnxTzi6LfN8PbjIdzG96ckW8elVakslpjgAcvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610745; c=relaxed/simple;
	bh=3oLeLa6rd2L74GgGe1DmbMXwWVI+cNrH91RsxvM/HdU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CtkgZQ/YiORuA4eCX3u9uUjOlFrHHpIXsECMFEGBsTQ8CnjpTPa4IO6ARj+CMbIkmJKv9t6uwHFPn0iSyttimd9MwYTQ2W0dlFujEJ4RpnBto8XVFRUsLWEg6il8TNtN3bSyUGztFueZvRKL9MdpyjCGHvsHegO5YyBijcWrS0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIWgfYuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFFAC43390;
	Thu, 22 Feb 2024 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708610745;
	bh=3oLeLa6rd2L74GgGe1DmbMXwWVI+cNrH91RsxvM/HdU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GIWgfYuUsPS4XvVO2lTxlI17U35koeY34HM6mt79Jdy7hxI109bKBGWOs/zgGbOwj
	 c5G4vORDQGBHPM/buap+bKoyjEnq1COlebNehisFZdyb7KMz14Vaw6pGu427gsqxoB
	 ze8LKrgoEqYOuxTFFufpQJuOqjel2fpCpj4LSQGKlV9xbWSptu/UmoyicZdGThVqHN
	 BmqMWhQc3A9RCrxc1M/13CwnB0Me43A1TV3WAtYkKDBnHrDUpTS5M8NP6JBNDyVVVB
	 pyX/9/tKgD7jyxA620LQigX1ApQ7KfH5puEh+QMQgDYgALF12EIuWct9Ev4v9A0IGw
	 9fNADVe3cCeaA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Anup Patel <anup@brainfault.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas
 Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>, Marc
 Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, Atish Patra
 <atishp@atishpatra.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Andrew Jones
 <ajones@ventanamicro.com>
Subject: Re: [PATCH v14 13/18] irqchip/riscv-imsic: Add device MSI domain
 support for PCI devices
In-Reply-To: <CAAhSdy3DtDFnZKQLXXJ2OPPSv5s8bbGvm8Mmqhg_F2rPneQ3sw@mail.gmail.com>
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-14-apatel@ventanamicro.com>
 <87msrstzck.fsf@all.your.base.are.belong.to.us>
 <CAAhSdy3DtDFnZKQLXXJ2OPPSv5s8bbGvm8Mmqhg_F2rPneQ3sw@mail.gmail.com>
Date: Thu, 22 Feb 2024 15:05:41 +0100
Message-ID: <87edd4twzu.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <anup@brainfault.org> writes:

> On Thu, Feb 22, 2024 at 6:44=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> Anup Patel <apatel@ventanamicro.com> writes:
>>
>> > The Linux PCI framework supports per-device MSI domains for PCI devices
>> > so extend the IMSIC driver to allow PCI per-device MSI domains.
>> >
>> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>> > ---
>> >  drivers/irqchip/Kconfig                    |  7 +++++
>> >  drivers/irqchip/irq-riscv-imsic-platform.c | 35 ++++++++++++++++++++--
>> >  2 files changed, 40 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> > index 85f86e31c996..2fc0cb32341a 100644
>> > --- a/drivers/irqchip/Kconfig
>> > +++ b/drivers/irqchip/Kconfig
>> > @@ -553,6 +553,13 @@ config RISCV_IMSIC
>> >       select GENERIC_IRQ_MATRIX_ALLOCATOR
>> >       select GENERIC_MSI_IRQ
>> >
>> > +config RISCV_IMSIC_PCI
>> > +     bool
>> > +     depends on RISCV_IMSIC
>> > +     depends on PCI
>> > +     depends on PCI_MSI
>> > +     default RISCV_IMSIC
>> > +
>> >  config EXYNOS_IRQ_COMBINER
>> >       bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
>> >       depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
>> > diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqc=
hip/irq-riscv-imsic-platform.c
>> > index e2344fc08dca..90ddcdd0bba5 100644
>> > --- a/drivers/irqchip/irq-riscv-imsic-platform.c
>> > +++ b/drivers/irqchip/irq-riscv-imsic-platform.c
>> > @@ -14,6 +14,7 @@
>> >  #include <linux/irqdomain.h>
>> >  #include <linux/module.h>
>> >  #include <linux/msi.h>
>> > +#include <linux/pci.h>
>> >  #include <linux/platform_device.h>
>> >  #include <linux/spinlock.h>
>> >  #include <linux/smp.h>
>> > @@ -208,6 +209,28 @@ static const struct irq_domain_ops imsic_base_dom=
ain_ops =3D {
>> >  #endif
>> >  };
>> >
>> > +#ifdef CONFIG_RISCV_IMSIC_PCI
>> > +
>> > +static void imsic_pci_mask_irq(struct irq_data *d)
>> > +{
>> > +     pci_msi_mask_irq(d);
>> > +     irq_chip_mask_parent(d);
>> > +}
>> > +
>> > +static void imsic_pci_unmask_irq(struct irq_data *d)
>> > +{
>> > +     irq_chip_unmask_parent(d);
>> > +     pci_msi_unmask_irq(d);
>> > +}
>> > +
>> > +#define MATCH_PCI_MSI                BIT(DOMAIN_BUS_PCI_MSI)
>> > +
>> > +#else
>> > +
>> > +#define MATCH_PCI_MSI                0
>> > +
>> > +#endif
>> > +
>> >  static bool imsic_init_dev_msi_info(struct device *dev,
>> >                                   struct irq_domain *domain,
>> >                                   struct irq_domain *real_parent,
>> > @@ -231,6 +254,13 @@ static bool imsic_init_dev_msi_info(struct device=
 *dev,
>> >
>> >       /* Is the target supported? */
>> >       switch (info->bus_token) {
>> > +#ifdef CONFIG_RISCV_IMSIC_PCI
>> > +     case DOMAIN_BUS_PCI_DEVICE_MSI:
>> > +     case DOMAIN_BUS_PCI_DEVICE_MSIX:
>> > +             info->chip->irq_mask =3D imsic_pci_mask_irq;
>> > +             info->chip->irq_unmask =3D imsic_pci_unmask_irq;
>>
>> irq_set_affinity()?
>
> It's already set by the switch-case above.

Ah, right -- the new .bus_select_token! Thank you!


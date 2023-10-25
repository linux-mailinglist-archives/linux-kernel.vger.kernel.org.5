Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2437D65E3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbjJYI4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjJYI4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:56:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E347B0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:56:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7016EC433C8;
        Wed, 25 Oct 2023 08:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698224162;
        bh=8Bq3Qbr/gkUku/+SWoEdJgAMfakCIxzCaI3vtlBxij0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=uUljIP0nXjpIJwp0WDGa9ZfJn/zLuzz3k43zWJq4sGpb8ZuHWM7LAb8VPIJivr+MV
         LFuMNqCL/2FMw72a12OQh1D1zoQ5PXSyE0Zz0yVxVXJllKkcyXMuXuNQVLvKcqDj3Q
         PshpFP9LtcjXFQ0i2zLTznMLaCFqHtWUWlSVZw6xP6auTvTC4U8CuY5VWL8gt3xl1q
         uVccUUx1xQmsx2izxdQdY1LZMkKy/l0dcJQUw92LTiZKx4or3GnnUq6pzRapDhCKbS
         sZ7m+xYxOKQloKVkVQTXoprD1S1sdCzXVGnOcAG6EEOFa+/qHKAi+CLNy23Nc63Mz1
         gse8XjPHTo1xA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v11 09/14] irqchip/riscv-imsic: Add support for PCI MSI
 irqdomain
In-Reply-To: <CAK9=C2UVgTd-a0671Lab_ZeOPWP3=wHY+pydKHqaR-Yg65YhrA@mail.gmail.com>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-10-apatel@ventanamicro.com>
 <8734y0rwtw.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2UVgTd-a0671Lab_ZeOPWP3=wHY+pydKHqaR-Yg65YhrA@mail.gmail.com>
Date:   Wed, 25 Oct 2023 10:55:59 +0200
Message-ID: <87jzrbf5cw.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anup Patel <apatel@ventanamicro.com> writes:

> On Tue, Oct 24, 2023 at 6:39=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> Anup Patel <apatel@ventanamicro.com> writes:
>>
>> > The Linux PCI framework requires it's own dedicated MSI irqdomain so
>> > let us create PCI MSI irqdomain as child of the IMSIC base irqdomain.
>> >
>> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>> > ---
>> >  drivers/irqchip/Kconfig                    |  7 +++
>> >  drivers/irqchip/irq-riscv-imsic-platform.c | 51 ++++++++++++++++++++++
>> >  drivers/irqchip/irq-riscv-imsic-state.h    |  1 +
>> >  3 files changed, 59 insertions(+)
>> >
>> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> > index bdd80716114d..c1d69b418dfb 100644
>> > --- a/drivers/irqchip/Kconfig
>> > +++ b/drivers/irqchip/Kconfig
>> > @@ -552,6 +552,13 @@ config RISCV_IMSIC
>> >       select IRQ_DOMAIN_HIERARCHY
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
>> > index 23d286cb017e..cdb659401199 100644
>> > --- a/drivers/irqchip/irq-riscv-imsic-platform.c
>> > +++ b/drivers/irqchip/irq-riscv-imsic-platform.c
>> > @@ -13,6 +13,7 @@
>> >  #include <linux/irqdomain.h>
>> >  #include <linux/module.h>
>> >  #include <linux/msi.h>
>> > +#include <linux/pci.h>
>> >  #include <linux/platform_device.h>
>> >  #include <linux/spinlock.h>
>> >  #include <linux/smp.h>
>> > @@ -215,6 +216,42 @@ static const struct irq_domain_ops imsic_base_dom=
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
>>
>> I've asked this before, but I still don't get why you need to propagate
>> to the parent? Why isn't masking on PCI enough?
>>
>
> We are using hierarchical IRQ domains where IMSIC-BASE is
> the root domain whereas IMSIC-PLAT domain (MSI irq domain
> for platform devices) and IMSIC-PCI domain (MSI irq domain
> for PCI devices). For hierarchical IRQ domains, if irq domain X
> does not implement irq_mask/unmask then the parent irq
> domain irq_mask/unmask is called with parent irq descriptor.
>
> Now for IMSIC-PCI domain, the PCI framework expects the
> pci_msi_mask/unmask_irq() functions to be called but if
> we directly point pci_msi_mask/unmask_irq() in the IMSIC-PCI
> irqchip then IMSIC-BASE (parent domain) irq_mask/umask
> won't be called hence the IRQ won't be masked/unmask.
> Due to this, we call both pci_msi_mask/unmask_irq() and
> irq_chip_mask/unmask_parent() for IMSIC-PCI domain.

Ok. I wont dig more into it for now! If the interrupt is disabled at
PCI, it seems a bit overkill to *also* mask it at the IMSIC level...


Bj=C3=B6rn

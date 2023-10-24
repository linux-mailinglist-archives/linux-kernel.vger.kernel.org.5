Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481B07D5111
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbjJXNJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjJXNJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:09:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2F48F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:09:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D214C433C7;
        Tue, 24 Oct 2023 13:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698152975;
        bh=dwCTjMWxulfmok8hvVUhl0To2h8rmkpi55JvtMmovYM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SUcqiR/MI1naRN0Gf16J8VSkRwGc1fRy1LwHqQzo0IIgu3y0WmI7KmjkfOAo67NzT
         LwrQB8py9L3UQLA//IghgTRsMT+id4QvBwMox4NZgylu6BD1q/qIdEoKMefvTR/xbc
         IuPzmcEGzvRBGJUNDzwTVoy14dHfTyoSwRjHK/f+hrJl3zmo9kkCr/rIRPtCLJE6eS
         76LIuehEj36TIfTp9XMnxBGJEGT5E3ka6j6oeWXataIOPl8YjUX6t4r+bwhAGXjkD6
         WpzuhZCQf0O6wDwsm49vru4nTubMY41AZLQzQps5bhsRIljmCc8LrrxuFbVgNFarN4
         RNInazFe2N9gA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH v11 09/14] irqchip/riscv-imsic: Add support for PCI MSI
 irqdomain
In-Reply-To: <20231023172800.315343-10-apatel@ventanamicro.com>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-10-apatel@ventanamicro.com>
Date:   Tue, 24 Oct 2023 15:09:31 +0200
Message-ID: <8734y0rwtw.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anup Patel <apatel@ventanamicro.com> writes:

> The Linux PCI framework requires it's own dedicated MSI irqdomain so
> let us create PCI MSI irqdomain as child of the IMSIC base irqdomain.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/irqchip/Kconfig                    |  7 +++
>  drivers/irqchip/irq-riscv-imsic-platform.c | 51 ++++++++++++++++++++++
>  drivers/irqchip/irq-riscv-imsic-state.h    |  1 +
>  3 files changed, 59 insertions(+)
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index bdd80716114d..c1d69b418dfb 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -552,6 +552,13 @@ config RISCV_IMSIC
>  	select IRQ_DOMAIN_HIERARCHY
>  	select GENERIC_MSI_IRQ
>=20=20
> +config RISCV_IMSIC_PCI
> +	bool
> +	depends on RISCV_IMSIC
> +	depends on PCI
> +	depends on PCI_MSI
> +	default RISCV_IMSIC
> +
>  config EXYNOS_IRQ_COMBINER
>  	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
>  	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
> diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip=
/irq-riscv-imsic-platform.c
> index 23d286cb017e..cdb659401199 100644
> --- a/drivers/irqchip/irq-riscv-imsic-platform.c
> +++ b/drivers/irqchip/irq-riscv-imsic-platform.c
> @@ -13,6 +13,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
> +#include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
>  #include <linux/smp.h>
> @@ -215,6 +216,42 @@ static const struct irq_domain_ops imsic_base_domain=
_ops =3D {
>  #endif
>  };
>=20=20
> +#ifdef CONFIG_RISCV_IMSIC_PCI
> +
> +static void imsic_pci_mask_irq(struct irq_data *d)
> +{
> +	pci_msi_mask_irq(d);
> +	irq_chip_mask_parent(d);

I've asked this before, but I still don't get why you need to propagate
to the parent? Why isn't masking on PCI enough?


Bj=C3=B6rn

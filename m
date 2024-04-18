Return-Path: <linux-kernel+bounces-150823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E3A8AA544
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAB11F223EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EBB199E9C;
	Thu, 18 Apr 2024 22:07:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192042F30;
	Thu, 18 Apr 2024 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713478059; cv=none; b=NC51hRgU8344D/KHhLI/c6XCSC58erEsYgjumQKLRhYqKkApwWlgQCmMJAdYYPSLOpBmrnxgYbTjzhSHCyF4NhqmaaChKQk+l2/v8bze0bdWel1Go0Kwuj1t4X+GnFp+dEM9k9P/xnrZNRhvVZzAoUPsLThHLz0S3+VaKFGe1c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713478059; c=relaxed/simple;
	bh=fTO83B9lWQ2Ur2tqdGc4yty66F7+uoKHWYHtE+j6Jis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uh4kpRainsT0vu4Yiy8EuO0Okf45RQs0U2BSobGTIIsZBSB2gH1NWn+XNCKM8z2G9lXam4OWWb9X0O4m3C8nhwiMbtrhsskDh0/xpdwpIk7I4zjcKDr0Eanc5iJ8QTmokTbyAfc4XgjkF/mjQ1AK2fL8/olLlSI/YryFPehSQtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A8332F;
	Thu, 18 Apr 2024 15:08:03 -0700 (PDT)
Received: from [10.57.20.187] (unknown [10.57.20.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3717E3F738;
	Thu, 18 Apr 2024 15:07:32 -0700 (PDT)
Message-ID: <08e12daa-3fcc-4ab2-ac55-dee8f69c429a@arm.com>
Date: Thu, 18 Apr 2024 23:07:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] iommu/riscv: Add RISC-V IOMMU PCIe device driver
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>,
 Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux@rivosinc.com
References: <cover.1713456597.git.tjeznach@rivosinc.com>
 <4a068da7a7a984a43d419c52310f8ab7d91da46e.1713456598.git.tjeznach@rivosinc.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <4a068da7a7a984a43d419c52310f8ab7d91da46e.1713456598.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-04-18 5:32 pm, Tomasz Jeznach wrote:
> Introduce device driver for PCIe implementation
> of RISC-V IOMMU architected hardware.
> 
> IOMMU hardware and system support for MSI or MSI-X is
> required by this implementation.
> 
> Vendor and device identifiers used in this patch
> matches QEMU implementation of the RISC-V IOMMU PCIe
> device, from Rivos VID (0x1efd) range allocated by the PCI-SIG.
> 
> Link: https://lore.kernel.org/qemu-devel/20240307160319.675044-1-dbarboza@ventanamicro.com/
> Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>   MAINTAINERS                     |   1 +
>   drivers/iommu/riscv/Kconfig     |   6 ++
>   drivers/iommu/riscv/Makefile    |   1 +
>   drivers/iommu/riscv/iommu-pci.c | 154 ++++++++++++++++++++++++++++++++
>   4 files changed, 162 insertions(+)
>   create mode 100644 drivers/iommu/riscv/iommu-pci.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 051599c76585..4da290d5e9db 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18975,6 +18975,7 @@ F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
>   F:	drivers/iommu/riscv/Kconfig
>   F:	drivers/iommu/riscv/Makefile
>   F:	drivers/iommu/riscv/iommu-bits.h
> +F:	drivers/iommu/riscv/iommu-pci.c
>   F:	drivers/iommu/riscv/iommu-platform.c
>   F:	drivers/iommu/riscv/iommu.c
>   F:	drivers/iommu/riscv/iommu.h
> diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
> index d02326bddb4c..711326992585 100644
> --- a/drivers/iommu/riscv/Kconfig
> +++ b/drivers/iommu/riscv/Kconfig
> @@ -14,3 +14,9 @@ config RISCV_IOMMU
>   
>   	  Say Y here if your SoC includes an IOMMU device implementing
>   	  the RISC-V IOMMU architecture.
> +
> +config RISCV_IOMMU_PCI
> +	def_bool y if RISCV_IOMMU && PCI_MSI
> +	depends on RISCV_IOMMU && PCI_MSI
> +	help
> +	  Support for the PCI implementation of RISC-V IOMMU architecture.

Similar comments as before.

> diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
> index e4c189de58d3..f54c9ed17d41 100644
> --- a/drivers/iommu/riscv/Makefile
> +++ b/drivers/iommu/riscv/Makefile
> @@ -1,2 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-platform.o
> +obj-$(CONFIG_RISCV_IOMMU_PCI) += iommu-pci.o
> diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
> new file mode 100644
> index 000000000000..9263c6e475be
> --- /dev/null
> +++ b/drivers/iommu/riscv/iommu-pci.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright © 2022-2024 Rivos Inc.
> + * Copyright © 2023 FORTH-ICS/CARV
> + *
> + * RISCV IOMMU as a PCIe device
> + *
> + * Authors
> + *	Tomasz Jeznach <tjeznach@rivosinc.com>
> + *	Nick Kossifidis <mick@ics.forth.gr>
> + */
> +
> +#include <linux/compiler.h>
> +#include <linux/init.h>
> +#include <linux/iommu.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +#include "iommu-bits.h"
> +#include "iommu.h"
> +
> +/* Rivos Inc. assigned PCI Vendor and Device IDs */
> +#ifndef PCI_VENDOR_ID_RIVOS
> +#define PCI_VENDOR_ID_RIVOS             0x1efd
> +#endif
> +
> +#ifndef PCI_DEVICE_ID_RIVOS_IOMMU
> +#define PCI_DEVICE_ID_RIVOS_IOMMU       0xedf1
> +#endif
> +
> +static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct riscv_iommu_device *iommu;
> +	int rc, vec;
> +
> +	rc = pci_enable_device_mem(pdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_request_mem_regions(pdev, KBUILD_MODNAME);
> +	if (rc)
> +		goto fail;
> +
> +	pci_set_master(pdev);
> +
> +	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM))
> +		goto fail;
> +
> +	if (pci_resource_len(pdev, 0) < RISCV_IOMMU_REG_SIZE)
> +		goto fail;
> +
> +	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> +	if (!iommu)
> +		goto fail;
> +
> +	iommu->dev = dev;
> +	iommu->reg = pci_iomap(pdev, 0, RISCV_IOMMU_REG_SIZE);

Maybe consider some of the pcim_* devres helpers, to simplify 
cleanup/remove?

> +
> +	if (!iommu->reg)
> +		goto fail;
> +
> +	dev_set_drvdata(dev, iommu);
> +
> +	/* Check device reported capabilities / features. */
> +	iommu->caps = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAP);
> +	iommu->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
> +
> +	/* The PCI driver only uses MSIs, make sure the IOMMU supports this */
> +	switch (FIELD_GET(RISCV_IOMMU_CAP_IGS, iommu->caps)) {
> +	case RISCV_IOMMU_CAP_IGS_MSI:
> +	case RISCV_IOMMU_CAP_IGS_BOTH:
> +		break;
> +	default:
> +		dev_err(dev, "unable to use message-signaled interrupts\n");
> +		rc = -ENODEV;
> +		goto fail_unmap;
> +	}
> +
> +	/* Allocate and assign IRQ vectors for the various events */
> +	rc = pci_alloc_irq_vectors(pdev, 1, RISCV_IOMMU_INTR_COUNT,
> +				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
> +	if (rc <= 0) {
> +		dev_err(dev, "unable to allocate irq vectors\n");
> +		goto fail_unmap;
> +	}
> +	for (vec = 0; vec < rc; vec++) {
> +		iommu->irqs[vec] = msi_get_virq(dev, vec);
> +		if (!iommu->irqs[vec])

Can that ever fail if the loop is already bounded to the number of 
vectors successfully allocated?

> +			break;
> +	}
> +	iommu->irqs_count = vec;
> +
> +	/* Enable message-signaled interrupts, fctl.WSI */
> +	if (iommu->fctl & RISCV_IOMMU_FCTL_WSI) {
> +		iommu->fctl ^= RISCV_IOMMU_FCTL_WSI;
> +		riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
> +	}
> +
> +	rc = riscv_iommu_init(iommu);
> +	if (!rc)
> +		return 0;
> +
> +fail_unmap:
> +	iounmap(iommu->reg);
> +	pci_free_irq_vectors(pdev);
> +fail:
> +	pci_release_regions(pdev);
> +	pci_clear_master(pdev);
> +	pci_disable_device(pdev);
> +	return rc;
> +}
> +
> +static void riscv_iommu_pci_remove(struct pci_dev *pdev)
> +{
> +	struct riscv_iommu_device *iommu = dev_get_drvdata(&pdev->dev);
> +
> +	riscv_iommu_remove(iommu);
> +	iounmap(iommu->reg);
> +	pci_free_irq_vectors(pdev);
> +	pci_release_regions(pdev);
> +	pci_clear_master(pdev);
> +	pci_disable_device(pdev);
> +}
> +
> +static const struct pci_device_id riscv_iommu_pci_tbl[] = {
> +	{PCI_VENDOR_ID_RIVOS, PCI_DEVICE_ID_RIVOS_IOMMU,
> +	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
> +	{0,}
> +};
> +
> +MODULE_DEVICE_TABLE(pci, riscv_iommu_pci_tbl);
> +
> +static const struct of_device_id riscv_iommu_of_match[] = {
> +	{.compatible = "riscv,pci-iommu",},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, riscv_iommu_of_match);
> +
> +static struct pci_driver riscv_iommu_pci_driver = {
> +	.name = KBUILD_MODNAME,
> +	.id_table = riscv_iommu_pci_tbl,
> +	.probe = riscv_iommu_pci_probe,
> +	.remove = riscv_iommu_pci_remove,
> +	.driver = {
> +		.of_match_table = riscv_iommu_of_match,

Does an of_match_table serve any functional purpose for a PCI driver? I 
can't find any other examples of this being done.

Thanks,
Robin.

> +		.suppress_bind_attrs = true,
> +	},
> +};
> +
> +module_pci_driver(riscv_iommu_pci_driver);


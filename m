Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6989677E846
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345380AbjHPSGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345379AbjHPSF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:05:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EFA710C0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:05:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DAD8D75;
        Wed, 16 Aug 2023 11:06:35 -0700 (PDT)
Received: from [10.57.90.114] (unknown [10.57.90.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A7BC3F6C4;
        Wed, 16 Aug 2023 11:05:51 -0700 (PDT)
Message-ID: <7e875daa-c2f3-7d03-d797-369762638897@arm.com>
Date:   Wed, 16 Aug 2023 19:05:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 01/11] RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu
 support.
To:     Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-19 20:33, Tomasz Jeznach wrote:
> The patch introduces skeleton IOMMU device driver implementation as defined
> by RISC-V IOMMU Architecture Specification, Version 1.0 [1], with minimal support
> for pass-through mapping, basic initialization and bindings for platform and PCIe
> hardware implementations.
> 
> Series of patches following specification evolution has been reorganized to provide
> functional separation of implemented blocks, compliant with ratified specification.
> 
> This and following patch series includes code contributed by: Nick Kossifidis
> <mick@ics.forth.gr> (iommu-platform device, number of specification clarification
> and bugfixes and readability improvements), Sebastien Boeuf <seb@rivosinc.com> (page
> table creation, ATS/PGR flow).
> 
> Complete history can be found at the maintainer's repository branch [2].
> 
> Device driver enables RISC-V 32/64 support for memory translation for DMA capable
> PCI and platform devices, multilevel device directory table, process directory,
> shared virtual address support, wired and message signaled interrupt for translation
> I/O fault, page request interface and command processing.
> 
> Matching RISCV-V IOMMU device emulation implementation is available for QEMU project,
> along with educational device extensions for PASID ATS/PRI support [3].
> 
> References:
>   - [1] https://github.com/riscv-non-isa/riscv-iommu
>   - [2] https://github.com/tjeznach/linux/tree/tjeznach/riscv-iommu
>   - [3] https://github.com/tjeznach/qemu/tree/tjeznach/riscv-iommu
> 
> Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>   drivers/iommu/Kconfig                |   1 +
>   drivers/iommu/Makefile               |   2 +-
>   drivers/iommu/riscv/Kconfig          |  22 +
>   drivers/iommu/riscv/Makefile         |   1 +
>   drivers/iommu/riscv/iommu-bits.h     | 704 +++++++++++++++++++++++++++
>   drivers/iommu/riscv/iommu-pci.c      | 134 +++++
>   drivers/iommu/riscv/iommu-platform.c |  94 ++++
>   drivers/iommu/riscv/iommu.c          | 660 +++++++++++++++++++++++++
>   drivers/iommu/riscv/iommu.h          | 115 +++++
>   9 files changed, 1732 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/iommu/riscv/Kconfig
>   create mode 100644 drivers/iommu/riscv/Makefile
>   create mode 100644 drivers/iommu/riscv/iommu-bits.h
>   create mode 100644 drivers/iommu/riscv/iommu-pci.c
>   create mode 100644 drivers/iommu/riscv/iommu-platform.c
>   create mode 100644 drivers/iommu/riscv/iommu.c
>   create mode 100644 drivers/iommu/riscv/iommu.h
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 2b12b583ef4b..36fcc6fd5b4e 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -187,6 +187,7 @@ config MSM_IOMMU
>   source "drivers/iommu/amd/Kconfig"
>   source "drivers/iommu/intel/Kconfig"
>   source "drivers/iommu/iommufd/Kconfig"
> +source "drivers/iommu/riscv/Kconfig"
>   
>   config IRQ_REMAP
>   	bool "Support for Interrupt Remapping"
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 769e43d780ce..8f57110a9fb1 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -1,5 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> -obj-y += amd/ intel/ arm/ iommufd/
> +obj-y += amd/ intel/ arm/ iommufd/ riscv/
>   obj-$(CONFIG_IOMMU_API) += iommu.o
>   obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>   obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
> diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
> new file mode 100644
> index 000000000000..01d4043849d4
> --- /dev/null
> +++ b/drivers/iommu/riscv/Kconfig
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# RISC-V IOMMU support
> +
> +config RISCV_IOMMU
> +	bool "RISC-V IOMMU driver"
> +	depends on RISCV
> +	select IOMMU_API
> +	select IOMMU_DMA

No. See commit de9f8a91eb32.

> +	select IOMMU_SVA
> +	select IOMMU_IOVA

No.

> +	select IOMMU_IO_PGTABLE

Do you anticipate needing to support multiple pagetable formats, or 
sharing this format with other drivers? If not, I'd usually suggest 
avoiding the overhead of io-pgtable.

> +	select IOASID

Doesn't exist.

> +	select PCI_MSI

Already selected at the arch level, does it really need reselecting here?

> +	select PCI_ATS
> +	select PCI_PRI
> +	select PCI_PASID
> +	select MMU_NOTIFIER
> +	help
> +	  Support for devices following RISC-V IOMMU specification.
> +
> +	  If unsure, say N here.
> +
[...]
> diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
> new file mode 100644
> index 000000000000..c91f963d7a29
> --- /dev/null
> +++ b/drivers/iommu/riscv/iommu-pci.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright © 2022-2023 Rivos Inc.
> + * Copyright © 2023 FORTH-ICS/CARV
> + *
> + * RISCV IOMMU as a PCIe device
> + *
> + * Authors
> + *	Tomasz Jeznach <tjeznach@rivosinc.com>
> + *	Nick Kossifidis <mick@ics.forth.gr>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/compiler.h>
> +#include <linux/pci.h>
> +#include <linux/init.h>
> +#include <linux/iommu.h>
> +#include <linux/bitfield.h>
> +
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
> +	int ret;
> +
> +	ret = pci_enable_device_mem(pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = pci_request_mem_regions(pdev, KBUILD_MODNAME);
> +	if (ret < 0)
> +		goto fail;
> +
> +	ret = -ENOMEM;
> +
> +	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> +	if (!iommu)
> +		goto fail;
> +
> +	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM))
> +		goto fail;
> +
> +	if (pci_resource_len(pdev, 0) < RISCV_IOMMU_REG_SIZE)
> +		goto fail;
> +
> +	iommu->reg_phys = pci_resource_start(pdev, 0);
> +	if (!iommu->reg_phys)
> +		goto fail;
> +
> +	iommu->reg = devm_ioremap(dev, iommu->reg_phys, RISCV_IOMMU_REG_SIZE);
> +	if (!iommu->reg)
> +		goto fail;
> +
> +	iommu->dev = dev;
> +	dev_set_drvdata(dev, iommu);
> +
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	pci_set_master(pdev);
> +
> +	ret = riscv_iommu_init(iommu);
> +	if (!ret)
> +		return ret;
> +
> + fail:
> +	pci_clear_master(pdev);
> +	pci_release_regions(pdev);
> +	pci_disable_device(pdev);
> +	/* Note: devres_release_all() will release iommu and iommu->reg */
> +	return ret;
> +}
> +
> +static void riscv_iommu_pci_remove(struct pci_dev *pdev)
> +{
> +	riscv_iommu_remove(dev_get_drvdata(&pdev->dev));
> +	pci_clear_master(pdev);
> +	pci_release_regions(pdev);
> +	pci_disable_device(pdev);
> +}
> +
> +static int riscv_iommu_suspend(struct device *dev)
> +{
> +	dev_warn(dev, "RISC-V IOMMU PM not implemented");
> +	return -ENODEV;
> +}
> +
> +static int riscv_iommu_resume(struct device *dev)
> +{
> +	dev_warn(dev, "RISC-V IOMMU PM not implemented");
> +	return -ENODEV;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(riscv_iommu_pm_ops, riscv_iommu_suspend,
> +				riscv_iommu_resume);
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
> +		   .pm = pm_sleep_ptr(&riscv_iommu_pm_ops),
> +		   .of_match_table = riscv_iommu_of_match,

Does that even do anything for a PCI driver?

Also you're missing suppress_bind_attrs here.

> +		   },
> +};
> +
> +module_driver(riscv_iommu_pci_driver, pci_register_driver, pci_unregister_driver);
> diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
> new file mode 100644
> index 000000000000..e4e8ca6711e7
> --- /dev/null
> +++ b/drivers/iommu/riscv/iommu-platform.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * RISC-V IOMMU as a platform device
> + *
> + * Copyright © 2023 FORTH-ICS/CARV
> + *
> + * Author: Nick Kossifidis <mick@ics.forth.gr>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/of_platform.h>
> +#include <linux/bitfield.h>
> +
> +#include "iommu-bits.h"
> +#include "iommu.h"
> +
> +static int riscv_iommu_platform_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct riscv_iommu_device *iommu = NULL;
> +	struct resource *res = NULL;
> +	int ret = 0;
> +
> +	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> +	if (!iommu)
> +		return -ENOMEM;
> +
> +	iommu->dev = dev;
> +	dev_set_drvdata(dev, iommu);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "could not find resource for register region\n");
> +		return -EINVAL;
> +	}
> +
> +	iommu->reg = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(iommu->reg)) {
> +		ret = dev_err_probe(dev, PTR_ERR(iommu->reg),
> +				    "could not map register region\n");
> +		goto fail;
> +	};
> +
> +	iommu->reg_phys = res->start;
> +
> +	ret = -ENODEV;
> +
> +	/* Sanity check: Did we get the whole register space ? */
> +	if ((res->end - res->start + 1) < RISCV_IOMMU_REG_SIZE) {
> +		dev_err(dev, "device region smaller than register file (0x%llx)\n",
> +			res->end - res->start);
> +		goto fail;
> +	}
> +
> +	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +
> +	return riscv_iommu_init(iommu);
> +
> + fail:
> +	/* Note: devres_release_all() will release iommu and iommu->reg */
> +	return ret;
> +};
> +
> +static void riscv_iommu_platform_remove(struct platform_device *pdev)
> +{
> +	riscv_iommu_remove(dev_get_drvdata(&pdev->dev));
> +};
> +
> +static void riscv_iommu_platform_shutdown(struct platform_device *pdev)
> +{
> +	return;

Surely just don't implement it at all?

> +};
> +
> +static const struct of_device_id riscv_iommu_of_match[] = {
> +	{.compatible = "riscv,iommu",},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, riscv_iommu_of_match);
> +
> +static struct platform_driver riscv_iommu_platform_driver = {
> +	.driver = {
> +		   .name = "riscv,iommu",
> +		   .of_match_table = riscv_iommu_of_match,
> +		   .suppress_bind_attrs = true,
> +		   },
> +	.probe = riscv_iommu_platform_probe,
> +	.remove_new = riscv_iommu_platform_remove,
> +	.shutdown = riscv_iommu_platform_shutdown,
> +};
> +
> +module_driver(riscv_iommu_platform_driver, platform_driver_register,
> +	      platform_driver_unregister);
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> new file mode 100644
> index 000000000000..8c236242e2cc
> --- /dev/null
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -0,0 +1,660 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * IOMMU API for RISC-V architected Ziommu implementations.
> + *
> + * Copyright © 2022-2023 Rivos Inc.
> + * Copyright © 2023 FORTH-ICS/CARV
> + *
> + * Authors
> + *	Tomasz Jeznach <tjeznach@rivosinc.com>
> + *	Nick Kossifidis <mick@ics.forth.gr>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/compiler.h>
> +#include <linux/pci.h>
> +#include <linux/pci-ats.h>
> +#include <linux/init.h>
> +#include <linux/completion.h>
> +#include <linux/uaccess.h>
> +#include <linux/iommu.h>
> +#include <linux/irqdomain.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-map-ops.h>

No. This is a device driver, not a DMA ops implemenmtation.

> +#include <asm/page.h>
> +
> +#include "../dma-iommu.h"
> +#include "../iommu-sva.h"
> +#include "iommu.h"
> +
> +#include <asm/csr.h>
> +#include <asm/delay.h>
> +
> +MODULE_DESCRIPTION("IOMMU driver for RISC-V architected Ziommu implementations");
> +MODULE_AUTHOR("Tomasz Jeznach <tjeznach@rivosinc.com>");
> +MODULE_AUTHOR("Nick Kossifidis <mick@ics.forth.gr>");
> +MODULE_ALIAS("riscv-iommu");
> +MODULE_LICENSE("GPL v2");
> +
> +/* Global IOMMU params. */
> +static int ddt_mode = RISCV_IOMMU_DDTP_MODE_BARE;
> +module_param(ddt_mode, int, 0644);
> +MODULE_PARM_DESC(ddt_mode, "Device Directory Table mode.");
> +
> +/* IOMMU PSCID allocation namespace. */
> +#define RISCV_IOMMU_MAX_PSCID	(1U << 20)
> +static DEFINE_IDA(riscv_iommu_pscids);
> +
> +/* 1 second */
> +#define RISCV_IOMMU_TIMEOUT	riscv_timebase
> +
> +/* RISC-V IOMMU PPN <> PHYS address conversions, PHYS <=> PPN[53:10] */
> +#define phys_to_ppn(va)  (((va) >> 2) & (((1ULL << 44) - 1) << 10))
> +#define ppn_to_phys(pn)	 (((pn) << 2) & (((1ULL << 44) - 1) << 12))
> +
> +#define iommu_domain_to_riscv(iommu_domain) \
> +    container_of(iommu_domain, struct riscv_iommu_domain, domain)
> +
> +#define iommu_device_to_riscv(iommu_device) \
> +    container_of(iommu_device, struct riscv_iommu, iommu)
> +
> +static const struct iommu_domain_ops riscv_iommu_domain_ops;
> +static const struct iommu_ops riscv_iommu_ops;
> +
> +/*
> + * Register device for IOMMU tracking.
> + */
> +static void riscv_iommu_add_device(struct riscv_iommu_device *iommu, struct device *dev)
> +{
> +	struct riscv_iommu_endpoint *ep, *rb_ep;
> +	struct rb_node **new_node, *parent_node = NULL;
> +
> +	mutex_lock(&iommu->eps_mutex);
> +
> +	ep = dev_iommu_priv_get(dev);
> +
> +	new_node = &(iommu->eps.rb_node);
> +	while (*new_node) {
> +		rb_ep = rb_entry(*new_node, struct riscv_iommu_endpoint, node);
> +		parent_node = *new_node;
> +		if (rb_ep->devid > ep->devid) {
> +			new_node = &((*new_node)->rb_left);
> +		} else if (rb_ep->devid < ep->devid) {
> +			new_node = &((*new_node)->rb_right);
> +		} else {
> +			dev_warn(dev, "device %u already in the tree\n", ep->devid);
> +			break;
> +		}
> +	}
> +
> +	rb_link_node(&ep->node, parent_node, new_node);
> +	rb_insert_color(&ep->node, &iommu->eps);
> +
> +	mutex_unlock(&iommu->eps_mutex);
> +}
> +
> +/*
> + * Endpoint management
> + */
> +
> +static int riscv_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
> +{
> +	return iommu_fwspec_add_ids(dev, args->args, 1);
> +}
> +
> +static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
> +{
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
> +	case IOMMU_CAP_PRE_BOOT_PROTECTION:

I don't think you can ever unconditionally claim pre-boot protection. 
Even if an IOMMU implementation does come out of reset in "Off" state - 
which I see the spec only recommends, not requires - something that ran 
before Linux could have done something and left it in "Bare" state.

> +		return true;
> +
> +	default:
> +		break;
> +	}
> +
> +	return false;
> +}
> +
> +static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
> +{
> +	struct riscv_iommu_device *iommu;
> +	struct riscv_iommu_endpoint *ep;
> +	struct iommu_fwspec *fwspec;
> +
> +	fwspec = dev_iommu_fwspec_get(dev);
> +	if (!fwspec || fwspec->ops != &riscv_iommu_ops ||
> +	    !fwspec->iommu_fwnode || !fwspec->iommu_fwnode->dev)

I'm pretty sure it shouldn't be possible for a fwspec to have ops set 
without a valid fwnode, given that the fwnode is used to find the ops :/

> +		return ERR_PTR(-ENODEV);
> +
> +	iommu = dev_get_drvdata(fwspec->iommu_fwnode->dev);
> +	if (!iommu)
> +		return ERR_PTR(-ENODEV);
> +
> +	if (dev_iommu_priv_get(dev))

That should never be true at this point.

> +		return &iommu->iommu;
> +
> +	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
> +	if (!ep)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_init(&ep->lock);
> +	INIT_LIST_HEAD(&ep->domain);
> +
> +	if (dev_is_pci(dev)) {
> +		ep->devid = pci_dev_id(to_pci_dev(dev));
> +		ep->domid = pci_domain_nr(to_pci_dev(dev)->bus);
> +	} else {
> +		/* TODO: Make this generic, for now hardcode domain id to 0 */
> +		ep->devid = fwspec->ids[0];
> +		ep->domid = 0;
> +	}
> +
> +	ep->iommu = iommu;
> +	ep->dev = dev;
> +
> +	dev_info(iommu->dev, "adding device to iommu with devid %i in domain %i\n",
> +		ep->devid, ep->domid);

Please clean up all these debugging prints before submitting patches 
upstream. I do start to wonder how worthwhile it is to review code that 
doesn't even look finished...

> +
> +	dev_iommu_priv_set(dev, ep);
> +	riscv_iommu_add_device(iommu, dev);
> +
> +	return &iommu->iommu;
> +}
> +
> +static void riscv_iommu_probe_finalize(struct device *dev)
> +{
> +	set_dma_ops(dev, NULL);
> +	iommu_setup_dma_ops(dev, 0, U64_MAX);
> +}

riscv already implements arch_setup_dma_ops(), so please make use of 
that flow; this probe_finalize bodge is an x86 thing, mostly for legacy 
reasons.

> +
> +static void riscv_iommu_release_device(struct device *dev)
> +{
> +	struct riscv_iommu_endpoint *ep = dev_iommu_priv_get(dev);
> +	struct riscv_iommu_device *iommu = ep->iommu;
> +
> +	dev_info(dev, "device with devid %i released\n", ep->devid);
> +
> +	mutex_lock(&ep->lock);
> +	list_del(&ep->domain);
> +	mutex_unlock(&ep->lock);
> +
> +	/* Remove endpoint from IOMMU tracking structures */
> +	mutex_lock(&iommu->eps_mutex);
> +	rb_erase(&ep->node, &iommu->eps);
> +	mutex_unlock(&iommu->eps_mutex);
> +
> +	set_dma_ops(dev, NULL);
> +	dev_iommu_priv_set(dev, NULL);
> +
> +	kfree(ep);
> +}
> +
> +static struct iommu_group *riscv_iommu_device_group(struct device *dev)
> +{
> +	if (dev_is_pci(dev))
> +		return pci_device_group(dev);
> +	return generic_device_group(dev);
> +}
> +
> +static void riscv_iommu_get_resv_regions(struct device *dev, struct list_head *head)
> +{
> +	iommu_dma_get_resv_regions(dev, head);

Just assign it as the callback directly - the wrapper function serves no 
purpose.

> +}
> +
> +/*
> + * Domain management
> + */
> +
> +static struct iommu_domain *riscv_iommu_domain_alloc(unsigned type)
> +{
> +	struct riscv_iommu_domain *domain;
> +
> +	if (type != IOMMU_DOMAIN_IDENTITY &&
> +	    type != IOMMU_DOMAIN_BLOCKED)

Whatever's going on here I don't think really fits the meaning of 
IOMMU_DOMAIN_BLOCKED.

> +		return NULL;
> +
> +	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> +	if (!domain)
> +		return NULL;
> +
> +	mutex_init(&domain->lock);
> +	INIT_LIST_HEAD(&domain->endpoints);
> +
> +	domain->domain.ops = &riscv_iommu_domain_ops;
> +	domain->mode = RISCV_IOMMU_DC_FSC_MODE_BARE;
> +	domain->pscid = ida_alloc_range(&riscv_iommu_pscids, 1,
> +					RISCV_IOMMU_MAX_PSCID, GFP_KERNEL);

If this fails, it seems you "successfully" return a completely useless 
domain to which nothing can attach. Why not just fail the allocation 
right here?

> +
> +	printk("domain type %x alloc %u\n", type, domain->pscid);
> +
> +	return &domain->domain;
> +}
> +
> +static void riscv_iommu_domain_free(struct iommu_domain *iommu_domain)
> +{
> +	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> +
> +	if (!list_empty(&domain->endpoints)) {
> +		pr_warn("IOMMU domain is not empty!\n");
> +	}
> +
> +	if (domain->pgd_root)
> +		free_pages((unsigned long)domain->pgd_root, 0);
> +
> +	if ((int)domain->pscid > 0)
> +		ida_free(&riscv_iommu_pscids, domain->pscid);
> +
> +	printk("domain free %u\n", domain->pscid);
> +
> +	kfree(domain);
> +}
> +
> +static int riscv_iommu_domain_finalize(struct riscv_iommu_domain *domain,
> +				       struct riscv_iommu_device *iommu)
> +{
> +	struct iommu_domain_geometry *geometry;
> +
> +	/* Domain assigned to another iommu */
> +	if (domain->iommu && domain->iommu != iommu)
> +		return -EINVAL;
> +	/* Domain already initialized */
> +	else if (domain->iommu)
> +		return 0;
> +
> +	/*
> +	 * TODO: Before using VA_BITS and satp_mode here, verify they
> +	 * are supported by the iommu, through the capabilities register.
> +	 */

Yes, doing that sounds like a very good idea.

> +
> +	geometry = &domain->domain.geometry;
> +
> +	/*
> +	 * Note: RISC-V Privilege spec mandates that virtual addresses
> +	 * need to be sign-extended, so if (VA_BITS - 1) is set, all
> +	 * bits >= VA_BITS need to also be set or else we'll get a
> +	 * page fault. However the code that creates the mappings
> +	 * above us (e.g. iommu_dma_alloc_iova()) won't do that for us
> +	 * for now, so we'll end up with invalid virtual addresses
> +	 * to map. As a workaround until we get this sorted out
> +	 * limit the available virtual addresses to VA_BITS - 1.
> +	 */

Would you have a practical use for a single 64-bit VA space with a 
massive hole in the middle anyway?

> +	geometry->aperture_start = 0;
> +	geometry->aperture_end = DMA_BIT_MASK(VA_BITS - 1);
> +	geometry->force_aperture = true;
> +
> +	domain->iommu = iommu;
> +
> +	if (domain->domain.type == IOMMU_DOMAIN_IDENTITY)
> +		return 0;
> +
> +	/* TODO: Fix this for RV32 */
> +	domain->mode = satp_mode >> 60;
> +	domain->pgd_root = (pgd_t *) __get_free_pages(GFP_KERNEL | __GFP_ZERO, 0);
> +
> +	if (!domain->pgd_root)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static int riscv_iommu_attach_dev(struct iommu_domain *iommu_domain, struct device *dev)
> +{
> +	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> +	struct riscv_iommu_endpoint *ep = dev_iommu_priv_get(dev);
> +	int ret;
> +
> +	/* PSCID not valid */
> +	if ((int)domain->pscid < 0)
> +		return -ENOMEM;
> +
> +	mutex_lock(&domain->lock);
> +	mutex_lock(&ep->lock);
> +
> +	if (!list_empty(&ep->domain)) {
> +		dev_warn(dev, "endpoint already attached to a domain. dropping\n");

This should not be a warning condition. Other than the very first attach 
at iommu_probe_device() time, .attach_dev will always be moving devices 
directly from one domain to another.

> +		list_del_init(&ep->domain);
> +	}
> +
> +	/* allocate root pages, initialize io-pgtable ops, etc. */
> +	ret = riscv_iommu_domain_finalize(domain, ep->iommu);
> +	if (ret < 0) {
> +		dev_err(dev, "can not finalize domain: %d\n", ret);
> +		mutex_unlock(&ep->lock);
> +		mutex_unlock(&domain->lock);
> +		return ret;
> +	}
> +
> +	if (ep->iommu->ddt_mode != RISCV_IOMMU_DDTP_MODE_BARE ||
> +	    domain->domain.type != IOMMU_DOMAIN_IDENTITY) {
> +		dev_warn(dev, "domain type %d not supported\n",
> +		    domain->domain.type);
> +		return -ENODEV;

OK, so you don't actually support blocking domains anyway? In that case, 
don't accept the allocation request in the first place.

> +	}
> +
> +	list_add_tail(&ep->domain, &domain->endpoints);
> +	mutex_unlock(&ep->lock);
> +	mutex_unlock(&domain->lock);
> +
> +	dev_info(dev, "domain type %d attached w/ PSCID %u\n",
> +	    domain->domain.type, domain->pscid);
> +
> +	return 0;
> +}
> +
> +static void riscv_iommu_flush_iotlb_range(struct iommu_domain *iommu_domain,
> +					  unsigned long *start, unsigned long *end,
> +					  size_t *pgsize)
> +{
> +	/* Command interface not implemented */
> +}
> +
> +static void riscv_iommu_flush_iotlb_all(struct iommu_domain *iommu_domain)
> +{
> +	riscv_iommu_flush_iotlb_range(iommu_domain, NULL, NULL, NULL);
> +}
> +
> +static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
> +				   struct iommu_iotlb_gather *gather)
> +{
> +	riscv_iommu_flush_iotlb_range(iommu_domain, &gather->start, &gather->end,
> +				      &gather->pgsize);
> +}
> +
> +static void riscv_iommu_iotlb_sync_map(struct iommu_domain *iommu_domain,
> +				       unsigned long iova, size_t size)
> +{
> +	unsigned long end = iova + size - 1;
> +	/*
> +	 * Given we don't know the page size used by this range, we assume the
> +	 * smallest page size to ensure all possible entries are flushed from
> +	 * the IOATC.
> +	 */
> +	size_t pgsize = PAGE_SIZE;
> +	riscv_iommu_flush_iotlb_range(iommu_domain, &iova, &end, &pgsize);

The spec says the IOMMU is not permitted to cache invalid PTEs, so why 
have this? (I mean, it's clearly a completely useless no-op anyway, but 
hey...)

> +}
> +
> +static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
> +				 unsigned long iova, phys_addr_t phys,
> +				 size_t pgsize, size_t pgcount, int prot,
> +				 gfp_t gfp, size_t *mapped)
> +{
> +	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> +
> +	if (domain->domain.type == IOMMU_DOMAIN_IDENTITY) {

That can't happen. Not to mention that pretending to successfully map 
any IOVA to any PA in an identity domain, which by definition doesn't do 
that, would be fundamentally nonsensical anyway.

> +		*mapped = pgsize * pgcount;
> +		return 0;
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
> +				      unsigned long iova, size_t pgsize,
> +				      size_t pgcount, struct iommu_iotlb_gather *gather)
> +{
> +	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> +
> +	if (domain->domain.type == IOMMU_DOMAIN_IDENTITY)

Ditto.

> +		return pgsize * pgcount;
> +
> +	return 0;
> +}
> +
> +static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
> +					    dma_addr_t iova)
> +{
> +	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> +
> +	if (domain->domain.type == IOMMU_DOMAIN_IDENTITY)

Ditto. Have you seen iommu_iova_to_phys()?

> +		return (phys_addr_t) iova;
> +
> +	return 0;
> +}
> +
> +/*
> + * Translation mode setup
> + */
> +
> +static u64 riscv_iommu_get_ddtp(struct riscv_iommu_device *iommu)
> +{
> +	u64 ddtp;
> +	cycles_t end_cycles = RISCV_IOMMU_TIMEOUT + get_cycles();
> +
> +	/* Wait for DDTP.BUSY to be cleared and return latest value */
> +	do {
> +		ddtp = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
> +		if (!(ddtp & RISCV_IOMMU_DDTP_BUSY))
> +			break;
> +		cpu_relax();
> +	} while (get_cycles() < end_cycles);

Smells like readq_poll_timeout().

> +
> +	return ddtp;
> +}
> +
> +static void riscv_iommu_ddt_cleanup(struct riscv_iommu_device *iommu)
> +{
> +	/* TODO: teardown whole device directory tree. */
> +	if (iommu->ddtp) {
> +		if (iommu->ddtp_in_iomem) {
> +			iounmap((void *)iommu->ddtp);
> +		} else
> +			free_page(iommu->ddtp);
> +		iommu->ddtp = 0;
> +	}
> +}
> +
> +static int riscv_iommu_enable(struct riscv_iommu_device *iommu, unsigned requested_mode)
> +{
> +	struct device *dev = iommu->dev;
> +	u64 ddtp = 0;
> +	u64 ddtp_paddr = 0;
> +	unsigned mode = requested_mode;
> +	unsigned mode_readback = 0;
> +
> +	ddtp = riscv_iommu_get_ddtp(iommu);
> +	if (ddtp & RISCV_IOMMU_DDTP_BUSY)
> +		return -EBUSY;
> +
> +	/* Disallow state transtion from xLVL to xLVL. */
> +	switch (FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp)) {
> +	case RISCV_IOMMU_DDTP_MODE_BARE:
> +	case RISCV_IOMMU_DDTP_MODE_OFF:
> +		break;
> +	default:
> +		if ((mode != RISCV_IOMMU_DDTP_MODE_BARE)
> +		    && (mode != RISCV_IOMMU_DDTP_MODE_OFF))
> +			return -EINVAL;
> +		break;
> +	}
> +
> + retry:
> +	switch (mode) {
> +	case RISCV_IOMMU_DDTP_MODE_BARE:
> +	case RISCV_IOMMU_DDTP_MODE_OFF:
> +		riscv_iommu_ddt_cleanup(iommu);
> +		ddtp = FIELD_PREP(RISCV_IOMMU_DDTP_MODE, mode);
> +		break;
> +	case RISCV_IOMMU_DDTP_MODE_1LVL:
> +	case RISCV_IOMMU_DDTP_MODE_2LVL:
> +	case RISCV_IOMMU_DDTP_MODE_3LVL:
> +		if (!iommu->ddtp) {
> +			/*
> +			 * We haven't initialized ddtp yet, since it's WARL make
> +			 * sure that we don't have a hardwired PPN field there
> +			 * that points to i/o memory instead.
> +			 */
> +			riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP, 0);
> +			ddtp = riscv_iommu_get_ddtp(iommu);
> +			ddtp_paddr = ppn_to_phys(ddtp);
> +			if (ddtp_paddr) {
> +				dev_warn(dev, "ddtp at 0x%llx\n", ddtp_paddr);
> +				iommu->ddtp =
> +				    (unsigned long)ioremap(ddtp_paddr, PAGE_SIZE);
> +				iommu->ddtp_in_iomem = true;
> +			} else {
> +				iommu->ddtp = get_zeroed_page(GFP_KERNEL);
> +			}
> +		}
> +		if (!iommu->ddtp)
> +			return -ENOMEM;
> +
> +		ddtp = FIELD_PREP(RISCV_IOMMU_DDTP_MODE, mode) |
> +		    phys_to_ppn(__pa(iommu->ddtp));
> +
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP, ddtp);
> +	ddtp = riscv_iommu_get_ddtp(iommu);
> +	if (ddtp & RISCV_IOMMU_DDTP_BUSY) {
> +		dev_warn(dev, "timeout when setting ddtp (ddt mode: %i)\n", mode);
> +		return -EBUSY;
> +	}
> +
> +	mode_readback = FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp);
> +	dev_info(dev, "mode_readback: %i, mode: %i\n", mode_readback, mode);
> +	if (mode_readback != mode) {
> +		/*
> +		 * Mode field is WARL, an I/O MMU may support a subset of
> +		 * directory table levels in which case if we tried to set
> +		 * an unsupported number of levels we'll readback either
> +		 * a valid xLVL or off/bare. If we got off/bare, try again
> +		 * with a smaller xLVL.
> +		 */
> +		if (mode_readback < RISCV_IOMMU_DDTP_MODE_1LVL &&
> +		    mode > RISCV_IOMMU_DDTP_MODE_1LVL) {
> +			mode--;
> +			goto retry;
> +		}
> +
> +		/*
> +		 * We tried all supported xLVL modes and still got off/bare instead,
> +		 * an I/O MMU must support at least one supported xLVL mode so something
> +		 * went very wrong.
> +		 */
> +		if (mode_readback < RISCV_IOMMU_DDTP_MODE_1LVL &&
> +		    mode == RISCV_IOMMU_DDTP_MODE_1LVL)
> +			goto fail;
> +
> +		/*
> +		 * We tried setting off or bare and got something else back, something
> +		 * went very wrong since off/bare is always legal.
> +		 */
> +		if (mode < RISCV_IOMMU_DDTP_MODE_1LVL)
> +			goto fail;
> +
> +		/*
> +		 * We tried setting an xLVL mode but got another xLVL mode that
> +		 * we don't support (e.g. a custom one).
> +		 */
> +		if (mode_readback > RISCV_IOMMU_DDTP_MODE_MAX)
> +			goto fail;
> +
> +		/* We tried setting an xLVL mode but got another supported xLVL mode */
> +		mode = mode_readback;
> +	}
> +
> +	if (mode != requested_mode)
> +		dev_warn(dev, "unsupported DDT mode requested (%i), using %i instead\n",
> +			 requested_mode, mode);
> +
> +	iommu->ddt_mode = mode;
> +	dev_info(dev, "ddt_mode: %i\n", iommu->ddt_mode);
> +	return 0;
> +
> + fail:
> +	dev_err(dev, "failed to set DDT mode, tried: %i and got %i\n", mode,
> +		mode_readback);
> +	riscv_iommu_ddt_cleanup(iommu);
> +	return -EINVAL;
> +}
> +
> +/*
> + * Common I/O MMU driver probe/teardown
> + */
> +
> +static const struct iommu_domain_ops riscv_iommu_domain_ops = {
> +	.free = riscv_iommu_domain_free,
> +	.attach_dev = riscv_iommu_attach_dev,
> +	.map_pages = riscv_iommu_map_pages,
> +	.unmap_pages = riscv_iommu_unmap_pages,
> +	.iova_to_phys = riscv_iommu_iova_to_phys,
> +	.iotlb_sync = riscv_iommu_iotlb_sync,
> +	.iotlb_sync_map = riscv_iommu_iotlb_sync_map,
> +	.flush_iotlb_all = riscv_iommu_flush_iotlb_all,
> +};
> +
> +static const struct iommu_ops riscv_iommu_ops = {
> +	.owner = THIS_MODULE,
> +	.pgsize_bitmap = SZ_4K | SZ_2M | SZ_512M,
> +	.capable = riscv_iommu_capable,
> +	.domain_alloc = riscv_iommu_domain_alloc,
> +	.probe_device = riscv_iommu_probe_device,
> +	.probe_finalize = riscv_iommu_probe_finalize,
> +	.release_device = riscv_iommu_release_device,
> +	.device_group = riscv_iommu_device_group,
> +	.get_resv_regions = riscv_iommu_get_resv_regions,
> +	.of_xlate = riscv_iommu_of_xlate,
> +	.default_domain_ops = &riscv_iommu_domain_ops,
> +};
> +
> +void riscv_iommu_remove(struct riscv_iommu_device *iommu)
> +{
> +	iommu_device_unregister(&iommu->iommu);
> +	riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
> +}
> +
> +int riscv_iommu_init(struct riscv_iommu_device *iommu)
> +{
> +	struct device *dev = iommu->dev;
> +	u32 fctl = 0;
> +	int ret;
> +
> +	iommu->eps = RB_ROOT;
> +
> +	fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
> +
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +	if (!(cap & RISCV_IOMMU_CAP_END)) {
> +		dev_err(dev, "IOMMU doesn't support Big Endian\n");
> +		return -EIO;
> +	} else if (!(fctl & RISCV_IOMMU_FCTL_BE)) {
> +		fctl |= FIELD_PREP(RISCV_IOMMU_FCTL_BE, 1);
> +		riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, fctl);
> +	}
> +#endif
> +
> +	/* Clear any pending interrupt flag. */
> +	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR,
> +			   RISCV_IOMMU_IPSR_CIP |
> +			   RISCV_IOMMU_IPSR_FIP |
> +			   RISCV_IOMMU_IPSR_PMIP | RISCV_IOMMU_IPSR_PIP);
> +	spin_lock_init(&iommu->cq_lock);
> +	mutex_init(&iommu->eps_mutex);
> +
> +	ret = riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_BARE);

Um, yeah, you definitely don't support blocking domains if you just put 
the whole thing in bypass :/

> +
> +	if (ret) {
> +		dev_err(dev, "cannot enable iommu device (%d)\n", ret);
> +		goto fail;
> +	}
> +
> +	ret = iommu_device_register(&iommu->iommu, &riscv_iommu_ops, dev);
> +	if (ret) {
> +		dev_err(dev, "cannot register iommu interface (%d)\n", ret);
> +		iommu_device_sysfs_remove(&iommu->iommu);

But it was never added?

> +		goto fail;
> +	}
> +
> +	return 0;
> + fail:
> +	riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
> +	return ret;
> +}
[...]
I appreciate the attempt to split the series up and not have one giant 
4000-line patch, but I have to say it's kind of hard to usefully review 
a patch like this where I'm struggling to tell the "real" code from the 
unfinished dead ends and plain nonsense. I'd suggest splitting it up 
slightly differently: strip out all the IOMMU API stuff here and just 
have this patch add the basic probing and hardware initialisation, then 
add the queues, device tables and pagetables, *then* wire it all up to 
the IOMMU API once it can be meaningfully functional. It ought to be 
possible to have each patch be purely additions of "final" code, no 
temporary placeholders and weird bodges just to let a bisection compile 
and/or pretend to work. Then "extra" features like SVA can be built on 
top as you have already. And of course we like the dt binding to be 
patch #1 :)

Thanks,
Robin.

Return-Path: <linux-kernel+bounces-138809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 495DC89FA9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40E5282F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B691791F2;
	Wed, 10 Apr 2024 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y+x/0sS8"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD831791E3;
	Wed, 10 Apr 2024 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760494; cv=none; b=o3v0PX2w+hGfQ6gnjzTgDok+5utWlmnTE3Am2RqBd2txptC6G/Z9HdJ/jAu/yWcsPpOghX4vcbh52N417xa4OhcM5tyzSRVa+ybIq/Fw1axBcPjjQBpJ1SoaoXm9/bEuj0HSYLcvwbR65goolrAP6n97yzYNsRhcPtJd0kO65TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760494; c=relaxed/simple;
	bh=Mx5APfYhQ6qs5XDiUnGjy2sblyz/TZEUPgdHnLlwSDg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LlYNYxAeKYh0tcHkUU4MSVfLlnnqw7GfKJiji92+LpSWLxDQo6JwIvz3Lj7USe55XW8z8rvWa5BQJM5tlDUCH4PzqveDBVptl0McJktCVMStlY27CDjeJvDd5PRqr8D+1QUDImEhmUWxmm8dFK3mwPc7dK50GKQ+MEZuhpgEiLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=y+x/0sS8; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43AEm5Tb035928;
	Wed, 10 Apr 2024 09:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712760485;
	bh=Q/30NjVleNgQNZ3XCNKdXg6b3jHd8lHtPEirYkxXq9c=;
	h=From:To:CC:Subject:Date;
	b=y+x/0sS8v0OtrDosvluY/MUt0eClge5CFjJYOQMdtoItO0HcwXy2Cwnel0sXpEnX8
	 4xDDaVxExU2oboIYcEPP4/y92vx9Xg49axIksCzz4c/qph5ql0YdRHT4HO8nKylsA+
	 U3nmeL2WQNY2cE9NHEUw3Qu956dijM9sUTYQvazo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43AEm5qX073598
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 09:48:05 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 09:48:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 09:48:04 -0500
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43AEm4UE048097;
	Wed, 10 Apr 2024 09:48:04 -0500
From: Andrew Davis <afd@ti.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren
	<tony@atomide.com>,
        Matthijs van Duin <matthijsvanduin@gmail.com>,
        Robert
 Nelson <robertcnelson@gmail.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>
CC: <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH v2] uio: pruss: Remove this driver
Date: Wed, 10 Apr 2024 09:48:03 -0500
Message-ID: <20240410144803.126831-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This UIO driver was used to control the PRU processors found on various
TI SoCs. It was created before the Remoteproc framework, but now with
that we have a standard way to program and manage the PRU processors.
The proper PRU Remoteproc driver should be used instead of this driver.

This driver only supported the original class of PRUSS (OMAP-L1xx /
AM17xx / AM18xx / TMS320C674x / DA8xx) but when these platforms were
switched to use Device Tree the support for DT was not added to this
driver and so it is now unused/unusable. Support for these platforms
can be added to the proper PRU Remoteproc driver if ever needed.

Remove this driver.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes for v2:
 - Simply remove the whole driver as discussed here[0]

[0] https://lore.kernel.org/lkml/20240325210045.153827-1-afd@ti.com/T/

 drivers/uio/Kconfig                     |  18 --
 drivers/uio/Makefile                    |   1 -
 drivers/uio/uio_pruss.c                 | 255 ------------------------
 include/linux/platform_data/uio_pruss.h |  18 --
 4 files changed, 292 deletions(-)
 delete mode 100644 drivers/uio/uio_pruss.c
 delete mode 100644 include/linux/platform_data/uio_pruss.h

diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 2e16c5338e5b1..b060dcd7c6350 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -125,24 +125,6 @@ config UIO_FSL_ELBC_GPCM_NETX5152
 	  Information about this hardware can be found at:
 	  http://www.hilscher.com/netx
 
-config UIO_PRUSS
-	tristate "Texas Instruments PRUSS driver"
-	select GENERIC_ALLOCATOR
-	depends on HAS_IOMEM && HAS_DMA
-	help
-	  PRUSS driver for OMAPL138/DA850/AM18XX devices
-	  PRUSS driver requires user space components, examples and user space
-	  driver is available from below SVN repo - you may use anonymous login
-
-	  https://gforge.ti.com/gf/project/pru_sw/
-
-	  More info on API is available at below wiki
-
-	  http://processors.wiki.ti.com/index.php/PRU_Linux_Application_Loader
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called uio_pruss.
-
 config UIO_MF624
 	tristate "Humusoft MF624 DAQ PCI card driver"
 	depends on PCI
diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
index f2f416a142286..1c5f3b5a95cf5 100644
--- a/drivers/uio/Makefile
+++ b/drivers/uio/Makefile
@@ -7,7 +7,6 @@ obj-$(CONFIG_UIO_AEC)	+= uio_aec.o
 obj-$(CONFIG_UIO_SERCOS3)	+= uio_sercos3.o
 obj-$(CONFIG_UIO_PCI_GENERIC)	+= uio_pci_generic.o
 obj-$(CONFIG_UIO_NETX)	+= uio_netx.o
-obj-$(CONFIG_UIO_PRUSS)         += uio_pruss.o
 obj-$(CONFIG_UIO_MF624)         += uio_mf624.o
 obj-$(CONFIG_UIO_FSL_ELBC_GPCM)	+= uio_fsl_elbc_gpcm.o
 obj-$(CONFIG_UIO_HV_GENERIC)	+= uio_hv_generic.o
diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
deleted file mode 100644
index f67881cba645b..0000000000000
--- a/drivers/uio/uio_pruss.c
+++ /dev/null
@@ -1,255 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Programmable Real-Time Unit Sub System (PRUSS) UIO driver (uio_pruss)
- *
- * This driver exports PRUSS host event out interrupts and PRUSS, L3 RAM,
- * and DDR RAM to user space for applications interacting with PRUSS firmware
- *
- * Copyright (C) 2010-11 Texas Instruments Incorporated - http://www.ti.com/
- */
-#include <linux/device.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/platform_device.h>
-#include <linux/uio_driver.h>
-#include <linux/platform_data/uio_pruss.h>
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <linux/dma-mapping.h>
-#include <linux/sizes.h>
-#include <linux/slab.h>
-#include <linux/genalloc.h>
-
-#define DRV_NAME "pruss_uio"
-#define DRV_VERSION "1.0"
-
-static int sram_pool_sz = SZ_16K;
-module_param(sram_pool_sz, int, 0);
-MODULE_PARM_DESC(sram_pool_sz, "sram pool size to allocate ");
-
-static int extram_pool_sz = SZ_256K;
-module_param(extram_pool_sz, int, 0);
-MODULE_PARM_DESC(extram_pool_sz, "external ram pool size to allocate");
-
-/*
- * Host event IRQ numbers from PRUSS - PRUSS can generate up to 8 interrupt
- * events to AINTC of ARM host processor - which can be used for IPC b/w PRUSS
- * firmware and user space application, async notification from PRU firmware
- * to user space application
- * 3	PRU_EVTOUT0
- * 4	PRU_EVTOUT1
- * 5	PRU_EVTOUT2
- * 6	PRU_EVTOUT3
- * 7	PRU_EVTOUT4
- * 8	PRU_EVTOUT5
- * 9	PRU_EVTOUT6
- * 10	PRU_EVTOUT7
-*/
-#define MAX_PRUSS_EVT	8
-
-#define PINTC_HIDISR	0x0038
-#define PINTC_HIPIR	0x0900
-#define HIPIR_NOPEND	0x80000000
-#define PINTC_HIER	0x1500
-
-struct uio_pruss_dev {
-	struct uio_info *info;
-	struct clk *pruss_clk;
-	dma_addr_t sram_paddr;
-	dma_addr_t ddr_paddr;
-	void __iomem *prussio_vaddr;
-	unsigned long sram_vaddr;
-	void *ddr_vaddr;
-	unsigned int hostirq_start;
-	unsigned int pintc_base;
-	struct gen_pool *sram_pool;
-};
-
-static irqreturn_t pruss_handler(int irq, struct uio_info *info)
-{
-	struct uio_pruss_dev *gdev = info->priv;
-	int intr_bit = (irq - gdev->hostirq_start + 2);
-	int val, intr_mask = (1 << intr_bit);
-	void __iomem *base = gdev->prussio_vaddr + gdev->pintc_base;
-	void __iomem *intren_reg = base + PINTC_HIER;
-	void __iomem *intrdis_reg = base + PINTC_HIDISR;
-	void __iomem *intrstat_reg = base + PINTC_HIPIR + (intr_bit << 2);
-
-	val = ioread32(intren_reg);
-	/* Is interrupt enabled and active ? */
-	if (!(val & intr_mask) && (ioread32(intrstat_reg) & HIPIR_NOPEND))
-		return IRQ_NONE;
-	/* Disable interrupt */
-	iowrite32(intr_bit, intrdis_reg);
-	return IRQ_HANDLED;
-}
-
-static void pruss_cleanup(struct device *dev, struct uio_pruss_dev *gdev)
-{
-	int cnt;
-	struct uio_info *p = gdev->info;
-
-	for (cnt = 0; cnt < MAX_PRUSS_EVT; cnt++, p++) {
-		uio_unregister_device(p);
-	}
-	iounmap(gdev->prussio_vaddr);
-	if (gdev->ddr_vaddr) {
-		dma_free_coherent(dev, extram_pool_sz, gdev->ddr_vaddr,
-			gdev->ddr_paddr);
-	}
-	if (gdev->sram_vaddr)
-		gen_pool_free(gdev->sram_pool,
-			      gdev->sram_vaddr,
-			      sram_pool_sz);
-	clk_disable(gdev->pruss_clk);
-}
-
-static int pruss_probe(struct platform_device *pdev)
-{
-	struct uio_info *p;
-	struct uio_pruss_dev *gdev;
-	struct resource *regs_prussio;
-	struct device *dev = &pdev->dev;
-	int ret, cnt, i, len;
-	struct uio_pruss_pdata *pdata = dev_get_platdata(dev);
-
-	gdev = devm_kzalloc(dev, sizeof(struct uio_pruss_dev), GFP_KERNEL);
-	if (!gdev)
-		return -ENOMEM;
-
-	gdev->info = devm_kcalloc(dev, MAX_PRUSS_EVT, sizeof(*p), GFP_KERNEL);
-	if (!gdev->info)
-		return -ENOMEM;
-
-	/* Power on PRU in case its not done as part of boot-loader */
-	gdev->pruss_clk = devm_clk_get(dev, "pruss");
-	if (IS_ERR(gdev->pruss_clk)) {
-		dev_err(dev, "Failed to get clock\n");
-		return PTR_ERR(gdev->pruss_clk);
-	}
-
-	ret = clk_enable(gdev->pruss_clk);
-	if (ret) {
-		dev_err(dev, "Failed to enable clock\n");
-		return ret;
-	}
-
-	regs_prussio = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!regs_prussio) {
-		dev_err(dev, "No PRUSS I/O resource specified\n");
-		ret = -EIO;
-		goto err_clk_disable;
-	}
-
-	if (!regs_prussio->start) {
-		dev_err(dev, "Invalid memory resource\n");
-		ret = -EIO;
-		goto err_clk_disable;
-	}
-
-	if (pdata->sram_pool) {
-		gdev->sram_pool = pdata->sram_pool;
-		gdev->sram_vaddr =
-			(unsigned long)gen_pool_dma_alloc(gdev->sram_pool,
-					sram_pool_sz, &gdev->sram_paddr);
-		if (!gdev->sram_vaddr) {
-			dev_err(dev, "Could not allocate SRAM pool\n");
-			ret = -ENOMEM;
-			goto err_clk_disable;
-		}
-	}
-
-	gdev->ddr_vaddr = dma_alloc_coherent(dev, extram_pool_sz,
-				&(gdev->ddr_paddr), GFP_KERNEL | GFP_DMA);
-	if (!gdev->ddr_vaddr) {
-		dev_err(dev, "Could not allocate external memory\n");
-		ret = -ENOMEM;
-		goto err_free_sram;
-	}
-
-	len = resource_size(regs_prussio);
-	gdev->prussio_vaddr = ioremap(regs_prussio->start, len);
-	if (!gdev->prussio_vaddr) {
-		dev_err(dev, "Can't remap PRUSS I/O  address range\n");
-		ret = -ENOMEM;
-		goto err_free_ddr_vaddr;
-	}
-
-	ret = platform_get_irq(pdev, 0);
-	if (ret < 0)
-		goto err_unmap;
-
-	gdev->hostirq_start = ret;
-	gdev->pintc_base = pdata->pintc_base;
-
-	for (cnt = 0, p = gdev->info; cnt < MAX_PRUSS_EVT; cnt++, p++) {
-		p->mem[0].addr = regs_prussio->start;
-		p->mem[0].size = resource_size(regs_prussio);
-		p->mem[0].memtype = UIO_MEM_PHYS;
-
-		p->mem[1].addr = gdev->sram_paddr;
-		p->mem[1].size = sram_pool_sz;
-		p->mem[1].memtype = UIO_MEM_PHYS;
-
-		p->mem[2].addr = (uintptr_t) gdev->ddr_vaddr;
-		p->mem[2].dma_addr = gdev->ddr_paddr;
-		p->mem[2].size = extram_pool_sz;
-		p->mem[2].memtype = UIO_MEM_DMA_COHERENT;
-		p->mem[2].dma_device = dev;
-
-		p->name = devm_kasprintf(dev, GFP_KERNEL, "pruss_evt%d", cnt);
-		p->version = DRV_VERSION;
-
-		/* Register PRUSS IRQ lines */
-		p->irq = gdev->hostirq_start + cnt;
-		p->handler = pruss_handler;
-		p->priv = gdev;
-
-		ret = uio_register_device(dev, p);
-		if (ret < 0)
-			goto err_unloop;
-	}
-
-	platform_set_drvdata(pdev, gdev);
-	return 0;
-
-err_unloop:
-	for (i = 0, p = gdev->info; i < cnt; i++, p++) {
-		uio_unregister_device(p);
-	}
-err_unmap:
-	iounmap(gdev->prussio_vaddr);
-err_free_ddr_vaddr:
-	dma_free_coherent(dev, extram_pool_sz, gdev->ddr_vaddr,
-			  gdev->ddr_paddr);
-err_free_sram:
-	if (pdata->sram_pool)
-		gen_pool_free(gdev->sram_pool, gdev->sram_vaddr, sram_pool_sz);
-err_clk_disable:
-	clk_disable(gdev->pruss_clk);
-
-	return ret;
-}
-
-static int pruss_remove(struct platform_device *dev)
-{
-	struct uio_pruss_dev *gdev = platform_get_drvdata(dev);
-
-	pruss_cleanup(&dev->dev, gdev);
-	return 0;
-}
-
-static struct platform_driver pruss_driver = {
-	.probe = pruss_probe,
-	.remove = pruss_remove,
-	.driver = {
-		   .name = DRV_NAME,
-		   },
-};
-
-module_platform_driver(pruss_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_VERSION(DRV_VERSION);
-MODULE_AUTHOR("Amit Chatterjee <amit.chatterjee@ti.com>");
-MODULE_AUTHOR("Pratheesh Gangadhar <pratheesh@ti.com>");
diff --git a/include/linux/platform_data/uio_pruss.h b/include/linux/platform_data/uio_pruss.h
deleted file mode 100644
index f76fa393b8023..0000000000000
--- a/include/linux/platform_data/uio_pruss.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * include/linux/platform_data/uio_pruss.h
- *
- * Platform data for uio_pruss driver
- *
- * Copyright (C) 2010-11 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-#ifndef _UIO_PRUSS_H_
-#define _UIO_PRUSS_H_
-
-/* To configure the PRUSS INTC base offset for UIO driver */
-struct uio_pruss_pdata {
-	u32		pintc_base;
-	struct gen_pool *sram_pool;
-};
-#endif /* _UIO_PRUSS_H_ */
-- 
2.39.2



Return-Path: <linux-kernel+bounces-105008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF4787D78E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4EF1F22D3E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC75E29A0;
	Sat, 16 Mar 2024 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JQHH7dXl"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94891FBB
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 00:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710548440; cv=none; b=iGilyd4qTx6fRbOakZNL/mlFP6MW+J5GxiXRk4JDmB7ZaSJZFtgDnHiLkbL0PRveDd2Iv8r/mSJNkEdKvwt3h+AAh13duOa8XFVm6wRLelYDVmbnF3WVWMMKfKgM+n/ihf6eocVZYgLz6uqWjGzA+p4CMn/ciV1fPi06iskWgKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710548440; c=relaxed/simple;
	bh=MqM80X4YxgW81337vJavfc/7oIgD/nNEZ9Fcqx5I+F4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbJW8ECJCzcRX+xyCKPgWXjuPhPUMkvcomY+/mao6EMx78nZjuubIyeYFcxy9aaIfFM66BKDWynmEupxio5h07+e1m/bz2xlwVZ4NH+j/+NOcR283phKqc/OmJBXL32LV4lH/h5KPaX0cgdjH15Md5/nw5zrT+PgbA/UTca+l9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JQHH7dXl; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710548435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kzD2gMkOSPKtFcjYM57vdZKog7Idle/NFA0nNQdkuYA=;
	b=JQHH7dXlsHsAAYYOCKBwMuhFu5A13vM/QCfxMiIfy8UI0HTbIBfR99LiBvcX+YCOqR4P5t
	1u8/bnbmmk+prgo8IlnWRRoQ8Os8wDuaua4mR0JiIO7tWxHl7f3Ug7P3WBBqvB8QbVtZA+
	p6n1dqIfe91B2YpkJmW9rhoUP2CdchU=
From: Sean Anderson <sean.anderson@linux.dev>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Richard Alpe <richard@bit42.se>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Michael Walle <michael@walle.cc>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 2/2] nvmem: Remove qoriq-efuse in favor of layerscape-sfp
Date: Fri, 15 Mar 2024 20:20:26 -0400
Message-Id: <20240316002026.1808336-2-sean.anderson@linux.dev>
In-Reply-To: <20240316002026.1808336-1-sean.anderson@linux.dev>
References: <20240316002026.1808336-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The qoriq-efuse driver is a duplicate of layerscape-sfp.c. The T-series
uses TA 2.0, while Layerscape uses TA 2.1 or 3.0 (depending on the
chip). Add appropriate compatibles to the layerscape-sfp driver and
remove the qoriq-efuse driver. I did not add support for P-series SoCs,
since they use TA 1.0 which doesn't share a major version with either of
the existing implementations.

The qoriq-efuse driver does not properly abstract the location/offset of
the fuses properly, instead exposing the device's whole address range to
userspace. This is not appropriate, as the fuses only occupy a small
portion of this range. The layerscape-sfp module correctly constrains
the nvmem size to the fuses size. This represents a (necessary)
compatibility break. The qoriq-efuse driver has been in-tree for around
six months. Hopefully this will limit the fallout.

I would appreciate if someone with access to trust architecture 2.0 user
guide could confirm the number of fuses.

Fixes: 0861110bb421 ("nvmem: add new NXP QorIQ eFuse driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/nvmem/Kconfig          | 14 +-----
 drivers/nvmem/Makefile         |  2 -
 drivers/nvmem/layerscape-sfp.c | 27 +++++++++---
 drivers/nvmem/qoriq-efuse.c    | 78 ----------------------------------
 4 files changed, 22 insertions(+), 99 deletions(-)
 delete mode 100644 drivers/nvmem/qoriq-efuse.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 5bc9c4874fe3..81531ebb073d 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -122,7 +122,7 @@ config NVMEM_LAN9662_OTPC
 
 config NVMEM_LAYERSCAPE_SFP
 	tristate "Layerscape SFP (Security Fuse Processor) support"
-	depends on ARCH_LAYERSCAPE || COMPILE_TEST
+	depends on ARCH_LAYERSCAPE || PPC_85xx || COMPILE_TEST
 	depends on HAS_IOMEM
 	select REGMAP_MMIO
 	help
@@ -405,16 +405,4 @@ config NVMEM_ZYNQMP
 
 	  If sure, say yes. If unsure, say no.
 
-config NVMEM_QORIQ_EFUSE
-	tristate "NXP QorIQ eFuse support"
-	depends on PPC_85xx || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  This driver provides read support for the eFuses (SFP) on NXP QorIQ
-	  series SoC's. This includes secure boot settings, the globally unique
-	  NXP ID 'FUIDR' and the OEM unique ID 'OUIDR'.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem_qoriq_efuse.
-
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 423baf089515..a276447b8c2f 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -79,5 +79,3 @@ obj-$(CONFIG_NVMEM_VF610_OCOTP)		+= nvmem-vf610-ocotp.o
 nvmem-vf610-ocotp-y			:= vf610-ocotp.o
 obj-$(CONFIG_NVMEM_ZYNQMP)		+= nvmem_zynqmp_nvmem.o
 nvmem_zynqmp_nvmem-y			:= zynqmp_nvmem.o
-obj-$(CONFIG_NVMEM_QORIQ_EFUSE)		+= nvmem-qoriq-efuse.o
-nvmem-qoriq-efuse-y			:= qoriq-efuse.o
diff --git a/drivers/nvmem/layerscape-sfp.c b/drivers/nvmem/layerscape-sfp.c
index e2b424561949..7e32133e492a 100644
--- a/drivers/nvmem/layerscape-sfp.c
+++ b/drivers/nvmem/layerscape-sfp.c
@@ -22,8 +22,9 @@ struct layerscape_sfp_priv {
 };
 
 struct layerscape_sfp_data {
-	int size;
+	int size, id;
 	enum regmap_endian endian;
+	const char *name;
 };
 
 static int layerscape_sfp_read(void *context, unsigned int offset, void *val,
@@ -37,7 +38,6 @@ static int layerscape_sfp_read(void *context, unsigned int offset, void *val,
 }
 
 static struct nvmem_config layerscape_sfp_nvmem_config = {
-	.name = "fsl-sfp",
 	.reg_read = layerscape_sfp_read,
 	.word_size = 4,
 	.stride = 4,
@@ -69,6 +69,8 @@ static int layerscape_sfp_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
+	layerscape_sfp_nvmem_config.name = data->name;
+	layerscape_sfp_nvmem_config.id = data->id;
 	layerscape_sfp_nvmem_config.size = data->size;
 	layerscape_sfp_nvmem_config.dev = &pdev->dev;
 	layerscape_sfp_nvmem_config.priv = priv;
@@ -78,19 +80,32 @@ static int layerscape_sfp_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(nvmem);
 }
 
-static const struct layerscape_sfp_data ls1021a_data = {
+static const struct layerscape_sfp_data ta2_0_data = {
 	.size = 0x88,
 	.endian = REGMAP_ENDIAN_BIG,
+	.name = "qoriq_efuse_read",
+	.id = NVMEM_DEVID_AUTO,
 };
 
-static const struct layerscape_sfp_data ls1028a_data = {
+static const struct layerscape_sfp_data ta2_1_data = {
+	.size = 0x88,
+	.endian = REGMAP_ENDIAN_BIG,
+	.name = "fsl-sfp",
+};
+
+static const struct layerscape_sfp_data ta3_0_data = {
 	.size = 0x88,
 	.endian = REGMAP_ENDIAN_LITTLE,
+	.name = "fsl-sfp",
 };
 
 static const struct of_device_id layerscape_sfp_dt_ids[] = {
-	{ .compatible = "fsl,ls1021a-sfp", .data = &ls1021a_data },
-	{ .compatible = "fsl,ls1028a-sfp", .data = &ls1028a_data },
+	{ .compatible = "fsl,ls1021a-sfp", .data = &ta2_1_data },
+	{ .compatible = "fsl,ls1028a-sfp", .data = &ta3_0_data },
+	{ .compatible = "fsl,t1023-sfp", .data = &ta2_0_data },
+	{ .compatible = "fsl,t1040-sfp", .data = &ta2_0_data },
+	{ .compatible = "fsl,t2080-sfp", .data = &ta2_0_data },
+	{ .compatible = "fsl,t4240-sfp", .data = &ta2_0_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, layerscape_sfp_dt_ids);
diff --git a/drivers/nvmem/qoriq-efuse.c b/drivers/nvmem/qoriq-efuse.c
deleted file mode 100644
index e7fd04d6dd94..000000000000
--- a/drivers/nvmem/qoriq-efuse.c
+++ /dev/null
@@ -1,78 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  Copyright (C) 2023  Westermo Network Technologies AB
- */
-
-#include <linux/device.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
-#include <linux/nvmem-provider.h>
-#include <linux/platform_device.h>
-
-struct qoriq_efuse_priv {
-	void __iomem *base;
-};
-
-static int qoriq_efuse_read(void *context, unsigned int offset, void *val,
-			    size_t bytes)
-{
-	struct qoriq_efuse_priv *priv = context;
-
-	/* .stride = 4 so offset is guaranteed to be aligned */
-	__ioread32_copy(val, priv->base + offset, bytes / 4);
-
-	/* Ignore trailing bytes (there shouldn't be any) */
-
-	return 0;
-}
-
-static int qoriq_efuse_probe(struct platform_device *pdev)
-{
-	struct nvmem_config config = {
-		.dev = &pdev->dev,
-		.read_only = true,
-		.reg_read = qoriq_efuse_read,
-		.stride = sizeof(u32),
-		.word_size = sizeof(u32),
-		.name = "qoriq_efuse_read",
-		.id = NVMEM_DEVID_AUTO,
-		.root_only = true,
-	};
-	struct qoriq_efuse_priv *priv;
-	struct nvmem_device *nvmem;
-	struct resource *res;
-
-	priv = devm_kzalloc(config.dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
-
-	config.size = resource_size(res);
-	config.priv = priv;
-	nvmem = devm_nvmem_register(config.dev, &config);
-
-	return PTR_ERR_OR_ZERO(nvmem);
-}
-
-static const struct of_device_id qoriq_efuse_of_match[] = {
-	{ .compatible = "fsl,t1023-sfp", },
-	{/* sentinel */},
-};
-MODULE_DEVICE_TABLE(of, qoriq_efuse_of_match);
-
-static struct platform_driver qoriq_efuse_driver = {
-	.probe = qoriq_efuse_probe,
-	.driver = {
-		.name = "qoriq-efuse",
-		.of_match_table = qoriq_efuse_of_match,
-	},
-};
-module_platform_driver(qoriq_efuse_driver);
-
-MODULE_AUTHOR("Richard Alpe <richard.alpe@bit42.se>");
-MODULE_DESCRIPTION("NXP QorIQ Security Fuse Processor (SFP) Reader");
-MODULE_LICENSE("GPL");
-- 
2.35.1.1320.gc452695387.dirty



Return-Path: <linux-kernel+bounces-77735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BC0860991
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964931C247BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA0D14AB8;
	Fri, 23 Feb 2024 03:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y+hUybMk"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D890311CBB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660114; cv=none; b=SDaZrYyGd9i3453g/ZHy8MXt0Nbih/Yd9GhDoxhf5Buue+uyV1T7R+3YWDFCfxPOFbEaMAhbiC7avl7fn+FM0URP066L8J9R6dn5DyrSHLVtA7ey8VkynPEeorPFIrYWn0NAyAcZ+/nNLdMMtiMIEgVpuvoBR93rEKXbNRBRFfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660114; c=relaxed/simple;
	bh=EeGtyBgoJGvKhK566NbjS/AeMLp0JeoYSWnEnJys/0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JaB+6hVTTW4T6jE+1+hBdlGJar7u2j2MDjgb6szQWY8YTPvnIVYRleVmTtjxcUKA/hh2PbBYoOa7xRf8l5OC+31ZPi3nucIlRM4nGm8k9HpfxGqqww2G3RmzksxH4R6Y0v5iw/CUdWDkmOcqct7URS4THBv8Rzdrg00mo1DoNx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y+hUybMk; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 46E24C00593C;
	Thu, 22 Feb 2024 19:48:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 46E24C00593C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1708660112;
	bh=EeGtyBgoJGvKhK566NbjS/AeMLp0JeoYSWnEnJys/0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+hUybMkBmpNuTBcO0NrknPLZtK1Y2wLqYJLN5P0UOrcXl/0i+F7Pgk2m3kcMf9+o
	 01lc4vW/4ivGVT2RqJj6o3sZZtaJMen3U5kHyGhcTsW8izTVlBvBBDPpiMAzaGFlqu
	 zyxpH1+mx1+c5UzE+HYnPAU6AL80NF4/hbGuibhM=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id C0D4818041CAC4;
	Thu, 22 Feb 2024 19:48:30 -0800 (PST)
From: William Zhang <william.zhang@broadcom.com>
To: Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc: f.fainelli@gmail.com,
	kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com,
	anand.gore@broadcom.com,
	dregan@mail.com,
	kamal.dasu@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	William Zhang <william.zhang@broadcom.com>,
	David Regan <dregan@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH v6 10/13] mtd: rawnand: brcmnand: Rename bcm63138 nand driver
Date: Thu, 22 Feb 2024 19:47:55 -0800
Message-Id: <20240223034758.13753-11-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240223034758.13753-1-william.zhang@broadcom.com>
References: <20240223034758.13753-1-william.zhang@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In preparing to support multiple BCMBCA SoCs, rename bcm63138 to bcmbca
in the driver code and driver file name.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: David Regan <dregan@broadcom.com>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mtd/nand/raw/brcmnand/Makefile        |  2 +-
 drivers/mtd/nand/raw/brcmnand/bcm63138_nand.c | 99 -------------------
 drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c   | 99 +++++++++++++++++++
 3 files changed, 100 insertions(+), 100 deletions(-)
 delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm63138_nand.c
 create mode 100644 drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c

diff --git a/drivers/mtd/nand/raw/brcmnand/Makefile b/drivers/mtd/nand/raw/brcmnand/Makefile
index 9907e3ec4bb2..0536568c6467 100644
--- a/drivers/mtd/nand/raw/brcmnand/Makefile
+++ b/drivers/mtd/nand/raw/brcmnand/Makefile
@@ -2,7 +2,7 @@
 # link order matters; don't link the more generic brcmstb_nand.o before the
 # more specific iproc_nand.o, for instance
 obj-$(CONFIG_MTD_NAND_BRCMNAND_IPROC)	+= iproc_nand.o
-obj-$(CONFIG_MTD_NAND_BRCMNAND_BCMBCA)	+= bcm63138_nand.o
+obj-$(CONFIG_MTD_NAND_BRCMNAND_BCMBCA)	+= bcmbca_nand.o
 obj-$(CONFIG_MTD_NAND_BRCMNAND_BCM63XX)	+= bcm6368_nand.o
 obj-$(CONFIG_MTD_NAND_BRCMNAND_BRCMSTB)	+= brcmstb_nand.o
 obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand.o
diff --git a/drivers/mtd/nand/raw/brcmnand/bcm63138_nand.c b/drivers/mtd/nand/raw/brcmnand/bcm63138_nand.c
deleted file mode 100644
index 968c5b674b08..000000000000
--- a/drivers/mtd/nand/raw/brcmnand/bcm63138_nand.c
+++ /dev/null
@@ -1,99 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright © 2015 Broadcom Corporation
- */
-
-#include <linux/device.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-
-#include "brcmnand.h"
-
-struct bcm63138_nand_soc {
-	struct brcmnand_soc soc;
-	void __iomem *base;
-};
-
-#define BCM63138_NAND_INT_STATUS		0x00
-#define BCM63138_NAND_INT_EN			0x04
-
-enum {
-	BCM63138_CTLRDY		= BIT(4),
-};
-
-static bool bcm63138_nand_intc_ack(struct brcmnand_soc *soc)
-{
-	struct bcm63138_nand_soc *priv =
-			container_of(soc, struct bcm63138_nand_soc, soc);
-	void __iomem *mmio = priv->base + BCM63138_NAND_INT_STATUS;
-	u32 val = brcmnand_readl(mmio);
-
-	if (val & BCM63138_CTLRDY) {
-		brcmnand_writel(val & ~BCM63138_CTLRDY, mmio);
-		return true;
-	}
-
-	return false;
-}
-
-static void bcm63138_nand_intc_set(struct brcmnand_soc *soc, bool en)
-{
-	struct bcm63138_nand_soc *priv =
-			container_of(soc, struct bcm63138_nand_soc, soc);
-	void __iomem *mmio = priv->base + BCM63138_NAND_INT_EN;
-	u32 val = brcmnand_readl(mmio);
-
-	if (en)
-		val |= BCM63138_CTLRDY;
-	else
-		val &= ~BCM63138_CTLRDY;
-
-	brcmnand_writel(val, mmio);
-}
-
-static int bcm63138_nand_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct bcm63138_nand_soc *priv;
-	struct brcmnand_soc *soc;
-
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-	soc = &priv->soc;
-
-	priv->base = devm_platform_ioremap_resource_byname(pdev, "nand-int-base");
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
-
-	soc->ctlrdy_ack = bcm63138_nand_intc_ack;
-	soc->ctlrdy_set_enabled = bcm63138_nand_intc_set;
-
-	return brcmnand_probe(pdev, soc);
-}
-
-static const struct of_device_id bcm63138_nand_of_match[] = {
-	{ .compatible = "brcm,nand-bcm63138" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, bcm63138_nand_of_match);
-
-static struct platform_driver bcm63138_nand_driver = {
-	.probe			= bcm63138_nand_probe,
-	.remove_new		= brcmnand_remove,
-	.driver = {
-		.name		= "bcm63138_nand",
-		.pm		= &brcmnand_pm_ops,
-		.of_match_table	= bcm63138_nand_of_match,
-	}
-};
-module_platform_driver(bcm63138_nand_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Brian Norris");
-MODULE_DESCRIPTION("NAND driver for BCM63138");
diff --git a/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c b/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
new file mode 100644
index 000000000000..3e2f3b79788d
--- /dev/null
+++ b/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright © 2015 Broadcom Corporation
+ */
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "brcmnand.h"
+
+struct bcmbca_nand_soc {
+	struct brcmnand_soc soc;
+	void __iomem *base;
+};
+
+#define BCMBCA_NAND_INT_STATUS		0x00
+#define BCMBCA_NAND_INT_EN			0x04
+
+enum {
+	BCMBCA_CTLRDY		= BIT(4),
+};
+
+static bool bcmbca_nand_intc_ack(struct brcmnand_soc *soc)
+{
+	struct bcmbca_nand_soc *priv =
+			container_of(soc, struct bcmbca_nand_soc, soc);
+	void __iomem *mmio = priv->base + BCMBCA_NAND_INT_STATUS;
+	u32 val = brcmnand_readl(mmio);
+
+	if (val & BCMBCA_CTLRDY) {
+		brcmnand_writel(val & ~BCMBCA_CTLRDY, mmio);
+		return true;
+	}
+
+	return false;
+}
+
+static void bcmbca_nand_intc_set(struct brcmnand_soc *soc, bool en)
+{
+	struct bcmbca_nand_soc *priv =
+			container_of(soc, struct bcmbca_nand_soc, soc);
+	void __iomem *mmio = priv->base + BCMBCA_NAND_INT_EN;
+	u32 val = brcmnand_readl(mmio);
+
+	if (en)
+		val |= BCMBCA_CTLRDY;
+	else
+		val &= ~BCMBCA_CTLRDY;
+
+	brcmnand_writel(val, mmio);
+}
+
+static int bcmbca_nand_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct bcmbca_nand_soc *priv;
+	struct brcmnand_soc *soc;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	soc = &priv->soc;
+
+	priv->base = devm_platform_ioremap_resource_byname(pdev, "nand-int-base");
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	soc->ctlrdy_ack = bcmbca_nand_intc_ack;
+	soc->ctlrdy_set_enabled = bcmbca_nand_intc_set;
+
+	return brcmnand_probe(pdev, soc);
+}
+
+static const struct of_device_id bcmbca_nand_of_match[] = {
+	{ .compatible = "brcm,nand-bcm63138" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, bcmbca_nand_of_match);
+
+static struct platform_driver bcmbca_nand_driver = {
+	.probe			= bcmbca_nand_probe,
+	.remove_new		= brcmnand_remove,
+	.driver = {
+		.name		= "bcmbca_nand",
+		.pm		= &brcmnand_pm_ops,
+		.of_match_table	= bcmbca_nand_of_match,
+	}
+};
+module_platform_driver(bcmbca_nand_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Brian Norris");
+MODULE_DESCRIPTION("NAND driver for BCMBCA");
-- 
2.37.3



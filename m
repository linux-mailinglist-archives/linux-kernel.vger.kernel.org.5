Return-Path: <linux-kernel+bounces-36384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C035D839FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82E91C281FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA8BF50D;
	Wed, 24 Jan 2024 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YbIH7/aO"
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF73C2D9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065540; cv=none; b=cUX0zK6i2But7UzMiRMhT8xQcm84CHk6oaPEBGGnt/936Wu+dRil4uzv5JGDyN3A6H+wg87yL0ihwMhOdcR5s/0PpltVwLiLMWVuU6v9jM2fkcp28DURo99EHWgG4GJyxeH3sQ25u94RITrzkEEUXD0WhVUTAAQaDlo4Ka58wHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065540; c=relaxed/simple;
	bh=LgK9YFvSVaOhWSi9pLclCKLFO6H21lb2bPG3XI4TJgE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5rmM66qhhT2elN28EVdI9tooWJW6FYX1Lhwf8roPPmLxYqs5b+fWuGVxpNOwc34XeXP3uk8VlzYJPvTS/w1ZmQxh89y1Qp5miWx67VMODzFbLIqVofn6BA95Q3f/ktQdFXKi6o3MArJ3YLozEmH9QgNijV169RjXMi8rrLO59o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YbIH7/aO; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-20503dc09adso3085550fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706065537; x=1706670337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mLcQeF9FuXOK8WBCCfjegF2sdhYHzfwLhFZBOTQRFw=;
        b=YbIH7/aOvPYYNsgF73hr/KRy+hux8xaXQrPsROuS7RA75JfgvYXEC7ABdy8Dt2uqO4
         ja7k/pvCRajGLWXwcaiALCeee7LPBWJYb12Vzpxy5lDhlTysnYf5NUuTsLm++U/Cy96W
         x1nhXh60PL5FxmBspLuC/vUCTBLH5lYovzXrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065537; x=1706670337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mLcQeF9FuXOK8WBCCfjegF2sdhYHzfwLhFZBOTQRFw=;
        b=weSngaKrtPHLPij7MET9T4zNTi6AGFWU6YgH2YKiS4kp2BJ82j2zQ60TG5TSkyfZs+
         j1zznRLUyMSdiBZA9AvZaJqdE8ausLfz2jeV07q+K2MOyFAH9ggDVRz2sI6VjAFuuPQd
         8WAT7WDdbn/ynlYZXyNEwal3F2US/jKIUEBc5sRTlt4B1hXmC0ahP5hG/R7Yh9qDppxF
         FMqU+J7/TzD4X3X8RlT5tcU8bUqi26CAobAF1mwvqKH3/Urn9syyr0FzqhqtOx/+lk5B
         rVPwOHFjBcPIlgNMYxq9GEsQpqcZVDIB0tYS8HNFucyoyNmmugZ8ABXPoa4RNS01J5ff
         JVCw==
X-Gm-Message-State: AOJu0Yww6J4lmN2rrOPc/V7u5cPqlTcXmOt4xe/3U6ogEXRXbAUb6221
	BpkSsE2PQ1DYDflu1t2qa9vngrZqlXOLZ7fUoIuj6kJCR3LmBGh5yol77bRKi5btgWbLQBEsGdF
	hG4Nzb7R8/wAKTXeMceRQs1Rr0TwoCQ==
X-Google-Smtp-Source: AGHT+IEwti28KOgk5JZbqc8N7eflg26tiqxChRZ/UxnePrOnDyhH3lpOm9OG92/C6A9/jTILjSY5MuspsC4u
X-Received: by 2002:a05:6871:4319:b0:206:862e:1b86 with SMTP id lu25-20020a056871431900b00206862e1b86mr3131367oab.31.1706065537115;
        Tue, 23 Jan 2024 19:05:37 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp-relay.gmail.com with ESMTPS id c22-20020a056830349600b006dc7502beabsm455320otu.3.2024.01.23.19.05.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 19:05:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
From: David Regan <dregan@broadcom.com>
To: dregan@broadcom.com,
	dregan@mail.com,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	computersforpeace@gmail.com,
	kdasu.kdev@gmail.com,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joel.peshkin@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	william.zhang@broadcom.com,
	anand.gore@broadcom.com,
	kursad.oney@broadcom.com,
	florian.fainelli@broadcom.com,
	rafal@milecki.pl,
	bcm-kernel-feedback-list@broadcom.com,
	andre.przywara@arm.com,
	baruch@tkos.co.il,
	linux-arm-kernel@lists.infradead.org,
	dan.carpenter@linaro.org
Subject: [PATCH v3 04/10] mtd: rawnand: brcmnand: Rename bcm63138 nand driver
Date: Tue, 23 Jan 2024 19:04:52 -0800
Message-Id: <20240124030458.98408-5-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240124030458.98408-1-dregan@broadcom.com>
References: <20240124030458.98408-1-dregan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: William Zhang <william.zhang@broadcom.com>

In preparing to support multiple BCMBCA SoCs, rename bcm63138 to bcmbca
in the driver code and driver file name.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: David Regan <dregan@broadcom.com>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Changes in v3: None
---
Changes in v2: None
---
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



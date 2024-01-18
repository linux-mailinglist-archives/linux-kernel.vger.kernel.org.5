Return-Path: <linux-kernel+bounces-30535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEAA832000
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB45289BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F64231759;
	Thu, 18 Jan 2024 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P/rq/RGl"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A22E842
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607671; cv=none; b=qm9u1A5hencAAxgFb8ss603QPfZ+9DKSBmVOcHkNWDpwnsCyNcCC3h+yBJxoY7c4ExnjtpuqhiySC97SVdHCab68u7gUFiiBdFDDPuMvx3J1Li24bce51U2UJRG86iWrnkO+iw5CB7mkiOVnhK0jFIhw72r/lX2vBGQDO6kef0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607671; c=relaxed/simple;
	bh=CagddVJVlACkK6LQIFFZzS+/b11zlokZLNjt/IlJCe8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZxtm10TM0Qr2FnElVEx4JfkWOei8j8RAiVada1jF+8iycvmcZUc1ghlqdKC1nPVRdeobfTzPOc5nforR6AaBN1ZpDqAMBhsGOiRxPOgpoZB64h1eJxtiIHjlBr+aZm4IOnpQ0z1Zir+6Z4h7lEUxV0dCYIH2BVUbgfG7+8qLgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P/rq/RGl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d5f1e0e32eso21926735ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705607669; x=1706212469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jja3d4MjXLOFSymCPf/lawx88oSJHo/XoqweGhZS6o4=;
        b=P/rq/RGln3QrZBTrTS+M4d1QnQ0oMoeSHAJ6/oWDQRDN8WxAisRfdvkW0pECcqHo9h
         H0n+jDEAIfFk/YYcWRg83mjfBu8hw2hZmmU24ulYrHK6WgWn4Q18eWJdwbQUk9JsEBmS
         RJ15+wStUlrX/SQ16Iq7HZXeHC/xZpMenBGn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607669; x=1706212469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jja3d4MjXLOFSymCPf/lawx88oSJHo/XoqweGhZS6o4=;
        b=ZiEn4WsTL5NS5+OazUAemCL7ViHA4ie0I/n37cQVusEV279Jq7paSNYPcrIyB9D+Cu
         PKEsF/SknO1muTkFEOFX+fevfafg8okKg2evwgOVK9e9XY06rlf9pK4uwANs93tbe2Av
         MDh8IfkrP0sQGHSAHIx7TPqrFiMvrNYjQ33Zux4g0jyaGPQ+O1YYwwQBrBStpsRDPMNh
         v9eDrJM3EVrT/dNeOSd/KyjEMlekruouJjgsAlcqht4v+H6j7o3AKQMJNtOOEAgkfO35
         oiHBNyTniuUsrkBRnqTrHzXRaHHIq00HUCYdXCRhUQ9HgaTHAcfQVaspkexN1AGTUCyH
         +cIQ==
X-Gm-Message-State: AOJu0Yz6+6ZY8iLdr3Wqf60dMq5B5V31NnzvV4L4HHuSjnPPIXxNpZMU
	7e4Lw5JyLiWI3f997bi27IPPW7/vXdTIqLWZx5yrkvZfVyqX0ZecB4tUWbuZNw==
X-Google-Smtp-Source: AGHT+IGWaTCuAGpakDPXPQVCgRpiaK5V07i0ywdIak6g2Fqi80lRf2SNBFR3l9QCrOG60CmvedyNcw==
X-Received: by 2002:a17:90a:5d8d:b0:290:14a1:d6be with SMTP id t13-20020a17090a5d8d00b0029014a1d6bemr963862pji.75.1705607669413;
        Thu, 18 Jan 2024 11:54:29 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id rr12-20020a17090b2b4c00b0028d9b5d41edsm2263805pjb.38.2024.01.18.11.54.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2024 11:54:29 -0800 (PST)
From: dregan@broadcom.com
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
Subject: [PATCH v2 04/10] mtd: rawnand: brcmnand: Rename bcm63138 nand driver
Date: Thu, 18 Jan 2024 11:53:50 -0800
Message-Id: <20240118195356.133391-5-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240118195356.133391-1-dregan@broadcom.com>
References: <20240118195356.133391-1-dregan@broadcom.com>
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



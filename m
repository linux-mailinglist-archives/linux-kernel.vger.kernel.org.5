Return-Path: <linux-kernel+bounces-57725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95A884DCBE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089F61C22B45
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC946D1AC;
	Thu,  8 Feb 2024 09:21:24 +0000 (UTC)
Received: from esa1.ltts.com (unknown [118.185.121.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A881671B24
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.185.121.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384083; cv=none; b=MYXUKLOVyAYGr5cHZFRv4pi1uqKZEQ3tzjCPym1654MTGkfb0LDhuTkqZdINFuiE1zF4XGHhfoIj5k896Ywd/R5vRixrVMsWFxTgydvduTNSbbfVlfQvZ9xGqR/bi09tldunuzOSMqEOVbp5OB67YyGEza5jTe69VRefmJxZ6Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384083; c=relaxed/simple;
	bh=ThP1e59BE2y0a+k0wmwXnnRV7uTwiiZ0I39TuYzmV0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Shroq9K2wTpyPjsl0516kvn5CLlKMZ5vfJPnB/L5w3aWEa0ennEUxWnNEjedMzk78vjBZpF2bR34D6NJOh1TJSSWFx/QwdqJSN0DKr3pS/pSSawpr3iw68sUBeda0iB1aXdEmY4ZNFg9ZJ+o5tX3fV6xfm/fZKIElbjmO70ITHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=118.185.121.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: f+BS/AvZcIkT+V+vVDnXBhlduYS8eoLLZsdpJ+TVClBYt3xLPcOhYcpyy3BFtzoaiBINjAof0K
 82nVD8yU/m7w==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa1.ltts.com with ESMTP; 08 Feb 2024 14:51:14 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v1 09/13] misc: tps6594-esm: use regmap_field
Date: Thu,  8 Feb 2024 14:50:58 +0530
Message-Id: <20240208092059.1207134-3-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208092059.1207134-1-bhargav.r@ltts.com>
References: <20240208092059.1207134-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use regmap_field and associated APIs to update the ESM_MODE_CFG and
ESM_START registers. This helps in adding support for TPS65224 PMIC.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
---
 drivers/misc/tps6594-esm.c | 60 ++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/tps6594-esm.c b/drivers/misc/tps6594-esm.c
index 8ec5af9dc..d0f86b0e9 100644
--- a/drivers/misc/tps6594-esm.c
+++ b/drivers/misc/tps6594-esm.c
@@ -15,6 +15,19 @@
 
 #define TPS6594_DEV_REV_1 0x08
 
+#define ESM_MODE_CFG_SET  0xff
+#define ESM_START_SET     0xff
+#define ESM_MODE_CFG_CLR  0x0
+#define ESM_START_CLR     0x0
+
+static struct reg_field tps6594_esm_mode_cfg  = REG_FIELD(TPS6594_REG_ESM_SOC_MODE_CFG,  5, 6);
+static struct reg_field tps6594_esm_start     = REG_FIELD(TPS6594_REG_ESM_SOC_START_REG, 0, 0);
+
+struct tps6594_esm {
+	struct regmap_field *esm_mode_cfg;
+	struct regmap_field *esm_start;
+};
+
 static irqreturn_t tps6594_esm_isr(int irq, void *dev_id)
 {
 	struct platform_device *pdev = dev_id;
@@ -34,6 +47,7 @@ static int tps6594_esm_probe(struct platform_device *pdev)
 {
 	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
 	struct device *dev = &pdev->dev;
+	struct tps6594_esm *esm;
 	unsigned int rev;
 	int irq;
 	int ret;
@@ -69,13 +83,30 @@ static int tps6594_esm_probe(struct platform_device *pdev)
 			return dev_err_probe(dev, ret, "Failed to request irq\n");
 	}
 
-	ret = regmap_set_bits(tps->regmap, TPS6594_REG_ESM_SOC_MODE_CFG,
-			      TPS6594_BIT_ESM_SOC_EN | TPS6594_BIT_ESM_SOC_ENDRV);
+	esm = devm_kzalloc(dev, sizeof(struct tps6594_esm), GFP_KERNEL);
+	if (!esm)
+		return -ENOMEM;
+
+	esm->esm_mode_cfg = devm_regmap_field_alloc(dev, tps->regmap, tps6594_esm_mode_cfg);
+	esm->esm_start = devm_regmap_field_alloc(dev, tps->regmap, tps6594_esm_start);
+
+	if (IS_ERR(esm->esm_mode_cfg)) {
+		dev_err(dev, "esm_mode_cfg reg field init failed\n");
+		return PTR_ERR(esm->esm_mode_cfg);
+	}
+
+	if (IS_ERR(esm->esm_start)) {
+		dev_err(dev, "esm_start reg field init failed\n");
+		return PTR_ERR(esm->esm_start);
+	}
+
+	platform_set_drvdata(pdev, esm);
+
+	ret = regmap_field_write(esm->esm_mode_cfg, ESM_MODE_CFG_SET);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to configure ESM\n");
 
-	ret = regmap_set_bits(tps->regmap, TPS6594_REG_ESM_SOC_START_REG,
-			      TPS6594_BIT_ESM_SOC_START);
+	ret = regmap_field_write(esm->esm_start, ESM_START_SET);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to start ESM\n");
 
@@ -87,19 +118,17 @@ static int tps6594_esm_probe(struct platform_device *pdev)
 
 static void tps6594_esm_remove(struct platform_device *pdev)
 {
-	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
 	struct device *dev = &pdev->dev;
+	struct tps6594_esm *esm = platform_get_drvdata(pdev);
 	int ret;
 
-	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_ESM_SOC_START_REG,
-				TPS6594_BIT_ESM_SOC_START);
+	ret = regmap_field_write(esm->esm_start, ESM_START_CLR);
 	if (ret) {
 		dev_err(dev, "Failed to stop ESM\n");
 		goto out;
 	}
 
-	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_ESM_SOC_MODE_CFG,
-				TPS6594_BIT_ESM_SOC_EN | TPS6594_BIT_ESM_SOC_ENDRV);
+	ret = regmap_field_write(esm->esm_mode_cfg, ESM_MODE_CFG_CLR);
 	if (ret)
 		dev_err(dev, "Failed to unconfigure ESM\n");
 
@@ -110,11 +139,12 @@ static void tps6594_esm_remove(struct platform_device *pdev)
 
 static int tps6594_esm_suspend(struct device *dev)
 {
-	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
+	struct tps6594_esm *esm = platform_get_drvdata(pdev);
+
 	int ret;
 
-	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_ESM_SOC_START_REG,
-				TPS6594_BIT_ESM_SOC_START);
+	ret = regmap_field_write(esm->esm_start, ESM_START_CLR);
 
 	pm_runtime_put_sync(dev);
 
@@ -123,12 +153,12 @@ static int tps6594_esm_suspend(struct device *dev)
 
 static int tps6594_esm_resume(struct device *dev)
 {
-	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
+	struct tps6594_esm *esm = platform_get_drvdata(pdev);
 
 	pm_runtime_get_sync(dev);
 
-	return regmap_set_bits(tps->regmap, TPS6594_REG_ESM_SOC_START_REG,
-			       TPS6594_BIT_ESM_SOC_START);
+	return regmap_field_write(esm->esm_start, ESM_START_SET);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(tps6594_esm_pm_ops, tps6594_esm_suspend, tps6594_esm_resume);
-- 
2.25.1



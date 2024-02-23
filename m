Return-Path: <linux-kernel+bounces-78040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EAC860E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A54D0B22A03
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6C15F464;
	Fri, 23 Feb 2024 09:38:40 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B7F5E23A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681120; cv=none; b=G6J1GpuRNx0zHBfJ9EFJEfTYcc/C4+XCa09Skeeh+uBkhPzHPRNaNPLX2Oh6/Kthb9tToeTRMoM+x5UUlUbhyd2kVsqPQMMM8i0B5Gby+3Ll1P0/JojnEEgMlGs89GMerP6g1nGIErAlSP3WnN3vIhLQwrbgnrp3/CzhQsvC/Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681120; c=relaxed/simple;
	bh=ThP1e59BE2y0a+k0wmwXnnRV7uTwiiZ0I39TuYzmV0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vFcAHgXz8WhZibDQwb35RW8/eA+YsaUzimyy3tqxgis3pFzv6zfphy4KSdKOK29HNqA04t5LTPaMA1t8gbT9Q+iTFpTTHgQJSZPDqctjjZWHmLwMTIlDrGMwSmlnNAouEI8Vo3NQCC0bzqiYkJwmTcw1eehZvU/dMU4PzC273uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: RNlqvsbwZQUn3SXsRH7RrO5NiWao73Cty4roxzM2G5AU9Pw4OHO1MjnlawiRToHFnqKlcJ1k1s
 r4gn41iW7TUw==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 23 Feb 2024 15:07:17 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com,
	lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jpanis@baylibre.com,
	devicetree@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linus.walleij@linaro.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v2 10/14] misc: tps6594-esm: use regmap_field
Date: Fri, 23 Feb 2024 15:06:57 +0530
Message-Id: <20240223093701.66034-11-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223093701.66034-1-bhargav.r@ltts.com>
References: <20240223093701.66034-1-bhargav.r@ltts.com>
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



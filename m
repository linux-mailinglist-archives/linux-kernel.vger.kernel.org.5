Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BFF783B33
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjHVHws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjHVHwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:52:39 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427BC1B9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:52:34 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37M7pnxm026891;
        Tue, 22 Aug 2023 15:51:49 +0800 (+08)
        (envelope-from Jiansheng.Wu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RVM1g3NgRz2QDlXq;
        Tue, 22 Aug 2023 15:49:27 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 22 Aug
 2023 15:51:46 +0800
From:   Jiansheng Wu <jiansheng.wu@unisoc.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yongzhi.chen@unisoc.com>, <xiaoqing.wu@unisoc.com>,
        <jinfeng.lin1@unisoc.com>, <jianshengwu16@gmail.com>
Subject: [PATCH 2/2] mfd: sprd-sc27xx-spi: Add PMICs support for UMS9621 SoC
Date:   Tue, 22 Aug 2023 15:51:13 +0800
Message-ID: <20230822075113.25506-3-jiansheng.wu@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230822075113.25506-1-jiansheng.wu@unisoc.com>
References: <20230822075113.25506-1-jiansheng.wu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 37M7pnxm026891
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three PMICs (UMP9620/21/22) on Unisoc's UMS9621 chip.
UMP9620 is a master PMIC, the others are slave ones. Slave PMICs
don't have irq functions, which is different from master device,
such as SC27xx series and UMP9620, etc.

Signed-off-by: Jiansheng Wu <jiansheng.wu@unisoc.com>
---
 drivers/mfd/sprd-sc27xx-spi.c | 104 +++++++++++++++++++++++++---------
 1 file changed, 77 insertions(+), 27 deletions(-)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index d21f32cc784d..aa91301568a9 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -24,6 +24,10 @@
 #define SPRD_SC2731_IRQ_BASE		0x140
 #define SPRD_SC2731_IRQ_NUMS		16
 #define SPRD_SC2731_CHG_DET		0xedc
+#define SPRD_UMP9620_IRQ_BASE           0x80
+#define SPRD_UMP9620_IRQ_NUMS           11
+#define SPRD_UMP9621_SLAVE_ID           0x8000
+#define SPRD_UMP9622_SLAVE_ID           0xc000
 
 /* PMIC charger detection definition */
 #define SPRD_PMIC_CHG_DET_DELAY_US	200000
@@ -45,6 +49,7 @@ struct sprd_pmic {
 };
 
 struct sprd_pmic_data {
+	u32 slave_id;
 	u32 irq_base;
 	u32 num_irqs;
 	u32 charger_det;
@@ -67,6 +72,19 @@ static const struct sprd_pmic_data sc2731_data = {
 	.charger_det = SPRD_SC2731_CHG_DET,
 };
 
+static const struct sprd_pmic_data ump9620_data = {
+	.irq_base = SPRD_UMP9620_IRQ_BASE,
+	.num_irqs = SPRD_UMP9620_IRQ_NUMS,
+};
+
+static const struct sprd_pmic_data ump9621_data = {
+	.slave_id = SPRD_UMP9621_SLAVE_ID,
+};
+
+static const struct sprd_pmic_data ump9622_data = {
+	.slave_id = SPRD_UMP9622_SLAVE_ID,
+};
+
 enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
@@ -108,8 +126,27 @@ static int sprd_pmic_spi_write(void *context, const void *data, size_t count)
 {
 	struct device *dev = context;
 	struct spi_device *spi = to_spi_device(dev);
+	const struct sprd_pmic_data *pdata;
+	int ret;
+	u32 *pmdata;
+
+	if (!pdata->slave_id) {
+		ret = spi_write(spi, data, count);
+	} else {
+		pdata = ((struct sprd_pmic *)spi_get_drvdata(spi))->pdata;
+
+		pmdata = kzalloc(count, GFP_KERNEL);
+		if (!pmdata)
+			return -ENOMEM;
+		memcpy(pmdata, data, count);
+		*pmdata += pdata->slave_id;
+		ret = spi_write(spi, (const void *)pmdata, count);
+		kfree(pmdata);
+	}
+	if (ret)
+		pr_err("pmic mfd write failed!\n");
 
-	return spi_write(spi, data, count);
+	return ret;
 }
 
 static int sprd_pmic_spi_read(void *context,
@@ -118,6 +155,7 @@ static int sprd_pmic_spi_read(void *context,
 {
 	struct device *dev = context;
 	struct spi_device *spi = to_spi_device(dev);
+	const struct sprd_pmic_data *pdata;
 	u32 rx_buf[2] = { 0 };
 	int ret;
 
@@ -125,11 +163,16 @@ static int sprd_pmic_spi_read(void *context,
 	if (reg_size != sizeof(u32) || val_size != sizeof(u32))
 		return -EINVAL;
 
+	pdata = ((struct sprd_pmic *)spi_get_drvdata(spi))->pdata;
 	/* Copy address to read from into first element of SPI buffer. */
 	memcpy(rx_buf, reg, sizeof(u32));
+	if (!pdata->slave_id)
+		rx_buf[0] += pdata->slave_id;
 	ret = spi_read(spi, rx_buf, 1);
-	if (ret < 0)
+	if (ret < 0) {
+		pr_err("pmic mfd read failed!\n");
 		return ret;
+	}
 
 	memcpy(val, rx_buf, val_size);
 	return 0;
@@ -175,33 +218,34 @@ static int sprd_pmic_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, ddata);
 	ddata->dev = &spi->dev;
-	ddata->irq = spi->irq;
 	ddata->pdata = pdata;
 
-	ddata->irq_chip.name = dev_name(&spi->dev);
-	ddata->irq_chip.status_base =
-		pdata->irq_base + SPRD_PMIC_INT_MASK_STATUS;
-	ddata->irq_chip.unmask_base = pdata->irq_base + SPRD_PMIC_INT_EN;
-	ddata->irq_chip.ack_base = 0;
-	ddata->irq_chip.num_regs = 1;
-	ddata->irq_chip.num_irqs = pdata->num_irqs;
-
-	ddata->irqs = devm_kcalloc(&spi->dev,
-				   pdata->num_irqs, sizeof(struct regmap_irq),
-				   GFP_KERNEL);
-	if (!ddata->irqs)
-		return -ENOMEM;
-
-	ddata->irq_chip.irqs = ddata->irqs;
-	for (i = 0; i < pdata->num_irqs; i++)
-		ddata->irqs[i].mask = BIT(i);
-
-	ret = devm_regmap_add_irq_chip(&spi->dev, ddata->regmap, ddata->irq,
-				       IRQF_ONESHOT, 0,
-				       &ddata->irq_chip, &ddata->irq_data);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to add PMIC irq chip %d\n", ret);
-		return ret;
+	if (spi->irq) {
+		ddata->irq = spi->irq;
+		ddata->irq_chip.name = dev_name(&spi->dev);
+		ddata->irq_chip.status_base = pdata->irq_base + SPRD_PMIC_INT_MASK_STATUS;
+		ddata->irq_chip.unmask_base = pdata->irq_base + SPRD_PMIC_INT_EN;
+		ddata->irq_chip.ack_base = 0;
+		ddata->irq_chip.num_regs = 1;
+		ddata->irq_chip.num_irqs = pdata->num_irqs;
+
+		ddata->irqs = devm_kcalloc(&spi->dev,
+					   pdata->num_irqs, sizeof(struct regmap_irq),
+					   GFP_KERNEL);
+		if (!ddata->irqs)
+			return -ENOMEM;
+
+		ddata->irq_chip.irqs = ddata->irqs;
+		for (i = 0; i < pdata->num_irqs; i++)
+			ddata->irqs[i].mask = BIT(i);
+
+		ret = devm_regmap_add_irq_chip(&spi->dev, ddata->regmap, ddata->irq,
+					       IRQF_ONESHOT, 0,
+					       &ddata->irq_chip, &ddata->irq_data);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to add PMIC irq chip %d\n", ret);
+			return ret;
+		}
 	}
 
 	ret = devm_of_platform_populate(&spi->dev);
@@ -240,6 +284,9 @@ static DEFINE_SIMPLE_DEV_PM_OPS(sprd_pmic_pm_ops,
 static const struct of_device_id sprd_pmic_match[] = {
 	{ .compatible = "sprd,sc2730", .data = &sc2730_data },
 	{ .compatible = "sprd,sc2731", .data = &sc2731_data },
+	{ .compatible = "sprd,ump9620", .data = &ump9620_data },
+	{ .compatible = "sprd,ump9621", .data = &ump9621_data },
+	{ .compatible = "sprd,ump9622", .data = &ump9622_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sprd_pmic_match);
@@ -247,6 +294,9 @@ MODULE_DEVICE_TABLE(of, sprd_pmic_match);
 static const struct spi_device_id sprd_pmic_spi_ids[] = {
 	{ .name = "sc2730", .driver_data = (unsigned long)&sc2730_data },
 	{ .name = "sc2731", .driver_data = (unsigned long)&sc2731_data },
+	{ .name = "ump9620", .driver_data = (unsigned long)&ump9620_data },
+	{ .name = "ump9621", .driver_data = (unsigned long)&ump9621_data },
+	{ .name = "ump9622", .driver_data = (unsigned long)&ump9622_data },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, sprd_pmic_spi_ids);
-- 
2.17.1


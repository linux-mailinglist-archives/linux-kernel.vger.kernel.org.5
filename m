Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B8A771CFB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjHGJSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHGJSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:18:45 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BEEE68
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:18:42 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3779IKEC009527;
        Mon, 7 Aug 2023 17:18:20 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RK9g028ZKz2P7KBl;
        Mon,  7 Aug 2023 17:16:28 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 7 Aug 2023
 17:18:19 +0800
From:   Wenhua Lin <Wenhua.Lin@unisoc.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: [PATCH] gpio: sprd: Two-dimensional arrays maintain pmic eic
Date:   Mon, 7 Aug 2023 17:18:01 +0800
Message-ID: <20230807091801.17988-1-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 3779IKEC009527
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maintain the registers of each pmic eic through a Two-dimensional
array to avoid mutual interference.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/gpio/gpio-pmic-eic-sprd.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index c3e4d90f6b18..8d67d130cbcf 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -57,7 +57,7 @@ struct sprd_pmic_eic {
 	struct gpio_chip chip;
 	struct regmap *map;
 	u32 offset;
-	u8 reg[CACHE_NR_REGS];
+	u8 reg[SPRD_PMIC_EIC_NR][CACHE_NR_REGS];
 	struct mutex buslock;
 	int irq;
 };
@@ -151,8 +151,8 @@ static void sprd_pmic_eic_irq_mask(struct irq_data *data)
 	struct sprd_pmic_eic *pmic_eic = gpiochip_get_data(chip);
 	u32 offset = irqd_to_hwirq(data);
 
-	pmic_eic->reg[REG_IE] = 0;
-	pmic_eic->reg[REG_TRIG] = 0;
+	pmic_eic->reg[offset][REG_IE] = 0;
+	pmic_eic->reg[offset][REG_TRIG] = 0;
 
 	gpiochip_disable_irq(chip, offset);
 }
@@ -165,8 +165,8 @@ static void sprd_pmic_eic_irq_unmask(struct irq_data *data)
 
 	gpiochip_enable_irq(chip, offset);
 
-	pmic_eic->reg[REG_IE] = 1;
-	pmic_eic->reg[REG_TRIG] = 1;
+	pmic_eic->reg[offset][REG_IE] = 1;
+	pmic_eic->reg[offset][REG_TRIG] = 1;
 }
 
 static int sprd_pmic_eic_irq_set_type(struct irq_data *data,
@@ -174,13 +174,14 @@ static int sprd_pmic_eic_irq_set_type(struct irq_data *data,
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
 	struct sprd_pmic_eic *pmic_eic = gpiochip_get_data(chip);
+	u32 offset = irqd_to_hwirq(data);
 
 	switch (flow_type) {
 	case IRQ_TYPE_LEVEL_HIGH:
-		pmic_eic->reg[REG_IEV] = 1;
+		pmic_eic->reg[offset][REG_IEV] = 1;
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
-		pmic_eic->reg[REG_IEV] = 0;
+		pmic_eic->reg[offset][REG_IEV] = 0;
 		break;
 	case IRQ_TYPE_EDGE_RISING:
 	case IRQ_TYPE_EDGE_FALLING:
@@ -222,15 +223,15 @@ static void sprd_pmic_eic_bus_sync_unlock(struct irq_data *data)
 			sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV, 1);
 	} else {
 		sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV,
-				     pmic_eic->reg[REG_IEV]);
+				     pmic_eic->reg[offset][REG_IEV]);
 	}
 
 	/* Set irq unmask */
 	sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IE,
-			     pmic_eic->reg[REG_IE]);
+			     pmic_eic->reg[offset][REG_IE]);
 	/* Generate trigger start pulse for debounce EIC */
 	sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_TRIG,
-			     pmic_eic->reg[REG_TRIG]);
+			     pmic_eic->reg[offset][REG_TRIG]);
 
 	mutex_unlock(&pmic_eic->buslock);
 }
@@ -335,6 +336,7 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 
 	ret = devm_request_threaded_irq(&pdev->dev, pmic_eic->irq, NULL,
 					sprd_pmic_eic_irq_handler,
+					IRQF_TRIGGER_LOW |
 					IRQF_ONESHOT | IRQF_NO_SUSPEND,
 					dev_name(&pdev->dev), pmic_eic);
 	if (ret) {
@@ -352,6 +354,7 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 	pmic_eic->chip.set_config = sprd_pmic_eic_set_config;
 	pmic_eic->chip.set = sprd_pmic_eic_set;
 	pmic_eic->chip.get = sprd_pmic_eic_get;
+	pmic_eic->chip.can_sleep = true;
 
 	irq = &pmic_eic->chip.irq;
 	gpio_irq_chip_set_chip(irq, &pmic_eic_irq_chip);
-- 
2.17.1


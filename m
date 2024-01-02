Return-Path: <linux-kernel+bounces-14146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5373682185E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CEEB1C21587
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704A34C8D;
	Tue,  2 Jan 2024 08:29:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB0246A3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4028SX5a044296;
	Tue, 2 Jan 2024 16:28:33 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4T45Rj2tMfz2Qxlxk;
	Tue,  2 Jan 2024 16:21:53 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 2 Jan 2024
 16:28:32 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko
	<andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, wenhua lin
	<wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu
	<xiongpeng.wu@unisoc.com>
Subject: [PATCH V3] gpio: pmic-eic-sprd: Configure the bit corresponding to the EIC through offset
Date: Tue, 2 Jan 2024 16:28:29 +0800
Message-ID: <20240102082829.30874-1-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 4028SX5a044296

A bank PMIC EIC contains 16 EICs, and the operating registers
are BIT0-BIT15, such as BIT0 of the register operated by EIC0.
Using the one-dimensional array reg[CACHE_NR_REGS] for maintenance
will cause the configuration of other EICs to be affected when
operating a certain EIC. In order to solve this problem, configure
the bit corresponding to the EIC through offset.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
Change in V3:
-Change title.
-Change commit message.
-Delete the modification of the two-dimensional array maintenance pmic eic,
 and add the corresponding bits to configure the eic according to the offset.
---
---
 drivers/gpio/gpio-pmic-eic-sprd.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index 01c0fd0a9d8c..d9b228bea42e 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -151,8 +151,8 @@ static void sprd_pmic_eic_irq_mask(struct irq_data *data)
 	struct sprd_pmic_eic *pmic_eic = gpiochip_get_data(chip);
 	u32 offset = irqd_to_hwirq(data);
 
-	pmic_eic->reg[REG_IE] = 0;
-	pmic_eic->reg[REG_TRIG] = 0;
+	pmic_eic->reg[REG_IE] &= ~BIT(offset);
+	pmic_eic->reg[REG_TRIG] &= ~BIT(offset);
 
 	gpiochip_disable_irq(chip, offset);
 }
@@ -165,8 +165,8 @@ static void sprd_pmic_eic_irq_unmask(struct irq_data *data)
 
 	gpiochip_enable_irq(chip, offset);
 
-	pmic_eic->reg[REG_IE] = 1;
-	pmic_eic->reg[REG_TRIG] = 1;
+	pmic_eic->reg[REG_IE] |= BIT(offset);
+	pmic_eic->reg[REG_TRIG] |= BIT(offset);
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
+		pmic_eic->reg[REG_IEV] |= BIT(offset);
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
-		pmic_eic->reg[REG_IEV] = 0;
+		pmic_eic->reg[REG_IEV] &= ~BIT(offset);
 		break;
 	case IRQ_TYPE_EDGE_RISING:
 	case IRQ_TYPE_EDGE_FALLING:
@@ -222,15 +223,15 @@ static void sprd_pmic_eic_bus_sync_unlock(struct irq_data *data)
 			sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV, 1);
 	} else {
 		sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV,
-				     pmic_eic->reg[REG_IEV]);
+				     !!(pmic_eic->reg[REG_IEV] & BIT(offset)));
 	}
 
 	/* Set irq unmask */
 	sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IE,
-			     pmic_eic->reg[REG_IE]);
+			     !!(pmic_eic->reg[REG_IE] & BIT(offset)));
 	/* Generate trigger start pulse for debounce EIC */
 	sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_TRIG,
-			     pmic_eic->reg[REG_TRIG]);
+			     !!(pmic_eic->reg[REG_TRIG] & BIT(offset)));
 
 	mutex_unlock(&pmic_eic->buslock);
 }
-- 
2.17.1



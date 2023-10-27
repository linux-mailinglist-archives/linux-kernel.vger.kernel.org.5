Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751CF7D8F76
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjJ0HQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbjJ0HQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:16:08 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA8ED4C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:16:03 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 39R7EnKA002897;
        Fri, 27 Oct 2023 15:14:49 +0800 (+08)
        (envelope-from linhua.xu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SGv2324QJz2L6pVh;
        Fri, 27 Oct 2023 15:10:19 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx04.spreadtrum.com
 (10.0.1.214) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 27 Oct
 2023 15:14:48 +0800
From:   Linhua Xu <Linhua.xu@unisoc.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lh xu <xulh0829@gmail.com>, Linhua Xu <Linhua.Xu@unisoc.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: [PATCH V3 3/6] pinctrl: sprd: Move common and misc offset parameters to private data
Date:   Fri, 27 Oct 2023 15:14:23 +0800
Message-ID: <20231027071426.17724-4-Linhua.xu@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231027071426.17724-1-Linhua.xu@unisoc.com>
References: <20231027071426.17724-1-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL: SHSQR01.spreadtrum.com 39R7EnKA002897
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linhua Xu <Linhua.Xu@unisoc.com>

For UNISOC pin controller, the offset values of the common
register and misc register will be different. So add SoC
structure in sprd_pinctrl_of_match() and parse it in sprd-pinctrl_core.

Signed-off-by: Linhua Xu <Linhua.Xu@unisoc.com>
---
 drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c | 12 +++++++++---
 drivers/pinctrl/sprd/pinctrl-sprd.c        | 14 ++++++++++----
 drivers/pinctrl/sprd/pinctrl-sprd.h        |  5 +++++
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c b/drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c
index d14f382f2392..6835f0f85888 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c
@@ -10,6 +10,9 @@
 
 #include "pinctrl-sprd.h"
 
+#define	PINCTRL_REG_OFFSET		0x0020
+#define	PINCTRL_REG_MISC_OFFSET		0x4020
+
 enum sprd_sc9860_pins {
 	/* pin global control register 0 */
 	SC9860_VIO28_0_IRTE = SPRD_PIN_INFO(0, GLOBAL_CTRL_PIN, 11, 1, 0),
@@ -923,6 +926,11 @@ static struct sprd_pins_info sprd_sc9860_pins_info[] = {
 	SPRD_PINCTRL_PIN(SC9860_RFCTL39_MISC),
 };
 
+static const struct sprd_pinctrl_priv_data sc9860_data = {
+	.common_offset = PINCTRL_REG_OFFSET,
+	.misc_offset = PINCTRL_REG_MISC_OFFSET,
+};
+
 static int sprd_pinctrl_probe(struct platform_device *pdev)
 {
 	return sprd_pinctrl_core_probe(pdev, sprd_sc9860_pins_info,
@@ -930,9 +938,7 @@ static int sprd_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sprd_pinctrl_of_match[] = {
-	{
-		.compatible = "sprd,sc9860-pinctrl",
-	},
+	{ .compatible = "sprd,sc9860-pinctrl", .data = &sc9860_data},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sprd_pinctrl_of_match);
diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index b7a3cb9e7a61..7a79735ec30a 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -30,8 +30,6 @@
 #include "pinctrl-sprd.h"
 
 #define PINCTRL_BIT_MASK(width)		(~(~0UL << (width)))
-#define PINCTRL_REG_OFFSET		0x20
-#define PINCTRL_REG_MISC_OFFSET		0x4020
 #define PINCTRL_REG_LEN			0x4
 
 #define PIN_FUNC_MASK			(BIT(4) | BIT(5))
@@ -149,12 +147,14 @@ struct sprd_pinctrl_soc_info {
  * @pctl: pointer to the pinctrl handle
  * @base: base address of the controller
  * @info: pointer to SoC's pins description information
+ * @pdata: pointer SoC's private data structure
  */
 struct sprd_pinctrl {
 	struct device *dev;
 	struct pinctrl_dev *pctl;
 	void __iomem *base;
 	struct sprd_pinctrl_soc_info *info;
+	const struct sprd_pinctrl_priv_data *pdata;
 };
 
 #define SPRD_PIN_CONFIG_CONTROL		(PIN_CONFIG_END + 1)
@@ -1026,12 +1026,12 @@ static int sprd_pinctrl_add_pins(struct sprd_pinctrl *sprd_pctl,
 			ctrl_pin++;
 		} else if (pin->type == COMMON_PIN) {
 			pin->reg = (unsigned long)sprd_pctl->base +
-				PINCTRL_REG_OFFSET + PINCTRL_REG_LEN *
+				sprd_pctl->pdata->common_offset + PINCTRL_REG_LEN *
 				(i - ctrl_pin);
 			com_pin++;
 		} else if (pin->type == MISC_PIN) {
 			pin->reg = (unsigned long)sprd_pctl->base +
-				PINCTRL_REG_MISC_OFFSET + PINCTRL_REG_LEN *
+				sprd_pctl->pdata->misc_offset + PINCTRL_REG_LEN *
 				(i - ctrl_pin - com_pin);
 		}
 	}
@@ -1053,6 +1053,7 @@ int sprd_pinctrl_core_probe(struct platform_device *pdev,
 	struct sprd_pinctrl *sprd_pctl;
 	struct sprd_pinctrl_soc_info *pinctrl_info;
 	struct pinctrl_pin_desc *pin_desc;
+	const struct sprd_pinctrl_priv_data *priv_data;
 	int ret, i;
 
 	sprd_pctl = devm_kzalloc(&pdev->dev, sizeof(struct sprd_pinctrl),
@@ -1070,6 +1071,11 @@ int sprd_pinctrl_core_probe(struct platform_device *pdev,
 	if (!pinctrl_info)
 		return -ENOMEM;
 
+	priv_data = of_device_get_match_data(&pdev->dev);
+	if (!priv_data)
+		return -EINVAL;
+
+	sprd_pctl->pdata = priv_data;
 	sprd_pctl->info = pinctrl_info;
 	sprd_pctl->dev = &pdev->dev;
 	platform_set_drvdata(pdev, sprd_pctl);
diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.h b/drivers/pinctrl/sprd/pinctrl-sprd.h
index 69544a3cd635..23bced4665f1 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.h
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.h
@@ -50,6 +50,11 @@ struct sprd_pins_info {
 	unsigned int reg;
 };
 
+struct sprd_pinctrl_priv_data {
+	unsigned long common_offset;
+	unsigned long misc_offset;
+};
+
 int sprd_pinctrl_core_probe(struct platform_device *pdev,
 			    struct sprd_pins_info *sprd_soc_pin_info,
 			    int pins_cnt);
-- 
2.17.1


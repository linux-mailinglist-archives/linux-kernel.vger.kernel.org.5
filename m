Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D149D7981A8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 07:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbjIHFxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 01:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbjIHFxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 01:53:35 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DC31BC8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 22:53:11 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3885q1Lk009939;
        Fri, 8 Sep 2023 13:52:01 +0800 (+08)
        (envelope-from linhua.xu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RhlXy55Yxz2RbT5V;
        Fri,  8 Sep 2023 13:49:06 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx04.spreadtrum.com
 (10.0.1.214) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 8 Sep
 2023 13:51:59 +0800
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
Subject: [PATCH V2 1/6] pinctrl: sprd: Modify the probe function parameters
Date:   Fri, 8 Sep 2023 13:51:41 +0800
Message-ID: <20230908055146.18347-2-Linhua.xu@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230908055146.18347-1-Linhua.xu@unisoc.com>
References: <20230908055146.18347-1-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL: SHSQR01.spreadtrum.com 3885q1Lk009939
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linhua Xu <Linhua.Xu@unisoc.com>

For UNISOC pin controller, the offset values of the common register and
misc register will be different. Thus put these in the probe function
parameters.

Signed-off-by: Linhua Xu <Linhua.Xu@unisoc.com>
---
 drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c |  7 +++++-
 drivers/pinctrl/sprd/pinctrl-sprd.c        | 27 +++++++++++++---------
 drivers/pinctrl/sprd/pinctrl-sprd.h        |  3 ++-
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c b/drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c
index d14f382f2392..05158c71ad77 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c
@@ -10,6 +10,9 @@
 
 #include "pinctrl-sprd.h"
 
+#define	PINCTRL_REG_OFFSET		0x20
+#define	PINCTRL_REG_MISC_OFFSET		0x4020
+
 enum sprd_sc9860_pins {
 	/* pin global control register 0 */
 	SC9860_VIO28_0_IRTE = SPRD_PIN_INFO(0, GLOBAL_CTRL_PIN, 11, 1, 0),
@@ -926,7 +929,9 @@ static struct sprd_pins_info sprd_sc9860_pins_info[] = {
 static int sprd_pinctrl_probe(struct platform_device *pdev)
 {
 	return sprd_pinctrl_core_probe(pdev, sprd_sc9860_pins_info,
-				       ARRAY_SIZE(sprd_sc9860_pins_info));
+				       ARRAY_SIZE(sprd_sc9860_pins_info),
+				       PINCTRL_REG_OFFSET,
+				       PINCTRL_REG_MISC_OFFSET);
 }
 
 static const struct of_device_id sprd_pinctrl_of_match[] = {
diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index ca9659f4e4b1..25fb9ce9ad78 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -30,8 +30,6 @@
 #include "pinctrl-sprd.h"
 
 #define PINCTRL_BIT_MASK(width)		(~(~0UL << (width)))
-#define PINCTRL_REG_OFFSET		0x20
-#define PINCTRL_REG_MISC_OFFSET		0x4020
 #define PINCTRL_REG_LEN			0x4
 
 #define PIN_FUNC_MASK			(BIT(4) | BIT(5))
@@ -148,12 +146,16 @@ struct sprd_pinctrl_soc_info {
  * @pctl: pointer to the pinctrl handle
  * @base: base address of the controller
  * @info: pointer to SoC's pins description information
+ * @common_pin_offset: offset value of common register
+ * @misc_pin_offset: offset value of misc register
  */
 struct sprd_pinctrl {
 	struct device *dev;
 	struct pinctrl_dev *pctl;
 	void __iomem *base;
 	struct sprd_pinctrl_soc_info *info;
+	u32 common_pin_offset;
+	u32 misc_pin_offset;
 };
 
 #define SPRD_PIN_CONFIG_CONTROL		(PIN_CONFIG_END + 1)
@@ -1023,12 +1025,12 @@ static int sprd_pinctrl_add_pins(struct sprd_pinctrl *sprd_pctl,
 			ctrl_pin++;
 		} else if (pin->type == COMMON_PIN) {
 			pin->reg = (unsigned long)sprd_pctl->base +
-				PINCTRL_REG_OFFSET + PINCTRL_REG_LEN *
+				sprd_pctl->common_pin_offset + PINCTRL_REG_LEN *
 				(i - ctrl_pin);
 			com_pin++;
 		} else if (pin->type == MISC_PIN) {
 			pin->reg = (unsigned long)sprd_pctl->base +
-				PINCTRL_REG_MISC_OFFSET + PINCTRL_REG_LEN *
+				sprd_pctl->misc_pin_offset + PINCTRL_REG_LEN *
 				(i - ctrl_pin - com_pin);
 		}
 	}
@@ -1045,7 +1047,9 @@ static int sprd_pinctrl_add_pins(struct sprd_pinctrl *sprd_pctl,
 
 int sprd_pinctrl_core_probe(struct platform_device *pdev,
 			    struct sprd_pins_info *sprd_soc_pin_info,
-			    int pins_cnt)
+			    int pins_cnt,
+			    u32 common_pin_offset,
+			    u32 misc_pin_offset)
 {
 	struct sprd_pinctrl *sprd_pctl;
 	struct sprd_pinctrl_soc_info *pinctrl_info;
@@ -1069,6 +1073,8 @@ int sprd_pinctrl_core_probe(struct platform_device *pdev,
 
 	sprd_pctl->info = pinctrl_info;
 	sprd_pctl->dev = &pdev->dev;
+	sprd_pctl->common_pin_offset = common_pin_offset;
+	sprd_pctl->misc_pin_offset = misc_pin_offset;
 	platform_set_drvdata(pdev, sprd_pctl);
 
 	ret = sprd_pinctrl_add_pins(sprd_pctl, sprd_soc_pin_info, pins_cnt);
@@ -1077,12 +1083,6 @@ int sprd_pinctrl_core_probe(struct platform_device *pdev,
 		return ret;
 	}
 
-	ret = sprd_pinctrl_parse_dt(sprd_pctl);
-	if (ret) {
-		dev_err(&pdev->dev, "fail to parse dt properties\n");
-		return ret;
-	}
-
 	pin_desc = devm_kcalloc(&pdev->dev,
 				pinctrl_info->npins,
 				sizeof(struct pinctrl_pin_desc),
@@ -1100,6 +1100,11 @@ int sprd_pinctrl_core_probe(struct platform_device *pdev,
 	sprd_pinctrl_desc.name = dev_name(&pdev->dev);
 	sprd_pinctrl_desc.npins = pinctrl_info->npins;
 
+	ret = sprd_pinctrl_parse_dt(sprd_pctl);
+	if (ret) {
+		dev_err(&pdev->dev, "fail to parse dt properties\n");
+		return ret;
+	}
 	sprd_pctl->pctl = pinctrl_register(&sprd_pinctrl_desc,
 					   &pdev->dev, (void *)sprd_pctl);
 	if (IS_ERR(sprd_pctl->pctl)) {
diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.h b/drivers/pinctrl/sprd/pinctrl-sprd.h
index 69544a3cd635..a696f81ce663 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.h
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.h
@@ -52,7 +52,8 @@ struct sprd_pins_info {
 
 int sprd_pinctrl_core_probe(struct platform_device *pdev,
 			    struct sprd_pins_info *sprd_soc_pin_info,
-			    int pins_cnt);
+			    int pins_cnt, u32 common_pin_offset,
+			    u32 misc_pin_offset);
 int sprd_pinctrl_remove(struct platform_device *pdev);
 void sprd_pinctrl_shutdown(struct platform_device *pdev);
 
-- 
2.17.1


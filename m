Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CCD7740A1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjHHRGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjHHRGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:06:08 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F02B5FDF3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:02:33 -0700 (PDT)
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.spreadtrum.com with ESMTP id 3783VdZg071455
        for <linux-kernel@vger.kernel.org>; Tue, 8 Aug 2023 11:31:39 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3783VEOX069922;
        Tue, 8 Aug 2023 11:31:14 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RKdw00nd5z2P8rS9;
        Tue,  8 Aug 2023 11:29:20 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 8 Aug 2023
 11:31:12 +0800
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
Subject: [PATCH 1/3] gpio: sprd: Modify the calculation method of eic number
Date:   Tue, 8 Aug 2023 11:31:06 +0800
Message-ID: <20230808033106.2174-1-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 3783VEOX069922
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Automatic calculation through matching nodes,
subsequent projects can avoid modifying driver files.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/gpio/gpio-eic-sprd.c | 49 +++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 84352a6f4973..0d85d9e80848 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -50,10 +50,10 @@
 #define SPRD_EIC_SYNC_DATA		0x1c
 
 /*
- * The digital-chip EIC controller can support maximum 3 banks, and each bank
+ * The digital-chip EIC controller can support maximum 8 banks, and each bank
  * contains 8 EICs.
  */
-#define SPRD_EIC_MAX_BANK		3
+#define SPRD_EIC_MAX_BANK		8
 #define SPRD_EIC_PER_BANK_NR		8
 #define SPRD_EIC_DATA_MASK		GENMASK(7, 0)
 #define SPRD_EIC_BIT(x)			((x) & (SPRD_EIC_PER_BANK_NR - 1))
@@ -99,33 +99,32 @@ struct sprd_eic {
 
 struct sprd_eic_variant_data {
 	enum sprd_eic_type type;
-	u32 num_eics;
 };
 
+#define SPRD_EIC_VAR_DATA(soc_name)				\
+static const struct sprd_eic_variant_data soc_name##_eic_dbnc_data = {	\
+	.type = SPRD_EIC_DEBOUNCE,					\
+};									\
+									\
+static const struct sprd_eic_variant_data soc_name##_eic_latch_data = {	\
+	.type = SPRD_EIC_LATCH,						\
+};									\
+									\
+static const struct sprd_eic_variant_data soc_name##_eic_async_data = {	\
+	.type = SPRD_EIC_ASYNC,						\
+};									\
+									\
+static const struct sprd_eic_variant_data soc_name##_eic_sync_data = {	\
+	.type = SPRD_EIC_SYNC,						\
+}
+
+SPRD_EIC_VAR_DATA(sc9860);
+
 static const char *sprd_eic_label_name[SPRD_EIC_MAX] = {
 	"eic-debounce", "eic-latch", "eic-async",
 	"eic-sync",
 };
 
-static const struct sprd_eic_variant_data sc9860_eic_dbnc_data = {
-	.type = SPRD_EIC_DEBOUNCE,
-	.num_eics = 8,
-};
-
-static const struct sprd_eic_variant_data sc9860_eic_latch_data = {
-	.type = SPRD_EIC_LATCH,
-	.num_eics = 8,
-};
-
-static const struct sprd_eic_variant_data sc9860_eic_async_data = {
-	.type = SPRD_EIC_ASYNC,
-	.num_eics = 8,
-};
-
-static const struct sprd_eic_variant_data sc9860_eic_sync_data = {
-	.type = SPRD_EIC_SYNC,
-	.num_eics = 8,
-};
 
 static inline void __iomem *sprd_eic_offset_base(struct sprd_eic *sprd_eic,
 						 unsigned int bank)
@@ -583,6 +582,7 @@ static int sprd_eic_probe(struct platform_device *pdev)
 	struct sprd_eic *sprd_eic;
 	struct resource *res;
 	int ret, i;
+	u16 num_banks = 0;
 
 	pdata = of_device_get_match_data(&pdev->dev);
 	if (!pdata) {
@@ -613,12 +613,13 @@ static int sprd_eic_probe(struct platform_device *pdev)
 			break;
 
 		sprd_eic->base[i] = devm_ioremap_resource(&pdev->dev, res);
+		num_banks++;
 		if (IS_ERR(sprd_eic->base[i]))
 			return PTR_ERR(sprd_eic->base[i]);
 	}
 
 	sprd_eic->chip.label = sprd_eic_label_name[sprd_eic->type];
-	sprd_eic->chip.ngpio = pdata->num_eics;
+	sprd_eic->chip.ngpio = num_banks * SPRD_EIC_PER_BANK_NR;
 	sprd_eic->chip.base = -1;
 	sprd_eic->chip.parent = &pdev->dev;
 	sprd_eic->chip.direction_input = sprd_eic_direction_input;
@@ -630,10 +631,12 @@ static int sprd_eic_probe(struct platform_device *pdev)
 		sprd_eic->chip.set = sprd_eic_set;
 		fallthrough;
 	case SPRD_EIC_ASYNC:
+		fallthrough;
 	case SPRD_EIC_SYNC:
 		sprd_eic->chip.get = sprd_eic_get;
 		break;
 	case SPRD_EIC_LATCH:
+		fallthrough;
 	default:
 		break;
 	}
-- 
2.17.1


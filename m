Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6537A9894
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjIURuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjIURt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:49:58 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002BF585EF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:19:27 -0700 (PDT)
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.spreadtrum.com with ESMTP id 38L92Pa5067742
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 17:02:25 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 38L90k9T061807;
        Thu, 21 Sep 2023 17:00:46 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Rrq6G2Ngqz2SZykd;
        Thu, 21 Sep 2023 16:57:26 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 21 Sep
 2023 17:00:45 +0800
From:   Wenhua Lin <Wenhua.Lin@unisoc.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: [PATCH V2 3/4] gpio: sprd: Modify the calculation method of eic number
Date:   Thu, 21 Sep 2023 17:00:26 +0800
Message-ID: <20230921090027.11136-4-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230921090027.11136-1-Wenhua.Lin@unisoc.com>
References: <20230921090027.11136-1-Wenhua.Lin@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 38L90k9T061807
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the soc changes, the corresponding gpio-eic-sprd.c
code needs to be modified, and the corresponding
Document must also be modified, which is quite troublesome.
To avoid modifying the driver file, the number of EICs
is automatically calculated by matching dts nodes.

Fixes: 2788938b7946 ("gpio: eic-sprd: Make the irqchip immutable")

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/gpio/gpio-eic-sprd.c | 43 ++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 96f1c7fd3988..e85addbdf8aa 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -100,33 +100,32 @@ struct sprd_eic {
 
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
@@ -595,6 +594,7 @@ static int sprd_eic_probe(struct platform_device *pdev)
 	struct sprd_eic *sprd_eic;
 	struct resource *res;
 	int ret, i;
+	u16 num_banks = 0;
 
 	pdata = of_device_get_match_data(&pdev->dev);
 	if (!pdata) {
@@ -625,12 +625,13 @@ static int sprd_eic_probe(struct platform_device *pdev)
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
-- 
2.17.1


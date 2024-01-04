Return-Path: <linux-kernel+bounces-16208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B82823ACD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1911F26192
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDE214F6E;
	Thu,  4 Jan 2024 02:43:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4069812E65
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 02:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4042h9eS001917;
	Thu, 4 Jan 2024 10:43:09 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4T59h94VLzz2Qby50;
	Thu,  4 Jan 2024 10:36:25 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 4 Jan 2024
 10:43:07 +0800
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
Subject: [PATCH V3 3/4] gpio: eic-sprd: Modify the calculation method of eic number
Date: Thu, 4 Jan 2024 10:42:43 +0800
Message-ID: <20240104024244.12163-4-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240104024244.12163-1-Wenhua.Lin@unisoc.com>
References: <20240104024244.12163-1-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 4042h9eS001917

When the soc changes, the corresponding gpio-eic-sprd.c
code needs to be modified, and the corresponding
Document must also be modified, which is quite troublesome.
To avoid modifying the driver file, the number of eics
is automatically calculated by matching dts nodes.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/gpio/gpio-eic-sprd.c | 45 ++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index e492157e5154..1ca3c444957c 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -109,34 +109,32 @@ static struct sprd_eic *to_sprd_eic(struct notifier_block *nb)
 
 struct sprd_eic_variant_data {
 	enum sprd_eic_type type;
-	u32 num_eics;
 };
 
+#define SPRD_EIC_VAR_DATA(soc_name)						\
+static const struct sprd_eic_variant_data soc_name##_eic_dbnc_data = {		\
+	.type = SPRD_EIC_DEBOUNCE,						\
+};										\
+										\
+static const struct sprd_eic_variant_data soc_name##_eic_latch_data = {	\
+	.type = SPRD_EIC_LATCH,							\
+};										\
+										\
+static const struct sprd_eic_variant_data soc_name##_eic_async_data = {	\
+	.type = SPRD_EIC_ASYNC,							\
+};										\
+										\
+static const struct sprd_eic_variant_data soc_name##_eic_sync_data = {		\
+	.type = SPRD_EIC_SYNC,							\
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
-
 static inline void __iomem *sprd_eic_offset_base(struct sprd_eic *sprd_eic,
 						 unsigned int bank)
 {
@@ -607,6 +605,7 @@ static int sprd_eic_probe(struct platform_device *pdev)
 	struct gpio_irq_chip *irq;
 	struct sprd_eic *sprd_eic;
 	struct resource *res;
+	u16 num_banks = 0;
 	int ret, i;
 
 	pdata = of_device_get_match_data(dev);
@@ -640,10 +639,12 @@ static int sprd_eic_probe(struct platform_device *pdev)
 		sprd_eic->base[i] = devm_ioremap_resource(dev, res);
 		if (IS_ERR(sprd_eic->base[i]))
 			return PTR_ERR(sprd_eic->base[i]);
+
+		num_banks++;
 	}
 
 	sprd_eic->chip.label = sprd_eic_label_name[sprd_eic->type];
-	sprd_eic->chip.ngpio = pdata->num_eics;
+	sprd_eic->chip.ngpio = num_banks * SPRD_EIC_PER_BANK_NR;
 	sprd_eic->chip.base = -1;
 	sprd_eic->chip.parent = dev;
 	sprd_eic->chip.direction_input = sprd_eic_direction_input;
-- 
2.17.1



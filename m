Return-Path: <linux-kernel+bounces-20483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3396D827F8A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94A71F24D88
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13D0B65F;
	Tue,  9 Jan 2024 07:39:51 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74F39455
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4097d95D027979;
	Tue, 9 Jan 2024 15:39:09 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4T8N1C2qB7z2Qvpgg;
	Tue,  9 Jan 2024 15:32:15 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 9 Jan 2024
 15:39:08 +0800
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
Subject: [PATCH V4 2/2] gpio: eic-sprd: Optimize the calculation method of eic number
Date: Tue, 9 Jan 2024 15:38:49 +0800
Message-ID: <20240109073849.10791-3-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240109073849.10791-1-Wenhua.Lin@unisoc.com>
References: <20240109073849.10791-1-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 4097d95D027979

The num_eics is a default value, but some SoCs support more than 8.
In order to adapt to all projects, the total number of eics is
automatically calculated through dts.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/gpio/gpio-eic-sprd.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 806b88d8dfb7..2dd0e46c42ad 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -108,7 +108,6 @@ static struct sprd_eic *to_sprd_eic(struct notifier_block *nb)
 
 struct sprd_eic_variant_data {
 	enum sprd_eic_type type;
-	u32 num_eics;
 };
 
 static const char *sprd_eic_label_name[SPRD_EIC_MAX] = {
@@ -118,22 +117,18 @@ static const char *sprd_eic_label_name[SPRD_EIC_MAX] = {
 
 static const struct sprd_eic_variant_data sc9860_eic_dbnc_data = {
 	.type = SPRD_EIC_DEBOUNCE,
-	.num_eics = 8,
 };
 
 static const struct sprd_eic_variant_data sc9860_eic_latch_data = {
 	.type = SPRD_EIC_LATCH,
-	.num_eics = 8,
 };
 
 static const struct sprd_eic_variant_data sc9860_eic_async_data = {
 	.type = SPRD_EIC_ASYNC,
-	.num_eics = 8,
 };
 
 static const struct sprd_eic_variant_data sc9860_eic_sync_data = {
 	.type = SPRD_EIC_SYNC,
-	.num_eics = 8,
 };
 
 static inline void __iomem *sprd_eic_offset_base(struct sprd_eic *sprd_eic,
@@ -619,6 +614,7 @@ static int sprd_eic_probe(struct platform_device *pdev)
 	struct gpio_irq_chip *irq;
 	struct sprd_eic *sprd_eic;
 	struct resource *res;
+	u16 num_banks = 0;
 	int ret, i;
 
 	pdata = of_device_get_match_data(dev);
@@ -652,10 +648,12 @@ static int sprd_eic_probe(struct platform_device *pdev)
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



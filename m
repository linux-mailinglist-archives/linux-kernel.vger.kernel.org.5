Return-Path: <linux-kernel+bounces-16209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCCD823AD0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1184F1C24C20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B75F1D689;
	Thu,  4 Jan 2024 02:43:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ECD1C6A4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 02:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4042hAVP001950;
	Thu, 4 Jan 2024 10:43:10 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4T59hB2vDtz2Qby5B;
	Thu,  4 Jan 2024 10:36:26 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 4 Jan 2024
 10:43:08 +0800
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
Subject: [PATCH V3 4/4] gpio: eic-sprd: Support 8 banks EIC controller
Date: Thu, 4 Jan 2024 10:42:44 +0800
Message-ID: <20240104024244.12163-5-Wenhua.Lin@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 4042hAVP001950

In order to solve the problem of insufficient eic,
it supports 8 banks of eic controller, each bank contains 8 eic.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/gpio/gpio-eic-sprd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 1ca3c444957c..715c7d581d7f 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -52,10 +52,10 @@
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
@@ -627,9 +627,9 @@ static int sprd_eic_probe(struct platform_device *pdev)
 
 	for (i = 0; i < SPRD_EIC_MAX_BANK; i++) {
 		/*
-		 * We can have maximum 3 banks EICs, and each EIC has
+		 * We can have maximum 8 banks EICs, and each EIC has
 		 * its own base address. But some platform maybe only
-		 * have one bank EIC, thus base[1] and base[2] can be
+		 * have one bank EIC, thus base[1] to base[7] can be
 		 * optional.
 		 */
 		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-- 
2.17.1



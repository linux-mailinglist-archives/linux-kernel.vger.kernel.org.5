Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DE87A9F23
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjIUUSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjIUUR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:17:58 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C661585F8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:19:31 -0700 (PDT)
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.spreadtrum.com with ESMTP id 38L92VFh068153
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 17:02:31 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 38L90lmX061831;
        Thu, 21 Sep 2023 17:00:47 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Rrq6H43t0z2SZykd;
        Thu, 21 Sep 2023 16:57:27 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 21 Sep
 2023 17:00:46 +0800
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
Subject: [PATCH V2 4/4] gpio: sprd: Support 8 banks EIC controller
Date:   Thu, 21 Sep 2023 17:00:27 +0800
Message-ID: <20230921090027.11136-5-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230921090027.11136-1-Wenhua.Lin@unisoc.com>
References: <20230921090027.11136-1-Wenhua.Lin@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 38L90lmX061831
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to solve the problem of insufficient eic,
it supports 8 banks of eic controller, each bank contains 8 eic.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/gpio/gpio-eic-sprd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index e85addbdf8aa..6bb002060c3e 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -51,10 +51,10 @@
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
@@ -615,9 +615,9 @@ static int sprd_eic_probe(struct platform_device *pdev)
 
 	for (i = 0; i < SPRD_EIC_MAX_BANK; i++) {
 		/*
-		 * We can have maximum 3 banks EICs, and each EIC has
+		 * We can have maximum 8 banks EICs, and each EIC has
 		 * its own base address. But some platform maybe only
-		 * have one bank EIC, thus base[1] and base[2] can be
+		 * have one bank EIC, thus base[1] and base[7] can be
 		 * optional.
 		 */
 		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-- 
2.17.1


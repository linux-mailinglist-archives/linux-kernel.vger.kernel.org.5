Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FE17A98BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjIURwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjIURvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:51:31 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A1F585C7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:19:15 -0700 (PDT)
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.spreadtrum.com with ESMTP id 38L92ICv067362
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 17:02:18 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 38L90iOc061737;
        Thu, 21 Sep 2023 17:00:44 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Rrq6D4FsMz2SZykd;
        Thu, 21 Sep 2023 16:57:24 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 21 Sep
 2023 17:00:43 +0800
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
Subject: [PATCH V2 1/4] gpio: sprd: In the sleep state, the eic debounce clk must be forced open
Date:   Thu, 21 Sep 2023 17:00:24 +0800
Message-ID: <20230921090027.11136-2-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230921090027.11136-1-Wenhua.Lin@unisoc.com>
References: <20230921090027.11136-1-Wenhua.Lin@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 38L90iOc061737
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the sleep state, Eic debounce has no clock and the clk of
debounce needs to be forced open, so that eic can wake up normally.

Fixes: 2788938b7946 ("gpio: eic-sprd: Make the irqchip immutable")

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/gpio/gpio-eic-sprd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 84352a6f4973..bfa8a4c7515a 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -23,6 +23,7 @@
 #define SPRD_EIC_DBNC_IC		0x24
 #define SPRD_EIC_DBNC_TRIG		0x28
 #define SPRD_EIC_DBNC_CTRL0		0x40
+#define SPRD_EIC_DBNC_FORCE_CLK		0x8000
 
 #define SPRD_EIC_LATCH_INTEN		0x0
 #define SPRD_EIC_LATCH_INTRAW		0x4
@@ -214,6 +215,7 @@ static int sprd_eic_set_debounce(struct gpio_chip *chip, unsigned int offset,
 	u32 value = readl_relaxed(base + reg) & ~SPRD_EIC_DBNC_MASK;
 
 	value |= (debounce / 1000) & SPRD_EIC_DBNC_MASK;
+	value |= SPRD_EIC_DBNC_FORCE_CLK;
 	writel_relaxed(value, base + reg);
 
 	return 0;
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F5777473D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjHHTMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjHHTLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:11:47 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58350332B1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:33:38 -0700 (PDT)
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.spreadtrum.com with ESMTP id 3783Vw0q072066
        for <linux-kernel@vger.kernel.org>; Tue, 8 Aug 2023 11:31:58 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3783VYwB071147;
        Tue, 8 Aug 2023 11:31:34 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RKdwN2gpJz2NsJlw;
        Tue,  8 Aug 2023 11:29:40 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 8 Aug 2023
 11:31:32 +0800
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
Subject: [PATCH 2/3] gpio: sprd: In the sleep state, the eic dbnc clk must be forced open
Date:   Tue, 8 Aug 2023 11:31:30 +0800
Message-ID: <20230808033130.2226-1-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 3783VYwB071147
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the sleep state, Eic dbnc has no clock and the clk enable
of dbnc needs to be forced open, so that eic can wake up normally.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/gpio/gpio-eic-sprd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 0d85d9e80848..c506cfd6df8e 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -23,6 +23,7 @@
 #define SPRD_EIC_DBNC_IC		0x24
 #define SPRD_EIC_DBNC_TRIG		0x28
 #define SPRD_EIC_DBNC_CTRL0		0x40
+#define SPRD_EIC_DBNC_FORCE_CLK		0x8000
 
 #define SPRD_EIC_LATCH_INTEN		0x0
 #define SPRD_EIC_LATCH_INTRAW		0x4
@@ -213,6 +214,7 @@ static int sprd_eic_set_debounce(struct gpio_chip *chip, unsigned int offset,
 	u32 value = readl_relaxed(base + reg) & ~SPRD_EIC_DBNC_MASK;
 
 	value |= (debounce / 1000) & SPRD_EIC_DBNC_MASK;
+	value |= SPRD_EIC_DBNC_FORCE_CLK;
 	writel_relaxed(value, base + reg);
 
 	return 0;
-- 
2.17.1


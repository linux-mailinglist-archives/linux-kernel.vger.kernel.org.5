Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9765A787EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbjHYDiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239444AbjHYDiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:38:18 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7943E1BC2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 20:38:16 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37P3bB5v075557;
        Fri, 25 Aug 2023 11:37:11 +0800 (+08)
        (envelope-from linhua.xu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RX5DN1DLsz2QTWfr;
        Fri, 25 Aug 2023 11:34:44 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx04.spreadtrum.com
 (10.0.1.214) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 25 Aug
 2023 11:37:10 +0800
From:   Linhua Xu <Linhua.xu@unisoc.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lh xu <xulh0829@gmail.com>, Linhua Xu <Linhua.Xu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: [PATCH 2/6] pinctrl: sprd: Fix the incorrect mask and shift definition
Date:   Fri, 25 Aug 2023 11:18:22 +0800
Message-ID: <20230825031826.31599-3-Linhua.xu@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825031826.31599-1-Linhua.xu@unisoc.com>
References: <20230825031826.31599-1-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL: SHSQR01.spreadtrum.com 37P3bB5v075557
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linhua Xu <Linhua.Xu@unisoc.com>

Pull-up and pull-down are mutually exclusive. When setting one of them,
the bit of the other needs to be clear. Now, there are cases where pull-up
and pull-down are set at the same time in the code, thus fix them.

Signed-off-by: Linhua Xu <Linhua.Xu@unisoc.com>
---
 drivers/pinctrl/sprd/pinctrl-sprd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index 4ee030d723c4..6464999aaebe 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -58,21 +58,21 @@
 #define DRIVE_STRENGTH_SHIFT		19
 
 #define SLEEP_PULL_DOWN			BIT(2)
-#define SLEEP_PULL_DOWN_MASK		0x1
+#define SLEEP_PULL_DOWN_MASK		0x3
 #define SLEEP_PULL_DOWN_SHIFT		2
 
 #define PULL_DOWN			BIT(6)
-#define PULL_DOWN_MASK			0x1
+#define PULL_DOWN_MASK			0x3
 #define PULL_DOWN_SHIFT			6
 
 #define SLEEP_PULL_UP			BIT(3)
-#define SLEEP_PULL_UP_MASK		0x1
-#define SLEEP_PULL_UP_SHIFT		3
+#define SLEEP_PULL_UP_MASK		0x3
+#define SLEEP_PULL_UP_SHIFT		2
 
 #define PULL_UP_4_7K			(BIT(12) | BIT(7))
 #define PULL_UP_20K			BIT(7)
-#define PULL_UP_MASK			0x21
-#define PULL_UP_SHIFT			7
+#define PULL_UP_MASK			0x43
+#define PULL_UP_SHIFT			6
 
 #define INPUT_SCHMITT			BIT(11)
 #define INPUT_SCHMITT_MASK		0x1
-- 
2.17.1


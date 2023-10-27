Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6B77D8F7B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345506AbjJ0HQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345427AbjJ0HQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:16:27 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29706D6A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:16:17 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 39R7ElfU002781;
        Fri, 27 Oct 2023 15:14:47 +0800 (+08)
        (envelope-from linhua.xu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SGv211H9Jz2L6pVh;
        Fri, 27 Oct 2023 15:10:17 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx04.spreadtrum.com
 (10.0.1.214) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 27 Oct
 2023 15:14:46 +0800
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
Subject: [PATCH V3 1/6] pinctrl: sprd: Modify pull-up parameters
Date:   Fri, 27 Oct 2023 15:14:21 +0800
Message-ID: <20231027071426.17724-2-Linhua.xu@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231027071426.17724-1-Linhua.xu@unisoc.com>
References: <20231027071426.17724-1-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL: SHSQR01.spreadtrum.com 39R7ElfU002781
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linhua Xu <Linhua.Xu@unisoc.com>

For UNISOC pin controller, there are three different configurations of
pull-up drive current. Modify the 20K pull-up resistor configuration and
add the 1.8K pull-up resistor configuration.

Fixes:<1fb4b907e808> ("pinctrl: sprd: Add Spreadtrum pin control driver")

Signed-off-by: Linhua Xu <Linhua.Xu@unisoc.com>
---
 drivers/pinctrl/sprd/pinctrl-sprd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index ca9659f4e4b1..74d8f8c3b9b6 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -71,7 +71,8 @@
 #define SLEEP_PULL_UP_MASK		0x1
 #define SLEEP_PULL_UP_SHIFT		3
 
-#define PULL_UP_4_7K			(BIT(12) | BIT(7))
+#define PULL_UP_1_8K			(BIT(12) | BIT(7))
+#define PULL_UP_4_7K			BIT(12)
 #define PULL_UP_20K			BIT(7)
 #define PULL_UP_MASK			0x21
 #define PULL_UP_SHIFT			7
@@ -497,7 +498,7 @@ static int sprd_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin_id,
 			break;
 		case PIN_CONFIG_BIAS_DISABLE:
 			if ((reg & (SLEEP_PULL_DOWN | SLEEP_PULL_UP)) ||
-			    (reg & (PULL_DOWN | PULL_UP_4_7K | PULL_UP_20K)))
+			    (reg & (PULL_DOWN | PULL_UP_4_7K | PULL_UP_20K | PULL_UP_1_8K)))
 				return -EINVAL;
 
 			arg = 1;
@@ -699,6 +700,8 @@ static int sprd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin_id,
 						val |= PULL_UP_20K;
 					else if (arg == 4700)
 						val |= PULL_UP_4_7K;
+					else if (arg == 1800)
+						val |= PULL_UP_1_8K;
 
 					mask = PULL_UP_MASK;
 					shift = PULL_UP_SHIFT;
@@ -711,7 +714,7 @@ static int sprd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin_id,
 				} else {
 					val = shift = 0;
 					mask = PULL_DOWN | PULL_UP_20K |
-						PULL_UP_4_7K;
+						PULL_UP_4_7K | PULL_UP_1_8K;
 				}
 				break;
 			case PIN_CONFIG_SLEEP_HARDWARE_STATE:
-- 
2.17.1


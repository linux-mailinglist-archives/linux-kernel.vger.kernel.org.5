Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ED2787EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbjHYDix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239609AbjHYDiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:38:20 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCA91BC2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 20:38:18 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37P3bCa7075675;
        Fri, 25 Aug 2023 11:37:12 +0800 (+08)
        (envelope-from linhua.xu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RX5DN6l09z2QTWgH;
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
Subject: [PATCH 3/6] pinctrl: sprd: Modify pull-up parameters
Date:   Fri, 25 Aug 2023 11:18:23 +0800
Message-ID: <20230825031826.31599-4-Linhua.xu@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825031826.31599-1-Linhua.xu@unisoc.com>
References: <20230825031826.31599-1-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL: SHSQR01.spreadtrum.com 37P3bCa7075675
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linhua Xu <Linhua.Xu@unisoc.com>

For UNISOC pin controller, there are three different configurations of
pull-up drive current: 1 for pull-up resistor is 20K, 2 for pull-up
resistor is 4.7K and 3 for pull-up resistor is 1.8K. Thus modify them.

Signed-off-by: Linhua Xu <Linhua.Xu@unisoc.com>
---
 drivers/pinctrl/sprd/pinctrl-sprd.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index 6464999aaebe..6d16209a4846 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -69,8 +69,9 @@
 #define SLEEP_PULL_UP_MASK		0x3
 #define SLEEP_PULL_UP_SHIFT		2
 
-#define PULL_UP_4_7K			(BIT(12) | BIT(7))
-#define PULL_UP_20K			BIT(7)
+#define PULL_UP_WPUSP			(BIT(12) | BIT(7))
+#define PULL_UP_WPUS			BIT(12)
+#define PULL_UP_WPU			BIT(7)
 #define PULL_UP_MASK			0x43
 #define PULL_UP_SHIFT			6
 
@@ -497,7 +498,7 @@ static int sprd_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin_id,
 			break;
 		case PIN_CONFIG_BIAS_DISABLE:
 			if ((reg & (SLEEP_PULL_DOWN | SLEEP_PULL_UP)) ||
-			    (reg & (PULL_DOWN | PULL_UP_4_7K | PULL_UP_20K)))
+			    (reg & (PULL_DOWN | PULL_UP_WPUSP)))
 				return -EINVAL;
 
 			arg = 1;
@@ -690,15 +691,17 @@ static int sprd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin_id,
 				shift = INPUT_SCHMITT_SHIFT;
 				break;
 			case PIN_CONFIG_BIAS_PULL_UP:
-				if (is_sleep_config) {
+				if (is_sleep_config == true) {
 					val |= SLEEP_PULL_UP;
 					mask = SLEEP_PULL_UP_MASK;
 					shift = SLEEP_PULL_UP_SHIFT;
 				} else {
-					if (arg == 20000)
-						val |= PULL_UP_20K;
-					else if (arg == 4700)
-						val |= PULL_UP_4_7K;
+					if (arg == 3)
+						val |= PULL_UP_WPUSP;
+					else if (arg == 2)
+						val |= PULL_UP_WPUS;
+					else if (arg == 1)
+						val |= PULL_UP_WPU;
 
 					mask = PULL_UP_MASK;
 					shift = PULL_UP_SHIFT;
@@ -710,8 +713,7 @@ static int sprd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin_id,
 					mask = SLEEP_PULL_DOWN | SLEEP_PULL_UP;
 				} else {
 					val = shift = 0;
-					mask = PULL_DOWN | PULL_UP_20K |
-						PULL_UP_4_7K;
+					mask = PULL_DOWN | PULL_UP_WPUSP;
 				}
 				break;
 			case PIN_CONFIG_SLEEP_HARDWARE_STATE:
-- 
2.17.1


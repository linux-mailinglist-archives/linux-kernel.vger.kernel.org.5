Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532667981A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 07:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240762AbjIHFwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 01:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbjIHFws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 01:52:48 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B77319BC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 22:52:44 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3885q4sK010186;
        Fri, 8 Sep 2023 13:52:04 +0800 (+08)
        (envelope-from linhua.xu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RhlY166RZz2RbT5V;
        Fri,  8 Sep 2023 13:49:09 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx04.spreadtrum.com
 (10.0.1.214) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 8 Sep
 2023 13:52:03 +0800
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
Subject: [PATCH V2 5/6] pinctrl: sprd: Increase the range of register values
Date:   Fri, 8 Sep 2023 13:51:45 +0800
Message-ID: <20230908055146.18347-6-Linhua.xu@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230908055146.18347-1-Linhua.xu@unisoc.com>
References: <20230908055146.18347-1-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL: SHSQR01.spreadtrum.com 3885q4sK010186
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linhua Xu <Linhua.Xu@unisoc.com>

As the UNISOC pin controller version iterates, more registers are required
to meet new functional requirements. Thus modify them.

Signed-off-by: Linhua Xu <Linhua.Xu@unisoc.com>
---
 drivers/pinctrl/sprd/pinctrl-sprd.h | 30 +++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.h b/drivers/pinctrl/sprd/pinctrl-sprd.h
index a696f81ce663..5357874186fd 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.h
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.h
@@ -7,30 +7,32 @@
 #ifndef __PINCTRL_SPRD_H__
 #define __PINCTRL_SPRD_H__
 
+#include <linux/bits.h>
+
 struct platform_device;
 
-#define NUM_OFFSET	(20)
-#define TYPE_OFFSET	(16)
-#define BIT_OFFSET	(8)
-#define WIDTH_OFFSET	(4)
+#define NUM_OFFSET	22
+#define TYPE_OFFSET	18
+#define BIT_OFFSET	10
+#define WIDTH_OFFSET	6
 
 #define SPRD_PIN_INFO(num, type, offset, width, reg)	\
-		(((num) & 0xFFF) << NUM_OFFSET |	\
-		 ((type) & 0xF) << TYPE_OFFSET |	\
-		 ((offset) & 0xFF) << BIT_OFFSET |	\
-		 ((width) & 0xF) << WIDTH_OFFSET |	\
-		 ((reg) & 0xF))
+		(((num) & GENMASK(10, 0)) << NUM_OFFSET |	\
+		 ((type) & GENMASK(3, 0)) << TYPE_OFFSET |	\
+		 ((offset) & GENMASK(7, 0)) << BIT_OFFSET |	\
+		 ((width) & GENMASK(3, 0)) << WIDTH_OFFSET |	\
+		 ((reg) & GENMASK(5, 0)))
 
 #define SPRD_PINCTRL_PIN(pin)	SPRD_PINCTRL_PIN_DATA(pin, #pin)
 
 #define SPRD_PINCTRL_PIN_DATA(a, b)				\
 	{							\
 		.name = b,					\
-		.num = (((a) >> NUM_OFFSET) & 0xfff),		\
-		.type = (((a) >> TYPE_OFFSET) & 0xf),		\
-		.bit_offset = (((a) >> BIT_OFFSET) & 0xff),	\
-		.bit_width = ((a) >> WIDTH_OFFSET & 0xf),	\
-		.reg = ((a) & 0xf)				\
+		.num = (((a) & GENMASK(31, 22)) >> NUM_OFFSET),	\
+		.type = (((a) & GENMASK(21, 18)) >> TYPE_OFFSET),	\
+		.bit_offset = (((a) & GENMASK(17, 10)) >> BIT_OFFSET),	\
+		.bit_width = (((a) & GENMASK(9, 6)) >> WIDTH_OFFSET),	\
+		.reg = ((a) & GENMASK(5, 0))				\
 	}
 
 enum pin_type {
-- 
2.17.1


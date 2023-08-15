Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4D877C5ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjHOCfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbjHOCfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:35:07 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1012810D0;
        Mon, 14 Aug 2023 19:35:03 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37F2YYVR066422;
        Tue, 15 Aug 2023 10:34:34 +0800 (+08)
        (envelope-from Jiansheng.Wu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RPwK704pXz2P8CXW;
        Tue, 15 Aug 2023 10:32:27 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 15 Aug
 2023 10:34:32 +0800
From:   Jiansheng Wu <jiansheng.wu@unisoc.com>
To:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yongzhi.chen@unisoc.com>, <xiaoqing.wu@unisoc.com>,
        <jianshengwu16@gmail.com>
Subject: [PATCH 1/8] Spi: sprd-adi: Getting panic reason before reboot
Date:   Tue, 15 Aug 2023 10:34:19 +0800
Message-ID: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 37F2YYVR066422
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Registered adi_panic_event to panic_notifier_list, that is used to
get panic reason and judge restart causes before system reboot.
It's can improve reboot reasons from panic.

Signed-off-by: Jiansheng Wu <jiansheng.wu@unisoc.com>
---
 drivers/spi/spi-sprd-adi.c | 46 ++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 22e39c4c12c4..dd00d63a3cd0 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/panic_notifier.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/spi/spi.h>
@@ -128,6 +129,8 @@
 #define WDG_LOAD_MASK			GENMASK(15, 0)
 #define WDG_UNLOCK_KEY			0xe551
 
+#define PANIC_REASON_LEN_MAX		20
+
 struct sprd_adi_wdg {
 	u32 base;
 	u32 rst_sts;
@@ -155,6 +158,31 @@ struct sprd_adi {
 	const struct sprd_adi_data *data;
 };
 
+static char *panic_reason;
+static int adi_panic_event(struct notifier_block *self, unsigned long val, void *reason)
+{
+	if (reason == NULL)
+		return 0;
+
+	if (strlen(reason) < PANIC_REASON_LEN_MAX)
+		memcpy(panic_reason, reason, strlen(reason));
+	else
+		memcpy(panic_reason, reason, PANIC_REASON_LEN_MAX);
+
+	return 0;
+}
+
+static struct notifier_block adi_panic_event_nb = {
+	.notifier_call  = adi_panic_event,
+	.priority       = INT_MAX,
+};
+
+static int adi_get_panic_reason_init(void)
+{
+	atomic_notifier_chain_register(&panic_notifier_list, &adi_panic_event_nb);
+	return 0;
+}
+
 static int sprd_adi_check_addr(struct sprd_adi *sadi, u32 reg)
 {
 	if (reg >= sadi->data->slave_addr_size) {
@@ -378,9 +406,15 @@ static int sprd_adi_restart(struct notifier_block *this, unsigned long mode,
 					     restart_handler);
 	u32 val, reboot_mode = 0;
 
-	if (!cmd)
-		reboot_mode = HWRST_STATUS_NORMAL;
-	else if (!strncmp(cmd, "recovery", 8))
+	if (!cmd) {
+		if (strlen(panic_reason)) {
+			reboot_mode = HWRST_STATUS_PANIC;
+			if (strstr(panic_reason, "tospanic"))
+				reboot_mode = HWRST_STATUS_SECURITY;
+		} else {
+			reboot_mode = HWRST_STATUS_NORMAL;
+		}
+	} else if (!strncmp(cmd, "recovery", 8))
 		reboot_mode = HWRST_STATUS_RECOVERY;
 	else if (!strncmp(cmd, "alarm", 5))
 		reboot_mode = HWRST_STATUS_ALARM;
@@ -520,6 +554,10 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	u16 num_chipselect;
 	int ret;
 
+	panic_reason = devm_kzalloc(&pdev->dev, (sizeof(char))*PANIC_REASON_LEN_MAX, GFP_KERNEL);
+	if (!panic_reason)
+		return -ENOMEM;
+
 	if (!np) {
 		dev_err(&pdev->dev, "can not find the adi bus node\n");
 		return -ENODEV;
@@ -573,7 +611,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	}
 
 	sprd_adi_hw_init(sadi);
-
+	adi_get_panic_reason_init();
 	if (sadi->data->wdg_rst)
 		sadi->data->wdg_rst(sadi);
 
-- 
2.17.1


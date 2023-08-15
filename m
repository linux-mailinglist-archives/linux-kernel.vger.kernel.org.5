Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E8C77C5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjHOCfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbjHOCfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:35:17 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B372B10C1;
        Mon, 14 Aug 2023 19:35:15 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37F2Ys2f067436;
        Tue, 15 Aug 2023 10:34:54 +0800 (+08)
        (envelope-from Jiansheng.Wu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RPwKV32gXz2P8CXW;
        Tue, 15 Aug 2023 10:32:46 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 15 Aug
 2023 10:34:51 +0800
From:   Jiansheng Wu <jiansheng.wu@unisoc.com>
To:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yongzhi.chen@unisoc.com>, <xiaoqing.wu@unisoc.com>,
        <jianshengwu16@gmail.com>
Subject: [PATCH 4/8] Spi: sprd-adi: Supported multi parameter configurations
Date:   Tue, 15 Aug 2023 10:34:22 +0800
Message-ID: <20230815023426.15076-4-jiansheng.wu@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
References: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 37F2Ys2f067436
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is supporting multi hardware and multi config on adi driver.
That we can define different parameter on boards' dts, and configure
cannels on adi-device.

Signed-off-by: Jiansheng Wu <jiansheng.wu@unisoc.com>
---
 drivers/spi/spi-sprd-adi.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 569a66943e8d..eea64d20279e 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -140,6 +140,8 @@
 #define WDG_UNLOCK_KEY			0xe551
 
 #define PANIC_REASON_LEN_MAX		20
+/*Adi single soft multi hard*/
+#define SPRD_ADI_MAGIC_LEN_MAX          5
 
 struct sprd_adi_data {
 	u32 slave_offset;
@@ -471,12 +473,40 @@ static int sprd_adi_restart_handler(struct notifier_block *this, unsigned long m
 	return NOTIFY_DONE;
 }
 
+static void sprd_adi_power_ssmh(char *adi_supply)
+{
+	struct device_node *cmdline_node;
+	const char *cmd_line, *adi_type;
+	char adi_value[SPRD_ADI_MAGIC_LEN_MAX] = "";
+	int ret;
+
+	cmdline_node = of_find_node_by_path("/chosen");
+	ret = of_property_read_string(cmdline_node, "bootargs", &cmd_line);
+	if (ret) {
+		pr_err("can't parse bootargs property\n");
+		return;
+	}
+
+	adi_type = strstr(cmd_line, "power.from.extern=");
+	if (!adi_type) {
+		pr_err("can't find power.from.extern\n");
+		return;
+	}
+
+	sscanf(adi_type, "power.from.extern=%s\n", adi_value);
+	if (!adi_value[0])
+		return;
+
+	strcat(adi_supply, adi_value);
+}
+
 static void sprd_adi_hw_init(struct sprd_adi *sadi)
 {
 	struct device_node *np = sadi->dev->of_node;
 	int i, size, chn_cnt;
 	const __be32 *list;
 	u32 tmp;
+	char adi_supply[25] = "sprd,hw-channels";
 
 	/* Set all channels as default priority */
 	writel_relaxed(0, sadi->base + REG_ADI_CHN_PRIL);
@@ -488,7 +518,10 @@ static void sprd_adi_hw_init(struct sprd_adi *sadi)
 	writel_relaxed(tmp, sadi->base + REG_ADI_GSSI_CFG0);
 
 	/* Set hardware channels setting */
-	list = of_get_property(np, "sprd,hw-channels", &size);
+	sprd_adi_power_ssmh(adi_supply);
+	dev_info(sadi->dev, "adi supply is %s\n", adi_supply);
+
+	list = of_get_property(np, adi_supply, &size);
 	if (!list || !size) {
 		dev_info(sadi->dev, "no hw channels setting in node\n");
 		return;
-- 
2.17.1


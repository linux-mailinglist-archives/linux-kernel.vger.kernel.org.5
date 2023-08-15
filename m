Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CD577C5F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjHOCfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbjHOCfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:35:06 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF95810F9;
        Mon, 14 Aug 2023 19:35:04 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37F2YhuR066935;
        Tue, 15 Aug 2023 10:34:43 +0800 (+08)
        (envelope-from Jiansheng.Wu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RPwKH2cFbz2PgxhY;
        Tue, 15 Aug 2023 10:32:35 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 15 Aug
 2023 10:34:40 +0800
From:   Jiansheng Wu <jiansheng.wu@unisoc.com>
To:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yongzhi.chen@unisoc.com>, <xiaoqing.wu@unisoc.com>,
        <jianshengwu16@gmail.com>
Subject: [PATCH 2/8] Spi: sprd-adi: Modify reboot method
Date:   Tue, 15 Aug 2023 10:34:20 +0800
Message-ID: <20230815023426.15076-2-jiansheng.wu@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
References: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 37F2YhuR066935
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing reboot mode on pmic, that write reset-reg to trigger reboot.
Before this, It used watchdog to reboot system, that's not the best
way.

Signed-off-by: Xiaoqing Wu <xiaoqing.wu@unisoc.com>
Signed-off-by: Jiansheng Wu <jiansheng.wu@unisoc.com>
---
 drivers/spi/spi-sprd-adi.c | 117 ++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 73 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index dd00d63a3cd0..734245492680 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -107,6 +107,14 @@
 #define PMIC_MODULE_EN			0xc08
 #define PMIC_CLK_EN			0xc18
 #define PMIC_WDG_BASE			0x80
+#define SC2730_MODULE_EN		0x1808
+#define SC2730_CLK_EN			0x1810
+#define SC2730_WDG_BASE			0x40
+#define SC2730_RST_STATUS		0x1bac
+#define SC2730_SWRST_CTRL0              0x1bf8
+#define SC2730_SOFT_RST_HW              0x1824
+#define REG_RST_EN                      BIT(4)
+#define REG_SOFT_RST                    BIT(0)
 
 /* Definition of PMIC reset status register */
 #define HWRST_STATUS_SECURITY		0x02
@@ -131,20 +139,16 @@
 
 #define PANIC_REASON_LEN_MAX		20
 
-struct sprd_adi_wdg {
-	u32 base;
-	u32 rst_sts;
-	u32 wdg_en;
-	u32 wdg_clk;
-};
-
 struct sprd_adi_data {
 	u32 slave_offset;
 	u32 slave_addr_size;
 	int (*read_check)(u32 val, u32 reg);
-	int (*restart)(struct notifier_block *this,
-		       unsigned long mode, void *cmd);
-	void (*wdg_rst)(void *p);
+	u32 rst_sts;
+	u32 swrst_base;
+	u32 softrst_base;
+	u32 wdg_base;
+	u32 wdg_en;
+	u32 wdg_clk;
 };
 
 struct sprd_adi {
@@ -386,21 +390,19 @@ static int sprd_adi_transfer_one(struct spi_controller *ctlr,
 	return ret;
 }
 
-static void sprd_adi_set_wdt_rst_mode(void *p)
+static void sprd_adi_set_wdt_rst_mode(struct sprd_adi *sadi)
 {
-#if IS_ENABLED(CONFIG_SPRD_WATCHDOG)
+#if IS_ENABLED(CONFIG_SPRD_WATCHDOG) || IS_ENABLED(CONFIG_SPRD_WATCHDOG_FIQ)
 	u32 val;
-	struct sprd_adi *sadi = (struct sprd_adi *)p;
 
 	/* Init watchdog reset mode */
-	sprd_adi_read(sadi, PMIC_RST_STATUS, &val);
+	sprd_adi_read(sadi, sadi->data->rst_sts, &val);
 	val |= HWRST_STATUS_WATCHDOG;
-	sprd_adi_write(sadi, PMIC_RST_STATUS, val);
+	sprd_adi_write(sadi, sadi->data->rst_sts, val);
 #endif
 }
 
-static int sprd_adi_restart(struct notifier_block *this, unsigned long mode,
-				  void *cmd, struct sprd_adi_wdg *wdg)
+static int sprd_adi_restart_handler(struct notifier_block *this, unsigned long mode, void *cmd)
 {
 	struct sprd_adi *sadi = container_of(this, struct sprd_adi,
 					     restart_handler);
@@ -442,40 +444,20 @@ static int sprd_adi_restart(struct notifier_block *this, unsigned long mode,
 		reboot_mode = HWRST_STATUS_NORMAL;
 
 	/* Record the reboot mode */
-	sprd_adi_read(sadi, wdg->rst_sts, &val);
-	val &= ~HWRST_STATUS_WATCHDOG;
+	sprd_adi_read(sadi, sadi->data->rst_sts, &val);
+	val &= ~0xFF;
 	val |= reboot_mode;
-	sprd_adi_write(sadi, wdg->rst_sts, val);
-
-	/* Enable the interface clock of the watchdog */
-	sprd_adi_read(sadi, wdg->wdg_en, &val);
-	val |= BIT_WDG_EN;
-	sprd_adi_write(sadi, wdg->wdg_en, val);
-
-	/* Enable the work clock of the watchdog */
-	sprd_adi_read(sadi, wdg->wdg_clk, &val);
-	val |= BIT_WDG_EN;
-	sprd_adi_write(sadi, wdg->wdg_clk, val);
-
-	/* Unlock the watchdog */
-	sprd_adi_write(sadi, wdg->base + REG_WDG_LOCK, WDG_UNLOCK_KEY);
+	sprd_adi_write(sadi, sadi->data->rst_sts, val);
 
-	sprd_adi_read(sadi, wdg->base + REG_WDG_CTRL, &val);
-	val |= BIT_WDG_NEW;
-	sprd_adi_write(sadi, wdg->base + REG_WDG_CTRL, val);
+	/*enable register reboot mode*/
+	sprd_adi_read(sadi, sadi->data->swrst_base, &val);
+	val |= REG_RST_EN;
+	sprd_adi_write(sadi, sadi->data->swrst_base, val);
 
-	/* Load the watchdog timeout value, 50ms is always enough. */
-	sprd_adi_write(sadi, wdg->base + REG_WDG_LOAD_HIGH, 0);
-	sprd_adi_write(sadi, wdg->base + REG_WDG_LOAD_LOW,
-		       WDG_LOAD_VAL & WDG_LOAD_MASK);
-
-	/* Start the watchdog to reset system */
-	sprd_adi_read(sadi, wdg->base + REG_WDG_CTRL, &val);
-	val |= BIT_WDG_RUN | BIT_WDG_RST;
-	sprd_adi_write(sadi, wdg->base + REG_WDG_CTRL, val);
-
-	/* Lock the watchdog */
-	sprd_adi_write(sadi, wdg->base + REG_WDG_LOCK, ~WDG_UNLOCK_KEY);
+	/*enable soft reboot mode */
+	sprd_adi_read(sadi, sadi->data->softrst_base, &val);
+	val |= REG_SOFT_RST;
+	sprd_adi_write(sadi, sadi->data->softrst_base, val);
 
 	mdelay(1000);
 
@@ -483,19 +465,6 @@ static int sprd_adi_restart(struct notifier_block *this, unsigned long mode,
 	return NOTIFY_DONE;
 }
 
-static int sprd_adi_restart_sc9860(struct notifier_block *this,
-					   unsigned long mode, void *cmd)
-{
-	struct sprd_adi_wdg wdg = {
-		.base = PMIC_WDG_BASE,
-		.rst_sts = PMIC_RST_STATUS,
-		.wdg_en = PMIC_MODULE_EN,
-		.wdg_clk = PMIC_CLK_EN,
-	};
-
-	return sprd_adi_restart(this, mode, cmd, &wdg);
-}
-
 static void sprd_adi_hw_init(struct sprd_adi *sadi)
 {
 	struct device_node *np = sadi->dev->of_node;
@@ -612,8 +581,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 
 	sprd_adi_hw_init(sadi);
 	adi_get_panic_reason_init();
-	if (sadi->data->wdg_rst)
-		sadi->data->wdg_rst(sadi);
+	sprd_adi_set_wdt_rst_mode(sadi);
 
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->bus_num = pdev->id;
@@ -628,14 +596,12 @@ static int sprd_adi_probe(struct platform_device *pdev)
 		goto put_ctlr;
 	}
 
-	if (sadi->data->restart) {
-		sadi->restart_handler.notifier_call = sadi->data->restart;
-		sadi->restart_handler.priority = 128;
-		ret = register_restart_handler(&sadi->restart_handler);
-		if (ret) {
-			dev_err(&pdev->dev, "can not register restart handler\n");
-			goto put_ctlr;
-		}
+	sadi->restart_handler.notifier_call = sprd_adi_restart_handler;
+	sadi->restart_handler.priority = 130;
+	ret = register_restart_handler(&sadi->restart_handler);
+	if (ret) {
+		dev_err(&pdev->dev, "can not register restart handler\n");
+		goto put_ctlr;
 	}
 
 	return 0;
@@ -657,8 +623,10 @@ static struct sprd_adi_data sc9860_data = {
 	.slave_offset = ADI_10BIT_SLAVE_OFFSET,
 	.slave_addr_size = ADI_10BIT_SLAVE_ADDR_SIZE,
 	.read_check = sprd_adi_read_check_r2,
-	.restart = sprd_adi_restart_sc9860,
-	.wdg_rst = sprd_adi_set_wdt_rst_mode,
+	.rst_sts = PMIC_RST_STATUS,
+	.wdg_base = PMIC_WDG_BASE,
+	.wdg_en = PMIC_MODULE_EN,
+	.wdg_clk = PMIC_CLK_EN,
 };
 
 static struct sprd_adi_data sc9863_data = {
@@ -671,6 +639,9 @@ static struct sprd_adi_data ums512_data = {
 	.slave_offset = ADI_15BIT_SLAVE_OFFSET,
 	.slave_addr_size = ADI_15BIT_SLAVE_ADDR_SIZE,
 	.read_check = sprd_adi_read_check_r3,
+	.rst_sts = SC2730_RST_STATUS,
+	.swrst_base = SC2730_SWRST_CTRL0,
+	.softrst_base = SC2730_SOFT_RST_HW,
 };
 
 static const struct of_device_id sprd_adi_of_match[] = {
-- 
2.17.1


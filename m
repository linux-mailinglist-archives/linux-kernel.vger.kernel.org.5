Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E161B7EB557
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjKNRFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjKNRE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:04:59 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6862711D;
        Tue, 14 Nov 2023 09:04:56 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r2wqH-0000hY-1n;
        Tue, 14 Nov 2023 17:04:49 +0000
Date:   Tue, 14 Nov 2023 17:04:46 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 2/2] watchdog: mediatek: mt7988: add wdt support
Message-ID: <3f5ed9656ea66637d259e9771ed852511369ba9b.1699980962.git.daniel@makrotopia.org>
References: <4d7db8786dce35273db516f3d41228bc27a08fe9.1699980962.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d7db8786dce35273db516f3d41228bc27a08fe9.1699980962.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for watchdog and reset generator unit of the MediaTek
MT7988 SoC.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: fix wrong function parameter name in kernel-doc comment
v2: call new toprgu_reset_sw_en_unlocked from toprgu_reset_update while
    holding lock.

 drivers/watchdog/mtk_wdt.c | 40 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index b2330b16b497a..3b4ee7185feed 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -58,6 +58,8 @@
 #define WDT_SWSYSRST		0x18U
 #define WDT_SWSYS_RST_KEY	0x88000000
 
+#define WDT_SWSYSRST_EN		0xfc
+
 #define DRV_NAME		"mtk-wdt"
 #define DRV_VERSION		"1.0"
 
@@ -71,10 +73,12 @@ struct mtk_wdt_dev {
 	struct reset_controller_dev rcdev;
 	bool disable_wdt_extrst;
 	bool reset_by_toprgu;
+	bool has_swsysrst_en;
 };
 
 struct mtk_wdt_data {
 	int toprgu_sw_rst_num;
+	bool has_swsysrst_en;
 };
 
 static const struct mtk_wdt_data mt2712_data = {
@@ -89,6 +93,11 @@ static const struct mtk_wdt_data mt7986_data = {
 	.toprgu_sw_rst_num = MT7986_TOPRGU_SW_RST_NUM,
 };
 
+static const struct mtk_wdt_data mt7988_data = {
+	.toprgu_sw_rst_num = 24,
+	.has_swsysrst_en = true,
+};
+
 static const struct mtk_wdt_data mt8183_data = {
 	.toprgu_sw_rst_num = MT8183_TOPRGU_SW_RST_NUM,
 };
@@ -109,6 +118,28 @@ static const struct mtk_wdt_data mt8195_data = {
 	.toprgu_sw_rst_num = MT8195_TOPRGU_SW_RST_NUM,
 };
 
+/**
+ * toprgu_reset_sw_en_unlocked() - enable/disable software control for reset bit
+ * @data: Pointer to instance of driver data.
+ * @id: Bit number identifying the reset to be enabled or disabled.
+ * @enable: If true, enable software control for that bit, disable otherwise.
+ *
+ * Context: The caller must hold lock of struct mtk_wdt_dev.
+ */
+static void toprgu_reset_sw_en_unlocked(struct mtk_wdt_dev *data,
+					unsigned long id, bool enable)
+{
+	u32 tmp;
+
+	tmp = readl(data->wdt_base + WDT_SWSYSRST_EN);
+	if (enable)
+		tmp |= BIT(id);
+	else
+		tmp &= ~BIT(id);
+
+	writel(tmp, data->wdt_base + WDT_SWSYSRST_EN);
+}
+
 static int toprgu_reset_update(struct reset_controller_dev *rcdev,
 			       unsigned long id, bool assert)
 {
@@ -119,6 +150,9 @@ static int toprgu_reset_update(struct reset_controller_dev *rcdev,
 
 	spin_lock_irqsave(&data->lock, flags);
 
+	if (assert && data->has_swsysrst_en)
+		toprgu_reset_sw_en_unlocked(data, id, true);
+
 	tmp = readl(data->wdt_base + WDT_SWSYSRST);
 	if (assert)
 		tmp |= BIT(id);
@@ -127,6 +161,9 @@ static int toprgu_reset_update(struct reset_controller_dev *rcdev,
 	tmp |= WDT_SWSYS_RST_KEY;
 	writel(tmp, data->wdt_base + WDT_SWSYSRST);
 
+	if (!assert && data->has_swsysrst_en)
+		toprgu_reset_sw_en_unlocked(data, id, false);
+
 	spin_unlock_irqrestore(&data->lock, flags);
 
 	return 0;
@@ -406,6 +443,8 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 						       wdt_data->toprgu_sw_rst_num);
 		if (err)
 			return err;
+
+		mtk_wdt->has_swsysrst_en = wdt_data->has_swsysrst_en;
 	}
 
 	mtk_wdt->disable_wdt_extrst =
@@ -444,6 +483,7 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
 	{ .compatible = "mediatek,mt6589-wdt" },
 	{ .compatible = "mediatek,mt6795-wdt", .data = &mt6795_data },
 	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
+	{ .compatible = "mediatek,mt7988-wdt", .data = &mt7988_data },
 	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
 	{ .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },
 	{ .compatible = "mediatek,mt8188-wdt", .data = &mt8188_data },
-- 
2.42.1

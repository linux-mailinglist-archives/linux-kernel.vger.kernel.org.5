Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAA479B48F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357757AbjIKWF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243973AbjIKSeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:34:19 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2651BB;
        Mon, 11 Sep 2023 11:34:07 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout3.routing.net (Postfix) with ESMTP id 8F86460546;
        Mon, 11 Sep 2023 18:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1694457245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E/Gp1HOJQpVt6kzdG1jbBjVVoqID2dO0BkBbfKI/SKo=;
        b=T3GbUsbwnNVvUGY8yPZLniV/AUr8EG6aIW6ALp3mgTsJWef6nYUREpaG8EOemJtykiHkQ5
        eTAS+00g8kHtMzUm+FHLwKOp/uKUm3tO1MDyJEZoSTxBFuRlLubzs8VwykqborcfnTnBc1
        iSDMWmVoR0c/Z+OrRYdz9sCwYAJkhYs=
Received: from frank-G5.. (fttx-pool-217.61.151.158.bambit.de [217.61.151.158])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id A9F8636077E;
        Mon, 11 Sep 2023 18:34:04 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
Subject: [RFC v1 3/3] thermal/drivers/mediatek/lvts_thermal: add mt7988 support
Date:   Mon, 11 Sep 2023 20:33:54 +0200
Message-Id: <20230911183354.11487-4-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911183354.11487-1-linux@fw-web.de>
References: <20230911183354.11487-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: a4e93b6f-45bb-4e0f-b9a9-b41ceba0b075
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add Support for mediatek fologic 880/MT7988.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/thermal/mediatek/lvts_thermal.c | 73 +++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index c1004b4da3b6..48b257a3c80e 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -82,6 +82,8 @@
 #define LVTS_GOLDEN_TEMP_DEFAULT	50
 #define LVTS_COEFF_A_MT8195			-250460
 #define LVTS_COEFF_B_MT8195			250460
+#define LVTS_COEFF_A_MT7988			-204650
+#define LVTS_COEFF_B_MT7988			204650
 
 #define LVTS_MSR_IMMEDIATE_MODE		0
 #define LVTS_MSR_FILTERED_MODE		1
@@ -1272,6 +1274,67 @@ static int lvts_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/*
+ * LVTS MT7988
+ */
+#define LVTS_HW_SHUTDOWN_MT7988	117000
+//enum mt7988_lvts_domain { MT7988_AP_DOMAIN, MT7988_NUM_DOMAIN };
+
+enum mt7988_lvts_sensor_enum {
+	MT7988_TS3_0,
+	MT7988_TS3_1,
+	MT7988_TS3_2,
+	MT7988_TS3_3,
+	MT7988_TS4_0,
+	MT7988_TS4_1,
+	MT7988_TS4_2,
+	MT7988_TS4_3,
+	MT7988_NUM_TS
+};
+
+//Efuse base : 0x11f50000
+//lvts offset in efuse : 0x918 (set in efuse dts node as calibration data)
+//offsets:
+//918 = LVTS_3_0_COUNT_R
+//91C = LVTS_3_1_COUNT_R
+//920 = LVTS_3_2_COUNT_R
+//924 = LVTS_3_3_COUNT_R
+//928 = LVTS_3_COUNT_RC
+
+//92C = LVTS_4_0_COUNT_R
+//930 = LVTS_4_1_COUNT_R
+//934 = LVTS_4_2_COUNT_R
+//938 = LVTS_4_3_COUNT_R
+//93C = LVTS_4_COUNT_RC
+
+static const struct lvts_ctrl_data mt7988_lvts_data_ctrl[] = {
+	{
+		.cal_offset = { 0x00, 0x04, 0x08, 0x0c }, //918,91C,920,924
+		.lvts_sensor = {
+			{ .dt_id = MT7988_TS3_0 },
+			{ .dt_id = MT7988_TS3_1 },
+			{ .dt_id = MT7988_TS3_2 },
+			{ .dt_id = MT7988_TS3_3 }
+		},
+		.num_lvts_sensor = 4,
+		.offset = 0x0,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT7988,
+	},
+	{
+		.cal_offset = { 0x14, 0x18, 0x1c, 0x20 }, //92C,930,934,938
+		.lvts_sensor = {
+			{ .dt_id = MT7988_TS4_0},
+			{ .dt_id = MT7988_TS4_1},
+			{ .dt_id = MT7988_TS4_2},
+			{ .dt_id = MT7988_TS4_3}
+		},
+		.num_lvts_sensor = 4,
+		.offset = 0x100,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT7988,
+	}
+};
+
+//MT8195
 static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
 	{
 		.cal_offset = { 0x04, 0x07 },
@@ -1351,6 +1414,15 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 	}
 };
 
+static const struct lvts_data mt7988_lvts_data = {
+	.lvts_ctrl	= mt7988_lvts_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt7988_lvts_data_ctrl),
+	.coeff = {
+		.a = LVTS_COEFF_A_MT7988,
+		.b = LVTS_COEFF_B_MT7988,
+	},
+};
+
 static const struct lvts_data mt8195_lvts_mcu_data = {
 	.lvts_ctrl	= mt8195_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_mcu_data_ctrl),
@@ -1372,6 +1444,7 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 };
 
 static const struct of_device_id lvts_of_match[] = {
+	{ .compatible = "mediatek,mt7988-lvts", .data = &mt7988_lvts_data },
 	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt8195_lvts_mcu_data },
 	{ .compatible = "mediatek,mt8195-lvts-ap", .data = &mt8195_lvts_ap_data },
 	{},
-- 
2.34.1


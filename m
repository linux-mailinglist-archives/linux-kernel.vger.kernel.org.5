Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F3E7CCB92
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344114AbjJQTC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjJQTCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:02:19 -0400
Received: from emag.lindev.ch (unknown [81.221.122.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDECEF0;
        Tue, 17 Oct 2023 12:02:16 -0700 (PDT)
Received: from ryzen9.fritz.box (unknown [81.221.122.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bero@lindev.ch)
        by emag.lindev.ch (Postfix) with ESMTPSA id 39CFF20046A;
        Tue, 17 Oct 2023 20:55:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lindev.ch; s=default;
        t=1697568968; bh=LuquMC1zO/eWMES9gHlWrV4+uC7g9zZf8IQJ+6DQiJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jckV5UtiZyYH6rKDhV2im+XXvBmbP6x2I/dvzT7CWrcyViHFewMnEycR14UbkbGgN
         +EhkNTPYWxpLXyIRc9ewFgXUioo3MI50fNZ6oLRogHUpeThlSWaFDWrRYLuumcxFRO
         SQuC35deey8dOrbR3qoN6oCYL1WUgUcNMKVCkn0I=
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@lindev.ch>
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dunlap@infradead.org,
        e.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, ames.lo@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v5 3/5] thermal/drivers/mediatek/lvts_thermal: Add mt8192 support
Date:   Tue, 17 Oct 2023 20:55:53 +0200
Message-ID: <20231017185555.142062-4-bero@lindev.ch>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017185555.142062-1-bero@lindev.ch>
References: <20231017185555.142062-1-bero@lindev.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add LVTS Driver support for MT8192.

Co-developed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
[bero@baylibre.com: cosmetic changes, rebase]
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 95 +++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index c5a03bdf63e9d..487401424951d 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -89,6 +89,7 @@
 #define LVTS_MSR_READ_TIMEOUT_US	400
 #define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
 
+#define LVTS_HW_SHUTDOWN_MT8192		105000
 #define LVTS_HW_SHUTDOWN_MT8195		105000
 
 #define LVTS_MINIMUM_THRESHOLD		20000
@@ -1286,6 +1287,88 @@ static int lvts_resume(struct device *dev)
 	return 0;
 }
 
+static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
+	{
+		.cal_offset = { 0x04, 0x08 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_MCU_BIG_CPU0 },
+			{ .dt_id = MT8192_MCU_BIG_CPU1 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x0,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+		.mode = LVTS_MSR_FILTERED_MODE,
+	},
+	{
+		.cal_offset = { 0x0c, 0x10 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_MCU_BIG_CPU2 },
+			{ .dt_id = MT8192_MCU_BIG_CPU3 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x100,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+		.mode = LVTS_MSR_FILTERED_MODE,
+	},
+	{
+		.cal_offset = { 0x14, 0x18, 0x1c, 0x20 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_MCU_LITTLE_CPU0 },
+			{ .dt_id = MT8192_MCU_LITTLE_CPU1 },
+			{ .dt_id = MT8192_MCU_LITTLE_CPU2 },
+			{ .dt_id = MT8192_MCU_LITTLE_CPU3 }
+		},
+		.num_lvts_sensor = 4,
+		.offset = 0x200,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+		.mode = LVTS_MSR_FILTERED_MODE,
+	}
+};
+
+static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
+		{
+		.cal_offset = { 0x24, 0x28 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_AP_VPU0 },
+			{ .dt_id = MT8192_AP_VPU1 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x0,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	},
+	{
+		.cal_offset = { 0x2c, 0x30 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_AP_GPU0 },
+			{ .dt_id = MT8192_AP_GPU1 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x100,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	},
+	{
+		.cal_offset = { 0x34, 0x38 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_AP_INFRA },
+			{ .dt_id = MT8192_AP_CAM },
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x200,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	},
+	{
+		.cal_offset = { 0x3c, 0x40, 0x44 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_AP_MD0 },
+			{ .dt_id = MT8192_AP_MD1 },
+			{ .dt_id = MT8192_AP_MD2 }
+		},
+		.num_lvts_sensor = 3,
+		.offset = 0x300,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	}
+};
+
 static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
 	{
 		.cal_offset = { 0x04, 0x07 },
@@ -1365,6 +1448,16 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 	}
 };
 
+static const struct lvts_data mt8192_lvts_mcu_data = {
+	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
+};
+
+static const struct lvts_data mt8192_lvts_ap_data = {
+	.lvts_ctrl	= mt8192_lvts_ap_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_ap_data_ctrl),
+};
+
 static const struct lvts_data mt8195_lvts_mcu_data = {
 	.lvts_ctrl	= mt8195_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_mcu_data_ctrl),
@@ -1376,6 +1469,8 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 };
 
 static const struct of_device_id lvts_of_match[] = {
+	{ .compatible = "mediatek,mt8192-lvts-mcu", .data = &mt8192_lvts_mcu_data },
+	{ .compatible = "mediatek,mt8192-lvts-ap", .data = &mt8192_lvts_ap_data },
 	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt8195_lvts_mcu_data },
 	{ .compatible = "mediatek,mt8195-lvts-ap", .data = &mt8195_lvts_ap_data },
 	{},
-- 
2.42.0


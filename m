Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C002B7AA893
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 07:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjIVFus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 01:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjIVFuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 01:50:39 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF39114;
        Thu, 21 Sep 2023 22:50:30 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout3.routing.net (Postfix) with ESMTP id E8CE160F65;
        Fri, 22 Sep 2023 05:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1695361829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wd/4D84ABQ1LUUMTxdk3iRJmoRHg+E5YpjikqYdM80A=;
        b=sioAofncDb3E5M01wPfvOv9pI8bqr77jl887SgjeUrwc9QkQTS7CkSVHUhMDDtD74BM1hr
        cecraz1Cw4gGi+vKytwcjtcvJ+KNxqqb6gXBtmFGF4s1Pty04GfeipPZmRfHXUEolZPI2p
        ovz4KJ4R0l5qWe0VDx59QYokUhfoKkI=
Received: from frank-G5.. (fttx-pool-217.61.149.125.bambit.de [217.61.149.125])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 1D6964021D;
        Fri, 22 Sep 2023 05:50:28 +0000 (UTC)
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/4] thermal/drivers/mediatek/lvts_thermal: add mt7988 support
Date:   Fri, 22 Sep 2023 07:50:20 +0200
Message-Id: <20230922055020.6436-5-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922055020.6436-1-linux@fw-web.de>
References: <20230922055020.6436-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mail-ID: 12176a23-d372-4442-8d8e-fe41e40334c0
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add Support for Mediatek Filogic 880/MT7988 LVTS.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v3:
- drop comments

v2:
- use 105°C for hw shutdown
- move constants to binding file
- change coeff.a to temp_factor and coeff.b to temp_offset
- change to lvts to lvts-ap (Application Processor)
- drop comments about efuse offsets
- change comment of mt8195 to be similar to mt7988
---
 drivers/thermal/mediatek/lvts_thermal.c | 38 +++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index c2669f405a94..23b4e0b3195c 100644
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
@@ -89,6 +91,7 @@
 #define LVTS_MSR_READ_TIMEOUT_US	400
 #define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
 
+#define LVTS_HW_SHUTDOWN_MT7988		105000
 #define LVTS_HW_SHUTDOWN_MT8195		105000
 
 #define LVTS_MINIMUM_THRESHOLD		20000
@@ -1269,6 +1272,33 @@ static int lvts_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct lvts_ctrl_data mt7988_lvts_ap_data_ctrl[] = {
+	{
+		.cal_offset = { 0x00, 0x04, 0x08, 0x0c },
+		.lvts_sensor = {
+			{ .dt_id = MT7988_CPU_0 },
+			{ .dt_id = MT7988_CPU_1 },
+			{ .dt_id = MT7988_ETH2P5G_0 },
+			{ .dt_id = MT7988_ETH2P5G_1 }
+		},
+		.num_lvts_sensor = 4,
+		.offset = 0x0,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT7988,
+	},
+	{
+		.cal_offset = { 0x14, 0x18, 0x1c, 0x20 },
+		.lvts_sensor = {
+			{ .dt_id = MT7988_TOPS_0},
+			{ .dt_id = MT7988_TOPS_1},
+			{ .dt_id = MT7988_ETHWARP_0},
+			{ .dt_id = MT7988_ETHWARP_1}
+		},
+		.num_lvts_sensor = 4,
+		.offset = 0x100,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT7988,
+	}
+};
+
 static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
 	{
 		.cal_offset = { 0x04, 0x07 },
@@ -1348,6 +1378,13 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 	}
 };
 
+static const struct lvts_data mt7988_lvts_ap_data = {
+	.lvts_ctrl	= mt7988_lvts_ap_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt7988_lvts_ap_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT7988,
+	.temp_offset	= LVTS_COEFF_B_MT7988,
+};
+
 static const struct lvts_data mt8195_lvts_mcu_data = {
 	.lvts_ctrl	= mt8195_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_mcu_data_ctrl),
@@ -1363,6 +1400,7 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 };
 
 static const struct of_device_id lvts_of_match[] = {
+	{ .compatible = "mediatek,mt7988-lvts-ap", .data = &mt7988_lvts_ap_data },
 	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt8195_lvts_mcu_data },
 	{ .compatible = "mediatek,mt8195-lvts-ap", .data = &mt8195_lvts_ap_data },
 	{},
-- 
2.34.1


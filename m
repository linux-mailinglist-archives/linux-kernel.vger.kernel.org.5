Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807F77A8ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjITRu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjITRuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:50:18 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D5EA3;
        Wed, 20 Sep 2023 10:50:12 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout1.routing.net (Postfix) with ESMTP id 9DD9B4045E;
        Wed, 20 Sep 2023 17:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1695232210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QpydNhnuiJDmq+DkprcEXtw+wHEatREQRn/jQOhq8U=;
        b=psadO1KI3iBd80l9ivfW3Xc8VuZT4T3fzQ+BK66uGeSaUavtIWoXIoq+BHtSJYcZ0N9Yj2
        O2mOPIkuv4OXumPzOmkAA9Q6GSWmgquA4FOHgOcEoqtFUzUcF3i5XYEQOGUA4DndII9uv3
        3HF2l7WMM/u5Ma6yg8ykXBoIkG+CbSU=
Received: from frank-G5.. (fttx-pool-217.61.152.105.bambit.de [217.61.152.105])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id BD9911006A2;
        Wed, 20 Sep 2023 17:50:09 +0000 (UTC)
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
Subject: [PATCH v2 3/4] thermal/drivers/mediatek/lvts_thermal: make coeff configurable
Date:   Wed, 20 Sep 2023 19:50:00 +0200
Message-Id: <20230920175001.47563-4-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920175001.47563-1-linux@fw-web.de>
References: <20230920175001.47563-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: ef1a64eb-da28-41db-a1c7-108f57370c3b
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

The upcoming mt7988 has different temperature coefficients so we
cannot use constants in the functions lvts_golden_temp_init,
lvts_golden_temp_init and lvts_raw_to_temp anymore.

Add a field in the lvts_ctrl pointing to the lvts_data which now
contains the soc-specific temperature coefficents.

To make the code better readable, rename static int coeff_b to
golden_temp_offset, COEFF_A to temp_factor and COEFF_B to temp_offset.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

---
v2:
- rename static int coeff_b to golden_temp_offset
- rename coeff.a to temp_factor and coeff.b to temp_offset
---
 drivers/thermal/mediatek/lvts_thermal.c | 51 ++++++++++++++++---------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index effd9b00a424..c2669f405a94 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -80,8 +80,8 @@
 #define LVTS_SENSOR_MAX				4
 #define LVTS_GOLDEN_TEMP_MAX		62
 #define LVTS_GOLDEN_TEMP_DEFAULT	50
-#define LVTS_COEFF_A				-250460
-#define LVTS_COEFF_B				250460
+#define LVTS_COEFF_A_MT8195			-250460
+#define LVTS_COEFF_B_MT8195			250460
 
 #define LVTS_MSR_IMMEDIATE_MODE		0
 #define LVTS_MSR_FILTERED_MODE		1
@@ -94,7 +94,7 @@
 #define LVTS_MINIMUM_THRESHOLD		20000
 
 static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
-static int coeff_b = LVTS_COEFF_B;
+static int golden_temp_offset;
 
 struct lvts_sensor_data {
 	int dt_id;
@@ -112,6 +112,8 @@ struct lvts_ctrl_data {
 struct lvts_data {
 	const struct lvts_ctrl_data *lvts_ctrl;
 	int num_lvts_ctrl;
+	int temp_factor;
+	int temp_offset;
 };
 
 struct lvts_sensor {
@@ -126,6 +128,7 @@ struct lvts_sensor {
 
 struct lvts_ctrl {
 	struct lvts_sensor sensors[LVTS_SENSOR_MAX];
+	const struct lvts_data *lvts_data;
 	u32 calibration[LVTS_SENSOR_MAX];
 	u32 hw_tshut_raw_temp;
 	int num_lvts_sensor;
@@ -247,21 +250,21 @@ static void lvts_debugfs_exit(struct lvts_domain *lvts_td) { }
 
 #endif
 
-static int lvts_raw_to_temp(u32 raw_temp)
+static int lvts_raw_to_temp(u32 raw_temp, int temp_factor)
 {
 	int temperature;
 
-	temperature = ((s64)(raw_temp & 0xFFFF) * LVTS_COEFF_A) >> 14;
-	temperature += coeff_b;
+	temperature = ((s64)(raw_temp & 0xFFFF) * temp_factor) >> 14;
+	temperature += golden_temp_offset;
 
 	return temperature;
 }
 
-static u32 lvts_temp_to_raw(int temperature)
+static u32 lvts_temp_to_raw(int temperature, int temp_factor)
 {
-	u32 raw_temp = ((s64)(coeff_b - temperature)) << 14;
+	u32 raw_temp = ((s64)(golden_temp_offset - temperature)) << 14;
 
-	raw_temp = div_s64(raw_temp, -LVTS_COEFF_A);
+	raw_temp = div_s64(raw_temp, -temp_factor);
 
 	return raw_temp;
 }
@@ -269,6 +272,9 @@ static u32 lvts_temp_to_raw(int temperature)
 static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct lvts_sensor *lvts_sensor = thermal_zone_device_priv(tz);
+	struct lvts_ctrl *lvts_ctrl = container_of(lvts_sensor, struct lvts_ctrl,
+						   sensors[lvts_sensor->id]);
+	const struct lvts_data *lvts_data = lvts_ctrl->lvts_data;
 	void __iomem *msr = lvts_sensor->msr;
 	u32 value;
 	int rc;
@@ -301,7 +307,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (rc)
 		return -EAGAIN;
 
-	*temp = lvts_raw_to_temp(value & 0xFFFF);
+	*temp = lvts_raw_to_temp(value & 0xFFFF, lvts_data->temp_factor);
 
 	return 0;
 }
@@ -348,10 +354,13 @@ static bool lvts_should_update_thresh(struct lvts_ctrl *lvts_ctrl, int high)
 static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
 	struct lvts_sensor *lvts_sensor = thermal_zone_device_priv(tz);
-	struct lvts_ctrl *lvts_ctrl = container_of(lvts_sensor, struct lvts_ctrl, sensors[lvts_sensor->id]);
+	struct lvts_ctrl *lvts_ctrl = container_of(lvts_sensor, struct lvts_ctrl,
+						   sensors[lvts_sensor->id]);
+	const struct lvts_data *lvts_data = lvts_ctrl->lvts_data;
 	void __iomem *base = lvts_sensor->base;
-	u32 raw_low = lvts_temp_to_raw(low != -INT_MAX ? low : LVTS_MINIMUM_THRESHOLD);
-	u32 raw_high = lvts_temp_to_raw(high);
+	u32 raw_low = lvts_temp_to_raw(low != -INT_MAX ? low : LVTS_MINIMUM_THRESHOLD,
+				       lvts_data->temp_factor);
+	u32 raw_high = lvts_temp_to_raw(high, lvts_data->temp_factor);
 	bool should_update_thresh;
 
 	lvts_sensor->low_thresh = low;
@@ -692,7 +701,7 @@ static int lvts_calibration_read(struct device *dev, struct lvts_domain *lvts_td
 	return 0;
 }
 
-static int lvts_golden_temp_init(struct device *dev, u32 *value)
+static int lvts_golden_temp_init(struct device *dev, u32 *value, int temp_offset)
 {
 	u32 gt;
 
@@ -701,7 +710,7 @@ static int lvts_golden_temp_init(struct device *dev, u32 *value)
 	if (gt && gt < LVTS_GOLDEN_TEMP_MAX)
 		golden_temp = gt;
 
-	coeff_b = golden_temp * 500 + LVTS_COEFF_B;
+	golden_temp_offset = golden_temp * 500 + temp_offset;
 
 	return 0;
 }
@@ -724,7 +733,7 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
 	 * The golden temp information is contained in the first chunk
 	 * of efuse data.
 	 */
-	ret = lvts_golden_temp_init(dev, (u32 *)lvts_td->calib);
+	ret = lvts_golden_temp_init(dev, (u32 *)lvts_td->calib, lvts_data->temp_offset);
 	if (ret)
 		return ret;
 
@@ -735,6 +744,7 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
 	for (i = 0; i < lvts_data->num_lvts_ctrl; i++) {
 
 		lvts_ctrl[i].base = lvts_td->base + lvts_data->lvts_ctrl[i].offset;
+		lvts_ctrl[i].lvts_data = lvts_data;
 
 		ret = lvts_sensor_init(dev, &lvts_ctrl[i],
 				       &lvts_data->lvts_ctrl[i]);
@@ -758,7 +768,8 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
 		 * after initializing the calibration.
 		 */
 		lvts_ctrl[i].hw_tshut_raw_temp =
-			lvts_temp_to_raw(lvts_data->lvts_ctrl[i].hw_tshut_temp);
+			lvts_temp_to_raw(lvts_data->lvts_ctrl[i].hw_tshut_temp,
+					 lvts_data->temp_factor);
 
 		lvts_ctrl[i].low_thresh = INT_MIN;
 		lvts_ctrl[i].high_thresh = INT_MIN;
@@ -1223,6 +1234,8 @@ static int lvts_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	golden_temp_offset = lvts_data->temp_offset;
+
 	ret = lvts_domain_init(dev, lvts_td, lvts_data);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to initialize the lvts domain\n");
@@ -1338,11 +1351,15 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 static const struct lvts_data mt8195_lvts_mcu_data = {
 	.lvts_ctrl	= mt8195_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_mcu_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8195,
+	.temp_offset	= LVTS_COEFF_B_MT8195,
 };
 
 static const struct lvts_data mt8195_lvts_ap_data = {
 	.lvts_ctrl	= mt8195_lvts_ap_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_ap_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8195,
+	.temp_offset	= LVTS_COEFF_B_MT8195,
 };
 
 static const struct of_device_id lvts_of_match[] = {
-- 
2.34.1


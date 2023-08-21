Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0E5782B23
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbjHUOEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbjHUOD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:03:56 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123DDE3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:03:52 -0700 (PDT)
Received: from [192.168.2.137] (bband-dyn221.178-41-211.t-com.sk [178.41.211.221])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 8BD393F312;
        Mon, 21 Aug 2023 16:03:50 +0200 (CEST)
From:   Martin Botka <martin.botka@somainline.org>
Date:   Mon, 21 Aug 2023 16:03:47 +0200
Subject: [PATCH v2 2/3] thermal: sun8i: Add support for H616 THS controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230821-ths-h616-v2-2-cda60d556798@somainline.org>
References: <20230821-ths-h616-v2-0-cda60d556798@somainline.org>
In-Reply-To: <20230821-ths-h616-v2-0-cda60d556798@somainline.org>
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Luke Harrison <bttuniversity@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin@biqu3d.com>,
        Martin Botka <martin.botka@somainline.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692626628; l=3663;
 i=martin.botka@somainline.org; s=20230811; h=from:subject:message-id;
 bh=3eq77nlTbm5Cngkl0jvZ6/DlERU3jpKgLGwvz/iFz7Y=;
 b=U/aPMfBD9D8cf/kdX6HO3vrpFdoTwFj+yd1eMvop5L1Iu+RV903eBhucrBxNcWGmaaAjHrmUl
 bl4QAHKwgZfC6tQQbES+YVE6AKfs9l42r1pE1DNsa+sMgnGc8hbFXZ0
X-Developer-Key: i=martin.botka@somainline.org; a=ed25519;
 pk=aTCd3jmwU8GrJidWg3DSKLpdVMcpFzXzCSLXLR6NtWU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the thermal sensor found in H616 SoC
which slightly resembles the H6 thermal sensor
controller with few changes like 4 sensors.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 drivers/thermal/sun8i_thermal.c | 74 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 195f3c5d0b38..cf96ab6a445b 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -278,6 +278,66 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 	return 0;
 }
 
+static int sun50i_h616_ths_calibrate(struct ths_device *tmdev,
+				     u16 *caldata, int callen)
+{
+	struct device *dev = tmdev->dev;
+	int i, ft_temp;
+
+	if (!caldata[0])
+		return -EINVAL;
+
+	/*
+	 * h616 efuse THS calibration data layout:
+	 *
+	 * 0      11  16     27   32     43   48    57
+	 * +----------+-----------+-----------+-----------+
+	 * |  temp |  |sensor0|   |sensor1|   |sensor2|   |
+	 * +----------+-----------+-----------+-----------+
+	 *                      ^           ^           ^
+	 *                      |           |           |
+	 *                      |           |           sensor3[11:8]
+	 *                      |           sensor3[7:4]
+	 *                      sensor3[3:0]
+	 *
+	 * The calibration data on the H616 is the ambient temperature and
+	 * sensor values that are filled during the factory test stage.
+	 *
+	 * The unit of stored FT temperature is 0.1 degree celsius.
+	 */
+	ft_temp = caldata[0] & FT_TEMP_MASK;
+
+	for (i = 0; i < tmdev->chip->sensor_num; i++) {
+		int delta, cdata, offset, reg;
+
+		if (i == 3)
+			reg = (caldata[1] >> 12)
+			      | ((caldata[2] >> 12) << 4)
+			      | ((caldata[3] >> 12) << 8);
+		else
+			reg = (int)caldata[i + 1] & TEMP_CALIB_MASK;
+
+		int sensor_temp = tmdev->chip->calc_temp(tmdev, i, reg);
+
+		delta = (sensor_temp - ft_temp * 100) * 10;
+		delta /= tmdev->chip->scale;
+		cdata = CALIBRATE_DEFAULT - delta;
+		if (cdata & ~TEMP_CALIB_MASK) {
+			dev_warn(dev, "sensor%d is not calibrated.\n", i);
+
+			continue;
+		}
+
+		offset = (i % 2) * 16;
+		regmap_update_bits(tmdev->regmap,
+				   SUN50I_H6_THS_TEMP_CALIB + (i / 2 * 4),
+				   TEMP_CALIB_MASK << offset,
+				   cdata << offset);
+	}
+
+	return 0;
+}
+
 static int sun8i_ths_calibrate(struct ths_device *tmdev)
 {
 	struct nvmem_cell *calcell;
@@ -608,6 +668,19 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
 	.calc_temp = sun8i_ths_calc_temp,
 };
 
+static const struct ths_thermal_chip sun50i_h616_ths = {
+	.sensor_num = 4,
+	.has_bus_clk_reset = true,
+	.ft_deviation = 8000,
+	.offset = 263655,
+	.scale = 810,
+	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
+	.calibrate = sun50i_h616_ths_calibrate,
+	.init = sun50i_h6_thermal_init,
+	.irq_ack = sun50i_h6_irq_ack,
+	.calc_temp = sun8i_ths_calc_temp,
+};
+
 static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun8i-a83t-ths", .data = &sun8i_a83t_ths },
 	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
@@ -616,6 +689,7 @@ static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun50i-a100-ths", .data = &sun50i_a100_ths },
 	{ .compatible = "allwinner,sun50i-h5-ths", .data = &sun50i_h5_ths },
 	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
+	{ .compatible = "allwinner,sun50i-h616-ths", .data = &sun50i_h616_ths },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, of_ths_match);

-- 
2.41.0


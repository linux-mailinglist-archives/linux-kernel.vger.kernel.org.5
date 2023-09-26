Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FA37AF55D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbjIZUiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbjIZUiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:38:11 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D1412A;
        Tue, 26 Sep 2023 13:38:04 -0700 (PDT)
Received: from p200300ccff2a5b001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2a:5b00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qlEoY-004D58-9q; Tue, 26 Sep 2023 22:37:49 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qlEoX-008tVQ-1u;
        Tue, 26 Sep 2023 22:37:49 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com,
        jean-baptiste.maneyrol@tdk.com, andreas@kemnade.info,
        chenhuiz@axis.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v2 2/3] iio: imu: mpu6050: add level shifter flag
Date:   Tue, 26 Sep 2023 22:37:38 +0200
Message-Id: <20230926203739.2119963-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230926203739.2119963-1-andreas@kemnade.info>
References: <20230926203739.2119963-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards fail in magnetometer probe if level shifter flag is not set,
definition was found in a 3.0 vendor kernel.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c  | 10 ++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  3 +++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
index 7327e5723f961..1d30360f1d482 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
@@ -71,6 +71,16 @@ int inv_mpu_aux_init(const struct inv_mpu6050_state *st)
 	unsigned int val;
 	int ret;
 
+	/* code based on a 3.0 vendor kernel, the exact meaning is unknown */
+	if (st->chip_type == INV_MPU9150) {
+		unsigned int mask = BIT(7);
+
+		val = st->level_shifter ? mask : 0;
+		ret = regmap_update_bits(st->map, 0x1, mask, val);
+		if (ret)
+			return ret;
+	}
+
 	/* configure i2c master */
 	val = INV_MPU6050_BITS_I2C_MST_CLK_400KHZ |
 			INV_MPU6050_BIT_WAIT_FOR_ES;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 29f906c884bd8..3fbeef1a70186 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -17,6 +17,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 
 #include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/iio.h>
@@ -1495,6 +1496,8 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	st->irq = irq;
 	st->map = regmap;
 
+	st->level_shifter = device_property_read_bool(dev,
+						      "invensense,level-shifter");
 	pdata = dev_get_platdata(dev);
 	if (!pdata) {
 		result = iio_read_mount_matrix(dev, &st->orientation);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index ed5a96e78df05..7eba1439c8093 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -203,6 +203,7 @@ struct inv_mpu6050_state {
 	s32 magn_raw_to_gauss[3];
 	struct iio_mount_matrix magn_orient;
 	unsigned int suspended_sensors;
+	bool level_shifter;
 	u8 *data;
 };
 
-- 
2.39.2


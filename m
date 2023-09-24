Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D627ACC8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 00:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjIXW0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 18:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjIXW01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 18:26:27 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83D9FC;
        Sun, 24 Sep 2023 15:26:19 -0700 (PDT)
Received: from p200300ccff1ebc001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff1e:bc00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qkXYA-00492D-TR; Mon, 25 Sep 2023 00:26:02 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qkXYA-008YN2-0Q;
        Mon, 25 Sep 2023 00:26:02 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com,
        jean-baptiste.maneyrol@tdk.com, chenhuiz@axis.com,
        andreas@kemnade.info, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 2/3] iio: imu: mpu6050: add level shifter flag
Date:   Mon, 25 Sep 2023 00:25:58 +0200
Message-Id: <20230924222559.2038721-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230924222559.2038721-1-andreas@kemnade.info>
References: <20230924222559.2038721-1-andreas@kemnade.info>
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

Some boards fail in magnetometer probe if flag is not set.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c  | 5 +++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 3 +++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
index 7327e5723f961..15dbe88ff8c43 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
@@ -71,6 +71,11 @@ int inv_mpu_aux_init(const struct inv_mpu6050_state *st)
 	unsigned int val;
 	int ret;
 
+	ret = regmap_update_bits(st->map, 0x1, 0x80,
+				 st->level_shifter ? 0x80 : 0);
+	if (ret)
+		return ret;
+
 	/* configure i2c master */
 	val = INV_MPU6050_BITS_I2C_MST_CLK_400KHZ |
 			INV_MPU6050_BIT_WAIT_FOR_ES;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 29f906c884bd8..21cf794a41561 100644
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
 
+	st->level_shifter = device_property_present(dev,
+						    "invensense,level-shifter");
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0B0790B4F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 11:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbjICJBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 05:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjICJBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 05:01:10 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 522CE127;
        Sun,  3 Sep 2023 02:01:03 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,224,1688396400"; 
   d="scan'208";a="178544903"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2023 18:01:03 +0900
Received: from localhost.localdomain (unknown [10.226.92.30])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9D4CD4189CC3;
        Sun,  3 Sep 2023 18:01:00 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/2] iio: accel: adxl345: Simplify adxl345_read_raw()
Date:   Sun,  3 Sep 2023 10:00:51 +0100
Message-Id: <20230903090051.39274-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230903090051.39274-1-biju.das.jz@bp.renesas.com>
References: <20230903090051.39274-1-biju.das.jz@bp.renesas.com>
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

Simplify adxl345_read_raw() by adding uscale variable to
struct adxl345_chip_info. Also convert variables adxl3{4,7}5_uscale to
macros and use it in OF/ACPI/ID match table.

Drop enum adxl345_device_type as there is no user.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3:
 * New patch.
---
 drivers/iio/accel/adxl345.h      | 20 +++++++++++++++-----
 drivers/iio/accel/adxl345_core.c | 25 +------------------------
 drivers/iio/accel/adxl345_i2c.c  |  4 ++--
 drivers/iio/accel/adxl345_spi.c  |  4 ++--
 4 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 826e0575ae79..284bd387ce69 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -8,14 +8,24 @@
 #ifndef _ADXL345_H_
 #define _ADXL345_H_
 
-enum adxl345_device_type {
-	ADXL345	= 1,
-	ADXL375 = 2,
-};
+/*
+ * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
+ * in all g ranges.
+ *
+ * At +/- 16g with 13-bit resolution, scale is computed as:
+ * (16 + 16) * 9.81 / (2^13 - 1) = 0.0383
+ */
+#define ADXL345_USCALE	38300
+
+/*
+ * The Datasheet lists a resolution of Resolution is ~49 mg per LSB. That's
+ * ~480mm/s**2 per LSB.
+ */
+#define ADXL375_USCALE	480000
 
 struct adxl345_chip_info {
 	const char *name;
-	unsigned int type;
+	int uscale;
 };
 
 int adxl345_core_probe(struct device *dev, struct regmap *regmap);
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 28f77b5de47d..8bd30a23ed3b 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -45,21 +45,6 @@
 
 #define ADXL345_DEVID			0xE5
 
-/*
- * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
- * in all g ranges.
- *
- * At +/- 16g with 13-bit resolution, scale is computed as:
- * (16 + 16) * 9.81 / (2^13 - 1) = 0.0383
- */
-static const int adxl345_uscale = 38300;
-
-/*
- * The Datasheet lists a resolution of Resolution is ~49 mg per LSB. That's
- * ~480mm/s**2 per LSB.
- */
-static const int adxl375_uscale = 480000;
-
 struct adxl345_data {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
@@ -110,15 +95,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-		switch (data->info->type) {
-		case ADXL345:
-			*val2 = adxl345_uscale;
-			break;
-		case ADXL375:
-			*val2 = adxl375_uscale;
-			break;
-		}
-
+		*val2 = data->info->uscale;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = regmap_read(data->regmap,
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 8cb6254297f7..a3084b0a8f78 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -32,12 +32,12 @@ static int adxl345_i2c_probe(struct i2c_client *client)
 
 static const struct adxl345_chip_info adxl345_i2c_info = {
 	.name = "adxl345",
-	.type = ADXL345,
+	.uscale = ADXL345_USCALE,
 };
 
 static const struct adxl345_chip_info adxl375_i2c_info = {
 	.name = "adxl375",
-	.type = ADXL375,
+	.uscale = ADXL375_USCALE,
 };
 
 static const struct i2c_device_id adxl345_i2c_id[] = {
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index ede9b9496158..93ca349f1780 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -38,12 +38,12 @@ static int adxl345_spi_probe(struct spi_device *spi)
 
 static const struct adxl345_chip_info adxl345_spi_info = {
 	.name = "adxl345",
-	.type = ADXL345,
+	.uscale = ADXL345_USCALE,
 };
 
 static const struct adxl345_chip_info adxl375_spi_info = {
 	.name = "adxl375",
-	.type = ADXL375,
+	.uscale = ADXL375_USCALE,
 };
 
 static const struct spi_device_id adxl345_spi_id[] = {
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37920790B4D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 11:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbjICJBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 05:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjICJBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 05:01:04 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6218D126;
        Sun,  3 Sep 2023 02:01:00 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,224,1688396400"; 
   d="scan'208";a="174837520"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2023 18:01:00 +0900
Received: from localhost.localdomain (unknown [10.226.92.30])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8674D4189AAA;
        Sun,  3 Sep 2023 18:00:57 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/2] iio: accel: adxl345: Convert enum->pointer for data in match data table
Date:   Sun,  3 Sep 2023 10:00:50 +0100
Message-Id: <20230903090051.39274-2-biju.das.jz@bp.renesas.com>
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

Convert enum->pointer for data in match data table, so that
device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
bus type match support added to it.

Add struct adxl345_chip_info and replace enum->adxl345_chip_info in the
match table and simplify adxl345_probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Replaced struct adxl3x5_chip_info->struct adxl345_chip_info.
v1->v2:
 * Replaced EINVAL->ENODEV for invalid chip type.
 * Kept leading commas for adxl345_*_info and adxl375_*_info.
 * Restored switch statement in adxl345_core_probe() 
---
 drivers/iio/accel/adxl345.h      |  5 +++++
 drivers/iio/accel/adxl345_core.c | 24 ++++++------------------
 drivers/iio/accel/adxl345_i2c.c  | 20 +++++++++++++++-----
 drivers/iio/accel/adxl345_spi.c  | 20 +++++++++++++++-----
 4 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index d7e67cb08538..826e0575ae79 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -13,6 +13,11 @@ enum adxl345_device_type {
 	ADXL375 = 2,
 };
 
+struct adxl345_chip_info {
+	const char *name;
+	unsigned int type;
+};
+
 int adxl345_core_probe(struct device *dev, struct regmap *regmap);
 
 #endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 1919e0089c11..28f77b5de47d 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -61,9 +61,9 @@ static const int adxl345_uscale = 38300;
 static const int adxl375_uscale = 480000;
 
 struct adxl345_data {
+	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
 	u8 data_range;
-	enum adxl345_device_type type;
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -110,7 +110,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-		switch (data->type) {
+		switch (data->info->type) {
 		case ADXL345:
 			*val2 = adxl345_uscale;
 			break;
@@ -222,25 +222,11 @@ static void adxl345_powerdown(void *regmap)
 
 int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 {
-	enum adxl345_device_type type;
 	struct adxl345_data *data;
 	struct iio_dev *indio_dev;
-	const char *name;
 	u32 regval;
 	int ret;
 
-	type = (uintptr_t)device_get_match_data(dev);
-	switch (type) {
-	case ADXL345:
-		name = "adxl345";
-		break;
-	case ADXL375:
-		name = "adxl375";
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Error reading device ID\n");
@@ -255,16 +241,18 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 
 	data = iio_priv(indio_dev);
 	data->regmap = regmap;
-	data->type = type;
 	/* Enable full-resolution mode */
 	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
+	data->info = device_get_match_data(dev);
+	if (!data->info)
+		return -ENODEV;
 
 	ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
 			   data->data_range);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to set data range\n");
 
-	indio_dev->name = name;
+	indio_dev->name = data->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl345_channels;
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index e47d12f19602..8cb6254297f7 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -30,22 +30,32 @@ static int adxl345_i2c_probe(struct i2c_client *client)
 	return adxl345_core_probe(&client->dev, regmap);
 }
 
+static const struct adxl345_chip_info adxl345_i2c_info = {
+	.name = "adxl345",
+	.type = ADXL345,
+};
+
+static const struct adxl345_chip_info adxl375_i2c_info = {
+	.name = "adxl375",
+	.type = ADXL375,
+};
+
 static const struct i2c_device_id adxl345_i2c_id[] = {
-	{ "adxl345", ADXL345 },
-	{ "adxl375", ADXL375 },
+	{ "adxl345", (kernel_ulong_t)&adxl345_i2c_info },
+	{ "adxl375", (kernel_ulong_t)&adxl375_i2c_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
 
 static const struct of_device_id adxl345_of_match[] = {
-	{ .compatible = "adi,adxl345", .data = (const void *)ADXL345 },
-	{ .compatible = "adi,adxl375", .data = (const void *)ADXL375 },
+	{ .compatible = "adi,adxl345", .data = &adxl345_i2c_info },
+	{ .compatible = "adi,adxl375", .data = &adxl375_i2c_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
 
 static const struct acpi_device_id adxl345_acpi_match[] = {
-	{ "ADS0345", ADXL345 },
+	{ "ADS0345", (kernel_ulong_t)&adxl345_i2c_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index aaade5808657..ede9b9496158 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -36,22 +36,32 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	return adxl345_core_probe(&spi->dev, regmap);
 }
 
+static const struct adxl345_chip_info adxl345_spi_info = {
+	.name = "adxl345",
+	.type = ADXL345,
+};
+
+static const struct adxl345_chip_info adxl375_spi_info = {
+	.name = "adxl375",
+	.type = ADXL375,
+};
+
 static const struct spi_device_id adxl345_spi_id[] = {
-	{ "adxl345", ADXL345 },
-	{ "adxl375", ADXL375 },
+	{ "adxl345", (kernel_ulong_t)&adxl345_spi_info },
+	{ "adxl375", (kernel_ulong_t)&adxl375_spi_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adxl345_spi_id);
 
 static const struct of_device_id adxl345_of_match[] = {
-	{ .compatible = "adi,adxl345", .data = (const void *)ADXL345 },
-	{ .compatible = "adi,adxl375", .data = (const void *)ADXL375 },
+	{ .compatible = "adi,adxl345", .data = &adxl345_spi_info },
+	{ .compatible = "adi,adxl375", .data = &adxl375_spi_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
 
 static const struct acpi_device_id adxl345_acpi_match[] = {
-	{ "ADS0345", ADXL345 },
+	{ "ADS0345", (kernel_ulong_t)&adxl345_spi_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);
-- 
2.25.1


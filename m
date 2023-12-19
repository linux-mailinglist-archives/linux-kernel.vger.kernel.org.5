Return-Path: <linux-kernel+bounces-5236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23506818855
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D38A1F21D04
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F078E1945B;
	Tue, 19 Dec 2023 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="vW4XTUNi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92D418C03;
	Tue, 19 Dec 2023 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id A1B5D28B539;
	Tue, 19 Dec 2023 13:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1702990963;
	bh=NbxLpjGkxVofT2sMG+J1g4M0MmpSKIKW2I7a7iUkCcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vW4XTUNiwtzB5WVDq4QXmKpT+l2BAjgJQfIMSr6FF54toyyE3XXYQpZl02Bi8BqNy
	 /YlSENCZ9n3QGbpP0boCu8IixFSoKIazsXrAukkKRXDkykPgl+FZg4SlTg75QaoMlr
	 3fnrMvyGO378WIO34uFKVhVo42OBW1DYOxyozqsc=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 2/2] iio: pressure: change driver for Honeywell MPR series
Date: Tue, 19 Dec 2023 15:02:21 +0200
Message-ID: <20231219130230.32584-3-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231219130230.32584-1-petre.rodan@subdimension.ro>
References: <20231219130230.32584-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ChangeLog
 - rewrite flow so that driver can use either i2c or spi as communication bus
 - add spi driver (tested on MPRLS0015PA0000SA)
 - add pressure-triplet property that automatically sets pmin, pmax
 - fix transfer-function enum typo based on previous review [1]
 - fix interrupt example in binding file (FALLING -> RISING edge)
 - indentation changes based on previous code reviews
 - renamed mpr_read_pressure to mpr_read_conversion since the sensor is
   supposed to also provide temperature measuremets
   (but I think mine is broken since the raw temperature value is always
   0x800000 - so temp reading not currently implemented)

I've been told in the past that the use of mutexes is redundant in these cases
so please assess if the guard() from the driver code is required or should be
removed.

patch uses device_property_match_property_string() from the 'togreg' branch

[1]: https://lore.kernel.org/lkml/20231116-grudge-hankering-b7a71d831b93@squawk/T/
Datasheet:
https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 MAINTAINERS                            |   3 +-
 drivers/iio/pressure/Kconfig           |  14 +-
 drivers/iio/pressure/Makefile          |   2 +
 drivers/iio/pressure/mprls0025pa.c     | 353 ++++++++++++-------------
 drivers/iio/pressure/mprls0025pa.h     | 103 ++++++++
 drivers/iio/pressure/mprls0025pa_i2c.c |  76 ++++++
 drivers/iio/pressure/mprls0025pa_spi.c |  67 +++++
 7 files changed, 439 insertions(+), 179 deletions(-)
 create mode 100644 drivers/iio/pressure/mprls0025pa.h
 create mode 100644 drivers/iio/pressure/mprls0025pa_i2c.c
 create mode 100644 drivers/iio/pressure/mprls0025pa_spi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3029841e92a8..cbb163e1b311 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9725,10 +9725,11 @@ F:	drivers/iio/pressure/hsc030pa*
 
 HONEYWELL MPRLS0025PA PRESSURE SENSOR SERIES IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
+M:	Petre Rodan <petre.rodan@subdimension.ro>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
-F:	drivers/iio/pressure/mprls0025pa.c
+F:	drivers/iio/pressure/mprls0025pa*
 
 HOST AP DRIVER
 L:	linux-wireless@vger.kernel.org
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 79adfd059c3a..5da7931dc537 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -181,7 +181,9 @@ config MPL3115
 
 config MPRLS0025PA
 	tristate "Honeywell MPRLS0025PA (MicroPressure sensors series)"
-	depends on I2C
+	depends on (I2C || SPI_MASTER)
+	select MPRLS0025PA_I2C if I2C
+	select MPRLS0025PA_SPI if SPI_MASTER
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
@@ -192,6 +194,16 @@ config MPRLS0025PA
 	  To compile this driver as a module, choose M here: the module will be
 	  called mprls0025pa.
 
+config MPRLS0025PA_I2C
+	tristate
+	depends on MPRLS0025PA
+	depends on I2C
+
+config MPRLS0025PA_SPI
+	tristate
+	depends on MPRLS0025PA
+	depends on SPI_MASTER
+
 config MS5611
 	tristate "Measurement Specialties MS5611 pressure sensor driver"
 	select IIO_BUFFER
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index b0f8b94662f2..a93709e35760 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -24,6 +24,8 @@ obj-$(CONFIG_MPL115_I2C) += mpl115_i2c.o
 obj-$(CONFIG_MPL115_SPI) += mpl115_spi.o
 obj-$(CONFIG_MPL3115) += mpl3115.o
 obj-$(CONFIG_MPRLS0025PA) += mprls0025pa.o
+obj-$(CONFIG_MPRLS0025PA_I2C) += mprls0025pa_i2c.o
+obj-$(CONFIG_MPRLS0025PA_SPI) += mprls0025pa_spi.o
 obj-$(CONFIG_MS5611) += ms5611_core.o
 obj-$(CONFIG_MS5611_I2C) += ms5611_i2c.o
 obj-$(CONFIG_MS5611_SPI) += ms5611_spi.o
diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 30fb2de36821..4a999bf73964 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -5,17 +5,14 @@
  * Copyright (c) Andreas Klinger <ak@it-klinger.de>
  *
  * Data sheet:
- *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/
- *    products/sensors/pressure-sensors/board-mount-pressure-sensors/
- *    micropressure-mpr-series/documents/
- *    sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
+ *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
  *
- * 7-bit I2C default slave address: 0x18
  */
 
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/i2c.h>
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/math64.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -33,11 +30,7 @@
 
 #include <asm/unaligned.h>
 
-/* bits in i2c status byte */
-#define MPR_I2C_POWER	BIT(6)	/* device is powered */
-#define MPR_I2C_BUSY	BIT(5)	/* device is busy */
-#define MPR_I2C_MEMORY	BIT(2)	/* integrity test passed */
-#define MPR_I2C_MATH	BIT(0)	/* internal math saturation */
+#include "mprls0025pa.h"
 
 /*
  * support _RAW sysfs interface:
@@ -65,73 +58,102 @@
  *                which reduces the offset to (-1 * outputmin)
  */
 
+#define MPR_PRESSURE_MASK GENMASK(23, 0)
+
+struct mpr_func_spec {
+	u32 output_min;
+	u32 output_max;
+};
+
 /*
  * transfer function A: 10%   to 90%   of 2^24
  * transfer function B:  2.5% to 22.5% of 2^24
  * transfer function C: 20%   to 80%   of 2^24
  */
-enum mpr_func_id {
-	MPR_FUNCTION_A,
-	MPR_FUNCTION_B,
-	MPR_FUNCTION_C,
+static const struct mpr_func_spec mpr_func_spec[] = {
+	[MPR_FUNCTION_A] = { .output_min = 1677722, .output_max = 15099494 },
+	[MPR_FUNCTION_B] = { .output_min =  419430, .output_max =  3774874 },
+	[MPR_FUNCTION_C] = { .output_min = 3355443, .output_max = 13421773 },
 };
 
-struct mpr_func_spec {
-	u32			output_min;
-	u32			output_max;
+enum mpr_variants {
+	MPR0001BA = 0x00, MPR01_6BA = 0x01, MPR02_5BA = 0x02, MPR0060MG = 0x03,
+	MPR0100MG = 0x04, MPR0160MG = 0x05, MPR0250MG = 0x06, MPR0400MG = 0x07,
+	MPR0600MG = 0x08, MPR0001BG = 0x09, MPR01_6BG = 0x0a, MPR02_5BG = 0x0b,
+	MPR0100KA = 0x0c, MPR0160KA = 0x0d, MPR0250KA = 0x0e, MPR0006KG = 0x0f,
+	MPR0010KG = 0x10, MPR0016KG = 0x11, MPR0025KG = 0x12, MPR0040KG = 0x13,
+	MPR0060KG = 0x14, MPR0100KG = 0x15, MPR0160KG = 0x16, MPR0250KG = 0x17,
+	MPR0015PA = 0x18, MPR0025PA = 0x19, MPR0030PA = 0x1a, MPR0001PG = 0x1b,
+	MPR0005PG = 0x1c, MPR0015PG = 0x1d, MPR0030PG = 0x1e, MPR0300YG = 0x1f,
+	MPR_VARIANTS_MAX
 };
 
-static const struct mpr_func_spec mpr_func_spec[] = {
-	[MPR_FUNCTION_A] = {.output_min = 1677722, .output_max = 15099494},
-	[MPR_FUNCTION_B] = {.output_min =  419430, .output_max =  3774874},
-	[MPR_FUNCTION_C] = {.output_min = 3355443, .output_max = 13421773},
+static const char * const mpr_triplet_variants[MPR_VARIANTS_MAX] = {
+	[MPR0001BA] = "0001BA", [MPR01_6BA] = "01.6BA", [MPR02_5BA] = "02.5BA",
+	[MPR0060MG] = "0060MG", [MPR0100MG] = "0100MG", [MPR0160MG] = "0160MG",
+	[MPR0250MG] = "0250MG", [MPR0400MG] = "0400MG", [MPR0600MG] = "0600MG",
+	[MPR0001BG] = "0001BG", [MPR01_6BG] = "01.6BG", [MPR02_5BG] = "02.5BG",
+	[MPR0100KA] = "0100KA", [MPR0160KA] = "0160KA", [MPR0250KA] = "0250KA",
+	[MPR0006KG] = "0006KG", [MPR0010KG] = "0010KG", [MPR0016KG] = "0016KG",
+	[MPR0025KG] = "0025KG", [MPR0040KG] = "0040KG", [MPR0060KG] = "0060KG",
+	[MPR0100KG] = "0100KG", [MPR0160KG] = "0160KG", [MPR0250KG] = "0250KG",
+	[MPR0015PA] = "0015PA", [MPR0025PA] = "0025PA", [MPR0030PA] = "0030PA",
+	[MPR0001PG] = "0001PG", [MPR0005PG] = "0005PG", [MPR0015PG] = "0015PG",
+	[MPR0030PG] = "0030PG", [MPR0300YG] = "0300YG"
 };
 
-struct mpr_chan {
-	s32			pres;		/* pressure value */
-	s64			ts;		/* timestamp */
+/**
+ * struct mpr_range_config - list of pressure ranges based on nomenclature
+ * @pmin: lowest pressure that can be measured
+ * @pmax: highest pressure that can be measured
+ */
+struct mpr_range_config {
+	const s32 pmin;
+	const s32 pmax;
 };
 
-struct mpr_data {
-	struct i2c_client	*client;
-	struct mutex		lock;		/*
-						 * access to device during read
-						 */
-	u32			pmin;		/* minimal pressure in pascal */
-	u32			pmax;		/* maximal pressure in pascal */
-	enum mpr_func_id	function;	/* transfer function */
-	u32			outmin;		/*
-						 * minimal numerical range raw
-						 * value from sensor
-						 */
-	u32			outmax;		/*
-						 * maximal numerical range raw
-						 * value from sensor
-						 */
-	int                     scale;          /* int part of scale */
-	int                     scale2;         /* nano part of scale */
-	int                     offset;         /* int part of offset */
-	int                     offset2;        /* nano part of offset */
-	struct gpio_desc	*gpiod_reset;	/* reset */
-	int			irq;		/*
-						 * end of conversion irq;
-						 * used to distinguish between
-						 * irq mode and reading in a
-						 * loop until data is ready
-						 */
-	struct completion	completion;	/* handshake from irq to read */
-	struct mpr_chan		chan;		/*
-						 * channel values for buffered
-						 * mode
-						 */
+/* All min max limits have been converted to pascals */
+static const struct mpr_range_config mpr_range_config[MPR_VARIANTS_MAX] = {
+	[MPR0001BA] = { .pmin = 0, .pmax = 100000 },
+	[MPR01_6BA] = { .pmin = 0, .pmax = 160000 },
+	[MPR02_5BA] = { .pmin = 0, .pmax = 250000 },
+	[MPR0060MG] = { .pmin = 0, .pmax =   6000 },
+	[MPR0100MG] = { .pmin = 0, .pmax =  10000 },
+	[MPR0160MG] = { .pmin = 0, .pmax =  16000 },
+	[MPR0250MG] = { .pmin = 0, .pmax =  25000 },
+	[MPR0400MG] = { .pmin = 0, .pmax =  40000 },
+	[MPR0600MG] = { .pmin = 0, .pmax =  60000 },
+	[MPR0001BG] = { .pmin = 0, .pmax = 100000 },
+	[MPR01_6BG] = { .pmin = 0, .pmax = 160000 },
+	[MPR02_5BG] = { .pmin = 0, .pmax = 250000 },
+	[MPR0100KA] = { .pmin = 0, .pmax = 100000 },
+	[MPR0160KA] = { .pmin = 0, .pmax = 160000 },
+	[MPR0250KA] = { .pmin = 0, .pmax = 250000 },
+	[MPR0006KG] = { .pmin = 0, .pmax =   6000 },
+	[MPR0010KG] = { .pmin = 0, .pmax =  10000 },
+	[MPR0016KG] = { .pmin = 0, .pmax =  16000 },
+	[MPR0025KG] = { .pmin = 0, .pmax =  25000 },
+	[MPR0040KG] = { .pmin = 0, .pmax =  40000 },
+	[MPR0060KG] = { .pmin = 0, .pmax =  60000 },
+	[MPR0100KG] = { .pmin = 0, .pmax = 100000 },
+	[MPR0160KG] = { .pmin = 0, .pmax = 160000 },
+	[MPR0250KG] = { .pmin = 0, .pmax = 250000 },
+	[MPR0015PA] = { .pmin = 0, .pmax = 103421 },
+	[MPR0025PA] = { .pmin = 0, .pmax = 172369 },
+	[MPR0030PA] = { .pmin = 0, .pmax = 206843 },
+	[MPR0001PG] = { .pmin = 0, .pmax =   6895 },
+	[MPR0005PG] = { .pmin = 0, .pmax =  34474 },
+	[MPR0015PG] = { .pmin = 0, .pmax = 103421 },
+	[MPR0030PG] = { .pmin = 0, .pmax = 206843 },
+	[MPR0300YG] = { .pmin = 0, .pmax =  39997 }
 };
 
 static const struct iio_chan_spec mpr_channels[] = {
 	{
 		.type = IIO_PRESSURE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-					BIT(IIO_CHAN_INFO_SCALE) |
-					BIT(IIO_CHAN_INFO_OFFSET),
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 's',
@@ -153,11 +175,8 @@ static void mpr_reset(struct mpr_data *data)
 }
 
 /**
- * mpr_read_pressure() - Read pressure value from sensor via I2C
+ * mpr_read_conversion() - Read pressure value from sensor
  * @data: Pointer to private data struct.
- * @press: Output value read from sensor.
- *
- * Reading from the sensor by sending and receiving I2C telegrams.
  *
  * If there is an end of conversion (EOC) interrupt registered the function
  * waits for a maximum of one second for the interrupt.
@@ -168,27 +187,19 @@ static void mpr_reset(struct mpr_data *data)
  * * -ETIMEDOUT	- Timeout while waiting for the EOC interrupt or busy flag is
  *		  still set after nloops attempts of reading
  */
-static int mpr_read_pressure(struct mpr_data *data, s32 *press)
+static int mpr_read_conversion(struct mpr_data *data)
 {
-	struct device *dev = &data->client->dev;
+	struct device *dev = data->dev;
 	int ret, i;
-	u8 wdata[] = {0xAA, 0x00, 0x00};
-	s32 status;
 	int nloops = 10;
-	u8 buf[4];
 
 	reinit_completion(&data->completion);
 
-	ret = i2c_master_send(data->client, wdata, sizeof(wdata));
+	ret = data->write_cb(data, MPR_CMD_SYNC, MPR_PKT_SYNC_LEN);
 	if (ret < 0) {
 		dev_err(dev, "error while writing ret: %d\n", ret);
 		return ret;
 	}
-	if (ret != sizeof(wdata)) {
-		dev_err(dev, "received size doesn't fit - ret: %d / %u\n", ret,
-							(u32)sizeof(wdata));
-		return -EIO;
-	}
 
 	if (data->irq > 0) {
 		ret = wait_for_completion_timeout(&data->completion, HZ);
@@ -206,14 +217,14 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
 			 *     quite long
 			 */
 			usleep_range(5000, 10000);
-			status = i2c_smbus_read_byte(data->client);
-			if (status < 0) {
+			ret = data->read_cb(data, MPR_CMD_NOP, 1);
+			if (ret < 0) {
 				dev_err(dev,
 					"error while reading, status: %d\n",
-					status);
-				return status;
+					ret);
+				return ret;
 			}
-			if (!(status & MPR_I2C_BUSY))
+			if (data->buffer[0] == MPR_I2C_POWER)
 				break;
 		}
 		if (i == nloops) {
@@ -222,30 +233,16 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
 		}
 	}
 
-	ret = i2c_master_recv(data->client, buf, sizeof(buf));
-	if (ret < 0) {
-		dev_err(dev, "error in i2c_master_recv ret: %d\n", ret);
+	ret = data->read_cb(data, MPR_CMD_NOP, MPR_PKT_NOP_LEN);
+	if (ret < 0)
 		return ret;
-	}
-	if (ret != sizeof(buf)) {
-		dev_err(dev, "received size doesn't fit - ret: %d / %u\n", ret,
-							(u32)sizeof(buf));
-		return -EIO;
-	}
 
-	if (buf[0] & MPR_I2C_BUSY) {
-		/*
-		 * it should never be the case that status still indicates
-		 * business
-		 */
-		dev_err(dev, "data still not ready: %08x\n", buf[0]);
+	if (data->buffer[0] != MPR_I2C_POWER) {
+		dev_err(data->dev,
+			"unexpected status byte %02x\n", data->buffer[0]);
 		return -ETIMEDOUT;
 	}
 
-	*press = get_unaligned_be24(&buf[1]);
-
-	dev_dbg(dev, "received: %*ph cnt: %d\n", ret, buf, *press);
-
 	return 0;
 }
 
@@ -261,20 +258,22 @@ static irqreturn_t mpr_eoc_handler(int irq, void *p)
 static irqreturn_t mpr_trigger_handler(int irq, void *p)
 {
 	int ret;
+	u32 recvd;
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct mpr_data *data = iio_priv(indio_dev);
 
-	mutex_lock(&data->lock);
-	ret = mpr_read_pressure(data, &data->chan.pres);
+	guard(mutex)(&data->lock);
+	ret = mpr_read_conversion(data);
 	if (ret < 0)
 		goto err;
 
+	recvd = get_unaligned_be32(data->buffer);
+	data->chan.pres = FIELD_GET(MPR_PRESSURE_MASK, recvd);
 	iio_push_to_buffers_with_timestamp(indio_dev, &data->chan,
-						iio_get_time_ns(indio_dev));
+					   iio_get_time_ns(indio_dev));
 
 err:
-	mutex_unlock(&data->lock);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
@@ -284,28 +283,28 @@ static int mpr_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
 	int ret;
-	s32 pressure;
 	struct mpr_data *data = iio_priv(indio_dev);
+	u32 recvd;
 
 	if (chan->type != IIO_PRESSURE)
 		return -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&data->lock);
-		ret = mpr_read_pressure(data, &pressure);
-		mutex_unlock(&data->lock);
+		ret = mpr_read_conversion(data);
 		if (ret < 0)
 			return ret;
-		*val = pressure;
+
+		recvd = get_unaligned_be32(data->buffer);
+		*val = FIELD_GET(MPR_PRESSURE_MASK, recvd);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = data->scale;
-		*val2 = data->scale2;
+		*val2 = data->scale_dec;
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = data->offset;
-		*val2 = data->offset2;
+		*val2 = data->offset_dec;
 		return IIO_VAL_INT_PLUS_NANO;
 	default:
 		return -EINVAL;
@@ -316,25 +315,25 @@ static const struct iio_info mpr_info = {
 	.read_raw = &mpr_read_raw,
 };
 
-static int mpr_probe(struct i2c_client *client)
+int mpr_common_probe(struct device *dev, mpr_xfer_fn read, mpr_xfer_fn write,
+		     int irq)
 {
 	int ret;
 	struct mpr_data *data;
 	struct iio_dev *indio_dev;
-	struct device *dev = &client->dev;
+	const char *triplet;
 	s64 scale, offset;
-
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BYTE))
-		return dev_err_probe(dev, -EOPNOTSUPP,
-					"I2C functionality not supported\n");
+	u32 func;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
-		return dev_err_probe(dev, -ENOMEM, "couldn't get iio_dev\n");
+		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-	data->client = client;
-	data->irq = client->irq;
+	data->dev = dev;
+	data->read_cb = read;
+	data->write_cb = write;
+	data->irq = irq;
 
 	mutex_init(&data->lock);
 	init_completion(&data->completion);
@@ -345,64 +344,85 @@ static int mpr_probe(struct i2c_client *client)
 	indio_dev->num_channels = ARRAY_SIZE(mpr_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = devm_regulator_get_enable(dev, "vdd");
+#ifdef TESTING_NOT_PART_OF_PRODUCTION_VERSION
+	/* when loaded as i2c device we need to use default values */
+	dev_notice(dev, "firmware node not found; using defaults\n");
+	data->pmin = 0;
+	data->pmax = 172369; /* 25 psi */
+	data->function = MPR_FUNCTION_A;
+#else
+	ret = device_property_read_u32(dev,
+			       "honeywell,transfer-function", &func);
 	if (ret)
 		return dev_err_probe(dev, ret,
-				"can't get and enable vdd supply\n");
+			    "honeywell,transfer-function could not be read\n");
+	data->function = func - 1;
+	if (data->function > MPR_FUNCTION_C)
+		return dev_err_probe(dev, -EINVAL,
+				     "honeywell,transfer-function %d invalid\n",
+				     data->function);
+
+	ret = device_property_read_string(dev, "honeywell,pressure-triplet",
+					  &triplet);
+	if (ret)
+		return dev_err_probe(dev, ret,
+			     "honeywell,pressure-triplet could not be read\n");
 
-	if (dev_fwnode(dev)) {
+	if (str_has_prefix(triplet, "NA")) {
 		ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
-								&data->pmin);
+					       &data->pmin);
 		if (ret)
 			return dev_err_probe(dev, ret,
-				"honeywell,pmin-pascal could not be read\n");
+				  "honeywell,pmin-pascal could not be read\n");
+
 		ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
-								&data->pmax);
-		if (ret)
-			return dev_err_probe(dev, ret,
-				"honeywell,pmax-pascal could not be read\n");
-		ret = device_property_read_u32(dev,
-				"honeywell,transfer-function", &data->function);
+					       &data->pmax);
 		if (ret)
 			return dev_err_probe(dev, ret,
-				"honeywell,transfer-function could not be read\n");
-		if (data->function > MPR_FUNCTION_C)
-			return dev_err_probe(dev, -EINVAL,
-				"honeywell,transfer-function %d invalid\n",
-								data->function);
+				  "honeywell,pmax-pascal could not be read\n");
 	} else {
-		/* when loaded as i2c device we need to use default values */
-		dev_notice(dev, "firmware node not found; using defaults\n");
-		data->pmin = 0;
-		data->pmax = 172369; /* 25 psi */
-		data->function = MPR_FUNCTION_A;
+		ret = device_property_match_property_string(dev,
+						  "honeywell,pressure-triplet",
+						  mpr_triplet_variants,
+						  MPR_VARIANTS_MAX);
+		if (ret < 0)
+			return dev_err_probe(dev, -EINVAL,
+				    "honeywell,pressure-triplet is invalid\n");
+
+		data->pmin = mpr_range_config[ret].pmin;
+		data->pmax = mpr_range_config[ret].pmax;
 	}
+#endif
+
+	if (data->pmin >= data->pmax)
+		return dev_err_probe(dev, -EINVAL,
+				     "pressure limits are invalid\n");
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "can't get vdd supply\n");
 
 	data->outmin = mpr_func_spec[data->function].output_min;
 	data->outmax = mpr_func_spec[data->function].output_max;
 
 	/* use 64 bit calculation for preserving a reasonable precision */
 	scale = div_s64(((s64)(data->pmax - data->pmin)) * NANO,
-						data->outmax - data->outmin);
-	data->scale = div_s64_rem(scale, NANO, &data->scale2);
-	/*
-	 * multiply with NANO before dividing by scale and later divide by NANO
-	 * again.
-	 */
+			data->outmax - data->outmin);
+	data->scale = div_s64_rem(scale, NANO, &data->scale_dec);
 	offset = ((-1LL) * (s64)data->outmin) * NANO -
-			div_s64(div_s64((s64)data->pmin * NANO, scale), NANO);
-	data->offset = div_s64_rem(offset, NANO, &data->offset2);
+		 div_s64(div_s64((s64)data->pmin * NANO, scale), NANO);
+	data->offset = div_s64_rem(offset, NANO, &data->offset_dec);
 
 	if (data->irq > 0) {
 		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
-				IRQF_TRIGGER_RISING, client->name, data);
+				IRQF_TRIGGER_RISING, dev_name(dev), data);
 		if (ret)
 			return dev_err_probe(dev, ret,
 				"request irq %d failed\n", data->irq);
 	}
 
 	data->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
-							GPIOD_OUT_HIGH);
+						    GPIOD_OUT_HIGH);
 	if (IS_ERR(data->gpiod_reset))
 		return dev_err_probe(dev, PTR_ERR(data->gpiod_reset),
 						"request reset-gpio failed\n");
@@ -410,41 +430,20 @@ static int mpr_probe(struct i2c_client *client)
 	mpr_reset(data);
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
-						mpr_trigger_handler, NULL);
+					      mpr_trigger_handler, NULL);
 	if (ret)
 		return dev_err_probe(dev, ret,
-					"iio triggered buffer setup failed\n");
+				     "iio triggered buffer setup failed\n");
 
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		return dev_err_probe(dev, ret,
-					"unable to register iio device\n");
+				     "unable to register iio device\n");
 
 	return 0;
 }
-
-static const struct of_device_id mpr_matches[] = {
-	{ .compatible = "honeywell,mprls0025pa" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, mpr_matches);
-
-static const struct i2c_device_id mpr_id[] = {
-	{ "mprls0025pa" },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, mpr_id);
-
-static struct i2c_driver mpr_driver = {
-	.probe		= mpr_probe,
-	.id_table	= mpr_id,
-	.driver		= {
-		.name		= "mprls0025pa",
-		.of_match_table = mpr_matches,
-	},
-};
-module_i2c_driver(mpr_driver);
+EXPORT_SYMBOL_NS(mpr_common_probe, IIO_HONEYWELL_MPRLS0025PA);
 
 MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
-MODULE_DESCRIPTION("Honeywell MPRLS0025PA I2C driver");
+MODULE_DESCRIPTION("Honeywell MPR pressure sensor core driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
new file mode 100644
index 000000000000..b47fc26a309d
--- /dev/null
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MPRLS0025PA - Honeywell MicroPressure pressure sensor series driver
+ *
+ * Copyright (c) Andreas Klinger <ak@it-klinger.de>
+ *
+ * Data sheet:
+ *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
+ */
+
+#ifndef _MPRLS0025PA_H
+#define _MPRLS0025PA_H
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+
+#define MPR_MEASUREMENT_RD_SIZE 4
+#define MPR_CMD_NOP      0xf0
+#define MPR_CMD_SYNC     0xaa
+#define MPR_PKT_NOP_LEN  MPR_MEASUREMENT_RD_SIZE
+#define MPR_PKT_SYNC_LEN 3
+
+/* bits in i2c status byte */
+#define MPR_I2C_POWER	BIT(6)	/* device is powered */
+#define MPR_I2C_BUSY	BIT(5)	/* device is busy */
+#define MPR_I2C_MEMORY	BIT(2)	/* integrity test passed */
+#define MPR_I2C_MATH	BIT(0)	/* internal math saturation */
+
+struct device;
+
+struct iio_chan_spec;
+struct iio_dev;
+
+struct mpr_data;
+
+typedef int (*mpr_xfer_fn)(struct mpr_data *, const u8, const u8);
+
+enum mpr_func_id {
+	MPR_FUNCTION_A,
+	MPR_FUNCTION_B,
+	MPR_FUNCTION_C,
+};
+
+/**
+ * struct mpr_chan
+ * @pres: pressure value
+ * @ts: timestamp
+ */
+struct mpr_chan {
+	s32 pres;
+	s64 ts;
+};
+
+/**
+ * struct mpr_data
+ * @dev: current device structure
+ * @read_cb: function that implements the sensor reads
+ * @write_cb: function that implements the sensor writes
+ * @pmin: minimal pressure in pascal
+ * @pmax: maximal pressure in pascal
+ * @function: transfer function
+ * @outmin: minimum raw pressure in counts (based on transfer function)
+ * @outmax: maximum raw pressure in counts (based on transfer function)
+ * @scale: pressure scale
+ * @scale2: pressure scale, decimal places
+ * @offset: pressure offset
+ * @offset2: pressure offset, decimal places
+ * @gpiod_reset: reset
+ * @irq: end of conversion irq. used to distinguish between irq mode and
+ *       reading in a loop until data is ready
+ * @completion: handshake from irq to read
+ * @chan: channel values for buffered mode
+ * @buffer: raw conversion data
+ */
+struct mpr_data {
+	struct device		*dev;
+	mpr_xfer_fn		read_cb;
+	mpr_xfer_fn		write_cb;
+	struct mutex		lock;
+	u32			pmin;
+	u32			pmax;
+	enum mpr_func_id	function;
+	u32			outmin;
+	u32			outmax;
+	int			scale;
+	int			scale_dec;
+	int			offset;
+	int			offset_dec;
+	struct gpio_desc	*gpiod_reset;
+	int			irq;
+	struct completion	completion;
+	struct mpr_chan		chan;
+	u8			buffer[MPR_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
+};
+
+int mpr_common_probe(struct device *dev, mpr_xfer_fn read, mpr_xfer_fn write,
+		     int irq);
+
+#endif
diff --git a/drivers/iio/pressure/mprls0025pa_i2c.c b/drivers/iio/pressure/mprls0025pa_i2c.c
new file mode 100644
index 000000000000..2651f1e1bc08
--- /dev/null
+++ b/drivers/iio/pressure/mprls0025pa_i2c.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MPRLS0025PA - Honeywell MicroPressure pressure sensor series driver
+ *
+ * Copyright (c) Andreas Klinger <ak@it-klinger.de>
+ *
+ * Data sheet:
+ *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
+ */
+
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+
+#include "mprls0025pa.h"
+
+static int mpr_i2c_read(struct mpr_data *data, const u8 unused, const u8 pkt_len)
+{
+	struct i2c_client *client = to_i2c_client(data->dev);
+
+	if (pkt_len > MPR_MEASUREMENT_RD_SIZE)
+		return -EOVERFLOW;
+
+	memset(data->buffer, 0, MPR_MEASUREMENT_RD_SIZE);
+	return i2c_master_recv(client, data->buffer, pkt_len);
+}
+
+static int mpr_i2c_write(struct mpr_data *data, const u8 cmd, const u8 unused)
+{
+	struct i2c_client *client = to_i2c_client(data->dev);
+	u8 wdata[MPR_PKT_SYNC_LEN];
+
+	memset(wdata, 0, sizeof(wdata));
+	wdata[0] = cmd;
+
+	return i2c_master_send(client, wdata, MPR_PKT_SYNC_LEN);
+}
+
+static int mpr_i2c_probe(struct i2c_client *client)
+{
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BYTE))
+		return -EOPNOTSUPP;
+
+	return mpr_common_probe(&client->dev, mpr_i2c_read, mpr_i2c_write,
+				client->irq);
+}
+
+static const struct of_device_id mpr_i2c_match[] = {
+	{ .compatible = "honeywell,mprls0025pa" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mpr_i2c_match);
+
+static const struct i2c_device_id mpr_i2c_id[] = {
+	{ "mprls0025pa" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mpr_i2c_id);
+
+static struct i2c_driver mpr_i2c_driver = {
+	.probe = mpr_i2c_probe,
+	.id_table = mpr_i2c_id,
+	.driver = {
+		.name = "mprls0025pa",
+		.of_match_table = mpr_i2c_match,
+	},
+};
+module_i2c_driver(mpr_i2c_driver);
+
+MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
+MODULE_DESCRIPTION("Honeywell MPR pressure sensor i2c driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_HONEYWELL_MPRLS0025PA);
diff --git a/drivers/iio/pressure/mprls0025pa_spi.c b/drivers/iio/pressure/mprls0025pa_spi.c
new file mode 100644
index 000000000000..41cd4bad02f7
--- /dev/null
+++ b/drivers/iio/pressure/mprls0025pa_spi.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MPRLS0025PA - Honeywell MicroPressure MPR series SPI sensor driver
+ *
+ * Copyright (c) 2024 Petre Rodan <petre.rodan@subdimension.ro>
+ *
+ * Data sheet:
+ *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/stddef.h>
+
+#include <linux/iio/iio.h>
+
+#include "mprls0025pa.h"
+
+static int mpr_spi_xfer(struct mpr_data *data, const u8 cmd, const u8 pkt_len)
+{
+	struct spi_device *spi = to_spi_device(data->dev);
+	u8 tx_buf[MPR_MEASUREMENT_RD_SIZE];
+	struct spi_transfer xfer;
+
+	if (pkt_len > MPR_MEASUREMENT_RD_SIZE)
+		return -EOVERFLOW;
+
+	tx_buf[0] = cmd;
+	xfer.tx_buf = tx_buf;
+	xfer.rx_buf = data->buffer;
+	xfer.len = pkt_len;
+
+	return spi_sync_transfer(spi, &xfer, 1);
+}
+
+static int mpr_spi_probe(struct spi_device *spi)
+{
+	return mpr_common_probe(&spi->dev, mpr_spi_xfer, mpr_spi_xfer, spi->irq);
+}
+
+static const struct of_device_id mpr_spi_match[] = {
+	{ .compatible = "honeywell,mprls0025pa" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mpr_spi_match);
+
+static const struct spi_device_id mpr_spi_id[] = {
+	{ "mprls0025pa" },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, mpr_spi_id);
+
+static struct spi_driver mpr_spi_driver = {
+	.driver = {
+		.name = "mprls0025pa",
+		.of_match_table = mpr_spi_match,
+	},
+	.probe = mpr_spi_probe,
+	.id_table = mpr_spi_id,
+};
+module_spi_driver(mpr_spi_driver);
+
+MODULE_AUTHOR("Petre Rodan <petre.rodan@subdimension.ro>");
+MODULE_DESCRIPTION("Honeywell MPR pressure sensor spi driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_HONEYWELL_MPRLS0025PA);
-- 
2.41.0



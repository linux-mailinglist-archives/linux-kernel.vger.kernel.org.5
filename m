Return-Path: <linux-kernel+bounces-10728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1539E81DAF7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC97282074
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54CE107A0;
	Sun, 24 Dec 2023 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="ok3lCv1n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9692CA6F;
	Sun, 24 Dec 2023 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id C0B6D28B595;
	Sun, 24 Dec 2023 14:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703428513;
	bh=cqOZFfGH+zbpKFTmFEpDpsmCmNKgk5D3iCAR6d0d/ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ok3lCv1nGTo9OpjeLOxUbVpjAqwoUhUdt/s6WF0FGrwa7HhFtzodH4ZBxcGG7zLPD
	 7BhRjR8o78+V8sn+Ab0Eb2C7IfmCZEu8bgTHlogPODMkIIk0btO3CzsOjELSs4NTLr
	 XvHGbHGdIe6jbFXRnmoHh/69AwQfCDb8HDwMWGQ8=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: [PATCH v2 08/10] iio: pressure: mprls0025pa.c refactor
Date: Sun, 24 Dec 2023 16:34:53 +0200
Message-ID: <20231224143500.10940-9-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231224143500.10940-1-petre.rodan@subdimension.ro>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor driver by splitting the code into core and i2c.

Seemingly redundant read/write function parameters are required for
compatibility with the SPI driver.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 MAINTAINERS                            |   3 +-
 drivers/iio/pressure/Kconfig           |   6 +
 drivers/iio/pressure/Makefile          |   1 +
 drivers/iio/pressure/mprls0025pa.c     | 203 ++++++++-----------------
 drivers/iio/pressure/mprls0025pa.h     | 100 ++++++++++++
 drivers/iio/pressure/mprls0025pa_i2c.c |  98 ++++++++++++
 6 files changed, 267 insertions(+), 144 deletions(-)
 create mode 100644 drivers/iio/pressure/mprls0025pa.h
 create mode 100644 drivers/iio/pressure/mprls0025pa_i2c.c

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
index 79adfd059c3a..f03007cfec85 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -182,6 +182,7 @@ config MPL3115
 config MPRLS0025PA
 	tristate "Honeywell MPRLS0025PA (MicroPressure sensors series)"
 	depends on I2C
+	select MPRLS0025PA_I2C if I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
@@ -192,6 +193,11 @@ config MPRLS0025PA
 	  To compile this driver as a module, choose M here: the module will be
 	  called mprls0025pa.

+config MPRLS0025PA_I2C
+	tristate
+	depends on MPRLS0025PA
+	depends on I2C
+
 config MS5611
 	tristate "Measurement Specialties MS5611 pressure sensor driver"
 	select IIO_BUFFER
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index b0f8b94662f2..7754135e190c 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_MPL115_I2C) += mpl115_i2c.o
 obj-$(CONFIG_MPL115_SPI) += mpl115_spi.o
 obj-$(CONFIG_MPL3115) += mpl3115.o
 obj-$(CONFIG_MPRLS0025PA) += mprls0025pa.o
+obj-$(CONFIG_MPRLS0025PA_I2C) += mprls0025pa_i2c.o
 obj-$(CONFIG_MS5611) += ms5611_core.o
 obj-$(CONFIG_MS5611_I2C) += ms5611_i2c.o
 obj-$(CONFIG_MS5611_SPI) += ms5611_spi.o
diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index e14cdee7989f..cb5d6c0cca7e 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -7,12 +7,11 @@
  * Data sheet:
  *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
  *
- * 7-bit I2C default slave address: 0x18
  */

-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/i2c.h>
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/math64.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -30,13 +29,15 @@

 #include <asm/unaligned.h>

-/* bits in i2c status byte */
-#define MPR_I2C_POWER	BIT(6)	/* device is powered */
-#define MPR_I2C_BUSY	BIT(5)	/* device is busy */
-#define MPR_I2C_MEMORY	BIT(2)	/* integrity test passed */
-#define MPR_I2C_MATH	BIT(0)	/* internal math saturation */
+#include "mprls0025pa.h"

-#define MPR_I2C_ERR_FLAG  (MPR_I2C_BUSY | MPR_I2C_MEMORY | MPR_I2C_MATH)
+/* bits in status byte */
+#define MPR_ST_POWER  BIT(6) /* device is powered */
+#define MPR_ST_BUSY   BIT(5) /* device is busy */
+#define MPR_ST_MEMORY BIT(2) /* integrity test passed */
+#define MPR_ST_MATH   BIT(0) /* internal math saturation */
+
+#define MPR_ST_ERR_FLAG  (MPR_ST_BUSY | MPR_ST_MEMORY | MPR_ST_MATH)

 /*
  * support _RAW sysfs interface:
@@ -69,12 +70,6 @@
  * transfer function B:  2.5% to 22.5% of 2^24
  * transfer function C: 20%   to 80%   of 2^24
  */
-enum mpr_func_id {
-	MPR_FUNCTION_A,
-	MPR_FUNCTION_B,
-	MPR_FUNCTION_C,
-};
-
 struct mpr_func_spec {
 	u32			output_min;
 	u32			output_max;
@@ -86,45 +81,6 @@ static const struct mpr_func_spec mpr_func_spec[] = {
 	[MPR_FUNCTION_C] = { .output_min = 3355443, .output_max = 13421773 },
 };

-struct mpr_chan {
-	s32			pres;		/* pressure value */
-	s64			ts;		/* timestamp */
-};
-
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
-};
-
 static const struct iio_chan_spec mpr_channels[] = {
 	{
 		.type = IIO_PRESSURE,
@@ -152,11 +108,11 @@ static void mpr_reset(struct mpr_data *data)
 }

 /**
- * mpr_read_pressure() - Read pressure value from sensor via I2C
+ * mpr_read_pressure() - Read pressure value from sensor
  * @data: Pointer to private data struct.
  * @press: Output value read from sensor.
  *
- * Reading from the sensor by sending and receiving I2C telegrams.
+ * Reading from the sensor by sending and receiving telegrams.
  *
  * If there is an end of conversion (EOC) interrupt registered the function
  * waits for a maximum of one second for the interrupt.
@@ -169,25 +125,17 @@ static void mpr_reset(struct mpr_data *data)
  */
 static int mpr_read_pressure(struct mpr_data *data, s32 *press)
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
+	ret = data->ops->write(data, MPR_CMD_SYNC, MPR_PKT_SYNC_LEN);
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
@@ -205,14 +153,14 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
 			 *     quite long
 			 */
 			usleep_range(5000, 10000);
-			status = i2c_smbus_read_byte(data->client);
-			if (status < 0) {
+			ret = data->ops->read(data, MPR_CMD_NOP, 1);
+			if (ret < 0) {
 				dev_err(dev,
 					"error while reading, status: %d\n",
-					status);
-				return status;
+					ret);
+				return ret;
 			}
-			if (!(status & MPR_I2C_ERR_FLAG))
+			if (!(data->buffer[0] & MPR_ST_ERR_FLAG))
 				break;
 		}
 		if (i == nloops) {
@@ -221,29 +169,19 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
 		}
 	}

-	ret = i2c_master_recv(data->client, buf, sizeof(buf));
-	if (ret < 0) {
-		dev_err(dev, "error in i2c_master_recv ret: %d\n", ret);
+	ret = data->ops->read(data, MPR_CMD_NOP, MPR_PKT_NOP_LEN);
+	if (ret < 0)
 		return ret;
-	}
-	if (ret != sizeof(buf)) {
-		dev_err(dev, "received size doesn't fit - ret: %d / %u\n", ret,
-							(u32)sizeof(buf));
-		return -EIO;
-	}

-	if (buf[0] & MPR_I2C_ERR_FLAG) {
-		/*
-		 * it should never be the case that status still indicates
-		 * business
-		 */
-		dev_err(dev, "data still not ready: %08x\n", buf[0]);
+	if (data->buffer[0] & MPR_ST_ERR_FLAG) {
+		dev_err(data->dev,
+			"unexpected status byte %02x\n", data->buffer[0]);
 		return -ETIMEDOUT;
 	}

-	*press = get_unaligned_be24(&buf[1]);
+	*press = get_unaligned_be24(&data->buffer[1]);

-	dev_dbg(dev, "received: %*ph cnt: %d\n", ret, buf, *press);
+	dev_dbg(dev, "received: %*ph cnt: %d\n", ret, data->buffer, *press);

 	return 0;
 }
@@ -315,26 +253,22 @@ static const struct iio_info mpr_info = {
 	.read_raw = &mpr_read_raw,
 };

-static int mpr_probe(struct i2c_client *client)
+int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
 {
 	int ret;
 	struct mpr_data *data;
 	struct iio_dev *indio_dev;
-	struct device *dev = &client->dev;
 	s64 scale, offset;
 	u32 func;

-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BYTE))
-		return dev_err_probe(dev, -EOPNOTSUPP,
-					"I2C functionality not supported\n");
-
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
-		return dev_err_probe(dev, -ENOMEM, "couldn't get iio_dev\n");
+		return -ENOMEM;

 	data = iio_priv(indio_dev);
-	data->client = client;
-	data->irq = client->irq;
+	data->dev = dev;
+	data->ops = ops;
+	data->irq = irq;

 	mutex_init(&data->lock);
 	init_completion(&data->completion);
@@ -350,32 +284,36 @@ static int mpr_probe(struct i2c_client *client)
 		return dev_err_probe(dev, ret,
 				"can't get and enable vdd supply\n");

-	if (dev_fwnode(dev)) {
-		ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
+	ret = data->ops->init(data->dev);
+	if (ret)
+		return ret;
+
+	ret = device_property_read_u32(dev,
+				       "honeywell,transfer-function", &func);
+	if (ret)
+		return dev_err_probe(dev, ret,
+			     "honeywell,transfer-function could not be read\n");
+	data->function = func - 1;
+	if (data->function > MPR_FUNCTION_C)
+		return dev_err_probe(dev, -EINVAL,
+				     "honeywell,transfer-function %d invalid\n",
+				     data->function);
+
+	ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
 					       &data->pmin);
-		if (ret)
-			return dev_err_probe(dev, ret,
+	if (ret)
+		return dev_err_probe(dev, ret,
 				   "honeywell,pmin-pascal could not be read\n");

-		ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
-					       &data->pmax);
-		if (ret)
-			return dev_err_probe(dev, ret,
+	ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
+				       &data->pmax);
+	if (ret)
+		return dev_err_probe(dev, ret,
 				   "honeywell,pmax-pascal could not be read\n");
-		ret = device_property_read_u32(dev,
-				"honeywell,transfer-function", &func);
-		if (ret)
-			return dev_err_probe(dev, ret,
-				"honeywell,transfer-function could not be read\n");
-		data->function = func - 1;
-		if (data->function > MPR_FUNCTION_C)
-			return dev_err_probe(dev, -EINVAL,
-				"honeywell,transfer-function %d invalid\n",
-								data->function);
-	} else {
+
+	if (data->pmin >= data->pmax)
 		return dev_err_probe(dev, -EINVAL,
-				  "driver needs to be initialized in the dt\n");
-	}
+				     "pressure limits are invalid\n");

 	data->outmin = mpr_func_spec[data->function].output_min;
 	data->outmax = mpr_func_spec[data->function].output_max;
@@ -394,7 +332,7 @@ static int mpr_probe(struct i2c_client *client)

 	if (data->irq > 0) {
 		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
-				IRQF_TRIGGER_RISING, client->name, data);
+				      IRQF_TRIGGER_RISING, dev_name(dev), data);
 		if (ret)
 			return dev_err_probe(dev, ret,
 					  "request irq %d failed\n", data->irq);
@@ -421,29 +359,8 @@ static int mpr_probe(struct i2c_client *client)

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
index 000000000000..7d7bd21bda95
--- /dev/null
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -0,0 +1,100 @@
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
+struct device;
+
+struct iio_chan_spec;
+struct iio_dev;
+
+struct mpr_data;
+struct mpr_ops;
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
+enum mpr_func_id {
+	MPR_FUNCTION_A,
+	MPR_FUNCTION_B,
+	MPR_FUNCTION_C,
+};
+
+/**
+ * struct mpr_data
+ * @dev: current device structure
+ * @ops: functions that implement the sensor reads/writes, bus init
+ * @lock: access to device during read
+ * @pmin: minimal pressure in pascal
+ * @pmax: maximal pressure in pascal
+ * @function: transfer function
+ * @outmin: minimum raw pressure in counts (based on transfer function)
+ * @outmax: maximum raw pressure in counts (based on transfer function)
+ * @scale: pressure scale
+ * @scale2: pressure scale, decimal number
+ * @offset: pressure offset
+ * @offset2: pressure offset, decimal number
+ * @gpiod_reset: reset
+ * @irq: end of conversion irq. used to distinguish between irq mode and
+ *       reading in a loop until data is ready
+ * @completion: handshake from irq to read
+ * @chan: channel values for buffered mode
+ * @buffer: raw conversion data
+ */
+struct mpr_data {
+	struct device		*dev;
+	const struct mpr_ops	*ops;
+	struct mutex		lock;
+	u32			pmin;
+	u32			pmax;
+	enum mpr_func_id	function;
+	u32			outmin;
+	u32			outmax;
+	int			scale;
+	int			scale2;
+	int			offset;
+	int			offset2;
+	struct gpio_desc	*gpiod_reset;
+	int			irq;
+	struct completion	completion;
+	struct mpr_chan		chan;
+	u8	    buffer[MPR_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
+};
+
+struct mpr_ops {
+	int (*init)(struct device *);
+	int (*read)(struct mpr_data *, const u8, const u8);
+	int (*write)(struct mpr_data *, const u8, const u8);
+};
+
+int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq);
+
+#endif
diff --git a/drivers/iio/pressure/mprls0025pa_i2c.c b/drivers/iio/pressure/mprls0025pa_i2c.c
new file mode 100644
index 000000000000..89d6a206192b
--- /dev/null
+++ b/drivers/iio/pressure/mprls0025pa_i2c.c
@@ -0,0 +1,98 @@
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
+static int mpr_i2c_init(struct device *unused)
+{
+	return 0;
+}
+
+static int mpr_i2c_read(struct mpr_data *data, const u8 unused, const u8 cnt)
+{
+	int ret;
+	struct i2c_client *client = to_i2c_client(data->dev);
+
+	if (cnt > MPR_MEASUREMENT_RD_SIZE)
+		return -EOVERFLOW;
+
+	memset(data->buffer, 0, MPR_MEASUREMENT_RD_SIZE);
+	ret = i2c_master_recv(client, data->buffer, cnt);
+	if (ret != cnt) {
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int mpr_i2c_write(struct mpr_data *data, const u8 cmd, const u8 unused)
+{
+	int ret;
+	struct i2c_client *client = to_i2c_client(data->dev);
+	u8 wdata[MPR_PKT_SYNC_LEN];
+
+	memset(wdata, 0, sizeof(wdata));
+	wdata[0] = cmd;
+
+	ret = i2c_master_send(client, wdata, MPR_PKT_SYNC_LEN);
+	if (ret != MPR_PKT_SYNC_LEN) {
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static const struct mpr_ops mpr_i2c_ops = {
+	.init = mpr_i2c_init,
+	.read = mpr_i2c_read,
+	.write = mpr_i2c_write,
+};
+
+static int mpr_i2c_probe(struct i2c_client *client)
+{
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BYTE))
+		return -EOPNOTSUPP;
+
+	return mpr_common_probe(&client->dev, &mpr_i2c_ops, client->irq);
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
--
2.41.0



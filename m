Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B71D7F922C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjKZK1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZK1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:27:34 -0500
Received: from mail.subdimension.ro (unknown [IPv6:2a01:7e01:e001:1d1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2802FD;
        Sun, 26 Nov 2023 02:27:37 -0800 (PST)
Received: from localhost.localdomain (unknown [188.24.94.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.subdimension.ro (Postfix) with ESMTPSA id 678FD28EE6F;
        Sun, 26 Nov 2023 10:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
        s=skycaves; t=1700994455;
        bh=80Gkmf/ukTSGwxZXNn9U/hL8mTCZF9vVG6DtWIoo2YM=;
        h=From:To:Cc:Subject:Date;
        b=aOapstxAki0c7uCgVTbX9to+UoBQgptEwGS8fWJvoQVeArVC4WK40jW0x1dDfcc65
         lFBptIZjGgTx4W8hePtnGsrSIBIq4PCCcICOg4FppQaVDCcFjY+LxvTlORGv0Ta3Gb
         E58oWv0kiMSBcI3nENqsWrIJsRSl8k6H72NjiUNs=
From:   Petre Rodan <petre.rodan@subdimension.ro>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Petre Rodan <petre.rodan@subdimension.ro>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v3 2/2] iio: pressure: driver for Honeywell HSC/SSC series pressure sensors
Date:   Sun, 26 Nov 2023 12:27:17 +0200
Message-ID: <20231126102721.15322-1-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds driver for digital Honeywell TruStability HSC and SSC series
pressure and temperature sensors. 
Communication is one way. The sensor only requires 4 bytes worth of
clock signals on both i2c and spi in order to push the data out.
The i2c address is hardcoded and depends on the part number.
There is no additional GPIO control.

Datasheet:
https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf [HSC]
Datasheet:
https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf [SSC]
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
V2: - No change
V3: - huge cleanup based on Andy's review. Thanks!
    - fixed pressure offset calculation for differential sensors
    - rename driver from honeywell,hsc to honeywell,hsc030pa
    - main probe() now uses strncmp for case-insensitive mathing
      can't use match_string() because I ain't planning on splitting the
      hsc_range_config struct.
---
 MAINTAINERS                         |   7 +
 drivers/iio/pressure/Kconfig        |  22 ++
 drivers/iio/pressure/Makefile       |   3 +
 drivers/iio/pressure/hsc030pa.c     | 414 ++++++++++++++++++++++++++++
 drivers/iio/pressure/hsc030pa.h     |  78 ++++++
 drivers/iio/pressure/hsc030pa_i2c.c |  81 ++++++
 drivers/iio/pressure/hsc030pa_spi.c |  71 +++++
 7 files changed, 676 insertions(+)
 create mode 100644 drivers/iio/pressure/hsc030pa.c
 create mode 100644 drivers/iio/pressure/hsc030pa.h
 create mode 100644 drivers/iio/pressure/hsc030pa_i2c.c
 create mode 100644 drivers/iio/pressure/hsc030pa_spi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 509281e9e169..3ee65cda2d72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9702,6 +9702,13 @@ F:	lib/test_hmm*
 F:	mm/hmm*
 F:	tools/testing/selftests/mm/*hmm*
 
+HONEYWELL HSC030PA PRESSURE SENSOR SERIES IIO DRIVER
+M:	Petre Rodan <petre.rodan@subdimension.ro>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
+F:	drivers/iio/pressure/hsc030pa*
+
 HONEYWELL MPRLS0025PA PRESSURE SENSOR SERIES IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 95efa32e4289..79adfd059c3a 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -109,6 +109,28 @@ config HP03
 	  To compile this driver as a module, choose M here: the module
 	  will be called hp03.
 
+config HSC030PA
+	tristate "Honeywell HSC/SSC TruStability pressure sensor series"
+	depends on (I2C || SPI_MASTER)
+	select HSC030PA_I2C if I2C
+	select HSC030PA_SPI if SPI_MASTER
+	help
+	  Say Y here to build support for the Honeywell TruStability
+	  HSC and SSC pressure and temperature sensor series.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called hsc030pa.
+
+config HSC030PA_I2C
+	tristate
+	depends on HSC030PA
+	depends on I2C
+
+config HSC030PA_SPI
+	tristate
+	depends on HSC030PA
+	depends on SPI_MASTER
+
 config ICP10100
 	tristate "InvenSense ICP-101xx pressure and temperature sensor"
 	depends on I2C
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index 436aec7e65f3..b0f8b94662f2 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -15,6 +15,9 @@ obj-$(CONFIG_DPS310) += dps310.o
 obj-$(CONFIG_IIO_CROS_EC_BARO) += cros_ec_baro.o
 obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
 obj-$(CONFIG_HP03) += hp03.o
+obj-$(CONFIG_HSC030PA) += hsc030pa.o
+obj-$(CONFIG_HSC030PA_I2C) += hsc030pa_i2c.o
+obj-$(CONFIG_HSC030PA_SPI) += hsc030pa_spi.o
 obj-$(CONFIG_ICP10100) += icp10100.o
 obj-$(CONFIG_MPL115) += mpl115.o
 obj-$(CONFIG_MPL115_I2C) += mpl115_i2c.o
diff --git a/drivers/iio/pressure/hsc030pa.c b/drivers/iio/pressure/hsc030pa.c
new file mode 100644
index 000000000000..a118d27e4342
--- /dev/null
+++ b/drivers/iio/pressure/hsc030pa.c
@@ -0,0 +1,414 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Honeywell TruStability HSC Series pressure/temperature sensor
+ *
+ * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
+ *
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/init.h>
+#include <linux/math64.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/printk.h>
+#include <linux/regulator/consumer.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#include <asm/unaligned.h>
+
+#include "hsc030pa.h"
+
+#define     HSC_PRESSURE_TRIPLET_LEN  6
+#define              HSC_STATUS_MASK  GENMASK(7, 6)
+#define         HSC_TEMPERATURE_MASK  GENMASK(15, 5)
+#define            HSC_PRESSURE_MASK  GENMASK(29, 16)
+
+struct hsc_func_spec {
+	u32 output_min;
+	u32 output_max;
+};
+
+/**
+ * function A: 10% - 90% of 2^14
+ * function B:  5% - 95% of 2^14
+ * function C:  5% - 85% of 2^14
+ * function F:  4% - 94% of 2^14
+ */
+static const struct hsc_func_spec hsc_func_spec[] = {
+	[HSC_FUNCTION_A] = {.output_min = 1638, .output_max = 14746},
+	[HSC_FUNCTION_B] = {.output_min =  819, .output_max = 15565},
+	[HSC_FUNCTION_C] = {.output_min =  819, .output_max = 13926},
+	[HSC_FUNCTION_F] = {.output_min =  655, .output_max = 15401},
+};
+
+/**
+ * struct hsc_range_config - pressure ranges based on the nomenclature
+ * @name: 5-char string triplet that defines the range, measurement unit
+ *        and type
+ * @pmin: lowest pressure that can be measured
+ * @pmax: highest pressure that can be measured
+ */
+struct hsc_range_config {
+	char name[HSC_PRESSURE_TRIPLET_LEN];
+	s32 pmin;
+	u32 pmax;
+};
+
+/* all min max limits have been converted to pascals */
+static const struct hsc_range_config hsc_range_config[] = {
+	{.name = "001BA", .pmin =       0, .pmax =  100000 },
+	{.name = "1.6BA", .pmin =       0, .pmax =  160000 },
+	{.name = "2.5BA", .pmin =       0, .pmax =  250000 },
+	{.name = "004BA", .pmin =       0, .pmax =  400000 },
+	{.name = "006BA", .pmin =       0, .pmax =  600000 },
+	{.name = "010BA", .pmin =       0, .pmax = 1000000 },
+	{.name = "1.6MD", .pmin =    -160, .pmax =     160 },
+	{.name = "2.5MD", .pmin =    -250, .pmax =     250 },
+	{.name = "004MD", .pmin =    -400, .pmax =     400 },
+	{.name = "006MD", .pmin =    -600, .pmax =     600 },
+	{.name = "010MD", .pmin =   -1000, .pmax =    1000 },
+	{.name = "016MD", .pmin =   -1600, .pmax =    1600 },
+	{.name = "025MD", .pmin =   -2500, .pmax =    2500 },
+	{.name = "040MD", .pmin =   -4000, .pmax =    4000 },
+	{.name = "060MD", .pmin =   -6000, .pmax =    6000 },
+	{.name = "100MD", .pmin =  -10000, .pmax =   10000 },
+	{.name = "160MD", .pmin =  -16000, .pmax =   16000 },
+	{.name = "250MD", .pmin =  -25000, .pmax =   25000 },
+	{.name = "400MD", .pmin =  -40000, .pmax =   40000 },
+	{.name = "600MD", .pmin =  -60000, .pmax =   60000 },
+	{.name = "001BD", .pmin = -100000, .pmax =  100000 },
+	{.name = "1.6BD", .pmin = -160000, .pmax =  160000 },
+	{.name = "2.5BD", .pmin = -250000, .pmax =  250000 },
+	{.name = "004BD", .pmin = -400000, .pmax =  400000 },
+	{.name = "2.5MG", .pmin =       0, .pmax =     250 },
+	{.name = "004MG", .pmin =       0, .pmax =     400 },
+	{.name = "006MG", .pmin =       0, .pmax =     600 },
+	{.name = "010MG", .pmin =       0, .pmax =    1000 },
+	{.name = "016MG", .pmin =       0, .pmax =    1600 },
+	{.name = "025MG", .pmin =       0, .pmax =    2500 },
+	{.name = "040MG", .pmin =       0, .pmax =    4000 },
+	{.name = "060MG", .pmin =       0, .pmax =    6000 },
+	{.name = "100MG", .pmin =       0, .pmax =   10000 },
+	{.name = "160MG", .pmin =       0, .pmax =   16000 },
+	{.name = "250MG", .pmin =       0, .pmax =   25000 },
+	{.name = "400MG", .pmin =       0, .pmax =   40000 },
+	{.name = "600MG", .pmin =       0, .pmax =   60000 },
+	{.name = "001BG", .pmin =       0, .pmax =  100000 },
+	{.name = "1.6BG", .pmin =       0, .pmax =  160000 },
+	{.name = "2.5BG", .pmin =       0, .pmax =  250000 },
+	{.name = "004BG", .pmin =       0, .pmax =  400000 },
+	{.name = "006BG", .pmin =       0, .pmax =  600000 },
+	{.name = "010BG", .pmin =       0, .pmax = 1000000 },
+	{.name = "100KA", .pmin =       0, .pmax =  100000 },
+	{.name = "160KA", .pmin =       0, .pmax =  160000 },
+	{.name = "250KA", .pmin =       0, .pmax =  250000 },
+	{.name = "400KA", .pmin =       0, .pmax =  400000 },
+	{.name = "600KA", .pmin =       0, .pmax =  600000 },
+	{.name = "001GA", .pmin =       0, .pmax = 1000000 },
+	{.name = "160LD", .pmin =    -160, .pmax =     160 },
+	{.name = "250LD", .pmin =    -250, .pmax =     250 },
+	{.name = "400LD", .pmin =    -400, .pmax =     400 },
+	{.name = "600LD", .pmin =    -600, .pmax =     600 },
+	{.name = "001KD", .pmin =   -1000, .pmax =    1000 },
+	{.name = "1.6KD", .pmin =   -1600, .pmax =    1600 },
+	{.name = "2.5KD", .pmin =   -2500, .pmax =    2500 },
+	{.name = "004KD", .pmin =   -4000, .pmax =    4000 },
+	{.name = "006KD", .pmin =   -6000, .pmax =    6000 },
+	{.name = "010KD", .pmin =  -10000, .pmax =   10000 },
+	{.name = "016KD", .pmin =  -16000, .pmax =   16000 },
+	{.name = "025KD", .pmin =  -25000, .pmax =   25000 },
+	{.name = "040KD", .pmin =  -40000, .pmax =   40000 },
+	{.name = "060KD", .pmin =  -60000, .pmax =   60000 },
+	{.name = "100KD", .pmin = -100000, .pmax =  100000 },
+	{.name = "160KD", .pmin = -160000, .pmax =  160000 },
+	{.name = "250KD", .pmin = -250000, .pmax =  250000 },
+	{.name = "400KD", .pmin = -400000, .pmax =  400000 },
+	{.name = "250LG", .pmin =       0, .pmax =     250 },
+	{.name = "400LG", .pmin =       0, .pmax =     400 },
+	{.name = "600LG", .pmin =       0, .pmax =     600 },
+	{.name = "001KG", .pmin =       0, .pmax =    1000 },
+	{.name = "1.6KG", .pmin =       0, .pmax =    1600 },
+	{.name = "2.5KG", .pmin =       0, .pmax =    2500 },
+	{.name = "004KG", .pmin =       0, .pmax =    4000 },
+	{.name = "006KG", .pmin =       0, .pmax =    6000 },
+	{.name = "010KG", .pmin =       0, .pmax =   10000 },
+	{.name = "016KG", .pmin =       0, .pmax =   16000 },
+	{.name = "025KG", .pmin =       0, .pmax =   25000 },
+	{.name = "040KG", .pmin =       0, .pmax =   40000 },
+	{.name = "060KG", .pmin =       0, .pmax =   60000 },
+	{.name = "100KG", .pmin =       0, .pmax =  100000 },
+	{.name = "160KG", .pmin =       0, .pmax =  160000 },
+	{.name = "250KG", .pmin =       0, .pmax =  250000 },
+	{.name = "400KG", .pmin =       0, .pmax =  400000 },
+	{.name = "600KG", .pmin =       0, .pmax =  600000 },
+	{.name = "001GG", .pmin =       0, .pmax = 1000000 },
+	{.name = "015PA", .pmin =       0, .pmax =  103421 },
+	{.name = "030PA", .pmin =       0, .pmax =  206843 },
+	{.name = "060PA", .pmin =       0, .pmax =  413685 },
+	{.name = "100PA", .pmin =       0, .pmax =  689476 },
+	{.name = "150PA", .pmin =       0, .pmax = 1034214 },
+	{.name = "0.5ND", .pmin =    -125, .pmax =     125 },
+	{.name = "001ND", .pmin =    -249, .pmax =     249 },
+	{.name = "002ND", .pmin =    -498, .pmax =     498 },
+	{.name = "004ND", .pmin =    -996, .pmax =     996 },
+	{.name = "005ND", .pmin =   -1245, .pmax =    1245 },
+	{.name = "010ND", .pmin =   -2491, .pmax =    2491 },
+	{.name = "020ND", .pmin =   -4982, .pmax =    4982 },
+	{.name = "030ND", .pmin =   -7473, .pmax =    7473 },
+	{.name = "001PD", .pmin =   -6895, .pmax =    6895 },
+	{.name = "005PD", .pmin =  -34474, .pmax =   34474 },
+	{.name = "015PD", .pmin = -103421, .pmax =  103421 },
+	{.name = "030PD", .pmin = -206843, .pmax =  206843 },
+	{.name = "060PD", .pmin = -413685, .pmax =  413685 },
+	{.name = "001NG", .pmin =       0, .pmax =     249 },
+	{.name = "002NG", .pmin =       0, .pmax =     498 },
+	{.name = "004NG", .pmin =       0, .pmax =     996 },
+	{.name = "005NG", .pmin =       0, .pmax =    1245 },
+	{.name = "010NG", .pmin =       0, .pmax =    2491 },
+	{.name = "020NG", .pmin =       0, .pmax =    4982 },
+	{.name = "030NG", .pmin =       0, .pmax =    7473 },
+	{.name = "001PG", .pmin =       0, .pmax =    6895 },
+	{.name = "005PG", .pmin =       0, .pmax =   34474 },
+	{.name = "015PG", .pmin =       0, .pmax =  103421 },
+	{.name = "030PG", .pmin =       0, .pmax =  206843 },
+	{.name = "060PG", .pmin =       0, .pmax =  413685 },
+	{.name = "100PG", .pmin =       0, .pmax =  689476 },
+	{.name = "150PG", .pmin =       0, .pmax = 1034214 }
+};
+
+/*
+ * hsc_measurement_is_valid() - validate last conversion via status bits
+ * @data: structure containing instantiated sensor data
+ * Return: true only if both status bits are zero
+ *
+ * the two MSB from the first transfered byte contain a status code
+ *   00 - normal operation, valid data
+ *   01 - device in factory programming mode
+ *   10 - stale data
+ *   11 - diagnostic condition
+ */
+static bool hsc_measurement_is_valid(struct hsc_data *data)
+{
+	return !(data->buffer[0] & HSC_STATUS_MASK);
+}
+
+static int hsc_get_measurement(struct hsc_data *data)
+{
+	const struct hsc_chip_data *chip = data->chip;
+	int ret;
+
+	guard(mutex)(&data->lock);
+	ret = data->xfer(data);
+	if (ret < 0)
+		return ret;
+
+	data->is_valid = chip->valid(data);
+	if (!data->is_valid)
+		return -EAGAIN;
+
+	return 0;
+}
+
+static int hsc_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *channel, int *val,
+			int *val2, long mask)
+{
+	struct hsc_data *data = iio_priv(indio_dev);
+	int ret;
+	u32 xfer;
+	int raw;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = hsc_get_measurement(data);
+		if (ret)
+			return ret;
+
+		xfer = get_unaligned_be32(data->buffer);
+		switch (channel->type) {
+		case IIO_PRESSURE:
+			raw = FIELD_GET(HSC_PRESSURE_MASK, xfer);
+			*val = raw;
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			raw = FIELD_GET(HSC_TEMPERATURE_MASK, xfer);
+			*val = raw;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+
+/**
+ * IIO ABI expects
+ * value = (conv + offset) * scale
+ *
+ * datasheet provides the following formula for determining the temperature
+ * temp[C] = conv * a + b
+ *   where a = 200/2047; b = -50
+ *
+ *  temp[C] = (conv + (b/a)) * a * (1000)
+ *  =>
+ *  scale = a * 1000 = .097703957 * 1000 = 97.703957
+ *  offset = b/a = -50 / .097703957 = -50000000 / 97704
+ *
+ *  based on the datasheet
+ *  pressure = (conv - Omin) * Q + Pmin =
+ *          ((conv - Omin) + Pmin/Q) * Q
+ *  =>
+ *  scale = Q = (Pmax - Pmin) / (Omax - Omin)
+ *  offset = Pmin/Q - Omin = Pmin * (Omax - Omin) / (Pmax - Pmin) - Omin
+ */
+
+	case IIO_CHAN_INFO_SCALE:
+		switch (channel->type) {
+		case IIO_TEMP:
+			*val = 97;
+			*val2 = 703957;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_PRESSURE:
+			*val = data->p_scale;
+			*val2 = data->p_scale_dec;
+			return IIO_VAL_INT_PLUS_NANO;
+		default:
+			return -EINVAL;
+		}
+
+	case IIO_CHAN_INFO_OFFSET:
+		switch (channel->type) {
+		case IIO_TEMP:
+			*val = -50000000;
+			*val2 = 97704;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_PRESSURE:
+			*val = data->p_offset;
+			*val2 = data->p_offset_dec;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_chan_spec hsc_channels[] = {
+	{.type = IIO_PRESSURE, .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+	 BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) },
+	{.type = IIO_TEMP, .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+	 BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) },
+};
+
+static const struct iio_info hsc_info = {
+	.read_raw = hsc_read_raw,
+};
+
+static const struct hsc_chip_data hsc_chip = {
+	.valid = hsc_measurement_is_valid,
+	.channels = hsc_channels,
+	.num_channels = ARRAY_SIZE(hsc_channels),
+};
+
+int hsc_probe(struct iio_dev *indio_dev, struct device *dev,
+	      const char *name, int type)
+{
+	struct hsc_data *hsc;
+	const char *triplet;
+	u64 tmp;
+	int index;
+	int found = 0;
+	int ret;
+
+	hsc = iio_priv(indio_dev);
+	hsc->chip = &hsc_chip;
+
+	ret = device_property_read_u32(dev,
+				       "honeywell,transfer-function",
+				       &hsc->function);
+	if (ret)
+		return dev_err_probe(dev, ret,
+			    "honeywell,transfer-function could not be read\n");
+	if (hsc->function > HSC_FUNCTION_F)
+		return dev_err_probe(dev, -EINVAL,
+				     "honeywell,transfer-function %d invalid\n",
+				     hsc->function);
+
+	ret = device_property_read_string(dev,
+		"honeywell,pressure-triplet", &triplet);
+	if (ret)
+		return dev_err_probe(dev, ret,
+			"honeywell,pressure-triplet could not be read\n");
+
+	if (strncmp(triplet, "NA", 2) == 0) {
+		// "not available" in the nomenclature
+		// we got a custom-range chip so extract pmin, pmax from dt
+		ret = device_property_read_u32(dev,
+					       "honeywell,pmin-pascal",
+					       &hsc->pmin);
+		if (ret)
+			return dev_err_probe(dev, ret,
+				"honeywell,pmin-pascal could not be read\n");
+		ret = device_property_read_u32(dev,
+					       "honeywell,pmax-pascal",
+					       &hsc->pmax);
+		if (ret)
+			return dev_err_probe(dev, ret,
+				"honeywell,pmax-pascal could not be read\n");
+	} else {
+		// chip should be defined in the nomenclature
+		for (index = 0; index < ARRAY_SIZE(hsc_range_config); index++) {
+			if (strncmp(hsc_range_config[index].name,
+					triplet,
+					HSC_PRESSURE_TRIPLET_LEN - 1) == 0) {
+				hsc->pmin = hsc_range_config[index].pmin;
+				hsc->pmax = hsc_range_config[index].pmax;
+				found = 1;
+				break;
+			}
+		}
+		if (hsc->pmin == hsc->pmax || !found)
+			return dev_err_probe(dev, -EINVAL,
+				"honeywell,pressure-triplet is invalid\n");
+	}
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "can't get vdd supply\n");
+
+	hsc->outmin = hsc_func_spec[hsc->function].output_min;
+	hsc->outmax = hsc_func_spec[hsc->function].output_max;
+
+	/* multiply with MICRO and then divide by NANO since the output needs
+	   to be in Pa * 1000 as per IIO ABI requirement */
+	tmp = div_s64(((s64)(hsc->pmax - hsc->pmin)) * MICRO,
+		      (hsc->outmax - hsc->outmin));
+	hsc->p_scale = div_s64_rem(tmp, NANO, &hsc->p_scale_dec);
+	tmp = div_s64(((s64)hsc->pmin * (s64)(hsc->outmax - hsc->outmin)) *
+		      MICRO, hsc->pmax - hsc->pmin);
+	tmp -= (s64)hsc->outmin * MICRO;
+	hsc->p_offset = div_s64_rem(tmp, MICRO, &hsc->p_offset_dec);
+
+	mutex_init(&hsc->lock);
+	indio_dev->name = name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &hsc_info;
+	indio_dev->channels = hsc->chip->channels;
+	indio_dev->num_channels = hsc->chip->num_channels;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+EXPORT_SYMBOL_NS(hsc_probe, IIO_HONEYWELL_HSC030PA);
+
+MODULE_AUTHOR("Petre Rodan <petre.rodan@subdimension.ro>");
+MODULE_DESCRIPTION("Honeywell HSC and SSC pressure sensor core driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/pressure/hsc030pa.h b/drivers/iio/pressure/hsc030pa.h
new file mode 100644
index 000000000000..cf1674d36485
--- /dev/null
+++ b/drivers/iio/pressure/hsc030pa.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Honeywell TruStability HSC Series pressure/temperature sensor
+ *
+ * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
+ */
+
+#ifndef _HSC030PA_H
+#define _HSC030PA_H
+
+#include <linux/property.h>
+#include <linux/types.h>
+
+/**
+ * get all conversions (4 bytes) in one go
+ * since transfers are not address-based
+*/
+#define  HSC_REG_MEASUREMENT_RD_SIZE  4
+
+struct device;
+
+struct iio_chan_spec;
+struct iio_dev;
+
+struct hsc_chip_data;
+
+/**
+ * struct hsc_data
+ * @client: either i2c or spi kernel interface struct for current dev
+ * @lock: lock protecting chip reads
+ * @xfer: function that implements the chip reads
+ * @is_valid: false if last transfer has failed
+ * @buffer: raw conversion data
+ * @pmin: minimum measurable pressure limit
+ * @pmax: maximum measurable pressure limit
+ * @outmin: minimum raw pressure in counts (based on transfer function)
+ * @outmax: maximum raw pressure in counts (based on transfer function)
+ * @function: transfer function
+ * @p_scale: pressure scale
+ * @p_scale_dec: pressure scale, decimal places
+ * @p_offset: pressure offset
+ * @p_offset_dec: pressure offset, decimal places
+ */
+struct hsc_data {
+	void *client;
+	const struct hsc_chip_data *chip;
+	struct mutex lock;
+	int (*xfer)(struct hsc_data *data);
+	bool is_valid;
+	u8 buffer[HSC_REG_MEASUREMENT_RD_SIZE];
+	s32 pmin;
+	s32 pmax;
+	u32 outmin;
+	u32 outmax;
+	u32 function;
+	s64 p_scale;
+	s32 p_scale_dec;
+	s64 p_offset;
+	s32 p_offset_dec;
+};
+
+struct hsc_chip_data {
+	bool (*valid)(struct hsc_data *data);
+	const struct iio_chan_spec *channels;
+	u8 num_channels;
+};
+
+enum hsc_func_id {
+	HSC_FUNCTION_A,
+	HSC_FUNCTION_B,
+	HSC_FUNCTION_C,
+	HSC_FUNCTION_F,
+};
+
+int hsc_probe(struct iio_dev *indio_dev, struct device *dev,
+	      const char *name, int type);
+
+#endif
diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/hsc030pa_i2c.c
new file mode 100644
index 000000000000..4132db4e356a
--- /dev/null
+++ b/drivers/iio/pressure/hsc030pa_i2c.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Honeywell TruStability HSC Series pressure/temperature sensor
+ *
+ * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
+ *
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf [hsc]
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/common/documents/sps-siot-i2c-comms-digital-output-pressure-sensors-tn-008201-3-en-ciid-45841.pdf [i2c related]
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+
+#include "hsc030pa.h"
+
+static int hsc_i2c_xfer(struct hsc_data *data)
+{
+	struct i2c_client *client = data->client;
+	struct i2c_msg msg;
+	int ret;
+
+	msg.addr = client->addr;
+	msg.flags = client->flags | I2C_M_RD;
+	msg.len = HSC_REG_MEASUREMENT_RD_SIZE;
+	msg.buf = (char *)&data->buffer;
+
+	ret = i2c_transfer(client->adapter, &msg, 1);
+
+	return (ret == 2) ? 0 : ret;
+}
+
+static int hsc_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct hsc_data *hsc;
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*hsc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	hsc = iio_priv(indio_dev);
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+
+	hsc->xfer = hsc_i2c_xfer;
+	hsc->client = client;
+
+	return hsc_probe(indio_dev, &client->dev, id->name, id->driver_data);
+}
+
+static const struct of_device_id hsc_i2c_match[] = {
+	{.compatible = "honeywell,hsc030pa"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, hsc_i2c_match);
+
+static const struct i2c_device_id hsc_i2c_id[] = {
+	{"hsc030pa"},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, hsc_i2c_id);
+
+static struct i2c_driver hsc_i2c_driver = {
+	.driver = {
+		.name = "hsc030pa",
+		.of_match_table = hsc_i2c_match,
+		},
+	.probe = hsc_i2c_probe,
+	.id_table = hsc_i2c_id,
+};
+module_i2c_driver(hsc_i2c_driver);
+
+MODULE_AUTHOR("Petre Rodan <petre.rodan@subdimension.ro>");
+MODULE_DESCRIPTION("Honeywell HSC and SSC pressure sensor i2c driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_HONEYWELL_HSC030PA);
diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressure/hsc030pa_spi.c
new file mode 100644
index 000000000000..d99688a65f04
--- /dev/null
+++ b/drivers/iio/pressure/hsc030pa_spi.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Honeywell TruStability HSC Series pressure/temperature sensor
+ *
+ * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
+ *
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
+ */
+
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+
+#include "hsc030pa.h"
+
+static int hsc_spi_xfer(struct hsc_data *data)
+{
+	struct spi_transfer xfer = {
+		.tx_buf = NULL,
+		.rx_buf = (char *)&data->buffer,
+		.len = HSC_REG_MEASUREMENT_RD_SIZE,
+	};
+
+	return spi_sync_transfer(data->client, &xfer, 1);
+}
+
+static int hsc_spi_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct hsc_data *hsc;
+	struct device *dev = &spi->dev;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*hsc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	hsc = iio_priv(indio_dev);
+	hsc->xfer = hsc_spi_xfer;
+	hsc->client = spi;
+
+	return hsc_probe(indio_dev, &spi->dev, spi_get_device_id(spi)->name,
+			 spi_get_device_id(spi)->driver_data);
+}
+
+static const struct of_device_id hsc_spi_match[] = {
+	{.compatible = "honeywell,hsc030pa",},
+	{}
+};
+MODULE_DEVICE_TABLE(of, hsc_spi_match);
+
+static const struct spi_device_id hsc_spi_id[] = {
+	{"hsc030pa"},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, hsc_spi_id);
+
+static struct spi_driver hsc_spi_driver = {
+	.driver = {
+		.name = "hsc030pa",
+		.of_match_table = hsc_spi_match,
+		},
+	.probe = hsc_spi_probe,
+	.id_table = hsc_spi_id,
+};
+module_spi_driver(hsc_spi_driver);
+
+MODULE_AUTHOR("Petre Rodan <petre.rodan@subdimension.ro>");
+MODULE_DESCRIPTION("Honeywell HSC and SSC pressure sensor spi driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_HONEYWELL_HSC030PA);
-- 
2.41.0


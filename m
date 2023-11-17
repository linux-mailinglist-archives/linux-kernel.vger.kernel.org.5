Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC7C7EF698
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346125AbjKQQvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346091AbjKQQvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:51:00 -0500
X-Greylist: delayed 467 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Nov 2023 08:50:55 PST
Received: from mail.subdimension.ro (unknown [IPv6:2a01:7e01:e001:1d1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BA9D57;
        Fri, 17 Nov 2023 08:50:55 -0800 (PST)
Received: from localhost.localdomain (unknown [188.24.94.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.subdimension.ro (Postfix) with ESMTPSA id 753A628F1F1;
        Fri, 17 Nov 2023 16:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
        s=skycaves; t=1700239396;
        bh=5ojv8tkZPPHaZjRpJOPj595D/vQrVX4CCO62HXtjjuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hQfW3R9kuS9k8OvZeIBXjpd8WndzSa4zuOf3rCgU+CFqWhDnfv1n1qZk99mViVqa2
         n75E0Q9D+3YQLOYYYxvflOsvXTyn0jS4KQ9al1B2OUN/2xkxOnVYX8x8apF+IlxWwf
         +pf/3DjAA7kB/V1V6Ciu1YUxq7OQc1Tz9UDxWUVs=
From:   Petre Rodan <petre.rodan@subdimension.ro>
To:     petre.rodan@subdimension.ro, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 2/2] iio: pressure: driver for Honeywell HSC/SSC series pressure sensors
Date:   Fri, 17 Nov 2023 18:42:06 +0200
Message-ID: <20231117164232.8474-2-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117164232.8474-1-petre.rodan@subdimension.ro>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds driver for Honeywell TruStability HSC and SSC series pressure and
temperature sensors.

Covers i2c and spi-based interfaces. For both series it supports all the
combinations of four transfer functions and all 118 pressure ranges.
In case of a special chip not covered by the nomenclature a custom range
can be specified.

Devices tested:
 HSCMLNN100PASA3 (SPI sensor)
 HSCMRNN030PA2A3 (i2c sensor)

Datasheet:
 [HSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
 [SSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf
 [i2c comms] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/common/documents/sps-siot-i2c-comms-digital-output-pressure-sensors-tn-008201-3-en-ciid-45841.pdf

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 MAINTAINERS                         |   7 +
 drivers/iio/pressure/Kconfig        |  22 ++
 drivers/iio/pressure/Makefile       |   3 +
 drivers/iio/pressure/hsc030pa.c     | 402 ++++++++++++++++++++++++++++
 drivers/iio/pressure/hsc030pa.h     |  59 ++++
 drivers/iio/pressure/hsc030pa_i2c.c | 136 ++++++++++
 drivers/iio/pressure/hsc030pa_spi.c | 129 +++++++++
 7 files changed, 758 insertions(+)
 create mode 100644 drivers/iio/pressure/hsc030pa.c
 create mode 100644 drivers/iio/pressure/hsc030pa.h
 create mode 100644 drivers/iio/pressure/hsc030pa_i2c.c
 create mode 100644 drivers/iio/pressure/hsc030pa_spi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 482d428472e7..cba0d34c504a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9708,6 +9708,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
 F:	drivers/iio/pressure/mprls0025pa.c
 
+HONEYWELL HSC, SSC PRESSURE SENSOR SERIES IIO DRIVER
+M:	Petre Rodan <petre.rodan@subdimension.ro>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
+F:	drivers/iio/pressure/hsc030pa*
+
 HOST AP DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Obsolete
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 95efa32e4289..266688802fb3 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -109,6 +109,28 @@ config HP03
 	  To compile this driver as a module, choose M here: the module
 	  will be called hp03.
 
+config HSC030PA
+	tristate "Honeywell HSC/SSC (TruStability pressure sensors series)"
+	depends on (I2C || SPI_MASTER)
+	select HSC030PA_I2C if (I2C)
+	select HSC030PA_SPI if (SPI_MASTER)
+	help
+	  Say Y here to build support for the Honeywell HSC and SSC TruStability
+      pressure and temperature sensor series.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called hsc030pa.
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
index 000000000000..b6ddfef7ee28
--- /dev/null
+++ b/drivers/iio/pressure/hsc030pa.c
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Honeywell TruStability HSC Series pressure/temperature sensor
+ *
+ * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
+ *
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf?download=false
+ */
+
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/init.h>
+#include <linux/math64.h>
+#include <linux/units.h>
+#include <linux/mod_devicetable.h>
+#include <linux/printk.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include "hsc030pa.h"
+
+struct hsc_func_spec {
+	u32 output_min;
+	u32 output_max;
+};
+
+static const struct hsc_func_spec hsc_func_spec[] = {
+	[HSC_FUNCTION_A] = {.output_min = 1638, .output_max = 14746}, // 10% - 90% of 2^14
+	[HSC_FUNCTION_B] = {.output_min =  819, .output_max = 15565}, //  5% - 95% of 2^14
+	[HSC_FUNCTION_C] = {.output_min =  819, .output_max = 13926}, //  5% - 85% of 2^14
+	[HSC_FUNCTION_F] = {.output_min =  655, .output_max = 15401}, //  4% - 94% of 2^14
+};
+
+// pressure range for current chip based on the nomenclature
+struct hsc_range_config {
+	char name[HSC_RANGE_STR_LEN];	// 5-char string that defines the range - ie "030PA"
+	s32 pmin;		// minimal pressure in pascals
+	s32 pmax;		// maximum pressure in pascals
+};
+
+// all min max limits have been converted to pascals
+// code generated by scripts/parse_variants_table.sh
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
+	{.name = "015PA", .pmin =       0, .pmax =  103425 },
+	{.name = "030PA", .pmin =       0, .pmax =  206850 },
+	{.name = "060PA", .pmin =       0, .pmax =  413700 },
+	{.name = "100PA", .pmin =       0, .pmax =  689500 },
+	{.name = "150PA", .pmin =       0, .pmax = 1034250 },
+	{.name = "0.5ND", .pmin =    -125, .pmax =     125 },
+	{.name = "001ND", .pmin =    -249, .pmax =     249 },
+	{.name = "002ND", .pmin =    -498, .pmax =     498 },
+	{.name = "004ND", .pmin =    -996, .pmax =     996 },
+	{.name = "005ND", .pmin =   -1245, .pmax =    1245 },
+	{.name = "010ND", .pmin =   -2491, .pmax =    2491 },
+	{.name = "020ND", .pmin =   -4982, .pmax =    4982 },
+	{.name = "030ND", .pmin =   -7473, .pmax =    7473 },
+	{.name = "001PD", .pmin =   -6895, .pmax =    6895 },
+	{.name = "005PD", .pmin =  -34475, .pmax =   34475 },
+	{.name = "015PD", .pmin = -103425, .pmax =  103425 },
+	{.name = "030PD", .pmin = -206850, .pmax =  206850 },
+	{.name = "060PD", .pmin = -413700, .pmax =  413700 },
+	{.name = "001NG", .pmin =       0, .pmax =     249 },
+	{.name = "002NG", .pmin =       0, .pmax =     498 },
+	{.name = "004NG", .pmin =       0, .pmax =     996 },
+	{.name = "005NG", .pmin =       0, .pmax =    1245 },
+	{.name = "010NG", .pmin =       0, .pmax =    2491 },
+	{.name = "020NG", .pmin =       0, .pmax =    4982 },
+	{.name = "030NG", .pmin =       0, .pmax =    7473 },
+	{.name = "001PG", .pmin =       0, .pmax =    6895 },
+	{.name = "005PG", .pmin =       0, .pmax =   34475 },
+	{.name = "015PG", .pmin =       0, .pmax =  103425 },
+	{.name = "030PG", .pmin =       0, .pmax =  206850 },
+	{.name = "060PG", .pmin =       0, .pmax =  413700 },
+	{.name = "100PG", .pmin =       0, .pmax =  689500 },
+	{.name = "150PG", .pmin =       0, .pmax = 1034250 }
+};
+
+/*
+ * the first two bits from the first byte contain a status code
+ *
+ * 00 - normal operation, valid data
+ * 01 - device in hidden factory command mode
+ * 10 - stale data
+ * 11 - diagnostic condition
+ *
+ * function returns 1 only if both bits are zero
+ */
+static bool hsc_measurement_is_valid(struct hsc_data *data)
+{
+	if (data->buffer[0] & 0xc0)
+		return 0;
+
+	return 1;
+}
+
+static int hsc_get_measurement(struct hsc_data *data)
+{
+	const struct hsc_chip_data *chip = data->chip;
+	int ret;
+
+	/* don't bother sensor more than once a second */
+	if (!time_after(jiffies, data->last_update + HZ))
+		return data->is_valid ? 0 : -EAGAIN;
+
+	data->is_valid = false;
+	data->last_update = jiffies;
+
+	ret = data->xfer(data);
+
+	if (ret < 0)
+		return ret;
+
+	ret = chip->valid(data);
+	if (!ret)
+		return -EAGAIN;
+
+	data->is_valid = true;
+
+	return 0;
+}
+
+/*
+ * 4 bytes are read, the dissection looks like
+ *
+ * .  0  .  1  .  2  .  3  .  4  .  5  .  6  .  7  .
+ * byte 0:
+ * |  s1 |  s0 | b13 | b12 | b11 | b10 |  b9 |  b8 |
+ * | status    | bridge data (pressure) MSB        |
+ * byte 1:
+ * |  b7 |  b6 |  b5 |  b4 |  b3 |  b2 |  b1 |  b0 |
+ * | bridge data (pressure) LSB                    |
+ * byte 2:
+ * | t10 |  t9 |  t8 |  t7 |  t6 |  t5 |  t4 |  t3 |
+ * | temperature data MSB                          |
+ * byte 3:
+ * |  t2 |  t1 |  t0 |  X  |  X  |  X  |  X  |  X  |
+ * | temperature LSB | ignore                      |
+ *
+ * .  0  .  1  .  2  .  3  .  4  .  5  .  6  .  7  .
+ */
+
+static int hsc_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *channel, int *val,
+			int *val2, long mask)
+{
+	struct hsc_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	switch (mask) {
+
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&data->lock);
+		ret = hsc_get_measurement(data);
+		mutex_unlock(&data->lock);
+
+		if (ret)
+			return ret;
+
+		switch (channel->type) {
+		case IIO_PRESSURE:
+			*val =
+			    ((data->buffer[0] & 0x3f) << 8) + data->buffer[1];
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			*val =
+			    (data->buffer[2] << 3) +
+			    ((data->buffer[3] & 0xe0) >> 5);
+			ret = 0;
+			if (!ret)
+				return IIO_VAL_INT;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+
+/**
+ *	IIO ABI expects
+ *	value = (conv + offset) * scale
+ *
+ *	datasheet provides the following formula for determining the temperature
+ *	temp[C] = conv * a + b
+ *        where a = 200/2047; b = -50
+ *
+ *	temp[C] = (conv + (b/a)) * a * (1000)
+ *      =>
+ *	scale = a * 1000 = .097703957 * 1000 = 97.703957
+ *	offset = b/a = -50 / .097703957 = -50000000 / 97704
+ *
+ *	based on the datasheet
+ *	pressure = (conv - HSC_OUTPUT_MIN) * Q + Pmin =
+ *	           ((conv - HSC_OUTPUT_MIN) + Pmin/Q) * Q
+ *	=>
+ *	scale = Q = (Pmax - Pmin) / (HSC_OUTPUT_MAX - HSC_OUTPUT_MIN)
+ *	offset = Pmin/Q = Pmin * (HSC_OUTPUT_MAX - HSC_OUTPUT_MIN) / (Pmax - Pmin)
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
+			*val2 = data->p_scale_nano;
+			return IIO_VAL_INT_PLUS_NANO;
+		default:
+			return -EINVAL;
+		}
+		break;
+
+	case IIO_CHAN_INFO_OFFSET:
+		switch (channel->type) {
+		case IIO_TEMP:
+			*val = -50000000;
+			*val2 = 97704;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_PRESSURE:
+			*val = data->p_offset;
+			*val2 = data->p_offset_nano;
+			return IIO_VAL_INT_PLUS_NANO;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return ret;
+}
+
+static const struct iio_chan_spec hsc_channels[] = {
+	{
+	 .type = IIO_PRESSURE,
+	 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+	 BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET)
+	 },
+	{
+	 .type = IIO_TEMP,
+	 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+	 BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET)
+	 },
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
+	u64 tmp;
+	int index;
+	int found = 0;
+
+	hsc = iio_priv(indio_dev);
+
+	hsc->last_update = jiffies - HZ;
+	hsc->chip = &hsc_chip;
+
+	if (strcasecmp(hsc->range_str, "na") != 0) {
+		// chip should be defined in the nomenclature
+		for (index = 0; index < ARRAY_SIZE(hsc_range_config); index++) {
+			if (strcasecmp
+			    (hsc_range_config[index].name,
+			     hsc->range_str) == 0) {
+				hsc->pmin = hsc_range_config[index].pmin;
+				hsc->pmax = hsc_range_config[index].pmax;
+				found = 1;
+				break;
+			}
+		}
+		if (hsc->pmin == hsc->pmax || !found)
+			return dev_err_probe(dev, -EINVAL,
+					     "honeywell,range_str is invalid\n");
+	}
+
+	hsc->outmin = hsc_func_spec[hsc->function].output_min;
+	hsc->outmax = hsc_func_spec[hsc->function].output_max;
+
+	// multiply with MICRO and then divide by NANO since the output needs
+	// to be in KPa as per IIO ABI requirement
+	tmp = div_s64(((s64) (hsc->pmax - hsc->pmin)) * MICRO,
+		      (hsc->outmax - hsc->outmin));
+	hsc->p_scale = div_s64_rem(tmp, NANO, &hsc->p_scale_nano);
+	tmp =
+	    div_s64(((s64) hsc->pmin * (s64) (hsc->outmax - hsc->outmin)) *
+		    MICRO, hsc->pmax - hsc->pmin);
+	hsc->p_offset =
+	    div_s64_rem(tmp, NANO, &hsc->p_offset_nano) - hsc->outmin;
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
+EXPORT_SYMBOL_NS(hsc_probe, IIO_HONEYWELL_HSC);
+
+void hsc_remove(struct iio_dev *indio_dev)
+{
+	iio_device_unregister(indio_dev);
+}
+EXPORT_SYMBOL_NS(hsc_remove, IIO_HONEYWELL_HSC);
+
+MODULE_AUTHOR("Petre Rodan <petre.rodan@subdimension.ro>");
+MODULE_DESCRIPTION("Honeywell HSC and SSC pressure sensor core driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/pressure/hsc030pa.h b/drivers/iio/pressure/hsc030pa.h
new file mode 100644
index 000000000000..bc2a4877465b
--- /dev/null
+++ b/drivers/iio/pressure/hsc030pa.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Honeywell TruStability HSC Series pressure/temperature sensor
+ *
+ * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
+ *
+ */
+
+#ifndef _HSC030PA_H
+#define _HSC030PA_H
+
+#define  HSC_REG_MEASUREMENT_RD_SIZE  4         // get all conversions in one go since transfers are not address-based
+#define            HSC_RANGE_STR_LEN  6
+
+struct hsc_chip_data;
+
+struct hsc_data {
+	void *client;                           // either i2c or spi kernel interface struct for current dev
+	const struct hsc_chip_data *chip;
+	struct mutex lock;                      // lock protecting chip reads
+	int (*xfer)(struct hsc_data *data);    // function that implements the chip reads
+	bool is_valid;                          // false if last transfer has failed
+	unsigned long last_update;              // time of last successful conversion
+	u8 buffer[HSC_REG_MEASUREMENT_RD_SIZE]; // raw conversion data
+	char range_str[HSC_RANGE_STR_LEN];	// range as defined by the chip nomenclature - ie "030PA" or "NA"
+	s32 pmin;                               // min pressure limit
+	s32 pmax;                               // max pressure limit
+	u32 outmin;                             // minimum raw pressure in counts (based on transfer function)
+	u32 outmax;                             // maximum raw pressure in counts (based on transfer function)
+	u32 function;                           // transfer function
+	s64 p_scale;                            // pressure scale
+	s32 p_scale_nano;                       // pressure scale, decimal places
+	s64 p_offset;                           // pressure offset
+	s32 p_offset_nano;                      // pressure offset, decimal places
+};
+
+struct hsc_chip_data {
+	bool (*valid)(struct hsc_data *data);  // function that checks the two status bits
+	const struct iio_chan_spec *channels;   // channel specifications
+	u8 num_channels;                        // pressure and temperature channels
+};
+
+enum hsc_func_id {
+	HSC_FUNCTION_A,
+	HSC_FUNCTION_B,
+	HSC_FUNCTION_C,
+	HSC_FUNCTION_F
+};
+
+enum hsc_variant {
+	HSC,
+	SSC
+};
+
+int hsc_probe(struct iio_dev *indio_dev, struct device *dev,
+	      const char *name, int type);
+void hsc_remove(struct iio_dev *indio_dev);
+
+#endif
diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/hsc030pa_i2c.c
new file mode 100644
index 000000000000..8d3fb174285a
--- /dev/null
+++ b/drivers/iio/pressure/hsc030pa_i2c.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Honeywell TruStability HSC Series pressure/temperature sensor
+ *
+ * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
+ *
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
+ * i2c-related datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/common/documents/sps-siot-i2c-comms-digital-output-pressure-sensors-tn-008201-3-en-ciid-45841.pdf
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regulator/consumer.h>
+#include <linux/iio/iio.h>
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
+static int hsc_i2c_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct hsc_data *hsc;
+	const char *range_nom;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*hsc));
+	if (!indio_dev) {
+		dev_err(&client->dev, "Failed to allocate device\n");
+		return -ENOMEM;
+	}
+
+	hsc = iio_priv(indio_dev);
+
+	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		hsc->xfer = hsc_i2c_xfer;
+	else
+		return -EOPNOTSUPP;
+
+	ret = devm_regulator_get_enable_optional(dev, "vdd");
+	if (ret == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	if (!dev_fwnode(dev))
+		return -EOPNOTSUPP;
+
+	ret = device_property_read_u32(dev,
+				       "honeywell,transfer-function",
+				       &hsc->function);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "honeywell,transfer-function could not be read\n");
+	if (hsc->function > HSC_FUNCTION_F)
+		return dev_err_probe(dev, -EINVAL,
+				     "honeywell,transfer-function %d invalid\n",
+				     hsc->function);
+
+	ret = device_property_read_string(dev,
+					  "honeywell,range_str", &range_nom);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "honeywell,range_str not defined\n");
+
+	memcpy(hsc->range_str, range_nom, HSC_RANGE_STR_LEN - 1);
+	hsc->range_str[HSC_RANGE_STR_LEN - 1] = 0;
+
+	if (strcasecmp(hsc->range_str, "na") == 0) {
+		// "not available"
+		// we got a custom-range chip not covered by the nomenclature
+		ret = device_property_read_u32(dev,
+					     "honeywell,pmin-pascal",
+					     &hsc->pmin);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "honeywell,pmin-pascal could not be read\n");
+		ret = device_property_read_u32(dev,
+					     "honeywell,pmax-pascal",
+					     &hsc->pmax);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "honeywell,pmax-pascal could not be read\n");
+	}
+
+	i2c_set_clientdata(client, indio_dev);
+	hsc->client = client;
+
+	return hsc_probe(indio_dev, &client->dev, id->name, id->driver_data);
+}
+
+static const struct of_device_id hsc_i2c_match[] = {
+	{.compatible = "honeywell,hsc",},
+	{.compatible = "honeywell,ssc",},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, hsc_i2c_match);
+
+static const struct i2c_device_id hsc_i2c_id[] = {
+	{"hsc", HSC},
+	{"ssc", SSC},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, hsc_i2c_id);
+
+static struct i2c_driver hsc_i2c_driver = {
+	.driver = {
+		   .name = "honeywell_hsc",
+		   .of_match_table = hsc_i2c_match,
+		   },
+	.probe = hsc_i2c_probe,
+	.id_table = hsc_i2c_id,
+};
+
+module_i2c_driver(hsc_i2c_driver);
+
+MODULE_AUTHOR("Petre Rodan <petre.rodan@subdimension.ro>");
+MODULE_DESCRIPTION("Honeywell HSC and SSC pressure sensor i2c driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_HONEYWELL_HSC);
diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressure/hsc030pa_spi.c
new file mode 100644
index 000000000000..e7a9b64ac84b
--- /dev/null
+++ b/drivers/iio/pressure/hsc030pa_spi.c
@@ -0,0 +1,129 @@
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
+#include <linux/iio/iio.h>
+#include <linux/regulator/consumer.h>
+#include "hsc030pa.h"
+
+static int hsc_spi_xfer(struct hsc_data *data)
+{
+	struct spi_transfer xfer = {
+		.tx_buf = NULL,
+		.rx_buf = (char *)&data->buffer,
+		.len = HSC_REG_MEASUREMENT_RD_SIZE,
+	};
+	int ret;
+
+	ret = spi_sync_transfer(data->client, &xfer, 1);
+
+	return ret;
+}
+
+static int hsc_spi_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct hsc_data *hsc;
+	const char *range_nom;
+	int ret;
+	struct device *dev = &spi->dev;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*hsc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, indio_dev);
+
+	spi->mode = SPI_MODE_0;
+	spi->max_speed_hz = min(spi->max_speed_hz, 800000U);
+	spi->bits_per_word = 8;
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
+
+	hsc = iio_priv(indio_dev);
+	hsc->xfer = hsc_spi_xfer;
+	hsc->client = spi;
+
+	ret = devm_regulator_get_enable_optional(dev, "vdd");
+	if (ret == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	ret = device_property_read_u32(dev,
+				       "honeywell,transfer-function",
+				       &hsc->function);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "honeywell,transfer-function could not be read\n");
+	if (hsc->function > HSC_FUNCTION_F)
+		return dev_err_probe(dev, -EINVAL,
+				     "honeywell,transfer-function %d invalid\n",
+				     hsc->function);
+
+	ret =
+	    device_property_read_string(dev, "honeywell,range_str", &range_nom);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "honeywell,range_str not defined\n");
+
+	// minimal input sanitization
+	memcpy(hsc->range_str, range_nom, HSC_RANGE_STR_LEN - 1);
+	hsc->range_str[HSC_RANGE_STR_LEN - 1] = 0;
+
+	if (strcasecmp(hsc->range_str, "na") == 0) {
+		// range string "not available"
+		// we got a custom chip not covered by the nomenclature with a custom range
+		ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
+					       &hsc->pmin);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "honeywell,pmin-pascal could not be read\n");
+		ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
+					       &hsc->pmax);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "honeywell,pmax-pascal could not be read\n");
+	}
+
+	return hsc_probe(indio_dev, &spi->dev, spi_get_device_id(spi)->name,
+			 spi_get_device_id(spi)->driver_data);
+}
+
+static const struct of_device_id hsc_spi_match[] = {
+	{.compatible = "honeywell,hsc",},
+	{.compatible = "honeywell,ssc",},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, hsc_spi_match);
+
+static const struct spi_device_id hsc_spi_id[] = {
+	{"hsc", HSC},
+	{"ssc", SSC},
+	{}
+};
+
+MODULE_DEVICE_TABLE(spi, hsc_spi_id);
+
+static struct spi_driver hsc_spi_driver = {
+	.driver = {
+		   .name = "honeywell_hsc",
+		   .of_match_table = hsc_spi_match,
+		   },
+	.probe = hsc_spi_probe,
+	.id_table = hsc_spi_id,
+};
+
+module_spi_driver(hsc_spi_driver);
+
+MODULE_AUTHOR("Petre Rodan <petre.rodan@subdimension.ro>");
+MODULE_DESCRIPTION("Honeywell HSC and SSC pressure sensor spi driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_HONEYWELL_HSC);
-- 
2.41.0


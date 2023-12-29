Return-Path: <linux-kernel+bounces-13036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A5581FEAF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7EEAB22DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D49134C1;
	Fri, 29 Dec 2023 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="UkNGK/Zw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE58125B2;
	Fri, 29 Dec 2023 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 1BB1928B597;
	Fri, 29 Dec 2023 09:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703841909;
	bh=eKbNnj7orFcc/inNQ34FTt139oscjUlCdr8IE4HhtlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UkNGK/ZwExSm4NC5CgKSJSfwHYZVzwW0GL2w9wfyBiRNPgV8vTO8daIbMzMrp9ffk
	 KpFhgg+qAL1l6svxEscx6OnDXPQ2gMQIg5fYooZ2hdxY0x/3S7C5BfNyiwMkg/WwJP
	 Y+dPL7Aw0gUmSnIK6WvR3O/e8addRp2S9Y6I+r1U=
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
Subject: [PATCH v3 10/10] iio: pressure: mprls0025pa add SPI driver
Date: Fri, 29 Dec 2023 11:24:38 +0200
Message-ID: <20231229092445.30180-11-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231229092445.30180-1-petre.rodan@subdimension.ro>
References: <20231229092445.30180-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SPI component of the driver.

Tested with mprls0015pa0000sa in spi mode on BeagleBone Black on
slightly patched 6.7.0-rc6 mainline.

Tested with mprls0025pa in i2c mode on BeagleBone Black with togreg
branch on
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
(tag: iio-for-6.8a)

Tested-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v2 -> v3 removed iio.h include line

 drivers/iio/pressure/Kconfig           |  8 ++-
 drivers/iio/pressure/Makefile          |  1 +
 drivers/iio/pressure/mprls0025pa_spi.c | 89 ++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/pressure/mprls0025pa_spi.c

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index f03007cfec85..5da7931dc537 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -181,8 +181,9 @@ config MPL3115

 config MPRLS0025PA
 	tristate "Honeywell MPRLS0025PA (MicroPressure sensors series)"
-	depends on I2C
+	depends on (I2C || SPI_MASTER)
 	select MPRLS0025PA_I2C if I2C
+	select MPRLS0025PA_SPI if SPI_MASTER
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
@@ -198,6 +199,11 @@ config MPRLS0025PA_I2C
 	depends on MPRLS0025PA
 	depends on I2C

+config MPRLS0025PA_SPI
+	tristate
+	depends on MPRLS0025PA
+	depends on SPI_MASTER
+
 config MS5611
 	tristate "Measurement Specialties MS5611 pressure sensor driver"
 	select IIO_BUFFER
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index 7754135e190c..a93709e35760 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_MPL115_SPI) += mpl115_spi.o
 obj-$(CONFIG_MPL3115) += mpl3115.o
 obj-$(CONFIG_MPRLS0025PA) += mprls0025pa.o
 obj-$(CONFIG_MPRLS0025PA_I2C) += mprls0025pa_i2c.o
+obj-$(CONFIG_MPRLS0025PA_SPI) += mprls0025pa_spi.o
 obj-$(CONFIG_MS5611) += ms5611_core.o
 obj-$(CONFIG_MS5611_I2C) += ms5611_i2c.o
 obj-$(CONFIG_MS5611_SPI) += ms5611_spi.o
diff --git a/drivers/iio/pressure/mprls0025pa_spi.c b/drivers/iio/pressure/mprls0025pa_spi.c
new file mode 100644
index 000000000000..32f6c2e60380
--- /dev/null
+++ b/drivers/iio/pressure/mprls0025pa_spi.c
@@ -0,0 +1,89 @@
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
+#include "mprls0025pa.h"
+
+struct mpr_spi_buf {
+	u8 tx[MPR_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
+};
+
+static int mpr_spi_init(struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct mpr_spi_buf *buf;
+
+	buf = devm_kzalloc(dev, sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, buf);
+
+	return 0;
+}
+
+static int mpr_spi_xfer(struct mpr_data *data, const u8 cmd, const u8 pkt_len)
+{
+	struct spi_device *spi = to_spi_device(data->dev);
+	struct mpr_spi_buf *buf = spi_get_drvdata(spi);
+	struct spi_transfer xfer;
+
+	if (pkt_len > MPR_MEASUREMENT_RD_SIZE)
+		return -EOVERFLOW;
+
+	buf->tx[0] = cmd;
+	xfer.tx_buf = buf->tx;
+	xfer.rx_buf = data->buffer;
+	xfer.len = pkt_len;
+
+	return spi_sync_transfer(spi, &xfer, 1);
+}
+
+static const struct mpr_ops mpr_spi_ops = {
+	.init = mpr_spi_init,
+	.read = mpr_spi_xfer,
+	.write = mpr_spi_xfer,
+};
+
+static int mpr_spi_probe(struct spi_device *spi)
+{
+	return mpr_common_probe(&spi->dev, &mpr_spi_ops, spi->irq);
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



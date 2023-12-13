Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39740810FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377403AbjLMLV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377300AbjLMLVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:21:24 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B0FF2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:21:29 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c25973988so69558255e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702466488; x=1703071288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+J3VQ5AgIfkGX+EialdKLCs66BF3uuHwTixtHbvZ1Q=;
        b=jEUo05cYnYn3pSW2wj4X93hM5dwmTChl0wU61gmUqfZ25ZkRL2l6QL8MTFKN4Nt4Xb
         c1TQjAxtbyioByzPWY7bNAXehcbh6CBGiZMxJjcK+/n8s09pT8L4s1VtBO3bg3RSCIpI
         wo2ewCnnXAxWDac31/+I35tTvg8zLl1UaKyDxlYbzawuqbeoN0CSKDQxGVmgDcejqnGP
         mu6uI/3EzOWYaB95fR9GixstgI1VArsmzmj60k/iYf5g/9RY25BzSHkby9oGY4y5mLM4
         H/aNnx/KiQCyWfJuDW+sQGVF+auO5UQJb6WQni3PJYJodayE1iMYCLSYh5a6EF5sTSY/
         P6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702466488; x=1703071288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+J3VQ5AgIfkGX+EialdKLCs66BF3uuHwTixtHbvZ1Q=;
        b=FVvHswj+fYkGZa9WTHL9hzy6wvujA7bTxsFjLpCUoMlPMMrqG4v7Erz1VDeZHt5kre
         SSt/k/CnyuAZ9DLBiJ+kHLMKeE5nO2+Xvgr9HCtOn+YgbGUogsky/iL5s7oABs/AjguP
         rG9gOQ6kFTVfA4mZ79TFQ0eKMmWAB/4AnIoFhDlFlHh2s9OcV8SJ9jUNkTskfFr785rE
         Tc2xyrUqQrq2H7UaNW2cZPviEf3NJay5IJ3gu7okO/eToM9X5FYYVAD62VKgD9ppswZk
         eO9W9yfx81+rgtqFhk8R5y5yryQSjOqX2tVW+/7lM0zVFVW+AHl2qda6D8V3OO98Kefq
         tBTQ==
X-Gm-Message-State: AOJu0Yz+ZDIpf2k7rloU1kdRDim68ZxluJnRptYSnnhCDVig9GD8cTT1
        gR7pv2CiiMCBdSmHdjz3UQmxfQ==
X-Google-Smtp-Source: AGHT+IGYmkVaa+wK/toz0y5IdhTZ3xypPkIM4MsJrYwTrYaUeKNsn8ikBKmYyTQXIH3MAH2xYbW85w==
X-Received: by 2002:a05:600c:1c90:b0:401:b6f6:d8fd with SMTP id k16-20020a05600c1c9000b00401b6f6d8fdmr3634566wms.6.1702466487992;
        Wed, 13 Dec 2023 03:21:27 -0800 (PST)
Received: from localhost.localdomain (abordeaux-655-1-152-60.w90-5.abo.wanadoo.fr. [90.5.9.60])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b0040b3515cdf8sm20097617wms.7.2023.12.13.03.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 03:21:27 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH v2 3/3] iio: adc: ad7380: new driver for AD7380 ADCs
Date:   Wed, 13 Dec 2023 05:21:20 -0600
Message-Id: <20231213-ad7380-mainline-v2-3-cd32150d84a3@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
References: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new driver for the AD7380 family ADCs.

The driver currently implements basic support for the AD7380, AD7381,
AD7383, and AD7384 2-channel differential ADCs. Support for additional
single-ended and 4-channel chips that use the same register map as well
as additional features of the chip will be added in future patches.

Co-developed-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
- Fixed CONFIG_AD7380 in Makefile
- rx_buf = st->scan_data.raw instead of rx_buf = &st->scan_data
- Moved iio_push_to_buffers_with_timestamp() outside of if statement
- Removed extra blank lines
- Renamed regulator disable function
- Dropped checking of adi,sdo-mode property (regardless of the actual
	wiring, we can always use 1-wire mode)
- Added available_scan_masks (we always sample two channels at the same time
  so we need to let userspace know this)
- Added check for missing driver match data

 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  16 ++
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7380.c | 464 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 482 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e2a998be5879..5a54620a31b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -438,6 +438,7 @@ S:	Supported
 W:	https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad738x
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+F:	drivers/iio/adc/ad7380.c
 
 AD7877 TOUCHSCREEN DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 35f9867da12c..cbfd626712e3 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -122,6 +122,22 @@ config AD7298
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7298.
 
+config AD7380
+	tristate "Analog Devices AD7380 ADC driver"
+	depends on SPI_MASTER
+	select IIO_BUFFER
+	select IIO_TRIGGER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  AD7380 is a family of simultaneous sampling ADCs that share the same
+	  SPI register map and have similar pinouts.
+
+	  Say yes here to build support for Analog Devices AD7380 ADC and
+	  similar chips.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad7380.
+
 config AD7476
 	tristate "Analog Devices AD7476 1-channel ADCs driver and other similar devices from AD and TI"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index bee11d442af4..9c921c497655 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7292) += ad7292.o
 obj-$(CONFIG_AD7298) += ad7298.o
 obj-$(CONFIG_AD7923) += ad7923.o
+obj-$(CONFIG_AD7380) += ad7380.o
 obj-$(CONFIG_AD7476) += ad7476.o
 obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
 obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
new file mode 100644
index 000000000000..b8025b636b67
--- /dev/null
+++ b/drivers/iio/adc/ad7380.c
@@ -0,0 +1,464 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD738x Simultaneous Sampling SAR ADCs
+ *
+ * Copyright 2017 Analog Devices Inc.
+ * Copyright 2023 BayLibre, SAS
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+/* 2.5V internal reference voltage */
+#define AD7380_INTERNAL_REF_MV		2500
+
+/* reading and writing registers is more reliable at lower than max speed */
+#define AD7380_REG_WR_SPEED_HZ		10000000
+
+#define AD7380_REG_WR			BIT(15)
+#define AD7380_REG_REGADDR		GENMASK(14, 12)
+#define AD7380_REG_DATA			GENMASK(11, 0)
+
+#define AD7380_REG_ADDR_NOP		0x0
+#define AD7380_REG_ADDR_CONFIG1		0x1
+#define AD7380_REG_ADDR_CONFIG2		0x2
+#define AD7380_REG_ADDR_ALERT		0x3
+#define AD7380_REG_ADDR_ALERT_LOW_TH	0x4
+#define AD7380_REG_ADDR_ALERT_HIGH_TH	0x5
+
+#define AD7380_CONFIG1_OS_MODE		BIT(9)
+#define AD7380_CONFIG1_OSR		GENMASK(8, 6)
+#define AD7380_CONFIG1_CRC_W		BIT(5)
+#define AD7380_CONFIG1_CRC_R		BIT(4)
+#define AD7380_CONFIG1_ALERTEN		BIT(3)
+#define AD7380_CONFIG1_RES		BIT(2)
+#define AD7380_CONFIG1_REFSEL		BIT(1)
+#define AD7380_CONFIG1_PMODE		BIT(0)
+
+#define AD7380_CONFIG2_SDO2		GENMASK(9, 8)
+#define AD7380_CONFIG2_SDO		BIT(8)
+#define AD7380_CONFIG2_RESET		GENMASK(7, 0)
+
+#define AD7380_CONFIG2_RESET_SOFT	0x3C
+#define AD7380_CONFIG2_RESET_HARD	0xFF
+
+#define AD7380_ALERT_LOW_TH		GENMASK(11, 0)
+#define AD7380_ALERT_HIGH_TH		GENMASK(11, 0)
+
+struct ad7380_chip_info {
+	const char *name;
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+};
+
+#define AD7380_DIFFERENTIAL_CHANNEL(index, bits) {		\
+	.type = IIO_VOLTAGE,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.indexed = 1,						\
+	.differential = 1,					\
+	.channel = 2 * (index),					\
+	.channel2 = 2 * (index) + 1,				\
+	.scan_index = (index),					\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = (bits),				\
+		.storagebits = 16,				\
+		.endianness = IIO_CPU,				\
+	},							\
+}
+
+#define DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(name, bits)	\
+static const struct iio_chan_spec name[] = {			\
+		AD7380_DIFFERENTIAL_CHANNEL(0, bits),		\
+		AD7380_DIFFERENTIAL_CHANNEL(1, bits),		\
+		IIO_CHAN_SOFT_TIMESTAMP(2),			\
+}
+
+/* fully differential */
+DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7380_channels, 16);
+DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7381_channels, 14);
+/* pseudo differential */
+DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7383_channels, 16);
+DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7384_channels, 14);
+
+/* Since this is simultaneous sampling, we don't allow individual channels. */
+static const unsigned long ad7380_2_channel_scan_masks[] = {
+	GENMASK(2, 0), /* both ADC channels and soft timestamp */
+	GENMASK(1, 0), /* both ADC channels, no timestamp */
+	0
+};
+
+static const struct ad7380_chip_info ad7380_chip_info = {
+	.name = "ad7380",
+	.channels = ad7380_channels,
+	.num_channels = ARRAY_SIZE(ad7380_channels),
+};
+
+static const struct ad7380_chip_info ad7381_chip_info = {
+	.name = "ad7381",
+	.channels = ad7381_channels,
+	.num_channels = ARRAY_SIZE(ad7381_channels),
+};
+
+static const struct ad7380_chip_info ad7383_chip_info = {
+	.name = "ad7383",
+	.channels = ad7383_channels,
+	.num_channels = ARRAY_SIZE(ad7383_channels),
+};
+
+static const struct ad7380_chip_info ad7384_chip_info = {
+	.name = "ad7384",
+	.channels = ad7384_channels,
+	.num_channels = ARRAY_SIZE(ad7384_channels),
+};
+
+struct ad7380_state {
+	const struct ad7380_chip_info *chip_info;
+	struct spi_device *spi;
+	struct regulator *vref;
+	struct regmap *regmap;
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 * Make the buffer large enough for 2 16-bit samples and one 64-bit
+	 * aligned 64 bit timestamp.
+	 */
+	struct {
+		u16 raw[2];
+		s64 ts __aligned(8);
+	} scan_data __aligned(IIO_DMA_MINALIGN);
+	u16 tx[2];
+	u16 rx[2];
+};
+
+static int ad7380_regmap_reg_write(void *context, unsigned int reg,
+				   unsigned int val)
+{
+	struct ad7380_state *st = context;
+	struct spi_transfer xfer = {
+		.speed_hz = AD7380_REG_WR_SPEED_HZ,
+		.bits_per_word = 16,
+		.len = 2,
+		.tx_buf = &st->tx[0],
+	};
+
+	st->tx[0] = FIELD_PREP(AD7380_REG_WR, 1) |
+		    FIELD_PREP(AD7380_REG_REGADDR, reg) |
+		    FIELD_PREP(AD7380_REG_DATA, val);
+
+	return spi_sync_transfer(st->spi, &xfer, 1);
+}
+
+static int ad7380_regmap_reg_read(void *context, unsigned int reg,
+				  unsigned int *val)
+{
+	struct ad7380_state *st = context;
+	struct spi_transfer xfers[] = {
+		{
+			.speed_hz = AD7380_REG_WR_SPEED_HZ,
+			.bits_per_word = 16,
+			.len = 2,
+			.tx_buf = &st->tx[0],
+			.cs_change = 1,
+			.cs_change_delay = {
+				.value = 10, /* t[CSH] */
+				.unit = SPI_DELAY_UNIT_NSECS,
+			},
+		}, {
+			.speed_hz = AD7380_REG_WR_SPEED_HZ,
+			.bits_per_word = 16,
+			.len = 2,
+			.rx_buf = &st->rx[0],
+		},
+	};
+	int ret;
+
+	st->tx[0] = FIELD_PREP(AD7380_REG_WR, 0) |
+		    FIELD_PREP(AD7380_REG_REGADDR, reg) |
+		    FIELD_PREP(AD7380_REG_DATA, 0);
+
+	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
+	if (ret < 0)
+		return ret;
+
+	*val = FIELD_GET(AD7380_REG_DATA, st->rx[0]);
+
+	return 0;
+}
+
+const struct regmap_config ad7380_regmap_config = {
+	.reg_bits = 3,
+	.val_bits = 12,
+	.reg_read = ad7380_regmap_reg_read,
+	.reg_write = ad7380_regmap_reg_write,
+	.max_register = AD7380_REG_ADDR_ALERT_HIGH_TH,
+	.can_sleep = true,
+};
+
+static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
+				     u32 writeval, u32 *readval)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	if (readval)
+		ret = regmap_read(st->regmap, reg, readval);
+	else
+		ret = regmap_write(st->regmap, reg, writeval);
+
+	iio_device_release_direct_mode(indio_dev);
+
+	return ret;
+}
+
+static irqreturn_t ad7380_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad7380_state *st = iio_priv(indio_dev);
+	struct spi_transfer xfer = {
+		.bits_per_word = st->chip_info->channels[0].scan_type.realbits,
+		.len = 4,
+		.rx_buf = st->scan_data.raw,
+	};
+	int ret;
+
+	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	if (ret)
+		goto out;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan_data,
+					   pf->timestamp);
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int ad7380_read_direct(struct ad7380_state *st,
+			      struct iio_chan_spec const *chan, int *val)
+{
+	struct spi_transfer xfers[] = {
+		/* toggle CS (no data xfer) to trigger a conversion */
+		{
+			.speed_hz = AD7380_REG_WR_SPEED_HZ,
+			.bits_per_word = chan->scan_type.realbits,
+			.delay = {
+				.value = 190, /* t[CONVERT] */
+				.unit = SPI_DELAY_UNIT_NSECS,
+			},
+			.cs_change = 1,
+			.cs_change_delay = {
+				.value = 10, /* t[CSH] */
+				.unit = SPI_DELAY_UNIT_NSECS,
+			},
+		},
+		/* then read both channels */
+		{
+			.speed_hz = AD7380_REG_WR_SPEED_HZ,
+			.bits_per_word = chan->scan_type.realbits,
+			.rx_buf = &st->rx[0],
+			.len = 4,
+		},
+	};
+	int ret;
+
+	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
+	if (ret < 0)
+		return ret;
+
+	*val = sign_extend32(st->rx[chan->scan_index],
+			     chan->scan_type.realbits - 1);
+
+	return IIO_VAL_INT;
+}
+
+static int ad7380_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = ad7380_read_direct(st, chan, val);
+		iio_device_release_direct_mode(indio_dev);
+
+		return ret;
+	case IIO_CHAN_INFO_SCALE:
+		if (st->vref) {
+			ret = regulator_get_voltage(st->vref);
+			if (ret < 0)
+				return ret;
+
+			*val = ret / 1000;
+		} else {
+			*val = AD7380_INTERNAL_REF_MV;
+		}
+
+		*val2 = chan->scan_type.realbits;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info ad7380_info = {
+	.read_raw = &ad7380_read_raw,
+	.debugfs_reg_access = &ad7380_debugfs_reg_access,
+};
+
+static int ad7380_init(struct ad7380_state *st)
+{
+	int ret;
+
+	/* perform hard reset */
+	ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
+				 AD7380_CONFIG2_RESET,
+				 FIELD_PREP(AD7380_CONFIG2_RESET,
+					    AD7380_CONFIG2_RESET_HARD));
+	if (ret < 0)
+		return ret;
+
+	/* select internal or external reference voltage */
+	ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
+				 AD7380_CONFIG1_REFSEL,
+				 FIELD_PREP(AD7380_CONFIG1_REFSEL, !!st->vref));
+	if (ret < 0)
+		return ret;
+
+	/* SPI 1-wire mode */
+	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
+				  AD7380_CONFIG2_SDO,
+				  FIELD_PREP(AD7380_CONFIG2_SDO, 1));
+}
+
+static void ad7380_regulator_disable(void *p)
+{
+	regulator_disable(p);
+}
+
+static int ad7380_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct ad7380_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return dev_err_probe(&spi->dev, -EINVAL, "missing match data\n");
+
+	st->vref = devm_regulator_get_optional(&spi->dev, "refio");
+	if (IS_ERR(st->vref)) {
+		/*
+		 * If there is no REFIO supply, then it means that we are using
+		 * the internal 2.5V reference.
+		 */
+		if (PTR_ERR(st->vref) == -ENODEV)
+			st->vref = NULL;
+		else
+			return dev_err_probe(&spi->dev, PTR_ERR(st->vref),
+					     "Failed to get refio regulator\n");
+	}
+
+	if (st->vref) {
+		ret = regulator_enable(st->vref);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7380_regulator_disable,
+					       st->vref);
+		if (ret)
+			return ret;
+	}
+
+	st->regmap = devm_regmap_init(&spi->dev, NULL, st, &ad7380_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
+				     "failed to allocate register map\n");
+
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = st->chip_info->name;
+	indio_dev->info = &ad7380_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->available_scan_masks = ad7380_2_channel_scan_masks;
+
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      ad7380_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
+	ret = ad7380_init(st);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id ad7380_of_match_table[] = {
+	{ .compatible = "adi,ad7380", .data = &ad7380_chip_info },
+	{ .compatible = "adi,ad7381", .data = &ad7381_chip_info },
+	{ .compatible = "adi,ad7383", .data = &ad7383_chip_info },
+	{ .compatible = "adi,ad7384", .data = &ad7384_chip_info },
+	{ }
+};
+
+static const struct spi_device_id ad7380_id_table[] = {
+	{ "ad7380", (kernel_ulong_t)&ad7380_chip_info },
+	{ "ad7381", (kernel_ulong_t)&ad7381_chip_info },
+	{ "ad7383", (kernel_ulong_t)&ad7383_chip_info },
+	{ "ad7384", (kernel_ulong_t)&ad7384_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad7380_id_table);
+
+static struct spi_driver ad7380_driver = {
+	.driver = {
+		.name = "ad7380",
+		.of_match_table = ad7380_of_match_table,
+	},
+	.probe = ad7380_probe,
+	.id_table = ad7380_id_table,
+};
+module_spi_driver(ad7380_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD738x ADC driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


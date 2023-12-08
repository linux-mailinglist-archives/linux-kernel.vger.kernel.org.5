Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBDF80A7EE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574429AbjLHPwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574379AbjLHPwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:52:34 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83324173F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:52:39 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d9e9b72ecfso482517a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702050759; x=1702655559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmJuRdP3O/ZSJRjxTAVnHQ3nmd13RM5mLsgR/Ebj3Jk=;
        b=url98Hg3h+VDqcI5K68BBfHfN7dA8lfCBBwqseXW8xekHmATBFlq4rKMum80pK8Lco
         /b39nJiprZAXX5S0xE1ywj1PUlY7TZgF68lKW1BcqZlDWydK8vJrUPnW8M58Vgk3zo2v
         P72oXu8tDcgFh9Juit2aCaszt1Ahdz/gzsWPitBJZW+1C64l2PrFOuZEDLNw3OEWAM+z
         aUem6vJ2YpGKXnwvzLHfoxSQLZAICNE70WxP4+W6oRYwtPt3g1iYyA3pyQRLOkGNFwIn
         K4pHXjK3awxWBy+1RW3TSU2KOeK8/tG3Ot/RsXZjUg+WGA8L33T4CNeurRrw+4Ap9t6u
         12Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050759; x=1702655559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmJuRdP3O/ZSJRjxTAVnHQ3nmd13RM5mLsgR/Ebj3Jk=;
        b=WBX8X7qvTHSNH3PwhZNXubFRsCaSdHB3bS4T4GnEPSG0ec4nhkKobFm7X/hZ/SnfC9
         WBaUvyAjRho+IfjTxwAp74NH7SPf85Vyni89BQOGkiXByb/iDWdt4s+ZN+Qiwgzf+PyQ
         NeNhuG5STPy+8M1K6+I2da8XD0sixl5tXVbKVI2SKqZhdvXEh9wzrd0/T8iTVQQ5pha2
         h9ANoZmlQBNb4iFgpzX7+lQkGm8LL2uB9WZJL4NKbjVKUWJqF1CbPVjaw8eVKqBZbCJC
         cm/9E9mQQHtNNJkPEJzYkVlUvtWQaF5kG4hetH40WE7NegMDm7I2d/cnAi/YwX89DMOp
         jSEQ==
X-Gm-Message-State: AOJu0YyjOerdNS36UaOtAORE3mEr9Ls00Cbv/ydr7RWZoeljj6sTASRK
        xclpYwgniXkvLuVIaLX8NLYAXA==
X-Google-Smtp-Source: AGHT+IG+jNUXFCzt+8HN/E6I0Sc5myARsi+3lXLrwg50UgWtfEQRkg4cms244aRKyZd2h5O5NHexkA==
X-Received: by 2002:a05:6830:1e04:b0:6d9:df71:9fc2 with SMTP id s4-20020a0568301e0400b006d9df719fc2mr266937otr.8.1702050758783;
        Fri, 08 Dec 2023 07:52:38 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id v3-20020a9d7d03000000b006d99d363723sm332032otn.63.2023.12.08.07.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:52:38 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH 2/2] iio: adc: ad7380: new driver for AD7380 ADCs
Date:   Fri,  8 Dec 2023 09:51:41 -0600
Message-ID: <20231208-ad7380-mainline-v1-2-2b33fe2f44ae@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208-ad7380-mainline-v1-0-2b33fe2f44ae@baylibre.com>
References: <20231208-ad7380-mainline-v1-0-2b33fe2f44ae@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  16 ++
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7380.c | 467 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 485 insertions(+)

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
index bee11d442af4..e046d8004f41 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7292) += ad7292.o
 obj-$(CONFIG_AD7298) += ad7298.o
 obj-$(CONFIG_AD7923) += ad7923.o
+obj-$(CONFIG_AD7476) += ad7380.o
 obj-$(CONFIG_AD7476) += ad7476.o
 obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
 obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
new file mode 100644
index 000000000000..6a5ec59bd1fd
--- /dev/null
+++ b/drivers/iio/adc/ad7380.c
@@ -0,0 +1,467 @@
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
+		.rx_buf = &st->scan_data,
+	};
+	int ret;
+
+	ret = spi_sync_transfer(st->spi, &xfer, 1);
+
+	if (ret == 0)
+		iio_push_to_buffers_with_timestamp(indio_dev, &st->scan_data,
+						   pf->timestamp);
+
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
+
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
+static void ad7380_release_regulator(void *p)
+{
+	struct regulator *reg = p;
+
+	regulator_disable(reg);
+}
+
+static int ad7380_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct ad7380_state *st;
+	const char *str_val;
+	int ret;
+
+	ret = device_property_read_string(&spi->dev, "adi,sdo-mode", &str_val);
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to read adi,sdo-mode property\n");
+
+	if (strcmp(str_val, "1-wire"))
+		return dev_err_probe(&spi->dev, -EINVAL,
+				     "Only 1-wire SDO is supported\n");
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+	st->chip_info = spi_get_device_match_data(spi);
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
+		ret = devm_add_action_or_reset(&spi->dev, ad7380_release_regulator,
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
+
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = st->chip_info->name;
+	indio_dev->info = &ad7380_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
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
2.43.0


Return-Path: <linux-kernel+bounces-55368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F305484BBD2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF9B2867F1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0353D536;
	Tue,  6 Feb 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XOeyTAn9"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4FF9475
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240410; cv=none; b=TDxcZpWPTD3juqfDDhCoapQCU+LoRbqF2AoQD0sDh1gy1D2uCDdxA6EoP8lBxKT1956e68nSYriof318XOr/jw1s3/X51YjHw4R3UoYLmab1b8D7g4P1P6TJGWPVcGv06X4TH7qiasV8TIEEFTWp0V3y7t8G3oVCDAJQ8K8IiUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240410; c=relaxed/simple;
	bh=XazVMLOJbAM/gRdK8X+BC5+I8+DqhQnRcd7DYAIkeH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YM1eNnC6O0CKtmFytWSOgwB6wT8MoGFVcE0D91AaujIn85CJ9FG7u8VfWwD1jm/Y2ab4yqPI2YxmZTXy8Y3mhIjBRMGJbm8323hfxJbVWGQjkhcSLjvplaTxJGybyOhXPMXA/64jLhTjZEx23FNII0sA/Xij30vK7zlHUaoxF1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XOeyTAn9; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21920c78c9fso2523632fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 09:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707240407; x=1707845207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8g2rdQmtRie8AcqF2+eOMTdU5EzOPlbdREIl+iEY+OE=;
        b=XOeyTAn9EeoaanKtTiBWfhS5XDR6SzgSEMxwi0EGyd/lgfNI6I0etzXZzolkgerQdp
         DswXPSBGDoxM12AFCv3VOTNXxAsvYfG7xZ/PhL2fODTV1VOQvARmpgyocETPVVi0CjKl
         B6TQjFxkHbO0bc0z+NwRq9QbuQhf5Blmu7f3K13BetPI4smQKpqE3frn3l0GCWRBN4No
         O/bY+UWPlBGZUFXO5u9lvcSZe+TuFp7IDHgWou+I8fv1Q9Cd3DiID8rBv/FU+BqKCPdW
         WeuTzlmaMh7Qy1a67bkiffrH72qSvUDl+VockJy8Ff3qo7VMCmhJgZvWeFB9H4jd0k6b
         RojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240407; x=1707845207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8g2rdQmtRie8AcqF2+eOMTdU5EzOPlbdREIl+iEY+OE=;
        b=VU0jQ7eOi/7FbfX94DK6hrhfXZEMcbhB626HBNjj1fM5CeLMz5BCgxKUkT0vv2YwD9
         2FLjJSd59JNY/YFcqL5NTpc6a+9/tBndUir7KRZXhzk5hgyY9HrjxuVu6GUPKOf/eV1D
         MykVGsrbQRKkqWZNqmez907xlLFohM7sFx7/q78tp7/AYcTwdMohMlhBVMpd7NFzm4ib
         yzUUnR5WLmyUpPacEfBH/IZSkVoBC52w4JQjSe8ebLb+yqhwXEhsNid7jC2P+HuWqZ31
         s6fDQF+y++cttr9aXUUoBEa/4NPNz3y2e6nna015KMuvKJRu80r3AGkwckcX0hT7Mxy2
         TNpA==
X-Gm-Message-State: AOJu0YzwNyC214+Fkl5oytLd3xY/nmvDCZbHSVN9/aEukH2omW30A9+5
	zr7YLl+6DOQqKHa+uVbnjgd4Vwe/52fNVBzQ0Ac01d0zNc/qg1oTXqf5qTvgQE0=
X-Google-Smtp-Source: AGHT+IFixp22bnaccJNRQo3rWx/lJOX46yadt23imDFI5PRO9exuyLujAYb7hkTWwnGtAZ4dAZAJ7w==
X-Received: by 2002:a05:6870:c0e:b0:218:f80e:a30b with SMTP id le14-20020a0568700c0e00b00218f80ea30bmr3962702oab.16.1707240407607;
        Tue, 06 Feb 2024 09:26:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVpU7Qgz3FFw52Gd/dutoeA3z4EKBnZC+7llD48XgyvHsu21orxd0Eehc2v4IEcS9ICTWTLORnUzd0ntaj72wjQKX5DX3bBe7fHDfD2Vk27ZKTM0G3H8sg4+um539fx0YuYtFsXDIleFB9Bm3FtNBPmbryphsIKcpZYs/Ml1CrPet4z5/kEBrnzOHLz6aqXyjrBbcy5wDEv1PPLkJjvQt4QciXDCM0Ja8JuBF+5AOm6AMSgefVJC2/vHLZ4SkNHy8QBnJIx4Y3b8R1/hDzgDN4v+wBtbepWjDzjIqvuqUzMu+3SZshcBQO/Cegy1c/lLk9bWdu9whfDFJ7gWYyN0JcpCh/QeOtBvzRrJq7xg5Lqs0luOhaW3TuPAYEk82a76bZL
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id ea9-20020a056870070900b0021998dc2bf1sm510172oab.36.2024.02.06.09.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:26:47 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: ad7944: add driver for AD7944/AD7985/AD7986
Date: Tue,  6 Feb 2024 11:26:00 -0600
Message-ID: <20240206-ad7944-mainline-v1-2-bf115fa9474f@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
References: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds a driver for the Analog Devices Inc. AD7944, AD7985, and
AD7986 ADCs. These are a family of pin-compatible ADCs that can sample
at rates up to 2.5 MSPS.

The initial driver adds support for sampling at lower rates using the
usual IIO triggered buffer and can handle all 3 possible reference
voltage configurations.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  10 ++
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7944.c | 397 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 409 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f1e658e1e0d..83d8367595f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -458,6 +458,7 @@ R:	David Lechner <dlechner@baylibre.com>
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
+F:	drivers/iio/adc/ad7944.c
 
 ADAFRUIT MINI I2C GAMEPAD
 M:	Anshul Dalal <anshulusr@gmail.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 59ae1d17b50d..93fbe6f8e306 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -280,6 +280,16 @@ config AD7923
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7923.
 
+config AD7944
+	tristate "Analog Devices AD7944 and similar ADCs driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices
+	  AD7944, AD7985, AD7986 ADCs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7944
+
 config AD7949
 	tristate "Analog Devices AD7949 and similar ADCs driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 5a26ab6f1109..52d803b92cd7 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_AD7780) += ad7780.o
 obj-$(CONFIG_AD7791) += ad7791.o
 obj-$(CONFIG_AD7793) += ad7793.o
 obj-$(CONFIG_AD7887) += ad7887.o
+obj-$(CONFIG_AD7944) += ad7944.o
 obj-$(CONFIG_AD7949) += ad7949.o
 obj-$(CONFIG_AD799X) += ad799x.o
 obj-$(CONFIG_AD9467) += ad9467.o
diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
new file mode 100644
index 000000000000..67b525fb8e59
--- /dev/null
+++ b/drivers/iio/adc/ad7944.c
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD7944/85/86 PulSAR ADC family driver.
+ *
+ * Copyright 2024 Analog Devices, Inc.
+ * Copyright 2024 Baylibre, SAS
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define AD7944_INTERNAL_REF_MV		4096
+
+struct ad7944_timing_spec {
+	/* Normal mode minimum CNV pulse width in nanoseconds. */
+	unsigned int cnv_ns;
+	/* TURBO mode minimum CNV pulse width in nanoseconds. */
+	unsigned int turbo_cnv_ns;
+};
+
+struct ad7944_adc {
+	struct spi_device *spi;
+	/* Chip-specific timing specifications. */
+	const struct ad7944_timing_spec *t;
+	/* GPIO connected to CNV pin. */
+	struct gpio_desc *cnv;
+	/* Optional GPIO to enable turbo mode. */
+	struct gpio_desc *turbo;
+	/* Indicates TURBO is hard-wired to be always enabled. */
+	bool always_turbo;
+	/* Reference voltage (millivolts). */
+	unsigned int ref_mv;
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	struct {
+		union {
+			u16 u16;
+			u32 u32;
+		} raw;
+		u64 timestamp __aligned(8);
+	 } sample __aligned(IIO_DMA_MINALIGN);
+};
+
+static const struct ad7944_timing_spec ad7944_timing_spec = {
+	.cnv_ns = 420,
+	.turbo_cnv_ns = 320,
+};
+
+static const struct ad7944_timing_spec ad7986_timing_spec = {
+	.cnv_ns = 500,
+	.turbo_cnv_ns = 400,
+};
+
+struct ad7944_chip_info {
+	const char *name;
+	const struct ad7944_timing_spec *t;
+	const struct iio_chan_spec channels[2];
+};
+
+#define AD7944_DEFINE_CHIP_INFO(_name, _t, _bits, _sign)		\
+static const struct ad7944_chip_info _name##_chip_info = {		\
+	.name = #_name,							\
+	.t = &_t##_timing_spec,						\
+	.channels = {							\
+		{							\
+			.type = IIO_VOLTAGE,				\
+			.indexed = 1,					\
+			.differential = 1,				\
+			.channel = 0,					\
+			.channel2 = 1,					\
+			.scan_index = 0,				\
+			.scan_type.sign = _sign,			\
+			.scan_type.realbits = _bits,			\
+			.scan_type.storagebits = _bits > 16 ? 32 : 16,	\
+			.scan_type.endianness = IIO_CPU,		\
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	\
+					| BIT(IIO_CHAN_INFO_SCALE),	\
+		},							\
+		IIO_CHAN_SOFT_TIMESTAMP(1),				\
+	},								\
+}
+
+AD7944_DEFINE_CHIP_INFO(ad7944, ad7944, 14, 'u');
+AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 'u');
+AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 's');
+
+/**
+ * ad7944_4_wire_mode_conversion - Perform a 4-wire mode conversion and acquisition
+ * @adc: The ADC device structure
+ * @chan: The channel specification
+ * Return: 0 on success, a negative error code on failure
+ *
+ * Upon successful return adc->sample.raw will contain the conversion result.
+ */
+static int ad7944_4_wire_mode_conversion(struct ad7944_adc *adc,
+					 const struct iio_chan_spec *chan)
+{
+	unsigned int t_cnv_ns = adc->always_turbo ? adc->t->turbo_cnv_ns
+						  : adc->t->cnv_ns;
+	struct spi_transfer xfers[] = {
+		{
+			/*
+			 * NB: can get better performance from some SPI
+			 * controllers if we use the same bits_per_word
+			 * in every transfer.
+			 */
+			.bits_per_word = chan->scan_type.realbits,
+			/*
+			 * CS has to be high for full conversion time to avoid
+			 * triggering the busy indication.
+			 */
+			.cs_off = 1,
+			.delay = {
+				.value = t_cnv_ns,
+				.unit = SPI_DELAY_UNIT_NSECS,
+			},
+
+		},
+		{
+			.rx_buf = &adc->sample.raw,
+			.len = BITS_TO_BYTES(chan->scan_type.storagebits),
+			.bits_per_word = chan->scan_type.realbits,
+		},
+	};
+	int ret;
+
+	/*
+	 * In 4-wire mode, the CNV line is held high for the entire conversion
+	 * and acquisition process.
+	 */
+	gpiod_set_value_cansleep(adc->cnv, 1);
+
+	ret = spi_sync_transfer(adc->spi, xfers, ARRAY_SIZE(xfers));
+	if (ret)
+		return ret;
+
+	gpiod_set_value_cansleep(adc->cnv, 0);
+
+	return 0;
+}
+
+static int ad7944_single_conversion(struct ad7944_adc *adc,
+				    const struct iio_chan_spec *chan,
+				    int *val)
+{
+	int ret;
+
+	ret = ad7944_4_wire_mode_conversion(adc, chan);
+	if (ret)
+		return ret;
+
+	if (chan->scan_type.storagebits > 16)
+		*val = adc->sample.raw.u32;
+	else
+		*val = adc->sample.raw.u16;
+
+	if (chan->scan_type.sign == 's')
+		*val = sign_extend32(*val, chan->scan_type.realbits - 1);
+
+	return IIO_VAL_INT;
+}
+
+static int ad7944_read_raw(struct iio_dev *indio_dev,
+			   const struct iio_chan_spec *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad7944_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = ad7944_single_conversion(adc, chan, val);
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = adc->ref_mv;
+			*val2 = chan->scan_type.realbits;
+
+			return IIO_VAL_FRACTIONAL_LOG2;
+		default:
+			return -EINVAL;
+		}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ad7944_iio_info = {
+	.read_raw = &ad7944_read_raw,
+};
+
+static irqreturn_t ad7944_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad7944_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	ret = ad7944_4_wire_mode_conversion(adc, &indio_dev->channels[0]);
+	if (ret)
+		goto out;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &adc->sample.raw,
+					   indio_dev->scan_timestamp);
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static const char * const ad7944_power_supplies[] = {
+	"avdd",	"dvdd",	"bvdd", "vio"
+};
+
+static void ad7944_ref_disable(void *ref)
+{
+	regulator_disable(ref);
+}
+
+static int ad7944_probe(struct spi_device *spi)
+{
+	const struct ad7944_chip_info *chip_info;
+	struct iio_dev *indio_dev;
+	struct ad7944_adc *adc;
+	struct regulator *ref;
+	const char *str_val;
+	int ret;
+
+	/* adi,spi-mode property defaults to "4-wire" if not present */
+	if (device_property_read_string(&spi->dev, "adi,spi-mode", &str_val) < 0)
+		str_val = "4-wire";
+
+	if (strcmp(str_val, "4-wire"))
+		return dev_err_probe(&spi->dev, -EINVAL,
+				     "only \"4-wire\" mode is currently supported\n");
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc = iio_priv(indio_dev);
+	adc->spi = spi;
+
+	chip_info = spi_get_device_match_data(spi);
+	if (!chip_info)
+		return dev_err_probe(&spi->dev, -EINVAL, "no chip info\n");
+
+	adc->t = chip_info->t;
+
+	/*
+	 * Some chips use unusual word sizes, so check now instead of waiting
+	 * for the first xfer.
+	 */
+	if (!spi_is_bpw_supported(spi, chip_info->channels[0].scan_type.realbits))
+		return dev_err_probe(&spi->dev, -EINVAL,
+				"SPI host does not support %d bits per word\n",
+				chip_info->channels[0].scan_type.realbits);
+
+	ret = devm_regulator_bulk_get_enable(&spi->dev,
+					     ARRAY_SIZE(ad7944_power_supplies),
+					     ad7944_power_supplies);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "failed to get and enable supplies\n");
+
+	/* adi,reference property defaults to "internal" if not present */
+	if (device_property_read_string(&spi->dev, "adi,reference", &str_val) < 0)
+		str_val = "internal";
+
+	/* sort out what is being used for the reference voltage */
+	if (strcmp(str_val, "internal") == 0) {
+		/* internal reference is used */
+		adc->ref_mv = AD7944_INTERNAL_REF_MV;
+	} else if (strcmp(str_val, "internal-buffer") == 0) {
+		/* external 1.2V REFIN and internal buffer is used */
+		ret = devm_regulator_get_enable_optional(&spi->dev, "refin");
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					"failed to get and enable REFIN supply\n");
+
+		adc->ref_mv = AD7944_INTERNAL_REF_MV;
+	} else if (strcmp(str_val, "external") == 0) {
+		/* external reference is used */
+		ref = devm_regulator_get_optional(&spi->dev, "ref");
+		if (IS_ERR(ref))
+			return dev_err_probe(&spi->dev, PTR_ERR(ref),
+					     "failed to get REF supply\n");
+
+		ret = regulator_enable(ref);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "failed to enable REF supply\n");
+
+		ret = devm_add_action_or_reset(&spi->dev,
+					       ad7944_ref_disable, ref);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(ref);
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "failed to get REF voltage\n");
+
+		adc->ref_mv = ret / 1000;
+	} else {
+		return dev_err_probe(&spi->dev, -EINVAL,
+				     "invalid adi,reference property: %s\n",
+				     str_val);
+	}
+
+	adc->cnv = devm_gpiod_get(&spi->dev, "cnv", GPIOD_OUT_LOW);
+	if (IS_ERR(adc->cnv))
+		return dev_err_probe(&spi->dev, PTR_ERR(adc->cnv),
+				     "failed to get CNV GPIO\n");
+
+	adc->turbo = devm_gpiod_get_optional(&spi->dev, "turbo", GPIOD_OUT_LOW);
+	if (IS_ERR(adc->turbo))
+		return dev_err_probe(&spi->dev, PTR_ERR(adc->turbo),
+				     "failed to get TURBO GPIO\n");
+
+	if (device_property_present(&spi->dev, "adi,always-turbo"))
+		adc->always_turbo = true;
+
+	if (adc->turbo && adc->always_turbo)
+		return dev_err_probe(&spi->dev, -EINVAL,
+			"cannot have both turbo-gpios and adi,always-turbo\n");
+
+	indio_dev->name = chip_info->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ad7944_iio_info;
+	indio_dev->channels = chip_info->channels;
+	indio_dev->num_channels = ARRAY_SIZE(chip_info->channels);
+
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      ad7944_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id ad7944_of_match[] = {
+	{ .compatible = "adi,ad7944", .data = &ad7944_chip_info },
+	{ .compatible = "adi,ad7985", .data = &ad7985_chip_info },
+	{ .compatible = "adi,ad7986", .data = &ad7986_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7944_of_match);
+
+static const struct spi_device_id ad7944_spi_id[] = {
+	{ "ad7944", (kernel_ulong_t)&ad7944_chip_info },
+	{ "ad7985", (kernel_ulong_t)&ad7985_chip_info },
+	{ "ad7986", (kernel_ulong_t)&ad7986_chip_info },
+	{ }
+
+};
+MODULE_DEVICE_TABLE(spi, ad7944_spi_id);
+
+static struct spi_driver ad7944_driver = {
+	.driver = {
+		.name = "ad7944",
+		.of_match_table = ad7944_of_match,
+	},
+	.probe = ad7944_probe,
+	.id_table = ad7944_spi_id,
+};
+module_spi_driver(ad7944_driver);
+
+MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
+MODULE_DESCRIPTION("Analog Devices AD7944 PulSAR ADC family driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0



Return-Path: <linux-kernel+bounces-85514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14F586B6ED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B64284ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE8A4087C;
	Wed, 28 Feb 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gmJWgxaq"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B184084E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144042; cv=none; b=lg8trO6rf8eUr8UlKtqav01ivCgQ/888w3H479CDEx2FXcHVMrg4FY7a0deJn8IRvKwtSXghglIiWHV69tyhlO2zKR2x3JwuCCzwCDqONHs4fsPE3CUBH+hA1CaYCLHI9NiVXWKCVkjV8UsLcSAsbYZXLdrYjv+/MVq4BEh+34c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144042; c=relaxed/simple;
	bh=1QfHsIORoXFg+tZIOpYbpH5WNeqMjBeKBcdedB/V6WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lu8KpgQKBcUbtCru6nBrk3Og+iL48ngHvRXePMb0HqArS29kJPRFTMMfZjjau1AJrjV+eJ4HqCiFRJkF8Bo/DZlMGiuzRVru47/pxcrLGglWGdQCebpCZ2ByJofDNS+gsgAufyx139Jy0I16KhDUx9eyyvRLQb7slbWcfTeWAis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gmJWgxaq; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59fd6684316so17558eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709144039; x=1709748839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jcyQueYhRVJP6CrfAlhtw8dKi4Zuon4YwRpnIXMkAg=;
        b=gmJWgxaqleAeeeYAxUVTc4CIFqax/G9OtBLvihB1LdMlp7GijHhLZ+VJ+mqaI7q7jf
         l66nzGYoKKPo1jTX01eBTfS2ZvWFHxuB8Q+9P/wpwmu8tZzyjrw9XHZBZ3Xk2tYwfKc7
         s/CZFmIPpacQv3CU8MPmvxZUBSoBK9WixbQdcthuT9CI+fPuYrU5H5iAq1sinu/9ORnC
         yKanedkz1HEpWCa6xS7XAnRXbM8f/AgKoRPLKjgauJOUUUWf6z44mUlOiGi9Lyf4HNw+
         vC26KurCoyE2UHiaYhDQ5dWdRLCEvsgyB8W8XDoiVmiFqH7+UQMrQlv5BFFh3BdeNG5q
         RPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709144039; x=1709748839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jcyQueYhRVJP6CrfAlhtw8dKi4Zuon4YwRpnIXMkAg=;
        b=sPB1EJc6PyRpSeZ/eEFymc1iLCKms/M5fzRdO5QvP1PejO7AQNjpD+nJKdCw0qV0HO
         +7Lm9skINjxAQ8zNriZBYisxupKYcWdq+3fABMEQJ/O+MX7bKJJYnsQchiayQlZbqxaE
         3Uj9PbXNlTMhN6fAtV3/Yznshq2eBDdrxsCfsfywF2YSDB0Z9LcwvbTRcSSpX7dbhw6Q
         tHjRLixvfSV0G8ASj2FuvbJrP/ODVF+Ft4fbUb8FiHx5Z98m4ywyEsXBPf9gN+w0zuFy
         DZ93+VQxeCHmScT9HxiUUdzqBKxSoy8gsIQZ/Ei/zHxp5jv8XUbmRrkuqaesRnhenlt6
         3H/A==
X-Forwarded-Encrypted: i=1; AJvYcCUYtwDKuhpkXDrzX3fLWCTimC4hOeZezr7J6d8gPFCgKvCK5MhdLynbO245m5Uqdx1FT27S0PUZm6f0lRST/N4C0Ybqg5HyM8BzImuG
X-Gm-Message-State: AOJu0Yx5TbZOzP6zbQjIu9ZD47kJDlPUP1l9r60Upz3t7VqYLkC6rCmU
	Q5Hj4NuexMxuWirw+JXnCy6qhwjjVyu/l1vc8NpgUfByFgih/MsqnJeeo+WKBPM=
X-Google-Smtp-Source: AGHT+IEcg1g93MVP8mbW8gf2Hi6QtNFAWIgYJsnsIwOe+hL38XGFn22Wsv78WoVP72ORRyMTUdaKGg==
X-Received: by 2002:a4a:d2dc:0:b0:5a0:ab00:28b5 with SMTP id j28-20020a4ad2dc000000b005a0ab0028b5mr428945oos.6.1709144039121;
        Wed, 28 Feb 2024 10:13:59 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f20-20020a4a9d54000000b005a0ac863a99sm12291ook.13.2024.02.28.10.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:13:58 -0800 (PST)
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
Subject: [PATCH v3 2/2] iio: adc: ad7944: add driver for AD7944/AD7985/AD7986
Date: Wed, 28 Feb 2024 12:10:04 -0600
Message-ID: <20240228-ad7944-mainline-v3-2-781b922334af@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228-ad7944-mainline-v3-0-781b922334af@baylibre.com>
References: <20240228-ad7944-mainline-v3-0-781b922334af@baylibre.com>
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

v2 changes:
- Replaced _sign with _diff in chip info struct to properly handle
  pseudo-differential vs. true differential chips. Pseudo-differential chips
  now just have a voltage0 channel instead of voltage0-voltage1.
- Fixed not resetting the CNV gpio on error return.
- Simplified check of adi,spi-mode property now that "multi" is no longer a
  valid option.


 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  10 ++
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7944.c | 413 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 425 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 35f27504632d..7b1a6f2d0c9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -448,6 +448,7 @@ R:	David Lechner <dlechner@baylibre.com>
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
+F:	drivers/iio/adc/ad7944.c
 
 ADAFRUIT MINI I2C GAMEPAD
 M:	Anshul Dalal <anshulusr@gmail.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 0d9282fa67f5..555ac74889f3 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -264,6 +264,16 @@ config AD7923
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
index b3c434722364..a0d69b452cca 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_AD7780) += ad7780.o
 obj-$(CONFIG_AD7791) += ad7791.o
 obj-$(CONFIG_AD7793) += ad7793.o
 obj-$(CONFIG_AD7887) += ad7887.o
+obj-$(CONFIG_AD7944) += ad7944.o
 obj-$(CONFIG_AD7949) += ad7949.o
 obj-$(CONFIG_AD799X) += ad799x.o
 obj-$(CONFIG_AD9467) += ad9467.o
diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
new file mode 100644
index 000000000000..d0ba4ae409c4
--- /dev/null
+++ b/drivers/iio/adc/ad7944.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD7944/85/86 PulSAR ADC family driver.
+ *
+ * Copyright 2024 Analog Devices, Inc.
+ * Copyright 2024 BayLibre, SAS
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
+#include <linux/string_helpers.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define AD7944_INTERNAL_REF_MV		4096
+
+struct ad7944_timing_spec {
+	/* Normal mode max conversion time (t_{CONV}) in nanoseconds. */
+	unsigned int conv_ns;
+	/* TURBO mode max conversion time (t_{CONV}) in nanoseconds. */
+	unsigned int turbo_conv_ns;
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
+	.conv_ns = 420,
+	.turbo_conv_ns = 320,
+};
+
+static const struct ad7944_timing_spec ad7986_timing_spec = {
+	.conv_ns = 500,
+	.turbo_conv_ns = 400,
+};
+
+struct ad7944_chip_info {
+	const char *name;
+	const struct ad7944_timing_spec *t;
+	const struct iio_chan_spec channels[2];
+};
+
+/*
+ * AD7944_DEFINE_CHIP_INFO - Define a chip info structure for a specific chip
+ * @_name: The name of the chip
+ * @_t: The timing specification for the chip
+ * @_bits: The number of bits in the conversion result
+ * @_diff: Whether the chip is true differential or not
+ */
+#define AD7944_DEFINE_CHIP_INFO(_name, _t, _bits, _diff)		\
+static const struct ad7944_chip_info _name##_chip_info = {		\
+	.name = #_name,							\
+	.t = &_t##_timing_spec,						\
+	.channels = {							\
+		{							\
+			.type = IIO_VOLTAGE,				\
+			.indexed = 1,					\
+			.differential = _diff,				\
+			.channel = 0,					\
+			.channel2 = _diff ? 1 : 0,			\
+			.scan_index = 0,				\
+			.scan_type.sign = _diff ? 's' : 'u',		\
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
+/* pseudo-differential with ground sense */
+AD7944_DEFINE_CHIP_INFO(ad7944, ad7944, 14, 0);
+AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 0);
+/* fully differential */
+AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
+
+/*
+ * ad7944_4wire_mode_conversion - Perform a 4-wire mode conversion and acquisition
+ * @adc: The ADC device structure
+ * @chan: The channel specification
+ * Return: 0 on success, a negative error code on failure
+ *
+ * Upon successful return adc->sample.raw will contain the conversion result.
+ */
+static int ad7944_4wire_mode_conversion(struct ad7944_adc *adc,
+					const struct iio_chan_spec *chan)
+{
+	unsigned int t_conv_ns = adc->always_turbo ? adc->t->turbo_conv_ns
+						   : adc->t->conv_ns;
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
+				.value = t_conv_ns,
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
+	ret = spi_sync_transfer(adc->spi, xfers, ARRAY_SIZE(xfers));
+	gpiod_set_value_cansleep(adc->cnv, 0);
+
+	return ret;
+}
+
+static int ad7944_single_conversion(struct ad7944_adc *adc,
+				    const struct iio_chan_spec *chan,
+				    int *val)
+{
+	int ret;
+
+	ret = ad7944_4wire_mode_conversion(adc, chan);
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
+
+			if (chan->scan_type.sign == 's')
+				*val2 = chan->scan_type.realbits - 1;
+			else
+				*val2 = chan->scan_type.realbits;
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
+	ret = ad7944_4wire_mode_conversion(adc, &indio_dev->channels[0]);
+	if (ret)
+		goto out;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &adc->sample.raw,
+					   pf->timestamp);
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
+	bool have_refin = false;
+	struct regulator *ref;
+	int ret;
+
+	/*
+	 * driver currently only supports the conventional "4-wire" mode and
+	 * not other special wiring configurations.
+	 */
+	if (device_property_present(&spi->dev, "adi,spi-mode"))
+		return dev_err_probe(&spi->dev, -EINVAL,
+				     "adi,spi-mode is not currently supported\n");
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
+	/*
+	 * Sort out what is being used for the reference voltage. Options are:
+	 * - internal reference: neither REF or REFIN is connected
+	 * - internal reference with external buffer: REF not connected, REFIN
+	 *   is connected
+	 * - external reference: REF is connected, REFIN is not connected
+	 */
+
+	ref = devm_regulator_get_optional(&spi->dev, "ref");
+	if (IS_ERR(ref)) {
+		if (PTR_ERR(ref) != -ENODEV)
+			ref = NULL;
+		else
+			return dev_err_probe(&spi->dev, PTR_ERR(ref),
+					     "failed to get REF supply\n");
+	}
+
+	ret = devm_regulator_get_enable_optional(&spi->dev, "refin");
+	if (ret == 0)
+		have_refin = true;
+	else if (ret != -ENODEV)
+		return dev_err_probe(&spi->dev, ret,
+				     "failed to get and enable REFIN supply\n");
+
+	if (have_refin && ref)
+		return dev_err_probe(&spi->dev, -EINVAL,
+				     "cannot have both refin and ref supplies\n");
+
+	if (ref) {
+		ret = regulator_enable(ref);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "failed to enable REF supply\n");
+
+		ret = devm_add_action_or_reset(&spi->dev,
+						ad7944_ref_disable, ref);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(ref);
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "failed to get REF voltage\n");
+
+		/* external reference */
+		adc->ref_mv = ret / 1000;
+	} else {
+		/* internal reference */
+		adc->ref_mv = AD7944_INTERNAL_REF_MV;
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
2.43.2



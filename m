Return-Path: <linux-kernel+bounces-103631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F85A87C22F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019EE1F21F53
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CC174BEC;
	Thu, 14 Mar 2024 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g/s7Kuaq"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC7E56B72
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710438249; cv=none; b=bGFmYjARdCi//2aFhhsqNMLLhW8vCYHuvtPEh2UWp3lOyR+kDq/3dkIda8EvKIe45iThHsEtK2M6PgEQkyZHwDgAL1oLdYW0Pj6L6KHfB9CKxGjY94KaR2GVxKP0fKnb9xPYU3vCa9Eaen5yj1fqQVMgjmPi2zowbDk/dnuxL7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710438249; c=relaxed/simple;
	bh=bMS7qno8XSHcHIJW0LJtjXJv9boRl6FZkAn8WIA0xYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f+4rfeiJNK7jTJ2PCQ1Q+P03RBupO0scLlOy1uVZPnyxGLi7u0F1szaEKl3+Sc0skGU4JLo4pMMeHpjiqsyUTxOv/kEJvEVJz49qul42z/4hiZRZsUfgaQafhzttuku+MBeWgZFMt3Vg4Wi0wHdUQR+UteXtLKvvFnIVYsToI3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g/s7Kuaq; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e0f43074edso754589a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710438245; x=1711043045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nHqMVr9UoBNoXr00r6Tp/14yR/buvgklUKV5jTJKppk=;
        b=g/s7Kuaq2Tsre3aOqhhurHu8KqpkJQIBZXh4ZW7KNQj0nB7xNXaxQsef1UHqIX5dqI
         m3KHCa81hpAC0QD5Qgef4gkFxk3PYXihrhoZGPI0GvcsctTmCOoIH/NAj02IthZCERvR
         ogloJ+OXTmtHKn+plaKNoSpE9Q3biy8DL8LnusGPwrDytDioVRqS1TjOtHStcZBMXJKB
         i5lgp+yfN9fjGdDrjaE8dzsnFVo30hGlmor384VRNZH0CNzjEgw57Yy65eXQoMCZhdd2
         pN1fMiv+ShODba2lFX8+RTDJvEhFKwqRKXks9PVpewK/bDyRYcRs/gtaVMhB05cvTDvN
         frWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710438245; x=1711043045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHqMVr9UoBNoXr00r6Tp/14yR/buvgklUKV5jTJKppk=;
        b=S+UoVdwSa2n/coeMXsWvbpu4himb6dg6XPVR7MNz5jqelEkJmKPgGOpCO21hECET+n
         XzyD7Wyu7garLY5wN9JlHvjGJyIQWZ20zqUzzwUHsTrJKqOXySPkpNnoB2SCHpjewE1t
         NsmGgUAzXzdt3vzXuO205eBT1qEA1JacCF6Z4xArkjjYenUMIcjZTjyD0mL2hlLUINYG
         XJCamjeeW8DdopAP/f+7Ru3NwF0/fqDco6op6mj+gVHjAttGvsI1bL4kxNZBLcTUU421
         wkuJ6xK67YT9d/BZTjMKEtX5SDYuAy+3pJDYw+uo0e4We2WH5PT8UABB6iKIDj2T6Ebj
         KZiA==
X-Forwarded-Encrypted: i=1; AJvYcCVp3ueBC8IDeN+ZTTrJ09Y4doJsjsvrsbC+BVKn173jxxZ1c++8BqEn+5yT/9nBjv6kNJZiiNq44x/oyUFSeeqZ0FdI0aGH/Fib6OIW
X-Gm-Message-State: AOJu0Yx4vALvkTsJb47M5RJ8dZ8/Bktlg844c3XqSlQrXybiBnTChI2n
	KpVhrQzCt3s7d0JxQsF2D+cSdSBQStLg7ZW+BFLTxQ5HDdinpYhQabSwOlQ1Oeo=
X-Google-Smtp-Source: AGHT+IGdtktP+Xf4JI7z1bvWIBvxBKgA4BmXthfJugWlroQCdhg1pC5mQLDBnb9MxZXgmfeMA8sxOg==
X-Received: by 2002:a9d:6b15:0:b0:6e5:42cc:8f21 with SMTP id g21-20020a9d6b15000000b006e542cc8f21mr1314207otp.6.1710438244854;
        Thu, 14 Mar 2024 10:44:04 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id w1-20020a9d5381000000b006e5273c35e5sm358461otg.64.2024.03.14.10.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 10:44:04 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: ad7944: Add support for "3-wire mode"
Date: Thu, 14 Mar 2024 12:43:38 -0500
Message-ID: <20240314-mainline-ad7944-3-wire-mode-v2-1-d469da0705d2@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds support for AD7944 ADCs wired in "3-wire mode". (NOTE: 3-wire
is the datasheet name for this wiring configuration and has nothing to
do with SPI_3WIRE.)

In the 3-wire mode, the SPI controller CS line can be wired to the CNV
line on the ADC and used to trigger conversions rather that using a
separate GPIO line.

The turbo/chain mode compatibility check at the end of the probe
function is technically can't be triggered right now but adding it now
anyway so that we don't forget to add it later when support for
daisy-chaining is added.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Use default: in case statements.
- Remove redundant else.
- Explain turbo/chain mode check in commit message.
- Link to v1: https://lore.kernel.org/r/20240311-mainline-ad7944-3-wire-mode-v1-1-8e8199efa1f7@baylibre.com
---
 drivers/iio/adc/ad7944.c | 157 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 139 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index adb007cdd287..d5ec6b5a41c7 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -32,8 +32,25 @@ struct ad7944_timing_spec {
 	unsigned int turbo_conv_ns;
 };
 
+enum ad7944_spi_mode {
+	/* datasheet calls this "4-wire mode" */
+	AD7944_SPI_MODE_DEFAULT,
+	/* datasheet calls this "3-wire mode" (not related to SPI_3WIRE!) */
+	AD7944_SPI_MODE_SINGLE,
+	/* datasheet calls this "chain mode" */
+	AD7944_SPI_MODE_CHAIN,
+};
+
+/* maps adi,spi-mode property value to enum */
+static const char * const ad7944_spi_modes[] = {
+	[AD7944_SPI_MODE_DEFAULT] = "",
+	[AD7944_SPI_MODE_SINGLE] = "single",
+	[AD7944_SPI_MODE_CHAIN] = "chain",
+};
+
 struct ad7944_adc {
 	struct spi_device *spi;
+	enum ad7944_spi_mode spi_mode;
 	/* Chip-specific timing specifications. */
 	const struct ad7944_timing_spec *timing_spec;
 	/* GPIO connected to CNV pin. */
@@ -58,6 +75,9 @@ struct ad7944_adc {
 	 } sample __aligned(IIO_DMA_MINALIGN);
 };
 
+/* quite time before CNV rising edge */
+#define T_QUIET_NS	20
+
 static const struct ad7944_timing_spec ad7944_timing_spec = {
 	.conv_ns = 420,
 	.turbo_conv_ns = 320,
@@ -110,6 +130,65 @@ AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 0);
 /* fully differential */
 AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
 
+/*
+ * ad7944_3wire_cs_mode_conversion - Perform a 3-wire CS mode conversion and
+ *                                   acquisition
+ * @adc: The ADC device structure
+ * @chan: The channel specification
+ * Return: 0 on success, a negative error code on failure
+ *
+ * This performs a conversion and reads data when the chip is wired in 3-wire
+ * mode with the CNV line on the ADC tied to the CS line on the SPI controller.
+ *
+ * Upon successful return adc->sample.raw will contain the conversion result.
+ */
+static int ad7944_3wire_cs_mode_conversion(struct ad7944_adc *adc,
+					   const struct iio_chan_spec *chan)
+{
+	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
+						   : adc->timing_spec->conv_ns;
+	struct spi_transfer xfers[] = {
+		{
+			/*
+			 * NB: can get better performance from some SPI
+			 * controllers if we use the same bits_per_word
+			 * in every transfer.
+			 */
+			.bits_per_word = chan->scan_type.realbits,
+			/*
+			 * CS is tied to CNV and we need a low to high
+			 * transition to start the conversion, so place CNV
+			 * low for t_QUIET to prepare for this.
+			 */
+			.delay = {
+				.value = T_QUIET_NS,
+				.unit = SPI_DELAY_UNIT_NSECS,
+			},
+
+		},
+		{
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
+		},
+		{
+			/* Then we can read the data during the acquisition phase */
+			.rx_buf = &adc->sample.raw,
+			.len = BITS_TO_BYTES(chan->scan_type.storagebits),
+			.bits_per_word = chan->scan_type.realbits,
+		},
+	};
+
+	return spi_sync_transfer(adc->spi, xfers, ARRAY_SIZE(xfers));
+}
+
 /*
  * ad7944_4wire_mode_conversion - Perform a 4-wire mode conversion and acquisition
  * @adc: The ADC device structure
@@ -167,9 +246,22 @@ static int ad7944_single_conversion(struct ad7944_adc *adc,
 {
 	int ret;
 
-	ret = ad7944_4wire_mode_conversion(adc, chan);
-	if (ret)
-		return ret;
+	switch (adc->spi_mode) {
+	case AD7944_SPI_MODE_DEFAULT:
+		ret = ad7944_4wire_mode_conversion(adc, chan);
+		if (ret)
+			return ret;
+
+		break;
+	case AD7944_SPI_MODE_SINGLE:
+		ret = ad7944_3wire_cs_mode_conversion(adc, chan);
+		if (ret)
+			return ret;
+
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
 
 	if (chan->scan_type.storagebits > 16)
 		*val = adc->sample.raw.u32;
@@ -230,9 +322,23 @@ static irqreturn_t ad7944_trigger_handler(int irq, void *p)
 	struct ad7944_adc *adc = iio_priv(indio_dev);
 	int ret;
 
-	ret = ad7944_4wire_mode_conversion(adc, &indio_dev->channels[0]);
-	if (ret)
+	switch (adc->spi_mode) {
+	case AD7944_SPI_MODE_DEFAULT:
+		ret = ad7944_4wire_mode_conversion(adc, &indio_dev->channels[0]);
+		if (ret)
+			goto out;
+
+		break;
+	case AD7944_SPI_MODE_SINGLE:
+		ret = ad7944_3wire_cs_mode_conversion(adc, &indio_dev->channels[0]);
+		if (ret)
+			goto out;
+
+		break;
+	default:
+		/* not supported */
 		goto out;
+	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, &adc->sample.raw,
 					   pf->timestamp);
@@ -260,16 +366,9 @@ static int ad7944_probe(struct spi_device *spi)
 	struct ad7944_adc *adc;
 	bool have_refin = false;
 	struct regulator *ref;
+	const char *str_val;
 	int ret;
 
-	/*
-	 * driver currently only supports the conventional "4-wire" mode and
-	 * not other special wiring configurations.
-	 */
-	if (device_property_present(dev, "adi,spi-mode"))
-		return dev_err_probe(dev, -EINVAL,
-				     "adi,spi-mode is not currently supported\n");
-
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -283,6 +382,22 @@ static int ad7944_probe(struct spi_device *spi)
 
 	adc->timing_spec = chip_info->timing_spec;
 
+	if (device_property_read_string(dev, "adi,spi-mode", &str_val) == 0) {
+		ret = sysfs_match_string(ad7944_spi_modes, str_val);
+		if (ret < 0)
+			return dev_err_probe(dev, -EINVAL,
+					     "unsupported adi,spi-mode\n");
+
+		adc->spi_mode = ret;
+	} else {
+		/* absence of adi,spi-mode property means default mode */
+		adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
+	}
+
+	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN)
+		return dev_err_probe(dev, -EINVAL,
+				     "chain mode is not implemented\n");
+
 	/*
 	 * Some chips use unusual word sizes, so check now instead of waiting
 	 * for the first xfer.
@@ -349,15 +464,17 @@ static int ad7944_probe(struct spi_device *spi)
 		adc->ref_mv = AD7944_INTERNAL_REF_MV;
 	}
 
-	/*
-	 * CNV gpio is required in 4-wire mode which is the only currently
-	 * supported mode.
-	 */
-	adc->cnv = devm_gpiod_get(dev, "cnv", GPIOD_OUT_LOW);
+	adc->cnv = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
 	if (IS_ERR(adc->cnv))
 		return dev_err_probe(dev, PTR_ERR(adc->cnv),
 				     "failed to get CNV GPIO\n");
 
+	if (!adc->cnv && adc->spi_mode == AD7944_SPI_MODE_DEFAULT)
+		return dev_err_probe(&spi->dev, -EINVAL, "CNV GPIO is required\n");
+	if (adc->cnv && adc->spi_mode != AD7944_SPI_MODE_DEFAULT)
+		return dev_err_probe(&spi->dev, -EINVAL,
+				     "CNV GPIO in single and chain mode is not currently supported\n");
+
 	adc->turbo = devm_gpiod_get_optional(dev, "turbo", GPIOD_OUT_LOW);
 	if (IS_ERR(adc->turbo))
 		return dev_err_probe(dev, PTR_ERR(adc->turbo),
@@ -369,6 +486,10 @@ static int ad7944_probe(struct spi_device *spi)
 		return dev_err_probe(dev, -EINVAL,
 			"cannot have both turbo-gpios and adi,always-turbo\n");
 
+	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN && adc->always_turbo)
+		return dev_err_probe(dev, -EINVAL,
+			"cannot have both chain mode and always turbo\n");
+
 	indio_dev->name = chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7944_iio_info;

---
base-commit: bbafdb305d6b00934cc09a90ec1bb659d43e5171
change-id: 20240311-mainline-ad7944-3-wire-mode-c240fe8af979


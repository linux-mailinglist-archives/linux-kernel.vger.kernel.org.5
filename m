Return-Path: <linux-kernel+bounces-99565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE2F878A05
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2E61F21996
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DE556B81;
	Mon, 11 Mar 2024 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ObTuvDYZ"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5598B56B63
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192423; cv=none; b=IlJ1I6JHAYeYRvDP5FgERCh/NZthQI0pWePulJeFClFO5y/4H09DtS1xSQCX2f3goU42R4pxJY0NKGXP2ZZHkPuA2bfNegBgL/1VjyFg7C9TrnNNH152A95FWnLsZkV2P3Gm7T6Bnwsg/gHAC+IDePT9ig+E3ZDK4HnOIE1kGvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192423; c=relaxed/simple;
	bh=r/k/zD4UjmgXk1SslwxTLRCqpcqrhVhqnAhWTq9ct0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QOWoHi69LUnqCr9c6XenI3FnEqZaTnkb2n1wjnh9eK7kITyLLZLs+zpFhcwH7z/86VZA6XR5X2LXuKArfqJZ4JplXdzCzhNv3k+Jo+XjMG4l/BcAYWvvbXwFChSiI7bClOKcf9P2/H8Vkz4pNBMbTsF2/CXTaSrXpUj6SSIXFDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ObTuvDYZ; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a1cbbad6ecso1530332eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710192419; x=1710797219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8UecoZzKSYut+vZhKQ1It3pvBftXrdE86DZ5998DKY=;
        b=ObTuvDYZg/wQXp4vlIcGcij/BYU9HpBqqOxjthmIucRU/ItzZQN6tFZJdHOJWiezng
         FjjX5S0HChb+lXbm2n8GkzHIHls7zmyBUiFpTgvt++bhC1zvrFeloXkFelr2K+ZuYKCY
         90jgUXywCrMLHpIzTZ7trRGhMaIKR4mCxvNlG/RwrUA0vhRz2RhcjL1a6cuYuhR1aKco
         7MggzpGyh3b3Zc/DePj6HJVmKJdmCwNQptutnTX6pIHAeeAsvdhedcU2SKJiRXJgH5m9
         pI50WZa3kykJl3/JoTwc+7fpcWDvvP5SnYCi57U/DLr/2sBt9lM6h2iAS4J1aYsMJmoW
         FLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710192419; x=1710797219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8UecoZzKSYut+vZhKQ1It3pvBftXrdE86DZ5998DKY=;
        b=vmCydt3UBpop9Z7dDzig/Tv4MLcE5zC09xSPxS5/77hcOfkzX8du//Kcr2KHAMzK1z
         V7sYiS2OPr/bUT3F1xSv/MpTWE7nxX4yMWy//Rj2F1a1Yp7AeTa3ziFOrtw5yKS7vJkm
         F5mtglbXKh11FhpwsL7R1bckzEWwEYdErsoP5kX8bajm5V/xEzfSK35Q4xoua9yasKN3
         0kSpo8XHAyLZRxiGmWlbq569TiS4h6zV7cG5noCmCLVFKMbYskjQbMD50a1XP7jL2l6Y
         r/T3b15z7heU2+0X/U/QVvOzxIPqBEADMdQs3LG9yBbuvXH54ThLiytAIIkknIj7iStG
         c91Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrUYpuqJu3HKgBtcRePlYfHB1y5F2U3vd6WAgyIE+Ck4iQ1vaf08Th2LRNBHx1/r9tmtBe1v1LNtts8OhR3t+oEqICNC4MOzR3a19y
X-Gm-Message-State: AOJu0YxyUQc1dNoVI4BXzQS2xTcp/S6SfnCONod2FLAxFmQOZ4JZ8Spo
	evQ+B0M9J9uWMr74ePQPAeNmcBUTA4mk5cNnIML7FWkt9/YGEGdsQ88gxNY5legUg3XzNGLLfHk
	s
X-Google-Smtp-Source: AGHT+IF9NQtKdXH78xZW2qijYZsTFbYpPxK69NgQXvR+N/CMWxfFlepZFHam+pf4xCSfQt+QjRFw3w==
X-Received: by 2002:a4a:3c08:0:b0:5a1:d5ab:3b94 with SMTP id d8-20020a4a3c08000000b005a1d5ab3b94mr4021465ooa.0.1710192419088;
        Mon, 11 Mar 2024 14:26:59 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b11-20020a056830310b00b006e529465addsm677172ots.7.2024.03.11.14.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 14:26:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ad7944: Add support for "3-wire mode"
Date: Mon, 11 Mar 2024 16:26:46 -0500
Message-ID: <20240311-mainline-ad7944-3-wire-mode-v1-1-8e8199efa1f7@baylibre.com>
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

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7944.c | 157 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 139 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index adb007cdd287..8f466eb66bc4 100644
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
+	case AD7944_SPI_MODE_CHAIN:
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
+	case AD7944_SPI_MODE_CHAIN:
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
+	else if (adc->cnv && adc->spi_mode != AD7944_SPI_MODE_DEFAULT)
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


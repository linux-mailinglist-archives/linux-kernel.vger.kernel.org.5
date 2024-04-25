Return-Path: <linux-kernel+bounces-158663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D60C8B2395
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C351C20B04
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823E614A4E0;
	Thu, 25 Apr 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ATSzA2qR"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E04149E0A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054217; cv=none; b=o46jM6/uebxV4tTVy6h1lVWpP3Ht0TYFPyRn9qu65mB9JpASFPvNyqP5KHxgPmMRS7GiqB+pqUJ1s8YlmVunaXBz1YZ1i17yLyv2kpLHTsfyK4pOfXz3JMdJxrm2BAOv3vaKfYHb6r3lpxUgIC06mGbcwlKbGa92FI9735Feous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054217; c=relaxed/simple;
	bh=3eNkbNXTnCYubLcTP1His6I5eWMP+rpNAYz+yS7l0yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbIatEfVng309gVTazWWe0MbpwHoWQspEBLJbvDtGE7JsR9kVE6vrS7+bn1B8Iccxfyv0wuUxWHc1jrtBsqWakVcGt0u9y6049IfslbDkO3e/GQ4sYu2f8kcOckRHu61m0e8ebgzcltbhJe/MyLFlMDbCv+zy2oWAhGmoyfm9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ATSzA2qR; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5af3035825eso884672eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714054214; x=1714659014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyA9tT6Emg0/KLamT2zhMsMgQpjlgM9I6w/LNXRpVi4=;
        b=ATSzA2qRBiolETMAZcoELe7C3IvCzqXOCego73gO27+vfIVoKreQLqQGgg0QdW32cx
         UzUJ5oylceDuxduHJYRODywUY/hhxWKKFwKdYQyGdKN7z9aOwk+cAqtuJFAXo+vwHwZe
         EkXpCcSi+HoNk9eQbx/Oa5RaBdI/EidIHm59dHruPRCVLHopChWygWJKyylC2Kky4Nwv
         yNQFyIU1OmTysbau627v05y2bQsIzew1z/7sDU7zl8jG2qcyDM+F4euvLV6q5WVe45rP
         +IZlX6TNlCRJ+Q53uqd93sErB/LnZPBKVc0VwiN7BCnMtEyb+5FwKHa9c00Zohd0NNV/
         veMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714054214; x=1714659014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyA9tT6Emg0/KLamT2zhMsMgQpjlgM9I6w/LNXRpVi4=;
        b=UYH/zdr0sAnSWysYAWaDmWbyKCxU2r74bZRh+Pt32Pi4y1WsF/3aQyhzYoPLJm8snR
         bJk0EhPrddiXngOxKCXlpE7jW9V9GuTVv+lykGrV4byk5XFd2OSl+gw+KA73PWdSJ9XI
         qoJ/f6+FhANa8jmmsB+l4/7WFqoepLojJIxREiAyTDmRm75hmlv4xYvja5VTOBT52Z5F
         fAM4jc6RYNhlcIm2Xs+OxX9VzkztLP5Q1KutAAho1OapC6bmenpNN5SdvnyTRwq+h6NU
         EQJ2v5WGWUmsUjIv9P7d7y/CohRvaDxuI6uBAYzYWBpM+xZNuLSD7XNlcHSZ8On3WFEg
         rIzA==
X-Forwarded-Encrypted: i=1; AJvYcCXj73yhOjwyFn3QXI3YbcNsRfh7Oma3fThrr+uGj+k5qYWPsiOhv0seskzZB9xnIQIX5LAJuhrpbWLKXIDmISPKqAEnVDgBh0LErx7Q
X-Gm-Message-State: AOJu0Yy5PtnIMr6WFG49ImXsZgbKdhWZYqTIl185KtGr/1Z9ztg3z3rX
	np9/q1S9zfZZlFpt5uwzXXKL19TTdbKEJFuaAhS7598EZoSMqx7/v4xiIOWztIQ=
X-Google-Smtp-Source: AGHT+IFNc7pmimjNp8Z3ThzitEkrCv20VpmevKzr2jH7fy9kzPqXxE/U1EMLxWWxVVykA3XWVBwf/Q==
X-Received: by 2002:a05:6870:1814:b0:232:fa39:1e2d with SMTP id t20-20020a056870181400b00232fa391e2dmr1529602oaf.7.1714054213677;
        Thu, 25 Apr 2024 07:10:13 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id pz8-20020a056871e48800b0023b5203fc58sm294786oac.37.2024.04.25.07.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 07:10:13 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/2] iio: adc: ad7944: add support for chain mode
Date: Thu, 25 Apr 2024 09:09:59 -0500
Message-ID: <20240425-iio-ad7944-chain-mode-v1-1-9d9220ff21e1@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240425-iio-ad7944-chain-mode-v1-0-9d9220ff21e1@baylibre.com>
References: <20240425-iio-ad7944-chain-mode-v1-0-9d9220ff21e1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds support for the chain mode of the AD7944 ADC. This mode allows
multiple ADCs to be daisy-chained together. Data from all of the ADCs in
is read by reading multiple words from the first ADC in the chain.

Each chip in the chain adds an extra IIO input voltage channel to the
IIO device.

Only the wiring configuration where the SPI controller CS line is
connected to the CNV pin of all of the ADCs in the chain is supported
in this patch.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7944.c | 186 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 176 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 4af574ffa864..1a87f70ce57f 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -6,6 +6,7 @@
  * Copyright 2024 BayLibre, SAS
  */
 
+#include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -53,6 +54,7 @@ struct ad7944_adc {
 	enum ad7944_spi_mode spi_mode;
 	struct spi_transfer xfers[3];
 	struct spi_message msg;
+	void *chain_mode_buf;
 	/* Chip-specific timing specifications. */
 	const struct ad7944_timing_spec *timing_spec;
 	/* GPIO connected to CNV pin. */
@@ -214,6 +216,46 @@ static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
 }
 
+static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
+				      const struct iio_chan_spec *chan,
+				      u32 n_chain_dev)
+{
+	struct spi_transfer *xfers = adc->xfers;
+	int ret;
+
+	/*
+	 * NB: SCLK has to be low before we toggle CS to avoid triggering the
+	 * busy indication.
+	 */
+	if (adc->spi->mode & SPI_CPOL)
+		return dev_err_probe(dev, -EINVAL,
+				     "chain mode requires ~SPI_CPOL\n");
+
+	/*
+	 * We only support CNV connected to CS in chain mode and we need CNV
+	 * to be high during the transfer to trigger the conversion.
+	 */
+	if (!(adc->spi->mode & SPI_CS_HIGH))
+		return dev_err_probe(dev, -EINVAL,
+				     "chain mode requires SPI_CS_HIGH\n");
+
+	/* CNV has to be high for full conversion time before reading data. */
+	xfers[0].delay.value = adc->timing_spec->conv_ns;
+	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	xfers[1].rx_buf = adc->chain_mode_buf;
+	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits) * n_chain_dev;
+	xfers[1].bits_per_word = chan->scan_type.realbits;
+
+	spi_message_init_with_transfers(&adc->msg, xfers, 2);
+
+	ret = spi_optimize_message(adc->spi, &adc->msg);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
+}
+
 /**
  * ad7944_convert_and_acquire - Perform a single conversion and acquisition
  * @adc: The ADC device structure
@@ -223,7 +265,8 @@ static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc
  * Perform a conversion and acquisition of a single sample using the
  * pre-optimized adc->msg.
  *
- * Upon successful return adc->sample.raw will contain the conversion result.
+ * Upon successful return adc->sample.raw will contain the conversion result
+ * (or adc->chain_mode_buf if the device is using chain mode).
  */
 static int ad7944_convert_and_acquire(struct ad7944_adc *adc,
 				      const struct iio_chan_spec *chan)
@@ -252,10 +295,17 @@ static int ad7944_single_conversion(struct ad7944_adc *adc,
 	if (ret)
 		return ret;
 
-	if (chan->scan_type.storagebits > 16)
-		*val = adc->sample.raw.u32;
-	else
-		*val = adc->sample.raw.u16;
+	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN) {
+		if (chan->scan_type.storagebits > 16)
+			*val = ((u32 *)adc->chain_mode_buf)[chan->scan_index];
+		else
+			*val = ((u16 *)adc->chain_mode_buf)[chan->scan_index];
+	} else {
+		if (chan->scan_type.storagebits > 16)
+			*val = adc->sample.raw.u32;
+		else
+			*val = adc->sample.raw.u16;
+	}
 
 	if (chan->scan_type.sign == 's')
 		*val = sign_extend32(*val, chan->scan_type.realbits - 1);
@@ -315,8 +365,12 @@ static irqreturn_t ad7944_trigger_handler(int irq, void *p)
 	if (ret)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &adc->sample.raw,
-					   pf->timestamp);
+	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN)
+		iio_push_to_buffers_with_timestamp(indio_dev, adc->chain_mode_buf,
+						   pf->timestamp);
+	else
+		iio_push_to_buffers_with_timestamp(indio_dev, &adc->sample.raw,
+						   pf->timestamp);
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);
@@ -324,6 +378,90 @@ static irqreturn_t ad7944_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+/**
+ * ad7944_chain_mode_alloc - allocate and initialize channel specs and buffers
+ *                           for daisy-chained devices
+ * @dev: The device for devm_ functions
+ * @chan_template: The channel template for the devices (array of 2 channels
+ *                 voltage and timestamp)
+ * @n_chain_dev: The number of devices in the chain
+ * @chain_chan: Pointer to receive the allocated channel specs
+ * @chain_mode_buf: Pointer to receive the allocated rx buffer
+ * @chain_scan_masks: Pointer to receive the allocated scan masks
+ * Return: 0 on success, a negative error code on failure
+ */
+static int ad7944_chain_mode_alloc(struct device *dev,
+				   const struct iio_chan_spec *chan_template,
+				   u32 n_chain_dev,
+				   struct iio_chan_spec **chain_chan,
+				   void **chain_mode_buf,
+				   unsigned long **chain_scan_masks)
+{
+	struct iio_chan_spec *chan;
+	size_t chain_mode_buf_size;
+	unsigned long *scan_masks;
+	void *buf;
+	int i;
+
+	/* 1 channel for each device in chain plus 1 for soft timestamp */
+
+	chan = devm_kcalloc(dev, n_chain_dev + 1, sizeof(*chan), GFP_KERNEL);
+	if (!chan)
+		return -ENOMEM;
+
+	for (i = 0; i < n_chain_dev; i++) {
+		chan[i] = chan_template[0];
+
+		if (chan_template[0].differential) {
+			chan[i].channel = 2 * i;
+			chan[i].channel2 = 2 * i + 1;
+		} else {
+			chan[i].channel = i;
+		}
+
+		chan[i].scan_index = i;
+	}
+
+	/* soft timestamp */
+	chan[i] = chan_template[1];
+	chan[i].scan_index = i;
+
+	*chain_chan = chan;
+
+	/* 1 word for each voltage channel + aligned u64 for timestamp */
+
+	chain_mode_buf_size = ALIGN(n_chain_dev *
+		BITS_TO_BYTES(chan[0].scan_type.storagebits), sizeof(u64))
+		+ sizeof(u64);
+	buf = devm_kmalloc(dev, chain_mode_buf_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	*chain_mode_buf = buf;
+
+	/*
+	 * Have to limit n_chain_dev due to current implementation of
+	 * available_scan_masks.
+	 */
+	if (n_chain_dev > BITS_PER_LONG)
+		return dev_err_probe(dev, -EINVAL,
+				     "chain is limited to 32 devices\n");
+
+	scan_masks = devm_kcalloc(dev, 2, sizeof(*scan_masks), GFP_KERNEL);
+	if (!scan_masks)
+		return -ENOMEM;
+
+	/*
+	 * Scan mask is needed since we always have to read all devices in the
+	 * chain in one SPI transfer.
+	 */
+	scan_masks[0] = GENMASK(n_chain_dev - 1, 0);
+
+	*chain_scan_masks = scan_masks;
+
+	return 0;
+}
+
 static const char * const ad7944_power_supplies[] = {
 	"avdd",	"dvdd",	"bvdd", "vio"
 };
@@ -341,6 +479,9 @@ static int ad7944_probe(struct spi_device *spi)
 	struct ad7944_adc *adc;
 	bool have_refin = false;
 	struct regulator *ref;
+	struct iio_chan_spec *chain_chan;
+	unsigned long *chain_scan_masks;
+	u32 n_chain_dev;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
@@ -474,14 +615,39 @@ static int ad7944_probe(struct spi_device *spi)
 
 		break;
 	case AD7944_SPI_MODE_CHAIN:
-		return dev_err_probe(dev, -EINVAL, "chain mode is not implemented\n");
+		ret = device_property_read_u32(dev, "#daisy-chained-devices",
+					       &n_chain_dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					"failed to get #daisy-chained-devices\n");
+
+		ret = ad7944_chain_mode_alloc(dev, chip_info->channels,
+					      n_chain_dev, &chain_chan,
+					      &adc->chain_mode_buf,
+					      &chain_scan_masks);
+		if (ret)
+			return ret;
+
+		ret = ad7944_chain_mode_init_msg(dev, adc, &chain_chan[0],
+						 n_chain_dev);
+		if (ret)
+			return ret;
+
+		break;
 	}
 
 	indio_dev->name = chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7944_iio_info;
-	indio_dev->channels = chip_info->channels;
-	indio_dev->num_channels = ARRAY_SIZE(chip_info->channels);
+
+	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN) {
+		indio_dev->available_scan_masks = chain_scan_masks;
+		indio_dev->channels = chain_chan;
+		indio_dev->num_channels = n_chain_dev + 1;
+	} else {
+		indio_dev->channels = chip_info->channels;
+		indio_dev->num_channels = ARRAY_SIZE(chip_info->channels);
+	}
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,

-- 
2.43.2



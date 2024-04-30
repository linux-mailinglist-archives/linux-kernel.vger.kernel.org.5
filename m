Return-Path: <linux-kernel+bounces-164380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEF58B7CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AB11C233A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF19181B95;
	Tue, 30 Apr 2024 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGET+pKg"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B89E17F38D;
	Tue, 30 Apr 2024 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494621; cv=none; b=uveqouILYWHU+UDvlG9Tfm1ZWogT6srao8xa+YuidG8tZcRhXEuTmKQWB0t5WubEA4DWaOV9xJi/m/ESD6WSb6DSczPQkDLjTuWSCxoBW35kT47SrXk7MVssxBB6XpVE5oLePm7PvnC5leWaf7XZGajgyY9QrF4Qes856rTBOMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494621; c=relaxed/simple;
	bh=Fot0dcyZZMSS29uGds9STubq37gcg7XH5YpiRTjsTIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dLnlSKt2ZR267JrmaFhbTlU5Aet7CsOSzpA30bWewvuP9kN/OnV3Q4PhbbkoidlN0LcRbesC3HQBsjsFnFuw9XHPnU77kXVaDr+DEp2lz0kvytYdedAvyIHXvqdP5WK8yviKQMKFP0+n8JEkOBK9nMV4N0kHZa5N3/EdtifeioU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGET+pKg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41ba1ba55e8so32435735e9.1;
        Tue, 30 Apr 2024 09:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714494618; x=1715099418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=US8dCoGQJ/6TBinSDooKuIRRwHoj7weiS688LyQVfKU=;
        b=SGET+pKgKIqcwJTtZIj4J2w7fOX/D6LQaesoN+CCWGGOyTaDgeGusBbf9PRlU/+1JM
         Hi4/hZL09Wn38P3PSuh/UAWWK8B25woJczAdZYI7WwkuA3rbgVX/UgsoeqyITBCvE6PJ
         vXZKslbYXFF2Yf8KwuBOK1B29hFwg13vEk8GjALovLBxcXgE/ZoWQblpILYs3s+jN0Jp
         0v4OJJfUsEdmjICAvZXhaeVWGusKMaqQgo8VTaQ7SrJZNxI8gIjFNgZZIHqCjNsZIK7J
         sNxWrWpx4MXCAhqSD6u8LLb6D2qfe+/5ft0GEXuNIzMCpR2X0gP7z1+DQfB4n/EMji/q
         BXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494618; x=1715099418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=US8dCoGQJ/6TBinSDooKuIRRwHoj7weiS688LyQVfKU=;
        b=EHITaPLlNkAkHdjmRWook6K9XnPrHNBtzYrThMoNEvOmTrD5pdSAr1M2AjYBPAtQ26
         wVLEeWs2XIjzoVIE+xjkuKWCj1Ak2Z12nRu3maB/bLOt2EPWnZ8JHKJz+894qRs7rIKZ
         ByHVuZU8DlRqY9dWbRU59moXQ9RqwDhTTfdSpFwYIKoJkHyJdkwv83DEjMgxcg24ltZC
         jcid8GNNyrNqVAbicefHnGOmg+FppRq9biS/fZnas+DsNGJCv+TWZXLfHUSEZarMnNHZ
         OdzS2jnAa939FpIwnBLeBzzEdOaQztaXjV+c2xQRrGy0Ls5fZHAfHFBpaRQonV8/HfPa
         RIRA==
X-Forwarded-Encrypted: i=1; AJvYcCXekSi2CdWrKzFu8WwNiZDTGZzuy645NWR706lnL1eKAxXUq+q9fcpVQ6YQg94Kt6tI0Ucg1e0pSA7BN33rDxxBvADwkio6bhP6M9CnV9VBQOsnuoCmIYykMLEKEwI618+BHmJxroU/Ob8LkaJiEMyZG+L8rwFIiNFQwcRpmbfxTh6+sA==
X-Gm-Message-State: AOJu0YxYdmPw/TND4ZcF8DlnGhSO2H/96vmvefJfEbvzNsfFiB8TpEUv
	JJCsFDsRh96DdHEj2bJzH6hWpc6XWgUfAsayWfo6NxcuMujatvNe
X-Google-Smtp-Source: AGHT+IE/zHCLaJwt/i8Z7kOFWFZ4biD8ksCGtm3L7lz0gx7kGbBEaHqAR51ngoplXh0b/P2meHcvMQ==
X-Received: by 2002:a05:600c:4ed2:b0:41c:11b:b36e with SMTP id g18-20020a05600c4ed200b0041c011bb36emr34971wmq.16.1714494618236;
        Tue, 30 Apr 2024 09:30:18 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a105:8300:da4d:6b2c:f166:22e6])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b00418d68df226sm46505396wmq.0.2024.04.30.09.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:30:17 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alexandru.tachici@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	okan.sahin@analog.com,
	fr0st61te@gmail.com,
	alisa.roman@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: [PATCH v7 6/6] iio: adc: ad7192: Add AD7194 support
Date: Tue, 30 Apr 2024 19:29:46 +0300
Message-Id: <20240430162946.589423-7-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430162946.589423-1-alisa.roman@analog.com>
References: <20240430162946.589423-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike the other AD719Xs, AD7194 has configurable channels. The user can
dynamically configure them in the devicetree.

Also modify config AD7192 description for better scaling.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/Kconfig  |  11 +++-
 drivers/iio/adc/ad7192.c | 129 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 133 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 8db68b80b391..74fecc284f1a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -88,12 +88,17 @@ config AD7173
 	  called ad7173.
 
 config AD7192
-	tristate "Analog Devices AD7190 AD7192 AD7193 AD7195 ADC driver"
+	tristate "Analog Devices AD7192 and similar ADC driver"
 	depends on SPI
 	select AD_SIGMA_DELTA
 	help
-	  Say yes here to build support for Analog Devices AD7190,
-	  AD7192, AD7193 or AD7195 SPI analog to digital converters (ADC).
+	  Say yes here to build support for Analog Devices SPI analog to digital
+	  converters (ADC):
+	  - AD7190
+	  - AD7192
+	  - AD7193
+	  - AD7194
+	  - AD7195
 	  If unsure, say N (but it's safe to say "Y").
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 3e797ff48086..0f6ecf953559 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * AD7190 AD7192 AD7193 AD7195 SPI ADC driver
+ * AD7192 and similar SPI ADC driver
  *
  * Copyright 2011-2015 Analog Devices Inc.
  */
@@ -129,10 +129,21 @@
 #define AD7193_CH_AIN8		0x480 /* AIN7 - AINCOM */
 #define AD7193_CH_AINCOM	0x600 /* AINCOM - AINCOM */
 
+#define AD7194_CH_POS(x)	(((x) - 1) << 4)
+#define AD7194_CH_NEG(x)	((x) - 1)
+#define AD7194_CH(pos, neg) \
+	(((neg) == 0 ? BIT(10) : AD7194_CH_NEG(neg)) | AD7194_CH_POS(pos))
+#define AD7194_CH_TEMP		0x100 /* Temp sensor */
+#define AD7194_CH_BASE_NR	2
+#define AD7194_CH_AIN_START	1
+#define AD7194_CH_AIN_NR	16
+#define AD7194_CH_MAX_NR	272
+
 /* ID Register Bit Designations (AD7192_REG_ID) */
 #define CHIPID_AD7190		0x4
 #define CHIPID_AD7192		0x0
 #define CHIPID_AD7193		0x2
+#define CHIPID_AD7194		0x3
 #define CHIPID_AD7195		0x6
 #define AD7192_ID_MASK		GENMASK(3, 0)
 
@@ -170,6 +181,7 @@ enum {
 	ID_AD7190,
 	ID_AD7192,
 	ID_AD7193,
+	ID_AD7194,
 	ID_AD7195,
 };
 
@@ -179,6 +191,7 @@ struct ad7192_chip_info {
 	const struct iio_chan_spec	*channels;
 	u8				num_channels;
 	const struct iio_info		*info;
+	int (*parse_channels)(struct iio_dev *indio_dev);
 };
 
 struct ad7192_state {
@@ -932,6 +945,15 @@ static const struct iio_info ad7192_info = {
 	.update_scan_mode = ad7192_update_scan_mode,
 };
 
+static const struct iio_info ad7194_info = {
+	.read_raw = ad7192_read_raw,
+	.write_raw = ad7192_write_raw,
+	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
+	.read_avail = ad7192_read_avail,
+	.validate_trigger = ad_sd_validate_trigger,
+	.update_scan_mode = ad7192_update_scan_mode,
+};
+
 static const struct iio_info ad7195_info = {
 	.read_raw = ad7192_read_raw,
 	.write_raw = ad7192_write_raw,
@@ -1023,6 +1045,91 @@ static const struct iio_chan_spec ad7193_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(14),
 };
 
+static int ad7194_validate_ain_channel(struct device *dev, u32 ain)
+{
+	if (!in_range(ain, AD7194_CH_AIN_START, AD7194_CH_AIN_NR))
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid AIN channel: %u\n", ain);
+
+	return 0;
+}
+
+static int ad7194_parse_channels(struct iio_dev *indio_dev)
+{
+	struct device *dev = indio_dev->dev.parent;
+	struct iio_chan_spec *ad7194_channels;
+	struct fwnode_handle *child;
+	struct iio_chan_spec ad7194_chan = AD7193_CHANNEL(0, 0, 0);
+	struct iio_chan_spec ad7194_chan_diff = AD7193_DIFF_CHANNEL(0, 0, 0, 0);
+	struct iio_chan_spec ad7194_chan_temp = AD719x_TEMP_CHANNEL(0, 0);
+	struct iio_chan_spec ad7194_chan_timestamp = IIO_CHAN_SOFT_TIMESTAMP(0);
+	unsigned int num_channels, index = 0;
+	u32 ain[2];
+	int ret;
+
+	num_channels = device_get_child_node_count(dev);
+	if (num_channels > AD7194_CH_MAX_NR)
+		return dev_err_probe(dev, -EINVAL,
+				     "Too many channels: %u\n", num_channels);
+
+	num_channels += AD7194_CH_BASE_NR;
+
+	ad7194_channels = devm_kcalloc(dev, num_channels,
+				       sizeof(*ad7194_channels), GFP_KERNEL);
+	if (!ad7194_channels)
+		return -ENOMEM;
+
+	indio_dev->channels = ad7194_channels;
+	indio_dev->num_channels = num_channels;
+
+	device_for_each_child_node(dev, child) {
+		ret = fwnode_property_read_u32_array(child, "diff-channels",
+						     ain, ARRAY_SIZE(ain));
+		if (ret == 0) {
+			ret = ad7194_validate_ain_channel(dev, ain[0]);
+			if (ret)
+				return ret;
+
+			ret = ad7194_validate_ain_channel(dev, ain[1]);
+			if (ret)
+				return ret;
+
+			*ad7194_channels = ad7194_chan_diff;
+			ad7194_channels->scan_index = index++;
+			ad7194_channels->channel = ain[0];
+			ad7194_channels->channel2 = ain[1];
+			ad7194_channels->address = AD7194_CH(ain[0], ain[1]);
+		} else {
+			ret = fwnode_property_read_u32(child, "single-channel",
+						       &ain[0]);
+			if (ret) {
+				fwnode_handle_put(child);
+				return ret;
+			}
+
+			ret = ad7194_validate_ain_channel(dev, ain[0]);
+			if (ret)
+				return ret;
+
+			*ad7194_channels = ad7194_chan;
+			ad7194_channels->scan_index = index++;
+			ad7194_channels->channel = ain[0];
+			ad7194_channels->address = AD7194_CH(ain[0], 0);
+		}
+		ad7194_channels++;
+	}
+
+	*ad7194_channels = ad7194_chan_temp;
+	ad7194_channels->scan_index = index++;
+	ad7194_channels->address = AD7194_CH_TEMP;
+	ad7194_channels++;
+
+	*ad7194_channels = ad7194_chan_timestamp;
+	ad7194_channels->scan_index = index;
+
+	return 0;
+}
+
 static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 	[ID_AD7190] = {
 		.chip_id = CHIPID_AD7190,
@@ -1045,6 +1152,12 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 		.num_channels = ARRAY_SIZE(ad7193_channels),
 		.info = &ad7192_info,
 	},
+	[ID_AD7194] = {
+		.chip_id = CHIPID_AD7194,
+		.name = "ad7194",
+		.info = &ad7194_info,
+		.parse_channels = ad7194_parse_channels,
+	},
 	[ID_AD7195] = {
 		.chip_id = CHIPID_AD7195,
 		.name = "ad7195",
@@ -1152,9 +1265,15 @@ static int ad7192_probe(struct spi_device *spi)
 	st->chip_info = spi_get_device_match_data(spi);
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = st->chip_info->channels;
-	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->info = st->chip_info->info;
+	if (st->chip_info->parse_channels) {
+		ret = st->chip_info->parse_channels(indio_dev);
+		if (ret)
+			return ret;
+	} else {
+		indio_dev->channels = st->chip_info->channels;
+		indio_dev->num_channels = st->chip_info->num_channels;
+	}
 
 	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7192_sigma_delta_info);
 	if (ret)
@@ -1193,6 +1312,7 @@ static const struct of_device_id ad7192_of_match[] = {
 	{ .compatible = "adi,ad7190", .data = &ad7192_chip_info_tbl[ID_AD7190] },
 	{ .compatible = "adi,ad7192", .data = &ad7192_chip_info_tbl[ID_AD7192] },
 	{ .compatible = "adi,ad7193", .data = &ad7192_chip_info_tbl[ID_AD7193] },
+	{ .compatible = "adi,ad7194", .data = &ad7192_chip_info_tbl[ID_AD7194] },
 	{ .compatible = "adi,ad7195", .data = &ad7192_chip_info_tbl[ID_AD7195] },
 	{}
 };
@@ -1202,6 +1322,7 @@ static const struct spi_device_id ad7192_ids[] = {
 	{ "ad7190", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7190] },
 	{ "ad7192", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7192] },
 	{ "ad7193", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7193] },
+	{ "ad7194", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7194] },
 	{ "ad7195", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7195] },
 	{}
 };
@@ -1218,6 +1339,6 @@ static struct spi_driver ad7192_driver = {
 module_spi_driver(ad7192_driver);
 
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7190, AD7192, AD7193, AD7195 ADC");
+MODULE_DESCRIPTION("Analog Devices AD7192 and similar ADC");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
-- 
2.34.1



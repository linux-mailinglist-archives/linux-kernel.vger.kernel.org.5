Return-Path: <linux-kernel+bounces-107370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC0987FB91
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C40D0B20FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D807E76A;
	Tue, 19 Mar 2024 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2L4okBV/"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787227EEF5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843100; cv=none; b=jmGLHlxeICOiLzELVEX2g7mAAMZl40StgLFOwSPsV+Z4W5tK4V9gyKVDoSzL10VnmQpaE3jlpur/fFCdOtjNvCy562sItkjPV3MAQsOyva8VUxZSOIqggVI09fjZhxywAiMkizvxI1fqnu6y+15M02qsNE3jdVN1DYtlzmHz6DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843100; c=relaxed/simple;
	bh=5drMRkc6cdhxzEXRuiFUG+ZazTN83pcjQOdgWR2Qpu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FtOIEViSwI1fNtM46RngZ8xXI80Px6sThoS3YblvqMQRYiX8e2Eviubl4BBXenoAcJT3bDroe07O0okinX28k1/n3DntBWC2imxOhh9SfuEkKuepr0nxSkgrD4L6Psyytv0sSjnHu1l+fX6DekExcUrXoKeX0ulfYPy0TVOCrRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2L4okBV/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-414612cfd82so8013975e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710843097; x=1711447897; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsfyZur1R0UqZb6MbuekND4ciUEpi+pLkRiJrw0UfQA=;
        b=2L4okBV/HIMmYWOzGu8ss2pJ7eJ+J2QloEQbKLF4wmQSnyswQh/cf9XQdFFZ2ZQcPA
         C7PFmfA2d2PMZTXk/mxmjH646sdPDEC39JuAmPFttqJdI2/z0b0Dir6iD4ryhYtbTz5f
         NAUw/TIea+CM22yns/KEx095+vvlG/ug8WgD4aXjmAUpae8Rx0a4PF9uiuPJ1tfA1+il
         Qd0d+DsVL+vvQ/RT1etfmi5ZM4QXrX9esVA0CM4xCcDeqG9LJIcs3mQj1EUZDWfV/o5Z
         DxcMEWXMHPSUl88NqrF6O9QAnpVInQCQCnYdGFTJlHGnje5GFw/JmXUwWyWKaQIu6yU+
         158A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843097; x=1711447897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsfyZur1R0UqZb6MbuekND4ciUEpi+pLkRiJrw0UfQA=;
        b=qNsy4N/qZ+Y9y9JviqzY63IUVPTAbnKiVSKIvrr5TIlgO2zqcFitpF3G2MKOBwKouo
         EayXiW06LwtWO0ie/MPk7gKDIbgYuY4XYHuud0PIl0vF9AamM+fBysPYcbtOtP/LTMI5
         xbffyHex1ho1G6LNfLNPApQHe06blVnBx6vR8Mnr8ZsAopA/hzIjMZr9v723LDgGIGnl
         a71wSzvVA1K+dmz78xXL5qcbmbFQUdTD40e5gXVXUn9Hyx7qxxIv9nBAjI9tXEH2WWvN
         EkFUOr024Rhpbfnvz6ZudZoEfV+x8BCRWcG1c/lFsrrPW2R/svGRI4IdjcvPsb3IjFJ0
         6MEw==
X-Forwarded-Encrypted: i=1; AJvYcCW7SYmXnq3rO4ZeQY1KI+0hLoX0PyuQ7vTTeBHK/efnX84JXxrAqLlQJrpuEy2S8xL0Y2f7VHEC0VUB3ywnlQFM/ThvnsVRtICZl+Mb
X-Gm-Message-State: AOJu0YyD2jmQPgsvE5b5w0rPFl7yTyqkZ63ZbBBDsh3kN8YRaCMiZLoW
	Ucs7SWuqNkGy2nAcWMI8A6KZEp4zB5T4XIxl+ze1rq7n56KCblVs+6I+ZL5Ub38=
X-Google-Smtp-Source: AGHT+IF36snA4qnITyiGndP/BqdVSGXnj6d0Gh72zGhEtdGy2zSoCJle1eukie7uxkg5AhI3BS2RBA==
X-Received: by 2002:a05:600c:1395:b0:413:38c6:2c7a with SMTP id u21-20020a05600c139500b0041338c62c7amr1328419wmf.22.1710843096914;
        Tue, 19 Mar 2024 03:11:36 -0700 (PDT)
Received: from [192.168.1.63] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id je2-20020a05600c1f8200b004133072017csm21096384wmb.42.2024.03.19.03.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:11:36 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 19 Mar 2024 11:11:28 +0100
Subject: [PATCH v5 7/7] iio: adc: ad7380: add support for ad738x-4 4
 channels variants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-adding-new-ad738x-driver-v5-7-ce7df004ceb3@baylibre.com>
References: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
In-Reply-To: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.13.0

Add support for ad7380/1/2/3-4 parts which are 4 channels
variants from ad7380/1/2/3

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 3aca41ce9a14..cf9d2ace5f20 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -8,6 +8,9 @@
  * Datasheets of supported parts:
  * ad7380/1 : https://www.analog.com/media/en/technical-documentation/data-sheets/AD7380-7381.pdf
  * ad7383/4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7383-7384.pdf
+ * ad7380-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7380-4.pdf
+ * ad7381-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7381-4.pdf
+ * ad7383/4-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7383-4-ad7384-4.pdf
  */
 
 #include <linux/bitfield.h>
@@ -29,7 +32,7 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#define MAX_NUM_CHANNELS		2
+#define MAX_NUM_CHANNELS		4
 /* 2.5V internal reference voltage */
 #define AD7380_INTERNAL_REF_MV		2500
 
@@ -106,27 +109,53 @@ static const struct iio_chan_spec name[] = {		\
 	IIO_CHAN_SOFT_TIMESTAMP(2),			\
 }
 
+#define DEFINE_AD7380_4_CHANNEL(name, bits, diff)	\
+static const struct iio_chan_spec name[] = {		\
+	AD7380_CHANNEL(0, bits, diff),			\
+	AD7380_CHANNEL(1, bits, diff),			\
+	AD7380_CHANNEL(2, bits, diff),			\
+	AD7380_CHANNEL(3, bits, diff),			\
+	IIO_CHAN_SOFT_TIMESTAMP(4),			\
+}
+
 /* fully differential */
 DEFINE_AD7380_2_CHANNEL(ad7380_channels, 16, 1);
 DEFINE_AD7380_2_CHANNEL(ad7381_channels, 14, 1);
+DEFINE_AD7380_4_CHANNEL(ad7380_4_channels, 16, 1);
+DEFINE_AD7380_4_CHANNEL(ad7381_4_channels, 14, 1);
 /* pseudo differential */
 DEFINE_AD7380_2_CHANNEL(ad7383_channels, 16, 0);
 DEFINE_AD7380_2_CHANNEL(ad7384_channels, 14, 0);
+DEFINE_AD7380_4_CHANNEL(ad7383_4_channels, 16, 0);
+DEFINE_AD7380_4_CHANNEL(ad7384_4_channels, 14, 0);
 
 static const char * const ad7380_2_channel_vcm_supplies[] = {
 	"aina", "ainb",
 };
 
+static const char * const ad7380_4_channel_vcm_supplies[] = {
+	"aina", "ainb", "ainc", "aind",
+};
+
 /* Since this is simultaneous sampling, we don't allow individual channels. */
 static const unsigned long ad7380_2_channel_scan_masks[] = {
 	GENMASK(1, 0),
 	0
 };
 
+static const unsigned long ad7380_4_channel_scan_masks[] = {
+	GENMASK(3, 0),
+	0
+};
+
 static const struct ad7380_timing_specs ad7380_timing = {
 	.t_csh_ns = 10,
 };
 
+static const struct ad7380_timing_specs ad7380_4_timing = {
+	.t_csh_ns = 20,
+};
+
 static const struct ad7380_chip_info ad7380_chip_info = {
 	.name = "ad7380",
 	.channels = ad7380_channels,
@@ -163,6 +192,42 @@ static const struct ad7380_chip_info ad7384_chip_info = {
 	.timing_specs = &ad7380_timing,
 };
 
+static const struct ad7380_chip_info ad7380_4_chip_info = {
+	.name = "ad7380-4",
+	.channels = ad7380_4_channels,
+	.num_channels = ARRAY_SIZE(ad7380_4_channels),
+	.available_scan_masks = ad7380_4_channel_scan_masks,
+	.timing_specs = &ad7380_4_timing,
+};
+
+static const struct ad7380_chip_info ad7381_4_chip_info = {
+	.name = "ad7381-4",
+	.channels = ad7381_4_channels,
+	.num_channels = ARRAY_SIZE(ad7381_4_channels),
+	.available_scan_masks = ad7380_4_channel_scan_masks,
+	.timing_specs = &ad7380_4_timing,
+};
+
+static const struct ad7380_chip_info ad7383_4_chip_info = {
+	.name = "ad7383-4",
+	.channels = ad7383_4_channels,
+	.num_channels = ARRAY_SIZE(ad7383_4_channels),
+	.vcm_supplies = ad7380_4_channel_vcm_supplies,
+	.num_vcm_supplies = ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
+	.available_scan_masks = ad7380_4_channel_scan_masks,
+	.timing_specs = &ad7380_4_timing,
+};
+
+static const struct ad7380_chip_info ad7384_4_chip_info = {
+	.name = "ad7384-4",
+	.channels = ad7384_4_channels,
+	.num_channels = ARRAY_SIZE(ad7384_4_channels),
+	.vcm_supplies = ad7380_4_channel_vcm_supplies,
+	.num_vcm_supplies = ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
+	.available_scan_masks = ad7380_4_channel_scan_masks,
+	.timing_specs = &ad7380_4_timing,
+};
+
 struct ad7380_state {
 	const struct ad7380_chip_info *chip_info;
 	struct spi_device *spi;
@@ -514,6 +579,10 @@ static const struct of_device_id ad7380_of_match_table[] = {
 	{ .compatible = "adi,ad7381", .data = &ad7381_chip_info },
 	{ .compatible = "adi,ad7383", .data = &ad7383_chip_info },
 	{ .compatible = "adi,ad7384", .data = &ad7384_chip_info },
+	{ .compatible = "adi,ad7380-4", .data = &ad7380_4_chip_info },
+	{ .compatible = "adi,ad7381-4", .data = &ad7381_4_chip_info },
+	{ .compatible = "adi,ad7383-4", .data = &ad7383_4_chip_info },
+	{ .compatible = "adi,ad7384-4", .data = &ad7384_4_chip_info },
 	{ }
 };
 
@@ -522,6 +591,10 @@ static const struct spi_device_id ad7380_id_table[] = {
 	{ "ad7381", (kernel_ulong_t)&ad7381_chip_info },
 	{ "ad7383", (kernel_ulong_t)&ad7383_chip_info },
 	{ "ad7384", (kernel_ulong_t)&ad7384_chip_info },
+	{ "ad7380-4", (kernel_ulong_t)&ad7380_4_chip_info },
+	{ "ad7381-4", (kernel_ulong_t)&ad7381_4_chip_info },
+	{ "ad7383-4", (kernel_ulong_t)&ad7383_4_chip_info },
+	{ "ad7384-4", (kernel_ulong_t)&ad7384_4_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7380_id_table);

-- 
2.44.0



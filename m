Return-Path: <linux-kernel+bounces-102288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE1987B130
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4589AB29DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0104133408;
	Wed, 13 Mar 2024 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMPaMNwf"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5600130AE5;
	Wed, 13 Mar 2024 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351626; cv=none; b=nWT6k2koL2Ovx4e698Hd1AODYO6mX43wM3Tj3hIyoovnzrBDhNspbF2r0C3VIzG6pRVRcfNA09Hiq4TalUZS4W0IeOD6NEIEfrumMucIi73djS3CCTEYbRVK/3jsPBDxjg9puzfCsgn8Zss9a9mZmdijBJdLAfcUjFlz7JNzAH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351626; c=relaxed/simple;
	bh=TA1y5b636zP09b5cRSGNjocDkGQZA6dZ+p28CQdY4aY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q+boZ5vn8VFg4uvSNkqqf6Mp83udc4R3GcAu9D6J6YYGChw15aHfuBh/18Ts0+E0KSBc3+KtBGWkil9wF4jKof0UEJ+/bQCkFdj/c2sNkHom1jtC4aLzaV3AnDFSnE4X7SqCpsn4xZl07bhpHFkETmZS72zNbkA6OEtsgFVExUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMPaMNwf; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a466381b411so12879866b.2;
        Wed, 13 Mar 2024 10:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710351623; x=1710956423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORPW/2ZdzZ09PyYXpFYFfEaDEBdWrfCLAH5sJrFRgL4=;
        b=JMPaMNwfck/d9hN2QBDouv/ZS3FwzdONuL4CHEYnvlcr/plTCNrbk67a6xvblXsSN9
         NGwpNPKiqcpUH7AKOJi9cXd+NCcBAcExlYchNItCMayz1WELGnnkaoSTvVwiZpH3z9yw
         1GTKi67IgDjPHBua8j7YEgYlP9t5379Sr4XfbTCpap7ZQRTHQwhQAna1z1W0+qRzw3t2
         T61BmHTdfMqW6UgkQt4kTAVkC7kCkHyJVGkk+uxKRqp2cKpjVwAWwbxGZpoCcfGsx89/
         AWq6aZMkTA+liF/OqOf0UBHTL9PIL6ywFKXeRycejwA48FULHy2PbBkg0QXeWbH+enoC
         TUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351623; x=1710956423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORPW/2ZdzZ09PyYXpFYFfEaDEBdWrfCLAH5sJrFRgL4=;
        b=mC7561kfAmVsGTTcYD2HsRkOwo5HaJxG8cJhxK/jc6Tn1wo0+x4SH2TUIMkcxIUODW
         oHFG9cYAvpiAeaIp8ZUyUacMbD7Xle3lhgleg4MKkN5n0C2N0byPxSoTIpxEjKV1uT1d
         HCrUgkYrLpxzQtl6aZ2poEGGvvj/okPADPvjH2zzT/GJ4Vwiru5CDm8cVE0Sua3swV35
         /YW6rHTmtOhHuWLVXTG4UUGB5gRXj96KaRKXhDi1lqNynvjFY88w4HfetMzPucXGgt5r
         qtWOFQrAJrgLpybV/2/KquN4MVZZuTOu0IMolvc5BMNdPWFIuOUB4vlYCvBvN/EnXXnJ
         4zxA==
X-Forwarded-Encrypted: i=1; AJvYcCWLLnHpE0jKlWOKC5MI5vyQp7nAa15sIPbA0/RrxYXAlN/sRkPbRpTVTcXBYFtrnp7TgYoZneluo9ntxeAogwUlTBKlWYV4XD2lxVZ4KJaoLkDj3JzFdWQBm1koBLb4ReYjhYN4ggkR
X-Gm-Message-State: AOJu0Yx+6FfbGZsxXcNYHGVfnOv8eNMHWmxNPu94eKAxBwTlfD/uQWZ9
	1K0QOEAs1aPsEoJXSiiN0ugItXZUOOdiSqa9DXD1tvK+zoZ02qzL
X-Google-Smtp-Source: AGHT+IFWl2+PSZlnEjBjFEKLfk48VCPTdUb486waFs89vkIiUVnQrE3LLmxSKPzOz9DFeW2A1ENZ4w==
X-Received: by 2002:a17:906:eece:b0:a45:511:1533 with SMTP id wu14-20020a170906eece00b00a4505111533mr10619941ejb.75.1710351623116;
        Wed, 13 Mar 2024 10:40:23 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:fa35:157e:1a40:3463])
        by smtp.gmail.com with ESMTPSA id m17-20020a1709061ed100b00a449076d0dbsm5028215ejj.53.2024.03.13.10.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:40:22 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	linus.walleij@linaro.org,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v2 5/6] iio: pressure: Add timestamp and scan_masks for BMP280 driver
Date: Wed, 13 Mar 2024 18:40:06 +0100
Message-Id: <20240313174007.1934983-6-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240313174007.1934983-1-vassilisamir@gmail.com>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scan mask for the BME280 supports humidity measurement needs
to be distinguished from the rest in order for the timestamp to
be able to work. Scan masks are added for different combinations
of measurements. The temperature measurement is always needed for
pressure and humidity measurements.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 116 +++++++++++++++++++++++++----
 drivers/iio/pressure/bmp280.h      |   1 +
 2 files changed, 102 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 377e90d9e5a2..f2cf9bef522c 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -134,40 +134,91 @@ enum {
 	BMP380_P11 = 20,
 };
 
+enum bmp280_scan {
+	BMP280_TEMP,
+	BMP280_PRESS,
+	BME280_HUMID,
+};
+
 static const struct iio_chan_spec bmp280_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
+	},
 	{
 		.type = IIO_PRESSURE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
+};
+
+static const struct iio_chan_spec bme280_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
-		.type = IIO_HUMIDITYRELATIVE,
+		.type = IIO_PRESSURE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
-};
-
-static const struct iio_chan_spec bmp380_channels[] = {
 	{
-		.type = IIO_PRESSURE,
+		.type = IIO_HUMIDITYRELATIVE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.scan_index = 2,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static const struct iio_chan_spec bmp380_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
@@ -176,16 +227,31 @@ static const struct iio_chan_spec bmp380_channels[] = {
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
-		.type = IIO_HUMIDITYRELATIVE,
+		.type = IIO_PRESSURE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
 static int bmp280_read_calib(struct bmp280_data *data)
@@ -829,6 +895,20 @@ static const struct iio_info bmp280_info = {
 	.write_raw = &bmp280_write_raw,
 };
 
+static const unsigned long bmp280_avail_scan_masks[] = {
+	BIT(BMP280_TEMP),
+	BIT(BMP280_PRESS) | BIT(BMP280_TEMP),
+	0
+};
+
+static const unsigned long bme280_avail_scan_masks[] = {
+	BIT(BMP280_TEMP),
+	BIT(BMP280_PRESS) | BIT(BMP280_TEMP),
+	BIT(BME280_HUMID) | BIT(BMP280_TEMP),
+	BIT(BME280_HUMID) | BIT(BMP280_PRESS) | BIT(BMP280_TEMP),
+	0
+};
+
 static int bmp280_chip_config(struct bmp280_data *data)
 {
 	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
@@ -870,7 +950,8 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.regmap_config = &bmp280_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
-	.num_channels = 2,
+	.num_channels = 3,
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
@@ -927,8 +1008,9 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_chip_id = ARRAY_SIZE(bme280_chip_ids),
 	.regmap_config = &bmp280_regmap_config,
 	.start_up_time = 2000,
-	.channels = bmp280_channels,
-	.num_channels = 3,
+	.channels = bme280_channels,
+	.num_channels = 4,
+	.avail_scan_masks = bme280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
@@ -1292,7 +1374,8 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.regmap_config = &bmp380_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
-	.num_channels = 2,
+	.num_channels = 3,
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp380_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp380_oversampling_avail),
@@ -1787,7 +1870,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.regmap_config = &bmp580_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
-	.num_channels = 2,
+	.num_channels = 3,
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp580_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp580_oversampling_avail),
@@ -2039,7 +2123,8 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.regmap_config = &bmp180_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
-	.num_channels = 2,
+	.num_channels = 3,
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp180_oversampling_temp_avail,
 	.num_oversampling_temp_avail =
@@ -2149,6 +2234,7 @@ int bmp280_common_probe(struct device *dev,
 	/* Apply initial values from chip info structure */
 	indio_dev->channels = chip_info->channels;
 	indio_dev->num_channels = chip_info->num_channels;
+	indio_dev->available_scan_masks = chip_info->avail_scan_masks;
 	data->oversampling_press = chip_info->oversampling_press_default;
 	data->oversampling_humid = chip_info->oversampling_humid_default;
 	data->oversampling_temp = chip_info->oversampling_temp_default;
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index dde55b556ea2..c8cb7c417dab 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -427,6 +427,7 @@ struct bmp280_chip_info {
 	const struct iio_chan_spec *channels;
 	int num_channels;
 	unsigned int start_up_time;
+	const unsigned long *avail_scan_masks;
 
 	const int *oversampling_temp_avail;
 	int num_oversampling_temp_avail;
-- 
2.25.1



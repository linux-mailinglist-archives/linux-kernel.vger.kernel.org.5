Return-Path: <linux-kernel+bounces-134592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DB989B354
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52C36B222E7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90A43FE4C;
	Sun,  7 Apr 2024 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ/hrnSe"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4618B3D55D;
	Sun,  7 Apr 2024 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712510980; cv=none; b=R78kDfrSbf1zzVkhZeoVuqBNios1DGpiPh+z9f6aN+5GjEixRVju9cyIuscoMvszDMLf4ElPJDaBvi7HgYqOGvRenyJkfXltjJpFX/HvmXoy0C5MIR9VAoNw8sTym9DPc9v+bl3Q0IlDoFfiBdMPkHYyaN4VFwvLFphBEITPp1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712510980; c=relaxed/simple;
	bh=bDSrE49DJaFMp6nzyT3Vq5oH100SGo3A5bocuOqYlGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HPNzu0UC5RQiOEwQFI2o4790hQoDQmqVwxfSmrz4yQeIzSSB//IP2bT5GwJs1h9U2NPdXmP73MQaz5ty5snZC5QaUMM4cmEZkgibHAh+OPwUOh0vePxEjO4yUellBQVYxe2TxUcgBbi6Yl6BjPcw35i0FBjAK+K9apmLB03f//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJ/hrnSe; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e480e770fso1081082a12.3;
        Sun, 07 Apr 2024 10:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712510975; x=1713115775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HylzSiiVBo6+8SBkXof+PZydI6eLgRQvjYi5HT+p0tI=;
        b=hJ/hrnSeqihBGL/1R2T5ubK5cO5jxq4sXQmQH7QTL02Zv467lCKWvwTbaeAMt6YLxN
         qRDpHF9BXEZdG1pNa6erttQ18GzUDdELnE7KODLSpgC49F93rRikWuDDXYcJ/9FNjRps
         45fmDmOhtxo3fq6WNqfjTJ+K59G1fPt8cvxeX8flqQeLTjwpWaA1xkGKs90UfxErwG4r
         F2zNL4dpMd0k9k+SsJ1NYmaEL0hy0sikpPWxdaSDI8E/JcW54iRcjASZACyVSBUJd7LY
         SgdRnO3WVZ9bAaYUGyAkA/Te1e/ZAZz29W2o9GCatLz6W8WQc17q15HtWozfZxF0hEb5
         Gm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712510975; x=1713115775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HylzSiiVBo6+8SBkXof+PZydI6eLgRQvjYi5HT+p0tI=;
        b=WjSuJ5AgBZZZSXYwvo7SyYrvDxCYivgGfC2mYxKID+wbWG4+ZF/XXrX1nlw3ZtM6b2
         ymx1r7hbBSsguyKJtME0XwzLXUOKpvB2n5mG/Lvzw1rND8PMdJZMU3qHNFjwuXdGkT2o
         d4ydqijDGyckMRBsrUUJJCkLO1IGQ2bnf1VmZ/CPK5cvaNxevxqjt/rUIbQorCtNWGwC
         VhuRhNCjGSez/jWx5os6VcDehr1fNb5CtJIRhow13Zv8DvEUw/eTo4ZR3nI6LJrp7MjX
         07eTg1Ypy8liXAQe3nXJ80HRiY/Fntge03IeayyKDkcZal+ziWVSTDK29WHXFWixebnj
         sO0g==
X-Forwarded-Encrypted: i=1; AJvYcCVjhFQXc7j2umroW4ugFAJqWGCuNw+RGNetLwCCJCJo1A3eSJkk+6JYgcoWf8ZpuAozktcLKQClF+drODdtKAPqeBUZxOtxewuNBkZmsf0Uhi2mLjiUHQhYtB3f2yTBwE2sS31UDFHa
X-Gm-Message-State: AOJu0YysVKXwtBCSFsNhrQDzb5xpPa/jkkT7FA/SwLDpEjimkzYQDwLV
	r6+D3++wGiBD3uVQIkePuta1fGN7OueZXJTDpVUAiV+BfO5DL1qB
X-Google-Smtp-Source: AGHT+IEQo60vy5rPNNabOMuWJFqzeLBM9CPIgVZLGuo931CAchgtkOpPYC5/ljLBjOR82200nHncDA==
X-Received: by 2002:a50:d4c5:0:b0:56e:2332:cb4b with SMTP id e5-20020a50d4c5000000b0056e2332cb4bmr4157226edj.40.1712510975595;
        Sun, 07 Apr 2024 10:29:35 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:c509:e54e:6ef:eb0c])
        by smtp.gmail.com with ESMTPSA id j22-20020aa7c416000000b0056e4b9ec1aasm1307134edq.52.2024.04.07.10.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 10:29:35 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	u.kleine-koenig@pengutronix.de,
	biju.das.jz@bp.renesas.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v4 6/6] iio: pressure: bmp280: Add triggered buffer support
Date: Sun,  7 Apr 2024 19:29:20 +0200
Message-Id: <20240407172920.264282-7-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240407172920.264282-1-vassilisamir@gmail.com>
References: <20240407172920.264282-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BMP2xx, BME280, BMP3xx, and BMP5xx use continuous buffers for their
temperature, pressure and humidity readings. This facilitates the
use of burst/bulk reads in order to acquire data faster. The
approach is different from the one used in oneshot captures.

BMP085 & BMP1xx devices use a completely different measurement
process that is well defined and is used in their buffer_handler().

Suggested-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/Kconfig       |   2 +
 drivers/iio/pressure/bmp280-core.c | 338 +++++++++++++++++++++++++++--
 drivers/iio/pressure/bmp280-spi.c  |   8 +-
 drivers/iio/pressure/bmp280.h      |  21 +-
 4 files changed, 347 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 3ad38506028e..0b5406a3f85d 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -31,6 +31,8 @@ config BMP280
 	select REGMAP
 	select BMP280_I2C if (I2C)
 	select BMP280_SPI if (SPI_MASTER)
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Bosch Sensortec BMP180, BMP280, BMP380
 	  and BMP580 pressure and temperature sensors. Also supports the BME280 with
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 1b894feb717b..32dd35475826 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -41,7 +41,10 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #include <asm/unaligned.h>
 
@@ -134,6 +137,12 @@ enum {
 	BMP380_P11 = 20
 };
 
+enum bmp280_scan {
+	BMP280_PRESS,
+	BMP280_TEMP,
+	BME280_HUMID,
+};
+
 static const struct iio_chan_spec bmp280_channels[] = {
 	{
 		.type = IIO_PRESSURE,
@@ -142,6 +151,13 @@ static const struct iio_chan_spec bmp280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
 		.type = IIO_TEMP,
@@ -150,7 +166,15 @@ static const struct iio_chan_spec bmp280_channels[] = {
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
 };
 
 static const struct iio_chan_spec bme280_channels[] = {
@@ -161,6 +185,13 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
 		.type = IIO_TEMP,
@@ -169,6 +200,13 @@ static const struct iio_chan_spec bme280_channels[] = {
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
 	{
 		.type = IIO_HUMIDITYRELATIVE,
@@ -177,7 +215,15 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 2,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 static const struct iio_chan_spec bmp380_channels[] = {
@@ -190,6 +236,13 @@ static const struct iio_chan_spec bmp380_channels[] = {
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
 		.type = IIO_TEMP,
@@ -200,7 +253,15 @@ static const struct iio_chan_spec bmp380_channels[] = {
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
 static int bmp280_read_calib(struct bmp280_data *data)
@@ -321,7 +382,7 @@ static int bme280_read_humid_adc(struct bmp280_data *data, s32 *adc_humidity)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
-			       &data->be16, sizeof(data->be16));
+			       &data->be16, BME280_NUM_HUMIDITY_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read humidity\n");
 		return ret;
@@ -366,7 +427,7 @@ static int bmp280_read_temp_adc(struct bmp280_data *data, s32 *adc_temp)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_TEMP_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
@@ -425,7 +486,7 @@ static int bmp280_read_press_adc(struct bmp280_data *data, s32 *adc_press)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_PRESS_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
@@ -866,6 +927,16 @@ static const struct iio_info bmp280_info = {
 	.write_raw = &bmp_write_raw,
 };
 
+static const unsigned long bmp280_avail_scan_masks[] = {
+	BIT(BMP280_TEMP) | BIT(BMP280_PRESS),
+	0
+};
+
+static const unsigned long bme280_avail_scan_masks[] = {
+	BIT(BME280_HUMID) | BIT(BMP280_TEMP) | BIT(BMP280_PRESS),
+	0
+};
+
 static int bmp280_chip_config(struct bmp280_data *data)
 {
 	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
@@ -893,6 +964,72 @@ static int bmp280_chip_config(struct bmp280_data *data)
 	return ret;
 }
 
+static irqreturn_t bmp280_buffer_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmp280_data *data = iio_priv(indio_dev);
+	s32 adc_temp, adc_press, adc_humidity, t_fine;
+	u8 sizeof_burst_read;
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	/* If humidity channel is enabled it means that we are called for the
+	 * BME280 humidity sensor.
+	 */
+	if (test_bit(BME280_HUMID, indio_dev->active_scan_mask))
+		sizeof_burst_read = BME280_BURST_READ_BYTES;
+	else
+		sizeof_burst_read = BMP280_BURST_READ_BYTES;
+
+	/* Burst read data registers */
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
+			       data->buf, sizeof_burst_read);
+	if (ret) {
+		dev_err(data->dev, "failed to burst read sensor data\n");
+		return IRQ_HANDLED;
+	}
+
+	/* Temperature calculations */
+	adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[3]));
+	if (adc_temp == BMP280_TEMP_SKIPPED) {
+		dev_err(data->dev, "reading temperature skipped\n");
+		return IRQ_HANDLED;
+	}
+
+	data->sensor_data[1] = bmp280_compensate_temp(data, adc_temp);
+
+	/* Pressure calculations */
+	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[0]));
+	if (adc_press == BMP280_PRESS_SKIPPED) {
+		dev_err(data->dev, "reading pressure skipped\n");
+		return IRQ_HANDLED;
+	}
+
+	t_fine = bmp280_calc_t_fine(data, adc_temp);
+
+	data->sensor_data[0] = bmp280_compensate_press(data, adc_press, t_fine);
+
+	/* Humidity calculations */
+	if (test_bit(BME280_HUMID, indio_dev->active_scan_mask)) {
+		adc_humidity = get_unaligned_be16(&data->buf[6]);
+
+		if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
+			dev_err(data->dev, "reading humidity skipped\n");
+			return IRQ_HANDLED;
+		}
+		data->sensor_data[2] = bme280_compensate_humidity(data, adc_humidity, t_fine);
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+					   iio_get_time_ns(indio_dev));
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
 static const int bmp280_temp_coeffs[] = { 10, 1 };
@@ -905,7 +1042,8 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.regmap_config = &bmp280_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
-	.num_channels = 2,
+	.num_channels = 3,
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
@@ -934,6 +1072,8 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_calib = bmp280_read_calib,
+
+	.buffer_handler = bmp280_buffer_handler,
 };
 EXPORT_SYMBOL_NS(bmp280_chip_info, IIO_BMP280);
 
@@ -966,7 +1106,8 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.regmap_config = &bmp280_regmap_config,
 	.start_up_time = 2000,
 	.channels = bme280_channels,
-	.num_channels = 3,
+	.num_channels = 4,
+	.avail_scan_masks = bme280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
@@ -992,6 +1133,8 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.read_press = bmp280_read_press,
 	.read_humid = bme280_read_humid,
 	.read_calib = bme280_read_calib,
+
+	.buffer_handler = bmp280_buffer_handler,
 };
 EXPORT_SYMBOL_NS(bme280_chip_info, IIO_BMP280);
 
@@ -1052,7 +1195,7 @@ static int bmp380_read_temp_adc(struct bmp280_data *data, u32 *adc_temp)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_TEMP_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
@@ -1119,7 +1262,7 @@ static int bmp380_read_press_adc(struct bmp280_data *data, u32 *adc_press)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_PRESS_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
@@ -1368,6 +1511,52 @@ static int bmp380_chip_config(struct bmp280_data *data)
 	return 0;
 }
 
+static irqreturn_t bmp380_buffer_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmp280_data *data = iio_priv(indio_dev);
+	s32 adc_temp, adc_press, t_fine;
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	/* Burst read data registers */
+	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
+			       data->buf, BMP280_BURST_READ_BYTES);
+	if (ret) {
+		dev_err(data->dev, "failed to burst read sensor data\n");
+		return IRQ_HANDLED;
+	}
+
+	/* Temperature calculations */
+	adc_temp = get_unaligned_le24(&data->buf[3]);
+	if (adc_temp == BMP380_TEMP_SKIPPED) {
+		dev_err(data->dev, "reading temperature skipped\n");
+		return IRQ_HANDLED;
+	}
+
+	data->sensor_data[1] = bmp380_compensate_temp(data, adc_temp);
+
+	/* Pressure calculations */
+	adc_press = get_unaligned_le24(&data->buf[0]);
+	if (adc_press == BMP380_PRESS_SKIPPED) {
+		dev_err(data->dev, "reading pressure skipped\n");
+		return IRQ_HANDLED;
+	}
+
+	t_fine = bmp380_calc_t_fine(data, adc_temp);
+
+	data->sensor_data[0] = bmp380_compensate_press(data, adc_press, t_fine);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+					   iio_get_time_ns(indio_dev));
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
 static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
 static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
@@ -1382,7 +1571,8 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.spi_read_extra_byte = true,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
-	.num_channels = 2,
+	.num_channels = 3,
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp380_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp380_oversampling_avail),
@@ -1410,6 +1600,8 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.read_press = bmp380_read_press,
 	.read_calib = bmp380_read_calib,
 	.preinit = bmp380_preinit,
+
+	.buffer_handler = bmp380_buffer_handler,
 };
 EXPORT_SYMBOL_NS(bmp380_chip_info, IIO_BMP280);
 
@@ -1525,8 +1717,8 @@ static int bmp580_read_temp(struct bmp280_data *data, s32 *raw_temp)
 {
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB, data->buf,
-			       sizeof(data->buf));
+	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB,
+			       data->buf, BMP280_NUM_TEMP_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
@@ -1545,8 +1737,8 @@ static int bmp580_read_press(struct bmp280_data *data, u32 *raw_press)
 {
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB, data->buf,
-			       sizeof(data->buf));
+	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB,
+			       data->buf, BMP280_NUM_PRESS_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
@@ -1870,6 +2062,54 @@ static int bmp580_chip_config(struct bmp280_data *data)
 	return 0;
 }
 
+static irqreturn_t bmp580_buffer_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmp280_data *data = iio_priv(indio_dev);
+	s32 adc_temp, adc_press;
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	/* If humidity channel is enabled it means that we are called for the
+	 * BME280 humidity sensor.
+	 */
+
+	/* Burst read data registers */
+	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB,
+			       data->buf, BMP280_BURST_READ_BYTES);
+	if (ret) {
+		dev_err(data->dev, "failed to burst read sensor data\n");
+		return IRQ_HANDLED;
+	}
+
+	/* Temperature calculations */
+	adc_temp = get_unaligned_le24(&data->buf[0]);
+	if (adc_temp == BMP580_TEMP_SKIPPED) {
+		dev_err(data->dev, "reading temperature skipped\n");
+		return IRQ_HANDLED;
+	}
+
+	data->sensor_data[1] = adc_temp;
+
+	/* Pressure calculations */
+	adc_press = get_unaligned_le24(&data->buf[3]);
+	if (adc_press == BMP380_PRESS_SKIPPED) {
+		dev_err(data->dev, "reading pressure skipped\n");
+		return IRQ_HANDLED;
+	}
+
+	data->sensor_data[0] = adc_press;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+					   iio_get_time_ns(indio_dev));
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
 static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
 static const int bmp580_temp_coeffs[] = { 1000, 16 };
@@ -1882,7 +2122,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.regmap_config = &bmp580_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
-	.num_channels = 2,
+	.num_channels = 3,
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp580_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp580_oversampling_avail),
@@ -1909,6 +2150,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.read_temp = bmp580_read_temp,
 	.read_press = bmp580_read_press,
 	.preinit = bmp580_preinit,
+
+	.buffer_handler = bmp580_buffer_handler,
 };
 EXPORT_SYMBOL_NS(bmp580_chip_info, IIO_BMP280);
 
@@ -2086,7 +2329,7 @@ static int bmp180_read_press_adc(struct bmp280_data *data, s32 *adc_press)
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_PRESS_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
@@ -2156,6 +2399,35 @@ static int bmp180_chip_config(struct bmp280_data *data)
 	return 0;
 }
 
+static irqreturn_t bmp180_buffer_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmp280_data *data = iio_priv(indio_dev);
+	int ret, chan_value;
+
+	guard(mutex)(&data->lock);
+
+	ret = bmp180_read_temp(data, &chan_value);
+	if (ret)
+		return IRQ_HANDLED;
+
+	data->sensor_data[1] = chan_value;
+
+	ret = bmp180_read_press(data, &chan_value);
+	if (ret)
+		return IRQ_HANDLED;
+
+	data->sensor_data[0] = chan_value;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+					   iio_get_time_ns(indio_dev));
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const int bmp180_oversampling_temp_avail[] = { 1 };
 static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
 static const u8 bmp180_chip_ids[] = { BMP180_CHIP_ID };
@@ -2169,7 +2441,8 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.regmap_config = &bmp180_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
-	.num_channels = 2,
+	.num_channels = 3,
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp180_oversampling_temp_avail,
 	.num_oversampling_temp_avail =
@@ -2190,6 +2463,8 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
 	.read_calib = bmp180_read_calib,
+
+	.buffer_handler = bmp180_buffer_handler,
 };
 EXPORT_SYMBOL_NS(bmp180_chip_info, IIO_BMP280);
 
@@ -2235,6 +2510,30 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 	return 0;
 }
 
+static int bmp_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct bmp280_data *data = iio_priv(indio_dev);
+
+	pm_runtime_get_sync(data->dev);
+
+	return 0;
+}
+
+static int bmp_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct bmp280_data *data = iio_priv(indio_dev);
+
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
+
+	return 0;
+}
+
+const struct iio_buffer_setup_ops bmp_buffer_setup_ops = {
+	.preenable = bmp_buffer_preenable,
+	.postdisable = bmp_buffer_postdisable,
+};
+
 static void bmp280_pm_disable(void *data)
 {
 	struct device *dev = data;
@@ -2281,6 +2580,7 @@ int bmp280_common_probe(struct device *dev,
 	/* Apply initial values from chip info structure */
 	indio_dev->channels = chip_info->channels;
 	indio_dev->num_channels = chip_info->num_channels;
+	indio_dev->available_scan_masks = chip_info->avail_scan_masks;
 	data->oversampling_press = chip_info->oversampling_press_default;
 	data->oversampling_humid = chip_info->oversampling_humid_default;
 	data->oversampling_temp = chip_info->oversampling_temp_default;
@@ -2366,6 +2666,14 @@ int bmp280_common_probe(struct device *dev,
 					     "failed to read calibration coefficients\n");
 	}
 
+	ret = devm_iio_triggered_buffer_setup(data->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      data->chip_info->buffer_handler,
+					      NULL);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "iio triggered buffer setup failed\n");
+
 	/*
 	 * Attempt to grab an optional EOC IRQ - only the BMP085 has this
 	 * however as it happens, the BMP085 shares the chip ID of BMP180
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index ce92f283e142..29b094b17c84 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -40,14 +40,10 @@ static int bmp380_regmap_spi_read(void *context, const void *reg,
 				  size_t reg_size, void *val, size_t val_size)
 {
 	struct spi_device *spi = to_spi_device(context);
-	u8 rx_buf[4];
+	u8 rx_buf[BMP280_BURST_READ_BYTES + 1];
 	ssize_t status;
 
-	/*
-	 * Maximum number of consecutive bytes read for a temperature or
-	 * pressure measurement is 3.
-	 */
-	if (val_size > 3)
+	if (val_size > BMP280_BURST_READ_BYTES)
 		return -EINVAL;
 
 	/*
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index ccba779d7a83..0373d5f9b9a8 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -301,6 +301,16 @@
 #define BMP280_PRESS_SKIPPED		0x80000
 #define BMP280_HUMIDITY_SKIPPED		0x8000
 
+/* Number of bytes for each value */
+#define BMP280_NUM_PRESS_BYTES		3
+#define BMP280_NUM_TEMP_BYTES		3
+#define BME280_NUM_HUMIDITY_BYTES	2
+#define BMP280_BURST_READ_BYTES		(BMP280_NUM_PRESS_BYTES + \
+					 BMP280_NUM_TEMP_BYTES)
+#define BME280_BURST_READ_BYTES		(BMP280_NUM_PRESS_BYTES + \
+					 BMP280_NUM_TEMP_BYTES + \
+					 BME280_NUM_HUMIDITY_BYTES)
+
 /* Core exported structs */
 
 static const char *const bmp280_supply_names[] = {
@@ -394,13 +404,19 @@ struct bmp280_data {
 	 */
 	int sampling_freq;
 
+	/*
+	 * Data to push to userspace triggered buffer. Up to 3 channels and
+	 * s64 timestamp, aligned.
+	 */
+	s32 sensor_data[5] __aligned(8);
+
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
 	 */
 	union {
 		/* Sensor data buffer */
-		u8 buf[3];
+		u8 buf[BMP280_BURST_READ_BYTES];
 		/* Calibration data buffers */
 		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
 		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
@@ -422,6 +438,7 @@ struct bmp280_chip_info {
 	const struct iio_chan_spec *channels;
 	int num_channels;
 	unsigned int start_up_time;
+	const unsigned long *avail_scan_masks;
 
 	const int *oversampling_temp_avail;
 	int num_oversampling_temp_avail;
@@ -456,6 +473,8 @@ struct bmp280_chip_info {
 	int (*read_humid)(struct bmp280_data *data, u32 *adc_humidity);
 	int (*read_calib)(struct bmp280_data *data);
 	int (*preinit)(struct bmp280_data *data);
+
+	irqreturn_t (*buffer_handler)(int irq, void *p);
 };
 
 /* Chip infos for each variant */
-- 
2.25.1



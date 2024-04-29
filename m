Return-Path: <linux-kernel+bounces-162873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829068B6190
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E441C2012A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCF813C9AA;
	Mon, 29 Apr 2024 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aauxvmO6"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600AF13C3EA;
	Mon, 29 Apr 2024 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417269; cv=none; b=KTHab9DMORvWYhuetcV2heZGpyre46C/VxypJ6oCa1HWCW6jFAYOz8dBQn77TM1WUTKAJpgIqVwr64AtnDeWeM5nKs/RrraWwmACnQX3vyldjgKTA+8JG5s8Q640kOdixLH2FG3R2gtjX/tyhYnfdjEvlbHGq0eHTPkK1MRiU9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417269; c=relaxed/simple;
	bh=FQ834MkUHmcBNDaCmnN/SB+UjZtSdHWN30xnAKSQS7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qKkwJ0WqrfN+aJXQ8jX9wBmAOxqSoLQHQdyloWVz3hEsb/N4htdO3tSpQ/ibaA7oiJZ11Mi5jQOoB8NTQWTF/MzXkRk1tOsak95HnNLIRFD4dj67b/swwO5+nXzTSfg6k8nX7hD50SunUU40aesxBJ6hCOmpofsGuvPOu1iSbo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aauxvmO6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-343e46ec237so4085015f8f.2;
        Mon, 29 Apr 2024 12:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417264; x=1715022064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3/iBXzdIz072pW4p/5iTz4vzAGpD6zPyh8wNEc+ajY=;
        b=aauxvmO6HlmUBuhfTGgRpuoainpYuArWf3LJvklOzai2mDST7epV0ml+MU8a3kwG4A
         GuXc5BLMUqcNSCTb+k/H0DIzHQ4kEQWyO8TmhZlPNpb8EOXUw2+RoDoueZ/zTgSw2sgG
         7DVcSSD/cJPaoBsEK7go6aeRHHdgCId6gJ5g9fmuU2lytM9fsh5PhCPM/TWNPU4AHB3e
         YOhhWtxbliJZ1cSQlqc/SzuCsg4Q52PIeWUSJZV38RhAZRpllHCxCK8vqeHebPd4yLMD
         KG7rscRDsX971nhaHmmJ2MQHzmy36gbmCWe919DnkxEE9cH+JlVtm/eeEx/FUl7zLl/p
         OXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417264; x=1715022064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3/iBXzdIz072pW4p/5iTz4vzAGpD6zPyh8wNEc+ajY=;
        b=ZSkb2jiBdtoZtMfmqpzXa5h0WsVjJPPpWgqFSw4Pr4PM/BIjPyldqxMSXSgzKLQxmK
         uAXT3NMZOZGWhZXO+tqcsNIcSq0/MkPp6Js0/Isb5LzwQVM9WeDHVo5ezRXIDlAtM7NV
         ds2aj7W9JndyBdvY0tPmdGmkrnaH2ryKyYo8jfhqhsPWE/qq/McHRgjAL0Og8x/aDS9H
         P1FAl2qIwgKXaRU1/WPatfS0LEsN7js6wRrsTsi2i1e5RNfqOZx8AnSoVO/rjn9hejOK
         b/E6Vs37Eqf0GZUlZZJ2g8y1jVxml/MVpxroLly4ILEH7xaX34PKpr3Gwbe8UEZQCPHZ
         rPLw==
X-Forwarded-Encrypted: i=1; AJvYcCUMKj8yLUNGr74/grQH0PkTXJUyrqP9eol+21mDUnZVkcy8T9udYEvkACpLy9xKy8NeBOJjp2Rm29/pvdxJKmJlpkQLwjTGIJpqbUwjXuotWbZyHu+NRvgEfH0jk9MPEsAHDfKy8TRP
X-Gm-Message-State: AOJu0Yzi+lCds8DtW5cYJGwPsB5siL43IJuIrZ/dPfalhtvpIQS6tCXU
	Xh0MoQLETCHw2NTof0W+CMoCKkJYpnRi9GREQ06V4CY+eYVht0lj
X-Google-Smtp-Source: AGHT+IEu3a96lk1ZlSvcb1+ofUEoW3P6yFb7F4kj2qTiAvyWUf5z6NluW2j9KsepTuI2xuvmkxMeaQ==
X-Received: by 2002:a05:6000:506:b0:34a:3f3d:bb14 with SMTP id a6-20020a056000050600b0034a3f3dbb14mr5993297wrf.27.1714417263259;
        Mon, 29 Apr 2024 12:01:03 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:abbf:c98a:cf84:d14c])
        by smtp.gmail.com with ESMTPSA id x2-20020adfdd82000000b0034c78bba70bsm8469456wrl.72.2024.04.29.12.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:01:02 -0700 (PDT)
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
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 06/10] iio: pressure: bmp280: Refactorize reading functions
Date: Mon, 29 Apr 2024 21:00:42 +0200
Message-Id: <20240429190046.24252-7-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240429190046.24252-1-vassilisamir@gmail.com>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For BMP18x, BMP28x, BME280, BMP38x the reading of the pressure
value requires an update of the t_fine variable which happens
through reading the temperature value.

So all the bmpxxx_read_press() functions of the above sensors
are internally calling the equivalent bmpxxx_read_temp() function
in order to update the t_fine value. By just looking at the code
this functionality is a bit hidden and is not easy to understand
why those channels are not independent.

This commit tries to clear these things a bit by splitting the
bmpxxx_{read/compensate}_{temp/press/humid}() to the following:

i. bmpxxx_read_{temp/press/humid}_adc(): read the raw value from
the sensor.

ii. bmpxx_calc_t_fine(): calculate the t_fine variable.

iii. bmpxxx_get_t_fine(): get the t_fine variable.

iv. bmpxxx_compensate_{temp/press/humid}(): compensate the adc
values and return the calculated value.

v. bmpxxx_read_{temp/press/humid}(): combine calls of the
aforementioned functions to return the requested value.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 351 ++++++++++++++++++-----------
 drivers/iio/pressure/bmp280.h      |   6 -
 2 files changed, 221 insertions(+), 136 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 8290028824e9..5ebce38e99f6 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -288,13 +288,33 @@ static int bme280_read_calib(struct bmp280_data *data)
  *
  * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
  */
+static int bme280_read_humid_adc(struct bmp280_data *data, s32 *adc_humidity)
+{
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
+			       &data->be16, sizeof(data->be16));
+	if (ret < 0) {
+		dev_err(data->dev, "failed to read humidity\n");
+		return ret;
+	}
+
+	*adc_humidity = be16_to_cpu(data->be16);
+	if (*adc_humidity == BMP280_HUMIDITY_SKIPPED) {
+		dev_err(data->dev, "reading humidity skipped\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static u32 bme280_compensate_humidity(struct bmp280_data *data,
-				      s32 adc_humidity)
+				      s32 adc_humidity, s32 t_fine)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	s32 var;
 
-	var = ((s32)data->t_fine) - (s32)76800;
+	var = ((s32)t_fine) - (s32)76800;
 	var = ((((adc_humidity << 14) - (calib->H4 << 20) - (calib->H5 * var))
 		+ (s32)16384) >> 15) * (((((((var * calib->H6) >> 10)
 		* (((var * (s32)calib->H3) >> 11) + (s32)32768)) >> 10)
@@ -313,8 +333,27 @@ static u32 bme280_compensate_humidity(struct bmp280_data *data,
  *
  * Taken from datasheet, Section 3.11.3, "Compensation formula".
  */
-static s32 bmp280_compensate_temp(struct bmp280_data *data,
-				  s32 adc_temp)
+static int bmp280_read_temp_adc(struct bmp280_data *data, s32 *adc_temp)
+{
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
+			       data->buf, sizeof(data->buf));
+	if (ret < 0) {
+		dev_err(data->dev, "failed to read temperature\n");
+		return ret;
+	}
+
+	*adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
+	if (*adc_temp == BMP280_TEMP_SKIPPED) {
+		dev_err(data->dev, "reading temperature skipped\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static s32 bmp280_calc_t_fine(struct bmp280_data *data, s32 adc_temp)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	s32 var1, var2;
@@ -324,9 +363,26 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
 	var2 = (((((adc_temp >> 4) - ((s32)calib->T1)) *
 		  ((adc_temp >> 4) - ((s32)calib->T1))) >> 12) *
 		((s32)calib->T3)) >> 14;
-	data->t_fine = var1 + var2;
+	return var1 + var2; /* t_fine = var1 + var2 */
+}
+
+static int bmp280_get_t_fine(struct bmp280_data *data, s32 *t_fine)
+{
+	s32 adc_temp;
+	int ret;
+
+	ret = bmp280_read_temp_adc(data, &adc_temp);
+	if (ret < 0)
+		return ret;
+
+	*t_fine = bmp280_calc_t_fine(data, adc_temp);
 
-	return (data->t_fine * 5 + 128) >> 8;
+	return 0;
+}
+
+static s32 bmp280_compensate_temp(struct bmp280_data *data, s32 adc_temp)
+{
+	return (bmp280_calc_t_fine(data, adc_temp) * 5 + 128) / 256;
 }
 
 /*
@@ -336,13 +392,33 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
  *
  * Taken from datasheet, Section 3.11.3, "Compensation formula".
  */
+static int bmp280_read_press_adc(struct bmp280_data *data, s32 *adc_press)
+{
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
+			       data->buf, sizeof(data->buf));
+	if (ret < 0) {
+		dev_err(data->dev, "failed to read pressure\n");
+		return ret;
+	}
+
+	*adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
+	if (*adc_press == BMP280_PRESS_SKIPPED) {
+		dev_err(data->dev, "reading pressure skipped\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static u32 bmp280_compensate_press(struct bmp280_data *data,
-				   s32 adc_press)
+				   s32 adc_press, s32 t_fine)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	s64 var1, var2, p;
 
-	var1 = ((s64)data->t_fine) - 128000;
+	var1 = ((s64)t_fine) - 128000;
 	var2 = var1 * var1 * (s64)calib->P6;
 	var2 += (var1 * (s64)calib->P5) << 17;
 	var2 += ((s64)calib->P4) << 35;
@@ -368,60 +444,35 @@ static int bmp280_read_temp(struct bmp280_data *data,
 	s32 adc_temp, comp_temp;
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
-			       data->buf, sizeof(data->buf));
-	if (ret < 0) {
-		dev_err(data->dev, "failed to read temperature\n");
+	ret = bmp280_read_temp_adc(data, &adc_temp);
+	if (ret < 0)
 		return ret;
-	}
 
-	adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
-	if (adc_temp == BMP280_TEMP_SKIPPED) {
-		/* reading was skipped */
-		dev_err(data->dev, "reading temperature skipped\n");
-		return -EIO;
-	}
 	comp_temp = bmp280_compensate_temp(data, adc_temp);
 
-	/*
-	 * val might be NULL if we're called by the read_press routine,
-	 * who only cares about the carry over t_fine value.
-	 */
-	if (val) {
-		*val = comp_temp * 10;
-		return IIO_VAL_INT;
-	}
-
-	return 0;
+	/* IIO units are in milli Celsius */
+	*val = comp_temp * 10;
+	return IIO_VAL_INT;
 }
 
 static int bmp280_read_press(struct bmp280_data *data,
 			     int *val, int *val2)
 {
+	s32 adc_press, t_fine;
 	u32 comp_press;
-	s32 adc_press;
 	int ret;
 
-	/* Read and compensate temperature so we get a reading of t_fine. */
-	ret = bmp280_read_temp(data, NULL, NULL);
+	ret = bmp280_get_t_fine(data, &t_fine);
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
-			       data->buf, sizeof(data->buf));
-	if (ret < 0) {
-		dev_err(data->dev, "failed to read pressure\n");
+	ret = bmp280_read_press_adc(data, &adc_press);
+	if (ret < 0)
 		return ret;
-	}
 
-	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
-	if (adc_press == BMP280_PRESS_SKIPPED) {
-		/* reading was skipped */
-		dev_err(data->dev, "reading pressure skipped\n");
-		return -EIO;
-	}
-	comp_press = bmp280_compensate_press(data, adc_press);
+	comp_press = bmp280_compensate_press(data, adc_press, t_fine);
 
+	/* IIO units are in kPa */
 	*val = comp_press;
 	*val2 = 256000;
 
@@ -430,30 +481,21 @@ static int bmp280_read_press(struct bmp280_data *data,
 
 static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
 {
+	s32 adc_humidity, t_fine;
 	u32 comp_humidity;
-	s32 adc_humidity;
 	int ret;
 
-	/* Read and compensate temperature so we get a reading of t_fine. */
-	ret = bmp280_read_temp(data, NULL, NULL);
+	ret = bmp280_get_t_fine(data, &t_fine);
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
-			       &data->be16, sizeof(data->be16));
-	if (ret < 0) {
-		dev_err(data->dev, "failed to read humidity\n");
+	ret = bme280_read_humid_adc(data, &adc_humidity);
+	if (ret < 0)
 		return ret;
-	}
 
-	adc_humidity = be16_to_cpu(data->be16);
-	if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
-		/* reading was skipped */
-		dev_err(data->dev, "reading humidity skipped\n");
-		return -EIO;
-	}
-	comp_humidity = bme280_compensate_humidity(data, adc_humidity);
+	comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
 
+	/* IIO units are in 1000 * % */
 	*val = comp_humidity * 1000 / 1024;
 
 	return IIO_VAL_INT;
@@ -930,9 +972,29 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
  * Taken from datasheet, Section Appendix 9, "Compensation formula" and repo
  * https://github.com/BoschSensortec/BMP3-Sensor-API.
  */
-static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
+static int bmp380_read_temp_adc(struct bmp280_data *data, u32 *adc_temp)
+{
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB,
+			       data->buf, sizeof(data->buf));
+	if (ret < 0) {
+		dev_err(data->dev, "failed to read temperature\n");
+		return ret;
+	}
+
+	*adc_temp = get_unaligned_le24(data->buf);
+	if (*adc_temp == BMP380_TEMP_SKIPPED) {
+		dev_err(data->dev, "reading temperature skipped\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static s32 bmp380_calc_t_fine(struct bmp280_data *data, u32 adc_temp)
 {
-	s64 var1, var2, var3, var4, var5, var6, comp_temp;
+	s64 var1, var2, var3, var4, var5, var6;
 	struct bmp380_calib *calib = &data->calib.bmp380;
 
 	var1 = ((s64) adc_temp) - (((s64) calib->T1) << 8);
@@ -941,7 +1003,29 @@ static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
 	var4 = var3 * ((s64) calib->T3);
 	var5 = (var2 << 18) + var4;
 	var6 = var5 >> 32;
-	data->t_fine = (s32) var6;
+	return (s32) var6; /* t_fine = var6 */
+}
+
+static int bmp380_get_t_fine(struct bmp280_data *data, s32 *t_fine)
+{
+	s32 adc_temp;
+	int ret;
+
+	ret = bmp380_read_temp_adc(data, &adc_temp);
+	if (ret < 0)
+		return ret;
+
+	*t_fine = bmp380_calc_t_fine(data, adc_temp);
+
+	return 0;
+}
+
+static int bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
+{
+	s64 comp_temp;
+	s32 var6;
+
+	var6 = bmp380_calc_t_fine(data, adc_temp);
 	comp_temp = (var6 * 25) >> 14;
 
 	comp_temp = clamp_val(comp_temp, BMP380_MIN_TEMP, BMP380_MAX_TEMP);
@@ -955,27 +1039,48 @@ static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
  * Taken from datasheet, Section 9.3. "Pressure compensation" and repository
  * https://github.com/BoschSensortec/BMP3-Sensor-API.
  */
-static u32 bmp380_compensate_press(struct bmp280_data *data, u32 adc_press)
+static int bmp380_read_press_adc(struct bmp280_data *data, u32 *adc_press)
+{
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
+			       data->buf, sizeof(data->buf));
+	if (ret < 0) {
+		dev_err(data->dev, "failed to read pressure\n");
+		return ret;
+	}
+
+	*adc_press = get_unaligned_le24(data->buf);
+	if (*adc_press == BMP380_PRESS_SKIPPED) {
+		dev_err(data->dev, "reading pressure skipped\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static u32 bmp380_compensate_press(struct bmp280_data *data,
+				   u32 adc_press, s32 t_fine)
 {
 	s64 var1, var2, var3, var4, var5, var6, offset, sensitivity;
 	struct bmp380_calib *calib = &data->calib.bmp380;
 	u32 comp_press;
 
-	var1 = (s64)data->t_fine * (s64)data->t_fine;
+	var1 = (s64)t_fine * (s64)t_fine;
 	var2 = var1 >> 6;
-	var3 = (var2 * ((s64) data->t_fine)) >> 8;
+	var3 = (var2 * ((s64) t_fine)) >> 8;
 	var4 = ((s64)calib->P8 * var3) >> 5;
 	var5 = ((s64)calib->P7 * var1) << 4;
-	var6 = ((s64)calib->P6 * (s64)data->t_fine) << 22;
+	var6 = ((s64)calib->P6 * (s64)t_fine) << 22;
 	offset = ((s64)calib->P5 << 47) + var4 + var5 + var6;
 	var2 = ((s64)calib->P4 * var3) >> 5;
 	var4 = ((s64)calib->P3 * var1) << 2;
 	var5 = ((s64)calib->P2 - ((s64)1 << 14)) *
-	       ((s64)data->t_fine << 21);
+	       ((s64)t_fine << 21);
 	sensitivity = (((s64) calib->P1 - ((s64) 1 << 14)) << 46) +
 			var2 + var4 + var5;
 	var1 = (sensitivity >> 24) * (s64)adc_press;
-	var2 = (s64)calib->P10 * (s64)data->t_fine;
+	var2 = (s64)calib->P10 * (s64)t_fine;
 	var3 = var2 + ((s64)calib->P9 << 16);
 	var4 = (var3 * (s64)adc_press) >> 13;
 
@@ -1001,60 +1106,34 @@ static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
 	u32 adc_temp;
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB,
-			       data->buf, sizeof(data->buf));
-	if (ret < 0) {
-		dev_err(data->dev, "failed to read temperature\n");
+	ret = bmp380_read_temp_adc(data, &adc_temp);
+	if (ret < 0)
 		return ret;
-	}
 
-	adc_temp = get_unaligned_le24(data->buf);
-	if (adc_temp == BMP380_TEMP_SKIPPED) {
-		dev_err(data->dev, "reading temperature skipped\n");
-		return -EIO;
-	}
 	comp_temp = bmp380_compensate_temp(data, adc_temp);
 
-	/*
-	 * Val might be NULL if we're called by the read_press routine,
-	 * who only cares about the carry over t_fine value.
-	 */
-	if (val) {
-		/* IIO reports temperatures in milli Celsius */
-		*val = comp_temp * 10;
-		return IIO_VAL_INT;
-	}
-
-	return 0;
+	/* IIO units are in milli Celsius */
+	*val = comp_temp * 10;
+	return IIO_VAL_INT;
 }
 
 static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
 {
-	s32 comp_press;
-	u32 adc_press;
+	u32 adc_press, comp_press, t_fine;
 	int ret;
 
-	/* Read and compensate for temperature so we get a reading of t_fine */
-	ret = bmp380_read_temp(data, NULL, NULL);
+	ret = bmp380_get_t_fine(data, &t_fine);
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
-			       data->buf, sizeof(data->buf));
-	if (ret < 0) {
-		dev_err(data->dev, "failed to read pressure\n");
+	ret = bmp380_read_press_adc(data, &adc_press);
+	if (ret < 0)
 		return ret;
-	}
 
-	adc_press = get_unaligned_le24(data->buf);
-	if (adc_press == BMP380_PRESS_SKIPPED) {
-		dev_err(data->dev, "reading pressure skipped\n");
-		return -EIO;
-	}
-	comp_press = bmp380_compensate_press(data, adc_press);
+	comp_press = bmp380_compensate_press(data, adc_press, t_fine);
 
+	/* IIO units are in kPa */
 	*val = comp_press;
-	/* Compensated pressure is in cPa (centipascals) */
 	*val2 = 100000;
 
 	return IIO_VAL_FRACTIONAL;
@@ -1826,7 +1905,7 @@ static int bmp180_wait_for_eoc(struct bmp280_data *data, u8 ctrl_meas)
 	return 0;
 }
 
-static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
+static int bmp180_read_temp_adc(struct bmp280_data *data, s32 *adc_temp)
 {
 	int ret;
 
@@ -1843,7 +1922,7 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 		return ret;
 	}
 
-	*val = be16_to_cpu(data->be16);
+	*adc_temp = be16_to_cpu(data->be16);
 
 	return 0;
 }
@@ -1893,16 +1972,34 @@ static int bmp180_read_calib(struct bmp280_data *data)
  *
  * Taken from datasheet, Section 3.5, "Calculating pressure and temperature".
  */
-static s32 bmp180_compensate_temp(struct bmp280_data *data, s32 adc_temp)
+
+static s32 bmp180_calc_t_fine(struct bmp280_data *data, s32 adc_temp)
 {
 	struct bmp180_calib *calib = &data->calib.bmp180;
 	s32 x1, x2;
 
 	x1 = ((adc_temp - calib->AC6) * calib->AC5) >> 15;
 	x2 = (calib->MC << 11) / (x1 + calib->MD);
-	data->t_fine = x1 + x2;
+	return x1 + x2; /* t_fine = x1 + x2; */
+}
+
+static int bmp180_get_t_fine(struct bmp280_data *data, s32 *t_fine)
+{
+	s32 adc_temp;
+	int ret;
+
+	ret = bmp180_read_temp_adc(data, &adc_temp);
+	if (ret < 0)
+		return ret;
+
+	*t_fine = bmp180_calc_t_fine(data, adc_temp);
 
-	return (data->t_fine + 8) >> 4;
+	return 0;
+}
+
+static s32 bmp180_compensate_temp(struct bmp280_data *data, s32 adc_temp)
+{
+	return (bmp180_calc_t_fine(data, adc_temp) + 8) / 16;
 }
 
 static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
@@ -1910,25 +2007,18 @@ static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
 	s32 adc_temp, comp_temp;
 	int ret;
 
-	ret = bmp180_read_adc_temp(data, &adc_temp);
+	ret = bmp180_read_temp_adc(data, &adc_temp);
 	if (ret < 0)
 		return ret;
 
 	comp_temp = bmp180_compensate_temp(data, adc_temp);
 
-	/*
-	 * val might be NULL if we're called by the read_press routine,
-	 * who only cares about the carry over t_fine value.
-	 */
-	if (val) {
-		*val = comp_temp * 100;
-		return IIO_VAL_INT;
-	}
-
-	return 0;
+	/* IIO units are in milli Celsius */
+	*val = comp_temp * 100;
+	return IIO_VAL_INT;
 }
 
-static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
+static int bmp180_read_press_adc(struct bmp280_data *data, s32 *adc_press)
 {
 	u8 oss = data->oversampling_press;
 	int ret;
@@ -1947,7 +2037,7 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
 		return ret;
 	}
 
-	*val = get_unaligned_be24(data->buf) >> (8 - oss);
+	*adc_press = get_unaligned_be24(data->buf) >> (8 - oss);
 
 	return 0;
 }
@@ -1957,7 +2047,8 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
  *
  * Taken from datasheet, Section 3.5, "Calculating pressure and temperature".
  */
-static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
+static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press,
+				   s32 t_fine)
 {
 	struct bmp180_calib *calib = &data->calib.bmp180;
 	s32 oss = data->oversampling_press;
@@ -1965,7 +2056,7 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
 	s32 b3, b6;
 	u32 b4, b7;
 
-	b6 = data->t_fine - 4000;
+	b6 = t_fine - 4000;
 	x1 = (calib->B2 * (b6 * b6 >> 12)) >> 11;
 	x2 = calib->AC2 * b6 >> 11;
 	x3 = x1 + x2;
@@ -1989,21 +2080,21 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
 
 static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
 {
+	s32 adc_press, t_fine;
 	u32 comp_press;
-	s32 adc_press;
 	int ret;
 
-	/* Read and compensate temperature so we get a reading of t_fine. */
-	ret = bmp180_read_temp(data, NULL, NULL);
+	ret = bmp180_get_t_fine(data, &t_fine);
 	if (ret < 0)
 		return ret;
 
-	ret = bmp180_read_adc_press(data, &adc_press);
+	ret = bmp180_read_press_adc(data, &adc_press);
 	if (ret < 0)
 		return ret;
 
-	comp_press = bmp180_compensate_press(data, adc_press);
+	comp_press = bmp180_compensate_press(data, adc_press, t_fine);
 
+	/* IIO units are in kPa */
 	*val = comp_press;
 	*val2 = 1000;
 
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index fe4d3f127954..7c30e4d523be 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -397,12 +397,6 @@ struct bmp280_data {
 	 */
 	int sampling_freq;
 
-	/*
-	 * Carryover value from temperature conversion, used in pressure
-	 * calculation.
-	 */
-	s32 t_fine;
-
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
-- 
2.25.1



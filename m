Return-Path: <linux-kernel+bounces-162875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC88B6191
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1A0280CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC58613CF87;
	Mon, 29 Apr 2024 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqHASwMG"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC2213C697;
	Mon, 29 Apr 2024 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417270; cv=none; b=dUpuhwX756YwJpj0D+BO4XnkgNa2Dg90Wt2CKrlevVdB5SyliUSGa6czVA667/ftZY1WLmEFZmcnF9wIkslNkLpc+OXSNwLvM97kgIWxbE9GajylYpRwSXvC+cVKu6OqH6IRxef4vbDR0/oYCXMjSXzRFFEtEvI0LOkVu+HozEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417270; c=relaxed/simple;
	bh=jUnIFwmN479zaELfVxMHwdlJyanVM5evpT4EUceIxnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RgEuHbnvA+XgmLe4yANgs967ANGb9MsX8klEYyJVRU+huWhz2MkDYF+c+8IcwlMb92kkd80mrkgn/Kp0akwX1kHGpiQaRB6OzK0JbX7Vzps5XtF+QmfK9MLulVaKfqt0ZpTXdeilgUYT9+TVYaUgKqUTNRqvccBrohRvcDOB3d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqHASwMG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41bca450fa3so19136925e9.2;
        Mon, 29 Apr 2024 12:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417265; x=1715022065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFJJTF6UwFjuI8s1cb6ftzX78U2lf2vbFXrsFgT6sXQ=;
        b=nqHASwMGZnOCzmYPLrGijztAPI0Mt0MQUxdZ66k8hJSq9AUhYBqxt1eo4UBx1HZk3h
         QKdybxWsWylSl/5guuzth6V+yYst1e1M0PtX9hLK1+XeipetVeS10MR4Sk0X1bjjTuxs
         QphjF6uXczJ6jRrp7XyYYdI9LCkNPi79tuhXQbSrlhhmkJ6rby+2FV1TydKnJ1J9uqNg
         xnx5JkRImj8MN3GgxTuDFnPmNGp03OM0JnTGvdzBYUbk/XIC2s4ZKhZfTzuMgGOZEf58
         CoPxB48OjFQOpkhwn5C3iaZsd73+A7zdz2rdUL6C4uibTC9Pp9m35BtZ6eLs09uE+r0q
         ghrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417265; x=1715022065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFJJTF6UwFjuI8s1cb6ftzX78U2lf2vbFXrsFgT6sXQ=;
        b=uRXn4FuM/z9nhESQn8Y/vBQQ+vYPXPqqr4d/3DXpu6tZIurmUoAPgIMJWG0yy7+z0o
         4i0TrGaj4DjgNccVm9eT0tRzXTYE+/TXkRTr36kPBbm7eX4IQlyyOAtFf+V8Hit8Ilh5
         UcdWsNt7YGcvWTq9ghctZDaTO/pMLhnAX9zotbUAevQtSXItgFRnIARI/iho0B0otRec
         KtmqDQ2eyNl/h2aPdgFAGYdtXGwqnuwEC5Ix+tQiBhNGOXWHXZI0ZWPRvf4oizYjB5pR
         GAdf0KNw7R4dahZfBFWRGRDqHdNxwyfK7qnNkazhVYfA439PJGF0usImmv6z//CvkcIa
         EiWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPZ5SqF95SHZFi1UyhlxbX8g35w96CUgOtp79SjjFsP8cDgBZQEWy/Tya4WCakUREFUYQ2bHbzdl6lRsa8JGQ2LDrAG1jlrNf8GUtLeAOGJjmDfPXoqLBdoZbHUwXEgf7W3zGmBcUJ
X-Gm-Message-State: AOJu0Yx33RxrAKZg0tE/hXsGa8/KP2huIE8L2mEBzja0AKp2N2W594pc
	5nFh7PjyBcgo19uDxP7GOjGnNxHbl43uCeyUnDKQp5+BtQ2zO/uD
X-Google-Smtp-Source: AGHT+IER2nDA4wwne/lMiKEjxwd/2pJxjjgNia8wfNhq5uOK+Lre+WcI7Q0LuuF2u1ALiLOt6r1UFw==
X-Received: by 2002:a5d:4387:0:b0:34c:a488:e6d0 with SMTP id i7-20020a5d4387000000b0034ca488e6d0mr437289wrq.36.1714417265254;
        Mon, 29 Apr 2024 12:01:05 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:abbf:c98a:cf84:d14c])
        by smtp.gmail.com with ESMTPSA id x2-20020adfdd82000000b0034c78bba70bsm8469456wrl.72.2024.04.29.12.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:01:04 -0700 (PDT)
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
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v5 08/10] iio: pressure: bmp280: Generalize read_{temp,press,humid}() functions
Date: Mon, 29 Apr 2024 21:00:44 +0200
Message-Id: <20240429190046.24252-9-vassilisamir@gmail.com>
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

Add the coefficients for the IIO standard units and the IIO value
inside the chip_info structure.

Move the calculations for the IIO unit compatibility from inside the
read_{temp,press,humid}() functions and move them to the general
read_raw() function.

In this way, all the data for the calculation of the value are
located in the chip_info structure of the respective sensor.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 169 ++++++++++++++++-------------
 drivers/iio/pressure/bmp280.h      |  13 ++-
 2 files changed, 102 insertions(+), 80 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index f14277bb882d..668c4e8a2ebf 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -439,28 +439,23 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
 	return (u32)p;
 }
 
-static int bmp280_read_temp(struct bmp280_data *data,
-			    int *val, int *val2)
+static int bmp280_read_temp(struct bmp280_data *data, s32 *comp_temp)
 {
-	s32 adc_temp, comp_temp;
+	s32 adc_temp;
 	int ret;
 
 	ret = bmp280_read_temp_adc(data, &adc_temp);
 	if (ret < 0)
 		return ret;
 
-	comp_temp = bmp280_compensate_temp(data, adc_temp);
+	*comp_temp = bmp280_compensate_temp(data, adc_temp);
 
-	/* IIO units are in milli Celsius */
-	*val = comp_temp * 10;
-	return IIO_VAL_INT;
+	return 0;
 }
 
-static int bmp280_read_press(struct bmp280_data *data,
-			     int *val, int *val2)
+static int bmp280_read_press(struct bmp280_data *data, u32 *comp_press)
 {
 	s32 adc_press, t_fine;
-	u32 comp_press;
 	int ret;
 
 	ret = bmp280_get_t_fine(data, &t_fine);
@@ -471,19 +466,14 @@ static int bmp280_read_press(struct bmp280_data *data,
 	if (ret < 0)
 		return ret;
 
-	comp_press = bmp280_compensate_press(data, adc_press, t_fine);
+	*comp_press = bmp280_compensate_press(data, adc_press, t_fine);
 
-	/* IIO units are in kPa */
-	*val = comp_press;
-	*val2 = 256000;
-
-	return IIO_VAL_FRACTIONAL;
+	return 0;
 }
 
-static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
+static int bme280_read_humid(struct bmp280_data *data, u32 *comp_humidity)
 {
 	s32 adc_humidity, t_fine;
-	u32 comp_humidity;
 	int ret;
 
 	ret = bmp280_get_t_fine(data, &t_fine);
@@ -494,12 +484,9 @@ static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	if (ret < 0)
 		return ret;
 
-	comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
+	*comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
 
-	/* IIO units are in 1000 * % */
-	*val = comp_humidity * 1000 / 1024;
-
-	return IIO_VAL_INT;
+	return 0;
 }
 
 static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
@@ -507,6 +494,8 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 				int *val, int *val2, long mask)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
+	int chan_value;
+	int ret;
 
 	guard(mutex)(&data->lock);
 
@@ -514,11 +503,29 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-			return data->chip_info->read_humid(data, val, val2);
+			ret = data->chip_info->read_humid(data, &chan_value);
+			if (ret < 0)
+				return ret;
+
+			*val = data->chip_info->humid_coeffs[0] * chan_value;
+			*val2 = data->chip_info->humid_coeffs[1];
+			return data->chip_info->humid_coeffs_type;
 		case IIO_PRESSURE:
-			return data->chip_info->read_press(data, val, val2);
+			ret = data->chip_info->read_press(data, &chan_value);
+			if (ret < 0)
+				return ret;
+
+			*val = data->chip_info->press_coeffs[0] * chan_value;
+			*val2 = data->chip_info->press_coeffs[1];
+			return data->chip_info->press_coeffs_type;
 		case IIO_TEMP:
-			return data->chip_info->read_temp(data, val, val2);
+			ret = data->chip_info->read_temp(data, &chan_value);
+			if (ret < 0)
+				return ret;
+
+			*val = data->chip_info->temp_coeffs[0] * chan_value;
+			*val2 = data->chip_info->temp_coeffs[1];
+			return data->chip_info->temp_coeffs_type;
 		default:
 			return -EINVAL;
 		}
@@ -818,6 +825,8 @@ static int bmp280_chip_config(struct bmp280_data *data)
 
 static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
+static const int bmp280_temp_coeffs[] = { 10, 1 };
+static const int bmp280_press_coeffs[] = { 1, 256000 };
 
 const struct bmp280_chip_info bmp280_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -846,6 +855,11 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
 
+	.temp_coeffs = bmp280_temp_coeffs,
+	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
+	.press_coeffs = bmp280_press_coeffs,
+	.press_coeffs_type = IIO_VAL_FRACTIONAL,
+
 	.chip_config = bmp280_chip_config,
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
@@ -873,6 +887,7 @@ static int bme280_chip_config(struct bmp280_data *data)
 }
 
 static const u8 bme280_chip_ids[] = { BME280_CHIP_ID };
+static const int bme280_humid_coeffs[] = { 1000, 1024 };
 
 const struct bmp280_chip_info bme280_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -895,6 +910,13 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_humid_default = BME280_OSRS_HUMIDITY_16X - 1,
 
+	.temp_coeffs = bmp280_temp_coeffs,
+	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
+	.press_coeffs = bmp280_press_coeffs,
+	.press_coeffs_type = IIO_VAL_FRACTIONAL,
+	.humid_coeffs = bme280_humid_coeffs,
+	.humid_coeffs_type = IIO_VAL_FRACTIONAL,
+
 	.chip_config = bme280_chip_config,
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
@@ -1083,9 +1105,8 @@ static u32 bmp380_compensate_press(struct bmp280_data *data,
 	return comp_press;
 }
 
-static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
+static int bmp380_read_temp(struct bmp280_data *data, s32 *comp_temp)
 {
-	s32 comp_temp;
 	u32 adc_temp;
 	int ret;
 
@@ -1093,16 +1114,14 @@ static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
 	if (ret < 0)
 		return ret;
 
-	comp_temp = bmp380_compensate_temp(data, adc_temp);
+	*comp_temp = bmp380_compensate_temp(data, adc_temp);
 
-	/* IIO units are in milli Celsius */
-	*val = comp_temp * 10;
-	return IIO_VAL_INT;
+	return 0;
 }
 
-static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
+static int bmp380_read_press(struct bmp280_data *data, u32 *comp_press)
 {
-	u32 adc_press, comp_press, t_fine;
+	u32 adc_press, t_fine;
 	int ret;
 
 	ret = bmp380_get_t_fine(data, &t_fine);
@@ -1113,13 +1132,9 @@ static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
 	if (ret < 0)
 		return ret;
 
-	comp_press = bmp380_compensate_press(data, adc_press, t_fine);
+	*comp_press = bmp380_compensate_press(data, adc_press, t_fine);
 
-	/* IIO units are in kPa */
-	*val = comp_press;
-	*val2 = 100000;
-
-	return IIO_VAL_FRACTIONAL;
+	return 0;
 }
 
 static int bmp380_read_calib(struct bmp280_data *data)
@@ -1290,6 +1305,8 @@ static int bmp380_chip_config(struct bmp280_data *data)
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
 static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
 static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
+static const int bmp380_temp_coeffs[] = { 10, 1 };
+static const int bmp380_press_coeffs[] = { 1, 100000 };
 
 const struct bmp280_chip_info bmp380_chip_info = {
 	.id_reg = BMP380_REG_ID,
@@ -1317,6 +1334,11 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp380_iir_filter_coeffs_avail),
 	.iir_filter_coeff_default = 2,
 
+	.temp_coeffs = bmp380_temp_coeffs,
+	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
+	.press_coeffs = bmp380_press_coeffs,
+	.press_coeffs_type = IIO_VAL_FRACTIONAL,
+
 	.chip_config = bmp380_chip_config,
 	.read_temp = bmp380_read_temp,
 	.read_press = bmp380_read_press,
@@ -1437,9 +1459,8 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
  * for what is expected on IIO ABI.
  */
 
-static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
+static int bmp580_read_temp(struct bmp280_data *data, s32 *raw_temp)
 {
-	s32 raw_temp;
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB, data->buf,
@@ -1449,25 +1470,17 @@ static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
 		return ret;
 	}
 
-	raw_temp = get_unaligned_le24(data->buf);
-	if (raw_temp == BMP580_TEMP_SKIPPED) {
+	*raw_temp = get_unaligned_le24(data->buf);
+	if (*raw_temp == BMP580_TEMP_SKIPPED) {
 		dev_err(data->dev, "reading temperature skipped\n");
 		return -EIO;
 	}
 
-	/*
-	 * Temperature is returned in Celsius degrees in fractional
-	 * form down 2^16. We rescale by x1000 to return milli Celsius
-	 * to respect IIO ABI.
-	 */
-	*val = raw_temp * 1000;
-	*val2 = 16;
-	return IIO_VAL_FRACTIONAL_LOG2;
+	return 0;
 }
 
-static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
+static int bmp580_read_press(struct bmp280_data *data, u32 *raw_press)
 {
-	u32 raw_press;
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB, data->buf,
@@ -1477,18 +1490,13 @@ static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
 		return ret;
 	}
 
-	raw_press = get_unaligned_le24(data->buf);
-	if (raw_press == BMP580_PRESS_SKIPPED) {
+	*raw_press = get_unaligned_le24(data->buf);
+	if (*raw_press == BMP580_PRESS_SKIPPED) {
 		dev_err(data->dev, "reading pressure skipped\n");
 		return -EIO;
 	}
-	/*
-	 * Pressure is returned in Pascals in fractional form down 2^16.
-	 * We rescale /1000 to convert to kilopascal to respect IIO ABI.
-	 */
-	*val = raw_press;
-	*val2 = 64000; /* 2^6 * 1000 */
-	return IIO_VAL_FRACTIONAL;
+
+	return 0;
 }
 
 static const int bmp580_odr_table[][2] = {
@@ -1804,6 +1812,8 @@ static int bmp580_chip_config(struct bmp280_data *data)
 
 static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
 static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
+static const int bmp580_temp_coeffs[] = { 1000, 16 };
+static const int bmp580_press_coeffs[] = { 1, 64000};
 
 const struct bmp280_chip_info bmp580_chip_info = {
 	.id_reg = BMP580_REG_CHIP_ID,
@@ -1830,6 +1840,11 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp380_iir_filter_coeffs_avail),
 	.iir_filter_coeff_default = 2,
 
+	.temp_coeffs = bmp580_temp_coeffs,
+	.temp_coeffs_type = IIO_VAL_FRACTIONAL_LOG2,
+	.press_coeffs = bmp580_press_coeffs,
+	.press_coeffs_type = IIO_VAL_FRACTIONAL,
+
 	.chip_config = bmp580_chip_config,
 	.read_temp = bmp580_read_temp,
 	.read_press = bmp580_read_press,
@@ -1985,20 +2000,18 @@ static s32 bmp180_compensate_temp(struct bmp280_data *data, s32 adc_temp)
 	return (bmp180_calc_t_fine(data, adc_temp) + 8) / 16;
 }
 
-static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
+static int bmp180_read_temp(struct bmp280_data *data, s32 *comp_temp)
 {
-	s32 adc_temp, comp_temp;
+	s32 adc_temp;
 	int ret;
 
 	ret = bmp180_read_temp_adc(data, &adc_temp);
 	if (ret < 0)
 		return ret;
 
-	comp_temp = bmp180_compensate_temp(data, adc_temp);
+	*comp_temp = bmp180_compensate_temp(data, adc_temp);
 
-	/* IIO units are in milli Celsius */
-	*val = comp_temp * 100;
-	return IIO_VAL_INT;
+	return 0;
 }
 
 static int bmp180_read_press_adc(struct bmp280_data *data, s32 *adc_press)
@@ -2061,10 +2074,9 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press,
 	return p + ((x1 + x2 + 3791) >> 4);
 }
 
-static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
+static int bmp180_read_press(struct bmp280_data *data, u32 *comp_press)
 {
 	s32 adc_press, t_fine;
-	u32 comp_press;
 	int ret;
 
 	ret = bmp180_get_t_fine(data, &t_fine);
@@ -2075,13 +2087,9 @@ static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
 	if (ret < 0)
 		return ret;
 
-	comp_press = bmp180_compensate_press(data, adc_press, t_fine);
-
-	/* IIO units are in kPa */
-	*val = comp_press;
-	*val2 = 1000;
+	*comp_press = bmp180_compensate_press(data, adc_press, t_fine);
 
-	return IIO_VAL_FRACTIONAL;
+	return 0;
 }
 
 static int bmp180_chip_config(struct bmp280_data *data)
@@ -2092,6 +2100,8 @@ static int bmp180_chip_config(struct bmp280_data *data)
 static const int bmp180_oversampling_temp_avail[] = { 1 };
 static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
 static const u8 bmp180_chip_ids[] = { BMP180_CHIP_ID };
+static const int bmp180_temp_coeffs[] = { 100, 1 };
+static const int bmp180_press_coeffs[] = { 1, 1000 };
 
 const struct bmp280_chip_info bmp180_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -2112,6 +2122,11 @@ const struct bmp280_chip_info bmp180_chip_info = {
 		ARRAY_SIZE(bmp180_oversampling_press_avail),
 	.oversampling_press_default = BMP180_MEAS_PRESS_8X,
 
+	.temp_coeffs = bmp180_temp_coeffs,
+	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
+	.press_coeffs = bmp180_press_coeffs,
+	.press_coeffs_type = IIO_VAL_FRACTIONAL,
+
 	.chip_config = bmp180_chip_config,
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 7c30e4d523be..a3d2cd722760 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -446,10 +446,17 @@ struct bmp280_chip_info {
 	int num_sampling_freq_avail;
 	int sampling_freq_default;
 
+	const int *temp_coeffs;
+	const int temp_coeffs_type;
+	const int *press_coeffs;
+	const int press_coeffs_type;
+	const int *humid_coeffs;
+	const int humid_coeffs_type;
+
 	int (*chip_config)(struct bmp280_data *data);
-	int (*read_temp)(struct bmp280_data *data, int *val, int *val2);
-	int (*read_press)(struct bmp280_data *data, int *val, int *val2);
-	int (*read_humid)(struct bmp280_data *data, int *val, int *val2);
+	int (*read_temp)(struct bmp280_data *data, s32 *adc_temp);
+	int (*read_press)(struct bmp280_data *data, u32 *adc_press);
+	int (*read_humid)(struct bmp280_data *data, u32 *adc_humidity);
 	int (*read_calib)(struct bmp280_data *data);
 	int (*preinit)(struct bmp280_data *data);
 };
-- 
2.25.1



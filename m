Return-Path: <linux-kernel+bounces-102287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DBE87B034
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D66728C0E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3667131E4E;
	Wed, 13 Mar 2024 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avYasxa4"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B06012FF9D;
	Wed, 13 Mar 2024 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351625; cv=none; b=tXqSw+GaDGkopPE8auhdETyujp1VnpwzUMFJ4Zkg37rCDDaQDCZenpBU5glaGPSs6e5MbuFJ4ZkeFALy/4CwL1OGUng+hlh5vP7l+W+9zmrthtuyoMVVVzmGukCwNAKFAan6RRGudf43NYsuqish9DEOip5n3hTs8PlqbeZW25g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351625; c=relaxed/simple;
	bh=S9zF1Lvby+c7nTni5s4hL/8l9Ch+C18fqZYolOwShGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rTC6/ODZ5Ms3t2a5p9w/6EIf9JgszHDSDn40lkFl36d280I846kFy0mMc/Ga7G0tgWDtn9/huS3S30hHcdwcxuPpecD+dpIwanvwn3xNkAhNA03h67GiQn8sKaIQaTxb0Z9SLwMGV/TS2KqFlQIPSdZtNfk5hmOtJVOWVo9R7/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avYasxa4; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a446b5a08f0so25025366b.1;
        Wed, 13 Mar 2024 10:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710351621; x=1710956421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myKz1FVxkkY2My67LEfKvneqOReMkZwpEuPPL7ER9GA=;
        b=avYasxa4L4gFpsLxajxqWhM+GrtpoA72+qmArUpdjEHsbXifU3qvLlYo1TS0Gkg7Fz
         JuxWzwoFligD1aWt6bE6qo8fgQyLC9yUOdgO+7MoyQePvw8aQl7BJr1SHc5Z0jQ3Vo3a
         DT/oT8rkbcFcQIHzlkSqO+X54xTBVpRZEvFsZK1OTCE6UmNx3Ty6UDoCAlUJzeLcKgZf
         15eI+e2+zt1nkifgAsw7txU7KpVyy0T8C3L49KfQIx1Nrx5n+yL6wpVkpWZuFL0BtsQY
         hbkm3HxVdGxtyHMQja2ojdD0d0NxzBLdxd/Ae+gYEbe/gUqjyuTeX8wkFMwJ9rs0h3df
         Pr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351621; x=1710956421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myKz1FVxkkY2My67LEfKvneqOReMkZwpEuPPL7ER9GA=;
        b=wsZ7mX+Ll2jJQqKUy+ybiEnGl9FkfPng3tj/FugNPKsvTP6jyS2WEnb0TNdM7ZMTfw
         NfOpz0OR7YA+6Mp2INjgbewmALaA+OqjonVYVe5WnsT7rzRsnpQou/RLz4rHRjn4kLMV
         L0DDUS+gijLNSjS2cYisqBWIqZ5tklaw/bl8toStiLvdNBVjzAQp04hqW4w1jFqYN1qt
         ir5h0yLN/JMZQ02DLyLEvvmglZFMFcKgGAUCp1jEfmGbfD5K6qoBWrBVsjWCWv9pXcdZ
         x8XXprFR/V+7qOCdTKsRYgG9Lvt0LSKrOyNVs3Jlv1NitQCB0nX7+TaF65iknzmEKBN2
         Y3FA==
X-Forwarded-Encrypted: i=1; AJvYcCUy9UA33MRobzhP7x5jd1uP75B5AhM5PODvQy/aKeHNNI+buraY23Pa7gXJVsiuTTdtVKOw0WEU8aAPkzotx07phwhwq0C3Esf7MT+ou/gAre2pRjSBzYJTUpjc2098R85B/YvcTMS1
X-Gm-Message-State: AOJu0YzKbxlhov17ShyPdAmleTqocxrlwcYK/OZUhSN5aT5lPtizttnt
	YnOw3z+Vw1Qu60RQ7S0u2bLoMpMm8SCulp3iVpDG0Z3BrAlYwLGP
X-Google-Smtp-Source: AGHT+IHR555BbTASeXdN+ypMqGbZN430GdtQ3U+LRAa2fZGP1GVOOw0Pyy/X6aHBgkwGoPkpt1m1vg==
X-Received: by 2002:a17:906:4f01:b0:a46:605d:697c with SMTP id t1-20020a1709064f0100b00a46605d697cmr1546466eju.4.1710351621511;
        Wed, 13 Mar 2024 10:40:21 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:fa35:157e:1a40:3463])
        by smtp.gmail.com with ESMTPSA id m17-20020a1709061ed100b00a449076d0dbsm5028215ejj.53.2024.03.13.10.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:40:21 -0700 (PDT)
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
Subject: [PATCH v2 4/6] iio: pressure: Simplify and make more clear temperature readings
Date: Wed, 13 Mar 2024 18:40:05 +0100
Message-Id: <20240313174007.1934983-5-vassilisamir@gmail.com>
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

The read_press/read_humid functions need the updated t_fine value
in order to calculate the current pressure/humidity. Temperature
reads should be removed from the read_press/read_humid functions
and should be placed in the oneshot captures before the pressure
and humidity reads. This makes the code more intuitive.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 38 ++++++++++++++----------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6d7734f867bc..377e90d9e5a2 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -404,11 +404,6 @@ static u32 bmp280_read_press(struct bmp280_data *data)
 	s32 adc_press;
 	int ret;
 
-	/* Read and compensate temperature so we get a reading of t_fine. */
-	ret = bmp280_read_temp(data);
-	if (ret < 0)
-		return ret;
-
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
 			       data->buf, sizeof(data->buf));
 	if (ret < 0) {
@@ -433,11 +428,6 @@ static u32 bmp280_read_humid(struct bmp280_data *data)
 	s32 adc_humidity;
 	int ret;
 
-	/* Read and compensate temperature so we get a reading of t_fine. */
-	ret = bmp280_read_temp(data);
-	if (ret < 0)
-		return ret;
-
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
 			       &data->be16, sizeof(data->be16));
 	if (ret < 0) {
@@ -470,12 +460,21 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
+			/* Read temperature to update the t_fine value */
+			data->chip_info->read_temp(data);
 			ret = data->chip_info->read_humid(data);
 			*val = data->chip_info->humid_coeffs[0] * ret;
 			*val2 = data->chip_info->humid_coeffs[1];
 			ret = IIO_VAL_FRACTIONAL;
 			break;
 		case IIO_PRESSURE:
+			/*
+			 * Read temperature to update the t_fine value.
+			 * BMP5xx devices do this in hardware, so skip it.
+			 */
+			if (strcmp(indio_dev->name, "bmp580"))
+				data->chip_info->read_temp(data);
+
 			ret = data->chip_info->read_press(data);
 			*val = data->chip_info->press_coeffs[0] * ret;
 			*val2 = data->chip_info->press_coeffs[1];
@@ -500,10 +499,19 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
+			/* Read temperature to update the t_fine value */
+			data->chip_info->read_temp(data);
 			*val = data->chip_info->read_humid(data);
 			ret = IIO_VAL_INT;
 			break;
 		case IIO_PRESSURE:
+			/*
+			 * Read temperature to update the t_fine value.
+			 * BMP5xx devices do this in hardware, so skip it.
+			 */
+			if (strcmp(indio_dev->name, "bmp580"))
+				data->chip_info->read_temp(data);
+
 			*val = data->chip_info->read_press(data);
 			ret = IIO_VAL_INT;
 			break;
@@ -1092,11 +1100,6 @@ static u32 bmp380_read_press(struct bmp280_data *data)
 	s32 adc_press;
 	int ret;
 
-	/* Read and compensate for temperature so we get a reading of t_fine */
-	ret = bmp380_read_temp(data);
-	if (ret)
-		return ret;
-
 	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
 			       data->buf, sizeof(data->buf));
 	if (ret) {
@@ -2009,11 +2012,6 @@ static u32 bmp180_read_press(struct bmp280_data *data)
 	s32 adc_press;
 	int ret;
 
-	/* Read and compensate temperature so we get a reading of t_fine. */
-	ret = bmp180_read_temp(data);
-	if (ret)
-		return ret;
-
 	ret = bmp180_read_adc_press(data, &adc_press);
 	if (ret)
 		return ret;
-- 
2.25.1



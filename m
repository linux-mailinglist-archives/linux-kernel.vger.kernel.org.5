Return-Path: <linux-kernel+bounces-102289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3664187B037
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B161C26361
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C6F134412;
	Wed, 13 Mar 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3fMC6X7"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1A8132C15;
	Wed, 13 Mar 2024 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351628; cv=none; b=FYFBBb0l2dVpF2RJO7sO3GVbXJ9bAEjrJAeY8NB2mYNJZTKBEsYEi91gyZmMk7NdY/m4Ozalbdyt3dWabiBZbBAStLhj2SR2UhLxXJFF1xLFRprd4bwV/EwnaGnkUV5+O9jleCKF8m72NU8m+9e9Hdqz4LuKrp9i/DOM7y5svGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351628; c=relaxed/simple;
	bh=tc9DKMBR8KwBT2icGVg5+ZgjQyRhDAM94iKrIGcjx/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rY7luiytaiM2xFjvdvJLr74dfQFeDhNNOkHVCkRydalDvQXQobyJQZ+9izS+NoqocxNjNT6zZK6D8DXNsiZr4rkyMXJjQAuSMdDI7zc0KTaHCuiuxAGOlvx3iuD5a9xSmnRUVtzkzmDoCLX70EB1ypP/yBJfHDHEwn7SQVHY52k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3fMC6X7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56845954fffso87620a12.3;
        Wed, 13 Mar 2024 10:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710351625; x=1710956425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDUkRWMU6Em/8H0zDUO+LaCCaghhRbcYZfIR5KeSXa8=;
        b=d3fMC6X7XPrf3kV+3bWnuVFzDz7bYwRKX25gSkUsTipzxzkogKEPRC+zyogmGq0VNb
         o51Q61PeNNG1a6z4CZKIQILH+9q9dSURjTqL8rlkwI5/A2gWD5cP5NTexznq0GPx5n31
         CIRiRUBUsPPYJAP79gF8Qqw6oAGqZbLpff5zSU9c+/ffLB8K+eKZ7rCeqfBUx+AgfSGI
         3rtw/jXRoxcQICv6UyGVxc4rai2tv5JVn33xiNtHUxhR+apmy8PS7UH+3cLTv4lEBxPe
         WkyYR7WWeqVyjE4fLmOS05IZo3EvoYNwyyz18raq+RAioBedn2CPenL7K92Re5fnjmI9
         0qGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351625; x=1710956425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDUkRWMU6Em/8H0zDUO+LaCCaghhRbcYZfIR5KeSXa8=;
        b=FZLQbUYiu9bs7lofLf79kgMf2qJPspmoF0hKH8dN4KgAkSlHprnkKRZTzyApNWq+Xs
         W2g0dRAxfOBfiTjS/515EUj/DAc0rn4XRfd5BHj3J9SDGSCNiDodxd28jIy4M/MkmUGB
         UJHLrHXuzSJaIdJ2glj6FTB1Sox//rxcP2YKQ8nURjd6sZ+ANaovK52PautIf+P0EWY3
         wh82ecWHn9OdBA6A6U+G3nxEVMlvMjFvHhxacmkl7ysBoRQGR5SN5sKVhpSzZfqwJK5w
         yeL53KeIBbU3+gIRhjVKdYQUADJjNrv6g0cZVApyT9QK7YtxnCPyt5Rk2jq/u2q2HqeJ
         WxUA==
X-Forwarded-Encrypted: i=1; AJvYcCW7J14xEeQXfucS6TSuUCDBhVBJ94wdciBbFHa0x86XZs6677KtP/DAW9a3CF7SVL+4bZLvkA4CQEDCUmT9O8Xf6yduaXnAzSvSz6mKErqbfKhK4BXWFgh3br3Z3d/EIIprc911sMjV
X-Gm-Message-State: AOJu0Yw5PGyr99k8dgMSQV1NDUj7apJ4KHiHR+KJLwpwRX71WzoOEKGo
	dDqeUweUzxN5lRgm7cf75qpBcJm5q5FsJ9IFZAoaFj9OhYGygveDv27ubJQ44dmFLYKg
X-Google-Smtp-Source: AGHT+IFnomHxxYnPOy5YMpL0B+A3GiwKNdZ/A9KAwzNIJEuZEqLNCTOE0dLpx9FOf/kA0WSh938wIQ==
X-Received: by 2002:a17:907:d389:b0:a45:92c4:7892 with SMTP id vh9-20020a170907d38900b00a4592c47892mr10865628ejc.56.1710351624808;
        Wed, 13 Mar 2024 10:40:24 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:fa35:157e:1a40:3463])
        by smtp.gmail.com with ESMTPSA id m17-20020a1709061ed100b00a449076d0dbsm5028215ejj.53.2024.03.13.10.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:40:24 -0700 (PDT)
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
Subject: [PATCH v2 6/6] iio: pressure: Add triggered buffer support for BMP280 driver
Date: Wed, 13 Mar 2024 18:40:07 +0100
Message-Id: <20240313174007.1934983-7-vassilisamir@gmail.com>
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

Add a buffer struct that will hold the values of the measurements
and will be pushed to userspace and a buffer_handler function to
read the data and push them.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/Kconfig       |  2 +
 drivers/iio/pressure/bmp280-core.c | 61 ++++++++++++++++++++++++++++++
 drivers/iio/pressure/bmp280.h      |  7 ++++
 3 files changed, 70 insertions(+)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 79adfd059c3a..5145b94b4679 100644
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
index f2cf9bef522c..7c889cda396a 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -40,7 +40,10 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #include <asm/unaligned.h>
 
@@ -2188,6 +2191,57 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 	return 0;
 }
 
+static irqreturn_t bmp280_buffer_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmp280_data *data = iio_priv(indio_dev);
+	int ret, temp;
+
+	/*
+	 * data->buf[3] is used to transfer data from the device. Whenever a
+	 * pressure or a humidity reading takes place, the data written in the
+	 * data->buf[3] overwrites the iio_buf.temperature value. Keep the
+	 * temperature value and apply it after the readings.
+	 */
+	mutex_lock(&data->lock);
+
+	if (test_bit(BMP280_TEMP, indio_dev->active_scan_mask)) {
+		ret = data->chip_info->read_temp(data);
+		if (ret < 0)
+			goto done;
+
+		temp = ret;
+	}
+
+	if (test_bit(BMP280_PRESS, indio_dev->active_scan_mask)) {
+		ret = data->chip_info->read_press(data);
+		if (ret < 0)
+			goto done;
+
+		data->iio_buf.pressure = ret;
+		data->iio_buf.temperature = temp;
+	}
+
+	if (test_bit(BME280_HUMID, indio_dev->active_scan_mask)) {
+		ret = data->chip_info->read_humid(data);
+		if (ret < 0)
+			goto done;
+
+		data->iio_buf.humidity = ret;
+		data->iio_buf.temperature = temp;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->iio_buf,
+					   iio_get_time_ns(indio_dev));
+
+done:
+	mutex_unlock(&data->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static void bmp280_pm_disable(void *data)
 {
 	struct device *dev = data;
@@ -2329,6 +2383,13 @@ int bmp280_common_probe(struct device *dev,
 			return ret;
 	}
 
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      &bmp280_buffer_handler, NULL);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "iio triggered buffer setup failed\n");
+
 	/* Enable runtime PM */
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index c8cb7c417dab..b5369dd496ba 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -407,6 +407,13 @@ struct bmp280_data {
 	union {
 		/* Sensor data buffer */
 		u8 buf[3];
+		/* Data buffer to push to userspace */
+		struct {
+			s32 temperature;
+			u32 pressure;
+			u32 humidity;
+			s64 timestamp __aligned(8);
+		} iio_buf;
 		/* Calibration data buffers */
 		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
 		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
-- 
2.25.1



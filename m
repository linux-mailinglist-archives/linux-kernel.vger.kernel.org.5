Return-Path: <linux-kernel+bounces-134589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1098789B34C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5E4282B5C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2744F3D0D1;
	Sun,  7 Apr 2024 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dri7OX66"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5716E3BBF1;
	Sun,  7 Apr 2024 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712510975; cv=none; b=mxBUfXs6ZZRjii5lVLj8MkMPHUA5PzdEIiBMeum8btWsC7cLW5HfULPoQUH2kzC6NcQY7BpezB/cw/YSW16OKOLaRs9DQH72x7izUhec3O02JcWDy+xI7DRj1KpBlD+TjDkoUIErnFIF6HX8piHDvmr6/IdCSrqBsMAQ6nqQK+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712510975; c=relaxed/simple;
	bh=9/kMHjGEoueWiVCVOFQgFniDThf6tunfbEB/DUOaqGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nvzjQg+Foy8wKm32K84KbXnCgMuQ4YUSWYDFx+RlNRAISxE1DltmcyzMxi7RPx9YIRRhgdJMr75/rjaih7LnXxTsr1HBg+lGlw+MlJM6eMbMYqf4yjXVKQhHVrVAV/b8kAK7afMIW2v95tyrcCEHURPdkVGW8/UpbJsvH/Mz6+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dri7OX66; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e346224bdso1831766a12.1;
        Sun, 07 Apr 2024 10:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712510972; x=1713115772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SIAHfipSVJxFUztE/GhclzixiHy/uZOBHqFJE0UN1Y=;
        b=Dri7OX66W/Ys8haZCP5chpH0Vdg/05ZGm+JUU93SOZ+VaZYxJfyDInM7llIlkU9YbC
         T8mHeC/aoW9Qe2RfRs+veiO+765XivcsIpqg5ShrFZp54l6Rd8nZbchgOecNo/2JZFlq
         P2ezZd7q8R7wQThie6kbj85R/c2N1bgqwPLJQYTsIwB0jyr3H8R4pZb6vohKmhKyNyXy
         5c7kQT26KgeyPJ4g4cwh2Cq9e98zvZl02+7b6/RZkddedQblYQ4u9qpj/OhyLHfNRa2Q
         zffrZAnY97I0WMiBfJvhbu87j5Ee7dLZ7WCQHBP1X0TPDNi+q+VIwzca4kbfx1ZI5JcY
         Rlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712510972; x=1713115772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SIAHfipSVJxFUztE/GhclzixiHy/uZOBHqFJE0UN1Y=;
        b=SsHKC3dqtI7vunIXErHTNYCG0TNYiOzLfupPh2fjBv3P+RAVLYW5NrIYNCyic78X5y
         U3LlbAf7Lsene9ZYQctavnnbUTTpYJtJjNqwyxPg/xaVSTHHfLwFHPCzql4sWceKzwMw
         2kHmQOP3UqJPQG71jLTXuxcBT/zMk3tPFqInf4UVku/+HYEtC35WJ6B4D4SSxURP1M0Z
         btVaU+xgtB24k6sTwlE/LWGD38HWaeWrLJgLc4Jwan8sMvVLZQTI7rtxuMJJUBMqVbQx
         wVb8fq4q0Nvi6N0N3nqVsdPa56UARNY03ZAWBIAPgmxjkCW1R6xWHQSbSHD6oX5roge1
         h+Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUYZ/HF76iWlY1i1aUJiss28K1imRvNJIPz6+mv8ZEQjVbL4mi0PxMEoKcWKU8Gdk8wqjzdeOPe6iZeoe426/bcEGvYwaQBPZZiP+stddXk/tzm4zhII/pXdOUATfue5uTmN+12yO29
X-Gm-Message-State: AOJu0YzVR5t26pzjje9fIoq1nCVm+FUH2VeCuo5n7p56b23CG33Qj93q
	FzV3J8GZBu7SXZYQiCRQcSNHDdnSoxiujKoBvdrpP/dnL+oN6RB0
X-Google-Smtp-Source: AGHT+IGVy7VeuKXu/3mSpMaWeDDAuzUYhajraIBS4EIoAsojtF8EgowmSBFUFZGRbG2MfOetNAzozA==
X-Received: by 2002:a50:bb48:0:b0:56c:4f5:7227 with SMTP id y66-20020a50bb48000000b0056c04f57227mr3879293ede.41.1712510971710;
        Sun, 07 Apr 2024 10:29:31 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:c509:e54e:6ef:eb0c])
        by smtp.gmail.com with ESMTPSA id j22-20020aa7c416000000b0056e4b9ec1aasm1307134edq.52.2024.04.07.10.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 10:29:31 -0700 (PDT)
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
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 3/6] iio: pressure: bmp280: Introduce new cleanup routines
Date: Sun,  7 Apr 2024 19:29:17 +0200
Message-Id: <20240407172920.264282-4-vassilisamir@gmail.com>
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

Introduce new linux/cleanup.h with the guard(mutex) functionality
in the {read,write}_raw() functions.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 129 +++++++++++++----------------
 1 file changed, 58 insertions(+), 71 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 50bdf79011bc..51bcdf8cede6 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -27,6 +27,7 @@
 
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -499,77 +500,69 @@ static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	return IIO_VAL_INT;
 }
 
-static int bmp_read_raw(struct iio_dev *indio_dev,
-			struct iio_chan_spec const *chan,
-			int *val, int *val2, long mask)
+static int bmp_read_raw_impl(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
-	int ret;
 
-	pm_runtime_get_sync(data->dev);
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-			ret = data->chip_info->read_humid(data, val, val2);
-			break;
+			return data->chip_info->read_humid(data, val, val2);
 		case IIO_PRESSURE:
-			ret = data->chip_info->read_press(data, val, val2);
-			break;
+			return data->chip_info->read_press(data, val, val2);
 		case IIO_TEMP:
-			ret = data->chip_info->read_temp(data, val, val2);
-			break;
+			return data->chip_info->read_temp(data, val, val2);
 		default:
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		break;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
 			*val = 1 << data->oversampling_humid;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		case IIO_PRESSURE:
 			*val = 1 << data->oversampling_press;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		case IIO_TEMP:
 			*val = 1 << data->oversampling_temp;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		default:
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (!data->chip_info->sampling_freq_avail) {
-			ret = -EINVAL;
-			break;
-		}
+		if (!data->chip_info->sampling_freq_avail)
+			return -EINVAL;
 
 		*val = data->chip_info->sampling_freq_avail[data->sampling_freq][0];
 		*val2 = data->chip_info->sampling_freq_avail[data->sampling_freq][1];
-		ret = IIO_VAL_INT_PLUS_MICRO;
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		if (!data->chip_info->iir_filter_coeffs_avail) {
-			ret = -EINVAL;
-			break;
-		}
+		if (!data->chip_info->iir_filter_coeffs_avail)
+			return -EINVAL;
 
 		*val = (1 << data->iir_filter_coeff) - 1;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
 
-	mutex_unlock(&data->lock);
+	return 0;
+}
+
+static int bmp_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int *val, int *val2, long mask)
+{
+	struct bmp280_data *data = iio_priv(indio_dev);
+	int ret;
+
+	pm_runtime_get_sync(data->dev);
+	ret = bmp_read_raw_impl(indio_dev, chan, val, val2, mask);
 	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
 
@@ -697,12 +690,13 @@ static int bmp_write_iir_filter_coeffs(struct bmp280_data *data, int val)
 	return -EINVAL;
 }
 
-static int bmp_write_raw(struct iio_dev *indio_dev,
-			 struct iio_chan_spec const *chan,
-			 int val, int val2, long mask)
+static int bmp_write_raw_impl(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
-	int ret = 0;
+
+	guard(mutex)(&data->lock);
 
 	/*
 	 * Helper functions to update sensor running configuration.
@@ -712,46 +706,39 @@ static int bmp_write_raw(struct iio_dev *indio_dev,
 	 */
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		pm_runtime_get_sync(data->dev);
-		mutex_lock(&data->lock);
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-			ret = bmp_write_oversampling_ratio_humid(data, val);
-			break;
+			return bmp_write_oversampling_ratio_humid(data, val);
 		case IIO_PRESSURE:
-			ret = bmp_write_oversampling_ratio_press(data, val);
-			break;
+			return bmp_write_oversampling_ratio_press(data, val);
 		case IIO_TEMP:
-			ret = bmp_write_oversampling_ratio_temp(data, val);
-			break;
+			return bmp_write_oversampling_ratio_temp(data, val);
 		default:
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		mutex_unlock(&data->lock);
-		pm_runtime_mark_last_busy(data->dev);
-		pm_runtime_put_autosuspend(data->dev);
-		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		pm_runtime_get_sync(data->dev);
-		mutex_lock(&data->lock);
-		ret = bmp_write_sampling_frequency(data, val, val2);
-		mutex_unlock(&data->lock);
-		pm_runtime_mark_last_busy(data->dev);
-		pm_runtime_put_autosuspend(data->dev);
-		break;
+		return bmp_write_sampling_frequency(data, val, val2);
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		pm_runtime_get_sync(data->dev);
-		mutex_lock(&data->lock);
-		ret = bmp_write_iir_filter_coeffs(data, val);
-		mutex_unlock(&data->lock);
-		pm_runtime_mark_last_busy(data->dev);
-		pm_runtime_put_autosuspend(data->dev);
-		break;
+		return bmp_write_iir_filter_coeffs(data, val);
 	default:
 		return -EINVAL;
 	}
 
+	return 0;
+}
+
+static int bmp_write_raw(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *chan,
+			 int val, int val2, long mask)
+{
+	struct bmp280_data *data = iio_priv(indio_dev);
+	int ret;
+
+	pm_runtime_get_sync(data->dev);
+	ret = bmp_write_raw_impl(indio_dev, chan, val, val2, mask);
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
+
 	return ret;
 }
 
-- 
2.25.1



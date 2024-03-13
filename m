Return-Path: <linux-kernel+bounces-102285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E6487B02E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541351C26A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70230130AF5;
	Wed, 13 Mar 2024 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqtvRuDt"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FF512FF69;
	Wed, 13 Mar 2024 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351623; cv=none; b=iisuRhKoV7BZFHsFyKcBIfSjOekf681ILbqqr2rfDomBwhS8ObKODqvCM58K//fP0h33SZqF2ITOKBNPJR4JgNX4LOvW6Je4DTHoxsUjgbO31gGZbPiPIJI9vwFjS3gBVzQM0rs8rLoO96CrLxQL7qupw+VEfTlqHZl5GH4MO+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351623; c=relaxed/simple;
	bh=zN8xCu1gH5zHdheG29PSsKuC/jtm9T0XpojF7b5SZ3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GTgOrPqBo58vnj0noOGVukHgjwWwfocguyv2uxn0X9PilOjh8Z1MbwyY6XcvgtwKcz2678+B7fhC+X2B2bmERDQsx9QmzOVjV1VTdblYLYoA0S7nZJvvcFPCdEFJ6z31z46XGLlsdKb+YI3/aViHhbLM4CjUTnZrOkOKdHa4GPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqtvRuDt; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56838e00367so136774a12.0;
        Wed, 13 Mar 2024 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710351620; x=1710956420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdi90LxAyqPq+F4TfJtl0rFJuWs6klQUvdsruwMjWcE=;
        b=XqtvRuDtlrkjQcV6UBEjgtKYVQ5hwEePbNuzNRt6Za9GneqA+ZywPJCkfwPmnbH0Rn
         MDFL++6ruDdR0i8gc0iPfTAuP7Wivp+aQyjq7teBhptSvyr/dFWoRxWl1FetkswWpAB/
         978FlDoWoG/kWOpvABYSt822vnMW68uX0aM+tQRh1c/dZtxMrmiXDDzn2T5EPzKt7Zv0
         Jot1VtcmZvlUi+XyYYSLZssEBphLqXFmM4z79hKZVXciN0zPhUPtamIv4h6mh6Uarn+W
         6z5anA8EM78aJq/p4SL2hps3bBWxmahZZue08NRyazFw/1WO4N98cBKPxU1/Rc7/z3V/
         zq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351620; x=1710956420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdi90LxAyqPq+F4TfJtl0rFJuWs6klQUvdsruwMjWcE=;
        b=YLLVwqnJW2Q0z9PZ+CP3sVtQwtOk/P9es79bfDgORW21xxzGh9mU9+q1uV9kBnv9ah
         FDNKCU+aFuYwxULOkVqe9AJ29EFJeSMsQsTVMJJfWkcPzf8LNIIHiJ8oPh94S9JtTLFO
         b+HgUetGFrwlo4ewdzN1OqfTPcFN8Vr/HToVqprx30BWkjtDUiuJstFOxbI6+2Ms3qdR
         r56ob33XceSsbRxDOUDFlTD0ytisLVyoskT4yIRLHkAo9yAvrlzMEtYvyspTRRnu+8gE
         rR6V4kUMKUudg/QkOeOoR+8ke10WBmlm5UFbab9auph8/WskC81g74HrZKR3wOGiqKUK
         RqHg==
X-Forwarded-Encrypted: i=1; AJvYcCUtEPqOSMXZPGNJAtos7H+5vVNuzk9XjxUsfBnRkibM8HaoP/pw/oBzD3XC0O2r3FSHNw2d2ADxmhOzN1+mZUQPjiS9iCSADiKHQUWB8y8QG9fl1gI5FI1GEDWXzXw2DE6rHh2PqMKL
X-Gm-Message-State: AOJu0YyamvN+3mRZzfTBX1KocfzLd2lzAcTUrSbQQchweoLqUwc3E71j
	/KwroxS1d+Ga4nxqHbXtrmBWksZ7b9wqb7FVaaIzOB/btPycOLqC
X-Google-Smtp-Source: AGHT+IEX3CdOr5y/3yGr0P7V8smY4MN88DXQT+HrFDPy7YX/asuOzflumw2wS7VnWCyGByiL9F6aFw==
X-Received: by 2002:a17:907:d50c:b0:a46:3ce4:5aef with SMTP id wb12-20020a170907d50c00b00a463ce45aefmr5219842ejc.57.1710351619935;
        Wed, 13 Mar 2024 10:40:19 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:fa35:157e:1a40:3463])
        by smtp.gmail.com with ESMTPSA id m17-20020a1709061ed100b00a449076d0dbsm5028215ejj.53.2024.03.13.10.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:40:19 -0700 (PDT)
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
Subject: [PATCH v3 3/6] iio: pressure: add SCALE and RAW values for channels
Date: Wed, 13 Mar 2024 18:40:04 +0100
Message-Id: <20240313174007.1934983-4-vassilisamir@gmail.com>
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

Add extra IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW in order to be
able to calculate the processed value with standard userspace IIO
tools. Can be used for triggered buffers as well.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 58 ++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index dfd845acfa22..6d7734f867bc 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -138,16 +138,22 @@ static const struct iio_chan_spec bmp280_channels[] = {
 	{
 		.type = IIO_PRESSURE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 	},
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 	},
 	{
 		.type = IIO_HUMIDITYRELATIVE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 	},
 };
@@ -156,6 +162,8 @@ static const struct iio_chan_spec bmp380_channels[] = {
 	{
 		.type = IIO_PRESSURE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
@@ -163,6 +171,8 @@ static const struct iio_chan_spec bmp380_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
@@ -170,6 +180,8 @@ static const struct iio_chan_spec bmp380_channels[] = {
 	{
 		.type = IIO_HUMIDITYRELATIVE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
@@ -485,6 +497,52 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 			break;
 		}
 		break;
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_HUMIDITYRELATIVE:
+			*val = data->chip_info->read_humid(data);
+			ret = IIO_VAL_INT;
+			break;
+		case IIO_PRESSURE:
+			*val = data->chip_info->read_press(data);
+			ret = IIO_VAL_INT;
+			break;
+		case IIO_TEMP:
+			*val = data->chip_info->read_temp(data);
+			ret = IIO_VAL_INT;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_HUMIDITYRELATIVE:
+			*val = data->chip_info->humid_coeffs[0];
+			*val2 = data->chip_info->humid_coeffs[1];
+			ret = IIO_VAL_FRACTIONAL;
+			break;
+		case IIO_PRESSURE:
+			*val = data->chip_info->press_coeffs[0];
+			*val2 = data->chip_info->press_coeffs[1];
+			ret = IIO_VAL_FRACTIONAL;
+			break;
+		case IIO_TEMP:
+			*val = data->chip_info->temp_coeffs[0];
+			*val2 = data->chip_info->temp_coeffs[1];
+
+			if (!strcmp(indio_dev->name, "bmp580"))
+				ret = IIO_VAL_FRACTIONAL_LOG2;
+			else
+				ret = IIO_VAL_FRACTIONAL;
+
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		break;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-- 
2.25.1



Return-Path: <linux-kernel+bounces-112342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 341008878A2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D5C5B24A23
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7460E4DA04;
	Sat, 23 Mar 2024 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA35LcD0"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D631E405F9;
	Sat, 23 Mar 2024 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711196449; cv=none; b=MD4KwTfIifdExqVEaeWS12Ml5Nr/uLCu6KsIPspjUkM3uMKD/cTERdCLGgxCoWUpbEr4rBWfgV7EgRwkPftKVaCRmxgCfaccFP9eYbrQZ6Nxp0no721uk7zPOcocYBCIiNzz7oDsVc6RBsSubOpdxPnvJcOkfJXFcOVxEjgHOk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711196449; c=relaxed/simple;
	bh=GXeXJ7p9rCjKuzMyD6PBhjw4946RJkUrBSuDdkeNakE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=subFMcDNaNmhUD+lVQlATslAYNHMbuhHqmyaNS+GO4pA+Mi8FJ9a/8Rfgomdqs+mLedNwtsMM/TKsXSdxVtrn2J+r1mny/iGHsXi5wTA7lBhKTdcjEDGX5lbcRuGCCCKSINKDejdwmu010VrPU+4xLaYBCA5jUSp1DF9arAmiFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA35LcD0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513dd2d2415so3107905e87.3;
        Sat, 23 Mar 2024 05:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711196446; x=1711801246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEF9k6OTzx0WzlkimL6gzHMA0JvM+lJpkyegtgtFp/I=;
        b=PA35LcD0YRHoMv5nOlSASwa8JPWEETREc6cbWwRNqlB3FciE+9LA1w2Z4bx22Ag8fj
         Hw13cUlHC7eUDdEh0pPPAt/XUQrf8Fhnwjrta2xfdaezpFmZXmcT/TIqsCu/9O1DUcVY
         kj8KSUHXXCLEhZeivIMDdIv6Veg8OiMqvjVWVcnJlvlw2hahJ3esOXhJC1NGIfuJg9IP
         uayib9UFQMJzVopr948P2USw9HTHXx1JvZzdLfdyFhelcPxWecokPyF9MpFl+OiTs7Nv
         oXcgqRHdBi/QmRtch1xPdMoVMIMizcAldw71huWmpe3Ftq32YR3kOdw0D/w6xmLrjkW3
         9sUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711196446; x=1711801246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEF9k6OTzx0WzlkimL6gzHMA0JvM+lJpkyegtgtFp/I=;
        b=ru++3aSdQusX193x5I5XQq6cm1rghgVUMCHXlYXhlbuMTp/c3fZt7GyoxMpo2K2+cO
         bViTcQWJ5tclc3b582cTMNiq4oYtTJkmEPPXdfpYBqt9SEOxw/FB5NUn6b51ilFfhjNQ
         Vxxeu/skvU+nSoVfec17xX6hnt9ay1dq5i21WVVg++s6JXUPdKVFfQe/Ti+OidcsTtvv
         UHs4zqkquXR4+UdgiOZyc+glxtrr9nstBe+cuZFj+m3iB04MP2/+5aTf+KaNFgmBO2vK
         ba3cVnQHZTXVd3zGePMy5EzarJscqQokLZ5+JN4yxNEtiAIh6otoVtLZCQ4w0+DxrQWn
         SowQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwGWSZK3Tqesit9hgVhZ2lwIElPVZ73dOUClDwBwsM6gEqjh5jeBWNL8EwmkZOWxz1sbYN5zcmxI3lBnhttGcQ7rUKDllZrYzYGcjqfM5uIv7Mquai0O3Q/meyfjrj5XI2aNHrttXCGg==
X-Gm-Message-State: AOJu0Yz+XhmB/2u04NKQ8gc1qdB4bbLUi7VtffXMdA9jsj80zINAEiMC
	cszYkg6w1NNDYFLTaXdNnNfsGy/2mBPqct90B5922O81DyuSXUIR
X-Google-Smtp-Source: AGHT+IE6i1OaBSulAf2ARyIB2hJ0C0FiKBkWhCpQomvMTB0RP8G0v5EfHh642qgQUTQxmQMiGsdkIg==
X-Received: by 2002:a05:6512:718:b0:515:8a62:682c with SMTP id b24-20020a056512071800b005158a62682cmr1380173lfs.58.1711196445872;
        Sat, 23 Mar 2024 05:20:45 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id gx24-20020a1709068a5800b00a46f0d133b9sm857265ejc.98.2024.03.23.05.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 05:20:45 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 4/6] iio: accel: adxl345: Remove single info instances
Date: Sat, 23 Mar 2024 12:20:28 +0000
Message-Id: <20240323122030.21800-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240323122030.21800-1-l.rubusch@gmail.com>
References: <20240323122030.21800-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a common array adxl3x5_chip_info and an enum for
indexing. This allows to remove local redundantly
initialized code in the bus specific modules.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      |  7 +++++++
 drivers/iio/accel/adxl345_core.c | 12 ++++++++++++
 drivers/iio/accel/adxl345_i2c.c  | 20 +++++---------------
 drivers/iio/accel/adxl345_spi.c  | 20 +++++---------------
 4 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 6b84a2cee..de6b1767d 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -26,11 +26,18 @@
  */
 #define ADXL375_USCALE	480000
 
+enum adxl345_device_type {
+	ADXL345,
+	ADXL375,
+};
+
 struct adxl345_chip_info {
 	const char *name;
 	int uscale;
 };
 
+extern const struct adxl345_chip_info adxl3x5_chip_info[];
+
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		       int (*setup)(struct device*, struct regmap*));
 
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 33424edca..e3718d0dd 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -62,6 +62,18 @@ struct adxl345_data {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
 }
 
+const struct adxl345_chip_info adxl3x5_chip_info[] = {
+	[ADXL345] = {
+		.name = "adxl345",
+		.uscale = ADXL345_USCALE,
+	},
+	[ADXL375] = {
+		.name = "adxl375",
+		.uscale = ADXL375_USCALE,
+	},
+};
+EXPORT_SYMBOL_NS_GPL(adxl3x5_chip_info, IIO_ADXL345);
+
 static const struct iio_chan_spec adxl345_channels[] = {
 	ADXL345_CHANNEL(0, X),
 	ADXL345_CHANNEL(1, Y),
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 4065b8f7c..afb2d0b79 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -30,32 +30,22 @@ static int adxl345_i2c_probe(struct i2c_client *client)
 	return adxl345_core_probe(&client->dev, regmap, NULL);
 }
 
-static const struct adxl345_chip_info adxl345_i2c_info = {
-	.name = "adxl345",
-	.uscale = ADXL345_USCALE,
-};
-
-static const struct adxl345_chip_info adxl375_i2c_info = {
-	.name = "adxl375",
-	.uscale = ADXL375_USCALE,
-};
-
 static const struct i2c_device_id adxl345_i2c_id[] = {
-	{ "adxl345", (kernel_ulong_t)&adxl345_i2c_info },
-	{ "adxl375", (kernel_ulong_t)&adxl375_i2c_info },
+	{ "adxl345", (kernel_ulong_t)&adxl3x5_chip_info[ADXL345] },
+	{ "adxl375", (kernel_ulong_t)&adxl3x5_chip_info[ADXL375] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
 
 static const struct of_device_id adxl345_of_match[] = {
-	{ .compatible = "adi,adxl345", .data = &adxl345_i2c_info },
-	{ .compatible = "adi,adxl375", .data = &adxl375_i2c_info },
+	{ .compatible = "adi,adxl345", .data = &adxl3x5_chip_info[ADXL345] },
+	{ .compatible = "adi,adxl375", .data = &adxl3x5_chip_info[ADXL375] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
 
 static const struct acpi_device_id adxl345_acpi_match[] = {
-	{ "ADS0345", (kernel_ulong_t)&adxl345_i2c_info },
+	{ "ADS0345", (kernel_ulong_t)&adxl3x5_chip_info[ADXL345] },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 1094396ac..5c1109136 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -46,32 +46,22 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	return adxl345_core_probe(&spi->dev, regmap, &adxl345_spi_setup);
 }
 
-static const struct adxl345_chip_info adxl345_spi_info = {
-	.name = "adxl345",
-	.uscale = ADXL345_USCALE,
-};
-
-static const struct adxl345_chip_info adxl375_spi_info = {
-	.name = "adxl375",
-	.uscale = ADXL375_USCALE,
-};
-
 static const struct spi_device_id adxl345_spi_id[] = {
-	{ "adxl345", (kernel_ulong_t)&adxl345_spi_info },
-	{ "adxl375", (kernel_ulong_t)&adxl375_spi_info },
+	{ "adxl345", (kernel_ulong_t)&adxl3x5_chip_info[ADXL345] },
+	{ "adxl375", (kernel_ulong_t)&adxl3x5_chip_info[ADXL375] },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adxl345_spi_id);
 
 static const struct of_device_id adxl345_of_match[] = {
-	{ .compatible = "adi,adxl345", .data = &adxl345_spi_info },
-	{ .compatible = "adi,adxl375", .data = &adxl375_spi_info },
+	{ .compatible = "adi,adxl345", .data = &adxl3x5_chip_info[ADXL345] },
+	{ .compatible = "adi,adxl375", .data = &adxl3x5_chip_info[ADXL375] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
 
 static const struct acpi_device_id adxl345_acpi_match[] = {
-	{ "ADS0345", (kernel_ulong_t)&adxl345_spi_info },
+	{ "ADS0345", (kernel_ulong_t)&adxl3x5_chip_info[ADXL345] },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);
-- 
2.25.1



Return-Path: <linux-kernel+bounces-127011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA8D8945B9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC35282540
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D4756B9D;
	Mon,  1 Apr 2024 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J03SfK4B"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5ED56459;
	Mon,  1 Apr 2024 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000964; cv=none; b=pSNHjrg961YieISLqzOssbqsYARt0mvPBfRlex4Zkt3UPOpPCzXdRI8Aa98/I6KQjidFhsL7dz6DB+86KR4Y3YAqW6oLdscHVLq6mTwUvfKPkedyvIxil75ESd74LEiJqIJjH4UMJzB0UGnc09Mc+8H0pDO3Y/U5kAVvtt8p6RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000964; c=relaxed/simple;
	bh=WIUwpBmvhODwp/Pmv5TOZAvQxvE4P44+MWrhzYC1oDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sP8NsegADtSqpG5ubZV/i3vOYm+pGPxD9KZkkYjrDhkqMovQAz95zWLAQuIbyAjy+fA3X+wVNOlwSuBXvgWP+3oGjbgzV9vdBjLuomUH5LXusSICfdFCRbPUzqAukjO4Qx6WQGrUmkR+MlKZwS36ok083e7CEk0Mfa6vyPMsO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J03SfK4B; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a46ba938de0so580890766b.3;
        Mon, 01 Apr 2024 12:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712000961; x=1712605761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGTJQgHYVEHYV+zZnpaby/KS0FGoN58yasNoZmxBwEM=;
        b=J03SfK4BKLpBPSO+Y/iHPelqERECE25uq056a+ONuZJH00RDy5z7vCJj34r2XBpYJ7
         s4How7RO7CarZdU3+vWZl/iX/5Nuub/kfd9vdQctNmnf/3G9R5YWyLbE0aBlKG6rx/GH
         MeAgs9fcA/UJWNrx0qX2Xuw7R+xGteoJnYit5pvjUHyVyfS8F3jhp66X26UJCZ71hNKV
         pu83QzDl2CUxzIn0RxY4cDeapUqGA7tGircuS7iHBnwy0J/NZ8mlloeigBihAyL94aOz
         ZHhZheEfUN1eOXOo76Aj8WnFHJASnU90VqtL0gXEBY9A69oDlhEHknB6NT+gZHXWrAuo
         Va8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000961; x=1712605761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGTJQgHYVEHYV+zZnpaby/KS0FGoN58yasNoZmxBwEM=;
        b=nZZMouCbHpC4Ylq7DhJX5jyWufu8n1it9L7xmou9d4P9Ng6a5DQLGFLBjWsw65GqyP
         UZfs1RTWTxnN/LLlw6exN1gQwF8gcGUUjnjFsP0M+LpYwKVjfREipScKKUfUXjvxUvqp
         DczZqsDiurX0z9XaUj+36up3CoIa3gDT8VJlrQ4NVGCLOIRGhwaN1f2iM2I0JuzD3vVC
         9y6aYq/7TsqhHvno1sHcwoV04eVxegktK1e1SgC82WNeKVM/MKCHgPReh/FkcSe31HiH
         IOxO7UeerLJtua8FhvZu0P1p58vetHovzPCtKAUJ20kQTQ6FvoTYJYFl2YTulLppn7YH
         eblQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvho5Igz8I4MyP0vGwcsJ1zbHt5yOnG6vHJH4RUdaOj3sh47WIwLsZLfjapfSrL6ZLgQLuhk0vxwRAHXR0JUUaz9WAJuOIjqf+7Rn+/X4CQUj3G/kGs8r61ayrhlNhBV44ySw73VVwhA==
X-Gm-Message-State: AOJu0Yyu+QnlaURB+ciPZFa3XzvaCJzLmBVExwiPIcR1ZC33jOVdWWyb
	kweIkJHkkeT85GfihlJ/c+HpNZqWhYMKH21T3HJGG1KbKXzgtlJJ
X-Google-Smtp-Source: AGHT+IFHcbVXsvqhwu1pQV9lyecrCN2a6YY77aM84smD+cJXvLTt4e/LHZDmec83/bPZYQy1anJrQQ==
X-Received: by 2002:a17:907:72c6:b0:a47:30a1:4c1b with SMTP id du6-20020a17090772c600b00a4730a14c1bmr8424347ejc.55.1712000960922;
        Mon, 01 Apr 2024 12:49:20 -0700 (PDT)
Received: from 13a4f82a8f12.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id dn21-20020a17090794d500b00a4588098c5esm5540575ejc.132.2024.04.01.12.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 12:49:20 -0700 (PDT)
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
Subject: [PATCH v7 5/8] iio: accel: adxl345: Pass function pointer to core
Date: Mon,  1 Apr 2024 19:49:03 +0000
Message-Id: <20240401194906.56810-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401194906.56810-1-l.rubusch@gmail.com>
References: <20240401194906.56810-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a way for bus specific pre-configuration by adding a function
pointer argument to the driver core's probe() function, and keep
the driver core implementation bus independent.

In case NULL was passed, a regmap_write() shall initialize all bits of
the data_format register, else regmap_update() is used. In this way
spi and i2c are covered.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      |  3 ++-
 drivers/iio/accel/adxl345_core.c | 32 +++++++++++++++++++++++++-------
 drivers/iio/accel/adxl345_i2c.c  |  2 +-
 drivers/iio/accel/adxl345_spi.c  |  2 +-
 4 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 732820d34..e859c01d4 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -60,6 +60,7 @@ struct adxl345_chip_info {
 	int uscale;
 };
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap);
+int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       int (*setup)(struct device*, struct regmap*));
 
 #endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index f875a6275..8d4a66d8c 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -168,7 +168,8 @@ static void adxl345_powerdown(void *regmap)
 	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
 }
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap)
+int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       int (*setup)(struct device*, struct regmap*))
 {
 	struct adxl345_data *data;
 	struct iio_dev *indio_dev;
@@ -179,6 +180,29 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 					 ADXL345_DATA_FORMAT_SELF_TEST);
 	int ret;
 
+	if (setup) {
+		/* Perform optional initial bus specific configuration */
+		ret = setup(dev, regmap);
+		if (ret)
+			return ret;
+
+		/* Enable full-resolution mode */
+		ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
+					 data_format_mask,
+					 ADXL345_DATA_FORMAT_FULL_RES);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to set data range\n");
+
+	} else {
+		/* Enable full-resolution mode (init all data_format bits) */
+		ret = regmap_write(regmap, ADXL345_REG_DATA_FORMAT,
+				   ADXL345_DATA_FORMAT_FULL_RES);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to set data range\n");
+	}
+
 	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Error reading device ID\n");
@@ -203,12 +227,6 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 	indio_dev->channels = adxl345_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
 
-	/* Enable full-resolution mode */
-	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
-			data_format_mask, ADXL345_DATA_FORMAT_FULL_RES);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to set data range\n");
-
 	/* Enable measurement mode */
 	ret = adxl345_powerup(data->regmap);
 	if (ret < 0)
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index a3084b0a8..4065b8f7c 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -27,7 +27,7 @@ static int adxl345_i2c_probe(struct i2c_client *client)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&client->dev, regmap);
+	return adxl345_core_probe(&client->dev, regmap, NULL);
 }
 
 static const struct adxl345_chip_info adxl345_i2c_info = {
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 93ca349f1..1c0513bd3 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -33,7 +33,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&spi->dev, regmap);
+	return adxl345_core_probe(&spi->dev, regmap, NULL);
 }
 
 static const struct adxl345_chip_info adxl345_spi_info = {
-- 
2.25.1



Return-Path: <linux-kernel+bounces-122076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5090D88F190
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81FB31C27DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A18F1552ED;
	Wed, 27 Mar 2024 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYPrLiHZ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60B15443A;
	Wed, 27 Mar 2024 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577017; cv=none; b=TPK6s7nIVlqOZ9T1UD4YTBHkyPp0xDeeY6tNubkf3gs0v/3reGJ9EQphleOXS4szY68oGH4NwRu32htS/bwd67y0GU7sGMsP7Gu9kWE6t04QtoJnjTQ7BXjsAgn5G+t/mTBwA8d2VKZxd40H4dAwNQMWcaxnDLs2O5IECN3SlLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577017; c=relaxed/simple;
	bh=99gZa2i0sUzSawrRZCPo/XlCgwX1PBlR4tNSa5sh+L0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SN1Svsb4HsRd7hJxYGIUKDscDCZTyV4e3tvNC0QxfTKrA8CoYpfSxG2AGPLRSYBN5W7kurr/ZnMw/Vyi18D0+4ZHqYPoqFji2zJ8aZCmiVVC6rgGQwk8uYKWN+JGZKuDwP1V07+TIKMZ6Ir/PZaoQizf1dNMe/aDwfzP59S9PYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYPrLiHZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46de423039so17813666b.0;
        Wed, 27 Mar 2024 15:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711577014; x=1712181814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89IafmFZ/aI3kr80E1zIue4BOC9yvNRvlIwDPCL8NKM=;
        b=KYPrLiHZJWzE9k1cFkO27WjK+BUKX74OpXsRxFSvqM72cY8FFsoPctlqKQI/4hCn7W
         p+2Ag0ijAW5bUvcFZKfkKnF+hJUwhX3Aq7/BnZ3IJRyqxAA6fewuflDzs+ETV8vC6ap4
         pbBgly8lEikfWTq8eDlVgR6A15Zzy4C8eNXOfZAQ2XArXftZptTXka6EG2fzT1bkAD5C
         Nq9hyvtP/U/vBDxzbwoy7XkAHpte8aMioKBgHIizcprx1Fl1iQwnQtg6as3+1FY2dwca
         o2Ne8gqZEbBzmVSUE2+4Zulw9ukZSrA2QsJhbwgQZW+gLwA6+7LNXMQNrvZfVPqHSUwB
         6LdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711577014; x=1712181814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89IafmFZ/aI3kr80E1zIue4BOC9yvNRvlIwDPCL8NKM=;
        b=nyRTpGWXqQZh2XWDhA5cMhNnuJftUn9pSJB/vQ6IMEbIP9tFxSgusDKVTIStbjVg7T
         sTTXQBkG4Ugerqy2AW1+ZX2bhmMPcK/haWzuwJ81bO4+Yhkthcp8g4h15fhFr5KRSFxn
         3ktSvHV/1E3N5f2OE1HDgENO9gXQudrtC99GtxpwUAdlGt4ZdsI0t6vOkrcZD97I3MwI
         RcHpQXfSVBlbDD/NlIdAJXi55z+DvLB7l/u5mSU2epmfN2nuApCeLkwKqbVtV9R20ebF
         jW8Hjbd94SyC0b63sxVKvSLKm+kxWqjJTxeHcYjXaXeSka2i5QFsjpcZewcY+gIggkUs
         j2wQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2D0MC17GwJTqBDUq0IbD+j2ebGbh/z/+b07Qeru434Qnps4rUPUw2p6IWmU4BN0cqJl3EbSBKFQZ39X2i4JuKM+/OcG6snH63t9Mf40OP6jC7DtrF7bVjH0BxJ1c4TIhbR4BmGKOVmg==
X-Gm-Message-State: AOJu0Yx2MWqjYlXXYiXqdP6+bj++7UtXZ4TpJ2VxIt4hPjzjVeKodcrM
	VcBRaQUtkBhcFXeyARE04klLL7Ar2lRdy+HTzL0TwJFjkpTkQyUY
X-Google-Smtp-Source: AGHT+IHjgcrbf7p6HGY/IJsRM+A/ALwN8WMUCZBO7hvHj3auPa7zmZ7DKEyV4ZgbPPw2WkqRwizfIg==
X-Received: by 2002:a50:9559:0:b0:56c:995:5b with SMTP id v25-20020a509559000000b0056c0995005bmr1205178eda.11.1711577014126;
        Wed, 27 Mar 2024 15:03:34 -0700 (PDT)
Received: from 51a0132e405f.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id f25-20020a056402161900b0056bc0c44f02sm59151edv.96.2024.03.27.15.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 15:03:33 -0700 (PDT)
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
Subject: [PATCH v5 5/7] iio: accel: adxl345: Pass function pointer to core
Date: Wed, 27 Mar 2024 22:03:18 +0000
Message-Id: <20240327220320.15509-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327220320.15509-1-l.rubusch@gmail.com>
References: <20240327220320.15509-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function pointer argument to the probe function in the core module
to provide a way to pre-configure the bus.

The passed setup function can be prepared in the bus specific spi or the
i2c module, or NULL otherwise. It shall then be executed in the bus
independent core module.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      |  3 ++-
 drivers/iio/accel/adxl345_core.c | 10 +++++++++-
 drivers/iio/accel/adxl345_i2c.c  |  2 +-
 drivers/iio/accel/adxl345_spi.c  |  2 +-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 564f7baf1..4ea9341d4 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -65,6 +65,7 @@ struct adxl345_chip_info {
 	int uscale;
 };
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap);
+int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       int (*setup)(struct device*, struct regmap*));
 
 #endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index c7c1156e8..40aab7683 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -168,13 +168,21 @@ static void adxl345_powerdown(void *regmap)
 	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
 }
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap)
+int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       int (*setup)(struct device*, struct regmap*))
 {
 	struct adxl345_data *data;
 	struct iio_dev *indio_dev;
 	u32 regval;
 	int ret;
 
+	/* Perform optional initial bus specific configuration */
+	if (setup) {
+		ret = setup(dev, regmap);
+		if (ret)
+			return ret;
+	}
+
 	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Error reading device ID\n");
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



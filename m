Return-Path: <linux-kernel+bounces-112341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B472488789F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BE03B248CE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8300243ABB;
	Sat, 23 Mar 2024 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9rPnrdU"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1085B4204E;
	Sat, 23 Mar 2024 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711196447; cv=none; b=eF5JUf1/knZ/mqarlI9AtRYfnAG6Q1wSF3YIpMl668leTWavjZ0nvrhCZ6R1we4kfmhDlPLN/eNADFtO30IyZXm+PKOOOmqUQNTYElMnpX8TVOWMH5i9arrIW5HK733wDxBVCy5y4mYGWBPTISGGpwJWD5kpiyZY5eJzKXq9fyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711196447; c=relaxed/simple;
	bh=F917oX/86+LzQsZH9R09o3vsMIcRYlaEtU1pcQYT4D4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OZhgvh4GO4jhulLiR6ofZT908HWWOvULmLZmvAflfU3VVYJ+ZkYxt2N19zrZRkVVnoyRMmhot6UKDgsEJbGWye6fmr26PQdGrEzdYIqWNs6OHbV82n9AgH6T7/+8bIcOjGZwAlaEhR4gke8aMz1bgobaZ3IfIh6saPffKfxN7NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9rPnrdU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513e10a4083so3408926e87.1;
        Sat, 23 Mar 2024 05:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711196444; x=1711801244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9M/azYNBq/ofGwHBqxZwD22VAkNumDS9czczl76sTQ=;
        b=l9rPnrdUoL/ofkvkw6t3V/x+mmwjkOQer0i6fO89wyn5A53tp1VJwdhpn/8vtSZDEj
         cq8L8LBawdaiI045A/g3IYeB3sp0cw5yIlW0BBEiUEj8nj+zbwgQDRWN1KeRlLSfS6mI
         5876RP30BjEWMg60UKWYuIiWAIiqJOVy7YaSiB195d2cESoAuJfYM38x1iPU9CX+Kr7m
         C7gjeczaL8jPg2ZUcf6yCX1qiQ8AWSt7vLLfIaBPE0DL1GdiCTWVXIASxjOJAm0GtFjm
         RmQxa2EjFuG0BKAH30ObZLD2b5PcGIFQywnArI1V0YTmBK0EmsuK8Tg70+2pcPKzLsq9
         A2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711196444; x=1711801244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9M/azYNBq/ofGwHBqxZwD22VAkNumDS9czczl76sTQ=;
        b=MKt8pPLhcPD9dpT12bfG081WjcHspWhGKfQ/+oph9r1FWeHPx9y+ksFFIoBT5Nhv1C
         u+HKAZXZFvAL2vOCEhbQ2vR3MHzBoqtD7Tr+uHG40IFuHs6WL+ZF9He1NJPd4h2ovXqD
         Rqpc0h8K/xXFeX98KliCETZDsLPBU5HCC/SwUH3NCdtz3utfgcIwY3d8wKQeWacCiuYQ
         4WKANtyBUkS4qywTiF+iQelmB/ilc9EKtOHLKMG1aEIj3os8XWenGw5j7IQQEhTQF66Z
         Smk7USNDkgEi/F9HyM6zjkBLV7ONY7TNa8ULXFJsEmOjBa95TSBVsDJl6o3MaVYMDmeH
         AGDA==
X-Forwarded-Encrypted: i=1; AJvYcCVGezvMfjCha6an1TVRywBzojUiqBYCSN93hX0D+yu4EzmBpPGyLuVjsuFqf0FAtlYdjfGT8kzrHenXSaEm6w6m6VvPIWVac4bweVQOnZh81ZgTF8NMlB+hAxT6FnGeUgxssouWiSzcQw==
X-Gm-Message-State: AOJu0YyQRe2AiQtzGkrmpvmhM3NZtigcc6yO3bBiAIcnUJZ5HRZFcT5G
	dzy4UJSvEdl2jqAwEyNGmSwuNi3Bv3Vfp+CHqr1jQ43b232OhSYu
X-Google-Smtp-Source: AGHT+IFbENMuoIu0VKadhifzuuDSg6swCOVCNZNuGUvbG3TGtUtkY9Pt9wBW5znbf+bJtSlVUi5GUw==
X-Received: by 2002:a05:6512:558:b0:513:cfa0:b689 with SMTP id h24-20020a056512055800b00513cfa0b689mr1261877lfl.61.1711196443835;
        Sat, 23 Mar 2024 05:20:43 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id gx24-20020a1709068a5800b00a46f0d133b9sm857265ejc.98.2024.03.23.05.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 05:20:43 -0700 (PDT)
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
Subject: [PATCH v3 3/6] iio: accel: adxl345: Add spi-3wire option
Date: Sat, 23 Mar 2024 12:20:27 +0000
Message-Id: <20240323122030.21800-4-l.rubusch@gmail.com>
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

Add a setup function implementation to the spi module to enable
spi-3wire as option when specified in the device-tree.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h     |  3 +++
 drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 3c1ded0c2..6b84a2cee 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -8,6 +8,9 @@
 #ifndef _ADXL345_H_
 #define _ADXL345_H_
 
+#define ADXL345_REG_DATA_FORMAT		0x31
+#define ADXL345_DATA_FORMAT_SPI         BIT(6) /* spi-3wire */
+
 /*
  * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
  * in all g ranges.
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 1c0513bd3..1094396ac 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -20,6 +20,16 @@ static const struct regmap_config adxl345_spi_regmap_config = {
 	.read_flag_mask = BIT(7) | BIT(6),
 };
 
+static int adxl345_spi_setup(struct device *dev, struct regmap *regmap)
+{
+	struct spi_device *spi = container_of(dev, struct spi_device, dev);
+
+	if (spi->mode & SPI_3WIRE)
+		return regmap_write(regmap, ADXL345_REG_DATA_FORMAT,
+			    ADXL345_DATA_FORMAT_SPI);
+	return 0;
+}
+
 static int adxl345_spi_probe(struct spi_device *spi)
 {
 	struct regmap *regmap;
@@ -33,7 +43,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&spi->dev, regmap, NULL);
+	return adxl345_core_probe(&spi->dev, regmap, &adxl345_spi_setup);
 }
 
 static const struct adxl345_chip_info adxl345_spi_info = {
-- 
2.25.1



Return-Path: <linux-kernel+bounces-110830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D4E886473
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A236F1C22184
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90078F68;
	Fri, 22 Mar 2024 00:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5+MWbDK"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5F376;
	Fri, 22 Mar 2024 00:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711067853; cv=none; b=QNCHArsH+2+PGvTbDz6Tac2vE8NjSBDUs8n54bJsrN2imhLELexJxU+LaUS60HDymVFzuHG7/s5f/dEzxzjv71gDcFHLMjgK4uZutarY9MqPNf52e7ahEtdhXH5On3lWXygNduampTFChmi9MpYsfLLPJzleTMqLDvhkqiIVy7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711067853; c=relaxed/simple;
	bh=JxHy/iDMhKrsFnbMqBwBudkOZ4YoNhM1yzPNfxgOBu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QjNHrLo3GjIJ/t5OS1CWAGo2EIsSlAELo/khOQlYRXDTjxr6uxbfdzuyBMY2Us5XEARL+65gCza+Xr2aWlZ7RyJi9vpXCoGEpTq7f/+WZRXl4NS4WGe9lMgDPFkmwebg0PvGHKVHFrITLgvh6NKBd6s/6Z0W/Hd3kw0bOiSd6yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5+MWbDK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a472f8c6a55so8510266b.0;
        Thu, 21 Mar 2024 17:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711067849; x=1711672649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3fxfI+40YsgLedt7aYPTZ9o6Yp1i1mqfN+KkhFOziE=;
        b=h5+MWbDKJd2rbqvvMdfZq/mQ3oEOgcKeLKlCv64Y03FACZAH1IMVYOXvE9V4t+ZOfT
         IT9jQSkAqchrZCYheI5PWs6/XduUnwVo/m4kw+JmQEQdcnvivuex9fRxMZMP60cFgIIv
         LiR9Yfgi0uIn5R66TLApxuLUXSP9mT/L406kf2AFKCrsfTs8yB/aW+zDGvoBVjLLQnPi
         mLO43JouANAp0SSwbTOKOH+XrNX0GkYr4BkLV67G8LT5tR+OolHt/tWaPiO0dHO9/j+B
         D5FG8NcVGGYGnAqi7L6md61dpDioPbzHhuT51XuZXMoO+eo+a/4pNzpEGzogVULvP4tb
         0WAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711067849; x=1711672649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3fxfI+40YsgLedt7aYPTZ9o6Yp1i1mqfN+KkhFOziE=;
        b=xNzW6zjZWUr0JJGLOvKrx8L6s0e4qs6qkI62Vhk3PgyspX4Edbw/WPBvveUhgSol9x
         LW7mTXVFzeLoX5Cm3JVhQKvAmoGK7YHp8d0gTy8bMDedhkgG99k2ajU5pvGsAv5zc8lb
         xu7Z05Xpcf1Muyo/CM7Xt1YFK2rj9WQCOC02JJZTeXH3wf0uStUJmKSGcFgxRZE6icqI
         p4Qn5ND8fXv66t/9bWkn+P8npkq5zbIf3FyT7p6Qf+PZKrn0ya1p+a719syEuAx3Q+cs
         Uu8yNpotFEVxn0kGmY0hwjH5Ap0n7L8ZOLxbd5R0+q9lX0zbTFmnsCtRNvOamRh9K63R
         poEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX3rL25zv/WUuYJqOvrUSPGg3ESmQ0zVkPbcRrgY6vI4EDkK1iK5iWcBBQ8VjLbdsg8Trq1dN0Np6SU9OvcQfWXAzIwE97/KK42WoQCqG/3K1LcN5qLAPabwfEYp0VeZIfLlr+S5zwTQ==
X-Gm-Message-State: AOJu0YwW9cYiqxNGuSvpXmi6xQoO+fSxDsLvwqu0NfOpCi3J19MYUJPg
	q7enGXBKcDp1fJZ+zFVqlbPpkpxM5wLaHzm2rpJEF3kUm62PyzQP
X-Google-Smtp-Source: AGHT+IGpE6SHu3yP1MzG/smAvFHw7/Wqg74dznGdvfu8zQwCzn6BLLz3c/t1IKaPAiqWJLO0wMWfaw==
X-Received: by 2002:a17:906:13d4:b0:a46:2c22:7f4c with SMTP id g20-20020a17090613d400b00a462c227f4cmr608290ejc.35.1711067849332;
        Thu, 21 Mar 2024 17:37:29 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906774b00b00a46af0fbf5dsm439950ejn.103.2024.03.21.17.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 17:37:29 -0700 (PDT)
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
Subject: [PATCH v2 2/3] iio: accel: adxl345: Add spi-3wire feature
Date: Fri, 22 Mar 2024 00:37:12 +0000
Message-Id: <20240322003713.6918-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240322003713.6918-1-l.rubusch@gmail.com>
References: <20240322003713.6918-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the spi-3wire feature to the iio driver. Pass a
function pointer to configure the device if 3-wire
was configured in the device-tree.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index c26bac462..aea368895 100644
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
 	const struct adxl345_chip_info *chip_data;
@@ -39,7 +49,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&spi->dev, regmap, chip_data, NULL);
+	return adxl345_core_probe(&spi->dev, regmap, chip_data, &adxl345_spi_setup);
 }
 
 static const struct spi_device_id adxl345_spi_id[] = {
-- 
2.25.1



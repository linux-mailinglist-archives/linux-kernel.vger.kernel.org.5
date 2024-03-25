Return-Path: <linux-kernel+bounces-117374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4836088AA9F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16A1324B45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF09481AAD;
	Mon, 25 Mar 2024 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmlFaR5O"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D9954912;
	Mon, 25 Mar 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380891; cv=none; b=sp4x/DKQkQlX7lrK7+B4+Fxm8CuZqbzSGkLxoPv3d+u/d71F9TMCWJEVhFvRdUQVb0X5QCezKHBBK7kV0vr70nlu7KmpcXmfJtNoF8yYfaGplVtsO+jIjvO/tQgBrVnStcoQq9FDXPyAaR4kQj2czDh6hxjv+nmoPUss074eK3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380891; c=relaxed/simple;
	bh=iKFinwSCIrAzuhZju333qXfiLrNqU3nEpbENeB8YuEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GGfRCoZYzU6D+Av2HxqhXzdVj7/+lsQ7edkmpyJ7VgusTQgD/AXur2HqdpS3twyf+jnmH0RAajN4X55z76+pNt2WI/TCrw2cDgdpexAXPXv+P/0pnrczgvUl40WyYwdJdOY7XGXcu1SfPqyoWWFushkCr6dVIvJ2ZUUR0esKqUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmlFaR5O; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so3152694a12.0;
        Mon, 25 Mar 2024 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711380887; x=1711985687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLkugZ41ZOy6ra5p6BTFzeyEFCqQHWApOAwI5fgcVQY=;
        b=MmlFaR5O4lLD9dsrVxr/khxhWhA/dGRSDfTiss5Y0KEu10Q82NQwMIPV7ag7eyHKRR
         T0StBn6dOLLNAoik8WXNMhyr1mIH0k9dq2BwssbK0acEPEornaIzHGjV3HLmyT311SNM
         AZsqE+VqtDrDfQWY1Svukpksj0xSxg8yfDK3PzkTVCZuTqrVKm1CEOVM+reGeaTXqM4A
         2kNHVPY1sImSioGu/488cC+dFLLmMxve6HeD9cwf8NENIPs0f5LFtiG3B7gdR/2cjZWk
         U9yXpo3+pIX+KZlP+b5CKXTRn/fcNshOMc6YiuplETTFemSCAf21rYsDkCzKqGjzBKB9
         d/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711380887; x=1711985687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLkugZ41ZOy6ra5p6BTFzeyEFCqQHWApOAwI5fgcVQY=;
        b=LhLJ6/0T7qI2Qi/oWderQ/pwIN6VnxVxrGNThquQwkNT4t7sTumMNUg4vXfsD3dSYs
         C8RAo9JQWz1mXP7MaTAAgVrTXjyaBAIGNvifa7YQJxyIPYyMw8uYDMT9+yRPt+ZIUiC8
         0qEUXQQ9a0QXFHZ1QCQchbbqKwBbo0aZho/KAa9UG9RYlgf9+Gx0nZ6+hfuHZfGvqmUk
         JBQ47yPxISLpgCWoWVm7VnsjN36qhjJ0OMQS5zveiIdKYLdGmEPmtrHL179Ks7FbhMhY
         RJX1iMuDBg+FUlES3hDW/iqyvbJfme9TKATFQ6T6SdlR04qjjsH3WHrn4QZ2VAGIYkpm
         0oVA==
X-Forwarded-Encrypted: i=1; AJvYcCVq8o2Ww3T8wWupO/ZfVibYq7SHHvHt4WXvKUUeVG5c+maP8GycHBhw2OchSCgLtE4hPrX57hp4LMtxS+v6OAYaT9CAaWwf1LHaF6idW+7AfhgqjkVc8rWN9c3EMeVExKcMODpdNuLWGQ==
X-Gm-Message-State: AOJu0Yyg4MGYGMnhS8Z0WwpFInO35JoKs+oqDiMjQee0GniCmJx4CLJd
	1qZHCeKZT1W+F+G7KJPuTLXKM2vywbiQXLwRxfR8iBaMBhsgeaLn
X-Google-Smtp-Source: AGHT+IF/kaIka1A/VUobqqXApZ1ckaZ2VnXLE4sPlKs6LoJkfUMQSktjyXYdmruCGt6kNwOi0jHiWw==
X-Received: by 2002:a17:906:304b:b0:a46:64e3:e284 with SMTP id d11-20020a170906304b00b00a4664e3e284mr4416202ejd.74.1711380887353;
        Mon, 25 Mar 2024 08:34:47 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090626cd00b00a45200fe2b5sm3142382ejc.224.2024.03.25.08.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 08:34:47 -0700 (PDT)
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
Subject: [PATCH v4 1/7] iio: accel: adxl345: Make data_range obsolete
Date: Mon, 25 Mar 2024 15:33:50 +0000
Message-Id: <20240325153356.46112-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240325153356.46112-1-l.rubusch@gmail.com>
References: <20240325153356.46112-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace write() data_format by regmap_update_bits(), because
bus specific pre-configuration may have happened before on
the same register. Changes then need to be masked.

Remove the data_range field from the struct adxl345_data,
because it is not used anymore.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 8bd30a23e..be6758015 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -42,13 +42,13 @@
 #define ADXL345_DATA_FORMAT_4G		1
 #define ADXL345_DATA_FORMAT_8G		2
 #define ADXL345_DATA_FORMAT_16G		3
+#define ADXL345_DATA_FORMAT_MSK		~((u8) BIT(6)) /* ignore spi-3wire */
 
 #define ADXL345_DEVID			0xE5
 
 struct adxl345_data {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
-	u8 data_range;
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -219,14 +219,13 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 	data = iio_priv(indio_dev);
 	data->regmap = regmap;
 	/* Enable full-resolution mode */
-	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
 	data->info = device_get_match_data(dev);
 	if (!data->info)
 		return -ENODEV;
 
-	ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
-			   data->data_range);
-	if (ret < 0)
+	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
+				 ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FORMAT_FULL_RES);
+	if (ret)
 		return dev_err_probe(dev, ret, "Failed to set data range\n");
 
 	indio_dev->name = data->info->name;
-- 
2.25.1



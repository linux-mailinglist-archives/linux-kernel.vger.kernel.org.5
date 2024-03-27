Return-Path: <linux-kernel+bounces-122072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F41F88F185
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C95B22872
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D570153BD5;
	Wed, 27 Mar 2024 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLMQQBs6"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA531514E3;
	Wed, 27 Mar 2024 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577013; cv=none; b=W6w93rCe0cGsNQ+1Y9yXL1LKKBsgU5shF+owaV1Z1f7LAdUO+ym3OYKtqWLi4Ry8eQx9sQPNGJVGHtQP8N5hSH6g4/Ostzl8sIMDopBxea+h3VvDuyy2cteu1OUti9YlhSC4uuUFl2xyav9Tr6PTeiLYMo8dKrxn3PIs55v2w10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577013; c=relaxed/simple;
	bh=bxzemSPDLNEPrCVWOebUIqzTqUx1AjPJ2yrr3Zwcx4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LNYdhMSGRHLP+BjUsp8ThTFrD0EVBwE9ASDgOMEZBgbjT5a3LUvgKPGJskq2gWMvmzE/F2e+O/rKUrteeE1y4UR3f50gB5Su1G3JNPbCeX7uGfBEYSMOtNSIvZxbXgF9TXUT7qdm0GN9YqGx1b4Z4FQ8h9E0S/Savjn3HeDbmhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLMQQBs6; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso343301a12.1;
        Wed, 27 Mar 2024 15:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711577009; x=1712181809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URyBg/+3Gh39BRJigcHvt7GSBnm62AJI1SDM77e7DKs=;
        b=cLMQQBs62WVWxfqV2A7XpmM4Y7g4WlZX8/BJgGL+3ja0FRsyeRM/pibK08+xJQ1c6I
         DsqNL91Lz+6lhP0bVJ7HtOCiYv81hNk3UwrbcGw068V+c4bHULA8ujfZ+6aqnS05+gd7
         Gx+R40bE3W0XM6b2YOyQzz1wOkDWnwijBkOgyHnDhiMtUZ77iWMbD4y8oBeSpRQ7lU2I
         80rgYv61+V10OZmF840gE9uTOaY6eA5/iBOcHDHMcMB1NMvSgrMDlJ8FEYZv1WsL7cMw
         yk+s3oLmwBPRcWXRXpJdjuL9A0CYl/YxvbE5dBE9kCIBdEVQTWN4biS9nMgqcc8X73cj
         Q7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711577009; x=1712181809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URyBg/+3Gh39BRJigcHvt7GSBnm62AJI1SDM77e7DKs=;
        b=KfHH6i4vz5JXdqVDpaY8296DVUQYI2X5SzG0/6CBq6j1VrkMXajrVJOQ/buOi0cG4s
         jF5j4BstWK2yuVKNIEo+BJdJZV8n2z9ZLJNPLz4OdzIYYJCXSe+SuiUF4EqWxRz0R01E
         Ke3gFwV/EeGRIIhujS4xH1HkyLlD06s+HoT+4j78HFWZgJu78MRZRELYpmHiUMUj5Ol2
         92QexGuqzogbe+OFTrID4fJTU5XMokQ6OvoJM6Vt2j87eYXGV8itHddCGFuZzd2q6I5+
         7v1fE4Gsw0fJmKHimlTFoAmjvgNXkBegDE2EecUe9gV/pFldxj/c2NkqiuZ+z8HFG3vP
         3aAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn6/QxGW6aUd5SiwpHjryHM/sgINTEBmDmzezhfI6jce8Xuz+d159Bnu0UuF9Gf/W49Q3MdBsbtTZ3olRMwOUpzkBC8BW/H/qHPdtncbzpHsCi3QPAS99HYoxSZ9zVLHMPZiw+oSf1WA==
X-Gm-Message-State: AOJu0Yzgczt02LyozN2l+4fk4YEQVc7U/1PM3UYj4xF7Uhoe9sVBlH1v
	meKKo2FHz6QpxFUbWW1MsWlRr8ib/PFrTPLcomMhdFROjFXZdvB5
X-Google-Smtp-Source: AGHT+IEzro4nMNvFDZXsQNoAzQZzZ/qBvohWDsjA22KWH050VFlWcN51oLO+mpYS7g+9BxAMro2uHQ==
X-Received: by 2002:a50:9341:0:b0:56b:afe0:3070 with SMTP id n1-20020a509341000000b0056bafe03070mr879037eda.19.1711577009512;
        Wed, 27 Mar 2024 15:03:29 -0700 (PDT)
Received: from 51a0132e405f.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id f25-20020a056402161900b0056bc0c44f02sm59151edv.96.2024.03.27.15.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 15:03:29 -0700 (PDT)
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
Subject: [PATCH v5 1/7] iio: accel: adxl345: Make data_range obsolete
Date: Wed, 27 Mar 2024 22:03:14 +0000
Message-Id: <20240327220320.15509-2-l.rubusch@gmail.com>
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

Replace write() data_format by regmap_update_bits(), because bus specific
pre-configuration may have happened before on the same register. For
further updates to the data_format register then bus pre-configuration
needs to be masked out.

Remove the data_range field from the struct adxl345_data, because it is
not used anymore.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 8bd30a23e..35df5e372 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -37,7 +37,15 @@
 #define ADXL345_POWER_CTL_MEASURE	BIT(3)
 #define ADXL345_POWER_CTL_STANDBY	0x00
 
+#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0) /* Set the g range */
+#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2) /* Left-justified (MSB) mode */
 #define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
+#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7) /* Enable a self test */
+#define ADXL345_DATA_FORMAT_MSK		(ADXL345_DATA_FORMAT_RANGE | \
+					 ADXL345_DATA_FORMAT_JUSTIFY |  \
+					 ADXL345_DATA_FORMAT_FULL_RES | \
+					 ADXL345_DATA_FORMAT_SELF_TEST)
+
 #define ADXL345_DATA_FORMAT_2G		0
 #define ADXL345_DATA_FORMAT_4G		1
 #define ADXL345_DATA_FORMAT_8G		2
@@ -48,7 +56,6 @@
 struct adxl345_data {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
-	u8 data_range;
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -218,15 +225,14 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 
 	data = iio_priv(indio_dev);
 	data->regmap = regmap;
-	/* Enable full-resolution mode */
-	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
 	data->info = device_get_match_data(dev);
 	if (!data->info)
 		return -ENODEV;
 
-	ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
-			   data->data_range);
-	if (ret < 0)
+	/* Enable full-resolution mode */
+	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
+				 ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FORMAT_FULL_RES);
+	if (ret)
 		return dev_err_probe(dev, ret, "Failed to set data range\n");
 
 	indio_dev->name = data->info->name;
-- 
2.25.1



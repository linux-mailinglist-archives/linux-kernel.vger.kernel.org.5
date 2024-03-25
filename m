Return-Path: <linux-kernel+bounces-117375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FBD88AAA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4658D1F27DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CFB548FE;
	Mon, 25 Mar 2024 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnLm4ZfF"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFC280C0D;
	Mon, 25 Mar 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380892; cv=none; b=JJqsin+f1Q4pWobxt65/eg8GltXBJP8UKQiXM5yc8EjPijOzdeECBVyb6jFIBnDS9X4JGka/8DvBL9iF0M5Loh+sIuFBTpKJnWKh7eDKm8eXhWYR8tM2hROSHXyO9ajYcEt5N144fxvYDro2WVZzUB88dwtV/E49yAxBsPDPu2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380892; c=relaxed/simple;
	bh=MJxDtiNn0WiBHEqI4ZWGVPbhPTs1Sp2fyf0QcQ2WkZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X7HC+nOckICQV1o5rfyt/6uD61OUL7PTsvVHRY90aarqXf0EAzKbw9+y6aadv+PYCKAMVPhrFyuglcEusa5Jp2X3TzZMd5WuGCx0Koacjy1s+dUVzwmH3szbsMmDUxtQu/xnrFrz1Che2C2hGoZi3QaJCCWjJX+zKsCz1lXiQNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnLm4ZfF; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513d599dbabso5857062e87.1;
        Mon, 25 Mar 2024 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711380888; x=1711985688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q62qeE9LUbJvesqIjmh+/4XQ6lfIbcixIfyRLYsEjls=;
        b=BnLm4ZfFBSwup2deIHXm4nxXGTQ3dEEIRg1jhrpHnQrNpeudCQRb5pBnF7yWGr2Qak
         haQW27oGGBzD40S4yjG6DNOwPVWnakxlYQyqOdxFzTPGwmY2lvSnddjJBvyWBboXzQRp
         38YFGFXZ/4Xup1/dzaqoFTRzchy1rzfcn3BXj/pgU3SuEYZsT1Ltx7PibH57mHN1j/PV
         le7AI0e0YUX0GD5L1ApDjIjt/oRwQCX5flouS725xpr31ou5KgeCo484GknBkvMRhm7D
         4vW/F4ntlUBkH9QYjVFfK+CXvafUQ3ZkJwJ/V9UAjuksvC+sQtDmkvkfIK03f/WpvRyK
         B3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711380888; x=1711985688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q62qeE9LUbJvesqIjmh+/4XQ6lfIbcixIfyRLYsEjls=;
        b=V7mAW/1QKK90yrELS3JjiT1PwyC/zT0O2f/RBUR4m4G9wh2X29UfWRzvKjNndFb9bO
         Kq7pz6CT6VEBAQnFrbYOp07NLmhoJMVN0Q8q/ll4sJFEq7QZdY/fnttCtwydUrwYWi+x
         TPbHZUHNqYkGNGYxTCVg7AkowImDs8C7dLhmIX51RTC4r6NSJ9z387uulS+FK34piJlv
         xJgCkyv9z2OMr9hx1ePt1h6YTzOtVSfZ7r6JOmMPy0a+nUQWdyPlh35xBRkNUTSak8Tl
         khNLqfJw0fkNU7V2bISFYEytSl2V8V9zqXolVZkK/OMD116z6sF+EEukKLFzlgvle22a
         OWgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9VY0eLCt+sDLqd0me0FpQEFD6Ge/OacFl1TAM2vi+5k9w7OPAIU0p8O7LidpRSdwfm7nG9iAhN3CaA2BLmGWOJDgnInXqLKzl3hdYy1afrQ/xMMqoxBzQx0jjzytPgPconzoUGKtjLg==
X-Gm-Message-State: AOJu0Yy7wDqEd0yThLkfWMTFREB2/f2TBPFY8qrP5d2zKjh6O/vX6+zb
	zTMcdOltMI6JO0q1NGBr4OXWWc+du14av0Vo/PQpb6zIA0Vt4My/
X-Google-Smtp-Source: AGHT+IHN+BG2YwuZj/MlFEd8j2tNOM2Ms/3d6dyNmISJAqVbq2i7+PiP79e2J1RO3Pbue+Wf0fvWSg==
X-Received: by 2002:a19:430c:0:b0:515:9ee7:ce45 with SMTP id q12-20020a19430c000000b005159ee7ce45mr4845126lfa.49.1711380888346;
        Mon, 25 Mar 2024 08:34:48 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090626cd00b00a45200fe2b5sm3142382ejc.224.2024.03.25.08.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 08:34:48 -0700 (PDT)
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
Subject: [PATCH v4 2/7] iio: accel: adxl345: Group bus configuration
Date: Mon, 25 Mar 2024 15:33:51 +0000
Message-Id: <20240325153356.46112-3-l.rubusch@gmail.com>
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

In the probe function group bus configuration and the
indio_dev initialization to improve readability.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index be6758015..469015e9c 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -218,22 +218,23 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 
 	data = iio_priv(indio_dev);
 	data->regmap = regmap;
-	/* Enable full-resolution mode */
+
 	data->info = device_get_match_data(dev);
 	if (!data->info)
 		return -ENODEV;
 
-	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
-				 ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FORMAT_FULL_RES);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to set data range\n");
-
 	indio_dev->name = data->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl345_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
 
+	/* Enable full-resolution mode */
+	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
+				 ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FORMAT_FULL_RES);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set data range\n");
+
 	/* Enable measurement mode */
 	ret = adxl345_powerup(data->regmap);
 	if (ret < 0)
-- 
2.25.1



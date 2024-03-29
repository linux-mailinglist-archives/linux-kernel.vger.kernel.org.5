Return-Path: <linux-kernel+bounces-123918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF8B890FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EE028FCA9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134D71EB20;
	Fri, 29 Mar 2024 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWZWrkNp"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F3E12B7D;
	Fri, 29 Mar 2024 00:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711672844; cv=none; b=P5+ha4exvqF3yJo8TmDR2Q11xbMWmBTStdAzuxK8UvbKGxIhCizoaVrqUTv2z0WSv3zqh7/kcXpHOiIqed9Wu6LkO5/FJInkTqe8yVoJ2uSpnNLCdQmGOtFzS3jgM1Z7IvfmaHDNPsac12ZZIyzGJSuVKnQUhPdpr7UVkziph/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711672844; c=relaxed/simple;
	bh=aP8XoWDKMAqyC8zqtB8kZRrILNh4BKvcnm/KEBjATvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UQuY0MINFsuN3C7O3fCl9fi+1k3YW4bzKbOwZ9MHkeUqg/hKb9vdC5IqAIlG4NtdSqbKaARXbVJED8EHVNkw67N7ArYpJMJVK4ClOPsYl9UBZgZYdaYzNR3Ad9se8GpxeUSBKkAlJBSZkIT57E5mx571NSyHcJPsnHo59j47Fp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWZWrkNp; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so1897738a12.3;
        Thu, 28 Mar 2024 17:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711672841; x=1712277641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QESGkji1riXQtsL/9cuxNH551LD8cpn/5+qi4Dzrz2w=;
        b=iWZWrkNpmBTSJMwlmtmE9mSdYbN1yJoF41VkQXlv0WzXMU5YXbT2giMZcjR+PPLV1E
         ElGAgjK3Mpglc8ABZMxhsGT9s9EezFyaWVWDabrxjnBU/bLp53w4g6ZY2ZdGTtgqkmmv
         DVOJUl3c3GOBVr3mzmtgNobpzfWavdpgfXfis1aNf8LKgc/qRyeE0abzRqIazFzgONy2
         T1eKn9KacLLbOkLtQsjun71H+g8GBA3rnE4idrNlz1zJ2YLOvNRyw+hMsaTOxgjo42Fm
         GPyODoP6SxNVULV5obe4XNnibmkIigNERi6xYHLJVhie/eS3UmsegyZmNJUVAmwLsQl7
         /pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711672841; x=1712277641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QESGkji1riXQtsL/9cuxNH551LD8cpn/5+qi4Dzrz2w=;
        b=QSlLXcWjGGcJFCuWiTvUOEgGtW6sBpvjuqy3x533/pA2eQctQEE4/mozZCxbrDa72x
         5xrf74sgPyTqY1PtJi8ql+KxmrtlCSV/KQ7mdtjCII6plSFOcIS+K1GvvDaAv6V4hZnJ
         jf7bgI0fKZ3aQEqJ264MFm4qlROtVFEWx7mNVGqxoZ3DX0Qrb+nhsYOzHlPPwqzCkLt6
         OxK9r7iyeAy90qzmQO9aCwItYXEhGB7ZOlI2ce33zp9c9SlEqgb1B+UhP7A25sbFVG9Q
         DXmMXiVSSywXstwIQkvcwy3aqGDPpyS+ctV1juMJ0IRDq+d5CBeKaGk3d6fDCHgZ4j3b
         4R+g==
X-Forwarded-Encrypted: i=1; AJvYcCVKczW9c8iHOXRUTtBlCuGL3E+TRm+Nm7T0o5qM1s1AoKqQ+4k/RGoCJK6MwyH0UFohY20lCEXfW0GlUPElm4VXOYVuqRZwE3pP6hbwIRjPaOvCyJbGon9TgV8okBkzUI0upBD3uUAwpQ==
X-Gm-Message-State: AOJu0YyEplnsrzxXnGL3jg5rVytRywKF/mID+Nyn+cWKQB558W/rXtd2
	FyLDJmBMyKYPhEK6VTLr46NzB4RYGNfgVi2qafcpgMqXkViddo4U
X-Google-Smtp-Source: AGHT+IFXJAwXscLH4CZVba7ouP+CtKrIp9U1Rk5TXtXcXr0nf3ZOqSH0xjPt2sUi/Gb5wA/j81oJ2g==
X-Received: by 2002:a50:9b01:0:b0:56b:d9b0:f1c3 with SMTP id o1-20020a509b01000000b0056bd9b0f1c3mr480751edi.39.1711672840911;
        Thu, 28 Mar 2024 17:40:40 -0700 (PDT)
Received: from 13a4f82a8f12.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id h7-20020a0564020e0700b00568e3d3337bsm1391679edh.18.2024.03.28.17.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 17:40:40 -0700 (PDT)
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
Subject: [PATCH v6 3/7] iio: accel: adxl345: Move defines to header
Date: Fri, 29 Mar 2024 00:40:26 +0000
Message-Id: <20240329004030.16153-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329004030.16153-1-l.rubusch@gmail.com>
References: <20240329004030.16153-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move defines from core to the header file. Keep the defines block together
in one location.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      | 32 ++++++++++++++++++++++++++++++++
 drivers/iio/accel/adxl345_core.c | 32 --------------------------------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 284bd387c..732820d34 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -8,6 +8,38 @@
 #ifndef _ADXL345_H_
 #define _ADXL345_H_
 
+#define ADXL345_REG_DEVID		0x00
+#define ADXL345_REG_OFSX		0x1E
+#define ADXL345_REG_OFSY		0x1F
+#define ADXL345_REG_OFSZ		0x20
+#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
+#define ADXL345_REG_BW_RATE		0x2C
+#define ADXL345_REG_POWER_CTL		0x2D
+#define ADXL345_REG_DATA_FORMAT		0x31
+#define ADXL345_REG_DATAX0		0x32
+#define ADXL345_REG_DATAY0		0x34
+#define ADXL345_REG_DATAZ0		0x36
+#define ADXL345_REG_DATA_AXIS(index)	\
+	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
+
+#define ADXL345_BW_RATE			GENMASK(3, 0)
+#define ADXL345_BASE_RATE_NANO_HZ	97656250LL
+
+#define ADXL345_POWER_CTL_MEASURE	BIT(3)
+#define ADXL345_POWER_CTL_STANDBY	0x00
+
+#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)	/* Set the g range */
+#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)	/* Left-justified (MSB) mode */
+#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)	/* Up to 13-bits resolution */
+#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)	/* Enable a self test */
+
+#define ADXL345_DATA_FORMAT_2G		0
+#define ADXL345_DATA_FORMAT_4G		1
+#define ADXL345_DATA_FORMAT_8G		2
+#define ADXL345_DATA_FORMAT_16G		3
+
+#define ADXL345_DEVID			0xE5
+
 /*
  * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
  * in all g ranges.
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 78ac6ea54..2d229fa80 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -17,38 +17,6 @@
 
 #include "adxl345.h"
 
-#define ADXL345_REG_DEVID		0x00
-#define ADXL345_REG_OFSX		0x1e
-#define ADXL345_REG_OFSY		0x1f
-#define ADXL345_REG_OFSZ		0x20
-#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
-#define ADXL345_REG_BW_RATE		0x2C
-#define ADXL345_REG_POWER_CTL		0x2D
-#define ADXL345_REG_DATA_FORMAT		0x31
-#define ADXL345_REG_DATAX0		0x32
-#define ADXL345_REG_DATAY0		0x34
-#define ADXL345_REG_DATAZ0		0x36
-#define ADXL345_REG_DATA_AXIS(index)	\
-	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
-
-#define ADXL345_BW_RATE			GENMASK(3, 0)
-#define ADXL345_BASE_RATE_NANO_HZ	97656250LL
-
-#define ADXL345_POWER_CTL_MEASURE	BIT(3)
-#define ADXL345_POWER_CTL_STANDBY	0x00
-
-#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)	/* Set the g range */
-#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)	/* Left-justified (MSB) mode */
-#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)	/* Up to 13-bits resolution */
-#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)	/* Enable a self test */
-
-#define ADXL345_DATA_FORMAT_2G		0
-#define ADXL345_DATA_FORMAT_4G		1
-#define ADXL345_DATA_FORMAT_8G		2
-#define ADXL345_DATA_FORMAT_16G		3
-
-#define ADXL345_DEVID			0xE5
-
 struct adxl345_data {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
-- 
2.25.1



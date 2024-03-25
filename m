Return-Path: <linux-kernel+bounces-117376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D2D88B203
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F524CE18AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111B082D80;
	Mon, 25 Mar 2024 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcOJ9JWS"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43904811F1;
	Mon, 25 Mar 2024 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380893; cv=none; b=n4zCYfKDq15U9+Q3lpYd+ftn3muefrlsj1ntvzzwJpw0qq6fUUSVZlaQDR0/4WhMzo3FFzQDcd3btEre77WpufwCbWIv/cMBefn7AbXORv2k310y7nLupsVkIdkr9ZNbn7bIbDwXo8s85558kd+U8xnbqFUYQ1GE0zcfinFHs2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380893; c=relaxed/simple;
	bh=+V8DFNWF4YEqwBXLncKDoMI1ttfk7hCpvo+Y4VoMUTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YBgxbs3RGCNccfpAJLMp2DXodAjEQ++XeoJh1yx5O/GZpQ8E0lYpuby3sozyReXALAju05ky2z7zBfj/O/t1AXgLNBPqH4UdKARx19qSvQToLQy+CjN5xkDgYO0cabgTYoPagkE/81ypzcRzMWOljdxqmLjrZCpLK3dgktymN4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcOJ9JWS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a47385a4379so462572766b.0;
        Mon, 25 Mar 2024 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711380889; x=1711985689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRyL2dhzaW6eUI5gOVnZcHnarOYXwzosHg6YqH3UA9A=;
        b=VcOJ9JWSkCj3qt2q6g4PUc12NA3+8AytBhnf0w730yY0Azo8VvXAdKDSdw6EqfDnf5
         eba4isRxopwtRW/waS7Mn9nk58BeBdl3c840ORMUnj8swts2Wx7ciTtlfyyniFtZopS2
         gSpK/K1WBBOKO/PYZ8rNC8NDc90RznWiA+4URurmtunpEKCyE39H4cLEV+2uyLctPfRH
         uRgatNG4UKHpb7eXES846jn8dR0FIyCqvqQ+k3L8mfflhTNJkXH4pTWFBC5v1OW9iDBU
         pkf8IoSKChXZL64njcrpKLgYDpHEc0TsMNadpuaPMyJ75UvsEE7DOjyh0MJUnr8r/XK1
         lF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711380889; x=1711985689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRyL2dhzaW6eUI5gOVnZcHnarOYXwzosHg6YqH3UA9A=;
        b=OEiY0mmPVrugYPQ6OROBlabPTPZJoAxyHlLp7Diba6hUFIb1gm+1hgnENCZCk5gDhu
         ajoCMq9pXt54VRCxPWawmNEMR96sj5We3vg+SVOHfzANMuO6bhs9fsMoh01UGML5I2Rr
         OgEJMpmZ0enC7zDnltrnOCFd/cwPP7IQtqPy6e3R69GqY7LJb8vy9g2EkVRKg/9p3jAu
         5zUEnOCWh6i2eHOAyo+q5AZBLwMRvKcLbDrhD6TT7dW2oJDnf1j1TKWPT4hflevH9tnI
         Ywv0XmHc5N9GPEWJl+vtnOQlYrOMhfusuw7WPm5xCzvO+PFX8Fj9D5frOqOqQK37ZXcE
         cEGA==
X-Forwarded-Encrypted: i=1; AJvYcCVJS4cwt6uUmxzKJGvEmAgaqBKphjnjH+7FARnUixDSF1BH4Sb6sza0taKt4QbU7DxfHxFedZcdIj5GVRtnrG7vNSX+mF7/Oi7bBf0n9o7MDWULScgd9tQ6ZFWvbKrYWMwpUI3GYa6SKw==
X-Gm-Message-State: AOJu0YxjSUgfjflk2L35Rcc+suOTyV4gN0/Bz+hdNLkkNaP+xEbL9De0
	uoUlxDhy5IbfsNVxVWxPnZnZRI8Fro1oGHrx+SpfuMRu9n1epkdK
X-Google-Smtp-Source: AGHT+IHbB5Uf3wQSMPhJiU5VVMgCO6h+Nj70Sj13mfvMZnOyPk8UqpCvkW9cUJQ7J2NOJpATfVxw9A==
X-Received: by 2002:a17:906:744:b0:a45:f9c5:3024 with SMTP id z4-20020a170906074400b00a45f9c53024mr5255862ejb.11.1711380889407;
        Mon, 25 Mar 2024 08:34:49 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090626cd00b00a45200fe2b5sm3142382ejc.224.2024.03.25.08.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 08:34:49 -0700 (PDT)
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
Subject: [PATCH v4 3/7] iio: accel: adxl345: Move defines to header
Date: Mon, 25 Mar 2024 15:33:52 +0000
Message-Id: <20240325153356.46112-4-l.rubusch@gmail.com>
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

Move defines to the header file. This keeps the defines block
together in one location, when extended by new shared defines
which then have to be in the header file.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      | 31 +++++++++++++++++++++++++++++++
 drivers/iio/accel/adxl345_core.c | 29 -----------------------------
 2 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 284bd387c..ee169fed4 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -8,6 +8,37 @@
 #ifndef _ADXL345_H_
 #define _ADXL345_H_
 
+#include <linux/iio/iio.h>
+
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
+#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
+#define ADXL345_DATA_FORMAT_2G		0
+#define ADXL345_DATA_FORMAT_4G		1
+#define ADXL345_DATA_FORMAT_8G		2
+#define ADXL345_DATA_FORMAT_16G		3
+#define ADXL345_DATA_FORMAT_MSK		~((u8) BIT(6)) /* ignore spi-3wire */
+
+#define ADXL345_DEVID			0xE5
+
 /*
  * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
  * in all g ranges.
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 469015e9c..eba9c048a 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -17,35 +17,6 @@
 
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
-#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
-#define ADXL345_DATA_FORMAT_2G		0
-#define ADXL345_DATA_FORMAT_4G		1
-#define ADXL345_DATA_FORMAT_8G		2
-#define ADXL345_DATA_FORMAT_16G		3
-#define ADXL345_DATA_FORMAT_MSK		~((u8) BIT(6)) /* ignore spi-3wire */
-
-#define ADXL345_DEVID			0xE5
-
 struct adxl345_data {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
-- 
2.25.1



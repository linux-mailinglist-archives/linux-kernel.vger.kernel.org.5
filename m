Return-Path: <linux-kernel+bounces-73522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E8185C3BA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57ABF1F232E3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D883A12EBD0;
	Tue, 20 Feb 2024 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye+2xP9N"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1876C94;
	Tue, 20 Feb 2024 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454493; cv=none; b=Bb2WkObviu0ub/f3PtNhpEejyagI81aFqTb50jwWDyV2P1Wshu+z9jFTHW3hogTVzz2KNTj2D0RYol3pJMPWSgzyH3UQGuvX0D5Y5x6CCMfyBvOeiaW+BWC39od2aI1x16/HjLwM2kVZ6AFjN1PWnUcpJZZi96nm7DK8Y5NmAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454493; c=relaxed/simple;
	bh=DwSB6eIUrVV5+VdOy3mihW0HfnTmkbLesBD6cSOFYUw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cpApiiS21V6GLOlJcgd0IyThs+ekwcCULJpu9wb5E7Gvi8Bd9dq2f3cikyxgzOBOIQDpv7VDhKtQJIF8VtlbKWIQGnKkjeZDKXMIsAjK8rdB5OVo6l2hDZJpm7UOW7FzyJu/SYaWlObuxjytnpGJm5VuYLVmFMGBgz7irwF9LlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ye+2xP9N; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563ed3d221aso7107232a12.0;
        Tue, 20 Feb 2024 10:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708454489; x=1709059289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1owq7Fy9RtBGgkYmyx+BQD0R3AB0m5IEudYK4GtR2Mw=;
        b=Ye+2xP9NMgRCwa2r+PKU6SkLkJhsn/cn2wMazz5t2pieeggYGi86BTL6/Tectp8T9n
         OgMafTGLa8xC2yzDsJmXpOk4t7lWBYN40YJzK29fVRM2H0Wl/KgYtN9V7Fb/xMnZRRHR
         xdX/ffi3mVFPofkuLwsR+b+dOYCHDiEooS0TOHAgjp7V4Sxw339YqJShxUMmFqk2ANUx
         rv9F89GWNDO2YXOnVmsVXCOedhZFm8Q3znUDh6QxVqkMU3s0/muWNWBbrEpqz+bPbMtT
         mE3PVTC4ilR81giQrpbLU97sOn+ua+yWENBeK3nXTVfPhglx+3fKALD3JUCNz4smM/GU
         NYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708454489; x=1709059289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1owq7Fy9RtBGgkYmyx+BQD0R3AB0m5IEudYK4GtR2Mw=;
        b=tUP1mFWtv+fN8hKGthF7eLy+HgRtlunXL7bsMhGhmYtRcr3p99WFCbc3Ssezrx3rz3
         W18V3r89uftPfeeuPpRt30YECXkH3EOiso1UoYUo4H+Jk+5+zszCymG13HYe0Mx6PFT3
         Z0uSdpbyvz3USG2EE01XYPVOH3nwaa0uDDinGKjbTOxGh54uQ7BBbNrHDg2XzIVFow6y
         jt7C0HDH0ekssUyQowi6xe1slnl2gCEc3Q2xUYggLIpbyNSEe6WBKV/jlCF6DN3AVRZo
         H4/RdnnckKoNcw81zvir6c0yvhNukDwL4aw2UxJm32beFK3OKBtZ7b1MUDIw3kP9FaIc
         wVGw==
X-Forwarded-Encrypted: i=1; AJvYcCWpI12rD28pN0tBWkLZkEHwWKqUneGWhpeG62raZz9rBsYvvNU+dPXHe1K9aMEZVAsOEyRS2EAKEA7qe7/jqFpnRJXXqukoyIvyIFKvshBMw8CLvh0QxcAmNEa8nxv7DfVxrm8j7UcR
X-Gm-Message-State: AOJu0YzbRjb8aBNN+/WpTEY9QfS/MV9i90kRX9eL9sWD+nFHAW+KhxyA
	ujoE2L6qBcCtROQhrexjj8Do73g917FXaumm8+LlpOtectY1hday
X-Google-Smtp-Source: AGHT+IFjHdwnwUxKeWXHSiGMm1iXa1mDeBERgCFjP3WMT9aHIgdToj2cGLMD5jeV30pW7fa9u9YM0Q==
X-Received: by 2002:a17:906:fa87:b0:a3e:c6de:e5ae with SMTP id lt7-20020a170906fa8700b00a3ec6dee5aemr5152274ejb.0.1708454488971;
        Tue, 20 Feb 2024 10:41:28 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4de1:dcc0:a48:7f])
        by smtp.gmail.com with ESMTPSA id bm8-20020a170906c04800b00a3d9e6e9983sm4269594ejb.174.2024.02.20.10.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:41:28 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	ang.iglesiasg@gmail.com,
	andriy.shevchenko@linux.intel.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH 1/2] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI support
Date: Tue, 20 Feb 2024 19:41:24 +0100
Message-Id: <20240220184125.32602-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the datasheet of BMP38x and BMP390 devices, for an SPI
read operation the first byte that is returned needs to be dropped,
and the rest of the bytes are the actual data returned from the
sensor.

Fixes: 8d329309184d ("iio: pressure: bmp280: Add support for BMP380 sensor family")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-spi.c | 49 ++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index e8a5fed07e88..1972014dca93 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -8,6 +8,7 @@
 #include <linux/spi/spi.h>
 #include <linux/err.h>
 #include <linux/regmap.h>
+#include <linux/bits.h>
 
 #include "bmp280.h"
 
@@ -35,6 +36,33 @@ static int bmp280_regmap_spi_read(void *context, const void *reg,
 	return spi_write_then_read(spi, reg, reg_size, val, val_size);
 }
 
+static int bmp380_regmap_spi_read(void *context, const void *reg,
+				  size_t reg_size, void *val, size_t val_size)
+{
+	struct spi_device *spi = to_spi_device(context);
+	u8 rx_buf[4];
+	ssize_t status;
+
+	/*
+	 * Maximum number of consecutive bytes read for a temperature or
+	 * pressure measurement is 3.
+	 */
+	if (val_size > 3)
+		return -EINVAL;
+	/*
+	 * According to the BMP3xx datasheets, for a basic SPI read opertion,
+	 * the first byte needs to be dropped and the rest are the requested
+	 * data.
+	 */
+	status = spi_write_then_read(spi, reg, 1, rx_buf, val_size + 1);
+	if (status)
+		return status;
+
+	memcpy(val, rx_buf + 1, val_size);
+
+	return 0;
+}
+
 static struct regmap_bus bmp280_regmap_bus = {
 	.write = bmp280_regmap_spi_write,
 	.read = bmp280_regmap_spi_read,
@@ -42,10 +70,19 @@ static struct regmap_bus bmp280_regmap_bus = {
 	.val_format_endian_default = REGMAP_ENDIAN_BIG,
 };
 
+static struct regmap_bus bmp380_regmap_bus = {
+	.write = bmp280_regmap_spi_write,
+	.read = bmp380_regmap_spi_read,
+	.read_flag_mask = BIT(7),
+	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
+	.val_format_endian_default = REGMAP_ENDIAN_BIG,
+};
+
 static int bmp280_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
 	const struct bmp280_chip_info *chip_info;
+	struct regmap_bus *bmp_regmap_bus;
 	struct regmap *regmap;
 	int ret;
 
@@ -58,8 +95,18 @@ static int bmp280_spi_probe(struct spi_device *spi)
 
 	chip_info = spi_get_device_match_data(spi);
 
+	switch (chip_info->chip_id[0]) {
+	case BMP380_CHIP_ID:
+	case BMP390_CHIP_ID:
+		bmp_regmap_bus = &bmp380_regmap_bus;
+		break;
+	default:
+		bmp_regmap_bus = &bmp280_regmap_bus;
+		break;
+	}
+
 	regmap = devm_regmap_init(&spi->dev,
-				  &bmp280_regmap_bus,
+				  bmp_regmap_bus,
 				  &spi->dev,
 				  chip_info->regmap_config);
 	if (IS_ERR(regmap)) {
-- 
2.25.1



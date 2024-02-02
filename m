Return-Path: <linux-kernel+bounces-50609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDEB847B8D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E11B28BAD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04947839F2;
	Fri,  2 Feb 2024 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z1PCcK2h"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7269B839ED
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909511; cv=none; b=eIwhKnjMXqQAffuVgiGXEl2OqwnaoPu6+xnCQPkMYn4ND6xKKEXDBRfGKK2SwL7h+Yh2mDDDpCubhKgxAbx/Nmnc9gIRL2SEEVw2OdB2ZoE9Zs9kAlnK6zebwxWUAEUWwNSeHb0LpgPN7DW8lAEgfpUrMCyLrX0mbNNm8vxPWaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909511; c=relaxed/simple;
	bh=Op3qPrMY2i1ZY4j6pqonag0+3Lyq6QstDp2KxGm17rU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHJNKWK8CGEBgsC6XxiIBgnCKgkF4F7MXBq1kxVd6WNUtXssYTazyta7j3mFgsGu0uZDKC4hgis7ndSjsWuyliM3IrWe5Tm6uEbrQZyE2ZMzlE6946LpYLOfjOk+9jt+L9A76dT55V9/n/nQw5xRARaIlWHwRaKjNHYFiscbyrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Z1PCcK2h; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e1226b30ffso1359368a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 13:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706909506; x=1707514306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTiox0wmIDmYtPibh8OuRKBz+PUfxpupwELt6ygSWRU=;
        b=Z1PCcK2h+fLVkaESVVTUMQTnFY7BoPDZRPjXoFRwR1i2wlc6CBbDM5ljNzLjfmjf7B
         MKTUXKvRXPoDb+sZVWaTeV5psnQx/aEbkRu6PfrvWYVnUU/w8OTEt/QBrJVEj0Lg12+w
         8rom5wfXsQYu8b/tfP9TuKIGJh80TVhwYwafPQvNdDGbTga/+1w9U9n2cSP7Q6jASlAt
         R6aKd4xV4tWdZNGJwZYY+9GX2RHh2YamLBmZavzhO2SJ8t7C300NsW62TsbQuHyXISkA
         l0uMrn/rWminD/YyR6SDNxZ/uabEtwdPMxL8f/de8Nj+Bs16uYFuHnuyy9Ze4WVm8M8V
         g1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706909506; x=1707514306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTiox0wmIDmYtPibh8OuRKBz+PUfxpupwELt6ygSWRU=;
        b=VveZ9J5gYDCT3gqQS/rVZ3Ak72C+WYkevFTb3V0t6441cpYOGh1TK9Pcxa8qR6vRuC
         KsINxFaLdn8QqOVmXvMxic3V9ykqGjFdtWAs/hBhujpFddPZcQMlI2gxEGt/opM/X0mX
         b6lJeOyc/E+LBrzv9YcAaZHHv1PuYKxm/d8nTipxI+LoPOZ2Jc6odwbPvwEJ0eEN1VNH
         i/e/YIO0cX8ZM6RrzRLvF9HoV6CKbQhN3l78UE5DVmctjAiUdl63vXeJagjH0tNjEQnb
         5Stn8w1MGpLKHZPy1VbzSiVotMDxRz7wDRLpou+1wtZsnomFzcd3UzX3c0HAJXOut14P
         NPHA==
X-Gm-Message-State: AOJu0YwD0KK8UnE3PrAMR+J7PV2wcrCdgVJM9lC+vhzUPkkIIN3B8KUm
	KdwbA4JDTS0W1gdDgsIpAqPOaX5gbeNqWdNfI0s1y8jiiU1KoEB4KuzT9cPKopM=
X-Google-Smtp-Source: AGHT+IF/RpXFVoFqWWIIG0pDfFvczWwKaz4e/giUbEuIHIeDJ0mRz9Iqlzmzunh/fzRY5YZO2KLYUQ==
X-Received: by 2002:a05:6830:14c6:b0:6dd:e7b5:3eab with SMTP id t6-20020a05683014c600b006dde7b53eabmr9156231otq.2.1706909506443;
        Fri, 02 Feb 2024 13:31:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVcUgL/jIyFlGndm48vyhsjjQr+1u7IbAG4kn5lDwpxHCDv8EM7sWNymGJu9x0yYkYw0yKIANfueWntVnz1Mi8XbRsUwon5lTsB1lPhxHrkIoxousF6lRBrPWIShy6oLD/C6eoFzwVICEBchS//pFcreRHOJdEJWwTP+WyCs3/3Y9Mxj1md843UjuYuIoKx2HEsodxdItUSVvs=
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id q23-20020a9d7c97000000b006e125aea5a3sm545994otn.41.2024.02.02.13.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 13:31:46 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: axi-spi-engine: use common AXI macros
Date: Fri,  2 Feb 2024 15:31:32 -0600
Message-ID: <20240202213132.3863124-2-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This avoid duplicating the same macros in multiple drivers by reusing
the common AXI macros for the version register.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 9ace259d2d29..6b0c72bf3395 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/fpga/adi-axi-common.h>
 #include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -15,12 +16,6 @@
 #include <linux/spi/spi.h>
 #include <linux/timer.h>
 
-#define SPI_ENGINE_VERSION_MAJOR(x)	((x >> 16) & 0xff)
-#define SPI_ENGINE_VERSION_MINOR(x)	((x >> 8) & 0xff)
-#define SPI_ENGINE_VERSION_PATCH(x)	(x & 0xff)
-
-#define SPI_ENGINE_REG_VERSION			0x00
-
 #define SPI_ENGINE_REG_RESET			0x40
 
 #define SPI_ENGINE_REG_INT_ENABLE		0x80
@@ -661,12 +656,12 @@ static int spi_engine_probe(struct platform_device *pdev)
 	if (IS_ERR(spi_engine->base))
 		return PTR_ERR(spi_engine->base);
 
-	version = readl(spi_engine->base + SPI_ENGINE_REG_VERSION);
-	if (SPI_ENGINE_VERSION_MAJOR(version) != 1) {
+	version = readl(spi_engine->base + ADI_AXI_REG_VERSION);
+	if (ADI_AXI_PCORE_VER_MAJOR(version) != 1) {
 		dev_err(&pdev->dev, "Unsupported peripheral version %u.%u.%c\n",
-			SPI_ENGINE_VERSION_MAJOR(version),
-			SPI_ENGINE_VERSION_MINOR(version),
-			SPI_ENGINE_VERSION_PATCH(version));
+			ADI_AXI_PCORE_VER_MAJOR(version),
+			ADI_AXI_PCORE_VER_MINOR(version),
+			ADI_AXI_PCORE_VER_PATCH(version));
 		return -ENODEV;
 	}
 
-- 
2.43.0



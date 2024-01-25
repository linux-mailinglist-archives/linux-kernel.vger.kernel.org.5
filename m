Return-Path: <linux-kernel+bounces-38755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CB983C569
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44AAD1C24734
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7A76EB45;
	Thu, 25 Jan 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBTOpaF7"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF975745E3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194220; cv=none; b=YxOiVtTfH3wn/QoG0kFbuKbO02m/2JDHRKK5gc5xg6aOYRW1xhdhY8dX5rvY0CfAeLGa+QpXZS0NM4QYDtbjuMBlG5MllXAgLsIJ6ZUgWCIaqKb0qDGlUfjlCozuhpLXItK+Hs556EghR6Z7llf9OY7uMuvvo+eh8Wd7GVXV9Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194220; c=relaxed/simple;
	bh=wja4sjDZUzyEJmTYDZeNeJO4ez4z4bixbTFjT7SJ0h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlhGcdGLSeST2H7RdwPaVuW/UQ9Uco6vuvl5w8xQ0Q/9uMx0N2YBV6Z+SoznqXhGEYdQSueV/lHKwysbcB/MQnLS+f4Xo0s7eUoU9moVduN+XZIoLRVlJ1ThOYs+1hX4JcBbvmvhiVbf/Kz3+fwfTZKzcykAwmhETEVlG31D/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NBTOpaF7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so74513325e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194216; x=1706799016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2zGHL3l4HfFHILf65OAbwjVhYLd59O+yJnAHxlD6UM=;
        b=NBTOpaF7eeh0TPXlKqetNLy4En7VUv01JEA7geLtjIlbJ5KIpDYfy59qRgp2uedpLj
         V4SlkiZkPENc/uyHDmbAiBv5w85hniRZp2ysZS+d4U0go2g760lXxETKdNCfcIvDZJq7
         XUjDf/MPVb125HZ6beZyonNQ2LrA/MAtj9HlzX/Hh9SIpoXacLsKKEsWa/YWBQqDc/Eh
         m/ChNf1OFOFvI7aClLQ3agVREUk7CRO+8r+uVRdtjBjqplYv4rIaMUCgG5GknWk0mUHV
         CRNmVHs13Kc9Fzbi+BGuwqsz7LOTk53n0ikZjQuJOJ70/8+N0DjInJ4qBuCm0Lqf6hWA
         WGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194216; x=1706799016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2zGHL3l4HfFHILf65OAbwjVhYLd59O+yJnAHxlD6UM=;
        b=YMR45zrXhSsN4UWl7c8QpcZKQNt6NuZkIZW2BO35Bbko4AbOrXDssG1+7kaSW4AT5/
         la/faGYlYWpgrb5Fwl9cX28QQWi6fUgwy0h+l1wBhOOZE7Mzg4enDu9aPtP8AMrpXq6I
         unXHVKk7SrPakpAB8QremWFIRF0WifF3T1smusM8O9oDFRy3LQsNw+MrTEEAo00TwrTx
         JvySRNSPYOvwwGaNOuyaeXrD756BN3KwHVAnPRfy8oVLKkeA7XJ9IGzG7Jwk3A+6OCYS
         21QANI63hCwYhu6y5Rdsh6+Tm+Uf8A/dFTTqNjMwIvcGvGrAUxba3W34+2+T28LN4XIY
         /9rA==
X-Gm-Message-State: AOJu0YyVQXZyg2k0gsmXtjeW5A3vSJNlLGxCMJYizNnGAbEHY6v0SZ1g
	O5/1coFmeh4xABb7DHZhZO1tOg/CNsPH0V7VcMfrpWBSXCxKktd8tIZfJSWhl9g=
X-Google-Smtp-Source: AGHT+IEJ1CIdTrTRD4BA8d8gYFgNBWkIAgKqFXH8Q364GdBqOQzM962Dg8TpAX/PiqTFyXyRbfeI3Q==
X-Received: by 2002:a05:600c:17d0:b0:40e:5562:bcda with SMTP id y16-20020a05600c17d000b0040e5562bcdamr513612wmo.155.1706194215945;
        Thu, 25 Jan 2024 06:50:15 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:15 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 06/28] spi: s3c64xx: sort headers alphabetically
Date: Thu, 25 Jan 2024 14:49:44 +0000
Message-ID: <20240125145007.748295-7-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125145007.748295-1-tudor.ambarus@linaro.org>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorting headers alphabetically helps locating duplicates,
and makes it easier to figure out where to insert new headers.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index c3176a510643..230fda2b3417 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -4,20 +4,19 @@
 //      Jaswinder Singh <jassi.brar@samsung.com>
 
 #include <linux/bits.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_data/spi-s3c64xx.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
-#include <linux/of.h>
-
-#include <linux/platform_data/spi-s3c64xx.h>
 
 #define MAX_SPI_PORTS		12
 #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
-- 
2.43.0.429.g432eaa2c6b-goog



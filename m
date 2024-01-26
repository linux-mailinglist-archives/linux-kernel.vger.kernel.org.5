Return-Path: <linux-kernel+bounces-40417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFC983DFCD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B5F1F22497
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4B124212;
	Fri, 26 Jan 2024 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sz0euFSo"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA0222EE3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289370; cv=none; b=WVxafnRED5InlxE3HkxRpdq+p2XXHkQlE5uiB+gQmAExO3A8eTqvhBe8JmnHrcgqXc4OfRletYSGT6fo6D4vZbKzEyqlhAhhSSaKEzcp7mRplW1qc2PSN/cmZqqv+bS8sHw3gdgT5rLT/vB/Penbft4qMW/AiZ6MGSjaaxo/g14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289370; c=relaxed/simple;
	bh=bGD0Z5hPEY/4y19pgklQ92T/GvTwYYstRxsthohCGMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPpojwKfwDpyTg27wz6vInmL+Bg0Fs2nfsB60T8CUT654L3ah9QjWaZ1Fxyl595GohtbDvAvuSXJDqr3Gblu2YoKsiT9GZBnXXpZiOhlJ0t2bHuhQ/xAtiduPYSPuofRgB0yon963Molm+TYHRUoKyv8fUlRNaQ8qaO7dhuh/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sz0euFSo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40ee705e9e3so7018355e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289367; x=1706894167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVq9gzGN+1aHFWyNtJAgoaKp9sfSAHeIW/0R0QyQQkg=;
        b=sz0euFSo1tA8ZuAwZ/qaaVEGDTR64Vio/AYZqgMBmSC0W7AYL7EVcWDCfzQ0/KlPJE
         d8EFOoE+WAbi+rvAk50257HRG/0LkPfIXMQ49LwnVdc8kiC7jCYtB2aa44rs/D1YK8wA
         GMy1sRvc3BfPrBkea883hS2QFpGl4mDk5gX5jHpsru964GVM8y1WhdEQqzdH8vJujPTO
         QuKWF5y79TqpGVSFRn8KD7OE9mgBzTjokb4OLkFRcJn2oX7Zt+zi8x33zFBrOGy6Vxx6
         cS6/JGDo2YzPeFGXyeitJdCVAVgSFf81+hdF3OI5gcqQTCBEUuvMkX1g8XLJ/iElpe7Y
         067A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289367; x=1706894167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVq9gzGN+1aHFWyNtJAgoaKp9sfSAHeIW/0R0QyQQkg=;
        b=UxJVkdZLgIShmjmjJ9LmbV/+uH2JXS5+Hm79qM81nh/xVy1xEBmUMFs7jlcjDLLkik
         TNduqec2fPapzQkeNaXQxPJ0uwSgPJnND2rJbjKYbpcgpxmoYdYyC3l5vD1kqTMdPVVW
         7koRbZbdmZNVCI0uwpkzmVRGy8lqtlRIbV/A3rMpdK9MPl/bOfgWTfaxH6zuEL7lExOf
         rZ5AS+Su7aw12dcPx4W7aSoUz6F+4O2zUdI+JHUGnZFDg/+tBlBpPjmf/izun+FPXka7
         pnr9Mq7T2HZTNRnfNo01NL9MiTICsFgY3d0hddYfhVYId1KeqF8ZaoIr4TyfQ1pAXqx/
         1hHg==
X-Gm-Message-State: AOJu0YwynTj9m4dODInnkeIoITA6ZSfXhIH9WGi2ofglxzhqLatyS7eJ
	wLn4XXeOB11pjjg2U2ABUKJCVcpcaBZdVOpwpbNo6JK8oSy0B7dMpyq9Id/Mr6s=
X-Google-Smtp-Source: AGHT+IFVRdh+nTto07hFuQ0RqYhrZMrRuBlmG3jqU+FgxzdxqJtLZQQ0bXMJzggiSnO7a4H5ktlVvA==
X-Received: by 2002:a05:600c:2146:b0:40e:e241:9347 with SMTP id v6-20020a05600c214600b0040ee2419347mr87421wml.85.1706289367150;
        Fri, 26 Jan 2024 09:16:07 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:16:06 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	jassi.brar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 15/17] spi: s3c64xx: remove duplicated definition
Date: Fri, 26 Jan 2024 17:15:43 +0000
Message-ID: <20240126171546.1233172-16-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

S3C64XX_SPI_TRAILCNT brings no benefit in terms of name over
S3C64XX_SPI_MAX_TRAILCNT. Remove the duplicated definition.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index dc779d5305a5..e9344fe71e56 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -115,8 +115,6 @@
 #define S3C64XX_SPI_MAX_TRAILCNT	0x3ff
 #define S3C64XX_SPI_TRAILCNT_OFF	19
 
-#define S3C64XX_SPI_TRAILCNT		S3C64XX_SPI_MAX_TRAILCNT
-
 #define S3C64XX_SPI_POLLING_SIZE	32
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
@@ -1092,7 +1090,7 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd)
 	val = readl(regs + S3C64XX_SPI_MODE_CFG);
 	val &= ~S3C64XX_SPI_MODE_4BURST;
 	val &= ~(S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
-	val |= (S3C64XX_SPI_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
+	val |= (S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
 	s3c64xx_flush_fifo(sdd);
-- 
2.43.0.429.g432eaa2c6b-goog



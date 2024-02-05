Return-Path: <linux-kernel+bounces-52645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD797849AD9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686C2284B61
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439AE3E486;
	Mon,  5 Feb 2024 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LLBP+mGt"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD0833CD4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137135; cv=none; b=pJnDGOCVHIdDdDolSjz7m1SnqNShH0/KQf0l6T+OcDyG3hFteDqSGC+Y5z1mLq5yF0wnxGLNt6APLJHohpHwgSZUaUzTDTI4F7/EKauvVUbwbefffqXMzf6KP/cR0GtANQe00aquN/b9PxGqURUa9RWS5SAzgVWGuJoHOCDcsH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137135; c=relaxed/simple;
	bh=nMWHTWDw4FSV8N1BenWt9bH//miQS2pEnl43CiMUQ1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcPRegjHRWqVPeSjEoIAAVkbiiSsH58ZGJ0FpV+OpbI8xXsXr0uL7Q6L5/Z/eddElv40IR8J2/Vd0fMVytS4xPlLYMyFny1iLnN7Y2Xivi+OMuEChV4OhxKnvaf/Tj7r0nR/24YH3sBQpe2NqyrIAqFLHzaFrfGFw4ij9l3omz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LLBP+mGt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b2ee2d1d6so1233571f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137132; x=1707741932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQXkAU+74DrdhIBCBHKX2MNDRgI/UgoC8DKW9ZMunl8=;
        b=LLBP+mGtvsPXlZTkgRDGKNLgTeM2KZMJxHpdMRNYmtF6WbF+/0lgpCwwvuK7tTdszg
         pajfrOsMFF63xL392rkiGXf3Txgl3B5WiKII87tqKqoTU+cAecTsnY8ORQW3gObU5I8e
         mymok+Ngh6X7OkGOsGs3grCjkN/0vdSDUBEI6BZ0liCqSu2ALpjRVMgK6HqZo3nnNI/P
         zPZgzjma99WPpmysSP+FZJSv6rv+IlDN3vtWsKCBZsdF/iCXwUC1kqNZtlaNQXL1UfS2
         rwXVaFBJItONKVJ8+9pcxOjI1uulUI+F2NmYZYXrQ7yRKbIEmQVP9+Maxj7GlXh5pg57
         fOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137132; x=1707741932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQXkAU+74DrdhIBCBHKX2MNDRgI/UgoC8DKW9ZMunl8=;
        b=HDkku3D0qn0LzQbSP6bGx/XVynDEHBRLuWFhGOtD/F4LBP4Y+3Ge5AsjNl5kqF4qBK
         xqWzATf/FaKzrQZ2u0oCabnKyDJoKlsJ9l+ulsL4nodJoBMm2y5ORyKfGaKhTcNzi1Vh
         t2YBUP71PT9ymbWHfJAwXQlL1yhYSKt1FdqHkG26H1cItlv0tWk6Ib8DIeDe2EerfcYv
         /wr1T4w51yMQJBDGKTSOeJrVZpV9ZSbvSpZ7weF2rxCd8qcKLN+6diYeFaKLEvyPIC7u
         VCVoJh5pPMBGWhNvA0fOw82gqIs+w1sB6p8NrHC4HR0ue06pAqwCZJ8AAPSGtPVFZ90M
         njkQ==
X-Gm-Message-State: AOJu0YzrNfZCwU6MgLpR5AEHCeqoITPZ53OKQvMYExaGdaVd5rAZxNTy
	nPCR8K1zTJvRKHtMoQ6mr8RbjZxVgzahU5qwWZ2EA4j2qUPbP0NGsEuk562rRas=
X-Google-Smtp-Source: AGHT+IF7w0SrhbwiPOGLZfv8BIa8of6H+8D1PRONLjMNE0XBKdpEovxHCLmvEEYujDtqITnemVr/hw==
X-Received: by 2002:a05:6000:1ac8:b0:33b:376b:8127 with SMTP id i8-20020a0560001ac800b0033b376b8127mr3215935wry.54.1707137131953;
        Mon, 05 Feb 2024 04:45:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX2qttf9AlWRBYLbY1d8gb8YqqL+/qbSPDmU1x/m+yaCWDvy07L1ROL3wauST1rGVbRb66EjPIOtlB4n9urmuC6jc87wSzy520b53wDeu2QKN5XqjMaIu+PEGXEtn2PsEEzukAyU3GBbZ6Sh3d1fbai9c99q0GXpW16SJhUi83MA6NNr9cmF+rJT4XDUjW5qAFbK9R8q34VF+gfJsgg7eRJXfTPV1PUwy9A0lDg73R8jnORoZs/RgQ/isCVKdR5yhkorP8qgWX1fPZZns0wex1myEuPyXCjGY88FP1yYOXpvl61hB+5ajhvUFWloaH10FTY6sjpoBbeyXa9UIC1FFORmZLspdFVt5U5PcTM43LzYsuLRANG5F8KTV46cse58Gk5Es8sgGXJjzTw1u2dCU+r+KNu3FOyvQDYTy3HxeCFEIupExIgi3oKRP7Cb/h+ihjduDAV6bGa0+o0EHVLO9kjnYGia/OhRedv/6a3n4v0eIkr9EqK8B2OBiJUhQ==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:31 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 15/16] spi: s3c64xx: remove duplicated definition
Date: Mon,  5 Feb 2024 12:45:12 +0000
Message-ID: <20240205124513.447875-16-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240205124513.447875-1-tudor.ambarus@linaro.org>
References: <20240205124513.447875-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

S3C64XX_SPI_TRAILCNT brings no benefit in terms of name over
S3C64XX_SPI_MAX_TRAILCNT. Remove the duplicated definition.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index a103d9e125b1..ed0b5cf8fb4d 100644
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
2.43.0.594.gd9cf4e227d-goog



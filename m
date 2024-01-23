Return-Path: <linux-kernel+bounces-35541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FE08392F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EB8293F66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040175FEE4;
	Tue, 23 Jan 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i4ivwGI7"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E465FF0D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024074; cv=none; b=UT1jnS7rkhpvm5qMQproKOGGHUk+NXEu3sPCxFXXeqGyFn/UCeQcIbI3TVhJbB8Nil0vQFGufsLnSwJkbwo0pTk6UHO7Ytl7mpzDBo26a7dS412Ttm+qTmh+EC5lqWN7xETxqREHJjyvjXQHCS9nUEFUiAyeEQpcfrX5+DC4754=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024074; c=relaxed/simple;
	bh=GYq0ktoBx5eIoBEt2IxaK7Hm43PmKkluplSV8nDXwcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ms/heSq7eTlPwLU1QelLCWf3buFb2cp9PJF9tjDktSPgp562L5T00+KZCZrJnYJ3rsjGeGcQ6DB3/FD5q4XnIjo2UYdUM0xhGYYcXUwjgw6Cca2s5sHEmCNszB6u26L+DJ8twahTcczoSclHstxfnmKuXEl3TQo4bcJXmxjYDA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i4ivwGI7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40eacb6067dso27104585e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706024070; x=1706628870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUhqsvib/uXsB8/ZG1ztFE4b7a6LgsyBrst5iQF/X8M=;
        b=i4ivwGI7zKVr1oTIleGQIJnnF1kdVhXVV/rkyReyZhIQukxApgt3GNfs4V0UO9scKA
         +vPl5R7cW+wPzMkrww5KU0NOZNR4nVDBeNvKywezW/ZAoDqWqdjewE44sQiWaph8kkzv
         GyFg/YGsUAxFTxyg2pw9KlKWYnegzpyDto9Fvk6AxwJ6PgQSNY/UEsHtzs+NdvfQehTE
         dEcdSr/Jii59uml0+n8iAkKLfBYA0+o6Yk3Q1PdrKkj8+wCSYjxOJ7SBwaAg7EYnj6uX
         S7G07WcLGHQaa4WdtD7rsx5hxCldV3pc1WyHDCGxgJYZ56oPFOjdxp3zOWoWPwxUwxf2
         dBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024070; x=1706628870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUhqsvib/uXsB8/ZG1ztFE4b7a6LgsyBrst5iQF/X8M=;
        b=w/i/hU6cpM0msoYur+8kc9HhswY8wS4pDvTui8NrQFxQKd5NjyrnKD0wr0CXFUMz5Y
         iDumYscCiXrLTKHMwWms82SDmLBC0KPMGmESfa7uaECSL9QNe3gcmnb2oCFoCq939I2o
         tZyfRmFqtPClMSL45JVuiWt6Q9zolerNC/ujnwXPCFOcuL4MqswZ6KdoBy1HxPalVOdC
         3Pe0cnEsKAwDnRWSNNZdzfOwdPNGOeAZMeSuCXR0LzzCVGDk1zOBvI1vRhgMqTsrQKeu
         Jpyw0EE3nFBKsVs8Iw5YSJ5KZdfUv5hsADcStkjpc4vEVIRIDyBUeh5MWjOHONkRAbjM
         9CAA==
X-Gm-Message-State: AOJu0YzRO8/gN1oNK01vFGkCkQvbTJ1eOgWm0s/WK3qcq62aQGutmYuw
	AzXWwndiuyOUTJ74XNuw0H+FqJiYBcMuqLJm4nPmQJchVkHOp461Poccl5p+5HA=
X-Google-Smtp-Source: AGHT+IEUQRFIekgMzpx0cR8sCCVG3w5xgk2OePoUsW4Y1C3evA/H4sd/SqXvBEWXjsocAfm8duQg6A==
X-Received: by 2002:a05:600c:1f8e:b0:40e:50c6:3b88 with SMTP id je14-20020a05600c1f8e00b0040e50c63b88mr370700wmb.142.1706024070623;
        Tue, 23 Jan 2024 07:34:30 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm42457536wmq.12.2024.01.23.07.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:34:29 -0800 (PST)
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
Subject: [PATCH 06/21] spi: s3c64xx: remove else after return
Date: Tue, 23 Jan 2024 15:34:05 +0000
Message-ID: <20240123153421.715951-7-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240123153421.715951-1-tudor.ambarus@linaro.org>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Else case is not needed after a return, remove it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 9ce56aa792ed..db1e1d6ee732 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -406,12 +406,10 @@ static bool s3c64xx_spi_can_dma(struct spi_controller *host,
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 
-	if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
+	if (sdd->rx_dma.ch && sdd->tx_dma.ch)
 		return xfer->len > FIFO_DEPTH(sdd);
-	} else {
-		return false;
-	}
 
+	return false;
 }
 
 static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
-- 
2.43.0.429.g432eaa2c6b-goog



Return-Path: <linux-kernel+bounces-35551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CEE83931F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5F928660D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25A6629E8;
	Tue, 23 Jan 2024 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wLxZgVcA"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF2160EFF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024082; cv=none; b=PgpUGH4C7WVx4+oHunkaao8lnGqjCdHtM1dDZkBTCFID0fA6Jwmlv9/I8d1HpiFmGRlF8eWNymOud+XkcfynrH4lGldWfU50U7wXxfMkl6PxPkwvrt9LZtT9kBNNhESc628/KUDYDrOGeVqcBmk5qsacPl3QuT/BHqa79gKSW4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024082; c=relaxed/simple;
	bh=aiqMUmyEj1u57UdPoECEzznrChPaur9StHF4KTgwvWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEqnPZ7cbVs+y6qxCNYH5AKSj2RXWc8ycWaWszg8urbeqTArN5q9CXWeLLFvqW9/P9KvarhHO0JH4pQd0GueO771gVN7SaONHoSIly+87K3V0HgqXqHI+Vb0bTkUnZ8opfhaP5FiVibZNqBEHJVv71iJOHlZ3ZqQXdND8PKIA28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wLxZgVcA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40eb95bd2c6so10517155e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706024078; x=1706628878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDcK5S8n/PLxtzPm44TTZV7bPj0wDFTndTNX2CSFLe8=;
        b=wLxZgVcAzEzLXYnZo3wMx4EiIwNbWUOpk4oYdcStPjgJDLfN5TbGpp1zylFNuX8TdN
         Db36L648Cf3roYfiJ1A1i7gwDg2Hv5VVSxqvC0wwxwL75h2GASLI0k9gjcjjRbWQ2nHB
         X5jfjCXpIIhFG5Ss3uSBHfv0y73WzW0biTTPD2HOZ3wjxYNrepz87XkA8RH2es7u9VD1
         UCGzVVqWjIxlMCox+U/v8u0OqF8JuLghvCwguFkDJmuMa33EYqvirXb/GgUMgZhajsF+
         MbYV6Z1UfmF9WdTgreVjIWwpD9c6E8pb1l8eK7oSSJeRXiUNKtqBLSlM2GS1qsfFF4Uh
         Sshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024078; x=1706628878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDcK5S8n/PLxtzPm44TTZV7bPj0wDFTndTNX2CSFLe8=;
        b=VRRJlh4X3LeHhY7TntfITVWGlA7ze1Kv0jkotowcwBOWfLgVor+3v2FuQp9/3CGpow
         9SS72Sv6vwLh4V17Jht11gmAiLr7oUIF4D64n97zZMWjnLakbYIanJp36JzLAURj47lx
         3HRWUHGgS0QUoJnqWYWhMjf1FdYPVpXwcFAtM7Nmqq1twI2KDH4lrgWKC5Rjcw3Muzua
         KAapPJSnPjuWtuEdvRj9sYl1rjFFjwsbp21+YwlV7eMRJpqGfk63ZWKX07T65OcWi7ih
         VutfqBSwm/iNJkIG8at1q9oLvVYjFzqlgnhdPezkya8ab8hkeZRvaRd4aarNHXXOM2j2
         0ksQ==
X-Gm-Message-State: AOJu0YwNmvOaxK13ZbIhX/5h+7fbP9hQ5Xbo7TSWylCDRqJtF/952f9R
	qde85z1bSzrTIfLNVSr/6JKwDap09EcSZV98xbm2kWgLNdFPLFbFgzkv7nGObWY=
X-Google-Smtp-Source: AGHT+IEaPKuKYQ2O6yA2vkn4qNMcqnTA/hNm86+45dMXVIcjSmoweGA6oIQ5FlKxetXppti+/C/LhA==
X-Received: by 2002:a05:600c:3ca9:b0:40e:88d7:3dd1 with SMTP id bg41-20020a05600c3ca900b0040e88d73dd1mr250569wmb.37.1706024078284;
        Tue, 23 Jan 2024 07:34:38 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm42457536wmq.12.2024.01.23.07.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:34:37 -0800 (PST)
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
Subject: [PATCH 14/21] spi: s3c64xx: return ETIMEDOUT for wait_for_completion_timeout()
Date: Tue, 23 Jan 2024 15:34:13 +0000
Message-ID: <20240123153421.715951-15-tudor.ambarus@linaro.org>
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

ETIMEDOUT is more specific than EIO, use it for
wait_for_completion_timeout().

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8897b5895cde..fd0e62ff8968 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -520,7 +520,7 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 	val = msecs_to_jiffies(ms) + 10;
 	val = wait_for_completion_timeout(&sdd->xfer_completion, val);
 	if (!val)
-		return -EIO;
+		return -ETIMEDOUT;
 	/*
 	 * If the previous xfer was completed within timeout proceed further.
 	 * DmaTx returns after simply writing data in the FIFO,
@@ -568,7 +568,7 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 	if (use_irq) {
 		val = msecs_to_jiffies(ms);
 		if (!wait_for_completion_timeout(&sdd->xfer_completion, val))
-			return -EIO;
+			return -ETIMEDOUT;
 	}
 
 	val = msecs_to_loops(ms);
-- 
2.43.0.429.g432eaa2c6b-goog



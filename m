Return-Path: <linux-kernel+bounces-52636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF82849ABC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CAB1F207C2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210CC1BDC4;
	Mon,  5 Feb 2024 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZaqNWtV+"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345521C6B4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137126; cv=none; b=ar6rCAmUz3aIErMw0yLBTApt6rh70kd3lgfAn2I30Ne/SIy2wvw87vP56mF73qn12ZqrPjzi0uFF5RcezWmaoQiU+PhY8UEBnNKbW3OCJuUPjknxcj/3rcTo09NEDHOfHI0FHyJ/hAOH+Q+6u33aDYM8DjdyWLUMNLkPjM5mE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137126; c=relaxed/simple;
	bh=uN4pmSgYbRXI2jvqo6UzvAcRTx54tWVkaWx0En1evXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2ggiS2HX+TMh2mqiqz6xodW5y/PcgDVSyqXHNJyDbCWJmqdoJpb7uJ0QUBFNUO16dmNloCiqz7N88oMWCxZY0OeDzja3wxSNDyx/xf8JYELF986/6rNz3AQlPjuPsMqU9TqgTYVziPGPzFNFV7SDpIy6Uz7SaiQIPud/nNlKnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZaqNWtV+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3394b892691so1719692f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137122; x=1707741922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dR8F8TtLujJzML+VHbYFd966gNYU8tLxVBTCD/Qpmho=;
        b=ZaqNWtV+PIeH/DoZrTyOqgIBIeqcDVuC4BIb2sMNv0aCfubHXOnvNnQPgv7zN/XlTc
         isjlKtovaCOc1y7IvXjFdhlmFML8ixdb8KpW86oNP6+brY+OSeclBO1kqV3DuLOMH4kB
         TKazF5fvChRPJnO12Ut2Mijz+zgfKjyDC2WNLKIf/jXDppc13MVHIRDy/+lhngDBNjU8
         XVTpPhk7VPK/8z2S81xA1z9BfBBsZA28clzNko+zQFBL4+xOlSrXvZV7lkVMekLX+TVd
         x9WSTzRZtjjOG9RPYptKMyW36ZMnfzIEEuhZedD3B4VqJLKsEtN2c2KZBbSHsak1XNVW
         nU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137122; x=1707741922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dR8F8TtLujJzML+VHbYFd966gNYU8tLxVBTCD/Qpmho=;
        b=qDc2CirPhCgfnsdXnNhvUF9wcHq0+Qr/dQINr+o8/batDW19uRIugcdX6xbvBiS9FU
         nfyGcVYVjaTltcFMgNw3dNNoYbrGfTw3LOsurPZX+PXJfrvPgOx34lSmnZsj2FvfTQm1
         dklw0ab6zP/OYzbULlvM50dBmIhisih8pM/9k9xdyDsSF7AOAvABd/o/6xp9EKL7I4gC
         mqD2rWiva6gX0cuPDeYv+sTwUisK2Fw2Xhfw4jJ+QGe3LZoo3MMLLwbU02szMbnW7zfg
         u4CMuQJe16WFeuVMSlMocowt+IrHZuJuACgYKFv+a9GONAJplD1EG0aSt9ge+NOs1mdT
         Rf7A==
X-Gm-Message-State: AOJu0Yww2gtC67ZlRy8ZIPtY/aZZz5W4zrsj4F8bMF1ng5tdLmPwr+vN
	cXaUsUqXMeuNzdL9eWS8GRAvE1wHmipq79GVHVI/6xWfSUgc21mJR+lNVwEBbhU=
X-Google-Smtp-Source: AGHT+IHCuUmi+aZgBfk65jmiz0AIwSuZ9vOXcT90pjJQzz+4Bn7QZ2XAsQmQC/0j7e9WxwoFjwSkYg==
X-Received: by 2002:a5d:400c:0:b0:33a:ebf1:2bf9 with SMTP id n12-20020a5d400c000000b0033aebf12bf9mr3498784wrp.21.1707137122511;
        Mon, 05 Feb 2024 04:45:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXl4yO1d8qcT/Zxvb0lobqGRNH7mNE0zJaKCteLlrfEU+JyL5wm+nZfgc3HDif717jZhnK8AwmpbghCtGct+2Q4SODKEIqEnCEHt/sPiym8+bPgxcAfnqA02Ugtre04fhpiMpg0MNX1JE1IVOgtRrWroBjq7Qj5MjMpKpu5CcWwA592/JgYX3AAxwL9HXrQ/3vuohqfTyORMqCNSlS0EaxsQ0ciJKjXwAhR/1GhvyYKmmlVixm8B+MAFM43NEvIKPIHWZmO41pvSnas7pfGoocPlN2I1qUWwExsUfHAvRR3ae9tSP2+VDIAMWLD8UycDNRRe+qlsnzfMctaHdmcWLQzk+hkQuyveQHQiTQyRRNIXNFSquM7JhAeKRy5pezKZ5tuTkkvn8PAUinD4LHmMOmyuqwkknpYtNubu5rdUBAV7N3zU8BHQ6rn9wvXbctFHxNjvS3V2tmvud97IGGFNigC4qmZmRx+bda4Rdt3ZZrAKj0K3XNHhA3/liOBog==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:21 -0800 (PST)
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
Subject: [PATCH v4 06/16] spi: s3c64xx: remove unneeded (void *) casts in of_match_table
Date: Mon,  5 Feb 2024 12:45:03 +0000
Message-ID: <20240205124513.447875-7-tudor.ambarus@linaro.org>
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

of_device_id::data is an opaque pointer. No explicit cast is needed.
Remove unneeded (void *) casts in of_match_table.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index ccb700312d64..807270ec3c8a 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1512,31 +1512,31 @@ static const struct platform_device_id s3c64xx_spi_driver_ids[] = {
 
 static const struct of_device_id s3c64xx_spi_dt_match[] = {
 	{ .compatible = "samsung,s3c2443-spi",
-			.data = (void *)&s3c2443_spi_port_config,
+			.data = &s3c2443_spi_port_config,
 	},
 	{ .compatible = "samsung,s3c6410-spi",
-			.data = (void *)&s3c6410_spi_port_config,
+			.data = &s3c6410_spi_port_config,
 	},
 	{ .compatible = "samsung,s5pv210-spi",
-			.data = (void *)&s5pv210_spi_port_config,
+			.data = &s5pv210_spi_port_config,
 	},
 	{ .compatible = "samsung,exynos4210-spi",
-			.data = (void *)&exynos4_spi_port_config,
+			.data = &exynos4_spi_port_config,
 	},
 	{ .compatible = "samsung,exynos7-spi",
-			.data = (void *)&exynos7_spi_port_config,
+			.data = &exynos7_spi_port_config,
 	},
 	{ .compatible = "samsung,exynos5433-spi",
-			.data = (void *)&exynos5433_spi_port_config,
+			.data = &exynos5433_spi_port_config,
 	},
 	{ .compatible = "samsung,exynos850-spi",
-			.data = (void *)&exynos850_spi_port_config,
+			.data = &exynos850_spi_port_config,
 	},
 	{ .compatible = "samsung,exynosautov9-spi",
-			.data = (void *)&exynosautov9_spi_port_config,
+			.data = &exynosautov9_spi_port_config,
 	},
 	{ .compatible = "tesla,fsd-spi",
-			.data = (void *)&fsd_spi_port_config,
+			.data = &fsd_spi_port_config,
 	},
 	{ },
 };
-- 
2.43.0.594.gd9cf4e227d-goog



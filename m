Return-Path: <linux-kernel+bounces-54528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699A084B059
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A4928948B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CF512C81A;
	Tue,  6 Feb 2024 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m++NnYdc"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D650712C532
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209569; cv=none; b=b5D/f5KUt2KbrjQwHUw7r5YABewe7aXt1mG4ekCVSc7fwttv5oI84tdUTjjw9hgTBtXwMjJQjTOMiBrDlRYVQxOIhv/7lEGxZT3En7fRL8RtuZ/CxqlEGza9hPID9jr2Ubaphyc7KQPgfuMSxJ1R1Y3mhEJu7pZLcysb/bsUhqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209569; c=relaxed/simple;
	bh=7MmXg1IlvTSQauM4ncPun+Zkso2AqD99duVghgsO4co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r19LZP2uH2yCDySWM9UBW1gSZWsaFx0fWdqkqoFI5YgD88oLwPP3AaZPoeSWNsIgOIGfpjsj16AD3LmsNWo9HL59KKcNPG3tpem7nIyo7BXrhXf77vo3U4oxh36wlikfT7p7iMfRYuyV4RJT7MntevIUyjzFtnVRDP5jG4SQzvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m++NnYdc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fdf5e7039so7557705e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 00:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707209565; x=1707814365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkCVQgxzGrBwaduk8EU6FbXs7WHVlMsXSEp7cPhdCDY=;
        b=m++NnYdcSzB+v5TUjxh1KT7+v7+HvBGocrhVzo0uxb49BOjbI/8MFbCpozReg/4EX5
         LNbSkHswKNQtKyEMPo8tzQYFyuKWrU+SLxHxhR3nIzzb4UEkkuUERerKYVYqkHVeDTjV
         Xf+j8Bu43mc13iEmdYjaKHQb6RJazLP8kcbiOoMPaV28uVijGhoSZmJVLPR47Gs0HmXs
         iA9xAqqDM9SS5SPcsfpPdvEHjk8zVlBCuTFFBTpOXW+or57YOmTb/yR8I3tGzKIZU51b
         l8MPjXYlX2DoTtzIGhz6X5wrlKX4OL9+CsS3QX8DWNryEp1LcKCDzuSZHl6dGA7WPUoK
         fnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707209565; x=1707814365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkCVQgxzGrBwaduk8EU6FbXs7WHVlMsXSEp7cPhdCDY=;
        b=GL2rmuk2ZTk/V8JQfZRLKs1mdJeMS8am8t6plC2cefPfl1F8RhcCplJk3rTPs0s/Da
         JdFpIuktBnUNrex+3oNSXWLoDDOgssdD0Po9EirAB7U89roBM9WdfTkhGYORbR6p8Ohd
         tbLvZUJWafY71cX6iIMFZMU4ggFsglZH5IVdoErXnKBKPXKGj9QKjHtxrT9SQuwlgX3l
         lSQKb27lmyAalqiZkAcjcTZsujIVcv7ROm/SIUDoiSMbrFXQRtIyHC9abal0z4CQ4c4b
         xfS/ubfIoqusJVbvraKSBbiW1e9t+i7ziwGk8hgKk1DS8EPZM1TXaxA8N7zdEQpDvJ5R
         1cvA==
X-Gm-Message-State: AOJu0YynSsolDRA938Yi1B4Fz504O8LRy8WRaG8defbvtcRY22rFck3r
	wb19LvNyS4q4PwYKLnKggQVRxEMITfw+sCzKciECjp/zpoEu5ZpSdOfqIW8cZ7M=
X-Google-Smtp-Source: AGHT+IEfbZ0TfE6ir6WxqVPHW4Z6wzJ6yydiTFjH0G/ELjvqFfmPNdduKf5sCMaMUzLONfMUUitvpg==
X-Received: by 2002:a05:600c:4f51:b0:40e:4806:f436 with SMTP id m17-20020a05600c4f5100b0040e4806f436mr862601wmq.3.1707209565085;
        Tue, 06 Feb 2024 00:52:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSVEfTQt0pSeBP677iT0RXq8Uvi7iy+AYsrqUOr9WRw2rreuee6l2i4d44/fyttNVWHm9NPm5FMybR0L9l1lqhU5bK8qYgfNfZUMmedtg5BqxNTOn0g+sDkiql6xOcsZgfbAvDGbRnm3vYM/ABbRgdtSpFPeNdkgCneee39d/OE0X2FzeVKCg+waYAIAX9QA8+cej9H4H+ZdSPGgyQO1DMC3KvB+GKzYvjfFzb1SO1Z4/+lNNJJsq+6D2owJ6zPd0SyE3vAX4q7WtWadQC9KECVoiEcBypDG5qP0HtayIJk1+1TqDcxweH7GA1xvsypjDpdos36atNUBcqQIWar550/DcGj0pMF7ewxm0HbWR7tZaloD3unnPXXexPWuUdyTn9EK3QQd1ZaVhfxC97hAuLGvON/OdURaZxnFIc/VBUlX5CJ6GSnA2ajQZOcoJxRLV45Y3h+lTOfsMEb87TRPg9qvohiFhxpHc4b9XfJtdgRP2FD02e/P73GVWmMz+1qufGxdcLYXoYqv0yNe5yreh9Xt3Ym1s/ckaZXvahIvj2M1YP5ZbqGvY8rtmSiOJ2Ys8ctqNeW4GwfDco9/CYtX1v2A==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c078a00b0040fe078fb03sm1221591wmo.32.2024.02.06.00.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 00:52:44 -0800 (PST)
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
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 1/4] spi: s3c64xx: explicitly include <linux/types.h>
Date: Tue,  6 Feb 2024 08:52:35 +0000
Message-ID: <20240206085238.1208256-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240206085238.1208256-1-tudor.ambarus@linaro.org>
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver uses u32 and relies on an implicit inclusion of
<linux/types.h>.

It is good practice to directly include all headers used, it avoids
implicit dependencies and spurious breakage if someone rearranges
headers and causes the implicit include to vanish.

Include the missing header.

Fixes: 230d42d422e7 ("spi: Add s3c64xx SPI Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 72c35dbe53b2..c15ca6a910dc 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 
 #define MAX_SPI_PORTS		12
 #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
-- 
2.43.0.594.gd9cf4e227d-goog



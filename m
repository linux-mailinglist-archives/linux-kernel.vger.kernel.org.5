Return-Path: <linux-kernel+bounces-40406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FD183DFA8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EA21C2249B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFFE20B34;
	Fri, 26 Jan 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltzeatPy"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555D020316
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289355; cv=none; b=oUivcgPRH9rCg59c8pdeua1/zR/sMsLcilosts5wxm4RtIoLjAWIIwJOBZgnl3q2lycyDZywYxrHhrS7fNQ8FcTJSD1vAZrr9aiuXzi7KPqOTFcbGr09XqJaHpQ2svTyeuEiYmRXO91sbQIEb1ehLYJsy6jUDsUuyA4qsxuLxWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289355; c=relaxed/simple;
	bh=AoGW2GcL8h1o+dsdkCi/8xC5olvRIKqtfKKZ6T6LaHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfIQIpTfWYKOtoQAdgVvOi97RafVDR115rHjr4pampx9EERT5hdqiAO68HmqSsEDwT4QIC+5mtHMpcfiOhx25KJaVm4bYESj82gT9QiWJ9mgw3H6eb7HKvBtquFLoHWZZp+BklHAONfl/UJJ7chahaODSPHzsaY0tGD3LQg2qhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ltzeatPy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e72a567eeso17511255e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289352; x=1706894152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZyIu4b6YNe2wvKK+UomLqm5rV84CGo8FcGUcF1/2RQ=;
        b=ltzeatPyGovRRuSoHwtx6y16gifwv0P4vzl5R0F96oETsy5mvGd0k8l/VL4WPufwpr
         KGYVSBrwcNzE3hd9U/5Zjen0eWz/aOvM9tY98Sku2CL6AjBA4XKFHJyJR8RgU0HjB8Ty
         EPpWAC9QfbTNZcHEw0DiOyk/ikiaw9IOYlbtBPvdhBvX/cNWolC9f38udZT3c92A/++5
         Z+1uMpkjlmFa/rHpJus17zKDVyN7XK3XLj4FyR3xget3jLiYwClbQ1OJzIq8mODC9AWi
         gn9uhA9MU1ESVCKne0uOyiFP5wfCCnSxGQOHVV/1zPrcth1wJcrmxeT7IzGOq03buI/Y
         qKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289352; x=1706894152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZyIu4b6YNe2wvKK+UomLqm5rV84CGo8FcGUcF1/2RQ=;
        b=T9wSgWoyvlncNbzcSetnxuCQ7/2q5SPiCUgN/q61sT6wdWJ4M3PCpny8s5HVowQLwp
         bXfS31edXXyjB93zjd9HJrwfnrJhXfrZzQAI3MRihxEfbKHmNfg1ziGzsx18dzJlOxRR
         WjtTvJmmGrLmb17HUs4sX1mVl5T4JNIX8P8RJLvCig+WgRCzVChlNL1At8VZfvedG/rl
         plZkmOjzX5oRJnkrvOYzXm6aalaCQDwRTSR60SYJ1+aBtl9fCco9RGq/iv3cXk9hKCJw
         ztd+N0jsaqx7xezc6HBX6jen/AX3fCGXHrZVT/242YbAhvjkNxULM/UleegNqfpVuTtF
         b9XA==
X-Gm-Message-State: AOJu0YxWgpmtD4oM3Gk1tj9xWLD5wvkehvZ+Y8fh9RtsRLPNBt/MpJ7d
	oco5izLhyb7WgrTUjpi6mz1gQtgeJCWKn78JI1Y9CfALkDSzae1FV9q9v3noot8=
X-Google-Smtp-Source: AGHT+IGiRqB6KKdRJGfBC0XVbzCa+2WAHj0q2DYE1xYBRryatdCnKSiMtb1kLgtQZLGJlYfS6qjo7g==
X-Received: by 2002:a05:600c:458c:b0:40e:3a6f:9b3e with SMTP id r12-20020a05600c458c00b0040e3a6f9b3emr57710wmo.6.1706289352631;
        Fri, 26 Jan 2024 09:15:52 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:15:52 -0800 (PST)
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
Subject: [PATCH v3 04/17] spi: s3c64xx: fix typo, s/configuartion/configuration
Date: Fri, 26 Jan 2024 17:15:32 +0000
Message-ID: <20240126171546.1233172-5-tudor.ambarus@linaro.org>
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

Fix typo, s/configuartion/configuration.

Fixes: 6b8d1e4739f4 ("spi: spi-s3c64xx: Add missing entries for structs 's3c64xx_spi_dma_data' and 's3c64xx_spi_dma_data'")
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index c3176a510643..3df4906bba34 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -180,7 +180,7 @@ struct s3c64xx_spi_port_config {
  * @cur_speed: Current clock speed
  * @rx_dma: Local receive DMA data (e.g. chan and direction)
  * @tx_dma: Local transmit DMA data (e.g. chan and direction)
- * @port_conf: Local SPI port configuartion data
+ * @port_conf: Local SPI port configuration data
  * @port_id: Port identification number
  */
 struct s3c64xx_spi_driver_data {
-- 
2.43.0.429.g432eaa2c6b-goog



Return-Path: <linux-kernel+bounces-40418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 537CA83DFCF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22201F22464
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F88D20303;
	Fri, 26 Jan 2024 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qtJIxCz8"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E102D22F19
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289371; cv=none; b=G7rQ/x/ChT1hrWBXBK/tmdiJk0fsjXG0SKyeBRyx+BYlBIQP9zxf+MhjQg1AnF8eb9cUePtAG/yaT2yJkq/Ll/29S9XSbrpHxsmJJPFM8XYvOREtI6Hm/6+CT19VLsGNMv6NQGV6bgrlTzpjfpr4Rbp7+7UsTtfNUcHn6h5S5K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289371; c=relaxed/simple;
	bh=Lda6uhylzUEwPqctZ/bYWn6dBNKjWS7g/L6QLlibWu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGmIosY1bcdt0LzgN6luwr5oTSDt/AzKxG4cLjyV0OtsOgu7mXXV983d2wtyH7udKvhNOmFm6fly7Sl3pDa0G8KLpY6Usa+Hxv18vnRNtbBq1d0eK8KMAZvFK1IQbWBgPTROsj+r+LqeJ3v07wwNMDLI92ao+OM+Fg4I7o0eqCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qtJIxCz8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e7065b692so9309795e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289368; x=1706894168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWAxzMIZUJGbfnyG/OlNotr0pMDtQfjiFLXbcGRYeAQ=;
        b=qtJIxCz8OkSFzWLgDtIjstS8l0+8d/rbf/fgq+ilcKgyEzuOjb+oo8rx+UbeCE28nA
         sXCSI82Yalf9Mw5r4liqjeI5yp8v/DWV0YjW7UvOE8Eucbrl0Rw/5GVw7fSUDJxygVNK
         t6nnSW7mPLZg/4XnqIS8rwcKQul5f56j/4t8h/sb6P7cooZPSoVEI3SV1//qFUXL1Bc6
         6t1RMPPuY8+jpBW/3xLOnimhdwBxZ9/gKiv06NwwyvSTUwK26Yi+WJHwy6rrgWp7siRO
         fLO7TOZKi91PnLr2+24Shj5qpF2VVjNxnC4J0fPmUVvlw9OZrX00zVMdEOpTGgnVP6h2
         katw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289368; x=1706894168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWAxzMIZUJGbfnyG/OlNotr0pMDtQfjiFLXbcGRYeAQ=;
        b=eyWfJadXTRTLdDPumVTGbwt7D5e+zPpyDHx6ji4FTNLRGiwv5SDSYXrCCfCU24NSSf
         ig9mvMb8w3izynphKz7PQqc/2dgRexb2+QFvVLVwNByyWAY7IMomizFykFraaMDY0ACj
         sYu/O7P0J78Vh0FQpuRNJwNKxXeiMJXB1L/3IOpxNrco57W4c5kDjsdPswCLpSMg//Ng
         OFpf9jIFKErOkcKjDR56VYlQ40laMd0qipmR0Nh4LdArqJgHaM+UPp+tE2nWSrm62r27
         DWC3botToJiKvEioGL4Vs9K3n4WuwdZxdO9U5D9lcOZDrCRMGnyFpT0ub3e8z9nLxeYG
         hlPA==
X-Gm-Message-State: AOJu0Yz3bxjPD5oU0TDeAbEc3rMMdCxPY+FckbUKKSmrMcmbjkyZZp0j
	K7i/0KyqQwbvAZlFZa9huahyP+pX4Jf0AuTkkms8tEYcGYr08XxA9REymj3GtNQ=
X-Google-Smtp-Source: AGHT+IGsOiEDkiB2xffnZw17FMX/xnuVHZhIvhWnxlSn6346ayQ0rGAqxJqIWl1P8tDQMLFabx03FA==
X-Received: by 2002:a05:600c:ad0:b0:40d:5f48:d1ed with SMTP id c16-20020a05600c0ad000b0040d5f48d1edmr89438wmr.66.1706289368230;
        Fri, 26 Jan 2024 09:16:08 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:16:07 -0800 (PST)
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
Subject: [PATCH v3 16/17] spi: s3c64xx: drop a superfluous bitwise NOT operation
Date: Fri, 26 Jan 2024 17:15:44 +0000
Message-ID: <20240126171546.1233172-17-tudor.ambarus@linaro.org>
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

val &= ~mask;
val |= mask;

is equivalent to:
val |= mask;

Drop the superfluous bitwise NOT operation.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index e9344fe71e56..43b888c8812e 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1089,7 +1089,6 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd)
 
 	val = readl(regs + S3C64XX_SPI_MODE_CFG);
 	val &= ~S3C64XX_SPI_MODE_4BURST;
-	val &= ~(S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
 	val |= (S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
-- 
2.43.0.429.g432eaa2c6b-goog



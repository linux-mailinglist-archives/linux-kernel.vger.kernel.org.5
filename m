Return-Path: <linux-kernel+bounces-147162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFE58A7056
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB13B285F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3661332B5;
	Tue, 16 Apr 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5v0Aq/b"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47552131726;
	Tue, 16 Apr 2024 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282792; cv=none; b=nT0+Wq8/SmG2mymPeOZ5cTtJJIzYyAtUhtHf72teTTCZISml8CiqiBFWyuHiqBR0Yd3skQy4Rs9lc8vIWbSmhn01zBQ4WBaZjhXlbtGLO8iWIOvgYCfynGEwQYuWuWXu8hD5xYhAO5DfOigcMi9vgczb7W/YBThmLS54UtvX24E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282792; c=relaxed/simple;
	bh=0PBo9Of6CNy3BPbkd/tZVfSeHDs2kDzIZaMPAx/MRPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6cmQg757Z52b+fh7Mz0zzDB9/Wd71XDcbrM90mb8kFl4IKJDnyR26LfEGASzHqBTimimIIZ0GVpBsizx/SCT3kcwKIXP0JMam41WXvjmL2oOD4//Ix1T/RvEPBh6rVt2J8yW0oXtmLnl4J5ABCFRAWZDgwXP1gSV1D6Fmz8c8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5v0Aq/b; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5171a529224so5829582e87.0;
        Tue, 16 Apr 2024 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713282789; x=1713887589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dckUSl5z4UaY1zLi6ZaUm7FPVPOD+pWKaRJKmeXicSI=;
        b=O5v0Aq/bVNou+CMzvMEDBknaRWuQMYccF4g9NJfO6w/rWazblIYnr7CbRLo2Dze+X6
         uQoN1ZinO3nxSuQlE65KiqVWGrk+Dzya1uRPWmAja7tbtiiAvLEN0PHRBzqufNbQEesA
         axUSngsHA+k6jXcJforTpRWjFBaCp0H9h9WtV9x+5VhDfENcSfUtVxD9tRZKFuWLmxhA
         Yk44VritcmTTNVum0Ewskd9CpjZuUd7GYR95mO6meUNxpMQGFMOh3Ve8YCNTzKyEJLMW
         y/k1MyI5pCIfGFS5FUVd99+/ZdTVltrWjTGpHMkKL7s+gXspd/l/u52tVgpH78FsU/gP
         IQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282789; x=1713887589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dckUSl5z4UaY1zLi6ZaUm7FPVPOD+pWKaRJKmeXicSI=;
        b=FH1wc8UsKgZ3gHEY/q1UONLkJSAMzClbJExumReWoqxiGLQpT8D5X2lo/g5prnE2BN
         Tus7fMkwvfBITCI6sJP86a6jvLMr7bClEn/7Lrrdd/jyWn+b2TVq5NDhNnfvCzbl5REf
         EJcnVtTTTpsIWUE7b+x9nUGRVOoK88ab66GHE769qvjFrw38aBa3opE/bBcvbWxbqBji
         6jtv0L4c14uAiagw7pumxUTTAFKuJPRjb+VIAWlBHWTj7+BxFH+gScWXgKsb10mCImiK
         mqn5HtvxpaylOkGGcpKXqQjfJ6THm4CkpLDJ2Mu2tDCPqnHnsnIuTxzeU4v/NRGWwIvd
         w6rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXutUKrv4tICXol/YAGEIOZl6Gx5QTanK94KKLVv7PryhE4lS2qIW8FrdTtgdnPsxfOrJYEeLGAH5HDj6gsA8It5Rc4/MpN8qEvBczvoIieyQyNX+PbXX3ILM3veDZXkkiXJvPzhUnd
X-Gm-Message-State: AOJu0Yw9dfsctglxzs0pFxYpwas5fYRK/4v/N2AntaqXy2IvbA1lxl5w
	TdxAlgHJNqg/8Z9DbNxuCD4mymH4dv+yLW8czoqXLdYPkhUYkMqw
X-Google-Smtp-Source: AGHT+IGVEuCQi+moMpiZAWclRgl+2kiaOhRvkqzJFDhaQQIiLhibEJ33yPFDB7F100uTJ3qRWKZozg==
X-Received: by 2002:a05:6512:4889:b0:518:c902:f992 with SMTP id eq9-20020a056512488900b00518c902f992mr4601473lfb.9.1713282789382;
        Tue, 16 Apr 2024 08:53:09 -0700 (PDT)
Received: from localhost (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id bp41-20020a05651215a900b00516d6924bc6sm793551lfb.175.2024.04.16.08.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:09 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 4/4] spi: dw: Drop default number of CS setting
Date: Tue, 16 Apr 2024 18:52:34 +0300
Message-ID: <20240416155257.22429-5-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416155257.22429-1-fancer.lancer@gmail.com>
References: <20240416155257.22429-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DW APB/AHB SSI core now supports the procedure automatically detecting the
number of native chip-select lines. Thus there is no longer point in
defaulting to four CS if the platform doesn't specify the real number
especially seeing the default number didn't correspond to any original DW
APB/AHB databook.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>

---

Changelog v2:
- Drop temporal variable and pass dws_spi::num_cs directly.
---
 drivers/spi/spi-dw-mmio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index cc74cbe03431..c56de35eca98 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -320,7 +320,6 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	struct resource *mem;
 	struct dw_spi *dws;
 	int ret;
-	int num_cs;
 
 	dwsmmio = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_mmio),
 			GFP_KERNEL);
@@ -364,11 +363,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 				     &dws->reg_io_width))
 		dws->reg_io_width = 4;
 
-	num_cs = 4;
-
-	device_property_read_u32(&pdev->dev, "num-cs", &num_cs);
-
-	dws->num_cs = num_cs;
+	/* Rely on the auto-detection if no property specified */
+	device_property_read_u32(&pdev->dev, "num-cs", &dws->num_cs);
 
 	init_func = device_get_match_data(&pdev->dev);
 	if (init_func) {
-- 
2.43.0



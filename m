Return-Path: <linux-kernel+bounces-87165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D0586D086
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80151F238A3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3E770ADA;
	Thu, 29 Feb 2024 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eQTuSeKA"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3742D70ACB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227559; cv=none; b=KA7+Qxf7LcSEQhO6v9Z/gcjNB/aqvgN7+vmz9bUP58BIqXuhX5zSGLmtyGVGvAIrU2gfOBZNooWWZB5IweY+LCHA959KFHYyxfayukV7CSoIZcT3t0iC0em7Nq8bIOT4DSPS7PbZdxbfnAtwt8TI6c4UD+YSreWCugOcGMQjAeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227559; c=relaxed/simple;
	bh=9oywh9FMw/06CP6mVYaiS1vpcKmACzm2SAHCdBQBzpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U5u1/QOEeovjEWBIg3NFLfFqMk5elJTIoCRx/kGfjH2SYe78dsNldxWHBcQyjg91tDMvW4DMkPgwmdKgsu7pC0nGHLRiqWKCY27LGxSMWMRB1FTlEHtU8oVB97dKDduZY/u1Ih6w5XW8oZPp2tSs5JmRR69CSqoxMln9OUj6DA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eQTuSeKA; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d2509c66daso13542051fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709227554; x=1709832354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k53WbnVf4+CpsoOIcyy5o8qV/jlN6Kum84cXcgG0fEg=;
        b=eQTuSeKA9zgVqSNp7vq2Jso/K+HHoK5UVE76rQ6B2LEFkicOGBhggTrvdxfBx2nbpy
         fkU+clg+zZJxwBvFcfJCVY1bwgGOP8wTezuVFk6lfj/XlDj+fhSqT4QcrQ4s0IyCtMyW
         k30to5R2FYKzVGqTdnyyvuNFajCF5HO8cc9E+umtZVVtBmQuAT0yAQ/1K8zVXNUwHjzD
         EewVfRUs+shVSTaqyOnzKIuozJr/SmaM46DACuRxjQhbZTvFn+lIj+cqLmcwoFI+d3Ii
         XIOd6mZly/RfuACjmqV+RRpLw9ENDfInPTV4yN8ZFWBKp2CCnOUQJUpscV3ZxC04t30Q
         FH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709227554; x=1709832354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k53WbnVf4+CpsoOIcyy5o8qV/jlN6Kum84cXcgG0fEg=;
        b=QlP2V1xff0ZcI2OpsS/LjajFt5VzyR53TVs1eklgwMqLr2AuHnHwpW+FepxtlWTyXK
         VAySqKJfHI1dYZi+awjY03Zdao/gePElIAZCQ9uVQDv5IvqcvSzv3AgNYrpNF7vTr5yO
         plMxYcMAqNYRezqx3WAynOJ9l9GKWoMrJ0UVZngz0S8bfVxCU4CEqdxErbPtIfhrRdF7
         HeEMlep6vc8a1n88mc1EtepeKHZ43xTFoB5DHYXWTmb+8EpJiGX2IkEJOxERr1aXrwvi
         UM/DKHcJTHgIttJLWkZHt1LYEJjiHuXWbxrDjWEyLKCe42zhyOcAC6ElCkLKQq3iWfVx
         qiMg==
X-Forwarded-Encrypted: i=1; AJvYcCX7V7IXO890k07QkifFE9s4rq5dBM02WzfKDCaTl1diIc8UucpYinbzlP0Lnc0NmgaYp3jKTpq9bOd2X0m3HelwiqbtNXyw5RcDJZxg
X-Gm-Message-State: AOJu0YzQbF7XDj2BX9jKIMBkKwQmPH6md46z+gtnm0GWoo7b5K7AgxDZ
	puf/LyW7GoUxwe453wpSmIpSLwvEePibhdCfHsPWf3sbHsSaBcEye8NTPaVsKBo=
X-Google-Smtp-Source: AGHT+IEb/HU8gsqPEBt9jBMoPEQ/VN0S2Oiwl0iriQjy+kGo8FQgIGt2JEuCnmpuFWvXivEm+VhMjg==
X-Received: by 2002:a2e:850e:0:b0:2d3:1be:2565 with SMTP id j14-20020a2e850e000000b002d301be2565mr1995722lji.6.1709227554171;
        Thu, 29 Feb 2024 09:25:54 -0800 (PST)
Received: from localhost.localdomain (46.205.204.142.nat.ftth.dynamic.t-mobile.pl. [46.205.204.142])
        by smtp.gmail.com with ESMTPSA id p26-20020a05600c205a00b00412b62f6e35sm4941922wmg.15.2024.02.29.09.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 09:25:53 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: fix resource unwinding order in error path
Date: Thu, 29 Feb 2024 18:25:49 +0100
Message-Id: <20240229172549.444227-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Hogs are added *after* ACPI so should be removed *before* in error path.

Fixes: 6d86750ce623 ("gpio: fix gpio leak in gpiochip_add error path")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 21edc5eafa68..7fd9c59e73c5 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1025,11 +1025,11 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 	ret = gpiochip_irqchip_init_valid_mask(gc);
 	if (ret)
-		goto err_remove_acpi_chip;
+		goto err_free_hogs;
 
 	ret = gpiochip_irqchip_init_hw(gc);
 	if (ret)
-		goto err_remove_acpi_chip;
+		goto err_remove_irqchip_mask;
 
 	ret = gpiochip_add_irqchip(gc, lock_key, request_key);
 	if (ret)
@@ -1054,11 +1054,11 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gpiochip_irqchip_remove(gc);
 err_remove_irqchip_mask:
 	gpiochip_irqchip_free_valid_mask(gc);
-err_remove_acpi_chip:
+err_free_hogs:
+	gpiochip_free_hogs(gc);
 	acpi_gpiochip_remove(gc);
 	gpiochip_remove_pin_ranges(gc);
 err_remove_of_chip:
-	gpiochip_free_hogs(gc);
 	of_gpiochip_remove(gc);
 err_cleanup_desc_srcu:
 	for (i = 0; i < gdev->ngpio; i++)
-- 
2.40.1



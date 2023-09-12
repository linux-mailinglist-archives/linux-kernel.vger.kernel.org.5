Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2026979CC30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjILJpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjILJpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:45:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E527FE6A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:45:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-403012f27e3so34422765e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694511926; x=1695116726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UafgOnXtuKh9m65/RPTh4Y2p9AF6HuTxWc4dq2+OROA=;
        b=P9ntPn5y3ViXGsTUSe4nqvuU6z+so9DFl+2H4p0YGox9aTlzh3PJ/aNi1Th2D63ZDz
         LkVDZSJOqa9gWD5v/YRCWjYOVO5mmPMDObGO996aWw+qZdCrZVOW9hKhaZGvHlpKUNBJ
         N4q4rmJMcHELIdDB+AxXU/9m7gt2JphpS0bPzU0Stvbs0piZRoLU8n4omKuW19fyO5tH
         uXDvHsY1ns7d8FnXzXIP02Dh6qIswUfacIrSB7moIvoPIldjARH2ezd4eYfkJH2WJh+N
         eEzYdlAfziDWaSN0jdHny84De4t0uzMMsvUVRkIr5Fsean1Ykf6n3fTynBslu+y5r5W5
         MC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694511926; x=1695116726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UafgOnXtuKh9m65/RPTh4Y2p9AF6HuTxWc4dq2+OROA=;
        b=kzqO2syIKXqpKNBLw93hw4YrWm2cbMu6Y0VLqJYC1Aki/8EDDIoC84bUMVBD8EKdKl
         EHBY95w1fJZwYS1qDgRzg8+S+WYzu10AUiSXO/wraAc8Jlwlr8ZaU2MT8ADAOFC2o9u+
         RYGQiTTl6smi9ORfSzutlT5Ar3vk6AuHudQgYeP2Cbe0afdfy6tPzGNWQTvolhynrISD
         wiZyVBxZBLd7N4J3aD9CYMu+BnmifIgQgORczduzRCftYmKthLCIeQh3Wqok7zFHLVWk
         9zVDxBopsYx5sF4tqUoPH+8VQ6OMUC1U0QImMRFmt/VaAOgQG2TJB3WJgRUotwDt/2iY
         h39A==
X-Gm-Message-State: AOJu0Yz2tjAYdYeMlYYjk7YEFpvuMXz9hfHOcl4+b+3GjGJKzqtln7wv
        K2cakcw8WKYWWXE+MiOjdb4LzQ==
X-Google-Smtp-Source: AGHT+IHfTi5tcH7CVZjdKGOzUnrCN0zFPiSYfWMyALIyvaA9NW8oMfpgk0XlqIzyxv5gap0GXugeQA==
X-Received: by 2002:a05:600c:3b1e:b0:402:f536:41c5 with SMTP id m30-20020a05600c3b1e00b00402f53641c5mr10218128wms.3.1694511926409;
        Tue, 12 Sep 2023 02:45:26 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:907f:4cd7:f0ae:6b2a])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bc8cb000000b003fefb94ccc9sm12321621wml.11.2023.09.12.02.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 02:45:26 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFT PATCH 3/3] gpio: eic-sprd: use devm_platform_ioremap_resource()
Date:   Tue, 12 Sep 2023 11:45:19 +0200
Message-Id: <20230912094519.22769-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912094519.22769-1-brgl@bgdev.pl>
References: <20230912094519.22769-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Make two calls into one by using devm_platform_ioremap_resource().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-eic-sprd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index be7f2fa5aa7b..1e548e4e4cb8 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -594,7 +594,6 @@ static int sprd_eic_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct gpio_irq_chip *irq;
 	struct sprd_eic *sprd_eic;
-	struct resource *res;
 	int ret, i;
 
 	pdata = of_device_get_match_data(dev);
@@ -621,11 +620,7 @@ static int sprd_eic_probe(struct platform_device *pdev)
 		 * have one bank EIC, thus base[1] and base[2] can be
 		 * optional.
 		 */
-		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-		if (!res)
-			break;
-
-		sprd_eic->base[i] = devm_ioremap_resource(dev, res);
+		sprd_eic->base[i] = devm_platform_ioremap_resource(pdev, i);
 		if (IS_ERR(sprd_eic->base[i]))
 			return PTR_ERR(sprd_eic->base[i]);
 	}
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F0579CC2D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjILJpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjILJpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:45:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A6D1BE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:45:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401d10e3e54so58753985e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694511924; x=1695116724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QUhS3M1t0YAyFz1IeQjV7tM/jIx87sSwaSY8W7cUf6Q=;
        b=YB7M7QUuZ72DzNgN9ZL1r95h7PdJ8CVKpPl8pTbxt9IXW4eE1+8fFBc+F/Bbz8rmJN
         HJGdgj+YSim4igJtPeugyDP9MPAgGszjn6jwiOfGpaxAwToh7opWF9AvZj7cK0OryA3P
         NdIXKMumyvFNNG4zlDDfOtKFGHXKa3nsBKgy36bjO4mGu+EY0sAJ1qBQZn+PrsBiK0j8
         kw2pT2/sd3p6ELAIOsjv9+c7ArxeZMuAfQUl7864qfz7XSByX6CxcqWHck9gvZTGF1Xl
         8Qnm8sKhNhFPO/YlN9zxac88wZut0WzwHORKxoLLx58Kg0O7PJlpTIMavGeVnqgaoUGK
         Kmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694511924; x=1695116724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUhS3M1t0YAyFz1IeQjV7tM/jIx87sSwaSY8W7cUf6Q=;
        b=OFI7uUbml6IA60loXFbGic3JqjqEQ89W8ystordMBYxOgsx6dwcsna0GfQTsQTerBC
         4kkoKMjoz4ej48KjJv0WWEXFJ9ZoJkztVMBur29fxoBzqa9kT+ugX6C5YyEFHEJCP7Ty
         K+VdAqrsDLVpnAO+xjGh2ikzbXaIFVEygA8MS3AK+memIy3QtVgYoPgDqq2BQ0HxrcDE
         QUdADRh1/JQcTL2o+O4ke+3VXkSwlZmyvlfkI7f77T4IynHVUnT9bR/ZPP96AlS4b4vo
         0It3SaBapwC1kOyBGDC6SPgBEdSxEtgZfBfGjbfse2MnYGfvvdNA3LwoaGvstuoR8JNK
         RbkA==
X-Gm-Message-State: AOJu0Yx3WOhYU5PM0ggx4nAvretb+NieTLiN44rGCUdh0zVQvJvSODuw
        d0tEmCedHWOMUhiP7VqHagnf+g==
X-Google-Smtp-Source: AGHT+IFnpsyjAydzu7TqtVX3XHlz40yYZmEQhdjvwMmZf6t4zmYWORi8e2LUbKdkvsfumGt1b7GWdg==
X-Received: by 2002:a1c:7516:0:b0:401:519:c5 with SMTP id o22-20020a1c7516000000b00401051900c5mr11209589wmc.41.1694511924547;
        Tue, 12 Sep 2023 02:45:24 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:907f:4cd7:f0ae:6b2a])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bc8cb000000b003fefb94ccc9sm12321621wml.11.2023.09.12.02.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 02:45:24 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFT PATCH 1/3] gpio: eic-sprd: unregister from the irq notifier on remove()
Date:   Tue, 12 Sep 2023 11:45:17 +0200
Message-Id: <20230912094519.22769-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This is a tristate module, it can be unloaded. We need to cleanup properly
and unregister from the interrupt notifier on driver detach.

Fixes: b32415652a4d ("gpio: eic-sprd: use atomic notifiers to notify all chips about irqs")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-eic-sprd.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 21a1afe358d6..9b2f9ccf8d77 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -580,6 +580,14 @@ static const struct irq_chip sprd_eic_irq = {
 	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
+
+static void sprd_eic_unregister_notifier(void *data)
+{
+	struct notifier_block *nb = data;
+
+	atomic_notifier_chain_unregister(&sprd_eic_irq_notifier, nb);
+}
+
 static int sprd_eic_probe(struct platform_device *pdev)
 {
 	const struct sprd_eic_variant_data *pdata;
@@ -658,8 +666,15 @@ static int sprd_eic_probe(struct platform_device *pdev)
 	}
 
 	sprd_eic->irq_nb.notifier_call = sprd_eic_irq_notify;
-	return atomic_notifier_chain_register(&sprd_eic_irq_notifier,
-					      &sprd_eic->irq_nb);
+	ret = atomic_notifier_chain_register(&sprd_eic_irq_notifier,
+					     &sprd_eic->irq_nb);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to register with the interrupt notifier");
+
+	return devm_add_action_or_reset(&pdev->dev,
+					sprd_eic_unregister_notifier,
+					&sprd_eic->irq_nb);
 }
 
 static const struct of_device_id sprd_eic_of_match[] = {
-- 
2.39.2


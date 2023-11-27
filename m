Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B957FAA78
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjK0Th6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjK0Thj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:37:39 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76CF1BE1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:37:24 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c88750e7d1so56281391fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701113843; x=1701718643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a+3yw4Nx5iHvqkKWy1CrBMmo9SCrgAxb4KbqilKfXTc=;
        b=1FAJSW24j7EAyvMc3oIynht23LHRkt4oybLWbnNGXBio2EwOklgJrlCco+adX8H1Pg
         qJMDUyhG6vUlIDOxpAQ9E+rMeGaprfPSaqOqbL1Pbm7WrFjBkmvHvoa5AHqMMrj/BIc6
         bIJDD1qbU8BLTZTCgMfn1pxOtQLM3B3Q6fhbNmGp2S0yfhafTOqVOlL7eYieBUbSPE4S
         ICS/H57xjoffY5LVXXNhKWoqy1d5mDj/HTlhqU0Os7LbY038mOt5Sj20QCRgqCGU/WZY
         xDPr/BdCcNVmaNIiCL+qi2g2rFGEaPHmUSBfU0lGOSMeNokwKCMkZMT9TdxCmsmdgAFF
         WtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701113843; x=1701718643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+3yw4Nx5iHvqkKWy1CrBMmo9SCrgAxb4KbqilKfXTc=;
        b=WkeY01c54yQ2vGA0RZb85O/AYw5YKKrnbq7m03qXVYRzH5fF+Py4A4PqORVodVI+pF
         Jc/VKpfbEJGbL7ArxB/14LqdyOUspQN8FWlqQ+QR58fLVcqZiHgKUiKzEpL8/FzrG/nB
         cDUIarZL6Z90yNlYl7sMS0L6y5AWzxN0jnnMA2aPHnVq3b1qvIK0/qFl8WxXZIz5hrQf
         Q8HQEKV/f0nKCuM/YeEb9OtpDarnwEE329BNVwZF6HSAj7XR8qNxX+Y3hW/RCArR4TH6
         Y+GABNyK/tJmqLcxV441q+BisLOLKdYYPQY9ndB4tPjneF4Y2U3Cgtsw1HhYn7103brU
         quBA==
X-Gm-Message-State: AOJu0YzKiEG2Mt/K6z3CRNkUVYApj/NSs1HbZiDJcuuB35NQxGZzqqHv
        z9xgNEjxnER4655NEHJS/oD6qg==
X-Google-Smtp-Source: AGHT+IEc/FkN03AUn3exkNcPYCn+yIrRAT4pLmfihq5+N7WqSkWZiWdI/w3JVayDgMaEeeQRYoM8dw==
X-Received: by 2002:a2e:5007:0:b0:2c9:9968:2d4c with SMTP id e7-20020a2e5007000000b002c999682d4cmr5138406ljb.9.1701113842849;
        Mon, 27 Nov 2023 11:37:22 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:bf33:77c7:8131:5e64])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b0040b3632e993sm15016610wmq.46.2023.11.27.11.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 11:37:22 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] gpio: sysfs: fix forward declaration of struct gpio_device
Date:   Mon, 27 Nov 2023 20:37:15 +0100
Message-Id: <20231127193716.63143-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The forward declaration for struct gpio_device should be provided for
both branches of the #ifdef.

Fixes: 08a149c40bdb ("gpiolib: Clean up headers")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.h b/drivers/gpio/gpiolib-sysfs.h
index 0f213bdb4732..b794b396d6a5 100644
--- a/drivers/gpio/gpiolib-sysfs.h
+++ b/drivers/gpio/gpiolib-sysfs.h
@@ -3,10 +3,10 @@
 #ifndef GPIOLIB_SYSFS_H
 #define GPIOLIB_SYSFS_H
 
-#ifdef CONFIG_GPIO_SYSFS
-
 struct gpio_device;
 
+#ifdef CONFIG_GPIO_SYSFS
+
 int gpiochip_sysfs_register(struct gpio_device *gdev);
 void gpiochip_sysfs_unregister(struct gpio_device *gdev);
 
-- 
2.40.1


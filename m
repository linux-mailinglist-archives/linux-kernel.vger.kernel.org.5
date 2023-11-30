Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C64E7FF09B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345742AbjK3Nqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345795AbjK3Nqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:46:36 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82550D40
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:40 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b31232bf0so7768965e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701351999; x=1701956799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDkm1mz5JKda1Ie70um5gnCumWIdGzqKbagKhi4Mqgw=;
        b=zO8d/RkZCozzHJ1jQKXdjSYznCbMIc23SHbSreyOKRFdYVhP+l2K2kxpdx5TeawVYM
         VObqZNzZkS73Kgy2UHewywsdJy3thgug3aq1ahTKAS2Oi61OSGMT8uHiliaZMkCBqGKH
         c/EkgFyKTTd878s3uk4QQTsN4e9IODJ/PNeZq24BOYkTKTyQYtJQExNUIUiCGvf+2tSo
         xdavwY5etTRVDax7kAnqhIAWMcrNnOQWIEyv/JuUXmRpPS6qHavUxpja+hqxJqokGvMP
         rnkdRhh4xz5psfSzzIlgywWJONcSfUzV2v8aoKx4MrWMERKU0/fYnxP8nCNj2vGPnRzF
         qJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701351999; x=1701956799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDkm1mz5JKda1Ie70um5gnCumWIdGzqKbagKhi4Mqgw=;
        b=E9w89mgLY6Azld3+Rk5WDLfHJuRWLjn0tQBmM6Dlxb+C80pfbFTtnHhkax74bxV70q
         aB7tuL7PvVU/FMdB0IA3LwcYB50+YIDqvBBam2QcaWIvPiyVFAEVq1mV07vJjXRtiGOV
         9BQFj7KFss+J4hKa0MDoc3ZHuo/8BAJlTaHqTPjgwZuUaRT0hLfMCrXANUmK2xGl0Dtl
         8IuHZKV36xPUpAi4jT3jji6zVwGDqYCBLSP9cV61uzebJ2xQI+y7GSsuhXKWvH48g/7H
         KJ+1uFsJBmnhjs3QlSAPwimB2myPDtxWQvctgNHPAFKV03xuKOg46ya0tUOJam8/VOSc
         ADZA==
X-Gm-Message-State: AOJu0YzsYp1l8RFE+Reej2AipEzKmXHMZDpahhZWe+mIrIr8TRG4Kb8m
        F5DLxjyPdCDMt+oGLIn2cPCdeg==
X-Google-Smtp-Source: AGHT+IH1lRBcUubHIz93kQOurCo+8m3nu0EZoQalJ3ieURmwlYH3CSTv+IgoVsqKPZPB7xaOjJ2hAQ==
X-Received: by 2002:a05:600c:290:b0:40b:377a:2ac1 with SMTP id 16-20020a05600c029000b0040b377a2ac1mr15522069wmk.20.1701351998814;
        Thu, 30 Nov 2023 05:46:38 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae84:904:6602:ec1e])
        by smtp.gmail.com with ESMTPSA id n18-20020adffe12000000b0032d2489a399sm1574824wrr.49.2023.11.30.05.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:46:38 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 03/10] gpio: wm8994: use gpiochip_dup_line_label()
Date:   Thu, 30 Nov 2023 14:46:23 +0100
Message-Id: <20231130134630.18198-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130134630.18198-1-brgl@bgdev.pl>
References: <20231130134630.18198-1-brgl@bgdev.pl>
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

Use the new gpiochip_dup_line_label() helper to safely retrieve the
descriptor label.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-wm8994.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-wm8994.c b/drivers/gpio/gpio-wm8994.c
index f4a474cef32d..bf05c9b5882b 100644
--- a/drivers/gpio/gpio-wm8994.c
+++ b/drivers/gpio/gpio-wm8994.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -193,18 +194,20 @@ static void wm8994_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	for (i = 0; i < chip->ngpio; i++) {
 		int gpio = i + chip->base;
 		int reg;
-		const char *label;
 
 		/* We report the GPIO even if it's not requested since
 		 * we're also reporting things like alternate
 		 * functions which apply even when the GPIO is not in
 		 * use as a GPIO.
 		 */
-		label = gpiochip_is_requested(chip, i);
-		if (!label)
-			label = "Unrequested";
+		char *label __free(kfree) = gpiochip_dup_line_label(chip, i);
+		if (IS_ERR(label)) {
+			dev_err(wm8994->dev, "Failed to duplicate label\n");
+			continue;
+		}
 
-		seq_printf(s, " gpio-%-3d (%-20.20s) ", gpio, label);
+		seq_printf(s, " gpio-%-3d (%-20.20s) ", gpio,
+			   label ?: "Unrequested");
 
 		reg = wm8994_reg_read(wm8994, WM8994_GPIO_1 + i);
 		if (reg < 0) {
-- 
2.40.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36741802EB8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjLDJfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbjLDJfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:35:12 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CD0124
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:35:16 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3333224c7b9so2279244f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701682515; x=1702287315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Sv99NjQCF32QfqStrxQNV++EDXzWOND44xPhDEPFwA=;
        b=i95wUyLNLZz5CTbGL8et8CKZjeP/avgInNMQvRUmE2P7Q5VDwnQvS675+d82tsyeBb
         PNl1qqSMK/Ev0BJbfhMauF3cOLd+m9dGGIzFca/BImEP0u5tTAeWP1e1XO/was82QZOl
         jLpSvp/fF0Xup/1p8u9SV2Aa4fiTMPC049o5gwM7+M3NyVpR62gldJCFnXGvXZOy0g6G
         Ywqlh22KyGpALjvdp0q7VjFR5E1XZI5hqK8vYii/U/j5uMxGphy/kCwhh1I5VCj7P19L
         b9K3gZWXcm4LzAUmubW38meDcSM0s02wj1XgszPx9BJlHMar4+u4A4nj6vI825qRutkt
         wOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701682515; x=1702287315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Sv99NjQCF32QfqStrxQNV++EDXzWOND44xPhDEPFwA=;
        b=ZYsoZlHeGSWFzllYunJr5eaqsIAyyv+V367QdH+yiCbLIw2/ZNhAkHa59FjsTVOmbc
         YFBuiCtGXKANaanuSTVkO+TM+dPxFYIEmEXvhLaNVrT/0W0zWKg6EZRYPBPBdGIjAReI
         JmRvF9XF0mMuGbICHN4wdijC7EyfI3hdyC4ypoa+E+0moI+wlvYVC+neFZJfh5g+fvMM
         X/b08HPu0W+wtgmLydeLMvmN78ammx+VR1o42FYWlTOHnHffcfZZqqglp2VowsGCoA53
         sHv1XDhuxNCJFqRZ+J4oF4sTcia0JD5iL5A0jOEV5CtRQx+LV8JEg+fZJTCmBHuzYobV
         RMOg==
X-Gm-Message-State: AOJu0YzkX09nxVjlVrcDcuPVMUhMkYYKe2DcoSkiJM5bG3p5xjp797fU
        ZJNSdkzTFnT4SnoPKNSY9H4CTQ==
X-Google-Smtp-Source: AGHT+IEkT16aKATtFm55qcW57SlcB1x4wElzEN+uRylbf+NHozoN4a3+LLiRLsuohCIJmlgWa1OL4A==
X-Received: by 2002:a7b:ca49:0:b0:40b:5e21:e276 with SMTP id m9-20020a7bca49000000b0040b5e21e276mr2343776wml.99.1701682514585;
        Mon, 04 Dec 2023 01:35:14 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4cb1:229e:8c33:122a])
        by smtp.gmail.com with ESMTPSA id fs16-20020a05600c3f9000b0040b48690c49sm14266219wmb.6.2023.12.04.01.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 01:35:13 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 02/10] gpio: wm831x: use gpiochip_dup_line_label()
Date:   Mon,  4 Dec 2023 10:35:01 +0100
Message-Id: <20231204093509.19225-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204093509.19225-1-brgl@bgdev.pl>
References: <20231204093509.19225-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/gpio/gpio-wm831x.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-wm831x.c b/drivers/gpio/gpio-wm831x.c
index 7eaf8a28638c..f7d5120ff8f1 100644
--- a/drivers/gpio/gpio-wm831x.c
+++ b/drivers/gpio/gpio-wm831x.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -160,18 +161,21 @@ static void wm831x_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	for (i = 0; i < chip->ngpio; i++) {
 		int gpio = i + chip->base;
 		int reg;
-		const char *label, *pull, *powerdomain;
+		const char *pull, *powerdomain;
 
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
+			dev_err(wm831x->dev, "Failed to duplicate label\n");
+			continue;
+		}
 
-		seq_printf(s, " gpio-%-3d (%-20.20s) ", gpio, label);
+		seq_printf(s, " gpio-%-3d (%-20.20s) ",
+			   gpio, label ?: "Unrequested");
 
 		reg = wm831x_reg_read(wm831x, WM831X_GPIO1_CONTROL + i);
 		if (reg < 0) {
-- 
2.40.1


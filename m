Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7DE802EB9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbjLDJfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbjLDJfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:35:13 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C8A134
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:35:17 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c0a0d068bso8917235e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701682516; x=1702287316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDkm1mz5JKda1Ie70um5gnCumWIdGzqKbagKhi4Mqgw=;
        b=Ljxd4lxaABYVLm5r3bNebUdRcZtxU7HsAZEFdR96QAbM7e1hNKQj1EtX+pUTN+EwuD
         iGAe9iMDj04DS3BZmEYfJOi1L0Qf2cDa+7xVBmNu7tReD9E/DPgVqMgfdY4BOTk6y3BH
         lbLzn7xTUb7fqYdkEsAjzvRtD7y7sAQCklJG804yZUwDcky4MUewHbCueT0WkSfiRtKl
         WpEK7EzWFiEZKXPepYbtIC9ODhn+7vMVre1kDHMh10VtGPacar9tJW7Z7PPJj+XkYnBY
         EQ08mLPpOibOdMOXK9YTnx9wAExCsmFaqBYj9v5Hxj5amH3+6ORUgKxt090bsWqmNQk6
         pX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701682516; x=1702287316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDkm1mz5JKda1Ie70um5gnCumWIdGzqKbagKhi4Mqgw=;
        b=K4ibNpXvnG0cIU/YE6LtUe34XM8Y3vDLmn9v4IM8PpZZX3sWGoNVnSkcf0k3H/cKhP
         M0mafhX9A08vT+Dk/BItpR13H1Y7bhSBxseaD7pXPRehHzFfDBXyIC/MG7/rDYrF3fqp
         0k2IF1NSCIin2LjcLChiNO1QvBWvphrLmSoS7O5ukPyXbfgMSCyKcJ+0yFEKmwIKNNAv
         s/EH4/aQrRNPQa0MFU7bkyag8ZOqVB2Z8lF6n6QoWfVDXtpbaooy5Db1My8CvgutNxzU
         Kz0i/UFfSa7q6FQGA41Qa1mtTTyYTG233Nmig5kVTt1gBIXMr6HLl9BCchZdZRtTnCfU
         qZ1Q==
X-Gm-Message-State: AOJu0Yxcop/zQGnrXfdzFeJngw15excZn0WY3dzg/E6T/ORwDlg2fK4t
        0Zz/UzsMvP3oNq6VlVRZbn2vNQ==
X-Google-Smtp-Source: AGHT+IG8j6GgcmneGkekjMxaAVZAOQL5vjLVSjwSnVPrBrikm52pKL8RtyTbjt6kyLLQHmJwOHZ5/A==
X-Received: by 2002:a05:600c:a41:b0:40c:d3a:2447 with SMTP id c1-20020a05600c0a4100b0040c0d3a2447mr288453wmq.87.1701682516457;
        Mon, 04 Dec 2023 01:35:16 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4cb1:229e:8c33:122a])
        by smtp.gmail.com with ESMTPSA id fs16-20020a05600c3f9000b0040b48690c49sm14266219wmb.6.2023.12.04.01.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 01:35:15 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 03/10] gpio: wm8994: use gpiochip_dup_line_label()
Date:   Mon,  4 Dec 2023 10:35:02 +0100
Message-Id: <20231204093509.19225-4-brgl@bgdev.pl>
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


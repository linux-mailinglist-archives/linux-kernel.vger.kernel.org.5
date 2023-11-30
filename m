Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7B87FF09F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345719AbjK3Nqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345787AbjK3Nqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:46:36 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B0F1725
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:39 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-33321a70bd9so391806f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701351998; x=1701956798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Sv99NjQCF32QfqStrxQNV++EDXzWOND44xPhDEPFwA=;
        b=RzoE4DJWVF3W3nkJlOJRdv4+NmcgoXiLB+gg1BmbJAdSjXdO6QHD0KtdwJ+12Fl3My
         55WXpqcLmbIhqfB6EXiyC3TOB4t4821ZMjkrX2BgMv+g/RKT0pGNt4btfGBlA661c49i
         FWG4egQtdxheJcTMecL/3iHGJ2F1A1sf55X5HMWQdtzYxnvUyZNHOhC6YeX1Oq//Y8H5
         xAEmCuCmY6y/ndwSGq8O4w9WCzjyLssVqySoFOm4Hw/o6elLOYT3mx5hy9+t3+IkLrWJ
         0jtXDfm3avWCkFD/JE6oXDJz91f74VpKSPmW8XzyKygh1SgtzXazFW4CeZw+rW9VmLlA
         HcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701351998; x=1701956798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Sv99NjQCF32QfqStrxQNV++EDXzWOND44xPhDEPFwA=;
        b=eN8CmiT5jIO/6xAYq4UrgGCOMH2uS4UECqNQHfBQRLtsM9BUNNcoB+3iXHIkRClyOb
         SvtFYBa0dr72ElPxC2txRmM4RhAuWk3+Zf+lJv5YTxmgkXWq28IotfPAr1wnV7Q3x9FX
         WhKng36PlQLlHgDZgeKEGyK3m4EcnEJ/Lc9yhiYRtWf8pORPgKCcgklhGlDyk6u27zZ7
         ruzuW9gje6BYAm0ZBTD4YVHIUjZzSwBykfZDRig+gd7IOdwkPbzKJJafdX8l/hBsjGe8
         iPWGD34l6PzKSq69gu0ucvfmPTwJv7JYl3DZ+xfXTGDhwXkq1J7cgglx0Fg8csTfarcC
         gUpg==
X-Gm-Message-State: AOJu0YwhMthGcgaQSDJ/we8B3JzKhrj2AKthRbWyIRCRN5RXivQ+tzy3
        9ZL1lXMPnHBURDlaYAw805i+/g==
X-Google-Smtp-Source: AGHT+IFFXiw8d4gEC87uJuGJeNe0IjCzYDScTUcvPWnXguWxDUdRf/gDmALnF5depRlp+rrGf1ryhQ==
X-Received: by 2002:a5d:6dcb:0:b0:332:fcd2:87fa with SMTP id d11-20020a5d6dcb000000b00332fcd287famr8728856wrz.27.1701351997780;
        Thu, 30 Nov 2023 05:46:37 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae84:904:6602:ec1e])
        by smtp.gmail.com with ESMTPSA id n18-20020adffe12000000b0032d2489a399sm1574824wrr.49.2023.11.30.05.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:46:36 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 02/10] gpio: wm831x: use gpiochip_dup_line_label()
Date:   Thu, 30 Nov 2023 14:46:22 +0100
Message-Id: <20231130134630.18198-3-brgl@bgdev.pl>
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


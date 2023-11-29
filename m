Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F847FD937
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjK2OYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjK2OYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:24:20 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD8AE1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:25 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c9bd3557cfso11505331fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701267864; x=1701872664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Sv99NjQCF32QfqStrxQNV++EDXzWOND44xPhDEPFwA=;
        b=KkU0Icqx8HR3nwLcQajkvSFBK6+OUPGRRyjgnUa1BO8ra9MFdWS/NPuH7KOwRzcrOR
         yzAR/a2ihBfjZPg+C9hGAQ7lGEWRRI62VXFF0iOVOQlgpvgw0s4O4V779l6jfUuTucXP
         VSzqwqawXHrNtaC+3bf7ey+Zx90e4+zRxXBelqlL5mHcBtuOrioNCnhLjK+/5QWSFV7G
         /0vWvU1pVhxTfiIcAbzUQwJIK6O+Tt2yIp2WaN7zBiohDgOD5nk+ZRSEG/sJakvuOdm8
         RXSsaJY2tpfR8arbUolhMOWoE+SrdIcmhEQVywHWOjJKQxOyHTlq+tVZj1zYcBgg7l73
         j8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701267864; x=1701872664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Sv99NjQCF32QfqStrxQNV++EDXzWOND44xPhDEPFwA=;
        b=gwfA+5rkSAoWqDIsEbIAQHWextn5wrsWLVflNG30kBZNoGipeHFfLd+K/FhMiT905D
         izly/ceRcOOHxnmRGq5N/FSotoo9jJy7NXcNK82qL1MOKMo4g7IC6s7LL+c0B9r4xoIg
         hKNybtp6xbG1IGI9A5fu/DZjSiFNSRfbZFgTxq1DypG3BYteursT/U7tnfI4U1b4B4iG
         qCVCSYsJOVW4CHnAmWMOyKlWnjYVv3dEpLiXpdvQx304qGDV0s/M39RgOZPorTfaNgDj
         LYzx7CXd9Ak6lt3PlLl9RxuHT1gUL4CjWymq3lThVBLlauFG3j93AsoCAxCkejqeWlsW
         zPUA==
X-Gm-Message-State: AOJu0YzPKsIUKFKgA2tzVdg7BLGWOZHcA8IpII0NOMGUyfm8OIhXExKs
        Lg06xe1reH3Dn7DHo+dCnHpD3A==
X-Google-Smtp-Source: AGHT+IEkczzI1R8jS+gFL7GKFMTH6r1tr8NT05t7eLAvQCb5G46R9vrMwpDmkFfL0LuzEN/A2vrYpQ==
X-Received: by 2002:a2e:8804:0:b0:2c9:b84a:1485 with SMTP id x4-20020a2e8804000000b002c9b84a1485mr2878937ljh.7.1701267864148;
        Wed, 29 Nov 2023 06:24:24 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4520:2f25:4d3a:4adf])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c3ba800b0040b34720206sm2406848wms.12.2023.11.29.06.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:24:23 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 02/10] gpio: wm831x: use gpiochip_dup_line_label()
Date:   Wed, 29 Nov 2023 15:24:03 +0100
Message-Id: <20231129142411.76863-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129142411.76863-1-brgl@bgdev.pl>
References: <20231129142411.76863-1-brgl@bgdev.pl>
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


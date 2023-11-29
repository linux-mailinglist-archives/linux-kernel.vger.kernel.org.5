Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922617FD93D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbjK2OYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjK2OYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:24:20 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E790419A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:26 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b40423df8so31815655e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701267865; x=1701872665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDkm1mz5JKda1Ie70um5gnCumWIdGzqKbagKhi4Mqgw=;
        b=LmLhgxQO3nHYMI2D6VsD6PUbZTI4P8P8pyL71/ah7j5htcKAuq+fZmhoQhie6rGmor
         EM0ExqKdJJ/qjlPCo1CK+sFFDHX23cP0LFR1Ohy3gQ9VauskBGHXtJxBbTI9hBGyfkgP
         wbRagLLQkNnlBc6ldAODpY370cVnp5PrScBcojZHEG5x+6I6SN2P5RUXHPRbNqbldIT7
         RAxjNp5OPdwL6TkFiU7IHgHcr9TthmxfotCSkMnFB0ak6+sWThNXrFKXqiaUDf7HVvTj
         vX7QukghLx/yXrgyIYVE4bT/EuacWr1UBEwzNGgVRVDQsUmve4N/bGRLaRDkH0crBs8G
         6eAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701267865; x=1701872665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDkm1mz5JKda1Ie70um5gnCumWIdGzqKbagKhi4Mqgw=;
        b=pTsSi6jlfdSgdMiw6gZIDeiPW39IIIZlGA10MFWXfFmoq7Z/7ZZaim9W7igKOCD9Bj
         UA97c1DgC8y1IEKAzXpscaQNo5Ebil2AzYXPdP6zhGMjZsNrtk2LeQ6b3m+B1UanvsKe
         28QL6Ho1gWFXtiE6cnajgwGDkwBChfiA1n+RDdKM6/yWh3jKVzrGSeKqbemwAuguR4Or
         7HWmCbb4hIz3LaKQnOkIsGzZTuUyBqPohwxR/+aGn0w8hfXCAQER3LK8YjJIUxB8fnQ8
         pT2W45P5HGWaLbdjxIQUuEvA8dfqwqCMGz5TXjOueZEVWFyjxWCNoTRGDfKuRrvZgQy6
         QGeQ==
X-Gm-Message-State: AOJu0YyJii0Sg09gAxKWiCAetfBLGqcDEcLbMrjqqu6QcOOnWK7eVGLJ
        Ovgs8yggn95HsgmEEC0GMVWwGQ8Fciowz6MymO0=
X-Google-Smtp-Source: AGHT+IGzwxqZ/cr1y8ySwFiJGA66fa+vba4/Je/dhnGCBrRLJyMyF58vXXnPj3KEdcBW2tko7WDfpw==
X-Received: by 2002:a05:600c:138e:b0:40b:3605:acda with SMTP id u14-20020a05600c138e00b0040b3605acdamr14504750wmf.25.1701267865284;
        Wed, 29 Nov 2023 06:24:25 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4520:2f25:4d3a:4adf])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c3ba800b0040b34720206sm2406848wms.12.2023.11.29.06.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:24:24 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 03/10] gpio: wm8994: use gpiochip_dup_line_label()
Date:   Wed, 29 Nov 2023 15:24:04 +0100
Message-Id: <20231129142411.76863-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129142411.76863-1-brgl@bgdev.pl>
References: <20231129142411.76863-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165CF7FF09E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345685AbjK3NrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345721AbjK3Nqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:46:39 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A4D10E5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:45 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-332ed1bd4cbso605720f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701352004; x=1701956804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lX1sqlEJJ4vEUK91SFq6mj5SEAnM+ha5YxcxRVGS6+w=;
        b=hPzNjZP3MiHNlaiBNK5uHoOFDkljjmXAmcylnoFm60bgMec4QC4X5skCapr3qftKoj
         PgR9V1jJg3RAPnvw7nxRVZGHqVMrpqrAtH0pxO71h7Ihfy7hGyL700YhG6gWF4cIHFux
         +eCppziCbu5N52REsxeqWAonVjw497Af7hLBVoD/6VUFEbZ01bPwA4iMUAGUIJqsHNT/
         b1biUc5LuPW2PI3W0Yk+RSMcUmYAQoTPnAv24qPVsboxDUO12E915sDm9jcu18CYRRVl
         H8rjZCZFUlBL4z1GdJk6pSEkm282W9ZIiIotZQY9ZbNwicOCJOyxEc/qVeOi5ywpjYbi
         RgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352004; x=1701956804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lX1sqlEJJ4vEUK91SFq6mj5SEAnM+ha5YxcxRVGS6+w=;
        b=PpAm0tyCeLW9IDrhoV4/Tm+yGwB7Mv1Yqaj498AteiXRYDt1e38Q4/MmE7ko0l4GF0
         12V2EOmcKz19lpWd2M3KKpyT+VH4FoKxJRZ/N4f7/jrHJA0wSXvMEo/zC9KjstX+NhgH
         1z08lrn9SVRMH0qI7m/HOS8DA/IIwv/4m7z4EK5X1FxrL908/4K5gTnq+sxzELuk+itm
         7b7rwjQzE6FyAAOB+Iwu4WyjD8CIk+CXR87wyKBrs1zg+uudf3q/uhPuLGAk93bxqnbo
         0waqqZ0MVdfj7MKGxYJgaqg2HwOl0/Hk4blRUqFCHhgYhwTU1dQQPIxsrhu7actOp/aO
         TmGA==
X-Gm-Message-State: AOJu0YzjByANexlW2gjDgXeqg5vuJ3uR/AW/VkctXSC/XL8AsuuMuleu
        bzAePPeiwQDaSMYcahDDvGr/yQ==
X-Google-Smtp-Source: AGHT+IEH8Mh7PFLu28rLEMPsJfxeGaU60dL2Y/lrZsr6Vmf/W1e5mS0Xhbaro9bpQTm02q7tKBDu7A==
X-Received: by 2002:adf:f305:0:b0:333:2e28:46f5 with SMTP id i5-20020adff305000000b003332e2846f5mr53628wro.1.1701352004522;
        Thu, 30 Nov 2023 05:46:44 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae84:904:6602:ec1e])
        by smtp.gmail.com with ESMTPSA id n18-20020adffe12000000b0032d2489a399sm1574824wrr.49.2023.11.30.05.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:46:43 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 07/10] pinctrl: baytrail: use gpiochip_dup_line_label()
Date:   Thu, 30 Nov 2023 14:46:27 +0100
Message-Id: <20231130134630.18198-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130134630.18198-1-brgl@bgdev.pl>
References: <20231130134630.18198-1-brgl@bgdev.pl>
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
 drivers/pinctrl/intel/pinctrl-baytrail.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 3cd0798ee631..3c8c02043481 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 #include <linux/array_size.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/gpio/driver.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -1173,7 +1174,6 @@ static void byt_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 		const char *pull_str = NULL;
 		const char *pull = NULL;
 		unsigned long flags;
-		const char *label;
 		unsigned int pin;
 
 		pin = vg->soc->pins[i].number;
@@ -1200,9 +1200,10 @@ static void byt_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 			seq_printf(s, "Pin %i: can't retrieve community\n", pin);
 			continue;
 		}
-		label = gpiochip_is_requested(chip, i);
-		if (!label)
-			label = "Unrequested";
+
+		char *label __free(kfree) = gpiochip_dup_line_label(chip, i);
+		if (IS_ERR(label))
+			continue;
 
 		switch (conf0 & BYT_PULL_ASSIGN_MASK) {
 		case BYT_PULL_ASSIGN_UP:
@@ -1231,7 +1232,7 @@ static void byt_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 		seq_printf(s,
 			   " gpio-%-3d (%-20.20s) %s %s %s pad-%-3d offset:0x%03x mux:%d %s%s%s",
 			   pin,
-			   label,
+			   label ?: "Unrequested",
 			   val & BYT_INPUT_EN ? "  " : "in",
 			   val & BYT_OUTPUT_EN ? "   " : "out",
 			   str_hi_lo(val & BYT_LEVEL),
-- 
2.40.1


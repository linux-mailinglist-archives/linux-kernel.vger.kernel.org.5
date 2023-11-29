Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E082B7FD948
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjK2OYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjK2OYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:24:32 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211D1D6C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:31 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c8879a1570so86867521fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701267869; x=1701872669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lX1sqlEJJ4vEUK91SFq6mj5SEAnM+ha5YxcxRVGS6+w=;
        b=cmui+8oUvf4Ks+gTyWIBhQm5JG7ZMZ4iUa+RgGSbI1FOXXh9qfUqryLfKlHRm/NsR8
         3sTfsLnrqes8B593KPQegLIqTkPCQIOTPGwqmxWQsxxNfg4po7gJhejOJJdSe2w0u5wA
         6ulnaQENKCaSj9XjN1tQiW9dcMQ0iNIwMbLAsSqIAJXYeUAbjnLbB7m3sOJu18bNTQEG
         7MYUe/nOcN3msrJCjSoDfUBtJg1ZtYInl6Qz+zmigAqKSkk5BXJ/3WdTlpPRKbj9wqZq
         zqYKZIj7A78lP+mkRl1K6S7ahdKTqSzi3Umd2dqBup5tKd7kR/FglystB0cuEw+uMHc2
         dkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701267869; x=1701872669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lX1sqlEJJ4vEUK91SFq6mj5SEAnM+ha5YxcxRVGS6+w=;
        b=e0SXF75sf9+RBz4J2pOqL+YYXDS+wr1eJThlKnd9eCz1Sce/nnXsoSYz8RCaA2ss8F
         wG3j18o+Hpovsgm4CyjQ5wTnNLifZdmOVZlXxcxkRVP7RWeKDGnbN//ow2EvLPQwUnYR
         DAp0L3AndlBBAfkAKeM7MM9QSX0P12tX+plhY54XTbIxttRZw1zUVCdxpWp2rGpT4t7h
         Jza9VzKoDRsKgGSVDp+8FzWDoVXVSue0JhcvDewNcpXEHIBUDGCSkozhsgnnz4FkP3Ub
         Y26RMoqYMQqrmAJ3Ec2WMh9jlkIUjjS1pZvO4IWI4vO4huAZI7JLM9Iitj61T2l42gU3
         VXJA==
X-Gm-Message-State: AOJu0YwsTQuoGo8iyqMowbA8mlrZdDyBS68ug2kskp0A1fx0Wj7z3+Xl
        Q1TEEELw2ODmKG5L2lyg30y9bg==
X-Google-Smtp-Source: AGHT+IFjEBWan0C97HdNCiQeMtPtXLlhZluROT5dGRXGCE0TfLtIbmQkWSsz4iIIEozMicZGD6j8hg==
X-Received: by 2002:a2e:9855:0:b0:2c9:c00a:c28e with SMTP id e21-20020a2e9855000000b002c9c00ac28emr1331701ljj.33.1701267869205;
        Wed, 29 Nov 2023 06:24:29 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4520:2f25:4d3a:4adf])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c3ba800b0040b34720206sm2406848wms.12.2023.11.29.06.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:24:28 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 07/10] pinctrl: baytrail: use gpiochip_dup_line_label()
Date:   Wed, 29 Nov 2023 15:24:08 +0100
Message-Id: <20231129142411.76863-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129142411.76863-1-brgl@bgdev.pl>
References: <20231129142411.76863-1-brgl@bgdev.pl>
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


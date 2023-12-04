Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF603802EC1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbjLDJgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjLDJfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:35:19 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDA4113
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:35:22 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40838915cecso43125095e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701682521; x=1702287321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lX1sqlEJJ4vEUK91SFq6mj5SEAnM+ha5YxcxRVGS6+w=;
        b=k/nTLUCJ6LFc9jAbF3VrnIECocahF8qiCl/z5yo7XN8BhWPV4MqrYXm1vgrMQf9hKp
         Kx62gzrG2Bmqd1OM6YJAYO7ikSZKl9HmT+Mvpzl/OSOD8bNMIHISz+1u4FkHsRx96JMR
         /jSgoLGvuAOdP6Wu+UkZZGbM6k4KSqZ8NBXkhTG2LYbaix3MpYq+ePs/QeuMOlFoPb3a
         X9SaPchFsX+SoeesY2a/S9hA/JdZYspq1aLO77xjjKcc5Io8NY/aCRlKNr3Cg9Op7oU2
         ae5fB2BUZkrzx/XCwYx1hGU7yjKVUg9jE/IXc5M1z6POSgyNGfPR5cxPDWvJbPNzj/15
         vMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701682521; x=1702287321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lX1sqlEJJ4vEUK91SFq6mj5SEAnM+ha5YxcxRVGS6+w=;
        b=piL0/YtlJTfDzHwP+VaJjDAsbh9xDd8rmpYw3+6lYIBqtL8Kjr1jM7EaYJSJqxPZy1
         rFN9RNNLG7FfJe8sXEx7vGYdj+oKMyoI6jQx66ns1cF0NdiRRArGpwN2FNLMTImG6WMa
         JFnF/gznC6PZL6x37owqom7nrxIRAfid1gdiV86f2BUvEgLfBvtojjEr0uv+o2KTqsmH
         m0z2SD1Hjlk59bpWCLBah4S5ifj44fO4vKkxXoovsUhjhol2nB9TX958jVRheLSOJrjL
         xsZtl7KU6thwDnT4DN9snXgXjQqiQDPoIl9lrp2Ev3VY7Ii624qD8CK/H73HbpxXTnfx
         /g4A==
X-Gm-Message-State: AOJu0Yx2jqZLN7iZGMdPPmMFhleXoSpdrD4vEtmPKlsmUMF/B4ucNC0Q
        GO1lCX+rk4QkfgeLawEe2SeP1g==
X-Google-Smtp-Source: AGHT+IFq4DBJmONbEWfXXbKiJ3kXh0xlYz/lUO6kayLYCeDzWPU9D0Wqi96fSt/UQSxXSGG9l7QZlg==
X-Received: by 2002:a05:600c:4fce:b0:40c:902:dc25 with SMTP id o14-20020a05600c4fce00b0040c0902dc25mr1059951wmq.51.1701682521118;
        Mon, 04 Dec 2023 01:35:21 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4cb1:229e:8c33:122a])
        by smtp.gmail.com with ESMTPSA id fs16-20020a05600c3f9000b0040b48690c49sm14266219wmb.6.2023.12.04.01.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 01:35:20 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 07/10] pinctrl: baytrail: use gpiochip_dup_line_label()
Date:   Mon,  4 Dec 2023 10:35:06 +0100
Message-Id: <20231204093509.19225-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204093509.19225-1-brgl@bgdev.pl>
References: <20231204093509.19225-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
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


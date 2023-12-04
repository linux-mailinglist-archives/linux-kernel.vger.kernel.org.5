Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49718802EBF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbjLDJfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbjLDJfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:35:14 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58149136
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:35:20 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c0a11a914so8843485e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701682519; x=1702287319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cffjJvUFWsxdgp9qJiLVkij+XoF+TZsz38c1WQZlyho=;
        b=aCxEbpksu1Qd6S2UOdyExLFlzGpiThUFwFt8nT+HZzKdS94b3g31TRo5NLa9jS5TGv
         bM/+8gCAJ9Lh9br0BGITvdg5ZLk+2e60EyjjsLBUPbOAAoR0UjhNBOSj+Dp/iazsTsMZ
         yXOaJbL4DiBoDcA7xpW5GIpn3kH5e4sW5c4ooc+irRENQH3j4DIPBMpFku8RfFoiykcU
         fdaJLhI32FHlyFXs0HW3yg1EpkK/bteqOQ+N53eznQThmQoAtVcq0wmddw6JK6T2rsua
         bmmBZdvVxcLRXia58OdJ+bxIKbuzrdrMnajs15Vxf80Y8cFyMhRcgw7NWlV3GxsSWUH4
         ckaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701682519; x=1702287319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cffjJvUFWsxdgp9qJiLVkij+XoF+TZsz38c1WQZlyho=;
        b=boAYYtdYgzLDgq2ffSWrA5AY7PsjFtd4rdCLw1txQ5uodKczxgix+neBfwIUhCcnzj
         043Sj17fyQzqqI9gSPT7gXZGTEZXlWAtF1DeKsf/jflYuGDAgs35J2u26V9PUrKNXWZY
         3vmAS2gAQvdMc0gBlHA8xqMfjFmmsocWyd5ZaWTSS/cL+Eym5z8pUdu1AljA9J/ygShe
         GuOve+Tl47jyeaRpKvoq/GC7EV0wMX7j1om6QwA/+t2NIsWG67UqjqcxqYhYnJgLEhzR
         EdxD9+5XFzKKCyUn6YQBezzldnS3qbPHZI/q78tVku6cOhjRWkLy4HAxBs9FeZyq5XFb
         t2dA==
X-Gm-Message-State: AOJu0YywCu0rU87vFIzBWAXaPszoVLl6PHfgpuMIIgTtGhjqR2K7s+Mf
        4tgQHN0Aufsk+sEynTrA/YkTkw==
X-Google-Smtp-Source: AGHT+IG5zgdmvymXaEV/9HDjU94CDsHzttR6WEf8JW7wnFekYp+m3ngvnASxirGcw0oJzT9gwgOS7A==
X-Received: by 2002:a05:600c:4708:b0:40b:3d9f:eedf with SMTP id v8-20020a05600c470800b0040b3d9feedfmr2257243wmo.15.1701682518591;
        Mon, 04 Dec 2023 01:35:18 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4cb1:229e:8c33:122a])
        by smtp.gmail.com with ESMTPSA id fs16-20020a05600c3f9000b0040b48690c49sm14266219wmb.6.2023.12.04.01.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 01:35:17 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 05/10] pinctrl: abx500: use gpiochip_dup_line_label()
Date:   Mon,  4 Dec 2023 10:35:04 +0100
Message-Id: <20231204093509.19225-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204093509.19225-1-brgl@bgdev.pl>
References: <20231204093509.19225-1-brgl@bgdev.pl>
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
 drivers/pinctrl/nomadik/pinctrl-abx500.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-abx500.c b/drivers/pinctrl/nomadik/pinctrl-abx500.c
index d3c32d809bac..80e3ac333136 100644
--- a/drivers/pinctrl/nomadik/pinctrl-abx500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-abx500.c
@@ -6,7 +6,9 @@
  *
  * Driver allows to use AxB5xx unused pins to be used as GPIO
  */
+
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
 #include <linux/init.h>
@@ -453,12 +455,11 @@ static void abx500_gpio_dbg_show_one(struct seq_file *s,
 				     unsigned offset, unsigned gpio)
 {
 	struct abx500_pinctrl *pct = pinctrl_dev_get_drvdata(pctldev);
-	const char *label = gpiochip_is_requested(chip, offset - 1);
 	u8 gpio_offset = offset - 1;
 	int mode = -1;
 	bool is_out;
 	bool pd;
-	int ret;
+	int ret = -ENOMEM;
 
 	const char *modes[] = {
 		[ABX500_DEFAULT]	= "default",
@@ -474,6 +475,10 @@ static void abx500_gpio_dbg_show_one(struct seq_file *s,
 		[ABX500_GPIO_PULL_UP]		= "pull up",
 	};
 
+	char *label __free(kfree) = gpiochip_dup_line_label(chip, offset - 1);
+	if (IS_ERR(label))
+		goto out;
+
 	ret = abx500_gpio_get_bit(chip, AB8500_GPIO_DIR1_REG,
 			gpio_offset, &is_out);
 	if (ret < 0)
-- 
2.40.1


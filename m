Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA037EC90D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjKOQuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjKOQuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:50:10 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981051A4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:50:06 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7b9bd9f8bfaso2637069241.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700067005; x=1700671805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/+c2VO8PV1RqLkhAzMdFyQNC3apc5LK2X9ZNQJCpQY=;
        b=pZ3F0WMxzknwX8Erg7N0MyTRtZdHeP/CSYxMYlbTW9KCnXX/GG6t7wT44v649yh3B6
         CMQBbFLPqEV6iQL/wmkHytQ6SjG98W1iUIL+E86SPT528c0JIdWPVXPQtl0tiHKQw+v2
         qrBWrgAxJ63rLPqpV55Orzog3Hl8cwF8EE+GjXl2lpoBxTjHKuHzZlh2ah0Pk8iaCV7r
         BNIyI4JsZ6SJbg2p/DxA2n+2d90tZSzeC8qO+UIpb6Wrnw24bo3ri1EQJrTSO03NYWPz
         By2gFNxqwrPgPk61wzqB5iY9LwKXeJqMIeSWIA2HSxxWIucZHfRmW80uF/Yz62vSc7nQ
         cv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067005; x=1700671805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/+c2VO8PV1RqLkhAzMdFyQNC3apc5LK2X9ZNQJCpQY=;
        b=SP3xwfAIZCq/Hkj7hN0RFFC7/YKzl1wZtN+86Z4fyB3OwCTdoBp8S4nGUyYZb+uprM
         dr0L+69mB3/RbToB9X5UON8MQ8nFb/3IfeIFUpDbGl0hXKDSbqySSFKlWM4Poiir86Ze
         TAVe/DY2C/UU4Eac+tYTP6j8R7rhHKFxKCtrOrBS+YHbM8uuRT40fQMu3NqszUki+Jm0
         BeEVIXFnjiWgW9x9qoL+w9iT0DNojItOowYnspGI9bcVxvSw5hZRleDkMU3JZBJtCrzI
         +qg9nLE0V/oQ1KpNTuLS0mw98MonXBDX2YZqkpEE7udFFOHayOe/KPBPYOvPjxHOlYKg
         qhlg==
X-Gm-Message-State: AOJu0YyDody6E0vLNEb03bzQHQostaeCz7nnDwwMdNBWm8+2t3u4rMdE
        OsGNrveeKN69AJHgtPlkFIDCcw==
X-Google-Smtp-Source: AGHT+IHOoVUBbpIgEyTvnyBKJGvAGhVu9Qj2aYtvhzH+QlMA+xwk5+Qd8WOs/1fmHihY3nCWNEfULQ==
X-Received: by 2002:a67:c218:0:b0:45d:9224:a898 with SMTP id i24-20020a67c218000000b0045d9224a898mr13122998vsj.16.1700067005671;
        Wed, 15 Nov 2023 08:50:05 -0800 (PST)
Received: from brgl-uxlite.. ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id mn16-20020a0562145ed000b00670a8921170sm658781qvb.112.2023.11.15.08.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:50:05 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/3] pinctrl: stop using gpiod_to_chip()
Date:   Wed, 15 Nov 2023 17:50:00 +0100
Message-Id: <20231115165001.2932350-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231115165001.2932350-1-brgl@bgdev.pl>
References: <20231115165001.2932350-1-brgl@bgdev.pl>
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

Don't dereference struct gpio_chip directly, use dedicated gpio_device
getters instead.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 1fa89be29b8f..0b4d07aea387 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -13,6 +13,7 @@
 #define pr_fmt(fmt) "pinctrl core: " fmt
 
 #include <linux/array_size.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -1649,8 +1650,8 @@ static int pinctrl_pins_show(struct seq_file *s, void *what)
 	const struct pinctrl_ops *ops = pctldev->desc->pctlops;
 	unsigned i, pin;
 #ifdef CONFIG_GPIOLIB
+	struct gpio_device *gdev __free(gpio_device_put) = NULL;
 	struct pinctrl_gpio_range *range;
-	struct gpio_chip *chip;
 	int gpio_num;
 #endif
 
@@ -1685,11 +1686,11 @@ static int pinctrl_pins_show(struct seq_file *s, void *what)
 			 * we need to get rid of the range->base eventually and
 			 * get the descriptor directly from the gpio_chip.
 			 */
-			chip = gpiod_to_chip(gpio_to_desc(gpio_num));
-		else
-			chip = NULL;
-		if (chip)
-			seq_printf(s, "%u:%s ", gpio_num - chip->gpiodev->base, chip->label);
+			gdev = gpiod_to_gpio_device(gpio_to_desc(gpio_num));
+		if (gdev)
+			seq_printf(s, "%u:%s ",
+				   gpio_num - gpio_device_get_base(gdev),
+				   gpio_device_get_label(gdev));
 		else
 			seq_puts(s, "0:? ");
 #endif
-- 
2.40.1


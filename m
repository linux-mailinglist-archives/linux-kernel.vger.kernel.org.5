Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545B37B06D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjI0O36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjI0O3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:29:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD3819F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:29:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4053cf48670so101218685e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695824982; x=1696429782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE8FiVQ373WPhEqnnd0k+Q8JE+kP4cy31sdBOoqrMw8=;
        b=sbouSzjOVd8ltn4tAEi/FEWXTjCdMfo/mYaQjAD8QmocqofoCee9CszmOgufxFCVtr
         SFfMPymQLA0G8W/k7/mcZRtET+jNBkM8rX7EiZjyRaT125jzTpRbNQ67eI63mq1jXRah
         WuSkaaXuF9l0wTzAe1kINn/2XtV+wLSc1CWB1vRGhKxsiE8+5GDTJZJ1YQDt3dNcCyTj
         O9P5PLTNbfbAzdHcoS3JxAvyzq4YVaCeaLyAAdWtE1Jz0/Jfk2UN+BbJz0vniAx5Xc5M
         D2wxKsmbow5aOtGic4+UHZkV3PyRevTELg5eQTNEsOU0LP7PPOcwS5T4JBwn6ZIp80kQ
         INEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824982; x=1696429782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oE8FiVQ373WPhEqnnd0k+Q8JE+kP4cy31sdBOoqrMw8=;
        b=VpcDW4MsBg2paLKssp9/fPQGvzrQciAoTw06tU9Etkz1EddqwQAReEVJK74f30FMBW
         zqWYWUrONCilt1cLNMv++hg6zwpcJ438E2ssIuqCK2n7F+Xs+NVgObiRKsr3MYYRbs/j
         6d+aroZtz+9IQfFbVfSZSV+dTKvqvWNtFLQFYvfeN0BoCe4plV3F3XMkPsvOmVPYV/Mc
         Fc6szW9FC39keS+OlpGwCHXnWr+dWSkrFh3gDl+ua0ApDu+dZP/vvok8gAxKk3oIAanE
         Fdi6cID0zlN07FZeafV2jRZlYqnGSymhRfPIXZSYlNowjU75B8pvYRvzJ3M0wEvne+Mw
         3YUQ==
X-Gm-Message-State: AOJu0Yy/om5+gBJVMomj1HxTdl9KNCF6WxOJI4CLZF1bP24ZaFPH4gOv
        PpQae7IrKOdEanDfFnW1xJPi0Q==
X-Google-Smtp-Source: AGHT+IENPJmvmWp0g+dGS8v34l0Gtx+t4X9kF9+AMSE7rr76Glskj8nT9+aAmH3ht7mwRdRjm2lEug==
X-Received: by 2002:a1c:4c13:0:b0:401:be77:9a50 with SMTP id z19-20020a1c4c13000000b00401be779a50mr2103103wmf.8.1695824982520;
        Wed, 27 Sep 2023 07:29:42 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4bb6:1525:9e22:4a15])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm20448303wmh.35.2023.09.27.07.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:29:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 08/11] gpio: of: replace gpiochip_find_* with gpio_device_find_*
Date:   Wed, 27 Sep 2023 16:29:28 +0200
Message-Id: <20230927142931.19798-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927142931.19798-1-brgl@bgdev.pl>
References: <20230927142931.19798-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We're porting all users of gpiochip_find() to using gpio_device_find().
Update the OF GPIO code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-of.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 58c0bbe9d569..5ea97c14d77a 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -127,10 +127,10 @@ static int of_gpiochip_match_node_and_xlate(struct gpio_chip *chip, void *data)
 				chip->of_xlate(chip, gpiospec, NULL) >= 0;
 }
 
-static struct gpio_chip *of_find_gpiochip_by_xlate(
-					struct of_phandle_args *gpiospec)
+static struct gpio_device *
+of_find_gpio_device_by_xlate(struct of_phandle_args *gpiospec)
 {
-	return gpiochip_find(gpiospec, of_gpiochip_match_node_and_xlate);
+	return gpio_device_find(gpiospec, of_gpiochip_match_node_and_xlate);
 }
 
 static struct gpio_desc *of_xlate_and_get_gpiod_flags(struct gpio_chip *chip,
@@ -372,7 +372,6 @@ static struct gpio_desc *of_get_named_gpiod_flags(const struct device_node *np,
 		     const char *propname, int index, enum of_gpio_flags *flags)
 {
 	struct of_phandle_args gpiospec;
-	struct gpio_chip *chip;
 	struct gpio_desc *desc;
 	int ret;
 
@@ -384,13 +383,15 @@ static struct gpio_desc *of_get_named_gpiod_flags(const struct device_node *np,
 		return ERR_PTR(ret);
 	}
 
-	chip = of_find_gpiochip_by_xlate(&gpiospec);
-	if (!chip) {
+	struct gpio_device *gdev __free(gpio_device_put) =
+				of_find_gpio_device_by_xlate(&gpiospec);
+	if (!gdev) {
 		desc = ERR_PTR(-EPROBE_DEFER);
 		goto out;
 	}
 
-	desc = of_xlate_and_get_gpiod_flags(chip, &gpiospec, flags);
+	desc = of_xlate_and_get_gpiod_flags(gpio_device_get_chip(gdev),
+					    &gpiospec, flags);
 	if (IS_ERR(desc))
 		goto out;
 
@@ -822,16 +823,16 @@ static int of_gpiochip_match_node(struct gpio_chip *chip, void *data)
 	return device_match_of_node(&chip->gpiodev->dev, data);
 }
 
-static struct gpio_chip *of_find_gpiochip_by_node(struct device_node *np)
+static struct gpio_device *of_find_gpio_device_by_node(struct device_node *np)
 {
-	return gpiochip_find(np, of_gpiochip_match_node);
+	return gpio_device_find(np, of_gpiochip_match_node);
 }
 
 static int of_gpio_notify(struct notifier_block *nb, unsigned long action,
 			  void *arg)
 {
+	struct gpio_device *gdev __free(gpio_device_put) = NULL;
 	struct of_reconfig_data *rd = arg;
-	struct gpio_chip *chip;
 	int ret;
 
 	/*
@@ -848,11 +849,11 @@ static int of_gpio_notify(struct notifier_block *nb, unsigned long action,
 		if (of_node_test_and_set_flag(rd->dn, OF_POPULATED))
 			return NOTIFY_DONE;
 
-		chip = of_find_gpiochip_by_node(rd->dn->parent);
-		if (chip == NULL)
+		gdev = of_find_gpio_device_by_node(rd->dn->parent);
+		if (!gdev)
 			return NOTIFY_DONE;	/* not for us */
 
-		ret = of_gpiochip_add_hog(chip, rd->dn);
+		ret = of_gpiochip_add_hog(gpio_device_get_chip(gdev), rd->dn);
 		if (ret < 0) {
 			pr_err("%s: failed to add hogs for %pOF\n", __func__,
 			       rd->dn);
@@ -865,11 +866,11 @@ static int of_gpio_notify(struct notifier_block *nb, unsigned long action,
 		if (!of_node_check_flag(rd->dn, OF_POPULATED))
 			return NOTIFY_DONE;	/* already depopulated */
 
-		chip = of_find_gpiochip_by_node(rd->dn->parent);
-		if (chip == NULL)
+		gdev = of_find_gpio_device_by_node(rd->dn->parent);
+		if (!gdev)
 			return NOTIFY_DONE;	/* not for us */
 
-		of_gpiochip_remove_hog(chip, rd->dn);
+		of_gpiochip_remove_hog(gpio_device_get_chip(gdev), rd->dn);
 		of_node_clear_flag(rd->dn, OF_POPULATED);
 		return NOTIFY_OK;
 	}
-- 
2.39.2


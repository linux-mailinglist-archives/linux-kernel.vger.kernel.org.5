Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906AC7B06D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjI0OaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjI0O3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:29:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F123C12A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:29:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32336a30d18so3385549f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695824984; x=1696429784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEkEuyWHPwtkJqqx/zp65rsN/kW+vWLAZiPV4yAfo60=;
        b=T53P/S8/9T02hxwplxxwI5HIC6fr8wFlqdkgtP2ngolZGGyetwJ2OesfrNIJvamTYS
         1KidFj6uhuN1LYs8XhqPz5ftp/0k6f366XXwijR2Qf4JWqPqN5wyCrv74tQ62c0diTdQ
         NsVzgg2zhYJ3wN8S/odCzkspPbl76jzMgml5pMqbUFwkxZ/AB1VlA9/oCQxwwzNCfOlV
         klGOy0zium87DDvTYfDBzoeas+R4ddkY2mOYSlIUJSptOk8nanwVOEZMDIDTeI7xi1o8
         hvr8x787z1GFZz/bpcaWZsK39DcIgUnU9kbEE9XJy1RfF3wiy5cVAlNl4Pw+zBE/H4Rb
         kWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824984; x=1696429784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEkEuyWHPwtkJqqx/zp65rsN/kW+vWLAZiPV4yAfo60=;
        b=GTBWin1b3K9ZPMnUgpIBQusQD5+Cm88cUccFdGAVc442LKwNCxbZ6uaRF4AaRLSn3I
         EKMebnBooMOYZzH3g4gZCmj9gDJS+/Nt6K/di+/2zs0Ly4x1wh2U65udHn7O9Je3Uzx1
         aWQ36jMHs+7pbycNpV5be90r4EXFPw/438MLFfccxo7YmylSjjSKVpmNqw9SsIqDfp8x
         VEly7CkPEPh3VaZ6rYKay9oEUpWhkOZPZQqbmFJdqu/QDLnwwWLvh/EFoGTCC4Uv2XKL
         bsocLUQ0LMoXxgw6m8y5mqIeX7yOc2zaKHk/Ib/seoTcPP34oJCZVmyei19HusrC7Tde
         MXsQ==
X-Gm-Message-State: AOJu0YxzCxubjFdoOmGQHU9bP3uAl8ryREA371JdXx/CTfX6JjWd3fPc
        svyy7X+gLWPKs6pHhLa9xG4MJBGwtNcaW3qJE64=
X-Google-Smtp-Source: AGHT+IFNb8l5Y6LCipefds19t5fIoqseWun2vJIxoTJoGFcSPsfaLd8QhwvSbDrL6X4lB0QT/ACnZg==
X-Received: by 2002:a5d:67cd:0:b0:323:306e:65cf with SMTP id n13-20020a5d67cd000000b00323306e65cfmr2124281wrw.10.1695824984517;
        Wed, 27 Sep 2023 07:29:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4bb6:1525:9e22:4a15])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm20448303wmh.35.2023.09.27.07.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:29:44 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 10/11] gpio: swnode: replace gpiochip_find() with gpio_device_find_by_label()
Date:   Wed, 27 Sep 2023 16:29:30 +0200
Message-Id: <20230927142931.19798-11-brgl@bgdev.pl>
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
Update the swnode GPIO code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-swnode.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index b5a6eaf3729b..fa52bdb1a29a 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -31,22 +31,17 @@ static void swnode_format_propname(const char *con_id, char *propname,
 		strscpy(propname, "gpios", max_size);
 }
 
-static int swnode_gpiochip_match_name(struct gpio_chip *chip, void *data)
+static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
 {
-	return !strcmp(chip->label, data);
-}
+	const struct software_node *gdev_node;
+	struct gpio_device *gdev;
 
-static struct gpio_chip *swnode_get_chip(struct fwnode_handle *fwnode)
-{
-	const struct software_node *chip_node;
-	struct gpio_chip *chip;
-
-	chip_node = to_software_node(fwnode);
-	if (!chip_node || !chip_node->name)
+	gdev_node = to_software_node(fwnode);
+	if (!gdev_node || !gdev_node->name)
 		return ERR_PTR(-EINVAL);
 
-	chip = gpiochip_find((void *)chip_node->name, swnode_gpiochip_match_name);
-	return chip ?: ERR_PTR(-EPROBE_DEFER);
+	gdev = gpio_device_find_by_label(gdev_node->name);
+	return gdev ?: ERR_PTR(-EPROBE_DEFER);
 }
 
 struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
@@ -55,7 +50,6 @@ struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
 {
 	const struct software_node *swnode;
 	struct fwnode_reference_args args;
-	struct gpio_chip *chip;
 	struct gpio_desc *desc;
 	char propname[32]; /* 32 is max size of property name */
 	int error;
@@ -77,12 +71,17 @@ struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
 		return ERR_PTR(error);
 	}
 
-	chip = swnode_get_chip(args.fwnode);
+	struct gpio_device *gdev __free(gpio_device_put) =
+					swnode_get_gpio_device(args.fwnode);
 	fwnode_handle_put(args.fwnode);
-	if (IS_ERR(chip))
-		return ERR_CAST(chip);
+	if (IS_ERR(gdev))
+		return ERR_CAST(gdev);
 
-	desc = gpiochip_get_desc(chip, args.args[0]);
+	/*
+	 * FIXME: The GPIO device reference is put at return but the descriptor
+	 * is passed on. Find a proper solution.
+	 */
+	desc = gpio_device_get_desc(gdev, args.args[0]);
 	*flags = args.args[1]; /* We expect native GPIO flags */
 
 	pr_debug("%s: parsed '%s' property of node '%pfwP[%d]' - status (%d)\n",
-- 
2.39.2


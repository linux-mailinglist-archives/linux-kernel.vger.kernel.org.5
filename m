Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6231D7C5383
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjJKMUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345956AbjJKMU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:20:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123AD199A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso63112225e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026188; x=1697630988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvacOMAsy6FdrV/J7pT291xHl3F2giUmTM8V2Tkqr7o=;
        b=vZqVc+bSZpgKue+0l6Q1VTop2/2jZ+nZmSd/VDRiWukvrMLRnBG3PrHmC0LK8aQ9Uk
         Y7LVFfGVp7/nYZj7uZaZNx0Sdx4b/C5i6NmGIcmPAkZXCWFwVk52sXBvl64twnbs7zTS
         /G9Za2x+fJFVf/1CjNrLU3Fnh32b7Dzjk7zCGgtqazmi2bzr80AV2Di4R959h1gfvetP
         Lywh5EgGb3+RDcR3ZoZUXv+qOCptt4Q4gR8Ire8g7+AUuyN7+46OVFml7P03AgyaEklG
         OrrIHd7sUCRCvN3k3EfLF/1gtJC1GgXjd4AkxwVXMFHIQTkd/73+KgWGGVr/WRIkuK90
         pXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026188; x=1697630988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvacOMAsy6FdrV/J7pT291xHl3F2giUmTM8V2Tkqr7o=;
        b=kW44taCe1d8D0IaECdjyZDVzxmtt1vJtKTk/x4Ki4GcWozFBiPDL0IOepKqGObRkVs
         aLpIhrfh4PuXDuXIkxQDn3NV+Lfv1M/kjMcVt5vvYe2+sxbb2rZZDoLOCUKPJ0tKw8Yt
         zwcfVG5QQ+NG0oMSPS+QVyjBROx6R05fJC1fDA20dX3T6DrSTJqCcbkuA1MHSYLFTQus
         y+oLdIda7tpEcpvj73PN9waWRQ5s9Fznp0YDjg0OitqRHyvOSwhfvwDtwlD6M3EsSm3f
         qb6OrAYiDp6O6KpX6ZDzJkftYq8z9bwU++2RMqTIQ8XkUzMLwgY6FWJW2sFesAd3EGV/
         qexw==
X-Gm-Message-State: AOJu0YyoW8LgmpJOCuUBTOV4tjah003RFkYlofJZ/3ARU4dYPu8jFj7Y
        Mo5lHSW2807NHnwhQNy54IkvLQ==
X-Google-Smtp-Source: AGHT+IHSvLmetJI0wFfvlmR2PQ5I2awpBh6SmY4ieaJBT9vT+eeMUOlqRrInwp+zikj18o3KLWhR8w==
X-Received: by 2002:a7b:cb8b:0:b0:3fb:e189:3532 with SMTP id m11-20020a7bcb8b000000b003fbe1893532mr18370414wmi.20.1697026188168;
        Wed, 11 Oct 2023 05:09:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:47 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 44/62] pinctrl: change the signature of pinctrl_match_gpio_range()
Date:   Wed, 11 Oct 2023 14:08:12 +0200
Message-Id: <20231011120830.49324-45-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011120830.49324-1-brgl@bgdev.pl>
References: <20231011120830.49324-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Modify pinctrl_match_gpio_range() to be in line with public GPIO
helpers and take a pair of GPIO chip & offset as arguments.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 2eebd86ca2bc..dbc59e409439 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -292,13 +292,15 @@ static inline int gpio_to_pin(struct pinctrl_gpio_range *range,
 /**
  * pinctrl_match_gpio_range() - check if a certain GPIO pin is in range
  * @pctldev: pin controller device to check
- * @gpio: gpio pin to check taken from the global GPIO pin space
+ * @gc: GPIO chip structure from the GPIO subsystem
+ * @offset: hardware offset of the GPIO relative to the controller
  *
  * Tries to match a GPIO pin number to the ranges handled by a certain pin
  * controller, return the range or NULL
  */
 static struct pinctrl_gpio_range *
-pinctrl_match_gpio_range(struct pinctrl_dev *pctldev, unsigned gpio)
+pinctrl_match_gpio_range(struct pinctrl_dev *pctldev, struct gpio_chip *gc,
+			 unsigned int offset)
 {
 	struct pinctrl_gpio_range *range;
 
@@ -306,8 +308,8 @@ pinctrl_match_gpio_range(struct pinctrl_dev *pctldev, unsigned gpio)
 	/* Loop over the ranges */
 	list_for_each_entry(range, &pctldev->gpio_ranges, node) {
 		/* Check if we're in the valid range */
-		if (gpio >= range->base &&
-		    gpio < range->base + range->npins) {
+		if ((gc->base + offset) >= range->base &&
+		    (gc->base + offset) < range->base + range->npins) {
 			mutex_unlock(&pctldev->mutex);
 			return range;
 		}
@@ -395,7 +397,7 @@ static int pinctrl_get_device_gpio_range(struct gpio_chip *gc,
 	list_for_each_entry(pctldev, &pinctrldev_list, node) {
 		struct pinctrl_gpio_range *range;
 
-		range = pinctrl_match_gpio_range(pctldev, gc->base + offset);
+		range = pinctrl_match_gpio_range(pctldev, gc, offset);
 		if (range) {
 			*outdev = pctldev;
 			*outrange = range;
-- 
2.39.2


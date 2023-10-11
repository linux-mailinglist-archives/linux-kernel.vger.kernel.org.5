Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A687C53BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346974AbjJKMXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjJKMWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:22:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DF3D65
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40666aa674fso63481255e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026198; x=1697630998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7umkbBqVb4ekwk4qPLSYyQOmuMCZz6eMQtDEbYpxk8=;
        b=DqSVuYfWO6wFHSbp4Ht0wm2VI9IyxdCllQeF6HEAfv6SlHI3oX6lwdMlAMXWy0JxOH
         o3EOBywgILVV48Mox6D84LkZXuUqxgvlfyjRIsF76OemVFZ4BFAkoVDC0rL3gBjhP5my
         cgYBj7AK7Z2elHr+5YkMjaeon7B0yHjs7yg5S4ktBqT0hYBNahJ/oGh2ufXqMx42O7E4
         aMMt6q+XhBRSiKvx5z288LBSEzVM57bw/WOFQWvtnD6Pq3H0+CBPcmUohJwL5mRprDxk
         BTqlT1vOzRVy/+LwpytBMNdKcEcbnqJJ1MFpxTCVmOSbmPC8vsbwC8EmqGcelPoa8zlI
         sZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026198; x=1697630998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7umkbBqVb4ekwk4qPLSYyQOmuMCZz6eMQtDEbYpxk8=;
        b=X24IO91bnrwUUUTEaXkwLMgaM0RXpNjbAEUKeyhwxLDqPyhuJBbm8cJw1Eb321txJH
         VFY5bpJvjivL6jg8ypB/JMEFoQ5T7/iEmt3CFJJK94RVjyoyOug1HF9326g9xbplfHB2
         rp8M3W3CfJlzHF0rm+tQkeIlWwZyqBVCb5K4j+wgcd+rCF7d0NBSZ1WejnSUE2eEYtTn
         i02AsO2JCbTevWNYLrRQYTd1DBul+UZ3AFgt/5KDLnJNkshqvPppylsC9OEMF4Roz1SP
         Imvir03bBWa9s6SVZTOGJ5zCJrsjkIJrJxLmqGp+6ev1ytmLodqdm6kMvsJUQLNkoz4+
         jYQw==
X-Gm-Message-State: AOJu0YzGyGLHvtD42B6Rt4cVYZ907iOJod+/BCoqVOnujVO1Kbw3cJqu
        5eTjxQlwQGrvZFdsV9hvgEdWeA==
X-Google-Smtp-Source: AGHT+IFyfLQRfRNQv/Aap//7J0BkR5itENHvEINMkF1uwUWU+yQ5zfYwaAVKTN5evBQyvYr8MKWv0Q==
X-Received: by 2002:a05:600c:220d:b0:406:5301:317c with SMTP id z13-20020a05600c220d00b004065301317cmr17875372wml.6.1697026198647;
        Wed, 11 Oct 2023 05:09:58 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:58 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 56/62] pinctrl: cirrus: drop the wrapper around pinctrl_gpio_direction_input()
Date:   Wed, 11 Oct 2023 14:08:24 +0200
Message-Id: <20231011120830.49324-57-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011120830.49324-1-brgl@bgdev.pl>
References: <20231011120830.49324-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

pinctrl_gpio_direction_input() now has the same signature as the
wrapper around it so we can drop them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
index 1ba89cf279fb..012b0a3bad5a 100644
--- a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
+++ b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
@@ -506,11 +506,6 @@ static void cs42l43_gpio_set(struct gpio_chip *chip, unsigned int offset, int va
 	pm_runtime_put(priv->dev);
 }
 
-static int cs42l43_gpio_direction_in(struct gpio_chip *chip, unsigned int offset)
-{
-	return pinctrl_gpio_direction_input(chip, offset);
-}
-
 static int cs42l43_gpio_direction_out(struct gpio_chip *chip,
 				      unsigned int offset, int value)
 {
@@ -551,7 +546,7 @@ static int cs42l43_pin_probe(struct platform_device *pdev)
 
 	priv->gpio_chip.request = gpiochip_generic_request;
 	priv->gpio_chip.free = gpiochip_generic_free;
-	priv->gpio_chip.direction_input = cs42l43_gpio_direction_in;
+	priv->gpio_chip.direction_input = pinctrl_gpio_direction_input;
 	priv->gpio_chip.direction_output = cs42l43_gpio_direction_out;
 	priv->gpio_chip.add_pin_ranges = cs42l43_gpio_add_pin_ranges;
 	priv->gpio_chip.get = cs42l43_gpio_get;
-- 
2.39.2


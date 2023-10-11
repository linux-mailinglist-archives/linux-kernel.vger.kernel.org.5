Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393E97C533E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346876AbjJKMLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346804AbjJKMKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:10:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B6DB9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so6117549f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026174; x=1697630974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLr8az2DF4wzR/3h2HT0nDrMk6XnIw1qWiC4OXYx06k=;
        b=s2bPdBFheeHzXbfVzwIuAlmfSgOD7HjgZbn9JRs9BXNYYrBQfMEO70Ad40viokEoU6
         eFg2L3V5UG8EqHZbN/Zah/Yxboe3EI22aWfmyHLRoqAvC6RztBQT5ePC6GTDpqZDHZng
         CLA50ubS6oc6/Qu8ift9Ip9B3sGZwruyJnftYbokfw+uTZSovg4XnzMbkhKF6oFApYhC
         Mh9MIBsz0HrFqYp8kF3P7nnOEbv2DM096yzQwEgOsoihgJSjPy7OkE6AfauEdd5zY3pC
         R6HyOkxLTmGwQAgQU7kfZ9kYktOhFOjxsk9EeG0JVTPv2B7Jh7KzfFyBHS5nzIj+OEoe
         LVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026174; x=1697630974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLr8az2DF4wzR/3h2HT0nDrMk6XnIw1qWiC4OXYx06k=;
        b=r3S+ylkF41hW9aPFuI9ti27svjIquThxalaBv5YyFm07gfbACMSPG77xx8AoZPR7Gj
         FJuEw8EjRPIfDgok4RwBvlPEmZBy4JRrs2n4aLMMzlHekgAKbUR6r73p+qkH5lQLoHkh
         pNmIEwBdFv7zRs2I77BvyJvwjkpCoS14dk9T5DcbJIHlVRycfat6GGdwmg+V/ET1cZUi
         8zkR+jyQlYD6OpJmt2FDoFT7iHPaevqY3UkTYR5HUttj44Jrg4ZuT4n249fptb45OHj1
         bsoTwLhwl+6j7D6e80PeuCJYRG+SrrzrC/Z8QhVYnHZulqiAlVzFmsuxkyW83h+qbsqo
         JeJw==
X-Gm-Message-State: AOJu0YxXGSw0QUhjSQX9gbSpLRcGrXOI2MKns3vRltLQNQlwAf8lmfQO
        Cp0xrN+MENzvA++m1zUsLXgK1g==
X-Google-Smtp-Source: AGHT+IEZ6rmGbIUuFrjMLFMQuyy/G9fH2uyqDPNfpC7oz+a/6MrX1LMoVNkVrzInMAPjIzAKDkD5jg==
X-Received: by 2002:adf:fc4c:0:b0:319:785a:fce0 with SMTP id e12-20020adffc4c000000b00319785afce0mr18642562wrs.26.1697026174482;
        Wed, 11 Oct 2023 05:09:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:34 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 30/62] pinctrl: remove pinctrl_gpio_can_use_line()
Date:   Wed, 11 Oct 2023 14:07:58 +0200
Message-Id: <20231011120830.49324-31-brgl@bgdev.pl>
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

There are no more users of pinctrl_gpio_can_use_line() so remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/core.c           | 12 +++---------
 include/linux/pinctrl/consumer.h |  1 -
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 13a6fa85c462..024e3825fa98 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -755,7 +755,7 @@ int pinctrl_get_group_selector(struct pinctrl_dev *pctldev,
 	return -EINVAL;
 }
 
-bool pinctrl_gpio_can_use_line(unsigned gpio)
+bool pinctrl_gpio_can_use_line_new(struct gpio_chip *gc, unsigned int offset)
 {
 	struct pinctrl_dev *pctldev;
 	struct pinctrl_gpio_range *range;
@@ -767,13 +767,13 @@ bool pinctrl_gpio_can_use_line(unsigned gpio)
 	 * we're probably dealing with GPIO driver
 	 * without a backing pin controller - bail out.
 	 */
-	if (pinctrl_get_device_gpio_range(gpio, &pctldev, &range))
+	if (pinctrl_get_device_gpio_range(gc->base + offset, &pctldev, &range))
 		return true;
 
 	mutex_lock(&pctldev->mutex);
 
 	/* Convert to the pin controllers number space */
-	pin = gpio_to_pin(range, gpio);
+	pin = gpio_to_pin(range, gc->base + offset);
 
 	result = pinmux_can_be_used_for_gpio(pctldev, pin);
 
@@ -781,12 +781,6 @@ bool pinctrl_gpio_can_use_line(unsigned gpio)
 
 	return result;
 }
-EXPORT_SYMBOL_GPL(pinctrl_gpio_can_use_line);
-
-bool pinctrl_gpio_can_use_line_new(struct gpio_chip *gc, unsigned int offset)
-{
-	return pinctrl_gpio_can_use_line(gc->base + offset);
-}
 EXPORT_SYMBOL_GPL(pinctrl_gpio_can_use_line_new);
 
 /* This function is deprecated and will be removed. Don't use. */
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index c95c13983376..105a4b0c1c14 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -26,7 +26,6 @@ struct pinctrl_state;
 #ifdef CONFIG_PINCTRL
 
 /* External interface to pin control */
-bool pinctrl_gpio_can_use_line(unsigned gpio);
 bool pinctrl_gpio_can_use_line_new(struct gpio_chip *gc, unsigned int offset);
 int pinctrl_gpio_request(unsigned gpio);
 int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset);
-- 
2.39.2


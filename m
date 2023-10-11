Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D347C534E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbjJKMMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbjJKMMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:12:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858F110C2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405524e6769so5546535e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026176; x=1697630976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63WjOp9UsiT59ywyo99tyOEp/CpCY6vvpVWnONIBEpw=;
        b=peZ6Fsn4XUud0jFzjDcUHU7bu940Yb+Qq18xQh6tfTox0KEXXlHg0GzaVQBzZ1WrkW
         8LC6khX/Mqs5oj0I66uhoMua09XwyvbfO1RjDKdbsw2M+ntfysESyl9teV3K7WUuHivy
         PJNqjWhVX8sdgY9YGUpHOIiT0ZTigNSTZzLvKtmsO6lTuTZlStqC2LW3B0f7tJrVtUKS
         les8SHyNm34qh101w2wcR3UkdelzO6WU+P4ExnZp66nu1w6vmFQktbIfcedUFAaX2uHA
         1Y0Rcbp9XC85zRbXe9Jny/5cv5O99Wb0ZTT5075oFCkPakSTl9q2R7zDLRIIZFRzSJpU
         NF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026176; x=1697630976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63WjOp9UsiT59ywyo99tyOEp/CpCY6vvpVWnONIBEpw=;
        b=iLqrfq6AMv7zq0/+B76TWxIOYJxctGT8Be1z9YWyVCJ4HPyIqCMoUw6rNnQHLrDD4Q
         GP5Y13cmfy96+McVT4w6i9ooUZ02QWTNPWfKzYBn3ZU0w0PWf+yUIp9E20R5h8NSvyMg
         QVmgARtek8LofmNA++nU4cy6ZckvQAJUcyU2HLHv9LPHYTOaq6+1LiCdTEcXKxdS0hoo
         ipAv6dDOI+ybLZHEYHs1dcfN3+QtIAwgP82GvTXb3eE6+euyYrjPoKQ1bLXh/2pdlZZC
         euBIktOHm+9p1ne+NpPdr+NaRcSI06uXI4cISKhwy09+Zbu3hDhBm+mkxUXf1tdLKxAN
         oTXw==
X-Gm-Message-State: AOJu0YwPuzva9JTMV8siVKGlZ/+niiDuPOprl8ejUh18p7AEqJd9QM3N
        pykoyGvsJqfbRTpn1Ukvtybrdw==
X-Google-Smtp-Source: AGHT+IEGqgu5V+Pg/7nLvW82pyAyz6O9E0Gf6z4or3apid/QwBxQIkmDYnSVBUM+m6s5v++vocBDJw==
X-Received: by 2002:a05:600c:895:b0:405:3be0:c78d with SMTP id l21-20020a05600c089500b004053be0c78dmr13871009wmp.3.1697026176573;
        Wed, 11 Oct 2023 05:09:36 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:36 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 32/62] pinctrl: remove pinctrl_gpio_free()
Date:   Wed, 11 Oct 2023 14:08:00 +0200
Message-Id: <20231011120830.49324-33-brgl@bgdev.pl>
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

There are no more users of pinctrl_gpio_free() so remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/core.c           | 41 +++++++++++++-------------------
 include/linux/pinctrl/consumer.h |  1 -
 2 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 837d35b0e5c3..6e163841d145 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -819,29 +819,6 @@ int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset)
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_request_new);
 
-/* This function is deprecated and will be removed. Don't use. */
-void pinctrl_gpio_free(unsigned gpio)
-{
-	struct pinctrl_dev *pctldev;
-	struct pinctrl_gpio_range *range;
-	int ret;
-	int pin;
-
-	ret = pinctrl_get_device_gpio_range(gpio, &pctldev, &range);
-	if (ret) {
-		return;
-	}
-	mutex_lock(&pctldev->mutex);
-
-	/* Convert to the pin controllers number space */
-	pin = gpio_to_pin(range, gpio);
-
-	pinmux_free_gpio(pctldev, pin, range);
-
-	mutex_unlock(&pctldev->mutex);
-}
-EXPORT_SYMBOL_GPL(pinctrl_gpio_free);
-
 /**
  * pinctrl_gpio_free_new() - free control on a single pin, currently used as GPIO
  * @gc: GPIO chip structure from the GPIO subsystem
@@ -853,7 +830,23 @@ EXPORT_SYMBOL_GPL(pinctrl_gpio_free);
  */
 void pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset)
 {
-	return pinctrl_gpio_free(gc->base + offset);
+	struct pinctrl_gpio_range *range;
+	struct pinctrl_dev *pctldev;
+	int ret, pin;
+
+	ret = pinctrl_get_device_gpio_range(gc->base + offset, &pctldev,
+					    &range);
+	if (ret)
+		return;
+
+	mutex_lock(&pctldev->mutex);
+
+	/* Convert to the pin controllers number space */
+	pin = gpio_to_pin(range, gc->base + offset);
+
+	pinmux_free_gpio(pctldev, pin, range);
+
+	mutex_unlock(&pctldev->mutex);
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_free_new);
 
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index ffce8d7dd0d3..467f02b0aa98 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -28,7 +28,6 @@ struct pinctrl_state;
 /* External interface to pin control */
 bool pinctrl_gpio_can_use_line_new(struct gpio_chip *gc, unsigned int offset);
 int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset);
-void pinctrl_gpio_free(unsigned gpio);
 void pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset);
 int pinctrl_gpio_direction_input(unsigned gpio);
 int pinctrl_gpio_direction_input_new(struct gpio_chip *gc,
-- 
2.39.2


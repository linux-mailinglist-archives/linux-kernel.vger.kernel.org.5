Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64C2786ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjHXI4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbjHXIzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:55:52 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4460610FB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:55:50 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ff9abf18f9so9996957e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692867348; x=1693472148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+6GA2aSSzjMIpYzS9IyphBftmr15QYQINEEJHnRuPlg=;
        b=HK5OHNsjOXmSg54H0vmXIKUU7xtCKB+PI5mVI5O/uyeRX63OQyA+8DPXQZ+FNNAwzA
         gtWVJ7avEWjCii8rWu6w6setTlOCjfrSm/whPNgMQ4Ruo2tpODLw38yjDX5KICc2nclg
         vlYreC/HHRndRHqcMimZ5VDXNhtvOaZ6sDfgkssWiVC41F8+inal5xt0ksEjWC7LcGlF
         NJyrNo0hSat6YaS9FeoVMOUcaolrpZQNqLJaLSeXCxb4iPkcCWGtIgZXmKnkHtkproWY
         bxDEyGRy6XJclv9PaSohpDMXu/+jONicNtjGSNyC9s+IlLTqL6II3UfnSom7vUTML6D4
         t+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692867348; x=1693472148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6GA2aSSzjMIpYzS9IyphBftmr15QYQINEEJHnRuPlg=;
        b=deZwETNjhWrQK+mY81Wf5Hvy/2Ni97sbwDO3bHKVuFtZWAo4GzaeeUDNtKgDMnYCZ/
         TdkQoAzRFIxyDvyB8/nx9A8t0sAfKn5Op0dj6MJmQ6fqK5O9juTKksQ7Rqf1VOW+7lLQ
         JvD0Jn3LGKys9Y7XhrkhMZ1xRlyDOmkuplB8ReLTcNogs7yZVU6S2y6655fj8my2nEyC
         8b9Ud2IWhBr8pc0MYjRh5PN+HtX+F9tHDQdxkS5nRiLP1PNX3HhDOLSVhD168WsJvy+F
         wcn5pgTeoH6V2wTKgpF5MWAR7WHhN9sGXTg2m7uUEXmTs43smNLBvTdg5kdjnGmud0e5
         O3ig==
X-Gm-Message-State: AOJu0Yw1uIvGAENXG88jcuGUq0wwY5F2XSwYEwRwsyBysRGEVJOtcBWL
        Mymo/o/r1cbkqYOT7t8GbHrLxQ==
X-Google-Smtp-Source: AGHT+IFWXDT3TqF+psIqd+hSiyZ6asUmU93AmVQQUGQ0Oc5a8zhMSy2rP+ao4X3JpENaKqIPqsym/w==
X-Received: by 2002:a05:6512:3e9:b0:4ff:95c:e158 with SMTP id n9-20020a05651203e900b004ff095ce158mr8804640lfq.64.1692867347584;
        Thu, 24 Aug 2023 01:55:47 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2a30:8709:b99d:e2bd])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fe29dc0ff2sm2021347wmc.21.2023.08.24.01.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 01:55:47 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] gpiolib: notify user-space about line state changes triggered by kernel
Date:   Thu, 24 Aug 2023 10:55:44 +0200
Message-Id: <20230824085544.110417-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We currently only emit CHANGED_CONFIG events when the user-space changes
GPIO config. We won't be notified if changes come from in-kernel. Let's
call the notifier chain whenever kernel users change direction or any of
the active-low, debounce or consumer name settings. We don't notify the
user-space about the persistence as the uAPI has no notion of it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- use the gpiod_line_state_notify() helper
- reorder the code in gpiod_set_debounce() for better readability

 drivers/gpio/gpiolib.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 40a0022ea719..1cb7731550ca 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2439,6 +2439,7 @@ int gpiod_direction_input(struct gpio_desc *desc)
 	}
 	if (ret == 0) {
 		clear_bit(FLAG_IS_OUT, &desc->flags);
+		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
 		ret = gpio_set_bias(desc);
 	}
 
@@ -2484,8 +2485,10 @@ static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 		gc->set(gc, gpio_chip_hwgpio(desc), val);
 	}
 
-	if (!ret)
+	if (!ret) {
 		set_bit(FLAG_IS_OUT, &desc->flags);
+		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
+	}
 	trace_gpio_value(desc_to_gpio(desc), 0, val);
 	trace_gpio_direction(desc_to_gpio(desc), 0, ret);
 	return ret;
@@ -2672,9 +2675,16 @@ EXPORT_SYMBOL_GPL(gpiod_set_config);
 int gpiod_set_debounce(struct gpio_desc *desc, unsigned int debounce)
 {
 	unsigned long config;
+	int ret;
 
 	config = pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, debounce);
-	return gpiod_set_config(desc, config);
+	ret = gpiod_set_config(desc, config);
+	if (ret)
+		return ret;
+
+	gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(gpiod_set_debounce);
 
@@ -2723,6 +2733,7 @@ void gpiod_toggle_active_low(struct gpio_desc *desc)
 {
 	VALIDATE_DESC_VOID(desc);
 	change_bit(FLAG_ACTIVE_LOW, &desc->flags);
+	gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
 }
 EXPORT_SYMBOL_GPL(gpiod_toggle_active_low);
 
@@ -3330,6 +3341,7 @@ int gpiod_set_consumer_name(struct gpio_desc *desc, const char *name)
 
 	kfree_const(desc->label);
 	desc_set_label(desc, name);
+	gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
 
 	return 0;
 }
-- 
2.39.2


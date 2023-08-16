Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E96277E15E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245089AbjHPMVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245076AbjHPMUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:20:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A306E109
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:20:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-3fe5695b180so58726865e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692188437; x=1692793237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBA1IVl8UDrUaAnJphV0hWGX9hyQzKWTZG3aW+04r/w=;
        b=uMRrmYNn8OhxPbzEV75US9J4Qp1kutfTE6aCNbx3JPT8CgSYkIreOHTMZoTuI5E5K2
         DJsFU3qL0dW2325cH96CCoG1sT6euM3YvFl7WpN/VOK1qNRXyrczMNVu1fTlia4xI5zA
         i1B7qrZQN3sGfET4pinIppZaDWQ4T5lAp5/39j2/hNY4GOndSb/nlr8anxQvZGVxPQ7T
         CepXRxPuOkmtqwGJBTF972YXnn9VhjWRXOs/msMFpVywbDgfTVSbFy636vLJjyToh+aC
         Vgk3/zzLy0c+RMbnZGMh9a6bqaEW4c9K+yM16WJcWZcixZJyiYyTlcNRhBvjxADi61RT
         HBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692188437; x=1692793237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBA1IVl8UDrUaAnJphV0hWGX9hyQzKWTZG3aW+04r/w=;
        b=Dmxtc3BTvxuXBvZDgiibdkl/6riXHEK0VlukhsCYBuvCwIFD2mPqjDc0MLLLmWYMkM
         CYu0djPJa1IRBdhpbDbGbv6p3Gyeh+5kqjRyquZRLNlnlzntBCMuz0j+Z4nxK/u2lCIa
         1yz6hxzfc2C8Zwpcc2NFTknz9RWyG/daA1zUV6aSYZZGyPC0yKelAGmLEhsFyUDPYevp
         AkBbe8cHb74nNmiGuxqzUIlBEYgfb6PYO4TG5w3pnDBRnSJ+5SNKdIZQnxWWvou74Gh+
         HW6OHvLR2AkcjjgzdnJqkShDI6aZujP94p5tX3oRJ7ZH0G6qCAVG9h6KraYJ/ZXcCpG3
         P21g==
X-Gm-Message-State: AOJu0Yz5V8DvGeDATPnlBhl6Ojn+WbAE/upI2Y+Vi07Okto/VM6TkhSn
        spVB70F+bF0Zt0tMSmdHzoyqDw==
X-Google-Smtp-Source: AGHT+IG1i8Q4sLfL31T9MsIoX7SkF8QEPazR8Ad7Rpp4u1ezh5QqceyHDr+yieA/tOxrDBu6ETL2lQ==
X-Received: by 2002:a05:600c:215:b0:3fc:a8:dc3c with SMTP id 21-20020a05600c021500b003fc00a8dc3cmr1215136wmi.37.1692188436544;
        Wed, 16 Aug 2023 05:20:36 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:55ba:c083:817:86f])
        by smtp.gmail.com with ESMTPSA id e6-20020adffd06000000b003196b1bb528sm14566112wrr.64.2023.08.16.05.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:20:36 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/5] gpio: cdev: ignore notifications other than line status changes
Date:   Wed, 16 Aug 2023 14:20:28 +0200
Message-Id: <20230816122032.15548-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816122032.15548-1-brgl@bgdev.pl>
References: <20230816122032.15548-1-brgl@bgdev.pl>
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

In preparation for extending the role of the GPIO device's blocking
notifier, make sure the callback used by the character device's file
descriptor data checks the action argument and only reacts to one of the
line state change values. Also: relax the kerneldoc describing the
notifier as it will have more responsibilities soon.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 35 +++++++++++++++++++++++------------
 drivers/gpio/gpiolib.h      |  3 +--
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 0a33971c964c..062521e1a9e0 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2502,22 +2502,33 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 {
 	struct gpio_chardev_data *cdev = to_gpio_chardev_data(nb);
 	struct gpio_v2_line_info_changed chg;
-	struct gpio_desc *desc = data;
+	struct gpio_desc *desc;
 	int ret;
 
-	if (!test_bit(gpio_chip_hwgpio(desc), cdev->watched_lines))
-		return NOTIFY_DONE;
+	switch (action) {
+	case GPIO_V2_LINE_CHANGED_REQUESTED:
+	case GPIO_V2_LINE_CHANGED_RELEASED:
+	case GPIO_V2_LINE_CHANGED_CONFIG:
+		desc = data;
 
-	memset(&chg, 0, sizeof(chg));
-	chg.event_type = action;
-	chg.timestamp_ns = ktime_get_ns();
-	gpio_desc_to_lineinfo(desc, &chg.info);
+		if (!test_bit(gpio_chip_hwgpio(desc), cdev->watched_lines))
+			return NOTIFY_DONE;
 
-	ret = kfifo_in_spinlocked(&cdev->events, &chg, 1, &cdev->wait.lock);
-	if (ret)
-		wake_up_poll(&cdev->wait, EPOLLIN);
-	else
-		pr_debug_ratelimited("lineinfo event FIFO is full - event dropped\n");
+		memset(&chg, 0, sizeof(chg));
+		chg.event_type = action;
+		chg.timestamp_ns = ktime_get_ns();
+		gpio_desc_to_lineinfo(desc, &chg.info);
+
+		ret = kfifo_in_spinlocked(&cdev->events, &chg, 1,
+					  &cdev->wait.lock);
+		if (ret)
+			wake_up_poll(&cdev->wait, EPOLLIN);
+		else
+			pr_debug_ratelimited("lineinfo event FIFO is full - event dropped\n");
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
 
 	return NOTIFY_OK;
 }
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index cca81375f127..de7b3b60f7ca 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -38,8 +38,7 @@
  * or name of the IP component in a System on Chip.
  * @data: per-instance data assigned by the driver
  * @list: links gpio_device:s together for traversal
- * @notifier: used to notify subscribers about lines being requested, released
- *            or reconfigured
+ * @notifier: used to notify subscribers about gpio_device events
  * @sem: protects the structure from a NULL-pointer dereference of @chip by
  *       user-space operations when the device gets unregistered during
  *       a hot-unplug event
-- 
2.39.2


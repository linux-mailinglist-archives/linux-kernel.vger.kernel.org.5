Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9913577FE25
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354582AbjHQSuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354568AbjHQSuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:50:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556C52D57
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:50:11 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe9c20f449so1629565e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692298210; x=1692903010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xjFbKJBDBiBFY+aycvUJbh13JjRxLaBnyPofJylkh8=;
        b=oLsg3/sOQZMmhARANNVu9DA/4a1GJa2yVTbOqFkstZ+qh3hMta52sfZC32MJZffNLo
         PzGgRckYbKjsqQ2UJ+R0vUsswARErk0XLgdSvMiFbwMDIWL0+onda9b8l/DILKvGxZZh
         welcaKpIimSIXHVPvLywgiYataXRNy+D4JVoa9JCD4jTQxIbE5vWtR+79MBVZpHr3wog
         uylZ/PoVr/6d7TwfLCMgOZ/N+j0J3ka57S9lZWCIjeEAv0MkQlVCcEzD2HXxDFfAqT53
         WrefbmfiGPnNxebLwMj3UIwRnAoonhlNwxjgEtqKGaC73ppj+fW+LAbhsAnmllvkWFHi
         QluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692298210; x=1692903010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xjFbKJBDBiBFY+aycvUJbh13JjRxLaBnyPofJylkh8=;
        b=BrDhp0PMmUa4ORGrN7g5KsIE6mMeiiOk/by9rWkzsxSiLVwjOmFxKYY4OH1Yh26/cL
         9pXCB0lOic07xBl/bJQx+oPX//y/FTXRS2aSzNZy+pbgOe13lmC7EyZZjGtTooaPTHr4
         j8r9goD2sMdVWVOJq0wLmf7iA0+fTUFZvlycVhhvCFCnuvgPqxNpaSRO3LICiqXRPElk
         tQ6gFeNDnm9YywaLpxytEUPAxz2ndQlEsDWA0gZU20ZWsRo1GoYQmW0D+zbJhyE6ffuQ
         w08CW0yHL8FJHSpAk6WMIueYXAeib5CfOuFrZBpZyMQmveNWmqJM4gGbHm/ivz1nrBOS
         10Mg==
X-Gm-Message-State: AOJu0YzsOnrxfh/EmDxKmgcSRtQWeRJnYeq/cYW/lC7GO05Cek/CZDTF
        DvYf9iKlbs/JWViTJDBvz6mBAQ==
X-Google-Smtp-Source: AGHT+IFnKrGwy2wg7vBEDHiNNdtTnpnDVZuMTc5dfF3B5Kr/iaOuiSby3ZWQkJE9UxwLAvPQ3n7jeA==
X-Received: by 2002:a05:600c:2299:b0:3fe:ba7:f200 with SMTP id 25-20020a05600c229900b003fe0ba7f200mr481524wmf.20.1692298209949;
        Thu, 17 Aug 2023 11:50:09 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2f99:c690:b4da:e3d2])
        by smtp.gmail.com with ESMTPSA id a23-20020a05600c225700b003fe1cdbc33dsm3963020wmm.9.2023.08.17.11.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 11:50:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 3/6] gpiolib: add a second blocking notifier to struct gpio_device
Date:   Thu, 17 Aug 2023 20:49:55 +0200
Message-Id: <20230817184958.25349-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230817184958.25349-1-brgl@bgdev.pl>
References: <20230817184958.25349-1-brgl@bgdev.pl>
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

Add a new blocking notifier to struct gpio_device and use it to notify
subscribers about the GPIO device being unregistered from the device
model.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 1 +
 drivers/gpio/gpiolib.c      | 1 +
 drivers/gpio/gpiolib.h      | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index df30d17f9e29..f95e1b110311 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2749,4 +2749,5 @@ int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
 void gpiolib_cdev_unregister(struct gpio_device *gdev)
 {
 	cdev_device_del(&gdev->chrdev, &gdev->dev);
+	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 769ca2333b7a..0737952882cd 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -842,6 +842,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	spin_unlock_irqrestore(&gpio_lock, flags);
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
+	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
 	init_rwsem(&gdev->sem);
 
 #ifdef CONFIG_PINCTRL
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 7dd06ef45d44..54012605b4a4 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -40,6 +40,8 @@
  * @list: links gpio_device:s together for traversal
  * @line_state_notifier: used to notify subscribers about lines being
  *                       requested, released or reconfigured
+ * @device_notifier: used to notify character device wait queues about the GPIO
+ *                   device being unregistered
  * @sem: protects the structure from a NULL-pointer dereference of @chip by
  *       user-space operations when the device gets unregistered during
  *       a hot-unplug event
@@ -64,6 +66,7 @@ struct gpio_device {
 	void			*data;
 	struct list_head        list;
 	struct blocking_notifier_head line_state_notifier;
+	struct blocking_notifier_head device_notifier;
 	struct rw_semaphore	sem;
 
 #ifdef CONFIG_PINCTRL
-- 
2.39.2


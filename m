Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DB07A21D7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbjIOPED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbjIOPDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:03:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710032703
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:03:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-403004a96eeso24334085e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694790214; x=1695395014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AG+MBGFlKyeqAoI+zBkkhuwZdyh02KZ6W2Oat6+x/rc=;
        b=lo08M29/S8Ch6GA1Fi7eCGWgf9Ni+B+3SGHBw/M+1NwJ8x8Dry5xj9ByPK+WA0lcRr
         FEpQYv6zoyLLniYO9UvF/oQtW0QvH/rZahNI6oQbgYax6h4CVsOz1bKOYbjXKhjPaJiU
         LbYFCgN/ol63Dezd2kNVpQ0j+ah3WEl7YQV2gkcJTj+ZqXsHZEdtF16Rugz5OTMA5Vln
         Fn+zfcDQZ/qU1gtYM5aL1oW0f9a6EENQTruSA+6zRwe3j3AuuMU9ggmD0jQMrt4qmApb
         OMqG9W5gyz6qu+5tPJrvsOww5U5Lz/U2Ur4XGiXeOkFVRkSwQFMiksCTR3zjY8zQW31X
         ExBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790214; x=1695395014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AG+MBGFlKyeqAoI+zBkkhuwZdyh02KZ6W2Oat6+x/rc=;
        b=CNQTR/VuDYAo+C7Ow4cj+9XRKOyJzbHj4ITt46v0XwGAfwkvF037Xb7B37Fhc3Eotj
         Azmfurju5/dKNlS8J2gV0CTUBLc6y+hdRNi2b3/Xj51R1N3nU8sR4YD6A4Erc5JSEl8Z
         V5Xm80MXSZlZ//b5MIJdDi5hZ3WUpM3Nw0utpHX6gjN2n1OAmWqKmALZR60D0v+JjCoq
         K8Rwd//xp7CnUrjY2RwndUkMSCCHYPNkvlxpH/jFSc5RLIlbVF0HqQCK0jyRGn1GRd0u
         g5w+ZsVTOTuQTOt69YWXMmqH+V/Jel9tFoyH3opXzReZoHzbvoz9lBZQGd+VRYX1VY1a
         pvVA==
X-Gm-Message-State: AOJu0Yyn9Ms7OEMh7cgcYTsFAyhq6hoLL4uWa4bUp6gUisZ23ZRxngDo
        3/qRlg57ei4zn2vEDJPEiQffcQ==
X-Google-Smtp-Source: AGHT+IGshzGAMvrTRC4iP67Dr5MQUtAKWXFbAVfdOvaRGoEw9o4pAJ923+byIZL4PBwy8MvNtRM4Xw==
X-Received: by 2002:a05:600c:378f:b0:401:d258:ad26 with SMTP id o15-20020a05600c378f00b00401d258ad26mr1690953wmr.19.1694790213635;
        Fri, 15 Sep 2023 08:03:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:aa19:4569:aeeb:c0d3])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fef19bb55csm4853369wmb.34.2023.09.15.08.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:03:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 03/11] gpiolib: provide gpio_device_find()
Date:   Fri, 15 Sep 2023 17:03:18 +0200
Message-Id: <20230915150327.81918-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915150327.81918-1-brgl@bgdev.pl>
References: <20230915150327.81918-1-brgl@bgdev.pl>
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

gpiochip_find() is wrong and its kernel doc is misleading as the
function doesn't return a reference to the gpio_chip but just a raw
pointer. The chip itself is not guaranteed to stay alive, in fact it can
be deleted at any point. Also: other than GPIO drivers themselves,
nobody else has any business accessing gpio_chip structs.

Provide a new gpio_device_find() function that returns a real reference
to the opaque gpio_device structure that is guaranteed to stay alive for
as long as there are active users of it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c      | 71 +++++++++++++++++++++++++++----------
 include/linux/gpio/driver.h |  3 ++
 2 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f84ad54d8dbd..0371d23f0a46 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1014,16 +1014,10 @@ void gpiochip_remove(struct gpio_chip *gc)
 }
 EXPORT_SYMBOL_GPL(gpiochip_remove);
 
-/**
- * gpiochip_find() - iterator for locating a specific gpio_chip
- * @data: data to pass to match function
- * @match: Callback function to check gpio_chip
+/*
+ * FIXME: This will be removed soon.
  *
- * Similar to bus_find_device.  It returns a reference to a gpio_chip as
- * determined by a user supplied @match callback.  The callback should return
- * 0 if the device doesn't match and non-zero if it does.  If the callback is
- * non-zero, this function will return to the caller and not iterate over any
- * more gpio_chips.
+ * This function is depracated, don't use.
  */
 struct gpio_chip *gpiochip_find(void *data,
 				int (*match)(struct gpio_chip *gc,
@@ -1031,21 +1025,62 @@ struct gpio_chip *gpiochip_find(void *data,
 {
 	struct gpio_device *gdev;
 	struct gpio_chip *gc = NULL;
-	unsigned long flags;
 
-	spin_lock_irqsave(&gpio_lock, flags);
-	list_for_each_entry(gdev, &gpio_devices, list)
-		if (gdev->chip && match(gdev->chip, data)) {
-			gc = gdev->chip;
-			break;
-		}
-
-	spin_unlock_irqrestore(&gpio_lock, flags);
+	gdev = gpio_device_find(data, match);
+	if (gdev) {
+		gc = gdev->chip;
+		gpio_device_put(gdev);
+	}
 
 	return gc;
 }
 EXPORT_SYMBOL_GPL(gpiochip_find);
 
+/**
+ * gpio_device_find() - find a specific GPIO device
+ * @data: data to pass to match function
+ * @match: Callback function to check gpio_chip
+ *
+ * Returns:
+ * New reference to struct gpio_device.
+ *
+ * Similar to bus_find_device(). It returns a reference to a gpio_device as
+ * determined by a user supplied @match callback. The callback should return
+ * 0 if the device doesn't match and non-zero if it does. If the callback
+ * returns non-zero, this function will return to the caller and not iterate
+ * over any more gpio_devices.
+ *
+ * The callback takes the GPIO chip structure as argument. During the execution
+ * of the callback function the chip is protected from being freed. TODO: This
+ * actually has yet to be implemented.
+ *
+ * If the function returns non-NULL, the returned reference must be freed by
+ * the caller using gpio_device_put().
+ */
+struct gpio_device *gpio_device_find(void *data,
+				     int (*match)(struct gpio_chip *gc,
+						  void *data))
+{
+	struct gpio_device *gdev;
+
+	/*
+	 * Not yet but in the future the spinlock below will become a mutex.
+	 * Annotate this function before anyone tries to use it in interrupt
+	 * context like it happened with gpiochip_find().
+	 */
+	might_sleep();
+
+	guard(spinlock_irqsave)(&gpio_lock);
+
+	list_for_each_entry(gdev, &gpio_devices, list) {
+		if (gdev->chip && match(gdev->chip, data))
+			return gpio_device_get(gdev);
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(gpio_device_find);
+
 static int gpiochip_match_name(struct gpio_chip *gc, void *data)
 {
 	const char *name = data;
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 1cedbc3d3200..6ad1f1a8ef2e 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -608,6 +608,9 @@ int devm_gpiochip_add_data_with_key(struct device *dev, struct gpio_chip *gc,
 struct gpio_chip *gpiochip_find(void *data,
 				int (*match)(struct gpio_chip *gc, void *data));
 
+struct gpio_device *gpio_device_find(void *data,
+				int (*match)(struct gpio_chip *gc, void *data));
+
 struct gpio_device *gpio_device_get(struct gpio_device *gdev);
 void gpio_device_put(struct gpio_device *gdev);
 
-- 
2.39.2


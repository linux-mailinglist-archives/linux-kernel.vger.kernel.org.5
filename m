Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31C577FE22
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354576AbjHQSug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354557AbjHQSuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:50:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEC62D57
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:50:09 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe4cdb727cso1901285e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692298208; x=1692903008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PekFEtrOYZxrIpSwnRFffcXubMgkAQwr8swW+ILwpfg=;
        b=IjBKcNqkZ4YPS5JZ5HtdtiCT+pNDh3PfOoIW246n5IIh3ntKzN+YMtsxh9uZNa40dL
         5mc+RvqNedtLOpH9L7GKIoinBm1cpn3eVhJT4jKoNXRcLHfeZGjIvHwAjY6SaCFaOrSD
         NKmYpgXIYcWZyW4j6zQSQFrEzC55PXEB5z3l8vUAFs3LBd7hi8wC9ukxYzhVuEv7gZtR
         OfzYyMDrPf66xEkwWOwpXFcELPyN2HSecFY08JwCb71g+rkuNnH4nGxJmfo6gVEhze/s
         J5hWz2yNuhFGXtbw2M/Z9JsQaikVsBfkRJCzX8pua5spNz7payeSjz2kESdpRWaBKZy+
         tNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692298208; x=1692903008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PekFEtrOYZxrIpSwnRFffcXubMgkAQwr8swW+ILwpfg=;
        b=BA9TX7+hoWvOGKM47UIrTdT8+t0dnpt0rUTA3TNTKLuTgzhz4IkDOHkIvge+yzbi16
         Gr2T/9HbkCHrF4xUjWT8IY2d6Rz5TFmNpIbxsLgPPQajY6yFbR0Fi8cYtyCRy16lM7j/
         yK5TdJAU4hew9cVnYDJvlYOY2EcNRyZS8uqCOGDBJJ4m+pxLl+14FQA4NQpObBzxVVFw
         vjKtbofWdLVysk4hKBjctdQhSkFzfWjXbv9ulLq1jLol7k+ZNm/S6Fg35eTc1ygaSI3d
         qlrsCELzGqOTmb1DHNtUcz5+c5FDsm3HwfU49haUNUfXV5gibXC5Et/yClACeZtWxeKB
         tpYg==
X-Gm-Message-State: AOJu0YwMSJZlu2OTPEmpbUMJYuFHmPtz3A8PNe6y3xSCpPdWDu8U6JeP
        E0CoZPKTtp9HBb0/PU8pke6uPA==
X-Google-Smtp-Source: AGHT+IH5WbcaWSn5QIWPOiMc7sNvzhoPyDrUanyCOyoTBOzTeoJvf4Crgt8aMBUGe/OhxLfXVTplQw==
X-Received: by 2002:a05:600c:2805:b0:3fc:3f31:4233 with SMTP id m5-20020a05600c280500b003fc3f314233mr401739wmb.38.1692298207922;
        Thu, 17 Aug 2023 11:50:07 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2f99:c690:b4da:e3d2])
        by smtp.gmail.com with ESMTPSA id a23-20020a05600c225700b003fe1cdbc33dsm3963020wmm.9.2023.08.17.11.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 11:50:07 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 1/6] gpiolib: rename the gpio_device notifier
Date:   Thu, 17 Aug 2023 20:49:53 +0200
Message-Id: <20230817184958.25349-2-brgl@bgdev.pl>
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

Change the generic "notifier" name to "line_state_notifier" in order to
reflect its purpose in preparation for adding a second notifier which
will be used to notify wait queues about device unregistering.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 16 ++++++++--------
 drivers/gpio/gpiolib.c      |  6 +++---
 drivers/gpio/gpiolib.h      |  6 +++---
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 0a33971c964c..9ee8604f32e1 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -230,7 +230,7 @@ static long linehandle_set_config(struct linehandle_state *lh,
 				return ret;
 		}
 
-		blocking_notifier_call_chain(&desc->gdev->notifier,
+		blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
 					     GPIO_V2_LINE_CHANGED_CONFIG,
 					     desc);
 	}
@@ -414,7 +414,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 				goto out_free_lh;
 		}
 
-		blocking_notifier_call_chain(&desc->gdev->notifier,
+		blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
 					     GPIO_V2_LINE_CHANGED_REQUESTED, desc);
 
 		dev_dbg(&gdev->dev, "registered chardev handle for line %d\n",
@@ -1407,7 +1407,7 @@ static long linereq_set_config_unlocked(struct linereq *lr,
 
 		WRITE_ONCE(line->edflags, edflags);
 
-		blocking_notifier_call_chain(&desc->gdev->notifier,
+		blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
 					     GPIO_V2_LINE_CHANGED_CONFIG,
 					     desc);
 	}
@@ -1720,7 +1720,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 
 		lr->lines[i].edflags = edflags;
 
-		blocking_notifier_call_chain(&desc->gdev->notifier,
+		blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
 					     GPIO_V2_LINE_CHANGED_REQUESTED, desc);
 
 		dev_dbg(&gdev->dev, "registered chardev handle for line %d\n",
@@ -2117,7 +2117,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	if (ret)
 		goto out_free_le;
 
-	blocking_notifier_call_chain(&desc->gdev->notifier,
+	blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
 				     GPIO_V2_LINE_CHANGED_REQUESTED, desc);
 
 	irq = gpiod_to_irq(desc);
@@ -2671,7 +2671,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	cdev->gdev = gpio_device_get(gdev);
 
 	cdev->lineinfo_changed_nb.notifier_call = lineinfo_changed_notify;
-	ret = blocking_notifier_chain_register(&gdev->notifier,
+	ret = blocking_notifier_chain_register(&gdev->line_state_notifier,
 					       &cdev->lineinfo_changed_nb);
 	if (ret)
 		goto out_free_bitmap;
@@ -2687,7 +2687,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	return ret;
 
 out_unregister_notifier:
-	blocking_notifier_chain_unregister(&gdev->notifier,
+	blocking_notifier_chain_unregister(&gdev->line_state_notifier,
 					   &cdev->lineinfo_changed_nb);
 out_free_bitmap:
 	gpio_device_put(gdev);
@@ -2711,7 +2711,7 @@ static int gpio_chrdev_release(struct inode *inode, struct file *file)
 	struct gpio_device *gdev = cdev->gdev;
 
 	bitmap_free(cdev->watched_lines);
-	blocking_notifier_chain_unregister(&gdev->notifier,
+	blocking_notifier_chain_unregister(&gdev->line_state_notifier,
 					   &cdev->lineinfo_changed_nb);
 	gpio_device_put(gdev);
 	kfree(cdev);
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 76e0c38026c3..769ca2333b7a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -841,7 +841,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 	spin_unlock_irqrestore(&gpio_lock, flags);
 
-	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->notifier);
+	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
 	init_rwsem(&gdev->sem);
 
 #ifdef CONFIG_PINCTRL
@@ -2159,7 +2159,7 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 	}
 
 	spin_unlock_irqrestore(&gpio_lock, flags);
-	blocking_notifier_call_chain(&desc->gdev->notifier,
+	blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
 				     GPIOLINE_CHANGED_RELEASED, desc);
 
 	return ret;
@@ -3995,7 +3995,7 @@ static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 		return ERR_PTR(ret);
 	}
 
-	blocking_notifier_call_chain(&desc->gdev->notifier,
+	blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
 				     GPIOLINE_CHANGED_REQUESTED, desc);
 
 	return desc;
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index cca81375f127..7dd06ef45d44 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -38,8 +38,8 @@
  * or name of the IP component in a System on Chip.
  * @data: per-instance data assigned by the driver
  * @list: links gpio_device:s together for traversal
- * @notifier: used to notify subscribers about lines being requested, released
- *            or reconfigured
+ * @line_state_notifier: used to notify subscribers about lines being
+ *                       requested, released or reconfigured
  * @sem: protects the structure from a NULL-pointer dereference of @chip by
  *       user-space operations when the device gets unregistered during
  *       a hot-unplug event
@@ -63,7 +63,7 @@ struct gpio_device {
 	const char		*label;
 	void			*data;
 	struct list_head        list;
-	struct blocking_notifier_head notifier;
+	struct blocking_notifier_head line_state_notifier;
 	struct rw_semaphore	sem;
 
 #ifdef CONFIG_PINCTRL
-- 
2.39.2


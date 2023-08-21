Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3F6782B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbjHUOS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbjHUOSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:18:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C981199
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:18:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fef56f7222so3071855e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692627509; x=1693232309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1wCqI5mdx+hSWHqLVvTuuBRE/sn8f7dnVbK7+8/dfUQ=;
        b=3QAJ3j6k7eEcPlCLONXeeJGFdDoEgay1LkgB992m/xz4YYZ4LG80WcAljys7i5jTE/
         PJpkfD3KBbjPKntC1BppnseQAae8uPec+iyfwzv28IIZNdMivds2fFrZ9AUPKJjJw7j3
         sOV+x8Uh7qr9XElLZPUI/aV03qTyvdFytfcP2vLESkQl5ZDWvKyRtcK1XnrN2wMW/dvr
         z8zh0zJwE1oyZq62z9B5KN+hibbm748HImRiCkp9GdRa7o+j4PTKMINLgWLulikMrVxn
         LgBgZERJEM4vm76x9UpLZal6MITYh6S3TT5ZL2zvO7nsjCHwNOuICKeH8PYckRdSMTXK
         Xnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692627509; x=1693232309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wCqI5mdx+hSWHqLVvTuuBRE/sn8f7dnVbK7+8/dfUQ=;
        b=P0C02JgI7ZcFgLsi6Vp7/VKmBnhix2Y0sZ3+DdEyhzIR/oeuJ3aJ/hFgfxxuH9+TnV
         enPUXogW4++SVfe442HAkP6IdwTClNzuQwgPv+TDNa2bvXqca28H1vzJ5CFOgQ36Y9o2
         R6/iMpU6eDPNyhVi7Gn37qPPOme44Cds1ecJJRF24seYYmqPulRf1z0jP2SWX96GFF6K
         pNQSY+TTE/o9qeHV4bDnzaq/4l+miNTII1LETzRRMYcEpqyKWMb+oqX2cLgSTBZ5rK6A
         SUtGF9wi6fZKSzVGsus0x90sgwOiIlVB1UN8OFzfrdogDIlld9nTTMIWRdXXQOthO9Xi
         x3EA==
X-Gm-Message-State: AOJu0YwoBusNjSNjuSlBbgjRs08n66p815rGIuQzS2niZwQOQF3rbZWE
        iawY338U0V5lPRq1y6241SpKsg==
X-Google-Smtp-Source: AGHT+IFPtwZ/p0P25Rmg/uFWDCn/cES3Rz0rGjTnasHcfXzNPwPxLEJn9m8RJHlZISMIu9RGn1ZJEA==
X-Received: by 2002:a5d:6111:0:b0:313:e971:53af with SMTP id v17-20020a5d6111000000b00313e97153afmr4851884wrt.32.1692627509400;
        Mon, 21 Aug 2023 07:18:29 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:677:995b:9c07:d7fc])
        by smtp.gmail.com with ESMTPSA id i12-20020adffdcc000000b0031ae8d86af4sm10193704wrs.103.2023.08.21.07.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 07:18:29 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpiolib: provide and use gpiod_line_state_notify()
Date:   Mon, 21 Aug 2023 16:18:27 +0200
Message-Id: <20230821141827.18061-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
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

Wrap the calls to blocking_notifier_call_chain() for the line state
notifier with a helper that allows us to use fewer lines of code and
simpler syntax.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 17 +++++------------
 drivers/gpio/gpiolib.c      | 12 ++++++++----
 drivers/gpio/gpiolib.h      |  1 +
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 35dcaf78aed6..e39d344feb28 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -230,9 +230,7 @@ static long linehandle_set_config(struct linehandle_state *lh,
 				return ret;
 		}
 
-		blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
-					     GPIO_V2_LINE_CHANGED_CONFIG,
-					     desc);
+		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
 	}
 	return 0;
 }
@@ -414,8 +412,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 				goto out_free_lh;
 		}
 
-		blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
-					     GPIO_V2_LINE_CHANGED_REQUESTED, desc);
+		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_REQUESTED);
 
 		dev_dbg(&gdev->dev, "registered chardev handle for line %d\n",
 			offset);
@@ -1420,9 +1417,7 @@ static long linereq_set_config_unlocked(struct linereq *lr,
 
 		WRITE_ONCE(line->edflags, edflags);
 
-		blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
-					     GPIO_V2_LINE_CHANGED_CONFIG,
-					     desc);
+		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
 	}
 	return 0;
 }
@@ -1737,8 +1732,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 
 		lr->lines[i].edflags = edflags;
 
-		blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
-					     GPIO_V2_LINE_CHANGED_REQUESTED, desc);
+		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_REQUESTED);
 
 		dev_dbg(&gdev->dev, "registered chardev handle for line %d\n",
 			offset);
@@ -2156,8 +2150,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	if (ret)
 		goto out_free_le;
 
-	blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
-				     GPIO_V2_LINE_CHANGED_REQUESTED, desc);
+	gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_REQUESTED);
 
 	irq = gpiod_to_irq(desc);
 	if (irq <= 0) {
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0737952882cd..43162fd71d92 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2160,8 +2160,7 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 	}
 
 	spin_unlock_irqrestore(&gpio_lock, flags);
-	blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
-				     GPIOLINE_CHANGED_RELEASED, desc);
+	gpiod_line_state_notify(desc, GPIOLINE_CHANGED_RELEASED);
 
 	return ret;
 }
@@ -3729,6 +3728,12 @@ int gpiod_set_array_value_cansleep(unsigned int array_size,
 }
 EXPORT_SYMBOL_GPL(gpiod_set_array_value_cansleep);
 
+void gpiod_line_state_notify(struct gpio_desc *desc, unsigned long action)
+{
+	blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
+				     action, desc);
+}
+
 /**
  * gpiod_add_lookup_table() - register GPIO device consumers
  * @table: table of consumers to register
@@ -3996,8 +4001,7 @@ static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 		return ERR_PTR(ret);
 	}
 
-	blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
-				     GPIOLINE_CHANGED_REQUESTED, desc);
+	gpiod_line_state_notify(desc, GPIOLINE_CHANGED_REQUESTED);
 
 	return desc;
 }
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 54012605b4a4..0d81ac3bbb40 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -146,6 +146,7 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 extern spinlock_t gpio_lock;
 extern struct list_head gpio_devices;
 
+void gpiod_line_state_notify(struct gpio_desc *desc, unsigned long action);
 
 /**
  * struct gpio_desc - Opaque descriptor for a GPIO
-- 
2.39.2


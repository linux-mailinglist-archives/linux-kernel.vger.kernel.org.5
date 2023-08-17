Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D82377FE28
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354598AbjHQSuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354575AbjHQSuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:50:13 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9122D59
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:50:12 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe5c0e5747so976245e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692298211; x=1692903011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYFslBVonJ+xiQFMq+cvoNQKoDryt0Y6N5Sk/97C38o=;
        b=H4ktycTgIZUk7z2Gv89YRYyucNJ1IKuZffteIKLC/IMYqqwXqzGNdXGIaj8xvicGL5
         19Z/uPS7iSkbzOhUOR4mpSgchdA3K7KBWGhJVmC3jkUfRIgx7Hwr68xMhdtPsieaOV+c
         KKWMliSmzBEatMkL6XxyrIeOkHjFbGIYUa74L0qzm5mhEZVClnhELo6srFHmzOp3Rbyk
         9jVyShbxI5w83mRPsAurj4QX6FHFMjMj7CI8wB0JrE74BPag1IPew31mgONGRmQhZL51
         wP+zktd3YGdmjHE56JomwwgXrrsgcIsfzCf9M6CqRhJpxX+1MtOmv4os92G4fvjujFrr
         U71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692298211; x=1692903011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYFslBVonJ+xiQFMq+cvoNQKoDryt0Y6N5Sk/97C38o=;
        b=fqzj8c5RhG6FmSxYmdvifqyezEWT/Lf5Dc5ihSZgYOnbfJeUmvQa2y0uOF1w/Yjnjo
         DMZUYAteWNslYQVGJ+dQWPs+ul6S733Mpb47UXsGsVsrIJ0UhtCc/U88lejEEyBLykov
         R4eBeQSxtOv3YLIO5gKDpOBJE0Crp0RmT1K2KoVkBiw1CWFpatTFe7t7JR1K0nxkho8K
         XcE75nodQEonCiCoykGovADtv7li0btL1PNZP48n2xxXQRPAmNWyebq2+vs8uKLUUNri
         MWX19K8ShSslIym48WTj4dJp/yVcffAAjfAR1VmS++VV2S1Wv6c4tWuk0Z/pIPHVuR1D
         GMqw==
X-Gm-Message-State: AOJu0YwC9HovYjRik79aEiaGBGnEpWqyl3fsHUw1oxwU2PiYn27x7Iy0
        uHsLsSGNUAZxPvyyEaHTBr3TZA==
X-Google-Smtp-Source: AGHT+IHfvoii3PIDV2LNoeGZYozUdevK9jCGsdAl7Uk1OZnf+6niJhlgMte797oeM4DVqnbpikVZHQ==
X-Received: by 2002:a05:600c:294b:b0:3fd:2e87:aa28 with SMTP id n11-20020a05600c294b00b003fd2e87aa28mr186799wmd.15.1692298210890;
        Thu, 17 Aug 2023 11:50:10 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2f99:c690:b4da:e3d2])
        by smtp.gmail.com with ESMTPSA id a23-20020a05600c225700b003fe1cdbc33dsm3963020wmm.9.2023.08.17.11.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 11:50:10 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 4/6] gpio: cdev: wake up chardev poll() on device unbind
Date:   Thu, 17 Aug 2023 20:49:56 +0200
Message-Id: <20230817184958.25349-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230817184958.25349-1-brgl@bgdev.pl>
References: <20230817184958.25349-1-brgl@bgdev.pl>
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

Add a notifier block to the gpio_chardev_data structure and register it
with the gpio_device's device notifier. Upon reception of an event, wake
up the wait queue so that the user-space be forced out of poll() and need
to go into a new system call which will then fail due to the chip being
gone.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f95e1b110311..8b081c9b8d27 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2320,6 +2320,7 @@ struct gpio_chardev_data {
 	wait_queue_head_t wait;
 	DECLARE_KFIFO(events, struct gpio_v2_line_info_changed, 32);
 	struct notifier_block lineinfo_changed_nb;
+	struct notifier_block device_unregistered_nb;
 	unsigned long *watched_lines;
 #ifdef CONFIG_GPIO_CDEV_V1
 	atomic_t watch_abi_version;
@@ -2518,6 +2519,18 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static int gpio_device_unregistered_notify(struct notifier_block *nb,
+					   unsigned long action, void *data)
+{
+	struct gpio_chardev_data *cdev = container_of(nb,
+						      struct gpio_chardev_data,
+						      device_unregistered_nb);
+
+	wake_up_poll(&cdev->wait, EPOLLIN | EPOLLERR);
+
+	return NOTIFY_OK;
+}
+
 static __poll_t lineinfo_watch_poll_unlocked(struct file *file,
 					     struct poll_table_struct *pollt)
 {
@@ -2672,17 +2685,27 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	if (ret)
 		goto out_free_bitmap;
 
+	cdev->device_unregistered_nb.notifier_call =
+					gpio_device_unregistered_notify;
+	ret = blocking_notifier_chain_register(&gdev->device_notifier,
+					       &cdev->device_unregistered_nb);
+	if (ret)
+		goto out_unregister_line_notifier;
+
 	file->private_data = cdev;
 
 	ret = nonseekable_open(inode, file);
 	if (ret)
-		goto out_unregister_notifier;
+		goto out_unregister_device_notifier;
 
 	up_read(&gdev->sem);
 
 	return ret;
 
-out_unregister_notifier:
+out_unregister_device_notifier:
+	blocking_notifier_chain_unregister(&gdev->device_notifier,
+					   &cdev->device_unregistered_nb);
+out_unregister_line_notifier:
 	blocking_notifier_chain_unregister(&gdev->line_state_notifier,
 					   &cdev->lineinfo_changed_nb);
 out_free_bitmap:
@@ -2707,6 +2730,8 @@ static int gpio_chrdev_release(struct inode *inode, struct file *file)
 	struct gpio_device *gdev = cdev->gdev;
 
 	bitmap_free(cdev->watched_lines);
+	blocking_notifier_chain_unregister(&gdev->device_notifier,
+					   &cdev->device_unregistered_nb);
 	blocking_notifier_chain_unregister(&gdev->line_state_notifier,
 					   &cdev->lineinfo_changed_nb);
 	gpio_device_put(gdev);
-- 
2.39.2


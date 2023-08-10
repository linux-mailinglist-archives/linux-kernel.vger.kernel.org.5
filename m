Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3076B777F92
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjHJRtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbjHJRta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:49:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF86D268C;
        Thu, 10 Aug 2023 10:49:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fc03d990daso2165435e9.1;
        Thu, 10 Aug 2023 10:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691689768; x=1692294568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+WtW7C4kJrDKR+pFEz/8HCXE+o1igHG4L2tikxGRk8=;
        b=Dst8YgJGJPudTH/hAM5XLNNv0YcF0gY5C81AfRH6SyCdMW63Z79w66jq+LpTCaXhqN
         mnqinyc2R1+2k5ydeeZesgcA6OSU3BS+WZ/uxl0tZkzGRXRTaP1V1LXTup3R5ux9mryW
         WPgG7in2VBznlLOv15Q7o84znO0aP8WzefUaZvuNPcu/CLyRshkj6hPbpFv97C7Tdl4z
         U0ZI0i7ZWtyOYv3N9dfWqyu0bFHqbVmGjd9+PiB9KbcFwm5/5b3vJnC5CLHleAmlpUxu
         ysd7B/0SEpmHKBmTyp1H4H3nEfLPid6IovlJvX7lkxYqfEO6Mx7U5437u7xLbsDGZ43F
         EDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691689768; x=1692294568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+WtW7C4kJrDKR+pFEz/8HCXE+o1igHG4L2tikxGRk8=;
        b=XE+p0uqMHbT0rEnNwEZ4mpbmepLtMWynhV/u6XA0mr/YAeU3IWnBKTYMn5GuzLyDZV
         O2w15P790AbSby5WkJZYo8kcayLaR4xZucs7KgIIDHD+C1V/Xrt8agba1tRueOSu5x57
         5GhDKJ5lI7FLsIPc4UOl2xxiPV2Zh3WWAMzSjs9cQJiTnL3VsJ1yhgn7qrF0etiSmfUg
         zrYQz18qlRARQHDetTkrGJTUi+JP5k4ajLKzGsiLlPyCjlNqFT+iHHYCVzEnn6GaA2L8
         jol2q2GTy22KDkbThN3X5huAdItYuFJRF0RcqDE6N1UcdYkqROY/FmuucYNHLOOvpLrG
         TAmQ==
X-Gm-Message-State: AOJu0YyoeS8//zTWQnTr2YXs7cU+ewgulezLFbshx7Tu9ZWxpK+k8cK4
        DvDPRvLG2NEc2/oZKXPZQ+YELwrvOxRdjW19
X-Google-Smtp-Source: AGHT+IGME+pB0VUU4mqNY41duyHcP8jL9JAmoSik57r4OaKMh+q7RRDGPhRe3+0dDoDDK6wcmpBvHg==
X-Received: by 2002:a05:600c:1d0b:b0:3fb:aadc:41dc with SMTP id l11-20020a05600c1d0b00b003fbaadc41dcmr2741860wms.4.1691689768300;
        Thu, 10 Aug 2023 10:49:28 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c0b4100b003fa95f328afsm5698719wmr.29.2023.08.10.10.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:49:28 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     pavel@ucw.cz, lee@kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH] leds: make leds_class a static const structure
Date:   Thu, 10 Aug 2023 21:49:05 +0400
Message-Id: <20230810174905.7997-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver core allows for struct class to be in read-only
memory, move the leds_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 drivers/leds/led-class.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 6dae56b914fe..2f702d50f5fb 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -22,7 +22,6 @@
 #include <linux/of.h>
 #include "leds.h"
 
-static struct class *leds_class;
 static DEFINE_MUTEX(leds_lookup_lock);
 static LIST_HEAD(leds_lookup_list);
 
@@ -234,6 +233,12 @@ static struct led_classdev *led_module_get(struct device *led_dev)
 	return led_cdev;
 }
 
+static const struct class leds_class = {
+	.name = "leds",
+	.dev_groups = led_groups,
+	.pm = &leds_class_dev_pm_ops,
+};
+
 /**
  * of_led_get() - request a LED device via the LED framework
  * @np: device node to get the LED device from
@@ -251,7 +256,7 @@ struct led_classdev *of_led_get(struct device_node *np, int index)
 	if (!led_node)
 		return ERR_PTR(-ENOENT);
 
-	led_dev = class_find_device_by_of_node(leds_class, led_node);
+	led_dev = class_find_device_by_of_node(&leds_class, led_node);
 	of_node_put(led_node);
 	put_device(led_dev);
 
@@ -346,7 +351,7 @@ struct led_classdev *led_get(struct device *dev, char *con_id)
 	if (!provider)
 		return ERR_PTR(-ENOENT);
 
-	led_dev = class_find_device_by_name(leds_class, provider);
+	led_dev = class_find_device_by_name(&leds_class, provider);
 	kfree_const(provider);
 
 	return led_module_get(led_dev);
@@ -412,7 +417,7 @@ static int led_classdev_next_name(const char *init_name, char *name,
 	strscpy(name, init_name, len);
 
 	while ((ret < len) &&
-	       (dev = class_find_device_by_name(leds_class, name))) {
+	       (dev = class_find_device_by_name(&leds_class, name))) {
 		put_device(dev);
 		ret = snprintf(name, len, "%s_%u", init_name, ++i);
 	}
@@ -468,8 +473,8 @@ int led_classdev_register_ext(struct device *parent,
 
 	mutex_init(&led_cdev->led_access);
 	mutex_lock(&led_cdev->led_access);
-	led_cdev->dev = device_create_with_groups(leds_class, parent, 0,
-				led_cdev, led_cdev->groups, "%s", final_name);
+	led_cdev->dev = device_create_with_groups(&leds_class, parent, 0,
+						  led_cdev, led_cdev->groups, "%s", final_name);
 	if (IS_ERR(led_cdev->dev)) {
 		mutex_unlock(&led_cdev->led_access);
 		return PTR_ERR(led_cdev->dev);
@@ -626,17 +631,12 @@ EXPORT_SYMBOL_GPL(devm_led_classdev_unregister);
 
 static int __init leds_init(void)
 {
-	leds_class = class_create("leds");
-	if (IS_ERR(leds_class))
-		return PTR_ERR(leds_class);
-	leds_class->pm = &leds_class_dev_pm_ops;
-	leds_class->dev_groups = led_groups;
-	return 0;
+	return class_register(&leds_class);
 }
 
 static void __exit leds_exit(void)
 {
-	class_destroy(leds_class);
+	class_unregister(&leds_class);
 }
 
 subsys_initcall(leds_init);
-- 
2.34.1


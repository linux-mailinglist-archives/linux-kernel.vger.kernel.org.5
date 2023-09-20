Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81617A7674
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjITI5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjITI45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:56:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8128B93
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:56:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5310a63cf7bso4046126a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695200208; x=1695805008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tWw1t4ALS79pB9kxjWM5PMdLLOt6nPp1AWWZtrHrPQ8=;
        b=e7+mjuYJcgP7VkEekbsmVnlyvFKX7E80u/bZBPvgDbEt9PQl2Wb1Q+3XZHZV3Y2XaU
         6f0aPFeoeAb2Kcpz9uv8moXPSWybQKRjqAYCaSjJrSe/u8D/ltXgMCAvSnzmyXEbG5Jf
         FVBQgE5ga54gxGAkaL/H2dOWArSA2cmGkvrExzV2VjQrWoB5r1jGj9eFHmd4cBQKSDek
         7dDK/xtVFf5rfH+gIJ2/182NmEBYNkGUWzGk0H96nh/7UBQtD/GxQZFK+T3XwFFydjxG
         uotEkm7cGeeZ+GHHNn/L+C7e9DADNwZtpJAaAGuNbfUz8FeKVkFSfXjc1/C//jYGdGmm
         A3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695200208; x=1695805008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWw1t4ALS79pB9kxjWM5PMdLLOt6nPp1AWWZtrHrPQ8=;
        b=Ur0xolJrdlD/5mDBJnwXBsu/ggsPfcleqqd1QDyn4S98txfTD7JMDYy0jU4wtayzLY
         3BnkNyEF5W+M5+3ybIjvFLOPqmkUO6lNzrkrHknUGPt2nnuWfFWpJbH5Do3mabLgZzpi
         InRxDwDNLvQl+vScYVjwndAiUCtby3JXql0YXwj7OnClS4KKfZMYi9OfRBkqm90sdOZE
         2e654GGvEXyS7G9JnGJ7a1k0AG0iSTuKYzqhlmzJC/+uc1x+Eyem07RxZK+oEtPGnCO5
         /wI6dApT1Vx7jvzeX2QS0Mx76dMPaXrvZ4tE1EeVkv+xk4+2MYDVULSUV/ZX05qBSkRF
         eYLQ==
X-Gm-Message-State: AOJu0Yw4sRsO+UwAlUwGypybpCV432TM0lWFbYRuVb9fMglgRZZ/suoL
        EQCZ4VkPkCu1x/yZLhE6BVOAYOv3y3fwS4h16sVQfQ==
X-Google-Smtp-Source: AGHT+IGXjbC1tb4RgeNU9s6vDfRt8H2U6A/YX/bk9skfM2AVLdcsSvGz3HYVAtziizBML2BM5Xfupw==
X-Received: by 2002:a05:6402:1b1b:b0:52b:db31:3c5c with SMTP id by27-20020a0564021b1b00b0052bdb313c5cmr1667421edb.0.1695200207902;
        Wed, 20 Sep 2023 01:56:47 -0700 (PDT)
Received: from brgl-uxlite.. (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id t18-20020a056402021200b0052fdfd8870bsm8621789edv.89.2023.09.20.01.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 01:56:47 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpiolib: extend the critical sections of lookup tables
Date:   Wed, 20 Sep 2023 10:56:39 +0200
Message-Id: <20230920085639.152441-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
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

There are two places in the code where we retrieve a lookup table using
gpiod_find_lookup_table() (which protects the table list with the lookup
table lock) and then use it after the lock is released.

We need to keep the lookup table mutex locked the entire time we're using
the tables. Remove the locking from gpiod_find_lookup_table() and use
guards to protect the code actually using the table objects.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index edffa0d2acaa..7c27a1efc1b0 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3822,8 +3822,6 @@ static struct gpiod_lookup_table *gpiod_find_lookup_table(struct device *dev)
 	const char *dev_id = dev ? dev_name(dev) : NULL;
 	struct gpiod_lookup_table *table;
 
-	mutex_lock(&gpio_lookup_lock);
-
 	list_for_each_entry(table, &gpio_lookup_list, list) {
 		if (table->dev_id && dev_id) {
 			/*
@@ -3831,21 +3829,18 @@ static struct gpiod_lookup_table *gpiod_find_lookup_table(struct device *dev)
 			 * a match
 			 */
 			if (!strcmp(table->dev_id, dev_id))
-				goto found;
+				return table;
 		} else {
 			/*
 			 * One of the pointers is NULL, so both must be to have
 			 * a match
 			 */
 			if (dev_id == table->dev_id)
-				goto found;
+				return table;
 		}
 	}
-	table = NULL;
 
-found:
-	mutex_unlock(&gpio_lookup_lock);
-	return table;
+	return NULL;
 }
 
 static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
@@ -3855,6 +3850,8 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 	struct gpiod_lookup_table *table;
 	struct gpiod_lookup *p;
 
+	guard(mutex)(&gpio_lookup_lock);
+
 	table = gpiod_find_lookup_table(dev);
 	if (!table)
 		return desc;
@@ -3920,15 +3917,18 @@ static int platform_gpio_count(struct device *dev, const char *con_id)
 	struct gpiod_lookup *p;
 	unsigned int count = 0;
 
-	table = gpiod_find_lookup_table(dev);
-	if (!table)
-		return -ENOENT;
+	scoped_guard(mutex, &gpio_lookup_lock) {
+		table = gpiod_find_lookup_table(dev);
+		if (!table)
+			return -ENOENT;
 
-	for (p = &table->table[0]; p->key; p++) {
-		if ((con_id && p->con_id && !strcmp(con_id, p->con_id)) ||
-		    (!con_id && !p->con_id))
-			count++;
+		for (p = &table->table[0]; p->key; p++) {
+			if ((con_id && p->con_id && !strcmp(con_id, p->con_id)) ||
+			    (!con_id && !p->con_id))
+				count++;
+		}
 	}
+
 	if (!count)
 		return -ENOENT;
 
-- 
2.39.2


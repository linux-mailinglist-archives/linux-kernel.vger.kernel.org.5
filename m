Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7368C79020F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350595AbjIASct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjIAScs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:32:48 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1CBCEB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 11:32:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so1988232f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 11:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693593163; x=1694197963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OAz0KgVu87lEXbvrXDdrxHlFUVSjyb+PiIQULpTmeH4=;
        b=s45mkDJZ25XKoOzJvussXOQ817w/NwJ0MuyWX5AHqs8+Fy27qGykdtT4maDsTZprdV
         MjeQfqqMyS1FgtI2JUuKK3BfLftp4nz7f02Y+o9KOm3RGCGLA5kM7vKpvxVlZw73LcsM
         aM8gAsZPR/xBs/SUSkU3Ew6rhuVAQ9/scJa6eSXpWn1CLFjr1lC0w/omCrS6qKt68kAD
         EuUY7uceUV1+62aU+THgAKhtIp0gCWJpk4Ct0jCffydwnEqb29jheg6kO/sPLf84dxTb
         jSo8Pl6qG0+qnYuFfPbdZM8TRmnaVctDBz50axPsYIy5HFBzUGo306QN3qC6fZMxZ1L1
         rcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693593163; x=1694197963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAz0KgVu87lEXbvrXDdrxHlFUVSjyb+PiIQULpTmeH4=;
        b=kkGPYbIuovc7ia/cU+dqD/OlddMjc9zF9/z/NvllJHqAOQwYOQkpZQ43xStfdNED78
         hqSLfPgX5JHW5z9Gtj2uHKcCGWFiCu1t89tC+pUh/xwo13VrKTj7EhWuoIwfOSiV2n8w
         uc38hkWu3zBAHTLY/XYokgIkfZRrfiSiC0Tma7i3E97mhvtCYkJ/7Tl9Azap6Qlfal+E
         LxPdCQyFBFhgWWljGPjdFJEeLKT73ekORx2ucomdbpMRm9YekZbRupxyd52YIqrG12GT
         s5ChPqj4VecMNtGIZXpq0zDx/VOjbj77CNIcqwT4nxkDBlCaZsJ4Qxy0sC4tEuDlzexk
         q5pQ==
X-Gm-Message-State: AOJu0YxM9BlVrtTkw9GXdKexeHtqOagMCnGCfvqQ3uLTRKotD+WCQzuc
        GaoVYqdmW86Dgk/fFZrU/iBfgA==
X-Google-Smtp-Source: AGHT+IHdcZv0aMC9hpKaw8d1Qby49feQRcpuBsplRoFoMasrDgWUCyPsOvbDhHM/3t7hALHQh4OU0w==
X-Received: by 2002:a5d:4d49:0:b0:319:6ce2:e5a3 with SMTP id a9-20020a5d4d49000000b003196ce2e5a3mr2435096wru.26.1693593162956;
        Fri, 01 Sep 2023 11:32:42 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e94b:1054:6760:aa27])
        by smtp.gmail.com with ESMTPSA id bl1-20020adfe241000000b00317b5c8a4f1sm5972281wrb.60.2023.09.01.11.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 11:32:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: sim: don't fiddle with GPIOLIB private members
Date:   Fri,  1 Sep 2023 20:32:40 +0200
Message-Id: <20230901183240.102701-1-brgl@bgdev.pl>
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

We access internals of struct gpio_device and struct gpio_desc because
it's easier but it can actually be avoided and we're working towards a
better encapsulation of GPIO data structures across the kernel so let's
start at home.

Instead of checking gpio_desc flags, let's just track the requests of
GPIOs in the driver. We also already store the information about
direction of simulated lines.

For kobjects needed by sysfs callbacks: we can leverage the fact that
once created for a software node, struct device is accessible from that
fwnode_handle. We don't need to dereference gpio_device.

While at it: fix one line break and remove the untrue part about
configfs callbacks using dev_get_drvdata() from a comment.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sim.c | 49 +++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 271db3639a78..5f52d77567a1 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -12,6 +12,7 @@
 #include <linux/completion.h>
 #include <linux/configfs.h>
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/idr.h>
@@ -30,8 +31,6 @@
 #include <linux/string_helpers.h>
 #include <linux/sysfs.h>
 
-#include "gpiolib.h"
-
 #define GPIO_SIM_NGPIO_MAX	1024
 #define GPIO_SIM_PROP_MAX	4 /* Max 3 properties + sentinel. */
 #define GPIO_SIM_NUM_ATTRS	3 /* value, pull and sentinel */
@@ -40,6 +39,8 @@ static DEFINE_IDA(gpio_sim_ida);
 
 struct gpio_sim_chip {
 	struct gpio_chip gc;
+	struct fwnode_handle *swnode;
+	unsigned long *request_map;
 	unsigned long *direction_map;
 	unsigned long *value_map;
 	unsigned long *pull_map;
@@ -63,16 +64,11 @@ static int gpio_sim_apply_pull(struct gpio_sim_chip *chip,
 			       unsigned int offset, int value)
 {
 	int irq, irq_type, ret;
-	struct gpio_desc *desc;
-	struct gpio_chip *gc;
-
-	gc = &chip->gc;
-	desc = &gc->gpiodev->descs[offset];
 
 	guard(mutex)(&chip->lock);
 
-	if (test_bit(FLAG_REQUESTED, &desc->flags) &&
-	    !test_bit(FLAG_IS_OUT, &desc->flags)) {
+	if (test_bit(offset, chip->request_map) &&
+	    test_bit(offset, chip->direction_map)) {
 		if (value == !!test_bit(offset, chip->value_map))
 			goto set_pull;
 
@@ -99,8 +95,8 @@ static int gpio_sim_apply_pull(struct gpio_sim_chip *chip,
 
 set_value:
 	/* Change the value unless we're actively driving the line. */
-	if (!test_bit(FLAG_REQUESTED, &desc->flags) ||
-	    !test_bit(FLAG_IS_OUT, &desc->flags))
+	if (!test_bit(offset, chip->request_map) ||
+	    test_bit(offset, chip->direction_map))
 		__assign_bit(offset, chip->value_map, value);
 
 set_pull:
@@ -181,7 +177,7 @@ static int gpio_sim_get_direction(struct gpio_chip *gc, unsigned int offset)
 }
 
 static int gpio_sim_set_config(struct gpio_chip *gc,
-				  unsigned int offset, unsigned long config)
+			       unsigned int offset, unsigned long config)
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
@@ -204,13 +200,25 @@ static int gpio_sim_to_irq(struct gpio_chip *gc, unsigned int offset)
 	return irq_create_mapping(chip->irq_sim, offset);
 }
 
-static void gpio_sim_free(struct gpio_chip *gc, unsigned int offset)
+static int gpio_sim_request(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
 	scoped_guard(mutex, &chip->lock)
+		__set_bit(offset, chip->request_map);
+
+	return 0;
+}
+
+static void gpio_sim_free(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
+
+	scoped_guard(mutex, &chip->lock) {
 		__assign_bit(offset, chip->value_map,
 			     !!test_bit(offset, chip->pull_map));
+		__clear_bit(offset, chip->request_map);
+	}
 }
 
 static ssize_t gpio_sim_sysfs_val_show(struct device *dev,
@@ -295,7 +303,7 @@ static void gpio_sim_sysfs_remove(void *data)
 {
 	struct gpio_sim_chip *chip = data;
 
-	sysfs_remove_groups(&chip->gc.gpiodev->dev.kobj, chip->attr_groups);
+	sysfs_remove_groups(&chip->swnode->dev->kobj, chip->attr_groups);
 }
 
 static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
@@ -352,7 +360,7 @@ static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
 		chip->attr_groups[i] = attr_group;
 	}
 
-	ret = sysfs_create_groups(&chip->gc.gpiodev->dev.kobj,
+	ret = sysfs_create_groups(&chip->swnode->dev->kobj,
 				  chip->attr_groups);
 	if (ret)
 		return ret;
@@ -387,6 +395,12 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	if (!chip)
 		return -ENOMEM;
 
+	chip->swnode = swnode;
+
+	chip->request_map = devm_bitmap_zalloc(dev, num_lines, GFP_KERNEL);
+	if (!chip->request_map)
+		return -ENOMEM;
+
 	chip->direction_map = devm_bitmap_alloc(dev, num_lines, GFP_KERNEL);
 	if (!chip->direction_map)
 		return -ENOMEM;
@@ -432,6 +446,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	gc->get_direction = gpio_sim_get_direction;
 	gc->set_config = gpio_sim_set_config;
 	gc->to_irq = gpio_sim_to_irq;
+	gc->request = gpio_sim_request;
 	gc->free = gpio_sim_free;
 	gc->can_sleep = true;
 
@@ -439,8 +454,8 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	if (ret)
 		return ret;
 
-	/* Used by sysfs and configfs callbacks. */
-	dev_set_drvdata(&gc->gpiodev->dev, chip);
+	/* Used by sysfs callbacks. */
+	dev_set_drvdata(swnode->dev, chip);
 
 	return gpio_sim_setup_sysfs(chip);
 }
-- 
2.39.2


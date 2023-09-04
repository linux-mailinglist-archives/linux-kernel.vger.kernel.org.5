Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B93D791247
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345743AbjIDHeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjIDHeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:34:23 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AB8DF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:34:18 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9338e4695so16270141fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 00:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693812857; x=1694417657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbQafOaqylHBe5YVpAobIpTuikzCjI7mdQP3b053dwY=;
        b=byZPCFGviyGM9mExjl2zBgGXixZVNhfWthUMJxr0BdsWEEsENUGwwojbH5O4qvZMbC
         02aKSu9wafCgdcS8UsjudUJort5jjeasyAT1eeUdUUis8MyagyM9bBA98rBJ8pOD+qnH
         cN1uA60G2sbj7cNyUWizPRP6EPp+Ug58XzE5fimZ6bV/i5/58BXjmX3BCNwxjalJVVh0
         9HbQ5liMOBBC2Rf613HOdGrG0dT1vDq1L9PBezEpm8NQY9/QtfzpkuGS4B6YVHVLnEmw
         RypdzZ+lLGWKAsDKeDWS98le2slRtNPzUqYEjXFlM1MoAtuHmhqz3MYs79x6j03oFHkG
         5rLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693812857; x=1694417657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbQafOaqylHBe5YVpAobIpTuikzCjI7mdQP3b053dwY=;
        b=gf+UFDZDu6kTyFnWUC9vOvHm81VgU1WlUCJ5lGb7Fc06IKSfMwYnDHc1T/DyPypxrP
         k4DPUhyq7Hl7u7ndqIjUYMJoBsUUiYmIqRxiU2MmAYD4cMWQKAmzlr/L2rWiA99ZK+Hj
         uO2sZlTFSyJUDJA54EhbeGDAt6maS553g1Of4uGAI+Kkz+dKLYIbRiQmLt7kdM8vZzcb
         QSfc+CE7EAjy6drI4U2RSkVBu2YmpJB0vsry0g3/m05vwmvTYPQsF87G5SRg/9QLH7xK
         St2+CENZw/mog1ViDTM7+0PhVVLTAyndcBjFvNajyqMAzm8k/Lkne0ppp7gsunukiKls
         6vyQ==
X-Gm-Message-State: AOJu0YwlDTo4DQB133gl5u5sBbwUVz7RM4LHM5YAb8GaVTKgv4nkkCNp
        4qjEREzBW51mHudk5VOTp5/Ssg==
X-Google-Smtp-Source: AGHT+IHjk+vzN1UyP1HGswxmBkx8jknUMgtpl1llxPWdcUQXIPepiQ2ydE78F9r6CBqrEFHgs3lsDw==
X-Received: by 2002:a05:6512:3b82:b0:500:7e70:ddf5 with SMTP id g2-20020a0565123b8200b005007e70ddf5mr8207133lfv.43.1693812857044;
        Mon, 04 Sep 2023 00:34:17 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7663:60b7:3a19:b5c4])
        by smtp.gmail.com with ESMTPSA id fj15-20020a05600c0c8f00b003fe2bea77ccsm13492733wmb.5.2023.09.04.00.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 00:34:16 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] gpiolib: rename gpio_chip_hwgpio() for consistency
Date:   Mon,  4 Sep 2023 09:34:10 +0200
Message-Id: <20230904073410.5880-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904073410.5880-1-brgl@bgdev.pl>
References: <20230904073410.5880-1-brgl@bgdev.pl>
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

All other functions that manipulate a struct gpio_desc use the gpiod_
prefix. Follow this convention and rename gpio_chip_hwgpio() to
gpiod_get_hwgpio().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-aspeed.c   |  6 ++---
 drivers/gpio/gpiolib-cdev.c  | 12 ++++-----
 drivers/gpio/gpiolib-sysfs.c | 10 ++++----
 drivers/gpio/gpiolib.c       | 48 ++++++++++++++++++------------------
 drivers/gpio/gpiolib.h       |  2 +-
 5 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index da33bbbdacb9..c9cef89e1f65 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -23,7 +23,7 @@
 
 /*
  * These two headers aren't meant to be used by GPIO drivers. We need
- * them in order to access gpio_chip_hwgpio() which we need to implement
+ * them in order to access gpiod_get_hwgpio() which we need to implement
  * the aspeed specific API which allows the coprocessor to request
  * access to some GPIOs and to arbitrate between coprocessor and ARM.
  */
@@ -1013,7 +1013,7 @@ int aspeed_gpio_copro_grab_gpio(struct gpio_desc *desc,
 {
 	struct gpio_chip *chip = gpiod_to_chip(desc);
 	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
-	int rc = 0, bindex, offset = gpio_chip_hwgpio(desc);
+	int rc = 0, bindex, offset = gpiod_get_hwgpio(desc);
 	const struct aspeed_gpio_bank *bank = to_bank(offset);
 	unsigned long flags;
 
@@ -1059,7 +1059,7 @@ int aspeed_gpio_copro_release_gpio(struct gpio_desc *desc)
 {
 	struct gpio_chip *chip = gpiod_to_chip(desc);
 	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
-	int rc = 0, bindex, offset = gpio_chip_hwgpio(desc);
+	int rc = 0, bindex, offset = gpiod_get_hwgpio(desc);
 	const struct aspeed_gpio_bank *bank = to_bank(offset);
 	unsigned long flags;
 
diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index e39d344feb28..5db38d49941f 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -698,7 +698,7 @@ static enum hte_return process_hw_ts_thread(void *p)
 	}
 	le.line_seqno = line->line_seqno;
 	le.seqno = (lr->num_lines == 1) ? le.line_seqno : line->req_seqno;
-	le.offset = gpio_chip_hwgpio(line->desc);
+	le.offset = gpiod_get_hwgpio(line->desc);
 
 	linereq_put_event(lr, &le);
 
@@ -815,7 +815,7 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
 	line->line_seqno++;
 	le.line_seqno = line->line_seqno;
 	le.seqno = (lr->num_lines == 1) ? le.line_seqno : line->req_seqno;
-	le.offset = gpio_chip_hwgpio(line->desc);
+	le.offset = gpiod_get_hwgpio(line->desc);
 
 	linereq_put_event(lr, &le);
 
@@ -913,7 +913,7 @@ static void debounce_work_func(struct work_struct *work)
 
 	lr = line->req;
 	le.timestamp_ns = line_event_timestamp(line);
-	le.offset = gpio_chip_hwgpio(line->desc);
+	le.offset = gpiod_get_hwgpio(line->desc);
 #ifdef CONFIG_HTE
 	if (edflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE) {
 		/* discard events except the last one */
@@ -1610,7 +1610,7 @@ static void linereq_show_fdinfo(struct seq_file *out, struct file *file)
 
 	for (i = 0; i < lr->num_lines; i++)
 		seq_printf(out, "gpio-line:\t%d\n",
-			   gpio_chip_hwgpio(lr->lines[i].desc));
+			   gpiod_get_hwgpio(lr->lines[i].desc));
 }
 #endif
 
@@ -2278,7 +2278,7 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	unsigned int num_attrs = 0;
 
 	memset(info, 0, sizeof(*info));
-	info->offset = gpio_chip_hwgpio(desc);
+	info->offset = gpiod_get_hwgpio(desc);
 
 	/*
 	 * This function takes a mutex so we must check this before taking
@@ -2539,7 +2539,7 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 	struct gpio_desc *desc = data;
 	int ret;
 
-	if (!test_bit(gpio_chip_hwgpio(desc), cdev->watched_lines))
+	if (!test_bit(gpiod_get_hwgpio(desc), cdev->watched_lines))
 		return NOTIFY_DONE;
 
 	memset(&chg, 0, sizeof(chg));
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 50503a4525eb..ee3a0cb62d20 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -194,7 +194,7 @@ static int gpio_sysfs_request_irq(struct device *dev, unsigned char flags)
 	 *        Remove this redundant call (along with the corresponding
 	 *        unlock) when those drivers have been fixed.
 	 */
-	ret = gpiochip_lock_as_irq(desc->gdev->chip, gpio_chip_hwgpio(desc));
+	ret = gpiochip_lock_as_irq(desc->gdev->chip, gpiod_get_hwgpio(desc));
 	if (ret < 0)
 		goto err_put_kn;
 
@@ -208,7 +208,7 @@ static int gpio_sysfs_request_irq(struct device *dev, unsigned char flags)
 	return 0;
 
 err_unlock:
-	gpiochip_unlock_as_irq(desc->gdev->chip, gpio_chip_hwgpio(desc));
+	gpiochip_unlock_as_irq(desc->gdev->chip, gpiod_get_hwgpio(desc));
 err_put_kn:
 	sysfs_put(data->value_kn);
 
@@ -226,7 +226,7 @@ static void gpio_sysfs_free_irq(struct device *dev)
 
 	data->irq_flags = 0;
 	free_irq(data->irq, data);
-	gpiochip_unlock_as_irq(desc->gdev->chip, gpio_chip_hwgpio(desc));
+	gpiochip_unlock_as_irq(desc->gdev->chip, gpiod_get_hwgpio(desc));
 	sysfs_put(data->value_kn);
 }
 
@@ -458,7 +458,7 @@ static ssize_t export_store(const struct class *class,
 		return -EINVAL;
 	}
 	gc = desc->gdev->chip;
-	offset = gpio_chip_hwgpio(desc);
+	offset = gpiod_get_hwgpio(desc);
 	if (!gpiochip_line_is_valid(gc, offset)) {
 		pr_warn("%s: GPIO %ld masked\n", __func__, gpio);
 		return -EINVAL;
@@ -613,7 +613,7 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 	else
 		data->direction_can_change = false;
 
-	offset = gpio_chip_hwgpio(desc);
+	offset = gpiod_get_hwgpio(desc);
 	if (chip->names && chip->names[offset])
 		ioname = chip->names[offset];
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6fab0f211e67..7b380e4b63e3 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -237,7 +237,7 @@ int gpiod_get_direction(struct gpio_desc *desc)
 	int ret;
 
 	gc = gpiod_to_chip(desc);
-	offset = gpio_chip_hwgpio(desc);
+	offset = gpiod_get_hwgpio(desc);
 
 	/*
 	 * Open drain emulation using input mode may incorrectly report
@@ -2052,7 +2052,7 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 	if (gc->request) {
 		/* gc->request may sleep */
 		spin_unlock_irqrestore(&gpio_lock, flags);
-		offset = gpio_chip_hwgpio(desc);
+		offset = gpiod_get_hwgpio(desc);
 		if (gpiochip_line_is_valid(gc, offset))
 			ret = gc->request(gc, offset);
 		else
@@ -2153,7 +2153,7 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 		if (gc->free) {
 			spin_unlock_irqrestore(&gpio_lock, flags);
 			might_sleep_if(gc->can_sleep);
-			gc->free(gc, gpio_chip_hwgpio(desc));
+			gc->free(gc, gpiod_get_hwgpio(desc));
 			spin_lock_irqsave(&gpio_lock, flags);
 		}
 		kfree_const(desc->label);
@@ -2317,7 +2317,7 @@ static int gpio_set_config_with_argument(struct gpio_desc *desc,
 	unsigned long config;
 
 	config = pinconf_to_config_packed(mode, argument);
-	return gpio_do_set_config(gc, gpio_chip_hwgpio(desc), config);
+	return gpio_do_set_config(gc, gpiod_get_hwgpio(desc), config);
 }
 
 static int gpio_set_config_with_argument_optional(struct gpio_desc *desc,
@@ -2325,7 +2325,7 @@ static int gpio_set_config_with_argument_optional(struct gpio_desc *desc,
 						  u32 argument)
 {
 	struct device *dev = &desc->gdev->dev;
-	int gpio = gpio_chip_hwgpio(desc);
+	int gpio = gpiod_get_hwgpio(desc);
 	int ret;
 
 	ret = gpio_set_config_with_argument(desc, mode, argument);
@@ -2429,9 +2429,9 @@ int gpiod_direction_input(struct gpio_desc *desc)
 	 * assume we are in input mode after this.
 	 */
 	if (gc->direction_input) {
-		ret = gc->direction_input(gc, gpio_chip_hwgpio(desc));
+		ret = gc->direction_input(gc, gpiod_get_hwgpio(desc));
 	} else if (gc->get_direction &&
-		  (gc->get_direction(gc, gpio_chip_hwgpio(desc)) != 1)) {
+		  (gc->get_direction(gc, gpiod_get_hwgpio(desc)) != 1)) {
 		gpiod_warn(desc,
 			   "%s: missing direction_input() operation and line is output\n",
 			   __func__);
@@ -2467,11 +2467,11 @@ static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 	}
 
 	if (gc->direction_output) {
-		ret = gc->direction_output(gc, gpio_chip_hwgpio(desc), val);
+		ret = gc->direction_output(gc, gpiod_get_hwgpio(desc), val);
 	} else {
 		/* Check that we are in output mode if we can */
 		if (gc->get_direction &&
-		    gc->get_direction(gc, gpio_chip_hwgpio(desc))) {
+		    gc->get_direction(gc, gpiod_get_hwgpio(desc))) {
 			gpiod_warn(desc,
 				"%s: missing direction_output() operation\n",
 				__func__);
@@ -2481,7 +2481,7 @@ static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 		 * If we can't actively set the direction, we are some
 		 * output-only chip, so just drive the output as desired.
 		 */
-		gc->set(gc, gpio_chip_hwgpio(desc), val);
+		gc->set(gc, gpiod_get_hwgpio(desc), val);
 	}
 
 	if (!ret)
@@ -2603,7 +2603,7 @@ int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags)
 		return -ENOTSUPP;
 	}
 
-	ret = gc->en_hw_timestamp(gc, gpio_chip_hwgpio(desc), flags);
+	ret = gc->en_hw_timestamp(gc, gpiod_get_hwgpio(desc), flags);
 	if (ret)
 		gpiod_warn(desc, "%s: hw ts request failed\n", __func__);
 
@@ -2632,7 +2632,7 @@ int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags)
 		return -ENOTSUPP;
 	}
 
-	ret = gc->dis_hw_timestamp(gc, gpio_chip_hwgpio(desc), flags);
+	ret = gc->dis_hw_timestamp(gc, gpiod_get_hwgpio(desc), flags);
 	if (ret)
 		gpiod_warn(desc, "%s: hw ts release failed\n", __func__);
 
@@ -2656,7 +2656,7 @@ int gpiod_set_config(struct gpio_desc *desc, unsigned long config)
 	VALIDATE_DESC(desc);
 	gc = desc->gdev->chip;
 
-	return gpio_do_set_config(gc, gpio_chip_hwgpio(desc), config);
+	return gpio_do_set_config(gc, gpiod_get_hwgpio(desc), config);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_config);
 
@@ -2727,7 +2727,7 @@ EXPORT_SYMBOL_GPL(gpiod_toggle_active_low);
 
 static int gpio_chip_get_value(struct gpio_chip *gc, const struct gpio_desc *desc)
 {
-	return gc->get ? gc->get(gc, gpio_chip_hwgpio(desc)) : -EIO;
+	return gc->get ? gc->get(gc, gpiod_get_hwgpio(desc)) : -EIO;
 }
 
 /* I/O calls are only valid after configuration completed; the relevant
@@ -2852,7 +2852,7 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 		first = i;
 		do {
 			const struct gpio_desc *desc = desc_array[i];
-			int hwgpio = gpio_chip_hwgpio(desc);
+			int hwgpio = gpiod_get_hwgpio(desc);
 
 			__set_bit(hwgpio, mask);
 			i++;
@@ -2874,7 +2874,7 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 
 		for (j = first; j < i; ) {
 			const struct gpio_desc *desc = desc_array[j];
-			int hwgpio = gpio_chip_hwgpio(desc);
+			int hwgpio = gpiod_get_hwgpio(desc);
 			int value = test_bit(hwgpio, bits);
 
 			if (!raw && test_bit(FLAG_ACTIVE_LOW, &desc->flags))
@@ -3006,7 +3006,7 @@ static void gpio_set_open_drain_value_commit(struct gpio_desc *desc, bool value)
 {
 	int ret = 0;
 	struct gpio_chip *gc = desc->gdev->chip;
-	int offset = gpio_chip_hwgpio(desc);
+	int offset = gpiod_get_hwgpio(desc);
 
 	if (value) {
 		ret = gc->direction_input(gc, offset);
@@ -3031,7 +3031,7 @@ static void gpio_set_open_source_value_commit(struct gpio_desc *desc, bool value
 {
 	int ret = 0;
 	struct gpio_chip *gc = desc->gdev->chip;
-	int offset = gpio_chip_hwgpio(desc);
+	int offset = gpiod_get_hwgpio(desc);
 
 	if (value) {
 		ret = gc->direction_output(gc, offset, 1);
@@ -3053,7 +3053,7 @@ static void gpiod_set_raw_value_commit(struct gpio_desc *desc, bool value)
 
 	gc = desc->gdev->chip;
 	trace_gpio_value(desc_to_gpio(desc), 0, value);
-	gc->set(gc, gpio_chip_hwgpio(desc), value);
+	gc->set(gc, gpiod_get_hwgpio(desc), value);
 }
 
 /*
@@ -3144,7 +3144,7 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 
 		do {
 			struct gpio_desc *desc = desc_array[i];
-			int hwgpio = gpio_chip_hwgpio(desc);
+			int hwgpio = gpiod_get_hwgpio(desc);
 			int value = test_bit(i, value_bitmap);
 
 			/*
@@ -3355,7 +3355,7 @@ int gpiod_to_irq(const struct gpio_desc *desc)
 		return -EINVAL;
 
 	gc = desc->gdev->chip;
-	offset = gpio_chip_hwgpio(desc);
+	offset = gpiod_get_hwgpio(desc);
 	if (gc->to_irq) {
 		int retirq = gc->to_irq(gc, offset);
 
@@ -4258,7 +4258,7 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
 	int ret;
 
 	gc = gpiod_to_chip(desc);
-	hwnum = gpio_chip_hwgpio(desc);
+	hwnum = gpiod_get_hwgpio(desc);
 
 	local_desc = gpiochip_request_own_desc(gc, hwnum, name,
 					       lflags, dflags);
@@ -4338,7 +4338,7 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 		 * If pin hardware number of array member 0 is also 0, select
 		 * its chip as a candidate for fast bitmap processing path.
 		 */
-		if (descs->ndescs == 0 && gpio_chip_hwgpio(desc) == 0) {
+		if (descs->ndescs == 0 && gpiod_get_hwgpio(desc) == 0) {
 			struct gpio_descs *array;
 
 			bitmap_size = BITS_TO_LONGS(gc->ngpio > count ?
@@ -4383,7 +4383,7 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 		 * Detect array members which belong to the 'fast' chip
 		 * but their pins are not in hardware order.
 		 */
-		else if (gpio_chip_hwgpio(desc) != descs->ndescs) {
+		else if (gpiod_get_hwgpio(desc) != descs->ndescs) {
 			/*
 			 * Don't use fast path if all array members processed so
 			 * far belong to the same chip as this one but its pin
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 9ea5b88ad304..bddf29699289 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -227,7 +227,7 @@ int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev);
 /*
  * Return the GPIO number of the passed descriptor relative to its chip
  */
-static inline int gpio_chip_hwgpio(const struct gpio_desc *desc)
+static inline int gpiod_get_hwgpio(const struct gpio_desc *desc)
 {
 	return desc - &desc->gdev->descs[0];
 }
-- 
2.39.2


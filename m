Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7295793E81
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239656AbjIFOPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjIFOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:15:44 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C326AE4C;
        Wed,  6 Sep 2023 07:15:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5008c19d97fso1077096e87.1;
        Wed, 06 Sep 2023 07:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694009738; x=1694614538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=73bvn9FYYPU01ViJQTTVFlkmF8Ln54AoHr7uFrtjneU=;
        b=quL0zKjMysAywcz3j8zN4mAGT4NGC7QKsYnPe4FJerCY1EOmt8jdRzfDTxugvXDDUq
         TswkmymJgWDRn4J15ZH/BpqgNhCqNBEhSbwoqM6hVLPutnLR5zWitHdX8NkixCj1GIq7
         EinDjAguCjFZWStn5qD1pvOGEzKFA8rNS09k2b6C6MaSkT9vH/YLf3PYYzIDnJctvgqP
         kkShaBlAy33hK/x0koHIb83FVInwkDmZ3dlloR+AoozJciNbB9RIE/8BF50aFpTcx2D1
         +5WjY2yBqg0QVtYia7MdAjtnr7nudStXi2bxQ42nF7C4JpmLMIblfD3/aJ8TFeNcOv1o
         ly7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694009738; x=1694614538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73bvn9FYYPU01ViJQTTVFlkmF8Ln54AoHr7uFrtjneU=;
        b=eM3ErhLc7ViuFu85/1x1ZzybVcg+u9AYSK0ifdqf9OlzHu/St8KBUcupCbVESZKm1S
         aLsCxmTDZePYwEvNamImukdS8jF8LPEZ9u83TusAmJ/STH7MLBGgzRlTxKWifk+1nC35
         hbiLJNdhZfUs270pZVd1GSb4mMaOSGxyGafA07R23Tbp9Ju1qbhwz5f3S4xI7vvnf6LF
         gjeb18M3UGCghXgEYHWSrjX+taGzMn5ucL076AHV7RH9xgyYvpQx7bvD1k/ISEuj3q20
         2SN0D/rsXYEXZ0wCQRcdn7gXXXf58EhUNc3YPXApRkNQSt0sw1J+1t0ogQMYjMnz79f5
         9T2Q==
X-Gm-Message-State: AOJu0Yz6Vq0MtWZlg0f1vYRNOkit0tWUw4zqp/lIqgjXokGpHE7C4qs8
        FFqgu9FMc3xipAB740cq8AarKdyln9MSft3j
X-Google-Smtp-Source: AGHT+IGIpeJX06Lh+aqA59KfRO7Sb5C5JS3MsILSw+tnumLBHHaQV1+DXO5n+nNaqI1rj3t+CvXKsA==
X-Received: by 2002:ac2:560a:0:b0:500:8b8d:d567 with SMTP id v10-20020ac2560a000000b005008b8dd567mr9728789lfd.1.1694009736951;
        Wed, 06 Sep 2023 07:15:36 -0700 (PDT)
Received: from desktop-nixos-martino.. ([2a01:e11:5004:180:66eb:4225:ad7f:c1e8])
        by smtp.gmail.com with ESMTPSA id r9-20020aa7d589000000b0052a1c0c859asm8571884edq.59.2023.09.06.07.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 07:15:36 -0700 (PDT)
From:   Martino Fontana <tinozzo123@gmail.com>
To:     djogorchock@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Martino Fontana <tinozzo123@gmail.com>
Subject: [PATCH v3] HID: nintendo: cleanup LED code
Date:   Wed,  6 Sep 2023 16:15:25 +0200
Message-ID: <20230906141533.36921-1-tinozzo123@gmail.com>
X-Mailer: git-send-email 2.41.0
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

- Only turn on the nth LED, instead of all the LEDs up to n. This better
  matches Nintendo consoles' behaviour, as they never turn on more than
  one LED.
  (Note that the behavior still consinsts in increasing the player number
  every time a controller is connected, never decreasing it. It should be
  as is described in https://bugzilla.kernel.org/show_bug.cgi?id=216225.
  However, any implementation here would stop making sense as soon as a
  non-Nintendo controller is connected, which is why I'm not bothering.)

- Split part of `joycon_home_led_brightness_set` (which is called by hid)
  into `joycon_set_home_led` (which is what actually sets the LEDs), for
  consistency with player LEDs.

- `joycon_player_led_brightness_set` won't try it to "determine which player
  led this is" anymore: it's already looking at every LED brightness value.

- Instead of first registering the `led_classdev`, then attempting to set
  the LED and unregistering the `led_classdev` if it fails, first attempt
  to set the LED, then register the `led_classdev` only if it succeeds
  (the class is still filled up in either case).

- If setting the player LEDs fails, still attempt setting the home LED.
  (I don't know there's a third party controller where this may actually
  happen, but who knows...)

- Use `JC_NUM_LEDS` where appropriate instead of 4.

- Print return codes in more places.

- Use spinlock instead of mutex for `input_num`. Copy its value to a local
  variable, so that it can be unlocked immediately.

- `input_num` starts counting from 0

- Less holding of mutexes in general.

Changes for v2:

Applied suggestions, commit message explains more stuff, restored `return ret`
when `devm_led_classdev_register` fails (since all other hid drivers do this).
If setting LED fails, `hid_warn` now explicitly says "skipping registration".

Changes for v3:

Fixed missing semicolon from the resend (I have no idea why it disappeared).

Signed-off-by: Martino Fontana <tinozzo123@gmail.com>
---
 drivers/hid/hid-nintendo.c | 117 ++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 60 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index a5ebe857a..ad3c1b74c 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -699,6 +699,25 @@ static int joycon_set_player_leds(struct joycon_ctlr *ctlr, u8 flash, u8 on)
 	return joycon_send_subcmd(ctlr, req, 1, HZ/4);
 }
 
+static int joycon_set_home_led(struct joycon_ctlr *ctlr, enum led_brightness brightness)
+{
+	struct joycon_subcmd_request *req;
+	u8 buffer[sizeof(*req) + 5] = { 0 };
+	u8 *data;
+
+	req = (struct joycon_subcmd_request *)buffer;
+	req->subcmd_id = JC_SUBCMD_SET_HOME_LIGHT;
+	data = req->data;
+	data[0] = 0x01;
+	data[1] = brightness << 4;
+	data[2] = brightness | (brightness << 4);
+	data[3] = 0x11;
+	data[4] = 0x11;
+
+	hid_dbg(ctlr->hdev, "setting home led brightness\n");
+	return joycon_send_subcmd(ctlr, req, 5, HZ/4);
+}
+
 static int joycon_request_spi_flash_read(struct joycon_ctlr *ctlr,
 					 u32 start_addr, u8 size, u8 **reply)
 {
@@ -1849,7 +1868,6 @@ static int joycon_player_led_brightness_set(struct led_classdev *led,
 	int val = 0;
 	int i;
 	int ret;
-	int num;
 
 	ctlr = hid_get_drvdata(hdev);
 	if (!ctlr) {
@@ -1857,21 +1875,10 @@ static int joycon_player_led_brightness_set(struct led_classdev *led,
 		return -ENODEV;
 	}
 
-	/* determine which player led this is */
-	for (num = 0; num < JC_NUM_LEDS; num++) {
-		if (&ctlr->leds[num] == led)
-			break;
-	}
-	if (num >= JC_NUM_LEDS)
-		return -EINVAL;
+	for (i = 0; i < JC_NUM_LEDS; i++)
+		val |= ctlr->leds[i].brightness << i;
 
 	mutex_lock(&ctlr->output_mutex);
-	for (i = 0; i < JC_NUM_LEDS; i++) {
-		if (i == num)
-			val |= brightness << i;
-		else
-			val |= ctlr->leds[i].brightness << i;
-	}
 	ret = joycon_set_player_leds(ctlr, 0, val);
 	mutex_unlock(&ctlr->output_mutex);
 
@@ -1884,9 +1891,6 @@ static int joycon_home_led_brightness_set(struct led_classdev *led,
 	struct device *dev = led->dev->parent;
 	struct hid_device *hdev = to_hid_device(dev);
 	struct joycon_ctlr *ctlr;
-	struct joycon_subcmd_request *req;
-	u8 buffer[sizeof(*req) + 5] = { 0 };
-	u8 *data;
 	int ret;
 
 	ctlr = hid_get_drvdata(hdev);
@@ -1894,25 +1898,13 @@ static int joycon_home_led_brightness_set(struct led_classdev *led,
 		hid_err(hdev, "No controller data\n");
 		return -ENODEV;
 	}
-
-	req = (struct joycon_subcmd_request *)buffer;
-	req->subcmd_id = JC_SUBCMD_SET_HOME_LIGHT;
-	data = req->data;
-	data[0] = 0x01;
-	data[1] = brightness << 4;
-	data[2] = brightness | (brightness << 4);
-	data[3] = 0x11;
-	data[4] = 0x11;
-
-	hid_dbg(hdev, "setting home led brightness\n");
 	mutex_lock(&ctlr->output_mutex);
-	ret = joycon_send_subcmd(ctlr, req, 5, HZ/4);
+	ret = joycon_set_home_led(ctlr, brightness);
 	mutex_unlock(&ctlr->output_mutex);
-
 	return ret;
 }
 
-static DEFINE_MUTEX(joycon_input_num_mutex);
+static DEFINE_SPINLOCK(joycon_input_num_spinlock);
 static int joycon_leds_create(struct joycon_ctlr *ctlr)
 {
 	struct hid_device *hdev = ctlr->hdev;
@@ -1920,17 +1912,16 @@ static int joycon_leds_create(struct joycon_ctlr *ctlr)
 	const char *d_name = dev_name(dev);
 	struct led_classdev *led;
 	char *name;
-	int ret = 0;
+	int ret;
 	int i;
-	static int input_num = 1;
+	unsigned long flags;
+	int player_led_number;
+	static int input_num;
 
-	/* Set the default controller player leds based on controller number */
-	mutex_lock(&joycon_input_num_mutex);
-	mutex_lock(&ctlr->output_mutex);
-	ret = joycon_set_player_leds(ctlr, 0, 0xF >> (4 - input_num));
-	if (ret)
-		hid_warn(ctlr->hdev, "Failed to set leds; ret=%d\n", ret);
-	mutex_unlock(&ctlr->output_mutex);
+	/* Set the player leds based on controller number */
+	spin_lock_irqsave(&joycon_input_num_spinlock, flags);
+	player_led_number = input_num++ % JC_NUM_LEDS;
+	spin_unlock_irqrestore(&joycon_input_num_spinlock, flags);
 
 	/* configure the player LEDs */
 	for (i = 0; i < JC_NUM_LEDS; i++) {
@@ -1938,31 +1929,34 @@ static int joycon_leds_create(struct joycon_ctlr *ctlr)
 				      d_name,
 				      "green",
 				      joycon_player_led_names[i]);
-		if (!name) {
-			mutex_unlock(&joycon_input_num_mutex);
+		if (!name)
 			return -ENOMEM;
-		}
 
 		led = &ctlr->leds[i];
 		led->name = name;
-		led->brightness = ((i + 1) <= input_num) ? 1 : 0;
+		led->brightness = (i == player_led_number) ? 1 : 0;
 		led->max_brightness = 1;
 		led->brightness_set_blocking =
 					joycon_player_led_brightness_set;
 		led->flags = LED_CORE_SUSPENDRESUME | LED_HW_PLUGGABLE;
+	}
+	mutex_lock(&ctlr->output_mutex);
+	ret = joycon_set_player_leds(ctlr, 0, 0x1 << player_led_number);
+	mutex_unlock(&ctlr->output_mutex);
+	if (ret) {
+		hid_warn(hdev, "Failed to set players LEDs, skipping registration; ret=%d\n", ret);
+		goto home_led;
+	}
 
+	for (i = 0; i < JC_NUM_LEDS; i++) {
+		led = &ctlr->leds[i];
 		ret = devm_led_classdev_register(&hdev->dev, led);
-		if (ret) {
-			hid_err(hdev, "Failed registering %s LED\n", led->name);
-			mutex_unlock(&joycon_input_num_mutex);
+		if (ret)
+			hid_err(hdev, "Failed to register player %d LED; ret=%d\n", i + 1, ret);
 			return ret;
-		}
 	}
 
-	if (++input_num > 4)
-		input_num = 1;
-	mutex_unlock(&joycon_input_num_mutex);
-
+home_led:
 	/* configure the home LED */
 	if (jc_type_has_right(ctlr)) {
 		name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s:%s",
@@ -1978,17 +1972,20 @@ static int joycon_leds_create(struct joycon_ctlr *ctlr)
 		led->max_brightness = 0xF;
 		led->brightness_set_blocking = joycon_home_led_brightness_set;
 		led->flags = LED_CORE_SUSPENDRESUME | LED_HW_PLUGGABLE;
-		ret = devm_led_classdev_register(&hdev->dev, led);
-		if (ret) {
-			hid_err(hdev, "Failed registering home led\n");
-			return ret;
-		}
+
 		/* Set the home LED to 0 as default state */
-		ret = joycon_home_led_brightness_set(led, 0);
+		mutex_lock(&ctlr->output_mutex);
+		ret = joycon_set_home_led(ctlr, 0);
+		mutex_unlock(&ctlr->output_mutex);
 		if (ret) {
-			hid_warn(hdev, "Failed to set home LED default, unregistering home LED");
-			devm_led_classdev_unregister(&hdev->dev, led);
+			hid_warn(hdev, "Failed to set home LED, skipping registration; ret=%d\n", ret);
+			return 0;
 		}
+
+		ret = devm_led_classdev_register(&hdev->dev, led);
+		if (ret)
+			hid_err(hdev, "Failed to register home LED; ret=%d\n", ret);
+			return ret;
 	}
 
 	return 0;
-- 
2.41.0


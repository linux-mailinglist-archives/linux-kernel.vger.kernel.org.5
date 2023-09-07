Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A497973DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343984AbjIGPcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245419AbjIGP31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:29:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9151170E;
        Thu,  7 Sep 2023 08:29:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401d61e9fecso2837705e9.0;
        Thu, 07 Sep 2023 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694100486; x=1694705286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BSRKg+LELYLme99XkRIhO/OA+PGjmCx60p3GSPYr/cg=;
        b=SpH+wuV10L4MIkUy8G6jVZapp6m5sZq+5P2LrBi5xBFuthL0znl58PqtyEqb0LPWHN
         3ttJj9CbO83WuqMg+14XEZzHYEnEV9myU3zHIDEAsRRnPz3XtvHpogpe08lpRXE9U2T9
         JtisJdG/1ulBLr3KQjbi9Hpgt6QokzM/RGfbVPXXQF4EpxXLATvTpzlZt6WsF+qDfU81
         GMTpHrkNjA92pFjMMWFpoXwauBo22yhEwnNUcvNFEFjm/CFpCctp600aIdnCAUg8OZXp
         2asODCIUZxC+rKw4CrPNIM24HiRjSGDbeQze7wND4qUykR+ipy7QV8d4W4/HCd9BCBvK
         xK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100486; x=1694705286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSRKg+LELYLme99XkRIhO/OA+PGjmCx60p3GSPYr/cg=;
        b=OMaeTzZNX3JuFCEHtd8a2QlOvyLQwCrzuJRmGWQzS7tjR4Zq9b5pPeaA89+Zj53IWW
         NGrMTZWLIRVQ4Y/V7inOj0hdbhLJqbmGlUayEhi4WWdv1Hpk2MWf5KoDqBsh6U5871iz
         pzyyRX+5A9TS9+VMLvfQQkUU1k98flsOQqqHJlLf5eQ4UTF9BdLn7AiRm0eLFfEkVtoy
         E+G/i5JqFhCCbj9cgnv1cW6ga6mIUwqZEtafRsQ9voaJ6YeohHWwcXNhAxhrpMVCGuIk
         Kowdda85UbMgQ5oskpmoSSWmABFKb6JMRMCctbvhVvpHWnZWJ9gUDtdh5b4vRFKwJprU
         HJ9A==
X-Gm-Message-State: AOJu0Ywe6Fum3abC1CDFUGEwpqTpYTM7TzAn6LHvEL02XY0IBKBVEr1f
        z7uwh/+HYQb+2kxm/lsa+u4kP4qIstsYQMBc
X-Google-Smtp-Source: AGHT+IHbpl1ilkHKpd3aQf6x/2+GMxsdvHaLv2Vqf2pMsRpLxk9weaUGpTl871U2w9yu1tCmUs0BIQ==
X-Received: by 2002:a17:906:109a:b0:9a1:ffec:aadf with SMTP id u26-20020a170906109a00b009a1ffecaadfmr12827540eju.5.1694080314450;
        Thu, 07 Sep 2023 02:51:54 -0700 (PDT)
Received: from desktop-nixos-martino.. ([2a01:e11:5004:180:ef6b:d5bb:8f1f:954f])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906495900b0099d9dee8108sm10304504ejt.149.2023.09.07.02.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:51:53 -0700 (PDT)
From:   Martino Fontana <tinozzo123@gmail.com>
To:     djogorchock@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Martino Fontana <tinozzo123@gmail.com>
Subject: [PATCH v4] HID: nintendo: cleanup LED code
Date:   Thu,  7 Sep 2023 11:49:04 +0200
Message-ID: <20230907094926.8278-1-tinozzo123@gmail.com>
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

Changes for v3 and v4:

Fixed errors and warnings from test robot.

Signed-off-by: Martino Fontana <tinozzo123@gmail.com>
---
 drivers/hid/hid-nintendo.c | 113 ++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 57 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index a5ebe857a..543098a8c 100644
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
@@ -1938,31 +1929,35 @@ static int joycon_leds_create(struct joycon_ctlr *ctlr)
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
 		if (ret) {
-			hid_err(hdev, "Failed registering %s LED\n", led->name);
-			mutex_unlock(&joycon_input_num_mutex);
+			hid_err(hdev, "Failed to register player %d LED; ret=%d\n", i + 1, ret);
 			return ret;
 		}
 	}
 
-	if (++input_num > 4)
-		input_num = 1;
-	mutex_unlock(&joycon_input_num_mutex);
-
+home_led:
 	/* configure the home LED */
 	if (jc_type_has_right(ctlr)) {
 		name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s:%s",
@@ -1978,16 +1973,20 @@ static int joycon_leds_create(struct joycon_ctlr *ctlr)
 		led->max_brightness = 0xF;
 		led->brightness_set_blocking = joycon_home_led_brightness_set;
 		led->flags = LED_CORE_SUSPENDRESUME | LED_HW_PLUGGABLE;
-		ret = devm_led_classdev_register(&hdev->dev, led);
+
+		/* Set the home LED to 0 as default state */
+		mutex_lock(&ctlr->output_mutex);
+		ret = joycon_set_home_led(ctlr, 0);
+		mutex_unlock(&ctlr->output_mutex);
 		if (ret) {
-			hid_err(hdev, "Failed registering home led\n");
-			return ret;
+			hid_warn(hdev, "Failed to set home LED, skipping registration; ret=%d\n", ret);
+			return 0;
 		}
-		/* Set the home LED to 0 as default state */
-		ret = joycon_home_led_brightness_set(led, 0);
+
+		ret = devm_led_classdev_register(&hdev->dev, led);
 		if (ret) {
-			hid_warn(hdev, "Failed to set home LED default, unregistering home LED");
-			devm_led_classdev_unregister(&hdev->dev, led);
+			hid_err(hdev, "Failed to register home LED; ret=%d\n", ret);
+			return ret;
 		}
 	}
 
-- 
2.41.0


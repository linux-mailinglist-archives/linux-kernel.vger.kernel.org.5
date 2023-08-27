Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6688B78A028
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 18:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjH0QWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 12:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjH0QVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 12:21:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C069F5;
        Sun, 27 Aug 2023 09:21:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-313e742a787so1509251f8f.1;
        Sun, 27 Aug 2023 09:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693153298; x=1693758098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umu9Cg68byW09n+Mwd3E9jBr6hmLuOPyXOBK72DjmBo=;
        b=p6Ht/hSklgtY8/P7CJc/5Oe2Xhq1mt9Qs27uRDpkCK+2uc96RTyif0ydhYTzmxTAzd
         TBO9zjECOJtoQdgnxpRcTDd72oKNpT0ygQsQuUWIVQY+dtm0kqQ8ITDHI/yNM6p/++c8
         cetQVd6eZrsOgeaUoXRr+RB1sDpsrD0EJ6N/xaXDftUKaIi72bfzvHo42IlHleSY3wsn
         vbPNt23wTcIfvhzDeXsh30e8ov4Ou0q2+LQiCHGJEkvxCXVDzuLtzEqwY7+EcPDewX5c
         3nB/lwpUeTEJhFreQJ4iaLZsR6Ee9/2K1LKhh6/4UOtqg3eIX6Qr4um68iSkzr7vZ3Ih
         +6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693153298; x=1693758098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umu9Cg68byW09n+Mwd3E9jBr6hmLuOPyXOBK72DjmBo=;
        b=F6oYs0ioePTMH+p90vQZUBuiSdk4Y8pJ6mkllJSryDCMZiw+RNU9ri30WxUqWB+Uqn
         LD7zRt6IY5LDhaRPn1cFeqtXGn+iI+3yxw4WvckpfTQ2bjfZplSLg07MW3Q3qph8lUgr
         90PngOREhawwilUn0O0s6ziX+Xq6HpXuo7lbMe4M+PApQ/AswN3mQ22Jq1rH2e/6MEYd
         Sgv/uY0BObItPeTxq2OI9kdj90Kcz+Q+nFxkyaWqxQ+dxML1Zd6vuHejRHhAQTBAAVRD
         nvBR5B6kKtP7fzilToUrS+MXrzdmLKx8ugXmc3kwbd9cBr8RJCPsnPerWbCoChqzwm7y
         xSFA==
X-Gm-Message-State: AOJu0YwmsH8LtMkhnzDx1HVP5M/0Gb2Eea3yjlQDxWz82rK0XqnatyOw
        /3KMlyfLHINWBzQQ4kVc9YvnXL524PUtdw==
X-Google-Smtp-Source: AGHT+IHXPkWFS9etdLeLrtB21p6gekyojf+fNsYIE45SrwuZKgTcC5E+N9MOvqYa9+43L26pHFCWeA==
X-Received: by 2002:adf:e583:0:b0:31a:cca0:2f3a with SMTP id l3-20020adfe583000000b0031acca02f3amr21627256wrm.0.1693153297402;
        Sun, 27 Aug 2023 09:21:37 -0700 (PDT)
Received: from localhost.localdomain (cpc157791-rdng31-2-0-cust585.15-3.cable.virginm.net. [86.24.214.74])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c020600b003fc04d13242sm11440824wmi.0.2023.08.27.09.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 09:21:37 -0700 (PDT)
From:   Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To:     ilpo.jarvinen@linux.intel.com
Cc:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ike Panhc <ike.pan@canonical.com>
Subject: [PATCH v3] platform/x86: ideapad-laptop: Add support for keyboard backlights using KBLC ACPI symbol
Date:   Sun, 27 Aug 2023 17:19:41 +0100
Message-ID: <20230827161940.485200-1-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <4aa2e668-aa50-202f-6ce-3d4cc1209b@linux.intel.com>
References: <4aa2e668-aa50-202f-6ce-3d4cc1209b@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer Lenovo laptops seem to use the KBLC symbol to control the backlight
Add support for handling the keyboard backlight on these devices

Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
---

Thanks, applied your feedback

v1 -> v2:
 - Replace keyboard identification hex literals with defines
 - Use a helper macro for checking a keyboard type is tristate
 - Reworked ideapad_kbd_bl_brightness_set
 - Reworked ideapad_kbd_bl_brightness_get
 - Clean up newlines and stray change
 - Use GENMASK, FIELD_GET and FIELD_PUT instead of manual masking and shifting
 - Correct format specifiers for new warnings

v2 -> v3:
 - Use named define for keyboard brightness event
 - Replaced CHECK_KBD_BL_TRISTATE macro with static function
 - Dropped _MASK suffix for bit masking
 - Use FIELD_PREP for the get command too
 - Ignore least significant bit in KBD__BL_GET_BRIGHTNESS mask

---
 drivers/platform/x86/ideapad-laptop.c | 118 ++++++++++++++++++++++++--
 1 file changed, 112 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index d2fee9a3e239..4a19a396fc3b 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -10,6 +10,7 @@
 
 #include <linux/acpi.h>
 #include <linux/backlight.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/debugfs.h>
@@ -85,6 +86,31 @@ enum {
 	SALS_FNLOCK_OFF       = 0xf,
 };
 
+/*
+ * These correspond to the number of supported states - 1
+ * Future keyboard types may need a new system, if there's a collision
+ * KBD_BL_TRISTATE_AUTO has no way to report or set the auto state
+ * so it effectively has 3 states, but needs to handle 4
+ */
+enum {
+	KBD_BL_STANDARD      = 1,
+	KBD_BL_TRISTATE      = 2,
+	KBD_BL_TRISTATE_AUTO = 3,
+};
+
+#define KBD_BL_QUERY_TYPE		0x1
+#define KBD_BL_TRISTATE_TYPE		0x5
+#define KBD_BL_TRISTATE_AUTO_TYPE	0x7
+
+#define KBD_BL_COMMAND_GET		0x2
+#define KBD_BL_COMMAND_SET		0x3
+#define KBD_BL_COMMAND_TYPE		GENMASK(7, 4)
+
+#define KBD_BL_GET_BRIGHTNESS		GENMASK(15, 1)
+#define KBD_BL_SET_BRIGHTNESS		GENMASK(19, 16)
+
+#define KBD_BL_KBLC_CHANGED_EVENT	12
+
 struct ideapad_dytc_priv {
 	enum platform_profile_option current_profile;
 	struct platform_profile_handler pprof;
@@ -122,6 +148,7 @@ struct ideapad_private {
 	} features;
 	struct {
 		bool initialized;
+		int type;
 		struct led_classdev led;
 		unsigned int last_brightness;
 	} kbd_bl;
@@ -242,6 +269,16 @@ static int exec_sals(acpi_handle handle, unsigned long arg)
 	return exec_simple_method(handle, "SALS", arg);
 }
 
+static int exec_kblc(acpi_handle handle, unsigned long arg)
+{
+	return exec_simple_method(handle, "KBLC", arg);
+}
+
+static int eval_kblc(acpi_handle handle, unsigned long cmd, unsigned long *res)
+{
+	return eval_int_with_arg(handle, "KBLC", cmd, res);
+}
+
 static int eval_dytc(acpi_handle handle, unsigned long cmd, unsigned long *res)
 {
 	return eval_int_with_arg(handle, "DYTC", cmd, res);
@@ -1270,16 +1307,47 @@ static void ideapad_backlight_notify_brightness(struct ideapad_private *priv)
 /*
  * keyboard backlight
  */
+static int ideapad_kbd_bl_check_tristate(int type)
+{
+	return (type == KBD_BL_TRISTATE) || (type == KBD_BL_TRISTATE_AUTO);
+}
+
 static int ideapad_kbd_bl_brightness_get(struct ideapad_private *priv)
 {
-	unsigned long hals;
+	unsigned long value;
 	int err;
 
-	err = eval_hals(priv->adev->handle, &hals);
+	if (ideapad_kbd_bl_check_tristate(priv->kbd_bl.type)) {
+		err = eval_kblc(priv->adev->handle,
+				FIELD_PREP(KBD_BL_COMMAND_TYPE, priv->kbd_bl.type) |
+				KBD_BL_COMMAND_GET,
+				&value);
+
+		if (err)
+			return err;
+
+		/* Convert returned value to brightness level */
+		value = FIELD_GET(KBD_BL_GET_BRIGHTNESS, value);
+
+		/* Off, low or high */
+		if (value <= priv->kbd_bl.led.max_brightness)
+			return value;
+
+		/* Auto, report as off */
+		if (value == priv->kbd_bl.led.max_brightness + 1)
+			return 0;
+
+		/* Unknown value */
+		dev_warn(&priv->platform_device->dev,
+			 "Unknown keyboard backlight value: %lu", value);
+		return -EINVAL;
+	}
+
+	err = eval_hals(priv->adev->handle, &value);
 	if (err)
 		return err;
 
-	return !!test_bit(HALS_KBD_BL_STATE_BIT, &hals);
+	return !!test_bit(HALS_KBD_BL_STATE_BIT, &value);
 }
 
 static enum led_brightness ideapad_kbd_bl_led_cdev_brightness_get(struct led_classdev *led_cdev)
@@ -1291,7 +1359,21 @@ static enum led_brightness ideapad_kbd_bl_led_cdev_brightness_get(struct led_cla
 
 static int ideapad_kbd_bl_brightness_set(struct ideapad_private *priv, unsigned int brightness)
 {
-	int err = exec_sals(priv->adev->handle, brightness ? SALS_KBD_BL_ON : SALS_KBD_BL_OFF);
+	int err;
+	unsigned long value;
+	int type = priv->kbd_bl.type;
+
+	if (ideapad_kbd_bl_check_tristate(type)) {
+		if (brightness > priv->kbd_bl.led.max_brightness)
+			return -EINVAL;
+
+		value = FIELD_PREP(KBD_BL_SET_BRIGHTNESS, brightness) |
+			FIELD_PREP(KBD_BL_COMMAND_TYPE, type) |
+			KBD_BL_COMMAND_SET;
+		err = exec_kblc(priv->adev->handle, value);
+	} else {
+		err = exec_sals(priv->adev->handle, brightness ? SALS_KBD_BL_ON : SALS_KBD_BL_OFF);
+	}
 
 	if (err)
 		return err;
@@ -1344,8 +1426,13 @@ static int ideapad_kbd_bl_init(struct ideapad_private *priv)
 
 	priv->kbd_bl.last_brightness = brightness;
 
+	if (ideapad_kbd_bl_check_tristate(priv->kbd_bl.type)) {
+		priv->kbd_bl.led.max_brightness = 2;
+	} else {
+		priv->kbd_bl.led.max_brightness = 1;
+	}
+
 	priv->kbd_bl.led.name                    = "platform::" LED_FUNCTION_KBD_BACKLIGHT;
-	priv->kbd_bl.led.max_brightness          = 1;
 	priv->kbd_bl.led.brightness_get          = ideapad_kbd_bl_led_cdev_brightness_get;
 	priv->kbd_bl.led.brightness_set_blocking = ideapad_kbd_bl_led_cdev_brightness_set;
 	priv->kbd_bl.led.flags                   = LED_BRIGHT_HW_CHANGED;
@@ -1456,6 +1543,7 @@ static void ideapad_acpi_notify(acpi_handle handle, u32 event, void *data)
 		case 2:
 			ideapad_backlight_notify_power(priv);
 			break;
+		case KBD_BL_KBLC_CHANGED_EVENT:
 		case 1:
 			/*
 			 * Some IdeaPads report event 1 every ~20
@@ -1557,13 +1645,31 @@ static void ideapad_check_features(struct ideapad_private *priv)
 			if (test_bit(HALS_FNLOCK_SUPPORT_BIT, &val))
 				priv->features.fn_lock = true;
 
-			if (test_bit(HALS_KBD_BL_SUPPORT_BIT, &val))
+			if (test_bit(HALS_KBD_BL_SUPPORT_BIT, &val)) {
 				priv->features.kbd_bl = true;
+				priv->kbd_bl.type = KBD_BL_STANDARD;
+			}
 
 			if (test_bit(HALS_USB_CHARGING_SUPPORT_BIT, &val))
 				priv->features.usb_charging = true;
 		}
 	}
+
+	if (acpi_has_method(handle, "KBLC")) {
+		if (!eval_kblc(priv->adev->handle, KBD_BL_QUERY_TYPE, &val)) {
+			if (val == KBD_BL_TRISTATE_TYPE) {
+				priv->features.kbd_bl = true;
+				priv->kbd_bl.type = KBD_BL_TRISTATE;
+			} else if (val == KBD_BL_TRISTATE_AUTO_TYPE) {
+				priv->features.kbd_bl = true;
+				priv->kbd_bl.type = KBD_BL_TRISTATE_AUTO;
+			} else {
+				dev_warn(&priv->platform_device->dev,
+					 "Unknown keyboard type: %lu",
+					 val);
+			}
+		}
+	}
 }
 
 #if IS_ENABLED(CONFIG_ACPI_WMI)
-- 
2.40.1.521.gf1e218fcd8


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115527939C5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbjIFKZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjIFKZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:25:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF57E47;
        Wed,  6 Sep 2023 03:25:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52a1c58ef30so1053095a12.1;
        Wed, 06 Sep 2023 03:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693995949; x=1694600749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ci/ELsipo0gd0dH4A82+2RtSVRggb4j1DAuDHo22Q9Q=;
        b=FM6Z9y4HtBWZ+OBmjbSqd0z97+HitVFxv2Yh1S8uGlu+XNzD3Dv1GPanBx3fNW3Hmj
         +GiXV/dBqawREnkboDBkmOmwZbeDpmRs8XqnpJC8eY60z+Z3xWYChXn7tAgTOQU7+twH
         tvJHa562/i/ZfyWwUCERoGLacI5gkXgEwLfNugaUQFgsjQ5+uFNkj79s00tXJyq9wFUH
         cZWNrTPoNjTypr1SSPGdWVdObtwb/FIdiu1Ss1gEY41CdHpGBcr0LHqJbsRSxYLWp7yN
         m46kOm30QCcE3N6a8lkd4Tqh+s7xYGU+nK6+2lRxlka8+wGzHdY+5x/jBqfBb627kj8B
         e2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693995949; x=1694600749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ci/ELsipo0gd0dH4A82+2RtSVRggb4j1DAuDHo22Q9Q=;
        b=JUlYYRkHh047XnRpqcxVvuaOuEqXNAc8GKbhyXiR3DNwGlIOdW1rPOz8eWzXqlKPDo
         d2ffMoVXLg5F8FZM8uthCyFZtdXrSt4CjvQzyiLOgJE4+jP7GlWaJtkq1jUR6/gBEmwI
         t5guy9piC8oUHrM48leJeYUyQwGTI+VUdfDNJMDpQrViaMC0WxIaXir1Up5bhGINh+Te
         Q9sqwQfLtiN+XLNBe/06T5FcKYVEy/c+/kEr9lbHf29XuqFnYpWuk7YS/luFIZN2wwrx
         whjSpjIZHEXXrZmerZucb02dVUV6gRlnSbDEwDersjyeJ6rULVFoFRavw2wB5NYJ6tvx
         z30Q==
X-Gm-Message-State: AOJu0YzPYh9Mbgohj19i/KH2nn+KqGolzZlaZ1Jf5Oc5+fTCJFUr/O3J
        lJAVr1x0ViDwfCBYXmZT3Fg=
X-Google-Smtp-Source: AGHT+IHZs0ML1rnXrtyFgcY9LcYJ2FxDIAnIIChJszpYfo6bMfx2A1WKQBg/InjODbvg4ZaONjBPTw==
X-Received: by 2002:a05:6402:4304:b0:523:100b:839a with SMTP id m4-20020a056402430400b00523100b839amr11584415edc.0.1693995948998;
        Wed, 06 Sep 2023 03:25:48 -0700 (PDT)
Received: from desktop-nixos-martino.. ([2a01:e11:5004:180:d575:320e:c3b7:48cc])
        by smtp.gmail.com with ESMTPSA id fj22-20020a0564022b9600b005256aaa6e7asm2078907edb.78.2023.09.06.03.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:25:48 -0700 (PDT)
From:   Martino Fontana <tinozzo123@gmail.com>
To:     djogorchock@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Martino Fontana <tinozzo123@gmail.com>
Subject: [PATCH v2 RESEND] HID: nintendo: reinitialize USB Pro Controller after resuming from suspend
Date:   Wed,  6 Sep 2023 12:20:15 +0200
Message-ID: <20230906102507.15504-2-tinozzo123@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When suspending the computer, a Switch Pro Controller connected via USB will
lose its internal status. However, because the USB connection was technically
never lost, when resuming the computer, the driver will attempt to communicate
with the controller as if nothing happened (and fail).
Because of this, the user was forced to manually disconnect the controller
(or to press the sync button on the controller to power it off), so that it
can be re-initialized.

With this patch, the controller will be automatically re-initialized after
resuming from suspend.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216233

Signed-off-by: Martino Fontana <tinozzo123@gmail.com>
---
 drivers/hid/hid-nintendo.c | 178 ++++++++++++++++++++++---------------
 1 file changed, 106 insertions(+), 72 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 250f5d2f8..a5ebe857a 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2088,7 +2088,9 @@ static int joycon_read_info(struct joycon_ctlr *ctlr)
 	struct joycon_input_report *report;
 
 	req.subcmd_id = JC_SUBCMD_REQ_DEV_INFO;
+	mutex_lock(&ctlr->output_mutex);
 	ret = joycon_send_subcmd(ctlr, &req, 0, HZ);
+	mutex_unlock(&ctlr->output_mutex);
 	if (ret) {
 		hid_err(ctlr->hdev, "Failed to get joycon info; ret=%d\n", ret);
 		return ret;
@@ -2117,6 +2119,88 @@ static int joycon_read_info(struct joycon_ctlr *ctlr)
 	return 0;
 }
 
+static int joycon_init(struct hid_device *hdev)
+{
+	struct joycon_ctlr *ctlr = hid_get_drvdata(hdev);
+	int ret = 0;
+
+	mutex_lock(&ctlr->output_mutex);
+	/* if handshake command fails, assume ble pro controller */
+	if ((jc_type_is_procon(ctlr) || jc_type_is_chrggrip(ctlr)) &&
+	    !joycon_send_usb(ctlr, JC_USB_CMD_HANDSHAKE, HZ)) {
+		hid_dbg(hdev, "detected USB controller\n");
+		/* set baudrate for improved latency */
+		ret = joycon_send_usb(ctlr, JC_USB_CMD_BAUDRATE_3M, HZ);
+		if (ret) {
+			hid_err(hdev, "Failed to set baudrate; ret=%d\n", ret);
+			goto err_mutex;
+		}
+		/* handshake */
+		ret = joycon_send_usb(ctlr, JC_USB_CMD_HANDSHAKE, HZ);
+		if (ret) {
+			hid_err(hdev, "Failed handshake; ret=%d\n", ret);
+			goto err_mutex;
+		}
+		/*
+		 * Set no timeout (to keep controller in USB mode).
+		 * This doesn't send a response, so ignore the timeout.
+		 */
+		joycon_send_usb(ctlr, JC_USB_CMD_NO_TIMEOUT, HZ/10);
+	} else if (jc_type_is_chrggrip(ctlr)) {
+		hid_err(hdev, "Failed charging grip handshake\n");
+		ret = -ETIMEDOUT;
+		goto err_mutex;
+	}
+
+	/* get controller calibration data, and parse it */
+	ret = joycon_request_calibration(ctlr);
+	if (ret) {
+		/*
+		 * We can function with default calibration, but it may be
+		 * inaccurate. Provide a warning, and continue on.
+		 */
+		hid_warn(hdev, "Analog stick positions may be inaccurate\n");
+	}
+
+	/* get IMU calibration data, and parse it */
+	ret = joycon_request_imu_calibration(ctlr);
+	if (ret) {
+		/*
+		 * We can function with default calibration, but it may be
+		 * inaccurate. Provide a warning, and continue on.
+		 */
+		hid_warn(hdev, "Unable to read IMU calibration data\n");
+	}
+
+	/* Set the reporting mode to 0x30, which is the full report mode */
+	ret = joycon_set_report_mode(ctlr);
+	if (ret) {
+		hid_err(hdev, "Failed to set report mode; ret=%d\n", ret);
+		goto err_mutex;
+	}
+
+	/* Enable rumble */
+	ret = joycon_enable_rumble(ctlr);
+	if (ret) {
+		hid_err(hdev, "Failed to enable rumble; ret=%d\n", ret);
+		goto err_mutex;
+	}
+
+	/* Enable the IMU */
+	ret = joycon_enable_imu(ctlr);
+	if (ret) {
+		hid_err(hdev, "Failed to enable the IMU; ret=%d\n", ret);
+		goto err_mutex;
+	}
+
+	mutex_unlock(&ctlr->output_mutex);
+	return 0;
+
+err_mutex:
+	mutex_unlock(&ctlr->output_mutex);
+	return ret;
+}
+
 /* Common handler for parsing inputs */
 static int joycon_ctlr_read_handler(struct joycon_ctlr *ctlr, u8 *data,
 							      int size)
@@ -2248,85 +2332,19 @@ static int nintendo_hid_probe(struct hid_device *hdev,
 
 	hid_device_io_start(hdev);
 
-	/* Initialize the controller */
-	mutex_lock(&ctlr->output_mutex);
-	/* if handshake command fails, assume ble pro controller */
-	if ((jc_type_is_procon(ctlr) || jc_type_is_chrggrip(ctlr)) &&
-	    !joycon_send_usb(ctlr, JC_USB_CMD_HANDSHAKE, HZ)) {
-		hid_dbg(hdev, "detected USB controller\n");
-		/* set baudrate for improved latency */
-		ret = joycon_send_usb(ctlr, JC_USB_CMD_BAUDRATE_3M, HZ);
-		if (ret) {
-			hid_err(hdev, "Failed to set baudrate; ret=%d\n", ret);
-			goto err_mutex;
-		}
-		/* handshake */
-		ret = joycon_send_usb(ctlr, JC_USB_CMD_HANDSHAKE, HZ);
-		if (ret) {
-			hid_err(hdev, "Failed handshake; ret=%d\n", ret);
-			goto err_mutex;
-		}
-		/*
-		 * Set no timeout (to keep controller in USB mode).
-		 * This doesn't send a response, so ignore the timeout.
-		 */
-		joycon_send_usb(ctlr, JC_USB_CMD_NO_TIMEOUT, HZ/10);
-	} else if (jc_type_is_chrggrip(ctlr)) {
-		hid_err(hdev, "Failed charging grip handshake\n");
-		ret = -ETIMEDOUT;
-		goto err_mutex;
-	}
-
-	/* get controller calibration data, and parse it */
-	ret = joycon_request_calibration(ctlr);
-	if (ret) {
-		/*
-		 * We can function with default calibration, but it may be
-		 * inaccurate. Provide a warning, and continue on.
-		 */
-		hid_warn(hdev, "Analog stick positions may be inaccurate\n");
-	}
-
-	/* get IMU calibration data, and parse it */
-	ret = joycon_request_imu_calibration(ctlr);
-	if (ret) {
-		/*
-		 * We can function with default calibration, but it may be
-		 * inaccurate. Provide a warning, and continue on.
-		 */
-		hid_warn(hdev, "Unable to read IMU calibration data\n");
-	}
-
-	/* Set the reporting mode to 0x30, which is the full report mode */
-	ret = joycon_set_report_mode(ctlr);
-	if (ret) {
-		hid_err(hdev, "Failed to set report mode; ret=%d\n", ret);
-		goto err_mutex;
-	}
-
-	/* Enable rumble */
-	ret = joycon_enable_rumble(ctlr);
-	if (ret) {
-		hid_err(hdev, "Failed to enable rumble; ret=%d\n", ret);
-		goto err_mutex;
-	}
-
-	/* Enable the IMU */
-	ret = joycon_enable_imu(ctlr);
+	ret = joycon_init(hdev);
 	if (ret) {
-		hid_err(hdev, "Failed to enable the IMU; ret=%d\n", ret);
-		goto err_mutex;
+		hid_err(hdev, "Failed to initialize controller; ret=%d\n", ret);
+		goto err_close;
 	}
 
 	ret = joycon_read_info(ctlr);
 	if (ret) {
 		hid_err(hdev, "Failed to retrieve controller info; ret=%d\n",
 			ret);
-		goto err_mutex;
+		goto err_close;
 	}
 
-	mutex_unlock(&ctlr->output_mutex);
-
 	/* Initialize the leds */
 	ret = joycon_leds_create(ctlr);
 	if (ret) {
@@ -2352,8 +2370,6 @@ static int nintendo_hid_probe(struct hid_device *hdev,
 	hid_dbg(hdev, "probe - success\n");
 	return 0;
 
-err_mutex:
-	mutex_unlock(&ctlr->output_mutex);
 err_close:
 	hid_hw_close(hdev);
 err_stop:
@@ -2383,6 +2399,20 @@ static void nintendo_hid_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 }
 
+#ifdef CONFIG_PM
+
+static int nintendo_hid_resume(struct hid_device *hdev)
+{
+	int ret = joycon_init(hdev);
+
+	if (ret)
+		hid_err(hdev, "Failed to restore controller after resume");
+
+	return ret;
+}
+
+#endif
+
 static const struct hid_device_id nintendo_hid_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NINTENDO,
 			 USB_DEVICE_ID_NINTENDO_PROCON) },
@@ -2404,6 +2434,10 @@ static struct hid_driver nintendo_hid_driver = {
 	.probe		= nintendo_hid_probe,
 	.remove		= nintendo_hid_remove,
 	.raw_event	= nintendo_hid_event,
+
+#ifdef CONFIG_PM
+	.resume		= nintendo_hid_resume,
+#endif
 };
 module_hid_driver(nintendo_hid_driver);
 
-- 
2.41.0


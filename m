Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C3B7AC9EE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 16:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjIXONf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 10:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXONe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:13:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A505FA;
        Sun, 24 Sep 2023 07:13:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-404800222d2so11921655e9.0;
        Sun, 24 Sep 2023 07:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695564806; x=1696169606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g75BzRaRkO9oRTJYb9F8+v/ms9n2RPmAlt8qWo05vUc=;
        b=fKhK2bCs38DW39YoMkIIzsqCfoPKvC8T3Zj1t2+vuzKTyOrOiKGWE7ab22fUoLLz4B
         GnDghThPyzsEpw5Zf8eUNHxXAjIh2QvO+qHqbrmRndfJQYWPCriING9taTNMY1dUNNbc
         wlmcPMlh/ufIGN7RoWgxb7BlNxLqzMODcXKnOYOwDNbLzK8CdN6VJeJK2qFqj7xuX0hY
         zRLlzr08oNefSl2SyApQ6IkREc0Nw5pzFDBt+AFvRX/1u+UmOU7EGuXykgbSlK3YkCqS
         18Yy17AQ1/AlR8GLsuti70h0NYf1z1Q3dCJroHJX/AHC9Dv4rmMRvVYQ1Tn0pHR5KxVq
         dzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695564806; x=1696169606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g75BzRaRkO9oRTJYb9F8+v/ms9n2RPmAlt8qWo05vUc=;
        b=dc6O+3W6gteYyGng/pDSVmVwQZDf7o/Rykd5lmuqgI3QzeM25MmwS/fpk13hffNK36
         bvOtPqG35qgD4UtWFF8XtG2455iHGSUu8Qht2lBCwdGQ8bimoe0iJe3jlmAvQYueOpLF
         GoPiC2O3uRfgclZjYrx53oAIQBROblhLhmXs8wr7JMAim0y06Gbqg/C0QNd9Bpk4cnL7
         RGczGcHFWVYOzw36Fp4tn3c0ar5BJDPxKXMWSOM7UHnWxZ6ryk1KOjySY00txJ95uReW
         dR9EBsfe72yeu5e3ilp96krM9pOMeQaCHg0HxKLXaBAQdahzXpwfu4c8wiaKXTQvG5WK
         lOZg==
X-Gm-Message-State: AOJu0YyPVrp7iqPBnjgBLPZmTW7WXqXvfqxcxtj3FTK34oG9RRpgXYWz
        CZd6GXcNbRMy7gulzG5hncU=
X-Google-Smtp-Source: AGHT+IHLI158DJYlJQGAElRC+dFbhrB/H1duK9xvwnx70IB6Xffkh90oQ55p3nmYuDQiVbLoZUUB/g==
X-Received: by 2002:a7b:c456:0:b0:3fe:d637:7b25 with SMTP id l22-20020a7bc456000000b003fed6377b25mr4229729wmi.0.1695564805593;
        Sun, 24 Sep 2023 07:13:25 -0700 (PDT)
Received: from desktop-nixos-martino.. ([2a01:e11:5004:180::bd5a:12c2])
        by smtp.gmail.com with ESMTPSA id cb9-20020a0564020b6900b00533ec6c617asm982173edb.54.2023.09.24.07.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 07:13:25 -0700 (PDT)
From:   Martino Fontana <tinozzo123@gmail.com>
To:     djogorchock@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Martino Fontana <tinozzo123@gmail.com>
Subject: [PATCH v3] HID: nintendo: reinitialize USB Pro Controller after resuming from suspend
Date:   Sun, 24 Sep 2023 16:06:01 +0200
Message-ID: <20230924140927.9844-2-tinozzo123@gmail.com>
X-Mailer: git-send-email 2.42.0
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
Changes for v2 and v3: Applied suggestions

 drivers/hid/hid-nintendo.c | 175 ++++++++++++++++++++++---------------
 1 file changed, 103 insertions(+), 72 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 250f5d2f8..10468f727 100644
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
@@ -2117,6 +2119,85 @@ static int joycon_read_info(struct joycon_ctlr *ctlr)
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
+			goto out_unlock;
+		}
+		/* handshake */
+		ret = joycon_send_usb(ctlr, JC_USB_CMD_HANDSHAKE, HZ);
+		if (ret) {
+			hid_err(hdev, "Failed handshake; ret=%d\n", ret);
+			goto out_unlock;
+		}
+		/*
+		 * Set no timeout (to keep controller in USB mode).
+		 * This doesn't send a response, so ignore the timeout.
+		 */
+		joycon_send_usb(ctlr, JC_USB_CMD_NO_TIMEOUT, HZ/10);
+	} else if (jc_type_is_chrggrip(ctlr)) {
+		hid_err(hdev, "Failed charging grip handshake\n");
+		ret = -ETIMEDOUT;
+		goto out_unlock;
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
+		goto out_unlock;
+	}
+
+	/* Enable rumble */
+	ret = joycon_enable_rumble(ctlr);
+	if (ret) {
+		hid_err(hdev, "Failed to enable rumble; ret=%d\n", ret);
+		goto out_unlock;
+	}
+
+	/* Enable the IMU */
+	ret = joycon_enable_imu(ctlr);
+	if (ret) {
+		hid_err(hdev, "Failed to enable the IMU; ret=%d\n", ret);
+		goto out_unlock;
+	}
+
+out_unlock:
+	mutex_unlock(&ctlr->output_mutex);
+	return ret;
+}
+
 /* Common handler for parsing inputs */
 static int joycon_ctlr_read_handler(struct joycon_ctlr *ctlr, u8 *data,
 							      int size)
@@ -2248,85 +2329,19 @@ static int nintendo_hid_probe(struct hid_device *hdev,
 
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
+	ret = joycon_init(hdev);
 	if (ret) {
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
-	if (ret) {
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
@@ -2352,8 +2367,6 @@ static int nintendo_hid_probe(struct hid_device *hdev,
 	hid_dbg(hdev, "probe - success\n");
 	return 0;
 
-err_mutex:
-	mutex_unlock(&ctlr->output_mutex);
 err_close:
 	hid_hw_close(hdev);
 err_stop:
@@ -2383,6 +2396,20 @@ static void nintendo_hid_remove(struct hid_device *hdev)
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
@@ -2404,6 +2431,10 @@ static struct hid_driver nintendo_hid_driver = {
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
2.42.0


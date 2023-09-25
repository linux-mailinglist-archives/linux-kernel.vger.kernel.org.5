Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F9A7AD5C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjIYKXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjIYKXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:23:42 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3B0106
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:23:34 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id CAAB8240027
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 12:23:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1695637412; bh=CzIIBHhlGAUxGhgWQf9eNBaRxB1SQS0JeVLGWV4aCTg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=n5CfrwIijMTHzdteJC4xWcCmgA2fo9KTVN4hHrrDqh/yQ7LMtmhAAEcLAoiRbPXQs
         RKUlkchun4xmXQLgzUPYNQovwROlI2vu1JPB0RnLGuE9pXa/Z2dXyxIBeWy5yXuPaK
         w4BkLU0EKMvt2o7Mh6W79+pPtiqhjnkq1uvds/4qVoiKzIUaiaVHdEAOJ/bgDy2yUs
         9VVVckyy1rrYqCVN4UTGZg6VUIwe/fMy5ckaDmU0K2xOFDIIfar0OIB+NOOstCy/Nw
         OXKpzzGS5536T7M0mg1Owwem7hnSXNzlX45qAimt4hlM4R6w0enHqRLJpo4HpLB4++
         tAOe0wdwWavMA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RvJqj5T72z6v4v;
        Mon, 25 Sep 2023 12:23:29 +0200 (CEST)
From:   Martin Kepplinger <martink@posteo.de>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com, jm@lentin.co.uk,
        linux-kernel@vger.kernel.org
Cc:     linux-input@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
Subject: [RFC PATCH 1/2] hid: lenovo: Resend all settings on reset_resume for compact keyboards
Date:   Mon, 25 Sep 2023 10:23:01 +0000
Message-Id: <20230925102302.13094-1-martink@posteo.de>
In-Reply-To: <140b721bc345a846863a37ebf17c3174@lentin.co.uk>
References: <140b721bc345a846863a37ebf17c3174@lentin.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jamie Lentin <jm@lentin.co.uk>

The USB Compact Keyboard variant requires a reset_resume function to
restore keyboard configuration after a suspend in some situations. Move
configuration normally done on probe to lenovo_features_set_cptkbd(), then
recycle this for use on reset_resume.

Without, the keyboard and driver would end up in an inconsistent state,
breaking middle-button scrolling amongst other problems, and twiddling
sysfs values wouldn't help as the middle-button mode won't be set until
the driver is reloaded.

Tested on a USB and Bluetooth Thinkpad Compact Keyboard.

Fixes: 94eefa271323 ("HID: lenovo: Use native middle-button mode for compact keyboards")
Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
Signed-off-by: Martin Kepplinger <martink@posteo.de>
---

hi Jamie,

thanks for sharing your patch! This works equally well for me. Is the
2nd patch what you had in mind? If so, let's create a new squashed non-RFC
patch.

thanks again,

                         martin


 drivers/hid/hid-lenovo.c | 50 +++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 44763c0da444..29aa6d372bad 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -521,6 +521,19 @@ static void lenovo_features_set_cptkbd(struct hid_device *hdev)
 	int ret;
 	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
 
+	/*
+	 * Tell the keyboard a driver understands it, and turn F7, F9, F11 into
+	 * regular keys
+	 */
+	ret = lenovo_send_cmd_cptkbd(hdev, 0x01, 0x03);
+	if (ret)
+		hid_warn(hdev, "Failed to switch F7/9/11 mode: %d\n", ret);
+
+	/* Switch middle button to native mode */
+	ret = lenovo_send_cmd_cptkbd(hdev, 0x09, 0x01);
+	if (ret)
+		hid_warn(hdev, "Failed to switch middle button: %d\n", ret);
+
 	ret = lenovo_send_cmd_cptkbd(hdev, 0x05, cptkbd_data->fn_lock);
 	if (ret)
 		hid_err(hdev, "Fn-lock setting failed: %d\n", ret);
@@ -1126,22 +1139,6 @@ static int lenovo_probe_cptkbd(struct hid_device *hdev)
 	}
 	hid_set_drvdata(hdev, cptkbd_data);
 
-	/*
-	 * Tell the keyboard a driver understands it, and turn F7, F9, F11 into
-	 * regular keys (Compact only)
-	 */
-	if (hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD ||
-	    hdev->product == USB_DEVICE_ID_LENOVO_CBTKBD) {
-		ret = lenovo_send_cmd_cptkbd(hdev, 0x01, 0x03);
-		if (ret)
-			hid_warn(hdev, "Failed to switch F7/9/11 mode: %d\n", ret);
-	}
-
-	/* Switch middle button to native mode */
-	ret = lenovo_send_cmd_cptkbd(hdev, 0x09, 0x01);
-	if (ret)
-		hid_warn(hdev, "Failed to switch middle button: %d\n", ret);
-
 	/* Set keyboard settings to known state */
 	cptkbd_data->middlebutton_state = 0;
 	cptkbd_data->fn_lock = true;
@@ -1264,6 +1261,24 @@ static int lenovo_probe(struct hid_device *hdev,
 	return ret;
 }
 
+#ifdef CONFIG_PM
+static int lenovo_reset_resume(struct hid_device *hdev)
+{
+	switch (hdev->product) {
+	case USB_DEVICE_ID_LENOVO_CUSBKBD:
+		if (hdev->type == HID_TYPE_USBMOUSE) {
+			lenovo_features_set_cptkbd(hdev);
+		}
+
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+#endif
+
 static void lenovo_remove_tpkbd(struct hid_device *hdev)
 {
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
@@ -1380,6 +1395,9 @@ static struct hid_driver lenovo_driver = {
 	.raw_event = lenovo_raw_event,
 	.event = lenovo_event,
 	.report_fixup = lenovo_report_fixup,
+#ifdef CONFIG_PM
+	.reset_resume = lenovo_reset_resume,
+#endif
 };
 module_hid_driver(lenovo_driver);
 
-- 
2.39.2


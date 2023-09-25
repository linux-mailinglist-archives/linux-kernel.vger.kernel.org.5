Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3F07AD5C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjIYKXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjIYKXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:23:42 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D24FC6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:23:34 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 1C2EA240105
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 12:23:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1695637413; bh=qC78CqDCUu8hI+DPLtNoWHc11J1C/tPhLY2OSTqPzUQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=P3BF8txZo6VhO3S1KXPUHAl2EPHvegZDbdGRNTch0zV+4gR7duOE3Qc60z/u8KPd5
         EJpMy5yv5pGmQZutRc+zpkkvHO1uyWbn55cOWu732XFmusx5rCsiDDEnGT6v0xFngb
         f0plb2qlkwDooAjnRvKE0o83JuMbBa6RlYzAecxa8d5A3O96PG0oHbhLpm4bZcmh1t
         NTa9vCmxRDzNaDQCo7P/8oP7+InCdJDa/DtqZOPL0dweTKDExDZr6MDzLfpANqOSBv
         U9asjzVrwKfP6sr8fJmFVKE7b0jK6L3Nvp+nrP/iHP708WfLXTFFulUwIYWQ8kiH+l
         Cdtgh/HGmejHA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RvJqk4dwxz6v7m;
        Mon, 25 Sep 2023 12:23:30 +0200 (CEST)
From:   Martin Kepplinger <martink@posteo.de>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com, jm@lentin.co.uk,
        linux-kernel@vger.kernel.org
Cc:     linux-input@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
Subject: [RFC PATCH 2/2] hid: lenovo: move type checks to lenovo_features_set_cptkbd()
Date:   Mon, 25 Sep 2023 10:23:02 +0000
Message-Id: <20230925102302.13094-2-martink@posteo.de>
In-Reply-To: <20230925102302.13094-1-martink@posteo.de>
References: <140b721bc345a846863a37ebf17c3174@lentin.co.uk>
 <20230925102302.13094-1-martink@posteo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These custom commands will be sent to both the USB keyboard & mouse
devices but only the mouse will respond. Avoid sending known-useless
messages by always prepending the filter before sending them.

Suggested-by: Jamie Lentin <jm@lentin.co.uk>
Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/hid/hid-lenovo.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 29aa6d372bad..922f3e5462f4 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -521,6 +521,14 @@ static void lenovo_features_set_cptkbd(struct hid_device *hdev)
 	int ret;
 	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
 
+	/* All the custom action happens on the USBMOUSE device for USB */
+	if (((hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD) ||
+	    (hdev->product == USB_DEVICE_ID_LENOVO_TPIIUSBKBD)) &&
+	    hdev->type != HID_TYPE_USBMOUSE) {
+		hid_dbg(hdev, "Ignoring keyboard half of device\n");
+		return;
+	}
+
 	/*
 	 * Tell the keyboard a driver understands it, and turn F7, F9, F11 into
 	 * regular keys
@@ -1122,14 +1130,6 @@ static int lenovo_probe_cptkbd(struct hid_device *hdev)
 	int ret;
 	struct lenovo_drvdata *cptkbd_data;
 
-	/* All the custom action happens on the USBMOUSE device for USB */
-	if (((hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD) ||
-	    (hdev->product == USB_DEVICE_ID_LENOVO_TPIIUSBKBD)) &&
-	    hdev->type != HID_TYPE_USBMOUSE) {
-		hid_dbg(hdev, "Ignoring keyboard half of device\n");
-		return 0;
-	}
-
 	cptkbd_data = devm_kzalloc(&hdev->dev,
 					sizeof(*cptkbd_data),
 					GFP_KERNEL);
@@ -1264,16 +1264,7 @@ static int lenovo_probe(struct hid_device *hdev,
 #ifdef CONFIG_PM
 static int lenovo_reset_resume(struct hid_device *hdev)
 {
-	switch (hdev->product) {
-	case USB_DEVICE_ID_LENOVO_CUSBKBD:
-		if (hdev->type == HID_TYPE_USBMOUSE) {
-			lenovo_features_set_cptkbd(hdev);
-		}
-
-		break;
-	default:
-		break;
-	}
+	lenovo_features_set_cptkbd(hdev);
 
 	return 0;
 }
-- 
2.39.2


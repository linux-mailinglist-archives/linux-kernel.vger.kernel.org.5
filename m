Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2235C7A9744
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjIURM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjIURLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:11:43 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8206FFF90
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:06:17 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 1BDAD240105
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:22:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1695288120; bh=KlagOBJ/Znqi813S+2Fe679zuj+86NZUSO3PsTHMyNI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=LPmm0Pu3SNgwlNsSM9gIxh1QJd1m67mMi2nH8+59Xx0X876YhVKTyvDWRDVg/LNzV
         kvM88FD6Aaio8GHeXEYaTYKvYNegD2TPLVcj5rp2mhwkNA/n+XinVFY/XrWmIqbG/H
         XKOGcM3hoGON5O6ZM0IXDPSu0HIs3B3ZvmUStgGwi5j/3+3DYnJpcC8+yD0GZv+Xhd
         U4WWZbh+0XCeT9Bl4dfbS67mNFNcRJ5bL/D8aF7AvqPZQeN8ACJZ03iTO1kc6B5SXb
         H+ApAzqv5lpkPeA47FuQtwi90ab2qzOh1Opu/82XtUqggj1zxQO+Mw6lFVV70vkeGO
         D6YVjNRBEo3vQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RrqfZ3sFWz9rxS;
        Thu, 21 Sep 2023 11:21:58 +0200 (CEST)
From:   Martin Kepplinger <martink@posteo.de>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com, jm@lentin.co.uk,
        linux-kernel@vger.kernel.org
Cc:     linux-input@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] HID: lenovo: Fix middle-button behaviour for system suspend
Date:   Thu, 21 Sep 2023 09:21:40 +0000
Message-Id: <20230921092140.120533-1-martink@posteo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After system suspend the middle-button mode is being reset to
compatibility mode which simply breaks functionality for the devices
where native mode is configured during probe().

Fix this by setting native mode in reset_resume() for the appropriate
devices.

Fixes: 94eefa271323 ("HID: lenovo: Use native middle-button mode for compact keyboards")
Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/hid/hid-lenovo.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 44763c0da444..d20562b9eca6 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -1344,6 +1344,28 @@ static int lenovo_input_configured(struct hid_device *hdev,
 	return 0;
 }
 
+static int __maybe_unused lenovo_resume(struct hid_device *hdev)
+{
+	int ret;
+
+	switch (hdev->product) {
+	case USB_DEVICE_ID_LENOVO_CUSBKBD:
+	case USB_DEVICE_ID_LENOVO_CBTKBD:
+	case USB_DEVICE_ID_LENOVO_TPIIUSBKBD:
+	case USB_DEVICE_ID_LENOVO_TPIIBTKBD:
+		/* Switch middle button to native mode again */
+		ret = lenovo_send_cmd_cptkbd(hdev, 0x09, 0x01);
+		if (ret)
+			hid_warn(hdev, "Failed to switch middle button: %d\n",
+				 ret);
+		break;
+	default:
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
 
 static const struct hid_device_id lenovo_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPKBD) },
@@ -1380,6 +1402,9 @@ static struct hid_driver lenovo_driver = {
 	.raw_event = lenovo_raw_event,
 	.event = lenovo_event,
 	.report_fixup = lenovo_report_fixup,
+#ifdef CONFIG_PM
+	.reset_resume = lenovo_resume,
+#endif
 };
 module_hid_driver(lenovo_driver);
 
-- 
2.39.2


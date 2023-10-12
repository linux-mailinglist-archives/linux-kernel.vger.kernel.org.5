Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EB87C6AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377894AbjJLKYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347120AbjJLKXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:23:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9505D7;
        Thu, 12 Oct 2023 03:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1697106227;
        bh=alxO7xFWraA3HKM6WF41cUbPDoefLV3zZhv5I90E+pg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=rE7peiHE79iPAIiKLaF0z/949FLJ/Zy4UCL+cNac8N6NcqZdKIxFaw0cJlnM1gWTR
         j15Ej4Uyo85TUj4naLqIYbTrz5witbF5s+X8Vm7IZyT3Bz8felUWwe/mTjExTs+YRO
         v07pzvJbFfHJnc1RJ2Krkqf5EZQ4cQ+4XtYmwD/0=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 12 Oct 2023 12:23:39 +0200
Subject: [PATCH 2/4] HID: usbhid: remove #ifdef CONFIG_PM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231012-hid-pm_ptr-v1-2-0a71531ca93b@weissschuh.net>
References: <20231012-hid-pm_ptr-v1-0-0a71531ca93b@weissschuh.net>
In-Reply-To: <20231012-hid-pm_ptr-v1-0-0a71531ca93b@weissschuh.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697106227; l=1539;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=alxO7xFWraA3HKM6WF41cUbPDoefLV3zZhv5I90E+pg=;
 b=QZGILVOJ+QPVXAY6Zni77eIF0Yi697+rGGIobSGwqD/pkwi/PhoZXOeEfnzUUGYNGtyCSDWc+
 uIpEsguUtBWBcXXSKwecJem0jyUsiScgV+6RI3orm8tGu70OZQf7tqH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Through the usage of pm_ptr() the CONFIG_PM-dependent code will always be
compiled, protecting against bitrot.
The linker will then garbage-collect the unused function avoiding any overhead.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hid/usbhid/hid-core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 257dd73e37bf..a90ed2ceae84 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1562,7 +1562,6 @@ static int hid_post_reset(struct usb_interface *intf)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int hid_resume_common(struct hid_device *hid, bool driver_suspended)
 {
 	int status = 0;
@@ -1654,8 +1653,6 @@ static int hid_reset_resume(struct usb_interface *intf)
 	return status;
 }
 
-#endif /* CONFIG_PM */
-
 static const struct usb_device_id hid_usb_ids[] = {
 	{ .match_flags = USB_DEVICE_ID_MATCH_INT_CLASS,
 		.bInterfaceClass = USB_INTERFACE_CLASS_HID },
@@ -1668,11 +1665,9 @@ static struct usb_driver hid_driver = {
 	.name =		"usbhid",
 	.probe =	usbhid_probe,
 	.disconnect =	usbhid_disconnect,
-#ifdef CONFIG_PM
-	.suspend =	hid_suspend,
-	.resume =	hid_resume,
-	.reset_resume =	hid_reset_resume,
-#endif
+	.suspend =	pm_ptr(hid_suspend),
+	.resume =	pm_ptr(hid_resume),
+	.reset_resume =	pm_ptr(hid_reset_resume),
 	.pre_reset =	hid_pre_reset,
 	.post_reset =	hid_post_reset,
 	.id_table =	hid_usb_ids,

-- 
2.42.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37406781783
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 07:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244561AbjHSFsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 01:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjHSFrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 01:47:55 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D35004208;
        Fri, 18 Aug 2023 22:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nKrHe
        h3vFgqCircTvGmw8LS+NCBCOKBP8D1zl/uTuM4=; b=PLKVQwcprNSru6sTORlXg
        LKj4bstjzcEfwbgdfgZmm+fMu9kY0c2wwJT/UyIzryOn2LCMWyWrb+eZ51Uejbak
        AuvH5mVOvgANCebiNI06KEpIu7lYx9jDfneuFArEaIlvWc4wYw2pWfuZ52KC0DWb
        VhmXqV4fvUQOHbvRcr6QEo=
Received: from sc9-mailhost1.vmware.com (unknown [114.250.138.216])
        by zwqz-smtp-mta-g5-3 (Coremail) with SMTP id _____wBn3XFkV+BkQevQDQ--.2412S2;
        Sat, 19 Aug 2023 13:47:16 +0800 (CST)
From:   Dingyan Li <18500469033@163.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, xiaofanc@gmail.com, oneukum@suse.com,
        lists.tormod@gmail.com, sebastian.reichel@collabora.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] USB: Support 20Gbps speed for ioctl USBDEVFS_GET_SPEED
Date:   Sat, 19 Aug 2023 13:46:55 +0800
Message-Id: <20230819054655.5495-1-18500469033@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <79f3ec25.fa3.18a0c111fa9.Coremail.18500469033@163.com>
References: <79f3ec25.fa3.18a0c111fa9.Coremail.18500469033@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBn3XFkV+BkQevQDQ--.2412S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrWUtrW3ArW7Cr4fuw1rJFb_yoW5uFy5pF
        WkCFWxJr4xJFWrur4fGay8Cw1rWws8Ca4qg342gw10vFy3t348ZF4vyr13CryxXan0yr42
        qFy7WrWFgaykCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTSoJUUUUU=
X-Originating-IP: [114.250.138.216]
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/xtbBZwbQy1et-+VHWAAAsF
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ioctl USBDEVFS_GET_SPEED can only return
USB_SPEED_SUPER_PLUS at most. However, there are also
ssp rates to indicate different connection speeds, which
we can not tell further via USBDEVFS_GET_SPEED.

To fix it, this patch still uses USB_SPEED_SUPER_PLUS
to indicate USB_SSP_GEN_UNKNOWN, USB_SSP_GEN_2x1, and
USB_SSP_GEN_1x2. But need to #define a new value for
USB_SSP_GEN_2x2. Besides, move the definition of enum
usb_ssp_rate from include/linux/usb/ch9.h to
include/uapi/linux/usb/ch9.h, which is a better place
to hold it.

Signed-off-by: Dingyan Li <18500469033@163.com>
---
 drivers/usb/core/devio.c          | 3 +++
 include/linux/usb/ch9.h           | 9 ---------
 include/uapi/linux/usb/ch9.h      | 8 ++++++++
 include/uapi/linux/usbdevice_fs.h | 8 ++++++--
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 1a16a8bdea60..ad13f58cbd06 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -2782,6 +2782,9 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		break;
 	case USBDEVFS_GET_SPEED:
 		ret = ps->dev->speed;
+		if (ret == USB_SPEED_SUPER_PLUS &&
+				ps->dev->ssp_rate == USB_SSP_GEN_2x2)
+			ret = USBDEVFS_SPEED_SUPER_PLUS_BY2;
 		break;
 	case USBDEVFS_FORBID_SUSPEND:
 		ret = proc_forbid_suspend(ps);
diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index c93b410b314a..b5a0bc89de5c 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -32,15 +32,6 @@
 
 #include <uapi/linux/usb/ch9.h>
 
-/* USB 3.2 SuperSpeed Plus phy signaling rate generation and lane count */
-
-enum usb_ssp_rate {
-	USB_SSP_GEN_UNKNOWN = 0,
-	USB_SSP_GEN_2x1,
-	USB_SSP_GEN_1x2,
-	USB_SSP_GEN_2x2,
-};
-
 struct device;
 
 extern const char *usb_ep_type_string(int ep_type);
diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
index 8a147abfc680..62591eb4d30a 100644
--- a/include/uapi/linux/usb/ch9.h
+++ b/include/uapi/linux/usb/ch9.h
@@ -1185,6 +1185,14 @@ enum usb_device_speed {
 	USB_SPEED_SUPER_PLUS,			/* usb 3.1 */
 };
 
+/* USB 3.2 SuperSpeed Plus phy signaling rate generation and lane count */
+
+enum usb_ssp_rate {
+	USB_SSP_GEN_UNKNOWN = 0,
+	USB_SSP_GEN_2x1,
+	USB_SSP_GEN_1x2,
+	USB_SSP_GEN_2x2,
+};
 
 enum usb_device_state {
 	/* NOTATTACHED isn't in the USB spec, and this state acts
diff --git a/include/uapi/linux/usbdevice_fs.h b/include/uapi/linux/usbdevice_fs.h
index 74a84e02422a..46ba793f4938 100644
--- a/include/uapi/linux/usbdevice_fs.h
+++ b/include/uapi/linux/usbdevice_fs.h
@@ -180,9 +180,13 @@ struct usbdevfs_streams {
 };
 
 /*
- * USB_SPEED_* values returned by USBDEVFS_GET_SPEED are defined in
- * linux/usb/ch9.h
+ * For USBDEVFS_GET_SPEED:
+ *
+ * When speed is USB_SPEED_SUPER_PLUS and ssp_rate is USB_SSP_GEN_2x2
+ * or higher, use below definitions to indicate actual connection speed.
+ * Otherwise, just return USB_SPEED_* values defined in linux/usb/ch9.h.
  */
+#define USBDEVFS_SPEED_SUPER_PLUS_BY2	7	/* USB_SSP_GEN_2x2, 20Gbps */
 
 #define USBDEVFS_CONTROL           _IOWR('U', 0, struct usbdevfs_ctrltransfer)
 #define USBDEVFS_CONTROL32           _IOWR('U', 0, struct usbdevfs_ctrltransfer32)
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759B2805D8E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345915AbjLESSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345907AbjLESSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:18:36 -0500
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC43C3;
        Tue,  5 Dec 2023 10:18:42 -0800 (PST)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 322B15202F5;
        Tue,  5 Dec 2023 19:18:41 +0100 (CET)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 5 Dec
 2023 19:18:40 +0100
From:   Hardik Gajjar <hgajjar@de.adit-jv.com>
To:     <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <corbet@lwn.net>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <hgajjar@de.adit-jv.com>, <tj@kernel.org>,
        <paulmck@kernel.org>, <Martin.Mueller5@de.bosch.com>
Subject: [PATCH v5 2/2] usb: hub: Add quirk to decrease IN-ep poll interval for Microchip USB491x hub
Date:   Tue, 5 Dec 2023 19:18:29 +0100
Message-ID: <20231205181829.127353-2-hgajjar@de.adit-jv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231205181829.127353-1-hgajjar@de.adit-jv.com>
References: <20231205181829.127353-1-hgajjar@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.72.93.77]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential delay in notifying Linux USB drivers of downstream
USB bus activity when connecting a high-speed or superSpeed device via the
Microchip USB491x hub. This delay is due to the fixed bInterval value of
12 in the silicon of the Microchip USB491x hub.

Microchip requested to ignore the device descriptor and decrease that
value to 9 as it was too late to modify that in silicon.

This patch speeds up the USB enummeration process that helps to pass
Apple Carplay certifications and improve the User experience when utilizing
the USB device via Microchip Multihost USB491x Hub.

A new hub quirk HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL speeds up
the notification process for Microchip USB491x hub by limiting
the maximum bInterval value to 9.

Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
---
changes since version 1:
	- Move implementation from config.c and quirk.c to hub.c as this is hub
	  specific changes.
	- Improve commit message.
	- Link to v1 - https://lore.kernel.org/all/20231123081948.58776-1-hgajjar@de.adit-jv.com/

changes since version 2:
    - Call usb_set_interface after updating the bInterval to Tell the HCD about modification
	- Link to v2 - https://lore.kernel.org/all/20231130084855.119937-1-hgajjar@de.adit-jv.com/

changes since version 3:
    - Change HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL value from 0x08 to 0x04
	- Link to v3 - https://lore.kernel.org/all/20231201144705.97385-1-hgajjar@de.adit-jv.com/

changes since version 4:
	- change quirk hardcoded value to BIT() Macro
	- Link to v4 - https://lore.kernel.org/all/20231204073834.112509-1-hgajjar@de.adit-jv.com/
---
 drivers/usb/core/hub.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 286d203e6952..3c8d42552642 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -47,12 +47,18 @@
 #define USB_VENDOR_TEXAS_INSTRUMENTS		0x0451
 #define USB_PRODUCT_TUSB8041_USB3		0x8140
 #define USB_PRODUCT_TUSB8041_USB2		0x8142
+#define USB_VENDOR_MICROCHIP			0x0424
+#define USB_PRODUCT_USB4913			0x4913
+#define USB_PRODUCT_USB4914			0x4914
+#define USB_PRODUCT_USB4915			0x4915
 #define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	BIT(0)
 #define HUB_QUIRK_DISABLE_AUTOSUSPEND		BIT(1)
+#define HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL	BIT(2)
 
 #define USB_TP_TRANSMISSION_DELAY	40	/* ns */
 #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
 #define USB_PING_RESPONSE_TIME		400	/* ns */
+#define USB_REDUCE_FRAME_INTR_BINTERVAL	9
 
 /* Protect struct usb_device->state and ->children members
  * Note: Both are also protected by ->dev.sem, except that ->state can
@@ -1927,6 +1933,14 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		usb_autopm_get_interface_no_resume(intf);
 	}
 
+	if ((id->driver_info & HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL) &&
+	    desc->endpoint[0].desc.bInterval > USB_REDUCE_FRAME_INTR_BINTERVAL) {
+		desc->endpoint[0].desc.bInterval =
+			USB_REDUCE_FRAME_INTR_BINTERVAL;
+		/* Tell the HCD about the interrupt ep's new bInterval */
+		usb_set_interface(hdev, 0, 0);
+	}
+
 	if (hub_configure(hub, &desc->endpoint[0].desc) >= 0) {
 		onboard_hub_create_pdevs(hdev, &hub->onboard_hub_devs);
 
@@ -5918,6 +5932,21 @@ static const struct usb_device_id hub_id_table[] = {
       .idVendor = USB_VENDOR_TEXAS_INSTRUMENTS,
       .idProduct = USB_PRODUCT_TUSB8041_USB3,
       .driver_info = HUB_QUIRK_DISABLE_AUTOSUSPEND},
+	{ .match_flags = USB_DEVICE_ID_MATCH_VENDOR
+			| USB_DEVICE_ID_MATCH_PRODUCT,
+	  .idVendor = USB_VENDOR_MICROCHIP,
+	  .idProduct = USB_PRODUCT_USB4913,
+	  .driver_info = HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL},
+	{ .match_flags = USB_DEVICE_ID_MATCH_VENDOR
+			| USB_DEVICE_ID_MATCH_PRODUCT,
+	  .idVendor = USB_VENDOR_MICROCHIP,
+	  .idProduct = USB_PRODUCT_USB4914,
+	  .driver_info = HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL},
+	{ .match_flags = USB_DEVICE_ID_MATCH_VENDOR
+			| USB_DEVICE_ID_MATCH_PRODUCT,
+	  .idVendor = USB_VENDOR_MICROCHIP,
+	  .idProduct = USB_PRODUCT_USB4915,
+	  .driver_info = HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL},
     { .match_flags = USB_DEVICE_ID_MATCH_DEV_CLASS,
       .bDeviceClass = USB_CLASS_HUB},
     { .match_flags = USB_DEVICE_ID_MATCH_INT_CLASS,
-- 
2.17.1


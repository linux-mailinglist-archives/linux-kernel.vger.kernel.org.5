Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F4C7D9CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346254AbjJ0PU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346184AbjJ0PUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:20:51 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAA4AC;
        Fri, 27 Oct 2023 08:20:48 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 6F34E520496;
        Fri, 27 Oct 2023 17:20:47 +0200 (CEST)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.34; Fri, 27 Oct
 2023 17:20:47 +0200
From:   Hardik Gajjar <hgajjar@de.adit-jv.com>
To:     <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <mathias.nyman@intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <hgajjar@de.adit-jv.com>,
        <s.shtylyov@omp.ru>
Subject: [PATCH v7 2/2] usb: new quirk to reduce the SET_ADDRESS request timeout
Date:   Fri, 27 Oct 2023 17:20:29 +0200
Message-ID: <20231027152029.104363-2-hgajjar@de.adit-jv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231027152029.104363-1-hgajjar@de.adit-jv.com>
References: <20231027152029.104363-1-hgajjar@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.72.93.77]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a new USB quirk,
USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT, which modifies the timeout value
for the SET_ADDRESS request. The standard timeout for USB request/command
is 5000 ms, as recommended in the USB 3.2 specification (section 9.2.6.1).

However, certain scenarios, such as connecting devices through an APTIV
hub, can lead to timeout errors when the device enumerates as full speed
initially and later switches to high speed during chirp negotiation.

In such cases, USB analyzer logs reveal that the bus suspends for
5 seconds due to incorrect chirp parsing and resumes only after two
consecutive timeout errors trigger a hub driver reset.

Packet(54) Dir(?) Full Speed J(997.100 us) Idle(  2.850 us)
_______| Time Stamp(28 . 105 910 682)
_______|_____________________________________________________________Ch0
Packet(55) Dir(?) Full Speed J(997.118 us) Idle(  2.850 us)
_______| Time Stamp(28 . 106 910 632)
_______|_____________________________________________________________Ch0
Packet(56) Dir(?) Full Speed J(399.650 us) Idle(222.582 us)
_______| Time Stamp(28 . 107 910 600)
_______|_____________________________________________________________Ch0
Packet(57) Dir Chirp J( 23.955 ms) Idle(115.169 ms)
_______| Time Stamp(28 . 108 532 832)
_______|_____________________________________________________________Ch0
Packet(58) Dir(?) Full Speed J (Suspend)( 5.347 sec) Idle(  5.366 us)
_______| Time Stamp(28 . 247 657 600)
_______|_____________________________________________________________Ch0

This 5-second delay in device enumeration is undesirable, particularly
in automotive applications where quick enumeration is crucial
(ideally within 3 seconds).

The newly introduced quirks provide the flexibility to align with a
3-second time limit, as required in specific contexts like automotive
applications.

By reducing the SET_ADDRESS request timeout to 500 ms, the
system can respond more swiftly to errors, initiate rapid recovery, and
ensure efficient device enumeration. This change is vital for scenarios
where rapid smartphone enumeration and screen projection are essential.

To use the quirk, please write "vendor_id:product_id:p" to
/sys/bus/usb/drivers/hub/module/parameter/quirks

For example,
echo "0x2c48:0x0132:p" > /sys/bus/usb/drivers/hub/module/parameters/quirks"

Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
---
changes since version 1:
        - implement quirk instead of new API in xhci driver

changes since version 2:
        - Add documentation for the new quirk.
        - Define the timeout unit in milliseconds in variable names and function arguments.
        - Change the xHCI command timeout from HZ (jiffies) to milliseconds.
        - Add APTIV usb hub vendor and product ID in device quirk list
        - Adding some other comments for clarity

Changes since version 3:
        - Add some comments for clarity.
        - Minor indentation and sequence change.

Changes since version 4:
        - Changing the USB specification reference to version 3.2.
        - Enhancing the commit message to provide more details about the technical issue.
        - Improving the structure of function comments.

Changes since version 5:
        - Changed the terminology in USB core driver files from 'command' to 'request'
          as it is more commonly used.
          It's important to note that USB specifications indicate these terms are interchangeable.
          For example, USB spec 3.2, section 9.2.6.1, uses the term 'command' in its text
          "USB sets an upper limit of 5 seconds for any command to be processed. "
        - Change set_address to SET_ADDRESS.

Changes since version 6:
	- Split this patch into two separate patches. There is now a separate patch for
	  xhci_hcd changes.
    	- Remove the _MS suffix from Macros.
    	- Make minor text corrections.
	- Link to V6: https://lore.kernel.org/linux-usb/20231026101551.36551-1-hgajjar@de.adit-jv.com/
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 drivers/usb/core/hub.c                          | 15 +++++++++++++--
 drivers/usb/core/quirks.c                       |  7 +++++++
 include/linux/usb/quirks.h                      |  3 +++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a0f0ef..62693a85bc45 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6817,6 +6817,9 @@
 					pause after every control message);
 				o = USB_QUIRK_HUB_SLOW_RESET (Hub needs extra
 					delay after resetting its port);
+				p = USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT
+					(Reduce timeout of the SET_ADDRESS
+					request from 5000 ms to 500 ms);
 			Example: quirks=0781:5580:bk,0a5c:5834:gij
 
 	usbhid.mousepoll=
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 376147af287f..fb181b2f0972 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -54,6 +54,12 @@
 #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
 #define USB_PING_RESPONSE_TIME		400	/* ns */
 
+/*
+ * The SET_ADDRESS request timeout will be 500 ms when
+ * USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT quirk flag is set.
+ */
+#define USB_SHORT_SET_ADDRESS_REQ_TIMEOUT	500  /* ms */
+
 /* Protect struct usb_device->state and ->children members
  * Note: Both are also protected by ->dev.sem, except that ->state can
  * change to USB_STATE_NOTATTACHED even when the semaphore isn't held. */
@@ -4626,7 +4632,12 @@ EXPORT_SYMBOL_GPL(usb_ep0_reinit);
 static int hub_set_address(struct usb_device *udev, int devnum)
 {
 	int retval;
+	unsigned int timeout_ms = USB_CTRL_SET_TIMEOUT;
 	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
+	struct usb_hub *hub = usb_hub_to_struct_hub(udev->parent);
+
+	if (hub->hdev->quirks & USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT)
+		timeout_ms = USB_SHORT_SET_ADDRESS_REQ_TIMEOUT;
 
 	/*
 	 * The host controller will choose the device address,
@@ -4639,11 +4650,11 @@ static int hub_set_address(struct usb_device *udev, int devnum)
 	if (udev->state != USB_STATE_DEFAULT)
 		return -EINVAL;
 	if (hcd->driver->address_device)
-		retval = hcd->driver->address_device(hcd, udev, USB_CTRL_SET_TIMEOUT);
+		retval = hcd->driver->address_device(hcd, udev, timeout_ms);
 	else
 		retval = usb_control_msg(udev, usb_sndaddr0pipe(),
 				USB_REQ_SET_ADDRESS, 0, devnum, 0,
-				NULL, 0, USB_CTRL_SET_TIMEOUT);
+				NULL, 0, timeout_ms);
 	if (retval == 0) {
 		update_devnum(udev, devnum);
 		/* Device now using proper address. */
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 15e9bd180a1d..b4783574b8e6 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -138,6 +138,9 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
 			case 'o':
 				flags |= USB_QUIRK_HUB_SLOW_RESET;
 				break;
+			case 'p':
+				flags |= USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT;
+				break;
 			/* Ignore unrecognized flag characters */
 			}
 		}
@@ -527,6 +530,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 
 	{ USB_DEVICE(0x2386, 0x350e), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* APTIV AUTOMOTIVE HUB */
+	{ USB_DEVICE(0x2c48, 0x0132), .driver_info =
+			USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT },
+
 	/* DJI CineSSD */
 	{ USB_DEVICE(0x2ca3, 0x0031), .driver_info = USB_QUIRK_NO_LPM },
 
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index eeb7c2157c72..59409c1fc3de 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -72,4 +72,7 @@
 /* device has endpoints that should be ignored */
 #define USB_QUIRK_ENDPOINT_IGNORE		BIT(15)
 
+/* short SET_ADDRESS request timeout */
+#define USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT	BIT(16)
+
 #endif /* __LINUX_USB_QUIRKS_H */
-- 
2.17.1


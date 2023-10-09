Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9857BE612
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377152AbjJIQOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377154AbjJIQOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:14:25 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF04A6;
        Mon,  9 Oct 2023 09:14:22 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 0E0C6520333;
        Mon,  9 Oct 2023 18:14:20 +0200 (CEST)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.32; Mon, 9 Oct
 2023 18:14:19 +0200
From:   Hardik Gajjar <hgajjar@de.adit-jv.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <stern@rowland.harvard.edu>
CC:     <yangyingliang@huawei.com>, <jinpu.wang@ionos.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <hgajjar@de.adit-jv.com>
Subject: [PATCH v2] usb: core: hub: Add quirks for reducing device address timeout
Date:   Mon, 9 Oct 2023 18:14:02 +0200
Message-ID: <20231009161402.104224-1-hgajjar@de.adit-jv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <--in-reply-to=20231006153808.9758-1-hgajjar@de.adit-jv.com>
References: <--in-reply-to=20231006153808.9758-1-hgajjar@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.72.93.77]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the timeout for the set address command is fixed at
5 seconds in the xhci driver. This means the host waits up to 5
seconds to receive a response for the set_address command from
the device.

In the automotive context, most smartphone enumerations, including
screen projection, should ideally complete within 3 seconds.
Achieving this is impossible in scenarios where the set_address is
not successful and waits for a timeout.

The shortened address device timeout quirks provide the flexibility
to align with a 3-second time limit in the event of errors.
By swiftly triggering a failure response and swiftly initiating
retry procedures, these quirks ensure efficient and rapid recovery,
particularly in automotive contexts where rapid smartphone enumeration
and screen projection are vital.

The quirk will set the timeout to 500 ms from 5 seconds.

To use the quirk, please write "vendor_id:product_id:p" to
/sys/bus/usb/drivers/hub/module/parameter/quirks

For example,
echo "0x2c48:0x0132:p" > /sys/bus/usb/drivers/hub/module/parameter/quirks"

Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
---
changes since version 1:
	- implement quirk instead of new API in xhci driver
---
 drivers/usb/core/hub.c       | 15 +++++++++++++--
 drivers/usb/core/quirks.c    |  3 +++
 drivers/usb/host/xhci-mem.c  |  1 +
 drivers/usb/host/xhci-ring.c |  3 ++-
 drivers/usb/host/xhci.c      |  9 +++++----
 drivers/usb/host/xhci.h      |  1 +
 include/linux/usb/hcd.h      |  3 ++-
 include/linux/usb/quirks.h   |  3 +++
 8 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 3c54b218301c..975449b03426 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -54,6 +54,9 @@
 #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
 #define USB_PING_RESPONSE_TIME		400	/* ns */
 
+#define USB_DEFAULT_ADDR_DEVICE_TIMEOUT		(HZ * 5) /* 5000ms */
+#define USB_SHORT_ADDR_DEVICE_TIMEOUT		125  /* ~500ms */
+
 /* Protect struct usb_device->state and ->children members
  * Note: Both are also protected by ->dev.sem, except that ->state can
  * change to USB_STATE_NOTATTACHED even when the semaphore isn't held. */
@@ -4626,8 +4629,16 @@ EXPORT_SYMBOL_GPL(usb_ep0_reinit);
 static int hub_set_address(struct usb_device *udev, int devnum)
 {
 	int retval;
+	int timeout = USB_DEFAULT_ADDR_DEVICE_TIMEOUT;
 	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
 
+	struct usb_hub *hub = usb_hub_to_struct_hub(udev->parent);
+
+	if (hub->hdev->quirks & USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT)
+		timeout = USB_SHORT_ADDR_DEVICE_TIMEOUT;
+
+	dev_dbg(&udev->dev, "address_device timeout %d\n", timeout);
+
 	/*
 	 * The host controller will choose the device address,
 	 * instead of the core having chosen it earlier
@@ -4639,11 +4650,11 @@ static int hub_set_address(struct usb_device *udev, int devnum)
 	if (udev->state != USB_STATE_DEFAULT)
 		return -EINVAL;
 	if (hcd->driver->address_device)
-		retval = hcd->driver->address_device(hcd, udev);
+		retval = hcd->driver->address_device(hcd, udev, timeout);
 	else
 		retval = usb_control_msg(udev, usb_sndaddr0pipe(),
 				USB_REQ_SET_ADDRESS, 0, devnum, 0,
-				NULL, 0, USB_CTRL_SET_TIMEOUT);
+				NULL, 0, jiffies_to_msecs(timeout));
 	if (retval == 0) {
 		update_devnum(udev, devnum);
 		/* Device now using proper address. */
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 15e9bd180a1d..01ed26bd41f0 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -138,6 +138,9 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
 			case 'o':
 				flags |= USB_QUIRK_HUB_SLOW_RESET;
 				break;
+			case 'p':
+				flags |= USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT;
+				break;
 			/* Ignore unrecognized flag characters */
 			}
 		}
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 8714ab5bf04d..492433fdac77 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1729,6 +1729,7 @@ struct xhci_command *xhci_alloc_command(struct xhci_hcd *xhci,
 	}
 
 	command->status = 0;
+	command->timeout = 0;
 	INIT_LIST_HEAD(&command->cmd_list);
 	return command;
 }
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 1dde53f6eb31..0bd19a1efdec 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -4301,7 +4301,8 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 	/* if there are no other commands queued we start the timeout timer */
 	if (list_empty(&xhci->cmd_list)) {
 		xhci->current_cmd = cmd;
-		xhci_mod_cmd_timer(xhci, XHCI_CMD_DEFAULT_TIMEOUT);
+		xhci_mod_cmd_timer(xhci, (cmd->timeout) ? cmd->timeout :
+				XHCI_CMD_DEFAULT_TIMEOUT);
 	}
 
 	list_add_tail(&cmd->cmd_list, &xhci->cmd_list);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index e1b1b64a0723..1d088ceb2b74 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4002,7 +4002,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
  * SetAddress request to the device.
  */
 static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
-			     enum xhci_setup_dev setup)
+			     enum xhci_setup_dev setup, int timeout)
 {
 	const char *act = setup == SETUP_CONTEXT_ONLY ? "context" : "address";
 	unsigned long flags;
@@ -4059,6 +4059,7 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 	}
 
 	command->in_ctx = virt_dev->in_ctx;
+	command->timeout = timeout;
 
 	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
 	ctrl_ctx = xhci_get_input_control_ctx(virt_dev->in_ctx);
@@ -4185,14 +4186,14 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 	return ret;
 }
 
-static int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev)
+static int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev, int timeout)
 {
-	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ADDRESS);
+	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ADDRESS, timeout);
 }
 
 static int xhci_enable_device(struct usb_hcd *hcd, struct usb_device *udev)
 {
-	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ONLY);
+	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ONLY, 0);
 }
 
 /*
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 7e282b4522c0..ebdca8dd01c2 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -818,6 +818,7 @@ struct xhci_command {
 	struct completion		*completion;
 	union xhci_trb			*command_trb;
 	struct list_head		cmd_list;
+	int				timeout;
 };
 
 /* drop context bitmasks */
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 61d4f0b793dc..b0fda87ad3a2 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -373,7 +373,8 @@ struct hc_driver {
 		 */
 	void	(*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
 		/* Returns the hardware-chosen device address */
-	int	(*address_device)(struct usb_hcd *, struct usb_device *udev);
+	int	(*address_device)(struct usb_hcd *, struct usb_device *udev,
+				  int timeout);
 		/* prepares the hardware to send commands to the device */
 	int	(*enable_device)(struct usb_hcd *, struct usb_device *udev);
 		/* Notifies the HCD after a hub descriptor is fetched.
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index eeb7c2157c72..0cb464e3eaf4 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -72,4 +72,7 @@
 /* device has endpoints that should be ignored */
 #define USB_QUIRK_ENDPOINT_IGNORE		BIT(15)
 
+/* short device address timeout */
+#define USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT	BIT(16)
+
 #endif /* __LINUX_USB_QUIRKS_H */
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442C77C5971
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjJKQpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjJKQpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:45:39 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ED58F;
        Wed, 11 Oct 2023 09:45:36 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id DDA9A5202D7;
        Wed, 11 Oct 2023 18:45:34 +0200 (CEST)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.32; Wed, 11 Oct
 2023 18:45:34 +0200
From:   Hardik Gajjar <hgajjar@de.adit-jv.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <stern@rowland.harvard.edu>
CC:     <yangyingliang@huawei.com>, <jinpu.wang@ionos.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <hgajjar@de.adit-jv.com>
Subject: [PATCH v4] usb: core: hub: Add quirks for reducing device address timeout
Date:   Wed, 11 Oct 2023 18:45:25 +0200
Message-ID: <20231011164525.97616-1-hgajjar@de.adit-jv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2023101155-unframed-satirical-f7ec@gregkh>
References: <2023101155-unframed-satirical-f7ec@gregkh>
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

changes since version 2:
	- Add documentation for the new quirk.
	- Define the timeout unit in milliseconds in variable names and function arguments.
	- Change the xHCI command timeout from HZ (jiffies) to milliseconds.
	- Add APTIV usb hub vendor and product ID in device quirk list
	- Adding some other comments for clarity

Changes since version 3:
	- Add some comments for clarity.
	- Minor indentation and sequence change.
---
 .../admin-guide/kernel-parameters.txt         |  3 +++
 drivers/usb/core/hub.c                        | 21 ++++++++++++++++--
 drivers/usb/core/quirks.c                     |  6 +++++
 drivers/usb/host/xhci-mem.c                   |  2 ++
 drivers/usb/host/xhci-ring.c                  | 11 +++++-----
 drivers/usb/host/xhci.c                       | 22 ++++++++++++++-----
 drivers/usb/host/xhci.h                       |  9 ++++++--
 include/linux/usb/hcd.h                       |  5 +++--
 include/linux/usb/quirks.h                    |  3 +++
 9 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a0f0ef..3c03f23bd5d5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6817,6 +6817,9 @@
 					pause after every control message);
 				o = USB_QUIRK_HUB_SLOW_RESET (Hub needs extra
 					delay after resetting its port);
+				p = USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT (Timeout
+					of set_address command reducing from
+					5000 ms to 500 ms)
 			Example: quirks=0781:5580:bk,0a5c:5834:gij
 
 	usbhid.mousepoll=
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 3c54b218301c..83d1af0a3953 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -54,6 +54,18 @@
 #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
 #define USB_PING_RESPONSE_TIME		400	/* ns */
 
+/*
+ * address device command timeout 5000 ms is recommended in
+ * USB 2.0 spec, section 9.2.6.1
+ */
+#define USB_DEFAULT_ADDR_DEVICE_TIMEOUT_MS	5000 /* ms */
+
+/*
+ * address device command timeout will be 500 ms when
+ * USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT enable.
+ */
+#define USB_SHORT_ADDR_DEVICE_TIMEOUT_MS	500  /* ms */
+
 /* Protect struct usb_device->state and ->children members
  * Note: Both are also protected by ->dev.sem, except that ->state can
  * change to USB_STATE_NOTATTACHED even when the semaphore isn't held. */
@@ -4626,7 +4638,12 @@ EXPORT_SYMBOL_GPL(usb_ep0_reinit);
 static int hub_set_address(struct usb_device *udev, int devnum)
 {
 	int retval;
+	unsigned int timeout_ms = USB_DEFAULT_ADDR_DEVICE_TIMEOUT_MS;
 	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
+	struct usb_hub *hub = usb_hub_to_struct_hub(udev->parent);
+
+	if (hub->hdev->quirks & USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT)
+		timeout_ms = USB_SHORT_ADDR_DEVICE_TIMEOUT_MS;
 
 	/*
 	 * The host controller will choose the device address,
@@ -4639,11 +4656,11 @@ static int hub_set_address(struct usb_device *udev, int devnum)
 	if (udev->state != USB_STATE_DEFAULT)
 		return -EINVAL;
 	if (hcd->driver->address_device)
-		retval = hcd->driver->address_device(hcd, udev);
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
index 15e9bd180a1d..863e7fe24157 100644
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
@@ -527,6 +530,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 
 	{ USB_DEVICE(0x2386, 0x350e), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* APTIV AUTOMOTIVE HUB */
+	{ USB_DEVICE(0x2c48, 0x0132), .driver_info = USB_QUIRK_SHORT_DEVICE_ADDR_TIMEOUT },
+
 	/* DJI CineSSD */
 	{ USB_DEVICE(0x2ca3, 0x0031), .driver_info = USB_QUIRK_NO_LPM },
 
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 8714ab5bf04d..4a286136d1a8 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1729,6 +1729,8 @@ struct xhci_command *xhci_alloc_command(struct xhci_hcd *xhci,
 	}
 
 	command->status = 0;
+	/* set default timeout to 5000 ms */
+	command->timeout_ms = XHCI_CMD_DEFAULT_TIMEOUT_MS;
 	INIT_LIST_HEAD(&command->cmd_list);
 	return command;
 }
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 1dde53f6eb31..8f36c2914938 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -366,9 +366,10 @@ void xhci_ring_cmd_db(struct xhci_hcd *xhci)
 	readl(&xhci->dba->doorbell[0]);
 }
 
-static bool xhci_mod_cmd_timer(struct xhci_hcd *xhci, unsigned long delay)
+static bool xhci_mod_cmd_timer(struct xhci_hcd *xhci)
 {
-	return mod_delayed_work(system_wq, &xhci->cmd_timer, delay);
+	return mod_delayed_work(system_wq, &xhci->cmd_timer,
+			msecs_to_jiffies(xhci->current_cmd->timeout_ms));
 }
 
 static struct xhci_command *xhci_next_queued_cmd(struct xhci_hcd *xhci)
@@ -412,7 +413,7 @@ static void xhci_handle_stopped_cmd_ring(struct xhci_hcd *xhci,
 	if ((xhci->cmd_ring->dequeue != xhci->cmd_ring->enqueue) &&
 	    !(xhci->xhc_state & XHCI_STATE_DYING)) {
 		xhci->current_cmd = cur_cmd;
-		xhci_mod_cmd_timer(xhci, XHCI_CMD_DEFAULT_TIMEOUT);
+		xhci_mod_cmd_timer(xhci);
 		xhci_ring_cmd_db(xhci);
 	}
 }
@@ -1786,7 +1787,7 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 	if (!list_is_singular(&xhci->cmd_list)) {
 		xhci->current_cmd = list_first_entry(&cmd->cmd_list,
 						struct xhci_command, cmd_list);
-		xhci_mod_cmd_timer(xhci, XHCI_CMD_DEFAULT_TIMEOUT);
+		xhci_mod_cmd_timer(xhci);
 	} else if (xhci->current_cmd == cmd) {
 		xhci->current_cmd = NULL;
 	}
@@ -4301,7 +4302,7 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 	/* if there are no other commands queued we start the timeout timer */
 	if (list_empty(&xhci->cmd_list)) {
 		xhci->current_cmd = cmd;
-		xhci_mod_cmd_timer(xhci, XHCI_CMD_DEFAULT_TIMEOUT);
+		xhci_mod_cmd_timer(xhci);
 	}
 
 	list_add_tail(&cmd->cmd_list, &xhci->cmd_list);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index e1b1b64a0723..85ea4e17d2a0 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3998,11 +3998,18 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 }
 
 /*
- * Issue an Address Device command and optionally send a corresponding
- * SetAddress request to the device.
+ * This function issues an Address Device command to assign a unique USB bus
+ * address. Optionally, it sends a SetAddress request.
+ *
+ * @param hcd        USB host controller data structure.
+ * @param udev       USB device structure representing the connected device.
+ * @param setup      Enum specifying setup mode: address only or with context.
+ * @param timeout_ms Max wait time (ms) for the command operation to complete.
+ *
+ * @return           Integer status code: 0 on success, negative on error.
  */
 static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
-			     enum xhci_setup_dev setup)
+			     enum xhci_setup_dev setup, unsigned int timeout_ms)
 {
 	const char *act = setup == SETUP_CONTEXT_ONLY ? "context" : "address";
 	unsigned long flags;
@@ -4059,6 +4066,7 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 	}
 
 	command->in_ctx = virt_dev->in_ctx;
+	command->timeout_ms = timeout_ms;
 
 	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
 	ctrl_ctx = xhci_get_input_control_ctx(virt_dev->in_ctx);
@@ -4185,14 +4193,16 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 	return ret;
 }
 
-static int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev)
+static int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev,
+			       unsigned int timeout_ms)
 {
-	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ADDRESS);
+	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ADDRESS, timeout_ms);
 }
 
 static int xhci_enable_device(struct usb_hcd *hcd, struct usb_device *udev)
 {
-	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ONLY);
+	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ONLY,
+				 XHCI_CMD_DEFAULT_TIMEOUT_MS);
 }
 
 /*
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 7e282b4522c0..ec5c663246e5 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -818,6 +818,8 @@ struct xhci_command {
 	struct completion		*completion;
 	union xhci_trb			*command_trb;
 	struct list_head		cmd_list;
+	/* xHCI command response timeout in milliseconds */
+	unsigned int			timeout_ms;
 };
 
 /* drop context bitmasks */
@@ -1576,8 +1578,11 @@ struct xhci_td {
 	unsigned int		num_trbs;
 };
 
-/* xHCI command default timeout value */
-#define XHCI_CMD_DEFAULT_TIMEOUT	(5 * HZ)
+/*
+ * xHCI command default timeout value in milliseconds.
+ * USB 2.0 spec, section 9.2.6.1
+ */
+#define XHCI_CMD_DEFAULT_TIMEOUT_MS	5000
 
 /* command descriptor */
 struct xhci_cd {
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 61d4f0b793dc..d0e19ac3ba6c 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -372,8 +372,9 @@ struct hc_driver {
 		 * or bandwidth constraints.
 		 */
 	void	(*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
-		/* Returns the hardware-chosen device address */
-	int	(*address_device)(struct usb_hcd *, struct usb_device *udev);
+		/* Set the hardware-chosen device address */
+	int	(*address_device)(struct usb_hcd *, struct usb_device *udev,
+				  unsigned int timeout_ms);
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


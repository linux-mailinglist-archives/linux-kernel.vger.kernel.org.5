Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD8A780890
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359190AbjHRJfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359191AbjHRJex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:34:53 -0400
X-Greylist: delayed 619 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 02:34:24 PDT
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ADE4204;
        Fri, 18 Aug 2023 02:34:24 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 450845200CA;
        Fri, 18 Aug 2023 11:24:03 +0200 (CEST)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.32; Fri, 18 Aug
 2023 11:24:03 +0200
From:   Hardik Gajjar <hgajjar@de.adit-jv.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <yangyingliang@huawei.com>
CC:     <jinpu.wang@ionos.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <erosca@de.adit-jv.com>
Subject: [PATCH] usb: hcd: xhci: Add set command timer delay API
Date:   Fri, 18 Aug 2023 11:23:53 +0200
Message-ID: <20230818092353.124658-1-hgajjar@de.adit-jv.com>
X-Mailer: git-send-email 2.17.1
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

xHCI driver starts the response timer after sending each
command to the device. The default value of this timer is
5 seconds (XHCI_CMD_DEFAULT_TIMEOUT = HZ*5). This seems
too high in time crtical use case.

This patch provides an API to change the default value of
the timer from the vendor USB driver.

The default value will be XHCI_CMD_DEFAULT_TIMEOUT (5 sec)

Use case:
According to the Smartphone integration certification
requirement in the automotive, the phone connected via USB
should complete enumeration and user space handshake
within 3 sec.

Reducing the response waiting time by setting the smaller
command timer delay helps to speed up overall re-enumeration
process of the USB device in case of device is not responding
properly in first enumeration iteration.

Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
---
 drivers/usb/core/hcd.c       | 23 +++++++++++++++++++++++
 drivers/usb/host/xhci-ring.c | 10 +++++-----
 drivers/usb/host/xhci.c      | 15 +++++++++++++++
 drivers/usb/host/xhci.h      |  1 +
 include/linux/usb/hcd.h      |  2 ++
 5 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 8300baedafd2..e392e90e918c 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -3157,6 +3157,29 @@ int usb_hcd_setup_local_mem(struct usb_hcd *hcd, phys_addr_t phys_addr,
 }
 EXPORT_SYMBOL_GPL(usb_hcd_setup_local_mem);
 
+/**
+ * usb_hcd_set_cmd_timer_delay Set the delay of the command timer.
+ * @hcd - pointer to the HCD representing the controller
+ * @delay - Delay value to be used in command timer.
+ *
+ * wrapper function to call the set_cmd_timer_delay API of the host
+ * diver.
+ *
+ * return 0 on success; otherwise -ENODEV means the feature not
+ * supported by host driver.
+ */
+
+int usb_hcd_set_cmd_timer_delay(struct usb_hcd *hcd, int delay)
+{
+	int ret = -ENODEV;
+
+	if (hcd->driver->set_cmd_timer_delay)
+		ret = hcd->driver->set_cmd_timer_delay(hcd, delay);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_hcd_set_cmd_timer_delay);
+
 /*-------------------------------------------------------------------------*/
 
 #if IS_ENABLED(CONFIG_USB_MON)
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 1dde53f6eb31..f4fcac9ae692 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -366,9 +366,9 @@ void xhci_ring_cmd_db(struct xhci_hcd *xhci)
 	readl(&xhci->dba->doorbell[0]);
 }
 
-static bool xhci_mod_cmd_timer(struct xhci_hcd *xhci, unsigned long delay)
+static bool xhci_mod_cmd_timer(struct xhci_hcd *xhci)
 {
-	return mod_delayed_work(system_wq, &xhci->cmd_timer, delay);
+	return mod_delayed_work(system_wq, &xhci->cmd_timer, xhci->cmd_timer_delay);
 }
 
 static struct xhci_command *xhci_next_queued_cmd(struct xhci_hcd *xhci)
@@ -412,7 +412,7 @@ static void xhci_handle_stopped_cmd_ring(struct xhci_hcd *xhci,
 	if ((xhci->cmd_ring->dequeue != xhci->cmd_ring->enqueue) &&
 	    !(xhci->xhc_state & XHCI_STATE_DYING)) {
 		xhci->current_cmd = cur_cmd;
-		xhci_mod_cmd_timer(xhci, XHCI_CMD_DEFAULT_TIMEOUT);
+		xhci_mod_cmd_timer(xhci);
 		xhci_ring_cmd_db(xhci);
 	}
 }
@@ -1786,7 +1786,7 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 	if (!list_is_singular(&xhci->cmd_list)) {
 		xhci->current_cmd = list_first_entry(&cmd->cmd_list,
 						struct xhci_command, cmd_list);
-		xhci_mod_cmd_timer(xhci, XHCI_CMD_DEFAULT_TIMEOUT);
+		xhci_mod_cmd_timer(xhci);
 	} else if (xhci->current_cmd == cmd) {
 		xhci->current_cmd = NULL;
 	}
@@ -4301,7 +4301,7 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 	/* if there are no other commands queued we start the timeout timer */
 	if (list_empty(&xhci->cmd_list)) {
 		xhci->current_cmd = cmd;
-		xhci_mod_cmd_timer(xhci, XHCI_CMD_DEFAULT_TIMEOUT);
+		xhci_mod_cmd_timer(xhci);
 	}
 
 	list_add_tail(&cmd->cmd_list, &xhci->cmd_list);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index fae994f679d4..e1920af985ed 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -449,6 +449,8 @@ static int xhci_init(struct usb_hcd *hcd)
 		compliance_mode_recovery_timer_init(xhci);
 	}
 
+	xhci->cmd_timer_delay = XHCI_CMD_DEFAULT_TIMEOUT;
+
 	return retval;
 }
 
@@ -5267,6 +5269,18 @@ static void xhci_clear_tt_buffer_complete(struct usb_hcd *hcd,
 	spin_unlock_irqrestore(&xhci->lock, flags);
 }
 
+static int xhci_set_cmd_delay(struct usb_hcd *hcd, int cmd_delay_ms)
+{
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+
+	if (cmd_delay_ms < 150 || cmd_delay_ms > 10000)
+		return -EINVAL;
+
+	xhci->cmd_timer_delay = cmd_delay_ms;
+
+	return 0;
+}
+
 static const struct hc_driver xhci_hc_driver = {
 	.description =		"xhci-hcd",
 	.product_desc =		"xHCI Host Controller",
@@ -5332,6 +5346,7 @@ static const struct hc_driver xhci_hc_driver = {
 	.disable_usb3_lpm_timeout =	xhci_disable_usb3_lpm_timeout,
 	.find_raw_port_number =	xhci_find_raw_port_number,
 	.clear_tt_buffer_complete = xhci_clear_tt_buffer_complete,
+	.set_cmd_timer_delay = xhci_set_cmd_delay,
 };
 
 void xhci_init_driver(struct hc_driver *drv,
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 7e282b4522c0..eb9a9b0bfa3d 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1808,6 +1808,7 @@ struct xhci_hcd {
 	struct list_head        cmd_list;
 	unsigned int		cmd_ring_reserved_trbs;
 	struct delayed_work	cmd_timer;
+	unsigned long		cmd_timer_delay;
 	struct completion	cmd_ring_stop_completion;
 	struct xhci_command	*current_cmd;
 
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 4e9623e8492b..b6b0a0bbf9fc 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -405,6 +405,7 @@ struct hc_driver {
 #define EHSET_TEST_SINGLE_STEP_SET_FEATURE 0x06
 	int	(*submit_single_step_set_feature)(struct usb_hcd *,
 			struct urb *, int);
+	int	(*set_cmd_timer_delay)(struct usb_hcd *hcd, int delay);
 };
 
 static inline int hcd_giveback_urb_in_bh(struct usb_hcd *hcd)
@@ -466,6 +467,7 @@ extern void usb_remove_hcd(struct usb_hcd *hcd);
 extern int usb_hcd_find_raw_port_number(struct usb_hcd *hcd, int port1);
 int usb_hcd_setup_local_mem(struct usb_hcd *hcd, phys_addr_t phys_addr,
 			    dma_addr_t dma, size_t size);
+int usb_hcd_set_cmd_timer_delay(struct usb_hcd *hcd, int delay);
 
 struct platform_device;
 extern void usb_hcd_platform_shutdown(struct platform_device *dev);
-- 
2.17.1


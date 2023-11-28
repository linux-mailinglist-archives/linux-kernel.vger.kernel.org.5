Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DB27FC29A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344875AbjK1OAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344802AbjK1OAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:00:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24FAB5;
        Tue, 28 Nov 2023 06:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701180053; x=1732716053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MNlQHIbeic/N5OcXLHIcXCVWnYu4P3iJBAyhPL8NeKQ=;
  b=YR76t52JeirAoil/rjLqIBq7CFupf56PCvqUvH/zRxBYaz8h+v9AQtU3
   T2M5YFro+nUeN11orlyiQQnhIPoSpQFDrpxQTqujexP/fRkzOrcoaCC26
   lKH/APIZM/6NHVk284OW+VdPqHGjmryjc0g1JdqY5Abne0L6xJFqR53FZ
   ak3QtPw8mx1mg1h47XyvlekcEeNT32NQy/2Hgz15vmXtYcoucZDAIa1Gb
   P34oNVfhpslkni2udgn+Iut7DltBCGfekpFHRunEKiWs+b4o4+zdCve12
   1jHJ+Op5e44d3t9yR/+URL2XDpITuIdhgY8UQ05kr3LVOBMywbUWl44xG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="383312970"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="383312970"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 06:00:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="892080410"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="892080410"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2023 06:00:28 -0800
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
To:     khtsai@google.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [RFT PATCH 1/2] xhci: Reconfigure endpoint 0 max packet size only during endpoint reset
Date:   Tue, 28 Nov 2023 16:01:40 +0200
Message-Id: <20231128140141.1161490-1-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <51b8fc3d-25ef-1ab3-d744-8d851a133828@linux.intel.com>
References: <51b8fc3d-25ef-1ab3-d744-8d851a133828@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max packet size for full speed control endpoint 0 may vary. It is
defined in the device descriptor, which is read using the same endpoint.
Usb core sets a temporary max packet size value until the real value is
read.

xhci driver needs to reconfigure the endpoint context seen by the
controller if the max packet size changes.
It makes more sense to do this reconfiguration in xhci_endpoint_reset()
instead of urb enqueue as usb core will call endpoint reset during
enumeration if the max packet values differ.
Max packet size adjustment for endpoinr 0 can only happen once per
device enumeration.

Previously the max packet size was checked during every urb enqueue.
This is an additional check for every enqueued urb, and also turned out
to have locking issues as urbs may be queued in any context while xhci
max packet size reconfiguration requires memory allocation, locking, and
sleeping.

Tested with a full speed device using both old and new scheme enumeration
and a intentionally incorrect preliminary max packet size value.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.c | 85 ++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 43 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 884b0898d9c9..df31d44498d6 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1438,10 +1438,8 @@ static int xhci_configure_endpoint(struct xhci_hcd *xhci,
  * descriptor.  If the usb_device's max packet size changes after that point,
  * we need to issue an evaluate context command and wait on it.
  */
-static int xhci_check_maxpacket(struct xhci_hcd *xhci, unsigned int slot_id,
-		unsigned int ep_index, struct urb *urb, gfp_t mem_flags)
+static int xhci_check_ep0_maxpacket(struct xhci_hcd *xhci, struct xhci_virt_device *vdev)
 {
-	struct xhci_container_ctx *out_ctx;
 	struct xhci_input_control_ctx *ctrl_ctx;
 	struct xhci_ep_ctx *ep_ctx;
 	struct xhci_command *command;
@@ -1449,11 +1447,15 @@ static int xhci_check_maxpacket(struct xhci_hcd *xhci, unsigned int slot_id,
 	int hw_max_packet_size;
 	int ret = 0;
 
-	out_ctx = xhci->devs[slot_id]->out_ctx;
-	ep_ctx = xhci_get_ep_ctx(xhci, out_ctx, ep_index);
+	ep_ctx = xhci_get_ep_ctx(xhci, vdev->out_ctx, 0);
 	hw_max_packet_size = MAX_PACKET_DECODED(le32_to_cpu(ep_ctx->ep_info2));
-	max_packet_size = usb_endpoint_maxp(&urb->dev->ep0.desc);
-	if (hw_max_packet_size != max_packet_size) {
+	max_packet_size = usb_endpoint_maxp(&vdev->udev->ep0.desc);
+
+	if (hw_max_packet_size == max_packet_size)
+		return 0;
+
+	switch (max_packet_size) {
+	case 8: case 16: case 32: case 64: case 9:
 		xhci_dbg_trace(xhci,  trace_xhci_dbg_context_change,
 				"Max Packet Size for ep 0 changed.");
 		xhci_dbg_trace(xhci,  trace_xhci_dbg_context_change,
@@ -1465,28 +1467,22 @@ static int xhci_check_maxpacket(struct xhci_hcd *xhci, unsigned int slot_id,
 		xhci_dbg_trace(xhci,  trace_xhci_dbg_context_change,
 				"Issuing evaluate context command.");
 
-		/* Set up the input context flags for the command */
-		/* FIXME: This won't work if a non-default control endpoint
-		 * changes max packet sizes.
-		 */
-
-		command = xhci_alloc_command(xhci, true, mem_flags);
+		command = xhci_alloc_command(xhci, true, GFP_KERNEL);
 		if (!command)
 			return -ENOMEM;
 
-		command->in_ctx = xhci->devs[slot_id]->in_ctx;
+		command->in_ctx = vdev->in_ctx;
 		ctrl_ctx = xhci_get_input_control_ctx(command->in_ctx);
 		if (!ctrl_ctx) {
 			xhci_warn(xhci, "%s: Could not get input context, bad type.\n",
 					__func__);
 			ret = -ENOMEM;
-			goto command_cleanup;
+			break;
 		}
 		/* Set up the modified control endpoint 0 */
-		xhci_endpoint_copy(xhci, xhci->devs[slot_id]->in_ctx,
-				xhci->devs[slot_id]->out_ctx, ep_index);
+		xhci_endpoint_copy(xhci, vdev->in_ctx, vdev->out_ctx, 0);
 
-		ep_ctx = xhci_get_ep_ctx(xhci, command->in_ctx, ep_index);
+		ep_ctx = xhci_get_ep_ctx(xhci, command->in_ctx, 0);
 		ep_ctx->ep_info &= cpu_to_le32(~EP_STATE_MASK);/* must clear */
 		ep_ctx->ep_info2 &= cpu_to_le32(~MAX_PACKET_MASK);
 		ep_ctx->ep_info2 |= cpu_to_le32(MAX_PACKET(max_packet_size));
@@ -1494,17 +1490,20 @@ static int xhci_check_maxpacket(struct xhci_hcd *xhci, unsigned int slot_id,
 		ctrl_ctx->add_flags = cpu_to_le32(EP0_FLAG);
 		ctrl_ctx->drop_flags = 0;
 
-		ret = xhci_configure_endpoint(xhci, urb->dev, command,
-				true, false);
-
-		/* Clean up the input context for later use by bandwidth
-		 * functions.
-		 */
+		ret = xhci_configure_endpoint(xhci, vdev->udev, command,
+					      true, false);
+		/* Clean up the input context for later use by bandwidth functions */
 		ctrl_ctx->add_flags = cpu_to_le32(SLOT_FLAG);
-command_cleanup:
-		kfree(command->completion);
-		kfree(command);
+		break;
+	default:
+		dev_dbg(&vdev->udev->dev, "incorrect max packet size %d for ep0\n",
+			max_packet_size);
+		return -EINVAL;
 	}
+
+	kfree(command->completion);
+	kfree(command);
+
 	return ret;
 }
 
@@ -1561,21 +1560,6 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 
 	trace_xhci_urb_enqueue(urb);
 
-	if (usb_endpoint_xfer_control(&urb->ep->desc)) {
-		/* Check to see if the max packet size for the default control
-		 * endpoint changed during FS device enumeration
-		 */
-		if (urb->dev->speed == USB_SPEED_FULL) {
-			ret = xhci_check_maxpacket(xhci, slot_id,
-					ep_index, urb, mem_flags);
-			if (ret < 0) {
-				xhci_urb_free_priv(urb_priv);
-				urb->hcpriv = NULL;
-				return ret;
-			}
-		}
-	}
-
 	spin_lock_irqsave(&xhci->lock, flags);
 
 	if (xhci->xhc_state & XHCI_STATE_DYING) {
@@ -3104,6 +3088,21 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 	int err;
 
 	xhci = hcd_to_xhci(hcd);
+	ep_index = xhci_get_endpoint_index(&host_ep->desc);
+
+	/*
+	 * Usb core assumes a max packet value for ep0 on FS devices until the
+	 * real value is read from the descriptor. Core resets Ep0 if values
+	 * mismatch. Reconfigure the xhci ep0 endpoint context here in that case
+	 */
+	if (usb_endpoint_xfer_control(&host_ep->desc) && ep_index == 0) {
+		udev = container_of(host_ep, struct usb_device, ep0);
+		if (udev->speed == USB_SPEED_FULL)
+			xhci_check_ep0_maxpacket(xhci, xhci->devs[udev->slot_id]);
+		/* Nothing else should be done here for ep0 during ep reset */
+		return;
+	}
+
 	if (!host_ep->hcpriv)
 		return;
 	udev = (struct usb_device *) host_ep->hcpriv;
@@ -3116,7 +3115,7 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 	 */
 	if (!udev->slot_id || !vdev)
 		return;
-	ep_index = xhci_get_endpoint_index(&host_ep->desc);
+
 	ep = &vdev->eps[ep_index];
 
 	/* Bail out if toggle is already being cleared by a endpoint reset */
-- 
2.25.1


Return-Path: <linux-kernel+bounces-41725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9605483F707
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04AA3B20C94
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4B95C5E5;
	Sun, 28 Jan 2024 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8/dH8Y1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5B35B211;
	Sun, 28 Jan 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458403; cv=none; b=SWppDSv1EEPTo5RS3/vf/xXbdCcGZqMX2nfbegJJJQXSDRnloCUSRbmnhY7gasATiYWQwc6Ys3DbzkbVStobVvGfAki2RxTo8H0dwgg4k/wkIlEYrbxJX/HX+xQA3m7tbTlZ8bnmYVkQ//d1G1hgTO+CXPp9HX1FEFg1bcj30M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458403; c=relaxed/simple;
	bh=IIE6rK5b2ck2c5U9EOv80xRLq3JhUK13cGioQvyBkoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbCRSamw/i3wA+WbV2Pewkyglcsdk7PV9o5pvtZvyWdf5dBwkJsiaPy8Jr29TRiXb/WhROzbIWmIjxD3t28RiNhvRPN7P0yeSq+GoNdu+qFERhjiyW+omGj3+KinS/ZM/dEBNRbnITg3gZ7Z+QQbXSXi85RSM4t8rP1jZ/xoxfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8/dH8Y1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AC6C43390;
	Sun, 28 Jan 2024 16:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458402;
	bh=IIE6rK5b2ck2c5U9EOv80xRLq3JhUK13cGioQvyBkoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8/dH8Y1KQPzTOKd10VuVEGhI/tvS4s4YzBOE4eLsIgRQu0Jz7ryiHJdXuH4Jdzog
	 NLvpS5vJ43/vCYNbzfhB/x69ewu368wvtQQN1qDRpHoIiOe+RibHJLqVMJ8ZaQXtKQ
	 YsxIjgOmSJyvJq/NmKhQKMrlWleksyBu6AJ24nSkB2X9nFLoM4V6uxmLndOXTcNR1b
	 RNcv8zbSXJaiN5F5ndF6dsWHDELoygU8SWiCegEyow6dUhmbR+HoFFQysbwXZxZPXP
	 NX9ihskK9ToWAmso/FEyubjZc7Q6sGJ3vdBUN8TJxm5Njjp7sY3Uz1W783ekTtQa1G
	 JwerPtpb0pREw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/31] xhci: fix possible null pointer deref during xhci urb enqueue
Date: Sun, 28 Jan 2024 11:12:34 -0500
Message-ID: <20240128161315.201999-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161315.201999-1-sashal@kernel.org>
References: <20240128161315.201999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit e2e2aacf042f52854c92775b7800ba668e0bdfe4 ]

There is a short gap between urb being submitted and actually added to the
endpoint queue (linked). If the device is disconnected during this time
then usb core is not yet aware of the pending urb, and device may be freed
just before xhci_urq_enqueue() continues, dereferencing the freed device.

Freeing the device is protected by the xhci spinlock, so make sure we take
and keep the lock while checking that device exists, dereference it, and
add the urb to the queue.

Remove the unnecessary URB check, usb core checks it before calling
xhci_urb_enqueue()

Suggested-by: Kuen-Han Tsai <khtsai@google.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20231201150647.1307406-20-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 132b76fa7ca6..e39c5ba9b7c7 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1498,24 +1498,7 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 	struct urb_priv	*urb_priv;
 	int num_tds;
 
-	if (!urb)
-		return -EINVAL;
-	ret = xhci_check_args(hcd, urb->dev, urb->ep,
-					true, true, __func__);
-	if (ret <= 0)
-		return ret ? ret : -EINVAL;
-
-	slot_id = urb->dev->slot_id;
 	ep_index = xhci_get_endpoint_index(&urb->ep->desc);
-	ep_state = &xhci->devs[slot_id]->eps[ep_index].ep_state;
-
-	if (!HCD_HW_ACCESSIBLE(hcd))
-		return -ESHUTDOWN;
-
-	if (xhci->devs[slot_id]->flags & VDEV_PORT_ERROR) {
-		xhci_dbg(xhci, "Can't queue urb, port error, link inactive\n");
-		return -ENODEV;
-	}
 
 	if (usb_endpoint_xfer_isoc(&urb->ep->desc))
 		num_tds = urb->number_of_packets;
@@ -1554,12 +1537,35 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 
 	spin_lock_irqsave(&xhci->lock, flags);
 
+	ret = xhci_check_args(hcd, urb->dev, urb->ep,
+			      true, true, __func__);
+	if (ret <= 0) {
+		ret = ret ? ret : -EINVAL;
+		goto free_priv;
+	}
+
+	slot_id = urb->dev->slot_id;
+
+	if (!HCD_HW_ACCESSIBLE(hcd)) {
+		ret = -ESHUTDOWN;
+		goto free_priv;
+	}
+
+	if (xhci->devs[slot_id]->flags & VDEV_PORT_ERROR) {
+		xhci_dbg(xhci, "Can't queue urb, port error, link inactive\n");
+		ret = -ENODEV;
+		goto free_priv;
+	}
+
 	if (xhci->xhc_state & XHCI_STATE_DYING) {
 		xhci_dbg(xhci, "Ep 0x%x: URB %p submitted for non-responsive xHCI host.\n",
 			 urb->ep->desc.bEndpointAddress, urb);
 		ret = -ESHUTDOWN;
 		goto free_priv;
 	}
+
+	ep_state = &xhci->devs[slot_id]->eps[ep_index].ep_state;
+
 	if (*ep_state & (EP_GETTING_STREAMS | EP_GETTING_NO_STREAMS)) {
 		xhci_warn(xhci, "WARN: Can't enqueue URB, ep in streams transition state %x\n",
 			  *ep_state);
-- 
2.43.0



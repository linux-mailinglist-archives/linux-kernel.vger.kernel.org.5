Return-Path: <linux-kernel+bounces-41759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7507883F767
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30ECE2848F8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3CB6A329;
	Sun, 28 Jan 2024 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1RgCpkC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5746A036;
	Sun, 28 Jan 2024 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458472; cv=none; b=USQisGxrJtCws1rCNOLeqfYIfzUY3WBFNYsIqIpdJkU41Pj3Zg5JaEG404pAb9wv3RiWtSIl+2cdSi/Z8KkiaHDBRHkq1KJUDvhjyHCa78jTtgQSU96ISGXSPrHGXITxYEwssrDStqlBjZ0QYvXNTMx6qGuNRfhvvd1vAgUi8lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458472; c=relaxed/simple;
	bh=ENRnlDx61NOkMW2P1EE0gGqfmzol4D9j0fgkECy6sxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXLgLF2gDb8VfSu0++ZZQZGrUjTXr5YAKakZkXz3Yjgu90cs3G2/cZ5SpEz4dYK6TA/dIXewn5P2TeZg7T+anMBlPahW4hwWQqgoYQScpEN7XlFqN/xH9kQNR9RLuYHzZGxLrtgPx+zA6zZ7elsrYENotF/i0w4x4l47gETaCAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1RgCpkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F278DC433F1;
	Sun, 28 Jan 2024 16:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458471;
	bh=ENRnlDx61NOkMW2P1EE0gGqfmzol4D9j0fgkECy6sxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1RgCpkCjufQOf5eVxh7hJ6yMmOJjkFQwDYPbIMLppGfIJ2i84e7ArMlWU6WZvpMe
	 QWuVvBje93qM0OIw5XsSez4/WR7OBlL6nBMXTNmOf1CRhleiiGrmdpZxUvlVK4SKsY
	 xaWZY2oiPxxDvo7+zz+0GmnyqVBGuSw2XOXyDTLvNTFkTJha4B0uVpaVhVMJvfdh9+
	 HF8AJ6UKaXzHRx74155fptoAD27xg9ImqsMXvnBtVUxrjsCgo+jkDbbNFC0NW7lCuv
	 QScWw7aqipVbIRQmd8AHJxjjURfxSKw9+FIyfqonesTzKFUpwOYuu+XAfoVVOvFP88
	 GCKXrvhFLIe+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/27] xhci: fix possible null pointer deref during xhci urb enqueue
Date: Sun, 28 Jan 2024 11:13:49 -0500
Message-ID: <20240128161424.203600-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161424.203600-1-sashal@kernel.org>
References: <20240128161424.203600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.75
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
index c02ad4f76bb3..127fbad32a75 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1654,24 +1654,7 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
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
@@ -1710,12 +1693,35 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 
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



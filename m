Return-Path: <linux-kernel+bounces-101908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA4F87ACA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFF91C2107E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4EB82D8F;
	Wed, 13 Mar 2024 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2Xz0MXh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A19B82894;
	Wed, 13 Mar 2024 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348047; cv=none; b=YdXzDrt/x29D3eVxUnyMK+2n5RRQOJhjuXKHErvr8c0hTCRCyvDr/xoOILN99QRFc1vgX8Xf7rcDEw8xJenDlfX/stBuukp2vU8vd26zFcz2bJxrBajKrWv/GG8w2JcLR0A1ADL9fC3PEnbt/KLJPSDzktzQuiZYOWS3dYDTyBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348047; c=relaxed/simple;
	bh=vf+z88VURtSlLLkLZwNjB5IXGlDWZe53u/QAx6jsFB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G937lOrPLTI4netJMoVhmsH9CyvFEjWmkFJGSMOszYMLYF2fHyLfVfVmgrBDgzuTFFZgg+u4v+LKH6Yk5b0ToxfjkfJ99aSIr1o//pE05zRxGcMu+IZteRx6Nyc1FXayAE8A/DfVMCzBsLqqlX+VaXDoQQtn7ZB+WjQg6zTHj3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2Xz0MXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2311EC433B1;
	Wed, 13 Mar 2024 16:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348047;
	bh=vf+z88VURtSlLLkLZwNjB5IXGlDWZe53u/QAx6jsFB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2Xz0MXheSyxlQ6I36zXGgeRiHNiYz9PZKgR7FFtsBqDQXQnB+iwe8GsbaAoWCHN5
	 yYUqZHTcZQsFAd8FIG39xnSFxj3ryTsOmzxB0C2G36CtkbzqAJhcHGJi7pMcZ6+BGs
	 QRpIwPN8SHfKqgA/UUK7ef0RQwBiiq/zZevBXaIPlsvvVcUrZu5Lo6PUXCE/iSRNzP
	 EGrQLtbIHBvzobgmj1DBJykknRKI3t9X9hxPPF4qaGFarmCydo1+c9jm7vVEEXdBdw
	 j6ltZ90zL4C1HZRweyxvgCT3aPy4Gg3LE7+4VZNco7TBXd7AZ20bAd8CL/5SJBp2PO
	 z3NUPUOcvfU4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	=?UTF-8?q?Micha=C5=82=20Pecio?= <michal.pecio@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 40/71] xhci: process isoc TD properly when there was a transaction error mid TD.
Date: Wed, 13 Mar 2024 12:39:26 -0400
Message-ID: <20240313163957.615276-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit 5372c65e1311a16351ef03dd096ff576e6477674 ]

The last TRB of a isoc TD might not trigger an event if there was
an error event for a TRB mid TD. This is seen on a NEC Corporation
uPD720200 USB 3.0 Host

After an error mid a multi-TRB TD the xHC should according to xhci 4.9.1
generate events for passed TRBs with IOC flag set if it proceeds to the
next TD. This event is either a copy of the original error, or a
"success" transfer event.

If that event is missing then the driver and xHC host get out of sync as
the driver is still expecting a transfer event for that first TD, while
xHC host is already sending events for the next TD in the list.
This leads to
"Transfer event TRB DMA ptr not part of current TD" messages.

As a solution we tag the isoc TDs that get error events mid TD.
If an event doesn't match the first TD, then check if the tag is
set, and event points to the next TD.
In that case give back the fist TD and process the next TD normally

Make sure TD status and transferred length stay valid in both cases
with and without final TD completion event.

Reported-by: Michał Pecio <michal.pecio@gmail.com>
Closes: https://lore.kernel.org/linux-usb/20240112235205.1259f60c@foxbook/
Tested-by: Michał Pecio <michal.pecio@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20240125152737.2983959-4-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 74 +++++++++++++++++++++++++++++-------
 drivers/usb/host/xhci.h      |  1 +
 2 files changed, 61 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 1239e06dfe411..e4441a71368e5 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2363,6 +2363,9 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	/* handle completion code */
 	switch (trb_comp_code) {
 	case COMP_SUCCESS:
+		/* Don't overwrite status if TD had an error, see xHCI 4.9.1 */
+		if (td->error_mid_td)
+			break;
 		if (remaining) {
 			frame->status = short_framestatus;
 			if (xhci->quirks & XHCI_TRUST_TX_LENGTH)
@@ -2388,8 +2391,9 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		break;
 	case COMP_USB_TRANSACTION_ERROR:
 		frame->status = -EPROTO;
+		sum_trbs_for_length = true;
 		if (ep_trb != td->last_trb)
-			return 0;
+			td->error_mid_td = true;
 		break;
 	case COMP_STOPPED:
 		sum_trbs_for_length = true;
@@ -2409,6 +2413,9 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		break;
 	}
 
+	if (td->urb_length_set)
+		goto finish_td;
+
 	if (sum_trbs_for_length)
 		frame->actual_length = sum_trb_lengths(xhci, ep->ring, ep_trb) +
 			ep_trb_len - remaining;
@@ -2417,6 +2424,14 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 
 	td->urb->actual_length += frame->actual_length;
 
+finish_td:
+	/* Don't give back TD yet if we encountered an error mid TD */
+	if (td->error_mid_td && ep_trb != td->last_trb) {
+		xhci_dbg(xhci, "Error mid isoc TD, wait for final completion event\n");
+		td->urb_length_set = true;
+		return 0;
+	}
+
 	return finish_td(xhci, ep, ep_ring, td, trb_comp_code);
 }
 
@@ -2801,17 +2816,51 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		}
 
 		if (!ep_seg) {
-			if (!ep->skip ||
-			    !usb_endpoint_xfer_isoc(&td->urb->ep->desc)) {
-				/* Some host controllers give a spurious
-				 * successful event after a short transfer.
-				 * Ignore it.
-				 */
-				if ((xhci->quirks & XHCI_SPURIOUS_SUCCESS) &&
-						ep_ring->last_td_was_short) {
-					ep_ring->last_td_was_short = false;
-					goto cleanup;
+
+			if (ep->skip && usb_endpoint_xfer_isoc(&td->urb->ep->desc)) {
+				skip_isoc_td(xhci, td, ep, status);
+				goto cleanup;
+			}
+
+			/*
+			 * Some hosts give a spurious success event after a short
+			 * transfer. Ignore it.
+			 */
+			if ((xhci->quirks & XHCI_SPURIOUS_SUCCESS) &&
+			    ep_ring->last_td_was_short) {
+				ep_ring->last_td_was_short = false;
+				goto cleanup;
+			}
+
+			/*
+			 * xhci 4.10.2 states isoc endpoints should continue
+			 * processing the next TD if there was an error mid TD.
+			 * So host like NEC don't generate an event for the last
+			 * isoc TRB even if the IOC flag is set.
+			 * xhci 4.9.1 states that if there are errors in mult-TRB
+			 * TDs xHC should generate an error for that TRB, and if xHC
+			 * proceeds to the next TD it should genete an event for
+			 * any TRB with IOC flag on the way. Other host follow this.
+			 * So this event might be for the next TD.
+			 */
+			if (td->error_mid_td &&
+			    !list_is_last(&td->td_list, &ep_ring->td_list)) {
+				struct xhci_td *td_next = list_next_entry(td, td_list);
+
+				ep_seg = trb_in_td(xhci, td_next->start_seg, td_next->first_trb,
+						   td_next->last_trb, ep_trb_dma, false);
+				if (ep_seg) {
+					/* give back previous TD, start handling new */
+					xhci_dbg(xhci, "Missing TD completion event after mid TD error\n");
+					ep_ring->dequeue = td->last_trb;
+					ep_ring->deq_seg = td->last_trb_seg;
+					inc_deq(xhci, ep_ring);
+					xhci_td_cleanup(xhci, td, ep_ring, td->status);
+					td = td_next;
 				}
+			}
+
+			if (!ep_seg) {
 				/* HC is busted, give up! */
 				xhci_err(xhci,
 					"ERROR Transfer event TRB DMA ptr not "
@@ -2823,9 +2872,6 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 					  ep_trb_dma, true);
 				return -ESHUTDOWN;
 			}
-
-			skip_isoc_td(xhci, td, ep, status);
-			goto cleanup;
 		}
 		if (trb_comp_code == COMP_SHORT_PACKET)
 			ep_ring->last_td_was_short = true;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 1354310cb37b1..fc25a5b09710c 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1570,6 +1570,7 @@ struct xhci_td {
 	struct xhci_segment	*bounce_seg;
 	/* actual_length of the URB has already been set */
 	bool			urb_length_set;
+	bool			error_mid_td;
 	unsigned int		num_trbs;
 };
 
-- 
2.43.0



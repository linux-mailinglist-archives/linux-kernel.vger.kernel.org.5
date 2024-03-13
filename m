Return-Path: <linux-kernel+bounces-102060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E10787AE11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4691C2275F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA4E1586C9;
	Wed, 13 Mar 2024 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFO8i0T3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02534157E8D;
	Wed, 13 Mar 2024 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348440; cv=none; b=EduJa9Vo1ymUFlcCmRWuXBOwDQqPDjeexJfjCT42rtMugyQj/GD4kxIepSJ4tj8LBZxJVbd+d5CB/Ep97oAqRs18PFulfKsVkzDWmMC087bnn2H3NXk9zxdWstgaYHZgyYaToFDVAWHEdkMtpaqVQMCV5rKEuyMmEbrY8Kdamls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348440; c=relaxed/simple;
	bh=aZXsDham/VRQJbUEVliVBpNZ6KlZ1VS3RCIQK+Epswc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MivJw+OJXuEHeNfsfNXVlGaGeskPBWR4YkRaMhnLBvFVtKRmwaI6yKnxAPvoTygusC7zo8PpSBKHtbtLCrEDLHZUhz4hoAa9yMVTu8yBS+d22QazfqGCCQ0I5pVrlWA0tcQCd1+DZbSkPZjas35/SxN+95Kma6KEQaL5QNFgPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFO8i0T3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A18FC433C7;
	Wed, 13 Mar 2024 16:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348439;
	bh=aZXsDham/VRQJbUEVliVBpNZ6KlZ1VS3RCIQK+Epswc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oFO8i0T3R+pBLREOmE+hei4N+BT+ZlwEA5KpcBGDH4fU4SeX3WAjoVXA2aMrs2iP4
	 9LQYa1ahQklvcDc1v6tYZ6JD/8hhD12r49nU9AnUSkFH4Zm/qOHVUcYpfzwQ3rHCIc
	 LmW/CHSX6cRdfLNMkZeLrHWpTbpi0Oz19H16dMr/OLPA9J5ey6o3CxVZ6TU2D1gRVX
	 rrVCenSyjyRKRQP78OHgKHJkAOEcAYgZnL3PHOrIZy+eAwjTgUVPvU7R7LEHJGamVe
	 qlTnIZRhhUzRhnYHTzR6Inpns17oj+pvy+QW+sqDI1x/Q3QrOh8cRCWjMvyWqzIRRY
	 5uUSbZ3Kqk0yw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 34/73] xhci: prevent double-fetch of transfer and transfer event TRBs
Date: Wed, 13 Mar 2024 12:46:01 -0400
Message-ID: <20240313164640.616049-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit e9fcb07704fcef6fa6d0333fd2b3a62442eaf45b ]

The same values are parsed several times from transfer and event
TRBs by different functions in the same call path, all while processing
one transfer event.

As the TRBs are in DMA memory and can be accessed by the xHC host we want
to avoid this to prevent double-fetch issues.

To resolve this pass the already parsed values to the different functions
in the path of parsing a transfer event

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20210406070208.3406266-5-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 5372c65e1311 ("xhci: process isoc TD properly when there was a transaction error mid TD.")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 42 ++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index b814dc07116da..62d92da7016e7 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2059,16 +2059,13 @@ int xhci_is_vendor_info_code(struct xhci_hcd *xhci, unsigned int trb_comp_code)
 	return 0;
 }
 
-static int finish_td(struct xhci_hcd *xhci, struct xhci_td *td,
-	struct xhci_transfer_event *event, struct xhci_virt_ep *ep)
+static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
+		     struct xhci_ring *ep_ring, struct xhci_td *td,
+		     u32 trb_comp_code)
 {
 	struct xhci_ep_ctx *ep_ctx;
-	struct xhci_ring *ep_ring;
-	u32 trb_comp_code;
 
-	ep_ring = xhci_dma_to_transfer_ring(ep, le64_to_cpu(event->buffer));
 	ep_ctx = xhci_get_ep_ctx(xhci, ep->vdev->out_ctx, ep->ep_index);
-	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
 
 	if (trb_comp_code == COMP_STOPPED_LENGTH_INVALID ||
 			trb_comp_code == COMP_STOPPED ||
@@ -2126,9 +2123,9 @@ static int sum_trb_lengths(struct xhci_hcd *xhci, struct xhci_ring *ring,
 /*
  * Process control tds, update urb status and actual_length.
  */
-static int process_ctrl_td(struct xhci_hcd *xhci, struct xhci_td *td,
-	union xhci_trb *ep_trb, struct xhci_transfer_event *event,
-	struct xhci_virt_ep *ep)
+static int process_ctrl_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
+		struct xhci_ring *ep_ring,  struct xhci_td *td,
+			   union xhci_trb *ep_trb, struct xhci_transfer_event *event)
 {
 	struct xhci_ep_ctx *ep_ctx;
 	u32 trb_comp_code;
@@ -2216,15 +2213,15 @@ static int process_ctrl_td(struct xhci_hcd *xhci, struct xhci_td *td,
 		td->urb->actual_length = requested;
 
 finish_td:
-	return finish_td(xhci, td, event, ep);
+	return finish_td(xhci, ep, ep_ring, td, trb_comp_code);
 }
 
 /*
  * Process isochronous tds, update urb packet status and actual_length.
  */
-static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
-	union xhci_trb *ep_trb, struct xhci_transfer_event *event,
-	struct xhci_virt_ep *ep)
+static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
+		struct xhci_ring *ep_ring, struct xhci_td *td,
+		union xhci_trb *ep_trb, struct xhci_transfer_event *event)
 {
 	struct urb_priv *urb_priv;
 	int idx;
@@ -2301,7 +2298,7 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
 
 	td->urb->actual_length += frame->actual_length;
 
-	return finish_td(xhci, td, event, ep);
+	return finish_td(xhci, ep, ep_ring, td, trb_comp_code);
 }
 
 static int skip_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
@@ -2333,17 +2330,15 @@ static int skip_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
 /*
  * Process bulk and interrupt tds, update urb status and actual_length.
  */
-static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_td *td,
-	union xhci_trb *ep_trb, struct xhci_transfer_event *event,
-	struct xhci_virt_ep *ep)
+static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
+		struct xhci_ring *ep_ring, struct xhci_td *td,
+		union xhci_trb *ep_trb, struct xhci_transfer_event *event)
 {
 	struct xhci_slot_ctx *slot_ctx;
-	struct xhci_ring *ep_ring;
 	u32 trb_comp_code;
 	u32 remaining, requested, ep_trb_len;
 
 	slot_ctx = xhci_get_slot_ctx(xhci, ep->vdev->out_ctx);
-	ep_ring = xhci_dma_to_transfer_ring(ep, le64_to_cpu(event->buffer));
 	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
 	remaining = EVENT_TRB_LEN(le32_to_cpu(event->transfer_len));
 	ep_trb_len = TRB_LEN(le32_to_cpu(ep_trb->generic.field[2]));
@@ -2403,7 +2398,8 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_td *td,
 			  remaining);
 		td->urb->actual_length = 0;
 	}
-	return finish_td(xhci, td, event, ep);
+
+	return finish_td(xhci, ep, ep_ring, td, trb_comp_code);
 }
 
 /*
@@ -2754,11 +2750,11 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 
 		/* update the urb's actual_length and give back to the core */
 		if (usb_endpoint_xfer_control(&td->urb->ep->desc))
-			process_ctrl_td(xhci, td, ep_trb, event, ep);
+			process_ctrl_td(xhci, ep, ep_ring, td, ep_trb, event);
 		else if (usb_endpoint_xfer_isoc(&td->urb->ep->desc))
-			process_isoc_td(xhci, td, ep_trb, event, ep);
+			process_isoc_td(xhci, ep, ep_ring, td, ep_trb, event);
 		else
-			process_bulk_intr_td(xhci, td, ep_trb, event, ep);
+			process_bulk_intr_td(xhci, ep, ep_ring, td, ep_trb, event);
 cleanup:
 		handling_skipped_tds = ep->skip &&
 			trb_comp_code != COMP_MISSED_SERVICE_ERROR &&
-- 
2.43.0



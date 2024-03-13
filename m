Return-Path: <linux-kernel+bounces-102059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5C687AE0F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1635C1F2D044
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1B9157E83;
	Wed, 13 Mar 2024 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaKQHxp0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2476B157E63;
	Wed, 13 Mar 2024 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348439; cv=none; b=nJz8FRebA/Y4ikloQiIN6NHdU+9Fy65pvrie1pcJQ0/yQcDCMlI6khhAT6tY4HG3zBk1ALZwlG4h89sTmPtkmp3tfNTPY7f2N6KzXGFE3OeOJNGHHAolqKFmW5/hzjoa0tzIsrxI5eGw4I/J/V4Gsv3W1L2/CZkKcK9KqmFlo84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348439; c=relaxed/simple;
	bh=RIVemwWILV1Ivhuy6i7UoQRPSNXn4l1ZvxG6KdWc4Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XR+08yDgWZP8rCGOdHJsOMpt4LMDuRek2ZUbe2jNKVXZhVjSw+HHNnBi8vtJq0b7EWxzpYQnQVBSW4sb6cuSaMvpP1A3X79fJAX7XaHEsQraC4iiMCGnVRtjmjzjvjdWpDfBtOJ9LPd+T4QAaPSNDeebNde0RsfYCxq4tZ7cD/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaKQHxp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05867C433B1;
	Wed, 13 Mar 2024 16:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348438;
	bh=RIVemwWILV1Ivhuy6i7UoQRPSNXn4l1ZvxG6KdWc4Ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FaKQHxp09dNWfWgSrVpxraTs37MFws+aJN24AJ8Cb+/tZ5XBqy+hJ6t9pOZ8SupFi
	 KCY6k6qEXTs2vhaRtTB4VQwoKP4M3zWZ6An2Tn5jpz0iAHnfhoGPpjYIF4uOIfpkSM
	 u8nX/xYSYwc4aFw6SkMoxU3e6AJuFz4ULEDG9RbwscPqksczNSHb9ZJg9h1/Zzf7xZ
	 NJHlDbfBq0Tuig786P0uCsa792ZBtFYT5eL78q0LcqVSh9/QSAJJBnJpkYvnXPzuav
	 sbL5vHGBseTrHXVpGhoXOTXESXMN5QDQgbsTEvZMmV5C/XuylrdXA3zgdJ93/czrYn
	 AJKVsEPJDHavw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 33/73] xhci: remove extra loop in interrupt context
Date: Wed, 13 Mar 2024 12:46:00 -0400
Message-ID: <20240313164640.616049-34-sashal@kernel.org>
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

[ Upstream commit 55f6153d8cc8eff0852d108f80087fdf41dc2169 ]

When finishing a TD we walk the endpoint dequeue trb pointer
until it matches the last TRB of the TD.

TDs can contain over 100 TRBs, meaning we call a function 100 times,
do a few comparisons and increase a couple values for each of these calls,
all in interrupt context.

This can all be avoided by adding a pointer to the last TRB segment, and
a number of TRBs in the TD. So instead of walking through each TRB just
set the new dequeue segment, pointer, and number of free TRBs directly.

Getting rid of the while loop also reduces the risk of getting stuck in a
infinite loop in the interrupt handler. Loop relied on valid matching
dequeue and last_trb values to break.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20210129130044.206855-12-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 5372c65e1311 ("xhci: process isoc TD properly when there was a transaction error mid TD.")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 21 ++++++++++++++-------
 drivers/usb/host/xhci.h      |  2 ++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index eb70f07e3623a..b814dc07116da 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2099,8 +2099,9 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_td *td,
 					     EP_HARD_RESET);
 	} else {
 		/* Update ring dequeue pointer */
-		while (ep_ring->dequeue != td->last_trb)
-			inc_deq(xhci, ep_ring);
+		ep_ring->dequeue = td->last_trb;
+		ep_ring->deq_seg = td->last_trb_seg;
+		ep_ring->num_trbs_free += td->num_trbs - 1;
 		inc_deq(xhci, ep_ring);
 	}
 
@@ -2321,8 +2322,9 @@ static int skip_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
 	frame->actual_length = 0;
 
 	/* Update ring dequeue pointer */
-	while (ep->ring->dequeue != td->last_trb)
-		inc_deq(xhci, ep->ring);
+	ep->ring->dequeue = td->last_trb;
+	ep->ring->deq_seg = td->last_trb_seg;
+	ep->ring->num_trbs_free += td->num_trbs - 1;
 	inc_deq(xhci, ep->ring);
 
 	return xhci_td_cleanup(xhci, td, ep->ring, status);
@@ -3487,7 +3489,7 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 			field |= TRB_IOC;
 			more_trbs_coming = false;
 			td->last_trb = ring->enqueue;
-
+			td->last_trb_seg = ring->enq_seg;
 			if (xhci_urb_suitable_for_idt(urb)) {
 				memcpy(&send_addr, urb->transfer_buffer,
 				       trb_buff_len);
@@ -3513,7 +3515,7 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 				upper_32_bits(send_addr),
 				length_field,
 				field);
-
+		td->num_trbs++;
 		addr += trb_buff_len;
 		sent_len = trb_buff_len;
 
@@ -3537,8 +3539,10 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 				       ep_index, urb->stream_id,
 				       1, urb, 1, mem_flags);
 		urb_priv->td[1].last_trb = ring->enqueue;
+		urb_priv->td[1].last_trb_seg = ring->enq_seg;
 		field = TRB_TYPE(TRB_NORMAL) | ring->cycle_state | TRB_IOC;
 		queue_trb(xhci, ring, 0, 0, 0, TRB_INTR_TARGET(0), field);
+		urb_priv->td[1].num_trbs++;
 	}
 
 	check_trb_math(urb, enqd_len);
@@ -3589,6 +3593,7 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 
 	urb_priv = urb->hcpriv;
 	td = &urb_priv->td[0];
+	td->num_trbs = num_trbs;
 
 	/*
 	 * Don't give the first TRB to the hardware (by toggling the cycle bit)
@@ -3661,6 +3666,7 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 
 	/* Save the DMA address of the last TRB in the TD */
 	td->last_trb = ep_ring->enqueue;
+	td->last_trb_seg = ep_ring->enq_seg;
 
 	/* Queue status TRB - see Table 7 and sections 4.11.2.2 and 6.4.1.2.3 */
 	/* If the device sent data, the status stage is an OUT transfer */
@@ -3905,7 +3911,7 @@ static int xhci_queue_isoc_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 			goto cleanup;
 		}
 		td = &urb_priv->td[i];
-
+		td->num_trbs = trbs_per_td;
 		/* use SIA as default, if frame id is used overwrite it */
 		sia_frame_id = TRB_SIA;
 		if (!(urb->transfer_flags & URB_ISO_ASAP) &&
@@ -3948,6 +3954,7 @@ static int xhci_queue_isoc_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 			} else {
 				more_trbs_coming = false;
 				td->last_trb = ep_ring->enqueue;
+				td->last_trb_seg = ep_ring->enq_seg;
 				field |= TRB_IOC;
 				if (trb_block_event_intr(xhci, num_tds, i))
 					field |= TRB_BEI;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index bb3c362a194b2..85ab213c7940a 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1550,9 +1550,11 @@ struct xhci_td {
 	struct xhci_segment	*start_seg;
 	union xhci_trb		*first_trb;
 	union xhci_trb		*last_trb;
+	struct xhci_segment	*last_trb_seg;
 	struct xhci_segment	*bounce_seg;
 	/* actual_length of the URB has already been set */
 	bool			urb_length_set;
+	unsigned int		num_trbs;
 };
 
 /* xHCI command default timeout value */
-- 
2.43.0



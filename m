Return-Path: <linux-kernel+bounces-113511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084438884E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B141F2259B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4721BBFE2;
	Sun, 24 Mar 2024 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFN3m3xu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699831BBFC3;
	Sun, 24 Mar 2024 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320312; cv=none; b=BZNZYqsaV7sm9QhNX8D2NWKrvvuqhji+xL+blQCSaNXcNS40HW4VcQg7Di0p7VSK90/eNkrzwzv30HVTz7ZQoZOZAFkPWJ91wlcqnqVBl2E0PXqr4xryXTxPem1Pt9dPMXu7vRGip/3DyDxZW8BtbX2ri+J6Qu+pIM5SmyGD3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320312; c=relaxed/simple;
	bh=xiSbIKNpF7aJ9VCvZK7OSe6KRyP2YgnsAbarA/1z+zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjYqcBu3anHrvw1JeCPssTze+56Nz0YY5UtXwDCu/Ab7ZGjT66Sp9jbgG85MdglLImIYnaxaFozEphOEDFEPATuys+v6V5ST180LBSQxXkok77C/I+2BD0Cxp6ofqd7+PTBVj30kGRbu5h1HST/BDEO911SVQddIaQSzHDhb9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFN3m3xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFDAC433C7;
	Sun, 24 Mar 2024 22:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320312;
	bh=xiSbIKNpF7aJ9VCvZK7OSe6KRyP2YgnsAbarA/1z+zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lFN3m3xuNtl+RFew+84RuDrD9620EGN4psvhvM3JlayFID3ZxEixBJ1G6sHE9fwjv
	 sB8w1EqFmZcoFm4d8nTz62BmWVvNophbaBhqjBsZ6/DdC9QNUkEqajVf1kD0+r9RVr
	 Bj7JCKiqeVUUhe/hmbxZ9hAEHmjCNbV/911t95Q1MWDQJQf6uSHbnEMzMe55tEpF62
	 dM7MR1dFcz9ooJ+UA3THzkvKTU35GM73Q0by/voUnswe0zS9lMwNK3rXwbKeOz0eSI
	 w0hYrtXBGrxnHu+EOer2xklFfiIx23P4hJqUHtuvF3wP2Ko/vUeslKKvLiI6oslbKg
	 Ja3zkevoJsymQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 620/715] xhci: remove unnecessary event_ring_deq parameter from xhci_handle_event()
Date: Sun, 24 Mar 2024 18:33:19 -0400
Message-ID: <20240324223455.1342824-621-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit 143e64df1bda33310c30ba5e15f72022e6135939 ]

The event_ring_deq parameter is used to check if the event ring dequeue
position is updated while calling by xhci_handle_event(), meaning there was
an actual event on the ring to handle. In this case the driver needs to
inform hardware about the updated dequeue position.
Basically event_ring_deq just stores the old event ring dequeue position
before calling the event handler.

Keeping track of software event dequeue updates this way is no longer
useful as driver anyways reads the current hardware dequeue position
within the handle event, and checks if it needs to be updated.

The driver might anyway need to modify the EHB (event handler busy) bit in
the same register as the dequeue pointer even if the actual dequeue
position did not change.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
Link: https://lore.kernel.org/r/20240217001017.29969-5-quic_wcheng@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: e30e9ad9ed66 ("xhci: update event ring dequeue pointer position to controller correctly")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 37 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 53852383d6143..129d2e83034c1 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3038,30 +3038,26 @@ static int xhci_handle_event(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
  */
 static void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
 				     struct xhci_interrupter *ir,
-				     union xhci_trb *event_ring_deq,
 				     bool clear_ehb)
 {
 	u64 temp_64;
 	dma_addr_t deq;
 
 	temp_64 = xhci_read_64(xhci, &ir->ir_set->erst_dequeue);
-	/* If necessary, update the HW's version of the event ring deq ptr. */
-	if (event_ring_deq != ir->event_ring->dequeue) {
-		deq = xhci_trb_virt_to_dma(ir->event_ring->deq_seg,
-				ir->event_ring->dequeue);
-		if (deq == 0)
-			xhci_warn(xhci, "WARN something wrong with SW event ring dequeue ptr\n");
-		/*
-		 * Per 4.9.4, Software writes to the ERDP register shall
-		 * always advance the Event Ring Dequeue Pointer value.
-		 */
-		if ((temp_64 & ERST_PTR_MASK) == (deq & ERST_PTR_MASK))
-			return;
+	deq = xhci_trb_virt_to_dma(ir->event_ring->deq_seg,
+				   ir->event_ring->dequeue);
+	if (deq == 0)
+		xhci_warn(xhci, "WARN something wrong with SW event ring dequeue ptr\n");
+	/*
+	 * Per 4.9.4, Software writes to the ERDP register shall always advance
+	 * the Event Ring Dequeue Pointer value.
+	 */
+	if ((temp_64 & ERST_PTR_MASK) == (deq & ERST_PTR_MASK) && !clear_ehb)
+		return;
 
-		/* Update HC event ring dequeue pointer */
-		temp_64 = ir->event_ring->deq_seg->num & ERST_DESI_MASK;
-		temp_64 |= deq & ERST_PTR_MASK;
-	}
+	/* Update HC event ring dequeue pointer */
+	temp_64 = ir->event_ring->deq_seg->num & ERST_DESI_MASK;
+	temp_64 |= deq & ERST_PTR_MASK;
 
 	/* Clear the event handler busy flag (RW1C) */
 	if (clear_ehb)
@@ -3090,7 +3086,6 @@ static void xhci_clear_interrupt_pending(struct xhci_hcd *xhci,
 irqreturn_t xhci_irq(struct usb_hcd *hcd)
 {
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
-	union xhci_trb *event_ring_deq;
 	struct xhci_interrupter *ir;
 	irqreturn_t ret = IRQ_NONE;
 	u64 temp_64;
@@ -3148,15 +3143,13 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 		goto out;
 	}
 
-	event_ring_deq = ir->event_ring->dequeue;
 	/* FIXME this should be a delayed service routine
 	 * that clears the EHB.
 	 */
 	while (xhci_handle_event(xhci, ir) > 0) {
 		if (event_loop++ < TRBS_PER_SEGMENT / 2)
 			continue;
-		xhci_update_erst_dequeue(xhci, ir, event_ring_deq, false);
-		event_ring_deq = ir->event_ring->dequeue;
+		xhci_update_erst_dequeue(xhci, ir, false);
 
 		/* ring is half-full, force isoc trbs to interrupt more often */
 		if (ir->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
@@ -3165,7 +3158,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 		event_loop = 0;
 	}
 
-	xhci_update_erst_dequeue(xhci, ir, event_ring_deq, true);
+	xhci_update_erst_dequeue(xhci, ir, true);
 	ret = IRQ_HANDLED;
 
 out:
-- 
2.43.0



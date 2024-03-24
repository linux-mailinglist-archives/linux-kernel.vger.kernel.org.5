Return-Path: <linux-kernel+bounces-113510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC98884E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC56528199A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425F81BAC50;
	Sun, 24 Mar 2024 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDuZKz+Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE001BB74B;
	Sun, 24 Mar 2024 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320311; cv=none; b=tz1yhe4aVaws2qwJAzO3WQnKUO1OxNtefFtQmvRRagEwGtwfxIG424XurVWYSuohQHDFdLuoyFwqDzuf17DzUMsDCCrYGdbW0fn5DQhXLuqqSMVXB8LAuELpXk3YD4ZfixDisBl/fUf/SwdYpyCdMIprqBUXBMotr6vV/rA1dLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320311; c=relaxed/simple;
	bh=GcmIa7DiEAW6r7/R3D2Ha1rcx+aYQsSRPv1Sv5+aRTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tx3LCU0KKJuOR2lvfIysufk8aOgPa4FRcSPZ+G5k3QqzOrifGw2Igrf/ZExgvCUoR4JwuWegGo13acqbXtEu7eWjvP8U8EpdbOo/axzuukOnx67HeByGxbVtq2XbQ3vdCZSXRrYxsIju1NGqOZWizRmEnso+0OAuvz3ig0LtL7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDuZKz+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91692C43394;
	Sun, 24 Mar 2024 22:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320311;
	bh=GcmIa7DiEAW6r7/R3D2Ha1rcx+aYQsSRPv1Sv5+aRTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kDuZKz+ZJW5rArNkr+EfaKcokgqYQ2Q0e0trJ/0WE2Ny6vGJXJwf3xEYIdDi8nJQt
	 fCtQb6mltvE8IkRzNLqizj41EzpZsnA1VuXsMQ7onvGcY3DE63rrq0dwSvJhgJ9ryc
	 TtJgt5+xMxMqA26gcjRqlg6j1lXyKUkVYCZn5QWRP+eOIzuxjiyLHKSmInMQCHch/w
	 Nfb4HgIZ6RUXzs1KnvGIslfDVyAAWksTtegC2z2JK6hlwJxVcwEBsAk26PQd6Wy3xF
	 nnzpACXYwB2tqqTGzdc+NYWac+YPFXHijGO0QGZ93AO2+BIMeFs3uEgfo2M8BJM4We
	 EVhehiRSvzg2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 619/715] xhci: make isoc_bei_interval variable interrupter specific.
Date: Sun, 24 Mar 2024 18:33:18 -0400
Message-ID: <20240324223455.1342824-620-sashal@kernel.org>
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

[ Upstream commit becbd202af8425e336b1c25e9254616a5c03d819 ]

isoc_bei_interval is used to balance how often completed isochronous
events cause interrupts. If interval is too large then the event ring
may fill up before the completed isoc TRBs are handled.

isoc_bei_interval is tuned based on how full the event ring is.

isoc_bei_interval variable needs to be per interrupter as
with several interrupters each one has its own event ring.

move isoc_bei_interval variable to the interrupter structure.

if a secondary interrupter does not care about this feature then
keep isoc_bei_interval 0.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
Link: https://lore.kernel.org/r/20240217001017.29969-4-quic_wcheng@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: e30e9ad9ed66 ("xhci: update event ring dequeue pointer position to controller correctly")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-mem.c  |  2 +-
 drivers/usb/host/xhci-ring.c | 15 +++++++++------
 drivers/usb/host/xhci.h      |  2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index a7716202a8dd5..450adaca68eeb 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2533,7 +2533,7 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	if (xhci_add_interrupter(xhci, ir, 0))
 		goto fail;
 
-	xhci->isoc_bei_interval = AVOID_BEI_INTERVAL_MAX;
+	ir->isoc_bei_interval = AVOID_BEI_INTERVAL_MAX;
 
 	/*
 	 * XXX: Might need to set the Interrupter Moderation Register to
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index b1ca3c9e5a75f..53852383d6143 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3159,8 +3159,8 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 		event_ring_deq = ir->event_ring->dequeue;
 
 		/* ring is half-full, force isoc trbs to interrupt more often */
-		if (xhci->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
-			xhci->isoc_bei_interval = xhci->isoc_bei_interval / 2;
+		if (ir->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
+			ir->isoc_bei_interval = ir->isoc_bei_interval / 2;
 
 		event_loop = 0;
 	}
@@ -4028,7 +4028,8 @@ static int xhci_get_isoc_frame_id(struct xhci_hcd *xhci,
 }
 
 /* Check if we should generate event interrupt for a TD in an isoc URB */
-static bool trb_block_event_intr(struct xhci_hcd *xhci, int num_tds, int i)
+static bool trb_block_event_intr(struct xhci_hcd *xhci, int num_tds, int i,
+				 struct xhci_interrupter *ir)
 {
 	if (xhci->hci_version < 0x100)
 		return false;
@@ -4039,8 +4040,8 @@ static bool trb_block_event_intr(struct xhci_hcd *xhci, int num_tds, int i)
 	 * If AVOID_BEI is set the host handles full event rings poorly,
 	 * generate an event at least every 8th TD to clear the event ring
 	 */
-	if (i && xhci->quirks & XHCI_AVOID_BEI)
-		return !!(i % xhci->isoc_bei_interval);
+	if (i && ir->isoc_bei_interval && xhci->quirks & XHCI_AVOID_BEI)
+		return !!(i % ir->isoc_bei_interval);
 
 	return true;
 }
@@ -4049,6 +4050,7 @@ static bool trb_block_event_intr(struct xhci_hcd *xhci, int num_tds, int i)
 static int xhci_queue_isoc_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 		struct urb *urb, int slot_id, unsigned int ep_index)
 {
+	struct xhci_interrupter *ir;
 	struct xhci_ring *ep_ring;
 	struct urb_priv *urb_priv;
 	struct xhci_td *td;
@@ -4066,6 +4068,7 @@ static int xhci_queue_isoc_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 
 	xep = &xhci->devs[slot_id]->eps[ep_index];
 	ep_ring = xhci->devs[slot_id]->eps[ep_index].ring;
+	ir = xhci->interrupters[0];
 
 	num_tds = urb->number_of_packets;
 	if (num_tds < 1) {
@@ -4153,7 +4156,7 @@ static int xhci_queue_isoc_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 				td->last_trb = ep_ring->enqueue;
 				td->last_trb_seg = ep_ring->enq_seg;
 				field |= TRB_IOC;
-				if (trb_block_event_intr(xhci, num_tds, i))
+				if (trb_block_event_intr(xhci, num_tds, i, ir))
 					field |= TRB_BEI;
 			}
 			/* Calculate TRB length */
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 9e05ccdd36b2b..bf05103aa68a0 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1689,6 +1689,7 @@ struct xhci_interrupter {
 	struct xhci_intr_reg __iomem *ir_set;
 	unsigned int		intr_num;
 	bool			ip_autoclear;
+	u32			isoc_bei_interval;
 	/* For interrupter registers save and restore over suspend/resume */
 	u32	s3_irq_pending;
 	u32	s3_irq_control;
@@ -1761,7 +1762,6 @@ struct xhci_hcd {
 	u8		isoc_threshold;
 	/* imod_interval in ns (I * 250ns) */
 	u32		imod_interval;
-	u32		isoc_bei_interval;
 	int		event_ring_max;
 	/* 4KB min, 128MB max */
 	int		page_size;
-- 
2.43.0



Return-Path: <linux-kernel+bounces-113512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646E08884EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953371C24334
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2BA13D883;
	Sun, 24 Mar 2024 22:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbwxvfRk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA31E1BBFEE;
	Sun, 24 Mar 2024 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320313; cv=none; b=pxhuQRLrbn+J1LRI7pbBZMJapH8TPWQ3aCMjnHZuP2FEa1+NfwFV7vDevNigenAEXrZkA2uG0nxEwgX2GkAZLAuv67/paLgZHpG41WFvXNlHdtIvn96cja6p6aIHt/Gg4oKuOJ79W42iD+UrwkZQpWz8YQ5jrYksSm42zEgCurA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320313; c=relaxed/simple;
	bh=b7pmiGPTXivY91/8QGsotvLKGxTURsI1N8VH15JtETc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrbtJqKzFEV6wBq4ymX9BbORLSZ7ruJs5YUdxTlL9Lzr54NCgDC2xVaR66TlgC/o+JhSbf5pkzVE6bRrEael3xSEPjWZNL4Yg7qP0l/bFRskJWz0kWfnP2MAUce/NG1zILcQlQ/5rDgHMMAFLC0iwafHKWn4Qe/pp/py3GaV7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbwxvfRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE81C433F1;
	Sun, 24 Mar 2024 22:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320313;
	bh=b7pmiGPTXivY91/8QGsotvLKGxTURsI1N8VH15JtETc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UbwxvfRkVGJeYkgPW7OVJaU9/LyAKEKmtQkH1x9JrFsmDvbKTsqCEn2jJ+ULcWFOz
	 sl0KbaoD0Pkks3kVoFx09n4i/GBnaFsf5+7w9dzX3EEnk9RW7GQ5CGVdeQEeawOXsL
	 MJAN6HBOYEcBgRboZ7UFtQV/Z31XUO1gNUCiHzGEmn+POiuu8o3neRIPfNxdLU6/pf
	 pPInypKYuXqp3FKPMqRcSrd1bJJRFArWlU2II8Bg8L8J6m+ZF9D767K2M6u8gzOWL1
	 GA6+vqztwP/XdBF0sZYU0TQEvnR++Xfsmle7coNnh9bQ2+Z/V7MZEvlm4LJJ3Gex9N
	 /AJ9ZNDJ1mMxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 621/715] xhci: update event ring dequeue pointer position to controller correctly
Date: Sun, 24 Mar 2024 18:33:20 -0400
Message-ID: <20240324223455.1342824-622-sashal@kernel.org>
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

[ Upstream commit e30e9ad9ed66c049f32ab2ffe38f0b576bebdd2c ]

The event ring dequeue pointer field (ERDP) in xHC hardware is used to
inform controller how far the driver has processed events on the event
ring.

In the case all events are handled and event ring is empty then the
address of the TRB after the last processed one should be written.
This TRB is both the enqueue and dequeue pointer.

But in case we are writing the ERDP in the middle of processing
several events then ERDP field should be written with the "up to and
including" address of the last handled event TRB.

Currenly each ERDP write by driver is done as if all events are handled
and ring is empty.

Fix this by adjusting the order when software dequeue "inc_deq()"
is called and hardware dequeue "xhci_update_erst_dequeue()" is updated.

Details in xhci 1.2 specification section 4.9.4:

"System software shall write the Event Ring Dequeue Pointer (ERDP)
 register to inform the xHC that it has completed the processing of Event
 TRBs up to and including the Event TRB referenced by the ERDP.

 The detection of a Cycle bit mismatch in an Event TRB processed by
 software indicates the location of the xHC Event Ring Enqueue Pointer
 and that the Event Ring is empty. Software shall write the ERDP with
 the address of this TRB to indicate that it has processed all Events
 in the ring"

This change depends on fixes made to relocate inc_deq() calls captured
in the below commits:

  commit 3321f84bfae0 ("xhci: simplify event ring dequeue tracking for
  transfer events")

  commit d1830364e963 ("xhci: Simplify event ring dequeue pointer update
  for port change events")

Fixes: dc0ffbea5729 ("usb: host: xhci: update event ring dequeue pointer on purpose")
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
Link: https://lore.kernel.org/r/20240217001017.29969-6-quic_wcheng@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 129d2e83034c1..61bd29dd71a2f 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3022,9 +3022,6 @@ static int xhci_handle_event(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
 		return 0;
 	}
 
-	/* Update SW event ring dequeue pointer */
-	inc_deq(xhci, ir->event_ring);
-
 	/* Are there more items on the event ring?  Caller will call us again to
 	 * check.
 	 */
@@ -3147,15 +3144,21 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 	 * that clears the EHB.
 	 */
 	while (xhci_handle_event(xhci, ir) > 0) {
-		if (event_loop++ < TRBS_PER_SEGMENT / 2)
-			continue;
-		xhci_update_erst_dequeue(xhci, ir, false);
+		/*
+		 * If half a segment of events have been handled in one go then
+		 * update ERDP, and force isoc trbs to interrupt more often
+		 */
+		if (event_loop++ > TRBS_PER_SEGMENT / 2) {
+			xhci_update_erst_dequeue(xhci, ir, false);
+
+			if (ir->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
+				ir->isoc_bei_interval = ir->isoc_bei_interval / 2;
 
-		/* ring is half-full, force isoc trbs to interrupt more often */
-		if (ir->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
-			ir->isoc_bei_interval = ir->isoc_bei_interval / 2;
+			event_loop = 0;
+		}
 
-		event_loop = 0;
+		/* Update SW event ring dequeue pointer */
+		inc_deq(xhci, ir->event_ring);
 	}
 
 	xhci_update_erst_dequeue(xhci, ir, true);
-- 
2.43.0



Return-Path: <linux-kernel+bounces-113509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE398884E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2BA1F22679
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9104E1BB74F;
	Sun, 24 Mar 2024 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZY4XEri"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80A41BB734;
	Sun, 24 Mar 2024 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320310; cv=none; b=ngmoWajW58pk5ikCSq1dGKv5nLan54CTXJeDXsOdgG37vtSEDLYaZ8wj0oadNuo+vtXieAFVwznrzz8lhUvbJIqP8r2Qp6+63BMNwDXc6mPTRVXr0vvqCm2aTBlR9DXxRY8kJgQg0MCXCfj/Qp35X8+xCDQMdqDPRuDVmOeSlM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320310; c=relaxed/simple;
	bh=RlwBWjENwuv2tAUDibTGQsGuPDVYxRvmhJSUI8qUEXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pp9F/prxoL4ZayHJtx9q3mpB/cLv+yEzC7oCt7eqFXI3qeqBM7EVFzeNlBVFs49fS5q75yRo5B45cUuRJhZsZag30S8rkOOWNPiVj/McN/xNkCr/GqZJGl6nZHWhcYU+001QRr36cEWgYUMf2FYuMuseEFHA8A++FWB2W8GlHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZY4XEri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AE0C433B1;
	Sun, 24 Mar 2024 22:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320310;
	bh=RlwBWjENwuv2tAUDibTGQsGuPDVYxRvmhJSUI8qUEXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kZY4XEri3/aAGrxn8sObunyU+cKw6rM9Dh59U/a+5P3RvIeJmHi05obC98ATDjRy2
	 6AAYn6UaGuQnW7G/GhH4O2nLZ0pa4PSltaZxddsBm5r9xW2MhuecacH3Ffky32Fl2+
	 SG4YCJ4Gz481Ca0Xg0/J4Sr10kfVXpN16dk0Rm/5C1UVybI+y2zMui+sxYbGL/4aa/
	 oF82R55OMMpfEW7rhaQVqvz0wVTbcq/4j7nwfjVppFJBk1WwkB9SfHJ7s9Xk1uYG9p
	 8dEaVgvsMMLpw2FPralkoNBnH0C3uqxTmXg+ijSHfPJwNk1IETzgeCbe+HJcjrHLfY
	 IEV4tpR9Zxp/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 618/715] xhci: Add interrupt pending autoclear flag to each interrupter
Date: Sun, 24 Mar 2024 18:33:17 -0400
Message-ID: <20240324223455.1342824-619-sashal@kernel.org>
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

[ Upstream commit 4f022aad80dc8b175e309197720f4fca8004fb2e ]

Each interrupter has an interrupt pending (IP) bit that should be cleared
in the interrupt handler. This is done automatically for systems using
MSI/MSI-X interrupts.

Secondary interrupters used by audio offload may not actually trigger
MSI/MSI-X messages, so driver may need to clear the IP bit manually for
these, even if the primary interrupter IP is cleared automatically.

Add an ip_autoclear flag to each interrupter that driver can configure
when requesting an interrupt for that xHC interrupter, and move
the interrupt pending clearing code to its own helper function.
Use this ip_autoclear flag instead of the current hcd->msi_enabled
to check if IP flag is cleared by software.

[Moved ip_autoclear into xhci and set based on msi_enabled -wcheng]

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
Link: https://lore.kernel.org/r/20240217001017.29969-2-quic_wcheng@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: e30e9ad9ed66 ("xhci: update event ring dequeue pointer position to controller correctly")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 21 +++++++++++++++------
 drivers/usb/host/xhci.c      |  3 +++
 drivers/usb/host/xhci.h      |  1 +
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 4f64b814d4aa2..b1ca3c9e5a75f 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3069,6 +3069,19 @@ static void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
 	xhci_write_64(xhci, temp_64, &ir->ir_set->erst_dequeue);
 }
 
+/* Clear the interrupt pending bit for a specific interrupter. */
+static void xhci_clear_interrupt_pending(struct xhci_hcd *xhci,
+					 struct xhci_interrupter *ir)
+{
+	if (!ir->ip_autoclear) {
+		u32 irq_pending;
+
+		irq_pending = readl(&ir->ir_set->irq_pending);
+		irq_pending |= IMAN_IP;
+		writel(irq_pending, &ir->ir_set->irq_pending);
+	}
+}
+
 /*
  * xHCI spec says we can get an interrupt, and if the HC has an error condition,
  * we might get bad data out of the event ring.  Section 4.10.2.7 has a list of
@@ -3118,12 +3131,8 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 
 	/* This is the handler of the primary interrupter */
 	ir = xhci->interrupters[0];
-	if (!hcd->msi_enabled) {
-		u32 irq_pending;
-		irq_pending = readl(&ir->ir_set->irq_pending);
-		irq_pending |= IMAN_IP;
-		writel(irq_pending, &ir->ir_set->irq_pending);
-	}
+
+	xhci_clear_interrupt_pending(xhci, ir);
 
 	if (xhci->xhc_state & XHCI_STATE_DYING ||
 	    xhci->xhc_state & XHCI_STATE_HALTED) {
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index c057c42c36f4c..0886829d53e51 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -538,6 +538,9 @@ int xhci_run(struct usb_hcd *hcd)
 	 */
 
 	hcd->uses_new_polling = 1;
+	if (hcd->msi_enabled)
+		ir->ip_autoclear = true;
+
 	if (!usb_hcd_is_primary_hcd(hcd))
 		return xhci_run_finished(xhci);
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 6f82d404883f9..9e05ccdd36b2b 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1688,6 +1688,7 @@ struct xhci_interrupter {
 	struct xhci_erst	erst;
 	struct xhci_intr_reg __iomem *ir_set;
 	unsigned int		intr_num;
+	bool			ip_autoclear;
 	/* For interrupter registers save and restore over suspend/resume */
 	u32	s3_irq_pending;
 	u32	s3_irq_control;
-- 
2.43.0



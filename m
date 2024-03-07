Return-Path: <linux-kernel+bounces-95810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE4287530E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA141C24BA3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7378112FB3D;
	Thu,  7 Mar 2024 15:22:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE0312F374
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824950; cv=none; b=p/Ep089/L4/STN3tXeTTV981WnKpvnMUsZykwImV9Ik7TU42qC8Y8HC6lWqk98Tl1t16P6tI8HqUsiLSZgpXe6xt+hLL6ZyX/3HQfCP0BWZgqO8gcxhjYMkOyrwtdHkr+bKlA/XVfXO5apRTDAyOD+Zu7l5wK6WEvkEQqHFallA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824950; c=relaxed/simple;
	bh=y5PPyv47vwajakI0WCCzwWI0+5CKdDwYJF4dLuKJReo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=InHQEy76mj4M1g0iPxjD9FP3xe7tTgLfXqwK9JaY1jA9iKBBKCLVuC+s3Ljs6Y6jiqgW7EtuLv42EpxZzWQB7Fe2tiesp3Pum0rj7mPAEmFN3aU9pa+um9xhfIiljMGllcGAZsTtPMzqd2aTA0eSDdYao1ReUyhr2xKQu75fs3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1riFZd-0007ML-5V; Thu, 07 Mar 2024 16:22:21 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1riFZb-004y6h-QD; Thu, 07 Mar 2024 16:22:19 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1riFZb-0029BI-2R;
	Thu, 07 Mar 2024 16:22:19 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 07 Mar 2024 16:22:03 +0100
Subject: [PATCH 1/3] usb: dwc3: gadget: reclaim the whole started list when
 request was missed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-dwc3-gadget-complete-irq-v1-1-4fe9ac0ba2b7@pengutronix.de>
References: <20240307-dwc3-gadget-complete-irq-v1-0-4fe9ac0ba2b7@pengutronix.de>
In-Reply-To: <20240307-dwc3-gadget-complete-irq-v1-0-4fe9ac0ba2b7@pengutronix.de>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2318;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=y5PPyv47vwajakI0WCCzwWI0+5CKdDwYJF4dLuKJReo=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBl6duq3zOdIbp0K9WhuFx01AOQ4JwAkYlDIamtp
 OB6ObNC54eJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZenbqgAKCRC/aVhE+XH0
 q8oFD/9+mQ6z0hwSyuHxcNOp6QcLDz8wHB44r/R5uJW485dramOromUtXGAQfi9OXN/T57c5pfr
 G0mPqQbMu3MOY3oyan3YYoxry5IkRUTE9TWyUxZn+m2mtBVcDCLxWbyjWTqWKZNILkHro0DzEBf
 OjIwhv7+RrDQYnn7tehjH2tCpcBhNkW76TKely9/WpYEnMA1WokOX9VdqeHbOwOkIXX2YWxtKCn
 bLItFf3n5ZNa9YwQLwelQ1GfWOOW/NcQG7V37IBlQLcYivMFBMwZKhcD3Pm+QM6qH47DGcT1qw4
 6OsLEeOCKIAMYDpHnefAZ2dBJI4TbZ/BhmB3/XTU5D93v7ZMzYtVfUMMPnPhPXPY1xHape7hG/M
 PzRxwgrVfSSmM1SrTEmzQHGDgNE8n5RB9Qjt5QYHJD50fR15NcjlyDBj4FrzvpHqMfQwGxf9awC
 KpYDOSFOxOxbN7aJAjOHTywwhpx/8z4qPUC+08D1CxSt72wWRv8S8T64m/oAqfCm+6MC9CnFIiw
 0fkg1uTGg6ep0nKl8fwGjsV60s121BRL14LRDawTR8BdtOc8fj5ko2U1govmgCGJXSUUie7uk/k
 Z3xwqM3mfssadEPHAqA9MgS3LsSiQ5wRar6LgAl08bRSitIym3U7HvOD/0eTfxlBtDPa93v6qU7
 m7RRKDMBdRx1uUA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On EXDEV/Missed status interrupt, the handler has to stop the running
transfer and ensure that every request complete call will not run kick
on the current transfer. This is achieved by calling
dwc3_stop_active_transfer early before cleaning up the started request
list.

If the current transfer was stopped we can not keep all requests in the
hardware and have to reclaim them all. Since the requests could have
no_interrupt bit the cleanup on an stopped pipeline has to remove every
request and may not stop on the one that has the IOC bit set.

To ensure that the dwc3_gadget_ep_cleanup_completed_request will
iterate over every request in that case, we skip the stop condition
in reclaim_completed_trb if the current transfer was stopped by checking
for DWC3_EP_END_TRANSFER_PENDING bit set.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/dwc3/gadget.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 40c52dbc28d3b..b9fce7b1dcdec 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3404,7 +3404,8 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	    DWC3_TRB_SIZE_TRBSTS(trb->size) == DWC3_TRBSTS_MISSED_ISOC)
 		return 1;
 
-	if ((trb->ctrl & DWC3_TRB_CTRL_IOC) ||
+	if (((trb->ctrl & DWC3_TRB_CTRL_IOC) &&
+		 !(dep->flags & DWC3_EP_END_TRANSFER_PENDING)) ||
 	    (trb->ctrl & DWC3_TRB_CTRL_LST))
 		return 1;
 
@@ -3568,6 +3569,9 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 	struct dwc3		*dwc = dep->dwc;
 	bool			no_started_trb = true;
 
+	if (status == -EXDEV)
+		dwc3_stop_active_transfer(dep, true, true);
+
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
 	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
@@ -3578,7 +3582,7 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
 		list_empty(&dep->started_list) &&
-		(list_empty(&dep->pending_list) || status == -EXDEV))
+		(list_empty(&dep->pending_list)))
 		dwc3_stop_active_transfer(dep, true, true);
 	else if (dwc3_gadget_ep_should_continue(dep))
 		if (__dwc3_gadget_kick_transfer(dep) == 0)

-- 
2.39.2



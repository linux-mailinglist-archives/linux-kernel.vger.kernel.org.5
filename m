Return-Path: <linux-kernel+bounces-128750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3D3895EF4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09DF0284F43
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A5315E80C;
	Tue,  2 Apr 2024 21:51:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C0015E215
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094719; cv=none; b=gOK25GlC5Eus8EZ7i1938QPN5rcR+WGwkQ2YffujQa+xQL84HGtcyzZbnv5mw03JFoSHVXR6U6O4hpS3ZuLjDclnpFobjFziFkf4KerJ9S+OVU/skCfY8EnHy1hd+3Rtwa88EGn63f/ALrPu78fe4uvYQqUIZfnsbqvDG67CBMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094719; c=relaxed/simple;
	bh=GJekezZDtgCEvDeDtRZqLACpKI5JpZybjW4NWiVqyDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oTVlcEXttOfU/WSbF/shtzfRibsjiVO7igAFaSCB7S8NXETHg9dxD9GONodMaHJnGLuk3i8B0d/BUjunAbT5vqXUDJ/vZRtr82E0zDfFUdUUGb3OXk7jgYc4+0L7Ac6ETxHt4aBf1QSg+v8mM2TahNQNYEd++hQ4IeTbpc8Gwmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rrm2r-0000zx-4z; Tue, 02 Apr 2024 23:51:53 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rrm2p-00A3YA-HR; Tue, 02 Apr 2024 23:51:51 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rrm2p-007wHT-1Y;
	Tue, 02 Apr 2024 23:51:51 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 02 Apr 2024 23:51:49 +0200
Subject: [PATCH v2] usb: dwc3: gadget: check drained isoc ep
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-dwc3-gadget-complete-irq-v2-1-8c5e9b35f7b9@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAPR9DGYC/42NQQ6DIBREr2JY9zeIJrZd9R6Niw98kMSCBbQ2x
 ruXeoIu32Rm3sYSRUeJ3aqNRVpccsEXEKeKqQG9JXC6MBNctLzhHei3asCitpRBhec0Ui6d+II
 aL8Zg03ZG16zMJSYCGdGroRz4eRxLOEUybj18j77w4FIO8XPol/qX/mFaauDQGrqi4hKF7O4Te
 TvnGLxbz5pYv+/7F57TXaPaAAAA
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2553;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=GJekezZDtgCEvDeDtRZqLACpKI5JpZybjW4NWiVqyDo=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmDH33hQZUD5UIVhMspw3/9bywzxBfG63O32KHY
 O4ssVULc9CJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZgx99wAKCRC/aVhE+XH0
 qxK3EAC3RWWNm716U2+StddrkQhnyoQMcMDScnBXr2H1GROnO5PDXDRsTa29ACJTQ7McI8JTG9D
 9X2+9mV7biOoiSl7A9Jg8OeRZn5PCcbSuZY4wYO3FhvX6J+rTHAwkmpcHIc/emwIhEzezh6kbUc
 l/D8tvJOPJkVt5AzUztcqE8YiAVdsFc91gQ1/vQY6BAWjhxQRa1to3D492IPtq8puAKJDQy8E+L
 Z/MANplf0F0ivhHG/2lY0X/pwrnC1OsneTt0CwSNBHu6OSqE8SbnPgmjHY2WZICPN+TTLz6e6wx
 IMBNV4qndkGDbt3UU3PCzMRMxXYyLEBgXeykCDG0sWttsFVcdWgOTt+DmzgrKUdDaf4/+CXwMhU
 vwYzotgaUExBuwmcMQUG4kyL6LJ8KJ2AKAXc9FSi00g3VlTqE1+nyve1yppjmAU7fzFmpS6jeoI
 AWZ5ugQpP9V9w18ZBMpe502uHMakt4pHGLCk4Wa7fryBGkU1gO0+CIiNRhMP6lVq4eChEa1zw3M
 3in/5MOvVqItwBqeOArWQgwwHYpb4akPNAMcKkRQAN3DLqhB5Q3HpJXRGDcQqI6r2blWhAPgw09
 mmny9U5j5aN4GQKXrrul5qkPnLwayxA9UK9gZqvEmIlU0ctTJ33waPIgs7WJ62t+4sqdSvfOV9B
 X2rurwSimd1t1CA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

To avoid a potential underrun of an currently drained transfer
we add a check for that scenario in the dwc3_gadget_endpoint_trbs_complete
function. In the case of an empty trb ring, we call the stop_transfer
cmd and avoid the underrun to occur.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Changes in v2:
- dropped patch "usb: dwc3: gadget: reclaim the whole started list when request was missed"
- fixed patch "usb: dwc3: gadget: check drained isoc ep"
- dropped patch "usb: dwc3: gadget: check the whole started queue for missed requests in complete"
- Link to v1: https://lore.kernel.org/r/20240307-dwc3-gadget-complete-irq-v1-0-4fe9ac0ba2b7@pengutronix.de
---
 drivers/usb/dwc3/gadget.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4df2661f66751..3e9c67799259a 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3582,13 +3582,26 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 	if (!dep->endpoint.desc)
 		return no_started_trb;
 
-	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
-		list_empty(&dep->started_list) &&
-		(list_empty(&dep->pending_list) || status == -EXDEV))
-		dwc3_stop_active_transfer(dep, true, true);
-	else if (dwc3_gadget_ep_should_continue(dep))
+	if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+		/* It is possible that the interrupt thread was delayed
+		 * by scheduling in the system, and therefor the HW has
+		 * already run dry. In that case the last trb in the
+		 * queue is already handled by the hw. By checking the
+		 * HWO bit we know to restart the whole transfer. The
+		 * condition to appear is more likely if not every req
+		 * has the IOC bit set and therefor does not trigger the
+		 * interrupt thread frequently.
+		 */
+		struct dwc3_trb *trb = dwc3_ep_prev_trb(dep, dep->trb_enqueue);
+		unsigned int transfer_in_flight = trb->ctrl & DWC3_TRB_CTRL_HWO;
+
+		if ((list_empty(&dep->started_list) || !transfer_in_flight) &&
+		    (list_empty(&dep->pending_list) || status == -EXDEV))
+			dwc3_stop_active_transfer(dep, true, true);
+	} else if (dwc3_gadget_ep_should_continue(dep)) {
 		if (__dwc3_gadget_kick_transfer(dep) == 0)
 			no_started_trb = false;
+	}
 
 out:
 	/*

---
base-commit: 5bab5dc780c9ed0c69fc2f828015532acf4a7848
change-id: 20240307-dwc3-gadget-complete-irq-1a8ffa347fd1

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>



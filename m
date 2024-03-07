Return-Path: <linux-kernel+bounces-95809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC1F87530D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F221F22D70
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1F812FB17;
	Thu,  7 Mar 2024 15:22:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDCA12F373
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824949; cv=none; b=C03yMB+cLXBbvEkdMOhbC9zjvwaik02aTaCCRZ0NI/6EUn+F/IldUeX724Ifc9Z/EUtQrcII2A/JoF6Nk1l/yK2JD348/b1T1WZu32WR1UXsm/oOU+L39aA1NyURJCX6/QFPVz9Jzv24/qtL86b4V2NoahFSCBCZWgQNtUgUfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824949; c=relaxed/simple;
	bh=Ez1QdUV04iD4E6g4vgQsdKZqu2XEGi7/ylSKu6ZB/CU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0DxHELUHSKG9amqeKVtDrUH2IAHKZZRpZFvy+lrOopziM7VKg73fwQ3D9VXuX5AC1zSRR56pryXbboxBlaNEAI46Hb/syo+JB9sIhZm3XPf1qF/RJo3jxOMpc4ZP1XziyGvjb9sdXObCBOKzIaDDjyUel+TtVBVcqvq7Bh0egQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1riFZd-0007MM-5V; Thu, 07 Mar 2024 16:22:21 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1riFZb-004y6j-QV; Thu, 07 Mar 2024 16:22:19 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1riFZb-0029BI-2T;
	Thu, 07 Mar 2024 16:22:19 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 07 Mar 2024 16:22:05 +0100
Subject: [PATCH 3/3] usb: dwc3: gadget: check the whole started queue for
 missed requests in complete
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-dwc3-gadget-complete-irq-v1-3-4fe9ac0ba2b7@pengutronix.de>
References: <20240307-dwc3-gadget-complete-irq-v1-0-4fe9ac0ba2b7@pengutronix.de>
In-Reply-To: <20240307-dwc3-gadget-complete-irq-v1-0-4fe9ac0ba2b7@pengutronix.de>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2246;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=Ez1QdUV04iD4E6g4vgQsdKZqu2XEGi7/ylSKu6ZB/CU=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBl6durU2XZUppWhknO+4hbYmEDglFjpowcKZEIx
 9SflZ9T1ZOJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZenbqwAKCRC/aVhE+XH0
 qzk1EACelLwRYh3AlWHS6eUG1KKpMfBZqocop45UyYKduPTX4vExZsrHqeR8A2VWvjywd0ckrHN
 VtBohqFvhjVQ4Nh9zONDzs4+EQqnHo/ePf+0E3wDl/nvjIxDbfj8s6kwtlAVjaslcUs3ntzOOAJ
 AiNYIEGw/u+pR2abmCu9/GvYFPXbnIIVxkghcQ2YMRXaVAcMEJaBEPT0jzmF6mvyXXR/eFVWPVe
 ic70MG48Q5SCkmBLYhbH42WETbLBNVOUX9V9G5MoQTijI5YVf746+Pj9TLRzgJy/Xsbrs3BfPsB
 U4xjq0RlxDutqioS+nC6yAncjsZoR7Cx83Fl05v5qFSOGXXFv4LUkSxuhQz6OkNd/Zvu2TqKqeV
 I4iw2PExnGbqzbDgmtg9cGxBk2Lx6Mra4xTK6Tz4Md5j+XkhVaqm+Mdu6eXjp7fIdeABSpF10Y1
 ZZTNvgBShfytRcmeFJ/cWvapOW2Zx/c4bQEpaJfQ/edKc/6OGl+ut6Unlyvq+qyNykcbz4oET+P
 DxWed70G/7DapkPEA67fQ4xmb6/mguKK6VXjD3scLV4TbJgGxb39klLcnG3xLBgDF1NW/WCSDhf
 uTvLsJr9BNmDfhIl9SEMDHHS1pfb7Kv83yDkBXyaK9N6C3YoxPJmjc+aJN9Xfgq0MF7C2XXnBjT
 +IVLY1I1lA6DIXQ==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The function dwc3_gadget_endpoint_trbs_complete will be called with the
interrupt event. This event is only representing the interrupt reason of
the exact trb that had IOC enabled. In the current approach the function
dwc3_gadget_ep_cleanup_completed_requests will give back and complete
the requests with the corresponding trb status and therefor will
correctly return the missed requests that are already finished.

Since inbetween those complete functioncalls of the properly
finished and the missed trbs, a missed transfer could get new
trbs enqueued with the updatecmd, this will just lead to more missed
trbs.

To break the cascading scenario this patch is checking all trbs from the
started list for any trb that has the missed trb status before even
calling the complete handler but stopping the transfer instead.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/dwc3/gadget.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f22b68a0b2dac..ca87f4d988d41 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3563,6 +3563,21 @@ static void dwc3_gadget_endpoint_frame_from_event(struct dwc3_ep *dep,
 	dep->frame_number = event->parameters;
 }
 
+static int dwc3_gadget_ep_check_missed_requests(struct dwc3_ep *dep)
+{
+	struct dwc3_request	*req;
+	struct dwc3_request	*tmp;
+
+	list_for_each_entry_safe(req, tmp, &dep->started_list, list) {
+		struct dwc3_trb *trb = req->trb;
+
+		if (DWC3_TRB_SIZE_TRBSTS(trb->size) == DWC3_TRBSTS_MISSED_ISOC)
+			return -EXDEV;
+	}
+
+	return 0;
+}
+
 static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event, int status)
 {
@@ -3584,7 +3599,7 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 		transfer_in_flight = trb->ctrl & DWC3_TRB_CTRL_HWO;
 	}
 
-	if (status == -EXDEV || !transfer_in_flight)
+	if (status == -EXDEV || !transfer_in_flight || dwc3_gadget_ep_check_missed_requests(dep))
 		dwc3_stop_active_transfer(dep, true, true);
 
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);

-- 
2.39.2



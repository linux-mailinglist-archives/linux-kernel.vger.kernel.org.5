Return-Path: <linux-kernel+bounces-95807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 982AD875309
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DBA28972D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B6112F5A8;
	Thu,  7 Mar 2024 15:22:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD891EEEA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824948; cv=none; b=PKFVsvnM2I8q8f64z+7SlszoTMPXbB5kNiKZuNZr5uK6VtKu9yvHWysKrvWfA5PxVghquzkLpiaSbSlTMboiqKKYLrNIbHUnW8boCFW38NxrF48fCA0CJN+O4HQ8RBoRSDLEiWsKOOGHtiVl6dlTcjB80E1bAXEWam/IH7lBpHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824948; c=relaxed/simple;
	bh=RchjYOpu4op2nA0WUf6YXLOXTpb5ovl/Mszcmr7J9FA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NQ/VkkyoQUfbGhYnsTRKT69TPTsS8DOgzqPkkWSN90RRKqMWQPERoOUyhjroa418P26IkobWTxtgS1cZ/OaFgR23uQITxKDzFoVBCZcKBmnlgCC+Ww3wRmcPKn9z1Oc4ZAr+byq78RVTv21/jpXJyvWeJhoiXF5bmOTKxyawx0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1riFZd-0007MN-5V; Thu, 07 Mar 2024 16:22:21 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1riFZb-004y6i-QR; Thu, 07 Mar 2024 16:22:19 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1riFZb-0029BI-2S;
	Thu, 07 Mar 2024 16:22:19 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 07 Mar 2024 16:22:04 +0100
Subject: [PATCH 2/3] usb: dwc3: gadget: check drained isoc ep
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-dwc3-gadget-complete-irq-v1-2-4fe9ac0ba2b7@pengutronix.de>
References: <20240307-dwc3-gadget-complete-irq-v1-0-4fe9ac0ba2b7@pengutronix.de>
In-Reply-To: <20240307-dwc3-gadget-complete-irq-v1-0-4fe9ac0ba2b7@pengutronix.de>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1656;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=RchjYOpu4op2nA0WUf6YXLOXTpb5ovl/Mszcmr7J9FA=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBl6durknLdj/tkPafi1nYQL17vXUkAmEPBoxHzW
 4PiiL0KpNuJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZenbqwAKCRC/aVhE+XH0
 qzTJEAC4UD1G/DrJazVsiJzLvfJdHjo12eK7GSkPwrRXb7PShdhMFdDXRi2m6s7Q1eFXHzm2vQ1
 /hFSjePhhVnkMS0LBmSL80xpt53k5inHbVIjzLoZnbqxMAY77RhUTjtilsfz0cBX/7XYMV8MYOU
 XC7kQE3X7iMvljdEQO4nodULhuzb97pkBIKHKjtWqShStdA25hjxOmGdxU0Ztjt1F/bAwfxfFW4
 7N7mCuutfCMIjyBR5LD/IqkAVKhxgfo0zkz30Cn3RZAbXs33kjZ7rn5SSEGLwB78ER7aCYPyZi7
 B3p+WiztT3DwAEbNzRG0TsGq0P5kvjVz3z1kW6IqFPLMZ7Se+5fq6ZVX8yTCjFUwoOshwAnloph
 NwHI12FaY4tV61vk92AlZ1J5CSN8jX7UcMPk72zxViVnnxkUMU3x78FbvNAdkKymivHTVykxR0D
 kV53ukseKzuB/osbDGEY+YeZm+5M20z+bsaVuh/NcZgd8Pk8aslddvC5m8KEgobHYuGmaQslc84
 k5B2q7+XYmjQuvCTu9N1/KqqJuGouGLY9pE1lD54i6b4G7yYkpzBo5qzYU31/5pYs5KbmiZGLYO
 T8Bi/tMVUz55LCrhHkM6PBOtMM0IXl2JoM3nS0Cfvl3ZyRrMCbEs2WH/1NOt23UY32+ZE2CnNxm
 nOCUPgrTREomefw==
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
 drivers/usb/dwc3/gadget.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index b9fce7b1dcdec..f22b68a0b2dac 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3568,8 +3568,23 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 {
 	struct dwc3		*dwc = dep->dwc;
 	bool			no_started_trb = true;
+	unsigned int		transfer_in_flight = 0;
+
+	/* It is possible that the interrupt thread was delayed by
+	 * scheduling in the system, and therefor the HW has already
+	 * run dry. In that case the last trb in the queue is already
+	 * handled by the hw. By checking the HWO bit we know to restart
+	 * the whole transfer. The condition to appear is more likely
+	 * if not every req has the IOC bit set and therefor does not
+	 * trigger the interrupt thread frequently.
+	 */
+	if (dep->number && usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+		struct dwc3_trb *trb = dwc3_ep_prev_trb(dep, dep->trb_enqueue);
+
+		transfer_in_flight = trb->ctrl & DWC3_TRB_CTRL_HWO;
+	}
 
-	if (status == -EXDEV)
+	if (status == -EXDEV || !transfer_in_flight)
 		dwc3_stop_active_transfer(dep, true, true);
 
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);

-- 
2.39.2



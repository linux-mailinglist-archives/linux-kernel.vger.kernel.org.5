Return-Path: <linux-kernel+bounces-131112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EA1898336
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55400B25F08
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9960E7172D;
	Thu,  4 Apr 2024 08:35:11 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584D871735
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219711; cv=none; b=fq5zmx5uhEthw3rBCJTc9uwKqbYs2bRiylY8SErb6Ucj5LXL19bTjjUbD+f73xGtMszLQV1u+UMCqprIUhkQbGudtZ6DECVWMRy5BMRFI36UtkEpaC7losY+nKCIzVGvzB3mdiaFF19XljMktZvYgP7/tmn0aptsJFeJwSpfwiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219711; c=relaxed/simple;
	bh=R3WK7lsgcv6hzJeNFgwT/ZIP/4S5DB86hBp3h/+cNz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Dup65vSlJIqz0IKSAyzJsXblTyH6BUYUBwDCp2NdT57WBOXlImI7JpiboMBAXUTgDu8oKbBVjM6epCaxS67nrp//r1e369rhAOByXMX166oQMJf+gVS+ZrgfHocagm0b+IgfgoaUslvwtsFUfnZ5CFlRLdUa+anwk/AHiMwJXZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rsIYo-0004iC-23; Thu, 04 Apr 2024 10:35:02 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rsIYn-00AKmC-KV; Thu, 04 Apr 2024 10:35:01 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rsIYn-00FhvA-1s;
	Thu, 04 Apr 2024 10:35:01 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 04 Apr 2024 10:35:01 +0200
Subject: [PATCH] usb: gadget: function: uvc: set req_size once when the vb2
 queue is calculated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-uvc_request_calc_once-v1-1-fea7fd8f0496@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIADRmDmYC/x2NUQrCQAwFr1Ly7UKtdUWvIrKkaWoDy1YTtwild
 zfI+5oHw2xgrMIGt2YD5VVMluJwPDRAM5YnBxmdoWu7vvWFulJSfle2TyLMlJZCHPByGqdrH+O
 ZI7g7oHEYFAvNbpeas58v5Um+/9j9se8/4OuZ43wAAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3280;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=R3WK7lsgcv6hzJeNFgwT/ZIP/4S5DB86hBp3h/+cNz0=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmDmY1g1F2hyDuU1n1BbR67d4Va4pa9j3iM6z5H
 BJd/VAuV3OJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZg5mNQAKCRC/aVhE+XH0
 q8gSD/99ZVnm/QDxrxfyZxr8Md0yVisuKOOH7aDnIZiLRuuWn1oQ9wHkx1UZeDXkoHgMW9tNfLH
 gTjI/E7aD7ejiUgrsfOyJ9Rf6xAoclXvnYUQm4uQbsSj/gHTPg2Pei/clbBvjhDu7MReU3sX6LO
 lzlS+YwEmjkzna0bkV1pFyrbmE0mA3+PGoJXNuVOg+n8X7fk+NpefJ4qw6gSrhWFNS8PECeiHVz
 APwZ0UHu0ZgsujpELAqg5SUDGM+i34jjoiWWCZVIvoFb0cpkYISauDJY9BAd3grQtL6yUxrXAWr
 xI1htGWQIPXmWumYpnsAC8goWEdZo38I4llYFu4BBwUL8yo0FyK7QnDgGDJfvy1IB6kKTeW7cs7
 wQnLTLUq4viQXQj2dxS7uLpljipXHR36c9Ehqu0vBdlcp8ZPiXMwbraO1FyR083nbDitGWchDsX
 A1TBzRQz8tQk+2ApVK1+gcvyzM7IxFUZPIPZNOEQ72ZSw1dXhoU7ZbluDLgUGu9mRMQDKerjllb
 q1YGt4OA2JN2pQDkqZOCgqySt6+2Pa0rtkVgtnxPqezFRtTaXjQe8mPSmba5frkmNSf62bDhKki
 Sjugang6fKGUZpAO47oPXa3YliQmAw2eORhSy4onVl1AGYd70wdI/huZPeeKFq93Vbyt9WUNxKk
 w2nJ8GmPAfc+O6w==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The uvc gadget driver is calculating the req_size on every
video_enable/alloc_request and is based on the fixed configfs parameters
maxpacket, maxburst and mult.

As those parameters can not be changed once the gadget is started and
the same calculation is done already early on the
vb2_streamon/queue_setup path its save to remove one extra calculation
and reuse the calculation from uvc_queue_setup for the allocation step.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/gadget/function/uvc_queue.c |  2 ++
 drivers/usb/gadget/function/uvc_video.c | 15 ++-------------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index 0aa3d7e1f3cc3..ce51643fc4639 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -63,6 +63,8 @@ static int uvc_queue_setup(struct vb2_queue *vq,
 	 */
 	nreq = DIV_ROUND_UP(DIV_ROUND_UP(sizes[0], 2), req_size);
 	nreq = clamp(nreq, 4U, 64U);
+
+	video->req_size = req_size;
 	video->uvc_num_requests = nreq;
 
 	return 0;
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index d41f5f31dadd5..95bb64e16f3da 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -496,7 +496,6 @@ uvc_video_free_requests(struct uvc_video *video)
 	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
 	INIT_LIST_HEAD(&video->req_ready);
-	video->req_size = 0;
 	return 0;
 }
 
@@ -504,16 +503,9 @@ static int
 uvc_video_alloc_requests(struct uvc_video *video)
 {
 	struct uvc_request *ureq;
-	unsigned int req_size;
 	unsigned int i;
 	int ret = -ENOMEM;
 
-	BUG_ON(video->req_size);
-
-	req_size = video->ep->maxpacket
-		 * max_t(unsigned int, video->ep->maxburst, 1)
-		 * (video->ep->mult);
-
 	for (i = 0; i < video->uvc_num_requests; i++) {
 		ureq = kzalloc(sizeof(struct uvc_request), GFP_KERNEL);
 		if (ureq == NULL)
@@ -523,7 +515,7 @@ uvc_video_alloc_requests(struct uvc_video *video)
 
 		list_add_tail(&ureq->list, &video->ureqs);
 
-		ureq->req_buffer = kmalloc(req_size, GFP_KERNEL);
+		ureq->req_buffer = kmalloc(video->req_size, GFP_KERNEL);
 		if (ureq->req_buffer == NULL)
 			goto error;
 
@@ -541,12 +533,10 @@ uvc_video_alloc_requests(struct uvc_video *video)
 		list_add_tail(&ureq->req->list, &video->req_free);
 		/* req_size/PAGE_SIZE + 1 for overruns and + 1 for header */
 		sg_alloc_table(&ureq->sgt,
-			       DIV_ROUND_UP(req_size - UVCG_REQUEST_HEADER_LEN,
+			       DIV_ROUND_UP(video->req_size - UVCG_REQUEST_HEADER_LEN,
 					    PAGE_SIZE) + 2, GFP_KERNEL);
 	}
 
-	video->req_size = req_size;
-
 	return 0;
 
 error:
@@ -699,7 +689,6 @@ uvcg_video_disable(struct uvc_video *video)
 	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
 	INIT_LIST_HEAD(&video->req_ready);
-	video->req_size = 0;
 	spin_unlock_irqrestore(&video->req_lock, flags);
 
 	/*

---
base-commit: 5bab5dc780c9ed0c69fc2f828015532acf4a7848
change-id: 20240404-uvc_request_calc_once-a73df94665e6

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>



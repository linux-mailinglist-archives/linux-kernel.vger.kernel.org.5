Return-Path: <linux-kernel+bounces-137640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1A889E4E6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEBE1C212D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D5C158D83;
	Tue,  9 Apr 2024 21:25:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2EA156F40
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712697906; cv=none; b=ejbXxHJD20cLWbL4N8Kik5zi7HBW0kTtDHdGXYIh08mnW0P1NCX61X7tZ8zVrMVcVTe25NFBBCnBq/8104hkaBWQZVtOuZIbjwW1oCYE2m2IAQpsyoNUxceUXvAua+ZbDvNvwELHE+9zk412Nc2dEoqBp1avHY5Jo9XUNg+ngqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712697906; c=relaxed/simple;
	bh=2S0XiBQEhafQJvyQNhvCXNW0prPzuhGVKt39M7Kdgt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCEGelT7gd8NU9h5BhNU+l3ys3hK99FAM2XePJtDITkD8Q37pheWrtLLBlHyRryc3DeQjbCKkgtvUmxhPNgoDhVMvKIvKtxC5vzunzYrx0xhjjMjoM8Hqf5GHLv30TCD1XrqH0FGnTec039pe9O+CrIIbQTeSDUvfSb0iVhNvHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ruIxf-00081Z-FR; Tue, 09 Apr 2024 23:24:59 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ruIxe-00BNAe-Ql; Tue, 09 Apr 2024 23:24:58 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ruIxe-00FQKu-2S;
	Tue, 09 Apr 2024 23:24:58 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 09 Apr 2024 23:24:57 +0200
Subject: [PATCH 1/3] usb: gadget: function: uvc: set req_size once when the
 vb2 queue is calculated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v1-1-9436c4716233@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v1-0-9436c4716233@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v1-0-9436c4716233@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3217;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=2S0XiBQEhafQJvyQNhvCXNW0prPzuhGVKt39M7Kdgt8=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmFbIpOc5dtFS8oO3jYgMNeAwhpXTaXzy+azwUR
 0LEiPF+Ip+JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZhWyKQAKCRC/aVhE+XH0
 q34aEACSSxF5mlMrKFC0Mz4nzFDFlYAVM6+IaAJ32qK+4JnAwjE70xb/gK4nV8XIKOVDtqJxQzW
 vY71kj+3DFa7l1++eaBv6mj29MEsyPwQo4+QicvGNeZ2EbfYrbGFo4Gk97XafiH8Mj052G3zjhl
 O7Gc5f/hZLcYvXME6T/Pp7tattQtwEUyXdRUMghzx+cxzV+1F4+MrunGi4uSsItNLXS+SyjKdk/
 0AQ7LLwsY5VsH8RhVoU5abOuIkO5YfS6rWx7nMk/kivqQzQYUOQqNY96qBwv8sBV4Eg3mpv9Ecq
 TRpxYI4y70iQJDDsr16vR81baiLreRRdhB+4z1Pw8W+/p/D/oq6P7YorWkINy7CPm6BSXNVGxUa
 JojR1SAs7haxChThgtUpVeHa0cf5gJ1RuQdB+NdLA/KwSE7jeR0ul9t+4Yb8rbWDZZ4rvQB34GS
 SBnakJiM/v8W2IompOADngh748KUok4jxsaLbDGKL0Ruz3ExVFelQ0eowWZqJocIjJk7iE88XFH
 CmPlWTef4Q5XHOqXrNsp7zTkre/TFdBVlAI+cmYBF4pcm4mSIPUX01ELVlrtoyPcFU7qAZPRTEI
 gYzP2qFpbwpWE7N6Wgz0cvd/4ihedOt+ri+yEWE5ntyvQYqWMqMZIrifsNxK9Fq0tv+fi0OYI9b
 WoYiLKSCsIv5HFg==
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
Link to v1: https://lore.kernel.org/r/20240404-uvc_request_calc_once-v1-1-fea7fd8f0496@pengutronix.de
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

-- 
2.39.2



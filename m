Return-Path: <linux-kernel+bounces-64541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97301854017
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F25028FCB6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B51C63064;
	Tue, 13 Feb 2024 23:28:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E758363101
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866905; cv=none; b=IIOllSbt7gwsDJT3rDiz50HxNV2R7tkMMc6MCfG8v/4FxpWGib4Hw4rLKiHMgDUpcUssClq7HHheKkKoS3bvm6UBPYbL+H6x2QXxGiXJpaNUZensQbYRNFqokPIEpd2v6Qp8tG+dLDHII1drsbCnAMa8lelSRpDxgcL7Ylzm/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866905; c=relaxed/simple;
	bh=IQ3Y/e/zPuJO66WvMrusL0LrQcoWvCq272yYuoXcg8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SnUq4at8De0kbww9/Ghi9c30r3D48iVo5DfeROrDuYdioSVEgDm2+Q0Ic7B59pqBn5mjFcZGZg+8N94nlbpTHED0NbGZ9j6Bi1Jo5leM6MxCGyZ63+jDgUADajV92Ve6SpVNyYpKaT1+je8eGUD2Ekt8LgTcGD4zn0TJu3qxkR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2CI-0000eU-Ih; Wed, 14 Feb 2024 00:28:18 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2CH-000Zcq-V8; Wed, 14 Feb 2024 00:28:17 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2CH-002uYW-2u;
	Wed, 14 Feb 2024 00:28:17 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Wed, 14 Feb 2024 00:28:02 +0100
Subject: [PATCH 3/3] usb: gadget: uvc: rework complete handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-uvc-gadget-cleanup-v1-3-de6d78780459@pengutronix.de>
References: <20240214-uvc-gadget-cleanup-v1-0-de6d78780459@pengutronix.de>
In-Reply-To: <20240214-uvc-gadget-cleanup-v1-0-de6d78780459@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5140;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=IQ3Y/e/zPuJO66WvMrusL0LrQcoWvCq272yYuoXcg8I=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBly/sRqPjQgnXhsPN6K1krJXPbN4oO0gMIjSHDh
 ODyESfaFlCJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZcv7EQAKCRC/aVhE+XH0
 q/CaEACMk8xx1roCJwuAZ81Qtu6o3wB2rl5GyAJ4TGAKUYLFtMwIMvqir785IWJBD5ddVQqosrW
 9AmHSNjTDXGpvYDLg5QjBwffQ/49LmMYf+Mrlsk/In1oRHlnFCIdN9geB4tFvClyzHf0H315nQa
 SjCyO62cqg/XRccWR+iJTyiD76bvAxHhWQDYr/UAWy4uei2gM48q2qYK4V3fVtMsfGqpihMBkjM
 VL+aOLY7UEPz3AG2l2CtdKF3/BrVROox+N3BMnuREWleGZua1UXL0YAuHoxwW66GVZbBYWSlbJr
 JsjkX4cnVOFb5bIdQZP1ljgCss2dFsYoI/QAv+gbWDLCRIfKKRNGE+uYIJ7D7eDMt/nmCr1nS6h
 DjjkpfqWil5Hxr6N9L21BBWmPSV6lTG7OAE7tF4+zyvAL802Bj1tbJQFr0lJ48D5dlklKS93+X2
 HGA44nijWDtmAiL43lHs4CDVMMA3juRa4rQazbVo9KsWP3m2PORNs1aktfGlMjZbFbGlhqS77NZ
 imRt0DdYrCsK+dISSMAR+Di2DXMiVsrlsxmAq7UWZw74yo49LkFclNVjGTMaU5zGe6sDAL/QkfA
 kEAgkORQJe3uR9ZdEgblKvQQprgjcFvIhTCOwlP8z8VpbhZ4MAanquiH1+ZCGyXuElIo2xzYhE9
 0y7ceOz4sHl6/gA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

We refactor the complete handler since the return path with the
locking are really difficult to follow. Just simplify the function by
switching the logic return it on an disabled endpoint early. This way
the second level of indentation can be removed.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/gadget/function/uvc_video.c | 95 +++++++++++++++++----------------
 1 file changed, 48 insertions(+), 47 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index b4f3b3c784218..ff7c1fa5c48f3 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -370,6 +370,7 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	struct uvc_video *video = ureq->video;
 	struct uvc_video_queue *queue = &video->queue;
 	struct uvc_buffer *last_buf;
+	struct usb_request *to_queue = req;
 	unsigned long flags;
 	bool is_bulk = video->max_payload_size;
 	int ret = 0;
@@ -425,59 +426,59 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	 * we're still streaming before queueing the usb_request
 	 * back to req_free
 	 */
-	if (video->is_enabled) {
+	if (!video->is_enabled) {
+		uvc_video_free_request(ureq, ep);
+		spin_unlock_irqrestore(&video->req_lock, flags);
+		uvcg_queue_cancel(queue, 0);
+
+		return;
+	}
+
+	/*
+	 * Here we check whether any request is available in the ready
+	 * list. If it is, queue it to the ep and add the current
+	 * usb_request to the req_free list - for video_pump to fill in.
+	 * Otherwise, just use the current usb_request to queue a 0
+	 * length request to the ep. Since we always add to the req_free
+	 * list if we dequeue from the ready list, there will never
+	 * be a situation where the req_free list is completely out of
+	 * requests and cannot recover.
+	 */
+	to_queue->length = 0;
+	if (!list_empty(&video->req_ready)) {
+		to_queue = list_first_entry(&video->req_ready,
+			struct usb_request, list);
+		list_del(&to_queue->list);
+		list_add_tail(&req->list, &video->req_free);
 		/*
-		 * Here we check whether any request is available in the ready
-		 * list. If it is, queue it to the ep and add the current
-		 * usb_request to the req_free list - for video_pump to fill in.
-		 * Otherwise, just use the current usb_request to queue a 0
-		 * length request to the ep. Since we always add to the req_free
-		 * list if we dequeue from the ready list, there will never
-		 * be a situation where the req_free list is completely out of
-		 * requests and cannot recover.
+		 * Queue work to the wq as well since it is possible that a
+		 * buffer may not have been completely encoded with the set of
+		 * in-flight usb requests for whih the complete callbacks are
+		 * firing.
+		 * In that case, if we do not queue work to the worker thread,
+		 * the buffer will never be marked as complete - and therefore
+		 * not be returned to userpsace. As a result,
+		 * dequeue -> queue -> dequeue flow of uvc buffers will not
+		 * happen.
 		 */
-		struct usb_request *to_queue = req;
-
-		to_queue->length = 0;
-		if (!list_empty(&video->req_ready)) {
-			to_queue = list_first_entry(&video->req_ready,
-				struct usb_request, list);
-			list_del(&to_queue->list);
-			list_add_tail(&req->list, &video->req_free);
-			/*
-			 * Queue work to the wq as well since it is possible that a
-			 * buffer may not have been completely encoded with the set of
-			 * in-flight usb requests for whih the complete callbacks are
-			 * firing.
-			 * In that case, if we do not queue work to the worker thread,
-			 * the buffer will never be marked as complete - and therefore
-			 * not be returned to userpsace. As a result,
-			 * dequeue -> queue -> dequeue flow of uvc buffers will not
-			 * happen.
-			 */
-			queue_work(video->async_wq, &video->pump);
-		}
+		queue_work(video->async_wq, &video->pump);
+	}
+	/*
+	 * Queue to the endpoint. The actual queueing to ep will
+	 * only happen on one thread - the async_wq for bulk endpoints
+	 * and this thread for isoc endpoints.
+	 */
+	ret = uvcg_video_usb_req_queue(video, to_queue, !is_bulk);
+	if (ret < 0) {
 		/*
-		 * Queue to the endpoint. The actual queueing to ep will
-		 * only happen on one thread - the async_wq for bulk endpoints
-		 * and this thread for isoc endpoints.
+		 * Endpoint error, but the stream is still enabled.
+		 * Put request back in req_free for it to be cleaned
+		 * up later.
 		 */
-		ret = uvcg_video_usb_req_queue(video, to_queue, !is_bulk);
-		if (ret < 0) {
-			/*
-			 * Endpoint error, but the stream is still enabled.
-			 * Put request back in req_free for it to be cleaned
-			 * up later.
-			 */
-			list_add_tail(&to_queue->list, &video->req_free);
-		}
-	} else {
-		uvc_video_free_request(ureq, ep);
-		ret = 0;
+		list_add_tail(&to_queue->list, &video->req_free);
 	}
+
 	spin_unlock_irqrestore(&video->req_lock, flags);
-	if (ret < 0)
-		uvcg_queue_cancel(queue, 0);
 }
 
 static int

-- 
2.39.2



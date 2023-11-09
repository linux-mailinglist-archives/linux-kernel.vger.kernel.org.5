Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330AF7E620A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 03:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjKICNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 21:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKICNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 21:13:10 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1173F258A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 18:13:08 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2802c0b610dso321487a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 18:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699495987; x=1700100787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQSzchrYmcJybujgPdSEDkeZ+xe2Ft5h1LW+9bLTBDU=;
        b=xfNaEluh4WgO5ma9UxkbYkoY2yHcLmGMicUK6xuKjDMllR5qxZubVoaJ70knvAuKR/
         rrSACw8dSJA3xS4BNX1oobcWmtwUhUBGVgtiNlC0ekOrokpiBLKfgUXg0Pyy9xvXnw2Y
         1kzOo7MWvdu45WLZCjuubgHO4aKMSDLbQ3aZmwbKefdf2SqGnbXnHsD8xAmvTxue1nMc
         W1tDzwTeWL59otN/tVkXyu3Drf3fZ1pHIsIRAXGjh2CmNbsXj2HAVHzH2y2uNLN1waJv
         Rkw3m0a3gY1gucg4Bex21B2ek1kKReMXNjlozHAURQTGeLL1HfqEZ3747bzqxrOIa05M
         1oEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699495987; x=1700100787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQSzchrYmcJybujgPdSEDkeZ+xe2Ft5h1LW+9bLTBDU=;
        b=WAvTHm9RYmZ5jUwlw8dm/9yDLcpcwbrKfBDCAle7OKCyKEfkS0/tHphfxG/lbjbP9c
         UcXC+jkA8AjKXrbBcJPlOxEpsK1cNg3Ke9lGl+DcdwvajpE2KPHkOlw/yeuiUk6PlzdY
         WeW7aAxY2q5IeliAOsh8GZcbP7KmLPFQUYx4G0sBt0Z/VE4lTSQUZ2OP0+Od7st/bXQc
         +8hdtHQL9QxH+9tTlEoAM5A7Ko8VpfXROqoOkNXTLwNKvFxab6J3dPSnvHYO7ETk7yq1
         fkwyTUdCAHTLWmNTP+3GvFXFCXCcanTLjP6ZCWE3koMvFSopYbdigPjym9z8bm4uVs9l
         9DrA==
X-Gm-Message-State: AOJu0YyYzuJPVCYsOLAf6YaoXhxrHJ35b7WFMBWCYUbJAY6adBTyDxPR
        0mrlC2h7z11Cnzh4k3Ynauv9CGubYuJn+QY4
X-Google-Smtp-Source: AGHT+IFHmlYWFyJjeYCWwtwGfzkdWOQSlkU99g1ToEzyX5My6rr9IrQFx3fq+cKJvEPQHq0FBTOS/AWSHgjOzO5H
X-Received: from jchowdhary2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:434b])
 (user=jchowdhary job=sendgmr) by 2002:a17:90a:fd94:b0:281:3cfb:cffb with SMTP
 id cx20-20020a17090afd9400b002813cfbcffbmr62883pjb.5.1699495987289; Wed, 08
 Nov 2023 18:13:07 -0800 (PST)
Date:   Thu,  9 Nov 2023 02:12:50 +0000
In-Reply-To: <20231103071353.1577383-1-jchowdhary@google.com>
Mime-Version: 1.0
References: <20231103071353.1577383-1-jchowdhary@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231109021251.542558-1-jchowdhary@google.com>
Subject: [PATCH v5] usb:gadget:uvc Do not use worker thread to pump isoc usb requests
From:   Jayant Chowdhary <jchowdhary@google.com>
To:     dan.scally@ideasonboard.com, jchowdhary@google.com,
        stern@rowland.harvard.edu, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, gregkh@linuxfoundation.org
Cc:     Thinh.Nguyen@synopsys.com, arakesh@google.com, etalvala@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use an async work queue to perform the function of pumping
usb requests to the usb controller, it is possible that amongst other
factors, thread scheduling affects at what cadence we're able to pump
requests. This could mean isoc usb requests miss their uframes - resulting
in video stream flickers on the host device.

To avoid this, we make the async_wq thread only produce isoc usb_requests
with uvc buffers encoded into them. The process of queueing to the
endpoint is done by the uvc_video_complete() handler. In case no
usb_requests are ready with encoded information, we just queue a zero
length request to the endpoint from the complete handler.

For bulk endpoints the async_wq thread still queues usb requests to the
endpoint.

Change-Id: I8a33cbf83fb2f04376826185079f8b25404fe761
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Jayant Chowdhary <jchowdhary@google.com>
Suggested-by: Avichal Rakesh <arakesh@google.com>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
---
 Based on top of
 https://lore.kernel.org/linux-usb/20230930184821.310143-1-arakesh@google.com/T/#t:
 v1->v2: Added self Signed-Off-by and addressed review comments
 v2->v3: Encode to usb requests in async_wq; queue to ep in complete handler
	 for isoc transfers.
 v3->v4: Address review comments around code style.
 v4->v5: Update comments. Remove 0 length request queueing from async_wq
	 thread since it is already done by the complete handler.

 drivers/usb/gadget/function/uvc.h       |   8 +
 drivers/usb/gadget/function/uvc_video.c | 204 ++++++++++++++++++------
 2 files changed, 166 insertions(+), 46 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index e8d4c87f1e09..5ff454528bd8 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -105,7 +105,15 @@ struct uvc_video {
 	bool is_enabled; /* tracks whether video stream is enabled */
 	unsigned int req_size;
 	struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
+
+	/* USB requests that the video pump thread can encode into */
 	struct list_head req_free;
+
+	/*
+	 * USB requests video pump thread has already encoded into. These are
+	 * ready to be queued to the endpoint.
+	 */
+	struct list_head req_ready;
 	spinlock_t req_lock;
 
 	unsigned int req_int_count;
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 53feb790a4c3..338e4b43e735 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -268,6 +268,100 @@ static int uvcg_video_ep_queue(struct uvc_video *video, struct usb_request *req)
 	return ret;
 }
 
+/* This function must be called with video->req_lock held. */
+static int uvcg_video_usb_req_queue(struct uvc_video *video,
+	struct usb_request *req, bool queue_to_ep)
+{
+	bool is_bulk = video->max_payload_size;
+
+	if (!video->is_enabled) {
+		uvc_video_free_request(req->context, video->ep);
+		return -ENODEV;
+	}
+	if (queue_to_ep) {
+		struct uvc_request *ureq = req->context;
+		/*
+		 * With USB3 handling more requests at a higher speed, we can't
+		 * afford to generate an interrupt for every request. Decide to
+		 * interrupt:
+		 *
+		 * - When no more requests are available in the free queue, as
+		 *   this may be our last chance to refill the endpoint's
+		 *   request queue.
+		 *
+		 * - When this is request is the last request for the video
+		 *   buffer, as we want to start sending the next video buffer
+		 *   ASAP in case it doesn't get started already in the next
+		 *   iteration of this loop.
+		 *
+		 * - Four times over the length of the requests queue (as
+		 *   indicated by video->uvc_num_requests), as a trade-off
+		 *   between latency and interrupt load.
+		 */
+		if (list_empty(&video->req_free) || ureq->last_buf ||
+			!(video->req_int_count %
+			DIV_ROUND_UP(video->uvc_num_requests, 4))) {
+			video->req_int_count = 0;
+			req->no_interrupt = 0;
+		} else {
+			req->no_interrupt = 1;
+		}
+		video->req_int_count++;
+		return uvcg_video_ep_queue(video, req);
+	} else {
+		/*
+		* If we're not queing to the ep, for isoc we're queing
+		* to the req_ready list, otherwise req_free.
+		*/
+		struct list_head *list =
+			is_bulk ? &video->req_free : &video->req_ready;
+		list_add_tail(&req->list, list);
+	}
+	return 0;
+}
+
+/*
+ * Must only be called from uvcg_video_enable - since after that we only want to
+ * queue requests to the endpoint from the uvc_video_complete complete handler.
+ * This function is needed in order to 'kick start' the flow of requests from
+ * gadget driver to the usb controller.
+ */
+static void uvc_video_ep_queue_initial_requests(struct uvc_video *video)
+{
+	struct usb_request *req = NULL;
+	unsigned long flags = 0;
+	unsigned int count = 0;
+	int ret = 0;
+	/*
+	 * We only queue half of the free list since we still want to have
+	 * some free usb_requests in the free list for the video_pump async_wq
+	 * thread to encode uvc buffers into. Otherwise we could get into a
+	 * situation where the free list does not have any usb requests to
+	 * encode into - we always end up queueing 0 length requests to the
+	 * end point.
+	 */
+	unsigned half_list_size = video->uvc_num_requests / 2;
+	spin_lock_irqsave(&video->req_lock, flags);
+	/*
+	 * Take these requests off the free list and queue them all to the
+	 * endpoint. Since we queue 0 length requests with the req_lock held,
+	 * there isn't any 'data' race involved here with the complete handler.
+	 */
+	while (count < half_list_size) {
+		req = list_first_entry(&video->req_free, struct usb_request,
+					list);
+		list_del(&req->list);
+		req->length = 0;
+		ret = uvcg_video_ep_queue(video, req);
+		if (ret < 0) {
+			uvcg_queue_cancel(&video->queue, /*disconnect*/0);
+			break;
+		}
+		count++;
+	}
+	spin_unlock_irqrestore(&video->req_lock, flags);
+}
+
 static void
 uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 {
@@ -276,6 +370,8 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	struct uvc_video_queue *queue = &video->queue;
 	struct uvc_buffer *last_buf = NULL;
 	unsigned long flags;
+	bool is_bulk = video->max_payload_size;
+	int ret = 0;
 
 	spin_lock_irqsave(&video->req_lock, flags);
 	if (!video->is_enabled) {
@@ -329,8 +425,46 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	 * back to req_free
 	 */
 	if (video->is_enabled) {
-		list_add_tail(&req->list, &video->req_free);
-		queue_work(video->async_wq, &video->pump);
+		/*
+		 * Here we check whether any request is available in the ready
+		 * list. If it is, queue it to the ep and add the current
+		 * usb_request to the req_free list - for video_pump to fill in.
+		 * Otherwise, just use the current usb_request to queue a 0
+		 * length request to the ep. Since we always add to the req_free
+		 * list if we dequeue from the ready list, there will never
+		 * be a situation where the req_free list is completely out of
+		 * requests and cannot recover.
+		 */
+		struct usb_request *to_queue = req;
+		to_queue->length = 0;
+		if (!list_empty(&video->req_ready)) {
+			to_queue = list_first_entry(&video->req_ready,
+				struct usb_request, list);
+			list_del(&to_queue->list);
+			/* Add it to the free list. */
+			list_add_tail(&req->list, &video->req_free);
+			/*
+			* Queue work to the wq as well since it is possible that a
+			* buffer may not have been completely encoded with the set of
+			* in-flight usb requests for whih the complete callbacks are
+			* firing.
+			* In that case, if we do not queue work to the worker thread,
+			* the buffer will never be marked as complete - and therefore
+			* not be returned to userpsace. As a result,
+			* dequeue -> queue -> dequeue flow of uvc buffers will not
+			* happen.
+			*/
+			queue_work(video->async_wq, &video->pump);
+		}
+		/*
+		 * Queue to the endpoint. The actual queueing to ep will
+		 * only happen on one thread - the async_wq for bulk endpoints
+		 * and this thread for isoc endpoints.
+		 */
+		ret = uvcg_video_usb_req_queue(video, to_queue, !is_bulk);
+		if(ret < 0) {
+			uvcg_queue_cancel(queue, 0);
+		}
 	} else {
 		uvc_video_free_request(ureq, ep);
 	}
@@ -347,6 +481,7 @@ uvc_video_free_requests(struct uvc_video *video)
 
 	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
+	INIT_LIST_HEAD(&video->req_ready);
 	video->req_size = 0;
 	return 0;
 }
@@ -424,8 +559,7 @@ static void uvcg_video_pump(struct work_struct *work)
 	struct usb_request *req = NULL;
 	struct uvc_buffer *buf;
 	unsigned long flags;
-	bool buf_done;
-	int ret;
+	int ret = 0;
 
 	while (true) {
 		if (!video->ep->enabled)
@@ -454,15 +588,6 @@ static void uvcg_video_pump(struct work_struct *work)
 
 		if (buf != NULL) {
 			video->encode(req, video, buf);
-			buf_done = buf->state == UVC_BUF_STATE_DONE;
-		} else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) && !is_bulk) {
-			/*
-			 * No video buffer available; the queue is still connected and
-			 * we're transferring over ISOC. Queue a 0 length request to
-			 * prevent missed ISOC transfers.
-			 */
-			req->length = 0;
-			buf_done = false;
 		} else {
 			/*
 			 * Either the queue has been disconnected or no video buffer
@@ -473,45 +598,25 @@ static void uvcg_video_pump(struct work_struct *work)
 			break;
 		}
 
-		/*
-		 * With USB3 handling more requests at a higher speed, we can't
-		 * afford to generate an interrupt for every request. Decide to
-		 * interrupt:
-		 *
-		 * - When no more requests are available in the free queue, as
-		 *   this may be our last chance to refill the endpoint's
-		 *   request queue.
-		 *
-		 * - When this is request is the last request for the video
-		 *   buffer, as we want to start sending the next video buffer
-		 *   ASAP in case it doesn't get started already in the next
-		 *   iteration of this loop.
-		 *
-		 * - Four times over the length of the requests queue (as
-		 *   indicated by video->uvc_num_requests), as a trade-off
-		 *   between latency and interrupt load.
-		 */
-		if (list_empty(&video->req_free) || buf_done ||
-		    !(video->req_int_count %
-		       DIV_ROUND_UP(video->uvc_num_requests, 4))) {
-			video->req_int_count = 0;
-			req->no_interrupt = 0;
-		} else {
-			req->no_interrupt = 1;
-		}
-
-		/* Queue the USB request */
-		ret = uvcg_video_ep_queue(video, req);
 		spin_unlock_irqrestore(&queue->irqlock, flags);
 
+		spin_lock_irqsave(&video->req_lock, flags);
+		/* For bulk end points we queue from the worker thread
+		 * since we would preferably not want to wait on requests
+		 * to be ready, in the uvcg_video_complete() handler.
+		 * For isoc endpoints we add the request to the ready list
+		 * and only queue it to the endpoint from the complete handler.
+		 */
+		ret = uvcg_video_usb_req_queue(video, req, is_bulk);
+		spin_unlock_irqrestore(&video->req_lock, flags);
+
 		if (ret < 0) {
 			uvcg_queue_cancel(queue, 0);
 			break;
 		}
 
-		/* Endpoint now owns the request */
+		/* The request is owned by  the endpoint / ready list. */
 		req = NULL;
-		video->req_int_count++;
 	}
 
 	if (!req)
@@ -567,7 +672,7 @@ uvcg_video_disable(struct uvc_video *video)
 
 	spin_lock_irqsave(&video->req_lock, flags);
 	/*
-	 * Remove all uvc_reqeusts from ureqs with list_del_init
+	* Remove all uvc_requests from ureqs with list_del_init
 	 * This lets uvc_video_free_request correctly identify
 	 * if the uvc_request is attached to a list or not when freeing
 	 * memory.
@@ -580,8 +685,14 @@ uvcg_video_disable(struct uvc_video *video)
 		uvc_video_free_request(req->context, video->ep);
 	}
 
+	list_for_each_entry_safe(req, temp, &video->req_ready, list) {
+		list_del(&req->list);
+		uvc_video_free_request(req->context, video->ep);
+	}
+
 	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
+	INIT_LIST_HEAD(&video->req_ready);
 	video->req_size = 0;
 	spin_unlock_irqrestore(&video->req_lock, flags);
 
@@ -635,7 +746,7 @@ int uvcg_video_enable(struct uvc_video *video)
 
 	video->req_int_count = 0;
 
-	queue_work(video->async_wq, &video->pump);
+	uvc_video_ep_queue_initial_requests(video);
 
 	return ret;
 }
@@ -648,6 +759,7 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 	video->is_enabled = false;
 	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
+	INIT_LIST_HEAD(&video->req_ready);
 	spin_lock_init(&video->req_lock);
 	INIT_WORK(&video->pump, uvcg_video_pump);
 
-- 
2.42.0.869.gea05f2083d-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033CB7E6184
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjKIAl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjKIAlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:41:24 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1010269F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 16:41:18 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7be940fe1so4282657b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 16:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699490478; x=1700095278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gcBBo0DVTc7llz0aQgPApWtsQP64S4JC7/VeqnxMe0M=;
        b=hgeV9A2619JjL4VknvNQ8zIn9aECPxBhO3cF/yZHsnlce+K45xVAOTDTiPmN7+9d0/
         fBEO/42rIuO6rhNmuzY47G81rfM5IbnkvGykAU5bifP16AaTpzfU0CZSCceatuXubbKQ
         G90fWZ0CJrMzrmle0cdY9I4nJMte28PTZRBU6c+o65NvmGkvcRaV3z2SfWkjdg0PoruR
         6y+uMY/nufIVCRA39suwJioBFrh7XD1tz8j5ridBSnH9X33JSLxe0G5yz3ma7pFDxlfV
         h9qgDR2N8O4KtB/uVFKvfgdU1upPI+4LOW4E0VjuAg9Xwqpl9NEsOSZUFn0wm+0+eGY2
         ys7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699490478; x=1700095278;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcBBo0DVTc7llz0aQgPApWtsQP64S4JC7/VeqnxMe0M=;
        b=bIPEDBZvXS2tJyiDjoKJs+5bOZ2rJaINsGjgXkNCyVMuox9KVFt13s4HxH08m51grA
         8H8nTmuuTw2hwjvoxDyCzQ8UZKLXF3OBBF0r0265rM0f5PUQJCxL3YEDuXNnOfEjlWAe
         mKxjQC1ERPfNqC1jTGL0WnkmuzP8SKD0Ehzb4vgtzxtqMFd2ueDWRMNo/76t26S2b0oL
         P7B94x3X2/RDonhIaOmXYd5WBkjBSa/EbiFZuBwoaSrjsqBmkPAm8Fo4eDpqaBX8qka1
         wKLLdqOjjSZVYqhHAQfVkxMmQ98UAM2d268epb/u63dKAtgGhtCt2OPTnSCX3zZaW1ZM
         K9sg==
X-Gm-Message-State: AOJu0YyxoxkejkpLUA8cEUPT8YLIfKDOhMeCHORRqWsWUx5LZ58XC7K2
        +2M+Sh9FA2iqC6GvxD6XLlmxumE8JZ00
X-Google-Smtp-Source: AGHT+IHTTC9lNpE2cYlgOHV3fV7L+syjLwoAs03bFhCGbay6P/r9/a8eqmHjnwtsWEl0QBCwlY/JDw0n6O7a
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a81:83ce:0:b0:5a7:7683:995d with SMTP id
 t197-20020a8183ce000000b005a77683995dmr82295ywf.5.1699490478216; Wed, 08 Nov
 2023 16:41:18 -0800 (PST)
Date:   Wed,  8 Nov 2023 16:41:04 -0800
In-Reply-To: <20231109004104.3467968-1-arakesh@google.com>
Mime-Version: 1.0
References: <73309396-3856-43a2-9a6f-81a40ed594db@google.com> <20231109004104.3467968-1-arakesh@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231109004104.3467968-4-arakesh@google.com>
Subject: [PATCH v12 4/4] usb: gadget: uvc: Fix use-after-free for inflight usb_requests
From:   Avichal Rakesh <arakesh@google.com>
To:     arakesh@google.com, dan.scally@ideasonboard.com,
        gregkh@linuxfoundation.org
Cc:     etalvala@google.com, jchowdhary@google.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, m.grzeschik@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the uvc gadget driver allocates all uvc_requests as one array
and deallocates them all when the video stream stops. This includes
de-allocating all the usb_requests associated with those uvc_requests.
This can lead to use-after-free issues if any of those de-allocated
usb_requests were still owned by the usb controller.

This is patch 2 of 2 in fixing the use-after-free issue. It adds a new
flag to uvc_video to track when frames and requests should be flowing.
When disabling the video stream, the flag is tripped and, instead
of de-allocating all uvc_requests and usb_requests, the gadget
driver only de-allocates those usb_requests that are currently
owned by it (as present in req_free). Other usb_requests are left
untouched until their completion handler is called which takes care
of freeing the usb_request and its corresponding uvc_request.

Now that uvc_video does not depends on uvc->state, this patch removes
unnecessary upates to uvc->state that were made to accommodate uvc_video
logic. This should ensure that uvc gadget driver never accidentally
de-allocates a usb_request that it doesn't own.

Link: https://lore.kernel.org/7cd81649-2795-45b6-8c10-b7df1055020d@google.com
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Reviewed-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Suggested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Tested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
v1  -> v2  : Rebased to ToT, and fixed deadlock reported in
             https://lore.kernel.org/all/ZRv2UnKztgyqk2pt@pengutronix.de/
v2  -> v3  : Fix email threading goof-up
v3  -> v4  : re-rebase to ToT & moved to a uvc_video level lock
             as discussed in
             https://lore.kernel.org/b14b296f-2e08-4edf-aeea-1c5b621e2d0c@google.com/
v4  -> v5  : Address review comments. Add Reviewed-by & Tested-by.
v5  -> v6  : Added another patch before this one to make uvcg_video_disable
             easier to review.
v6  -> v7  : Fix warning reported in
             https://lore.kernel.org/202310200457.GwPPFuHX-lkp@intel.com/
v7  -> v8  : No change. Getting back in review queue
v8  -> v9  : No change.
v9  -> v10 : Address review comments. Rebase to ToT (usb-next)
v10 -> v11 : Address review comments
v11 -> v12 : Add Reviewed-by; Rebase to ToT (usb-next)

 drivers/usb/gadget/function/uvc.h       |   1 +
 drivers/usb/gadget/function/uvc_v4l2.c  |  10 +-
 drivers/usb/gadget/function/uvc_video.c | 130 ++++++++++++++++++++----
 3 files changed, 112 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 993694da0bbc..be0d012aa244 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -102,6 +102,7 @@ struct uvc_video {
 	unsigned int uvc_num_requests;

 	/* Requests */
+	bool is_enabled; /* tracks whether video stream is enabled */
 	unsigned int req_size;
 	struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
 	struct list_head req_free;
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index 904dd283cbf7..c7e5fa4f29e0 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -468,11 +468,11 @@ uvc_v4l2_streamoff(struct file *file, void *fh, enum v4l2_buf_type type)
 	if (type != video->queue.queue.type)
 		return -EINVAL;

-	uvc->state = UVC_STATE_CONNECTED;
 	ret = uvcg_video_disable(video);
 	if (ret < 0)
 		return ret;

+	uvc->state = UVC_STATE_CONNECTED;
 	uvc_function_setup_continue(uvc, 1);
 	return 0;
 }
@@ -507,14 +507,6 @@ uvc_v4l2_subscribe_event(struct v4l2_fh *fh,
 static void uvc_v4l2_disable(struct uvc_device *uvc)
 {
 	uvc_function_disconnect(uvc);
-	/*
-	 * Drop uvc->state to CONNECTED if it was streaming before.
-	 * This ensures that the usb_requests are no longer queued
-	 * to the controller.
-	 */
-	if (uvc->state == UVC_STATE_STREAMING)
-		uvc->state = UVC_STATE_CONNECTED;
-
 	uvcg_video_disable(&uvc->video);
 	uvcg_free_buffers(&uvc->video.queue);
 	uvc->func_connected = false;
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index c3e8c48f46a9..164bdeb7f2a9 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -227,6 +227,10 @@ uvc_video_encode_isoc(struct usb_request *req, struct uvc_video *video,
  * Request handling
  */

+/*
+ * Callers must take care to hold req_lock when this function may be called
+ * from multiple threads. For example, when frames are streaming to the host.
+ */
 static void
 uvc_video_free_request(struct uvc_request *ureq, struct usb_ep *ep)
 {
@@ -271,9 +275,26 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	struct uvc_request *ureq = req->context;
 	struct uvc_video *video = ureq->video;
 	struct uvc_video_queue *queue = &video->queue;
-	struct uvc_device *uvc = video->uvc;
+	struct uvc_buffer *last_buf;
 	unsigned long flags;

+	spin_lock_irqsave(&video->req_lock, flags);
+	if (!video->is_enabled) {
+		/*
+		 * When is_enabled is false, uvcg_video_disable() ensures
+		 * that in-flight uvc_buffers are returned, so we can
+		 * safely call free_request without worrying about
+		 * last_buf.
+		 */
+		uvc_video_free_request(ureq, ep);
+		spin_unlock_irqrestore(&video->req_lock, flags);
+		return;
+	}
+
+	last_buf = ureq->last_buf;
+	ureq->last_buf = NULL;
+	spin_unlock_irqrestore(&video->req_lock, flags);
+
 	switch (req->status) {
 	case 0:
 		break;
@@ -295,17 +316,26 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 		uvcg_queue_cancel(queue, 0);
 	}

-	if (ureq->last_buf) {
-		uvcg_complete_buffer(&video->queue, ureq->last_buf);
-		ureq->last_buf = NULL;
+	if (last_buf) {
+		spin_lock_irqsave(&queue->irqlock, flags);
+		uvcg_complete_buffer(queue, last_buf);
+		spin_unlock_irqrestore(&queue->irqlock, flags);
 	}

 	spin_lock_irqsave(&video->req_lock, flags);
-	list_add_tail(&req->list, &video->req_free);
-	spin_unlock_irqrestore(&video->req_lock, flags);
-
-	if (uvc->state == UVC_STATE_STREAMING)
+	/*
+	 * Video stream might have been disabled while we were
+	 * processing the current usb_request. So make sure
+	 * we're still streaming before queueing the usb_request
+	 * back to req_free
+	 */
+	if (video->is_enabled) {
+		list_add_tail(&req->list, &video->req_free);
 		queue_work(video->async_wq, &video->pump);
+	} else {
+		uvc_video_free_request(ureq, ep);
+	}
+	spin_unlock_irqrestore(&video->req_lock, flags);
 }

 static int
@@ -392,20 +422,22 @@ static void uvcg_video_pump(struct work_struct *work)
 	struct uvc_video_queue *queue = &video->queue;
 	/* video->max_payload_size is only set when using bulk transfer */
 	bool is_bulk = video->max_payload_size;
-	struct uvc_device *uvc = video->uvc;
 	struct usb_request *req = NULL;
 	struct uvc_buffer *buf;
 	unsigned long flags;
 	bool buf_done;
 	int ret;

-	while (uvc->state == UVC_STATE_STREAMING && video->ep->enabled) {
+	while (true) {
+		if (!video->ep->enabled)
+			return;
+
 		/*
-		 * Retrieve the first available USB request, protected by the
-		 * request lock.
+		 * Check is_enabled and retrieve the first available USB
+		 * request, protected by the request lock.
 		 */
 		spin_lock_irqsave(&video->req_lock, flags);
-		if (list_empty(&video->req_free)) {
+		if (!video->is_enabled || list_empty(&video->req_free)) {
 			spin_unlock_irqrestore(&video->req_lock, flags);
 			return;
 		}
@@ -487,9 +519,11 @@ static void uvcg_video_pump(struct work_struct *work)
 		return;

 	spin_lock_irqsave(&video->req_lock, flags);
-	list_add_tail(&req->list, &video->req_free);
+	if (video->is_enabled)
+		list_add_tail(&req->list, &video->req_free);
+	else
+		uvc_video_free_request(req->context, video->ep);
 	spin_unlock_irqrestore(&video->req_lock, flags);
-	return;
 }

 /*
@@ -498,7 +532,11 @@ static void uvcg_video_pump(struct work_struct *work)
 int
 uvcg_video_disable(struct uvc_video *video)
 {
-	struct uvc_request *ureq;
+	unsigned long flags;
+	struct list_head inflight_bufs;
+	struct usb_request *req, *temp;
+	struct uvc_buffer *buf, *btemp;
+	struct uvc_request *ureq, *utemp;

 	if (video->ep == NULL) {
 		uvcg_info(&video->uvc->func,
@@ -506,15 +544,58 @@ uvcg_video_disable(struct uvc_video *video)
 		return -ENODEV;
 	}

+	INIT_LIST_HEAD(&inflight_bufs);
+	spin_lock_irqsave(&video->req_lock, flags);
+	video->is_enabled = false;
+
+	/*
+	 * Remove any in-flight buffers from the uvc_requests
+	 * because we want to return them before cancelling the
+	 * queue. This ensures that we aren't stuck waiting for
+	 * all complete callbacks to come through before disabling
+	 * vb2 queue.
+	 */
+	list_for_each_entry(ureq, &video->ureqs, list) {
+		if (ureq->last_buf) {
+			list_add_tail(&ureq->last_buf->queue, &inflight_bufs);
+			ureq->last_buf = NULL;
+		}
+	}
+	spin_unlock_irqrestore(&video->req_lock, flags);
+
 	cancel_work_sync(&video->pump);
 	uvcg_queue_cancel(&video->queue, 0);

-	list_for_each_entry(ureq, &video->ureqs, list) {
-		if (ureq->req)
-			usb_ep_dequeue(video->ep, ureq->req);
+	spin_lock_irqsave(&video->req_lock, flags);
+	/*
+	 * Remove all uvc_requests from ureqs with list_del_init
+	 * This lets uvc_video_free_request correctly identify
+	 * if the uvc_request is attached to a list or not when freeing
+	 * memory.
+	 */
+	list_for_each_entry_safe(ureq, utemp, &video->ureqs, list)
+		list_del_init(&ureq->list);
+
+	list_for_each_entry_safe(req, temp, &video->req_free, list) {
+		list_del(&req->list);
+		uvc_video_free_request(req->context, video->ep);
 	}

-	uvc_video_free_requests(video);
+	INIT_LIST_HEAD(&video->ureqs);
+	INIT_LIST_HEAD(&video->req_free);
+	video->req_size = 0;
+	spin_unlock_irqrestore(&video->req_lock, flags);
+
+	/*
+	 * Return all the video buffers before disabling the queue.
+	 */
+	spin_lock_irqsave(&video->queue.irqlock, flags);
+	list_for_each_entry_safe(buf, btemp, &inflight_bufs, queue) {
+		list_del(&buf->queue);
+		uvcg_complete_buffer(&video->queue, buf);
+	}
+	spin_unlock_irqrestore(&video->queue.irqlock, flags);
+
 	uvcg_queue_enable(&video->queue, 0);
 	return 0;
 }
@@ -532,6 +613,14 @@ int uvcg_video_enable(struct uvc_video *video)
 		return -ENODEV;
 	}

+	/*
+	 * Safe to access request related fields without req_lock because
+	 * this is the only thread currently active, and no other
+	 * request handling thread will become active until this function
+	 * returns.
+	 */
+	video->is_enabled = true;
+
 	if ((ret = uvcg_queue_enable(&video->queue, 1)) < 0)
 		return ret;

@@ -557,6 +646,7 @@ int uvcg_video_enable(struct uvc_video *video)
  */
 int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 {
+	video->is_enabled = false;
 	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
 	spin_lock_init(&video->req_lock);
--
2.42.0.869.gea05f2083d-goog

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C187C61AD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 02:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376654AbjJLAZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 20:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjJLAZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 20:25:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BD294
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 17:25:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7bcbb95b2so6191867b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 17:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697070301; x=1697675101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cgopB/iDnieNYkK7XiJQZLx39wNfXfhXvxUWXbNmypA=;
        b=1ljthnVeOZf9UjDqB2Sp540FxxcFM5z7ZblmA4a0xvcS33PJ195O3wsWZCOw29IJtP
         mCvQb5GODgwwk2qLLT2TiRUdBSEvMnjFnsFDD56aVCuYuTfECjzVfiyEAXSWPbSeK36y
         gnbk58j9+uynbI0f9l6ZPcrp984txAJzYuaYuT0GuSJdy3jp5QiHc24BY1prCr0E8LcF
         PCiay15W+dLKXHPdHNdEQvDNzLs4b3p/Z4h77ZAH8KiUg6sKhgOVI3opMm2vdDb6OaRY
         g7Q4fmk/ZLHUne/OMLc4gqIC9/Jd2GtlIAMJ68uh1qfCb/o93ARA+E8FBtI724HU5dXX
         QaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697070301; x=1697675101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgopB/iDnieNYkK7XiJQZLx39wNfXfhXvxUWXbNmypA=;
        b=Y/DuqGlpqAeMbBfH43nCGRv9ATw81VFcl1sN7zhYF62lGfuaPpMCK3MB4tYsiSEten
         7sdO1gl8Ca6Y0JBuL9+eiNhhZbOTMDjFUaAR928V0Wja2EU7qYvTn4UodITLXbSKGnXo
         M4NELXBaNp+aw1QdAJMi0v1zcpDH3Jf4HAn4kDZQYNWP7zo8mvJjSJboT8mTha8Nitam
         MYEhABgx5IEr5gKzPJn6MQDFyZlfn0++W9TMPVrsHFe2eEcFyRF7jLyJJ1/jY1amMS5s
         xZpAYdjY2TNBDVNtpXDjya3ol4tIDJNWQgIhO+dvjc0fmsEG1hfoYhjP65DWWcrQpsMZ
         i9+g==
X-Gm-Message-State: AOJu0YzSwooV0ccBMX1qOmGQnDGdKgyRptthNPL4Bb9/lzs4Clm9eUWA
        pHb57XTCOdgBhE184ifCv6ncRsUXtMjn
X-Google-Smtp-Source: AGHT+IGTUCvg0T62P8yjvDrwz42KhHNI45jgYgxN1C492zyW8/z5GeXccX8hqXkecTX8BKpuTjvRDR4jZ7wB
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a81:ac05:0:b0:5a7:ccf3:3f28 with SMTP id
 k5-20020a81ac05000000b005a7ccf33f28mr112624ywh.0.1697070300856; Wed, 11 Oct
 2023 17:25:00 -0700 (PDT)
Date:   Wed, 11 Oct 2023 17:24:51 -0700
In-Reply-To: <20231012002451.254737-1-arakesh@google.com>
Mime-Version: 1.0
References: <20230930184821.310143-1-arakesh@google.com> <20231012002451.254737-1-arakesh@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231012002451.254737-3-arakesh@google.com>
Subject: [PATCH v4 3/3] usb: gadget: uvc: Fix use-after-free for inflight usb_requests
From:   Avichal Rakesh <arakesh@google.com>
To:     arakesh@google.com, dan.scally@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, m.grzeschik@pengutronix.de
Cc:     etalvala@google.com, gregkh@linuxfoundation.org,
        jchowdhary@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
unnecessary upates to uvc->state that were made to accomodate uvc_video
logic. This should ensure that uvc gadget driver never accidentally
de-allocates a usb_request that it doesn't own.

Link: https://lore.kernel.org/7cd81649-2795-45b6-8c10-b7df1055020d@google.com
Suggested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
v1 -> v2: Rebased to ToT, and fixed deadlock reported in
          https://lore.kernel.org/all/ZRv2UnKztgyqk2pt@pengutronix.de/
v2 -> v3: Fix email threading goof-up
v3 -> v4: re-rebase to ToT & moved to a uvc_video level lock
          as discussed in
          https://lore.kernel.org/b14b296f-2e08-4edf-aeea-1c5b621e2d0c@google.com/

 drivers/usb/gadget/function/uvc.h       |   1 +
 drivers/usb/gadget/function/uvc_v4l2.c  |  12 +-
 drivers/usb/gadget/function/uvc_video.c | 156 +++++++++++++++++++-----
 3 files changed, 128 insertions(+), 41 deletions(-)

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
index c0d77564a204..ded7d33c2a52 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -451,8 +451,8 @@ uvc_v4l2_streamon(struct file *file, void *fh, enum v4l2_buf_type type)
 	 * Complete the alternate setting selection setup phase now that
 	 * userspace is ready to provide video frames.
 	 */
-	uvc_function_setup_continue(uvc, 0);
 	uvc->state = UVC_STATE_STREAMING;
+	uvc_function_setup_continue(uvc, 0);

 	return 0;
 }
@@ -468,12 +468,12 @@ uvc_v4l2_streamoff(struct file *file, void *fh, enum v4l2_buf_type type)
 	if (type != video->queue.queue.type)
 		return -EINVAL;

-	uvc->state = UVC_STATE_CONNECTED;
 	ret = uvcg_video_enable(video, 0);
 	if (ret < 0) {
 		return ret;
 	}

+	uvc->state = UVC_STATE_CONNECTED;
 	uvc_function_setup_continue(uvc, 1);
 	return 0;
 }
@@ -508,14 +508,6 @@ uvc_v4l2_subscribe_event(struct v4l2_fh *fh,
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
 	uvcg_video_enable(&uvc->video, 0);
 	uvcg_free_buffers(&uvc->video.queue);
 	uvc->func_connected = false;
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index b62b3de79153..05b89b5b6c48 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -227,6 +227,9 @@ uvc_video_encode_isoc(struct usb_request *req, struct uvc_video *video,
  * Request handling
  */

+/**
+ * Must be called with req_lock held as it modifies the list ureq is held in
+ */
 static void
 uvc_video_free_request(struct uvc_request *ureq, struct usb_ep *ep)
 {
@@ -271,9 +274,25 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	struct uvc_request *ureq = req->context;
 	struct uvc_video *video = ureq->video;
 	struct uvc_video_queue *queue = &video->queue;
-	struct uvc_device *uvc = video->uvc;
+	struct uvc_buffer *last_buf = NULL;
 	unsigned long flags;

+	spin_lock_irqsave(&video->req_lock, flags);
+	if (!video->is_enabled) {
+		/*
+		 * When is_enabled is false, uvc_video_disable ensures that
+		 * in-flight uvc_buffers are returned, so we can safely
+		 * call free_request without worrying about last_buf.
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
@@ -295,17 +314,26 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 		uvcg_queue_cancel(queue, 0);
 	}

-	if (ureq->last_buf) {
-		uvcg_complete_buffer(&video->queue, ureq->last_buf);
-		ureq->last_buf = NULL;
+	if (last_buf) {
+		spin_lock_irqsave(&queue->irqlock, flags);
+		uvcg_complete_buffer(&video->queue, last_buf);
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
@@ -391,20 +419,22 @@ static void uvcg_video_pump(struct work_struct *work)
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
+	while(true) {
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
@@ -486,9 +516,78 @@ static void uvcg_video_pump(struct work_struct *work)
 		return;

 	spin_lock_irqsave(&video->req_lock, flags);
-	list_add_tail(&req->list, &video->req_free);
+	if (video->is_enabled)
+		list_add_tail(&req->list, &video->req_free);
+	else
+		uvc_video_free_request(req->context, video->ep);
+	spin_unlock_irqrestore(&video->req_lock, flags);
+}
+
+/*
+ * Disable video stream
+ */
+static int
+uvcg_video_disable(struct uvc_video *video) {
+	unsigned long flags;
+	struct list_head inflight_bufs;
+	struct usb_request *req, *temp;
+	struct uvc_buffer *buf, *btemp;
+	struct uvc_request *ureq, *utemp;
+
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
 	spin_unlock_irqrestore(&video->req_lock, flags);
-	return;
+
+	cancel_work_sync(&video->pump);
+	uvcg_queue_cancel(&video->queue, 0);
+
+	spin_lock_irqsave(&video->req_lock, flags);
+	/*
+	 * Remove all uvc_reqeusts from from ureqs with list_del_init
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
+	}
+
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
+	uvcg_queue_enable(&video->queue, 0);
+	return 0;
 }

 /*
@@ -497,28 +596,22 @@ static void uvcg_video_pump(struct work_struct *work)
 int uvcg_video_enable(struct uvc_video *video, int enable)
 {
 	int ret;
-	struct uvc_request *ureq;

 	if (video->ep == NULL) {
 		uvcg_info(&video->uvc->func,
 			  "Video enable failed, device is uninitialized.\n");
 		return -ENODEV;
 	}
-
-	if (!enable) {
-		cancel_work_sync(&video->pump);
-		uvcg_queue_cancel(&video->queue, 0);
-
-		list_for_each_entry(ureq, &video->ureqs, list) {
-			if (ureq->req)
-				usb_ep_dequeue(video->ep, ureq->req);
-		}
-
-		uvc_video_free_requests(video);
-		uvcg_queue_enable(&video->queue, 0);
-		return 0;
-	}
-
+	if (!enable)
+		return uvcg_video_disable(video);
+
+	/*
+	 * Safe to access request related fields without req_lock because
+	 * this is the only thread currently active, and no other
+	 * request handling thread will become active until this function
+	 * returns.
+	 */
+	video->is_enabled = true;
 	if ((ret = uvcg_queue_enable(&video->queue, 1)) < 0)
 		return ret;

@@ -544,6 +637,7 @@ int uvcg_video_enable(struct uvc_video *video, int enable)
  */
 int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 {
+	video->is_enabled = false;
 	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
 	spin_lock_init(&video->req_lock);
--
2.42.0.609.gbb76f46606-goog


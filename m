Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD32A7A8D74
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjITUEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjITUEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:04:20 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DABA1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:04:14 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56f75e70190so109394a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695240254; x=1695845054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6p0bzky6LCEPL6bgGS8tF4NF2gWtz4P0WZiH/wuU5o=;
        b=cezSsR4vZDI0SYv02xYRQrvXSJHL7rAn/0iFAhNIkuNnhZ5hcU9eMCoxmzHLby/jaJ
         iKQaQHEQ+htYTcbrSAi2fYOHwNFdqSk/I3m+rWUDsq2F994r3JaboGxjhyaBbGcf4KEp
         G02vTSLNHajorLWhfmbdvw8if+0FvYQTn848GC9nmo/ruxna2fvQSQfASeGB88O0gj/1
         ocqnUfPipLAwLn5pKZrY2VGoE5uOgxXR8CP1sJus/ji3W7H9A4DcHVCMJl/zhP0mstrP
         aQ3q3T4XX6vo+hOUb0vLZ5QtF5kxIqyl++ANpPeeOsDgIpL2XwqZNcrU1s8OZmc4y5aY
         O3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695240254; x=1695845054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6p0bzky6LCEPL6bgGS8tF4NF2gWtz4P0WZiH/wuU5o=;
        b=WfMMLKM0lYUnIlvBCke66G2165sgMgyX01WafiDjVfOb0nsHTkjUYQTsY7WgjapN68
         QW+xAJvqjLWIpccn/X7HGhVLTPyaNulFvWDQ72KxisfgYRRcJZFa4pwavjkT40M+l/6q
         dB2LsDUA3EOx2sFH+ZaayNaF9nzgR34xx2unY41t/rycAWFREb88QolRdl9JTtiy0LXK
         VtvMIoErb3M+WIvTtbQTlWVyMy9i0DXvFJuixysrabearebBaIj+q8V5EuHOtdXAbD+l
         wWCWhXA0uGSNbiuDtDgZeB4r0/uUgSO/bydYtTrL/5LNwh7W7YXIhmPPg9bmBhbFq5yG
         YI5Q==
X-Gm-Message-State: AOJu0Yx4inMtd4p6cEFx9I20KzV40CyTpokFxHDvNTaY7+Ib96AVeqRS
        mCkrfwxq3lijXkCmTEGVZ3Uxv15dft7f
X-Google-Smtp-Source: AGHT+IHOrt+ZGxpBa7ZFZy/Q1qXiEcEWpwQrnwbCeflIlYCKYBFd0+T9/gb2zbqMgep7bR3VXmD3UwPgqXbx
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a63:4861:0:b0:578:bb30:d0c9 with SMTP id
 x33-20020a634861000000b00578bb30d0c9mr48353pgk.8.1695240253710; Wed, 20 Sep
 2023 13:04:13 -0700 (PDT)
Date:   Wed, 20 Sep 2023 13:03:35 -0700
In-Reply-To: <20230912041910.726442-3-arakesh@google.com>
Mime-Version: 1.0
References: <20230912041910.726442-3-arakesh@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920200335.63709-1-arakesh@google.com>
Subject: [PATCH v2 2/2] usb: gadget: uvc: prevent de-allocating inflight usb_requests
From:   Avichal Rakesh <arakesh@google.com>
To:     arakesh@google.com, dan.scally@ideasonboard.com,
        laurent.pinchart@ideasonboard.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, m.grzeschik@pengutronix.de,
        jchowdhary@google.com, etalvala@google.com,
        Michael Grzeschik <mgr@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when stopping the stream, uvcg_video_enable immediately
deallocates the usb_requests after calling usb_ep_dequeue. However,
usb_ep_dequeue is asynchronous and it is possible that it a request
that is still in use by the controller. This can lead to some hard
to reproduce crashes with double frees and general memory
inconsistencies.

This patch sets up some stronger guarantees around when a request should
be deallocated. To that extent, this patch does the following:
1. When stream is stopped only the currently owned uvc_requests are freed
   and all in-flight uvc_requests are marked 'abandoned'
2. uvc_video_complete callback is made responsible for freeing up the
   abandoned requests. No uvc specific logic is triggered when handling
   abandoned requests.

This ensures that the ownership of uvc_request (and its corresponding
usb_request) is never ambiguous, and uvc_requests are always freed
regardless of when the requests are returned to the gadget driver.

Other changes in the patch are required to decouple the allocated
uvc_requests from uvc_video that allocated them.

Link: https://lore.kernel.org/7cd81649-2795-45b6-8c10-b7df1055020d@google.com
Suggested-by: Michael Grzeschik <mgr@pengutronix.de>
Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
v1 -> v2: Switched from a timed wait to free on complete model based
          on discussions with Michael.

 drivers/usb/gadget/function/uvc.h       |   4 +-
 drivers/usb/gadget/function/uvc_video.c | 182 +++++++++++++++++-------
 2 files changed, 133 insertions(+), 53 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 989bc6b4e93d..e69cfb7cced1 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -81,6 +81,8 @@ struct uvc_request {
 	struct sg_table sgt;
 	u8 header[UVCG_REQUEST_HEADER_LEN];
 	struct uvc_buffer *last_buf;
+	struct list_head list;
+	bool is_abandoned;
 };

 struct uvc_video {
@@ -102,7 +104,7 @@ struct uvc_video {

 	/* Requests */
 	unsigned int req_size;
-	struct uvc_request *ureq;
+	struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
 	struct list_head req_free;
 	spinlock_t req_lock;

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 70ff88854539..e999bf5bd458 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -227,6 +227,23 @@ uvc_video_encode_isoc(struct usb_request *req, struct uvc_video *video,
  * Request handling
  */

+static void uvc_video_free_request(struct uvc_request *ureq, struct usb_ep *ep)
+{
+	sg_free_table(&ureq->sgt);
+	if (ureq->req && ep) {
+		usb_ep_free_request(ep, ureq->req);
+		ureq->req = NULL;
+	}
+
+	kfree(ureq->req_buffer);
+	ureq->req_buffer = NULL;
+
+	if (!list_empty(&ureq->list))
+		list_del(&ureq->list);
+
+	kfree(ureq);
+}
+
 static int uvcg_video_ep_queue(struct uvc_video *video, struct usb_request *req)
 {
 	int ret;
@@ -254,7 +271,21 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	struct uvc_video *video = ureq->video;
 	struct uvc_video_queue *queue = &video->queue;
 	struct uvc_device *uvc = video->uvc;
+	struct uvc_buffer *last_buf;
 	unsigned long flags;
+	bool is_abandoned;
+
+	spin_lock_irqsave(&video->req_lock, flags);
+	is_abandoned = ureq->is_abandoned;
+	last_buf = ureq->last_buf;
+	ureq->last_buf = NULL;
+	spin_unlock_irqrestore(&video->req_lock, flags);
+
+	if (is_abandoned) {
+		uvcg_dbg(&video->uvc->func, "Freeing abandoned request\n");
+		uvc_video_free_request(ureq, ep);
+		return;
+	}

 	switch (req->status) {
 	case 0:
@@ -277,15 +308,27 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 		uvcg_queue_cancel(queue, 0);
 	}

-	if (ureq->last_buf) {
-		uvcg_complete_buffer(&video->queue, ureq->last_buf);
-		ureq->last_buf = NULL;
+	if (last_buf) {
+		spin_lock_irqsave(&video->queue.irqlock, flags);
+		uvcg_complete_buffer(&video->queue, last_buf);
+		spin_unlock_irqrestore(&video->queue.irqlock, flags);
 	}

+	/*
+	 * request might have been abandoned while being processed.
+	 * do a last minute check before queueing the request back.
+	 */
 	spin_lock_irqsave(&video->req_lock, flags);
-	list_add_tail(&req->list, &video->req_free);
+	is_abandoned = ureq->is_abandoned;
+	if (!is_abandoned)
+		list_add_tail(&req->list, &video->req_free);
 	spin_unlock_irqrestore(&video->req_lock, flags);

+	if (is_abandoned) {
+		uvc_video_free_request(ureq, ep);
+		return;
+	}
+
 	if (uvc->state == UVC_STATE_STREAMING)
 		queue_work(video->async_wq, &video->pump);
 }
@@ -293,25 +336,10 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 static int
 uvc_video_free_requests(struct uvc_video *video)
 {
-	unsigned int i;
-
-	if (video->ureq) {
-		for (i = 0; i < video->uvc_num_requests; ++i) {
-			sg_free_table(&video->ureq[i].sgt);
+	struct uvc_request *ureq, *temp;

-			if (video->ureq[i].req) {
-				usb_ep_free_request(video->ep, video->ureq[i].req);
-				video->ureq[i].req = NULL;
-			}
-
-			if (video->ureq[i].req_buffer) {
-				kfree(video->ureq[i].req_buffer);
-				video->ureq[i].req_buffer = NULL;
-			}
-		}
-
-		kfree(video->ureq);
-		video->ureq = NULL;
+	list_for_each_entry_safe(ureq, temp, &video->ureqs, list) {
+		uvc_video_free_request(ureq, video->ep);
 	}

 	INIT_LIST_HEAD(&video->req_free);
@@ -322,6 +350,7 @@ uvc_video_free_requests(struct uvc_video *video)
 static int
 uvc_video_alloc_requests(struct uvc_video *video)
 {
+	struct uvc_request *ureq;
 	unsigned int req_size;
 	unsigned int i;
 	int ret = -ENOMEM;
@@ -332,35 +361,36 @@ uvc_video_alloc_requests(struct uvc_video *video)
 		 * max_t(unsigned int, video->ep->maxburst, 1)
 		 * (video->ep->mult);

-	video->ureq = kcalloc(video->uvc_num_requests, sizeof(struct uvc_request), GFP_KERNEL);
-	if (video->ureq == NULL)
-		return -ENOMEM;
-
-	for (i = 0; i < video->uvc_num_requests; ++i) {
-		video->ureq[i].req_buffer = kmalloc(req_size, GFP_KERNEL);
-		if (video->ureq[i].req_buffer == NULL)
+	INIT_LIST_HEAD(&video->ureqs);
+	for (i = 0; i < video->uvc_num_requests; i++) {
+		ureq = kzalloc(sizeof(struct uvc_request), GFP_KERNEL);
+		if (ureq == NULL)
 			goto error;
+		INIT_LIST_HEAD(&ureq->list);
+		list_add_tail(&ureq->list, &video->ureqs);
+	}

-		video->ureq[i].req = usb_ep_alloc_request(video->ep, GFP_KERNEL);
-		if (video->ureq[i].req == NULL)
+	list_for_each_entry(ureq, &video->ureqs, list) {
+		ureq->req_buffer = kmalloc(req_size, GFP_KERNEL);
+		if (ureq->req_buffer == NULL)
 			goto error;
-
-		video->ureq[i].req->buf = video->ureq[i].req_buffer;
-		video->ureq[i].req->length = 0;
-		video->ureq[i].req->complete = uvc_video_complete;
-		video->ureq[i].req->context = &video->ureq[i];
-		video->ureq[i].video = video;
-		video->ureq[i].last_buf = NULL;
-
-		list_add_tail(&video->ureq[i].req->list, &video->req_free);
+		ureq->req = usb_ep_alloc_request(video->ep, GFP_KERNEL);
+		if (ureq->req == NULL)
+			goto error;
+		ureq->req->buf = ureq->req_buffer;
+		ureq->req->length = 0;
+		ureq->req->complete = uvc_video_complete;
+		ureq->req->context = ureq;
+		ureq->video = video;
+		ureq->last_buf = NULL;
+		list_add_tail(&ureq->req->list, &video->req_free);
 		/* req_size/PAGE_SIZE + 1 for overruns and + 1 for header */
-		sg_alloc_table(&video->ureq[i].sgt,
+		sg_alloc_table(&ureq->sgt,
 			       DIV_ROUND_UP(req_size - UVCG_REQUEST_HEADER_LEN,
 					    PAGE_SIZE) + 2, GFP_KERNEL);
 	}

 	video->req_size = req_size;
-
 	return 0;

 error:
@@ -484,12 +514,68 @@ static void uvcg_video_pump(struct work_struct *work)
 	return;
 }

+/*
+ * Disable video stream. This ensures that any inflight usb requests are marked
+ * for clean up and video buffers are dropped up before returning.
+ */
+static void uvcg_video_disable(struct uvc_video *video)
+{
+	struct uvc_buffer *buf, *tmp_buf;
+	struct uvc_request *ureq, *temp;
+	struct list_head buf_list; /* track in-flight video buffers */
+	struct usb_request *req;
+	unsigned long flags;
+
+	cancel_work_sync(&video->pump);
+	uvcg_queue_cancel(&video->queue, 0);
+
+	INIT_LIST_HEAD(&buf_list);
+	spin_lock_irqsave(&video->req_lock, flags);
+	/* abandon all usb requests */
+	list_for_each_entry_safe(ureq, temp, &video->ureqs, list) {
+		ureq->is_abandoned = true;
+		if (ureq->last_buf) {
+			list_add(&ureq->last_buf->queue, &buf_list);
+			ureq->last_buf = NULL;
+		}
+		list_del_init(&ureq->list);
+		if (ureq->req)
+			usb_ep_dequeue(video->ep, ureq->req);
+	}
+	/*
+	 * re-add uvc_requests currently owned by the gadget to
+	 * video->ureqs to be deallocated
+	 */
+	list_for_each_entry(req, &video->req_free, list) {
+		ureq = req->context;
+		list_add_tail(&ureq->list, &video->ureqs);
+	}
+	spin_unlock_irqrestore(&video->req_lock, flags);
+
+	/*
+	 * drop abandoned uvc_buffers, as the completion handler
+	 * no longer will
+	 */
+	if (!list_empty(&buf_list)) {
+		spin_lock_irqsave(&video->queue.irqlock, flags);
+		list_for_each_entry_safe(buf, tmp_buf,
+						&buf_list, queue) {
+			video->queue.flags |= UVC_QUEUE_DROP_INCOMPLETE;
+			uvcg_complete_buffer(&video->queue, buf);
+			list_del(&buf->queue);
+		}
+		spin_unlock_irqrestore(&video->queue.irqlock, flags);
+	}
+
+	uvc_video_free_requests(video);
+	uvcg_queue_enable(&video->queue, 0);
+}
+
 /*
  * Enable or disable the video stream.
  */
 int uvcg_video_enable(struct uvc_video *video, int enable)
 {
-	unsigned int i;
 	int ret;

 	if (video->ep == NULL) {
@@ -499,15 +585,7 @@ int uvcg_video_enable(struct uvc_video *video, int enable)
 	}

 	if (!enable) {
-		cancel_work_sync(&video->pump);
-		uvcg_queue_cancel(&video->queue, 0);
-
-		for (i = 0; i < video->uvc_num_requests; ++i)
-			if (video->ureq && video->ureq[i].req)
-				usb_ep_dequeue(video->ep, video->ureq[i].req);
-
-		uvc_video_free_requests(video);
-		uvcg_queue_enable(&video->queue, 0);
+		uvcg_video_disable(video);
 		return 0;
 	}

--
2.42.0.459.ge4e396fd5e-goog


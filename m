Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCD87B74BF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbjJCXV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbjJCXV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:21:27 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C8BA6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:21:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a2318df875so21389207b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696375283; x=1696980083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xX0umRmiZ0cLGmGD38f/MibuOBTvqO+eaoVVtdmVDCY=;
        b=nd4Vi0j/kzWHsBJ17zftBwdc6C/M7Msob9+RgKP5gBZxYSHK3vfmFbpJ0RncMTgpu/
         R6RGKa8jBe96fK3O+YKKvkxGJipEsMkwQrQLTV9xPytZcHP6R91aON1heMWcSG+boVmF
         CUkQpvyVhDReZWgzmuOo2/v+kvleNInOiWsIq+LL3Ss/9D+tQK/prAMsH5ur6kyAHOPy
         H12705hfVo5Z7kchSOvXhxHCOALaS/hH6xNlYF6rKHuQOTBnYrnEIosYkAJMqX61MbTP
         W5w52YKfbRhj6+c9qlzr8fteVsxli236ZXDKHtkrehs3YogjxT4OzIacA+t6Fr4VyXZV
         8MJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375283; x=1696980083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xX0umRmiZ0cLGmGD38f/MibuOBTvqO+eaoVVtdmVDCY=;
        b=Ix4TuQxLzeV1Qcek9cfyQ8yebvI2u4qIa+WuTRvJyeyWIZ1FPCdq735PvA1Os2x9KJ
         haqfqWuGQdTUVfyvNPE6N4aRgYWgQDLyFYPZH/8XQDBWSTT6bqQ2llTxS63U6h29Jo9r
         K0Fm3Ujp8xa2f7xUrWy8iKba7P1Eu4/YCtNYBeMun5pkqekvAvGumbjXVoRIhpvxvWtI
         7o7gcJzeY9RDDMWTuhVQzkEkmO9sBGLLO1ycUeFXPhYf93KdR0aCvL5n7mejlFhlXP6U
         zkYDv+6RquWeENv2joJla10r410ZN07TBMcnvj3tiHc3aBpjv0NwIP+DkaHSzgRmL4n7
         QQBA==
X-Gm-Message-State: AOJu0YwZvyK4Gn+K8Pp5WJl6YJ0tK/kgzjlR8jBtWqCrgBpwUziigrD2
        LjEhoQ3O+MN9lnqd7znKCsbPmy3UyFRQ
X-Google-Smtp-Source: AGHT+IGSrWanjAkruP+Az1MmmFYTVYaT8bPHGsJb3wfDLC5Ra2CutV+dDmO/2/x+1U3Y1LlA5xpJrA9Ay0LN
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a81:b3c3:0:b0:59b:eb63:4beb with SMTP id
 r186-20020a81b3c3000000b0059beb634bebmr18764ywh.7.1696375283016; Tue, 03 Oct
 2023 16:21:23 -0700 (PDT)
Date:   Tue,  3 Oct 2023 16:21:20 -0700
In-Reply-To: <20230930184821.310143-4-arakesh@google.com>
Mime-Version: 1.0
References: <20230930184821.310143-4-arakesh@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003232120.2594176-1-arakesh@google.com>
Subject: [PATCH v2 3/3] usb: gadget: uvc: Fix use-after-free for inflight usb_requests
From:   Avichal Rakesh <arakesh@google.com>
To:     arakesh@google.com, dan.scally@ideasonboard.com,
        gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, mgr@pengutronix.de
Cc:     etalvala@google.com, jchowdhary@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
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

Currently, the uvc gadget driver allocates all uvc_requests as one array
and deallocates them all when the video stream stops. This includes
de-allocating all the usb_requests associated with those uvc_requests.
This can lead to use-after-free issues if any of those de-allocated
usb_requests were still owned by the usb controller.

This is patch 2 of 2 in fixing the use-after-free issue. It adds a new
flag to uvc_request to mark it as 'abandoned'. When disabling the video
stream, instead of de-allocating all uvc_requests and usb_requests, the
gadget driver only de-allocates those usb_requests that are currently
owned by the gadget driver (as present in req_free). Other usb_requests
have their corresponding 'is_abandoned' flag tripped, and the
usb_requests complete handler takes care of freeing the usb_request and
its corresponding uvc_request.

This should ensure that uvc gadget driver never accidentally de-allocates
a usb_request that it doesn't own.

Link: https://lore.kernel.org/7cd81649-2795-45b6-8c10-b7df1055020d@google.com
Suggested-by: Michael Grzeschik <mgr@pengutronix.de>
Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
v1 -> v2: Rebased to ToT, and fixed deadlock reported in
          https://lore.kernel.org/all/ZRv2UnKztgyqk2pt@pengutronix.de/

 drivers/usb/gadget/function/uvc.h       |   1 +
 drivers/usb/gadget/function/uvc_video.c | 118 ++++++++++++++++++++----
 2 files changed, 102 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 993694da0bbc..e69cfb7cced1 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -82,6 +82,7 @@ struct uvc_request {
 	u8 header[UVCG_REQUEST_HEADER_LEN];
 	struct uvc_buffer *last_buf;
 	struct list_head list;
+	bool is_abandoned;
 };

 struct uvc_video {
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 3c4d286d81c0..69521886d599 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -271,7 +271,21 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
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
+		uvcg_dbg(&video->uvc->func, "Freeing abandoned usb_request\n");
+		uvc_video_free_request(ureq, ep);
+		return;
+	}

 	if (uvc->state == UVC_STATE_CONNECTED) {
 		usb_ep_free_request(video->ep, ureq->req);
@@ -300,15 +314,29 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
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
+		uvcg_dbg(&video->uvc->func,
+			 "usb_request abandoned mid-processing - freeing.\n");
+		uvc_video_free_request(ureq, ep);
+		return;
+	}
+
 	if (uvc->state == UVC_STATE_STREAMING)
 		queue_work(video->async_wq, &video->pump);
 }
@@ -372,7 +400,6 @@ uvc_video_alloc_requests(struct uvc_video *video)
 	}

 	video->req_size = req_size;
-
 	return 0;

 error:
@@ -504,13 +531,80 @@ static void uvcg_video_pump(struct work_struct *work)
 	return;
 }

+/*
+ * Disable video stream. This ensures that any inflight usb requests are marked
+ * for clean up and all video buffers are dropped before returning.
+ */
+static void uvcg_video_disable(struct uvc_video *video)
+{
+	struct uvc_buffer *buf, *tmp_buf;
+	struct uvc_request *ureq, *temp;
+	struct list_head buf_list; /* track in-flight video buffers */
+	struct usb_request *req;
+	unsigned long flags;
+
+	INIT_LIST_HEAD(&buf_list);
+
+	cancel_work_sync(&video->pump);
+	uvcg_queue_cancel(&video->queue, 0);
+
+	list_for_each_entry(ureq, &video->ureqs, list) {
+		if (ureq->req)
+			usb_ep_dequeue(video->ep, ureq->req);
+	}
+
+	/**
+	 * acquiring req_lock here should prevent any more complete
+	 * callbacks from processing until we've abandoned the
+	 * requests that are still in-flight and let the complete
+	 * callback handle cleanup
+	 */
+	spin_lock_irqsave(&video->req_lock, flags);
+	/* abandon all usb requests */
+	list_for_each_entry_safe(ureq, temp, &video->ureqs, list) {
+		ureq->is_abandoned = true;
+		if (ureq->last_buf) {
+			list_add(&ureq->last_buf->queue, &buf_list);
+			ureq->last_buf = NULL;
+		}
+		list_del_init(&ureq->list);
+	}
+	/*
+	 * re-add uvc_requests currently owned by the gadget to
+	 * video->ureqs to be deallocated. This effectively leaves
+	 * video->ureqs with the requests that we currently own.
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
 	struct uvc_device *uvc = video->uvc;
-	struct uvc_request *ureq;
 	int ret;

 	if (video->ep == NULL) {
@@ -521,17 +615,7 @@ int uvcg_video_enable(struct uvc_video *video, int enable)

 	if (!enable) {
 		uvc->state = UVC_STATE_CONNECTED;
-
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
+		uvcg_video_disable(video);
 		return 0;
 	}

--
2.42.0.582.g8ccd20d70d-goog


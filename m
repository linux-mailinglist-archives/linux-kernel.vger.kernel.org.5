Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DFF7D8AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 23:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjJZV5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 17:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbjJZV5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 17:57:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671D61B8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 14:57:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da13698a6d3so112394276.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 14:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698357420; x=1698962220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xj6XVZNwfxjqWewdiKu4ByaEQplFcBt/XZGTN29oDzw=;
        b=eWKkSCLTk3bCmqhqTNybvimzmBnFbWLhM4749OfetVFr4E19KmdjHvknr9U5Bzx4Cb
         6E5h3Qg8i79ytGopVMl0TOlpHjv2CffQaY7pHPF8i5o9a5BDgaYPlUhS0FjXETcOuF1g
         lRMP6pfSAbMyoXfsPAQoPcw84o8oz4OCoAPyD3bCVilO3Q0c2HAAiLwW4QCLmCq02wjX
         orNeFHTm0/eFjfkP/tSXTfJnLmlrL2fY+iimI271gSveazaTOF511DRdideL/QIa38EN
         Q3HSL98U0G7FFCtHLjpc3FmufeH6/5dnTng3negCYxjaipkhWM73WPp0v4ufMNkOYk9h
         HNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698357420; x=1698962220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xj6XVZNwfxjqWewdiKu4ByaEQplFcBt/XZGTN29oDzw=;
        b=tbhL+MsreZW70JkuIXKTbpqtl1r+P5v6Ns7PTWps2FyMjMn7d2mZI0cwB5KslWHoT4
         ofHxZaPT9+eVNVIjg/8MppGJV+20ckj1fB2IBJ2LKvzksdtiTFBUYGdPkX4R0SG/r+D6
         u2ubwB4ON11WhdOvK4/U5bcANHr+qZY+DD3TEluntRcGFQP40DCv7mS46LwTL9shtnuq
         ynatoQghejTpfdrKqwVF5RPqizcJvhMDfhzLjinTt3jL9ltihBgxS5W5ISXPPP0c7hPG
         BvcrGSYsMwGhGNhHFxNPzvj1gzVv0IinVg4AgI9w3TM2L5Rj/Otae7WNaYAMMFQcAhmj
         uUOQ==
X-Gm-Message-State: AOJu0YxQ7Rbrd2Y80QuPf0O2A7cZVXA0i86nt+yw+yx32q6sVssWDtLB
        gy5oMhCGHXoRBdwJFpnp3O3i81skA6rMBWBw
X-Google-Smtp-Source: AGHT+IGgtVNdC0ZLM9h66ApnqbGSTJ6kzoaktiyJp+osM9r+jx4dQJEwHbSSTqwmj933j/BkA/IZ3h8FMJ7VZEUk
X-Received: from jchowdhary2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:434b])
 (user=jchowdhary job=sendgmr) by 2002:a25:688b:0:b0:da0:46e5:a7ef with SMTP
 id d133-20020a25688b000000b00da046e5a7efmr14266ybc.3.1698357420515; Thu, 26
 Oct 2023 14:57:00 -0700 (PDT)
Date:   Thu, 26 Oct 2023 21:56:35 +0000
In-Reply-To: <ZToOJhyOFeGCGUFj@pengutronix.de>
Mime-Version: 1.0
References: <ZToOJhyOFeGCGUFj@pengutronix.de>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231026215635.2478767-1-jchowdhary@google.com>
Subject: [PATCH v2] usb:gadget:uvc Do not use worker thread to pump usb requests
From:   Jayant Chowdhary <jchowdhary@google.com>
To:     mgr@pengutronix.de, jchowdhary@google.com
Cc:     Thinh.Nguyen@synopsys.com, arakesh@google.com, etalvala@google.com,
        dan.scally@ideasonboard.com, gregkh@linuxfoundation.org,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Michael Grzeschik <m.grzeschik@pengutronix.de>
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

This patch is based on top of
https://lore.kernel.org/linux-usb/20230930184821.310143-1-arakesh@google.com/T/#t:

When we use an async work queue to perform the function of pumping
usb requests to the usb controller, it is possible that thread scheduling
affects at what cadence we're able to pump requests. This could mean usb
requests miss their uframes - resulting in video stream flickers on the host
device.

In this patch, we move the pumping of usb requests to
1) uvcg_video_complete() complete handler for both isoc + bulk
   endpoints. We still send 0 length requests when there is no uvc buffer
   available to encode.
2) uvc_v4l2_qbuf - only for bulk endpoints since it is not legal to send
   0 length requests.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Jayant Chowdhary <jchowdhary@google.com>
Suggested-by: Jayant Chowdhary <jchowdhary@google.com>
Suggested-by: Avichal Rakesh <arakesh@google.com>
Tested-by: Jayant Chowdhary <jchowdhary@google.com>
---
 v1->v2: Fix code style and add self Signed-off-by

 drivers/usb/gadget/function/f_uvc.c     |  4 --
 drivers/usb/gadget/function/uvc.h       |  4 +-
 drivers/usb/gadget/function/uvc_v4l2.c  |  5 +-
 drivers/usb/gadget/function/uvc_video.c | 71 ++++++++++++++++---------
 drivers/usb/gadget/function/uvc_video.h |  2 +
 5 files changed, 51 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index ae08341961eb..53cb2539486d 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -959,14 +959,10 @@ static void uvc_function_unbind(struct usb_configuration *c,
 {
 	struct usb_composite_dev *cdev = c->cdev;
 	struct uvc_device *uvc = to_uvc(f);
-	struct uvc_video *video = &uvc->video;
 	long wait_ret = 1;
 
 	uvcg_info(f, "%s()\n", __func__);
 
-	if (video->async_wq)
-		destroy_workqueue(video->async_wq);
-
 	/*
 	 * If we know we're connected via v4l2, then there should be a cleanup
 	 * of the device from userspace either via UVC_EVENT_DISCONNECT or
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index be0d012aa244..498f344fda4b 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -88,9 +88,6 @@ struct uvc_video {
 	struct uvc_device *uvc;
 	struct usb_ep *ep;
 
-	struct work_struct pump;
-	struct workqueue_struct *async_wq;
-
 	/* Frame parameters */
 	u8 bpp;
 	u32 fcc;
@@ -116,6 +113,7 @@ struct uvc_video {
 	/* Context data used by the completion handler */
 	__u32 payload_size;
 	__u32 max_payload_size;
+	bool is_bulk;
 
 	struct uvc_video_queue queue;
 	unsigned int fid;
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index f4d2e24835d4..678ea6df7b5c 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -414,10 +414,7 @@ uvc_v4l2_qbuf(struct file *file, void *fh, struct v4l2_buffer *b)
 	ret = uvcg_queue_buffer(&video->queue, b);
 	if (ret < 0)
 		return ret;
-
-	if (uvc->state == UVC_STATE_STREAMING)
-		queue_work(video->async_wq, &video->pump);
-
+	uvcg_video_pump_qbuf(video);
 	return ret;
 }
 
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index ab3f02054e85..0fcd8e5edbac 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -24,6 +24,8 @@
  * Video codecs
  */
 
+static void uvcg_video_pump(struct uvc_video *video);
+
 static int
 uvc_video_encode_header(struct uvc_video *video, struct uvc_buffer *buf,
 		u8 *data, int len)
@@ -329,7 +331,9 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	 */
 	if (video->is_enabled) {
 		list_add_tail(&req->list, &video->req_free);
-		queue_work(video->async_wq, &video->pump);
+		spin_unlock_irqrestore(&video->req_lock, flags);
+		uvcg_video_pump(video);
+		return;
 	} else {
 		uvc_video_free_request(ureq, ep);
 	}
@@ -409,20 +413,31 @@ uvc_video_alloc_requests(struct uvc_video *video)
  * Video streaming
  */
 
+void uvcg_video_pump_qbuf(struct uvc_video *video)
+{
+	/*
+	 * Only call uvcg_video_pump() from qbuf, for bulk eps since
+	 * for isoc, the complete handler will call uvcg_video_pump()
+	 * consistently. Calling it for isoc eps, while correct
+	 * will increase contention for video->req_lock since the
+	 * complete handler will be called more often.
+	*/
+	if (video->is_bulk)
+		uvcg_video_pump(video);
+}
+
 /*
  * uvcg_video_pump - Pump video data into the USB requests
  *
  * This function fills the available USB requests (listed in req_free) with
  * video data from the queued buffers.
  */
-static void uvcg_video_pump(struct work_struct *work)
+static void uvcg_video_pump(struct uvc_video *video)
 {
-	struct uvc_video *video = container_of(work, struct uvc_video, pump);
 	struct uvc_video_queue *queue = &video->queue;
-	/* video->max_payload_size is only set when using bulk transfer */
-	bool is_bulk = video->max_payload_size;
 	struct usb_request *req = NULL;
-	struct uvc_buffer *buf;
+	struct uvc_request *ureq = NULL;
+	struct uvc_buffer *buf = NULL, *last_buf = NULL;
 	unsigned long flags;
 	bool buf_done;
 	int ret;
@@ -455,7 +470,8 @@ static void uvcg_video_pump(struct work_struct *work)
 		if (buf != NULL) {
 			video->encode(req, video, buf);
 			buf_done = buf->state == UVC_BUF_STATE_DONE;
-		} else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) && !is_bulk) {
+		} else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) &&
+				!video->is_bulk) {
 			/*
 			 * No video buffer available; the queue is still connected and
 			 * we're transferring over ISOC. Queue a 0 length request to
@@ -500,18 +516,30 @@ static void uvcg_video_pump(struct work_struct *work)
 			req->no_interrupt = 1;
 		}
 
-		/* Queue the USB request */
-		ret = uvcg_video_ep_queue(video, req);
 		spin_unlock_irqrestore(&queue->irqlock, flags);
-
+		spin_lock_irqsave(&video->req_lock, flags);
+		if (video->is_enabled) {
+			/* Queue the USB request */
+			ret = uvcg_video_ep_queue(video, req);
+			/* Endpoint now owns the request */
+			req = NULL;
+			video->req_int_count++;
+		} else {
+			ret =  -ENODEV;
+			ureq = req->context;
+			last_buf = ureq->last_buf;
+			ureq->last_buf = NULL;
+		}
+		spin_unlock_irqrestore(&video->req_lock, flags);
 		if (ret < 0) {
+			if (last_buf != NULL) {
+				// Return the buffer to the queue in the case the
+				// request was not queued to the ep.
+				uvcg_complete_buffer(&video->queue, last_buf);
+			}
 			uvcg_queue_cancel(queue, 0);
 			break;
 		}
-
-		/* Endpoint now owns the request */
-		req = NULL;
-		video->req_int_count++;
 	}
 
 	if (!req)
@@ -556,7 +584,6 @@ uvcg_video_disable(struct uvc_video *video)
 	}
 	spin_unlock_irqrestore(&video->req_lock, flags);
 
-	cancel_work_sync(&video->pump);
 	uvcg_queue_cancel(&video->queue, 0);
 
 	spin_lock_irqsave(&video->req_lock, flags);
@@ -626,14 +653,16 @@ int uvcg_video_enable(struct uvc_video *video, int enable)
 	if (video->max_payload_size) {
 		video->encode = uvc_video_encode_bulk;
 		video->payload_size = 0;
-	} else
+		video->is_bulk = true;
+	} else {
 		video->encode = video->queue.use_sg ?
 			uvc_video_encode_isoc_sg : uvc_video_encode_isoc;
+		video->is_bulk = false;
+	}
 
 	video->req_int_count = 0;
 
-	queue_work(video->async_wq, &video->pump);
-
+	uvcg_video_pump(video);
 	return ret;
 }
 
@@ -646,12 +675,6 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
 	spin_lock_init(&video->req_lock);
-	INIT_WORK(&video->pump, uvcg_video_pump);
-
-	/* Allocate a work queue for asynchronous video pump handler. */
-	video->async_wq = alloc_workqueue("uvcgadget", WQ_UNBOUND | WQ_HIGHPRI, 0);
-	if (!video->async_wq)
-		return -EINVAL;
 
 	video->uvc = uvc;
 	video->fcc = V4L2_PIX_FMT_YUYV;
diff --git a/drivers/usb/gadget/function/uvc_video.h b/drivers/usb/gadget/function/uvc_video.h
index 03adeefa343b..29c6b9a2e9c3 100644
--- a/drivers/usb/gadget/function/uvc_video.h
+++ b/drivers/usb/gadget/function/uvc_video.h
@@ -18,4 +18,6 @@ int uvcg_video_enable(struct uvc_video *video, int enable);
 
 int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc);
 
+void uvcg_video_pump_qbuf(struct uvc_video *video);
+
 #endif /* __UVC_VIDEO_H__ */
-- 
2.42.0.820.g83a721a137-goog


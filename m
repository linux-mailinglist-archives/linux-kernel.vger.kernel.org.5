Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9513B79C4A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjILETx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjILETp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:19:45 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7C7E64
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:19:38 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bf60f85d78so73910595ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694492377; x=1695097177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FoTtHZn5McnPgtWNsfVZSyVXUY1RZpX9ounYkXsDLo=;
        b=m01Afecuhy9AK3GxxTyUuPvu74pfp2YF5BpLxhxSTCguBgYu9/ZbTxh3cRWhTBfUbb
         d481CrU/dV0gARnOvAYUDAN/h3YN6vfizBcQv194JXZdOP2H3gee98/hLKPom8RsHfE0
         e9fCzHuAbchc62yUbTiOJ1mwklZMWsF9aEhl7qUQS55CQrKCs4w5MEOokhSWhKZFRVs8
         RyssCBzXxrJd2Z2bw0Yr4JL9z8kxaFKDU/6XeiYH9LufPuwBwCm3WSMlIrWsObnhXSsN
         byR79q4iSenoZHcQw3nZmgD313yu6HeZ49DV3zVdCBamw3jZw2um1w5nlsSi/cGPtZrY
         ngPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694492377; x=1695097177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FoTtHZn5McnPgtWNsfVZSyVXUY1RZpX9ounYkXsDLo=;
        b=Vw+bH/8+swmOP1As6lFVp0p+QFBd6dHGIMzMZuBxCYBWTQhX6b70otS2D+r5GZJ67H
         ckaEBKDviBS47jxQcqp2vx14VcQBauXTfPjAKm47EEPG/mxh/FGrC7aZ573cZn4+mZqj
         THkTBw9ejDUaaDtWazSw1CcWoasK4Q2O2lI+W2shcuprWe0Yl/YU+NfLBZ/9w5OqIxET
         ui8LkYl1Lr8rvP3QsjC0zIRQ1OmeDIyTczavIw6ZvofHgRcfw8xyqiqx357wvN9qmPUV
         hbj3LCQx1PpWHaB7vvB8RYi6YC/jI4BT6fSULaBef5UsF4K9d54P0lQ/XWF89tsSjUuR
         PUgA==
X-Gm-Message-State: AOJu0YwOjPODUy40bWqpTfYtBpyy10SLPcP4X9zMV9CdsySHJX9RCIaB
        ilgPDFeHNUdWWF91i/KzpVKT40i5MybE
X-Google-Smtp-Source: AGHT+IEjziNcHioUnH4onhylNieAYY2qPb4XrVhqHo+raURB6CW2pn7JG4PBrbjfERTU4xeq4CNwieAL4VEt
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a17:902:e808:b0:1bb:de7f:a4b7 with SMTP id
 u8-20020a170902e80800b001bbde7fa4b7mr4796225plg.10.1694492377612; Mon, 11 Sep
 2023 21:19:37 -0700 (PDT)
Date:   Mon, 11 Sep 2023 21:19:10 -0700
In-Reply-To: <20230912041910.726442-1-arakesh@google.com>
Mime-Version: 1.0
References: <20230912041910.726442-1-arakesh@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912041910.726442-3-arakesh@google.com>
Subject: [PATCH v1 2/2] usb: gadget: uvc: prevent de-allocating inflight usb_requests
From:   Avichal Rakesh <arakesh@google.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Avichal Rakesh <arakesh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when stopping the stream, uvcg_video_enable immediately
deallocates the usb_requests after calling usb_ep_dequeue. However,
usb_ep_dequeue is asynchronous and it is possible that it deallocates an
inflight request. The gadget drivers should wait until the complete
callbacks before assuming ownership of the request.

This patch adds a simple request counting mechanism to track how many
requests are currently owned by the driver. Now when stopping the stream,
uvcg_video_enable waits for all the complete callbacks to come through
before deallocating the usb_requests.

Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
 drivers/usb/gadget/function/uvc.h       |  3 +++
 drivers/usb/gadget/function/uvc_video.c | 31 ++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 989bc6b4e93d..e40e702a7074 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -104,8 +104,11 @@ struct uvc_video {
 	unsigned int req_size;
 	struct uvc_request *ureq;
 	struct list_head req_free;
+	unsigned int req_free_count; /* number of requests in req_free */
 	spinlock_t req_lock;

+	wait_queue_head_t req_free_queue;
+
 	unsigned int req_int_count;

 	void (*encode) (struct usb_request *req, struct uvc_video *video,
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 70ff88854539..3ea7d52df80d 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -284,10 +284,18 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)

 	spin_lock_irqsave(&video->req_lock, flags);
 	list_add_tail(&req->list, &video->req_free);
+	video->req_free_count++;
 	spin_unlock_irqrestore(&video->req_lock, flags);

-	if (uvc->state == UVC_STATE_STREAMING)
+	if (uvc->state == UVC_STATE_STREAMING) {
 		queue_work(video->async_wq, &video->pump);
+	} else if (video->req_free_count == video->req_size) {
+		/*
+		 * Wake up thread waiting for all requests to be returned to
+		 * the gadget driver.
+		 */
+		wake_up_interruptible(&video->req_free_queue);
+	}
 }

 static int
@@ -316,6 +324,7 @@ uvc_video_free_requests(struct uvc_video *video)

 	INIT_LIST_HEAD(&video->req_free);
 	video->req_size = 0;
+	video->req_free_count = 0;
 	return 0;
 }

@@ -360,6 +369,7 @@ uvc_video_alloc_requests(struct uvc_video *video)
 	}

 	video->req_size = req_size;
+	video->req_free_count = req_size; /* all requests are currently free */

 	return 0;

@@ -404,6 +414,7 @@ static void uvcg_video_pump(struct work_struct *work)
 		req = list_first_entry(&video->req_free, struct usb_request,
 					list);
 		list_del(&req->list);
+		video->req_free_count--;
 		spin_unlock_irqrestore(&video->req_lock, flags);

 		/*
@@ -480,6 +491,7 @@ static void uvcg_video_pump(struct work_struct *work)

 	spin_lock_irqsave(&video->req_lock, flags);
 	list_add_tail(&req->list, &video->req_free);
+	video->req_free_count++;
 	spin_unlock_irqrestore(&video->req_lock, flags);
 	return;
 }
@@ -506,6 +518,22 @@ int uvcg_video_enable(struct uvc_video *video, int enable)
 			if (video->ureq && video->ureq[i].req)
 				usb_ep_dequeue(video->ep, video->ureq[i].req);

+		/*
+		 * Wait 500ms for the usb_requests to be given back to the
+		 * gadget driver. This ensures that we don't accidentally
+		 * reference de-allocated usb_requests in the complete callback.
+		 */
+		if (video->req_free_count != video->req_size) {
+			uvcg_info(&video->uvc->func,
+					"Waiting 500ms for usb_request complete callbacks.\n");
+			ret = wait_event_interruptible_timeout(
+					video->req_free_queue,
+					video->req_free_count == video->req_size,
+					msecs_to_jiffies(500));
+			uvcg_info(&video->uvc->func,
+					"Done waiting for complete callbacks: %d\n", ret);
+		}
+
 		uvc_video_free_requests(video);
 		uvcg_queue_enable(&video->queue, 0);
 		return 0;
@@ -538,6 +566,7 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 {
 	INIT_LIST_HEAD(&video->req_free);
 	spin_lock_init(&video->req_lock);
+	init_waitqueue_head(&video->req_free_queue);
 	INIT_WORK(&video->pump, uvcg_video_pump);

 	/* Allocate a work queue for asynchronous video pump handler. */
--
2.42.0.283.g2d96d420d3-goog


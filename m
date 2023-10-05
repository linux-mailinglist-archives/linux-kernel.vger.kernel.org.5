Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F167BA8B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjJESJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjJESIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:08:30 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94510124
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:08:21 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-56f75e70190so940023a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 11:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696529301; x=1697134101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IkpdLXIt9+7FxRDrbqZkUhDTP8vYUcMsBTcxO7grRS4=;
        b=ovGOLpxhv3kCLd0KOhKHtNXY/UcTgYeJIW5drJhk4Gieo4TeUirKDioDoUM4iIYHAo
         UqDB61bKMFL7vXMsX2QN2od4kFicnrNGyEQ4kgkmckYE2JqIcrI2aK5v0wj6RQwbL4Xr
         /a/Ary9xWJSbUpn9dpv9iqvqQM2Sl+Xpu095XOIO9plnihPl8ZFhKnzxQRuH7tquPUxZ
         YqxjXlQMQydgQO3oznOjFKLIZ1z4tw6dBMq2csmCGaFuaofnwoe7zQdQfvzXiOL5KHay
         sX0VtFSXkaiVmL3GAUuzw/0JJJNfoU49RZ26MPbWsTBRCtcxCvQi6zAxj4ifOr84J+Gy
         yKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696529301; x=1697134101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkpdLXIt9+7FxRDrbqZkUhDTP8vYUcMsBTcxO7grRS4=;
        b=Ar0lb0Fk5Sa1o4D9+CVAUv7pF5qkXIm7RqdSNPXvCU/inFh3uu8qg4NwbzoFImM9yL
         sjfDQjGKhjFANcPy6kYkEPk3WOYfI3bt+1CwiNWVpy3u5c8oN9MRzE+18i6Xi1oUoRN8
         rjnaxf73jA6kYR3g9aONSH82HZ6Igiqb5HWHzNrItwn7EXgQmZw3hMHwJ4PrTwgxctGA
         CZbT9Xn7DXTbIk9GsGJ4M9oDerDcHCUKCJ6m+wMA83pXEblxX/7Dovc6ni2ooJ121BO8
         i63+NXn4GGmv4W9rA7RGtZCwyxZ6uvkRmRMPlPhNwFZDN9/2rU4L7Gf4OrS+xzXn9iza
         e3pw==
X-Gm-Message-State: AOJu0YxAD/5CbfRaUNbt8TvDvw/ETW1qTR4eJKaisxUoDlXISzs3cmNF
        je+xX388rnQGwElmBoSkVFEzy04qfUdS
X-Google-Smtp-Source: AGHT+IH213TFECOejx1F7cJTbvghqy0D8oRoVL733NVY02HU1dFc0Xk6yqI9KiscnQOlVOhWaCUKLrus0GG1
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a63:3ecd:0:b0:585:554c:27b1 with SMTP id
 l196-20020a633ecd000000b00585554c27b1mr80021pga.7.1696529301045; Thu, 05 Oct
 2023 11:08:21 -0700 (PDT)
Date:   Thu,  5 Oct 2023 11:08:13 -0700
In-Reply-To: <20231005180814.3278050-1-arakesh@google.com>
Mime-Version: 1.0
References: <20230930184821.310143-1-arakesh@google.com> <20231005180814.3278050-1-arakesh@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231005180814.3278050-2-arakesh@google.com>
Subject: [PATCH v3 2/3] usb: gadget: uvc: Allocate uvc_requests one at a time
From:   Avichal Rakesh <arakesh@google.com>
To:     arakesh@google.com, dan.scally@ideasonboard.com,
        gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de
Cc:     etalvala@google.com, jchowdhary@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Michael Grzeschik <mgr@pengutronix.de>
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

This patch is 1 of 2 patches addressing the use-after-free issue.
Instead of bulk allocating all uvc_requests as an array, this patch
allocates uvc_requests one at a time, which should allows for similar
granularity when deallocating the uvc_requests. This patch has no
functional changes other than allocating each uvc_request separately,
and similarly freeing each of them separately.

Link: https://lore.kernel.org/7cd81649-2795-45b6-8c10-b7df1055020d@google.com
Suggested-by: Michael Grzeschik <mgr@pengutronix.de>
Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
v1 -> v2: Rebased to ToT
V2 -> V3: Fix email threading goof-up

 drivers/usb/gadget/function/uvc.h       |  3 +-
 drivers/usb/gadget/function/uvc_video.c | 90 ++++++++++++++-----------
 2 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 989bc6b4e93d..993694da0bbc 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -81,6 +81,7 @@ struct uvc_request {
 	struct sg_table sgt;
 	u8 header[UVCG_REQUEST_HEADER_LEN];
 	struct uvc_buffer *last_buf;
+	struct list_head list;
 };

 struct uvc_video {
@@ -102,7 +103,7 @@ struct uvc_video {

 	/* Requests */
 	unsigned int req_size;
-	struct uvc_request *ureq;
+	struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
 	struct list_head req_free;
 	spinlock_t req_lock;

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 97d875c27dcf..3c4d286d81c0 100644
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
+		list_del_init(&ureq->list);
+
+	kfree(ureq);
+}
+
 static int uvcg_video_ep_queue(struct uvc_video *video, struct usb_request *req)
 {
 	int ret;
@@ -299,27 +316,13 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 static int
 uvc_video_free_requests(struct uvc_video *video)
 {
-	unsigned int i;
-
-	if (video->ureq) {
-		for (i = 0; i < video->uvc_num_requests; ++i) {
-			sg_free_table(&video->ureq[i].sgt);
-
-			if (video->ureq[i].req) {
-				usb_ep_free_request(video->ep, video->ureq[i].req);
-				video->ureq[i].req = NULL;
-			}
+	struct uvc_request *ureq, *temp;

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

+	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
 	video->req_size = 0;
 	return 0;
@@ -328,6 +331,7 @@ uvc_video_free_requests(struct uvc_video *video)
 static int
 uvc_video_alloc_requests(struct uvc_video *video)
 {
+	struct uvc_request *ureq;
 	unsigned int req_size;
 	unsigned int i;
 	int ret = -ENOMEM;
@@ -338,29 +342,31 @@ uvc_video_alloc_requests(struct uvc_video *video)
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
@@ -504,7 +510,7 @@ static void uvcg_video_pump(struct work_struct *work)
 int uvcg_video_enable(struct uvc_video *video, int enable)
 {
 	struct uvc_device *uvc = video->uvc;
-	unsigned int i;
+	struct uvc_request *ureq;
 	int ret;

 	if (video->ep == NULL) {
@@ -519,9 +525,10 @@ int uvcg_video_enable(struct uvc_video *video, int enable)
 		cancel_work_sync(&video->pump);
 		uvcg_queue_cancel(&video->queue, 0);

-		for (i = 0; i < video->uvc_num_requests; ++i)
-			if (video->ureq && video->ureq[i].req)
-				usb_ep_dequeue(video->ep, video->ureq[i].req);
+		list_for_each_entry(ureq, &video->ureqs, list) {
+			if (ureq->req)
+				usb_ep_dequeue(video->ep, ureq->req);
+		}

 		uvc_video_free_requests(video);
 		uvcg_queue_enable(&video->queue, 0);
@@ -555,6 +562,7 @@ int uvcg_video_enable(struct uvc_video *video, int enable)
  */
 int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 {
+	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
 	spin_lock_init(&video->req_lock);
 	INIT_WORK(&video->pump, uvcg_video_pump);
--
2.42.0.609.gbb76f46606-goog

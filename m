Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F357B74B4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjJCXUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjJCXUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:20:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243CEAB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:20:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d848694462aso1848093276.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696375201; x=1696980001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a9F/CsgN+I3aKYDGh78e89+RvKvnGhCoOINQE/TaiJM=;
        b=2Al8PCCAeqOt2ZY/IpRVRAfx99jz0+W4MKczNHNcarodPdjda2d5FNBCLASTb5fPRc
         UlugbHFdKap274tFo9MhrAyh2z+W6fxdOcLJH+TEH+KRshPUAi2a3Q8SInnfo59pUR44
         DREPnG6h8mHW4Y/XTvdWZYu7grX1JWCGOA7QyLdRex+yRf+EP4bx6Zrk6Qq/7eOG04QL
         QSMy0aPK7CtKdh7G68tF3ckp/y8IFc44ZdteWuVOb8LgNZKGnVh+U30jlNBMS+xuBmpm
         H/0EToLTneRxmHzxFweqBvtjfVQqM6w7vONiEG1Il7XhaWBpCTYxWUEO6GidDMPOMY2F
         EVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375201; x=1696980001;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9F/CsgN+I3aKYDGh78e89+RvKvnGhCoOINQE/TaiJM=;
        b=ESTp0dsNBjf6aJ/hp/UXFkPceKKd2rY5jBfIZENSlWWMcdJB0JD+L7Dt0LF7K/jiDz
         hZC5yQR3vA33MTLJAsq4o72Isfmjgo+qNBvrVTKKUVgCLmmlULKu9gZSvVTeF0bDwiEe
         zniaX71EK28UDnHTApuEWODaaznLMBMVJjeMFWffIcYQncQwttNZbV/dgBCbND0wlzyC
         eYHOdJdLcASYmXnyHEmgv9171wj1fWi6HaPLR3J9Fql2fxemDkglX5jXtQq5sBgSqtbP
         zHhoh/cuP/CuQvMuxj0yZo7hpSalfysIIEJ0EW5d1j4cN3xSz7YyOX2vzI6EOyJpTvWm
         fJPg==
X-Gm-Message-State: AOJu0YwvmmVYfHHzA4x68Qv+WuLlvFv1cYejrI8WzOGfq8dGHBpxRzis
        rBsQKCxydwhoq+RAD7FWr7fj5dEISQ+U
X-Google-Smtp-Source: AGHT+IEqxIxPiX43dqxacLO7c7zk2DqU5E+LmJjAXC6P+m0sQhzYCJ5/5OXuDzjYANESHSkndu7IG3gLONvI
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a25:bcd:0:b0:d7f:2cb6:7d8c with SMTP id
 196-20020a250bcd000000b00d7f2cb67d8cmr10653ybl.13.1696375201361; Tue, 03 Oct
 2023 16:20:01 -0700 (PDT)
Date:   Tue,  3 Oct 2023 16:19:58 -0700
In-Reply-To: <20230930184821.310143-3-arakesh@google.com>
Mime-Version: 1.0
References: <20230930184821.310143-3-arakesh@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003231958.2592275-1-arakesh@google.com>
Subject: [PATCH v2 2/3] usb: gadget: uvc: Allocate uvc_requests one at a time
From:   Avichal Rakesh <arakesh@google.com>
To:     arakesh@google.com, dan.scally@ideasonboard.com,
        gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, mgr@pengutronix.de
Cc:     etalvala@google.com, jchowdhary@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
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
2.42.0.582.g8ccd20d70d-goog


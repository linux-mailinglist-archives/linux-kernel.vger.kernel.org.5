Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988E07B74B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbjJCXTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbjJCXTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:19:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C498E9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:19:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d817775453dso1769846276.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696375141; x=1696979941; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ArVoPjwYMHkkpCMoH+/iCkmQnlykQeUcYYwAmxq8LD0=;
        b=WydiE7B3N+hxLrGCWv4r4W2+Hd07tS0rkcgTxOlIh7Keo6dQK21MkUankHbAc5gPHM
         yTxnTiLLsGXswPhpSHpS4YGFvuedVq451ocS1KZjVmrC7j5gvw/425UlojvMTGzg0/xs
         Et8+UBWiGq+zV+6OH4AWSd+E8Y7xruiXGkS3mF5N7ZY3cNFxBdoPqMZB1ccMvQoEeRfe
         LCykC8MARovqNllAv5cOU1+7CxbaH8w1h1uUV/K2NWXrKJVQ2JSPRnWWYhx1rRa1dQm8
         jlyR3VFClwnKlS+OUqXzxL/RkXpdMiYDulE86FaODXDFtPpYxjbCyI+nqJyfbZV9uOh9
         ln7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375141; x=1696979941;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ArVoPjwYMHkkpCMoH+/iCkmQnlykQeUcYYwAmxq8LD0=;
        b=v7+j8K0zcyhycALkhwOj5pV01/SdsNOFraOE1gt1r3ivxMSVkw6cCJbVkX5vR/OJT4
         Wt2G0iQFCljdh2C0H558cT3Uabd4ifZpT7qQp451VC2sL3ZWMrKGdoaXMUkae6Ty/awZ
         fbdjxh0jgc1Lqd1TU/ATq55hJ7QaBe53MHeu70SWPkk98RcS/F0rGIg6ZSOJXuEtlgcE
         aqWNkVbP6SbLSxAW+RgoxsmoN+o6SxWDj6dzpHet5MaC5BpM4dkCiOtyDJtJ2eFZQJfv
         8ZxxB+tD7Ps88AchRwNSOoSJ/ZXbZu/z+pNucjxHCYtSTx5lViLWKvtPh1swc+I0ZG/l
         OdtQ==
X-Gm-Message-State: AOJu0YwuDB4QRA0ALu1sRiuYcWCUk//X2yxQCdj0W0u2w9UxYdnahBgf
        UC8FyQd9xexzSApTvzuY/tYkzqsWLfAs
X-Google-Smtp-Source: AGHT+IFSGzebqILp0IStIPy/7RKYqInAfboPET5jE6hqmI9IOEaPOwoqZFGZGSwEg2T7/Xb7Encqp+EjDHJG
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a25:f816:0:b0:d84:e73f:6f8c with SMTP id
 u22-20020a25f816000000b00d84e73f6f8cmr9891ybd.6.1696375141136; Tue, 03 Oct
 2023 16:19:01 -0700 (PDT)
Date:   Tue,  3 Oct 2023 16:18:56 -0700
In-Reply-To: <20230930184821.310143-2-arakesh@google.com>
Mime-Version: 1.0
References: <20230930184821.310143-2-arakesh@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003231856.2591708-1-arakesh@google.com>
Subject: [PATCH v2 1/3] usb: gadget: uvc: prevent use of disabled endpoint
From:   Avichal Rakesh <arakesh@google.com>
To:     arakesh@google.com, dan.scally@ideasonboard.com,
        gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com,
        mgr@pengutronix.de
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

Currently the set_alt callback immediately disables the endpoint and queues
the v4l2 streamoff event. However, as the streamoff event is processed
asynchronously, it is possible that the video_pump thread attempts to queue
requests to an already disabled endpoint.

This change moves disabling usb endpoint to the end of streamoff event
callback. To be consistent with the actual streaming state, uvc->state
is now toggled between CONNECTED and STREAMING from the v4l2 event
callback only.

Link: https://lore.kernel.org/20230615171558.GK741@pendragon.ideasonboard.com/
Link: https://lore.kernel.org/20230531085544.253363-1-dan.scally@ideasonboard.com/
Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
v1 -> v2: Rebased to ToT and reworded commit message.

 drivers/usb/gadget/function/f_uvc.c    | 11 +++++------
 drivers/usb/gadget/function/f_uvc.h    |  2 +-
 drivers/usb/gadget/function/uvc.h      |  2 +-
 drivers/usb/gadget/function/uvc_v4l2.c | 21 ++++++++++++++++++---
 4 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index faa398109431..75c9f9a3f884 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -263,10 +263,13 @@ uvc_function_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 	return 0;
 }

-void uvc_function_setup_continue(struct uvc_device *uvc)
+void uvc_function_setup_continue(struct uvc_device *uvc, int disable_ep)
 {
 	struct usb_composite_dev *cdev = uvc->func.config->cdev;

+	if (disable_ep && uvc->video.ep) {
+		usb_ep_disable(uvc->video.ep);
+	}
 	usb_composite_setup_continue(cdev);
 }

@@ -337,15 +340,11 @@ uvc_function_set_alt(struct usb_function *f, unsigned interface, unsigned alt)
 		if (uvc->state != UVC_STATE_STREAMING)
 			return 0;

-		if (uvc->video.ep)
-			usb_ep_disable(uvc->video.ep);
-
 		memset(&v4l2_event, 0, sizeof(v4l2_event));
 		v4l2_event.type = UVC_EVENT_STREAMOFF;
 		v4l2_event_queue(&uvc->vdev, &v4l2_event);

-		uvc->state = UVC_STATE_CONNECTED;
-		return 0;
+		return USB_GADGET_DELAYED_STATUS;

 	case 1:
 		if (uvc->state != UVC_STATE_CONNECTED)
diff --git a/drivers/usb/gadget/function/f_uvc.h b/drivers/usb/gadget/function/f_uvc.h
index 1db972d4beeb..e7f9f13f14dc 100644
--- a/drivers/usb/gadget/function/f_uvc.h
+++ b/drivers/usb/gadget/function/f_uvc.h
@@ -11,7 +11,7 @@

 struct uvc_device;

-void uvc_function_setup_continue(struct uvc_device *uvc);
+void uvc_function_setup_continue(struct uvc_device *uvc, int disale_ep);

 void uvc_function_connect(struct uvc_device *uvc);

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 6751de8b63ad..989bc6b4e93d 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -177,7 +177,7 @@ struct uvc_file_handle {
  * Functions
  */

-extern void uvc_function_setup_continue(struct uvc_device *uvc);
+extern void uvc_function_setup_continue(struct uvc_device *uvc, int disable_ep);
 extern void uvc_function_connect(struct uvc_device *uvc);
 extern void uvc_function_disconnect(struct uvc_device *uvc);

diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index 3f0a9795c0d4..3d3469883ed0 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -451,7 +451,7 @@ uvc_v4l2_streamon(struct file *file, void *fh, enum v4l2_buf_type type)
 	 * Complete the alternate setting selection setup phase now that
 	 * userspace is ready to provide video frames.
 	 */
-	uvc_function_setup_continue(uvc);
+	uvc_function_setup_continue(uvc, 0);
 	uvc->state = UVC_STATE_STREAMING;

 	return 0;
@@ -463,11 +463,19 @@ uvc_v4l2_streamoff(struct file *file, void *fh, enum v4l2_buf_type type)
 	struct video_device *vdev = video_devdata(file);
 	struct uvc_device *uvc = video_get_drvdata(vdev);
 	struct uvc_video *video = &uvc->video;
+	int ret = 0;

 	if (type != video->queue.queue.type)
 		return -EINVAL;

-	return uvcg_video_enable(video, 0);
+	uvc->state = UVC_STATE_CONNECTED;
+	ret = uvcg_video_enable(video, 0);
+	if (ret < 0) {
+		return ret;
+	}
+
+	uvc_function_setup_continue(uvc, 1);
+	return 0;
 }

 static int
@@ -500,6 +508,14 @@ uvc_v4l2_subscribe_event(struct v4l2_fh *fh,
 static void uvc_v4l2_disable(struct uvc_device *uvc)
 {
 	uvc_function_disconnect(uvc);
+	if (uvc->state == UVC_STATE_STREAMING) {
+		/*
+		 * Drop uvc->state to CONNECTED if it was streaming before.
+		 * This ensures that the usb_requests are no longer queued
+		 * to the controller.
+		 */
+		uvc->state = UVC_STATE_CONNECTED;
+	}
 	uvcg_video_enable(&uvc->video, 0);
 	uvcg_free_buffers(&uvc->video.queue);
 	uvc->func_connected = false;
@@ -647,4 +663,3 @@ const struct v4l2_file_operations uvc_v4l2_fops = {
 	.get_unmapped_area = uvcg_v4l2_get_unmapped_area,
 #endif
 };
-
--
2.42.0.582.g8ccd20d70d-goog


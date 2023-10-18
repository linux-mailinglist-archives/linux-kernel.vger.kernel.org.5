Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAA07CE808
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjJRTqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjJRTqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:46:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF5B112
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:46:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a88f9a1cf7so49525257b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697658403; x=1698263203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wazq6oxL63t4WK65yHIQsChGr02y7yPq4mkDkJPS1lI=;
        b=yBuI7vqGYV937YH8bRXnsQBr7GgLNVJW87gdSZ5VZVSHNuVzCwV8O41Y5BId7ZlzlN
         JICtdvUfmA56jjsdN5is6jtqaEiPBCv/M6JJaIYCKXxcif1rQXSBnWqILNgNHUaI6iH0
         I4pS+C0TL7pKGDuUkmsF05dNws6zYjqEiTsc+GTqHfmoJ6Dy4aPx5IjzFpilG5C9xDX4
         zLiOKWH7//7DLGBRhfwpXrJ/Cpts869a/8aQoandLd9fcimoHaCv7SkS+1B/iwDdHMq/
         UQx1ZCX+lnheQNqLJybJmt8UvkDzxVBwLtE/WkQxV0gN2M9ntmCQy6kdgcaWyWsboUlJ
         NbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697658403; x=1698263203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wazq6oxL63t4WK65yHIQsChGr02y7yPq4mkDkJPS1lI=;
        b=qXv+7uoXg9EBEFijAFkCgVVVSzWhCcgVD4NxggX2DGeaPPo7uWZAQZdmgULX4t3Kwe
         VXl/QjEU0ndEE06Rt9DoCbQFcq6M9SKVL/EH8o6AHwP+SmIzgf+X0OGR+P/+2feDW+Q0
         BhNhbmddCb/IP8gS5gwXZCD4c+DoaIfyA67V+mQfd+q0nqfroWhl7BGcklbV7FlQon/H
         afUkurB1Df2ea6vPXeuF7cR9kFJjHemeW+aH/IA5/LkxPN2iozxECc3b+yaBKsv5GoFs
         5HFVIm9wj3bJ1VSGZybrpMaLPkjKn78h2L6hn0uCr7vIXgA++z2e5572iIX4WxWuDfBI
         meHw==
X-Gm-Message-State: AOJu0Yx71bKpHau+iKU7vZoy4M91mHd1/fsex17FeUh3hl/7lR0ZsaDf
        N6ceZ8MwXasq1wceZ6y5DKOFfbjj9xUz
X-Google-Smtp-Source: AGHT+IG8AcCB3JfVpB3VCsrBZOxctE7QIMb3NeGNL9VMrYruPW7eR7/H71EE/aqE4bot844Rim6PoZy72OoI
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a05:6902:52:b0:d9b:f88c:ca2b with SMTP id
 m18-20020a056902005200b00d9bf88cca2bmr8249ybh.11.1697658403560; Wed, 18 Oct
 2023 12:46:43 -0700 (PDT)
Date:   Wed, 18 Oct 2023 12:46:36 -0700
In-Reply-To: <20230930184821.310143-1-arakesh@google.com>
Mime-Version: 1.0
References: <20230930184821.310143-1-arakesh@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231018194638.2446575-1-arakesh@google.com>
Subject: [PATCH v5 1/3] usb: gadget: uvc: prevent use of disabled endpoint
From:   Avichal Rakesh <arakesh@google.com>
To:     arakesh@google.com, dan.scally@ideasonboard.com,
        gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de
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
callback. As the endpoint's state can no longer be used, video_pump is
now guarded by uvc->state as well. To be consistent with the actual
streaming state, uvc->state is now toggled between CONNECTED and STREAMING
from the v4l2 event callback only.

Link: https://lore.kernel.org/20230615171558.GK741@pendragon.ideasonboard.com/
Link: https://lore.kernel.org/20230531085544.253363-1-dan.scally@ideasonboard.com/
Reviewed-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Tested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
v1 -> v2: Rebased to ToT and reworded commit message.
v2 -> v3: Fix email threading goof-up
v3 -> v4: Address review comments & re-rebase to ToT
v4 -> v5: Add Reviewed-by & Tested-by

 drivers/usb/gadget/function/f_uvc.c     | 11 +++++------
 drivers/usb/gadget/function/f_uvc.h     |  2 +-
 drivers/usb/gadget/function/uvc.h       |  2 +-
 drivers/usb/gadget/function/uvc_v4l2.c  | 20 +++++++++++++++++---
 drivers/usb/gadget/function/uvc_video.c |  3 ++-
 5 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index faa398109431..ae08341961eb 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -263,10 +263,13 @@ uvc_function_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 	return 0;
 }

-void uvc_function_setup_continue(struct uvc_device *uvc)
+void uvc_function_setup_continue(struct uvc_device *uvc, int disable_ep)
 {
 	struct usb_composite_dev *cdev = uvc->func.config->cdev;

+	if (disable_ep && uvc->video.ep)
+		usb_ep_disable(uvc->video.ep);
+
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
index 3f0a9795c0d4..7cb8d027ff0c 100644
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
@@ -463,11 +463,18 @@ uvc_v4l2_streamoff(struct file *file, void *fh, enum v4l2_buf_type type)
 	struct video_device *vdev = video_devdata(file);
 	struct uvc_device *uvc = video_get_drvdata(vdev);
 	struct uvc_video *video = &uvc->video;
+	int ret = 0;

 	if (type != video->queue.queue.type)
 		return -EINVAL;

-	return uvcg_video_enable(video, 0);
+	uvc->state = UVC_STATE_CONNECTED;
+	ret = uvcg_video_enable(video, 0);
+	if (ret < 0)
+		return ret;
+
+	uvc_function_setup_continue(uvc, 1);
+	return 0;
 }

 static int
@@ -500,6 +507,14 @@ uvc_v4l2_subscribe_event(struct v4l2_fh *fh,
 static void uvc_v4l2_disable(struct uvc_device *uvc)
 {
 	uvc_function_disconnect(uvc);
+	/*
+	 * Drop uvc->state to CONNECTED if it was streaming before.
+	 * This ensures that the usb_requests are no longer queued
+	 * to the controller.
+	 */
+	if (uvc->state == UVC_STATE_STREAMING)
+		uvc->state = UVC_STATE_CONNECTED;
+
 	uvcg_video_enable(&uvc->video, 0);
 	uvcg_free_buffers(&uvc->video.queue);
 	uvc->func_connected = false;
@@ -647,4 +662,3 @@ const struct v4l2_file_operations uvc_v4l2_fops = {
 	.get_unmapped_area = uvcg_v4l2_get_unmapped_area,
 #endif
 };
-
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 91af3b1ef0d4..c334802ac0a4 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -384,13 +384,14 @@ static void uvcg_video_pump(struct work_struct *work)
 	struct uvc_video_queue *queue = &video->queue;
 	/* video->max_payload_size is only set when using bulk transfer */
 	bool is_bulk = video->max_payload_size;
+	struct uvc_device *uvc = video->uvc;
 	struct usb_request *req = NULL;
 	struct uvc_buffer *buf;
 	unsigned long flags;
 	bool buf_done;
 	int ret;

-	while (video->ep->enabled) {
+	while (uvc->state == UVC_STATE_STREAMING && video->ep->enabled) {
 		/*
 		 * Retrieve the first available USB request, protected by the
 		 * request lock.
--
2.42.0.758.gaed0368e0e-goog

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD067E617D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjKIAlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKIAlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:41:11 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B72A2693
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 16:41:09 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b02ed0f886so4469067b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 16:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699490468; x=1700095268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H3EiwN1qoUJxzkJq7np8tfIJfl4CuGSTuhpyOd2tJ0s=;
        b=4kFlzVHvsQH9kXbIcIS917dp+b+1apoiiGwUo4dY2KCLiruw0L35IjaBsdnI5tj0bT
         VbcQeqqOVuPMbQJ4fKRH0ckABnfqC5FhsRpFM3oTkD66SsTA1HOwYaavsrw3AbJT1DHR
         lrfctQ0NLRjGESZ0m1K4tHQKIQEe3w91Zm3LxO0Mg1LZoC6vUWJQg7EfkxZ3AMWuWZJf
         X2gL1EH8hyfhlOOVHgiNvDlu2899RM56PpeAxzjDXDcKybe4gFT4o0ZPl06g2cBzwLdT
         1TCY3A52S3P/pxlyHRAqpakk/S++rDIm9NmpPvorkgTF5tq6aExRLYXlGhgodP3SVD2c
         LYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699490468; x=1700095268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H3EiwN1qoUJxzkJq7np8tfIJfl4CuGSTuhpyOd2tJ0s=;
        b=sHAs4/sUhHSvuydO3QQ86DAMUluBj5oJRzFr/1AEgRIwJNwGc90jcnwhGhglC07gJE
         wrdqXGnmIvqpDwhgMpmoWSVvGQoZ1HArjrtvVnBYYyEeHpWqFJFTJgYuZq6x9LcclPP1
         eVXWM0PRBUynz//rwREymLN2BGCoNeI9YIgaiDvVqx9woX1xtV/khg3OzMKnEEkdM3le
         Vv8coa2ww99o29VMcNZImerBMiUR+QQEKfpWAvolYzLnhh10DTX70KO8iW4BR5t5ypRQ
         1RguPpP4sOvH8PU0eIKlr3XTNvHzps4h0CCGk423HrQDl5/CokVZZtDEgLMyk/jKMQpZ
         NRKw==
X-Gm-Message-State: AOJu0YwPp7Y8C35CvEeVtkwvgSVbjuXYIFu2We8RI7KQrM9mHUxKYrk/
        iK4D4+rOj9938FUIhREM4RqkaR+E7lQx
X-Google-Smtp-Source: AGHT+IFO7FYCH0Og+ExNPyGA7Cj94s+xhLX9PbzDvB0wr2/zfk7+nwV/0djWkSPigUu0wJNy8wlRTjgVyTkB
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a0d:d752:0:b0:59b:e97e:f7df with SMTP id
 z79-20020a0dd752000000b0059be97ef7dfmr100355ywd.2.1699490468293; Wed, 08 Nov
 2023 16:41:08 -0800 (PST)
Date:   Wed,  8 Nov 2023 16:41:01 -0800
In-Reply-To: <73309396-3856-43a2-9a6f-81a40ed594db@google.com>
Mime-Version: 1.0
References: <73309396-3856-43a2-9a6f-81a40ed594db@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231109004104.3467968-1-arakesh@google.com>
Subject: [PATCH v12 1/4] usb: gadget: uvc: prevent use of disabled endpoint
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
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Reviewed-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Tested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
v1  -> v2  : Rebased to ToT and reworded commit message.
v2  -> v3  : Fix email threading goof-up
v3  -> v4  : Address review comments & re-rebase to ToT
v4  -> v5  : Add Reviewed-by & Tested-by
v5  -> v6  : No change
v6  -> v7  : No change
v7  -> v8  : No change. Getting back in review queue
v8  -> v9  : Fix typo. No functional change.
v9  -> v10 : Rebase to ToT (usb-next)
v10 -> v11 : No change
v11 -> v12 : Rebase to ToT (usb-next)

 drivers/usb/gadget/function/f_uvc.c     | 11 +++++------
 drivers/usb/gadget/function/f_uvc.h     |  2 +-
 drivers/usb/gadget/function/uvc.h       |  2 +-
 drivers/usb/gadget/function/uvc_v4l2.c  | 20 +++++++++++++++++---
 drivers/usb/gadget/function/uvc_video.c |  3 ++-
 5 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 786379f1b7b7..77999ed53d33 100644
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
index 1db972d4beeb..083aef0c65c6 100644
--- a/drivers/usb/gadget/function/f_uvc.h
+++ b/drivers/usb/gadget/function/f_uvc.h
@@ -11,7 +11,7 @@

 struct uvc_device;

-void uvc_function_setup_continue(struct uvc_device *uvc);
+void uvc_function_setup_continue(struct uvc_device *uvc, int disable_ep);

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
2.42.0.869.gea05f2083d-goog

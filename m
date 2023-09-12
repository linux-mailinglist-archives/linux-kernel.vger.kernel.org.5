Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B1B79C4A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjILETo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjILETj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:19:39 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CA81BE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:19:35 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56c556b5aceso6906972a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694492375; x=1695097175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NUt0ePSVkhiVTD3YqchYHP4wGyuRh1Xi9jvupkBpj0M=;
        b=i//bJjHlxbhXMfT+5h63w/OTZ6Y6PVvRllKc8UFty5eHzac+RVZ0ktj9M9oWZJxg8o
         k7GD59TXMAreMqdlqbQ4vuLCIhcWn5/0qlhMf3iePeQKsL5HnwR/wKwv+QL+5pUd4B0j
         XN3pUL3tDo8C2AsbyDwBCl8xdkj3Ya3dOJ+dQ2rwOKTZ7Je8vDrrxvBqFRj5cSsIxD7W
         NEZY1FySZlaWMhb7Y8a9qM4W4p6hVahv50aCAH0SDcbURQGmLj9jLebiNlvx/j5Ep4Z3
         Aalt4eqA+ggkENhSmlTxyXZoknWMXa1hBqhH+27IGQKR5VkCeFXroKi+SkGEhPBy1cIe
         KNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694492375; x=1695097175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUt0ePSVkhiVTD3YqchYHP4wGyuRh1Xi9jvupkBpj0M=;
        b=tkfzBGokkoF85J7lxF11lckaQMtjb7zrHEnBmd8guRlG51gnPe4eJG6QP2KNsSOI89
         +rG3hdaEu89yQKKydIV8QjVNY6HuyMfzS65CJ7eLmT4TxU3CTTSFzRF4tIh9QrvOnWeV
         hf52EL55ZnAt/WVmNYUz6iSSqwhzm2J+6mR+JAPGmuRCDerQx4AVQHrUyUd629/jU4A9
         7kPdyKumfN+5BgKYyK3Gvky6pjQbgda/bJApdrfXC1QNA6EgvGd4Yg+zkupJsIgtzovU
         uIs7FD5ao5T1Nio3Ombt1K6+0Ds7kUxOiXr6GN8zzvN2DV8NhVAdkY0oEZ22kVGja5X5
         FB6A==
X-Gm-Message-State: AOJu0Yz+3JQRJcElhuSM1Yv77aASyS9Ba4xYdEQGbQIp0LQbY5qETmMt
        aepH4/yHVJwSCJwLvIoCCQQptIeruqZl
X-Google-Smtp-Source: AGHT+IHtEWOZ7TyYlnNxo65RAiYznJuUj92woCNmuCaylZUkFJKgip3tg8gkIlOII8dOVWMKPKbrRV6YAuFW
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a63:b215:0:b0:577:4510:2391 with SMTP id
 x21-20020a63b215000000b0057745102391mr1781839pge.12.1694492374822; Mon, 11
 Sep 2023 21:19:34 -0700 (PDT)
Date:   Mon, 11 Sep 2023 21:19:09 -0700
In-Reply-To: <20230912041910.726442-1-arakesh@google.com>
Mime-Version: 1.0
References: <20230912041910.726442-1-arakesh@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912041910.726442-2-arakesh@google.com>
Subject: [PATCH v1 1/2] usb: gadget: uvc: prevent use of disabled endpoint
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
Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
 drivers/usb/gadget/function/f_uvc.c     | 11 +++++------
 drivers/usb/gadget/function/f_uvc.h     |  2 +-
 drivers/usb/gadget/function/uvc.h       |  2 +-
 drivers/usb/gadget/function/uvc_v4l2.c  | 21 ++++++++++++++++++---
 drivers/usb/gadget/function/uvc_video.c |  3 ++-
 5 files changed, 27 insertions(+), 12 deletions(-)

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
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 91af3b1ef0d4..70ff88854539 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -382,6 +382,7 @@ static void uvcg_video_pump(struct work_struct *work)
 {
 	struct uvc_video *video = container_of(work, struct uvc_video, pump);
 	struct uvc_video_queue *queue = &video->queue;
+	struct uvc_device *uvc = video->uvc;
 	/* video->max_payload_size is only set when using bulk transfer */
 	bool is_bulk = video->max_payload_size;
 	struct usb_request *req = NULL;
@@ -390,7 +391,7 @@ static void uvcg_video_pump(struct work_struct *work)
 	bool buf_done;
 	int ret;
 
-	while (video->ep->enabled) {
+	while (uvc->state == UVC_STATE_STREAMING && video->ep->enabled) {
 		/*
 		 * Retrieve the first available USB request, protected by the
 		 * request lock.
-- 
2.42.0.283.g2d96d420d3-goog


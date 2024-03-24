Return-Path: <linux-kernel+bounces-114717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F95889206
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D8D1F2E365
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802C419D1D9;
	Mon, 25 Mar 2024 00:43:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E52172645
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323161; cv=none; b=dtnerl7wfIm1pcvDirhJXY+/gCfcUdhmF4yzL8tM6UGGxuTKsKq8618LPrBhQuJ8+mSD8vPX5rjttQSrw39HAY16YYQTR6m5B8iD4eC52Z8z7qdw1h2vvfKC9AF8/Yum8Ayp2iDzaP+4tkr2MUxs6Kr+82i1Hqq6O7x4MLOM9sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323161; c=relaxed/simple;
	bh=MR6LiyqvdzJQOZPGvyqmUcabXsb6JiaKTN2J7yPF1+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IssHswRJA8grgbv0cDUrAM9kH/+jEWt93HpaczTV+a104cEbWmQ4WnpAKrspzUsWGeJB4bLrSnGB+CAzDYBvVJYIDhZJZsBa0lXyba3zuwfLv/AlmWJ74LpClsByj4WRGKmLfSu3/CfSKy5ZG0jF29ei7w+lWoWL7hQbwDu713w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1roXKN-0007qh-Ea; Mon, 25 Mar 2024 00:32:35 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1roXKM-008JQl-QP; Mon, 25 Mar 2024 00:32:34 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1roXKM-00FsDT-2S;
	Mon, 25 Mar 2024 00:32:34 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Mon, 25 Mar 2024 00:32:30 +0100
Subject: [PATCH] usb: gadget: uvc: Improve error checking and tagging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-uvc-gadget-errorcheck-v1-1-5538c57bbeba@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAA24AGYC/x2NywqDMBAAf0X23AWTBiz9ldLDZrN5UIllU0UQ/
 73B4wwMc0ATLdLgORygspVWltrB3AbgTDUJltAZ7GjdeLcO140xUUjyQ1FdlLPwB53xDzNRjM4
 F6K2nJuiVKude13Weu/yqxLJfs9f7PP8ir+1yfAAAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7088;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=MR6LiyqvdzJQOZPGvyqmUcabXsb6JiaKTN2J7yPF1+M=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmALgSL9zCLOcFouQ2WqIZ76dmrdygu07rc5KnE
 WytqzTr1t6JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZgC4EgAKCRC/aVhE+XH0
 q3wlD/4uVVTJGFEIGn/Hde+HACmjdT839upbn0Qf3YKQpGAlNpalz0XN1jyEu+C25dvUHXTA+NL
 wBB9TkAwlXPCD0mdlLWqWqjvzFskGGS0yJnBZeQkaKaj0qRg4qGwB4IXIK4fOCcqSaOzN1GADpc
 z1RQDRLOuIS7acCxPQ3jdl7gb9VGTP6ApEIi1PJ63MMyNgFLLlov6gHhXD1Dxtb4BVU4diGIJ68
 C66qwD08HJEIXn5SYfpnvtK+Ye+pwAOmwUo3qGcGmR+7b1QzWxCRyG6Zs882/TKPWrsRvRcghm0
 W5rGL0/e9ApIDCMBWG8igQ1814pPq+Z3kHhAbxUFDRCbxkxMb9qm4xm9/+rxPCh5nVzZCqolDcr
 IZ/lDHoXCoqqRi7G4dC3ICPiAdns+ZNxbCiriSipz0TzalldcPt4lVoa9fZqLo+E2ZlT5qxEqnR
 SJ7juHdj3baui6VYZQpec3QKjFN8qcd/rQX59OXikAUXxAK/cFL2jy7z2rYthyUT+UwF/BIEVkm
 ZmZoHa2Z8Z2HNwAVBmSnC6kuxT9NlAv4NtBkSn51UG/zBfZ6uHW4eo4gBBxojI0FmRlkHVrjkg4
 pUwK7Klhl25aqxdsQ7VGDFNSfUEYzTmymohFcgsC+brZtXUZFLFx7hKWqfbuQdoi2RzVGFlHim6
 1iLNAJkNYpua50w==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Right now after one transfer was completed with EXDEV the currently
encoded frame will get the UVC_STREAM_ERR tag attached. Since the
complete and encode path are handling separate requests from different
threads, there is no direct correspondence between the missed transfer
of one request and the currently encoded request which might already
belong to an completely different frame.

When queueing requests into the hardware by calling ep_queue the
underlying ringbuffer of the usb driver will be filled. However when
one of these requests will have some issue while transfer the hardware
will trigger an interrupt but will continue transferring the pending
requests in the ringbuffer. This interrupt-latency will make it
impossible to react in time to tag the fully enqueued frame with the
UVC_STREAM_ERR in the header.

This patch is also addressing this particular issue by delaying the
transmit of the EOF/ERR tagged header by waiting for the last enqueued
buffer of the frame to be completed. This way it is possible to react to
send the EOF/ERR tag depending on the whole frame transfer status.

As this is patch is adding latency to the enqueuing path of the frames
we make this errorcheck optional by adding an extra module parameter.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/gadget/function/f_uvc.c     |  4 ++
 drivers/usb/gadget/function/uvc.h       |  3 ++
 drivers/usb/gadget/function/uvc_video.c | 69 +++++++++++++++++++++++++++++----
 3 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 929666805bd23..6a7ca8ccaf360 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -33,6 +33,10 @@ unsigned int uvc_gadget_trace_param;
 module_param_named(trace, uvc_gadget_trace_param, uint, 0644);
 MODULE_PARM_DESC(trace, "Trace level bitmask");
 
+bool uvc_gadget_errorcheck_param = true;
+module_param_named(errorcheck, uvc_gadget_errorcheck_param, bool, 0644);
+MODULE_PARM_DESC(errorcheck, "Check and mark errors in the transfer of a frame");
+
 /* --------------------------------------------------------------------------
  * Function descriptors
  */
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index cb35687b11e7e..e21fea6784597 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -46,6 +46,7 @@ struct uvc_device;
 #define UVC_WARN_PROBE_DEF			1
 
 extern unsigned int uvc_gadget_trace_param;
+extern bool uvc_gadget_errorcheck_param;
 
 #define uvc_trace(flag, msg...) \
 	do { \
@@ -91,6 +92,8 @@ struct uvc_video {
 	struct work_struct pump;
 	struct workqueue_struct *async_wq;
 
+	struct usb_request *last_req;
+
 	/* Frame parameters */
 	u8 bpp;
 	u32 fcc;
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index d41f5f31dadd5..8e9ec21b5154b 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -35,9 +35,6 @@ uvc_video_encode_header(struct uvc_video *video, struct uvc_buffer *buf,
 
 	data[1] = UVC_STREAM_EOH | video->fid;
 
-	if (video->queue.flags & UVC_QUEUE_DROP_INCOMPLETE)
-		data[1] |= UVC_STREAM_ERR;
-
 	if (video->queue.buf_used == 0 && ts.tv_sec) {
 		/* dwClockFrequency is 48 MHz */
 		u32 pts = ((u64)ts.tv_sec * USEC_PER_SEC + ts.tv_nsec / NSEC_PER_USEC) * 48;
@@ -62,7 +59,8 @@ uvc_video_encode_header(struct uvc_video *video, struct uvc_buffer *buf,
 
 	data[0] = pos;
 
-	if (buf->bytesused - video->queue.buf_used <= len - pos)
+	if (!uvc_gadget_errorcheck_param &&
+	    (buf->bytesused - video->queue.buf_used <= len - pos))
 		data[1] |= UVC_STREAM_EOF;
 
 	return pos;
@@ -366,6 +364,32 @@ static void uvc_video_ep_queue_initial_requests(struct uvc_video *video)
 	spin_unlock_irqrestore(&video->req_lock, flags);
 }
 
+static void
+uvc_video_fixup_header(struct usb_request *next, struct usb_request *done,
+		       bool error)
+{
+	struct uvc_request *next_ureq = next->context;
+	struct uvc_request *done_ureq = done->context;
+	struct uvc_video *video = next_ureq->video;
+	struct uvc_video_queue *queue = &video->queue;
+
+	u8 header = UVC_STREAM_EOF;
+
+	if (error)
+		header |= UVC_STREAM_ERR;
+
+	if (queue->use_sg) {
+		memcpy(next_ureq->header, done_ureq->header,
+				UVCG_REQUEST_HEADER_LEN);
+
+		((u8 *)next_ureq->header)[1] |= header;
+	} else {
+		memcpy(next->buf, done->buf, UVCG_REQUEST_HEADER_LEN);
+
+		((u8 *)next->buf)[1] |= header;
+	}
+}
+
 static void
 uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 {
@@ -377,6 +401,7 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	unsigned long flags;
 	bool is_bulk = video->max_payload_size;
 	int ret = 0;
+	bool error = false;
 
 	spin_lock_irqsave(&video->req_lock, flags);
 	if (!video->is_enabled) {
@@ -419,6 +444,8 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 
 	if (last_buf) {
 		spin_lock_irqsave(&queue->irqlock, flags);
+		if (queue->flags & UVC_QUEUE_DROP_INCOMPLETE)
+			error = true;
 		uvcg_complete_buffer(queue, last_buf);
 		spin_unlock_irqrestore(&queue->irqlock, flags);
 	}
@@ -449,11 +476,37 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	 * requests and cannot recover.
 	 */
 	to_queue->length = 0;
+
+	/* If the last request was queued the just copy the previous
+	 * header without payload to the empty request and fixup the
+	 * tags with ERR/EOF to finish the frame.
+	 */
+	if (uvc_gadget_errorcheck_param && (video->last_req == req)) {
+		uvc_video_fixup_header(to_queue, req, error);
+		to_queue->length = UVCG_REQUEST_HEADER_LEN;
+		video->last_req = NULL;
+	}
+
 	if (!list_empty(&video->req_ready)) {
-		to_queue = list_first_entry(&video->req_ready,
-			struct usb_request, list);
-		list_del(&to_queue->list);
-		list_add_tail(&req->list, &video->req_free);
+		struct usb_request *next_req =
+				list_first_entry(&video->req_ready,
+						 struct usb_request, list);
+		struct uvc_request *next_ureq = next_req->context;
+
+		/* If the last request of the frame will be queued, we delay
+		 * the enqueueing of every next request. This way it is
+		 * possible to react to send the EOF/ERR tag depending
+		 * on the whole frame transfer status.
+		 */
+		if (!video->last_req && !to_queue->length) {
+			if (uvc_gadget_errorcheck_param && next_ureq->last_buf)
+				video->last_req = next_req;
+
+			to_queue = next_req;
+			list_del(&to_queue->list);
+			list_add_tail(&req->list, &video->req_free);
+		}
+
 		/*
 		 * Queue work to the wq as well since it is possible that a
 		 * buffer may not have been completely encoded with the set of

---
base-commit: bfa8f18691ed2e978e4dd51190569c434f93e268
change-id: 20240324-uvc-gadget-errorcheck-41b817aff44d

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>



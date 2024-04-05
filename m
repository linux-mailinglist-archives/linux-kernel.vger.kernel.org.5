Return-Path: <linux-kernel+bounces-132580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863408996D0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C9F1F23158
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3325F13D538;
	Fri,  5 Apr 2024 07:45:01 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059B013D534
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303100; cv=none; b=XrXe+ykX6KPE497xU9F33mtG2QQ7lu2rXPIafxRlw45GKa3Emd7rtCzie3m1SYw0+Qf5iMmTFtHVFYe8sSzdaaLGcq+3niTqm2jJkFNT8SdMmPBzEfBJIMTUL59YigxqFqIk2+DR2P8Zrg7VF1P4D7e5w3n/k50gXEvohLiV6Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303100; c=relaxed/simple;
	bh=EGFVhu5uEEGFBRV4ovRnzduyzuYnoarCf2q6cUuQ8OU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IaL+mycj8nWslvsSDXmF+LU8pstp1Fkbj7L1Ar6/DotHswfQ+uxtfkcflY5IIS8LbT/D2jrT19/Hj8WNJ8CIeN0fIy3BttgMCeZ0YEUZtBcrwoWKc9zCpAemF/q4l6+2jw9NcxPf3GE4VKR9+YezuNjfNWjWn/XgY1qDXJYwz3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rseFt-0001Wp-AV; Fri, 05 Apr 2024 09:44:57 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rseFs-00AWqy-ST; Fri, 05 Apr 2024 09:44:56 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rseFs-00DzJw-2h;
	Fri, 05 Apr 2024 09:44:56 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Fri, 05 Apr 2024 09:44:56 +0200
Subject: [PATCH v2] usb: gadget: uvc: Improve error checking and tagging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-uvc-gadget-errorcheck-v2-1-f141b13ade0e@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAPerD2YC/4WNSwqDMBQAryJZ9xUTI0pXvUdxkc8zCZUoLxos4
 t2beoEuZ2CYgyWkgIk9qoMR5pDCHAuIW8WMV9EhBFuYiVrIuhEStmzAKetwBSSayXg0b5Bc97x
 T4yilZaXVKiFoUtH4UsdtmopcCMewX7PXUNiHtM70ud6Z/+y/TebAoW2b3rSd1qjVc8HotpXmG
 Pa7RTac5/kFNO2MXtQAAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6004;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=EGFVhu5uEEGFBRV4ovRnzduyzuYnoarCf2q6cUuQ8OU=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmD6v4dkOR1+x1k0MdAqaO+E5Koh62lTp4/8eYL
 mGId6/9C12JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZg+r+AAKCRC/aVhE+XH0
 qxLoD/9RwbdmTQR8SpV4BicvnulhQKbDIihIHJvHTj9/LnFfP5kadiYRGSbJB7iFpGhc3/Wve9a
 kASzasUJ+zB6Lo+QS4+uyUl4WIkLlfM6yQ7wQ1CIRATxv5Byd4NBSx/mxxhyQOQbl7/hf95V+iK
 kC+IBq9XcuNpdOlQp9xKEiOI39lt6KeCYt1shYI+K5p+z2rRddOJeh5X44eyVCotyLHaxmtNpBm
 n89yOdHqx3wUXq1r7tsKMXinMi9jnQeeVBTtnfTWL3azvwDo1oYylpfDINXvMzoNHB9VlNyVVCn
 O7XbDI8yHOkoQbQdKy/wsV5OBV1ao64SU4qtl7VfrusDt/A9A2asOicdqhvymeuSMK4j6vEOBJt
 qXarZ78iR8KTPjugC3U8R3hAoPOsRomYvPi75YasFJxrX/nV+M7MWNsvqqnxrYQJowOHtBB/QYu
 qHFxvPEcOPLb3x7czqJtisRKArEKRM2qkHOG9ejHUuFlWq7c+Yp+RsvEGIXpNIJTdfUwZ2qAeH9
 IPxa/DqIe2Li0C77SprjU+ipHogQc8PPz0MgbSS9WvKgQ9iqbZqrpInmsf90hz9SYqArj/8P+0d
 hLGmYyCwxi/fqCn9vsv2qg4eVgPe1yRQ5CQegknUXHFFudt8P2udiTowG5QKTgiJMhp/jIto7mr
 rDLj/LM9ctnm3/A==
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

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Changes in v2:
- removed unnecessary uvc_gadget_errorcheck_param module parameter
- Link to v1: https://lore.kernel.org/r/20240324-uvc-gadget-errorcheck-v1-1-5538c57bbeba@pengutronix.de
---
 drivers/usb/gadget/function/uvc.h       |  2 +
 drivers/usb/gadget/function/uvc_video.c | 69 ++++++++++++++++++++++++++++-----
 2 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index cb35687b11e7e..210c9b5e6a5ee 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -91,6 +91,8 @@ struct uvc_video {
 	struct work_struct pump;
 	struct workqueue_struct *async_wq;
 
+	struct usb_request *last_req;
+
 	/* Frame parameters */
 	u8 bpp;
 	u32 fcc;
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index d41f5f31dadd5..2bfeea94131a9 100644
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
@@ -62,9 +59,6 @@ uvc_video_encode_header(struct uvc_video *video, struct uvc_buffer *buf,
 
 	data[0] = pos;
 
-	if (buf->bytesused - video->queue.buf_used <= len - pos)
-		data[1] |= UVC_STREAM_EOF;
-
 	return pos;
 }
 
@@ -366,6 +360,32 @@ static void uvc_video_ep_queue_initial_requests(struct uvc_video *video)
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
@@ -377,6 +397,7 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	unsigned long flags;
 	bool is_bulk = video->max_payload_size;
 	int ret = 0;
+	bool error = false;
 
 	spin_lock_irqsave(&video->req_lock, flags);
 	if (!video->is_enabled) {
@@ -419,6 +440,8 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 
 	if (last_buf) {
 		spin_lock_irqsave(&queue->irqlock, flags);
+		if (queue->flags & UVC_QUEUE_DROP_INCOMPLETE)
+			error = true;
 		uvcg_complete_buffer(queue, last_buf);
 		spin_unlock_irqrestore(&queue->irqlock, flags);
 	}
@@ -449,11 +472,37 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	 * requests and cannot recover.
 	 */
 	to_queue->length = 0;
+
+	/* If the last request was queued just copy the previous
+	 * header without payload to the empty request and fixup the
+	 * tags with ERR/EOF to finish the frame.
+	 */
+	if (video->last_req == req) {
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
+			if (next_ureq->last_buf)
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
base-commit: 3295f1b866bfbcabd625511968e8a5c541f9ab32
change-id: 20240324-uvc-gadget-errorcheck-41b817aff44d

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>



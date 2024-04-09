Return-Path: <linux-kernel+bounces-137641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E17B589E4E7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCF3284633
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8A0158A02;
	Tue,  9 Apr 2024 21:25:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C42F158A00
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712697906; cv=none; b=aymTB3aaBlIeH/2qh1ARnThUbFYA33BIAqiAx5hTSBUCTgrNSc8ylsHzv+/ToWpE605XQB5JcujP43LsQOJxt31pBwW/KQm6iXkI6fGc4XNAEyVVrzuIQEwspE3heQnSfx7kVxQmmmJwvLw30QavGKTpFJ49kHKhUb0LwxTBXYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712697906; c=relaxed/simple;
	bh=6TmMXgCfd8u3hiqGzGhPNGk2tjA7rmKiDfupaGxCdqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUlZBIWAt+tUJcRTd1jFrgm5rpG/LXOfJftiJBoYBXesVDLzrrAobRjGy4LZr9cZ2m3O9RJDCFjUHdQFw5o+yUeSCmye5Ju9KAwBmHebo6faB0Jx4Y3FboCn6whg1+cejjtvHcPZrb5OmZGmIP3HAGyHSKuq4ugCOUqcFV2ygNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ruIxf-00081a-FR; Tue, 09 Apr 2024 23:24:59 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ruIxe-00BNAg-RD; Tue, 09 Apr 2024 23:24:58 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ruIxe-00FQKu-2U;
	Tue, 09 Apr 2024 23:24:58 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 09 Apr 2024 23:24:59 +0200
Subject: [PATCH 3/3] usb: gadget: uvc: set req_size and n_requests based on
 the frame interval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v1-3-9436c4716233@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v1-0-9436c4716233@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v1-0-9436c4716233@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3029;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=6TmMXgCfd8u3hiqGzGhPNGk2tjA7rmKiDfupaGxCdqY=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmFbIq8jorVF6Ra+5mJRuXSj4fgO1Wmk6Jc6g/c
 z+9XExEyRiJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZhWyKgAKCRC/aVhE+XH0
 q5GlD/41zsRHDlttuBY8aTSvLZ4Z0E1s/v6sAlwkr0KEtGGKpkobKgX9bZCSmG5EuXbud/1PdK9
 AnvGzCML8QinMlVgbW4RcH9C8u0zi7fTSrA8Nf5BHxkltxPBB/WU2OGndNhIRcuhpIESPeSoFR2
 aNn20ut0OoIbWvm+Pijn+23AZrPzbKrUgEzciMpXUxgsga4TrHIl+mJ7tj9ZLX4D1+tBcgiigr+
 nKNPRlmm6tlGYif/y783CXHNAOcVbDwKqXwoI5Y5eeSUt5piG2RlFdjM37RiBZHpIDczQ6k16jl
 2Qy5tsiuPmb9uK4mEDkj172k2X3bx0uYy4c2mYHl9mRSVrdc6enW8qjgvHdN4j0YOJPR2yLAiXj
 hyhzb5qso8uE7zzhvkbepVhofltCmsElEV+0szV1Lauk8j+2qnh7Boyk+z6rqx2XA2pKByDinrW
 /QvZ0XuZkIuRScFwu2N+HBmj4fslYLU00HIXLBloxX9PlKSfX+7iIoKHS84xAt85AOR2oTSRH8U
 u2uaNtsmmJOgYxxe7bdHaeGo8FhAj8WgZOpICOLEzcnNBk4aRD5+UoPMyR8uR09RI2e5UyfselM
 ycriv1tooV00FjvjGXF9TxVrtMGXUHVan14u5p3ARSn/PgNRI3gO3FSgoVDo4PgdwwK7/+j6nSq
 UNTpkS1XxCJSKJw==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

With the information of the interval frame length it is now possible to
calculate the number of usb requests by the frame duration. Based on the
request size and the imagesize we calculate the actual size per request.
This has calculation has the benefit that the frame data is equally
distributed over all allocated requests.

We keep the current req_size calculation as a fallback, if the interval
callbacks did not set the interval property.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/gadget/function/uvc_queue.c | 28 +++++++++++++++++++++-------
 drivers/usb/gadget/function/uvc_video.c |  2 +-
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index ce51643fc4639..cd8a9793aa72e 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -44,7 +44,7 @@ static int uvc_queue_setup(struct vb2_queue *vq,
 {
 	struct uvc_video_queue *queue = vb2_get_drv_priv(vq);
 	struct uvc_video *video = container_of(queue, struct uvc_video, queue);
-	unsigned int req_size;
+	unsigned int req_size, max_req_size;
 	unsigned int nreq;
 
 	if (*nbuffers > UVC_MAX_VIDEO_BUFFERS)
@@ -54,15 +54,29 @@ static int uvc_queue_setup(struct vb2_queue *vq,
 
 	sizes[0] = video->imagesize;
 
-	req_size = video->ep->maxpacket
+	nreq = DIV_ROUND_UP(video->interval, video->ep->desc->bInterval * 1250);
+
+	req_size = DIV_ROUND_UP(sizes[0], nreq);
+
+	max_req_size = video->ep->maxpacket
 		 * max_t(unsigned int, video->ep->maxburst, 1)
 		 * (video->ep->mult);
 
-	/* We divide by two, to increase the chance to run
-	 * into fewer requests for smaller framesizes.
-	 */
-	nreq = DIV_ROUND_UP(DIV_ROUND_UP(sizes[0], 2), req_size);
-	nreq = clamp(nreq, 4U, 64U);
+	if (!req_size) {
+		req_size = max_req_size;
+
+		/* We divide by two, to increase the chance to run
+		 * into fewer requests for smaller framesizes.
+		 */
+		nreq = DIV_ROUND_UP(DIV_ROUND_UP(sizes[0], 2), req_size);
+		nreq = clamp(nreq, 4U, 64U);
+	} else if (req_size > max_req_size) {
+		/* The prepared interval length and expected buffer size
+		 * is not possible to stream with the currently configured
+		 * isoc bandwidth
+		 */
+		return -EINVAL;
+	}
 
 	video->req_size = req_size;
 	video->uvc_num_requests = nreq;
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 95bb64e16f3da..d197c46e93fb4 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -304,7 +304,7 @@ static int uvcg_video_usb_req_queue(struct uvc_video *video,
 		 */
 		if (list_empty(&video->req_free) || ureq->last_buf ||
 			!(video->req_int_count %
-			DIV_ROUND_UP(video->uvc_num_requests, 4))) {
+			clamp(DIV_ROUND_UP(video->uvc_num_requests, 4), 4U, 16U))) {
 			video->req_int_count = 0;
 			req->no_interrupt = 0;
 		} else {

-- 
2.39.2



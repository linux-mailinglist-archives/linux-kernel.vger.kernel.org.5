Return-Path: <linux-kernel+bounces-75589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F78D85EB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE1028459F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412C7128385;
	Wed, 21 Feb 2024 22:08:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E57127B6F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553317; cv=none; b=nOGWWxu1iS/CexTlYTpTK21ntVXdQMNvHkz9oh5o46uGeftePmDVy2SkBdF8QWRuNjnwXj4rdd0NSyLqoLC/mLC796wPGXuu3mUyrNPbfr6Lsakg6IQ6lI+yIwFH/1akwMvBN7mcGwIxSXpxTp1/d3mDc1uXqN61w7KfqoOgwhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553317; c=relaxed/simple;
	bh=osIvO3Rr4RNhy8KfumCNnV1e4Hfi2ZGD6cGUJ7ZBljY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DB7ioh3cpzti3SZ/sx6adFonEIUjnb1ll3RnALNMDpBExUMEdba4Tv5Y622bt1pCJaxR67bXcHcG3d8sjG0k7PzRaS6G2E79ZQQSWT+K3Q+S5urCOTS3+dMMED/75SM/MvKnJtUViIrwHg8jPCGmqD2q5u0i9UU97r+yo+io4+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rculU-00087C-FK; Wed, 21 Feb 2024 23:08:32 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rculT-00275u-Tj; Wed, 21 Feb 2024 23:08:31 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rculT-009xti-2n;
	Wed, 21 Feb 2024 23:08:31 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Wed, 21 Feb 2024 23:08:31 +0100
Subject: [PATCH] usb: gadget: uvc: fix try format returns on uncompressed
 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-uvc-gadget-uncompressed-v1-1-f55e97287cae@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAF501mUC/x2N0QqDMAxFf0XyvICWOXC/MvbQNlkNuDiaVQTx3
 xf2eA73cA8wrsIG9+6AypuYrOowXDrIc9TCKOQMoQ/XPoQB25axRCr8xaZ5fX8qmzFhTCNlnqY
 b0whep2iMqUbNs/falsWlj1+y/+8ez/P8AUUeFCV+AAAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2107;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=osIvO3Rr4RNhy8KfumCNnV1e4Hfi2ZGD6cGUJ7ZBljY=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBl1nRfVFFupHo9D4ssRIPwvD9iwMrUWrf9w4/4M
 T20WCfCPSiJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZdZ0XwAKCRC/aVhE+XH0
 q3zwD/sGkFvwYCARNgOqt3OjyxmAqc4U3iU4t+LabEPz/x7whMQ7MKv5t7TranPdMmXwyQx+e1Y
 zgLlH+CvEZAhHP7Eo4Jyb/k06nGFKbWwvkQCVNf7e2MvOZ+3uKuGe+xvRz6nzBfvkI5turlaSdg
 FzkWIBXV1YBprzEpMd5Hjanb4OlX8r89ppRMrhzV2jnqSS5yqZuxs2a5qXzXfM6epk96t5wLS2y
 kYdY8A+zGnlq3sp7zVh9AuYavVDclwTNi9Hrwyo75UTg/N0qIuNuap+wIkymxmiBcydYJSM96Pq
 fOR99O1+HwoH3RLzpeaQaS9ZWm7HkNnZu2j/gHGRfCcoUZwnDxyW3Lolw/BUFHRAs4Pbc5i/MBj
 Jv0FWWUfN/jU6H3DlvVAHfr6C/9oL0nRsuOGn9Lxv1PfvbAPyQQqs+I27o5joXXSKFIWXkM4eYq
 5fMqvLxRvctnbKb2UmEP4njTtRv32nlKrId+0CYsJ1wmZ4ClqWSWoWuOd1qps2RzHtYb40Vh64X
 rln7dU0gFbPgx/oLAAPHbKxlYqh0t+zlVm9sFAlqVuxedFY57DNf3VuscDQdAQgl3TWvBmUN2Hg
 IhYpB2d62ifVVdyj29P/rgbC/o5SSF3YTDrxjqN2WOCoE2dXGU4qacP0bjA6HH7jISmRMYLYzqm
 12m7IhvpC1VFwew==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

When setting uncompressed formats, the values of bytesperline and
sizeimage can already be determined by using the v4l2_fill_pixfmt helper
function. We change the try_fmt function to use the helper instead.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/gadget/function/uvc_v4l2.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index c7e5fa4f29e03..a024aecb76dc3 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -260,12 +260,26 @@ uvc_v4l2_try_format(struct file *file, void *fh, struct v4l2_format *fmt)
 	if (!uframe)
 		return -EINVAL;
 
-	fmt->fmt.pix.width = uframe->frame.w_width;
-	fmt->fmt.pix.height = uframe->frame.w_height;
+	if (uformat->type == UVCG_UNCOMPRESSED) {
+		struct uvcg_uncompressed *u =
+			to_uvcg_uncompressed(&uformat->group.cg_item);
+		if (!u)
+			return 0;
+
+		v4l2_fill_pixfmt(&fmt->fmt.pix, fmt->fmt.pix.pixelformat,
+				 uframe->frame.w_width, uframe->frame.w_height);
+
+		if (fmt->fmt.pix.sizeimage != (uvc_v4l2_get_bytesperline(uformat, uframe) *
+						uframe->frame.w_height))
+			return -EINVAL;
+	} else {
+		fmt->fmt.pix.width = uframe->frame.w_width;
+		fmt->fmt.pix.height = uframe->frame.w_height;
+		fmt->fmt.pix.bytesperline = uvc_v4l2_get_bytesperline(uformat, uframe);
+		fmt->fmt.pix.sizeimage = uvc_get_frame_size(uformat, uframe);
+		fmt->fmt.pix.pixelformat = to_uvc_format(uformat)->fcc;
+	}
 	fmt->fmt.pix.field = V4L2_FIELD_NONE;
-	fmt->fmt.pix.bytesperline = uvc_v4l2_get_bytesperline(uformat, uframe);
-	fmt->fmt.pix.sizeimage = uvc_get_frame_size(uformat, uframe);
-	fmt->fmt.pix.pixelformat = to_uvc_format(uformat)->fcc;
 	fmt->fmt.pix.colorspace = V4L2_COLORSPACE_SRGB;
 	fmt->fmt.pix.priv = 0;
 

---
base-commit: 3bf0514dc6f36f81ee11b1becd977cb87b4c90c6
change-id: 20240221-uvc-gadget-uncompressed-ab5dce996ed5

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>



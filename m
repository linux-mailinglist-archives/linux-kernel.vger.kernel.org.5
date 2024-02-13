Return-Path: <linux-kernel+bounces-64539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8283D854015
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC2728FCD2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269E46340C;
	Tue, 13 Feb 2024 23:28:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD263106
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866905; cv=none; b=OcpKASm3wg3jIwXRriNeD7OykG2BxEJbUJZuiu2rQk4PnbLY/ABSR/QXMUBTWn73PhgcyBmZ+551j4muzz0HIjKbBs+sNcRDs6NCVOvmwZX2RR+24q+Va0MxiQZCozIO+9BGlpfn+xouRcOEKbL62GeAAyaIkGduElJaHcLhYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866905; c=relaxed/simple;
	bh=30YYmuToXt0Be5FF1D9822Y6K2GuA90aOezsbaqJW0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MaV2dA8pIMgXJQ1orxBQmuGLQ24G1DB65lZp/Begp8ZcGbQG/Dw+Yk5lPfJVEB6NWujHRZaQnY26zH6hjKj4hPMC9QkPdJ8Mt36a/9bCOSvdSctP/xAl3aSkHRLvwRo9fjSs1q5HO8fOYB2G5aAIVzKqorHw6dKHA4EkmpRVYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2CI-0000eR-Ij; Wed, 14 Feb 2024 00:28:18 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2CH-000Zcp-Up; Wed, 14 Feb 2024 00:28:17 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2CH-002uYW-2t;
	Wed, 14 Feb 2024 00:28:17 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Wed, 14 Feb 2024 00:28:01 +0100
Subject: [PATCH 2/3] usb: gadget: uvc: refactor the check for a valid
 buffer in the pump worker
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-uvc-gadget-cleanup-v1-2-de6d78780459@pengutronix.de>
References: <20240214-uvc-gadget-cleanup-v1-0-de6d78780459@pengutronix.de>
In-Reply-To: <20240214-uvc-gadget-cleanup-v1-0-de6d78780459@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=30YYmuToXt0Be5FF1D9822Y6K2GuA90aOezsbaqJW0s=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBly/sR6vOuNRf8bz1usN1hrU8dGhJSMxHuyafO/
 vgaWNxSX/eJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZcv7EQAKCRC/aVhE+XH0
 q3pXEACPUYRmu19z11qUsOha/z9QRa+P7klnxF6Mf3Zgi6d8WSPDG3m1wdvDxkGuPcRJ6ksszw6
 qBmF8jzi/kPJFD8aOZwdaPExVhPEP2QN9n7k09m2C+hLlEzstCtqMF4oIUseP4P+4ERtJDac0JW
 qux4XtvYoU2d4OIMKZ0jHTLKT2TDe+QSuvYhFCFse0EUufu1lJvQrY36oaYFbIMGRN4jIqS3/OL
 LqmIQPuKzluEaypn5dL2EiUMt/e8SWbtBGowp6byn0x2YK7x14x7VaZqzcWRsF1c3W77PS9GFtA
 kVdq9F2uUQaI/MOGtx/aYZ0c3Z+C4JTV0JJOjoc+3dgsNXRqn+qOE/Wusr3fMgKd+mbg4B970lE
 pZETUw5p5wv1CwsbcKeEp6MZZGLU4ujE3ortF9rWAAJx4WJzlXiYRoTnBg7TrfFf+41ssu5kdPU
 ZcXN0G6VQlz7r42JKbezSEIeGbjhUAEFpMv3RDOqxm1DUw0z+Ao9KfAV724kGW407Y8gE8kWfmT
 D5Xw9BMLebOHgSiEqJPtKzym3/fkI6uc2pMycN7pZzgqhLLiawSLiYqDKiI+bV6Tucy6/mOV2cZ
 VYTZr5upT5Xy0zxQKbIr9nb968YB9ybO+KD7A75HetLTqQ5un+Daq+T0KJYhJdAlXf2QtGeYwU5
 lizaj9dmtWYG1aw==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

By toggling the condition check for a valid buffer, the else path
can be completely avoided.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/gadget/function/uvc_video.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index b17c61c932652..b4f3b3c784218 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -594,10 +594,7 @@ static void uvcg_video_pump(struct work_struct *work)
 		 */
 		spin_lock_irqsave(&queue->irqlock, flags);
 		buf = uvcg_queue_head(queue);
-
-		if (buf != NULL) {
-			video->encode(req, video, buf);
-		} else {
+		if (!buf) {
 			/*
 			 * Either the queue has been disconnected or no video buffer
 			 * available for bulk transfer. Either way, stop processing
@@ -607,6 +604,8 @@ static void uvcg_video_pump(struct work_struct *work)
 			break;
 		}
 
+		video->encode(req, video, buf);
+
 		spin_unlock_irqrestore(&queue->irqlock, flags);
 
 		spin_lock_irqsave(&video->req_lock, flags);

-- 
2.39.2



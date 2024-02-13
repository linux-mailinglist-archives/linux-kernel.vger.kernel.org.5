Return-Path: <linux-kernel+bounces-64550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F37854032
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1259A286590
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAC56310A;
	Tue, 13 Feb 2024 23:38:05 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797C963110
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867485; cv=none; b=f0hH9lhowmgvmUllRi2TYSatCbjsfDcOE9LdwjZ2CJFSLH95DUF9k8vffAxY2jTRBpdDzEKtAwOwNf2QQHSLAURulV2GHETIW0xRbYllKn5VfbZVy8W7fdr55QzVK2161eoX4jgq86nnQIqrYmE1sZ7vLbab8OSuBFE7unGYxx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867485; c=relaxed/simple;
	bh=gTEKiN/I5qFt+biy0SUpmyrfSWXAwpkAIwfL3qS3OLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HTxAV1Xc9yshbAgqbcsJmCW6v382zjwRHpG1ztgnUoTiMqx0wS78+MbTxdDtivLa5bvY4rBsq6fbHxDS84t0SyePy9VNVJbNyaKnMlytyFzOb2QgSoB242NoQyaiI1xs6giCMjf+AI0GCOmqU9tdhP9w3y6RFdGPmuDPrD4hN9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2Lg-00013K-2r; Wed, 14 Feb 2024 00:38:00 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2Lf-000Zga-JR; Wed, 14 Feb 2024 00:37:59 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2Lf-0032pb-1k;
	Wed, 14 Feb 2024 00:37:59 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Wed, 14 Feb 2024 00:37:54 +0100
Subject: [PATCH 1/2] usb: gadget: uvc: dont drop frames if zero length
 packages are late
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-uvc-error-tag-v1-1-37659a3877fe@pengutronix.de>
References: <20240214-uvc-error-tag-v1-0-37659a3877fe@pengutronix.de>
In-Reply-To: <20240214-uvc-error-tag-v1-0-37659a3877fe@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=937;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=gTEKiN/I5qFt+biy0SUpmyrfSWXAwpkAIwfL3qS3OLE=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBly/1Wy/1EqSpObvI/HG2k4YG/rBcLlg2ivgGR9
 wdjpHOzXeqJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZcv9VgAKCRC/aVhE+XH0
 q9PDD/wLSvtIVxMOKt1XQdj5EHM5Gb8+3in0n7Snqmg4EQCxnmSXXGv7QacEK1fvvH75d23AFg9
 jAn9b8FxbYLi3cYmpJO/NBQBHmumcstzkncr++maVbLw816H069f241gcIJWOm8c5x/BFVvk38l
 9OB1WZxe/MmkslzP8vATHUBpEGtJyPW0DqCnsccek0OS6KzYTm/6TUTaqoJxInbfL+2NQgWc2Zc
 CcvHj/JP8H/3ihq3BdvPKz+F6iYY94hKF79mIPH5cA/OrqoOGpf8YNFTCT4gQKVhAKTfd4qFoEo
 0vzqSj7/J4bUiAlVHAVC9QDycunlKJA+SBDFlbEUzS7K4DSXX8CI2TC37WZTM+rmiAt6e0fwd6/
 sR4q18wOon1QgxE3Nczyq6dJNlKlKsxuPkqTTud6DyPOKRfs3YrMsXBxwHeya4gYKQF7m0mcd/9
 PANbBlpTbjiBqp8uuzu4g5MuwvmLa7y0NBvhVfaVUS9zJn1P31uiZxzN2WXh7zLazUYgFqLAiL7
 aBHjMkQT1x3aQO/YEODkts9BgAv0P7dVHVP/TCPDx9V8NAVGtHc7T61ElWxunVVqLISSBHkNfAY
 M6o6zCKM6GTv4ybbsrWO74C1RI7h50hvdhO/A8PMsQ2QTdSOdfIhyo17wjfr/Yp2AsUzsjgApmN
 zQue72UoZMKV+yw==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

If the request that was missed was zero bytes long, it
is likely that the overall transferred frame was not affected.
So don't flag the frame incomplete in that case.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/gadget/function/uvc_video.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index dd3241fc6939d..c288aceee92ac 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -397,7 +397,8 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 
 	case -EXDEV:
 		uvcg_dbg(&video->uvc->func, "VS request missed xfer.\n");
-		queue->flags |= UVC_QUEUE_DROP_INCOMPLETE;
+		if (req->length != 0)
+			queue->flags |= UVC_QUEUE_DROP_INCOMPLETE;
 		break;
 
 	case -ESHUTDOWN:	/* disconnect from host. */

-- 
2.39.2



Return-Path: <linux-kernel+bounces-75618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4926E85EC02
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8101C22C79
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0967FBC2;
	Wed, 21 Feb 2024 22:52:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D5E3A29E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708555921; cv=none; b=QB/wGwqOzL3BS9/aEL+Mwt2cjYuk/E0+OijUcY82l/NY8yEXO85HwFtFyMSJP6qcvru8/Wv0rBHamGiqH8ud3YxQoueS05HAoRwGYN0RnduZLaHYq6z6zOrZasSuywZg0NP85UVBsLfG64YSYRHhbFzhK6d7LKEaVhKgMh4r4sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708555921; c=relaxed/simple;
	bh=R/JHQ1lrEpJPhxyrIeQctCznqCSCvFwGCgMiq98FyQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ij9y5m/g4MDdLCbhOKpkQFCuyy4nZs1MaHNWnltYOwvQgNTMS++LZQPX3Jw55ABVN8rglVetLnb1NGNlexTRWnLN6QtYN9fjxkm48/jiMFNVvk4RfD7gE5C+89rw+++iIox932ejaOfEv8oGEZJn5JcmaoCBudPzm3BrtT2FuFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rcvRU-0006yg-FQ; Wed, 21 Feb 2024 23:51:56 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rcvRU-0027V8-0C; Wed, 21 Feb 2024 23:51:56 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rcvRT-00A5aE-33;
	Wed, 21 Feb 2024 23:51:55 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Wed, 21 Feb 2024 23:51:49 +0100
Subject: [PATCH] uvc_video: check for fid change early in decode_start and
 avoid wrong error counting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-uvc-host-video-decode-start-v1-1-228995925c70@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAIR+1mUC/x2NMQrDMAwAvxI0V5C4ydB+pXRwJLkWBLtYjgmE/
 L2m491wd4JJUTF4DicUaWqaU4fpNgBFnz6Cyp3BjW4enZtwb4QxW8WmLBlZKLOgVV8q+rDcOSw
 PNxNDL6zeBNfiE8XeSPu2dfktEvT4L1/v6/oBGDngMoIAAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4304;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=R/JHQ1lrEpJPhxyrIeQctCznqCSCvFwGCgMiq98FyQo=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBl1n6F23BMm2PAm3HqB/7FdHZGPkL2gcZvuQgF9
 YzxBri35zKJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZdZ+hQAKCRC/aVhE+XH0
 qxjwEACBbnUOZymdfOIo6PGQrjBiQ2M35j16DH6zwUC4TEjun5YIjpH8obnvZqP/L+fSbibfk5g
 xL8pJeY2y7a51tzZYcOFfF4tIHOfeA7jEJ9OjrkZHrvLXUx4lUUzZozwrFBBwayTDYrogjBcRUs
 PMv8QXCgYQqF/MntFTFCZL6Ob8jCsc5lhX8FoTDaSj1xwrORab+pgR5YWbsgJiDwJosnDH0xsrf
 v14WDS2lVv5Uxa0cIkJcvu+ZKgfHbNQTL/zWjNyLFZ9O+L04WKasT8tiIhyYn/68DYKlMZrPuto
 UaHw0lvpaZVVHp1sd1OSWdM5ISDHRw/Nt3rgC0ApcS7tn+Ez99msqv/Zyw5CbULO6zADeRlnSb8
 cNSc2+QLwdDnD4YwgDERlr7JXzlqd9iq0FtY+JGoLQXMoOL0mYJW2WJBynOA5oucqOJoep02ETH
 VPY3U5rLXlhuU5/0Fh8AfkdfYWJ+8PX/IVLGMYw4ZWQNCvxRjhEpUbq+YOX2fx8pBcoBaPPq0m4
 Azw2hTk8cH+xZYkYQAskAqSKnTyA2cBuv9kL0rT9z53/T3BAiSTmh5w3dxO+lNkn8Yot+0UUqQS
 QVZTWpfUIgzXmjE8sT2Ka5Sox/gUuEBiwdbg/g+BekxHUscIMKmNxDoMfeyFq7/AyPeyLklW0Wo
 UzU5zFsTswTNi7Q==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

When the uvc request will get parsed by uvc_video_decode_start it will
leave the function with -EAGAIN to be restarted on the next frame. While
the first wrong parse the statistics will already be updated with
uvc_video_stats_decode.

One value e.g. is the error_count, which therefor will be incremented
twice in case the fid has changed on the way. This patch fixes the
unnecessary extra parsing by returning early from the function when the
fid has changed.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/media/usb/uvc/uvc_video.c | 64 +++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 7cbf4692bd875..fce5349b5f9fa 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1068,11 +1068,43 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 
 	fid = data[1] & UVC_STREAM_FID;
 
+	/*
+	 * Store the payload FID bit and return immediately when the buffer is
+	 * NULL.
+	 */
+	if (buf == NULL) {
+		stream->last_fid = fid;
+		return -ENODATA;
+	}
+
 	/*
 	 * Increase the sequence number regardless of any buffer states, so
 	 * that discontinuous sequence numbers always indicate lost frames.
 	 */
 	if (stream->last_fid != fid) {
+		/*
+		 * Mark the buffer as done if we're at the beginning of a new frame.
+		 * End of frame detection is better implemented by checking the EOF
+		 * bit (FID bit toggling is delayed by one frame compared to the EOF
+		 * bit), but some devices don't set the bit at end of frame (and the
+		 * last payload can be lost anyway). We thus must check if the FID has
+		 * been toggled.
+		 *
+		 * stream->last_fid is initialized to -1, so the first isochronous
+		 * frame will never trigger an end of frame detection.
+		 *
+		 * Empty buffers (bytesused == 0) don't trigger end of frame detection
+		 * as it doesn't make sense to return an empty buffer. This also
+		 * avoids detecting end of frame conditions at FID toggling if the
+		 * previous payload had the EOF bit set.
+		 */
+		if (buf->bytesused) {
+			uvc_dbg(stream->dev, FRAME,
+				"Frame complete (FID bit toggled)\n");
+			buf->state = UVC_BUF_STATE_READY;
+			return -EAGAIN;
+		}
+
 		stream->sequence++;
 		if (stream->sequence)
 			uvc_video_stats_update(stream);
@@ -1081,15 +1113,6 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 	uvc_video_clock_decode(stream, buf, data, len);
 	uvc_video_stats_decode(stream, data, len);
 
-	/*
-	 * Store the payload FID bit and return immediately when the buffer is
-	 * NULL.
-	 */
-	if (buf == NULL) {
-		stream->last_fid = fid;
-		return -ENODATA;
-	}
-
 	/* Mark the buffer as bad if the error bit is set. */
 	if (data[1] & UVC_STREAM_ERR) {
 		uvc_dbg(stream->dev, FRAME,
@@ -1124,29 +1147,6 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 		buf->state = UVC_BUF_STATE_ACTIVE;
 	}
 
-	/*
-	 * Mark the buffer as done if we're at the beginning of a new frame.
-	 * End of frame detection is better implemented by checking the EOF
-	 * bit (FID bit toggling is delayed by one frame compared to the EOF
-	 * bit), but some devices don't set the bit at end of frame (and the
-	 * last payload can be lost anyway). We thus must check if the FID has
-	 * been toggled.
-	 *
-	 * stream->last_fid is initialized to -1, so the first isochronous
-	 * frame will never trigger an end of frame detection.
-	 *
-	 * Empty buffers (bytesused == 0) don't trigger end of frame detection
-	 * as it doesn't make sense to return an empty buffer. This also
-	 * avoids detecting end of frame conditions at FID toggling if the
-	 * previous payload had the EOF bit set.
-	 */
-	if (fid != stream->last_fid && buf->bytesused != 0) {
-		uvc_dbg(stream->dev, FRAME,
-			"Frame complete (FID bit toggled)\n");
-		buf->state = UVC_BUF_STATE_READY;
-		return -EAGAIN;
-	}
-
 	stream->last_fid = fid;
 
 	return data[0];

---
base-commit: 3bf0514dc6f36f81ee11b1becd977cb87b4c90c6
change-id: 20240221-uvc-host-video-decode-start-af53df5924cd

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>



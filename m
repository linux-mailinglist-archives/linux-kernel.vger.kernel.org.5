Return-Path: <linux-kernel+bounces-79897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754EC862812
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F383B21530
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435F84E1CA;
	Sat, 24 Feb 2024 22:52:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171F6D2E6
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708815158; cv=none; b=LnNVKRzV6xy+0bVcCwBhDSKqF54lcprObb9PnQcyj7jTsnadfFgCthycwvPMiW1129Xg+P0IG/t0j/t5jZvbFxynPZEAXtd5CkAAUvDJin4+DbNe/bFvREy64mjdYPMoIzqBPtA0Gmapi1VNgRlri/OTk2sFeEQJbIlk/5RI+/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708815158; c=relaxed/simple;
	bh=52sXyCJLlZ36sa+ODb0qXNh3CCBkzC6xeDrUfnPCX04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d4yEtZ8fB8nNczQDUaRwfrGSiQCsQlZPb6dN1ws1LdgxFdmgYgaVf8yNdz5KoGpsB6MKY3JgAXVkGucO4HlILoDZqZP8k/gQppnfIS49nVKGmf6yvE/+9rpi8wp6KwsV83VzzrXYDmNxpyjPGieYWYtWPBtn1x7NNWsMKUQHSlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1re0sh-00035S-9Q; Sat, 24 Feb 2024 23:52:31 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1re0sg-002gzJ-SC; Sat, 24 Feb 2024 23:52:30 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1re0sg-0004rt-2e;
	Sat, 24 Feb 2024 23:52:30 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Sat, 24 Feb 2024 23:52:29 +0100
Subject: [PATCH v2] uvc_video: check for fid change early in decode_start
 and avoid wrong error counting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-uvc-host-video-decode-start-v2-1-88c6e17e487a@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIACxz2mUC/42OQQ6DIBBFr2JYdxqZalq76j0aFwijTGLAABIb4
 91LPUGX7y3++7uIFJiieFa7CJQ5sncF8FIJbZWbCNgUFlhjUyNKWLMG62OCzIY8GNLeEMSkQgI
 1tjczth022oiyMKhIMATltC0bbp3nIpdAI29n8t0XthyTD5/zQZY/+18sS5CA+Oi6Emz1vX4t5
 KY1Be94uxoS/XEcXxMPwB/gAAAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4491;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=52sXyCJLlZ36sa+ODb0qXNh3CCBkzC6xeDrUfnPCX04=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBl2nMudEB5CtjNxDNnO7Y/7nVTXe42kg+kY3Yaw
 rsLcmv2DBGJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZdpzLgAKCRC/aVhE+XH0
 q5HiEACmkUdA1SkNnz258bLrhw0bdAesdXXgpWVBmElv31j5V3LsaBkSBj/BdfnR49qZ5s43Sl4
 2AAomzNektQIUH630Eug4CSZlzRbhUn9DV9jeZE4MxjWTBizLEgKAbV3U+rmT1XRr718aR6rHxx
 5n5n5tbgz9SswMiO0YTFSurRePefaXfxE4Lt5HnoFAxZQ/CTl6jZDipaBRoCwUQ0WAiwk4YOl7P
 Slq2RZC18eKJSX8ZVjjLNA1jGmAGmi+jXMfr4YQHn0mGRH29Of+QyUTGylwalq7Gc0ViujQrXPW
 At4Wu/lGwcx7ItVn6ynYr0cSAGa6R1QVCGgn+S00FaNzVwOt4Jn9bGodxIQUde+squTWbwWVhli
 oRKNj7P/t8pvXK8Cx2CcQc+9O+W4bKr7kh1H8spOhvihB+i4mXsHWjHQAkcFyZvXQuHVnXkAZPp
 5ele3cw1n8Xnac07gJ8rrSbO42yj1OV+5X4HcKYMLNCy1rrRoI4Ql9yYQ+1fprNuYAYwDP0yaR+
 lCYCCFAHF/jDn7lmoWyLsBrYiqlsyfw6qDrxCg77bHTLV2frbJ8bsREXSpNVh0h4nkoIQ1ZrDD9
 kLqm/c3uYqMTFuR7xqDlz+qw+JrjwEg7u+rRZnfbr+zleF6hQ9lfN4oQx8v65Oj0/KXM/Va6x0/
 /4C8SMlMXIfq+EQ==
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
Changes in v2:
- Moved the EAGAIN bailout after the sequence handling as mentioned by Ricardo Ribalda
- Link to v1: https://lore.kernel.org/r/20240221-uvc-host-video-decode-start-v1-1-228995925c70@pengutronix.de
---
 drivers/media/usb/uvc/uvc_video.c | 64 +++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 7cbf4692bd875..af368c45c4297 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1068,6 +1068,15 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 
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
@@ -1076,20 +1085,34 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 		stream->sequence++;
 		if (stream->sequence)
 			uvc_video_stats_update(stream);
+
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
 	}
 
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
base-commit: e89fbb5bc21a10a0de2bb878d4df09f538dc523b
change-id: 20240221-uvc-host-video-decode-start-af53df5924cd

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>



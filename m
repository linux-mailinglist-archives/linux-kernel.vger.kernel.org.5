Return-Path: <linux-kernel+bounces-105871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B59AC87E5BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6961B2827E2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE662C1AD;
	Mon, 18 Mar 2024 09:27:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030D426AF7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754055; cv=none; b=Aet9523VGYQy6G1GDsVMd/BqOKJ18+yFnqlFgbavUX3iwTkKDS4sCfyHEciEba35NNjIorD4ybIsdGWpyzg+g/IdouElI72L8D1VpK7VIhZZCzAQ4D659Uftanu366hRfBAIPUzSESMHe7CP1GoVRVTEGBqqZc5TGrl+bzQDG2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754055; c=relaxed/simple;
	bh=YHiuOn4hq18fkHfMqEhWJZ8muMTRuaWOyeakJRLBng4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MuITdIjvxZUMA3b06Nq67GpUoXr0UNJx0LsoAxdE/1KAWjIcFX6ewtir9E88JZyJPixfMXeEV9M3RKl13tYI0UObWBBMxAYBMWv3/OeMBvUFaBgbvO5DZG8GZ13sHHEHQEDGhHkx5JiShQ++eIjzdOK/w2bnGchoE1dQdO+ox4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rm9HF-000139-72; Mon, 18 Mar 2024 10:27:29 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rm9HE-00735O-QA; Mon, 18 Mar 2024 10:27:28 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rm9HE-006V5M-2R;
	Mon, 18 Mar 2024 10:27:28 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Mon, 18 Mar 2024 10:27:28 +0100
Subject: [PATCH v3] uvc_video: move clock_decode and stats_decode to the
 end of decode_start
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-uvc-host-video-decode-start-v3-1-40e9b9ced97b@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAP8I+GUC/5WOsQ6DIBRFf8Uw9zXy1Kqd+h9NB4SnkhgwgMTG+
 O9F1y7teO5wzt2YJ6fJs3u2MUdRe21NguKSMTkKMxBolZhhjmWOyGGJEkbrA0StyIIiaRWBD8I
 FEH1VqL5qsZSKJUMnPEHnhJFjcphlmtI4O+r1eiafr8Sj9sG69/kg8mP9LRY5cEBs2jYFK1nnj
 5nMsARnjV6vitghj/iHEJOwaeSNeE1lU4sv4b7vHw606zUxAQAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2110;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=YHiuOn4hq18fkHfMqEhWJZ8muMTRuaWOyeakJRLBng4=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBl+AkAsnlDrR3gAv9akcDuPnTJurQXGhOslEARd
 QJhUAOxujOJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZfgJAAAKCRC/aVhE+XH0
 qz6mEACP/k2WYqTeiJ5VuMRsRkih5hAz0R/tAYjJpbRm6Jo8ztDwS4OenojAITwo89NSaVn9ep5
 IvT1/qTzUP+B8Wgl5b67VgLlN2/jLED8+/bVF8Ym8NRB+H+6+J+ZVA37WlMTih5Lc4jclhJVjcs
 UssvT1JFEJ3oeU3FNivsxT0l6D/f9Kohl0KQjoobncY9FwqWkLjRMwDVsr6Uvqlr/EuYw4a3mXj
 /+yocd4F6vIv0P1BrlxLmOMSGDCg/0KudLg3kP+C5BK/vsTA+Z8ZyKToIMYhGRwrehd3G3LKkyP
 vA8pxLS4gaN3NEbc07YigNJsgeUCzPrgbyw273jC8vXLA/3c09oCOjFaGdAg0JDNSmTHJYDoEYC
 nWXgchHhkUa0xai1REo2Er0voziEfWcObJn6Vr2azsEGIYUxs75MUqtqA1F0hsISUIHA7Ak9270
 PW0XGM3SPvp+h2gZ5M+TKa3EFa3vwQin1ePgXZDlptOuJl9ZubrZUEqqjPjkX0g5ftJfs0Qhyxd
 ZOVcV2siP+01cpsKouOO52bML7vhmlsBIRXoK3R1y3d6jP/XyhWUKn3/Uoq2UXP2qIAjRgj1l2W
 2b4IaUd8OG7QXBULaDCTw0WD/cC+PCR+iW28T5joQj+jQ5Br4lGwccOXjV+MzbjvdC9a5zVSrgj
 knx2D+NCfmh43Vg==
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
unnecessary extra parsing by moving the decode functions to the
end of decode_start, when it is save to really parse the data.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Changes in v3:
- Moved the clock_decode and stat_decode to end of function as suggested by Ricardo Ribalda
- Link to v2: https://lore.kernel.org/r/20240221-uvc-host-video-decode-start-v2-1-88c6e17e487a@pengutronix.de

Changes in v2:
- Moved the EAGAIN bailout after the sequence handling as mentioned by Ricardo Ribalda
- Link to v1: https://lore.kernel.org/r/20240221-uvc-host-video-decode-start-v1-1-228995925c70@pengutronix.de
---
 drivers/media/usb/uvc/uvc_video.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 7cbf4692bd875..7471bff0ca894 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1078,9 +1078,6 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 			uvc_video_stats_update(stream);
 	}
 
-	uvc_video_clock_decode(stream, buf, data, len);
-	uvc_video_stats_decode(stream, data, len);
-
 	/*
 	 * Store the payload FID bit and return immediately when the buffer is
 	 * NULL.
@@ -1147,6 +1144,9 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 		return -EAGAIN;
 	}
 
+	uvc_video_clock_decode(stream, buf, data, len);
+	uvc_video_stats_decode(stream, data, len);
+
 	stream->last_fid = fid;
 
 	return data[0];

---
base-commit: d99e42ce6b8341d3f09e22c6706461ec900fe172
change-id: 20240221-uvc-host-video-decode-start-af53df5924cd

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>



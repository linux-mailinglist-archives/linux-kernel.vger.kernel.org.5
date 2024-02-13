Return-Path: <linux-kernel+bounces-64551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00668854036
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339421C26393
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6552463512;
	Tue, 13 Feb 2024 23:38:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F2263115
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867486; cv=none; b=LYrAcQL5hgvn3TwHAKYliKzVtaMIVJTPsPMct2bV4S4H3aJZ/VW9pbcmz2BApIDNyKXvMk5FmFyJiVPdakmRpcwAN/PnxvmORU+CDRzTYv2FcH/zd+ckh6N8eVgjG4UA2zwFj2CArZfnErFhXzcUIKMvTJF/VbHyNjF7cbX2XCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867486; c=relaxed/simple;
	bh=zJFsKlY0WC/+vbUF5r0+a6ycxV44n2X/Clj+/b/RXHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rDz+ZggOcTXMuDmbd5ic/h97TyHeRkUrE1egqRsyp/JJ/lR2kD98OilzBvEmGzTok7KnmzX8DOwuHfXZgqQtjL4v3Ow6vYEBVNFFo5v4ghArhyA88Sf6L0xIidJBCbcwCriIF1AqvihJ4B/bn31Q8oXl0p8OnMNP+iRTc46x4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2Lg-00013M-2r; Wed, 14 Feb 2024 00:38:00 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2Lf-000Zgb-JV; Wed, 14 Feb 2024 00:37:59 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2Lf-0032pb-1l;
	Wed, 14 Feb 2024 00:37:59 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Wed, 14 Feb 2024 00:37:55 +0100
Subject: [PATCH 2/2] usb: gadget: uvc: mark incomplete frames with
 UVC_STREAM_ERR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-uvc-error-tag-v1-2-37659a3877fe@pengutronix.de>
References: <20240214-uvc-error-tag-v1-0-37659a3877fe@pengutronix.de>
In-Reply-To: <20240214-uvc-error-tag-v1-0-37659a3877fe@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=zJFsKlY0WC/+vbUF5r0+a6ycxV44n2X/Clj+/b/RXHA=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBly/1Xia0Z7Bi7XYREgNjlQdb6dlD2+EA8P8+hH
 cg0SyT2JkiJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZcv9VwAKCRC/aVhE+XH0
 q2bXEAC83zfWn5hUq144BEgxUOJ/7IZ1mFOGLHo8wjQWok6Eogoygz0wGnq6TK2OwqXwud7Djlw
 +vfSQcP9lATfvIYYGZcTNoZUo5ZvxWNGuRU/jbhb22P61S0zTsuBFnEcUjdYMqiHQb0q6fC92nd
 LsuidPwrjc4/AO5DOfin3TgbqUm2MxqzB5TNuXXlZh01/d6cRt6zpUF8Gi6H4GkBbIKz1yjLsIF
 vVD/w2HBfCEVMAX+BDLbRVN3lZ6y7UYbhGha+NMwwIcnsl7I41XMsJI0hx/A9KqhOLn+5lYk+iL
 xnssLiqISc+qN/nJlS0eANq/ZQMBBKEyrDYc+yxpVN4Q0MApfe2kYIZC+R2ocwZvnAVUxyCUNey
 OPyREdnSHfKqwedhAwO6RhEMKSBM8E2EP05tQTAs3RpqCUjYyGlgsNPW08vS8N2IeiGcUbr+1U5
 puHNp0+RyBFkfifQoPBRLSdTkFTTZO/r6dGpCTH7VjQlDE0UwiQ3qlWO5RNF91EUAi5OQF0j0Gn
 sOWXKLtXMK0stIwNP9T3N6j+TAXevL2Djkl5IZjD/JMEYKaTzB8olJcZGkO1U6yHuUOjvcspCOs
 bvG5F++LSvPZLmNKP3ErKo/r5s9x0rbbp1mpNbKIjIbYOygbat5aIqp51GDdlErfJRHIMChdUep
 MblXw3ANt6lMtXA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

If an frame was transmitted incomplete to the host, we set the
UVC_STREAM_ERR bit in the header for the last request that is going
to be queued. This way the host will know that it should drop the
frame instead of trying to display the corrupted content.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/gadget/function/uvc_video.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index c288aceee92ac..af99958e6abf8 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -35,6 +35,9 @@ uvc_video_encode_header(struct uvc_video *video, struct uvc_buffer *buf,
 
 	data[1] = UVC_STREAM_EOH | video->fid;
 
+	if (video->queue.flags & UVC_QUEUE_DROP_INCOMPLETE)
+		data[1] |= UVC_STREAM_ERR;
+
 	if (video->queue.buf_used == 0 && ts.tv_sec) {
 		/* dwClockFrequency is 48 MHz */
 		u32 pts = ((u64)ts.tv_sec * USEC_PER_SEC + ts.tv_nsec / NSEC_PER_USEC) * 48;

-- 
2.39.2



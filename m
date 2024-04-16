Return-Path: <linux-kernel+bounces-146645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CC38A68BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA941B2105B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7051292CE;
	Tue, 16 Apr 2024 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="V+01Wog9"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B366BB30;
	Tue, 16 Apr 2024 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264036; cv=none; b=Q/81IwdelGRc0olX+N2hd2RbnZmErFY5lNZvGl+LqPfoow+mtlBhh/xQJM07Q5G+kWtfy52uCcgXBd/0xDeqDLOhpgp+gDLtQVn5gQ4u1vMIZNnI4yh4v2orItLd2xBVpI352eWyhCiC4hGuW5QOzURckRgbcjH9Y7vDKPBEzWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264036; c=relaxed/simple;
	bh=HDDQMoAu1J/nqy54T1qbzKVRZVUdd5vlToKPN3OlY38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=quCwuWCSd+Syv3NXpQ1Fh0+V7+O6SjiW3ytW5j7Z78JBC345VCzUsLJalj6JPfIMXIBRZrwot7VlON1BhFeO6+L+P2vLrvUzXHilFIvr2uve+lLvyNU7n1V8/D4vhalTWqSN6skVgfxx+usdsG63y0tGDY1La7tsB2Yh5V9KdCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=V+01Wog9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6BF23512;
	Tue, 16 Apr 2024 12:39:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713263986;
	bh=HDDQMoAu1J/nqy54T1qbzKVRZVUdd5vlToKPN3OlY38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V+01Wog9qx5wk0Evoh0a4pso0baxb0geOks8d/TY+SXn+sAXJXLQS4oqWgojPKnxT
	 LxSWE580TTzmq+bOMu+Bg/Ge0odW0pUpmR3HlRucfIDf3Jrm0vklam5Y8fZq/4z7G1
	 VvdW3HFxofwzszh6kqNU6R4s4vLA90l/hlw0z6Yw=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 13:40:00 +0300
Subject: [PATCH v4 01/10] media: subdev: Add privacy led helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v4-1-1d370c9c2b6d@ideasonboard.com>
References: <20240416-enable-streams-impro-v4-0-1d370c9c2b6d@ideasonboard.com>
In-Reply-To: <20240416-enable-streams-impro-v4-0-1d370c9c2b6d@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1985;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=HDDQMoAu1J/nqy54T1qbzKVRZVUdd5vlToKPN3OlY38=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHlWccoO/zUzeu292dIBDfL5cEr7SrC5ATD9bW
 07zSM55xiGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh5VnAAKCRD6PaqMvJYe
 9dhGD/4l52Unx5JsLj8n+Dzm271E+4Qb1qmdI5H0E4E97+NQf51kUTpiRaw/j/kXCFmzCo10Foe
 GsvR1gRQ0YN82bp1bCsSEV4IxKA9vrxksq0m9MGrb5VYJsVuT/1zPBENS7AQB9qRFDgnt1wnsSr
 5quPmulgL8R90OkQXQNxHu41YFjrVLQlaMwU7FHWKIZbTtoCLH57zkphkSA5nVrFwGOf+TnCXOS
 SaTjrnJhtr//LqfXfpoSh7y3q3wu5U0sN9PmfwAtgO7VIAh6oGG4UKaBgONd7ecw3B2FX/2wuAs
 1EwZ4zgApaC42JX4h/JZJ0RVsumSzOv7jUPHvflx0HEGcrXu0gNJ39iVXLEcvR76h39B1hvMrNA
 GIFJ6hA4Ox9ChHaC0iehF3+Y0qyrd0AMY5WpLJRYm9ZfmeApXUs3z6O01bHeMh/HMZH0igZXv+C
 Qv6PDWX9ZZN9BMUhLZKuaIjOqwEluwVbjJdR8yWChgy1AQ0T4SRROjTPyDFJIRrZx7chTiBP+1Y
 x6w01RVdTj+C0vwDksudrcGP8chvvxdIfmGw2Vrms7NgP4XXUMaX8ysfNFddOfLPxke+dRKVtuT
 KH09E6NxkkiY/xoL44aWsgXyu88oHiRbzSU7rNT/qkIDSsl8uw6nqpeV9igr1NpTeSSLxCiEQiK
 +Q0S8GWzuDoSs2A==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add helper functions to enable and disable the privacy led. This moves
the #if from the call site to the privacy led functions, and makes
adding privacy led support to v4l2_subdev_enable/disable_streams()
cleaner.

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 012b757eac9f..13957543d153 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -148,6 +148,23 @@ static int subdev_close(struct file *file)
 }
 #endif /* CONFIG_VIDEO_V4L2_SUBDEV_API */
 
+static void v4l2_subdev_enable_privacy_led(struct v4l2_subdev *sd)
+{
+#if IS_REACHABLE(CONFIG_LEDS_CLASS)
+	if (!IS_ERR_OR_NULL(sd->privacy_led))
+		led_set_brightness(sd->privacy_led,
+				   sd->privacy_led->max_brightness);
+#endif
+}
+
+static void v4l2_subdev_disable_privacy_led(struct v4l2_subdev *sd)
+{
+#if IS_REACHABLE(CONFIG_LEDS_CLASS)
+	if (!IS_ERR_OR_NULL(sd->privacy_led))
+		led_set_brightness(sd->privacy_led, 0);
+#endif
+}
+
 static inline int check_which(u32 which)
 {
 	if (which != V4L2_SUBDEV_FORMAT_TRY &&
@@ -422,15 +439,10 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
 	if (!ret) {
 		sd->enabled_streams = enable ? BIT(0) : 0;
 
-#if IS_REACHABLE(CONFIG_LEDS_CLASS)
-		if (!IS_ERR_OR_NULL(sd->privacy_led)) {
-			if (enable)
-				led_set_brightness(sd->privacy_led,
-						   sd->privacy_led->max_brightness);
-			else
-				led_set_brightness(sd->privacy_led, 0);
-		}
-#endif
+		if (enable)
+			v4l2_subdev_enable_privacy_led(sd);
+		else
+			v4l2_subdev_disable_privacy_led(sd);
 	}
 
 	return ret;

-- 
2.34.1



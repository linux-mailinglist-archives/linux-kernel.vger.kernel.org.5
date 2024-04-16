Return-Path: <linux-kernel+bounces-146917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C858A6CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85761F21FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EE912CDAF;
	Tue, 16 Apr 2024 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="a7EI6CAC"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F99B128398;
	Tue, 16 Apr 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275728; cv=none; b=uLk+RpYfI6YZGndph/7Z56LlmFk2purRyBAn2eQqqRRj2PIpBqclK/zB7PYumWymLl61Qty2NsjIzHkU6oBKBLOCWEFNRs6bCZv1k4SkgqYJe29bF7ClzTjP1zv7fXUDTzSoaeoSm0L/4r4DBHb0bxC3c56p9j3IJfRHmzaLJJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275728; c=relaxed/simple;
	bh=HDDQMoAu1J/nqy54T1qbzKVRZVUdd5vlToKPN3OlY38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bO6YoH+CAorcgmxsHA7lZYIpDcMX7aCafP14m+5yBOCQv3hqX8c2brikoOhr0FwkdR38QUljPBzOmGCJyVYRnyofabp0NUKUogk0EDv4jjuUCvpYnWp66I+YY8DMDoLcsf1SpzfBmMQ8OZD1X1UvMjIEuLmiucFUaqRE7vckNiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=a7EI6CAC; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1FF18E0C;
	Tue, 16 Apr 2024 15:54:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713275679;
	bh=HDDQMoAu1J/nqy54T1qbzKVRZVUdd5vlToKPN3OlY38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a7EI6CACsqLunUDEnSPpIU4SfR+wgzOUvX6YdGZPhfC6Y4qVwDgG9RYW9gmmg+5Ft
	 mkYqLhAULJSuNqIuorpZ2o20bZrcBpgmuOey5Jtq1RFzGQ51TFzZ9aUC7VlfEcLRn+
	 ER2wKztvgzALZYSn+YAiLbtQHfKh5TGfxkOt2l7o=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 16:55:04 +0300
Subject: [PATCH v5 01/10] media: subdev: Add privacy led helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v5-1-bd5fcea49388@ideasonboard.com>
References: <20240416-enable-streams-impro-v5-0-bd5fcea49388@ideasonboard.com>
In-Reply-To: <20240416-enable-streams-impro-v5-0-bd5fcea49388@ideasonboard.com>
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
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHoNIYoTxjUiNWqxEKS5D3N9kKWEU+csS6oTBA
 lt2AfmvtpuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh6DSAAKCRD6PaqMvJYe
 9RtLEACNAd54didoxkE1V2UMhayPIb36iZSRoUG+xPUGVuqEzeQMDBGVH3qpbxOyH7Xb+D6DruQ
 gN8Ngl/AcVT9Y0mz5GLVuWl4+VJqrgTSF0RQR5X1f38DcZHE6kj0TwekQyOPqP5nuL34zvENr8q
 JnxNw1DFo9RCXo9MDohCs6o3WM8RXM6I1Rw19SWWmNDK61tjQOjLYXYpWNIGE+gSC1BfCizs5xu
 +yr6BM+KVNMOTA6QdjhfFVDcRM9U4TzxC1xECbciLBggxlpHA65Vr+cd1g+JGZksQFmylpnaI6a
 CQc5XUR3k7Gx9SbZHydlCnA/BAstB18c6IpHdsv+4eMaLsqqrOJk2avv71LoTIUZEa3rwg9Wh66
 PWYLgo+y4jPOoAi04gYRlEivZPLHH+yCx0fb/ABDO9lgQJCPAt3VySuIDhVINx6pAxpH4dS2Hr0
 WtkG4kCb/U4nJT6Ud+69wGtZ3UKWzoIYzyyHqex1fHIaVSUBwnV25dJEv9EmN1LFZPY4fprLZ4H
 0MqaZXyTz98D1prl2mEItdc26N08ZYHmtRW6onBNKOsPJFwwHIfTVxKEgrydQiwupeI2TXIx85Q
 iZz4YKXf8QoXRK3Jnqh4YZEqYVC5tU8KMnUQ/rzClTOlfcw4FM0vF4PLrvU7znkQg5KCIu+RLPp
 mcNUlQX7zo5dKiA==
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



Return-Path: <linux-kernel+bounces-138506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8BB89F263
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F17C1F23CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EF415B541;
	Wed, 10 Apr 2024 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IQ87CtXM"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F2F7C08F;
	Wed, 10 Apr 2024 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752614; cv=none; b=OJKv1x3rfEgc0Q91oi4siYFL62ePbNdutEaghg3hgF2ALo2lq5U5sylkvPxex9fBnxEL4BVT1lC+rSqFOdYyh/OJDOuTVPPLP2N9nEhPb4rej50ut+GtbD7WLXg6vcsajWqFvmGnWNRRQchxrshRoNCb8XKPt7kFQhjI21TFY6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752614; c=relaxed/simple;
	bh=le94SkkfW9uul6i34iKBtYi/Z7zUyGKKz208IU5JKeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F9xoOzO6ZBM6183hSZk9fRFLs5lCV15vtMuc7r3VoYIDkUEFWQ8/vvhCXmSexZmQWHDj9O4fefjBsSzh1i50tg3St+IcCdi5rwdGmcSlERThsjsGI363tO+eZNb33Q5LXWZQa0R/zSQXsE9y4GNLUU+qPlQPIGlyvTBC+YYjQ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=IQ87CtXM; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 83A63A9A;
	Wed, 10 Apr 2024 14:36:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712752568;
	bh=le94SkkfW9uul6i34iKBtYi/Z7zUyGKKz208IU5JKeo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IQ87CtXMneByaBE1UplzL+ChRadT04Wxs4X5ELeClwkifoDmB4eIWWz0+RslNHRg8
	 8V3IIcZMxzzG1PYowUBsKPwDCCEIlop5EWYTPKaa882zmaA8X+xBfsKCSUQCIeBn+Z
	 H1RV9STkgANn1Ldo8X98DQu+hitimRycwUeVvaOg=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 10 Apr 2024 15:35:48 +0300
Subject: [PATCH v3 1/9] media: subdev: Add privacy led helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-enable-streams-impro-v3-1-e5e7a5da7420@ideasonboard.com>
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
In-Reply-To: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=le94SkkfW9uul6i34iKBtYi/Z7zUyGKKz208IU5JKeo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmFofe4ALeW0V6reIObLvxN7BsmmAxljaKE64ls
 fUDD22Sa12JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZhaH3gAKCRD6PaqMvJYe
 9ZJKD/wPEWBbZICpfZqb+N3PQUtclfBIaOtSyuYdqwR5PjVNc/5Y+jhm8H3aRw/skXinKTdmxwD
 PI5u1/YhW1Q2Iu6n04VH/72ZcKyzlTcu/aPuyBp7gQUawdtW6N4FDb50eCACH4UHTOgbYNKhA23
 CeupTngJj5dM8IDur7tYeNE+eJudtYnoEDnXwfWKsVTGZnxBW2Bg7jaVHaWxEwwT+Wc7e8g9KsN
 BDxSsZT5ErQLWSVHP80LU+Ock0ZD5j1pj0YtgV2/2LPEf+cBNFy19+2UTOvBgC7Qp3GwoY8ofu2
 d/oWMFMbS+GA4Z57mlwxuSkf387ZieepUFfHPxgnHG7VLB7v0HoPtVnuWxoXDGG0m4RiG7xreGi
 j2gtzLY5QnL1+drUy7zlg5JLOtuOfXPqeG+OCxXxkTR90zRL7hQ6MnNeDs6zpElbmKuh/EP8pfl
 YspMgQgRRclJN0NTOnaz/l9oiO5o1hKYBi3HI64x8GzpGDVtPNsAFTNLnJRfXnEt4WnEEVobVLJ
 c/eA4WaDSECHjl+mUmM1WSJfeBuoM76beZTz9kcbysvoqtE0gD38iJRKt2mgsEwjdHpxO9bZMpu
 btymEE6QbabUtWQfONhju0vUSS7uI839dWoyKgguSD52UWRIEl/G7z9mL4SV1264ivJ5LsnrAG/
 U4y26OxbTKT4seg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add helper functions to enable and disable the privacy led. This moves
the #if from the call site to the privacy led functions, and makes
adding privacy led support to v4l2_subdev_enable/disable_streams()
cleaner.

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



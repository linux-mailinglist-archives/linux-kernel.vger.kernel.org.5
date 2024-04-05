Return-Path: <linux-kernel+bounces-132710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 875C9899923
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41709283BC9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051F515FD17;
	Fri,  5 Apr 2024 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="W5bHRzKr"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BC415FA6C;
	Fri,  5 Apr 2024 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308485; cv=none; b=HcbggogfLxngUb7XfA16uUcX/1XRXC2DbZGMpzmxhSvzVoONNaMdeTGGcwQkyvc6GPYN95bS+WHb40YEma6FYQ1lKL5+1nTM+9GHQps2xnjqFPopzmM7VF5T5bLTL51Zgd8lmOz/S+ULUmt8YVXSTWao6DjG+8pQi/TTiyKZ39M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308485; c=relaxed/simple;
	bh=9mXTtGDpitUEzyHWLPsdvBFtHi7vvqqQxqsj2Nz0lu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FeNkK2n/avCy2Gq3G5uenaASe6mNeSpsv/ZzlMfaDZ3lVtbkhLWTrl8r6JKgL8fQnUR6y0em8mhREdlDTSUlRHfdZYzvNZGEzOLhZRCq3n9oWIjzyRKrTJymlQGdPU9CSmY8xKk63PePqTmue92GOzDleB7xTNROG2NtfJqQs4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=W5bHRzKr; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B518DDC9;
	Fri,  5 Apr 2024 11:14:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712308443;
	bh=9mXTtGDpitUEzyHWLPsdvBFtHi7vvqqQxqsj2Nz0lu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W5bHRzKrFAvISyg13zUuyoz3wwwRzSHotxpZTD0jIdZ2bPJM/2b8/8bPj7MS0unf7
	 6HCsWefCjzYz3rhM9F3CV3pK00d9QKwDk8ogDS2YKfFXrU7FBI7rFcRxmAuHLiXYjy
	 FYYVgrU5q5Yc14D2rG+H4pZodObfYIhPCEKiwqLI=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 05 Apr 2024 12:14:19 +0300
Subject: [PATCH v2 1/9] media: subdev: Add privacy led helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-enable-streams-impro-v2-1-22bca967665d@ideasonboard.com>
References: <20240405-enable-streams-impro-v2-0-22bca967665d@ideasonboard.com>
In-Reply-To: <20240405-enable-streams-impro-v2-0-22bca967665d@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=9mXTtGDpitUEzyHWLPsdvBFtHi7vvqqQxqsj2Nz0lu4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmD8D9PKk5m/aneVv3WUawS0bT8nWPrkksElujb
 rmAHCaFW7yJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZg/A/QAKCRD6PaqMvJYe
 9RLAEACYtjUDlFJ7FR4epbNukPUUDe68AtpfG1hqKIi6H5qlJTgNRiRaR0nVqM6dXNKgrOYpU/4
 oz7tD7t3hATzqAUKTSb0V7/fkfx47rlOk4OZuipqNZk06NHgyFXQeObzMQpWxQBu/sEHqZMrrjk
 5GMwgskmvW+4UH7FnDDrwG0FepOxsfktooZ4Hfgf95OeLoD7tDkAQWIjPdaMwbvHwPxOhZTRd6n
 nSSqZFY0SkyZhGH5azenbA9HO0+cU0a14h2SZbLyJkRhDYstY+Iehe4BJzkLl+fm1MMyx1eRihw
 qlhwlIf28PHbKBOPXsMRcSv+br4wgU6qKa3RP+FHajNoJhf+kIv5O7nRkNBRb3mZz/tGRJFHNBH
 j22cSjmnhor786XrSvtTOmQxdGF37jhCNfyiqwe9tNhdfvb9n8LVQSsuUdr52kNdyc64NzVsWtF
 Rmm/yRnz77cLO4wVnoLSlyW05ciEdQ+ATlkCaFExtavbnzz0LqJC6HvrdIHufr5pSHORDMxnq/e
 xuz8puyQpCcrYS+GrTg7znad/qojZyE8bvv2BSkpOJiyNk9tb4Qla5SnDuzuN0tQZr6OQyUNAUR
 q+y7c1qnJ9/YFF60gjRjFCk4mVnZ813WL8HzaqBJHNd4EoAME4NJ+51D4J0kwO14gFRRKoBYiQl
 DHIwP4pyHxt89XQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add helper functions to enable and disable the privacy led. This moves
the #if from the call site to the privacy led functions, and makes
adding privacy led support to v4l2_subdev_enable/disable_streams()
cleaner.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 4c6198c48dd6..942c7a644033 100644
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
@@ -412,15 +429,11 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
 	if (WARN_ON(!!sd->enabled_streams == !!enable))
 		return 0;
 
-#if IS_REACHABLE(CONFIG_LEDS_CLASS)
-	if (!IS_ERR_OR_NULL(sd->privacy_led)) {
-		if (enable)
-			led_set_brightness(sd->privacy_led,
-					   sd->privacy_led->max_brightness);
-		else
-			led_set_brightness(sd->privacy_led, 0);
-	}
-#endif
+	if (enable)
+		v4l2_subdev_enable_privacy_led(sd);
+	else
+		v4l2_subdev_disable_privacy_led(sd);
+
 	ret = sd->ops->video->s_stream(sd, enable);
 
 	if (!enable && ret < 0) {

-- 
2.34.1



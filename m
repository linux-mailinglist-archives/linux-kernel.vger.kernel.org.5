Return-Path: <linux-kernel+bounces-157218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2057B8B0EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03237B2CBCB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7691607A7;
	Wed, 24 Apr 2024 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="l6kT5UEI"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73866537E9;
	Wed, 24 Apr 2024 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973183; cv=none; b=MudKDx3Nd2J9pBmyKy4H2k6PsGTPGZju09MH0eLtVbftP0UgXIW/n5iIayXUH9t1QAXGPafeQccxvRZmHm4PgHilipRXvhUTsUs77Gygd8tTeGvldhBuk6n/sie4pUDLKBZ1a7lfWhP+81GFuRgfWtGnR1O7D7h6oua3okco36s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973183; c=relaxed/simple;
	bh=23+0yDyOWieu/OvqCnq30wt6Gy8zITnht47Y9cnyRBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yc72L//dxY4UcpCcN3alIQstB4J0XGQdxRUHgCFgQPzbY3lnd/8eQe5wi+6w0jIsZh7PV8hdGWb+U7eue8YlT4G+WC6N2TrsqSB6+beiP2Hn6EO4QiuFgdJbAHIps8f6cUr5taOi0M+ODkh71lDe7Hb9jZqtSjWIOGe/hkKtlRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=l6kT5UEI; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B208582A;
	Wed, 24 Apr 2024 17:38:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713973129;
	bh=23+0yDyOWieu/OvqCnq30wt6Gy8zITnht47Y9cnyRBI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l6kT5UEIr5z4wboZG2u4xduokf3VY9YNP2jHz5c1f7MWnfSpK3jveJabtOwAES7Ew
	 GxP2MbLSbCXwTZPkscoiYZIkKoUTDcgnANAZJdm+sjfg2fRlEFhzKFEeubwCTgbsss
	 ECHaVuoy7XMx7mdjZmE5R8buVcHwjwQz3bC/voB4=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 24 Apr 2024 18:39:04 +0300
Subject: [PATCH v6 01/11] media: subdev: Add privacy led helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-enable-streams-impro-v6-1-5fb14c20147d@ideasonboard.com>
References: <20240424-enable-streams-impro-v6-0-5fb14c20147d@ideasonboard.com>
In-Reply-To: <20240424-enable-streams-impro-v6-0-5fb14c20147d@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2038;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=23+0yDyOWieu/OvqCnq30wt6Gy8zITnht47Y9cnyRBI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmKSe3dx/jb6pAhJovrc5ZPCvTIdE9XH5hWVQg6
 tiVaXMQ59GJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZikntwAKCRD6PaqMvJYe
 9S6XD/9JTdPIoBtpzJFndCfeS/N1WwDLvHTF+hdnm3CkW1IYpjvQfAoThvFmJXgCvB3rfOzf4KA
 TxSV9AGnM7hcCIWx/BOtCrZEcYRVIymHzIToJLMNwmySWq3S0UXwZUsxEDDSXyKG9i7ZfLQ6Q/R
 OH1hQ+W4DhISCrcVyaQU4mxA/fflIU3yy1s4zr3RK8AtL/gm0EhX/kCFjW9kNAbX3+Iou1bt+Dq
 sjX9YjpbQHNMBG5RnZM+CmdkAc2HFH/glUgaD9BHgte/v3CfZUPD7PYbltIWOVzqtDeZdHwzXbQ
 oI26BHw2IyTGQnuxA0mVJQ9VqbqgPiTyQglPAb/h8LftS6n5boBb2WJmkGzQe7d/sZk/QqfVRNz
 NQR+cXC277TGLAEAlvjWywwBE+KS6z5yabKWN2+5ImgoIMu+XnNHdRnHPBtQzUw/xvHOEDMpgiG
 HNc8nWnt/NNaGDCh9aeOx19EoI8Txrc2Clwe1a+EZXVZ88fBQQX37E1B2jBi5amgaKsv4DAVYWQ
 ARsBiMLfZmR2kuTvh5WITkA+iI0lwaQc7dWnLZhNXpkPmG2QoN0n/Jt9bK8AGLde9PRmVAR2R5a
 dyDs0bl1gp0cByKwuuSpWKgC5q9TVkDkqqW/hRkywMsKUNRya024tj3dvs0IP1y+URK88cT2c3P
 bp75HPqBvvXuxgA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add helper functions to enable and disable the privacy led. This moves
the #if from the call site to the privacy led functions, and makes
adding privacy led support to v4l2_subdev_enable/disable_streams()
cleaner.

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Umang Jain <umang.jain@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 2d67ec54569a..b4f0b89412eb 100644
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
@@ -452,15 +469,10 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
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



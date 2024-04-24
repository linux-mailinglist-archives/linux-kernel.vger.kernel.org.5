Return-Path: <linux-kernel+bounces-157223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 891E78B0EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D8A1F2B4A8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C22168B0D;
	Wed, 24 Apr 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="cXFXJ3Hj"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D88E16C6A5;
	Wed, 24 Apr 2024 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973191; cv=none; b=Ba0kwxHXkMQvDkD/0ctbjvt3Z1+kWO4rd+/wLSqe4Wkeoz2BGYwMavjFxkAbhwlaYfVVkJ+611fjaORijmxF46Mxq1LDlO5/OQ/tlwotynFC9gzAHcByBGbQ3ueKFh2RZIwB5crz8kIqL3ieByyuDTE15iAYfj2sgWFKWlXTDFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973191; c=relaxed/simple;
	bh=Y7RThHdyMFn/yhjyiR2IHCWsmk/FspUZdx/Zb4T64cU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hl0xAWTfboxsvsmHQhsYPocIrog0aMSaqv3dVa+/iXHxYUX9LxLdIHHJOZFAhnAlW41iFLp66KYm3s7ueaIQiiNPUJQhv0iThdDrxqFIA1pJyIi46l/BnEz/wXvlbtqRf0gCjJ2KAsLnFzNm3UfUpV9X1X0EiRHxzk5js+UNO1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=cXFXJ3Hj; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6914C11D6;
	Wed, 24 Apr 2024 17:38:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713973131;
	bh=Y7RThHdyMFn/yhjyiR2IHCWsmk/FspUZdx/Zb4T64cU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cXFXJ3HjlZQCgsaRswt/PYFSo0kiq+afHKXi7o2DVZbPqMQMullGI6g2DSSyQz/Q9
	 0AeSC9nM5pzKNCjfKtkwkK89b4/Z2EA0a2MWW97Vi1gjBNvN3A5Wqav6X8iCVBQRAG
	 iEPWDYfHU03wKdqJmsfhUquhDix2dTvIElVHP+68=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 24 Apr 2024 18:39:09 +0300
Subject: [PATCH v6 06/11] media: subdev: Add v4l2_subdev_is_streaming()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-enable-streams-impro-v6-6-5fb14c20147d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2570;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Y7RThHdyMFn/yhjyiR2IHCWsmk/FspUZdx/Zb4T64cU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmKSe5s8/tI8TZotW9XtUv+1mx0N9jJXbI26HSG
 Me8ibyKRE6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZiknuQAKCRD6PaqMvJYe
 9U2SD/9McekwdJRK+hWs8Zn6acpNUs+dl4eZQbyZAze/uoAkE/f4/aUnkCCuta7s2kmD8Q/ewtN
 K4WC1n2tZEEGa7mDKq2HSncda3ycxsqN9WIYwC1ddA80zGAoib2wTcUTtsJVzeKEYOUJwFNKXG4
 /pAmbMXvLbc+aJM8PWJbgSnojfqDdcBaykY5O4ANID00ZjtsMUz6GhX+lXhe0ievC/kCPgtLit6
 0Rtlu80RKqtqSQhPu4iDum5kA7tkC6gK2k/0TfroZJfQV9GgIZD/w2QIcMw77Ad7nGTHhXPOuZg
 JqmSBO0HiM8buYOjIPGh7Qv+SiVo8KzyayzFdaaZOVSh2VDc8+T+dXUPiSAydXaggYJWqShWCCO
 cTBip5UK/9/ttMfpCg4ebIaVnZc96L9XVIY+gG938Q+fp92fvIKLjbz+vym3Z4PY0hs7F/S0Pvv
 N1LpnUhWdexbjcDQFPo3dQGulcUxnMdKZDT98rQV+Q6yx1LEFRiGXAX/Fwpmrb6eZ3iCrTMHkAq
 lVqk6a5Yy3uoHB3ozA+DWCKQDoE/paCZ18jNFXQVFa95o4icWoNi+hL77ajc14NWvr88K/IBJCr
 6UKIGaY/arVO7b2CNYnwL3btWIQ4KUrHV/SGz6HRMDgFh6ZjwEQc4QJdO25t2FjTks8joBZTp8E
 HxEgPjdo/oRJAbQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add a helper function which returns whether the subdevice is streaming,
i.e. if .s_stream or .enable_streams has been called successfully.

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Umang Jain <umang.jain@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 25 +++++++++++++++++++++++++
 include/media/v4l2-subdev.h           | 13 +++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 3fe3de5abead..c877646047d1 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2454,6 +2454,31 @@ void v4l2_subdev_notify_event(struct v4l2_subdev *sd,
 }
 EXPORT_SYMBOL_GPL(v4l2_subdev_notify_event);
 
+bool v4l2_subdev_is_streaming(struct v4l2_subdev *sd)
+{
+	struct v4l2_subdev_state *state;
+
+	if (!v4l2_subdev_has_op(sd, pad, enable_streams))
+		return sd->s_stream_enabled;
+
+	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
+		return !!sd->enabled_pads;
+
+	state = v4l2_subdev_get_locked_active_state(sd);
+
+	for (unsigned int i = 0; i < state->stream_configs.num_configs; ++i) {
+		const struct v4l2_subdev_stream_config *cfg;
+
+		cfg = &state->stream_configs.configs[i];
+
+		if (cfg->enabled)
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(v4l2_subdev_is_streaming);
+
 int v4l2_subdev_get_privacy_led(struct v4l2_subdev *sd)
 {
 #if IS_REACHABLE(CONFIG_LEDS_CLASS)
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 37c623f39dae..14a3c91cce93 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -1914,4 +1914,17 @@ extern const struct v4l2_subdev_ops v4l2_subdev_call_wrappers;
 void v4l2_subdev_notify_event(struct v4l2_subdev *sd,
 			      const struct v4l2_event *ev);
 
+/**
+ * v4l2_subdev_is_streaming() - Returns if the subdevice is streaming
+ * @sd: The subdevice
+ *
+ * v4l2_subdev_is_streaming() tells if the subdevice is currently streaming.
+ * "Streaming" here means whether .s_stream() or .enable_streams() has been
+ * successfully called, and the streaming has not yet been disabled.
+ *
+ * If the subdevice implements .enable_streams() this function must be called
+ * while holding the active state lock.
+ */
+bool v4l2_subdev_is_streaming(struct v4l2_subdev *sd);
+
 #endif /* _V4L2_SUBDEV_H */

-- 
2.34.1



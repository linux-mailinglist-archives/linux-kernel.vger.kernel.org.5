Return-Path: <linux-kernel+bounces-132715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8EA899939
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA9F1C20FF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A9916192A;
	Fri,  5 Apr 2024 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hdKazecF"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD1161900;
	Fri,  5 Apr 2024 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308493; cv=none; b=uTdsPOeNsVsxsvHVEdPrl+9xcVH5egXmnwK+NApeF21sIvAUN7eGIChDi4267AbYlWH4Ilk+PCl517AAnxNXLEDMTCqLqyy3zKeuehMOkxbpjiCnrcFY1AGM2x7e9EBEpLuI768/bEqQJ3XoxfAO0M6NXoCD39maNozp2lvYppU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308493; c=relaxed/simple;
	bh=SmjoyNZdXH0QHsqGAvVV4SYT4WhY/bNxg3ZaVboKmlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mr8Jj1PToG1nMgNEs6tt4fACJPUh33eaKurd7ITugynVM0FaLE7XySK8IJYzW/s7v/dn3myy+XsdTDnpvw0BEeJvaVfMt/3E+E9gAGj9Um09DRPLrkZW+ZM6ZNdujLNfkg1X/HafThIhoZw66T453vf3W0d76x63xT+J2ibOTbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hdKazecF; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 72C04FF1;
	Fri,  5 Apr 2024 11:14:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712308445;
	bh=SmjoyNZdXH0QHsqGAvVV4SYT4WhY/bNxg3ZaVboKmlU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hdKazecFoOsmH5qG/VmdOe8p/TIEOveEvl4Li9NNwcwDIP64pdp7tOJGfkK1YNliv
	 M0Jt/f8Am53Nt3XmGq3EWi9nJzLdASnT+7qDcnGf8K2vwFErA+l6dYkbwEk96tikVt
	 UD9XAXNsQ4dE76Sav6uXHJkDj9boVNp3EEZcptp4=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 05 Apr 2024 12:14:24 +0300
Subject: [PATCH v2 6/9] media: subdev: Add v4l2_subdev_is_streaming()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-enable-streams-impro-v2-6-22bca967665d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2396;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=SmjoyNZdXH0QHsqGAvVV4SYT4WhY/bNxg3ZaVboKmlU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmD8D+Wag68/TfqwC+u5tnQCk/2V6vs/Axl66km
 G3wDAquVfyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZg/A/gAKCRD6PaqMvJYe
 9bJSD/4msRPFJyqW0DADfx4k1K1hrGD7HnXuMVCMR7MlCThOxLSoWO4CzmLpk3FvgnyGTZO6sy8
 Vq5JJYnz7LNLNIfExNaf5GacmX7oiCz7TRqmx6hJwzGWKwn7dBxiHii+3QoGPqkwJ3wtoG0SxOi
 iH3OjOLpkAbQftSh0Qv4x/IT40G7TSiMGI5DwIsQHvioOa60Ed+hHxdDmhy2hqJTjif9SjN8Fxp
 VVCERRvM+mCt+WnFgaOaAr2JpM7aw4HmJmZgruQB2tpJN2dUJ2LVma738h6DmpijHJ7IJd0b7cG
 tyd6r5Pbkxs27PTO4Hl9x10j+dAKO7aosUZlHc4XFqAhcWULxLY0lmnxhILzfaaw+qH4ZP1xZUQ
 LVcn/w4ZrYlRPENTkbSSE5Z3MCq5/DByfzr7Osn7SqpU88WRDJObS9/BqG04boDw76MPKp72tA3
 sy41rbJ3/sTRFWcBlDZdUzzbBxQVdE0JppgjAQTnM2JdxJubuXgF3R4E++EvtAu/bKznIe2PfWD
 UKG0BoCnJFPTrp81h7cwnpzXsTl0X+5KJFl4RDAzRAv4khyuOcl+8HBjaSS47d4Si2prx68z1in
 iQQzEoLXhqgwXBmpudYntS/+49OIcOtgjZyKUkxKVw05YMYFOr9r+mlKf+G8wfsdLvw4Hi7nRsw
 cGKHlQPVPLAGZng==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add a helper function which returns whether the subdevice is streaming,
i.e. if .s_stream or .enable_streams has been called successfully.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 25 +++++++++++++++++++++++++
 include/media/v4l2-subdev.h           | 13 +++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 764d61636765..b4981447961a 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2418,6 +2418,31 @@ void v4l2_subdev_notify_event(struct v4l2_subdev *sd,
 }
 EXPORT_SYMBOL_GPL(v4l2_subdev_notify_event);
 
+bool v4l2_subdev_is_streaming(struct v4l2_subdev *sd)
+{
+	struct v4l2_subdev_state *state;
+
+	if (!v4l2_subdev_has_op(sd, pad, enable_streams))
+		return sd->streaming_enabled;
+
+	state = v4l2_subdev_get_locked_active_state(sd);
+
+	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
+		return !!sd->enabled_pads;
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
index d6867511e9cf..270a4dfa5663 100644
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



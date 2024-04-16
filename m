Return-Path: <linux-kernel+bounces-146652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951BB8A68CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88DF1C20A60
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E7912C49C;
	Tue, 16 Apr 2024 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GIEhihUE"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9442012C478;
	Tue, 16 Apr 2024 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264048; cv=none; b=TDHkd293wok3ghODfh5RxDJb/6/ard+2+7ZA90mh4IVaNp2V4bX9WtR6ZNzN8knk+isRZPOq/EYg5ToCn9lsqwA6xTCDiIqsJdfrJbs713REU5eLEyoMGC2TAIOu6j4laFIXcHhzv0eO35Nu+gjFMZHXfLVBRj1w129GSnr+U9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264048; c=relaxed/simple;
	bh=P5Mk1MbOCA+IjWUrNTqMU+A9EoigwOcf3/o12ANGKQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mQsn3xQ4mBxpsfPVOV6Acwzrke3BFahWbaP/BYKgLIReHM8EKkBaGu4Sik5+NNWn5L3tqVnHk/VxVL/DK/bK/wqnjHrSTCQKN88td+TpV9XZpPQ74cVRHd+Vqp96MNMQZhCZLSezPw6glKhONFhnTXMhwXlS95BxDqfDoD7PQO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=GIEhihUE; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2FF2817E1;
	Tue, 16 Apr 2024 12:39:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713263990;
	bh=P5Mk1MbOCA+IjWUrNTqMU+A9EoigwOcf3/o12ANGKQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GIEhihUEZri/VqvuAK0z+NoLiKxHjEuY1h6ypPe3xYSY5wpufbLuASB/4yCk7wUMa
	 PIwjLayfaHOr9+pcu/HFk9Q3cWOEhYBwm2h9RYnG4sNiG69uJf027isFBMWupOkHAo
	 SNU/zRDIZ3hmPeEO3zcWh697Jl4MquCohjDDrjyg=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 13:40:07 +0300
Subject: [PATCH v4 08/10] media: subdev: Refactor
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v4-8-1d370c9c2b6d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6440;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=P5Mk1MbOCA+IjWUrNTqMU+A9EoigwOcf3/o12ANGKQI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHlWeRsGMjnG7FWQVe6yFYHUSrlXyTjpN4PglE
 6ruXycVeCuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh5VngAKCRD6PaqMvJYe
 9U77D/9J+/2I0xDp4N06MXQHbAcYXddmlerqBFZ33A1AEs6EgtFbTNgrUjG2t/3LLNzCkt0xGEi
 2koo9IQc+1yxsA3e7EX0Pkskmbbj3HwElKVJ8SdbIZWnNudFMNYCbKfNSQe61U2UHBi2+baLcSK
 NNFNNk31a0WyGrS7wmBRbog5i7oXPkVCsWN1CMvyCmOlN5rY8DZqgttJuTVJtGHXbkRVvQmYHe4
 5YOOrB3aShPA/9CenW86BTYol38cA5Simo9U/hyURMhio1A+JNntFd4+MkfTSPn9np4aPZcMHuT
 ROQtXdJhg2YOfg2bPKzMyUPo0DN8KvIZ8DgKZAWVdWsaX0eMgH8pizQ1SORassMsiRrjjRdT961
 Pgdr+jbp1vZJwDI2hIR+0vDIDshIO/ybEMNxe1PBVZkReRSuJZzBLbZT67u6NPosHbg2QeIFneb
 GML27AmvvQfwBizLYOL4MLY6uClbaHc0eX1czOs+0TguCwb1Hcu0lElP86v9sqCxzeSvbe8zqCU
 wEcw3qCfYkzkCsNOGvNiClZampAj3uw8tJMIgQ2ZE8pP/X2QBIq3N0nxZ3m0tvfv7uPmKicewSB
 CUD8+H2w6RCMFV+YMaWvgD74mc78KBRfvXeBmwzpgoBMdwD4zWkyF5AhyFvGUrvjKAXr7pw/m9s
 B0bRCGAAFFHMLIw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add two internal helper functions, v4l2_subdev_collect_streams() and
v4l2_subdev_set_streams_enabled(), which allows us to refactor
v4l2_subdev_enable/disable_streams() functions.

This (I think) makes the code a bit easier to read, and lets us more
easily add new functionality in the helper functions in the following
patch.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 109 +++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 49 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 38388b223564..e45fd42da1e3 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2100,6 +2100,42 @@ int v4l2_subdev_routing_validate(struct v4l2_subdev *sd,
 }
 EXPORT_SYMBOL_GPL(v4l2_subdev_routing_validate);
 
+static void v4l2_subdev_collect_streams(struct v4l2_subdev *sd,
+					struct v4l2_subdev_state *state,
+					u32 pad, u64 streams_mask,
+					u64 *found_streams,
+					u64 *enabled_streams)
+{
+	*found_streams = 0;
+	*enabled_streams = 0;
+
+	for (unsigned int i = 0; i < state->stream_configs.num_configs; ++i) {
+		const struct v4l2_subdev_stream_config *cfg =
+			&state->stream_configs.configs[i];
+
+		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
+			continue;
+
+		*found_streams |= BIT_ULL(cfg->stream);
+		if (cfg->enabled)
+			*enabled_streams |= BIT_ULL(cfg->stream);
+	}
+}
+
+static void v4l2_subdev_set_streams_enabled(struct v4l2_subdev *sd,
+					    struct v4l2_subdev_state *state,
+					    u32 pad, u64 streams_mask,
+					    bool enabled)
+{
+	for (unsigned int i = 0; i < state->stream_configs.num_configs; ++i) {
+		struct v4l2_subdev_stream_config *cfg =
+			&state->stream_configs.configs[i];
+
+		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
+			cfg->enabled = enabled;
+	}
+}
+
 static int v4l2_subdev_enable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
 					       u64 streams_mask)
 {
@@ -2151,8 +2187,8 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 	struct device *dev = sd->entity.graph_obj.mdev->dev;
 	struct v4l2_subdev_state *state;
 	bool already_streaming;
-	u64 found_streams = 0;
-	unsigned int i;
+	u64 enabled_streams;
+	u64 found_streams;
 	int ret;
 
 	/* A few basic sanity checks first. */
@@ -2173,22 +2209,9 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 	 * Verify that the requested streams exist and that they are not
 	 * already enabled.
 	 */
-	for (i = 0; i < state->stream_configs.num_configs; ++i) {
-		struct v4l2_subdev_stream_config *cfg =
-			&state->stream_configs.configs[i];
 
-		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
-			continue;
-
-		found_streams |= BIT_ULL(cfg->stream);
-
-		if (cfg->enabled) {
-			dev_dbg(dev, "stream %u already enabled on %s:%u\n",
-				cfg->stream, sd->entity.name, pad);
-			ret = -EALREADY;
-			goto done;
-		}
-	}
+	v4l2_subdev_collect_streams(sd, state, pad, streams_mask,
+				    &found_streams, &enabled_streams);
 
 	if (found_streams != streams_mask) {
 		dev_dbg(dev, "streams 0x%llx not found on %s:%u\n",
@@ -2197,6 +2220,13 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 		goto done;
 	}
 
+	if (enabled_streams) {
+		dev_dbg(dev, "streams 0x%llx already enabled on %s:%u\n",
+			enabled_streams, sd->entity.name, pad);
+		ret = -EINVAL;
+		goto done;
+	}
+
 	dev_dbg(dev, "enable streams %u:%#llx\n", pad, streams_mask);
 
 	already_streaming = v4l2_subdev_is_streaming(sd);
@@ -2211,13 +2241,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 	}
 
 	/* Mark the streams as enabled. */
-	for (i = 0; i < state->stream_configs.num_configs; ++i) {
-		struct v4l2_subdev_stream_config *cfg =
-			&state->stream_configs.configs[i];
-
-		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
-			cfg->enabled = true;
-	}
+	v4l2_subdev_set_streams_enabled(sd, state, pad, streams_mask, true);
 
 	if (!already_streaming)
 		v4l2_subdev_enable_privacy_led(sd);
@@ -2279,8 +2303,8 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 {
 	struct device *dev = sd->entity.graph_obj.mdev->dev;
 	struct v4l2_subdev_state *state;
-	u64 found_streams = 0;
-	unsigned int i;
+	u64 enabled_streams;
+	u64 found_streams;
 	int ret;
 
 	/* A few basic sanity checks first. */
@@ -2301,22 +2325,9 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 	 * Verify that the requested streams exist and that they are not
 	 * already disabled.
 	 */
-	for (i = 0; i < state->stream_configs.num_configs; ++i) {
-		struct v4l2_subdev_stream_config *cfg =
-			&state->stream_configs.configs[i];
-
-		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
-			continue;
 
-		found_streams |= BIT_ULL(cfg->stream);
-
-		if (!cfg->enabled) {
-			dev_dbg(dev, "stream %u already disabled on %s:%u\n",
-				cfg->stream, sd->entity.name, pad);
-			ret = -EALREADY;
-			goto done;
-		}
-	}
+	v4l2_subdev_collect_streams(sd, state, pad, streams_mask,
+				    &found_streams, &enabled_streams);
 
 	if (found_streams != streams_mask) {
 		dev_dbg(dev, "streams 0x%llx not found on %s:%u\n",
@@ -2325,6 +2336,13 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 		goto done;
 	}
 
+	if (enabled_streams != streams_mask) {
+		dev_dbg(dev, "streams 0x%llx already disabled on %s:%u\n",
+			streams_mask & ~enabled_streams, sd->entity.name, pad);
+		ret = -EINVAL;
+		goto done;
+	}
+
 	dev_dbg(dev, "disable streams %u:%#llx\n", pad, streams_mask);
 
 	/* Call the .disable_streams() operation. */
@@ -2336,14 +2354,7 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 		goto done;
 	}
 
-	/* Mark the streams as disabled. */
-	for (i = 0; i < state->stream_configs.num_configs; ++i) {
-		struct v4l2_subdev_stream_config *cfg =
-			&state->stream_configs.configs[i];
-
-		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
-			cfg->enabled = false;
-	}
+	v4l2_subdev_set_streams_enabled(sd, state, pad, streams_mask, false);
 
 done:
 	if (!v4l2_subdev_is_streaming(sd))

-- 
2.34.1



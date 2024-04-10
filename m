Return-Path: <linux-kernel+bounces-138513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0112089F273
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0FC52869FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61F15F3F8;
	Wed, 10 Apr 2024 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kW3hV9x9"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B5215EFC4;
	Wed, 10 Apr 2024 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752626; cv=none; b=mrb/iTA+bZ2KAsr9rDzhMXOCYWpt8/soLaKSGFmI2OIFUH2KLmHJwJH69ZDJDVIME1PfHdfpL6wt/bj4c9Ev2GtkAZHBTgOIK1y6bEoDLDXYoaX8vCmIgtD0G13mM5XOk15LE6Yl19NyY6RRx/MwVXHqij57ovJqRb1DSdwxdsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752626; c=relaxed/simple;
	bh=hIT1XDENjpdRkRoM6FaZj9/JwzLPb3kW37UU3WDbkSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c8+NxzDVYGXiBY3vFju+K4yccrdX7XK63WGDxNLRkS7Iocqbtx/FsqWswmwyACYoSPVzw9JbWZsCNSGHnGlvGMhaJUzRJrhaCL05XJFoA5wMKcalO6MgpnhCbh9td7fjMw621WWivsmMSTcPjNEBNODuBIhgKLHYA4I5pbjOw5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=kW3hV9x9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7ACFF151C;
	Wed, 10 Apr 2024 14:36:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712752572;
	bh=hIT1XDENjpdRkRoM6FaZj9/JwzLPb3kW37UU3WDbkSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kW3hV9x9XScAFEwkqzJvvppZPNpcI5Z8a4LLFOtKWtb7RLARKBkMR1Df9LiGOV6Qe
	 dT4mDUTLBXrbWPgFVueECCxkjN4+zuaYqOYjQk2swIxFgChBW/V1kgN9Bfma9AAQH9
	 DBMGxduCQ4uKWi73MuN0IMIJLF9HYVCHDq8HGDIo=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 10 Apr 2024 15:35:55 +0300
Subject: [PATCH v3 8/9] media: subdev: Refactor
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-enable-streams-impro-v3-8-e5e7a5da7420@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6373;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=hIT1XDENjpdRkRoM6FaZj9/JwzLPb3kW37UU3WDbkSg=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmFofgo7pzmuWifhCsQb6bH1dxoJlcJ7YoPUSiH
 xCvBe86JIWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZhaH4AAKCRD6PaqMvJYe
 9evSEACbN0v7VCN1aaZLPfgepjPZhc+zcWV4aUV0IqwuhJgObnFJTDbOMgqzOP0K5mbdTojOPno
 bUicEsifQWenUUwkaZaoU0HLVmd614PLZC5wVDo1dX6wZp7b+nd10ns3tut0NuVSC1s+b5AX1Bw
 fAgehwIe7CE7juJ//0J16y9rm8k8LYi4UgfIArmVL6VB598ZnejrpIqPi6iPau0nJlj+zvG1i2Z
 7H+qjTkx4HsF2oP4LUZc9qJ9rqLPgLgzl5eNM7tmf0o0ZsqYEjgvO4uOM6qYT+touQB6r/YcgKh
 ehDbwMXsDzzPJNJecJKaJCFKUCJXu22trtP1frTIs1q9RMOkXtxsxSP8bo3lAe96pjnP8rGbivW
 epimoim9nEtut1qTjVUGnQ6VBiM/mxjWZPbj1VHWL4k3FZztEx9ourkjMtVJY+eTtcEL1xuF7nK
 kXTQgi0QIzS0FA2s9FspIphvfpjVrgXHzk1y2/brbuPNH6P99S8zuG0rpTrK7Mknc7VzLHqarHu
 7NzycT+BDKMtk6d6uNU31NEQoBCLhSgPyQhlNQkgltSh4RsEk9b6i4X58IZFS4qppAqoHv1YgBY
 lwLd/c9fD9vXTvZaPkOX1oLd3Iikp9BjPEM6aXcwhEv87xCWW/wRNBkQ1HwUzV4pKaj72dZa7E8
 QjSrR5E3dzpPHaA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add two internal helper functions, v4l2_subdev_collect_streams() and
v4l2_subdev_set_streams_enabled(), which allows us to refactor
v4l2_subdev_enable/disable_streams() functions.

This (I think) makes the code a bit easier to read, and lets us more
easily add new functionality in the helper functions in the following
patch.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 109 +++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 49 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index f44aaa4e1fab..0d376d72ecc7 100644
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



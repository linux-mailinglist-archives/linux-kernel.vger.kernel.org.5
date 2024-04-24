Return-Path: <linux-kernel+bounces-157225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B938B0ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65170281523
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FAF16DEA7;
	Wed, 24 Apr 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fufNphZp"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C9616D4FF;
	Wed, 24 Apr 2024 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973195; cv=none; b=FT9d64+3iOEvISPdLz/8ihU1+QX38GTzT6ESCF3UjuE/UwHG3KdUxh4pqY3MrVoN+YLDHRc8dfbsXMkPKkg/36vU76sL0jEasWFetxbkc7Ze84KuTWxBLLxzo5kWdgElDLcHREZ182xvV1RoFHJv4OOBKQCRN2wwF2lEK7XgzYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973195; c=relaxed/simple;
	bh=SCpfcNeSlufEzUBR6PXLvSnUQtGIKEEZh8CT6DWaZPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+0hYc7FbUKs0PiKP8CUDT0Sc7h7829GICLOpVqImk7yczx7buP77p+7HwQyBRrfjQzOJcMqR/aZMx+2ViYauNCVwSJB7swL33r76wg5HBw8mihun5irxk8sdp098Yq0ZRxyNb/Ns6LJgKUt8GxbxAwoTnDkOcXxgnEnBOM+1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fufNphZp; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7B27982A;
	Wed, 24 Apr 2024 17:38:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713973132;
	bh=SCpfcNeSlufEzUBR6PXLvSnUQtGIKEEZh8CT6DWaZPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fufNphZpqHSA2jRN7tn3mxxzhy9GZFe8EQRFiBP+BFGD1eFdPue41FSNmUQcfEgNL
	 Db/+f3r5FbMRo6IOK+JOiuEnpKKl5A3EtK1tDDI5IgEtM3cG5cIqs2cbeRY1VqEF2v
	 Cyr+8o8nSYaq6CnFva7001FhFLYfFD/rW/VOfwN8=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 24 Apr 2024 18:39:11 +0300
Subject: [PATCH v6 08/11] media: subdev: Refactor
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-enable-streams-impro-v6-8-5fb14c20147d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6497;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=SCpfcNeSlufEzUBR6PXLvSnUQtGIKEEZh8CT6DWaZPA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmKSe6M6pFmjzVBidJbZHR5oknlHUkFT7GnuVyn
 DzYlLv4OvKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZiknugAKCRD6PaqMvJYe
 9QEEEACIQIZoYaynszMwGP/VL8gywnUGsU0mEWZ2fWlsJabz9KLZjvU8MalOZypBCr6xKiU52fp
 XZwPPRwZDEjx+3n0bEHvQ+qXLECzQAM/3F8n5OlGGmSNFDst9vU9hwELsIp806qE0JYH0juZ8Md
 5f3JeEuHYPo+WxKpzewWJRsSvWe++myIsR/saen22Tx+SCe7m1xeH88FhoWsKWgiyfmI+LYCR84
 KvCt0KpOTwP1qDuix6+BWxtagoz4Zagt0f7CMYunNEFt1x/i0v/q+Lmm/Adep+7vRzSwW5/Ng3z
 78GNAmbypxI0R+nRPYd/C6fOnBojkdWclyPZiGjpeOmRpZcmdrBtjTR9KYtEp4wY+EsKkf4/9ma
 W8YOjBujzG3f9be6z9p8qyhyBqRFoEbZO8P0WU88krWR58Q9eiIcwlf0dfxpXueG3A1cJ4OQSJv
 y9EpYEnYZSldb1Gl3K+cj3f5p6wlOja8dFFrS5axtzFixuWah5mZ9FquMjjsrN5H++2RzDRtvcn
 tJXR1UVYEXK6u7JemtJ39mM50jP10e2AjbKVOjMlcablwCJnNuL6SKHB8/s99sxmfpTKgwUcmKN
 F9Ncq6VSwhPIsX1w9ITdsR5GWLlPYFaRRqVCDMwzeTG7olNHMNURTJL9VRHhcPqLlBIJLcaB8Ux
 Ivi8mzpyENRn5kw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add two internal helper functions, v4l2_subdev_collect_streams() and
v4l2_subdev_set_streams_enabled(), which allows us to refactor
v4l2_subdev_enable/disable_streams() functions.

This (I think) makes the code a bit easier to read, and lets us more
easily add new functionality in the helper functions in the following
patch.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Umang Jain <umang.jain@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 109 +++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 49 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 7d0343e8480b..98629fa6de49 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2135,6 +2135,42 @@ int v4l2_subdev_routing_validate(struct v4l2_subdev *sd,
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
@@ -2186,8 +2222,8 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 	struct device *dev = sd->entity.graph_obj.mdev->dev;
 	struct v4l2_subdev_state *state;
 	bool already_streaming;
-	u64 found_streams = 0;
-	unsigned int i;
+	u64 enabled_streams;
+	u64 found_streams;
 	int ret;
 
 	/* A few basic sanity checks first. */
@@ -2208,22 +2244,9 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
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
@@ -2232,6 +2255,13 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 		goto done;
 	}
 
+	if (enabled_streams) {
+		dev_dbg(dev, "streams 0x%llx already enabled on %s:%u\n",
+			enabled_streams, sd->entity.name, pad);
+		ret = -EALREADY;
+		goto done;
+	}
+
 	dev_dbg(dev, "enable streams %u:%#llx\n", pad, streams_mask);
 
 	already_streaming = v4l2_subdev_is_streaming(sd);
@@ -2246,13 +2276,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
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
@@ -2314,8 +2338,8 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 {
 	struct device *dev = sd->entity.graph_obj.mdev->dev;
 	struct v4l2_subdev_state *state;
-	u64 found_streams = 0;
-	unsigned int i;
+	u64 enabled_streams;
+	u64 found_streams;
 	int ret;
 
 	/* A few basic sanity checks first. */
@@ -2336,22 +2360,9 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 	 * Verify that the requested streams exist and that they are not
 	 * already disabled.
 	 */
-	for (i = 0; i < state->stream_configs.num_configs; ++i) {
-		struct v4l2_subdev_stream_config *cfg =
-			&state->stream_configs.configs[i];
 
-		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
-			continue;
-
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
@@ -2360,6 +2371,13 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 		goto done;
 	}
 
+	if (enabled_streams != streams_mask) {
+		dev_dbg(dev, "streams 0x%llx already disabled on %s:%u\n",
+			streams_mask & ~enabled_streams, sd->entity.name, pad);
+		ret = -EALREADY;
+		goto done;
+	}
+
 	dev_dbg(dev, "disable streams %u:%#llx\n", pad, streams_mask);
 
 	/* Call the .disable_streams() operation. */
@@ -2371,14 +2389,7 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
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



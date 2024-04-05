Return-Path: <linux-kernel+bounces-132717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1306489993D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D961C2156B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A617E1649D8;
	Fri,  5 Apr 2024 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XeoUqcwn"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3612616193C;
	Fri,  5 Apr 2024 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308496; cv=none; b=MwJie2R7SInZmIPPUhZVtpteCK1W3+qA6U9lkVgCq65ekoD7CzC94OYvNoo9dMIkYzVSzA4bYSQix9+0nIzxXfpwJ2x92t2lVabsk37cVz7FGIeFvzCFR9IkZa8IVbryXgtJfd4bG4kAGF0CXbg/rhBQ5J7J6dBCmc2VsjPU74U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308496; c=relaxed/simple;
	bh=oB2pLuuJ6qpIoObMiHjIPESMqaoPlOn7z6vO5JW31NE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MGJ+efDhTGVCtd0LHALHxsEjqRvgQm1R5nqowls/X+oJ0S1BHA+eoXd1K/i0DoHjHScBKxQ9mYRNPLfcWOr7ajs9FK/z1M7yZfiHEFXN8CdRZxq+BCdAawmB4tysNsJAuiH7tFRnMUAzr7iIYYPTHKIdRV3ZheisrN4g3SQbr1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=XeoUqcwn; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 864C5D01;
	Fri,  5 Apr 2024 11:14:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712308446;
	bh=oB2pLuuJ6qpIoObMiHjIPESMqaoPlOn7z6vO5JW31NE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XeoUqcwnDt6XaskydgUA6ngDItx/GAOltWttEYUN1Fdbk3VMTn2aWHiHYhx/dGnY0
	 34DUl546nvjUu5KiItyBWxHRYOlknGq9L15XUbT8s0HppZt+BUiuh4GO8nX5c09ZXq
	 vWAJdXWqyOiE+K18J13KyR0a/8Dy3dW0d/GLPqXo=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 05 Apr 2024 12:14:26 +0300
Subject: [PATCH v2 8/9] media: subdev: Refactor
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-enable-streams-impro-v2-8-22bca967665d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6362;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=oB2pLuuJ6qpIoObMiHjIPESMqaoPlOn7z6vO5JW31NE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmD8D/vZsu2W/fcdIXopXfNxxzpguZ5zeFC564s
 8DwBlL/EfiJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZg/A/wAKCRD6PaqMvJYe
 9UNpD/95NU2ysrgU05s0iznVe2SJ7dkGBF8dZztvEBvD6eCohQ7fTY0ojA6vMsT2vrY8mh+KojX
 ZtYO7ZYQJQR00vqgHTvMo3cYYn39ETSAlC3EpACV6oRBS/VIOpHsTDi9RY0uXKmz4TGNxSO1AQv
 ZJnqp26d2wodaN5DH5js/KRSXgOjrGoxiq5XXBsUX85AHWa026hdMTn5KlwgAafKC2a2R/7W8g3
 JqamYrNmC3SBbvCBicH2H9NzIBMWJZS22m2TzIJj9dD5L3c1h0gWwq2jwop0wT+3tye8XO3yE7K
 7bk0enexvGWJ66uwSGO/wUcEl6+eL3memIL5KHSh29WB9WlrGBNNaQGMn37ujs2HgV4j3AWnfrz
 6tr9108gYMmZOym4JSFOX0ufnjbAfQp8kNwKQIjpBvgFG8yAYSu4S4Y6OyAODtVpSJ1knZH/mY2
 Q8h0w6kpcJH3UsjWkft2gZlnOZ9ggAl2mSeZOggDutBzPbSMa7TOGMzLvpWPYBqfDikm/Wv/xU2
 J9fY2yPJCcZ3j40wOIKN1NEfk16C/SSFuXne+BKvnooXGvnwLqT4BAQXkDznK9iq9i6Ky03vFmd
 ZF2LLn+MwNhDqjxXEnFs/TfN5BeFvs7wn7VvVdtvirt86t1QMZYycydJ9jRGXAJvkOBPkxem6HN
 09biEuUuBNUzsEg==
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
 drivers/media/v4l2-core/v4l2-subdev.c | 111 +++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 49 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 015f2fb423c9..6c3c9069f1e2 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2099,6 +2099,44 @@ int v4l2_subdev_routing_validate(struct v4l2_subdev *sd,
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
+		const struct v4l2_subdev_stream_config *cfg;
+
+		cfg = &state->stream_configs.configs[i];
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
+		struct v4l2_subdev_stream_config *cfg;
+
+		cfg = &state->stream_configs.configs[i];
+
+		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
+			cfg->enabled = enabled;
+	}
+}
+
 static int v4l2_subdev_enable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
 					       u64 streams_mask)
 {
@@ -2150,8 +2188,8 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 	struct device *dev = sd->entity.graph_obj.mdev->dev;
 	struct v4l2_subdev_state *state;
 	bool already_streaming;
-	u64 found_streams = 0;
-	unsigned int i;
+	u64 enabled_streams;
+	u64 found_streams;
 	int ret;
 
 	/* A few basic sanity checks first. */
@@ -2172,22 +2210,9 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
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
@@ -2196,6 +2221,13 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
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
@@ -2213,13 +2245,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
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
 
 done:
 	if (ret && !already_streaming)
@@ -2281,8 +2307,8 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 {
 	struct device *dev = sd->entity.graph_obj.mdev->dev;
 	struct v4l2_subdev_state *state;
-	u64 found_streams = 0;
-	unsigned int i;
+	u64 enabled_streams;
+	u64 found_streams;
 	int ret;
 
 	/* A few basic sanity checks first. */
@@ -2303,22 +2329,9 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
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
@@ -2327,6 +2340,13 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
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
@@ -2338,14 +2358,7 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
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



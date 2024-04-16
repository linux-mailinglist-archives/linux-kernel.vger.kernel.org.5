Return-Path: <linux-kernel+bounces-146924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291E18A6D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23CE284467
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A776130E2E;
	Tue, 16 Apr 2024 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BhzDoCFt"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B655D130A4A;
	Tue, 16 Apr 2024 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275740; cv=none; b=l5+ubETXduhQnQJQf+Sd4pJJxmZ+TzjVhEl/Zgz6EFpxI/+kWgbWaDunL1XNlcHA0fZU7WJ9OxxsaFUgr6xgWOQjI/Mw+st8kUxYV7KlLCALtEBt62FYkCZB0/Hwp0M5frYAdtLWBv9+zIdPwjLg6RxsiXgLzphW7UlAXjdBZPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275740; c=relaxed/simple;
	bh=P5Mk1MbOCA+IjWUrNTqMU+A9EoigwOcf3/o12ANGKQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DUAaQhJ0vn8MXQRjhmOkWZzxBJgXcBqn182rKzGJBjd3GpWie905li1pPs7fDP5VbWcsYzpdFwmOiEScMlPT1Dhr5A5Y5App4CjWniuodzdrKRn+sC977MFMSCcPtQHrppAykzIKlXL1WNCN3HlcWMuQ68EX5rIxgkzwYM2rKC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=BhzDoCFt; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E62BBDFB;
	Tue, 16 Apr 2024 15:54:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713275683;
	bh=P5Mk1MbOCA+IjWUrNTqMU+A9EoigwOcf3/o12ANGKQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BhzDoCFtAMooJYRPtOc1cKj5n+NSNhUNnF5lko69i6XDLtSCigDf0nzS63360dkZq
	 8fPXvNK2LJNLSrtvSvvOcEAtPJK2syhK5cMV5KINRKYQZjLG9OnmQEa7iHE/YpZDVy
	 WT2uSc1H+3TGUiObLrqSFaiQweFVDmnLlSJy/C2M=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 16:55:11 +0300
Subject: [PATCH v5 08/10] media: subdev: Refactor
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v5-8-bd5fcea49388@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6440;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=P5Mk1MbOCA+IjWUrNTqMU+A9EoigwOcf3/o12ANGKQI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHoNLLizQ+TtDj3TZwPD2c/LO0GhP+Gv67LkCT
 VVV0+7M0xWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh6DSwAKCRD6PaqMvJYe
 9duwD/9w/YtnJJ2MSM+B1AAdaJtN7q/ULVukNgh0FW4qQIX7rtku/rN8FpYB0ceGnr9NO5R80Q8
 CyELfeSioivwZCBntBXWpP3R6EWNmez+FRBt8PsM6Mv7S2JiYl62CwxER7tIPTWLcYJ24f8GqC1
 QPwyw94jMaHi1/90oVEhTZo2WKiErs7L6kJYW4eBeeBlK85rM1xnpn9LUgKrFIx1wgiSASlrFkK
 S48g6SME/qUDZevT/G+hU6gKM7AbGZEb5Rhwn4fCWWBC0bzHN982jlP71O4vNG8g1DzxT6uST1q
 h9dWy7QZ0S5uzIPPDfSb9dJd42p/OyyhKtF3Hzq84jv9bh2jrlgxYctN9j4dWVDp1PqBwHUe8BP
 GMWQlEeSt5FgxPmyMmnFstYaLS9ZAX2IroPnfDmIuF4VwnlrUoQLb3HFxSr8cAhCbVFQDhgw0YR
 CY/UYWBD0At0Y1WvzdJE2nYw6lMPsdyxpvLbAjx6W+It7+dSzV1KxkL36VXoDJx0O1viJGYkw5/
 CXpZgof9amnEIxjueB/uVbfbFKIB1owoyo2LXJEXDagjxVdSiz0I8rwBXZL9HENLwCErxeX6zZ9
 b/8Hrjjve+jlCy4DO2I2mbwgAcQ78PhEMaKEeOpBnpKKRc9AoXIjUVnOhErqG32P/JW1d+WGS/4
 /Bz9Yyktys53hWQ==
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



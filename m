Return-Path: <linux-kernel+bounces-146925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588358A6D0C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5F51C215A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D1612FF8F;
	Tue, 16 Apr 2024 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fHOC0edD"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA1D130A64;
	Tue, 16 Apr 2024 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275740; cv=none; b=GdxGNDVz5JyJMk0eUM2LM6lc2QaM4uBtjgyPJ4NI4uyO1PJWDO4xlsoQgwl/d71I2U4JOSMCpAQx+5FjcmdWVjYH04rI3AL/8Sjsj1pr+wQ5ACn4BFgZY2T+rrV13keEvhzqkbFFhTAe0OvfV7ej/8d48LbBwQe5/Y19rBx79lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275740; c=relaxed/simple;
	bh=DT8uUZrrFm88CNYEqCHYMCeA6zSqjEyTf1Ae5xlz9mM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nSIGjY7HVBDy/PlDsJqN06a8YmkIFMhI7L49wtk5bz7lkXOUx9aKyE60KM8WTsoEr/EqjHimitJNTleq+3QWYwqdnfynXW+2AcllnoGwwfQj0JJuwYyx5AMr2yMQkthbCUf5UUKihV/fv35S5ENtTujLq8bQIFQ063SUDjqqFeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fHOC0edD; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 78E14182D;
	Tue, 16 Apr 2024 15:54:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713275683;
	bh=DT8uUZrrFm88CNYEqCHYMCeA6zSqjEyTf1Ae5xlz9mM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fHOC0edD8m5Vng87U61KU+nuyLc8YLf/jd8MlduVBft19H4Fm/oIH/ANYI1ACUlCK
	 lz+Fpxom4Jt+c1nxCXz9lmK97l3dBbHxPycn4iWGJVfUJ5zTuI1mhuYujDjBSMhSEb
	 6jMFFKyGaaMK7PMdNHQjUgpmpBIF7D4gsuvS0/qw=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 16:55:12 +0300
Subject: [PATCH v5 09/10] media: subdev: Support single-stream case in
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v5-9-bd5fcea49388@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10481;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=DT8uUZrrFm88CNYEqCHYMCeA6zSqjEyTf1Ae5xlz9mM=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHoNLqUuqEVhxfJWhYjlA/0RJQkQEtD1iwxFiq
 pKevKQDW++JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh6DSwAKCRD6PaqMvJYe
 9R+HD/4r6GvNZCfeX5SpzrfctB4Ldaiyxyc7DUN82SFzqAWaq11H5raBsUpg6WXpijxrohH6l+l
 mPd00rNb58AGtD6b2OfCeyZ44uyq7/NDSgsP+dd+W2RTnIbaLk8eJ4sQnxtSQDOCAjs0VZ+dLzL
 7hVSrbUl+yC7cGJ52mVrjUKOCZc6S63FUo6hWgdJA9SAyVvJoKCYrADeuuDMSFObxUBLWXpEj/3
 P7y5aa+lVSvGATzWWuhmhn72/2I64Sn3dm9L0oyaEBTMokQHo4xL9COpT71fpUGSsez2HF/vh6w
 /eUIfFRyzIDDCMx+kV3exj0U8HQwU/ZMJJstWMTijB2h+V+W5WMzoXf1Xd0z7n1fvxXJQJKElCh
 mTmAXcW1Jmc42FpffMojEcHnKJWzvQ0aF7pmtflmuN19W5OjegulJTJGAi8GR3e7T+NEj7NNATm
 r3fLF6TmzqZ7KbOhoarf0vuzDp7+T34ex84cPjttsVJvObNQARl5KCmAh5L/C+NG3jSG5xoahXe
 SQz5Sf8RtVmqZmpHK5JEqAaZKiuWy/pFtQBfVUjnGwPNlbqAmmbpqeKemePoVMHp4yShe7Fq113
 BYKcx209hKx45KkQFwPgAhrjFckGkgf5PwEknM6Vgdvu28ipym7EA2m3ZPY8qdH4kf+enZ6b07y
 aE1AbvoXpK7x8Gg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

At the moment the v4l2_subdev_enable/disable_streams() functions call
fallback helpers to handle the case where the subdev only implements
s_stream(), and the main function handles the case where the subdev
implements streams (V4L2_SUBDEV_FL_STREAMS, which implies
enable/disable_streams()).

What is missing is support for subdevs which do not implement streams
support, but do implement .enable/disable_streams(). Example cases of
these subdevices are single-stream cameras, where using
enable/disable_streams() is not required but helps us remove the users
of the legacy .s_stream(), and subdevices with multiple source pads (but
single stream per pad), where .enable/disable_streams() allows the
subdevice to control the enable/disable state per pad.

The two single-streams cases (.s_stream() and .enable/disable_streams())
are very similar, and with small changes we can change the
v4l2_subdev_enable/disable_streams() functions to support all three
cases, without needing separate fallback functions.

A few potentially problematic details, though:

- For the single-streams cases we use sd->enabled_pads field, which
  limits the number of pads for the subdevice to 64. For simplicity I
  added the check for this limitation to the beginning of the function,
  and it also applies to the streams case.

- The fallback functions only allowed the target pad to be a source pad.
  It is not very clear to me why this check was needed, but it was not
  needed in the streams case. However, I doubt the
  v4l2_subdev_enable/disable_streams() code has ever been tested with
  sink pads, so to be on the safe side, I added the same check
  to the v4l2_subdev_enable/disable_streams() functions.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 187 ++++++++++++++--------------------
 1 file changed, 79 insertions(+), 108 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index e45fd42da1e3..10406acfb9d0 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2106,6 +2106,13 @@ static void v4l2_subdev_collect_streams(struct v4l2_subdev *sd,
 					u64 *found_streams,
 					u64 *enabled_streams)
 {
+	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS)) {
+		*found_streams = BIT_ULL(0);
+		*enabled_streams =
+			(sd->enabled_pads & BIT_ULL(pad)) ? BIT_ULL(0) : 0;
+		return;
+	}
+
 	*found_streams = 0;
 	*enabled_streams = 0;
 
@@ -2127,6 +2134,14 @@ static void v4l2_subdev_set_streams_enabled(struct v4l2_subdev *sd,
 					    u32 pad, u64 streams_mask,
 					    bool enabled)
 {
+	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS)) {
+		if (enabled)
+			sd->enabled_pads |= BIT_ULL(pad);
+		else
+			sd->enabled_pads &= ~BIT_ULL(pad);
+		return;
+	}
+
 	for (unsigned int i = 0; i < state->stream_configs.num_configs; ++i) {
 		struct v4l2_subdev_stream_config *cfg =
 			&state->stream_configs.configs[i];
@@ -2136,51 +2151,6 @@ static void v4l2_subdev_set_streams_enabled(struct v4l2_subdev *sd,
 	}
 }
 
-static int v4l2_subdev_enable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
-					       u64 streams_mask)
-{
-	struct device *dev = sd->entity.graph_obj.mdev->dev;
-	int ret;
-
-	/*
-	 * The subdev doesn't implement pad-based stream enable, fall back
-	 * to the .s_stream() operation.
-	 */
-	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
-		return -EOPNOTSUPP;
-
-	/*
-	 * .s_stream() means there is no streams support, so the only allowed
-	 * stream is the implicit stream 0.
-	 */
-	if (streams_mask != BIT_ULL(0))
-		return -EOPNOTSUPP;
-
-	/*
-	 * We use a 64-bit bitmask for tracking enabled pads, so only subdevices
-	 * with 64 pads or less can be supported.
-	 */
-	if (pad >= sizeof(sd->enabled_pads) * BITS_PER_BYTE)
-		return -EOPNOTSUPP;
-
-	if (sd->enabled_pads & BIT_ULL(pad)) {
-		dev_dbg(dev, "pad %u already enabled on %s\n",
-			pad, sd->entity.name);
-		return -EALREADY;
-	}
-
-	/* Start streaming when the first pad is enabled. */
-	if (!sd->enabled_pads) {
-		ret = v4l2_subdev_call(sd, video, s_stream, 1);
-		if (ret)
-			return ret;
-	}
-
-	sd->enabled_pads |= BIT_ULL(pad);
-
-	return 0;
-}
-
 int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 			       u64 streams_mask)
 {
@@ -2189,21 +2159,33 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 	bool already_streaming;
 	u64 enabled_streams;
 	u64 found_streams;
+	bool use_s_stream;
 	int ret;
 
 	/* A few basic sanity checks first. */
 	if (pad >= sd->entity.num_pads)
 		return -EINVAL;
 
+	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
+		return -EOPNOTSUPP;
+
+	/*
+	 * We use a 64-bit bitmask for tracking enabled pads, so only subdevices
+	 * with 64 pads or less can be supported.
+	 */
+	if (pad >= sizeof(sd->enabled_pads) * BITS_PER_BYTE)
+		return -EOPNOTSUPP;
+
 	if (!streams_mask)
 		return 0;
 
 	/* Fallback on .s_stream() if .enable_streams() isn't available. */
-	if (!v4l2_subdev_has_op(sd, pad, enable_streams))
-		return v4l2_subdev_enable_streams_fallback(sd, pad,
-							   streams_mask);
+	use_s_stream = !v4l2_subdev_has_op(sd, pad, enable_streams);
 
-	state = v4l2_subdev_lock_and_get_active_state(sd);
+	if (!use_s_stream)
+		state = v4l2_subdev_lock_and_get_active_state(sd);
+	else
+		state = NULL;
 
 	/*
 	 * Verify that the requested streams exist and that they are not
@@ -2231,9 +2213,18 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 
 	already_streaming = v4l2_subdev_is_streaming(sd);
 
-	/* Call the .enable_streams() operation. */
-	ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
-			       streams_mask);
+	if (!use_s_stream) {
+		/* Call the .enable_streams() operation. */
+		ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
+				       streams_mask);
+	} else {
+		/* Start streaming when the first pad is enabled. */
+		if (!already_streaming)
+			ret = v4l2_subdev_call(sd, video, s_stream, 1);
+		else
+			ret = 0;
+	}
+
 	if (ret) {
 		dev_dbg(dev, "enable streams %u:%#llx failed: %d\n", pad,
 			streams_mask, ret);
@@ -2243,34 +2234,32 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 	/* Mark the streams as enabled. */
 	v4l2_subdev_set_streams_enabled(sd, state, pad, streams_mask, true);
 
-	if (!already_streaming)
+	if (!use_s_stream && !already_streaming)
 		v4l2_subdev_enable_privacy_led(sd);
 
 done:
-	v4l2_subdev_unlock_state(state);
+	if (!use_s_stream)
+		v4l2_subdev_unlock_state(state);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(v4l2_subdev_enable_streams);
 
-static int v4l2_subdev_disable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
-						u64 streams_mask)
+int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
+				u64 streams_mask)
 {
 	struct device *dev = sd->entity.graph_obj.mdev->dev;
+	struct v4l2_subdev_state *state;
+	u64 enabled_streams;
+	u64 found_streams;
+	bool use_s_stream;
 	int ret;
 
-	/*
-	 * If the subdev doesn't implement pad-based stream enable, fall back
-	 * to the .s_stream() operation.
-	 */
-	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
-		return -EOPNOTSUPP;
+	/* A few basic sanity checks first. */
+	if (pad >= sd->entity.num_pads)
+		return -EINVAL;
 
-	/*
-	 * .s_stream() means there is no streams support, so the only allowed
-	 * stream is the implicit stream 0.
-	 */
-	if (streams_mask != BIT_ULL(0))
+	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
 		return -EOPNOTSUPP;
 
 	/*
@@ -2280,46 +2269,16 @@ static int v4l2_subdev_disable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
 	if (pad >= sizeof(sd->enabled_pads) * BITS_PER_BYTE)
 		return -EOPNOTSUPP;
 
-	if (!(sd->enabled_pads & BIT_ULL(pad))) {
-		dev_dbg(dev, "pad %u already disabled on %s\n",
-			pad, sd->entity.name);
-		return -EALREADY;
-	}
-
-	/* Stop streaming when the last streams are disabled. */
-	if (!(sd->enabled_pads & ~BIT_ULL(pad))) {
-		ret = v4l2_subdev_call(sd, video, s_stream, 0);
-		if (ret)
-			return ret;
-	}
-
-	sd->enabled_pads &= ~BIT_ULL(pad);
-
-	return 0;
-}
-
-int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
-				u64 streams_mask)
-{
-	struct device *dev = sd->entity.graph_obj.mdev->dev;
-	struct v4l2_subdev_state *state;
-	u64 enabled_streams;
-	u64 found_streams;
-	int ret;
-
-	/* A few basic sanity checks first. */
-	if (pad >= sd->entity.num_pads)
-		return -EINVAL;
-
 	if (!streams_mask)
 		return 0;
 
 	/* Fallback on .s_stream() if .disable_streams() isn't available. */
-	if (!v4l2_subdev_has_op(sd, pad, disable_streams))
-		return v4l2_subdev_disable_streams_fallback(sd, pad,
-							    streams_mask);
+	use_s_stream = !v4l2_subdev_has_op(sd, pad, disable_streams);
 
-	state = v4l2_subdev_lock_and_get_active_state(sd);
+	if (!use_s_stream)
+		state = v4l2_subdev_lock_and_get_active_state(sd);
+	else
+		state = NULL;
 
 	/*
 	 * Verify that the requested streams exist and that they are not
@@ -2345,9 +2304,19 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 
 	dev_dbg(dev, "disable streams %u:%#llx\n", pad, streams_mask);
 
-	/* Call the .disable_streams() operation. */
-	ret = v4l2_subdev_call(sd, pad, disable_streams, state, pad,
-			       streams_mask);
+	if (!use_s_stream) {
+		/* Call the .disable_streams() operation. */
+		ret = v4l2_subdev_call(sd, pad, disable_streams, state, pad,
+				       streams_mask);
+	} else {
+		/* Stop streaming when the last streams are disabled. */
+
+		if (!(sd->enabled_pads & ~BIT_ULL(pad)))
+			ret = v4l2_subdev_call(sd, video, s_stream, 0);
+		else
+			ret = 0;
+	}
+
 	if (ret) {
 		dev_dbg(dev, "disable streams %u:%#llx failed: %d\n", pad,
 			streams_mask, ret);
@@ -2357,10 +2326,12 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 	v4l2_subdev_set_streams_enabled(sd, state, pad, streams_mask, false);
 
 done:
-	if (!v4l2_subdev_is_streaming(sd))
-		v4l2_subdev_disable_privacy_led(sd);
+	if (!use_s_stream) {
+		if (!v4l2_subdev_is_streaming(sd))
+			v4l2_subdev_disable_privacy_led(sd);
 
-	v4l2_subdev_unlock_state(state);
+		v4l2_subdev_unlock_state(state);
+	}
 
 	return ret;
 }

-- 
2.34.1



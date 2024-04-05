Return-Path: <linux-kernel+bounces-132718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D138899940
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C1BCB2329A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7996A13D265;
	Fri,  5 Apr 2024 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="p051XxgA"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F41E1649A7;
	Fri,  5 Apr 2024 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308498; cv=none; b=gQkfCKArezPJthtC9Hj5q10PKLy8MBpVBV0UTHF/AdwVI/7tM7GpLnwGG7ZyENBwR4+35ZLiegVK8ZlBvwm/9H6N8dxfJN9pxwXiwt+k2/j4neKV35RbCZ6pzWnNaJ+uj/ZxjwdhpLdXVNoo+A/Z03GWiZSssHYcE0QWon7+v3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308498; c=relaxed/simple;
	bh=VJ1VCMP8/mqpDK0x4H1ZKQ5lnAJENk/9mk7rosoMzQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uJqkHPl6CPzdqcQniY9g4amHLeO8XoUNjbKgwDIUKCNGzl/OR8gwM3/tynB1u5RMyYYjvSKLk6ewl+rR2cMlktDukOEnVR9uqV4dKKdAc0lSrhPEwXgg/C2AlDk2KSGrikf9XeauuFWHmi/iJh9iOmdJKr4cAGoyzVH0bW7t0Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=p051XxgA; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 16EF211D1;
	Fri,  5 Apr 2024 11:14:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712308447;
	bh=VJ1VCMP8/mqpDK0x4H1ZKQ5lnAJENk/9mk7rosoMzQU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p051XxgABuRfg4oW3WGR8YWGadbZ46vhMeQEq8+ohggMxUkwtnxZXAhtC9VluaQf0
	 bh2XchtN3me4lK33i717neqWsvxj2M7BLgXnljMEPSm1LRBUpJErhP3f5eYIpMcjA3
	 Eu4TAHj9YrrB+ekusk7nrAd/p/pmWDFh1TaONt4Q=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 05 Apr 2024 12:14:27 +0300
Subject: [PATCH v2 9/9] media: subdev: Support single-stream case in
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-enable-streams-impro-v2-9-22bca967665d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10582;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=VJ1VCMP8/mqpDK0x4H1ZKQ5lnAJENk/9mk7rosoMzQU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmD8D/jVZ+ZihNEv5GC+cr6+1vhyCuHMXQfu9hK
 y7d9U/kc0aJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZg/A/wAKCRD6PaqMvJYe
 9VDID/9437Z63Id59BceWArJc6rdY1IVWPYU3m41p7iZYdoNmYWdkPeg+JRYD41W9IKtzeNNxYh
 C6aPHSnuSXTaUXpN+8UD0b417budMldyQPqzSgtMDPXoEgNjxSB+mT2bkkxjUJxb+WgERXoxv76
 NYux5NmJv0AvwjRCmamKhXuhrqALOST9H9C7byiPjVk5/xrWVGg/MvW47TLShzOJvvTvSdLE9PL
 sBWbWBWSqt+2GNwKL6ALAUWjkUj2GX9RsIw8X0coDXZLisGQ1q4WNc1wq3CPV1trn+MwkOPmSJ2
 2ZXYwhX6hcF/oEdWVI1oTPzqhPFdLD8Oo/LLJDFAw3If2DMYX0wJZS5KWD7bWHw+cXuQwKNEzj3
 x0lV0BRYhV538zR4XQZzJp97ngilhJP3+dZSi/oWGhwlHhEjF3fMbmtdgU8ueRJjF34IAM5uO3n
 tA9TTZKW3VFZHNk+8vvAZebNvsmDEqOTKDNIMaSG1CKaPG8Y2rZRBlRxIZ9EukiR8ipCBjbRoWr
 ZMNQxy1Hzf8GaOmM7+BG/aeBMCyVC2/2Wa7ReqW/6exm81xKWOD7OI9Gp04N1w8c2K0atfg4v6y
 9HajlI8HMQNvVK2gYbpXe2caS9cx0vUIELd+tDatvBhXspdI2srC40eoZsEG3wF+cqpJ/SMFsDe
 MnJz9WeTDWeQuyg==
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
 drivers/media/v4l2-core/v4l2-subdev.c | 194 +++++++++++++++-------------------
 1 file changed, 83 insertions(+), 111 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 6c3c9069f1e2..12b90a1cdf6f 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2105,6 +2105,13 @@ static void v4l2_subdev_collect_streams(struct v4l2_subdev *sd,
 					u64 *found_streams,
 					u64 *enabled_streams)
 {
+	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS)) {
+		*found_streams = BIT_ULL(0);
+		if (sd->enabled_pads & BIT_ULL(pad))
+			*enabled_streams = BIT_ULL(0);
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
 		struct v4l2_subdev_stream_config *cfg;
 
@@ -2137,51 +2152,6 @@ static void v4l2_subdev_set_streams_enabled(struct v4l2_subdev *sd,
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
-	 * .s_stream() means there is no streams support, so only allowed stream
-	 * is the implicit stream 0.
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
@@ -2190,21 +2160,33 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
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
@@ -2232,12 +2214,21 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 
 	already_streaming = v4l2_subdev_is_streaming(sd);
 
-	if (!already_streaming)
-		v4l2_subdev_enable_privacy_led(sd);
+	if (!use_s_stream) {
+		if (!already_streaming)
+			v4l2_subdev_enable_privacy_led(sd);
+
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
 
-	/* Call the .enable_streams() operation. */
-	ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
-			       streams_mask);
 	if (ret) {
 		dev_dbg(dev, "enable streams %u:%#llx failed: %d\n", pad,
 			streams_mask, ret);
@@ -2248,33 +2239,32 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 	v4l2_subdev_set_streams_enabled(sd, state, pad, streams_mask, true);
 
 done:
-	if (ret && !already_streaming)
-		v4l2_subdev_disable_privacy_led(sd);
+	if (!use_s_stream) {
+		if (ret && !already_streaming)
+			v4l2_subdev_disable_privacy_led(sd);
 
-	v4l2_subdev_unlock_state(state);
+		v4l2_subdev_unlock_state(state);
+	}
 
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
-	 * .s_stream() means there is no streams support, so only allowed stream
-	 * is the implicit stream 0.
-	 */
-	if (streams_mask != BIT_ULL(0))
+	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
 		return -EOPNOTSUPP;
 
 	/*
@@ -2284,46 +2274,16 @@ static int v4l2_subdev_disable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
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
@@ -2349,9 +2309,19 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 
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
@@ -2361,10 +2331,12 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
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



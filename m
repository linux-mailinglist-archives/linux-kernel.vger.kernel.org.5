Return-Path: <linux-kernel+bounces-157226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E03C8B0ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F681C2426F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC8C16DEBD;
	Wed, 24 Apr 2024 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="csWWoQsM"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1242416D9AF;
	Wed, 24 Apr 2024 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973195; cv=none; b=ZdPTWPEbeQXrQ5W8krm1DON0Oz2VCZ6Arv2zHDUn2ruJGBdp2t4kIrRR3C5IsWaJ32zdGi7lCKskdKtfB9xN2v4fAkN1wQu60vlzu3xwwNWSAYSROmY89QI4qSmfJ2nFu2eLQ1GOfVi4kG/Q9GtB/TEGacLnHdVNxlqX0tLheZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973195; c=relaxed/simple;
	bh=pRFDkZbp0x8t5qt9VYf1wG+iyvJvLslpuDjA4BhzFHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=drlahy8NfthE1SF7hrjbjC0uN/9d6rGT2lwpVH80gfoW45iidjLR3B+b8AVgYT+uB4e80v3yi3CALi9epPNKAXQ5X4s8nwBVYzsQ7eqLQr+cWQy3fad5EEFymL/j0Ep3Ojfx+It+H1MyyX39kBMqOSn0UdfwFLLK6BfuSGKgch4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=csWWoQsM; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 09700149B;
	Wed, 24 Apr 2024 17:38:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713973133;
	bh=pRFDkZbp0x8t5qt9VYf1wG+iyvJvLslpuDjA4BhzFHo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=csWWoQsMh19bt4caqYa5wRAfar5ptIn4+YDrV1GyYXsdZB41gI2fhwnuX2u0YKsI7
	 HQUcYerb9bn1k8HgJoMYCkdGt6jpiruprVR5L6sb53Azc1UZ8C19velgnB8MfAqWFD
	 M0Y6ZyrAdv608jnMJ8gTQ038Qf9OrZeJFUNG8M+k=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 24 Apr 2024 18:39:12 +0300
Subject: [PATCH v6 09/11] media: subdev: Support single-stream case in
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-enable-streams-impro-v6-9-5fb14c20147d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10901;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=pRFDkZbp0x8t5qt9VYf1wG+iyvJvLslpuDjA4BhzFHo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmKSe6REjgSapIg2he+87ar3oPFER1O+z8GfAAl
 WFVlbkjuRCJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZiknugAKCRD6PaqMvJYe
 9U2OEACWAKf7DG0o0APTc9a4eMNVWe6IttJk/Dp2ie108WZbTngTanUoRKmijmceYGiUEYUUEnJ
 CIYp7/QQEOJ/wOdcoWhJ4oE95J33XJMQxpB+/nYO4Eaj++VVgjqlGaYqL65es46MwwmdzTEAQoT
 iLzzPfBFSjLcW8Du7+HJ/O/qP7d+ymN1+l73xU4S29n2wyxE5Gt7/rKkf1MHy36xFovitFfJ+g1
 Ci6vADc4lhx7/99YeJZi6S0JLtqEWgeTIEZudiM3Mhbwd6kYo5EF4+H42sABBw6g6WLn7z8ij/O
 vw25BIovg1d0fCYpjp9/DYykL1Ksf31CdK9EU50JuDWhAs0ExpRiOS/CF6hKx2PvGlkAd7jFtV4
 PFNTtnq8tXLIScIBwFPMK+ilKA8OAwKQoij2KzVpvo3yc9I1xUYpH32P3/mHMKrgIFwpeLRMnsV
 L3OLGhgF1wgywnQaraX20UodmtRDqNJ+EhTvQsH3jksRqFjijZ+pyCF8r8lPIUHmT5DZQQJAUXi
 nYSLsoUj0EOc9jSnAlv/vQUybElGMErM0o3cPrsUcNcsz18KDA+nQslgXWv7RkDWTQLZe3lWSoF
 xUgCGlyQRsnnILPGkERUYGVkUqMG7l9GSgKkNSKbEw+A/nCRoR8h58xZ7jgPLxhxK0J0C2sEHtV
 TE74Va8gePePogA==
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

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Umang Jain <umang.jain@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 194 +++++++++++++++-------------------
 1 file changed, 86 insertions(+), 108 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 98629fa6de49..72085027e213 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2141,6 +2141,13 @@ static void v4l2_subdev_collect_streams(struct v4l2_subdev *sd,
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
 
@@ -2162,6 +2169,14 @@ static void v4l2_subdev_set_streams_enabled(struct v4l2_subdev *sd,
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
@@ -2171,51 +2186,6 @@ static void v4l2_subdev_set_streams_enabled(struct v4l2_subdev *sd,
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
@@ -2224,21 +2194,33 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
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
@@ -2266,9 +2248,18 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 
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
@@ -2278,34 +2269,39 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 	/* Mark the streams as enabled. */
 	v4l2_subdev_set_streams_enabled(sd, state, pad, streams_mask, true);
 
-	if (!already_streaming)
+	/*
+	 * TODO: When all the drivers have been changed to use
+	 * v4l2_subdev_enable_streams() and v4l2_subdev_disable_streams(),
+	 * instead of calling .s_stream() operation directly, we can remove
+	 * the privacy LED handling from call_s_stream() and do it here
+	 * for all cases.
+	 */
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
@@ -2315,46 +2311,16 @@ static int v4l2_subdev_disable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
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
@@ -2380,9 +2346,19 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 
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
@@ -2392,10 +2368,12 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
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



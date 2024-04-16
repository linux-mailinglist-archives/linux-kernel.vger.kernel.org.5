Return-Path: <linux-kernel+bounces-146653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0EF8A68CD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3971C20AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC6312C549;
	Tue, 16 Apr 2024 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="S/qm1612"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E71A12BEBF;
	Tue, 16 Apr 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264049; cv=none; b=ZPukpr3EK+K3rZGj8u1gj3y02KTPgb8/p2qRoHI1fGb9tbZmCCv46g3Em2EOW9089ewcfDvPJv/ls/wNg3BVIq5Pb6wFdZgzcHd5ZASk01nv+e00pJaCDMfaKoaNmCXNFRbgbyDvgh9abmxGx/KAWSTIMDSVaPTX9WPZORqejUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264049; c=relaxed/simple;
	bh=I7FJRoxmg13/uSTJeBjTcd/3nfaPZV8Nz+fLKzo8qDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hPLiUIq0FOVi2RlNwmjUD3j18fT/TOqnTVTFia7FwTeQrwPwcZcA7phV39A40P5PjHcbF0+lRXdJDjKNT/C9UCQNwHSfy6M+RkywLZ0qV2FJnTViST0P+VpPzi5rO07L4T1BDn59P6ZV7i5v24Vh7UvABTfrfGwBfcPCHlr/u9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=S/qm1612; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B3BBC1815;
	Tue, 16 Apr 2024 12:39:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713263991;
	bh=I7FJRoxmg13/uSTJeBjTcd/3nfaPZV8Nz+fLKzo8qDw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S/qm1612CGyAutla4Wobre4e8if1hCiXMfpENTEudiRor/pXZKF44JhiTP+RmiEsx
	 ZI5bTnNVmdROCLteReo7GvVu/W8sg7tXc/bmwLREMI1VBMpASlNyokrCnWRbFS0QQ3
	 uiRjSrjbLmidOjv+dqYUfKbJGQ6GIyrOXhJtYM0E=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 13:40:08 +0300
Subject: [PATCH v4 09/10] media: subdev: Support single-stream case in
 v4l2_subdev_enable/disable_streams()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v4-9-1d370c9c2b6d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10478;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=I7FJRoxmg13/uSTJeBjTcd/3nfaPZV8Nz+fLKzo8qDw=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHlWeE0gcnoVskz2Occk6xDHCJ+aAffyGjmTMy
 JSshY+xDI6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh5VngAKCRD6PaqMvJYe
 9WpED/4hMbREKSdseJBCUQWmhMTWDLG4C8mtLH+gIfIHVgML2CVP2dS0Pe56b7Lxa/22/R/tYOx
 2nJxpzSqWY040EKT69PmFXdBKcA77XWbQ/oxewT2VqE2i40Dfyqj4ijREY1rHp+k4uitRS+B1EV
 21ETJO70VuqlR8MlEGnYcn6/T3BQONuE6cS2X+SUIF6GpX2JdHpYYwV3+wQTY9Iw10AkwTzdJlg
 A2HQ8VBsk38+CpgDETppUnc+oml6I3F/5uS9TvU1NDsjm2frkN0u8Z2eFUWBtEbw801QVVT+KJ3
 JDA4m/x/rdl73fmpMAJgz1LDfK3LgFdm26Wq/0PyhUD9CGR8m9noIVxCUze8J368J/VXjKqDdjd
 HtnHce3TeOQ3XwKoq8vAt5japrXK9CRMVb5VkNoaXAGvDSFYHffTL39JjF+Pd/RvzNi0w10czQd
 CmycC+gc6Dy7SXqKwSh1DLyckajnVfrrEI7jy8XGezP3uMRxDNkyLqe+O3zh1+f2+7APbvLcuk7
 tKv1nssOZ6UvHYWYYXXE9bPa1s2VdwZ9N0rfSS3oyCja8A7ITsdzlomMxzLRsY45aLcNKcOcA2A
 w7OUiwNeOxaX29hjou4fdCdn/21v8q4KD7axzNm48244ilZqEZ01e8CldDjBJTJXsjeGVxrnu+U
 Do7AyhzjaSBA0tw==
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
index e45fd42da1e3..1c6b305839a1 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2106,6 +2106,13 @@ static void v4l2_subdev_collect_streams(struct v4l2_subdev *sd,
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



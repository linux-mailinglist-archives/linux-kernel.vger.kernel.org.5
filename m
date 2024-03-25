Return-Path: <linux-kernel+bounces-117028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BD588A64A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711BB1F3F43D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C49613E056;
	Mon, 25 Mar 2024 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="cIea7vew"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A5B74437;
	Mon, 25 Mar 2024 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370621; cv=none; b=jbXZwgN9XfwD7PekQkqZ0fZv2883Jdm8ivq9zyq4HeCQkzz5rXXXieNnSJw6olpRlCIX07zEaPM2TXFqP3qdBy53PnLlI2eoeifIKAOnpJInZgRce2xXHAs/qsjM0Ku+DeuGZU0xyN0yV2p5Sd+pfgV4lpdzBu/unPWMPcfZf20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370621; c=relaxed/simple;
	bh=c8CCSDfPXv/Yx8EpNla6R7eV3b154JsDt8OqeBf7Bzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Gm/Rfx68Gwwk2H3ps7FBKWajbLajYymZVM94N5I4uxEjqhcY6rZ1lquyYHflvW+1Ql4e7OW9cJ4UFI2W5guUBszkRVPpnJoRXv57obZF6Inp67KQmRb428zv2FOnUZRDO0FrZiUsHsjK7QUZH+ErdKMRGPOrB1rMUej6airr7Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=cIea7vew; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DEB9C7E4;
	Mon, 25 Mar 2024 13:43:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711370586;
	bh=c8CCSDfPXv/Yx8EpNla6R7eV3b154JsDt8OqeBf7Bzg=;
	h=From:Date:Subject:To:Cc:From;
	b=cIea7vewsQUiCdWHdm37dwQtxoncOv3OCGumqraCTohg3qN8MdEPhOOBgJ2aqfckr
	 +IGVpnoxXUd8EfP9RQ8sedwY3+xDU36QN03AEeXPh2c9iXoh27ZwV01eB8P4vrJoFy
	 5b7OflSnXjNsX1TDrIAx1uTEWYt7Z5d9zZR6n68Q=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 25 Mar 2024 14:43:23 +0200
Subject: [PATCH] media: v4l2-subdev: Support enable/disable_streams for
 single-pad subdevs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-single-pad-enable-streams-v1-1-142e19896a72@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIAGpxAWYC/x2MSQqAMAwAvyI5G9C6oV8RD1GjBrSWRkQo/t3ib
 eYwE0DZCyt0SQDPt6icNkqeJjBtZFdGmaODyUyZFaZCFbvujI5mZEtjRL0806FYGGqpKWuaqhF
 i7zwv8vzvfnjfDxy+zINrAAAA
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7013;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=c8CCSDfPXv/Yx8EpNla6R7eV3b154JsDt8OqeBf7Bzg=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmAXF3+QyPaNqFvltADC+IGM/HydDH2KFVvy+py
 mebVrC3x/iJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZgFxdwAKCRD6PaqMvJYe
 9Xk1D/9p5EBxiUcuSh5UAIbaXkU1q09tfSyBEAGRLB6R3wAwnu9NzkN9SjbcV7NguBZb0WE14db
 iO6i9oiaVBkKqG8+B3b8i8iaGqdR6vSzYAfdJ2drUr0Uizm01DlB2eYRk+BZisMSu4uAl7iH4LI
 cD4ecwak78a1efT/QGm7jjNWo63mxuK6oz6ULFPCf1lXB9h3g/wUq8EwNudHzEer7tySq8NEGq3
 ykY5VcR0ueqieoNaAIQddwNHnjPKHG7PIpiUT6MBc/IXZzpFVERqhKpx29yO3szXmlBTsOpKb2V
 YAqlsojezeqRjeNy8Pper4SUbluAfOPk0BIHWeCy5nubADyltOpi58mTKeCjgDv2M7qBxIAvYaA
 V2DkuEHKj/yCJxTmHff1CJ5vb84y77E+10WgYu4zeDtWVdyHfAZKI52g2j3dle14XFg8vjaR0FH
 IbpLzan0MGt3BFc4az6XBdAT6YQyO3L7PyLFx2iazP3zwjyc/htFRQFgI7LqxQhvRXqJS63xbt7
 2/MdZ4/DpCiSajmmtHUJ0oKmeQasizeijZGLzz2O53bdFQ5ectWOb8eAYjev5lKOz53valvMXFO
 Jl5l8w1x73yWNy8znunJ+P/kbjSF/TD1hFUYsSnY281BQaGEXgeLHM0ynRCLm1iaMkPPLMyYD4X
 Q0C+WfWcmW28LSQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Currently a subdevice with a single pad, e.g. a sensor subdevice, must
use the v4l2_subdev_video_ops.s_stream op, instead of
v4l2_subdev_pad_ops.enable/disable_streams. This is because the
enable/disable_streams machinery requires a routing table which a subdev
cannot have with a single pad.

Implement enable/disable_streams support for these single-pad subdevices
by assuming an implicit stream 0 when the subdevice has only one pad.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Even though I did send this patch, I'm not sure if this is necessary.
s_stream works fine for the subdevs with a single pad. With the upcoming
internal pads, adding an internal pad to the subdev will create a
routing table, and enable/disable_streams would get "fixed" that way.

So perhaps the question is, do we want to support single-pad subdevs in
the future, in which case something like this patch is necessary, or
will all modern source subdev drivers have internal pads, in which
case this is not needed...
---
 drivers/media/v4l2-core/v4l2-subdev.c | 105 ++++++++++++++++++++++------------
 include/media/v4l2-subdev.h           |   4 +-
 2 files changed, 72 insertions(+), 37 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 4c6198c48dd6..ddc7ed69421c 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2129,21 +2129,33 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
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
+	if (sd->entity.num_pads == 1) {
+		if (sd->enabled_streams) {
 			dev_dbg(dev, "stream %u already enabled on %s:%u\n",
-				cfg->stream, sd->entity.name, pad);
+				0, sd->entity.name, pad);
 			ret = -EALREADY;
 			goto done;
 		}
+
+		found_streams = BIT_ULL(0);
+	} else {
+		for (i = 0; i < state->stream_configs.num_configs; ++i) {
+			struct v4l2_subdev_stream_config *cfg =
+				&state->stream_configs.configs[i];
+
+			if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
+				continue;
+
+			found_streams |= BIT_ULL(cfg->stream);
+
+			if (cfg->enabled) {
+				dev_dbg(dev, "stream %u already enabled on %s:%u\n",
+					cfg->stream, sd->entity.name, pad);
+				ret = -EALREADY;
+				goto done;
+			}
+		}
 	}
 
 	if (found_streams != streams_mask) {
@@ -2164,13 +2176,17 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 		goto done;
 	}
 
-	/* Mark the streams as enabled. */
-	for (i = 0; i < state->stream_configs.num_configs; ++i) {
-		struct v4l2_subdev_stream_config *cfg =
-			&state->stream_configs.configs[i];
+	if (sd->entity.num_pads == 1) {
+		sd->enabled_streams |= streams_mask;
+	} else {
+		/* Mark the streams as enabled. */
+		for (i = 0; i < state->stream_configs.num_configs; ++i) {
+			struct v4l2_subdev_stream_config *cfg =
+				&state->stream_configs.configs[i];
 
-		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
-			cfg->enabled = true;
+			if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
+				cfg->enabled = true;
+		}
 	}
 
 done:
@@ -2246,21 +2262,32 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 	 * Verify that the requested streams exist and that they are not
 	 * already disabled.
 	 */
-	for (i = 0; i < state->stream_configs.num_configs; ++i) {
-		struct v4l2_subdev_stream_config *cfg =
-			&state->stream_configs.configs[i];
-
-		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
-			continue;
-
-		found_streams |= BIT_ULL(cfg->stream);
-
-		if (!cfg->enabled) {
+	if (sd->entity.num_pads == 1) {
+		if (!sd->enabled_streams) {
 			dev_dbg(dev, "stream %u already disabled on %s:%u\n",
-				cfg->stream, sd->entity.name, pad);
+				0, sd->entity.name, pad);
 			ret = -EALREADY;
 			goto done;
 		}
+
+		found_streams = BIT_ULL(0);
+	} else {
+		for (i = 0; i < state->stream_configs.num_configs; ++i) {
+			struct v4l2_subdev_stream_config *cfg =
+				&state->stream_configs.configs[i];
+
+			if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
+				continue;
+
+			found_streams |= BIT_ULL(cfg->stream);
+
+			if (!cfg->enabled) {
+				dev_dbg(dev, "stream %u already disabled on %s:%u\n",
+					cfg->stream, sd->entity.name, pad);
+				ret = -EALREADY;
+				goto done;
+			}
+		}
 	}
 
 	if (found_streams != streams_mask) {
@@ -2281,13 +2308,17 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 		goto done;
 	}
 
-	/* Mark the streams as disabled. */
-	for (i = 0; i < state->stream_configs.num_configs; ++i) {
-		struct v4l2_subdev_stream_config *cfg =
-			&state->stream_configs.configs[i];
+	if (sd->entity.num_pads == 1) {
+		sd->enabled_streams &= ~streams_mask;
+	} else {
+		/* Mark the streams as disabled. */
+		for (i = 0; i < state->stream_configs.num_configs; ++i) {
+			struct v4l2_subdev_stream_config *cfg =
+				&state->stream_configs.configs[i];
 
-		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
-			cfg->enabled = false;
+			if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
+				cfg->enabled = false;
+		}
 	}
 
 done:
@@ -2325,8 +2356,12 @@ int v4l2_subdev_s_stream_helper(struct v4l2_subdev *sd, int enable)
 	 */
 	state = v4l2_subdev_lock_and_get_active_state(sd);
 
-	for_each_active_route(&state->routing, route)
-		source_mask |= BIT_ULL(route->source_stream);
+	if (sd->entity.num_pads == 1) {
+		source_mask = BIT_ULL(0);
+	} else {
+		for_each_active_route(&state->routing, route)
+			source_mask |= BIT_ULL(route->source_stream);
+	}
 
 	v4l2_subdev_unlock_state(state);
 
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index a9e6b8146279..39b230f7b3c8 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -1041,8 +1041,8 @@ struct v4l2_subdev_platform_data {
  *		  v4l2_subdev_init_finalize().
  * @enabled_streams: Bitmask of enabled streams used by
  *		     v4l2_subdev_enable_streams() and
- *		     v4l2_subdev_disable_streams() helper functions for fallback
- *		     cases.
+ *		     v4l2_subdev_disable_streams() helper functions. This is
+ *		     for fallback cases and for subdevs with single pads.
  *
  * Each instance of a subdev driver should create this struct, either
  * stand-alone or embedded in a larger struct.

---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240325-single-pad-enable-streams-32a9a746ac5b

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>



Return-Path: <linux-kernel+bounces-138510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1013789F26D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7E11F24980
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96FE15ECF0;
	Wed, 10 Apr 2024 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="olKpc5p1"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2344315E7FB;
	Wed, 10 Apr 2024 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752621; cv=none; b=GNiso0eX5S3ysq9ByHgbrQii0RaFUNrZVGB9GINh0kSn3YuMK3nx/FfIOLp3zDL0qauc6GIV3ub0vDa9R6YUs6o6vqYR7raCkVJD7ooFD3aO0DHv1xfO3SWb06sLQzcIHjJtunlCTce/evr/vMMEp40Rm4XlsCTMUg3onVIO1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752621; c=relaxed/simple;
	bh=uXIdlNOiCPH7wLnGs0l7FIpa16razcWfyX7yOHhjJPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WJfjOaL2wtMvqqjbMPeLTEMgOzZ60hqqmSGbLfdMFJPtKXOVS7GOpxtSLdPCQVZaqwtkPlAWs8iIx8imOetO6aVQg7HdVRrI2Dblqiidx9HJGDrSQ8k218JBKUiQhzN7yVbhEqryq750zPg0O5VP2ivoxwIOorfhXd3dglmNquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=olKpc5p1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C0AE3149B;
	Wed, 10 Apr 2024 14:36:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712752571;
	bh=uXIdlNOiCPH7wLnGs0l7FIpa16razcWfyX7yOHhjJPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=olKpc5p1vl9YeHmufJ4FCgEXle/QH+I6NtPhjAZiKg78eorb1DDgxRCFrEjtjgyKc
	 Omyxcsj5Mc4qeB4o7I8XTrauVeXxtMz6ngq/mtQNiMlhggxgv45d6D7MUXywdBnZn3
	 7ns5vt30fraXZw5DZ2QTlTahAl7PRacmzZ0dBH+c=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 10 Apr 2024 15:35:52 +0300
Subject: [PATCH v3 5/9] media: subdev: Improve
 v4l2_subdev_enable/disable_streams_fallback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-enable-streams-impro-v3-5-e5e7a5da7420@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6393;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=uXIdlNOiCPH7wLnGs0l7FIpa16razcWfyX7yOHhjJPA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmFoffrOrmb+9T5kD1Mik66U7kT05jRUJv8T+4Q
 QQf+3VJFk6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZhaH3wAKCRD6PaqMvJYe
 9ffoD/9qZwj/3vcR0KTbgA8JHtYHcaUZEM0+R86IgWziprU1EFZN73UOvOFmDAytAOaEBvxNvlA
 rZDsZAiqXFfWbo2Lh+oQQOZwIUHortkb6azielqYzH8CmUGSWB/o7AgZ85/NEUW3OoqO1fo6d0D
 j+MdOlfhGlb1ZTqmkNjf1ankgUF0kOdm/2yn+iKJkvF6u2wVSCPX24zha3Lpe/lV6wiXPl3iapI
 WVC+TlpOMVHlhFCykMngFnoxkgR5Sys/luTd1nIGxo8Wpbev3pqHWN7lho4lQekXtY0A4crlxFd
 Hqz7CzH6dlwCEjjByofA/hm+mXrZQmHH7BNDhbdjMu7+5CT/OyEuA5Usvb4eLPtTHWzu/dLxG36
 fPUjDiD/mXwwtFVCM3bhSVLoAa8CUHeWz6PpKBnzs9S6IIYn1LQPeq8dZ3Stet9z3boz0HQu7Rq
 XtG0injIOhAe6krue24KbQ+7tXhUzTSBlgV029E1K8pTdv2RFC3IqDFolwHlC6Ad2rl2kfu57e1
 pKJKHQroNGvU3eeftbBeVTsWD20J2y1R8vQdGLkdj3OiO1YU96b7aO9OtfkExfd5c2kmuLEDVNA
 q+vhrxdkwyuKcqj7rgx2Aoa/d7ETeeP7vv5O1YQmydPZfERVcK/4Raf0MRatJ/G7ncKpCj5GXjO
 fTl/pCSbbn5uHOQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

v4l2_subdev_enable/disable_streams_fallback() supports falling back to
s_stream() for subdevs with a single source pad. It also tracks the
enabled streams for that one pad in the sd->enabled_streams field.

Tracking the enabled streams with sd->enabled_streams does not make
sense, as with .s_stream() there can only be a single stream per pad.
Thus, as the v4l2_subdev_enable/disable_streams_fallback() only supports
a single source pad, all we really need is a boolean which tells whether
streaming has been enabled on this pad or not.

However, as we only need a true/false state for a pad (instead of
tracking which streams have been enabled for a pad), we can easily
extend the fallback mechanism to support multiple source pads as we only
need to keep track of which pads have been enabled.

Change the sd->enabled_streams field to sd->enabled_pads, which is a
64-bit bitmask tracking the enabled source pads. With this change we can
remove the restriction that
v4l2_subdev_enable/disable_streams_fallback() only supports a single
source pad.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 68 ++++++++++++++++++++---------------
 include/media/v4l2-subdev.h           |  9 +++--
 2 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 6cd353d83dfc..3d2c9c224b8f 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2104,37 +2104,43 @@ static int v4l2_subdev_enable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
 					       u64 streams_mask)
 {
 	struct device *dev = sd->entity.graph_obj.mdev->dev;
-	unsigned int i;
 	int ret;
 
 	/*
 	 * The subdev doesn't implement pad-based stream enable, fall back
-	 * on the .s_stream() operation. This can only be done for subdevs that
-	 * have a single source pad, as sd->enabled_streams is global to the
-	 * subdev.
+	 * to the .s_stream() operation.
 	 */
 	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
 		return -EOPNOTSUPP;
 
-	for (i = 0; i < sd->entity.num_pads; ++i) {
-		if (i != pad && sd->entity.pads[i].flags & MEDIA_PAD_FL_SOURCE)
-			return -EOPNOTSUPP;
-	}
+	/*
+	 * .s_stream() means there is no streams support, so only allowed stream
+	 * is the implicit stream 0.
+	 */
+	if (streams_mask != BIT_ULL(0))
+		return -EOPNOTSUPP;
+
+	/*
+	 * We use a 64-bit bitmask for tracking enabled pads, so only subdevices
+	 * with 64 pads or less can be supported.
+	 */
+	if (pad >= sizeof(sd->enabled_pads) * BITS_PER_BYTE)
+		return -EOPNOTSUPP;
 
-	if (sd->enabled_streams & streams_mask) {
-		dev_dbg(dev, "set of streams %#llx already enabled on %s:%u\n",
-			streams_mask, sd->entity.name, pad);
+	if (sd->enabled_pads & BIT_ULL(pad)) {
+		dev_dbg(dev, "pad %u already enabled on %s\n",
+			pad, sd->entity.name);
 		return -EALREADY;
 	}
 
-	/* Start streaming when the first streams are enabled. */
-	if (!sd->enabled_streams) {
+	/* Start streaming when the first pad is enabled. */
+	if (!sd->enabled_pads) {
 		ret = v4l2_subdev_call(sd, video, s_stream, 1);
 		if (ret)
 			return ret;
 	}
 
-	sd->enabled_streams |= streams_mask;
+	sd->enabled_pads |= BIT_ULL(pad);
 
 	return 0;
 }
@@ -2221,37 +2227,43 @@ static int v4l2_subdev_disable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
 						u64 streams_mask)
 {
 	struct device *dev = sd->entity.graph_obj.mdev->dev;
-	unsigned int i;
 	int ret;
 
 	/*
-	 * If the subdev doesn't implement pad-based stream enable, fall  back
-	 * on the .s_stream() operation. This can only be done for subdevs that
-	 * have a single source pad, as sd->enabled_streams is global to the
-	 * subdev.
+	 * If the subdev doesn't implement pad-based stream enable, fall back
+	 * to the .s_stream() operation.
 	 */
 	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
 		return -EOPNOTSUPP;
 
-	for (i = 0; i < sd->entity.num_pads; ++i) {
-		if (i != pad && sd->entity.pads[i].flags & MEDIA_PAD_FL_SOURCE)
-			return -EOPNOTSUPP;
-	}
+	/*
+	 * .s_stream() means there is no streams support, so only allowed stream
+	 * is the implicit stream 0.
+	 */
+	if (streams_mask != BIT_ULL(0))
+		return -EOPNOTSUPP;
+
+	/*
+	 * We use a 64-bit bitmask for tracking enabled pads, so only subdevices
+	 * with 64 pads or less can be supported.
+	 */
+	if (pad >= sizeof(sd->enabled_pads) * BITS_PER_BYTE)
+		return -EOPNOTSUPP;
 
-	if ((sd->enabled_streams & streams_mask) != streams_mask) {
-		dev_dbg(dev, "set of streams %#llx already disabled on %s:%u\n",
-			streams_mask, sd->entity.name, pad);
+	if (!(sd->enabled_pads & BIT_ULL(pad))) {
+		dev_dbg(dev, "pad %u already disabled on %s\n",
+			pad, sd->entity.name);
 		return -EALREADY;
 	}
 
 	/* Stop streaming when the last streams are disabled. */
-	if (!(sd->enabled_streams & ~streams_mask)) {
+	if (!(sd->enabled_pads & ~BIT_ULL(pad))) {
 		ret = v4l2_subdev_call(sd, video, s_stream, 0);
 		if (ret)
 			return ret;
 	}
 
-	sd->enabled_streams &= ~streams_mask;
+	sd->enabled_pads &= ~BIT_ULL(pad);
 
 	return 0;
 }
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index f55d03e0acc1..d6867511e9cf 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -1039,10 +1039,9 @@ struct v4l2_subdev_platform_data {
  * @active_state: Active state for the subdev (NULL for subdevs tracking the
  *		  state internally). Initialized by calling
  *		  v4l2_subdev_init_finalize().
- * @enabled_streams: Bitmask of enabled streams used by
- *		     v4l2_subdev_enable_streams() and
- *		     v4l2_subdev_disable_streams() helper functions for fallback
- *		     cases.
+ * @enabled_pads: Bitmask of enabled pads used by v4l2_subdev_enable_streams()
+ *		  and v4l2_subdev_disable_streams() helper functions for
+ *		  fallback cases.
  * @streaming_enabled: Tracks whether streaming has been enabled with s_stream.
  *                     This is only for call_s_stream() internal use.
  *
@@ -1092,7 +1091,7 @@ struct v4l2_subdev {
 	 * doesn't support it.
 	 */
 	struct v4l2_subdev_state *active_state;
-	u64 enabled_streams;
+	u64 enabled_pads;
 	bool streaming_enabled;
 };
 

-- 
2.34.1



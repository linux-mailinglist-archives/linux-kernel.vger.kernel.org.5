Return-Path: <linux-kernel+bounces-146921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2838A6CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DB0BB2132D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E00F12C55D;
	Tue, 16 Apr 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fpLHr/F6"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D09912EBC3;
	Tue, 16 Apr 2024 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275734; cv=none; b=l671lZ15UVWnO5mff3C90sVpUv8gJgGygJ3OUrRd+sb7zleh4lz2h1yWxTkjIoJlq3TeFzsRwKI8v0uG3N279Z+W0c65s/DzQSqg4z+zHgwkR/+tSD1y0rOqfoSY8uHUG5btGXH/uMc+Cnss9KUbnUu1OmI9WqqwvjRLW2QPVQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275734; c=relaxed/simple;
	bh=aCnDspzZEt06MUge756JFr8IcUIbBzfpqoQOxbjW9DY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CnRHDKZGpnkvTBZkokse/fIilih9BAViAXhxaykdFJmY4eVgK9umjrCGhxThhtDHQMZnHA7haYSLYhPTyfOzjMi0dsmqA1x/mr3IWYlh3XixI/GsBQ32SToWFqFQgfbpggtXrZXs0/yaz2catD2WWbZjh6MiAaWeYecwWJDRjus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fpLHr/F6; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4C7A517E1;
	Tue, 16 Apr 2024 15:54:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713275681;
	bh=aCnDspzZEt06MUge756JFr8IcUIbBzfpqoQOxbjW9DY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fpLHr/F6mFO2zcqzEcQUUfaL7D6DHvePzFuY75nUE1sB7WBQdg114laVAtWk4O/TT
	 Y74V1QSNwuoYJEO0PNMl5iDfOI9MJuuU7cMWUZEs8n6QjF8bEpOFBA38gUCh4xqFdq
	 yablaWYsrvvDnjy61T9kz/ZOC1bha9WEeupqny44=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 16:55:08 +0300
Subject: [PATCH v5 05/10] media: subdev: Improve
 v4l2_subdev_enable/disable_streams_fallback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v5-5-bd5fcea49388@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6465;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=aCnDspzZEt06MUge756JFr8IcUIbBzfpqoQOxbjW9DY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHoNKbSA1XGIJ8FSBO34fBCKDS+SxoW7Clyk6C
 OvApYenHkqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh6DSgAKCRD6PaqMvJYe
 9XSxEACLSgbq+KW35VrqO48IBygrp7IaLhhexhzzMHFienaPxDh4VsOfwcDl/ME5i9Pxi8+4/nl
 3TpEZySSqGyqnlEASHLQac++kx31Lr1eL30kFxA7yYFOXkKZ2K38SWqYzCebvtrq+s6gPGHimT1
 WmPbu78uRunyOydInEu/9eBprBO5jD+tWRJqVRJU9CqyeSgc78VqjOp340kPKzFrDrqbYjYpXPI
 7pgvVVI8Owo35hXOeEyIyp8WHuKzhp97yJCMlJjxYjzX+FzcWJDZKdhJi3+6v1a0rF+mdRny3ar
 BgelVeS4yxSQ77khH0jpZOxqQTTyJM2NhtBaVsUrIvRAsuzx4TX+w358XJO0SJaJOwbe8vaKs7y
 XZLxIx1pJSFSnUz5ABJSDngAv9umyhU6FKLrg5df7NZbCC+PYFIqf4OiuBfGWGtSym9WBy6iQHU
 B5VfzXlniMvF7ZPAh7Iau/Ihz72lX9UZOkQHXr8DXCohns+uLqdCo+ggYi5XvMRlvvIgvdrrn+s
 QHfPlsBPkviQJ9ijd5d4RHOlzhnq8EHxuCcJJe6/SvsEh4QJxa+xF53Knqox9dDHYEtQk7AJU+u
 MVfRhbeyPU/R3GHzDGECjh3JdUKbOQq6OT7Ozj4VhojdAJs80eOIGWeLTvjcuLKeSnYuGvpY26u
 98bOpcdr1AnYL0Q==
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

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 68 ++++++++++++++++++++---------------
 include/media/v4l2-subdev.h           |  9 +++--
 2 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 941cf7be22c3..3824159bbe79 100644
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
+	 * .s_stream() means there is no streams support, so the only allowed
+	 * stream is the implicit stream 0.
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
+	 * .s_stream() means there is no streams support, so the only allowed
+	 * stream is the implicit stream 0.
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
index b3c3777db464..ddf22d7e5b9d 100644
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
  * @s_stream_enabled: Tracks whether streaming has been enabled with s_stream.
  *                    This is only for call_s_stream() internal use.
  *
@@ -1092,7 +1091,7 @@ struct v4l2_subdev {
 	 * doesn't support it.
 	 */
 	struct v4l2_subdev_state *active_state;
-	u64 enabled_streams;
+	u64 enabled_pads;
 	bool s_stream_enabled;
 };
 

-- 
2.34.1



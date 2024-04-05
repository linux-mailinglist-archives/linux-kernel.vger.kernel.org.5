Return-Path: <linux-kernel+bounces-132714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F00A1899937
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CEE1F23228
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27CC161914;
	Fri,  5 Apr 2024 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YaYEbuEl"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9E3161319;
	Fri,  5 Apr 2024 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308491; cv=none; b=KCTYtdMvwUiNAi06OFPYOzbjdRTpsV5rBmSeluK1cM0dCeBmkJEKSR59I8vTcjqH2dYVhQEegJ4JzcXuQbFdKTQW/WHJKzDsJeCb52uK77MGdZ3wOHopYpbMbFzCxxiGoqj+fQk51EoTTKuYYR/GOSmR1NDT8d6JMFLHz/i5uuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308491; c=relaxed/simple;
	bh=kSZwpWlf514IoxE2BoF5xBV0zVQADm4oWeSxvTLDfLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mz+gJsF6+CWuMvVpOm5EkFRUZvAyptKMkyZrt+37apaj+k8c0NbTX05nhCna1LAeqrtxe6up63Q2PkTcty57xv3MHk1PVnXQWUcZ4tV5SbazYJHoZChmM5TlfvMomTue9R8ZnGtihmaUm29k/LxO8sMff3mR1h525hXU0s51hqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=YaYEbuEl; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E1A03FD6;
	Fri,  5 Apr 2024 11:14:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712308445;
	bh=kSZwpWlf514IoxE2BoF5xBV0zVQADm4oWeSxvTLDfLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YaYEbuEldqMM86ipY52eBVgNNrR6ppMWyxfZL08RCbKe03mrgy0Cbm+uZw/HAfYhc
	 mk/T4fWvEG5okMMKpNvH3S/39E3F39843a8mgD5GI5ICvtY3yLhqSfp5CwlAb3h+Ak
	 t4gW/kuhAz/4uTQhOH4ZM2Eawbljr6M1/C8f+xGY=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 05 Apr 2024 12:14:23 +0300
Subject: [PATCH v2 5/9] media: subdev: Improve
 v4l2_subdev_enable/disable_streams_fallback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-enable-streams-impro-v2-5-22bca967665d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6393;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=kSZwpWlf514IoxE2BoF5xBV0zVQADm4oWeSxvTLDfLI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmD8D+svIbNaDM3jU+EcHLWTydCsd3mgnkMnUCt
 eeefUkqioeJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZg/A/gAKCRD6PaqMvJYe
 9VRkEACXoeofMoo36MK284aCz5Y9k/f2q9RN7fLo4P66PNbTuDTOQWkxhF1/wS+HJpKU2fMnd0Q
 2oaKmvzw3I00og/SdfAm+W/uokqavBjcMuWQorFElDcRancImCy1Jba5+0huJabSPle9Ba2IpRO
 gUxwhpxLw/GYT9w6LF4jLIs0wAiuwUfrLOmFKenoJ/fYh6qidjFd4cUkcGqNYyt3pWk7JDtaxLY
 AVtZ5987X47uYTfCQNzbn3/BNvrD81eWnD22JCCfY5rO1ynvGneFaQFMsysLKCJDWffevcnlnkc
 I21dOtWObgcfac3muaNlp6qCXSwjOIPts1f5wgOtn7l+fSr3kfa1m5yb4U4VHAAipzo5NkRvd2d
 OF58Y2/RQ1Z8jV++epDn7wA7eS1QPBlT0ARokkTkm4MzWsanSJyQgfpzUCY2lqFg5TAFhT9Ej95
 bSBMhfLIi5NN4aSdic352S5XpwLmadwU0NpsM2MNaoZj8zgO1wxk3vlDmqQh8J2e/6n4v+fuMDX
 G8oQuk2eOYNW/n3MnKeHU1hlwkNiBHUg5U0DDDwefHMRw/FjRXCzTSvHa1AkDa6Kds9ls4CQLY+
 WEdOJryhm1Z8jQPSsUEjw13QqiWBrKhjnAS160jREiF4DLRxTDOqf4RKy+QJ/mIB4ODjLPw4Oa+
 zcU+w1o29CVvN0Q==
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
index 94483b238f2a..764d61636765 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2103,37 +2103,43 @@ static int v4l2_subdev_enable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
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
@@ -2220,37 +2226,43 @@ static int v4l2_subdev_disable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
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



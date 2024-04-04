Return-Path: <linux-kernel+bounces-131260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE9B898568
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4B91F23C92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AF883CA2;
	Thu,  4 Apr 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hzMlX1H9"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCF9823DC;
	Thu,  4 Apr 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227826; cv=none; b=PwT7Tht0tmsRCzMQ3nBDvZfDZRZxDV5/r8kQUo5Q2h5/JxSzgR3EqYR7KpbCJXsVUE7Q3q2OwgLS2/RaBRVoaO0RolNVCDdEZhDRA6+gyEyaxCjUYTfRvriARhWf3e393CeimBiRfWL9DqUQETsPwjinTnzz5bnoEq+meMsMx+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227826; c=relaxed/simple;
	bh=6xModmV44eQ1wxMDDoC5M/XSmbDHzCEIS6vWiAXlbQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wbvw2qJhj+dZvQ6cqJGVr02sYhKBiIup0UqBoJV6arM0NnlMPnQIyHOswYUMIWapBVr6hzKOn2oNLMSALmQKvEAAirrJmI0QTF4k+Tet51wV13RpX7tvwWWkmD7xsQ/WmRKPD05VXSFJZC2zEAgmezbRcwXvMQKaANjfPDIgCKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hzMlX1H9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 09069B9A;
	Thu,  4 Apr 2024 12:49:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712227783;
	bh=6xModmV44eQ1wxMDDoC5M/XSmbDHzCEIS6vWiAXlbQU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hzMlX1H9lL6oPnwooCWCEgcrpgxiVIhzb/EplIMg3N4hoLSn9WNwKrZmdSTfeC1WT
	 PCP4jmnMehQhSdjx56nWx2iM0Co9P1Xa3P9zZ781WzcXlMJxPNTuSOrVO5WUGS9Ya9
	 SFRAWcqX9jWA0Mc3gPwPfmzNBCXZNXQdgJi7HDvA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 04 Apr 2024 13:50:02 +0300
Subject: [PATCH 3/4] media: subdev: Improve
 v4l2_subdev_enable/disable_streams_fallback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-enable-streams-impro-v1-3-1017a35bbe07@ideasonboard.com>
References: <20240404-enable-streams-impro-v1-0-1017a35bbe07@ideasonboard.com>
In-Reply-To: <20240404-enable-streams-impro-v1-0-1017a35bbe07@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6382;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=6xModmV44eQ1wxMDDoC5M/XSmbDHzCEIS6vWiAXlbQU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmDoXqzUOii7XDdjTJn6I2i0gRonETw2qZXprZ3
 l7KU4JNzyOJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZg6F6gAKCRD6PaqMvJYe
 9XEjD/9MskIxC7waa4ouYtk/VC23zfMtGwJyPLaCqGqllsD4e/1Ygq8TXUPvLJjF7islq6teylQ
 3hrNAzF84aIZt9gfmM1wc4p+0UiRHuZTr2fZR6ZElDMVLEd50i0xINIBYlwUGpyIp+m+rfk9TDb
 uJKKDzDaM0oM+7W6QMA0yHaDm8Ax9hsswu9sfRhGIL7uExA8L1REzQW3TIqCQdXFReACu2m7z+n
 cNPvXowTrJmJb7o+UiM39/7WO+juTRyozothrD1CHV8QSAUpbSp/NEMY2EoVMn3MXIQ9XNIkx5M
 XZcYR89HFnT905iOfynqVooEs1vv4Y6VC4zz/IyAcbWDf+/mJBRTfUN0Tvjf9GaDdKQsFtf3XmK
 34xN2IOVaGdNrwY+9TY7t7uXRqujy3yCeMUUs/mFkmdx1TTP05Lr2Jclcftn+mZTEh+T+YAAQvP
 cwG9cXEd5jFJd0VTBuLbnwBlc3hKU/lfpub4ZFKkC+qt86YGmbgSYKFjlCHF6B1ey+JQ7ugKU9P
 JkBosrdtg0LGhPVAZSMnfazMFCx/BQtjcJrPtTbVq2ZMN5ibU9SqRdTkrXLFBAe4rh2dZeSu9KY
 x6HmyOiKMPB8/CEhbT+kjmxKHjexm0H0DHhiYfT9ZEJyZpDHwi2uYVx2EjlEQBeeVVoEC/HzCps
 RGD0zASxfNQ2shQ==
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
soruce pad.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 68 ++++++++++++++++++++---------------
 include/media/v4l2-subdev.h           |  9 +++--
 2 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 3b3310bce5d4..91298bb84e6b 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2090,37 +2090,43 @@ static int v4l2_subdev_enable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
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
+	 * on the .s_stream() operation.
 	 */
 	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
 		return -EOPNOTSUPP;
 
-	for (i = 0; i < sd->entity.num_pads; ++i) {
-		if (i != pad && sd->entity.pads[i].flags & MEDIA_PAD_FL_SOURCE)
-			return -EOPNOTSUPP;
-	}
+	/*
+	 * .s_stream() means there is no streams support, so only allowed stream
+	 * is the imlicit stream 0.
+	 */
+	if (streams_mask != BIT_ULL(0))
+		return -EOPNOTSUPP;
+
+	/*
+	 * We use a 64-bit bitmask for tracking enabled pads, so only subdevices
+	 * with 64 pads or less can be supported.
+	 */
+	if (pad >= sizeof(sd->enabled_pads) * 8)
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
@@ -2207,37 +2213,43 @@ static int v4l2_subdev_disable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
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
+	 * on the .s_stream() operation.
 	 */
 	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
 		return -EOPNOTSUPP;
 
-	for (i = 0; i < sd->entity.num_pads; ++i) {
-		if (i != pad && sd->entity.pads[i].flags & MEDIA_PAD_FL_SOURCE)
-			return -EOPNOTSUPP;
-	}
+	/*
+	 * .s_stream() means there is no streams support, so only allowed stream
+	 * is the imlicit stream 0.
+	 */
+	if (streams_mask != BIT_ULL(0))
+		return -EOPNOTSUPP;
+
+	/*
+	 * We use a 64-bit bitmask for tracking enabled pads, so only subdevices
+	 * with 64 pads or less can be supported.
+	 */
+	if (pad >= sizeof(sd->enabled_pads) * 8)
+		return -EOPNOTSUPP;
 
-	if ((sd->enabled_streams & streams_mask) != streams_mask) {
-		dev_dbg(dev, "set of streams %#llx already disabled on %s:%u\n",
-			streams_mask, sd->entity.name, pad);
+	if ((sd->enabled_pads & BIT_ULL(pad)) != BIT_ULL(pad)) {
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
index 8bd1e3c96d2b..7077aec3176c 100644
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
  *
  * Each instance of a subdev driver should create this struct, either
@@ -1091,7 +1090,7 @@ struct v4l2_subdev {
 	 * doesn't support it.
 	 */
 	struct v4l2_subdev_state *active_state;
-	u64 enabled_streams;
+	u64 enabled_pads;
 	bool streaming_enabled;
 };
 

-- 
2.34.1



Return-Path: <linux-kernel+bounces-146649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8118A68C4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801EB1C21082
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAD412BE8D;
	Tue, 16 Apr 2024 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XmEnps++"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61AC129A7F;
	Tue, 16 Apr 2024 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264042; cv=none; b=hvPyaQN3MOdnhiKq5q2SKtSXt1JPmFhPT8c9cc4Bab+gGJPN64fgYt/w8MdiG8lb9KOzpr+X6GIcvNrO42GE1WEDrEWJsGwUlEMiC9iZaRpKiVWOPq3J+ee36fruWDOZjH2vxg4lmoK2OheF8w7+P05MIEwAKK8/B9+ugpyiPng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264042; c=relaxed/simple;
	bh=aCnDspzZEt06MUge756JFr8IcUIbBzfpqoQOxbjW9DY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JGvGQqYNfNA7xeZ4owK+DKpp9oj32eKGKOGL8nDHJ9PUXA+bCxz7FxGekxQUuOy8mNRnlYY6pT4AZB+mN9F8FdrRyc33TZf+R9yDE0ELv3cKgAvnv7c1xL/aUZOQWY7iIGoA4yej90HbcvQj2np/iHNuRBMJUkCF+JygfvuEgwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=XmEnps++; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 90E1114B1;
	Tue, 16 Apr 2024 12:39:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713263988;
	bh=aCnDspzZEt06MUge756JFr8IcUIbBzfpqoQOxbjW9DY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XmEnps++cuRr6tTj0yWBvff7NsDnPqCEAvR8ZrfGguyIzFHcII781aahukpNebq/Y
	 t+aYIEET7YSYss/IUgwwZ4ODGDZf6qwD6RS3azxB2lu3Gqn1RguVJEw4Y0fQUX/zO5
	 4BRCTlMejb1ElgOKP+6srDQxMFzNWIMK0gk6xEx0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 16 Apr 2024 13:40:04 +0300
Subject: [PATCH v4 05/10] media: subdev: Improve
 v4l2_subdev_enable/disable_streams_fallback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-enable-streams-impro-v4-5-1d370c9c2b6d@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6465;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=aCnDspzZEt06MUge756JFr8IcUIbBzfpqoQOxbjW9DY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHlWdkpZoVKvlDBKFD7J+e3JAbQuzfNE0MWqmj
 9LbE8iznHqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh5VnQAKCRD6PaqMvJYe
 9S6HD/9swy39lykKEsaNM6moCjlnpz050Utrg3KafWu+mBN1dfieZ9BNnDzX2GEVn96tTlkMab1
 iHEYSrczPNgq8wKtOgPP3CG6EcY7hpRtxLEzcO5nZqwTga5gPNIACFzzUlb58V7b9Sz3R4Bvp5a
 NXgrGZ1K03I4plePCtYiFgbc73iPd3HbLzeCrgg9FpIVrmb5Xy4RR+NiFkdg0ToB+9R2jAOHlMm
 4Xx4cFNk7xmC7Co1HE72FWXeoCRf5abvOOlMI9q9mgnb9PWI358eoDHov2ujrGeDR9wgT3oE5XX
 dE4SSw3uWraq7Vy11nm4nXEnkze4Og5IH5JLyKTCAqV0IMbDwCOz+K10NFxl8YJ5UkjT9/IWRu/
 juHoecSWlyNSOr/W8S0ebua1SMO2b3skWxRBas814/Z2GsO+NE1WP9ZkW5po3mbEeF+1RQNbTxf
 bsP/0/PQVhpgeNX1MzyWSB3bzr9zr7xvxaugCgsgVtNqmeX0CFWlAGPOXQycefLClXHxDUrCSh1
 7csXdMpX3E9h5/2W+UGlgttigLFJOD++fQbgEphASMRfG5ik9VB2Q2HVGGVEazS7QC6v+Ja0KDS
 npae+3FGDjkGby+UeyizvVHaJdLxWxgzXuinGRrEqm9oR9wSjz5XHYD+Z1wtrT0FzLN5XkPETZd
 lRv6C++WQbm6K0w==
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



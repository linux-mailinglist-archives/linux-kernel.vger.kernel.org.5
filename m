Return-Path: <linux-kernel+bounces-45791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719D5843647
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2713E1F279BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB023FE5B;
	Wed, 31 Jan 2024 05:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XxR8jA1k"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87643FB10;
	Wed, 31 Jan 2024 05:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680349; cv=none; b=VrEpYACJCdMvC2fMrE1otntYoHGV6/DlWCf7iK9LVbPocJJmoMMT55x6pKVM7G5fYK8I98f7ArLvZHAcUdMNpxL8Mre0dYNuzEhidnFY3KjEldR16CGrrOBJCns98xDwU8OcBhdpaPcjiJ6667mADvCzBQBliEOw+B/ReGCFp4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680349; c=relaxed/simple;
	bh=KVoYFTXgiQEorCS81o3nouTGpkktg/UDGZx3Jyex/DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqaJxKq3qbWrZYybCukCxs4WOadlDxn/Sr9mdyT4xabhRfWQAcnOE0iEeBr/CW0L1r6oa8x3yLIp4IdqH7iC5bjZyc7UJ3u9U9p5ytaORGe3p8aLnmbtSfKg7Q7Xfuknc+xIF0AH3Lfdc7kMbh9Ou+bXoER8l5WsrXTNFR6YXAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=XxR8jA1k; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.Jain (unknown [103.86.18.206])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 26C211803;
	Wed, 31 Jan 2024 06:50:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706680261;
	bh=KVoYFTXgiQEorCS81o3nouTGpkktg/UDGZx3Jyex/DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XxR8jA1kVtrydQiLOoWH6ZqGHfUV+pgXjLp09MfHYs9xDAO6sURVwXvW2anSd5Cj+
	 ixh/nVCrfkcqaVP3p2VANjXlhLKt3zUB3PDZ+XfKIYrQzq5Qe5DC9GEYvV1BvjzgJv
	 U8+XPvYxmjyFWjhAHS/AUa6gcZLysnexNpmQXgZ8=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 2/5] media: imx335: Use v4l2_link_freq_to_bitmap helper
Date: Wed, 31 Jan 2024 11:22:05 +0530
Message-ID: <20240131055208.170934-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240131055208.170934-1-umang.jain@ideasonboard.com>
References: <20240131055208.170934-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the v4l2_link_freq_to_bitmap() helper to figure out which
driver-supported link frequencies can be used on a given system.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 927b4806a5d7..73691069556f 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -49,7 +49,7 @@
 #define IMX335_INCLK_RATE	24000000
 
 /* CSI2 HW configuration */
-#define IMX335_LINK_FREQ	594000000
+#define IMX335_LINK_FREQ	594000000LL
 #define IMX335_NUM_DATA_LANES	4
 
 #define IMX335_REG_MIN		0x00
@@ -134,6 +134,7 @@ struct imx335_mode {
  * @vblank: Vertical blanking in lines
  * @cur_mode: Pointer to current selected sensor mode
  * @mutex: Mutex for serializing sensor controls
+ * @link_freq_bitmap: Menu bitmap for link_freq_ctrl
  * @cur_mbus_code: Currently selected media bus format code
  */
 struct imx335 {
@@ -157,6 +158,7 @@ struct imx335 {
 	u32 vblank;
 	const struct imx335_mode *cur_mode;
 	struct mutex mutex;
+	unsigned long link_freq_bitmap;
 	u32 cur_mbus_code;
 };
 
@@ -404,7 +406,8 @@ static int imx335_update_controls(struct imx335 *imx335,
 {
 	int ret;
 
-	ret = __v4l2_ctrl_s_ctrl(imx335->link_freq_ctrl, mode->link_freq_idx);
+	ret = __v4l2_ctrl_s_ctrl(imx335->link_freq_ctrl,
+				 __ffs(imx335->link_freq_bitmap));
 	if (ret)
 		return ret;
 
@@ -690,6 +693,13 @@ static int imx335_init_state(struct v4l2_subdev *sd,
 	fmt.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE;
 	imx335_fill_pad_format(imx335, &supported_mode, &fmt);
 
+	mutex_lock(&imx335->mutex);
+	__v4l2_ctrl_modify_range(imx335->link_freq_ctrl, 0,
+				 __fls(imx335->link_freq_bitmap),
+				 ~(imx335->link_freq_bitmap),
+				 __ffs(imx335->link_freq_bitmap));
+	mutex_unlock(&imx335->mutex);
+
 	return imx335_set_pad_format(sd, sd_state, &fmt);
 }
 
@@ -938,19 +948,10 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
 		goto done_endpoint_free;
 	}
 
-	if (!bus_cfg.nr_of_link_frequencies) {
-		dev_err(imx335->dev, "no link frequencies defined\n");
-		ret = -EINVAL;
-		goto done_endpoint_free;
-	}
-
-	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++)
-		if (bus_cfg.link_frequencies[i] == IMX335_LINK_FREQ)
-			goto done_endpoint_free;
-
-	dev_err(imx335->dev, "no compatible link frequencies found\n");
-
-	ret = -EINVAL;
+	ret = v4l2_link_freq_to_bitmap(imx335->dev, bus_cfg.link_frequencies,
+				       bus_cfg.nr_of_link_frequencies,
+				       link_freq, ARRAY_SIZE(link_freq),
+				       &imx335->link_freq_bitmap);
 
 done_endpoint_free:
 	v4l2_fwnode_endpoint_free(&bus_cfg);
@@ -1098,9 +1099,8 @@ static int imx335_init_controls(struct imx335 *imx335)
 	imx335->link_freq_ctrl = v4l2_ctrl_new_int_menu(ctrl_hdlr,
 							&imx335_ctrl_ops,
 							V4L2_CID_LINK_FREQ,
-							ARRAY_SIZE(link_freq) -
-							1,
-							mode->link_freq_idx,
+							__fls(imx335->link_freq_bitmap),
+							__ffs(imx335->link_freq_bitmap),
 							link_freq);
 	if (imx335->link_freq_ctrl)
 		imx335->link_freq_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
-- 
2.41.0



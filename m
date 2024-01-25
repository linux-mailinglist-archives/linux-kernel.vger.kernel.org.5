Return-Path: <linux-kernel+bounces-38851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67F583C740
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F7E1F26213
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF1B76908;
	Thu, 25 Jan 2024 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="n3I6TOoN"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21F674E2E;
	Thu, 25 Jan 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197773; cv=none; b=m8XURXG4V1mbPeq6Za5zYJSkCYWrlqHCawoNhd7sRC5PLRMHPqeylFFbzOkOrZ8Mq1Zehs3w4OJq2fR1tr1SbVVqRZf4NL4YD5ODyjbsyFEcbN3s35h5QoT1L8SZFJrAZMLH4X0rRWytinoOVrIYuKKcWSsqi1ynPIeF7Dq2KMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197773; c=relaxed/simple;
	bh=qPG6O3t7fXsKr/KZeQDHeleOcdDGSiCC1BklX+oeDXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NeXdVlxVQ9+/JxyS34vE2MXP98VLbyBRpx8iqCFijzv+t2IWpWowedu3n+/UU4LANi0GJIscbvVN0qQtGX+q/efLfCuwM89kUfTzf/VjsNQS3bL3kFdCAIr29vdS8sNATHUvPjjtvYvsj3aSPA7Y1DvXPsDxq8XT9JCoJe3El/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=n3I6TOoN; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.175])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 159F4A9A;
	Thu, 25 Jan 2024 16:48:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706197689;
	bh=qPG6O3t7fXsKr/KZeQDHeleOcdDGSiCC1BklX+oeDXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n3I6TOoN5Dqf99Xt1f/VSRpZ8GoNR7RFildvHv3YiTQ72UpzY1MoeV66bzoLcL132
	 h491vhqDv3+HOU5rk1VJ4tPP93LC6rMsc3ou4OPCo7vsPbgjyWuY2OhElcn4tEZpSv
	 WW4I3+fZwZ81DFpsILUGNdYRiofw5gak2P+AIDaM=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 2/4] media: i2c: imx335: Refactor power sequence to set controls
Date: Thu, 25 Jan 2024 21:19:06 +0530
Message-ID: <20240125154908.465191-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240125154908.465191-1-umang.jain@ideasonboard.com>
References: <20240125154908.465191-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Additional controls might require the sensor to be powered up
to set the control value. Currently, only the exposure control
powers up the sensor.

Move the power up sequence out of the switch-case block.
In a subsequent patch, test pattern control will be added that
needs the sensor to be powered up. Hence, refactor the power
sequence to be present outside the switch-case block.

The VBLANK control is also moved out of the switch-case in order
to be handled early on, to propagate the changes to other controls.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 0df9ea189fff..5add50af20e6 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -475,8 +475,8 @@ static int imx335_set_ctrl(struct v4l2_ctrl *ctrl)
 	u32 exposure;
 	int ret;
 
-	switch (ctrl->id) {
-	case V4L2_CID_VBLANK:
+	/* Propagate change of current control to all related controls */
+	if (ctrl->id == V4L2_CID_VBLANK) {
 		imx335->vblank = imx335->vblank_ctrl->val;
 
 		dev_dbg(imx335->dev, "Received vblank %u, new lpfr %u\n",
@@ -489,12 +489,17 @@ static int imx335_set_ctrl(struct v4l2_ctrl *ctrl)
 					       imx335->cur_mode->height -
 					       IMX335_EXPOSURE_OFFSET,
 					       1, IMX335_EXPOSURE_DEFAULT);
-		break;
-	case V4L2_CID_EXPOSURE:
-		/* Set controls only if sensor is in power on state */
-		if (!pm_runtime_get_if_in_use(imx335->dev))
-			return 0;
+	}
+
+	/*
+	 * Applying V4L2 control value only happens
+	 * when power is up for streaming.
+	 */
+	if (pm_runtime_get_if_in_use(imx335->dev) == 0)
+		return 0;
 
+	switch (ctrl->id) {
+	case V4L2_CID_EXPOSURE:
 		exposure = ctrl->val;
 		analog_gain = imx335->again_ctrl->val;
 
@@ -503,14 +508,14 @@ static int imx335_set_ctrl(struct v4l2_ctrl *ctrl)
 
 		ret = imx335_update_exp_gain(imx335, exposure, analog_gain);
 
-		pm_runtime_put(imx335->dev);
-
 		break;
 	default:
 		dev_err(imx335->dev, "Invalid control %d\n", ctrl->id);
 		ret = -EINVAL;
 	}
 
+	pm_runtime_put(imx335->dev);
+
 	return ret;
 }
 
-- 
2.41.0



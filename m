Return-Path: <linux-kernel+bounces-45794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C1C84364D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79772B25B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D40E41233;
	Wed, 31 Jan 2024 05:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Q6A6S9nu"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0B43FB14;
	Wed, 31 Jan 2024 05:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680352; cv=none; b=qKWf1PNmilGFaFmtF8GZ+T991mHMlGZqhA1dffCiAfLyXqsi+qOA8Tj7QAYIsD51g0zB8tclC+jhLQ7JylRVkIt7lGpZ3gZhihOX0YiVcPcubLEh6x3PqgN7NqB5tL2jsjTuSUHgtYFy6wyORpEeP9mg1HYPsiRMyO1UrAuramg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680352; c=relaxed/simple;
	bh=vdKoqMvA7LSgk/e2WNUBvI9QcKVaD8d7AAKwOmSxsjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DagYPte9GoseZmiakUi2PPZAHjXfXtYsXc/2VjtdiCwT1Wai6myK+yDTZ2KfC2q9JIgXAjxAowdzSs8pummhoV5E3iNALqmnpFlO7mDy5ssyzHframuGxzghPNwpg0vFRhJYWL4/obJ2PAm5FZNxbWyLHdLntvZU8DKwhfUVfWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Q6A6S9nu; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.Jain (unknown [103.86.18.206])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 716C6613C;
	Wed, 31 Jan 2024 06:51:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706680266;
	bh=vdKoqMvA7LSgk/e2WNUBvI9QcKVaD8d7AAKwOmSxsjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6A6S9nu04THOw1LPI+7w0Haoocb3VyKrhOGuNiOodzrEKkipxJdhFtg/1GIJtbH4
	 LeXABsvHztmnAh/JuJRIVxFPmbCieK/VL8ci02cmAyvimeL5hjhjedlSV5EYIfdkBI
	 s7dl5dYzU4UqR3r5xtT6eLSvAtlgKkoJ9d3VfhAc=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 4/5] media: i2c: imx335: Refactor power sequence to set controls
Date: Wed, 31 Jan 2024 11:22:07 +0530
Message-ID: <20240131055208.170934-5-umang.jain@ideasonboard.com>
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
 drivers/media/i2c/imx335.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index ca3eab50f714..250b7136048d 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -526,26 +526,31 @@ static int imx335_set_ctrl(struct v4l2_ctrl *ctrl)
 	u32 exposure;
 	int ret;
 
-	switch (ctrl->id) {
-	case V4L2_CID_VBLANK:
+	/* Propagate change of current control to all related controls */
+	if (ctrl->id == V4L2_CID_VBLANK) {
 		imx335->vblank = imx335->vblank_ctrl->val;
 
 		dev_dbg(imx335->dev, "Received vblank %u, new lpfr %u\n",
 			imx335->vblank,
 			imx335->vblank + imx335->cur_mode->height);
 
-		ret = __v4l2_ctrl_modify_range(imx335->exp_ctrl,
-					       IMX335_EXPOSURE_MIN,
-					       imx335->vblank +
-					       imx335->cur_mode->height -
-					       IMX335_EXPOSURE_OFFSET,
-					       1, IMX335_EXPOSURE_DEFAULT);
-		break;
-	case V4L2_CID_EXPOSURE:
-		/* Set controls only if sensor is in power on state */
-		if (!pm_runtime_get_if_in_use(imx335->dev))
-			return 0;
+		return __v4l2_ctrl_modify_range(imx335->exp_ctrl,
+						IMX335_EXPOSURE_MIN,
+						imx335->vblank +
+						imx335->cur_mode->height -
+						IMX335_EXPOSURE_OFFSET,
+						1, IMX335_EXPOSURE_DEFAULT);
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
 
@@ -554,14 +559,14 @@ static int imx335_set_ctrl(struct v4l2_ctrl *ctrl)
 
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



Return-Path: <linux-kernel+bounces-72697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9870485B77A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1E31C24910
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C4264CCF;
	Tue, 20 Feb 2024 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ttiucm6u"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA2263410;
	Tue, 20 Feb 2024 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421320; cv=none; b=Vo096vDu+wS0uP01dpdFynfbn5vZ12/7ol/o5Jc99+/rp9RXssxB+HcVR2ZQMh3vbmNuVPKdLsXwaiMq1c2lr96S/SsPUr8uwgo6TIShkeOzXDpcHQw/WG6do5r5ZO+EJIznEXPBXVc7RaU1RnoLYMronZLfYhKMInKuAmzjK78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421320; c=relaxed/simple;
	bh=7/nlcTXjn6fmMKJ6B7TxNKPbpJTYZY5Sd+dT6NQXmgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGK26k5RlLFhqjipqegO005gRd77II2wK8MWkwsyDa2pcWEJ4pgEY2UT3Ug7YRDC1IgfFoKG9exysFMoECOIEHws8XweqOlzWjpRBvdK+/vRdxTmvMnCSp9fIbTLPKkbOYhMRnOOZwaFxzIXpt+x87bueqSNBIinp3uf5CNa6qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ttiucm6u; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.159])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AF1931593;
	Tue, 20 Feb 2024 10:28:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708421310;
	bh=7/nlcTXjn6fmMKJ6B7TxNKPbpJTYZY5Sd+dT6NQXmgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ttiucm6uWkPdAzg00xsrPDHowYPf5Vmm0N0DbC+ogiKfoqo8tCJJItrF1qpgpAibi
	 gJWSZ2FQKfFmxIf00Qr27Ii5f8HPmlXQsMzMna+BvqfgAP6D9oQpkbTtOX3ToFPP/H
	 d1JfUhpdX9zdX7kaT0LbMXWo3HIBgizWaD4DmQTM=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v3 4/5] media: imx335: Refactor power sequence to set controls
Date: Tue, 20 Feb 2024 14:58:20 +0530
Message-ID: <20240220092821.1993-5-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220092821.1993-1-umang.jain@ideasonboard.com>
References: <20240220092821.1993-1-umang.jain@ideasonboard.com>
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
index 27f850a5b9b7..e2445b94cf91 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -527,26 +527,31 @@ static int imx335_set_ctrl(struct v4l2_ctrl *ctrl)
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
 
@@ -555,14 +560,14 @@ static int imx335_set_ctrl(struct v4l2_ctrl *ctrl)
 
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
2.43.0



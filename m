Return-Path: <linux-kernel+bounces-142995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B37F98A3308
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4066FB2201B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368F71494DF;
	Fri, 12 Apr 2024 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tK0qkGHG"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4081494A8;
	Fri, 12 Apr 2024 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937659; cv=none; b=FWPI1ccam9ksFnbvAFRJYraNElrPyMsA4dH0rm/U6Y1HYtix/+iFnqrTQrYtO/x2v4XY3DZfKnjOSxMBJwgDZGqRwjopGKilngt1qK3/HWTHywFKHVY3lz3AgvDgQtt7SgGejVH3aFoV0DzE+RukkW3/6zeL/DzCevGrq0qfN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937659; c=relaxed/simple;
	bh=jNXV8hHoJduX5tXufEQNHt5F63rCqvvq3i2twRk/QcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r56WvMD+QV/BLO/Y4mUM0C1jWL1AfSxW38Uw0iRb4/O4jUXDg6dZs7pFYGYUdXRwYrf05TzQrRx8osOkkyfrS0eiZx/rdpCPtwSOeQmpbFMb1Us2ZFa8ulYyaCEf70KUmsQwfBnTJKFxh/Ir5vBT7PyuquaGHJm6NvYytBGJk8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=tK0qkGHG; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.251.226.65])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6018CA12;
	Fri, 12 Apr 2024 18:00:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712937613;
	bh=jNXV8hHoJduX5tXufEQNHt5F63rCqvvq3i2twRk/QcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tK0qkGHGuNKwqiWGNCzS2ejCn8mDUhwD/UI3WriGP14gU8hZ0V6mQCR+0bAgstHpl
	 eDX1kebiR+ywpBH7BDCfabQ/3Bp8jHSGEhbrPo2cxEw8+F0xgDL1opx/aXcmnT/Pfq
	 TT+ukgFV3eJPozu7EtyJZ0893lV8NNNgUdrifLIM=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v6 2/6] media: imx335: Parse fwnode properties
Date: Fri, 12 Apr 2024 21:30:35 +0530
Message-ID: <20240412160039.276743-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412160039.276743-1-umang.jain@ideasonboard.com>
References: <20240412160039.276743-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kieran Bingham <kieran.bingham@ideasonboard.com>

Call the V4L2 fwnode device parser to handle controls that are
standardised by the framework.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index c633ea1380e7..cebe8cfd77be 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -1227,10 +1227,16 @@ static int imx335_init_controls(struct imx335 *imx335)
 {
 	struct v4l2_ctrl_handler *ctrl_hdlr = &imx335->ctrl_handler;
 	const struct imx335_mode *mode = imx335->cur_mode;
+	struct v4l2_fwnode_device_properties props;
 	u32 lpfr;
 	int ret;
 
-	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 7);
+	ret = v4l2_fwnode_device_parse(imx335->dev, &props);
+	if (ret)
+		return ret;
+
+	/* v4l2_fwnode_device_properties can add two more controls */
+	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 9);
 	if (ret)
 		return ret;
 
@@ -1295,6 +1301,8 @@ static int imx335_init_controls(struct imx335 *imx335)
 	if (imx335->hblank_ctrl)
 		imx335->hblank_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
+	v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx335_ctrl_ops, &props);
+
 	if (ctrl_hdlr->error) {
 		dev_err(imx335->dev, "control init failed: %d\n",
 			ctrl_hdlr->error);
-- 
2.43.0



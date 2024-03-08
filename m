Return-Path: <linux-kernel+bounces-96656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56218875F92
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95BF1F23F31
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8A5524DB;
	Fri,  8 Mar 2024 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SN/7T8jv"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC9037171;
	Fri,  8 Mar 2024 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709886811; cv=none; b=Qucr4BiAfHFQOfdAvPUS9+O1LVP9W6UgZ/ooYGdeXJF5GGxiUMR2AAO1BKuJ3OQ+4+G0/9qH6+Rn4It9wrpNLcMDjqRNCpO//Z1v1DbjhanYv8i1FosH6J2JfoUkDOLNejV57P8H5KfL0uYJoyAcfMi2Vnh0qF5R1aWSqsjHfUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709886811; c=relaxed/simple;
	bh=QAcCvi/VWLJ9KXWFVAp95ifhx0kCqdkYbogSkEAjqxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+ZV1SHfsHg9LHmvOQEpRtUpmM+KKcoepDSgJTxgSwPDbVtX53Ad71mu7hNlUkvIfAMlYlkariMovR785HHggyRolzuDv8rALofzmo6TI4qizDSF8egVvi4BzgGMxgOK2gaPDygU7wzrEULweKCCi4FHB+tymlKmZW/nOmhT55E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=SN/7T8jv; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.251.226.70])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 48CC282A;
	Fri,  8 Mar 2024 09:33:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709886789;
	bh=QAcCvi/VWLJ9KXWFVAp95ifhx0kCqdkYbogSkEAjqxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SN/7T8jvQD7+hyWNpkwxQfTCj1IcpshESwl0TBSUe966HhJzSFkQ0H6lLY1RHPzvq
	 8ZTPrOJzNbpuLERuhMYrEvSTS6dCsJ93ofPa1kfgvK8lhgWIWkq8hFjPuUjTurdV+f
	 SiN2dqyCMAApp9zy5K69myY7kbS/Zj67cALPe32E=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 2/6] media: imx335: Parse fwnode properties
Date: Fri,  8 Mar 2024 14:03:08 +0530
Message-ID: <20240308083312.90279-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240308083312.90279-1-umang.jain@ideasonboard.com>
References: <20240308083312.90279-1-umang.jain@ideasonboard.com>
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
 drivers/media/i2c/imx335.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 7162b0a3cef3..819ab3a6c5fc 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -1225,10 +1225,12 @@ static int imx335_init_controls(struct imx335 *imx335)
 {
 	struct v4l2_ctrl_handler *ctrl_hdlr = &imx335->ctrl_handler;
 	const struct imx335_mode *mode = imx335->cur_mode;
+	struct v4l2_fwnode_device_properties props;
 	u32 lpfr;
 	int ret;
 
-	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 7);
+	/* v4l2_fwnode_device_properties can add two more controls */
+	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 9);
 	if (ret)
 		return ret;
 
@@ -1300,6 +1302,15 @@ static int imx335_init_controls(struct imx335 *imx335)
 		return ctrl_hdlr->error;
 	}
 
+	ret = v4l2_fwnode_device_parse(imx335->dev, &props);
+	if (ret)
+		return ret;
+
+	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx335_ctrl_ops,
+					      &props);
+	if (ret)
+		return ret;
+
 	imx335->sd.ctrl_handler = ctrl_hdlr;
 
 	return 0;
-- 
2.43.0



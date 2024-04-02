Return-Path: <linux-kernel+bounces-128110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88211895642
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265E31F2678A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F5B86120;
	Tue,  2 Apr 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="U2BqdYqH"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1D286647;
	Tue,  2 Apr 2024 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066982; cv=none; b=anrf5Erf18AIFLTYcpXKZBwSSJ26od/UjPhRP+XmHjXnu6RWx+DMSbGQFE5WQMh2X39z46bQymMJK/72c8EeXgCKv6rUHEWjtrkU6rK50Ca6K31TTFbPAP3ZZTQcPDLLsf585roslJLd6aaacWbuuLwoiqZMqLS2dRt8YzPTBq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066982; c=relaxed/simple;
	bh=QiWGhNyPclP30U/OSfPGoQv0ru4Y4LDzmV4Byhyje2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opqwCGEjcM1rSk11d+L4mlDR5B/lc8e5AdHOucnvcq6eqf4goCmXVKjcezzhxEn2wA/cnXFJN87PU8+v4wPO4Bp0skx2PAGFEe3cDi4T0pwR0jKrotpQxGHk1sa1APmxHh2ThYpyOMALVPouOyw+4/Uz7pb10+qtEj9xSwnOiX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=U2BqdYqH; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.232])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D0E428E1;
	Tue,  2 Apr 2024 16:09:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712066943;
	bh=QiWGhNyPclP30U/OSfPGoQv0ru4Y4LDzmV4Byhyje2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U2BqdYqHjuQfgz5dpug8jXQCAFddfWPj8SE5KqVr6fhALLvGMocDR9oUN9grl6PuS
	 iBqSGCak+OVnXITfJEHqSQHQPZbLr0oGdibyBhk+vakcAce/x5Ek+4xyjyDLRWE6Et
	 L2OzWngexZfXClmzFwYKM1nfxiOUTb3F2zF68+mU=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v4 2/6] media: imx335: Parse fwnode properties
Date: Tue,  2 Apr 2024 19:39:20 +0530
Message-ID: <20240402140924.10009-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402140924.10009-1-umang.jain@ideasonboard.com>
References: <20240402140924.10009-1-umang.jain@ideasonboard.com>
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
 drivers/media/i2c/imx335.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index c633ea1380e7..b8cf85984127 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -1227,10 +1227,12 @@ static int imx335_init_controls(struct imx335 *imx335)
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
 
@@ -1296,15 +1298,27 @@ static int imx335_init_controls(struct imx335 *imx335)
 		imx335->hblank_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
 	if (ctrl_hdlr->error) {
-		dev_err(imx335->dev, "control init failed: %d\n",
-			ctrl_hdlr->error);
-		v4l2_ctrl_handler_free(ctrl_hdlr);
-		return ctrl_hdlr->error;
+		ret = ctrl_hdlr->error;
+		dev_err(imx335->dev, "control init failed: %d\n", ret);
+		goto free_ctrl_hdlr;
 	}
 
+	ret = v4l2_fwnode_device_parse(imx335->dev, &props);
+	if (ret)
+		goto free_ctrl_hdlr;
+
+	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx335_ctrl_ops,
+					      &props);
+	if (ret)
+		goto free_ctrl_hdlr;
+
 	imx335->sd.ctrl_handler = ctrl_hdlr;
 
 	return 0;
+
+free_ctrl_hdlr:
+	v4l2_ctrl_handler_free(ctrl_hdlr);
+	return ret;
 }
 
 /**
-- 
2.43.0



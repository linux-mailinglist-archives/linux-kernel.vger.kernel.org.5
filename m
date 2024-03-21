Return-Path: <linux-kernel+bounces-109926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8538857DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFBCAB21BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE2F59147;
	Thu, 21 Mar 2024 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="skWcKhL5"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF1158AD6;
	Thu, 21 Mar 2024 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019584; cv=none; b=FWEwBAc/bDtBPMFC4iL1yy4EfDbpMpy9SgUIckC6A7SHe3kuZTkx1ZOKeeIugIoJx8HoDjgp7FUfAUi/mnTwPGkQtk6JC681FxLeJXxHPv6BQWfxzhfw6cJDYjCY0Y1NGpKdOxpqCG7nDytsY6vw8fst+v2T8mxwdnNj8oVgBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019584; c=relaxed/simple;
	bh=QiWGhNyPclP30U/OSfPGoQv0ru4Y4LDzmV4Byhyje2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTWowwU+3dZIbewT/VsfudLFkYYKGtNjeIb3VFCMhk7cdM6IFw+S00+tPG589oC4/AiI3Wi0aa84aBHi+PMsBYaNiaqLjD5TIBK1Wlg8f7D6XSjKT+tDY75u7nVB90AYQmd3Puh4MACc5CFrtNhzr9niemr6boX4Pbd8Pbt98mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=skWcKhL5; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.138])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 970B2CC8;
	Thu, 21 Mar 2024 12:12:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711019553;
	bh=QiWGhNyPclP30U/OSfPGoQv0ru4Y4LDzmV4Byhyje2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skWcKhL5FTO72n4hV63ONM76CjUEByftfx7+VOHrXZUuI5FtIfIdSTbYoxcHCh3qs
	 iN5jNge8jQFT42HrKZ2JREiYDVNNH2RniTrrjUfNjqTIp3uMny/2e8W84KJyIeosm9
	 wcX6tQqkAH/jXiQdctBiJBHsE+UU1BQTfCPGN1Bo=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v3 2/6] media: imx335: Parse fwnode properties
Date: Thu, 21 Mar 2024 16:42:35 +0530
Message-ID: <20240321111239.808735-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321111239.808735-1-umang.jain@ideasonboard.com>
References: <20240321111239.808735-1-umang.jain@ideasonboard.com>
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



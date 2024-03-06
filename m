Return-Path: <linux-kernel+bounces-93476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3541873051
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E792287D68
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0089A5DF09;
	Wed,  6 Mar 2024 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bU3xHkUh"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155565CDC9;
	Wed,  6 Mar 2024 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712665; cv=none; b=ZSK6VctwMNO5+YiCUaCI7AP5uQroUGgUlqJBVPd4yXjVrHQELppvna6U6VZxTGZpcjj2xngFecxYDgrcRQ5il/fqxOAz+sJXlcgzUE5IMEG0sOaDO2VHXwcYmsxuQ7uAIbjaYIVj1jbpDzwBqQVoB05MzLeLvfiTUGG1ZN9Hzfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712665; c=relaxed/simple;
	bh=eGi/asiE2T7+c3wnXbY4y7w7m3h3dlY60L0/uI3eZV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wii55ACH/6EtuO/zXan7OXGYHZs4SsNz8Dmzh8IjSeSy58uf7Ewu5yEucFEDh1HtO0SPimheKSDIHIti5bdSGsCdVNLT43QyRi9xL6cmNLqjsMfrVBCwkja7uHHMODrQYDUmQaT6/2DEMKgqTBw3d5XtUHomNfZwOsQHAG8nh7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bU3xHkUh; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.251.226.70])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CB89AFAD;
	Wed,  6 Mar 2024 09:10:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709712642;
	bh=eGi/asiE2T7+c3wnXbY4y7w7m3h3dlY60L0/uI3eZV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bU3xHkUh5Ce5AMZYe+761JpiwDI2oWM3wuA3h+SUzAImZLIiAqg6TWk1NSnhnggqb
	 8j6gk6SRI32cPcdXGuwHwotWmwmtPtQBr0RLSYMCHVabff8JBQwaFix+GOqZX02xTd
	 ZMRNWxL1opE+bbaW9f7ExvL5aje86LTG5p117K8Q=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 2/5] media: imx335: Parse fwnode properties
Date: Wed,  6 Mar 2024 13:40:35 +0530
Message-ID: <20240306081038.212412-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306081038.212412-1-umang.jain@ideasonboard.com>
References: <20240306081038.212412-1-umang.jain@ideasonboard.com>
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
index a42f48823515..7f3f74240cd0 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -1222,13 +1222,15 @@ static int imx335_init_controls(struct imx335 *imx335)
 {
 	struct v4l2_ctrl_handler *ctrl_hdlr = &imx335->ctrl_handler;
 	const struct imx335_mode *mode = imx335->cur_mode;
+	struct v4l2_fwnode_device_properties props;
 	u32 lpfr;
 	u64 pclk;
 	s64 link_freq_in_use;
 	u8 bpp;
 	int ret;
 
-	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 7);
+	/* v4l2_fwnode_device_properties can add two more controls */
+	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 9);
 	if (ret)
 		return ret;
 
@@ -1313,6 +1315,15 @@ static int imx335_init_controls(struct imx335 *imx335)
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



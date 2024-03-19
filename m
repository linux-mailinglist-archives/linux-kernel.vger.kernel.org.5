Return-Path: <linux-kernel+bounces-107165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FC187F85D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC3B4B21A96
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F393E54775;
	Tue, 19 Mar 2024 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DDgp61dS"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAB254670
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833253; cv=none; b=FDcsHbzhgHyv8iQrFUKm7avmIIaPMl/QbbFdmOBz6lfW28xkwPykfSKuMv/DEC1bICuOZU/Wkbxpy5R2crF8TOjTZnSYxDg2Nb98mV6eyJ6uOVwr6T+gbAL+aTBy0S4BwzAZZzVkrKmAf08uVrbFFoKxongiq3PoERKGcmH+cmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833253; c=relaxed/simple;
	bh=QiWGhNyPclP30U/OSfPGoQv0ru4Y4LDzmV4Byhyje2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNtVB4D0S5I4jlOLshnjwvUfTgxvyXY2a/W7AKYO2fR3TLoJTatKh09ToobmYoH6vvwY9P+iZiLzIQccHhaCRw0pRpr7eWj4WKRr88dyc73LrKpM8j7QYRGyOLw0vKY+qhRdrDdTAi9LedlwJx9QZCgIE0acmr/rG9pwTqYdsWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=DDgp61dS; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.138])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0FB24BB2;
	Tue, 19 Mar 2024 08:27:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710833223;
	bh=QiWGhNyPclP30U/OSfPGoQv0ru4Y4LDzmV4Byhyje2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDgp61dSY3xFEod20n31t0J2YkCQfhqt8vKeJJFDDoZOmEhFjVW5W7msixkeQRpVJ
	 zAdgTfZvJxVwQsFvy+/V6pmlUQohqkPN3vH97VESwzTfwtmc28tKjnqFORyI+x25o7
	 Th+Yg1OQS1QtoLgqtDBbtfHX2GCQ4zwG2jvaVp8o=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v3 2/6] media: imx335: Parse fwnode properties
Date: Tue, 19 Mar 2024 12:57:08 +0530
Message-ID: <20240319072712.133449-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319072712.133449-1-umang.jain@ideasonboard.com>
References: <20240319072712.133449-1-umang.jain@ideasonboard.com>
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



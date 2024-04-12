Return-Path: <linux-kernel+bounces-142646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C91C8A2E45
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11D91F2339A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540645812A;
	Fri, 12 Apr 2024 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="npW1HRQB"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B1057321;
	Fri, 12 Apr 2024 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924936; cv=none; b=obxxr7NeNjuqP1o69KgDbYYCs8S9uhmnj4aeQbu29gO8d5RrtRuUi9dA0C1SPA6wqTAn5cMxapPsrzZwtChiXhrrTM/SiG6bMr5XPw4n1iMIzUV4TTzgeXJke4HusS4j89BpbBBQL2YpIOoiwsca5bxgNQGsLmektU02WJ/HAMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924936; c=relaxed/simple;
	bh=2h6WEboiVr0pnc/sy1Hd1sz7AyQj7EENcv/yL7xPOJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DE+1Mv9iUVqIPZ14Fbc3SKW8zfH4qSiEfWvEey8cQW2Rosusz10PpE5sBiQPLE7khlUFvQaIZHbb6CJhjoCmbQtrEVGMxkN9TieqcwSk5l8k3v/xn11m2PVEiJbx6Zx9e5JGJ80/+Mmnuom5PIMeNPxrbcDIo8zeSb6nlM3EnqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=npW1HRQB; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.251.226.65])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DB943B0E;
	Fri, 12 Apr 2024 14:28:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712924889;
	bh=2h6WEboiVr0pnc/sy1Hd1sz7AyQj7EENcv/yL7xPOJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=npW1HRQBdFI5eN3dz0Xs4SRpU3lSIi7Tfv2nqM21ScLNnh2zGfN33raJf8sNrcfGC
	 oZFgeVV7aCU9iWOD6S3HJcgkhB46TviUTuiiLHGZs5G7aREsbkGD++q+88aYlto2we
	 yc3Vfcc37vLw6/p+tnMMF09uVOexPsdknTGqaKns=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v5 2/6] media: imx335: Parse fwnode properties
Date: Fri, 12 Apr 2024 17:58:38 +0530
Message-ID: <20240412122842.193713-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412122842.193713-1-umang.jain@ideasonboard.com>
References: <20240412122842.193713-1-umang.jain@ideasonboard.com>
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
 drivers/media/i2c/imx335.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index c633ea1380e7..3ea9c0ebe278 100644
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
 
@@ -1295,9 +1297,15 @@ static int imx335_init_controls(struct imx335 *imx335)
 	if (imx335->hblank_ctrl)
 		imx335->hblank_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
-	if (ctrl_hdlr->error) {
-		dev_err(imx335->dev, "control init failed: %d\n",
-			ctrl_hdlr->error);
+	ret = v4l2_fwnode_device_parse(imx335->dev, &props);
+	if (!ret) {
+		/* Failure sets ctrl_hdlr->error, which we check afterwards anyway */
+		v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx335_ctrl_ops,
+						&props);
+	}
+
+	if (ctrl_hdlr->error || ret) {
+		dev_err(imx335->dev, "control init failed: %d\n", ctrl_hdlr->error);
 		v4l2_ctrl_handler_free(ctrl_hdlr);
 		return ctrl_hdlr->error;
 	}
-- 
2.43.0



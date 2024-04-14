Return-Path: <linux-kernel+bounces-144175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55358A42C3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED70281244
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2E258AB0;
	Sun, 14 Apr 2024 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nr7kB/FD"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF945730A;
	Sun, 14 Apr 2024 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713103598; cv=none; b=KZmSkMC4TKeJHaCX1CYnRmed5IFVAbEGnsMBEu0A905YKYugzyqn+ULvD5NFO++W1xvU69uNA9le+86QZe93War4USjW8ZmuBZSkRJb2SUBPB8DZJ6VEdjD0houeTGim7vImg7JvwzjoY857feoGbHNHnl+8aHXzDWEOGYD+gMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713103598; c=relaxed/simple;
	bh=jNXV8hHoJduX5tXufEQNHt5F63rCqvvq3i2twRk/QcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2Q2WL6u4FluioRPIIKm7qmHl8k9/Vs794Ui3lKg7LDJ+9zOtYa3kCm47VH+VvlqW4rDXrB46b1Z5sNVGJRlu7JVql8uMYBsIrbmwe0xstregN8LjXGQc/RXVSN5Z2X6K9zoqnes5fX/XW0FIL+xvDAI0SoFKp1WJ+UOD1IhkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=nr7kB/FD; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.238])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 44115F50;
	Sun, 14 Apr 2024 16:05:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713103550;
	bh=jNXV8hHoJduX5tXufEQNHt5F63rCqvvq3i2twRk/QcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nr7kB/FDvhWozzalLdhY4jSTAngUOk+VqeqBOsS846JpajqDDDucSoByu3PPEdlmU
	 eZ861VoAZURW/JbjKRUozZd2SrlQExF2UzKizBX4Vj3oMyckgD2CKopq3KU8I4YHLw
	 AqqRCXXsHSAJmWypVPpTZ2mO1vtZWWTIBixvazZI=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v7 2/6] media: imx335: Parse fwnode properties
Date: Sun, 14 Apr 2024 19:36:17 +0530
Message-ID: <20240414140621.167717-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240414140621.167717-1-umang.jain@ideasonboard.com>
References: <20240414140621.167717-1-umang.jain@ideasonboard.com>
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



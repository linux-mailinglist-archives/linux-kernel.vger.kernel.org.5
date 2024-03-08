Return-Path: <linux-kernel+bounces-96655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB26875F90
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8D71C219EE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F563EA86;
	Fri,  8 Mar 2024 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Cqqj6Hsq"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D0121106;
	Fri,  8 Mar 2024 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709886809; cv=none; b=ksUOPHb6qGw0jortXcwvyGRfedZu41EltvumE1hnUAaSbgcTpLc7mAwHJMIAhtQa9zLDxL8nSO/PeeH1VH88094S/zqcT1eQjJr3H9E5cIvHn5N8haqfYX3CfFZovZ5kl/B+BKVPpNauX8NcjUOEFaE+CkFpkNQOJ99ajqPd09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709886809; c=relaxed/simple;
	bh=RZeoDePZ7kVp/lZIABVhzAFWmoGZZpXWjAplocxHPio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9Yt1oV7LIAxvckqW9hLmkug5xayVfSU1Sci0L3sNS1SaRR2t331vu97A0zqmKTSZZdPkZtfsNAcfWpcKJQSde/vI3dxphXNILnRaMt5cGRdCT2uzqhKtvX5SbbTCDB7PLz6MbEKV/sjpkTXf7awzfNEJWkMri7oP8S6gOGPUPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Cqqj6Hsq; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.251.226.70])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 09D6FBEB;
	Fri,  8 Mar 2024 09:33:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709886786;
	bh=RZeoDePZ7kVp/lZIABVhzAFWmoGZZpXWjAplocxHPio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cqqj6Hsqex8QWOfN+vPE2R+8Qp7YtwXZi960A7vqYdfBdiX/nYII++pXKt/hZ69TC
	 kmR05EvuYlqluM8/wh3D/WnQt+CNocAQRY+ZXUn1wFC7Ex0eappwF8XFarV6kuyI8j
	 /gwW5iVaTwPet7tu/7kxQOvPPTwNbMALh8KM4rq8=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 1/6] media: imx335: Support 2 or 4 lane operation modes
Date: Fri,  8 Mar 2024 14:03:07 +0530
Message-ID: <20240308083312.90279-2-umang.jain@ideasonboard.com>
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

The IMX335 can support both 2 and 4 lane configurations.
Extend the driver to configure the lane mode accordingly.
Update the pixel rate depending on the number of lanes in use.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index b47ec71054c3..7162b0a3cef3 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -21,6 +21,11 @@
 #define IMX335_MODE_STANDBY	0x01
 #define IMX335_MODE_STREAMING	0x00
 
+/* Data Lanes */
+#define IMX335_LANEMODE		0x3a01
+#define IMX335_2LANE		1
+#define IMX335_4LANE		3
+
 /* Lines per frame */
 #define IMX335_REG_LPFR		0x3030
 
@@ -145,6 +150,7 @@ struct imx335_mode {
  * @exp_ctrl: Pointer to exposure control
  * @again_ctrl: Pointer to analog gain control
  * @vblank: Vertical blanking in lines
+ * @lane_mode Mode for number of connected data lanes
  * @cur_mode: Pointer to current selected sensor mode
  * @mutex: Mutex for serializing sensor controls
  * @link_freq_bitmap: Menu bitmap for link_freq_ctrl
@@ -169,6 +175,7 @@ struct imx335 {
 		struct v4l2_ctrl *again_ctrl;
 	};
 	u32 vblank;
+	u32 lane_mode;
 	const struct imx335_mode *cur_mode;
 	struct mutex mutex;
 	unsigned long link_freq_bitmap;
@@ -934,6 +941,11 @@ static int imx335_start_streaming(struct imx335 *imx335)
 		return ret;
 	}
 
+	/* Configure lanes */
+	ret = imx335_write_reg(imx335, IMX335_LANEMODE, 1, imx335->lane_mode);
+	if (ret)
+		return ret;
+
 	/* Setup handler will write actual exposure and gain */
 	ret =  __v4l2_ctrl_handler_setup(imx335->sd.ctrl_handler);
 	if (ret) {
@@ -1094,7 +1106,14 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
 	if (ret)
 		return ret;
 
-	if (bus_cfg.bus.mipi_csi2.num_data_lanes != IMX335_NUM_DATA_LANES) {
+	switch (bus_cfg.bus.mipi_csi2.num_data_lanes) {
+	case 2:
+		imx335->lane_mode = IMX335_2LANE;
+		break;
+	case 4:
+		imx335->lane_mode = IMX335_4LANE;
+		break;
+	default:
 		dev_err(imx335->dev,
 			"number of CSI2 data lanes %d is not supported\n",
 			bus_cfg.bus.mipi_csi2.num_data_lanes);
-- 
2.43.0



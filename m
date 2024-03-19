Return-Path: <linux-kernel+bounces-107164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F20A87F85C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE67E282240
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B546454657;
	Tue, 19 Mar 2024 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="npK/i2L0"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EA653E28
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833250; cv=none; b=HKaYzjrhAOSxVOr2uuuujQ5EtOzQfk+GVFnmphcpQwIEs0O8jrppweG3DXRCUOzIh5Mho8XEJq3oSMYatBsSo/O2bXxSmvH6I5tMv7nTmSymqiSdV1ggNXm/YrhK8NWipND+KrkezqYZOb38GN+Tkm5Vu+FVPJK3kWHuplW8xtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833250; c=relaxed/simple;
	bh=CKkaIB1VMOnmqCrBsV70ZTXEjY9urL8LUoJA5O5CNOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwpvRNv4NMQRyWzR1HnqQEF6JBkoEd5A8+jHj5lhNMEXnsOpHInl0gDI2a0oqCkuIoGLthZa0I2yBW9+EBEi3ry/pCZBM7+8uva5+5eXQ9ea0oTgoTUsbx5VkwGsoCA+Qq8tDDTdYCst9sqUk8w1GmgrK54bVrb80FNDF4QbWK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=npK/i2L0; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.138])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3D8C6C80;
	Tue, 19 Mar 2024 08:26:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710833220;
	bh=CKkaIB1VMOnmqCrBsV70ZTXEjY9urL8LUoJA5O5CNOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=npK/i2L0CqGZpHecqJpEEJRaRxfvsgpgfm4LgyvabArFoQex9NcgYeKZpt1NwhrGa
	 WT7ia80p6LAvOJzvLlwC67gsmPTOWi6VCo04zmLsEw+l1F0+MyDzYu5l9UZwGWcDT3
	 CdTqE3hWq/vd1ape1tthBYDdvc5vdpN8w/IEGk2s=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>
Subject: [PATCH v3 1/6] media: imx335: Support 2 or 4 lane operation modes
Date: Tue, 19 Mar 2024 12:57:07 +0530
Message-ID: <20240319072712.133449-2-umang.jain@ideasonboard.com>
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

The IMX335 can support both 2 and 4 lane configurations.
Extend the driver to configure the lane mode accordingly.
Update the pixel rate depending on the number of lanes in use.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/media/i2c/imx335.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index dab6d080bc4c..c633ea1380e7 100644
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
 
@@ -147,6 +152,7 @@ struct imx335_mode {
  * @exp_ctrl: Pointer to exposure control
  * @again_ctrl: Pointer to analog gain control
  * @vblank: Vertical blanking in lines
+ * @lane_mode Mode for number of connected data lanes
  * @cur_mode: Pointer to current selected sensor mode
  * @mutex: Mutex for serializing sensor controls
  * @link_freq_bitmap: Menu bitmap for link_freq_ctrl
@@ -171,6 +177,7 @@ struct imx335 {
 		struct v4l2_ctrl *again_ctrl;
 	};
 	u32 vblank;
+	u32 lane_mode;
 	const struct imx335_mode *cur_mode;
 	struct mutex mutex;
 	unsigned long link_freq_bitmap;
@@ -936,6 +943,11 @@ static int imx335_start_streaming(struct imx335 *imx335)
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
@@ -1096,7 +1108,14 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
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



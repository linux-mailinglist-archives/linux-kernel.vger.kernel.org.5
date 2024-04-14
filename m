Return-Path: <linux-kernel+bounces-144174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C33E8A42C0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF97B1F21316
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644D556746;
	Sun, 14 Apr 2024 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RHmP/KGt"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25540537E9;
	Sun, 14 Apr 2024 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713103595; cv=none; b=uYb01crenqcedBWNX+iQcmJrXOwu8ZTjt9BjOIGsEhNhK/N4jRfs++GLMznaJxXPmSQpbmVdCjdPQDDyf49eCY155x6lW90x3lIWCejkmQm6l9q4rPmKf92c0yIQJcwmDROljftzNgk2pyqLnFEx6rdEZMs2T6VIkV0Hucll/EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713103595; c=relaxed/simple;
	bh=CKkaIB1VMOnmqCrBsV70ZTXEjY9urL8LUoJA5O5CNOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K56IWQAXpZLutcfOIPwZQtzbZVWMdWPOCBlpjp1Xd8aHHit2oREwtWWAA0mtDR/c35GGDT45xMI4XpjzJSPqMbwo2Rq5kG1pJkKc0QrLXumXf+nIRP8ZR/AysYW7xTdXm0KmRJlPGSwkjsXzkHOG0Nht82mb+pScosfqtridqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=RHmP/KGt; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.238])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4D999842;
	Sun, 14 Apr 2024 16:05:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713103547;
	bh=CKkaIB1VMOnmqCrBsV70ZTXEjY9urL8LUoJA5O5CNOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHmP/KGtOLTlUh1dNCFjskkArPYwASXE0twPU3jqSPaJOvLVJGuAIcXNgKFf4VU6k
	 L6VXdNLRNX+YN/0FlUbznlhA08y5nOurLFpJ2AT5MMsl8L/sPjP9H5eAsqZa2LyQ/6
	 Uwzdw8E3H19/b0U/yjKsNCkIq7tbx0f9fIUfGmKs=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>
Subject: [PATCH v7 1/6] media: imx335: Support 2 or 4 lane operation modes
Date: Sun, 14 Apr 2024 19:36:16 +0530
Message-ID: <20240414140621.167717-2-umang.jain@ideasonboard.com>
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



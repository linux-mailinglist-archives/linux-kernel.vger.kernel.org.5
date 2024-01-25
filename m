Return-Path: <linux-kernel+bounces-38853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0458F83C744
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D3DEB23F05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DF87CF31;
	Thu, 25 Jan 2024 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OZiRQtwq"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6797A707;
	Thu, 25 Jan 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197776; cv=none; b=a658ZMYhoV4UP8AnCs/fKQ+HqmNcKCppKE9irFdizelDIP+s4+lO2jZLaBnm9ih84F+CSrMyxvaMUuONFNpkS4ox/Ihu6ySrl8xTc48h8sTE5NsFzygLv0QTzrkQvZEvXfVMm6KIAEkl9arwv75gACykiuukflz4KxB8dD2QRrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197776; c=relaxed/simple;
	bh=W1Z5z7CyCm6OJIhlRbgJ7qn8gVztgK3gJEzxblTd6J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/R976hNReNV8NH/tN61XCIgHIj/63aDxjx8P2GIp92Jy6Tt0pJkymfG+11FiLiR/acS/+AQFkfBaOOPZEPhysg+JWabCuhc02fVRgndCBY44KD6dbjn5mEjsnY9wV30sSsEg9ER1qb+C/7u93oE3aEIgCVQ4kPMrg5rG8/le34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=OZiRQtwq; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.175])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B760951A6;
	Thu, 25 Jan 2024 16:48:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706197695;
	bh=W1Z5z7CyCm6OJIhlRbgJ7qn8gVztgK3gJEzxblTd6J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZiRQtwqP73QFH7tCmGmTedDWV1o1yIGO/87wKQ3AgVVk2nCEmP8YoZURugOc0zTa
	 b1+Y+pItMc1UrCvsmQd5mcp1AcyfT/FW6Z12Mf5LKzCjVeI9VNvhOkInPCZ1xJzXeD
	 PZTdq7DD3jacYG180ySdXqbm9iSs1ZgHB/WqhXjs=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Matthias Fend <matthias.fend@emfend.at>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 4/4] media: i2c: imx335: Add support for test pattern generator
Date: Thu, 25 Jan 2024 21:19:08 +0530
Message-ID: <20240125154908.465191-5-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240125154908.465191-1-umang.jain@ideasonboard.com>
References: <20240125154908.465191-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthias Fend <matthias.fend@emfend.at>

Add support for the sensor's test pattern generator.

Signed-off-by: Matthias Fend <matthias.fend@emfend.at>
Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 99 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index e64ee99cbae4..f9a2337a80c0 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -45,6 +45,21 @@
 /* Group hold register */
 #define IMX335_REG_HOLD		0x3001
 
+/* Test pattern generator */
+#define IMX335_REG_TPG		0x329e
+#define IMX335_TPG_ALL_000	0
+#define IMX335_TPG_ALL_FFF	1
+#define IMX335_TPG_ALL_555	2
+#define IMX335_TPG_ALL_AAA	3
+#define IMX335_TPG_TOG_555_AAA	4
+#define IMX335_TPG_TOG_AAA_555	5
+#define IMX335_TPG_TOG_000_555	6
+#define IMX335_TPG_TOG_555_000	7
+#define IMX335_TPG_TOG_000_FFF	8
+#define IMX335_TPG_TOG_FFF_000	9
+#define IMX335_TPG_H_COLOR_BARS 10
+#define IMX335_TPG_V_COLOR_BARS 11
+
 /* Input clock rate */
 #define IMX335_INCLK_RATE	24000000
 
@@ -162,6 +177,38 @@ struct imx335 {
 };
 
 
+static const char * const imx335_tpg_menu[] = {
+	"Disabled",
+	"All 000h",
+	"All FFFh",
+	"All 555h",
+	"All AAAh",
+	"Toggle 555/AAAh",
+	"Toggle AAA/555h",
+	"Toggle 000/555h",
+	"Toggle 555/000h",
+	"Toggle 000/FFFh",
+	"Toggle FFF/000h",
+	"Horizontal color bars",
+	"Vertical color bars",
+};
+
+static const int imx335_tpg_val[] = {
+	IMX335_TPG_ALL_000,
+	IMX335_TPG_ALL_000,
+	IMX335_TPG_ALL_FFF,
+	IMX335_TPG_ALL_555,
+	IMX335_TPG_ALL_AAA,
+	IMX335_TPG_TOG_555_AAA,
+	IMX335_TPG_TOG_AAA_555,
+	IMX335_TPG_TOG_000_555,
+	IMX335_TPG_TOG_555_000,
+	IMX335_TPG_TOG_000_FFF,
+	IMX335_TPG_TOG_FFF_000,
+	IMX335_TPG_H_COLOR_BARS,
+	IMX335_TPG_V_COLOR_BARS,
+};
+
 /* Sensor mode registers */
 static const struct imx335_reg mode_2592x1940_regs[] = {
 	{0x3000, 0x01},
@@ -505,6 +552,46 @@ static int imx335_update_exp_gain(struct imx335 *imx335, u32 exposure, u32 gain)
 	return ret;
 }
 
+static int imx335_update_test_pattern(struct imx335 *imx335, u32 pattern_index)
+{
+	int ret;
+
+	if (pattern_index >= ARRAY_SIZE(imx335_tpg_val))
+		return -EINVAL;
+
+	if (pattern_index) {
+		const struct imx335_reg tpg_enable_regs[] = {
+			{ 0x3148, 0x10 },
+			{ 0x3280, 0x00 },
+			{ 0x329c, 0x01 },
+			{ 0x32a0, 0x11 },
+			{ 0x3302, 0x00 },
+			{ 0x3303, 0x00 },
+			{ 0x336c, 0x00 },
+		};
+
+		ret = imx335_write_reg(imx335, IMX335_REG_TPG, 1, imx335_tpg_val[pattern_index]);
+		if (ret)
+			return ret;
+
+		ret = imx335_write_regs(imx335, tpg_enable_regs, ARRAY_SIZE(tpg_enable_regs));
+	} else {
+		const struct imx335_reg tpg_disable_regs[] = {
+			{ 0x3148, 0x00 },
+			{ 0x3280, 0x01 },
+			{ 0x329c, 0x00 },
+			{ 0x32a0, 0x10 },
+			{ 0x3302, 0x32 },
+			{ 0x3303, 0x00 },
+			{ 0x336c, 0x01 },
+		};
+
+		ret = imx335_write_regs(imx335, tpg_disable_regs, ARRAY_SIZE(tpg_disable_regs));
+	}
+
+	return ret;
+}
+
 /**
  * imx335_set_ctrl() - Set subdevice control
  * @ctrl: pointer to v4l2_ctrl structure
@@ -558,6 +645,10 @@ static int imx335_set_ctrl(struct v4l2_ctrl *ctrl)
 
 		ret = imx335_update_exp_gain(imx335, exposure, analog_gain);
 
+		break;
+	case V4L2_CID_TEST_PATTERN:
+		ret = imx335_update_test_pattern(imx335, ctrl->val);
+
 		break;
 	default:
 		dev_err(imx335->dev, "Invalid control %d\n", ctrl->id);
@@ -1122,7 +1213,7 @@ static int imx335_init_controls(struct imx335 *imx335)
 	u32 lpfr;
 	int ret;
 
-	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 6);
+	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 7);
 	if (ret)
 		return ret;
 
@@ -1156,6 +1247,12 @@ static int imx335_init_controls(struct imx335 *imx335)
 						mode->vblank_max,
 						1, mode->vblank);
 
+	v4l2_ctrl_new_std_menu_items(ctrl_hdlr,
+				     &imx335_ctrl_ops,
+				     V4L2_CID_TEST_PATTERN,
+				     ARRAY_SIZE(imx335_tpg_menu) - 1,
+				     0, 0, imx335_tpg_menu);
+
 	/* Read only controls */
 	imx335->pclk_ctrl = v4l2_ctrl_new_std(ctrl_hdlr,
 					      &imx335_ctrl_ops,
-- 
2.41.0



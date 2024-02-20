Return-Path: <linux-kernel+bounces-72698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ED085B77E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E141C24BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C35651BE;
	Tue, 20 Feb 2024 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YgpesD7J"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B469164CD0;
	Tue, 20 Feb 2024 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421322; cv=none; b=iCU+nTrz0M+jbPwiS2kj5R54K+Tdue6PZFBBmLim5s67KBmDeTZcNLJ/kNvuXlZrkyHE4IiIgxKki0QLLiJST+vkFw6ZRN2B5ZHNnrcs1niej49GwB+lCM714klBUwckkPHoYI7zs8Kvv8ub1GcNkvjJeFFMOBH2esd44wWA9eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421322; c=relaxed/simple;
	bh=kKxMnPSqYT9qIUkqI4fHrZWKiMHCC/3+G1YH1yVFWls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qG3oSZMSrlTpmHctAYWwUoLyUfdcBuiarg8Z7qQoqUNazRxtqpMznW86dbkeK8r/qezJ9WGUQs+SnjkV+q+sW0B65/GHdIhj4RgIvneEGNajjI0Y9y6VJN1xXxx5LVC/+jtInwg+RILLrsQXoqfjC8F09m1S/qXjdGB51r0Kjb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=YgpesD7J; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.159])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CC2B613AC;
	Tue, 20 Feb 2024 10:28:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708421312;
	bh=kKxMnPSqYT9qIUkqI4fHrZWKiMHCC/3+G1YH1yVFWls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YgpesD7JrKzfT8j/4eHuZlPLZr/jZfqCymfkGvlHAaEIWkUuqa4kcvvAJezCAnwGc
	 QxUYvkdKLdUSQ/a412tplw38oTRTZnKrdu4Syo4tl38CgJYON9H8opTWW/DdjUEaL9
	 CTBFvvh8fHtbbGlDAfotGfnhs4Ag7ubAIHF/+pmg=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Matthias Fend <matthias.fend@emfend.at>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v3 5/5] media: imx335: Add support for test pattern generator
Date: Tue, 20 Feb 2024 14:58:21 +0530
Message-ID: <20240220092821.1993-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220092821.1993-1-umang.jain@ideasonboard.com>
References: <20240220092821.1993-1-umang.jain@ideasonboard.com>
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
 drivers/media/i2c/imx335.c | 102 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index e2445b94cf91..dab6d080bc4c 100644
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
 	u32 cur_mbus_code;
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
@@ -507,6 +554,49 @@ static int imx335_update_exp_gain(struct imx335 *imx335, u32 exposure, u32 gain)
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
+		ret = imx335_write_reg(imx335, IMX335_REG_TPG, 1,
+				       imx335_tpg_val[pattern_index]);
+		if (ret)
+			return ret;
+
+		ret = imx335_write_regs(imx335, tpg_enable_regs,
+					ARRAY_SIZE(tpg_enable_regs));
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
+		ret = imx335_write_regs(imx335, tpg_disable_regs,
+					ARRAY_SIZE(tpg_disable_regs));
+	}
+
+	return ret;
+}
+
 /**
  * imx335_set_ctrl() - Set subdevice control
  * @ctrl: pointer to v4l2_ctrl structure
@@ -560,6 +650,10 @@ static int imx335_set_ctrl(struct v4l2_ctrl *ctrl)
 
 		ret = imx335_update_exp_gain(imx335, exposure, analog_gain);
 
+		break;
+	case V4L2_CID_TEST_PATTERN:
+		ret = imx335_update_test_pattern(imx335, ctrl->val);
+
 		break;
 	default:
 		dev_err(imx335->dev, "Invalid control %d\n", ctrl->id);
@@ -1117,7 +1211,7 @@ static int imx335_init_controls(struct imx335 *imx335)
 	u32 lpfr;
 	int ret;
 
-	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 6);
+	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 7);
 	if (ret)
 		return ret;
 
@@ -1151,6 +1245,12 @@ static int imx335_init_controls(struct imx335 *imx335)
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
2.43.0



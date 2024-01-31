Return-Path: <linux-kernel+bounces-45795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD2A84364E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A2A1F281E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0A746420;
	Wed, 31 Jan 2024 05:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VbhW2nqf"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8439541766;
	Wed, 31 Jan 2024 05:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680355; cv=none; b=ot1fQHholw1LRkDJ0MnOn3mxzJAMhI+IIPAs7c9gwnv7Djgy8NTU8C2wDWlhLa25+m4Ln8vb5BZWv8LC53Q905fgYz7M0HjyPkmxfW3iEojFdtjXK3IspiDPI4dUyFT3/iKn/C2zzZLy/0ZAUooheNsGqr7PMGY1tthrdWGWYwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680355; c=relaxed/simple;
	bh=yXS+KNTgFczxaukcxvwvOc9qcDyw663NWCmbbQpW/j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU70tMfBm3uBorYBIuEYG3CUjeJjysWsPV1JytsKV4+gt8LTj54LK8TM8TnAEb3A8ifo4BQ+HusllnICCngAG0ZYEFz8btqbR1pQr1R2f8JCmhIDsxVi3oQFuAAzjlzT4v5mrjdPjaD739oErel1FG/0CBuSmsy58eltmHqAw5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=VbhW2nqf; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.Jain (unknown [103.86.18.206])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 91DBA6057;
	Wed, 31 Jan 2024 06:51:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706680268;
	bh=yXS+KNTgFczxaukcxvwvOc9qcDyw663NWCmbbQpW/j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VbhW2nqfiEHQA4Ml3Yad1FAvJLC/072RJWw073uZMtLOv0RvJ8nBMSlBSwlQw2PVi
	 f7TwLNjw1XwiLPwMSaXuuR608GMkQpNu8YE7qnISmtTinCVBftvkLFnRSVBJHYAW1m
	 LDtL8Bt1Zs87NHp9Yo9ffcXGFlJbqBxlK97kUcoE=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Matthias Fend <matthias.fend@emfend.at>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 5/5] media: i2c: imx335: Add support for test pattern generator
Date: Wed, 31 Jan 2024 11:22:08 +0530
Message-ID: <20240131055208.170934-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240131055208.170934-1-umang.jain@ideasonboard.com>
References: <20240131055208.170934-1-umang.jain@ideasonboard.com>
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
index 250b7136048d..a003da8a81b1 100644
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
@@ -506,6 +553,49 @@ static int imx335_update_exp_gain(struct imx335 *imx335, u32 exposure, u32 gain)
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
@@ -559,6 +649,10 @@ static int imx335_set_ctrl(struct v4l2_ctrl *ctrl)
 
 		ret = imx335_update_exp_gain(imx335, exposure, analog_gain);
 
+		break;
+	case V4L2_CID_TEST_PATTERN:
+		ret = imx335_update_test_pattern(imx335, ctrl->val);
+
 		break;
 	default:
 		dev_err(imx335->dev, "Invalid control %d\n", ctrl->id);
@@ -1116,7 +1210,7 @@ static int imx335_init_controls(struct imx335 *imx335)
 	u32 lpfr;
 	int ret;
 
-	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 6);
+	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 7);
 	if (ret)
 		return ret;
 
@@ -1150,6 +1244,12 @@ static int imx335_init_controls(struct imx335 *imx335)
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



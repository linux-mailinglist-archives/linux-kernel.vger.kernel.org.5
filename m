Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F5680D49C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbjLKRvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345206AbjLKRvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:51:31 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397B793;
        Mon, 11 Dec 2023 09:51:08 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bf8843a6fso4723550e87.0;
        Mon, 11 Dec 2023 09:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317065; x=1702921865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/C0YbxXisOYuGkb4hmqJPNMzEyl5yI/OtRTBBpCRGRE=;
        b=nR1cUa+6WZo2E9ss+pRTKFpsiycvFZyTfqS5Yh1E5F2yT+Lnx5Gyh9f/q29dTHnGSd
         g1zShF9IYc0Vp+LDreFI8rXOh55R7lrR0PBwR/ZrkI/lcZRokIIDih4qRe1EAbJbTe+G
         mZnJSPawgcFMWTuvgCtZpOrTt6qy3DsrrxeD0JYU0hoV3S/dBSQxYfL1E2JotM7Cyc4Y
         gleyvONvuJErwOUIg0/K3MpZ81TBFGPslzr3Q5VeYTSqS9h2ZNWnx42QLWJ2zJaXIL8B
         RGr8dgu/tp0moqlBRZZWqM/62vSgOGRuBvRhSZOVcxt6f/AaaVnpBp2Ua5Xpf3HbJ7vd
         zm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317065; x=1702921865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/C0YbxXisOYuGkb4hmqJPNMzEyl5yI/OtRTBBpCRGRE=;
        b=ojtILzkw5K7Gr87ykYJxfzNsRu47tfnOoT6T7rzC1Y5o2mm2jES3INsPswMc9d0bZA
         0fYpJwsXLL2tiIW39XgHtai1hjjAQrSoUDabhzXquFKCp2N/0aM6Yuq5LpFC6PFU2OMb
         kp2CZ2tu6RA5nMwIGLpDcp7O1IBSQxGqE8c8XciseSYd32IrtBrdSSA+i7gae/b8Jrug
         M8UP3Dm4j/nm5JZUbb6Vi3XFv+/ZXFu0mwM5niuX7V6hIC8z67CeUgIJGBapkx2NH+rd
         8RvbU+UsjzBrxRTmkI0kJohNLu1SYJpPfCeKaXd+6lzmQqF5eFzdpuGFaxEzYsBRONjp
         uYuQ==
X-Gm-Message-State: AOJu0YxAuCgpZwMdMmL+yEBb4ANXpqMlgG9bwRJXxWvTyDDa9uO5vfM8
        hzF1twTu6j/mkR9zPI763Cs3SWk8s45+yMQX
X-Google-Smtp-Source: AGHT+IH/WwveD5m32+W0pb29xLp3NW32L7ZcSid1R5ABHEAu3lehqPxBav3DaWHPLLjNoAaKNq9CFg==
X-Received: by 2002:ac2:4e0a:0:b0:50b:cafc:bd70 with SMTP id e10-20020ac24e0a000000b0050bcafcbd70mr4285598lfr.0.1702317065101;
        Mon, 11 Dec 2023 09:51:05 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id m21-20020a0565120a9500b0050d1d8674d2sm722733lfu.292.2023.12.11.09.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:51:04 -0800 (PST)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH 17/19] media: i2c: ov4689: Eliminate struct ov4689_mode
Date:   Mon, 11 Dec 2023 20:50:20 +0300
Message-ID: <20231211175023.1680247-18-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211175023.1680247-1-mike.rudenko@gmail.com>
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the output frame size now controlled by selection rather than
cur_mode, this commit relocates pixel rate and default VTS to
defines. Consequently, it removes struct ov4689_mode and the cur_mode
field from struct ov4689.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 70 +++++++++-----------------------------
 1 file changed, 17 insertions(+), 53 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index f3071e661f4a..e21527ae0b10 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -67,6 +67,8 @@
 #define OV4689_REG_V_WIN_OFF		CCI_REG16(0x3812)
 
 #define OV4689_REG_VTS			CCI_REG16(0x380e)
+/* Default VTS corresponds to 30 fps at default crop and minimal HTS */
+#define OV4689_VTS_DEF			4683
 #define OV4689_VTS_MAX			0x7fff
 
 #define OV4689_REG_HTS			CCI_REG16(0x380c)
@@ -94,6 +96,7 @@
 
 #define OV4689_LANES			4
 #define OV4689_XVCLK_FREQ		24000000
+#define OV4689_PIXEL_RATE		480000000
 
 #define OV4689_PIXEL_ARRAY_WIDTH	2720
 #define OV4689_PIXEL_ARRAY_HEIGHT	1536
@@ -119,24 +122,6 @@ static const char *const ov4689_supply_names[] = {
 	"dvdd", /* Digital core power */
 };
 
-enum ov4689_mode_id {
-	OV4689_MODE_2688_1520 = 0,
-	OV4689_NUM_MODES,
-};
-
-struct ov4689_mode {
-	enum ov4689_mode_id id;
-	u32 width;
-	u32 height;
-	u32 hts_def;
-	u32 hts_min;
-	u32 vts_def;
-	u32 exp_def;
-	u32 pixel_rate;
-	const struct cci_reg_sequence *reg_list;
-	unsigned int num_regs;
-};
-
 struct ov4689 {
 	struct device *dev;
 	struct regmap *regmap;
@@ -152,8 +137,6 @@ struct ov4689 {
 
 	struct v4l2_ctrl_handler ctrl_handler;
 	struct v4l2_ctrl *exposure, *hblank, *vblank;
-
-	const struct ov4689_mode *cur_mode;
 };
 
 #define to_ov4689(sd) container_of(sd, struct ov4689, subdev)
@@ -172,7 +155,7 @@ struct ov4689_gain_range {
  * max_framerate 90fps
  * mipi_datarate per lane 1008Mbps
  */
-static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
+static const struct cci_reg_sequence ov4689_common_regs[] = {
 	/* System control*/
 	{CCI_REG8(0x0103), 0x01}, /* SC_CTRL0103 software_reset = 1 */
 	{CCI_REG8(0x3000), 0x20}, /* SC_CMMN_PAD_OEN0 FSIN_output_enable = 1 */
@@ -273,21 +256,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
 	{CCI_REG8(0x5503), 0x0f}, /* OTP_DPC_END_L otp_end_address[7:0] = 0x0f */
 };
 
-static const struct ov4689_mode supported_modes[] = {
-	{
-		.id = OV4689_MODE_2688_1520,
-		.width = 2688,
-		.height = 1520,
-		.exp_def = 1536,
-		.hts_def = 10296,
-		.hts_min = 3432,
-		.vts_def = 1554,
-		.pixel_rate = 480000000,
-		.reg_list = ov4689_2688x1520_regs,
-		.num_regs = ARRAY_SIZE(ov4689_2688x1520_regs),
-	},
-};
-
 static const u64 link_freq_menu_items[] = { 504000000 };
 
 static const char *const ov4689_test_pattern_menu[] = {
@@ -584,8 +552,8 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 			goto unlock_and_return;
 
 		ret = cci_multi_reg_write(ov4689->regmap,
-					  ov4689->cur_mode->reg_list,
-					  ov4689->cur_mode->num_regs,
+					  ov4689_common_regs,
+					  ARRAY_SIZE(ov4689_common_regs),
 					  NULL);
 		if (ret) {
 			pm_runtime_put(dev);
@@ -858,14 +826,12 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 	struct i2c_client *client = v4l2_get_subdevdata(&ov4689->subdev);
 	struct v4l2_fwnode_device_properties props;
 	struct v4l2_ctrl_handler *handler;
-	const struct ov4689_mode *mode;
 	s64 exposure_max, vblank_def;
-	s64 hblank_def, hblank_min;
 	struct v4l2_ctrl *ctrl;
+	s64 hblank_def;
 	int ret;
 
 	handler = &ov4689->ctrl_handler;
-	mode = ov4689->cur_mode;
 	ret = v4l2_ctrl_handler_init(handler, 16);
 	if (ret)
 		return ret;
@@ -876,26 +842,26 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 		ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
 	v4l2_ctrl_new_std(handler, NULL, V4L2_CID_PIXEL_RATE, 0,
-			  mode->pixel_rate, 1, mode->pixel_rate);
+			  OV4689_PIXEL_RATE, 1, OV4689_PIXEL_RATE);
 
-	hblank_def = mode->hts_def - mode->width;
-	hblank_min = mode->hts_min - mode->width;
+	hblank_def = ov4689_hts_min(OV4689_H_OUTPUT_SIZE_DEFAULT) -
+		     OV4689_H_OUTPUT_SIZE_DEFAULT;
 	ov4689->hblank = v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops,
-					   V4L2_CID_HBLANK, hblank_min,
-					   OV4689_HTS_MAX - mode->width,
+					   V4L2_CID_HBLANK, hblank_def,
+					   OV4689_HTS_MAX - OV4689_H_OUTPUT_SIZE_DEFAULT,
 					   OV4689_HTS_DIVIDER, hblank_def);
 
-	vblank_def = mode->vts_def - mode->height;
+	vblank_def = OV4689_VTS_DEF - OV4689_V_OUTPUT_SIZE_DEFAULT;
 	ov4689->vblank = v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops,
 					   V4L2_CID_VBLANK, OV4689_VBLANK_MIN,
-					   OV4689_VTS_MAX - mode->height, 1,
-					   vblank_def);
+					   OV4689_VTS_MAX - OV4689_V_OUTPUT_SIZE_DEFAULT,
+					   1, vblank_def);
 
-	exposure_max = mode->vts_def - 4;
+	exposure_max = OV4689_VTS_DEF - 4;
 	ov4689->exposure =
 		v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_EXPOSURE,
 				  OV4689_EXPOSURE_MIN, exposure_max,
-				  OV4689_EXPOSURE_STEP, mode->exp_def);
+				  OV4689_EXPOSURE_STEP, exposure_max);
 
 	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_ANALOGUE_GAIN,
 			  ov4689_gain_ranges[0].logical_min,
@@ -1050,8 +1016,6 @@ static int ov4689_probe(struct i2c_client *client)
 
 	ov4689->dev = dev;
 
-	ov4689->cur_mode = &supported_modes[OV4689_MODE_2688_1520];
-
 	ov4689->xvclk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(ov4689->xvclk))
 		return dev_err_probe(dev, PTR_ERR(ov4689->xvclk),
-- 
2.43.0


Return-Path: <linux-kernel+bounces-128385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B3D895A27
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED58C282AF1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516D215E206;
	Tue,  2 Apr 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWE2aReu"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB315DBA7;
	Tue,  2 Apr 2024 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076413; cv=none; b=KYndcjNHhJjV89JsqEmvw3SOMM6mD0+FH4FvBDS31+V2XIK77obn2IfHoK8HaWq5QRPAoEO5TfzJmOkUFQEo0ZC9ZK/FA4Julabe7DBU497otdPz8Z6L35b5MwzSZZIYJxd2ZSJTZFKDgBxQhs9HC/R2bsGfBnNhICoSIZPdTB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076413; c=relaxed/simple;
	bh=1f6gojjb+INwJL2QHcPec+kq5x9ig7XnPzFAKtUV1r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ni5d4lrz3wkGhoZS/l+3H3mxE9O3WkZsY5A2y/nzpwCDYpZxMXaoEwbqWOBmhCE0SnnPmA8J91JtQC0erdboqrhyLqK17yVdrXTuL7BoXRGOyA/PJSAcSgEFLc5cRYgN7CKMz2SoY9gLqk0vubc6lSkTC1OEY3Dr+COBwLK4+20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWE2aReu; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513d3746950so6711882e87.1;
        Tue, 02 Apr 2024 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076406; x=1712681206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZcGbp/aSjT4uCKduFFi6iHXwPLpORW7vzFz6wh+mo0=;
        b=KWE2aReuSTN0hLCk7vAmxHNyw20mEoRt2ccL2QAYWoBBJLVZCt2/n1mluVz7Jkp4MS
         7cT+OL8VhWNqwPfcj7NKhUPXjec/smSb0CjmVzxkreOWfQituEnKwPH95fOSFJNLHD1W
         kWWGHpKfHCus4kkRBBBohyXjjOB1N2p8z1Z9j3fGm26C/Yg/3LwkyHRsH0FZrNBCt8wh
         KRnOdSpfEjNuxyCVFEDh5Ou6DOsLX9YIuy4Jn7RzoNveI3lBkgAcuTdUQVEH+RBsDnnX
         L2kXn9STnrCCZC4WWo5fuDdrFUAdtAZ+BBLWKPWPc7lD9z7tkuEtfnMNWryhBol3L9lt
         LSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076406; x=1712681206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZcGbp/aSjT4uCKduFFi6iHXwPLpORW7vzFz6wh+mo0=;
        b=EpFTDaiirV+z7KrHzPD0lvkdCiEsbHAX1tN5u99r7yIo7uC019SzjUF/8vQMuv+3Eo
         E24NmSdg3b4ohvqCXkYRDplLyycYoubY5UlfR6cVyVDdE+MOWHTrIToTt5eKMvOgdlsl
         i/vzU+iIz/V/h1LEttB11E7g8lhs/zB+cfLo4JN0J+BKDiyZZ7soH0BRwBRREJfxrQBO
         +sQVb1qpR/69pXARFT5yhFF6arJFA2YnYF4ncqVnrtnN6erIyygIJnE8mSmwaNTW55LR
         aeSD1NpDMrwPMzbnQj5tS20bZR4nVTG6jwC9GZ/4PU8zH1aIDYuZ9MkWz1vFfLfokZgz
         ibwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ0wlnRIMIVuX6ouvhhLdlUSkY9VxsRuWOWsJHUTWNu1MT9wtIJqsCbWme/nwksm7gVFpEQl7enVQeN5oM/+Z3chX1VYBSuULEYnB6
X-Gm-Message-State: AOJu0YxfApbNuk7etyRkxjzif6EqaUBK483wgCkExo4FImWGrJV9XdTF
	cUuiLnPMUqoOVBXRY7h0711ZlHsVFcnNP6uZL4pyGKWf+3RaDq9wZpgKvXw7T6x54w==
X-Google-Smtp-Source: AGHT+IEtrZh2mFnIUuU+XSzqNppFq14eqhyrePXus6hReJe6vEN6uD9EcVhC7wqZlq4E/+NlJkfTng==
X-Received: by 2002:a05:6512:3d0e:b0:515:d335:a0ab with SMTP id d14-20020a0565123d0e00b00515d335a0abmr10029956lfv.37.1712076406244;
        Tue, 02 Apr 2024 09:46:46 -0700 (PDT)
Received: from localhost ([77.91.78.25])
        by smtp.gmail.com with ESMTPSA id v6-20020ac25b06000000b00515a79f0cd0sm1754324lfn.82.2024.04.02.09.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:46:45 -0700 (PDT)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH v4 18/20] media: i2c: ov4689: Eliminate struct ov4689_mode
Date: Tue,  2 Apr 2024 19:45:49 +0300
Message-ID: <20240402164552.19171-19-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402164552.19171-1-mike.rudenko@gmail.com>
References: <20240402164552.19171-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the output frame size now controlled by selection rather than
cur_mode, this commit relocates pixel rate and default VTS to
defines. Consequently, it removes struct ov4689_mode and the cur_mode
field from struct ov4689.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 70 +++++++++-----------------------------
 1 file changed, 17 insertions(+), 53 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index f25bc260dde2..f43be255234b 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -57,6 +57,8 @@
 #define OV4689_HTS_MAX			0x7fff
 
 #define OV4689_REG_VTS			CCI_REG16(0x380e)
+/* Default VTS corresponds to 30 fps at default crop and minimal HTS */
+#define OV4689_VTS_DEF			4683
 #define OV4689_VTS_MAX			0x7fff
 
 #define OV4689_REG_H_WIN_OFF		CCI_REG16(0x3810)
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
@@ -863,14 +831,12 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
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
 	ret = v4l2_ctrl_handler_init(handler, 15);
 	if (ret)
 		return ret;
@@ -881,26 +847,26 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
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
@@ -1055,8 +1021,6 @@ static int ov4689_probe(struct i2c_client *client)
 
 	ov4689->dev = dev;
 
-	ov4689->cur_mode = &supported_modes[OV4689_MODE_2688_1520];
-
 	ov4689->xvclk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(ov4689->xvclk))
 		return dev_err_probe(dev, PTR_ERR(ov4689->xvclk),
-- 
2.44.0



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4435F80D4A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345237AbjLKRwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjLKRvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:51:44 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CE3F4;
        Mon, 11 Dec 2023 09:51:11 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ca09601127so63403581fa.1;
        Mon, 11 Dec 2023 09:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317068; x=1702921868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnEjGpYqb0K7tittd+dUy5/SHqg4UXSF+hRs5s4lNiU=;
        b=V0NTn7AegTR/N6P6knaLaKJSPKAMjGSD9R1rHHZjFwKA1xefdr1R4tUO/VY4Z9sBJ9
         OTsIWgtHVmADErnl4e2CXLzjgKPf4fuGk7ZHYt5WBH3j3lWGL2/V2soCMOlyZhDZ0uY6
         Dz/tU4Z03wSEinBBjKzMwu6+CLviB6KwNieKvBmYH/hyzXOPO1JaXlSKDNjZpC2ftUtD
         X3FJIbBT2t3OF0MwTQCOYxa56EZVES0ahPNKGqzeQFTBoOlJ5WIN209kkP4J1EDllUAW
         x2juxzbKIT4bcurTWov+v+9DTeNMiq6WgRJIBvOZO/+wByq2FFCoHzHbReKuc+M5Qc9N
         TgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317068; x=1702921868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnEjGpYqb0K7tittd+dUy5/SHqg4UXSF+hRs5s4lNiU=;
        b=Tg7Be8UQjCnKqbfy86tehPsi3XNAdCNCMLyk+Wck3lIe4T49IZx1KwiH067S8roa1j
         OVkgUF960cxWO/6T4hiyFuJwFdAV6VtI0QlQeWQLmx6WqTDjCmCf9fxJKtiGPRFouTve
         T3BGQOU8PA1D9AuIcx4bC+U3Fraew+tCzDYqg4LhxB0bYWx3pLuZVt8EobU3+p1cUiJs
         II7DdjExU07RF2JW0zuTASARh1nR7z/rVG3ZQSuu43IIWWbk1Q8U/Yug450kSm8/Pl+d
         t/Y9dWp/8JaA0wl7TgfQLk9Js6u59hGt6+MgNajavnp/KabnQmt/EsXb3tf3O23Rz+ML
         7RyQ==
X-Gm-Message-State: AOJu0Yw5FW5VNcLmM+9ZdiyvsVzVZc1vTDn/B3UEAAaH3Jg0wQyVR+8e
        tIk+ypQK2AlT9azCE8ovqFaDUUmfmpuqjK7D
X-Google-Smtp-Source: AGHT+IEIxjIusrdZxXE48QL3l6bFqRK3VBhCxRbV7yzFOcXCv5oMcUbay46/rhcadR9x/dv7hp8pNg==
X-Received: by 2002:a2e:a585:0:b0:2cc:1d21:80a0 with SMTP id m5-20020a2ea585000000b002cc1d2180a0mr1257989ljp.107.1702317068111;
        Mon, 11 Dec 2023 09:51:08 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id p7-20020a2e9a87000000b002cc238645aesm303879lji.61.2023.12.11.09.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:51:07 -0800 (PST)
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
Subject: [PATCH 19/19] media: i2c: ov4689: Implement 2x2 binning
Date:   Mon, 11 Dec 2023 20:50:22 +0300
Message-ID: <20231211175023.1680247-20-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211175023.1680247-1-mike.rudenko@gmail.com>
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement 2x2 binning support. Compute best binning mode (none or 2x2)
from pad crop and pad format in ov4689_set_fmt. Use output frame size
instead of analogue crop to compute control ranges and BLC anchors.

Also move ov4689_hts_min and ov4689_update_ctrl_ranges, since they are
now also called from ov4689_set_fmt. Update frame timings to
accommodate the requirements of binning mode and avoid visual
artefacts. Additionally, report 2x2 binned mode in addition to
non-binned one in ov4689_enum_frame_sizes.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 192 +++++++++++++++++++++++++------------
 1 file changed, 130 insertions(+), 62 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 034bd9077a3a..2967fbfb81e4 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -114,7 +114,7 @@
  * Minimum working vertical blanking value. Found experimentally at
  * minimum HTS values.
  */
-#define OV4689_VBLANK_MIN		31
+#define OV4689_VBLANK_MIN		35
 
 static const char *const ov4689_supply_names[] = {
 	"avdd", /* Analog power */
@@ -256,6 +256,18 @@ static const struct cci_reg_sequence ov4689_common_regs[] = {
 	{CCI_REG8(0x5503), 0x0f}, /* OTP_DPC_END_L otp_end_address[7:0] = 0x0f */
 };
 
+static const struct cci_reg_sequence ov4689_2x2_binning_regs[] = {
+	{CCI_REG8(0x3632), 0x05}, /* ADC */
+	{CCI_REG8(0x376b), 0x40}, /* Sensor control */
+	{CCI_REG8(0x3814), 0x03}, /* H_INC_ODD */
+	{CCI_REG8(0x3821), 0x07}, /* TIMING_FORMAT_2 hor_binning = 1*/
+	{CCI_REG8(0x382a), 0x03}, /* V_INC_ODD */
+	{CCI_REG8(0x3830), 0x08}, /* BLC_NUM_OPTION blc_use_num_2 = 1 */
+	{CCI_REG8(0x3836), 0x02}, /* TIMING_REG_36 r_zline_use_num_2 = 1 */
+	{CCI_REG8(0x4001), 0x50}, /* BLC DEBUG MODE */
+	{CCI_REG8(0x4502), 0x44}, /* ADC synch control*/
+};
+
 static const u64 link_freq_menu_items[] = { 504000000 };
 
 static const char *const ov4689_test_pattern_menu[] = {
@@ -305,18 +317,96 @@ static const struct ov4689_gain_range ov4689_gain_ranges[] = {
 	},
 };
 
+/*
+ * For now, only 2x2 binning implemented in this driver.
+ */
+static int ov4689_best_binning(struct ov4689 *ov4689,
+			       const struct v4l2_mbus_framefmt *format,
+			       const struct v4l2_rect *crop,
+			       unsigned int *binning)
+{
+	const struct v4l2_area candidates[] = {
+		{ crop->width, crop->height },
+		{ crop->width / 2, crop->height / 2 },
+	};
+
+	const struct v4l2_area *best;
+	int index;
+
+	best = v4l2_find_nearest_size(candidates, ARRAY_SIZE(candidates), width,
+				      height, format->width, format->height);
+	if (!best) {
+		dev_err(ov4689->dev,
+			"failed to find best binning for requested mode\n");
+		return -EINVAL;
+	}
+
+	index = best - candidates;
+	*binning = index + 1;
+
+	dev_dbg(ov4689->dev,
+		"best_binning: crop=%dx%d format=%dx%d binning=%d\n",
+		crop->width, crop->height, format->width, format->height,
+		*binning);
+
+	return 0;
+}
+
+/*
+ * Minimum working HTS value for given output width (found
+ * experimentally).
+ */
+static unsigned int ov4689_hts_min(unsigned int width)
+{
+	return max_t(unsigned int, 3156, 224 + width * 19 / 16);
+}
+
+static void ov4689_update_ctrl_ranges(struct ov4689 *ov4689, unsigned int width,
+				      unsigned int height)
+{
+	struct v4l2_ctrl *exposure = ov4689->exposure;
+	struct v4l2_ctrl *vblank = ov4689->vblank;
+	struct v4l2_ctrl *hblank = ov4689->hblank;
+	s64 def_val, min_val, max_val;
+
+	min_val = ov4689_hts_min(width) - width;
+	max_val = OV4689_HTS_MAX - width;
+	def_val = clamp_t(s64, hblank->default_value, min_val, max_val);
+	__v4l2_ctrl_modify_range(hblank, min_val, max_val, hblank->step,
+				 def_val);
+
+	min_val = OV4689_VBLANK_MIN;
+	max_val = OV4689_HTS_MAX - width;
+	def_val = clamp_t(s64, vblank->default_value, min_val, max_val);
+	__v4l2_ctrl_modify_range(vblank, min_val, max_val, vblank->step,
+				 def_val);
+
+	min_val = exposure->minimum;
+	max_val = height + vblank->val - 4;
+	def_val = clamp_t(s64, exposure->default_value, min_val, max_val);
+	__v4l2_ctrl_modify_range(exposure, min_val, max_val, exposure->step,
+				 def_val);
+}
+
 static int ov4689_set_fmt(struct v4l2_subdev *sd,
 			  struct v4l2_subdev_state *sd_state,
 			  struct v4l2_subdev_format *fmt)
 {
+	struct ov4689 *ov4689 = to_ov4689(sd);
 	struct v4l2_mbus_framefmt *format;
 	struct v4l2_rect *crop;
+	unsigned int binning;
+	int ret;
 
 	crop = v4l2_subdev_state_get_crop(sd_state, fmt->pad);
 	format = v4l2_subdev_state_get_format(sd_state, fmt->pad);
 
-	format->width = crop->width;
-	format->height = crop->height;
+	ret = ov4689_best_binning(ov4689, &fmt->format, crop, &binning);
+	if (ret)
+		return ret;
+
+	format->width = crop->width / binning;
+	format->height = crop->height / binning;
 
 	format->code = MEDIA_BUS_FMT_SBGGR10_1X10;
 	format->field = V4L2_FIELD_NONE;
@@ -327,6 +417,9 @@ static int ov4689_set_fmt(struct v4l2_subdev *sd,
 
 	fmt->format = *format;
 
+	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE)
+		ov4689_update_ctrl_ranges(ov4689, format->width, format->height);
+
 	return 0;
 }
 
@@ -346,8 +439,9 @@ static int ov4689_enum_frame_sizes(struct v4l2_subdev *sd,
 				   struct v4l2_subdev_frame_size_enum *fse)
 {
 	const struct v4l2_rect *crop;
+	int binning;
 
-	if (fse->index >= 1)
+	if (fse->index >= 2)
 		return -EINVAL;
 
 	if (fse->code != MEDIA_BUS_FMT_SBGGR10_1X10)
@@ -355,10 +449,11 @@ static int ov4689_enum_frame_sizes(struct v4l2_subdev *sd,
 
 	crop = v4l2_subdev_state_get_crop(sd_state, 0);
 
-	fse->min_width = crop->width;
-	fse->max_width = crop->width;
-	fse->max_height = crop->height;
-	fse->min_height = crop->height;
+	binning = fse->index + 1;
+	fse->min_width = crop->width / binning;
+	fse->max_width = crop->width / binning;
+	fse->max_height = crop->height / binning;
+	fse->min_height = crop->height / binning;
 
 	return 0;
 }
@@ -398,42 +493,6 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
 	return -EINVAL;
 }
 
-/*
- * Minimum working HTS value for given output width (found
- * experimentally).
- */
-static unsigned int ov4689_hts_min(unsigned int width)
-{
-	return max_t(unsigned int, 3156, 224 + width * 19 / 16);
-}
-
-static void ov4689_update_ctrl_ranges(struct ov4689 *ov4689,
-				      struct v4l2_rect *crop)
-{
-	struct v4l2_ctrl *exposure = ov4689->exposure;
-	struct v4l2_ctrl *vblank = ov4689->vblank;
-	struct v4l2_ctrl *hblank = ov4689->hblank;
-	s64 def_val, min_val, max_val;
-
-	min_val = ov4689_hts_min(crop->width) - crop->width;
-	max_val = OV4689_HTS_MAX - crop->width;
-	def_val = clamp_t(s64, hblank->default_value, min_val, max_val);
-	__v4l2_ctrl_modify_range(hblank, min_val, max_val, hblank->step,
-				 def_val);
-
-	min_val = OV4689_VBLANK_MIN;
-	max_val = OV4689_HTS_MAX - crop->width;
-	def_val = clamp_t(s64, vblank->default_value, min_val, max_val);
-	__v4l2_ctrl_modify_range(vblank, min_val, max_val, vblank->step,
-				 def_val);
-
-	min_val = exposure->minimum;
-	max_val = crop->height + vblank->val - 4;
-	def_val = clamp_t(s64, exposure->default_value, min_val, max_val);
-	__v4l2_ctrl_modify_range(exposure, min_val, max_val, exposure->step,
-				 def_val);
-}
-
 static int ov4689_set_selection(struct v4l2_subdev *sd,
 				struct v4l2_subdev_state *state,
 				struct v4l2_subdev_selection *sel)
@@ -470,7 +529,8 @@ static int ov4689_set_selection(struct v4l2_subdev *sd,
 		format->height = rect.height;
 
 		if (sel->which == V4L2_SUBDEV_FORMAT_ACTIVE)
-			ov4689_update_ctrl_ranges(ov4689, &rect);
+			ov4689_update_ctrl_ranges(ov4689, rect.width,
+						  rect.height);
 	}
 
 	*crop = rect;
@@ -485,21 +545,27 @@ static int ov4689_setup_timings(struct ov4689 *ov4689,
 	const struct v4l2_mbus_framefmt *format;
 	struct regmap *rm = ov4689->regmap;
 	const struct v4l2_rect *crop;
+	const int v_offset = 2;
+	unsigned int binning;
 	int ret = 0;
 
 	format = v4l2_subdev_state_get_format(state, 0);
 	crop = v4l2_subdev_state_get_crop(state, 0);
 
+	ret = ov4689_best_binning(ov4689, format, crop, &binning);
+	if (ret)
+		return ret;
+
 	cci_write(rm, OV4689_REG_H_CROP_START, crop->left, &ret);
-	cci_write(rm, OV4689_REG_V_CROP_START, crop->top, &ret);
-	cci_write(rm, OV4689_REG_H_CROP_END, crop->left + crop->width + 1, &ret);
-	cci_write(rm, OV4689_REG_V_CROP_END, crop->top + crop->height + 1, &ret);
+	cci_write(rm, OV4689_REG_V_CROP_START, crop->top - v_offset, &ret);
+	cci_write(rm, OV4689_REG_H_CROP_END, crop->left + crop->width + 3, &ret);
+	cci_write(rm, OV4689_REG_V_CROP_END, crop->top + crop->height + 7, &ret);
 
 	cci_write(rm, OV4689_REG_H_OUTPUT_SIZE, format->width, &ret);
 	cci_write(rm, OV4689_REG_V_OUTPUT_SIZE, format->height, &ret);
 
 	cci_write(rm, OV4689_REG_H_WIN_OFF, 0, &ret);
-	cci_write(rm, OV4689_REG_V_WIN_OFF, 0, &ret);
+	cci_write(rm, OV4689_REG_V_WIN_OFF, v_offset, &ret);
 
 	/*
 	 * Maximum working value of vfifo_read_start for given output
@@ -507,6 +573,10 @@ static int ov4689_setup_timings(struct ov4689 *ov4689,
 	 */
 	cci_write(rm, OV4689_REG_VFIFO_CTRL_01, format->width / 16 - 1, &ret);
 
+	if (binning == 2)
+		cci_multi_reg_write(ov4689->regmap, ov4689_2x2_binning_regs,
+				    ARRAY_SIZE(ov4689_2x2_binning_regs),
+				    &ret);
 	return ret;
 }
 
@@ -519,20 +589,20 @@ static int ov4689_setup_blc_anchors(struct ov4689 *ov4689,
 				    struct v4l2_subdev_state *state)
 {
 	unsigned int width_def = OV4689_H_OUTPUT_SIZE_DEFAULT;
+	const struct v4l2_mbus_framefmt *format;
 	struct regmap *rm = ov4689->regmap;
-	const struct v4l2_rect *crop;
 	int ret = 0;
 
-	crop = v4l2_subdev_state_get_crop(state, 0);
+	format = v4l2_subdev_state_get_format(state, 0);
 
 	cci_write(rm, OV4689_REG_ANCHOR_LEFT_START,
-		  OV4689_ANCHOR_LEFT_START_DEF * crop->width / width_def, &ret);
+		  OV4689_ANCHOR_LEFT_START_DEF * format->width / width_def, &ret);
 	cci_write(rm, OV4689_REG_ANCHOR_LEFT_END,
-		  OV4689_ANCHOR_LEFT_END_DEF * crop->width / width_def, &ret);
+		  OV4689_ANCHOR_LEFT_END_DEF * format->width / width_def, &ret);
 	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_START,
-		  OV4689_ANCHOR_RIGHT_START_DEF * crop->width / width_def, &ret);
+		  OV4689_ANCHOR_RIGHT_START_DEF * format->width / width_def, &ret);
 	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_END,
-		  OV4689_ANCHOR_RIGHT_END_DEF * crop->width / width_def, &ret);
+		  OV4689_ANCHOR_RIGHT_END_DEF * format->width / width_def, &ret);
 
 	return ret;
 }
@@ -730,20 +800,20 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 	struct regmap *regmap = ov4689->regmap;
 	struct v4l2_subdev_state *sd_state;
 	struct device *dev = ov4689->dev;
-	struct v4l2_rect *crop;
+	struct v4l2_mbus_framefmt *fmt;
 	s32 val = ctrl->val;
 	int sensor_gain;
 	s64 max_expo, def_expo;
 	int ret;
 
 	sd_state = v4l2_subdev_get_locked_active_state(&ov4689->subdev);
-	crop = v4l2_subdev_state_get_crop(sd_state, 0);
+	fmt = v4l2_subdev_state_get_format(sd_state, 0);
 
 	/* Propagate change of current control to all related controls */
 	switch (ctrl->id) {
 	case V4L2_CID_VBLANK:
 		/* Update max exposure while meeting expected vblanking */
-		max_expo = crop->height + val - 4;
+		max_expo = fmt->height + val - 4;
 		def_expo = clamp_t(s64, ov4689->exposure->default_value,
 				   ov4689->exposure->minimum, max_expo);
 
@@ -767,16 +837,14 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 		cci_write(regmap, OV4689_REG_GAIN, sensor_gain, &ret);
 		break;
 	case V4L2_CID_VBLANK:
-		cci_write(regmap, OV4689_REG_VTS,
-			  val + crop->height, &ret);
+		cci_write(regmap, OV4689_REG_VTS, val + fmt->height, &ret);
 		break;
 	case V4L2_CID_TEST_PATTERN:
 		ret = ov4689_enable_test_pattern(ov4689, val);
 		break;
 	case V4L2_CID_HBLANK:
 		cci_write(regmap, OV4689_REG_HTS,
-			  (val + crop->width) /
-			  OV4689_HTS_DIVIDER, &ret);
+			  (val + fmt->width) / OV4689_HTS_DIVIDER, &ret);
 		break;
 	case V4L2_CID_VFLIP:
 		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT1,
-- 
2.43.0


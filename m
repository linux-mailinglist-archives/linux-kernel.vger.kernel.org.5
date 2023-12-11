Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFCB80D49A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345097AbjLKRvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345185AbjLKRva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:51:30 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB4C107;
        Mon, 11 Dec 2023 09:51:06 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso6227780e87.3;
        Mon, 11 Dec 2023 09:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317064; x=1702921864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Szd3tCJq3BzuFOQAHr0j38m73gmT9ejF3aS5J8pZX5s=;
        b=iB5pY8/fEWLd+CMZhUfZY0IUZscXbjk91jxThziFGjpyPMDZY8LcdvrAXL28wqr/+1
         IHGNmYV40fQuwv7e62aKMD8otcFn4z6UHicwabB5suSkGErkraU3IFG+EEoqU5pigWwP
         vRGfdNO5oq29nJ+414/xzQSioXSv0wMrfAbUgHf3cHAGvnvdhA6STBXYWkKaRgDT/bxw
         N7g9hd4liQpkJTiSmXK0LDGNCyVhQQYXDd/xAiSoPhSqhrcgkwWmNz7L+MgvUdf4sup+
         GgnVfI0ob1ib0cWQhkrd9EJp/174P49hKXRwYVn362f+/jD1i8zNXda+R9besiydVgTi
         UwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317064; x=1702921864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Szd3tCJq3BzuFOQAHr0j38m73gmT9ejF3aS5J8pZX5s=;
        b=H/0tiN281/Hfk7bb8gjtrqurO1wJaUPV3R6AsPYDsdCWt1ZydmdlCNgcTNwQMFkhYW
         YHtBug3GQT+w8Z1LQuV15DJ8NrZ+PMbadmt2C1ldZf+ZzGZK1aYsK6vD1KYhxgDO4ChW
         jReAqzhMoNNGWqZUMTKOCVzPKfykluieE8XS66z3jjfkyo3x5pVNIStCTC2k5AMuIPjX
         fiFjY78N9wSCTidsCM78lI9DQH2XeDyYJ5jhJuF4pcjnyDY6LEES5A3H+RS8Bxu3Y2Xl
         /dhwOaKe9uldmululiZfR20w49/cIWkGaqz8HW0pbAGvUtM3KWuvIBCSV3wU34n15HMn
         TmJQ==
X-Gm-Message-State: AOJu0Ywhau/O7FB5qxgLsGKfkDlkyyPaoIVLiNwdzGzxBBVd775vu8mF
        yMieLKf4ecq9Sy+Ob0UCUVbTM4xvy9FQOC/L
X-Google-Smtp-Source: AGHT+IEO3mLGvZyXgdC7AMfMkph90RHVp+VwsfDFSZpgKhi01IxC9ZdOiJcYl0HpKeys8sAI+xPg8A==
X-Received: by 2002:ac2:4f90:0:b0:50b:f7fe:bc11 with SMTP id z16-20020ac24f90000000b0050bf7febc11mr1956528lfs.54.1702317063971;
        Mon, 11 Dec 2023 09:51:03 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id w22-20020ac254b6000000b0050bf273a895sm1130193lfk.240.2023.12.11.09.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:51:03 -0800 (PST)
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
Subject: [PATCH 16/19] media: i2c: ov4689: Configurable analogue crop
Date:   Mon, 11 Dec 2023 20:50:19 +0300
Message-ID: <20231211175023.1680247-17-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211175023.1680247-1-mike.rudenko@gmail.com>
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement configurable analogue crop via .set_selectiong call.
ov4689_init_cfg is modified to initialize default subdev selection.
Offsets are aligned to 2 to preserve Bayer order, selection width is
aligned to 4 and height to 2 to meet hardware requirements.

Experimentally discovered values of the cropping-related registers and
vfifo_read_start for various output sizes are used. Default BLC anchor
positions are used for the default analogue crop, scaling down
proportionally for the smaller crop sizes.

When analogue crop is adjusted, several consequential actions take
place: the output format is reset, exposure/vblank/hblank control
ranges and default values are adjusted accordingly. Additionally,
ov4689_set_ctrl utilizes pad crop instead of cur_mode width and
height for HTS and VTS calculation. Also, ov4689_enum_frame_sizes is
modified to report crop size as available frame size.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 278 ++++++++++++++++++++++++++++---------
 1 file changed, 213 insertions(+), 65 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 9088b4c61cab..f3071e661f4a 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -56,8 +56,13 @@
 #define OV4689_REG_V_CROP_START		CCI_REG16(0x3802)
 #define OV4689_REG_H_CROP_END		CCI_REG16(0x3804)
 #define OV4689_REG_V_CROP_END		CCI_REG16(0x3806)
+
 #define OV4689_REG_H_OUTPUT_SIZE	CCI_REG16(0x3808)
+#define OV4689_H_OUTPUT_SIZE_DEFAULT	2688
+
 #define OV4689_REG_V_OUTPUT_SIZE	CCI_REG16(0x380a)
+#define OV4689_V_OUTPUT_SIZE_DEFAULT	1520
+
 #define OV4689_REG_H_WIN_OFF		CCI_REG16(0x3810)
 #define OV4689_REG_V_WIN_OFF		CCI_REG16(0x3812)
 
@@ -95,6 +100,19 @@
 #define OV4689_DUMMY_ROWS		8
 #define OV4689_DUMMY_COLUMNS		16
 
+/*
+ * These values are not hardware limits, but rather the minimums that
+ * the driver has been tested to.
+ */
+#define OV4689_H_CROP_MIN		128
+#define OV4689_V_CROP_MIN		128
+
+/*
+ * Minimum working vertical blanking value. Found experimentally at
+ * minimum HTS values.
+ */
+#define OV4689_VBLANK_MIN		31
+
 static const char *const ov4689_supply_names[] = {
 	"avdd", /* Analog power */
 	"dovdd", /* Digital I/O power */
@@ -133,7 +151,7 @@ struct ov4689 {
 	u32 clock_rate;
 
 	struct v4l2_ctrl_handler ctrl_handler;
-	struct v4l2_ctrl *exposure;
+	struct v4l2_ctrl *exposure, *hblank, *vblank;
 
 	const struct ov4689_mode *cur_mode;
 };
@@ -319,24 +337,27 @@ static const struct ov4689_gain_range ov4689_gain_ranges[] = {
 	},
 };
 
-static void ov4689_fill_fmt(const struct ov4689_mode *mode,
-			    struct v4l2_mbus_framefmt *fmt)
-{
-	fmt->code = MEDIA_BUS_FMT_SBGGR10_1X10;
-	fmt->width = mode->width;
-	fmt->height = mode->height;
-	fmt->field = V4L2_FIELD_NONE;
-}
-
 static int ov4689_set_fmt(struct v4l2_subdev *sd,
 			  struct v4l2_subdev_state *sd_state,
 			  struct v4l2_subdev_format *fmt)
 {
-	struct v4l2_mbus_framefmt *mbus_fmt = &fmt->format;
-	struct ov4689 *ov4689 = to_ov4689(sd);
+	struct v4l2_mbus_framefmt *format;
+	struct v4l2_rect *crop;
+
+	crop = v4l2_subdev_state_get_crop(sd_state, fmt->pad);
+	format = v4l2_subdev_state_get_format(sd_state, fmt->pad);
 
-	/* only one mode supported for now */
-	ov4689_fill_fmt(ov4689->cur_mode, mbus_fmt);
+	format->width = crop->width;
+	format->height = crop->height;
+
+	format->code = MEDIA_BUS_FMT_SBGGR10_1X10;
+	format->field = V4L2_FIELD_NONE;
+	format->colorspace = V4L2_COLORSPACE_RAW;
+	format->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	format->quantization = V4L2_QUANTIZATION_FULL_RANGE;
+	format->xfer_func = V4L2_XFER_FUNC_NONE;
+
+	fmt->format = *format;
 
 	return 0;
 }
@@ -356,16 +377,20 @@ static int ov4689_enum_frame_sizes(struct v4l2_subdev *sd,
 				   struct v4l2_subdev_state *sd_state,
 				   struct v4l2_subdev_frame_size_enum *fse)
 {
-	if (fse->index >= ARRAY_SIZE(supported_modes))
+	const struct v4l2_rect *crop;
+
+	if (fse->index >= 1)
 		return -EINVAL;
 
 	if (fse->code != MEDIA_BUS_FMT_SBGGR10_1X10)
 		return -EINVAL;
 
-	fse->min_width = supported_modes[fse->index].width;
-	fse->max_width = supported_modes[fse->index].width;
-	fse->max_height = supported_modes[fse->index].height;
-	fse->min_height = supported_modes[fse->index].height;
+	crop = v4l2_subdev_state_get_crop(sd_state, 0);
+
+	fse->min_width = crop->width;
+	fse->max_width = crop->width;
+	fse->max_height = crop->height;
+	fse->min_height = crop->height;
 
 	return 0;
 }
@@ -387,20 +412,14 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
 				struct v4l2_subdev_state *state,
 				struct v4l2_subdev_selection *sel)
 {
-	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
-		return -EINVAL;
-
 	switch (sel->target) {
-	case V4L2_SEL_TGT_CROP_BOUNDS:
-		sel->r.top = 0;
-		sel->r.left = 0;
-		sel->r.width = OV4689_PIXEL_ARRAY_WIDTH;
-		sel->r.height = OV4689_PIXEL_ARRAY_HEIGHT;
-		return 0;
 	case V4L2_SEL_TGT_CROP:
+		sel->r = *v4l2_subdev_state_get_crop(state, sel->pad);
+		return 0;
+	case V4L2_SEL_TGT_CROP_BOUNDS:
 	case V4L2_SEL_TGT_CROP_DEFAULT:
-		sel->r.top = OV4689_DUMMY_ROWS;
 		sel->r.left = OV4689_DUMMY_COLUMNS;
+		sel->r.top = OV4689_DUMMY_ROWS;
 		sel->r.width =
 			OV4689_PIXEL_ARRAY_WIDTH - 2 * OV4689_DUMMY_COLUMNS;
 		sel->r.height =
@@ -411,37 +430,141 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
 	return -EINVAL;
 }
 
-static int ov4689_setup_timings(struct ov4689 *ov4689)
+/*
+ * Minimum working HTS value for given output width (found
+ * experimentally).
+ */
+static unsigned int ov4689_hts_min(unsigned int width)
 {
-	const struct ov4689_mode *mode = ov4689->cur_mode;
+	return max_t(unsigned int, 3156, 224 + width * 19 / 16);
+}
+
+static void ov4689_update_ctrl_ranges(struct ov4689 *ov4689,
+				      struct v4l2_rect *crop)
+{
+	struct v4l2_ctrl *exposure = ov4689->exposure;
+	struct v4l2_ctrl *vblank = ov4689->vblank;
+	struct v4l2_ctrl *hblank = ov4689->hblank;
+	s64 def_val, min_val, max_val;
+
+	min_val = ov4689_hts_min(crop->width) - crop->width;
+	max_val = OV4689_HTS_MAX - crop->width;
+	def_val = clamp_t(s64, hblank->default_value, min_val, max_val);
+	__v4l2_ctrl_modify_range(hblank, min_val, max_val, hblank->step,
+				 def_val);
+
+	min_val = OV4689_VBLANK_MIN;
+	max_val = OV4689_HTS_MAX - crop->width;
+	def_val = clamp_t(s64, vblank->default_value, min_val, max_val);
+	__v4l2_ctrl_modify_range(vblank, min_val, max_val, vblank->step,
+				 def_val);
+
+	min_val = exposure->minimum;
+	max_val = crop->height + vblank->val - 4;
+	def_val = clamp_t(s64, exposure->default_value, min_val, max_val);
+	__v4l2_ctrl_modify_range(exposure, min_val, max_val, exposure->step,
+				 def_val);
+}
+
+static int ov4689_set_selection(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *state,
+				struct v4l2_subdev_selection *sel)
+{
+	struct ov4689 *ov4689 = to_ov4689(sd);
+	struct v4l2_mbus_framefmt *format;
+	struct v4l2_rect *crop;
+	struct v4l2_rect rect;
+
+	if (sel->target != V4L2_SEL_TGT_CROP)
+		return -EINVAL;
+
+	rect.left = clamp(ALIGN(sel->r.left, 2), OV4689_DUMMY_COLUMNS,
+			  OV4689_PIXEL_ARRAY_WIDTH);
+	rect.top = clamp(ALIGN(sel->r.top, 2), OV4689_DUMMY_ROWS,
+			 OV4689_PIXEL_ARRAY_HEIGHT);
+
+	rect.width = clamp_t(unsigned int, ALIGN(sel->r.width, 4),
+			     OV4689_H_CROP_MIN, OV4689_PIXEL_ARRAY_WIDTH -
+			     2 * OV4689_DUMMY_COLUMNS);
+	rect.height = clamp_t(unsigned int, ALIGN(sel->r.height, 2),
+			      OV4689_V_CROP_MIN, OV4689_PIXEL_ARRAY_HEIGHT -
+			      2 * OV4689_DUMMY_ROWS);
+
+	crop = v4l2_subdev_state_get_crop(state, sel->pad);
+
+	if (rect.width != crop->width || rect.height != crop->height) {
+		/*
+		 * Reset the output image size if the crop rectangle size has
+		 * been modified.
+		 */
+		format = v4l2_subdev_state_get_format(state, sel->pad);
+		format->width = rect.width;
+		format->height = rect.height;
+
+		if (sel->which == V4L2_SUBDEV_FORMAT_ACTIVE)
+			ov4689_update_ctrl_ranges(ov4689, &rect);
+	}
+
+	*crop = rect;
+	sel->r = rect;
+
+	return 0;
+}
+
+static int ov4689_setup_timings(struct ov4689 *ov4689,
+				struct v4l2_subdev_state *state)
+{
+	const struct v4l2_mbus_framefmt *format;
 	struct regmap *rm = ov4689->regmap;
+	const struct v4l2_rect *crop;
 	int ret = 0;
 
-	cci_write(rm, OV4689_REG_H_CROP_START, 8, &ret);
-	cci_write(rm, OV4689_REG_V_CROP_START, 8, &ret);
-	cci_write(rm, OV4689_REG_H_CROP_END, 2711, &ret);
-	cci_write(rm, OV4689_REG_V_CROP_END, 1531, &ret);
+	format = v4l2_subdev_state_get_format(state, 0);
+	crop = v4l2_subdev_state_get_crop(state, 0);
+
+	cci_write(rm, OV4689_REG_H_CROP_START, crop->left, &ret);
+	cci_write(rm, OV4689_REG_V_CROP_START, crop->top, &ret);
+	cci_write(rm, OV4689_REG_H_CROP_END, crop->left + crop->width + 1, &ret);
+	cci_write(rm, OV4689_REG_V_CROP_END, crop->top + crop->height + 1, &ret);
 
-	cci_write(rm, OV4689_REG_H_OUTPUT_SIZE, mode->width, &ret);
-	cci_write(rm, OV4689_REG_V_OUTPUT_SIZE, mode->height, &ret);
+	cci_write(rm, OV4689_REG_H_OUTPUT_SIZE, format->width, &ret);
+	cci_write(rm, OV4689_REG_V_OUTPUT_SIZE, format->height, &ret);
 
-	cci_write(rm, OV4689_REG_H_WIN_OFF, 8, &ret);
-	cci_write(rm, OV4689_REG_V_WIN_OFF, 4, &ret);
+	cci_write(rm, OV4689_REG_H_WIN_OFF, 0, &ret);
+	cci_write(rm, OV4689_REG_V_WIN_OFF, 0, &ret);
 
-	cci_write(rm, OV4689_REG_VFIFO_CTRL_01, 167, &ret);
+	/*
+	 * Maximum working value of vfifo_read_start for given output
+	 * width (found experimentally).
+	 */
+	cci_write(rm, OV4689_REG_VFIFO_CTRL_01, format->width / 16 - 1, &ret);
 
 	return ret;
 }
 
-static int ov4689_setup_blc_anchors(struct ov4689 *ov4689)
+/*
+ * Setup black level compensation anchors. For the default frame width
+ * default anchors positions are used. For smaller crop sizes they are
+ * scaled accordingly.
+ */
+static int ov4689_setup_blc_anchors(struct ov4689 *ov4689,
+				    struct v4l2_subdev_state *state)
 {
+	unsigned int width_def = OV4689_H_OUTPUT_SIZE_DEFAULT;
 	struct regmap *rm = ov4689->regmap;
+	const struct v4l2_rect *crop;
 	int ret = 0;
 
-	cci_write(rm, OV4689_REG_ANCHOR_LEFT_START, 16, &ret);
-	cci_write(rm, OV4689_REG_ANCHOR_LEFT_END, 1999, &ret);
-	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_START, 2400, &ret);
-	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_END, 2415, &ret);
+	crop = v4l2_subdev_state_get_crop(state, 0);
+
+	cci_write(rm, OV4689_REG_ANCHOR_LEFT_START,
+		  OV4689_ANCHOR_LEFT_START_DEF * crop->width / width_def, &ret);
+	cci_write(rm, OV4689_REG_ANCHOR_LEFT_END,
+		  OV4689_ANCHOR_LEFT_END_DEF * crop->width / width_def, &ret);
+	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_START,
+		  OV4689_ANCHOR_RIGHT_START_DEF * crop->width / width_def, &ret);
+	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_END,
+		  OV4689_ANCHOR_RIGHT_END_DEF * crop->width / width_def, &ret);
 
 	return ret;
 }
@@ -469,13 +592,13 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 			goto unlock_and_return;
 		}
 
-		ret = ov4689_setup_timings(ov4689);
+		ret = ov4689_setup_timings(ov4689, sd_state);
 		if (ret) {
 			pm_runtime_put(dev);
 			goto unlock_and_return;
 		}
 
-		ret = ov4689_setup_blc_anchors(ov4689);
+		ret = ov4689_setup_blc_anchors(ov4689, sd_state);
 		if (ret) {
 			pm_runtime_put(dev);
 			goto unlock_and_return;
@@ -566,11 +689,25 @@ static int __maybe_unused ov4689_power_off(struct device *dev)
 static int ov4689_init_cfg(struct v4l2_subdev *sd,
 			   struct v4l2_subdev_state *sd_state)
 {
-	struct v4l2_mbus_framefmt *try_fmt =
-		v4l2_subdev_state_get_format(sd_state, 0);
+	u32 width_def = OV4689_H_OUTPUT_SIZE_DEFAULT;
+	u32 height_def = OV4689_V_OUTPUT_SIZE_DEFAULT;
+
+	struct v4l2_subdev_selection sel  = {
+		.target = V4L2_SEL_TGT_CROP,
+		.r.left = OV4689_DUMMY_COLUMNS,
+		.r.top = OV4689_DUMMY_ROWS,
+		.r.width = width_def,
+		.r.height = height_def,
+	};
+	struct v4l2_subdev_format format = {
+		.format = {
+			.width = width_def,
+			.height = height_def,
+		},
+	};
 
-	/* Initialize try_fmt */
-	ov4689_fill_fmt(&supported_modes[OV4689_MODE_2688_1520], try_fmt);
+	ov4689_set_selection(sd, sd_state, &sel);
+	ov4689_set_fmt(sd, sd_state, &format);
 
 	return 0;
 }
@@ -590,6 +727,7 @@ static const struct v4l2_subdev_pad_ops ov4689_pad_ops = {
 	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = ov4689_set_fmt,
 	.get_selection = ov4689_get_selection,
+	.set_selection = ov4689_set_selection,
 };
 
 static const struct v4l2_subdev_ops ov4689_subdev_ops = {
@@ -631,21 +769,29 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 	struct ov4689 *ov4689 =
 		container_of(ctrl->handler, struct ov4689, ctrl_handler);
 	struct regmap *regmap = ov4689->regmap;
+	struct v4l2_subdev_state *sd_state;
 	struct device *dev = ov4689->dev;
+	struct v4l2_rect *crop;
 	s32 val = ctrl->val;
 	int sensor_gain;
-	s64 max_expo;
+	s64 max_expo, def_expo;
 	int ret;
 
+	sd_state = v4l2_subdev_get_locked_active_state(&ov4689->subdev);
+	crop = v4l2_subdev_state_get_crop(sd_state, 0);
+
 	/* Propagate change of current control to all related controls */
 	switch (ctrl->id) {
 	case V4L2_CID_VBLANK:
 		/* Update max exposure while meeting expected vblanking */
-		max_expo = ov4689->cur_mode->height + val - 4;
-		__v4l2_ctrl_modify_range(ov4689->exposure,
-					 ov4689->exposure->minimum, max_expo,
-					 ov4689->exposure->step,
-					 ov4689->exposure->default_value);
+		max_expo = crop->height + val - 4;
+		def_expo = clamp_t(s64, ov4689->exposure->default_value,
+				   ov4689->exposure->minimum, max_expo);
+
+		ret = __v4l2_ctrl_modify_range(ov4689->exposure,
+					       ov4689->exposure->minimum,
+					       max_expo, ov4689->exposure->step,
+					       def_expo);
 		break;
 	}
 
@@ -663,14 +809,14 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	case V4L2_CID_VBLANK:
 		cci_write(regmap, OV4689_REG_VTS,
-			  val + ov4689->cur_mode->height, &ret);
+			  val + crop->height, &ret);
 		break;
 	case V4L2_CID_TEST_PATTERN:
 		ret = ov4689_enable_test_pattern(ov4689, val);
 		break;
 	case V4L2_CID_HBLANK:
 		cci_write(regmap, OV4689_REG_HTS,
-			  (val + ov4689->cur_mode->width) /
+			  (val + crop->width) /
 			  OV4689_HTS_DIVIDER, &ret);
 		break;
 	case V4L2_CID_VFLIP:
@@ -734,14 +880,16 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 
 	hblank_def = mode->hts_def - mode->width;
 	hblank_min = mode->hts_min - mode->width;
-	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HBLANK,
-			  hblank_min, OV4689_HTS_MAX - mode->width,
-			  OV4689_HTS_DIVIDER, hblank_def);
+	ov4689->hblank = v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops,
+					   V4L2_CID_HBLANK, hblank_min,
+					   OV4689_HTS_MAX - mode->width,
+					   OV4689_HTS_DIVIDER, hblank_def);
 
 	vblank_def = mode->vts_def - mode->height;
-	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VBLANK,
-			  vblank_def, OV4689_VTS_MAX - mode->height, 1,
-			  vblank_def);
+	ov4689->vblank = v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops,
+					   V4L2_CID_VBLANK, OV4689_VBLANK_MIN,
+					   OV4689_VTS_MAX - mode->height, 1,
+					   vblank_def);
 
 	exposure_max = mode->vts_def - 4;
 	ov4689->exposure =
-- 
2.43.0


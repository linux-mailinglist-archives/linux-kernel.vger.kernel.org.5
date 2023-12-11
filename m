Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B6D80D498
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345091AbjLKRvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345169AbjLKRvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:51:24 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E2211D;
        Mon, 11 Dec 2023 09:51:05 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ca1e6a94a4so61519651fa.0;
        Mon, 11 Dec 2023 09:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317062; x=1702921862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtvsS5+cD5ElkCe7WN7GeNxLAQrSXFq4ofwLsevoTLU=;
        b=iLtXiiIHrCiYoyz45znkkLJQR8eDQwz4HgSVJ7/SxEyZEVIwmDykW1GRfbbA5qAtmW
         hR8kVJBPXenltCtbcZDDQ79GlcHQRUX6wFSxcdHtaxf38Dfwpairk603UTJo6eoBzkLV
         hYpr0MWpGVJFn3imihF45tymfLyj7X6AuACO7x33+5gFeP3Csb5t8H/uT+8bIF/vzoBN
         r3e2KJxmqafJkprENuPB4D+lZOTps0VqmyrhtcxrB6rfjHVWBPYsTL8DpgCLVDRPwtrL
         tJzOSQ5nha7YHfK9k8TWN6vLxsJ6vjHYGOpPpTUelYDR7jLA0T1PEtbAxVcLVWcoT/wZ
         iRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317062; x=1702921862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtvsS5+cD5ElkCe7WN7GeNxLAQrSXFq4ofwLsevoTLU=;
        b=TxodND3FXDt6WQIzCmQWXF/fU86eUt+BO3QoGrTBmclJjZlcez6zZyn3iF4AMGeGi7
         0N4EJTGRYeu3bVdTIAtGTsz0+am+z9ByyFIG0aobqqnP8iCb45QUuKQbEiPkpE9sJxTb
         UxsqJ/Dv7c/7j1OPeTLwu1ngT74D9CXGPRVQ4RyjjUE1wZJD9cOolsYmNXIiXAZliBJk
         lpq9tDmV/BlssvxtdpA0SES0nhLO/DLj8DMODqMt6OhpeQF5r8C7sLPZjsg+SoG2AGs6
         bSRvbdbfQFF/j5FEKFgAI3yV5CCc/tupELiuIEqfv4MlLSg2Qkz0pgPZZzjuwgnM5Eq/
         F0VA==
X-Gm-Message-State: AOJu0YzQ/7AyJxlHmnT/FE5Ncn70g0RPJVvbfGpXDerBmCAC+1qte08N
        NWl23R6lpJFs1LTsC19kZVw+05bCoOwVuOzj
X-Google-Smtp-Source: AGHT+IH/ZthI3yG2Fr7v2ykhYv8bI10WLuD7jRBZm/KlH+KkQSlkDpmriA3ba2M6pw6GNxHasUrv9Q==
X-Received: by 2002:a05:651c:158b:b0:2cc:1eb1:b43f with SMTP id h11-20020a05651c158b00b002cc1eb1b43fmr1884874ljq.68.1702317062572;
        Mon, 11 Dec 2023 09:51:02 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id r6-20020a2e9946000000b002c9f71e61f3sm1293441ljj.6.2023.12.11.09.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:51:02 -0800 (PST)
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
Subject: [PATCH 15/19] media: i2c: ov4689: Set timing registers programmatically
Date:   Mon, 11 Dec 2023 20:50:18 +0300
Message-ID: <20231211175023.1680247-16-mike.rudenko@gmail.com>
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

Set timing-related and BLC anchor registers via cci calls instead of
hardcoding them in the register table. This prepares the driver for
implementation of configurable analogue crop and binning. No
functional change intended.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 82 +++++++++++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 15 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 5acdf9e1b670..9088b4c61cab 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -52,6 +52,15 @@
 #define OV4689_TEST_PATTERN_ENABLE	0x80
 #define OV4689_TEST_PATTERN_DISABLE	0x0
 
+#define OV4689_REG_H_CROP_START		CCI_REG16(0x3800)
+#define OV4689_REG_V_CROP_START		CCI_REG16(0x3802)
+#define OV4689_REG_H_CROP_END		CCI_REG16(0x3804)
+#define OV4689_REG_V_CROP_END		CCI_REG16(0x3806)
+#define OV4689_REG_H_OUTPUT_SIZE	CCI_REG16(0x3808)
+#define OV4689_REG_V_OUTPUT_SIZE	CCI_REG16(0x380a)
+#define OV4689_REG_H_WIN_OFF		CCI_REG16(0x3810)
+#define OV4689_REG_V_WIN_OFF		CCI_REG16(0x3812)
+
 #define OV4689_REG_VTS			CCI_REG16(0x380e)
 #define OV4689_VTS_MAX			0x7fff
 
@@ -67,6 +76,17 @@
 #define OV4689_TIMING_FLIP_BOTH		(OV4689_TIMING_FLIP_ARRAY |\
 					 OV4689_TIMING_FLIP_DIGITAL)
 
+#define OV4689_REG_ANCHOR_LEFT_START	CCI_REG16(0x4020)
+#define OV4689_ANCHOR_LEFT_START_DEF	576
+#define OV4689_REG_ANCHOR_LEFT_END	CCI_REG16(0x4022)
+#define OV4689_ANCHOR_LEFT_END_DEF	831
+#define OV4689_REG_ANCHOR_RIGHT_START	CCI_REG16(0x4024)
+#define OV4689_ANCHOR_RIGHT_START_DEF	1984
+#define OV4689_REG_ANCHOR_RIGHT_END	CCI_REG16(0x4026)
+#define OV4689_ANCHOR_RIGHT_END_DEF	2239
+
+#define OV4689_REG_VFIFO_CTRL_01	CCI_REG8(0x4601)
+
 #define OV4689_LANES			4
 #define OV4689_XVCLK_FREQ		24000000
 
@@ -199,10 +219,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
 	{CCI_REG8(0x3798), 0x1b},
 
 	/* Timing control */
-	{CCI_REG8(0x3801), 0x08}, /* H_CROP_START_L h_crop_start[7:0] = 0x08 */
-	{CCI_REG8(0x3805), 0x97}, /* H_CROP_END_L h_crop_end[7:0] = 0x97 */
-	{CCI_REG8(0x3811), 0x08}, /* H_WIN_OFF_L h_win_off[7:0] = 0x08*/
-	{CCI_REG8(0x3813), 0x04}, /* V_WIN_OFF_L v_win_off[7:0] = 0x04 */
 	{CCI_REG8(0x3819), 0x01}, /* VSYNC_END_L vsync_end_point[7:0] = 0x01 */
 
 	/* OTP control */
@@ -218,22 +234,11 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
 	{CCI_REG8(0x401b), 0x00}, /* DEBUG_MODE */
 	{CCI_REG8(0x401d), 0x00}, /* DEBUG_MODE */
 	{CCI_REG8(0x401f), 0x00}, /* DEBUG_MODE */
-	{CCI_REG8(0x4020), 0x00}, /* ANCHOR_LEFT_START_H anchor_left_start[11:8] = 0 */
-	{CCI_REG8(0x4021), 0x10}, /* ANCHOR_LEFT_START_L anchor_left_start[7:0] = 0x10 */
-	{CCI_REG8(0x4022), 0x07}, /* ANCHOR_LEFT_END_H anchor_left_end[11:8] = 0x07 */
-	{CCI_REG8(0x4023), 0xcf}, /* ANCHOR_LEFT_END_L anchor_left_end[7:0] = 0xcf */
-	{CCI_REG8(0x4024), 0x09}, /* ANCHOR_RIGHT_START_H anchor_right_start[11:8] = 0x09 */
-	{CCI_REG8(0x4025), 0x60}, /* ANCHOR_RIGHT_START_L anchor_right_start[7:0] = 0x60 */
-	{CCI_REG8(0x4026), 0x09}, /* ANCHOR_RIGHT_END_H anchor_right_end[11:8] = 0x09 */
-	{CCI_REG8(0x4027), 0x6f}, /* ANCHOR_RIGHT_END_L anchor_right_end[7:0] = 0x6f */
 
 	/* ADC sync control */
 	{CCI_REG8(0x4500), 0x6c}, /* ADC_SYNC_CTRL */
 	{CCI_REG8(0x4503), 0x01}, /* ADC_SYNC_CTRL */
 
-	/* VFIFO */
-	{CCI_REG8(0x4601), 0xa7}, /* VFIFO_CTRL_01 r_vfifo_read_start[7:0] = 0xa7 */
-
 	/* Temperature monitor */
 	{CCI_REG8(0x4d00), 0x04}, /* TPM_CTRL_00 tmp_slope[15:8] = 0x04 */
 	{CCI_REG8(0x4d01), 0x42}, /* TPM_CTRL_01 tmp_slope[7:0] = 0x42 */
@@ -406,6 +411,41 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
 	return -EINVAL;
 }
 
+static int ov4689_setup_timings(struct ov4689 *ov4689)
+{
+	const struct ov4689_mode *mode = ov4689->cur_mode;
+	struct regmap *rm = ov4689->regmap;
+	int ret = 0;
+
+	cci_write(rm, OV4689_REG_H_CROP_START, 8, &ret);
+	cci_write(rm, OV4689_REG_V_CROP_START, 8, &ret);
+	cci_write(rm, OV4689_REG_H_CROP_END, 2711, &ret);
+	cci_write(rm, OV4689_REG_V_CROP_END, 1531, &ret);
+
+	cci_write(rm, OV4689_REG_H_OUTPUT_SIZE, mode->width, &ret);
+	cci_write(rm, OV4689_REG_V_OUTPUT_SIZE, mode->height, &ret);
+
+	cci_write(rm, OV4689_REG_H_WIN_OFF, 8, &ret);
+	cci_write(rm, OV4689_REG_V_WIN_OFF, 4, &ret);
+
+	cci_write(rm, OV4689_REG_VFIFO_CTRL_01, 167, &ret);
+
+	return ret;
+}
+
+static int ov4689_setup_blc_anchors(struct ov4689 *ov4689)
+{
+	struct regmap *rm = ov4689->regmap;
+	int ret = 0;
+
+	cci_write(rm, OV4689_REG_ANCHOR_LEFT_START, 16, &ret);
+	cci_write(rm, OV4689_REG_ANCHOR_LEFT_END, 1999, &ret);
+	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_START, 2400, &ret);
+	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_END, 2415, &ret);
+
+	return ret;
+}
+
 static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 {
 	struct ov4689 *ov4689 = to_ov4689(sd);
@@ -429,6 +469,18 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 			goto unlock_and_return;
 		}
 
+		ret = ov4689_setup_timings(ov4689);
+		if (ret) {
+			pm_runtime_put(dev);
+			goto unlock_and_return;
+		}
+
+		ret = ov4689_setup_blc_anchors(ov4689);
+		if (ret) {
+			pm_runtime_put(dev);
+			goto unlock_and_return;
+		}
+
 		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
 		if (ret) {
 			pm_runtime_put(dev);
-- 
2.43.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8496280D48E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345177AbjLKRvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345065AbjLKRu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:50:59 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368A8C3;
        Mon, 11 Dec 2023 09:50:59 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bf8843a6fso4723373e87.0;
        Mon, 11 Dec 2023 09:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317057; x=1702921857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRa38RGEmz27i+dqJIZM7KN8VTKbmG28KhKh8WuCaJ4=;
        b=jstO4TdZZqBVGzJ5soti4kqLyfE9JLFOqDNGcG5tSa9CvL3Ke5Pr9VKIucgIkd552d
         Gp7hIMTJt9DK/UhNuJkm0Iqjuf4TEqo7VdC5DkiU/uBX7o3JnZgRmdvf0EfKbSPOtnf5
         nUfUu5OI8fSQKNm/Y+VIwPIvMYiloNzBZV8NGIMXtaxzM801ckaRGoXYIL+bsXUkwJER
         5DIzdH8+0lI7v3EYyrqkInMRUc9RB1DxqMNf49751HMFqVJij2J/5eQurwVaTsJr8VNM
         hWnOoSEBshmyHzTVcEf47gl+rQKH9/Ha87LFZDEzX9n2hz4E7bwHtMKk0Zannl09kWpm
         LQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317057; x=1702921857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRa38RGEmz27i+dqJIZM7KN8VTKbmG28KhKh8WuCaJ4=;
        b=M5GC+oG610jNrBFI/05HRPYMAM5PNyOUaSYOyktZVSZnB487V4bS+NSEfE0YdcZpov
         z/h2Dtmv9g1SVCBi3YRObvgdrsGaFXqSnmUtGnLn1SDlrKyIEm6OTc3F4AsC6SD1tLna
         EakJJgVP7gb4EuajcmEYby9oh1gLX6EowwBWPr0Xd+wkXb17GGxMQR3ynmv9MqZ5tNA+
         EQHcjH+hO86S+yi2/5m7LCCJeyvBs5hBRlifMaol1Y+tvHjhofYcGFSaBLXugW7l4vjL
         T9mO9j2m+qXkh62k8xp4Lc31SbZ5oR3e+VhSvk/uZ7tpw8D34yGVLtfRTqu97/xLPA19
         HbFw==
X-Gm-Message-State: AOJu0YygqOcQB3cmQaI5unqd/40a5febeQwmUVUEV5zFOM117gXlrxMt
        WEpFhMtxfjiHHeAC3nWH78zJ7AU6E7IADVSU
X-Google-Smtp-Source: AGHT+IEvo0fhC92MBtgDiBCjKsHeXq9ZlNGlX/1YBBRYosWGMcHiwVUoMAmpTTiLySpueO62rD2Fgw==
X-Received: by 2002:ac2:548d:0:b0:50b:f706:81cd with SMTP id t13-20020ac2548d000000b0050bf70681cdmr2409825lfk.19.1702317056754;
        Mon, 11 Dec 2023 09:50:56 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id r14-20020ac25a4e000000b0050bfd883f56sm1141079lfn.129.2023.12.11.09.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:50:56 -0800 (PST)
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
Subject: [PATCH 11/19] media: i2c: ov4689: Implement vflip/hflip controls
Date:   Mon, 11 Dec 2023 20:50:14 +0300
Message-ID: <20231211175023.1680247-12-mike.rudenko@gmail.com>
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

The OV4689 sensor supports horizontal and vertical flipping. Add
appropriate controls to the driver. Toggling both array flip and
digital flip bits allows to achieve flipping while maintaining output
Bayer order. Note that the default value of hflip control corresponds
to both bits set, as it was before this patch.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 67d4004bdcfb..62aeae43d749 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -46,6 +46,14 @@
 #define OV4689_HTS_DIVIDER		4
 #define OV4689_HTS_MAX			0x7fff
 
+#define OV4689_REG_TIMING_FORMAT1	CCI_REG8(0x3820)
+#define OV4689_REG_TIMING_FORMAT2	CCI_REG8(0x3821)
+#define OV4689_TIMING_FLIP_MASK		GENMASK(2, 1)
+#define OV4689_TIMING_FLIP_ARRAY	BIT(1)
+#define OV4689_TIMING_FLIP_DIGITAL	BIT(2)
+#define OV4689_TIMING_FLIP_BOTH		(OV4689_TIMING_FLIP_ARRAY |\
+					 OV4689_TIMING_FLIP_DIGITAL)
+
 #define OV4689_LANES			4
 #define OV4689_XVCLK_FREQ		24000000
 
@@ -183,7 +191,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
 	{CCI_REG8(0x3811), 0x08}, /* H_WIN_OFF_L h_win_off[7:0] = 0x08*/
 	{CCI_REG8(0x3813), 0x04}, /* V_WIN_OFF_L v_win_off[7:0] = 0x04 */
 	{CCI_REG8(0x3819), 0x01}, /* VSYNC_END_L vsync_end_point[7:0] = 0x01 */
-	{CCI_REG8(0x3821), 0x06}, /* TIMING_FORMAT2 array_h_mirror = 1, digital_h_mirror = 1 */
 
 	/* OTP control */
 	{CCI_REG8(0x3d85), 0x36}, /* OTP_REG85 OTP_power_up_load_setting_enable = 1,
@@ -605,6 +612,16 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 			  (val + ov4689->cur_mode->width) /
 			  OV4689_HTS_DIVIDER, &ret);
 		break;
+	case V4L2_CID_VFLIP:
+		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT1,
+				OV4689_TIMING_FLIP_MASK,
+				val ? OV4689_TIMING_FLIP_BOTH : 0, &ret);
+		break;
+	case V4L2_CID_HFLIP:
+		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT2,
+				OV4689_TIMING_FLIP_MASK,
+				val ? 0 : OV4689_TIMING_FLIP_BOTH, &ret);
+		break;
 	default:
 		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
 			 __func__, ctrl->id, val);
@@ -633,7 +650,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 
 	handler = &ov4689->ctrl_handler;
 	mode = ov4689->cur_mode;
-	ret = v4l2_ctrl_handler_init(handler, 11);
+	ret = v4l2_ctrl_handler_init(handler, 13);
 	if (ret)
 		return ret;
 
@@ -673,6 +690,9 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 				     ARRAY_SIZE(ov4689_test_pattern_menu) - 1,
 				     0, 0, ov4689_test_pattern_menu);
 
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
+
 	if (handler->error) {
 		ret = handler->error;
 		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);
-- 
2.43.0


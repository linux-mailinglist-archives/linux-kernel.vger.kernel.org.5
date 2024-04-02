Return-Path: <linux-kernel+bounces-128378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FFF895A17
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1F7285AF8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC9E15B974;
	Tue,  2 Apr 2024 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McjkzbXB"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB75C15B573;
	Tue,  2 Apr 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076396; cv=none; b=DF/hz51nj51gMhcSr9gbXDUPV2c6a+ryhIvO5UkuUXCab/N/QM3I0mH2JD1hNMSQAMOlNj0dvrzkx8t6bw6wkYOXa9QTp5FJA2t7OFq5hwsiRqd3Uf04JYpbs+E/asvFCKpDGFfddMVMGroU++6yEUtRu3PeVeEjYXnpsi/aJx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076396; c=relaxed/simple;
	bh=ULaOPfWzIwKAJ1BEtNHETjk+lhgQqSvGOwKmfaVHku0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJXgUdEb040Jzd0UuLSHyB8O5f04Z3yI+t040OrfStwzvlA1JxEOIGa3gzqDll4XRQMZpUSn9R6EYtbE9PdCG3nyH5E+Iti1yVaMMLlfY/gIlnFIewRbLvNy7uc319BnqZH3ODZc1tg55+uyYCKPDE4nh3ZXbQ6AyX+zXw1oZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McjkzbXB; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51588f70d2dso7142592e87.3;
        Tue, 02 Apr 2024 09:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076392; x=1712681192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF+PZCdqvnd0yhpSWqmYTafH0sl0UariPGXjZv/SFLM=;
        b=McjkzbXBigq7mwjC617V0lHXnqBRLiM5tHjfeXDBNZmZNt3q1IynknHChCXdLfRM5y
         h77t3RVFjRVMpCBgX/f4rsWIS0G3QRIqwxJMVkDH0IwnmFbFXGLe3/Ez+WMy4vXFUGUS
         EuLPUTP+Zu/z+/UJcSJMy3SF4vfOMSxikVki5zkWWowYBJNGewuTaeB5EQE9o4yyWWic
         ZP9Fym+B7Ryf+TEeaSEQHqwOAKld5+5wQrLgjOdKCyc7CPytLES1PjXBlMWZzmT3+Z4Z
         wXiQ2o8h/V6fQarrzW+qET/dDD9I7vN8mB7vSrRJ0ypEvkqTktK/L0OldID22dzC03LU
         oTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076392; x=1712681192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WF+PZCdqvnd0yhpSWqmYTafH0sl0UariPGXjZv/SFLM=;
        b=kP5prPj7VUfmsSI7RxTmQ1S2ZsBlWyc+dk2WLaZSxdw71IZKaIH14ke3HJrpg9qbL4
         oq0QGA3w1tyFUcyRD89/iU9mhVyA07fz8k4RSmTZoY9TOK9lwf/Il+xWMcKvS+KIQa5g
         Aq4RCexOmZTVFIt52XxfGjcFoCP3mvLbhb67rmumIZwTqRCFtn8UYjIhgLW/zASZ3l/T
         4UZGfFUMm7dFr9SZJy+JIXTWqkhvVyXTwQghpog61UjmFuh7d0tQozHoLzwFSzfYe3lr
         XlWi5a0foBkbpWQ+tMQSqzHuLWGCI1iDKuRK3YXq0FFYfJkwm2l026ldB5ExITl3GISr
         hdaA==
X-Forwarded-Encrypted: i=1; AJvYcCUWfEyt8bUAuPOQMwyUMzSr0xbV4kBspWHjwwp2BqzCXeeL8K0QmBguyjrymuBTjT9jSfb/PUfSYMwq7wZ4pZsjdwZHQqFbhV8p7AAH
X-Gm-Message-State: AOJu0YxHcdM79sCZf1h+Vjf+dAqNl0MxVdLeEZFWmHl9wha27DPKqWrL
	mDd8uIHKKd+aDIUNj5SJ0hezS6K0u4otgMEpHeMf15eYjdLEsn3diMYIji5BhHBmjQ==
X-Google-Smtp-Source: AGHT+IEP6GF9wPbEex/Oag7Q22/3Ew0loGIxA/YsS87pFr0Y9rEzy1WBZuktm2boS7uQ/7+wHyE9Og==
X-Received: by 2002:a19:f806:0:b0:513:5951:61a4 with SMTP id a6-20020a19f806000000b00513595161a4mr96715lff.6.1712076391916;
        Tue, 02 Apr 2024 09:46:31 -0700 (PDT)
Received: from localhost ([77.91.78.25])
        by smtp.gmail.com with ESMTPSA id q17-20020ac25151000000b00515af4b4878sm1757814lfd.183.2024.04.02.09.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:46:31 -0700 (PDT)
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
	Mikhail Rudenko <mike.rudenko@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: [PATCH v4 12/20] media: i2c: ov4689: Implement vflip/hflip controls
Date: Tue,  2 Apr 2024 19:45:43 +0300
Message-ID: <20240402164552.19171-13-mike.rudenko@gmail.com>
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

The OV4689 sensor supports horizontal and vertical flipping. Add
appropriate controls to the driver. Toggling both array flip and
digital flip bits allows to achieve flipping while maintaining output
Bayer order. Note that the default value of hflip control corresponds
to both bits set, as it was before this patch.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 8283a9ac86c9..60c60bbfe3bb 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -42,6 +42,14 @@
 #define OV4689_REG_VTS			CCI_REG16(0x380e)
 #define OV4689_VTS_MAX			0x7fff
 
+#define OV4689_REG_TIMING_FORMAT1	CCI_REG8(0x3820) /* Vertical */
+#define OV4689_REG_TIMING_FORMAT2	CCI_REG8(0x3821) /* Horizontal */
+#define OV4689_TIMING_FLIP_MASK		GENMASK(2, 1)
+#define OV4689_TIMING_FLIP_ARRAY	BIT(1)
+#define OV4689_TIMING_FLIP_DIGITAL	BIT(2)
+#define OV4689_TIMING_FLIP_BOTH		(OV4689_TIMING_FLIP_ARRAY |\
+					 OV4689_TIMING_FLIP_DIGITAL)
+
 #define OV4689_REG_TEST_PATTERN		CCI_REG8(0x5040)
 #define OV4689_TEST_PATTERN_ENABLE	0x80
 #define OV4689_TEST_PATTERN_DISABLE	0x0
@@ -183,7 +191,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
 	{CCI_REG8(0x3811), 0x08}, /* H_WIN_OFF_L h_win_off[7:0] = 0x08*/
 	{CCI_REG8(0x3813), 0x04}, /* V_WIN_OFF_L v_win_off[7:0] = 0x04 */
 	{CCI_REG8(0x3819), 0x01}, /* VSYNC_END_L vsync_end_point[7:0] = 0x01 */
-	{CCI_REG8(0x3821), 0x06}, /* TIMING_FORMAT2 array_h_mirror = 1, digital_h_mirror = 1 */
 
 	/* OTP control */
 	{CCI_REG8(0x3d85), 0x36}, /* OTP_REG85 OTP_power_up_load_setting_enable = 1,
@@ -607,6 +614,16 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 			  (ctrl->val + ov4689->cur_mode->width) /
 			  OV4689_HTS_DIVIDER, &ret);
 		break;
+	case V4L2_CID_VFLIP:
+		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT1,
+				OV4689_TIMING_FLIP_MASK,
+				ctrl->val ? OV4689_TIMING_FLIP_BOTH : 0, &ret);
+		break;
+	case V4L2_CID_HFLIP:
+		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT2,
+				OV4689_TIMING_FLIP_MASK,
+				ctrl->val ? 0 : OV4689_TIMING_FLIP_BOTH, &ret);
+		break;
 	default:
 		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
 			 __func__, ctrl->id, ctrl->val);
@@ -637,7 +654,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 
 	handler = &ov4689->ctrl_handler;
 	mode = ov4689->cur_mode;
-	ret = v4l2_ctrl_handler_init(handler, 10);
+	ret = v4l2_ctrl_handler_init(handler, 12);
 	if (ret)
 		return ret;
 
@@ -677,6 +694,9 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 				     ARRAY_SIZE(ov4689_test_pattern_menu) - 1,
 				     0, 0, ov4689_test_pattern_menu);
 
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
+
 	if (handler->error) {
 		ret = handler->error;
 		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);
-- 
2.44.0



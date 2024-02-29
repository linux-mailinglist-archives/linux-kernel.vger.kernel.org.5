Return-Path: <linux-kernel+bounces-87107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894B186CFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADFA01C21E41
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDA86CC04;
	Thu, 29 Feb 2024 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYctecZu"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935673771E;
	Thu, 29 Feb 2024 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225632; cv=none; b=FTpnUdMH6U760IBsszAM3XLZ19o/hhaHBZFfRTw8QzCnPp1XWnbUhn2gLXXmFEw2M6T2dp6VFNqVdkNNuzxq7KlNI25UeeANPIsaeN8qorRKXgxoyeYQqh8hjTGu5lEMQh4R9S0Ota5twPO7MxqFzXgmeePRlUo7XqJ/e1VvZ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225632; c=relaxed/simple;
	bh=6LhnKLkyHoR2DQhrygMZnlhExO0jOETkNADL5rYjKBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGJvI2fOtyUXE+VChPbrQ4+2PLXoZaOA8bldI/jg/gvHyVdI80AQZL465NoqLfhKGOns931lq+XAqIr34bqaxDTmHtCKs+vx8Um2iKSdNu07EPSYfMk25Vxe4mjuNM700xIuf3ka29KS5XZUYZpZ2b6s/QxUYq7it4KD8enkKwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYctecZu; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513235b5975so1542140e87.2;
        Thu, 29 Feb 2024 08:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709225628; x=1709830428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDcEufGaeEidfkZcKTWsyxzNEaaKvnRrmWH2EUzo0uE=;
        b=fYctecZuKsXWxc8ny1v+Sxd7MP8N7pKVBS76esCbhXm59Znt2T0bvGGuyNCZtoNcYT
         v03nulk460IohSFsoBvogzoKjlFlvMT9AUIL/7LNdvkrrU/l8ZcJVsEdzEuZMu9YXdUf
         g+BKxRLfL8hNlR15BYrDftuuJDjOWaSU1EesEjKGyKkIckSNePI5U0t9jRyW6f0ukMNi
         b/Ahgf2mNWSFn0Gy5prBrYY4/htVsSmUGDHyM2wPtMGjXnPKnnH908XMK14GuQ//cOxB
         U2BdDQ6t68jQMHtsWQ+1o+fOMXa++xQPxOCblpaBHv2+/WPhU8S6q5TvZvexzjS1zPw/
         GbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225628; x=1709830428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDcEufGaeEidfkZcKTWsyxzNEaaKvnRrmWH2EUzo0uE=;
        b=viaabchR7OuZuJnXDRS3JoyN0C0oVMa6/uB0CPG7svicdU59IB1II3AyhIbkbicSnv
         wBZks4mgoYuGKLdP2+tUI2P3lVMcpcijyYjJ6PlUMxwKnWYmHWKms0FlQ8WiH9G3QcBY
         PBFpGiJhD8gOn7iCik8uO6s+OtHQwk/B/53t7I3auijIDnKI0dWwbog6O3t7o8Hbr1uS
         8+KlOX1ETMLYcMZ7W8Jl+o3ahFEDVVJd+V2MJlk9+2O4quBHRsEUNgYcehTNbWnPErzw
         Rh3hewIWWLpnMpiw59FKU6qP9AyKoJ1HHKgKXf7yunZ0Q93gGv5WVW+trP+Vew3KMbNz
         1Ogw==
X-Forwarded-Encrypted: i=1; AJvYcCWIEEMiFrvIBRRqvZ52jao+MWH3hnqQdL74KvF7XN+1rkMR13ZdXWApbXw3pI4fvlu90dcGXV6GbwxBt3BrqAgGqs4b/PeJlrvIWPct
X-Gm-Message-State: AOJu0YyKUjfWkemxu+by4RiOlGkKn4rIJHxvLqwDt2nr+7L3l7rIKSSM
	+yujXm98dEHCobpiQSpkJpDhL0dfhvBF2Ydx4TSmacxuHd63mVj5fbAPQ/KVwvk=
X-Google-Smtp-Source: AGHT+IEtCrfAsH0/0aQdK3Zrv1ZJ9cSpKT2JDEkPiWDICd8OFMB10iFf5wo9ayhCzN01V+Qd/qcfeA==
X-Received: by 2002:ac2:4d10:0:b0:513:2347:4b57 with SMTP id r16-20020ac24d10000000b0051323474b57mr1924844lfi.66.1709225627682;
        Thu, 29 Feb 2024 08:53:47 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id c41-20020a05651223a900b00513256fb6fasm293233lfv.187.2024.02.29.08.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:53:46 -0800 (PST)
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
Subject: [PATCH v3 01/20] media: i2c: ov4689: Clean up and annotate the register table
Date: Thu, 29 Feb 2024 19:53:14 +0300
Message-ID: <20240229165333.227484-2-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229165333.227484-1-mike.rudenko@gmail.com>
References: <20240229165333.227484-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many values in the register table are actually power-on
defaults. Remove those and also unused HDR exposures and gains.
Annotate the remaining values using the publicly available datasheet
to facilitate further development. No functional change intended.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 203 +++++++++++++++++++++----------------
 1 file changed, 118 insertions(+), 85 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 403091651885..5a509e908e3c 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -3,7 +3,7 @@
  * ov4689 driver
  *
  * Copyright (C) 2017 Fuzhou Rockchip Electronics Co., Ltd.
- * Copyright (C) 2022 Mikhail Rudenko
+ * Copyright (C) 2022, 2024 Mikhail Rudenko
  */
 
 #include <linux/clk.h>
@@ -123,90 +123,123 @@ struct ov4689_gain_range {
  * mipi_datarate per lane 1008Mbps
  */
 static const struct regval ov4689_2688x1520_regs[] = {
-	{0x0103, 0x01}, {0x3638, 0x00}, {0x0300, 0x00},
-	{0x0302, 0x2a}, {0x0303, 0x00}, {0x0304, 0x03},
-	{0x030b, 0x00}, {0x030d, 0x1e}, {0x030e, 0x04},
-	{0x030f, 0x01}, {0x0312, 0x01}, {0x031e, 0x00},
-	{0x3000, 0x20}, {0x3002, 0x00}, {0x3018, 0x72},
-	{0x3020, 0x93}, {0x3021, 0x03}, {0x3022, 0x01},
-	{0x3031, 0x0a}, {0x303f, 0x0c}, {0x3305, 0xf1},
-	{0x3307, 0x04}, {0x3309, 0x29}, {0x3500, 0x00},
-	{0x3501, 0x60}, {0x3502, 0x00}, {0x3503, 0x04},
-	{0x3504, 0x00}, {0x3505, 0x00}, {0x3506, 0x00},
-	{0x3507, 0x00}, {0x3508, 0x00}, {0x3509, 0x80},
-	{0x350a, 0x00}, {0x350b, 0x00}, {0x350c, 0x00},
-	{0x350d, 0x00}, {0x350e, 0x00}, {0x350f, 0x80},
-	{0x3510, 0x00}, {0x3511, 0x00}, {0x3512, 0x00},
-	{0x3513, 0x00}, {0x3514, 0x00}, {0x3515, 0x80},
-	{0x3516, 0x00}, {0x3517, 0x00}, {0x3518, 0x00},
-	{0x3519, 0x00}, {0x351a, 0x00}, {0x351b, 0x80},
-	{0x351c, 0x00}, {0x351d, 0x00}, {0x351e, 0x00},
-	{0x351f, 0x00}, {0x3520, 0x00}, {0x3521, 0x80},
-	{0x3522, 0x08}, {0x3524, 0x08}, {0x3526, 0x08},
-	{0x3528, 0x08}, {0x352a, 0x08}, {0x3602, 0x00},
-	{0x3603, 0x40}, {0x3604, 0x02}, {0x3605, 0x00},
-	{0x3606, 0x00}, {0x3607, 0x00}, {0x3609, 0x12},
-	{0x360a, 0x40}, {0x360c, 0x08}, {0x360f, 0xe5},
-	{0x3608, 0x8f}, {0x3611, 0x00}, {0x3613, 0xf7},
-	{0x3616, 0x58}, {0x3619, 0x99}, {0x361b, 0x60},
-	{0x361c, 0x7a}, {0x361e, 0x79}, {0x361f, 0x02},
-	{0x3632, 0x00}, {0x3633, 0x10}, {0x3634, 0x10},
-	{0x3635, 0x10}, {0x3636, 0x15}, {0x3646, 0x86},
-	{0x364a, 0x0b}, {0x3700, 0x17}, {0x3701, 0x22},
-	{0x3703, 0x10}, {0x370a, 0x37}, {0x3705, 0x00},
-	{0x3706, 0x63}, {0x3709, 0x3c}, {0x370b, 0x01},
-	{0x370c, 0x30}, {0x3710, 0x24}, {0x3711, 0x0c},
-	{0x3716, 0x00}, {0x3720, 0x28}, {0x3729, 0x7b},
-	{0x372a, 0x84}, {0x372b, 0xbd}, {0x372c, 0xbc},
-	{0x372e, 0x52}, {0x373c, 0x0e}, {0x373e, 0x33},
-	{0x3743, 0x10}, {0x3744, 0x88}, {0x3745, 0xc0},
-	{0x374a, 0x43}, {0x374c, 0x00}, {0x374e, 0x23},
-	{0x3751, 0x7b}, {0x3752, 0x84}, {0x3753, 0xbd},
-	{0x3754, 0xbc}, {0x3756, 0x52}, {0x375c, 0x00},
-	{0x3760, 0x00}, {0x3761, 0x00}, {0x3762, 0x00},
-	{0x3763, 0x00}, {0x3764, 0x00}, {0x3767, 0x04},
-	{0x3768, 0x04}, {0x3769, 0x08}, {0x376a, 0x08},
-	{0x376b, 0x20}, {0x376c, 0x00}, {0x376d, 0x00},
-	{0x376e, 0x00}, {0x3773, 0x00}, {0x3774, 0x51},
-	{0x3776, 0xbd}, {0x3777, 0xbd}, {0x3781, 0x18},
-	{0x3783, 0x25}, {0x3798, 0x1b}, {0x3800, 0x00},
-	{0x3801, 0x08}, {0x3802, 0x00}, {0x3803, 0x04},
-	{0x3804, 0x0a}, {0x3805, 0x97}, {0x3806, 0x05},
-	{0x3807, 0xfb}, {0x3808, 0x0a}, {0x3809, 0x80},
-	{0x380a, 0x05}, {0x380b, 0xf0}, {0x380c, 0x0a},
-	{0x380d, 0x0e}, {0x380e, 0x06}, {0x380f, 0x12},
-	{0x3810, 0x00}, {0x3811, 0x08}, {0x3812, 0x00},
-	{0x3813, 0x04}, {0x3814, 0x01}, {0x3815, 0x01},
-	{0x3819, 0x01}, {0x3820, 0x00}, {0x3821, 0x06},
-	{0x3829, 0x00}, {0x382a, 0x01}, {0x382b, 0x01},
-	{0x382d, 0x7f}, {0x3830, 0x04}, {0x3836, 0x01},
-	{0x3837, 0x00}, {0x3841, 0x02}, {0x3846, 0x08},
-	{0x3847, 0x07}, {0x3d85, 0x36}, {0x3d8c, 0x71},
-	{0x3d8d, 0xcb}, {0x3f0a, 0x00}, {0x4000, 0xf1},
-	{0x4001, 0x40}, {0x4002, 0x04}, {0x4003, 0x14},
-	{0x400e, 0x00}, {0x4011, 0x00}, {0x401a, 0x00},
-	{0x401b, 0x00}, {0x401c, 0x00}, {0x401d, 0x00},
-	{0x401f, 0x00}, {0x4020, 0x00}, {0x4021, 0x10},
-	{0x4022, 0x07}, {0x4023, 0xcf}, {0x4024, 0x09},
-	{0x4025, 0x60}, {0x4026, 0x09}, {0x4027, 0x6f},
-	{0x4028, 0x00}, {0x4029, 0x02}, {0x402a, 0x06},
-	{0x402b, 0x04}, {0x402c, 0x02}, {0x402d, 0x02},
-	{0x402e, 0x0e}, {0x402f, 0x04}, {0x4302, 0xff},
-	{0x4303, 0xff}, {0x4304, 0x00}, {0x4305, 0x00},
-	{0x4306, 0x00}, {0x4308, 0x02}, {0x4500, 0x6c},
-	{0x4501, 0xc4}, {0x4502, 0x40}, {0x4503, 0x01},
-	{0x4601, 0xa7}, {0x4800, 0x04}, {0x4813, 0x08},
-	{0x481f, 0x40}, {0x4829, 0x78}, {0x4837, 0x10},
-	{0x4b00, 0x2a}, {0x4b0d, 0x00}, {0x4d00, 0x04},
-	{0x4d01, 0x42}, {0x4d02, 0xd1}, {0x4d03, 0x93},
-	{0x4d04, 0xf5}, {0x4d05, 0xc1}, {0x5000, 0xf3},
-	{0x5001, 0x11}, {0x5004, 0x00}, {0x500a, 0x00},
-	{0x500b, 0x00}, {0x5032, 0x00}, {0x5040, 0x00},
-	{0x5050, 0x0c}, {0x5500, 0x00}, {0x5501, 0x10},
-	{0x5502, 0x01}, {0x5503, 0x0f}, {0x8000, 0x00},
-	{0x8001, 0x00}, {0x8002, 0x00}, {0x8003, 0x00},
-	{0x8004, 0x00}, {0x8005, 0x00}, {0x8006, 0x00},
-	{0x8007, 0x00}, {0x8008, 0x00}, {0x3638, 0x00},
+	/* System control*/
+	{0x0103, 0x01}, /* SC_CTRL0103 software_reset = 1 */
+	{0x3000, 0x20}, /* SC_CMMN_PAD_OEN0 FSIN_output_enable = 1 */
+	{0x3021, 0x03}, /*
+			 * SC_CMMN_MISC_CTRL fst_stby_ctr = 0,
+			 * sleep_no_latch_enable = 0
+			 */
+
+	/* AEC PK */
+	{0x3503, 0x04}, /* AEC_MANUAL gain_input_as_sensor_gain_format = 1 */
+	{0x352a, 0x08}, /* DIG_GAIN_FRAC_LONG dig_gain_long[14:8] = 0x08 (2x) */
+
+	/* ADC and analog control*/
+	{0x3603, 0x40},
+	{0x3604, 0x02},
+	{0x3609, 0x12},
+	{0x360c, 0x08},
+	{0x360f, 0xe5},
+	{0x3608, 0x8f},
+	{0x3611, 0x00},
+	{0x3613, 0xf7},
+	{0x3616, 0x58},
+	{0x3619, 0x99},
+	{0x361b, 0x60},
+	{0x361e, 0x79},
+	{0x3634, 0x10},
+	{0x3635, 0x10},
+	{0x3636, 0x15},
+	{0x3646, 0x86},
+	{0x364a, 0x0b},
+
+	/* Sensor control */
+	{0x3700, 0x17},
+	{0x3701, 0x22},
+	{0x3703, 0x10},
+	{0x370a, 0x37},
+	{0x3706, 0x63},
+	{0x3709, 0x3c},
+	{0x370c, 0x30},
+	{0x3710, 0x24},
+	{0x3720, 0x28},
+	{0x3729, 0x7b},
+	{0x372b, 0xbd},
+	{0x372c, 0xbc},
+	{0x372e, 0x52},
+	{0x373c, 0x0e},
+	{0x373e, 0x33},
+	{0x3743, 0x10},
+	{0x3744, 0x88},
+	{0x3745, 0xc0},
+	{0x374c, 0x00},
+	{0x374e, 0x23},
+	{0x3751, 0x7b},
+	{0x3753, 0xbd},
+	{0x3754, 0xbc},
+	{0x3756, 0x52},
+	{0x376b, 0x20},
+	{0x3774, 0x51},
+	{0x3776, 0xbd},
+	{0x3777, 0xbd},
+	{0x3781, 0x18},
+	{0x3783, 0x25},
+	{0x3798, 0x1b},
+
+	/* Timing control */
+	{0x3801, 0x08}, /* H_CROP_START_L h_crop_start[7:0] = 0x08 */
+	{0x3805, 0x97}, /* H_CROP_END_L h_crop_end[7:0] = 0x97 */
+	{0x380c, 0x0a}, /* TIMING_HTS_H hts[14:8] = 0x0a */
+	{0x380d, 0x0e}, /* TIMING_HTS_L hts[7:0] = 0x0e */
+	{0x3811, 0x08}, /* H_WIN_OFF_L h_win_off[7:0] = 0x08*/
+	{0x3813, 0x04}, /* V_WIN_OFF_L v_win_off[7:0] = 0x04 */
+	{0x3819, 0x01}, /* VSYNC_END_L vsync_end_point[7:0] = 0x01 */
+	{0x3821, 0x06}, /* TIMING_FORMAT2 array_h_mirror = 1, digital_h_mirror = 1 */
+
+	/* OTP control */
+	{0x3d85, 0x36}, /* OTP_REG85 OTP_power_up_load_setting_enable = 1,
+			 * OTP_power_up_load_data_enable = 1,
+			 * OTP_bist_select = 1 (compare with zero)
+			 */
+	{0x3d8c, 0x71}, /* OTP_SETTING_STT_ADDRESS_H */
+	{0x3d8d, 0xcb}, /* OTP_SETTING_STT_ADDRESS_L */
+
+	/* BLC registers*/
+	{0x4001, 0x40}, /* DEBUG_MODE */
+	{0x401b, 0x00}, /* DEBUG_MODE */
+	{0x401d, 0x00}, /* DEBUG_MODE */
+	{0x401f, 0x00}, /* DEBUG_MODE */
+	{0x4020, 0x00}, /* ANCHOR_LEFT_START_H anchor_left_start[11:8] = 0 */
+	{0x4021, 0x10}, /* ANCHOR_LEFT_START_L anchor_left_start[7:0] = 0x10 */
+	{0x4022, 0x07}, /* ANCHOR_LEFT_END_H anchor_left_end[11:8] = 0x07 */
+	{0x4023, 0xcf}, /* ANCHOR_LEFT_END_L anchor_left_end[7:0] = 0xcf */
+	{0x4024, 0x09}, /* ANCHOR_RIGHT_START_H anchor_right_start[11:8] = 0x09 */
+	{0x4025, 0x60}, /* ANCHOR_RIGHT_START_L anchor_right_start[7:0] = 0x60 */
+	{0x4026, 0x09}, /* ANCHOR_RIGHT_END_H anchor_right_end[11:8] = 0x09 */
+	{0x4027, 0x6f}, /* ANCHOR_RIGHT_END_L anchor_right_end[7:0] = 0x6f */
+
+	/* ADC sync control */
+	{0x4500, 0x6c}, /* ADC_SYNC_CTRL */
+	{0x4503, 0x01}, /* ADC_SYNC_CTRL */
+
+	/* VFIFO */
+	{0x4601, 0xa7}, /* VFIFO_CTRL_01 r_vfifo_read_start[7:0] = 0xa7 */
+
+	/* Temperature monitor */
+	{0x4d00, 0x04}, /* TPM_CTRL_00 tmp_slope[15:8] = 0x04 */
+	{0x4d01, 0x42}, /* TPM_CTRL_01 tmp_slope[7:0] = 0x42 */
+	{0x4d02, 0xd1}, /* TPM_CTRL_02 tpm_offset[31:24] = 0xd1 */
+	{0x4d03, 0x93}, /* TPM_CTRL_03 tpm_offset[23:16] = 0x93 */
+	{0x4d04, 0xf5}, /* TPM_CTRL_04 tpm_offset[15:8]  = 0xf5 */
+	{0x4d05, 0xc1}, /* TPM_CTRL_05 tpm_offset[7:0]   = 0xc1 */
+
+	/* pre-ISP control */
+	{0x5050, 0x0c}, /* DEBUG_MODE */
+
+	/* OTP-DPC control */
+	{0x5501, 0x10}, /* OTP_DPC_START_L otp_start_address[7:0] = 0x10 */
+	{0x5503, 0x0f}, /* OTP_DPC_END_L otp_end_address[7:0] = 0x0f */
 	{REG_NULL, 0x00},
 };
 
-- 
2.43.0



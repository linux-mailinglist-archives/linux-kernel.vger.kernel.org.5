Return-Path: <linux-kernel+bounces-87112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A45586CFC6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B6C2866FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7453A7828D;
	Thu, 29 Feb 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3EW2Yn1"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC838757F3;
	Thu, 29 Feb 2024 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225638; cv=none; b=K1skiH/d4Am8B8085KID8Tx8BNbTkPV0sfiM2WLwnrE/KkMNM3V5Z6RSPYudX8ewwej2VPS8eblgMz+uoXINmetIfjhEMn/31FvOGBWItPmwmIEx961P+Z2qZ/Iq1oMnJidVegbQU6SsPpcnn/t18VeWjljFO3EaCbrqL6Ski4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225638; c=relaxed/simple;
	bh=lmFS16DLEvweY84g6ZsRhA8j45XGSzBWi6FzU2Tk8QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEQQFpUrVwasF/tTsmZfJ4J5Fsxa0QWy6TJtBpDBJdRZb3ylwJv/nDyJkbtJJ880H7dmBKrxJkfoVM4X8wUAb1i/Kv2cmqMvDGqSO/biDe3sLjBsHdWz4x6Kr4qus/M9rCbgvvKol5Q24fjPTSK66LwRV/bnKXzIZDfZeuVd2ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3EW2Yn1; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512bd533be0so1387519e87.0;
        Thu, 29 Feb 2024 08:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709225635; x=1709830435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRgS0UXYHPj1RQ/rJTomS6xIK9CdxCZ6J6KiJf7SUus=;
        b=L3EW2Yn1juzhTLAUt4FPSf9bd5Aw6dvHDMABEuO9c8nuTHDdA6N5ykl9Hz1+Aul+/w
         38Xho5TOpsR1r5VeNyE7RiDfRgjyKuU8r34gRjcAfm7UIs3DU3bMYD0L0b7WIUORYz/L
         +tDlAnU4De65+9fpPthilK8TIMUfe527c0kN4E5N4oQs6gy28Hif+xfi9Z+iDPHMnvxP
         gh/OBYWSu5Kg89QoAkejyIUq2wCAr2dusIsEiz1aq9vD+3RdFEWUV/c+T3cs2TZ7qDDL
         UV0be3P07LZMVpPJrMAx6tcl7KxtECwsZyOSRsoJPzuMhJzHpLXw24YOeYgltOkuyWp4
         XVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225635; x=1709830435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRgS0UXYHPj1RQ/rJTomS6xIK9CdxCZ6J6KiJf7SUus=;
        b=DbxcaUNes6RkjRpXj/4aOgXaiM9d5aWXl4fQC8/xlaH+VbWirZAQhd2eKl4Wy36B27
         Ag8HYjnZPdo/WGmH1y9GTHugoq82iZAEQH3FG8FIJJ8CWiKaiCSKxzuNGGnwAJ+qFZi4
         u61Czb6ZXPEKpQtzICXgrzA6nJwJ2rJRveaxigy5idAcJMiw5YwTUfSed4e7CxSqu5e9
         hIsub9MQCmVgwwnB5qxVd23jYKl0niiyTpXT1KnDmZVp9XiSdLU2c0koWjiSY0CCTOBB
         OE2cDR6NroLOPMBz3mxGgvlTngfL/bbeAPMyxb7dLGFCSBhkklbKz9kq1ISsrLZRcWps
         IeoA==
X-Forwarded-Encrypted: i=1; AJvYcCVX9+S8+B9yxZI8fbsjnHNSAhGWxLSqXxpO6sH/+ask0VJmVvefq1+UISQR7TJ/vX2A3S4SCg3I9XAldt1nGsPukgblfx+8yzlBgZdv
X-Gm-Message-State: AOJu0YzxOy0BIV3JQISNbidunc4BG8Xye5yCedJnlC1/v50PivwquhjP
	GpuBAa3l2tBGMHU6+SVFzPmMl/iHKoRv2Hr0x4sPGZl3TeuDNe/Is8xrqWu6yaA=
X-Google-Smtp-Source: AGHT+IEzBqLB+98tQIt10pO+oo/355mY4aAAk884okFArSwq1UAY60T9ZQ2keI5hzjUK3KGZhUjvUg==
X-Received: by 2002:a05:6512:2248:b0:513:23be:e924 with SMTP id i8-20020a056512224800b0051323bee924mr2290513lfu.59.1709225634880;
        Thu, 29 Feb 2024 08:53:54 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id h30-20020a19ca5e000000b005132996de60sm200348lfj.28.2024.02.29.08.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:53:54 -0800 (PST)
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
Subject: [PATCH v3 06/20] media: i2c: ov4689: Refactor ov4689_set_ctrl
Date: Thu, 29 Feb 2024 19:53:19 +0300
Message-ID: <20240229165333.227484-7-mike.rudenko@gmail.com>
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

Introduce local variable for regmap within the ov4689_set_ctrl
function. This adjustment eliminates repetition within the function.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 56bf1d964e43..1bc00404f3fb 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -580,10 +580,11 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct ov4689 *ov4689 =
 		container_of(ctrl->handler, struct ov4689, ctrl_handler);
+	struct regmap *regmap = ov4689->regmap;
 	struct device *dev = ov4689->dev;
 	int sensor_gain;
 	s64 max_expo;
-	int ret;
+	int ret = 0;
 
 	/* Propagate change of current control to all related controls */
 	switch (ctrl->id) {
@@ -603,16 +604,15 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 	switch (ctrl->id) {
 	case V4L2_CID_EXPOSURE:
 		/* 4 least significant bits of exposure are fractional part */
-		ret = cci_write(ov4689->regmap, OV4689_REG_EXPOSURE,
-				ctrl->val << 4, NULL);
+		cci_write(regmap, OV4689_REG_EXPOSURE, ctrl->val << 4, &ret);
 		break;
 	case V4L2_CID_ANALOGUE_GAIN:
 		ret = ov4689_map_gain(ov4689, ctrl->val, &sensor_gain);
-		cci_write(ov4689->regmap, OV4689_REG_GAIN, sensor_gain, &ret);
+		cci_write(regmap, OV4689_REG_GAIN, sensor_gain, &ret);
 		break;
 	case V4L2_CID_VBLANK:
-		ret = cci_write(ov4689->regmap, OV4689_REG_VTS,
-				ctrl->val + ov4689->cur_mode->height, NULL);
+		cci_write(regmap, OV4689_REG_VTS,
+			  ctrl->val + ov4689->cur_mode->height, &ret);
 		break;
 	case V4L2_CID_TEST_PATTERN:
 		ret = ov4689_enable_test_pattern(ov4689, ctrl->val);
-- 
2.43.0



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E423280D482
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345092AbjLKRvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345104AbjLKRup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:50:45 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA29AD0;
        Mon, 11 Dec 2023 09:50:51 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bf1e32571so5581961e87.2;
        Mon, 11 Dec 2023 09:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317049; x=1702921849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4fte2YHRSrHHN42OBWruBtaIGZ/SFtVFuhUHEuhcX8=;
        b=IqFLlH4hfcQN+nVLz+K238zJs287ZHvR6ddocANW7MKwC1bTrAp5lE/ASgXEyoUvQl
         oqEn1zXb5ta+5RjuYRJYTslbWIF26fWJwIcL6ap/MP/12dMZ0yHjQWgvRgygRFfwRMlX
         AYglRkXztW9Xk/JY6ZzssxWLtktBFOMc0oGesNzaD81QSLZ6Yr1FIV9YlZJ4ZROc6PaC
         5Naf2893cI63+ICan4gDM8BnyZ8e1tGTkQzOVOrC0/B/UPw8Y34mU1ow4s0Idtw0hdoO
         1rQd0Lr1voyFVAixcFPoObmOuywWf0qbZBlGPd6L/T9WI18C7t0ShOyOvhAhzYTqiBWZ
         hKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317049; x=1702921849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4fte2YHRSrHHN42OBWruBtaIGZ/SFtVFuhUHEuhcX8=;
        b=NtReQpCWkpf0gtZGwIPsPKvbmE8UgIlP1rvFea3DF+R4WWiw1xFsrmOLXN7T4yJYVg
         QRlEZkXI/q5UZP0zLiVgWGdO6vzYxSEEgwH4r2rulSMBTtEd8qqAJj6/ecHu+Ds1/WY1
         XlrUgCh+6mxSXthzasazIq/RBhsFh/+Czf8QFUN/G/33U9rroJf6SDzK8dON87ILJUle
         CP7M0R5c9NqwN9nRW+9LNjJ4feUAwAogal/O+UoaJnXwZmu0+gpKfOniIesJTPbxh+6C
         w7J3J0BmmqZSLAtD9tdbyyNRWoK13Za+qHLQEauB4LfWVN4wSbEe3fCoPm0sjhcDiTyT
         pxew==
X-Gm-Message-State: AOJu0YxuayilUJAFgHP0X0XA3uephF625qxtVnmVo9znGjKcLHwTbxfc
        IDGX91YZ6XrJV/IGMnELR3iNUtgtXch1/ozV
X-Google-Smtp-Source: AGHT+IF5X7lZC/m/xlcA22hSseem5KEqJ7lk6Q+Zx/IJMWZsJ4d2zmf8M/D4xSPXrwkgHBduCisf8Q==
X-Received: by 2002:ac2:5328:0:b0:50d:ff76:61ee with SMTP id f8-20020ac25328000000b0050dff7661eemr767800lfh.134.1702317049431;
        Mon, 11 Dec 2023 09:50:49 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id k4-20020a05651210c400b0050bef21a012sm1141582lfg.191.2023.12.11.09.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:50:48 -0800 (PST)
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
Subject: [PATCH 05/19] media: i2c: ov4689: Refactor ov4689_set_ctrl
Date:   Mon, 11 Dec 2023 20:50:08 +0300
Message-ID: <20231211175023.1680247-6-mike.rudenko@gmail.com>
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

Introduces local variables for regmap and the control value within the
ov4689_set_ctrl function. This adjustment eliminates repetition within
the function.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 8c120d7f7830..42700ecfbe0e 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -584,7 +584,9 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct ov4689 *ov4689 =
 		container_of(ctrl->handler, struct ov4689, ctrl_handler);
+	struct regmap *regmap = ov4689->regmap;
 	struct device *dev = ov4689->dev;
+	s32 val = ctrl->val;
 	int sensor_gain;
 	s64 max_expo;
 	int ret;
@@ -593,7 +595,7 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 	switch (ctrl->id) {
 	case V4L2_CID_VBLANK:
 		/* Update max exposure while meeting expected vblanking */
-		max_expo = ov4689->cur_mode->height + ctrl->val - 4;
+		max_expo = ov4689->cur_mode->height + val - 4;
 		__v4l2_ctrl_modify_range(ov4689->exposure,
 					 ov4689->exposure->minimum, max_expo,
 					 ov4689->exposure->step,
@@ -607,36 +609,34 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 	switch (ctrl->id) {
 	case V4L2_CID_EXPOSURE:
 		/* 4 least significant bits of exposure are fractional part */
-		ret = cci_write(ov4689->regmap, OV4689_REG_EXPOSURE,
-				ctrl->val << 4, NULL);
+		cci_write(regmap, OV4689_REG_EXPOSURE, val << 4, &ret);
 		break;
 	case V4L2_CID_ANALOGUE_GAIN:
-		ret = ov4689_map_gain(ov4689, ctrl->val, &sensor_gain);
+		ret = ov4689_map_gain(ov4689, val, &sensor_gain);
 
-		cci_write(ov4689->regmap, OV4689_REG_GAIN_H,
+		cci_write(regmap, OV4689_REG_GAIN_H,
 			  (sensor_gain >> OV4689_GAIN_H_SHIFT) &
 			  OV4689_GAIN_H_MASK, &ret);
 
-		cci_write(ov4689->regmap, OV4689_REG_GAIN_L,
+		cci_write(regmap, OV4689_REG_GAIN_L,
 			  sensor_gain & OV4689_GAIN_L_MASK,
 			  &ret);
 		break;
 	case V4L2_CID_VBLANK:
-		ret = cci_write(ov4689->regmap, OV4689_REG_VTS,
-				ctrl->val + ov4689->cur_mode->height, NULL);
+		cci_write(regmap, OV4689_REG_VTS,
+			  val + ov4689->cur_mode->height, &ret);
 		break;
 	case V4L2_CID_TEST_PATTERN:
-		ret = ov4689_enable_test_pattern(ov4689, ctrl->val);
+		ret = ov4689_enable_test_pattern(ov4689, val);
 		break;
 	default:
 		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
-			 __func__, ctrl->id, ctrl->val);
+			 __func__, ctrl->id, val);
 		ret = -EINVAL;
 		break;
 	}
 
 	pm_runtime_put(dev);
-
 	return ret;
 }
 
-- 
2.43.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32E380D483
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344801AbjLKRvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345103AbjLKRup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:50:45 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AFF93;
        Mon, 11 Dec 2023 09:50:50 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50be4f03b06so4519835e87.0;
        Mon, 11 Dec 2023 09:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317047; x=1702921847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jt3HgKogia1ukkriZaYijzD0Deb4LMT0CLdQl1sk2DA=;
        b=hHPlHfyw0AzvWUbPe8NBRnzUX0bJ2b0jN/eXDf5ikcbLDplZlZkaNcBuMnx5R0RiN7
         n8QT/9aOgZ/JwfQ/6fwM4E6KquAdwk6FjS1KapIrQ5T3tAhBNoWJL7JZgo+s7TpbHGq7
         fun6BBDgGSN5UFf8p7Jl/XVKRM4j5DGfUSKh+pDfVV0xWb4+gZe9GmQY/wZA2rqUO6Gt
         75JnzSVWloqDEgg7CMLB1YPf9/4soNSu+bi8dcizsA1QNE2enHfoAUw8Ytm1YUOH6/U+
         7gH13IcpJtEs4DkdEO2AmPABprukI0GRoRdL9yaJCkmGHwjZPXkbwCqHhSIqwCGeocLU
         3G2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317047; x=1702921847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jt3HgKogia1ukkriZaYijzD0Deb4LMT0CLdQl1sk2DA=;
        b=uwZ3f+Iim/pnlyckCHXK7D4VPQDIZGoORRbdho2rr7gvGPVayyBCIIfV85M0v5FH6E
         vQG2DQ4beOGHMBDOi6/Ahtzm7z4oBcXw8CvrlxLtxrXc9wFJ2H5yGYzm515+/hOevO30
         fBvZw/FWjL5cLGLpk7nHHVY7b9LrfaYnhfDrdBdwoPP0oSwRt+zjbIZJRx4x04iILDEm
         JATljndpdjGEM0naUziacI/gSuVtG0lcy+W0j+khnl06lALZut06M+xIsPuHCu+SLldJ
         AtD74XitGRydWgp6q//f13HyTYs0aHvyWsYXxlWoWfcI1vF5qMiLYgdkvF3PhaLI4Zsv
         GE0g==
X-Gm-Message-State: AOJu0YznVG4IdJ/iNLH3aEhVjLodC4u6mOy9irNVqPrA37TWM/lrmS6B
        9XS37Cwhc8PqMG3sguc1H5w0JJCXlIxiHOVN
X-Google-Smtp-Source: AGHT+IHGtRxg62XsLtnV8YDpkrlqiE8FmzxAdThxxu6GtQ+CP6LvFmkhtHLA9Y0xQg28KtVhJxxQoA==
X-Received: by 2002:ac2:5e3a:0:b0:50b:f30b:534d with SMTP id o26-20020ac25e3a000000b0050bf30b534dmr1323845lfg.57.1702317047409;
        Mon, 11 Dec 2023 09:50:47 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id i24-20020a0565123e1800b0050bfdc711b8sm1088996lfv.15.2023.12.11.09.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:50:46 -0800 (PST)
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
Subject: [PATCH 04/19] media: i2c: ov4689: Remove i2c_client from ov4689 struct
Date:   Mon, 11 Dec 2023 20:50:07 +0300
Message-ID: <20231211175023.1680247-5-mike.rudenko@gmail.com>
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

The 'client' field within the 'ov4689' structure is solely used to
access its 'dev' member. This commit removes the 'client' field and
directly stores a pointer to the 'struct device'.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 51a15810cb1d..8c120d7f7830 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -78,7 +78,7 @@ struct ov4689_mode {
 };
 
 struct ov4689 {
-	struct i2c_client *client;
+	struct device *dev;
 	struct regmap *regmap;
 	struct clk *xvclk;
 	struct gpio_desc *reset_gpio;
@@ -409,13 +409,13 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
 static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 {
 	struct ov4689 *ov4689 = to_ov4689(sd);
-	struct i2c_client *client = ov4689->client;
+	struct device *dev = ov4689->dev;
 	int ret = 0;
 
 	mutex_lock(&ov4689->mutex);
 
 	if (on) {
-		ret = pm_runtime_resume_and_get(&client->dev);
+		ret = pm_runtime_resume_and_get(dev);
 		if (ret < 0)
 			goto unlock_and_return;
 
@@ -424,26 +424,26 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 					  ov4689->cur_mode->num_regs,
 					  NULL);
 		if (ret) {
-			pm_runtime_put(&client->dev);
+			pm_runtime_put(dev);
 			goto unlock_and_return;
 		}
 
 		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
 		if (ret) {
-			pm_runtime_put(&client->dev);
+			pm_runtime_put(dev);
 			goto unlock_and_return;
 		}
 
 		ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
 				OV4689_MODE_STREAMING, NULL);
 		if (ret) {
-			pm_runtime_put(&client->dev);
+			pm_runtime_put(dev);
 			goto unlock_and_return;
 		}
 	} else {
 		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
 			  OV4689_MODE_SW_STANDBY, NULL);
-		pm_runtime_put(&client->dev);
+		pm_runtime_put(dev);
 	}
 
 unlock_and_return:
@@ -557,7 +557,6 @@ static const struct v4l2_subdev_ops ov4689_subdev_ops = {
  */
 static int ov4689_map_gain(struct ov4689 *ov4689, int logical_gain, int *result)
 {
-	const struct device *dev = &ov4689->client->dev;
 	const struct ov4689_gain_range *range;
 	unsigned int n;
 
@@ -568,7 +567,8 @@ static int ov4689_map_gain(struct ov4689 *ov4689, int logical_gain, int *result)
 	}
 
 	if (n == ARRAY_SIZE(ov4689_gain_ranges)) {
-		dev_warn_ratelimited(dev, "no mapping found for gain %d\n",
+		dev_warn_ratelimited(ov4689->dev,
+				     "no mapping found for gain %d\n",
 				     logical_gain);
 		return -EINVAL;
 	}
@@ -584,7 +584,7 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct ov4689 *ov4689 =
 		container_of(ctrl->handler, struct ov4689, ctrl_handler);
-	struct i2c_client *client = ov4689->client;
+	struct device *dev = ov4689->dev;
 	int sensor_gain;
 	s64 max_expo;
 	int ret;
@@ -601,7 +601,7 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
-	if (!pm_runtime_get_if_in_use(&client->dev))
+	if (!pm_runtime_get_if_in_use(dev))
 		return 0;
 
 	switch (ctrl->id) {
@@ -629,13 +629,13 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 		ret = ov4689_enable_test_pattern(ov4689, ctrl->val);
 		break;
 	default:
-		dev_warn(&client->dev, "%s Unhandled id:0x%x, val:0x%x\n",
+		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
 			 __func__, ctrl->id, ctrl->val);
 		ret = -EINVAL;
 		break;
 	}
 
-	pm_runtime_put(&client->dev);
+	pm_runtime_put(dev);
 
 	return ret;
 }
@@ -700,8 +700,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 
 	if (handler->error) {
 		ret = handler->error;
-		dev_err(&ov4689->client->dev, "Failed to init controls(%d)\n",
-			ret);
+		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);
 		goto err_free_handler;
 	}
 
@@ -727,7 +726,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 static int ov4689_check_sensor_id(struct ov4689 *ov4689,
 				  struct i2c_client *client)
 {
-	struct device *dev = &ov4689->client->dev;
+	struct device *dev = ov4689->dev;
 	u64 id = 0;
 	int ret;
 
@@ -755,7 +754,7 @@ static int ov4689_configure_regulators(struct ov4689 *ov4689)
 	for (i = 0; i < ARRAY_SIZE(ov4689_supply_names); i++)
 		ov4689->supplies[i].supply = ov4689_supply_names[i];
 
-	return devm_regulator_bulk_get(&ov4689->client->dev,
+	return devm_regulator_bulk_get(ov4689->dev,
 				       ARRAY_SIZE(ov4689_supply_names),
 				       ov4689->supplies);
 }
@@ -824,7 +823,8 @@ static int ov4689_probe(struct i2c_client *client)
 	if (!ov4689)
 		return -ENOMEM;
 
-	ov4689->client = client;
+	ov4689->dev = dev;
+
 	ov4689->cur_mode = &supported_modes[OV4689_MODE_2688_1520];
 
 	ov4689->xvclk = devm_clk_get_optional(dev, NULL);
-- 
2.43.0


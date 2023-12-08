Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1701080A6A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574208AbjLHPIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574178AbjLHPII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:08:08 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D19AF1;
        Fri,  8 Dec 2023 07:08:14 -0800 (PST)
Received: from umang.jain (unknown [103.251.226.108])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C23AEEEE;
        Fri,  8 Dec 2023 16:07:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1702048051;
        bh=SUi9QHBg3ssLxhypa1TBo31nHAR/h6rKQLwai92AHS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=efUR303hy79pBF81cYZCqrlnejeNnguQ9OCCXb52XQOfHrxOd22raF3aL/YRffUp4
         dTEJ1PCA4h5Om2LbxkudOAZAYi2SFfiESsPfZ0oH7fUH5ursZ8kjVsItkyxOs7gpKH
         17tHrS4TjvgkvazsBJYg94vXTqejgEOhQLGT5KMk=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     devicetree@vger.kernel.org, linux-media@vger.kernel.org
Cc:     "Paul J . Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/8] media: i2c: imx335: Enable regulator supplies
Date:   Fri,  8 Dec 2023 20:37:50 +0530
Message-ID: <20231208150756.124720-5-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231208150756.124720-1-umang.jain@ideasonboard.com>
References: <20231208150756.124720-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kieran Bingham <kieran.bingham@ideasonboard.com>

Provide support for enabling and disabling regulator supplies to control
power to the camera sensor.

While updating the power on function, document that a sleep is
represented as 'T4' in the datasheet power on sequence.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 31c612c6bdd8..b25216b3350e 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -75,6 +75,12 @@ struct imx335_reg_list {
 	const struct imx335_reg *regs;
 };
 
+static const char * const imx335_supply_name[] = {
+	"avdd", /* Analog (2.9V) supply */
+	"ovdd", /* Digital I/O (1.8V) supply */
+	"dvdd", /* Digital Core (1.2V) supply */
+};
+
 /**
  * struct imx335_mode - imx335 sensor mode structure
  * @width: Frame width
@@ -108,6 +114,7 @@ struct imx335_mode {
  * @sd: V4L2 sub-device
  * @pad: Media pad. Only one pad supported
  * @reset_gpio: Sensor reset gpio
+ * @supplies: Regulator supplies to handle power control
  * @inclk: Sensor input clock
  * @ctrl_handler: V4L2 control handler
  * @link_freq_ctrl: Pointer to link frequency control
@@ -126,6 +133,8 @@ struct imx335 {
 	struct v4l2_subdev sd;
 	struct media_pad pad;
 	struct gpio_desc *reset_gpio;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(imx335_supply_name)];
+
 	struct clk *inclk;
 	struct v4l2_ctrl_handler ctrl_handler;
 	struct v4l2_ctrl *link_freq_ctrl;
@@ -781,6 +790,17 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
 		return PTR_ERR(imx335->reset_gpio);
 	}
 
+	for (i = 0; i < ARRAY_SIZE(imx335_supply_name); i++)
+		imx335->supplies[i].supply = imx335_supply_name[i];
+
+	ret = devm_regulator_bulk_get(imx335->dev,
+				      ARRAY_SIZE(imx335_supply_name),
+				      imx335->supplies);
+	if (ret) {
+		dev_err(imx335->dev, "Failed to get regulators\n");
+		return ret;
+	}
+
 	/* Get sensor input clock */
 	imx335->inclk = devm_clk_get(imx335->dev, NULL);
 	if (IS_ERR(imx335->inclk)) {
@@ -863,6 +883,17 @@ static int imx335_power_on(struct device *dev)
 	struct imx335 *imx335 = to_imx335(sd);
 	int ret;
 
+	ret = regulator_bulk_enable(ARRAY_SIZE(imx335_supply_name),
+				    imx335->supplies);
+	if (ret) {
+		dev_err(dev, "%s: failed to enable regulators\n",
+			__func__);
+		return ret;
+	}
+
+	usleep_range(500, 550); /* Tlow */
+
+	/* Set XCLR */
 	gpiod_set_value_cansleep(imx335->reset_gpio, 1);
 
 	ret = clk_prepare_enable(imx335->inclk);
@@ -871,12 +902,13 @@ static int imx335_power_on(struct device *dev)
 		goto error_reset;
 	}
 
-	usleep_range(20, 22);
+	usleep_range(20, 22); /* T4 */
 
 	return 0;
 
 error_reset:
 	gpiod_set_value_cansleep(imx335->reset_gpio, 0);
+	regulator_bulk_disable(ARRAY_SIZE(imx335_supply_name), imx335->supplies);
 
 	return ret;
 }
@@ -893,8 +925,8 @@ static int imx335_power_off(struct device *dev)
 	struct imx335 *imx335 = to_imx335(sd);
 
 	gpiod_set_value_cansleep(imx335->reset_gpio, 0);
-
 	clk_disable_unprepare(imx335->inclk);
+	regulator_bulk_disable(ARRAY_SIZE(imx335_supply_name), imx335->supplies);
 
 	return 0;
 }
-- 
2.41.0


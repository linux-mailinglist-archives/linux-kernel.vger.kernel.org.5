Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D577BEFF8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379296AbjJJAvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379274AbjJJAvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:51:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22973EB;
        Mon,  9 Oct 2023 17:51:38 -0700 (PDT)
Received: from Monstersaurus.local (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1BBB3EF2;
        Tue, 10 Oct 2023 02:51:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1696899093;
        bh=rnMJgKFBWGCjiyhcMU2IuGY2WEmrwzEZzGWN5THJvAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CK46n6zV6Xh9jK/5YUIjEJ4q7bl6SZiYuDbASL3wtLglk7WEJc01WpilsbssmYsII
         1cEdcpA/7IYdbIkV9HKVgCI4cjg3KyG35dvO/gKOfp/HIMrb+MLOflsJ2u4RU/9uCS
         yZNijO2DAel4XvrixE/Cds6c13aiAi6j114HS0N4=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] media: i2c: imx335: Enable regulator supplies
Date:   Tue, 10 Oct 2023 01:51:23 +0100
Message-Id: <20231010005126.3425444-3-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010005126.3425444-1-kieran.bingham@ideasonboard.com>
References: <20231010005126.3425444-1-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide support for enabling and disabling regulator supplies to control
power to the camera sensor.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 41 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index ec729126274b..bf12b9b69fce 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -75,6 +75,19 @@ struct imx335_reg_list {
 	const struct imx335_reg *regs;
 };
 
+static const char * const imx335_supply_name[] = {
+	/*
+	 * Turn on the power supplies so that they rise in order of
+	 *           1.2v,-> 1.8 -> 2.9v
+	 * All power supplies should finish rising within 200ms.
+	 */
+	"avdd", /* Analog (2.9V) supply */
+	"ovdd", /* Digital I/O (1.8V) supply */
+	"dvdd", /* Digital Core (1.2V) supply */
+};
+
+#define IMX335_NUM_SUPPLIES ARRAY_SIZE(imx335_supply_name)
+
 /**
  * struct imx335_mode - imx335 sensor mode structure
  * @width: Frame width
@@ -126,6 +139,8 @@ struct imx335 {
 	struct v4l2_subdev sd;
 	struct media_pad pad;
 	struct gpio_desc *reset_gpio;
+	struct regulator_bulk_data supplies[IMX335_NUM_SUPPLIES];
+
 	struct clk *inclk;
 	struct v4l2_ctrl_handler ctrl_handler;
 	struct v4l2_ctrl *link_freq_ctrl;
@@ -781,6 +796,17 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
 		return PTR_ERR(imx335->reset_gpio);
 	}
 
+	for (i = 0; i < IMX335_NUM_SUPPLIES; i++)
+		imx335->supplies[i].supply = imx335_supply_name[i];
+
+	ret = devm_regulator_bulk_get(imx335->dev,
+				      IMX335_NUM_SUPPLIES,
+				      imx335->supplies);
+	if (ret) {
+		dev_err(imx335->dev, "Failed to get regulators\n");
+		return ret;
+	}
+
 	/* Get sensor input clock */
 	imx335->inclk = devm_clk_get(imx335->dev, NULL);
 	if (IS_ERR(imx335->inclk)) {
@@ -859,6 +885,17 @@ static int imx335_power_on(struct device *dev)
 	struct imx335 *imx335 = to_imx335(sd);
 	int ret;
 
+	ret = regulator_bulk_enable(IMX335_NUM_SUPPLIES,
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
@@ -867,7 +904,7 @@ static int imx335_power_on(struct device *dev)
 		goto error_reset;
 	}
 
-	usleep_range(20, 22);
+	usleep_range(20, 22); /* T4 */
 
 	return 0;
 
@@ -889,8 +926,8 @@ static int imx335_power_off(struct device *dev)
 	struct imx335 *imx335 = to_imx335(sd);
 
 	gpiod_set_value_cansleep(imx335->reset_gpio, 0);
-
 	clk_disable_unprepare(imx335->inclk);
+	regulator_bulk_disable(IMX335_NUM_SUPPLIES, imx335->supplies);
 
 	return 0;
 }
-- 
2.34.1


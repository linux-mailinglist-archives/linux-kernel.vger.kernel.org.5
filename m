Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4324E80125C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379131AbjLASOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjLASOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:14:33 -0500
Received: from mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F93115;
        Fri,  1 Dec 2023 10:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1701454445; bh=LBso1uZhHt0uj5YhUuRR61vXVMULnFH6NsONGw2NEpk=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=VzgnDh5cI26kRDOulJEMi02YIIyNrzJ3ySeNexSc/p1u7r2U4dwxJ31HIWRuhaFQD
         ZaQM6REfkb/qpTcOW0/PXM9B/cFAwuKpUX3648ga17RiHjCgDtIsYhdJ+xiL5qEQ43
         44RI3fMMA/BAf/vGhC+cmfin6YfC8T4hKmBELb+U=
Received: by b221-6.in.mailobj.net [192.168.90.26] with ESMTP
        via ip-22.mailoo.org [213.182.54.22]
        Fri,  1 Dec 2023 19:14:05 +0100 (CET)
X-EA-Auth: wNN2j8v31ubmgWDts7TwNENjNsL7Af2Gz0y4d8MH0A1gYp9Tuc3v3G/ajOExFuYGjL6GItXot7p09v0A44vJjZemqAufFNdp3DcCh2bFGbs=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v2 1/3] media: i2c: ak7375: Prepare for supporting another chip
Date:   Fri,  1 Dec 2023 19:13:48 +0100
Message-ID: <20231201181350.26454-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In view of adding support for at least one other chip,
change the driver to move chip-specific properties and
values in a common structure.

No functional changes.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
v2: no change
---
 drivers/media/i2c/ak7375.c | 110 ++++++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 44 deletions(-)

diff --git a/drivers/media/i2c/ak7375.c b/drivers/media/i2c/ak7375.c
index 463b51d46320..3a14eff41531 100644
--- a/drivers/media/i2c/ak7375.c
+++ b/drivers/media/i2c/ak7375.c
@@ -10,30 +10,45 @@
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
 
-#define AK7375_MAX_FOCUS_POS	4095
-/*
- * This sets the minimum granularity for the focus positions.
- * A value of 1 gives maximum accuracy for a desired focus position
- */
-#define AK7375_FOCUS_STEPS	1
-/*
- * This acts as the minimum granularity of lens movement.
- * Keep this value power of 2, so the control steps can be
- * uniformly adjusted for gradual lens movement, with desired
- * number of control steps.
- */
-#define AK7375_CTRL_STEPS	64
-#define AK7375_CTRL_DELAY_US	1000
-/*
- * The vcm may take up 10 ms (tDELAY) to power on and start taking
- * I2C messages. Based on AK7371 datasheet.
- */
-#define AK7375_POWER_DELAY_US	10000
+struct ak73xx_chipdef {
+	u8 reg_position;
+	u8 reg_cont;
+	u8 shift_pos;
+	u8 mode_active;
+	u8 mode_standby;
+	u16 focus_pos_max;
+	/*
+	 * This sets the minimum granularity for the focus positions.
+	 * A value of 1 gives maximum accuracy for a desired focus position
+	 */
+	u16 focus_steps;
+	/*
+	 * This acts as the minimum granularity of lens movement.
+	 * Keep this value power of 2, so the control steps can be
+	 * uniformly adjusted for gradual lens movement, with desired
+	 * number of control steps.
+	 */
+	u16 ctrl_steps;
+	u16 ctrl_delay_us;
+	/*
+	 * The vcm may take time (tDELAY) to power on and start taking
+	 * I2C messages.
+	 */
+	u16 power_delay_us;
+};
 
-#define AK7375_REG_POSITION	0x0
-#define AK7375_REG_CONT		0x2
-#define AK7375_MODE_ACTIVE	0x0
-#define AK7375_MODE_STANDBY	0x40
+static const struct ak73xx_chipdef ak7375_cdef = {
+	.reg_position	= 0x0,
+	.reg_cont	= 0x2,
+	.shift_pos	= 4,	/* 12 bits position values, need to << 4 */
+	.mode_active	= 0x0,
+	.mode_standby	= 0x40,
+	.focus_pos_max	= 4095,
+	.focus_steps	= 1,
+	.ctrl_steps	= 64,
+	.ctrl_delay_us	= 1000,
+	.power_delay_us	= 10000,
+};
 
 static const char * const ak7375_supply_names[] = {
 	"vdd",
@@ -42,6 +57,7 @@ static const char * const ak7375_supply_names[] = {
 
 /* ak7375 device structure */
 struct ak7375_device {
+	const struct ak73xx_chipdef *cdef;
 	struct v4l2_ctrl_handler ctrls_vcm;
 	struct v4l2_subdev sd;
 	struct v4l2_ctrl *focus;
@@ -86,10 +102,11 @@ static int ak7375_i2c_write(struct ak7375_device *ak7375,
 static int ak7375_set_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct ak7375_device *dev_vcm = to_ak7375_vcm(ctrl);
+	const struct ak73xx_chipdef *cdef = dev_vcm->cdef;
 
 	if (ctrl->id == V4L2_CID_FOCUS_ABSOLUTE)
-		return ak7375_i2c_write(dev_vcm, AK7375_REG_POSITION,
-					ctrl->val << 4, 2);
+		return ak7375_i2c_write(dev_vcm, cdef->reg_position,
+					ctrl->val << cdef->shift_pos, 2);
 
 	return -EINVAL;
 }
@@ -128,11 +145,12 @@ static int ak7375_init_controls(struct ak7375_device *dev_vcm)
 {
 	struct v4l2_ctrl_handler *hdl = &dev_vcm->ctrls_vcm;
 	const struct v4l2_ctrl_ops *ops = &ak7375_vcm_ctrl_ops;
+	const struct ak73xx_chipdef *cdef = dev_vcm->cdef;
 
 	v4l2_ctrl_handler_init(hdl, 1);
 
 	dev_vcm->focus = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_FOCUS_ABSOLUTE,
-		0, AK7375_MAX_FOCUS_POS, AK7375_FOCUS_STEPS, 0);
+		0, cdef->focus_pos_max, cdef->focus_steps, 0);
 
 	if (hdl->error)
 		dev_err(dev_vcm->sd.dev, "%s fail error: 0x%x\n",
@@ -153,6 +171,8 @@ static int ak7375_probe(struct i2c_client *client)
 	if (!ak7375_dev)
 		return -ENOMEM;
 
+	ak7375_dev->cdef = device_get_match_data(&client->dev);
+
 	for (i = 0; i < ARRAY_SIZE(ak7375_supply_names); i++)
 		ak7375_dev->supplies[i].supply = ak7375_supply_names[i];
 
@@ -206,30 +226,31 @@ static void ak7375_remove(struct i2c_client *client)
 
 /*
  * This function sets the vcm position, so it consumes least current
- * The lens position is gradually moved in units of AK7375_CTRL_STEPS,
+ * The lens position is gradually moved in units of ctrl_steps,
  * to make the movements smoothly.
  */
 static int __maybe_unused ak7375_vcm_suspend(struct device *dev)
 {
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct ak7375_device *ak7375_dev = sd_to_ak7375_vcm(sd);
+	const struct ak73xx_chipdef *cdef = ak7375_dev->cdef;
 	int ret, val;
 
 	if (!ak7375_dev->active)
 		return 0;
 
-	for (val = ak7375_dev->focus->val & ~(AK7375_CTRL_STEPS - 1);
-	     val >= 0; val -= AK7375_CTRL_STEPS) {
-		ret = ak7375_i2c_write(ak7375_dev, AK7375_REG_POSITION,
-				       val << 4, 2);
+	for (val = ak7375_dev->focus->val & ~(cdef->ctrl_steps - 1);
+	     val >= 0; val -= cdef->ctrl_steps) {
+		ret = ak7375_i2c_write(ak7375_dev, cdef->reg_position,
+				       val << cdef->shift_pos, 2);
 		if (ret)
 			dev_err_once(dev, "%s I2C failure: %d\n",
 				     __func__, ret);
-		usleep_range(AK7375_CTRL_DELAY_US, AK7375_CTRL_DELAY_US + 10);
+		usleep_range(cdef->ctrl_delay_us, cdef->ctrl_delay_us + 10);
 	}
 
-	ret = ak7375_i2c_write(ak7375_dev, AK7375_REG_CONT,
-			       AK7375_MODE_STANDBY, 1);
+	ret = ak7375_i2c_write(ak7375_dev, cdef->reg_cont,
+			       cdef->mode_standby, 1);
 	if (ret)
 		dev_err(dev, "%s I2C failure: %d\n", __func__, ret);
 
@@ -246,13 +267,14 @@ static int __maybe_unused ak7375_vcm_suspend(struct device *dev)
 /*
  * This function sets the vcm position to the value set by the user
  * through v4l2_ctrl_ops s_ctrl handler
- * The lens position is gradually moved in units of AK7375_CTRL_STEPS,
+ * The lens position is gradually moved in units of ctrl_steps,
  * to make the movements smoothly.
  */
 static int __maybe_unused ak7375_vcm_resume(struct device *dev)
 {
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct ak7375_device *ak7375_dev = sd_to_ak7375_vcm(sd);
+	const struct ak73xx_chipdef *cdef = ak7375_dev->cdef;
 	int ret, val;
 
 	if (ak7375_dev->active)
@@ -264,24 +286,24 @@ static int __maybe_unused ak7375_vcm_resume(struct device *dev)
 		return ret;
 
 	/* Wait for vcm to become ready */
-	usleep_range(AK7375_POWER_DELAY_US, AK7375_POWER_DELAY_US + 500);
+	usleep_range(cdef->power_delay_us, cdef->power_delay_us + 500);
 
-	ret = ak7375_i2c_write(ak7375_dev, AK7375_REG_CONT,
-		AK7375_MODE_ACTIVE, 1);
+	ret = ak7375_i2c_write(ak7375_dev, cdef->reg_cont,
+			       cdef->mode_active, 1);
 	if (ret) {
 		dev_err(dev, "%s I2C failure: %d\n", __func__, ret);
 		return ret;
 	}
 
-	for (val = ak7375_dev->focus->val % AK7375_CTRL_STEPS;
+	for (val = ak7375_dev->focus->val % cdef->ctrl_steps;
 	     val <= ak7375_dev->focus->val;
-	     val += AK7375_CTRL_STEPS) {
-		ret = ak7375_i2c_write(ak7375_dev, AK7375_REG_POSITION,
-				       val << 4, 2);
+	     val += cdef->ctrl_steps) {
+		ret = ak7375_i2c_write(ak7375_dev, cdef->reg_position,
+				       val << cdef->shift_pos, 2);
 		if (ret)
 			dev_err_ratelimited(dev, "%s I2C failure: %d\n",
 						__func__, ret);
-		usleep_range(AK7375_CTRL_DELAY_US, AK7375_CTRL_DELAY_US + 10);
+		usleep_range(cdef->ctrl_delay_us, cdef->ctrl_delay_us + 10);
 	}
 
 	ak7375_dev->active = true;
@@ -290,7 +312,7 @@ static int __maybe_unused ak7375_vcm_resume(struct device *dev)
 }
 
 static const struct of_device_id ak7375_of_table[] = {
-	{ .compatible = "asahi-kasei,ak7375" },
+	{ .compatible = "asahi-kasei,ak7375", .data = &ak7375_cdef, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ak7375_of_table);
-- 
2.43.0




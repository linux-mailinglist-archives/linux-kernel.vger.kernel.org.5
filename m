Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9BE7DA575
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 09:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjJ1HTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 03:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjJ1HSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 03:18:49 -0400
Received: from smtprelay08.ispgateway.de (smtprelay08.ispgateway.de [134.119.228.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C95C11B;
        Sat, 28 Oct 2023 00:18:45 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay08.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1qwdak-0002T7-1M;
        Sat, 28 Oct 2023 09:18:42 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Date:   Sat, 28 Oct 2023 09:17:44 +0200
Subject: [PATCH v2 1/5] media: i2c: imx214: Explain some magic numbers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231028-imx214-v2-1-69a8fb730d6e@apitzsch.eu>
References: <20231028-imx214-v2-0-69a8fb730d6e@apitzsch.eu>
In-Reply-To: <20231028-imx214-v2-0-69a8fb730d6e@apitzsch.eu>
To:     Ricardo Ribalda <ribalda@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.3
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code refinement, no functional changes.

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 drivers/media/i2c/imx214.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 4f77ea02cc27..1c30f6666d35 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -19,12 +19,23 @@
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-subdev.h>
 
+#define IMX214_REG_MODE_SELECT		0x0100
+#define IMX214_MODE_STANDBY		0x00
+#define IMX214_MODE_STREAMING		0x01
+
 #define IMX214_DEFAULT_CLK_FREQ	24000000
 #define IMX214_DEFAULT_LINK_FREQ 480000000
 #define IMX214_DEFAULT_PIXEL_RATE ((IMX214_DEFAULT_LINK_FREQ * 8LL) / 10)
 #define IMX214_FPS 30
 #define IMX214_MBUS_CODE MEDIA_BUS_FMT_SRGGB10_1X10
 
+/* Exposure control */
+#define IMX214_REG_EXPOSURE		0x0202
+#define IMX214_EXPOSURE_MIN		0
+#define IMX214_EXPOSURE_MAX		3184
+#define IMX214_EXPOSURE_STEP		1
+#define IMX214_EXPOSURE_DEFAULT		3184
+
 static const char * const imx214_supply_name[] = {
 	"vdda",
 	"vddd",
@@ -665,7 +676,7 @@ static int imx214_set_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_EXPOSURE:
 		vals[1] = ctrl->val;
 		vals[0] = ctrl->val >> 8;
-		ret = regmap_bulk_write(imx214->regmap, 0x202, vals, 2);
+		ret = regmap_bulk_write(imx214->regmap, IMX214_REG_EXPOSURE, vals, 2);
 		if (ret < 0)
 			dev_err(imx214->dev, "Error %d\n", ret);
 		ret = 0;
@@ -743,7 +754,7 @@ static int imx214_start_streaming(struct imx214 *imx214)
 		dev_err(imx214->dev, "could not sync v4l2 controls\n");
 		goto error;
 	}
-	ret = regmap_write(imx214->regmap, 0x100, 1);
+	ret = regmap_write(imx214->regmap, IMX214_REG_MODE_SELECT, IMX214_MODE_STREAMING);
 	if (ret < 0) {
 		dev_err(imx214->dev, "could not sent start table %d\n", ret);
 		goto error;
@@ -761,7 +772,7 @@ static int imx214_stop_streaming(struct imx214 *imx214)
 {
 	int ret;
 
-	ret = regmap_write(imx214->regmap, 0x100, 0);
+	ret = regmap_write(imx214->regmap, IMX214_REG_MODE_SELECT, IMX214_MODE_STANDBY);
 	if (ret < 0)
 		dev_err(imx214->dev, "could not sent stop table %d\n",	ret);
 
@@ -991,9 +1002,12 @@ static int imx214_probe(struct i2c_client *client)
 	 *
 	 * Yours sincerely, Ricardo.
 	 */
-	imx214->exposure = v4l2_ctrl_new_std(&imx214->ctrls, &imx214_ctrl_ops,
+	imx214->exposure = v4l2_ctrl_new_std(ctrl_hdlr, &imx214_ctrl_ops,
 					     V4L2_CID_EXPOSURE,
-					     0, 3184, 1, 0x0c70);
+					     IMX214_EXPOSURE_MIN,
+					     IMX214_EXPOSURE_MAX,
+					     IMX214_EXPOSURE_STEP,
+					     IMX214_EXPOSURE_DEFAULT);
 
 	imx214->unit_size = v4l2_ctrl_new_std_compound(&imx214->ctrls,
 				NULL,

-- 
2.42.0


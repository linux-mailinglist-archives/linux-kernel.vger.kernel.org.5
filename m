Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E34177042B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjHDPPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjHDPPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:15:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB2846B2;
        Fri,  4 Aug 2023 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691162119; x=1722698119;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=atf6awQZSaLep4xKPbRypTbT3WBxXblEP6kiO8HAjXs=;
  b=kEAHQwNrbR2VvfZ3fxQZdL4/bkvzoIf7k/5U54GcL7/DhszfpA1wIDJQ
   7wbO3xfIS9ko7teYq+7PZ2sB8/am2O7Xv+J1pUH9lWOCAbKx1GeEkuv2m
   mFavwuHGYfgL2DtopfKW3gL+Br3qTGmPkpQSEY2+r/Y1J2IKQyTtKRNVT
   HVfS6BJRq1fCFodmccg8o6GldlwVNN+SBTH0VSvwRPnEPU5HXopTQsHrc
   srMBTbZcGz6UVxAnTWktoFoJJvYBPYxeeCsE3Ewhw5hxRr7m9Rj8uGulA
   sc2r1jza6/C4Ig2tBWmfJcOVrA5pAyKyV3WdEvolo4oXrWLkxWMSnKX2c
   g==;
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="228222022"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2023 08:15:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 4 Aug 2023 08:15:18 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 4 Aug 2023 08:15:15 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>
CC:     <sakari.ailus@iki.fi>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Shravan Chippa <shravan.chippa@microchip.com>
Subject: [PATCH v2] media: i2c: imx334: add support for test pattern generator
Date:   Fri, 4 Aug 2023 20:45:41 +0530
Message-ID: <20230804151541.3162667-1-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

Add support for the imx334's test pattern generator.
By default the test pattern generator is disabled, so add support for
enabling and disabling horizontal and vertical colour bars.

Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 drivers/media/i2c/imx334.c | 57 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
index d722c9b7cd31..91c79af70734 100644
--- a/drivers/media/i2c/imx334.c
+++ b/drivers/media/i2c/imx334.c
@@ -56,6 +56,24 @@
 #define IMX334_REG_MIN		0x00
 #define IMX334_REG_MAX		0xfffff
 
+/* Test Pattern Control */
+#define IMX334_REG_TP		0x329e
+#define IMX334_TP_COLOR_HBARS	0xA
+#define IMX334_TP_COLOR_VBARS	0xB
+
+#define IMX334_TPG_EN_DOUT	0x329c
+#define IMX334_TP_ENABLE	0x1
+#define IMX334_TP_DISABLE	0x0
+
+#define IMX334_TPG_COLORW	0x32a0
+#define IMX334_TPG_COLORW_120P	0x13
+
+#define IMX334_TP_CLK_EN	0x3148
+#define IMX334_TP_CLK_EN_VAL	0x10
+#define IMX334_TP_CLK_DIS_VAL	0x0
+
+#define IMX334_DIG_CLP_MODE	0x3280
+
 /**
  * struct imx334_reg - imx334 sensor register
  * @address: Register address
@@ -430,6 +448,18 @@ static const struct imx334_reg mode_3840x2160_regs[] = {
 	{0x3a29, 0x00},
 };
 
+static const char * const imx334_test_pattern_menu[] = {
+	"Disabled",
+	"Vertical Color Bars",
+	"Horizontal Color Bars",
+};
+
+static const int imx334_test_pattern_val[] = {
+	IMX334_TP_DISABLE,
+	IMX334_TP_COLOR_HBARS,
+	IMX334_TP_COLOR_VBARS,
+};
+
 static const struct imx334_reg raw10_framefmt_regs[] = {
 	{0x3050, 0x00},
 	{0x319d, 0x00},
@@ -716,6 +746,26 @@ static int imx334_set_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_HBLANK:
 		ret = 0;
 		break;
+	case V4L2_CID_TEST_PATTERN:
+		if (ctrl->val) {
+			imx334_write_reg(imx334, IMX334_TP_CLK_EN, 1,
+					 IMX334_TP_CLK_EN_VAL);
+			imx334_write_reg(imx334, IMX334_DIG_CLP_MODE, 1, 0x0);
+			imx334_write_reg(imx334, IMX334_TPG_COLORW, 1,
+					 IMX334_TPG_COLORW_120P);
+			imx334_write_reg(imx334, IMX334_REG_TP, 1,
+					 imx334_test_pattern_val[ctrl->val]);
+			imx334_write_reg(imx334, IMX334_TPG_EN_DOUT, 1,
+					 IMX334_TP_ENABLE);
+		} else {
+			imx334_write_reg(imx334, IMX334_DIG_CLP_MODE, 1, 0x1);
+			imx334_write_reg(imx334, IMX334_TP_CLK_EN, 1,
+					 IMX334_TP_CLK_DIS_VAL);
+			imx334_write_reg(imx334, IMX334_TPG_EN_DOUT, 1,
+					 IMX334_TP_DISABLE);
+		}
+		ret = 0;
+		break;
 	default:
 		dev_err(imx334->dev, "Invalid control %d", ctrl->id);
 		ret = -EINVAL;
@@ -1222,7 +1272,7 @@ static int imx334_init_controls(struct imx334 *imx334)
 	u32 lpfr;
 	int ret;
 
-	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 6);
+	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 7);
 	if (ret)
 		return ret;
 
@@ -1282,6 +1332,11 @@ static int imx334_init_controls(struct imx334 *imx334)
 	if (imx334->hblank_ctrl)
 		imx334->hblank_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
+	v4l2_ctrl_new_std_menu_items(ctrl_hdlr, &imx334_ctrl_ops,
+				     V4L2_CID_TEST_PATTERN,
+				     ARRAY_SIZE(imx334_test_pattern_menu) - 1,
+				     0, 0, imx334_test_pattern_menu);
+
 	if (ctrl_hdlr->error) {
 		dev_err(imx334->dev, "control init failed: %d",
 			ctrl_hdlr->error);
-- 
2.34.1


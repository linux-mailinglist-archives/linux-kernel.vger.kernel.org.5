Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB14807B86
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377604AbjLFWjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377507AbjLFWjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:39:31 -0500
Received: from smtprelay03.ispgateway.de (smtprelay03.ispgateway.de [80.67.31.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9366D5B;
        Wed,  6 Dec 2023 14:39:37 -0800 (PST)
Received: from [92.206.191.209] (helo=note-book.lan)
        by smtprelay03.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1rB0TI-0007Ur-2A;
        Wed, 06 Dec 2023 23:34:24 +0100
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Date:   Wed, 06 Dec 2023 23:33:58 +0100
Subject: [PATCH v4 4/4] media: i2c: imx214: Add sensor's pixel matrix size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231206-imx214-v4-4-7ef604b01dcb@apitzsch.eu>
References: <20231206-imx214-v4-0-7ef604b01dcb@apitzsch.eu>
In-Reply-To: <20231206-imx214-v4-0-7ef604b01dcb@apitzsch.eu>
To:     Ricardo Ribalda <ribalda@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.12.4
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set effective and active sensor pixel sizes as shown in product
brief[1].

[1]: https://www.mouser.com/datasheet/2/897/ProductBrief_IMX214_20150428-1289331.pdf

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 drivers/media/i2c/imx214.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 132267e3a8f5..d67b5b928b9d 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -36,6 +36,14 @@
 #define IMX214_EXPOSURE_STEP		1
 #define IMX214_EXPOSURE_DEFAULT		3184
 
+/* IMX214 native and active pixel array size */
+#define IMX214_NATIVE_WIDTH		4224U
+#define IMX214_NATIVE_HEIGHT		3136U
+#define IMX214_PIXEL_ARRAY_LEFT		8U
+#define IMX214_PIXEL_ARRAY_TOP		8U
+#define IMX214_PIXEL_ARRAY_WIDTH	4208U
+#define IMX214_PIXEL_ARRAY_HEIGHT	3120U
+
 static const char * const imx214_supply_name[] = {
 	"vdda",
 	"vddd",
@@ -634,14 +642,31 @@ static int imx214_get_selection(struct v4l2_subdev *sd,
 {
 	struct imx214 *imx214 = to_imx214(sd);
 
-	if (sel->target != V4L2_SEL_TGT_CROP)
-		return -EINVAL;
+	switch (sel->target) {
+	case V4L2_SEL_TGT_CROP:
+		mutex_lock(&imx214->mutex);
+		sel->r = *__imx214_get_pad_crop(imx214, sd_state, sel->pad,
+						sel->which);
+		mutex_unlock(&imx214->mutex);
+		return 0;
 
-	mutex_lock(&imx214->mutex);
-	sel->r = *__imx214_get_pad_crop(imx214, sd_state, sel->pad,
-					sel->which);
-	mutex_unlock(&imx214->mutex);
-	return 0;
+	case V4L2_SEL_TGT_NATIVE_SIZE:
+		sel->r.top = 0;
+		sel->r.left = 0;
+		sel->r.width = IMX214_NATIVE_WIDTH;
+		sel->r.height = IMX214_NATIVE_HEIGHT;
+		return 0;
+
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+		sel->r.top = IMX214_PIXEL_ARRAY_TOP;
+		sel->r.left = IMX214_PIXEL_ARRAY_LEFT;
+		sel->r.width = IMX214_PIXEL_ARRAY_WIDTH;
+		sel->r.height = IMX214_PIXEL_ARRAY_HEIGHT;
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 static int imx214_entity_init_cfg(struct v4l2_subdev *subdev,

-- 
2.43.0


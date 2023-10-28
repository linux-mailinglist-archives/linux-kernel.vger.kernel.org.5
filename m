Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B77F7DA576
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 09:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjJ1HTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 03:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ1HSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 03:18:54 -0400
Received: from smtprelay08.ispgateway.de (smtprelay08.ispgateway.de [134.119.228.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6950B126;
        Sat, 28 Oct 2023 00:18:46 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay08.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1qwdal-0002T7-1R;
        Sat, 28 Oct 2023 09:18:43 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Date:   Sat, 28 Oct 2023 09:17:47 +0200
Subject: [PATCH v2 4/5] media: i2c: imx214: Add sensor's pixel matrix size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231028-imx214-v2-4-69a8fb730d6e@apitzsch.eu>
References: <20231028-imx214-v2-0-69a8fb730d6e@apitzsch.eu>
In-Reply-To: <20231028-imx214-v2-0-69a8fb730d6e@apitzsch.eu>
To:     Ricardo Ribalda <ribalda@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.12.3
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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
index 574878e8c97d..e0d9624a9d3f 100644
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
2.42.0


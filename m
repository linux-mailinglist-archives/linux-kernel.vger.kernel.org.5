Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D103280A6A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574133AbjLHPIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574185AbjLHPIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:08:10 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B38010DE;
        Fri,  8 Dec 2023 07:08:16 -0800 (PST)
Received: from umang.jain (unknown [103.251.226.108])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CC0B91435;
        Fri,  8 Dec 2023 16:07:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1702048053;
        bh=v4zXIcoXuUwhPMrAke1jILyP8oPZPN1RS9zYrSyz7ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GIWbQKZRW9UuEttt6SO7ArZdTB+5QWb0akEHtalYJZjYnfeLHlIZs2shQQsAWSuDC
         tgDW287BnP69EfmFnUG/o4om2muBsqVNazehX6Od5F2+SkcXhUj6ZKLgsvnSxSCrVv
         yOkPLhl7iolYwFcef1ZzmaUQLR2ryogZybm0giqI=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     devicetree@vger.kernel.org, linux-media@vger.kernel.org
Cc:     "Paul J . Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 5/8] media: i2c: imx335: Implement get selection API
Date:   Fri,  8 Dec 2023 20:37:51 +0530
Message-ID: <20231208150756.124720-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231208150756.124720-1-umang.jain@ideasonboard.com>
References: <20231208150756.124720-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kieran Bingham <kieran.bingham@ideasonboard.com>

Support reporting of the Sensor Native and Active pixel array areas
through the Selection API.

The implementation reports a single target crop only for the mode that
is presently exposed by the driver.

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index b25216b3350e..a924b7222ca3 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -55,6 +55,14 @@
 #define IMX335_REG_MIN		0x00
 #define IMX335_REG_MAX		0xfffff
 
+/* IMX335 native and active pixel array size. */
+#define IMX335_NATIVE_WIDTH		2616U
+#define IMX335_NATIVE_HEIGHT		1964U
+#define IMX335_PIXEL_ARRAY_LEFT		12U
+#define IMX335_PIXEL_ARRAY_TOP		12U
+#define IMX335_PIXEL_ARRAY_WIDTH	2592U
+#define IMX335_PIXEL_ARRAY_HEIGHT	1944U
+
 /**
  * struct imx335_reg - imx335 sensor register
  * @address: Register address
@@ -645,6 +653,41 @@ static int imx335_init_pad_cfg(struct v4l2_subdev *sd,
 	return imx335_set_pad_format(sd, sd_state, &fmt);
 }
 
+/**
+ * imx335_get_selection() - Selection API
+ * @sd: pointer to imx335 V4L2 sub-device structure
+ * @sd_state: V4L2 sub-device configuration
+ * @sel: V4L2 selection info
+ *
+ * Return: 0 if successful, error code otherwise.
+ */
+static int imx335_get_selection(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *sd_state,
+				struct v4l2_subdev_selection *sel)
+{
+	switch (sel->target) {
+	case V4L2_SEL_TGT_NATIVE_SIZE:
+		sel->r.top = 0;
+		sel->r.left = 0;
+		sel->r.width = IMX335_NATIVE_WIDTH;
+		sel->r.height = IMX335_NATIVE_HEIGHT;
+
+		return 0;
+
+	case V4L2_SEL_TGT_CROP:
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+		sel->r.top = IMX335_PIXEL_ARRAY_TOP;
+		sel->r.left = IMX335_PIXEL_ARRAY_LEFT;
+		sel->r.width = IMX335_PIXEL_ARRAY_WIDTH;
+		sel->r.height = IMX335_PIXEL_ARRAY_HEIGHT;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 /**
  * imx335_start_streaming() - Start sensor stream
  * @imx335: pointer to imx335 device
@@ -862,6 +905,8 @@ static const struct v4l2_subdev_pad_ops imx335_pad_ops = {
 	.init_cfg = imx335_init_pad_cfg,
 	.enum_mbus_code = imx335_enum_mbus_code,
 	.enum_frame_size = imx335_enum_frame_size,
+	.get_selection = imx335_get_selection,
+	.set_selection = imx335_get_selection,
 	.get_fmt = imx335_get_pad_format,
 	.set_fmt = imx335_set_pad_format,
 };
-- 
2.41.0


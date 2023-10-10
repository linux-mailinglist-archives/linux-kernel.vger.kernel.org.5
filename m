Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB9E7BEFFC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379321AbjJJAv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379264AbjJJAvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:51:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8F0F1;
        Mon,  9 Oct 2023 17:51:38 -0700 (PDT)
Received: from Monstersaurus.local (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9BC66F02;
        Tue, 10 Oct 2023 02:51:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1696899093;
        bh=tDl8dQbSLOdU2vIuvYIAxnS8VvsF93CmOO6YTQ/B+Dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TZglu5jKFXXyGhPtduqeBPjPLLbK0aaT1Y0KEEdOR2A5CtTBVMnwRcMd0EsdhcGSi
         3FhL3w8P7mday7fuDxW3BNgx6o1JxSJpbbivdvtk3/pC4lOJOZoVO/5MjOsTJF0oqC
         /YbjlloL8jH3tesqoZpuRIo8kwAlT+96Ou00hphA=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] media: i2c: imx335: Implement get selection API
Date:   Tue, 10 Oct 2023 01:51:24 +0100
Message-Id: <20231010005126.3425444-4-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010005126.3425444-1-kieran.bingham@ideasonboard.com>
References: <20231010005126.3425444-1-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support reporting of the Sensor Native and Active pixel array areas
through the Selection API.

The implementation reports a single target crop only for the mode that
is presently exposed by the driver.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index bf12b9b69fce..026777eb362e 100644
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
@@ -651,6 +659,41 @@ static int imx335_init_pad_cfg(struct v4l2_subdev *sd,
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
@@ -864,6 +907,7 @@ static const struct v4l2_subdev_pad_ops imx335_pad_ops = {
 	.init_cfg = imx335_init_pad_cfg,
 	.enum_mbus_code = imx335_enum_mbus_code,
 	.enum_frame_size = imx335_enum_frame_size,
+	.get_selection = imx335_get_selection,
 	.get_fmt = imx335_get_pad_format,
 	.set_fmt = imx335_set_pad_format,
 };
-- 
2.34.1


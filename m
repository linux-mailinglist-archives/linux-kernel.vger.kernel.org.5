Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DEB771D86
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjHGJvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjHGJvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:51:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A06199B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:51:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso42934835e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 02:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691401873; x=1692006673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+rDcbsu17ty6qtUFxa7zH2Z3kpKEhbgiNWpxFudl4A=;
        b=X69ZIvZNbPIJLd2srDq9MisWf67BmTcneWjCOA5wNefa4LUFhjS9GMpq9DJfDkOMh6
         U9XRK6Vxk14GKHL3bFfvisiX8ILx3r42XjgR0XvDz7dLPAJ1fDq85FmptUAd98ZBThdz
         QHxavdD+GeJ87Ej+fNvRdaMLWynILjAa3dseciypjWTWaOduIxyoxUTza+tPd/zzxHXn
         OWGHynaBJTjdI2C2iIhZlK0J1drcOhQtXyn/oUzdBjcsPqqOFON0arMvRwTwODAcM6rF
         35jAiDUY2vem2+gGB+Kt5s9dNfct87SG+EAhvF0HAHvbCWH/V61Yupq8m6weofNgJkCC
         njfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691401873; x=1692006673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+rDcbsu17ty6qtUFxa7zH2Z3kpKEhbgiNWpxFudl4A=;
        b=Lb2nwSEYzEfr+NgmB0Xqp+kxnSBiwXtyH3tg7qVyOUIuXSHXuCsqDJ5zSmkBiFvjI1
         od5UXYGqCwevfiEVEIfMO2OsvUz8NA91Fn9MFUQ7NLykFfyUdOeRTHX6u4sHIu3ZvS1e
         slyiOqLrg2vQA1Z4MiEhwF0VpRtoyN8036n1VvOUknddUhgRkOc1T/zEfm+IxvFKfXY9
         X7E5zqcfx+cmWVDMBGxUvz1OBqRnsao+hZuGrk7o0+QwidvAwws+nMmecKErQRkZCN5a
         GuUTGW+5iH5WN9eX2T47Ad1diNVLZzcBosRnqkrIbN993RPpoOjc0jHf+rTNPC4ZULFd
         aOuQ==
X-Gm-Message-State: AOJu0YzDQ4Twa7nhb8CGyJCSEBqqW91Oy/4EqS74xkH8fsQFfdG/Q7s+
        HEnPyJDYPaNPCBozBg8RsOEl3w==
X-Google-Smtp-Source: AGHT+IF2SwYPrsgXNzgeH0mTFI8pblULXSu+AHQQ3Gsh0Izus0XMR2PG1ghfW4GmOPvi9kCuwfwvxg==
X-Received: by 2002:a05:600c:2811:b0:3fe:16d3:7d60 with SMTP id m17-20020a05600c281100b003fe16d37d60mr7342869wmb.9.1691401872672;
        Mon, 07 Aug 2023 02:51:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c2d8b00b003fe5228b78dsm2752429wmg.1.2023.08.07.02.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 02:51:12 -0700 (PDT)
From:   Julien Stephan <jstephan@baylibre.com>
Cc:     Phi-bang Nguyen <pnguyen@baylibre.com>,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Julien Stephan <jstephan@baylibre.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Louis Kuo <louis.kuo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 4/4] media: platform: mediatek: isp_30: add mediatek ISP3.0 camsv
Date:   Mon,  7 Aug 2023 11:48:13 +0200
Message-ID: <20230807094940.329165-5-jstephan@baylibre.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807094940.329165-1-jstephan@baylibre.com>
References: <20230807094940.329165-1-jstephan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phi-bang Nguyen <pnguyen@baylibre.com>

This driver provides a path to bypass the SoC ISP so that image data
coming from the SENINF can go directly into memory without any image
processing. This allows the use of an external ISP.

Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 MAINTAINERS                                   |   1 +
 .../platform/mediatek/isp/isp_30/Kconfig      |  19 +
 .../platform/mediatek/isp/isp_30/Makefile     |   1 +
 .../mediatek/isp/isp_30/camsv/Makefile        |   7 +
 .../mediatek/isp/isp_30/camsv/mtk_camsv.c     | 328 ++++++++
 .../mediatek/isp/isp_30/camsv/mtk_camsv.h     | 196 +++++
 .../isp/isp_30/camsv/mtk_camsv30_hw.c         | 432 ++++++++++
 .../isp/isp_30/camsv/mtk_camsv30_regs.h       |  60 ++
 .../isp/isp_30/camsv/mtk_camsv_video.c        | 781 ++++++++++++++++++
 9 files changed, 1825 insertions(+)
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/Makefile
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.c
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.h
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_hw.c
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_regs.h
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv_video.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fd192d3799b5..22ec98b31520 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13366,6 +13366,7 @@ M:	Andy Hsieh <andy.hsieh@mediatek.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
 F:	Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
+F:	drivers/media/platform/mediatek/isp/isp_30/camsv/*
 F:	drivers/media/platform/mediatek/isp/isp_30/seninf/*
 
 MEDIATEK SMI DRIVER
diff --git a/drivers/media/platform/mediatek/isp/isp_30/Kconfig b/drivers/media/platform/mediatek/isp/isp_30/Kconfig
index 9791312589fb..5293a061ae0b 100644
--- a/drivers/media/platform/mediatek/isp/isp_30/Kconfig
+++ b/drivers/media/platform/mediatek/isp/isp_30/Kconfig
@@ -14,3 +14,22 @@ config MTK_SENINF30
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called mtk-seninf.
+
+config MTK_CAMSV30
+	tristate "MediaTek ISP3.0 CAMSV driver"
+	depends on VIDEO_V4L2_SUBDEV_API
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on OF
+	depends on PM
+	select VIDEOBUF2_VMALLOC
+	select VIDEOBUF2_DMA_CONTIG
+	select MTK_SENINF30
+	select PHY_MTK_MIPI_CSI_0_5
+	default n
+	help
+	  This driver provides a path to bypass the SoC ISP so that
+	  image data come from the SENINF can go directly into memory
+	  without any image processing.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mtk-camsv30.
diff --git a/drivers/media/platform/mediatek/isp/isp_30/Makefile b/drivers/media/platform/mediatek/isp/isp_30/Makefile
index ac3142de4739..a76f440c5358 100644
--- a/drivers/media/platform/mediatek/isp/isp_30/Makefile
+++ b/drivers/media/platform/mediatek/isp/isp_30/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_MTK_SENINF30) += seninf/
+obj-$(CONFIG_MTK_CAMSV30) += camsv/
diff --git a/drivers/media/platform/mediatek/isp/isp_30/camsv/Makefile b/drivers/media/platform/mediatek/isp/isp_30/camsv/Makefile
new file mode 100644
index 000000000000..fffbc6e7cb78
--- /dev/null
+++ b/drivers/media/platform/mediatek/isp/isp_30/camsv/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+mtk-camsv30-objs += mtk_camsv.o
+mtk-camsv30-objs += mtk_camsv30_hw.o
+mtk-camsv30-objs += mtk_camsv_video.o
+
+obj-$(CONFIG_MTK_CAMSV30) += mtk-camsv30.o
diff --git a/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.c b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.c
new file mode 100644
index 000000000000..98f3e42ff87f
--- /dev/null
+++ b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 BayLibre
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <media/v4l2-async.h>
+#include <media/v4l2-device.h>
+
+#include "mtk_camsv.h"
+
+static inline struct mtk_cam_dev *to_mtk_cam_dev(struct v4l2_subdev *sd)
+{
+	return container_of(sd, struct mtk_cam_dev, subdev);
+}
+
+static const u32 mtk_cam_mbus_formats[] = {
+	MEDIA_BUS_FMT_SBGGR8_1X8,
+	MEDIA_BUS_FMT_SGBRG8_1X8,
+	MEDIA_BUS_FMT_SGRBG8_1X8,
+	MEDIA_BUS_FMT_SRGGB8_1X8,
+	MEDIA_BUS_FMT_SBGGR10_1X10,
+	MEDIA_BUS_FMT_SGBRG10_1X10,
+	MEDIA_BUS_FMT_SGRBG10_1X10,
+	MEDIA_BUS_FMT_SRGGB10_1X10,
+	MEDIA_BUS_FMT_SBGGR12_1X12,
+	MEDIA_BUS_FMT_SGBRG12_1X12,
+	MEDIA_BUS_FMT_SGRBG12_1X12,
+	MEDIA_BUS_FMT_SRGGB12_1X12,
+	MEDIA_BUS_FMT_UYVY8_1X16,
+	MEDIA_BUS_FMT_VYUY8_1X16,
+	MEDIA_BUS_FMT_YUYV8_1X16,
+	MEDIA_BUS_FMT_YVYU8_1X16,
+};
+
+/* -----------------------------------------------------------------------------
+ * V4L2 Subdev Operations
+ */
+
+static int mtk_cam_cio_stream_on(struct mtk_cam_dev *cam)
+{
+	struct device *dev = cam->dev;
+	struct v4l2_subdev *seninf;
+	int ret;
+
+	if (!cam->seninf) {
+		cam->seninf = media_pad_remote_pad_first(&cam->subdev_pads[MTK_CAM_CIO_PAD_SENINF]);
+		if (!cam->seninf) {
+			dev_err(dev, "%s: No SENINF connected\n", __func__);
+			return -ENOLINK;
+		}
+	}
+
+	seninf = media_entity_to_v4l2_subdev(cam->seninf->entity);
+
+	/* Seninf must stream on first */
+	ret = v4l2_subdev_call(seninf, pad, enable_streams, NULL, cam->seninf->index, 0);
+	if (ret) {
+		dev_err(dev, "failed to stream on %s:%d\n",
+			seninf->entity.name, ret);
+		return ret;
+	}
+
+	cam->streaming = true;
+
+	return 0;
+}
+
+static int mtk_cam_cio_stream_off(struct mtk_cam_dev *cam)
+{
+	int ret;
+
+	if (cam->seninf) {
+		struct v4l2_subdev *sd = media_entity_to_v4l2_subdev(cam->seninf->entity);
+
+		ret = v4l2_subdev_call(sd, pad, disable_streams, NULL,
+				       cam->seninf->index, 0);
+		if (ret) {
+			dev_err(cam->dev, "failed to stream off %s:%d\n",
+				sd->entity.name, ret);
+			return ret;
+		}
+	}
+
+	cam->streaming = false;
+
+	return 0;
+}
+
+static int mtk_cam_sd_s_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct mtk_cam_dev *cam = to_mtk_cam_dev(sd);
+
+	if (enable) {
+		/* Align vb2_core_streamon design */
+		if (cam->streaming) {
+			dev_warn(cam->dev, "already streaming on\n");
+			return 0;
+		}
+		return mtk_cam_cio_stream_on(cam);
+	}
+
+	if (!cam->streaming) {
+		dev_warn(cam->dev, "already streaming off\n");
+		return 0;
+	}
+
+	return mtk_cam_cio_stream_off(cam);
+}
+
+static struct v4l2_mbus_framefmt *
+mtk_cam_get_pad_format(struct mtk_cam_dev *cam,
+		       struct v4l2_subdev_state *sd_state,
+		       unsigned int pad, u32 which)
+{
+	switch (which) {
+	case V4L2_SUBDEV_FORMAT_TRY:
+		return v4l2_subdev_get_try_format(&cam->subdev, sd_state, pad);
+	case V4L2_SUBDEV_FORMAT_ACTIVE:
+		return &cam->formats[pad];
+	default:
+		return NULL;
+	}
+}
+
+static int mtk_cam_init_cfg(struct v4l2_subdev *sd,
+			    struct v4l2_subdev_state *sd_state)
+{
+	static const struct v4l2_mbus_framefmt def_format = {
+		.code = MEDIA_BUS_FMT_SGRBG10_1X10,
+		.width = IMG_DEF_WIDTH,
+		.height = IMG_DEF_HEIGHT,
+		.field = V4L2_FIELD_NONE,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.xfer_func = V4L2_XFER_FUNC_DEFAULT,
+		.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT,
+		.quantization = V4L2_QUANTIZATION_DEFAULT,
+	};
+
+	struct mtk_cam_dev *cam = to_mtk_cam_dev(sd);
+	u32 which = sd_state ? V4L2_SUBDEV_FORMAT_TRY
+		  : V4L2_SUBDEV_FORMAT_ACTIVE;
+	struct v4l2_mbus_framefmt *format;
+	unsigned int i;
+
+	for (i = 0; i < sd->entity.num_pads; i++) {
+		format = mtk_cam_get_pad_format(cam, sd_state, i, which);
+		*format = def_format;
+	}
+
+	return 0;
+}
+
+static int mtk_cam_enum_mbus_code(struct v4l2_subdev *sd,
+				  struct v4l2_subdev_state *sd_state,
+				  struct v4l2_subdev_mbus_code_enum *code)
+{
+	if (code->index >= ARRAY_SIZE(mtk_cam_mbus_formats))
+		return -EINVAL;
+
+	code->code = mtk_cam_mbus_formats[code->index];
+
+	return 0;
+}
+
+static int mtk_cam_get_fmt(struct v4l2_subdev *sd,
+			   struct v4l2_subdev_state *sd_state,
+			   struct v4l2_subdev_format *fmt)
+{
+	struct mtk_cam_dev *cam = to_mtk_cam_dev(sd);
+
+	fmt->format = *mtk_cam_get_pad_format(cam, sd_state, fmt->pad,
+					      fmt->which);
+
+	return 0;
+}
+
+static int mtk_cam_set_fmt(struct v4l2_subdev *sd,
+			   struct v4l2_subdev_state *sd_state,
+			   struct v4l2_subdev_format *fmt)
+{
+	struct mtk_cam_dev *cam = to_mtk_cam_dev(sd);
+	struct v4l2_mbus_framefmt *format;
+	unsigned int i;
+
+	/*
+	 * We only support pass-through mode, the format on source pads can't
+	 * be modified.
+	 */
+	if (fmt->pad != MTK_CAM_CIO_PAD_SENINF)
+		return mtk_cam_get_fmt(sd, sd_state, fmt);
+
+	for (i = 0; i < ARRAY_SIZE(mtk_cam_mbus_formats); ++i) {
+		if (mtk_cam_mbus_formats[i] == fmt->format.code)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(mtk_cam_mbus_formats))
+		fmt->format.code = mtk_cam_mbus_formats[0];
+
+	format = mtk_cam_get_pad_format(cam, sd_state, fmt->pad, fmt->which);
+	format->width = fmt->format.width;
+	format->height = fmt->format.height;
+	format->code = fmt->format.code;
+
+	fmt->format = *format;
+
+	/* Propagate the format to the source pad. */
+	format = mtk_cam_get_pad_format(cam, sd_state, MTK_CAM_CIO_PAD_VIDEO,
+					fmt->which);
+	format->width = fmt->format.width;
+	format->height = fmt->format.height;
+	format->code = fmt->format.code;
+
+	return 0;
+}
+
+static int mtk_cam_subdev_registered(struct v4l2_subdev *sd)
+{
+	struct mtk_cam_dev *cam = to_mtk_cam_dev(sd);
+
+	/* Create the video device and link. */
+	return mtk_cam_video_register(cam);
+}
+
+static const struct v4l2_subdev_video_ops mtk_cam_subdev_video_ops = {
+	.s_stream = mtk_cam_sd_s_stream,
+};
+
+static const struct v4l2_subdev_pad_ops mtk_cam_subdev_pad_ops = {
+	.init_cfg = mtk_cam_init_cfg,
+	.enum_mbus_code = mtk_cam_enum_mbus_code,
+	.set_fmt = mtk_cam_set_fmt,
+	.get_fmt = mtk_cam_get_fmt,
+	.link_validate = v4l2_subdev_link_validate_default,
+};
+
+static const struct v4l2_subdev_ops mtk_cam_subdev_ops = {
+	.video = &mtk_cam_subdev_video_ops,
+	.pad = &mtk_cam_subdev_pad_ops,
+};
+
+static const struct v4l2_subdev_internal_ops mtk_cam_internal_ops = {
+	.registered = mtk_cam_subdev_registered,
+};
+
+/* -----------------------------------------------------------------------------
+ * Media Entity Operations
+ */
+
+static const struct media_entity_operations mtk_cam_media_entity_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+	.get_fwnode_pad = v4l2_subdev_get_fwnode_pad_1_to_1,
+};
+
+/* -----------------------------------------------------------------------------
+ * Init & Cleanup
+ */
+
+static int mtk_cam_v4l2_register(struct mtk_cam_dev *cam)
+{
+	struct device *dev = cam->dev;
+	int ret;
+
+	/* Initialize subdev pads */
+	ret = media_entity_pads_init(&cam->subdev.entity,
+				     ARRAY_SIZE(cam->subdev_pads),
+				     cam->subdev_pads);
+	if (ret) {
+		dev_err(dev, "failed to initialize media pads:%d\n", ret);
+		return ret;
+	}
+
+	cam->subdev_pads[MTK_CAM_CIO_PAD_SENINF].flags = MEDIA_PAD_FL_SINK;
+	cam->subdev_pads[MTK_CAM_CIO_PAD_VIDEO].flags = MEDIA_PAD_FL_SOURCE;
+
+	/* Initialize subdev */
+	v4l2_subdev_init(&cam->subdev, &mtk_cam_subdev_ops);
+
+	cam->subdev.dev = dev;
+	cam->subdev.entity.function = MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
+	cam->subdev.entity.ops = &mtk_cam_media_entity_ops;
+	cam->subdev.internal_ops = &mtk_cam_internal_ops;
+	cam->subdev.flags = V4L2_SUBDEV_FL_HAS_DEVNODE;
+	strscpy(cam->subdev.name, dev_name(dev), V4L2_SUBDEV_NAME_SIZE);
+	v4l2_set_subdevdata(&cam->subdev, cam);
+
+	mtk_cam_init_cfg(&cam->subdev, NULL);
+
+	ret = v4l2_async_register_subdev(&cam->subdev);
+	if (ret) {
+		dev_err(dev, "failed to initialize subdev:%d\n", ret);
+		media_entity_cleanup(&cam->subdev.entity);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void mtk_cam_v4l2_unregister(struct mtk_cam_dev *cam)
+{
+	mtk_cam_video_unregister(&cam->vdev);
+
+	media_entity_cleanup(&cam->subdev.entity);
+	v4l2_async_unregister_subdev(&cam->subdev);
+}
+
+int mtk_cam_dev_init(struct mtk_cam_dev *cam_dev)
+{
+	int ret;
+
+	mutex_init(&cam_dev->op_lock);
+
+	/* v4l2 sub-device registration */
+	ret = mtk_cam_v4l2_register(cam_dev);
+	if (ret) {
+		mutex_destroy(&cam_dev->op_lock);
+		return ret;
+	}
+
+	return 0;
+}
+
+void mtk_cam_dev_cleanup(struct mtk_cam_dev *cam)
+{
+	mtk_cam_v4l2_unregister(cam);
+	mutex_destroy(&cam->op_lock);
+}
diff --git a/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.h b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.h
new file mode 100644
index 000000000000..902f2a391064
--- /dev/null
+++ b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.h
@@ -0,0 +1,196 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 BayLibre
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#ifndef __MTK_CAMSV_H__
+#define __MTK_CAMSV_H__
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/of_graph.h>
+#include <linux/pm_runtime.h>
+#include <linux/videodev2.h>
+#include <media/media-entity.h>
+#include <media/v4l2-subdev.h>
+#include <media/videobuf2-core.h>
+#include <media/videobuf2-dma-contig.h>
+#include <media/videobuf2-v4l2.h>
+#include <soc/mediatek/smi.h>
+
+#define IMG_MAX_WIDTH			5376
+#define IMG_MAX_HEIGHT			4032
+#define IMG_DEF_WIDTH			1920
+#define IMG_DEF_HEIGHT			1080
+#define IMG_MIN_WIDTH			80
+#define IMG_MIN_HEIGHT			60
+
+#define MTK_CAM_CIO_PAD_SENINF		0
+#define MTK_CAM_CIO_PAD_VIDEO		1
+#define MTK_CAM_CIO_NUM_PADS		2
+
+struct mtk_cam_format_info {
+	u32 code;
+	u32 fourcc;
+	bool packed;
+	u8 bpp;
+};
+
+struct mtk_cam_dev_buffer {
+	struct vb2_v4l2_buffer v4l2_buf;
+	struct list_head list;
+	dma_addr_t daddr;
+	dma_addr_t fhaddr;
+};
+
+struct mtk_cam_sparams {
+	u32 w_factor;
+	u32 module_en_pak;
+	u32 fmt_sel;
+	u32 pak;
+	u32 imgo_stride;
+};
+
+/**
+ * struct mtk_cam_vdev_desc - MTK camera device descriptor
+ * @name: name of the node
+ * @cap: supported V4L2 capabilities
+ * @buf_type: supported V4L2 buffer type
+ * @link_flags: default media link flags
+ * @def_width: the default format width
+ * @def_height: the default format height
+ * @num_fmts: the number of supported node formats
+ * @max_buf_count: maximum VB2 buffer count
+ * @ioctl_ops:  mapped to v4l2_ioctl_ops
+ * @fmts: supported format
+ * @frmsizes: supported V4L2 frame size number
+ */
+struct mtk_cam_vdev_desc {
+	const char *name;
+	u32 cap;
+	u32 buf_type;
+	u32 link_flags;
+	u32 def_width;
+	u32 def_height;
+	u8 num_fmts;
+	u8 max_buf_count;
+	const struct v4l2_ioctl_ops *ioctl_ops;
+	const u32 *fmts;
+	const struct v4l2_frmsizeenum *frmsizes;
+};
+
+/**
+ * struct mtk_cam_video_device - MediaTek video device structure
+ * @desc: The node description of video device
+ * @vdev_pad: The media pad graph object of video device
+ * @vdev: The video device instance
+ * @vbq: A videobuf queue of video device
+ * @vdev_lock: Serializes vb2 queue and video device operations
+ * @format: The V4L2 format of video device
+ * @fmtinfo: Information about the current format
+ */
+struct mtk_cam_video_device {
+	const struct mtk_cam_vdev_desc *desc;
+
+	struct media_pad vdev_pad;
+	struct video_device vdev;
+	struct vb2_queue vbq;
+
+	/* Serializes vb2 queue and video device operations */
+	struct mutex vdev_lock;
+
+	struct v4l2_pix_format_mplane format;
+	const struct mtk_cam_format_info *fmtinfo;
+};
+
+/**
+ * struct mtk_cam_dev - MediaTek camera device structure.
+ * @dev: Pointer to device.
+ * @regs: Base address of CAMSV.
+ * @regs_img0: Base address of CAMSV IMG0.
+ * @regs_tg: Base address of CAMSV TG.
+ * @num_clks: Number of clocks.
+ * @clks: The clocks.
+ * @irq: Irq fired when buffer is ready.
+ * @conf: soc specific driver data.
+ * @pipeline: Media pipeline information.
+ * @subdev: The V4L2 sub-device instance.
+ * @subdev_pads: Media pads of this sub-device.
+ * @formats: Media bus format for all pads.
+ * @vdev: The video device node.
+ * @seninf: Pointer to the seninf pad.
+ * @streaming: Indicate the overall streaming status is on or off.
+ * @stream_count: Number of streaming video nodes.
+ * @sequence: Buffer sequence number.
+ * @op_lock: Serializes driver's VB2 callback operations.
+ * @irqlock: Protects the buffer list.
+ * @buf_list: List head for the buffer list.
+ * @hw_functions: Hardware specific functions.
+ * @dummy: Dummy buffer used when user buffer is not available.
+ * @dummy_size : Size of the dummy buffer.
+ * @is_dummy_used: True if dummy buffer is currently used.
+ */
+struct mtk_cam_dev {
+	struct device *dev;
+	void __iomem *regs;
+	void __iomem *regs_img0;
+	void __iomem *regs_tg;
+
+	unsigned int num_clks;
+	struct clk_bulk_data *clks;
+	unsigned int irq;
+	const struct mtk_cam_conf *conf;
+
+	struct media_pipeline pipeline;
+	struct v4l2_subdev subdev;
+	struct media_pad subdev_pads[MTK_CAM_CIO_NUM_PADS];
+	struct v4l2_mbus_framefmt formats[MTK_CAM_CIO_NUM_PADS];
+	struct mtk_cam_video_device vdev;
+	struct media_pad *seninf;
+	unsigned int streaming;
+	unsigned int stream_count;
+	unsigned int sequence;
+
+	struct mutex op_lock;
+	spinlock_t irqlock;
+
+	struct list_head buf_list;
+
+	struct mtk_cam_hw_functions *hw_functions;
+
+	struct mtk_cam_dev_buffer dummy;
+	unsigned int dummy_size;
+	bool is_dummy_used;
+};
+
+struct mtk_cam_conf {
+	u32 tg_sen_mode;
+	u32 module_en;
+	u32 pak;
+	u32 dma_special_fun;
+	u32 imgo_con;
+	u32 imgo_con2;
+	u32 imgo_con3;
+	bool frm_hdr_en;
+};
+
+struct mtk_cam_hw_functions {
+	void (*mtk_cam_setup)(struct mtk_cam_dev *cam_dev, u32 width,
+			      u32 height, u32 bpl, u32 mbus_fmt);
+	void (*mtk_cam_update_buffers_add)(struct mtk_cam_dev *cam_dev,
+					   struct mtk_cam_dev_buffer *buf);
+	void (*mtk_cam_cmos_vf_hw_enable)(struct mtk_cam_dev *cam_dev,
+					  bool pak_en);
+	void (*mtk_cam_cmos_vf_hw_disable)(struct mtk_cam_dev *cam_dev,
+					   bool pak_en);
+};
+
+int mtk_cam_dev_init(struct mtk_cam_dev *cam_dev);
+void mtk_cam_dev_cleanup(struct mtk_cam_dev *cam_dev);
+int mtk_cam_video_register(struct mtk_cam_dev *cam_dev);
+void mtk_cam_video_unregister(struct mtk_cam_video_device *vdev);
+
+#endif /* __MTK_CAMSV_H__ */
diff --git a/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_hw.c b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_hw.c
new file mode 100644
index 000000000000..bdf878460354
--- /dev/null
+++ b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_hw.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 BayLibre
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/iommu.h>
+#include <linux/iopoll.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include "mtk_camsv.h"
+#include "mtk_camsv30_regs.h"
+
+#define MTK_CAMSV30_AUTOSUSPEND_DELAY_MS 100
+
+static const struct mtk_cam_conf camsv30_conf = {
+	.tg_sen_mode = 0x00010002U, /* TIME_STP_EN = 1. DBL_DATA_BUS = 1 */
+	.module_en = 0x40000001U, /* enable double buffer and TG */
+	.dma_special_fun = 0x61000000U, /* enable RDMA insterlace */
+	.imgo_con = 0x80000080U, /* DMA FIFO depth and burst */
+	.imgo_con2 = 0x00020002U, /* DMA priority */
+	.imgo_con3 = 0x00020002U, /* DMA pre-priority */
+	.frm_hdr_en = false, /* Frame Header disabled */
+};
+
+static void fmt_to_sparams(u32 mbus_fmt, struct mtk_cam_sparams *sparams)
+{
+	switch (mbus_fmt) {
+	/* SBGGR values coming from isp5.0 configuration.
+	 * not tested on isp2.0
+	 */
+	case MEDIA_BUS_FMT_SBGGR12_1X12:
+	case MEDIA_BUS_FMT_SGBRG12_1X12:
+	case MEDIA_BUS_FMT_SGRBG12_1X12:
+	case MEDIA_BUS_FMT_SRGGB12_1X12:
+		sparams->w_factor = 1;
+		sparams->module_en_pak = 0x4;
+		sparams->fmt_sel = 0x2;
+		sparams->pak = 0x5;
+		sparams->imgo_stride = 0x000B0000;
+		break;
+	case MEDIA_BUS_FMT_SBGGR10_1X10:
+	case MEDIA_BUS_FMT_SGBRG10_1X10:
+	case MEDIA_BUS_FMT_SGRBG10_1X10:
+	case MEDIA_BUS_FMT_SRGGB10_1X10:
+		sparams->w_factor = 1;
+		sparams->module_en_pak = 0x4;
+		sparams->fmt_sel = 0x1;
+		sparams->pak = 0x6;
+		sparams->imgo_stride = 0x000B0000;
+		break;
+	case MEDIA_BUS_FMT_SBGGR8_1X8:
+	case MEDIA_BUS_FMT_SGBRG8_1X8:
+	case MEDIA_BUS_FMT_SGRBG8_1X8:
+	case MEDIA_BUS_FMT_SRGGB8_1X8:
+		sparams->w_factor = 1;
+		sparams->module_en_pak = 0x4;
+		sparams->fmt_sel = 0x0;
+		sparams->pak = 0x7;
+		sparams->imgo_stride = 0x000B0000;
+		break;
+	case MEDIA_BUS_FMT_UYVY8_1X16:
+	case MEDIA_BUS_FMT_VYUY8_1X16:
+	case MEDIA_BUS_FMT_YUYV8_1X16:
+	case MEDIA_BUS_FMT_YVYU8_1X16:
+		sparams->w_factor = 2;
+		sparams->module_en_pak = 0x8;
+		sparams->fmt_sel = 0x1000003;
+		sparams->pak = 0x0;
+		sparams->imgo_stride = 0x00090000;
+		break;
+	default:
+		break;
+	}
+}
+
+static void mtk_camsv30_update_buffers_add(struct mtk_cam_dev *cam_dev,
+					   struct mtk_cam_dev_buffer *buf)
+{
+	writel(buf->daddr, cam_dev->regs_img0 + CAMSV_IMGO_SV_BASE_ADDR);
+
+	writel(0x1U, cam_dev->regs + CAMSV_IMGO_FBC);
+}
+
+static void mtk_camsv30_cmos_vf_hw_enable(struct mtk_cam_dev *cam_dev,
+					  bool pak_en)
+{
+	u32 clk_en;
+
+	clk_en = CAMSV_TG_DP_CLK_EN | CAMSV_DMA_DP_CLK_EN;
+	if (pak_en)
+		clk_en |= CAMSV_PAK_DP_CLK_EN;
+	writel(clk_en, cam_dev->regs + CAMSV_CLK_EN);
+	writel(readl(cam_dev->regs_tg + CAMSV_TG_VF_CON) | CAMSV_TG_VF_CON_VFDATA_EN,
+			cam_dev->regs_tg + CAMSV_TG_VF_CON);
+}
+
+static void mtk_camsv30_cmos_vf_hw_disable(struct mtk_cam_dev *cam_dev,
+					   bool pak_en)
+{
+	writel(readl(cam_dev->regs_tg + CAMSV_TG_SEN_MODE) & ~CAMSV_TG_SEN_MODE_CMOS_EN,
+			cam_dev->regs_tg + CAMSV_TG_SEN_MODE);
+	writel(readl(cam_dev->regs_tg + CAMSV_TG_VF_CON) & ~CAMSV_TG_VF_CON_VFDATA_EN,
+			cam_dev->regs_tg + CAMSV_TG_VF_CON);
+}
+
+static void mtk_camsv30_setup(struct mtk_cam_dev *cam_dev, u32 w, u32 h,
+			      u32 bpl, u32 mbus_fmt)
+{
+	const struct mtk_cam_conf *conf = cam_dev->conf;
+	u32 int_en = INT_ST_MASK_CAMSV;
+	u32 tmp;
+	struct mtk_cam_sparams sparams;
+
+	fmt_to_sparams(mbus_fmt, &sparams);
+
+	spin_lock(&cam_dev->irqlock);
+
+	if (pm_runtime_get_sync(cam_dev->dev) < 0) {
+		dev_err(cam_dev->dev, "failed to get pm_runtime\n");
+		spin_unlock(&cam_dev->irqlock);
+		return;
+	}
+
+	writel(conf->tg_sen_mode, cam_dev->regs_tg + CAMSV_TG_SEN_MODE);
+
+	writel((w * sparams.w_factor) << 16U, cam_dev->regs_tg + CAMSV_TG_SEN_GRAB_PXL);
+
+	writel(h << 16U, cam_dev->regs_tg + CAMSV_TG_SEN_GRAB_LIN);
+
+	/* YUV_U2S_DIS: disable YUV sensor unsigned to signed */
+	writel(0x1000U, cam_dev->regs_tg + CAMSV_TG_PATH_CFG);
+
+	/* Reset cam */
+	writel(CAMSV_SW_RST, cam_dev->regs + CAMSV_SW_CTL);
+	writel(0x0U, cam_dev->regs + CAMSV_SW_CTL);
+	writel(CAMSV_IMGO_RST_TRIG, cam_dev->regs + CAMSV_SW_CTL);
+
+	readl_poll_timeout(cam_dev->regs + CAMSV_SW_CTL, tmp,
+			(tmp == (CAMSV_IMGO_RST_TRIG | CAMSV_IMGO_RST_ST)), 10, 200);
+
+	writel(0x0U, cam_dev->regs + CAMSV_SW_CTL);
+
+	writel(int_en, cam_dev->regs + CAMSV_INT_EN);
+
+	writel(conf->module_en | sparams.module_en_pak,
+	      cam_dev->regs + CAMSV_MODULE_EN);
+	writel(sparams.fmt_sel, cam_dev->regs + CAMSV_FMT_SEL);
+	writel(sparams.pak, cam_dev->regs + CAMSV_PAK);
+
+	writel(bpl - 1U, cam_dev->regs_img0 + CAMSV_IMGO_SV_XSIZE);
+	writel(h - 1U, cam_dev->regs_img0 + CAMSV_IMGO_SV_YSIZE);
+
+	writel(sparams.imgo_stride | bpl, cam_dev->regs_img0 + CAMSV_IMGO_SV_STRIDE);
+
+	writel(conf->imgo_con, cam_dev->regs_img0 + CAMSV_IMGO_SV_CON);
+	writel(conf->imgo_con2, cam_dev->regs_img0 + CAMSV_IMGO_SV_CON2);
+
+	/* CMOS_EN first */
+	writel(readl(cam_dev->regs_tg + CAMSV_TG_SEN_MODE) | CAMSV_TG_SEN_MODE_CMOS_EN,
+			cam_dev->regs_tg + CAMSV_TG_SEN_MODE);
+
+	/* finally, CAMSV_MODULE_EN : IMGO_EN */
+	writel(readl(cam_dev->regs + CAMSV_MODULE_EN) | CAMSV_MODULE_EN_IMGO_EN,
+		    cam_dev->regs + CAMSV_MODULE_EN);
+
+	pm_runtime_put_autosuspend(cam_dev->dev);
+	spin_unlock(&cam_dev->irqlock);
+}
+
+static irqreturn_t isp_irq_camsv30(int irq, void *data)
+{
+	struct mtk_cam_dev *cam_dev = (struct mtk_cam_dev *)data;
+	struct mtk_cam_dev_buffer *buf;
+	unsigned long flags = 0;
+	unsigned int irq_status;
+
+	spin_lock_irqsave(&cam_dev->irqlock, flags);
+
+	irq_status = readl(cam_dev->regs + CAMSV_INT_STATUS);
+
+	if (irq_status & INT_ST_MASK_CAMSV_ERR) {
+		dev_err(cam_dev->dev, "irq error 0x%x\n",
+			(unsigned int)(irq_status & INT_ST_MASK_CAMSV_ERR));
+	}
+
+	/* De-queue frame */
+	if (irq_status & CAMSV_IRQ_PASS1_DON) {
+		cam_dev->sequence++;
+
+		if (!cam_dev->is_dummy_used) {
+			buf = list_first_entry_or_null(&cam_dev->buf_list,
+						       struct mtk_cam_dev_buffer,
+						       list);
+			if (buf) {
+				buf->v4l2_buf.sequence = cam_dev->sequence;
+				buf->v4l2_buf.vb2_buf.timestamp = ktime_get_ns();
+				vb2_buffer_done(&buf->v4l2_buf.vb2_buf,
+						VB2_BUF_STATE_DONE);
+				list_del(&buf->list);
+			}
+		}
+
+		if (list_empty(&cam_dev->buf_list)) {
+			mtk_camsv30_update_buffers_add(cam_dev, &cam_dev->dummy);
+			cam_dev->is_dummy_used = true;
+		} else {
+			buf = list_first_entry_or_null(&cam_dev->buf_list,
+						       struct mtk_cam_dev_buffer,
+						       list);
+			mtk_camsv30_update_buffers_add(cam_dev, buf);
+			cam_dev->is_dummy_used = false;
+		}
+	}
+
+	spin_unlock_irqrestore(&cam_dev->irqlock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static int mtk_camsv30_runtime_suspend(struct device *dev)
+{
+	struct mtk_cam_dev *cam_dev = dev_get_drvdata(dev);
+	struct vb2_queue *vbq = &cam_dev->vdev.vbq;
+
+	if (vb2_is_streaming(vbq)) {
+		mutex_lock(&cam_dev->op_lock);
+		v4l2_subdev_call(&cam_dev->subdev, video, s_stream, 0);
+		mutex_unlock(&cam_dev->op_lock);
+	}
+
+	clk_bulk_disable_unprepare(cam_dev->num_clks, cam_dev->clks);
+
+	return 0;
+}
+
+static int mtk_camsv30_runtime_resume(struct device *dev)
+{
+	struct mtk_cam_dev *cam_dev = dev_get_drvdata(dev);
+	struct mtk_cam_video_device *vdev = &cam_dev->vdev;
+	const struct v4l2_pix_format_mplane *fmt = &vdev->format;
+	struct vb2_queue *vbq = &vdev->vbq;
+	struct mtk_cam_dev_buffer *buf, *buf_prev;
+	int ret;
+	unsigned long flags = 0;
+
+	ret = clk_bulk_prepare_enable(cam_dev->num_clks, cam_dev->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clock:%d\n", ret);
+		return ret;
+	}
+
+	if (vb2_is_streaming(vbq)) {
+		spin_lock_irqsave(&cam_dev->irqlock, flags);
+
+		mtk_camsv30_setup(cam_dev, fmt->width, fmt->height,
+				  fmt->plane_fmt[0].bytesperline, vdev->fmtinfo->code);
+
+		buf = list_first_entry_or_null(&cam_dev->buf_list,
+					       struct mtk_cam_dev_buffer,
+					       list);
+		if (buf) {
+			mtk_camsv30_update_buffers_add(cam_dev, buf);
+			cam_dev->is_dummy_used = false;
+		} else {
+			mtk_camsv30_update_buffers_add(cam_dev, &cam_dev->dummy);
+			cam_dev->is_dummy_used = true;
+		}
+
+		mtk_camsv30_cmos_vf_hw_enable(cam_dev, vdev->fmtinfo->packed);
+
+		spin_unlock_irqrestore(&cam_dev->irqlock, flags);
+
+		/* Stream on the sub-device */
+		mutex_lock(&cam_dev->op_lock);
+		ret = v4l2_subdev_call(&cam_dev->subdev, video, s_stream, 1);
+
+		if (ret) {
+			cam_dev->stream_count--;
+			if (cam_dev->stream_count == 0)
+				media_pipeline_stop(vdev->vdev.entity.pads);
+		}
+		mutex_unlock(&cam_dev->op_lock);
+
+		if (ret)
+			goto fail_no_stream;
+	}
+
+	return 0;
+
+fail_no_stream:
+	spin_lock_irqsave(&cam_dev->irqlock, flags);
+	list_for_each_entry_safe(buf, buf_prev, &cam_dev->buf_list, list) {
+		buf->daddr = 0ULL;
+		list_del(&buf->list);
+		vb2_buffer_done(&buf->v4l2_buf.vb2_buf, VB2_BUF_STATE_ERROR);
+	}
+	spin_unlock_irqrestore(&cam_dev->irqlock, flags);
+	return ret;
+}
+
+static struct mtk_cam_hw_functions mtk_camsv30_hw_functions = {
+	.mtk_cam_setup = mtk_camsv30_setup,
+	.mtk_cam_update_buffers_add = mtk_camsv30_update_buffers_add,
+	.mtk_cam_cmos_vf_hw_enable = mtk_camsv30_cmos_vf_hw_enable,
+	.mtk_cam_cmos_vf_hw_disable = mtk_camsv30_cmos_vf_hw_disable,
+};
+
+static int mtk_camsv30_probe(struct platform_device *pdev)
+{
+	static const char * const clk_names[] = { "cam", "camtg", "camsv"};
+
+	struct mtk_cam_dev *cam_dev;
+	struct device *dev = &pdev->dev;
+	int ret;
+	int i;
+
+	if (!iommu_present(&platform_bus_type))
+		return -EPROBE_DEFER;
+
+	cam_dev = devm_kzalloc(dev, sizeof(*cam_dev), GFP_KERNEL);
+	if (!cam_dev)
+		return -ENOMEM;
+
+	cam_dev->conf = of_device_get_match_data(dev);
+	if (!cam_dev->conf)
+		return -ENODEV;
+
+	cam_dev->dev = dev;
+	dev_set_drvdata(dev, cam_dev);
+
+	cam_dev->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(cam_dev->regs))
+		return dev_err_probe(dev, PTR_ERR(cam_dev->regs),
+				"failed to map register base\n");
+
+
+	cam_dev->regs_img0 = devm_platform_ioremap_resource(pdev, 1);
+
+	if (IS_ERR(cam_dev->regs_img0))
+		return dev_err_probe(dev, PTR_ERR(cam_dev->regs_img0),
+				"failed to map img0 register base\n");
+
+
+	cam_dev->regs_tg = devm_platform_ioremap_resource(pdev, 2);
+	if (IS_ERR(cam_dev->regs_tg))
+		return dev_err_probe(dev, PTR_ERR(cam_dev->regs_tg),
+				"failed to map TG register base\n");
+
+
+	cam_dev->num_clks = ARRAY_SIZE(clk_names);
+	cam_dev->clks = devm_kcalloc(dev, cam_dev->num_clks,
+				     sizeof(*cam_dev->clks), GFP_KERNEL);
+	if (!cam_dev->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < cam_dev->num_clks; ++i)
+		cam_dev->clks[i].id = clk_names[i];
+
+	ret = devm_clk_bulk_get(dev, cam_dev->num_clks, cam_dev->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get clocks: %i\n", ret);
+
+
+	cam_dev->irq = platform_get_irq(pdev, 0);
+	ret = devm_request_irq(dev, cam_dev->irq,
+			       isp_irq_camsv30, 0,
+			       dev_name(dev), cam_dev);
+	if (ret != 0)
+		return dev_err_probe(dev, -ENODEV, "failed to request irq=%d\n",
+				cam_dev->irq);
+
+	cam_dev->hw_functions = &mtk_camsv30_hw_functions;
+
+	spin_lock_init(&cam_dev->irqlock);
+
+	/* initialise runtime power management */
+	pm_runtime_set_autosuspend_delay(dev, MTK_CAMSV30_AUTOSUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_enable(dev);
+
+	/* Initialize the v4l2 common part */
+	return mtk_cam_dev_init(cam_dev);
+}
+
+static int mtk_camsv30_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_cam_dev *cam_dev = dev_get_drvdata(dev);
+
+	mtk_cam_dev_cleanup(cam_dev);
+	pm_runtime_put_autosuspend(dev);
+	pm_runtime_disable(dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops mtk_camsv30_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(mtk_camsv30_runtime_suspend,
+			   mtk_camsv30_runtime_resume, NULL)
+};
+
+static const struct of_device_id mtk_camsv30_of_ids[] = {
+	{ .compatible = "mediatek,mt8365-camsv", .data = &camsv30_conf },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mtk_camsv30_of_ids);
+
+static struct platform_driver mtk_camsv30_driver = {
+	.probe = mtk_camsv30_probe,
+	.remove = mtk_camsv30_remove,
+	.driver = {
+		.name = "mtk-camsv-isp30",
+		.of_match_table = mtk_camsv30_of_ids,
+		.pm = &mtk_camsv30_pm_ops,
+	}
+};
+
+module_platform_driver(mtk_camsv30_driver);
+
+MODULE_DESCRIPTION("MediaTek CAMSV ISP3.0 driver");
+MODULE_AUTHOR("Florian Sylvestre <fsylvestre@baylibre.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_regs.h b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_regs.h
new file mode 100644
index 000000000000..6d30087270cc
--- /dev/null
+++ b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_regs.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#ifndef __MTK_CAMSV30_REGS_H__
+#define __MTK_CAMSV30_REGS_H__
+
+/* CAMSV */
+#define CAMSV_MODULE_EN				0x0000
+#define CAMSV_MODULE_EN_IMGO_EN			BIT(4)
+#define CAMSV_FMT_SEL				0x0004
+#define CAMSV_INT_EN				0x0008
+#define CAMSV_INT_STATUS			0x000c
+#define CAMSV_SW_CTL				0x0010
+#define CAMSV_IMGO_FBC				0x001C
+#define CAMSV_CLK_EN				0x0020
+#define CAMSV_PAK				0x003c
+
+/* CAMSV_TG */
+#define CAMSV_TG_SEN_MODE			0x0010
+#define CAMSV_TG_VF_CON				0x0014
+#define CAMSV_TG_SEN_GRAB_PXL			0x0018
+#define CAMSV_TG_SEN_GRAB_LIN			0x001c
+#define CAMSV_TG_PATH_CFG			0x0020
+
+/* CAMSV_IMG0 */
+#define CAMSV_IMGO_SV_BASE_ADDR			0x0000
+#define CAMSV_IMGO_SV_XSIZE			0x0008
+#define CAMSV_IMGO_SV_YSIZE			0x000c
+#define CAMSV_IMGO_SV_STRIDE			0x0010
+#define CAMSV_IMGO_SV_CON			0x0014
+#define CAMSV_IMGO_SV_CON2			0x0018
+
+#define CAMSV_TG_SEN_MODE_CMOS_EN		BIT(0)
+#define CAMSV_TG_VF_CON_VFDATA_EN		BIT(0)
+
+/* CAMSV_CLK_EN bits */
+#define CAMSV_TG_DP_CLK_EN			BIT(0)
+#define CAMSV_PAK_DP_CLK_EN			BIT(2)
+#define CAMSV_DMA_DP_CLK_EN			BIT(15)
+
+/* CAMSV_SW_CTL bits */
+#define CAMSV_IMGO_RST_TRIG			BIT(0)
+#define CAMSV_IMGO_RST_ST			BIT(1)
+#define CAMSV_SW_RST				BIT(2)
+
+/* IRQ BITS */
+#define CAMSV_IRQ_TG_ERR			BIT(4)
+#define CAMSV_IRQ_TG_GBERR			BIT(5)
+#define CAMSV_IRQ_PASS1_DON			BIT(10)
+#define CAMSV_IRQ_IMGO_ERR			BIT(16)
+
+#define INT_ST_MASK_CAMSV                                                      \
+	(CAMSV_IRQ_PASS1_DON)
+
+#define INT_ST_MASK_CAMSV_ERR                                                  \
+	(CAMSV_IRQ_TG_ERR | CAMSV_IRQ_TG_GBERR | CAMSV_IRQ_IMGO_ERR)
+
+#endif /* __MTK_CAMSV30_REGS_H__ */
diff --git a/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv_video.c b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv_video.c
new file mode 100644
index 000000000000..f879726eacd8
--- /dev/null
+++ b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv_video.c
@@ -0,0 +1,781 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mtk_camsv_video.c - V4L2 video node support
+ *
+ * Copyright (c) 2020 BayLibre
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/version.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-mediabus.h>
+
+#include "mtk_camsv.h"
+
+static inline struct mtk_cam_video_device *
+file_to_mtk_cam_video_device(struct file *__file)
+{
+	return container_of(video_devdata(__file),
+			    struct mtk_cam_video_device, vdev);
+}
+
+static inline struct mtk_cam_video_device *
+vb2_queue_to_mtk_cam_video_device(struct vb2_queue *vq)
+{
+	return container_of(vq, struct mtk_cam_video_device, vbq);
+}
+
+static inline struct mtk_cam_dev_buffer *
+to_mtk_cam_dev_buffer(struct vb2_buffer *buf)
+{
+	return container_of(buf, struct mtk_cam_dev_buffer, v4l2_buf.vb2_buf);
+}
+
+/* -----------------------------------------------------------------------------
+ * Format Information
+ */
+
+static const struct mtk_cam_format_info mtk_cam_format_info[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_SBGGR8,
+		.code = MEDIA_BUS_FMT_SBGGR8_1X8,
+		.packed = true,
+		.bpp = 8,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGBRG8,
+		.code = MEDIA_BUS_FMT_SGBRG8_1X8,
+		.packed = true,
+		.bpp = 8,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGRBG8,
+		.code = MEDIA_BUS_FMT_SGRBG8_1X8,
+		.packed = true,
+		.bpp = 8,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SRGGB8,
+		.code = MEDIA_BUS_FMT_SRGGB8_1X8,
+		.packed = true,
+		.bpp = 8,
+	}, {
+		.fourcc = V4L2_PIX_FMT_YUYV,
+		.code = MEDIA_BUS_FMT_YUYV8_1X16,
+		.packed = true,
+		.bpp = 16,
+	}, {
+		.fourcc = V4L2_PIX_FMT_YVYU,
+		.code = MEDIA_BUS_FMT_YVYU8_1X16,
+		.packed = true,
+		.bpp = 16,
+	}, {
+		.fourcc = V4L2_PIX_FMT_UYVY,
+		.code = MEDIA_BUS_FMT_UYVY8_1X16,
+		.packed = true,
+		.bpp = 16,
+	}, {
+		.fourcc = V4L2_PIX_FMT_VYUY,
+		.code = MEDIA_BUS_FMT_VYUY8_1X16,
+		.packed = true,
+		.bpp = 16,
+	},
+};
+
+static const struct mtk_cam_format_info *
+mtk_cam_format_info_by_fourcc(u32 fourcc)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(mtk_cam_format_info); ++i) {
+		const struct mtk_cam_format_info *info =
+			&mtk_cam_format_info[i];
+
+		if (info->fourcc == fourcc)
+			return info;
+	}
+
+	return NULL;
+}
+
+static const struct mtk_cam_format_info *
+mtk_cam_format_info_by_code(u32 code)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(mtk_cam_format_info); ++i) {
+		const struct mtk_cam_format_info *info =
+			&mtk_cam_format_info[i];
+
+		if (info->code == code)
+			return info;
+	}
+
+	return NULL;
+}
+
+static bool mtk_cam_dev_find_fmt(const struct mtk_cam_vdev_desc *desc,
+				 u32 format)
+{
+	unsigned int i;
+
+	for (i = 0; i < desc->num_fmts; i++) {
+		if (desc->fmts[i] == format)
+			return true;
+	}
+
+	return false;
+}
+
+static void calc_bpl_size_pix_mp(const struct mtk_cam_format_info *fmtinfo,
+				 struct v4l2_pix_format_mplane *pix_mp)
+{
+	unsigned int bpl;
+	unsigned int i;
+
+	bpl = ALIGN(DIV_ROUND_UP(pix_mp->width * fmtinfo->bpp, 8), 2);
+
+	for (i = 0; i < pix_mp->num_planes; ++i) {
+		pix_mp->plane_fmt[i].bytesperline = bpl;
+		pix_mp->plane_fmt[i].sizeimage = bpl * pix_mp->height;
+	}
+}
+
+static void mtk_cam_dev_load_default_fmt(struct mtk_cam_dev *cam)
+{
+	struct mtk_cam_video_device *vdev = &cam->vdev;
+	struct v4l2_pix_format_mplane *fmt = &vdev->format;
+
+	fmt->num_planes = cam->conf->frm_hdr_en ? 2 : 1;
+	fmt->pixelformat = vdev->desc->fmts[0];
+	fmt->width = vdev->desc->def_width;
+	fmt->height = vdev->desc->def_height;
+
+	fmt->colorspace = V4L2_COLORSPACE_SRGB;
+	fmt->field = V4L2_FIELD_NONE;
+	fmt->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	fmt->quantization = V4L2_QUANTIZATION_DEFAULT;
+	fmt->xfer_func = V4L2_XFER_FUNC_DEFAULT;
+
+	vdev->fmtinfo = mtk_cam_format_info_by_fourcc(fmt->pixelformat);
+
+	calc_bpl_size_pix_mp(vdev->fmtinfo, fmt);
+}
+
+/* -----------------------------------------------------------------------------
+ * VB2 Queue Operations
+ */
+
+static int mtk_cam_vb2_queue_setup(struct vb2_queue *vq,
+				   unsigned int *num_buffers,
+				   unsigned int *num_planes,
+				   unsigned int sizes[],
+				   struct device *alloc_devs[])
+{
+	struct mtk_cam_video_device *vdev =
+		vb2_queue_to_mtk_cam_video_device(vq);
+	unsigned int max_buffer_count = vdev->desc->max_buf_count;
+	const struct v4l2_pix_format_mplane *fmt = &vdev->format;
+	struct mtk_cam_dev *cam = vb2_get_drv_priv(vq);
+	unsigned int size;
+	unsigned int np_conf;
+	unsigned int i;
+
+	/* Check the limitation of buffer size */
+	if (max_buffer_count)
+		*num_buffers = clamp_val(*num_buffers, 1, max_buffer_count);
+
+	size = fmt->plane_fmt[0].sizeimage;
+	/* Add for q.create_bufs with fmt.g_sizeimage(p) / 2 test */
+
+	np_conf = cam->conf->frm_hdr_en ? 2 : 1;
+
+	if (*num_planes == 0) {
+		*num_planes = np_conf;
+		for (i = 0; i < *num_planes; ++i)
+			sizes[i] = size;
+	} else if (*num_planes != np_conf || sizes[0] < size) {
+		return -EINVAL;
+	}
+
+	(*cam->hw_functions->mtk_cam_setup)(cam, fmt->width, fmt->height,
+			fmt->plane_fmt[0].bytesperline, vdev->fmtinfo->code);
+
+	return 0;
+}
+
+static int mtk_cam_vb2_buf_init(struct vb2_buffer *vb)
+{
+	struct mtk_cam_dev_buffer *buf = to_mtk_cam_dev_buffer(vb);
+
+	buf->daddr = 0ULL;
+
+	return 0;
+}
+
+static int mtk_cam_vb2_buf_prepare(struct vb2_buffer *vb)
+{
+	struct mtk_cam_video_device *vdev =
+		vb2_queue_to_mtk_cam_video_device(vb->vb2_queue);
+	struct mtk_cam_dev *cam = vb2_get_drv_priv(vb->vb2_queue);
+	struct mtk_cam_dev_buffer *buf = to_mtk_cam_dev_buffer(vb);
+	const struct v4l2_pix_format_mplane *fmt = &vdev->format;
+	u32 size;
+	int i;
+
+	for (i = 0; i < vb->num_planes; i++) {
+		size = fmt->plane_fmt[i].sizeimage;
+		if (vb2_plane_size(vb, i) < size) {
+			dev_err(cam->dev, "plane size is too small:%lu<%u\n",
+				vb2_plane_size(vb, i), size);
+			return -EINVAL;
+		}
+	}
+
+	buf->v4l2_buf.field = V4L2_FIELD_NONE;
+
+	for (i = 0; i < vb->num_planes; i++) {
+		size = fmt->plane_fmt[i].sizeimage;
+		vb2_set_plane_payload(vb, i, size);
+	}
+
+	if (buf->daddr == 0ULL) {
+		buf->daddr = vb2_dma_contig_plane_dma_addr(vb, 0);
+		if (cam->conf->frm_hdr_en)
+			buf->fhaddr = vb2_dma_contig_plane_dma_addr(vb, 1);
+	}
+
+	return 0;
+}
+
+static void mtk_cam_vb2_buf_queue(struct vb2_buffer *vb)
+{
+	struct mtk_cam_dev *cam = vb2_get_drv_priv(vb->vb2_queue);
+	struct mtk_cam_dev_buffer *buf = to_mtk_cam_dev_buffer(vb);
+	unsigned long flags = 0;
+
+	/* added the buffer into the tracking list */
+	spin_lock_irqsave(&cam->irqlock, flags);
+	list_add_tail(&buf->list, &cam->buf_list);
+	spin_unlock_irqrestore(&cam->irqlock, flags);
+}
+
+static void mtk_cam_vb2_return_all_buffers(struct mtk_cam_dev *cam,
+					   enum vb2_buffer_state state)
+{
+	struct mtk_cam_dev_buffer *buf, *buf_prev;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&cam->irqlock, flags);
+	list_for_each_entry_safe(buf, buf_prev, &cam->buf_list, list) {
+		buf->daddr = 0ULL;
+		list_del(&buf->list);
+		vb2_buffer_done(&buf->v4l2_buf.vb2_buf, state);
+	}
+	spin_unlock_irqrestore(&cam->irqlock, flags);
+}
+
+static void mtk_cam_cmos_vf_enable(struct mtk_cam_dev *cam_dev,
+				   bool enable, bool pak_en)
+{
+	struct device *dev = cam_dev->dev;
+	unsigned long flags = 0;
+
+	if (pm_runtime_get_sync(dev) < 0) {
+		dev_err(dev, "failed to get pm_runtime\n");
+		goto out;
+	}
+
+	spin_lock_irqsave(&cam_dev->irqlock, flags);
+	if (enable)
+		(*cam_dev->hw_functions->mtk_cam_cmos_vf_hw_enable)(cam_dev, pak_en);
+	else
+		(*cam_dev->hw_functions->mtk_cam_cmos_vf_hw_disable)(cam_dev, pak_en);
+	spin_unlock_irqrestore(&cam_dev->irqlock, flags);
+
+out:
+	pm_runtime_put_autosuspend(dev);
+}
+
+static int mtk_cam_verify_format(struct mtk_cam_dev *cam)
+{
+	struct mtk_cam_video_device *vdev = &cam->vdev;
+	struct v4l2_subdev_format fmt = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.pad = MTK_CAM_CIO_PAD_VIDEO,
+	};
+	int ret;
+
+	ret = v4l2_subdev_call(&cam->subdev, pad, get_fmt, NULL, &fmt);
+	if (ret < 0)
+		return ret == -ENOIOCTLCMD ? -EINVAL : ret;
+
+	if (vdev->fmtinfo->code != fmt.format.code ||
+	    vdev->format.height != fmt.format.height ||
+	    vdev->format.width != fmt.format.width)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int mtk_cam_vb2_start_streaming(struct vb2_queue *vq,
+				       unsigned int count)
+{
+	struct mtk_cam_dev *cam = vb2_get_drv_priv(vq);
+	struct mtk_cam_dev_buffer *buf;
+	struct mtk_cam_video_device *vdev =
+		vb2_queue_to_mtk_cam_video_device(vq);
+	struct device *dev = cam->dev;
+	const struct v4l2_pix_format_mplane *fmt = &vdev->format;
+	int ret;
+	unsigned long flags = 0;
+
+	if (pm_runtime_get_sync(dev) < 0) {
+		dev_err(dev, "failed to get pm_runtime\n");
+		pm_runtime_put_autosuspend(dev);
+		return -1;
+	}
+
+	/* Enable CMOS and VF */
+	mtk_cam_cmos_vf_enable(cam, true, vdev->fmtinfo->packed);
+
+	mutex_lock(&cam->op_lock);
+
+	ret = mtk_cam_verify_format(cam);
+	if (ret < 0)
+		goto fail_unlock;
+
+	/* Start streaming of the whole pipeline now*/
+	if (!cam->pipeline.start_count) {
+		ret = media_pipeline_start(vdev->vdev.entity.pads,
+					   &cam->pipeline);
+		if (ret) {
+			dev_err(dev, "failed to start pipeline:%d\n", ret);
+			goto fail_unlock;
+		}
+	}
+
+	/* Media links are fixed after media_pipeline_start */
+	cam->stream_count++;
+
+	cam->sequence = (unsigned int)-1;
+
+	/* Stream on the sub-device */
+	ret = v4l2_subdev_call(&cam->subdev, video, s_stream, 1);
+	if (ret)
+		goto fail_no_stream;
+
+	mutex_unlock(&cam->op_lock);
+
+	/* Create dummy buffer */
+	cam->dummy_size = fmt->plane_fmt[0].sizeimage;
+
+	cam->dummy.fhaddr = (dma_addr_t)dma_alloc_coherent(cam->dev,
+					       cam->dummy_size,
+					       &cam->dummy.daddr, GFP_KERNEL);
+	if (!cam->dummy.fhaddr) {
+		dev_err(cam->dev, "can't allocate dummy buffer\n");
+		ret = -ENOMEM;
+		goto fail_no_buffer;
+	}
+
+	/* update first buffer address */
+
+	/* added the buffer into the tracking list */
+	spin_lock_irqsave(&cam->irqlock, flags);
+	if (list_empty(&cam->buf_list)) {
+		(*cam->hw_functions->mtk_cam_update_buffers_add)(cam, &cam->dummy);
+		cam->is_dummy_used = true;
+	} else {
+		buf = list_first_entry_or_null(&cam->buf_list,
+					       struct mtk_cam_dev_buffer,
+					       list);
+		(*cam->hw_functions->mtk_cam_update_buffers_add)(cam, buf);
+		cam->is_dummy_used = false;
+	}
+	spin_unlock_irqrestore(&cam->irqlock, flags);
+
+	return 0;
+
+fail_no_buffer:
+	mutex_lock(&cam->op_lock);
+	v4l2_subdev_call(&cam->subdev, video, s_stream, 0);
+fail_no_stream:
+	cam->stream_count--;
+	if (cam->stream_count == 0)
+		media_pipeline_stop(vdev->vdev.entity.pads);
+fail_unlock:
+	mutex_unlock(&cam->op_lock);
+	mtk_cam_vb2_return_all_buffers(cam, VB2_BUF_STATE_QUEUED);
+
+	return ret;
+}
+
+static void mtk_cam_vb2_stop_streaming(struct vb2_queue *vq)
+{
+	struct mtk_cam_dev *cam = vb2_get_drv_priv(vq);
+	struct mtk_cam_video_device *vdev =
+		vb2_queue_to_mtk_cam_video_device(vq);
+
+	/* Disable CMOS and VF */
+	mtk_cam_cmos_vf_enable(cam, false, false);
+
+	mutex_lock(&cam->op_lock);
+
+	v4l2_subdev_call(&cam->subdev, video, s_stream, 0);
+
+	mtk_cam_vb2_return_all_buffers(cam, VB2_BUF_STATE_ERROR);
+	cam->stream_count--;
+	if (cam->stream_count) {
+		mutex_unlock(&cam->op_lock);
+		return;
+	}
+
+	/* Destroy dummy buffer */
+	if (cam->dummy.fhaddr) {
+		dma_free_coherent(cam->dev, cam->dummy_size,
+				  (void *)cam->dummy.fhaddr,
+				  cam->dummy.daddr);
+		memset(&cam->dummy, 0, sizeof(cam->dummy));
+		cam->dummy_size = 0;
+		cam->is_dummy_used = false;
+	}
+
+	mutex_unlock(&cam->op_lock);
+
+	media_pipeline_stop(vdev->vdev.entity.pads);
+}
+
+static const struct vb2_ops mtk_cam_vb2_ops = {
+	.queue_setup = mtk_cam_vb2_queue_setup,
+	.buf_init = mtk_cam_vb2_buf_init,
+	.buf_prepare = mtk_cam_vb2_buf_prepare,
+	.buf_queue = mtk_cam_vb2_buf_queue,
+	.start_streaming = mtk_cam_vb2_start_streaming,
+	.stop_streaming = mtk_cam_vb2_stop_streaming,
+	.wait_prepare = vb2_ops_wait_prepare,
+	.wait_finish = vb2_ops_wait_finish,
+};
+
+/* -----------------------------------------------------------------------------
+ * V4L2 Video IOCTLs
+ */
+
+static int mtk_cam_vidioc_querycap(struct file *file, void *fh,
+				   struct v4l2_capability *cap)
+{
+	struct mtk_cam_dev *cam = video_drvdata(file);
+
+	strscpy(cap->driver, dev_driver_string(cam->dev), sizeof(cap->driver));
+	strscpy(cap->card, dev_driver_string(cam->dev), sizeof(cap->card));
+	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
+		 dev_name(cam->dev));
+
+	/* Minimum v4l2 api kernel version required by libcamera is 5.0.0 */
+	cap->version = KERNEL_VERSION(5, 0, 0);
+
+	return 0;
+}
+
+static int mtk_cam_vidioc_enum_fmt(struct file *file, void *fh,
+				   struct v4l2_fmtdesc *f)
+{
+	struct mtk_cam_video_device *vdev = file_to_mtk_cam_video_device(file);
+	const struct mtk_cam_format_info *fmtinfo;
+	unsigned int i;
+
+	/* If mbus_code is not set enumerate all supported formats. */
+	if (!f->mbus_code) {
+		if (f->index >= vdev->desc->num_fmts)
+			return -EINVAL;
+
+		/* f->description is filled in v4l_fill_fmtdesc function */
+		f->pixelformat = vdev->desc->fmts[f->index];
+		f->flags = 0;
+
+		return 0;
+	}
+
+	/*
+	 * Otherwise only enumerate supported pixel formats corresponding to
+	 * that bus code.
+	 */
+	if (f->index)
+		return -EINVAL;
+
+	fmtinfo = mtk_cam_format_info_by_code(f->mbus_code);
+	if (!fmtinfo)
+		return -EINVAL;
+
+	for (i = 0; i < vdev->desc->num_fmts; ++i) {
+		if (vdev->desc->fmts[i] == fmtinfo->fourcc) {
+			f->pixelformat = fmtinfo->fourcc;
+			f->flags = 0;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int mtk_cam_vidioc_g_fmt(struct file *file, void *fh,
+				struct v4l2_format *f)
+{
+	struct mtk_cam_video_device *vdev = file_to_mtk_cam_video_device(file);
+
+	f->fmt.pix_mp = vdev->format;
+
+	return 0;
+}
+
+static int mtk_cam_vidioc_try_fmt(struct file *file, void *fh,
+				  struct v4l2_format *f)
+{
+	struct mtk_cam_dev *cam = video_drvdata(file);
+	struct mtk_cam_video_device *vdev = file_to_mtk_cam_video_device(file);
+	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
+	const struct mtk_cam_format_info *fmtinfo;
+
+	/* Validate pixelformat */
+	if (!mtk_cam_dev_find_fmt(vdev->desc, pix_mp->pixelformat))
+		pix_mp->pixelformat = vdev->desc->fmts[0];
+
+	pix_mp->width = clamp_val(pix_mp->width, IMG_MIN_WIDTH, IMG_MAX_WIDTH);
+	pix_mp->height = clamp_val(pix_mp->height, IMG_MIN_HEIGHT,
+				   IMG_MAX_HEIGHT);
+
+	pix_mp->num_planes = cam->conf->frm_hdr_en ? 2 : 1;
+
+	fmtinfo = mtk_cam_format_info_by_fourcc(pix_mp->pixelformat);
+	calc_bpl_size_pix_mp(fmtinfo, pix_mp);
+
+	/* Constant format fields */
+	pix_mp->colorspace = V4L2_COLORSPACE_SRGB;
+	pix_mp->field = V4L2_FIELD_NONE;
+	pix_mp->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	pix_mp->quantization = V4L2_QUANTIZATION_DEFAULT;
+	pix_mp->xfer_func = V4L2_XFER_FUNC_DEFAULT;
+
+	return 0;
+}
+
+static int mtk_cam_vidioc_s_fmt(struct file *file, void *fh,
+				struct v4l2_format *f)
+{
+	struct mtk_cam_dev *cam = video_drvdata(file);
+	struct mtk_cam_video_device *vdev = file_to_mtk_cam_video_device(file);
+	int ret;
+
+	if (vb2_is_busy(vdev->vdev.queue)) {
+		dev_dbg(cam->dev, "%s: queue is busy\n", __func__);
+		return -EBUSY;
+	}
+
+	ret = mtk_cam_vidioc_try_fmt(file, fh, f);
+	if (ret)
+		return ret;
+
+	/* Configure to video device */
+	vdev->format = f->fmt.pix_mp;
+	vdev->fmtinfo =
+		mtk_cam_format_info_by_fourcc(f->fmt.pix_mp.pixelformat);
+
+	return 0;
+}
+
+static int mtk_cam_vidioc_enum_framesizes(struct file *file, void *priv,
+					  struct v4l2_frmsizeenum *sizes)
+{
+	struct mtk_cam_video_device *vdev = file_to_mtk_cam_video_device(file);
+
+	if (sizes->index)
+		return -EINVAL;
+
+	if (!mtk_cam_dev_find_fmt(vdev->desc, sizes->pixel_format))
+		return -EINVAL;
+
+	sizes->type = vdev->desc->frmsizes->type;
+	memcpy(&sizes->stepwise, &vdev->desc->frmsizes->stepwise,
+	       sizeof(sizes->stepwise));
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops mtk_cam_v4l2_vcap_ioctl_ops = {
+	.vidioc_querycap = mtk_cam_vidioc_querycap,
+	.vidioc_enum_framesizes = mtk_cam_vidioc_enum_framesizes,
+	.vidioc_enum_fmt_vid_cap = mtk_cam_vidioc_enum_fmt,
+	.vidioc_g_fmt_vid_cap_mplane = mtk_cam_vidioc_g_fmt,
+	.vidioc_s_fmt_vid_cap_mplane = mtk_cam_vidioc_s_fmt,
+	.vidioc_try_fmt_vid_cap_mplane = mtk_cam_vidioc_try_fmt,
+	.vidioc_reqbufs = vb2_ioctl_reqbufs,
+	.vidioc_create_bufs = vb2_ioctl_create_bufs,
+	.vidioc_prepare_buf = vb2_ioctl_prepare_buf,
+	.vidioc_querybuf = vb2_ioctl_querybuf,
+	.vidioc_qbuf = vb2_ioctl_qbuf,
+	.vidioc_dqbuf = vb2_ioctl_dqbuf,
+	.vidioc_streamon = vb2_ioctl_streamon,
+	.vidioc_streamoff = vb2_ioctl_streamoff,
+	.vidioc_expbuf = vb2_ioctl_expbuf,
+	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
+	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
+};
+
+static const struct v4l2_file_operations mtk_cam_v4l2_fops = {
+	.unlocked_ioctl = video_ioctl2,
+	.open = v4l2_fh_open,
+	.release = vb2_fop_release,
+	.poll = vb2_fop_poll,
+	.mmap = vb2_fop_mmap,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl32 = v4l2_compat_ioctl32,
+#endif
+};
+
+/* -----------------------------------------------------------------------------
+ * Init & Cleanup
+ */
+
+static const u32 stream_out_fmts[] = {
+	/* The 1st entry is the default image format */
+	V4L2_PIX_FMT_SBGGR8,
+	V4L2_PIX_FMT_SGBRG8,
+	V4L2_PIX_FMT_SGRBG8,
+	V4L2_PIX_FMT_SRGGB8,
+	V4L2_PIX_FMT_UYVY,
+	V4L2_PIX_FMT_VYUY,
+	V4L2_PIX_FMT_YUYV,
+	V4L2_PIX_FMT_YVYU,
+};
+
+static const struct mtk_cam_vdev_desc video_stream = {
+	.name = "video stream",
+	.cap = V4L2_CAP_VIDEO_CAPTURE_MPLANE,
+	.buf_type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+	.link_flags = MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED,
+	.fmts = stream_out_fmts,
+	.num_fmts = ARRAY_SIZE(stream_out_fmts),
+	.def_width = 1920,
+	.def_height = 1080,
+	.ioctl_ops = &mtk_cam_v4l2_vcap_ioctl_ops,
+	.frmsizes =
+		&(struct v4l2_frmsizeenum){
+			.index = 0,
+			.type = V4L2_FRMSIZE_TYPE_CONTINUOUS,
+			.stepwise = {
+				.max_width = IMG_MAX_WIDTH,
+				.min_width = IMG_MIN_WIDTH,
+				.max_height = IMG_MAX_HEIGHT,
+				.min_height = IMG_MIN_HEIGHT,
+				.step_height = 1,
+				.step_width = 1,
+			},
+		},
+};
+
+int mtk_cam_video_register(struct mtk_cam_dev *cam)
+{
+	struct device *dev = cam->dev;
+	struct mtk_cam_video_device *cam_vdev = &cam->vdev;
+	struct video_device *vdev = &cam_vdev->vdev;
+	struct vb2_queue *vbq = &cam_vdev->vbq;
+	int ret;
+
+	vb2_dma_contig_set_max_seg_size(cam->dev, DMA_BIT_MASK(32));
+
+	cam_vdev->desc = &video_stream;
+
+	/* Initialize mtk_cam_video_device */
+	mtk_cam_dev_load_default_fmt(cam);
+
+	cam->subdev_pads[MTK_CAM_CIO_PAD_VIDEO].flags = MEDIA_PAD_FL_SOURCE;
+
+	/* Initialize media entities */
+	ret = media_entity_pads_init(&vdev->entity, 1, &cam_vdev->vdev_pad);
+	if (ret) {
+		dev_err(dev, "failed to initialize media pad:%d\n", ret);
+		return ret;
+	}
+	cam_vdev->vdev_pad.flags = MEDIA_PAD_FL_SINK;
+
+	vbq->type = cam_vdev->desc->buf_type;
+	vbq->io_modes = VB2_MMAP | VB2_DMABUF;
+	vbq->dev = dev;
+	vbq->ops = &mtk_cam_vb2_ops;
+	vbq->mem_ops = &vb2_dma_contig_memops;
+	vbq->buf_struct_size = sizeof(struct mtk_cam_dev_buffer);
+	/*
+	 * TODO: The hardware supports SOF interrupts, switch to a SOF
+	 * timestamp source would give better accuracy, but first requires
+	 * extending the V4L2 API to support it.
+	 */
+	vbq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC
+			     | V4L2_BUF_FLAG_TSTAMP_SRC_EOF;
+
+	/* No minimum buffers limitation */
+	vbq->min_buffers_needed = 0;
+	vbq->drv_priv = cam;
+
+	vbq->lock = &cam_vdev->vdev_lock;
+	ret = vb2_queue_init(vbq);
+	if (ret) {
+		dev_err(dev, "failed to init. vb2 queue:%d\n", ret);
+		goto fail_media_clean;
+	}
+
+	/* Initialize vdev */
+	snprintf(vdev->name, sizeof(vdev->name), "%s %s",
+		 dev_name(dev), cam_vdev->desc->name);
+
+	/* Set cap/type/ioctl_ops of the video device */
+	vdev->device_caps = cam_vdev->desc->cap | V4L2_CAP_STREAMING
+			  | V4L2_CAP_IO_MC;
+	vdev->ioctl_ops = cam_vdev->desc->ioctl_ops;
+	vdev->fops = &mtk_cam_v4l2_fops;
+	vdev->release = video_device_release_empty;
+	vdev->lock = &cam_vdev->vdev_lock;
+	vdev->v4l2_dev = cam->subdev.v4l2_dev;
+	vdev->queue = &cam_vdev->vbq;
+	vdev->vfl_dir = VFL_DIR_RX;
+	vdev->entity.function = MEDIA_ENT_F_IO_V4L;
+	vdev->entity.ops = NULL;
+	video_set_drvdata(vdev, cam);
+
+	/* Initialize miscellaneous variables */
+	mutex_init(&cam_vdev->vdev_lock);
+	INIT_LIST_HEAD(&cam->buf_list);
+
+	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
+	if (ret) {
+		dev_err(dev, "failed to register vde:%d\n", ret);
+		goto fail_vb2_rel;
+	}
+
+	/* Create link between the video pad and the subdev pad. */
+	ret = media_create_pad_link(&cam->subdev.entity,
+				    MTK_CAM_CIO_PAD_VIDEO,
+				    &vdev->entity, 0, cam_vdev->desc->link_flags);
+
+	if (ret)
+		goto fail_vdev_ureg;
+
+	return 0;
+
+fail_vdev_ureg:
+	video_unregister_device(vdev);
+fail_vb2_rel:
+	mutex_destroy(&cam_vdev->vdev_lock);
+	vb2_queue_release(vbq);
+fail_media_clean:
+	media_entity_cleanup(&vdev->entity);
+
+	return ret;
+}
+
+void mtk_cam_video_unregister(struct mtk_cam_video_device *vdev)
+{
+	video_unregister_device(&vdev->vdev);
+	vb2_queue_release(&vdev->vbq);
+	media_entity_cleanup(&vdev->vdev.entity);
+	mutex_destroy(&vdev->vdev_lock);
+	vb2_dma_contig_clear_max_seg_size(&vdev->vdev.dev);
+}
-- 
2.41.0


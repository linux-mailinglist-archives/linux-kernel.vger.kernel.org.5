Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36E87E5B7E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjKHQjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjKHQjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:39:08 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7161FEB;
        Wed,  8 Nov 2023 08:39:05 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 603D020003;
        Wed,  8 Nov 2023 16:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699461544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zfmoRr0vXrWN+o7PYcK5C8evyUFVe/aXrn/oWSiSMNg=;
        b=RBcMgPd8uQfyyCizkN/ZwctYjbvGPC34eiLYjyP9knKsxsu85ge/wQ+yoX9yshdm46Ivmn
        ntQ8S1jBQLOb29YMPA5FT3SCloFNf9gGB+XGvE8MpFTUqUcArGe9LtL2o66ksAYweiR9/F
        rSLaSJHQ2iKY5tw4/vVDPPa8G/k4oIpu1rrczyF/Z60mx/ZkTZF8d2KimshsIf24hvdpr9
        F0eaTQPKYO+WoEGLFzsdLbd2aTFulnQuzhua9SlwwnMrdiST1nWEBaC7kDf+1s7MOP61Ly
        ANXWdmAHYzAP3Bkhz0+xGFoR31Rqp1Bgq7rUklptbD1vKR4tSVUORMwKvoUhdA==
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com, michael.riesch@wolfvision.net,
        Mehdi Djait <mehdi.djait@bootlin.com>
Subject: [PATCH v10 2/3] media: rockchip: Add a driver for Rockchip's camera interface
Date:   Wed,  8 Nov 2023 17:38:57 +0100
Message-ID: <bcc0b84f4a6a8cf4c007cfe25025060b22627408.1699460637.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699460637.git.mehdi.djait@bootlin.com>
References: <cover.1699460637.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a V4L2 driver for the Rockchip CIF video capture controller.

This controller supports multiple parallel interfaces, but for now only the
BT.656 interface could be tested, hence it's the only one that's supported
in the first version of this driver.

This controller can be found on RK3066, PX30, RK1808, RK3128 and RK3288,
but for now it's only been tested on the PX30.

CIF is implemented as a video node-centric driver.

Most of this driver was written following the BSP driver from rockchip,
removing the parts that either didn't fit correctly the guidelines, or that
couldn't be tested.

This basic version doesn't support cropping nor scaling and is only
designed with one SDTV video decoder being attached to it at any time.

This version uses the "pingpong" mode of the controller, which is a
double-buffering mechanism.

Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
---
 MAINTAINERS                                   |    7 +
 drivers/media/platform/rockchip/Kconfig       |    1 +
 drivers/media/platform/rockchip/Makefile      |    1 +
 drivers/media/platform/rockchip/cif/Kconfig   |   13 +
 drivers/media/platform/rockchip/cif/Makefile  |    3 +
 drivers/media/platform/rockchip/cif/capture.c | 1152 +++++++++++++++++
 drivers/media/platform/rockchip/cif/dev.c     |  289 +++++
 drivers/media/platform/rockchip/cif/dev.h     |  139 ++
 drivers/media/platform/rockchip/cif/regs.h    |  192 +++
 9 files changed, 1797 insertions(+)
 create mode 100644 drivers/media/platform/rockchip/cif/Kconfig
 create mode 100644 drivers/media/platform/rockchip/cif/Makefile
 create mode 100644 drivers/media/platform/rockchip/cif/capture.c
 create mode 100644 drivers/media/platform/rockchip/cif/dev.c
 create mode 100644 drivers/media/platform/rockchip/cif/dev.h
 create mode 100644 drivers/media/platform/rockchip/cif/regs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b47e0b56859..f47a828d08a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18523,6 +18523,13 @@ F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
 F:	drivers/hid/hid-roccat*
 F:	include/linux/hid-roccat*
 
+ROCKCHIP CIF DRIVER
+M:	Mehdi Djait <mehdi.djait@bootlin.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml
+F:	drivers/media/platform/rockchip/cif/
+
 ROCKCHIP CRYPTO DRIVERS
 M:	Corentin Labbe <clabbe@baylibre.com>
 L:	linux-crypto@vger.kernel.org
diff --git a/drivers/media/platform/rockchip/Kconfig b/drivers/media/platform/rockchip/Kconfig
index b41d3960c1b4..f73d68d1d2b6 100644
--- a/drivers/media/platform/rockchip/Kconfig
+++ b/drivers/media/platform/rockchip/Kconfig
@@ -2,5 +2,6 @@
 
 comment "Rockchip media platform drivers"
 
+source "drivers/media/platform/rockchip/cif/Kconfig"
 source "drivers/media/platform/rockchip/rga/Kconfig"
 source "drivers/media/platform/rockchip/rkisp1/Kconfig"
diff --git a/drivers/media/platform/rockchip/Makefile b/drivers/media/platform/rockchip/Makefile
index 4f782b876ac9..1a7aa1f8e134 100644
--- a/drivers/media/platform/rockchip/Makefile
+++ b/drivers/media/platform/rockchip/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-y += cif/
 obj-y += rga/
 obj-y += rkisp1/
diff --git a/drivers/media/platform/rockchip/cif/Kconfig b/drivers/media/platform/rockchip/cif/Kconfig
new file mode 100644
index 000000000000..68fc50c51f1c
--- /dev/null
+++ b/drivers/media/platform/rockchip/cif/Kconfig
@@ -0,0 +1,13 @@
+config VIDEO_ROCKCHIP_CIF
+	tristate "Rockchip CIF Video Camera Interface"
+	depends on VIDEO_DEV
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on V4L_PLATFORM_DRIVERS
+	depends on PM && COMMON_CLK
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_FWNODE
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  This is a driver for Rockchip SoC Camera interface. It supports
+	  parallel interfaces such as BT.656. This camera interface is both
+	  called VIP and CIF.
diff --git a/drivers/media/platform/rockchip/cif/Makefile b/drivers/media/platform/rockchip/cif/Makefile
new file mode 100644
index 000000000000..e44ef687aeb6
--- /dev/null
+++ b/drivers/media/platform/rockchip/cif/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_VIDEO_ROCKCHIP_CIF) += rockchip-cif.o
+rockchip-cif-objs += dev.o capture.o
diff --git a/drivers/media/platform/rockchip/cif/capture.c b/drivers/media/platform/rockchip/cif/capture.c
new file mode 100644
index 000000000000..f5f30884ebcc
--- /dev/null
+++ b/drivers/media/platform/rockchip/cif/capture.c
@@ -0,0 +1,1152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Rockchip CIF Camera Interface Driver
+ *
+ * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
+ * Copyright (C) 2020 Maxime Chevallier <maxime.chevallier@bootlin.com>
+ * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-fh.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-mc.h>
+#include <media/v4l2-subdev.h>
+#include <media/videobuf2-dma-contig.h>
+
+#include "dev.h"
+#include "regs.h"
+
+#define CIF_REQ_BUFS_MIN	2
+#define CIF_MIN_WIDTH		64
+#define CIF_MIN_HEIGHT		64
+#define CIF_MAX_WIDTH		8192
+#define CIF_MAX_HEIGHT		8192
+
+#define CIF_PLANE_Y		0
+#define CIF_PLANE_UV		1
+
+static struct cif_output_fmt out_fmts[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_NV16,
+		.fmt_val = CIF_FORMAT_YUV_OUTPUT_422 |
+			   CIF_FORMAT_UV_STORAGE_ORDER_UVUV,
+		.cplanes = 2,
+	}, {
+		.fourcc = V4L2_PIX_FMT_NV61,
+		.fmt_val = CIF_FORMAT_YUV_OUTPUT_422 |
+			   CIF_FORMAT_UV_STORAGE_ORDER_VUVU,
+		.cplanes = 2,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_NV12,
+		.fmt_val = CIF_FORMAT_YUV_OUTPUT_420 |
+			   CIF_FORMAT_UV_STORAGE_ORDER_UVUV,
+		.cplanes = 2,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_NV21,
+		.fmt_val = CIF_FORMAT_YUV_OUTPUT_420 |
+			   CIF_FORMAT_UV_STORAGE_ORDER_VUVU,
+		.cplanes = 2,
+	}, {
+		.fourcc = V4L2_PIX_FMT_RGB24,
+		.cplanes = 1,
+	}, {
+		.fourcc = V4L2_PIX_FMT_RGB565,
+		.cplanes = 1,
+	}, {
+		.fourcc = V4L2_PIX_FMT_BGR666,
+		.cplanes = 1,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SRGGB8,
+		.cplanes = 1,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGRBG8,
+		.cplanes = 1,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGBRG8,
+		.cplanes = 1,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SBGGR8,
+		.cplanes = 1,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SRGGB10,
+		.cplanes = 1,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGRBG10,
+		.cplanes = 1,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGBRG10,
+		.cplanes = 1,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SBGGR10,
+		.cplanes = 1,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SRGGB12,
+		.cplanes = 1,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGRBG12,
+		.cplanes = 1,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGBRG12,
+		.cplanes = 1,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SBGGR12,
+		.cplanes = 1,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SBGGR16,
+		.cplanes = 1,
+	}, {
+		.fourcc = V4L2_PIX_FMT_Y16,
+		.cplanes = 1,
+	}
+};
+
+static const struct cif_input_fmt in_fmts[] = {
+	{
+		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_UYVY,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_UYVY,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_VYUY8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_VYUY,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_VYUY8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_VYUY,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR8_1X8,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_8,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW8,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG8_1X8,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_8,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW8,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG8_1X8,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_8,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW8,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB8_1X8,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_8,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW8,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_10,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW10,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG10_1X10,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_10,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW10,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG10_1X10,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_10,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW10,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB10_1X10,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_10,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW10,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR12_1X12,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_12,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW12,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG12_1X12,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_12,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW12,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG12_1X12,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_12,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW12,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB12_1X12,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_12,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW12,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_RGB888_1X24,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RGB888,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_Y8_1X8,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_8,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW8,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_Y10_1X10,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_10,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW10,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_Y12_1X12,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_12,
+		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_RAW12,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}
+};
+
+static const struct
+cif_input_fmt *get_input_fmt(struct v4l2_subdev *sd)
+{
+	struct v4l2_subdev_format fmt;
+	u32 i;
+
+	fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
+	fmt.pad = 0;
+	v4l2_subdev_call(sd, pad, get_fmt, NULL, &fmt);
+
+	for (i = 0; i < ARRAY_SIZE(in_fmts); i++)
+		if (fmt.format.code == in_fmts[i].mbus_code &&
+		    fmt.format.field == in_fmts[i].field)
+			return &in_fmts[i];
+
+	v4l2_err(sd->v4l2_dev, "remote's mbus code not supported\n");
+	return NULL;
+}
+
+static struct
+cif_output_fmt *find_output_fmt(struct cif_stream *stream, u32 pixelfmt)
+{
+	struct cif_output_fmt *fmt;
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(out_fmts); i++) {
+		fmt = &out_fmts[i];
+		if (fmt->fourcc == pixelfmt)
+			return fmt;
+	}
+
+	return NULL;
+}
+
+static struct cif_buffer *cif_get_buffer(struct cif_stream *stream)
+{
+	struct cif_buffer *buff;
+
+	lockdep_assert_held(&stream->vbq_lock);
+
+	if (list_empty(&stream->buf_head))
+		return NULL;
+
+	buff = list_first_entry(&stream->buf_head, struct cif_buffer, queue);
+	list_del(&buff->queue);
+
+	return buff;
+}
+
+static int cif_init_buffers(struct cif_stream *stream)
+{
+	struct cif_device *cif_dev = stream->cifdev;
+	unsigned long lock_flags;
+
+	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
+
+	stream->buffs[0] = cif_get_buffer(stream);
+	stream->buffs[1] = cif_get_buffer(stream);
+
+	if (!(stream->buffs[0]) || !(stream->buffs[1])) {
+		spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
+		return -EINVAL;
+	}
+
+	stream->drop_frame = false;
+
+	cif_write(cif_dev, CIF_FRM0_ADDR_Y,
+		  stream->buffs[0]->buff_addr[CIF_PLANE_Y]);
+	cif_write(cif_dev, CIF_FRM0_ADDR_UV,
+		  stream->buffs[0]->buff_addr[CIF_PLANE_UV]);
+
+	cif_write(cif_dev, CIF_FRM1_ADDR_Y,
+		  stream->buffs[1]->buff_addr[CIF_PLANE_Y]);
+	cif_write(cif_dev, CIF_FRM1_ADDR_UV,
+		  stream->buffs[1]->buff_addr[CIF_PLANE_UV]);
+
+	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
+
+	return 0;
+}
+
+static void cif_assign_new_buffer_pingpong(struct cif_stream *stream)
+{
+	struct cif_device *cif_dev = stream->cifdev;
+	struct cif_buffer *buffer = NULL;
+	u32 frm_addr_y, frm_addr_uv;
+	unsigned long lock_flags;
+
+	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
+
+	buffer = cif_get_buffer(stream);
+
+	/*
+	 * In Pingpong mode:
+	 * After one frame0 captured, CIF will start to capture the next frame1
+	 * automatically.
+	 *
+	 * If there is no buffer:
+	 * 1. Make the next frame0 write to the buffer of frame1.
+	 *
+	 * 2. Drop the frame1: Don't return it to user-space, as it will be
+	 *    overwritten by the next frame0.
+	 */
+	if (!buffer) {
+		stream->drop_frame = true;
+		buffer = stream->buffs[1 - stream->frame_phase];
+	} else {
+		stream->drop_frame = false;
+	}
+
+	stream->buffs[stream->frame_phase] = buffer;
+	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
+
+	frm_addr_y = stream->frame_phase ? CIF_FRM1_ADDR_Y : CIF_FRM0_ADDR_Y;
+	frm_addr_uv = stream->frame_phase ? CIF_FRM1_ADDR_UV : CIF_FRM0_ADDR_UV;
+
+	cif_write(cif_dev, frm_addr_y, buffer->buff_addr[CIF_PLANE_Y]);
+	cif_write(cif_dev, frm_addr_uv, buffer->buff_addr[CIF_PLANE_UV]);
+}
+
+static void cif_stream_stop(struct cif_stream *stream)
+{
+	struct cif_device *cif_dev = stream->cifdev;
+	u32 val;
+
+	val = cif_read(cif_dev, CIF_CTRL);
+	cif_write(cif_dev, CIF_CTRL, val & (~CIF_CTRL_ENABLE_CAPTURE));
+	cif_write(cif_dev, CIF_INTEN, 0x0);
+	cif_write(cif_dev, CIF_INTSTAT, 0x3ff);
+	cif_write(cif_dev, CIF_FRAME_STATUS, 0x0);
+
+	stream->stopping = false;
+}
+
+static int cif_queue_setup(struct vb2_queue *queue,
+			   unsigned int *num_buffers,
+			   unsigned int *num_planes,
+			   unsigned int sizes[],
+			   struct device *alloc_devs[])
+{
+	struct cif_stream *stream = queue->drv_priv;
+	const struct v4l2_pix_format *pix;
+
+	pix = &stream->pix;
+
+	if (*num_planes) {
+		if (*num_planes != 1)
+			return -EINVAL;
+
+		if (sizes[0] < pix->sizeimage)
+			return -EINVAL;
+		return 0;
+	}
+
+	*num_planes = 1;
+
+	sizes[0] = pix->sizeimage;
+
+	*num_buffers = CIF_REQ_BUFS_MIN;
+
+	return 0;
+}
+
+static void cif_buf_queue(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct cif_buffer *cifbuf = to_cif_buffer(vbuf);
+	struct vb2_queue *queue = vb->vb2_queue;
+	struct cif_stream *stream = queue->drv_priv;
+	struct v4l2_pix_format *pix = &stream->pix;
+	unsigned long lock_flags;
+	int i;
+
+	struct cif_output_fmt *fmt = stream->cif_fmt_out;
+
+	memset(cifbuf->buff_addr, 0, sizeof(cifbuf->buff_addr));
+
+	cifbuf->buff_addr[0] = vb2_dma_contig_plane_dma_addr(vb, 0);
+
+	for (i = 0; i < fmt->cplanes - 1; i++)
+		cifbuf->buff_addr[i + 1] = cifbuf->buff_addr[i] +
+			pix->bytesperline * pix->height;
+
+	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
+	list_add_tail(&cifbuf->queue, &stream->buf_head);
+	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
+}
+
+static void cif_return_all_buffers(struct cif_stream *stream,
+				   enum vb2_buffer_state state)
+{
+	struct cif_buffer *buf;
+	unsigned long lock_flags;
+
+	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
+
+	if (stream->buffs[0]) {
+		vb2_buffer_done(&stream->buffs[0]->vb.vb2_buf, state);
+		stream->buffs[0] = NULL;
+	}
+
+	if (stream->buffs[1]) {
+		if (!stream->drop_frame)
+			vb2_buffer_done(&stream->buffs[1]->vb.vb2_buf, state);
+
+		stream->buffs[1] = NULL;
+	}
+
+	while (!list_empty(&stream->buf_head)) {
+		buf = cif_get_buffer(stream);
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
+	}
+
+	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
+}
+
+static void cif_stop_streaming(struct vb2_queue *queue)
+{
+	struct cif_stream *stream = queue->drv_priv;
+	struct cif_device *cif_dev = stream->cifdev;
+	struct v4l2_subdev *sd;
+	int ret;
+
+	stream->stopping = true;
+	ret = wait_event_timeout(stream->wq_stopped,
+				 !stream->stopping,
+				 msecs_to_jiffies(1000));
+	if (!ret) {
+		cif_stream_stop(stream);
+		stream->stopping = false;
+	}
+
+	/* Stop the sub device. */
+	sd = cif_dev->remote.sd;
+	v4l2_subdev_call(sd, video, s_stream, 0);
+
+	pm_runtime_put(cif_dev->dev);
+
+	cif_return_all_buffers(stream, VB2_BUF_STATE_ERROR);
+}
+
+static int cif_stream_start(struct cif_stream *stream)
+{
+	u32 val, mbus_flags, href_pol, vsync_pol, fmt_type,
+	    xfer_mode = 0, yc_swap = 0;
+	struct cif_device *cif_dev = stream->cifdev;
+	struct cif_remote *remote_info;
+	int ret;
+	u32 input_mode;
+
+	remote_info = &cif_dev->remote;
+	fmt_type = stream->cif_fmt_in->fmt_type;
+	stream->frame_idx = 0;
+	input_mode = (remote_info->std == V4L2_STD_NTSC) ?
+		      CIF_FORMAT_INPUT_MODE_NTSC :
+		      CIF_FORMAT_INPUT_MODE_PAL;
+	mbus_flags = remote_info->mbus.bus.parallel.flags;
+	href_pol = (mbus_flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH) ?
+			0 : CIF_FORMAT_HSY_LOW_ACTIVE;
+	vsync_pol = (mbus_flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH) ?
+			CIF_FORMAT_VSY_HIGH_ACTIVE : 0;
+
+	val = vsync_pol | href_pol | input_mode | stream->cif_fmt_out->fmt_val |
+	      stream->cif_fmt_in->dvp_fmt_val | xfer_mode | yc_swap;
+	cif_write(cif_dev, CIF_FOR, val);
+
+	val = stream->pix.width;
+	if (stream->cif_fmt_in->fmt_type == CIF_FMT_TYPE_RAW)
+		val = stream->pix.width * 2;
+
+	cif_write(cif_dev, CIF_VIR_LINE_WIDTH, val);
+	cif_write(cif_dev, CIF_SET_SIZE,
+		  stream->pix.width | (stream->pix.height << 16));
+
+	cif_write(cif_dev, CIF_FRAME_STATUS, CIF_FRAME_STAT_CLS);
+	cif_write(cif_dev, CIF_INTSTAT, CIF_INTSTAT_CLS);
+	cif_write(cif_dev, CIF_SCL_CTRL, (fmt_type == CIF_FMT_TYPE_YUV) ?
+					 CIF_SCL_CTRL_ENABLE_YUV_16BIT_BYPASS :
+					 CIF_SCL_CTRL_ENABLE_RAW_16BIT_BYPASS);
+
+	ret = cif_init_buffers(stream);
+	if (ret)
+		return ret;
+
+	cif_write(cif_dev, CIF_INTEN, CIF_INTEN_FRAME_END_EN |
+				      CIF_INTEN_LINE_ERR_EN |
+				      CIF_INTEN_PST_INF_FRAME_END_EN);
+
+	cif_write(cif_dev, CIF_CTRL, CIF_CTRL_AXI_BURST_16 |
+				     CIF_CTRL_MODE_PINGPONG |
+				     CIF_CTRL_ENABLE_CAPTURE);
+
+	return 0;
+}
+
+static int cif_start_streaming(struct vb2_queue *queue, unsigned int count)
+{
+	struct cif_stream *stream = queue->drv_priv;
+	struct cif_device *cif_dev = stream->cifdev;
+	struct v4l2_device *v4l2_dev = &cif_dev->v4l2_dev;
+	struct v4l2_subdev *sd;
+	int ret;
+
+	if (!cif_dev->remote.sd) {
+		ret = -ENODEV;
+		v4l2_err(v4l2_dev, "No remote subdev detected\n");
+		goto destroy_buf;
+	}
+
+	ret = pm_runtime_get_sync(cif_dev->dev);
+	if (ret < 0) {
+		v4l2_err(v4l2_dev, "Failed to get runtime pm, %d\n", ret);
+		goto destroy_buf;
+	}
+
+	sd = cif_dev->remote.sd;
+	stream->cif_fmt_in = get_input_fmt(cif_dev->remote.sd);
+
+	ret = cif_stream_start(stream);
+	if (ret < 0)
+		goto stop_stream;
+
+	ret = v4l2_subdev_call(sd, video, s_stream, 1);
+	if (ret < 0)
+		goto runtime_put;
+
+	return 0;
+
+runtime_put:
+	pm_runtime_put(cif_dev->dev);
+stop_stream:
+	cif_stream_stop(stream);
+destroy_buf:
+	cif_return_all_buffers(stream, VB2_BUF_STATE_QUEUED);
+
+	return ret;
+}
+
+static const struct vb2_ops cif_vb2_ops = {
+	.queue_setup = cif_queue_setup,
+	.buf_queue = cif_buf_queue,
+	.wait_prepare = vb2_ops_wait_prepare,
+	.wait_finish = vb2_ops_wait_finish,
+	.stop_streaming = cif_stop_streaming,
+	.start_streaming = cif_start_streaming,
+};
+
+static int cif_init_vb2_queue(struct vb2_queue *q,
+			      struct cif_stream *stream)
+{
+	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+	q->io_modes = VB2_MMAP | VB2_DMABUF;
+	q->drv_priv = stream;
+	q->ops = &cif_vb2_ops;
+	q->mem_ops = &vb2_dma_contig_memops;
+	q->buf_struct_size = sizeof(struct cif_buffer);
+	q->min_buffers_needed = CIF_REQ_BUFS_MIN;
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->lock = &stream->vlock;
+	q->dev = stream->cifdev->dev;
+
+	return vb2_queue_init(q);
+}
+
+static void cif_update_pix(struct cif_stream *stream,
+			   struct cif_output_fmt *fmt,
+			   struct v4l2_pix_format *pix)
+{
+	struct cif_remote *remote_info = &stream->cifdev->remote;
+	struct v4l2_subdev_format sd_fmt;
+	u32 width, height;
+
+	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
+	sd_fmt.pad = 0;
+	v4l2_subdev_call(remote_info->sd, pad, get_fmt, NULL, &sd_fmt);
+
+	width = clamp_t(u32, sd_fmt.format.width,
+			CIF_MIN_WIDTH, CIF_MAX_WIDTH);
+	height = clamp_t(u32, sd_fmt.format.height,
+			 CIF_MIN_HEIGHT, CIF_MAX_HEIGHT);
+
+	pix->width = width;
+	pix->height = height;
+	pix->field = sd_fmt.format.field;
+	pix->colorspace = sd_fmt.format.colorspace;
+	pix->ycbcr_enc = sd_fmt.format.ycbcr_enc;
+	pix->quantization = sd_fmt.format.quantization;
+	pix->xfer_func = sd_fmt.format.xfer_func;
+
+	v4l2_fill_pixfmt(pix, fmt->fourcc, pix->width, pix->height);
+}
+
+static int cif_set_fmt(struct cif_stream *stream,
+		       struct v4l2_pix_format *pix)
+{
+	struct cif_device *cif_dev = stream->cifdev;
+	struct v4l2_subdev_format sd_fmt;
+	struct cif_output_fmt *fmt;
+	int ret;
+
+	if (vb2_is_streaming(&stream->buf_queue))
+		return -EBUSY;
+
+	fmt = find_output_fmt(stream, pix->pixelformat);
+	if (!fmt)
+		fmt = &out_fmts[0];
+
+	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
+	sd_fmt.pad = 0;
+	sd_fmt.format.width = pix->width;
+	sd_fmt.format.height = pix->height;
+
+	ret = v4l2_subdev_call(cif_dev->remote.sd, pad, set_fmt, NULL, &sd_fmt);
+	if (ret)
+		return ret;
+
+	cif_update_pix(stream, fmt, pix);
+	stream->pix = *pix;
+	stream->cif_fmt_out = fmt;
+
+	return 0;
+}
+
+void cif_set_default_format(struct cif_device *cif_dev)
+{
+	struct cif_stream *stream = &cif_dev->stream;
+	struct v4l2_pix_format pix;
+
+	cif_dev->remote.std = V4L2_STD_NTSC;
+
+	pix.pixelformat = V4L2_PIX_FMT_NV12;
+	pix.width = CIF_DEFAULT_WIDTH;
+	pix.height = CIF_DEFAULT_HEIGHT;
+
+	cif_set_fmt(stream, &pix);
+}
+
+void cif_stream_init(struct cif_device *cif_dev)
+{
+	struct cif_stream *stream = &cif_dev->stream;
+	struct v4l2_pix_format pix;
+
+	memset(stream, 0, sizeof(*stream));
+	memset(&pix, 0, sizeof(pix));
+	stream->cifdev = cif_dev;
+
+	INIT_LIST_HEAD(&stream->buf_head);
+	spin_lock_init(&stream->vbq_lock);
+	init_waitqueue_head(&stream->wq_stopped);
+}
+
+static const struct v4l2_file_operations cif_fops = {
+	.open = v4l2_fh_open,
+	.release = vb2_fop_release,
+	.unlocked_ioctl = video_ioctl2,
+	.poll = vb2_fop_poll,
+	.mmap = vb2_fop_mmap,
+};
+
+static int cif_enum_input(struct file *file, void *priv,
+			  struct v4l2_input *input)
+{
+	struct cif_stream *stream = video_drvdata(file);
+	struct v4l2_subdev *sd = stream->cifdev->remote.sd;
+	int ret;
+
+	if (input->index > 0)
+		return -EINVAL;
+
+	ret = v4l2_subdev_call(sd, video, g_input_status, &input->status);
+	if (ret)
+		return ret;
+
+	strscpy(input->name, "Camera", sizeof(input->name));
+	input->type = V4L2_INPUT_TYPE_CAMERA;
+	input->std = stream->vdev.tvnorms;
+	input->capabilities = V4L2_IN_CAP_STD;
+
+	return 0;
+}
+
+static int cif_try_fmt_vid_cap(struct file *file, void *fh,
+			       struct v4l2_format *f)
+{
+	struct cif_stream *stream = video_drvdata(file);
+	struct cif_output_fmt *fmt;
+
+	fmt = find_output_fmt(stream, f->fmt.pix.pixelformat);
+	if (!fmt)
+		fmt = &out_fmts[0];
+
+	cif_update_pix(stream, fmt, &f->fmt.pix);
+
+	return 0;
+}
+
+static int cif_g_std(struct file *file, void *fh, v4l2_std_id *norm)
+{
+	struct cif_stream *stream = video_drvdata(file);
+	struct cif_remote *remote_info = &stream->cifdev->remote;
+
+	*norm = remote_info->std;
+
+	return 0;
+}
+
+static int cif_s_std(struct file *file, void *fh, v4l2_std_id norm)
+{
+	struct cif_stream *stream = video_drvdata(file);
+	struct cif_remote *remote_info = &stream->cifdev->remote;
+	int ret;
+
+	if (norm == remote_info->std)
+		return 0;
+
+	if (vb2_is_busy(&stream->buf_queue))
+		return -EBUSY;
+
+	ret = v4l2_subdev_call(remote_info->sd, video, s_std, norm);
+	if (ret)
+		return ret;
+
+	remote_info->std = norm;
+
+	/* S_STD will update the format since that depends on the standard. */
+	cif_update_pix(stream, stream->cif_fmt_out, &stream->pix);
+
+	return 0;
+}
+
+static int cif_querystd(struct file *file, void *fh, v4l2_std_id *a)
+{
+	struct cif_stream *stream = video_drvdata(file);
+	struct cif_remote *remote_info = &stream->cifdev->remote;
+
+	*a = V4L2_STD_UNKNOWN;
+
+	return v4l2_subdev_call(remote_info->sd, video, querystd, a);
+}
+
+static int cif_enum_fmt_vid_cap(struct file *file, void *priv,
+				struct v4l2_fmtdesc *f)
+{
+	struct cif_output_fmt *fmt = NULL;
+
+	if (f->index >= ARRAY_SIZE(out_fmts))
+		return -EINVAL;
+
+	fmt = &out_fmts[f->index];
+	f->pixelformat = fmt->fourcc;
+
+	return 0;
+}
+
+static int cif_s_fmt_vid_cap(struct file *file,
+			     void *priv, struct v4l2_format *f)
+{
+	struct cif_stream *stream = video_drvdata(file);
+	int ret;
+
+	if (vb2_is_busy(&stream->buf_queue))
+		return -EBUSY;
+
+	ret = cif_set_fmt(stream, &f->fmt.pix);
+
+	return ret;
+}
+
+static int cif_g_fmt_vid_cap(struct file *file, void *fh,
+			     struct v4l2_format *f)
+{
+	struct cif_stream *stream = video_drvdata(file);
+
+	f->fmt.pix = stream->pix;
+
+	return 0;
+}
+
+static int cif_querycap(struct file *file, void *priv,
+			struct v4l2_capability *cap)
+{
+	struct cif_stream *stream = video_drvdata(file);
+	struct device *dev = stream->cifdev->dev;
+
+	strscpy(cap->driver, dev->driver->name, sizeof(cap->driver));
+	strscpy(cap->card, dev->driver->name, sizeof(cap->card));
+	snprintf(cap->bus_info, sizeof(cap->bus_info),
+		 "platform:%s", dev_name(dev));
+
+	return 0;
+}
+
+static int cif_enum_framesizes(struct file *file, void *fh,
+			       struct v4l2_frmsizeenum *fsize)
+{
+	struct cif_stream *stream = video_drvdata(file);
+	struct cif_device *cif_dev = stream->cifdev;
+	struct v4l2_subdev_frame_size_enum fse = {
+		.index = fsize->index,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	struct cif_output_fmt *fmt;
+	int ret;
+
+	if (!cif_dev->remote.sd)
+		return -ENODEV;
+
+	fmt = find_output_fmt(stream, fsize->pixel_format);
+	if (!fmt)
+		return -EINVAL;
+
+	fse.code = fmt->mbus;
+
+	ret = v4l2_subdev_call(cif_dev->remote.sd, pad, enum_frame_size,
+			       NULL, &fse);
+	if (ret)
+		return ret;
+
+	fsize->type = V4L2_FRMSIZE_TYPE_DISCRETE;
+	fsize->discrete.width = fse.max_width;
+	fsize->discrete.height = fse.max_height;
+
+	return 0;
+}
+
+static int cif_enum_frameintervals(struct file *file, void *fh,
+				   struct v4l2_frmivalenum *fival)
+{
+	struct cif_stream *stream = video_drvdata(file);
+	struct cif_device *cif_dev = stream->cifdev;
+	struct v4l2_subdev_frame_interval_enum fie = {
+		.index = fival->index,
+		.width = fival->width,
+		.height = fival->height,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	struct cif_output_fmt *fmt;
+	int ret;
+
+	if (!cif_dev->remote.sd)
+		return -ENODEV;
+
+	fmt = find_output_fmt(stream, fival->pixel_format);
+	if (!fmt)
+		return -EINVAL;
+
+	fie.code = fmt->mbus;
+
+	ret = v4l2_subdev_call(cif_dev->remote.sd, pad, enum_frame_interval,
+			       NULL, &fie);
+	if (ret)
+		return ret;
+
+	fival->type = V4L2_FRMSIZE_TYPE_DISCRETE;
+	fival->discrete = fie.interval;
+
+	return 0;
+}
+
+static int cif_g_input(struct file *file, void *fh, unsigned int *i)
+{
+	*i = 0;
+	return 0;
+}
+
+static int cif_s_input(struct file *file, void *fh, unsigned int i)
+{
+	if (i)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int cif_g_parm(struct file *file, void *priv, struct v4l2_streamparm *p)
+{
+	struct cif_stream *stream = video_drvdata(file);
+	struct cif_device *cif_dev = stream->cifdev;
+
+	if (!cif_dev->remote.sd)
+		return -ENODEV;
+
+	return v4l2_g_parm_cap(video_devdata(file), cif_dev->remote.sd, p);
+}
+
+static int cif_s_parm(struct file *file, void *priv, struct v4l2_streamparm *p)
+{
+	struct cif_stream *stream = video_drvdata(file);
+	struct cif_device *cif_dev = stream->cifdev;
+
+	if (!cif_dev->remote.sd)
+		return -ENODEV;
+
+	return v4l2_s_parm_cap(video_devdata(file), cif_dev->remote.sd, p);
+}
+
+static const struct v4l2_ioctl_ops cif_v4l2_ioctl_ops = {
+	.vidioc_reqbufs = vb2_ioctl_reqbufs,
+	.vidioc_querybuf = vb2_ioctl_querybuf,
+	.vidioc_create_bufs = vb2_ioctl_create_bufs,
+	.vidioc_qbuf = vb2_ioctl_qbuf,
+	.vidioc_expbuf = vb2_ioctl_expbuf,
+	.vidioc_dqbuf = vb2_ioctl_dqbuf,
+	.vidioc_prepare_buf = vb2_ioctl_prepare_buf,
+	.vidioc_streamon = vb2_ioctl_streamon,
+	.vidioc_streamoff = vb2_ioctl_streamoff,
+
+	.vidioc_g_std = cif_g_std,
+	.vidioc_s_std = cif_s_std,
+	.vidioc_querystd = cif_querystd,
+
+	.vidioc_enum_fmt_vid_cap = cif_enum_fmt_vid_cap,
+	.vidioc_try_fmt_vid_cap = cif_try_fmt_vid_cap,
+	.vidioc_s_fmt_vid_cap = cif_s_fmt_vid_cap,
+	.vidioc_g_fmt_vid_cap = cif_g_fmt_vid_cap,
+	.vidioc_querycap = cif_querycap,
+	.vidioc_enum_framesizes = cif_enum_framesizes,
+	.vidioc_enum_frameintervals = cif_enum_frameintervals,
+
+	.vidioc_enum_input = cif_enum_input,
+	.vidioc_g_input = cif_g_input,
+	.vidioc_s_input = cif_s_input,
+
+	.vidioc_g_parm = cif_g_parm,
+	.vidioc_s_parm = cif_s_parm,
+};
+
+void cif_unregister_stream_vdev(struct cif_device *cif_dev)
+{
+	struct cif_stream *stream = &cif_dev->stream;
+
+	media_entity_cleanup(&stream->vdev.entity);
+	video_unregister_device(&stream->vdev);
+}
+
+int cif_register_stream_vdev(struct cif_device *cif_dev)
+{
+	struct cif_stream *stream = &cif_dev->stream;
+	struct v4l2_device *v4l2_dev = &cif_dev->v4l2_dev;
+	struct video_device *vdev = &stream->vdev;
+	int ret;
+
+	strscpy(vdev->name, CIF_DRIVER_NAME, sizeof(vdev->name));
+	mutex_init(&stream->vlock);
+
+	vdev->ioctl_ops = &cif_v4l2_ioctl_ops;
+	vdev->release = video_device_release_empty;
+	vdev->fops = &cif_fops;
+	vdev->minor = -1;
+	vdev->v4l2_dev = v4l2_dev;
+	vdev->lock = &stream->vlock;
+	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE |
+			    V4L2_CAP_STREAMING;
+	vdev->tvnorms = V4L2_STD_NTSC | V4L2_STD_PAL;
+	video_set_drvdata(vdev, stream);
+	vdev->vfl_dir = VFL_DIR_RX;
+	stream->pad.flags = MEDIA_PAD_FL_SINK;
+
+	cif_init_vb2_queue(&stream->buf_queue, stream);
+
+	vdev->queue = &stream->buf_queue;
+	strscpy(vdev->name, KBUILD_MODNAME, sizeof(vdev->name));
+
+	ret = media_entity_pads_init(&vdev->entity, 1, &stream->pad);
+	if (ret < 0)
+		return ret;
+
+	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
+	if (ret < 0)
+		v4l2_err(v4l2_dev,
+			 "video_register_device failed with error %d\n", ret);
+
+	return ret;
+}
+
+static void cif_vb_done(struct cif_stream *stream,
+			struct vb2_v4l2_buffer *vb_done)
+{
+	vb2_set_plane_payload(&vb_done->vb2_buf, 0,
+			      stream->pix.sizeimage);
+	vb_done->vb2_buf.timestamp = ktime_get_ns();
+	vb_done->sequence = stream->frame_idx;
+	vb2_buffer_done(&vb_done->vb2_buf, VB2_BUF_STATE_DONE);
+}
+
+static void cif_reset_stream(struct cif_device *cif_dev)
+{
+	u32 ctl = cif_read(cif_dev, CIF_CTRL);
+
+	cif_write(cif_dev, CIF_CTRL, ctl & (~CIF_CTRL_ENABLE_CAPTURE));
+	cif_write(cif_dev, CIF_CTRL, ctl | CIF_CTRL_ENABLE_CAPTURE);
+}
+
+irqreturn_t cif_irq_pingpong(int irq, void *ctx)
+{
+	struct device *dev = ctx;
+	struct cif_device *cif_dev = dev_get_drvdata(dev);
+	struct cif_stream *stream = &cif_dev->stream;
+	unsigned int intstat;
+	u32 lastline, lastpix, ctl, cif_frmst;
+
+	intstat = cif_read(cif_dev, CIF_INTSTAT);
+	cif_frmst = cif_read(cif_dev, CIF_FRAME_STATUS);
+	lastline = CIF_FETCH_Y_LAST_LINE(cif_read(cif_dev, CIF_LAST_LINE));
+	lastpix =  CIF_FETCH_Y_LAST_LINE(cif_read(cif_dev, CIF_LAST_PIX));
+	ctl = cif_read(cif_dev, CIF_CTRL);
+
+	/*
+	 * There are two irqs enabled:
+	 *  - PST_INF_FRAME_END: cif FIFO is ready,
+	 *    this is prior to FRAME_END
+	 *  - FRAME_END: cif has saved frame to memory,
+	 *    a frame ready
+	 */
+
+	if (intstat & CIF_INTSTAT_PST_INF_FRAME_END) {
+		cif_write(cif_dev, CIF_INTSTAT,
+			  CIF_INTSTAT_PST_INF_FRAME_END_CLR);
+
+		if (stream->stopping)
+			/* To stop CIF ASAP, before FRAME_END irq. */
+			cif_write(cif_dev, CIF_CTRL,
+				  ctl & (~CIF_CTRL_ENABLE_CAPTURE));
+	}
+
+	if (intstat & CIF_INTSTAT_PRE_INF_FRAME_END)
+		cif_write(cif_dev, CIF_INTSTAT, CIF_INTSTAT_PRE_INF_FRAME_END);
+
+	if (intstat & (CIF_INTSTAT_LINE_ERR | CIF_INTSTAT_PIX_ERR)) {
+		v4l2_err(&cif_dev->v4l2_dev,
+			 "LINE_ERR OR PIX_ERR detected, stream will be reset");
+		cif_write(cif_dev, CIF_INTSTAT, CIF_INTSTAT_LINE_ERR |
+						CIF_INTSTAT_PIX_ERR);
+		cif_reset_stream(cif_dev);
+	}
+
+	if (intstat & CIF_INTSTAT_FRAME_END) {
+		struct vb2_v4l2_buffer *vb_done = NULL;
+
+		cif_write(cif_dev, CIF_INTSTAT, CIF_INTSTAT_FRAME_END_CLR |
+						CIF_INTSTAT_LINE_END_CLR);
+
+		if (stream->stopping) {
+			cif_stream_stop(stream);
+			wake_up(&stream->wq_stopped);
+			return IRQ_HANDLED;
+		}
+
+		if (lastline != stream->pix.height) {
+			v4l2_err(&cif_dev->v4l2_dev,
+				 "Bad frame, irq:%#x frmst:%#x size:%dx%d\n",
+				 intstat, cif_frmst, lastpix, lastline);
+
+			cif_reset_stream(cif_dev);
+		}
+
+		if (cif_frmst & CIF_INTSTAT_F0_READY)
+			stream->frame_phase = 0;
+		else if (cif_frmst & CIF_INTSTAT_F1_READY)
+			stream->frame_phase = 1;
+		else
+			return IRQ_HANDLED;
+
+		vb_done = &stream->buffs[stream->frame_phase]->vb;
+		if (!stream->drop_frame) {
+			cif_vb_done(stream, vb_done);
+			stream->frame_idx++;
+		}
+
+		cif_assign_new_buffer_pingpong(stream);
+	}
+
+	return IRQ_HANDLED;
+}
diff --git a/drivers/media/platform/rockchip/cif/dev.c b/drivers/media/platform/rockchip/cif/dev.c
new file mode 100644
index 000000000000..f7d061a13577
--- /dev/null
+++ b/drivers/media/platform/rockchip/cif/dev.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Rockchip CIF Camera Interface Driver
+ *
+ * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
+ * Copyright (C) 2020 Maxime Chevallier <maxime.chevallier@bootlin.com>
+ * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
+ */
+
+#include "linux/platform_device.h"
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/reset.h>
+#include <linux/pm_runtime.h>
+#include <linux/pinctrl/consumer.h>
+#include <media/v4l2-fwnode.h>
+
+#include "dev.h"
+#include "regs.h"
+
+static int subdev_notifier_complete(struct v4l2_async_notifier *notifier)
+{
+	struct cif_device *cif_dev;
+	struct v4l2_subdev *sd;
+	int ret;
+
+	cif_dev = container_of(notifier, struct cif_device, notifier);
+	sd = cif_dev->remote.sd;
+
+	mutex_lock(&cif_dev->media_dev.graph_mutex);
+
+	ret = v4l2_device_register_subdev_nodes(&cif_dev->v4l2_dev);
+	if (ret < 0)
+		goto unlock;
+
+	ret = media_create_pad_link(&sd->entity, 0,
+				    &cif_dev->stream.vdev.entity, 0,
+				    MEDIA_LNK_FL_ENABLED);
+	if (ret)
+		dev_err(cif_dev->dev, "failed to create link");
+
+unlock:
+	mutex_unlock(&cif_dev->media_dev.graph_mutex);
+	return ret;
+}
+
+static int subdev_notifier_bound(struct v4l2_async_notifier *notifier,
+				 struct v4l2_subdev *subdev,
+				 struct v4l2_async_connection *asd)
+{
+	struct cif_device *cif_dev = container_of(notifier,
+						  struct cif_device, notifier);
+	int pad;
+
+	cif_dev->remote.sd = subdev;
+	pad = media_entity_get_fwnode_pad(&subdev->entity, subdev->fwnode,
+					  MEDIA_PAD_FL_SOURCE);
+	if (pad < 0)
+		return pad;
+
+	cif_dev->remote.pad = pad;
+
+	return 0;
+}
+
+static const struct v4l2_async_notifier_operations subdev_notifier_ops = {
+	.bound = subdev_notifier_bound,
+	.complete = subdev_notifier_complete,
+};
+
+static int cif_subdev_notifier(struct cif_device *cif_dev)
+{
+	struct v4l2_async_notifier *ntf = &cif_dev->notifier;
+	struct device *dev = cif_dev->dev;
+	struct v4l2_async_connection *asd;
+	struct v4l2_fwnode_endpoint vep = {
+		.bus_type = V4L2_MBUS_PARALLEL,
+	};
+	struct fwnode_handle *ep;
+	int ret;
+
+	v4l2_async_nf_init(ntf, &cif_dev->v4l2_dev);
+
+	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 0, 0,
+					     FWNODE_GRAPH_ENDPOINT_NEXT);
+	if (!ep)
+		return -EINVAL;
+
+	ret = v4l2_fwnode_endpoint_parse(ep, &vep);
+	if (ret)
+		return ret;
+
+	asd = v4l2_async_nf_add_fwnode_remote(ntf, ep,
+					      struct v4l2_async_connection);
+	if (IS_ERR(asd))
+		return PTR_ERR(asd);
+
+	ntf->ops = &subdev_notifier_ops;
+
+	fwnode_handle_put(ep);
+
+	return v4l2_async_nf_register(ntf);
+}
+
+static struct clk_bulk_data px30_cif_clks[] = {
+	{ .id = "aclk", },
+	{ .id = "hclk", },
+	{ .id = "pclk", },
+};
+
+static const struct cif_match_data px30_cif_match_data = {
+	.clks = px30_cif_clks,
+	.clks_num = ARRAY_SIZE(px30_cif_clks),
+};
+
+static const struct of_device_id cif_plat_of_match[] = {
+	{
+		.compatible = "rockchip,px30-vip",
+		.data = &px30_cif_match_data,
+	},
+	{},
+};
+
+static int cif_get_resource(struct platform_device *pdev,
+			    struct cif_device *cif_dev)
+{
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev,
+			"Unable to allocate resources for device\n");
+		return -ENODEV;
+	}
+
+	cif_dev->base_addr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(cif_dev->base_addr))
+		return PTR_ERR(cif_dev->base_addr);
+
+	return 0;
+}
+
+static int cif_plat_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct v4l2_device *v4l2_dev;
+	struct cif_device *cif_dev;
+	int ret, irq;
+
+	cif_dev = devm_kzalloc(dev, sizeof(*cif_dev), GFP_KERNEL);
+	if (!cif_dev)
+		return -ENOMEM;
+
+	cif_dev->match_data = of_device_get_match_data(dev);
+	if (!cif_dev->match_data)
+		return -ENODEV;
+
+	platform_set_drvdata(pdev, cif_dev);
+	cif_dev->dev = dev;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, cif_irq_pingpong, IRQF_SHARED,
+			       dev_driver_string(dev), dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "request irq failed\n");
+
+	cif_dev->irq = irq;
+
+	ret = cif_get_resource(pdev, cif_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_clk_bulk_get(dev, cif_dev->match_data->clks_num,
+				cif_dev->match_data->clks);
+	if (ret)
+		return ret;
+
+	cif_dev->cif_rst = devm_reset_control_array_get(dev, false, false);
+	if (IS_ERR(cif_dev->cif_rst))
+		return PTR_ERR(cif_dev->cif_rst);
+
+	cif_stream_init(cif_dev);
+	strscpy(cif_dev->media_dev.model, "cif",
+		sizeof(cif_dev->media_dev.model));
+	cif_dev->media_dev.dev = &pdev->dev;
+	v4l2_dev = &cif_dev->v4l2_dev;
+	v4l2_dev->mdev = &cif_dev->media_dev;
+	strscpy(v4l2_dev->name, "rockchip-cif", sizeof(v4l2_dev->name));
+
+	ret = v4l2_device_register(cif_dev->dev, &cif_dev->v4l2_dev);
+	if (ret < 0)
+		return ret;
+
+	media_device_init(&cif_dev->media_dev);
+
+	ret = media_device_register(&cif_dev->media_dev);
+	if (ret < 0)
+		goto err_unreg_v4l2_dev;
+
+	/* Create & register platform subdev. */
+	ret = cif_register_stream_vdev(cif_dev);
+	if (ret < 0)
+		goto err_unreg_media_dev;
+
+	ret = cif_subdev_notifier(cif_dev);
+	if (ret < 0) {
+		v4l2_err(&cif_dev->v4l2_dev,
+			 "Failed to register subdev notifier(%d)\n", ret);
+		goto err_unreg_stream_vdev;
+	}
+
+	cif_set_default_format(cif_dev);
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+
+err_unreg_stream_vdev:
+	cif_unregister_stream_vdev(cif_dev);
+err_unreg_media_dev:
+	media_device_unregister(&cif_dev->media_dev);
+err_unreg_v4l2_dev:
+	v4l2_device_unregister(&cif_dev->v4l2_dev);
+	return ret;
+}
+
+static int cif_plat_remove(struct platform_device *pdev)
+{
+	struct cif_device *cif_dev = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+
+	media_device_unregister(&cif_dev->media_dev);
+	v4l2_device_unregister(&cif_dev->v4l2_dev);
+	cif_unregister_stream_vdev(cif_dev);
+
+	return 0;
+}
+
+static int __maybe_unused cif_runtime_suspend(struct device *dev)
+{
+	struct cif_device *cif_dev = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(cif_dev->match_data->clks_num,
+				   cif_dev->match_data->clks);
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int __maybe_unused cif_runtime_resume(struct device *dev)
+{
+	struct cif_device *cif_dev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret < 0)
+		return ret;
+
+	return clk_bulk_prepare_enable(cif_dev->match_data->clks_num,
+				       cif_dev->match_data->clks);
+}
+
+static const struct dev_pm_ops cif_plat_pm_ops = {
+	.runtime_suspend = cif_runtime_suspend,
+	.runtime_resume	 = cif_runtime_resume,
+};
+
+static struct platform_driver cif_plat_drv = {
+	.driver = {
+		   .name = CIF_DRIVER_NAME,
+		   .of_match_table = cif_plat_of_match,
+		   .pm = &cif_plat_pm_ops,
+	},
+	.probe = cif_plat_probe,
+	.remove = cif_plat_remove,
+};
+module_platform_driver(cif_plat_drv);
+
+MODULE_AUTHOR("Rockchip Camera/ISP team");
+MODULE_DESCRIPTION("Rockchip CIF platform driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/media/platform/rockchip/cif/dev.h b/drivers/media/platform/rockchip/cif/dev.h
new file mode 100644
index 000000000000..3be3db08c75b
--- /dev/null
+++ b/drivers/media/platform/rockchip/cif/dev.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Rockchip CIF Driver
+ *
+ * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
+ * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
+ */
+
+#ifndef _CIF_DEV_H
+#define _CIF_DEV_H
+
+#include <linux/clk.h>
+#include <linux/mutex.h>
+
+#include <media/media-device.h>
+#include <media/media-entity.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
+#include <media/videobuf2-v4l2.h>
+
+#define CIF_DRIVER_NAME		"rockchip-cif"
+
+#define CIF_MAX_BUS_CLK		8
+#define CIF_MAX_SENSOR		1
+#define CIF_MAX_RESET		5
+#define CIF_MAX_CSI_CHANNEL	4
+
+#define CIF_DEFAULT_WIDTH	640
+#define CIF_DEFAULT_HEIGHT	480
+
+struct cif_buffer {
+	struct vb2_v4l2_buffer	vb;
+	struct list_head	queue;
+	u32			buff_addr[VIDEO_MAX_PLANES];
+};
+
+static inline struct cif_buffer *to_cif_buffer(struct vb2_v4l2_buffer *vb)
+{
+	return container_of(vb, struct cif_buffer, vb);
+}
+
+struct cif_remote {
+	struct v4l2_subdev	*sd;
+	int			pad;
+	struct v4l2_mbus_config mbus;
+	int			lanes;
+	v4l2_std_id		std;
+};
+
+struct cif_output_fmt {
+	u32	fourcc;
+	u32	mbus;
+	u32	fmt_val;
+	u8	cplanes;
+};
+
+enum cif_fmt_type {
+	CIF_FMT_TYPE_YUV = 0,
+	CIF_FMT_TYPE_RAW,
+};
+
+struct cif_input_fmt {
+	u32			mbus_code;
+	u32			dvp_fmt_val;
+	u32			csi_fmt_val;
+	enum cif_fmt_type	fmt_type;
+	enum v4l2_field		field;
+};
+
+struct cif_stream {
+	struct cif_device		*cifdev;
+	bool				stopping;
+	wait_queue_head_t		wq_stopped;
+	int				frame_idx;
+	int				frame_phase;
+	bool				drop_frame;
+
+	/* Lock between irq and buf_queue, buffs. */
+	spinlock_t			vbq_lock;
+	struct vb2_queue		buf_queue;
+	struct list_head		buf_head;
+	struct cif_buffer		*buffs[2];
+
+	/* Vfd lock. */
+	struct mutex			vlock;
+	struct video_device		vdev;
+	struct media_pad		pad;
+
+	struct cif_output_fmt		*cif_fmt_out;
+	const struct cif_input_fmt	*cif_fmt_in;
+	struct v4l2_pix_format		pix;
+};
+
+static inline struct cif_stream *to_cif_stream(struct video_device *vdev)
+{
+	return container_of(vdev, struct cif_stream, vdev);
+}
+
+struct cif_match_data {
+	struct clk_bulk_data *clks;
+	int clks_num;
+};
+
+struct cif_device {
+	struct device			*dev;
+	int				irq;
+	void __iomem			*base_addr;
+	struct reset_control		*cif_rst;
+
+	struct v4l2_device		v4l2_dev;
+	struct media_device		media_dev;
+	struct v4l2_async_notifier	notifier;
+	struct v4l2_async_connection	asd;
+	struct cif_remote		remote;
+
+	struct cif_stream		stream;
+	const struct cif_match_data	*match_data;
+};
+
+static inline void
+cif_write(struct cif_device *cif_dev, unsigned int addr, u32 val)
+{
+	writel(val, cif_dev->base_addr + addr);
+}
+
+static inline u32 cif_read(struct cif_device *cif_dev, unsigned int addr)
+{
+	return readl(cif_dev->base_addr + addr);
+}
+
+void cif_unregister_stream_vdev(struct cif_device *dev);
+int cif_register_stream_vdev(struct cif_device *dev);
+void cif_stream_init(struct cif_device *dev);
+void cif_set_default_format(struct cif_device *dev);
+
+irqreturn_t cif_irq_pingpong(int irq, void *ctx);
+void cif_soft_reset(struct cif_device *cif_dev);
+
+#endif
diff --git a/drivers/media/platform/rockchip/cif/regs.h b/drivers/media/platform/rockchip/cif/regs.h
new file mode 100644
index 000000000000..cc39bf9ce8da
--- /dev/null
+++ b/drivers/media/platform/rockchip/cif/regs.h
@@ -0,0 +1,192 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Rockchip CIF Driver
+ *
+ * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
+ * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
+ */
+
+#ifndef _CIF_REGS_H
+#define _CIF_REGS_H
+
+#define CIF_CTRL				0x00
+#define CIF_INTEN				0x04
+#define CIF_INTSTAT				0x08
+#define CIF_FOR					0x0c
+#define CIF_LINE_NUM_ADDR			0x10
+#define CIF_FRM0_ADDR_Y				0x14
+#define CIF_FRM0_ADDR_UV			0x18
+#define CIF_FRM1_ADDR_Y				0x1c
+#define CIF_FRM1_ADDR_UV			0x20
+#define CIF_VIR_LINE_WIDTH			0x24
+#define CIF_SET_SIZE				0x28
+#define CIF_SCM_ADDR_Y				0x2c
+#define CIF_SCM_ADDR_U				0x30
+#define CIF_SCM_ADDR_V				0x34
+#define CIF_WB_UP_FILTER			0x38
+#define CIF_WB_LOW_FILTER			0x3c
+#define CIF_WBC_CNT				0x40
+#define CIF_CROP				0x44
+#define CIF_SCL_CTRL				0x48
+#define CIF_SCL_DST				0x4c
+#define CIF_SCL_FCT				0x50
+#define CIF_SCL_VALID_NUM			0x54
+#define CIF_LINE_LOOP_CTR			0x58
+#define CIF_FRAME_STATUS			0x60
+#define CIF_CUR_DST				0x64
+#define CIF_LAST_LINE				0x68
+#define CIF_LAST_PIX				0x6c
+#define CIF_FETCH_Y_LAST_LINE(VAL)		((VAL) & 0x1fff)
+
+#define CIF_CTRL_ENABLE_CAPTURE			BIT(0)
+#define CIF_CTRL_MODE_PINGPONG			BIT(1)
+#define CIF_CTRL_MODE_LINELOOP			BIT(2)
+#define CIF_CTRL_AXI_BURST_16			(0xf << 12)
+
+#define CIF_INTEN_FRAME_END_EN			BIT(0)
+#define CIF_INTEN_LINE_ERR_EN			BIT(2)
+#define CIF_INTEN_BUS_ERR_EN			BIT(6)
+#define CIF_INTEN_SCL_ERR_EN			BIT(7)
+#define CIF_INTEN_PST_INF_FRAME_END_EN		BIT(9)
+
+#define CIF_INTSTAT_CLS				0x3ff
+#define CIF_INTSTAT_FRAME_END			BIT(0)
+#define CIF_INTSTAT_LINE_END			BIT(1)
+#define CIF_INTSTAT_LINE_ERR			BIT(2)
+#define CIF_INTSTAT_PIX_ERR			BIT(3)
+#define CIF_INTSTAT_DFIFO_OF			BIT(5)
+#define CIF_INTSTAT_BUS_ERR			BIT(6)
+#define CIF_INTSTAT_PRE_INF_FRAME_END		BIT(8)
+#define CIF_INTSTAT_PST_INF_FRAME_END		BIT(9)
+#define CIF_INTSTAT_FRAME_END_CLR		BIT(0)
+#define CIF_INTSTAT_LINE_END_CLR		BIT(1)
+#define CIF_INTSTAT_LINE_ERR_CLR		BIT(2)
+#define CIF_INTSTAT_PST_INF_FRAME_END_CLR	BIT(9)
+#define CIF_INTSTAT_ERR				0xfc
+
+#define CIF_FRAME_STAT_CLS			0x00
+#define CIF_FRAME_FRM0_STAT_CLS			0x20
+
+#define CIF_FORMAT_VSY_HIGH_ACTIVE		BIT(0)
+#define CIF_FORMAT_HSY_LOW_ACTIVE		BIT(1)
+
+#define CIF_FORMAT_INPUT_MODE_YUV		(0x00 << 2)
+#define CIF_FORMAT_INPUT_MODE_PAL		(0x02 << 2)
+#define CIF_FORMAT_INPUT_MODE_NTSC		(0x03 << 2)
+#define CIF_FORMAT_INPUT_MODE_BT1120		(0x07 << 2)
+#define CIF_FORMAT_INPUT_MODE_RAW		(0x04 << 2)
+#define CIF_FORMAT_INPUT_MODE_JPEG		(0x05 << 2)
+#define CIF_FORMAT_INPUT_MODE_MIPI		(0x06 << 2)
+
+#define CIF_FORMAT_YUV_INPUT_ORDER_UYVY		(0x00 << 5)
+#define CIF_FORMAT_YUV_INPUT_ORDER_YVYU		BIT(5)
+#define CIF_FORMAT_YUV_INPUT_ORDER_VYUY		BIT(6)
+#define CIF_FORMAT_YUV_INPUT_ORDER_YUYV		(0x03 << 5)
+#define CIF_FORMAT_YUV_INPUT_422		(0x00 << 7)
+#define CIF_FORMAT_YUV_INPUT_420		BIT(7)
+
+#define CIF_FORMAT_INPUT_420_ORDER_ODD		BIT(8)
+
+#define CIF_FORMAT_CCIR_INPUT_ORDER_EVEN	BIT(9)
+
+#define CIF_FORMAT_RAW_DATA_WIDTH_8		(0x00 << 11)
+#define CIF_FORMAT_RAW_DATA_WIDTH_10		BIT(11)
+#define CIF_FORMAT_RAW_DATA_WIDTH_12		(0x02 << 11)
+
+#define CIF_FORMAT_YUV_OUTPUT_422		(0x00 << 16)
+#define CIF_FORMAT_YUV_OUTPUT_420		BIT(16)
+
+#define CIF_FORMAT_OUTPUT_420_ORDER_EVEN	(0x00 << 17)
+#define CIF_FORMAT_OUTPUT_420_ORDER_ODD		BIT(17)
+
+#define CIF_FORMAT_RAWD_DATA_LITTLE_ENDIAN	(0x00 << 18)
+#define CIF_FORMAT_RAWD_DATA_BIG_ENDIAN		BIT(18)
+
+#define CIF_FORMAT_UV_STORAGE_ORDER_UVUV	(0x00 << 19)
+#define CIF_FORMAT_UV_STORAGE_ORDER_VUVU	BIT(19)
+
+#define CIF_FORMAT_BT1120_CLOCK_SINGLE_EDGES	(0x00 << 24)
+#define CIF_FORMAT_BT1120_CLOCK_DOUBLE_EDGES	BIT(24)
+#define CIF_FORMAT_BT1120_TRANSMIT_INTERFACE	(0x00 << 25)
+#define CIF_FORMAT_BT1120_TRANSMIT_PROGRESS	BIT(25)
+#define CIF_FORMAT_BT1120_YC_SWAP		BIT(26)
+
+#define CIF_SCL_CTRL_ENABLE_SCL_DOWN		BIT(0)
+#define CIF_SCL_CTRL_ENABLE_SCL_UP		BIT(1)
+#define CIF_SCL_CTRL_ENABLE_YUV_16BIT_BYPASS	BIT(4)
+#define CIF_SCL_CTRL_ENABLE_RAW_16BIT_BYPASS	BIT(5)
+#define CIF_SCL_CTRL_ENABLE_32BIT_BYPASS	BIT(6)
+#define CIF_SCL_CTRL_DISABLE_32BIT_BYPASS	(0x00 << 6)
+
+#define CIF_INTSTAT_F0_READY			BIT(0)
+#define CIF_INTSTAT_F1_READY			BIT(1)
+
+#define CIF_CROP_Y_SHIFT			16
+#define CIF_CROP_X_SHIFT			0
+
+#define CIF_CSI_ENABLE_CAPTURE			BIT(0)
+#define CIF_CSI_WRDDR_TYPE_RAW8			(0x0 << 1)
+#define CIF_CSI_WRDDR_TYPE_RAW10		BIT(1)
+#define CIF_CSI_WRDDR_TYPE_RAW12		(0x2 << 1)
+#define CIF_CSI_WRDDR_TYPE_RGB888		(0x3 << 1)
+#define CIF_CSI_WRDDR_TYPE_YUV422		(0x4 << 1)
+#define CIF_CSI_ENABLE_COMMAND_MODE		BIT(4)
+#define CIF_CSI_ENABLE_CROP			BIT(5)
+
+#define CIF_CSI_FRAME0_START_INTEN(id)		(0x1 << ((id) * 2))
+#define CIF_CSI_FRAME1_START_INTEN(id)		(0x1 << ((id) * 2 + 1))
+#define CIF_CSI_FRAME0_END_INTEN(id)		(0x1 << ((id) * 2 + 8))
+#define CIF_CSI_FRAME1_END_INTEN(id)		(0x1 << ((id) * 2 + 9))
+#define CIF_CSI_DMA_Y_FIFO_OVERFLOW_INTEN	BIT(16)
+#define CIF_CSI_DMA_UV_FIFO_OVERFLOW_INTEN	BIT(17)
+#define CIF_CSI_CONFIG_FIFO_OVERFLOW_INTEN	BIT(18)
+#define CIF_CSI_BANDWIDTH_LACK_INTEN		BIT(19)
+#define CIF_CSI_RX_FIFO_OVERFLOW_INTEN		BIT(20)
+#define CIF_CSI_ALL_FRAME_START_INTEN		(0xff << 0)
+#define CIF_CSI_ALL_FRAME_END_INTEN		(0xff << 8)
+#define CIF_CSI_ALL_ERROR_INTEN			(0x1f << 16)
+
+#define CIF_CSI_FRAME0_START_ID0		BIT(0)
+#define CIF_CSI_FRAME1_START_ID0		BIT(1)
+#define CIF_CSI_FRAME0_START_ID1		BIT(2)
+#define CIF_CSI_FRAME1_START_ID1		BIT(3)
+#define CIF_CSI_FRAME0_START_ID2		BIT(4)
+#define CIF_CSI_FRAME1_START_ID2		BIT(5)
+#define CIF_CSI_FRAME0_START_ID3		BIT(6)
+#define CIF_CSI_FRAME1_START_ID3		BIT(7)
+#define CIF_CSI_FRAME0_END_ID0			BIT(8)
+#define CIF_CSI_FRAME1_END_ID0			BIT(9)
+#define CIF_CSI_FRAME0_END_ID1			BIT(10)
+#define CIF_CSI_FRAME1_END_ID1			BIT(11)
+#define CIF_CSI_FRAME0_END_ID2			BIT(12)
+#define CIF_CSI_FRAME1_END_ID2			BIT(13)
+#define CIF_CSI_FRAME0_END_ID3			BIT(14)
+#define CIF_CSI_FRAME1_END_ID3			BIT(15)
+#define CIF_CSI_DMA_Y_FIFO_OVERFLOW		BIT(16)
+#define CIF_CSI_DMA_UV_FIFO_OVERFLOW		BIT(17)
+#define CIF_CSI_CONFIG_FIFO_OVERFLOW		BIT(18)
+#define CIF_CSI_BANDWIDTH_LACK			BIT(19)
+#define CIF_CSI_RX_FIFO_OVERFLOW		BIT(20)
+
+#define CIF_CSI_FIFO_OVERFLOW	(CIF_CSI_DMA_Y_FIFO_OVERFLOW |	\
+				 CIF_CSI_DMA_UV_FIFO_OVERFLOW |	\
+				 CIF_CSI_CONFIG_FIFO_OVERFLOW |	\
+				 CIF_CSI_RX_FIFO_OVERFLOW)
+
+#define CIF_CSIHOST_N_LANES			0x04
+#define CIF_CSIHOST_PHY_RSTZ			0x0c
+#define CIF_CSIHOST_RESETN			0x10
+#define CIF_CSIHOST_ERR1			0x20
+#define CIF_CSIHOST_ERR2			0x24
+#define CIF_CSIHOST_MSK1			0x28
+#define CIF_CSIHOST_MSK2			0x2c
+#define CIF_CSIHOST_CONTROL			0x40
+
+#define CIF_SW_CPHY_EN(x)			((x) << 0)
+#define CIF_SW_DSI_EN(x)			((x) << 4)
+#define CIF_SW_DATATYPE_FS(x)			((x) << 8)
+#define CIF_SW_DATATYPE_FE(x)			((x) << 14)
+#define CIF_SW_DATATYPE_LS(x)			((x) << 20)
+#define CIF_SW_DATATYPE_LE(x)			((x) << 26)
+
+#endif
-- 
2.41.0


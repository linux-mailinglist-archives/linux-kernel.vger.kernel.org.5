Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC38D7CA31D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjJPJBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjJPJAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:00:51 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8A5B4;
        Mon, 16 Oct 2023 02:00:42 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F088FF815;
        Mon, 16 Oct 2023 09:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697446841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDrazTJO7ukTfjT1p5esQLk41nw3YqTvhAuOGyw8C10=;
        b=e6FYD95EdD8DwtqnwnsdBqvTGfdzbL4oyKJGC/mqv5LLvZvUp1P153KNqothvCY20sc+yD
        NVwjkuf3hhtLQkjxKS+pGpts/xD542IpAkJiWHHpDd1JRwbFap4W2mVvDHqTLK1yAHFY47
        F6VKDGBzQmAheXA43RaSCv0PC0+MYTKqKIAoZlbRL666NtnEcv2i/7bAdmpFD1Mpt7CgR2
        TfiE+j8Q0D1QR7SPgL8YJPhxSqwwm64eZxCmOJl1pmTPv+2qJDNTY3mlUjCnktiuuiSTsf
        b4zg/E6qzBMm62/JR1J/7p3npWNzMJjAb8eZIn9OXcg6xaFaOAEy38TcgLSZtw==
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, ezequiel@vanguardiasur.com.ar
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com,
        Mehdi Djait <mehdi.djait@bootlin.com>
Subject: [PATCH v8 2/3] media: rockchip: Add a driver for Rockhip's camera interface
Date:   Mon, 16 Oct 2023 11:00:04 +0200
Message-ID: <3790470ff7606fc075ec742d43254e52dde5d120.1697446303.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697446303.git.mehdi.djait@bootlin.com>
References: <cover.1697446303.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a driver for the camera interface on some Rockchip platforms.

This controller supports CSI2 and BT656 interfaces, but for
now only the BT656 interface could be tested, hence it's the only one
that's supported in the first version of this driver.

This controller can be fond on PX30, RK1808, RK3128 and RK3288,
but for now it's only been tested on PX30.

Most of this driver was written following the BSP driver from rockchip,
removing the parts that either didn't fit correctly the guidelines, or
that couldn't be tested.

In the BSP, this driver is known as the "cif" driver, but this was
renamed to "vip" to better fit the controller denomination in the
datasheet.

This basic version doesn't support cropping nor scaling, and is only
designed with one SDTV video decoder being attached to it a any time.

This version uses the "pingpong" mode of the controller, which is a
double-buffering mechanism.

Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
---
 drivers/media/platform/rockchip/Kconfig       |    1 +
 drivers/media/platform/rockchip/Makefile      |    1 +
 drivers/media/platform/rockchip/vip/Kconfig   |   14 +
 drivers/media/platform/rockchip/vip/Makefile  |    3 +
 drivers/media/platform/rockchip/vip/capture.c | 1210 +++++++++++++++++
 drivers/media/platform/rockchip/vip/dev.c     |  346 +++++
 drivers/media/platform/rockchip/vip/dev.h     |  163 +++
 drivers/media/platform/rockchip/vip/regs.h    |  260 ++++
 8 files changed, 1998 insertions(+)
 create mode 100644 drivers/media/platform/rockchip/vip/Kconfig
 create mode 100644 drivers/media/platform/rockchip/vip/Makefile
 create mode 100644 drivers/media/platform/rockchip/vip/capture.c
 create mode 100644 drivers/media/platform/rockchip/vip/dev.c
 create mode 100644 drivers/media/platform/rockchip/vip/dev.h
 create mode 100644 drivers/media/platform/rockchip/vip/regs.h

diff --git a/drivers/media/platform/rockchip/Kconfig b/drivers/media/platform/rockchip/Kconfig
index b41d3960c1b4..f82a56d1431f 100644
--- a/drivers/media/platform/rockchip/Kconfig
+++ b/drivers/media/platform/rockchip/Kconfig
@@ -4,3 +4,4 @@ comment "Rockchip media platform drivers"
 
 source "drivers/media/platform/rockchip/rga/Kconfig"
 source "drivers/media/platform/rockchip/rkisp1/Kconfig"
+source "drivers/media/platform/rockchip/vip/Kconfig"
diff --git a/drivers/media/platform/rockchip/Makefile b/drivers/media/platform/rockchip/Makefile
index 4f782b876ac9..3f1dade70103 100644
--- a/drivers/media/platform/rockchip/Makefile
+++ b/drivers/media/platform/rockchip/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += rga/
 obj-y += rkisp1/
+obj-y += vip/
diff --git a/drivers/media/platform/rockchip/vip/Kconfig b/drivers/media/platform/rockchip/vip/Kconfig
new file mode 100644
index 000000000000..05953e12a2a8
--- /dev/null
+++ b/drivers/media/platform/rockchip/vip/Kconfig
@@ -0,0 +1,14 @@
+config VIDEO_ROCKCHIP_VIP
+	tristate "Rockchip VIP (Video InPut) Camera Interface"
+	depends on VIDEO_DEV
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	select VIDEOBUF2_DMA_SG
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_FWNODE
+	select V4L2_MEM2MEM_DEV
+	help
+	  This is a v4l2 driver for Rockchip SOC Camera interface. It supports
+	  BT.656 and CSI2 inputs.
+
+	  To compile this driver as a module choose m here : the module will
+	  be called video_rkvip.
diff --git a/drivers/media/platform/rockchip/vip/Makefile b/drivers/media/platform/rockchip/vip/Makefile
new file mode 100644
index 000000000000..c239ee0bb0fe
--- /dev/null
+++ b/drivers/media/platform/rockchip/vip/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_VIDEO_ROCKCHIP_VIP) += video_rkvip.o
+video_rkvip-objs += dev.o capture.o
diff --git a/drivers/media/platform/rockchip/vip/capture.c b/drivers/media/platform/rockchip/vip/capture.c
new file mode 100644
index 000000000000..e8f3480aacdb
--- /dev/null
+++ b/drivers/media/platform/rockchip/vip/capture.c
@@ -0,0 +1,1210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Rockchip VIP Camera Interface Driver
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
+#include <media/v4l2-event.h>
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
+#define VIP_REQ_BUFS_MIN	3
+#define VIP_MIN_WIDTH		64
+#define VIP_MIN_HEIGHT		64
+#define VIP_MAX_WIDTH		8192
+#define VIP_MAX_HEIGHT		8192
+
+#define RK_VIP_PLANE_Y			0
+#define RK_VIP_PLANE_CBCR		1
+
+#define VIP_FETCH_Y_LAST_LINE(VAL) ((VAL) & 0x1fff)
+
+static struct vip_output_fmt out_fmts[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_NV16,
+		.fmt_val = VIP_FORMAT_YUV_OUTPUT_422 |
+			   VIP_FORMAT_UV_STORAGE_ORDER_UVUV,
+		.cplanes = 2,
+	}, {
+		.fourcc = V4L2_PIX_FMT_NV61,
+		.fmt_val = VIP_FORMAT_YUV_OUTPUT_422 |
+			   VIP_FORMAT_UV_STORAGE_ORDER_VUVU,
+		.cplanes = 2,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_NV12,
+		.fmt_val = VIP_FORMAT_YUV_OUTPUT_420 |
+			   VIP_FORMAT_UV_STORAGE_ORDER_UVUV,
+		.cplanes = 2,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_NV21,
+		.fmt_val = VIP_FORMAT_YUV_OUTPUT_420 |
+			   VIP_FORMAT_UV_STORAGE_ORDER_VUVU,
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
+static const struct vip_input_fmt in_fmts[] = {
+	{
+		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
+		.dvp_fmt_val	= VIP_FORMAT_YUV_INPUT_422 |
+				  VIP_FORMAT_YUV_INPUT_ORDER_YUYV,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_YUV422,
+		.fmt_type	= VIP_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
+		.dvp_fmt_val	= VIP_FORMAT_YUV_INPUT_422 |
+				  VIP_FORMAT_YUV_INPUT_ORDER_YUYV,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_YUV422,
+		.fmt_type	= VIP_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8,
+		.dvp_fmt_val	= VIP_FORMAT_YUV_INPUT_422 |
+				  VIP_FORMAT_YUV_INPUT_ORDER_YVYU,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_YUV422,
+		.fmt_type	= VIP_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8,
+		.dvp_fmt_val	= VIP_FORMAT_YUV_INPUT_422 |
+				  VIP_FORMAT_YUV_INPUT_ORDER_YVYU,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_YUV422,
+		.fmt_type	= VIP_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
+		.dvp_fmt_val	= VIP_FORMAT_YUV_INPUT_422 |
+				  VIP_FORMAT_YUV_INPUT_ORDER_UYVY,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_YUV422,
+		.fmt_type	= VIP_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
+		.dvp_fmt_val	= VIP_FORMAT_YUV_INPUT_422 |
+				  VIP_FORMAT_YUV_INPUT_ORDER_UYVY,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_YUV422,
+		.fmt_type	= VIP_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_VYUY8_2X8,
+		.dvp_fmt_val	= VIP_FORMAT_YUV_INPUT_422 |
+				  VIP_FORMAT_YUV_INPUT_ORDER_VYUY,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_YUV422,
+		.fmt_type	= VIP_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_VYUY8_2X8,
+		.dvp_fmt_val	= VIP_FORMAT_YUV_INPUT_422 |
+				  VIP_FORMAT_YUV_INPUT_ORDER_VYUY,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_YUV422,
+		.fmt_type	= VIP_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR8_1X8,
+		.dvp_fmt_val	= VIP_FORMAT_INPUT_MODE_RAW |
+				  VIP_FORMAT_RAW_DATA_WIDTH_8,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_RAW8,
+		.fmt_type	= VIP_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG8_1X8,
+		.dvp_fmt_val	= VIP_FORMAT_INPUT_MODE_RAW |
+				  VIP_FORMAT_RAW_DATA_WIDTH_8,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_RAW8,
+		.fmt_type	= VIP_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG8_1X8,
+		.dvp_fmt_val	= VIP_FORMAT_INPUT_MODE_RAW |
+				  VIP_FORMAT_RAW_DATA_WIDTH_8,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_RAW8,
+		.fmt_type	= VIP_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB8_1X8,
+		.dvp_fmt_val	= VIP_FORMAT_INPUT_MODE_RAW |
+				  VIP_FORMAT_RAW_DATA_WIDTH_8,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_RAW8,
+		.fmt_type	= VIP_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
+		.dvp_fmt_val	= VIP_FORMAT_INPUT_MODE_RAW |
+				  VIP_FORMAT_RAW_DATA_WIDTH_10,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_RAW10,
+		.fmt_type	= VIP_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG10_1X10,
+		.dvp_fmt_val	= VIP_FORMAT_INPUT_MODE_RAW |
+				  VIP_FORMAT_RAW_DATA_WIDTH_10,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_RAW10,
+		.fmt_type	= VIP_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG10_1X10,
+		.dvp_fmt_val	= VIP_FORMAT_INPUT_MODE_RAW |
+				  VIP_FORMAT_RAW_DATA_WIDTH_10,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_RAW10,
+		.fmt_type	= VIP_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB10_1X10,
+		.dvp_fmt_val	= VIP_FORMAT_INPUT_MODE_RAW |
+				  VIP_FORMAT_RAW_DATA_WIDTH_10,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_RAW10,
+		.fmt_type	= VIP_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR12_1X12,
+		.dvp_fmt_val	= VIP_FORMAT_INPUT_MODE_RAW |
+				  VIP_FORMAT_RAW_DATA_WIDTH_12,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_RAW12,
+		.fmt_type	= VIP_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG12_1X12,
+		.dvp_fmt_val	= VIP_FORMAT_INPUT_MODE_RAW |
+				  VIP_FORMAT_RAW_DATA_WIDTH_12,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_RAW12,
+		.fmt_type	= VIP_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG12_1X12,
+		.dvp_fmt_val	= VIP_FORMAT_INPUT_MODE_RAW |
+				  VIP_FORMAT_RAW_DATA_WIDTH_12,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_RAW12,
+		.fmt_type	= VIP_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB12_1X12,
+		.dvp_fmt_val	= VIP_FORMAT_INPUT_MODE_RAW |
+				  VIP_FORMAT_RAW_DATA_WIDTH_12,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_RAW12,
+		.fmt_type	= VIP_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_RGB888_1X24,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_RGB888,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_Y8_1X8,
+		.dvp_fmt_val	= VIP_FORMAT_INPUT_MODE_RAW |
+				  VIP_FORMAT_RAW_DATA_WIDTH_8,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_RAW8,
+		.fmt_type	= VIP_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_Y10_1X10,
+		.dvp_fmt_val	= VIP_FORMAT_INPUT_MODE_RAW |
+				  VIP_FORMAT_RAW_DATA_WIDTH_10,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_RAW10,
+		.fmt_type	= VIP_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_Y12_1X12,
+		.dvp_fmt_val	= VIP_FORMAT_INPUT_MODE_RAW |
+				  VIP_FORMAT_RAW_DATA_WIDTH_12,
+		.csi_fmt_val	= VIP_CSI_WRDDR_TYPE_RAW12,
+		.fmt_type	= VIP_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}
+};
+
+static const struct
+vip_input_fmt *get_input_fmt(struct v4l2_subdev *sd)
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
+	v4l2_err(sd->v4l2_dev, "remote sensor mbus code not supported\n");
+	return NULL;
+}
+
+static struct
+vip_output_fmt *find_output_fmt(struct rk_vip_stream *stream, u32 pixelfmt)
+{
+	struct vip_output_fmt *fmt;
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
+static struct rk_vip_buffer *rk_vip_get_buffer(struct rk_vip_stream *stream)
+{
+	struct rk_vip_buffer *buff;
+
+	lockdep_assert_held(&stream->vbq_lock);
+
+	if (list_empty(&stream->buf_head))
+		return NULL;
+
+	buff = list_first_entry(&stream->buf_head, struct rk_vip_buffer, queue);
+	list_del(&buff->queue);
+
+	return buff;
+}
+
+static int rk_vip_init_buffers(struct rk_vip_stream *stream)
+{
+	struct rk_vip_device *vip_dev = stream->vipdev;
+	void __iomem *base = vip_dev->base_addr;
+
+	spin_lock(&stream->vbq_lock);
+
+	stream->buffs[0] = rk_vip_get_buffer(stream);
+	stream->buffs[1] = rk_vip_get_buffer(stream);
+
+	if (!(stream->buffs[0]) || !(stream->buffs[1])) {
+		spin_unlock(&stream->vbq_lock);
+		return -EINVAL;
+	}
+
+	spin_unlock(&stream->vbq_lock);
+
+	write_vip_reg(base, VIP_FRM0_ADDR_Y,
+		      stream->buffs[0]->buff_addr[RK_VIP_PLANE_Y]);
+	write_vip_reg(base, VIP_FRM0_ADDR_UV,
+		      stream->buffs[0]->buff_addr[RK_VIP_PLANE_CBCR]);
+
+	write_vip_reg(base, VIP_FRM1_ADDR_Y,
+		      stream->buffs[1]->buff_addr[RK_VIP_PLANE_Y]);
+	write_vip_reg(base, VIP_FRM1_ADDR_UV,
+		      stream->buffs[1]->buff_addr[RK_VIP_PLANE_CBCR]);
+
+	return 0;
+}
+
+static void rk_vip_assign_new_buffer_pingpong(struct rk_vip_stream *stream)
+{
+	struct rk_vip_scratch_buffer *scratch_buf = &stream->scratch_buf;
+	struct rk_vip_device *vip_dev = stream->vipdev;
+	struct rk_vip_buffer *buffer = NULL;
+	void __iomem *base = vip_dev->base_addr;
+	u32 frm_addr_y, frm_addr_uv;
+
+	/* Set up an empty buffer for the next frame */
+	spin_lock(&stream->vbq_lock);
+
+	buffer = rk_vip_get_buffer(stream);
+
+	stream->buffs[stream->frame_phase] = buffer;
+
+	spin_unlock(&stream->vbq_lock);
+
+	frm_addr_y = stream->frame_phase ? VIP_FRM1_ADDR_Y : VIP_FRM0_ADDR_Y;
+	frm_addr_uv = stream->frame_phase ? VIP_FRM1_ADDR_UV : VIP_FRM0_ADDR_UV;
+
+	if (buffer) {
+		write_vip_reg(base, frm_addr_y,
+			      buffer->buff_addr[RK_VIP_PLANE_Y]);
+		write_vip_reg(base, frm_addr_uv,
+			      buffer->buff_addr[RK_VIP_PLANE_CBCR]);
+	} else {
+		write_vip_reg(base, frm_addr_y, scratch_buf->dma_addr);
+		write_vip_reg(base, frm_addr_uv, scratch_buf->dma_addr);
+	}
+}
+
+static void rk_vip_stream_stop(struct rk_vip_stream *stream)
+{
+	struct rk_vip_device *vip_dev = stream->vipdev;
+	void __iomem *base = vip_dev->base_addr;
+	u32 val;
+
+	val = read_vip_reg(base, VIP_CTRL);
+	write_vip_reg(base, VIP_CTRL, val & (~VIP_CTRL_ENABLE_CAPTURE));
+	write_vip_reg(base, VIP_INTEN, 0x0);
+	write_vip_reg(base, VIP_INTSTAT, 0x3ff);
+	write_vip_reg(base, VIP_FRAME_STATUS, 0x0);
+
+	stream->state = RK_VIP_STATE_READY;
+}
+
+static int rk_vip_queue_setup(struct vb2_queue *queue,
+			      unsigned int *num_buffers,
+			      unsigned int *num_planes,
+			      unsigned int sizes[],
+			      struct device *alloc_devs[])
+{
+	struct rk_vip_stream *stream = queue->drv_priv;
+	const struct v4l2_plane_pix_format *plane_fmt;
+	const struct v4l2_pix_format_mplane *pixm;
+
+	pixm = &stream->pixm;
+
+	if (*num_planes) {
+		if (*num_planes != 1)
+			return -EINVAL;
+
+		if (sizes[0] < pixm->plane_fmt[0].sizeimage)
+			return -EINVAL;
+		return 0;
+	}
+
+	*num_planes = 1;
+
+	plane_fmt = &pixm->plane_fmt[0];
+	sizes[0] = plane_fmt->sizeimage;
+
+	*num_buffers = VIP_REQ_BUFS_MIN;
+
+	return 0;
+}
+
+static void rk_vip_buf_queue(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct rk_vip_buffer *vipbuf = to_rk_vip_buffer(vbuf);
+	struct vb2_queue *queue = vb->vb2_queue;
+	struct rk_vip_stream *stream = queue->drv_priv;
+	struct v4l2_pix_format_mplane *pixm = &stream->pixm;
+	unsigned long lock_flags = 0;
+	int i;
+
+	struct vip_output_fmt *fmt = stream->vip_fmt_out;
+
+	memset(vipbuf->buff_addr, 0, sizeof(vipbuf->buff_addr));
+
+	vipbuf->buff_addr[0] = vb2_dma_contig_plane_dma_addr(vb, 0);
+
+	for (i = 0; i < fmt->cplanes - 1; i++)
+		vipbuf->buff_addr[i + 1] = vipbuf->buff_addr[i] +
+			pixm->plane_fmt[i].bytesperline * pixm->height;
+
+	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
+	list_add_tail(&vipbuf->queue, &stream->buf_head);
+	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
+}
+
+static int rk_vip_create_scratch_buf(struct rk_vip_stream *stream)
+{
+	struct rk_vip_scratch_buffer *scratch_buf = &stream->scratch_buf;
+	struct rk_vip_device *vip_dev = stream->vipdev;
+
+	/* get a maximum plane size */
+	scratch_buf->size = max(stream->pixm.plane_fmt[0].sizeimage,
+				stream->pixm.plane_fmt[1].sizeimage);
+
+	scratch_buf->vaddr = dma_alloc_coherent(vip_dev->dev, scratch_buf->size,
+						&scratch_buf->dma_addr,
+						GFP_KERNEL);
+	if (!scratch_buf->vaddr)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void rk_vip_destroy_scratch_buf(struct rk_vip_stream *stream)
+{
+	struct rk_vip_scratch_buffer *scratch_buf = &stream->scratch_buf;
+	struct rk_vip_device *vip_dev = stream->vipdev;
+
+	dma_free_coherent(vip_dev->dev, scratch_buf->size,
+			  scratch_buf->vaddr, scratch_buf->dma_addr);
+}
+
+static void rk_vip_stop_streaming(struct vb2_queue *queue)
+{
+	struct rk_vip_stream *stream = queue->drv_priv;
+	struct rk_vip_device *vip_dev = stream->vipdev;
+	struct rk_vip_buffer *buf;
+	struct v4l2_subdev *sd;
+	int ret;
+
+	stream->stopping = true;
+	ret = wait_event_timeout(stream->wq_stopped,
+				 stream->state != RK_VIP_STATE_STREAMING,
+				 msecs_to_jiffies(1000));
+	if (!ret) {
+		rk_vip_stream_stop(stream);
+		stream->stopping = false;
+	}
+	pm_runtime_put(vip_dev->dev);
+
+	/* stop the sub device*/
+	sd = vip_dev->sensor.sd;
+	v4l2_subdev_call(sd, video, s_stream, 0);
+
+	/* release buffers */
+	if (stream->buffs[0]) {
+		list_add_tail(&stream->buffs[0]->queue, &stream->buf_head);
+		stream->buffs[0] = NULL;
+	}
+
+	if (stream->buffs[1]) {
+		list_add_tail(&stream->buffs[1]->queue, &stream->buf_head);
+		stream->buffs[1] = NULL;
+	}
+
+	while (!list_empty(&stream->buf_head)) {
+		buf = rk_vip_get_buffer(stream);
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+	}
+
+	rk_vip_destroy_scratch_buf(stream);
+}
+
+static u32 rk_vip_determine_input_mode(struct rk_vip_device *vip_dev)
+{
+	v4l2_std_id std = vip_dev->sensor.std;
+
+	return (std == V4L2_STD_NTSC) ?
+		VIP_FORMAT_INPUT_MODE_NTSC :
+		VIP_FORMAT_INPUT_MODE_PAL;
+}
+
+static inline u32 rk_vip_scl_ctl(struct rk_vip_stream *stream)
+{
+	u32 fmt_type = stream->vip_fmt_in->fmt_type;
+
+	return (fmt_type == VIP_FMT_TYPE_YUV) ?
+		VIP_SCL_CTRL_ENABLE_YUV_16BIT_BYPASS :
+		VIP_SCL_CTRL_ENABLE_RAW_16BIT_BYPASS;
+}
+
+static int rk_vip_stream_start(struct rk_vip_stream *stream)
+{
+	u32 val, mbus_flags, href_pol, vsync_pol,
+	    xfer_mode = 0, yc_swap = 0, skip_top = 0;
+	struct rk_vip_device *vip_dev = stream->vipdev;
+	struct rk_vip_sensor_info *sensor_info;
+	void __iomem *base = vip_dev->base_addr;
+	int ret;
+	u32 input_mode;
+
+	sensor_info = &vip_dev->sensor;
+	stream->frame_idx = 0;
+	input_mode = rk_vip_determine_input_mode(vip_dev);
+
+	mbus_flags = sensor_info->mbus.bus.parallel.flags;
+	href_pol = (mbus_flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH) ?
+			0 : VIP_FORMAT_HSY_LOW_ACTIVE;
+	vsync_pol = (mbus_flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH) ?
+			VIP_FORMAT_VSY_HIGH_ACTIVE : 0;
+
+	val = vsync_pol | href_pol | input_mode | stream->vip_fmt_out->fmt_val |
+	      stream->vip_fmt_in->dvp_fmt_val | xfer_mode | yc_swap;
+	write_vip_reg(base, VIP_FOR, val);
+
+	val = stream->pixm.width;
+	if (stream->vip_fmt_in->fmt_type == VIP_FMT_TYPE_RAW)
+		val = stream->pixm.width * 2;
+
+	write_vip_reg(base, VIP_VIR_LINE_WIDTH, val);
+	write_vip_reg(base, VIP_SET_SIZE,
+		      stream->pixm.width | (stream->pixm.height << 16));
+
+	v4l2_subdev_call(sensor_info->sd, sensor, g_skip_top_lines, &skip_top);
+
+	write_vip_reg(base, VIP_CROP, skip_top << VIP_CROP_Y_SHIFT);
+	write_vip_reg(base, VIP_FRAME_STATUS, VIP_FRAME_STAT_CLS);
+	write_vip_reg(base, VIP_INTSTAT, VIP_INTSTAT_CLS);
+	write_vip_reg(base, VIP_SCL_CTRL, rk_vip_scl_ctl(stream));
+
+	ret = rk_vip_init_buffers(stream);
+	if (ret)
+		return ret;
+
+	write_vip_reg(base, VIP_INTEN, VIP_INTEN_FRAME_END_EN |
+				       VIP_INTEN_LINE_ERR_EN |
+				       VIP_INTEN_PST_INF_FRAME_END_EN);
+
+	write_vip_reg(base, VIP_CTRL, VIP_CTRL_AXI_BURST_16 |
+				      VIP_CTRL_MODE_PINGPONG |
+				      VIP_CTRL_ENABLE_CAPTURE);
+
+	stream->state = RK_VIP_STATE_STREAMING;
+
+	return 0;
+}
+
+static int rk_vip_start_streaming(struct vb2_queue *queue, unsigned int count)
+{
+	struct rk_vip_stream *stream = queue->drv_priv;
+	struct rk_vip_device *vip_dev = stream->vipdev;
+	struct v4l2_device *v4l2_dev = &vip_dev->v4l2_dev;
+	struct v4l2_subdev *sd;
+	int ret;
+
+	if (stream->state != RK_VIP_STATE_READY) {
+		ret = -EBUSY;
+		v4l2_err(v4l2_dev, "Stream in busy state\n");
+		goto destroy_buf;
+	}
+
+	if (!vip_dev->sensor.sd) {
+		ret = -EINVAL;
+		v4l2_err(v4l2_dev, "No sensor subdev detected\n");
+		goto destroy_buf;
+	}
+
+	ret = rk_vip_create_scratch_buf(stream);
+	if (ret < 0) {
+		v4l2_err(v4l2_dev, "Failed to create scratch_buf, %d\n", ret);
+		goto destroy_buf;
+	}
+
+	ret = pm_runtime_get_sync(vip_dev->dev);
+	if (ret < 0) {
+		v4l2_err(v4l2_dev, "Failed to get runtime pm, %d\n", ret);
+		goto destroy_scratch_buf;
+	}
+
+	/* start sub-devices */
+	sd = vip_dev->sensor.sd;
+	stream->vip_fmt_in = get_input_fmt(vip_dev->sensor.sd);
+
+	ret = v4l2_subdev_call(sd, video, s_stream, 1);
+	if (ret < 0)
+		goto runtime_put;
+
+	ret = rk_vip_stream_start(stream);
+	if (ret < 0)
+		goto stop_stream;
+
+	return 0;
+
+stop_stream:
+	rk_vip_stream_stop(stream);
+runtime_put:
+	pm_runtime_put(vip_dev->dev);
+destroy_scratch_buf:
+	rk_vip_destroy_scratch_buf(stream);
+destroy_buf:
+	while (!list_empty(&stream->buf_head)) {
+		struct rk_vip_buffer *buf;
+
+		buf = rk_vip_get_buffer(stream);
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
+	}
+
+	return ret;
+}
+
+static const struct vb2_ops rk_vip_vb2_ops = {
+	.queue_setup = rk_vip_queue_setup,
+	.buf_queue = rk_vip_buf_queue,
+	.wait_prepare = vb2_ops_wait_prepare,
+	.wait_finish = vb2_ops_wait_finish,
+	.stop_streaming = rk_vip_stop_streaming,
+	.start_streaming = rk_vip_start_streaming,
+};
+
+static int rk_vip_init_vb2_queue(struct vb2_queue *q,
+				 struct rk_vip_stream *stream)
+{
+	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	q->io_modes = VB2_MMAP | VB2_DMABUF;
+	q->drv_priv = stream;
+	q->ops = &rk_vip_vb2_ops;
+	q->mem_ops = &vb2_dma_contig_memops;
+	q->buf_struct_size = sizeof(struct rk_vip_buffer);
+	q->min_buffers_needed = VIP_REQ_BUFS_MIN;
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->lock = &stream->vlock;
+	q->dev = stream->vipdev->dev;
+
+	return vb2_queue_init(q);
+}
+
+static void rk_vip_update_pixm(struct rk_vip_stream *stream,
+			       struct vip_output_fmt *fmt,
+			       struct v4l2_pix_format_mplane *pixm)
+{
+	struct rk_vip_sensor_info *sensor_info = &stream->vipdev->sensor;
+	struct v4l2_subdev_format sd_fmt;
+	struct v4l2_rect input_rect;
+	u32 width, height;
+
+	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
+	sd_fmt.pad = 0;
+	v4l2_subdev_call(sensor_info->sd, pad, get_fmt, NULL, &sd_fmt);
+
+	input_rect.width = VIP_MAX_WIDTH;
+	input_rect.height = VIP_MAX_HEIGHT;
+	width = clamp_t(u32, sd_fmt.format.width,
+			VIP_MIN_WIDTH, input_rect.width);
+	height = clamp_t(u32, sd_fmt.format.height,
+			 VIP_MIN_HEIGHT, input_rect.height);
+
+	pixm->width = width;
+	pixm->height = height;
+	pixm->field = sd_fmt.format.field;
+	pixm->colorspace = sd_fmt.format.colorspace;
+	pixm->ycbcr_enc = sd_fmt.format.ycbcr_enc;
+	pixm->quantization = sd_fmt.format.quantization;
+	pixm->xfer_func = sd_fmt.format.xfer_func;
+
+	v4l2_fill_pixfmt_mp(pixm, fmt->fourcc, pixm->width, pixm->height);
+}
+
+static int rk_vip_set_fmt(struct rk_vip_stream *stream,
+			  struct v4l2_pix_format_mplane *pixm)
+{
+	struct rk_vip_device *vip_dev = stream->vipdev;
+	struct v4l2_subdev_format sd_fmt;
+	struct vip_output_fmt *fmt;
+	int ret;
+
+	if (stream->state == RK_VIP_STATE_STREAMING)
+		return -EBUSY;
+
+	fmt = find_output_fmt(stream, pixm->pixelformat);
+	if (!fmt)
+		fmt = &out_fmts[0];
+
+	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
+	sd_fmt.pad = 0;
+	sd_fmt.format.width = pixm->width;
+	sd_fmt.format.height = pixm->height;
+	ret = v4l2_subdev_call(vip_dev->sensor.sd, pad, set_fmt, NULL, &sd_fmt);
+	rk_vip_update_pixm(stream, fmt, pixm);
+	stream->pixm = *pixm;
+	stream->vip_fmt_out = fmt;
+
+	return ret;
+}
+
+void rk_vip_set_default_format(struct rk_vip_device *vip_dev)
+{
+	struct rk_vip_stream *stream = &vip_dev->stream;
+	struct v4l2_pix_format_mplane pixm;
+
+	pixm.pixelformat = V4L2_PIX_FMT_NV12;
+	pixm.width = RK_VIP_DEFAULT_WIDTH;
+	pixm.height = RK_VIP_DEFAULT_HEIGHT;
+	rk_vip_set_fmt(stream, &pixm);
+}
+
+void rk_vip_stream_init(struct rk_vip_device *vip_dev)
+{
+	struct rk_vip_stream *stream = &vip_dev->stream;
+	struct v4l2_pix_format_mplane pixm;
+
+	memset(stream, 0, sizeof(*stream));
+	memset(&pixm, 0, sizeof(pixm));
+	stream->vipdev = vip_dev;
+
+	INIT_LIST_HEAD(&stream->buf_head);
+	spin_lock_init(&stream->vbq_lock);
+	stream->state = RK_VIP_STATE_READY;
+	init_waitqueue_head(&stream->wq_stopped);
+}
+
+static const struct v4l2_file_operations rk_vip_fops = {
+	.open = v4l2_fh_open,
+	.release = vb2_fop_release,
+	.unlocked_ioctl = video_ioctl2,
+	.poll = vb2_fop_poll,
+	.mmap = vb2_fop_mmap,
+};
+
+static int rk_vip_enum_input(struct file *file, void *priv,
+			     struct v4l2_input *input)
+{
+	struct rk_vip_stream *stream = video_drvdata(file);
+	struct v4l2_subdev *sd = stream->vipdev->sensor.sd;
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
+static int rk_vip_try_fmt_vid_cap_mplane(struct file *file, void *fh,
+					 struct v4l2_format *f)
+{
+	struct rk_vip_stream *stream = video_drvdata(file);
+	struct vip_output_fmt *fmt;
+
+	fmt = find_output_fmt(stream, f->fmt.pix_mp.pixelformat);
+	if (!fmt)
+		fmt = &out_fmts[0];
+
+	rk_vip_update_pixm(stream, fmt, &f->fmt.pix_mp);
+
+	return 0;
+}
+
+static int rk_vip_g_std(struct file *file, void *fh, v4l2_std_id *norm)
+{
+	struct rk_vip_stream *stream = video_drvdata(file);
+	struct rk_vip_sensor_info *sensor_info = &stream->vipdev->sensor;
+
+	*norm = sensor_info->std;
+
+	return 0;
+}
+
+static int rk_vip_s_std(struct file *file, void *fh, v4l2_std_id norm)
+{
+	struct rk_vip_stream *stream = video_drvdata(file);
+	struct rk_vip_sensor_info *sensor_info = &stream->vipdev->sensor;
+	int ret;
+
+	if (norm == sensor_info->std)
+		return 0;
+
+	if (stream->state == RK_VIP_STATE_STREAMING)
+		return -EBUSY;
+
+	ret = v4l2_subdev_call(sensor_info->sd, video, s_std, norm);
+	if (ret)
+		return ret;
+
+	sensor_info->std = norm;
+
+	/* S_STD will update the format since that depends on the standard */
+	rk_vip_update_pixm(stream, stream->vip_fmt_out, &stream->pixm);
+
+	return 0;
+}
+
+static int rk_vip_querystd(struct file *file, void *fh, v4l2_std_id *a)
+{
+	struct rk_vip_stream *stream = video_drvdata(file);
+	struct rk_vip_sensor_info *sensor_info = &stream->vipdev->sensor;
+
+	*a = V4L2_STD_UNKNOWN;
+
+	return v4l2_subdev_call(sensor_info->sd, video, querystd, a);
+}
+
+static int rk_vip_enum_fmt_vid_cap(struct file *file, void *priv,
+				   struct v4l2_fmtdesc *f)
+{
+	struct vip_output_fmt *fmt = NULL;
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
+static int rk_vip_s_fmt_vid_cap_mplane(struct file *file,
+				       void *priv, struct v4l2_format *f)
+{
+	struct rk_vip_stream *stream = video_drvdata(file);
+	int ret;
+
+	if (stream->state == RK_VIP_STATE_STREAMING)
+		return -EBUSY;
+
+	ret = rk_vip_set_fmt(stream, &f->fmt.pix_mp);
+
+	return ret;
+}
+
+static int rk_vip_g_fmt_vid_cap_mplane(struct file *file, void *fh,
+				       struct v4l2_format *f)
+{
+	struct rk_vip_stream *stream = video_drvdata(file);
+
+	f->fmt.pix_mp = stream->pixm;
+
+	return 0;
+}
+
+static int rk_vip_querycap(struct file *file, void *priv,
+			   struct v4l2_capability *cap)
+{
+	struct rk_vip_stream *stream = video_drvdata(file);
+	struct device *dev = stream->vipdev->dev;
+
+	strscpy(cap->driver, dev->driver->name, sizeof(cap->driver));
+	strscpy(cap->card, dev->driver->name, sizeof(cap->card));
+	snprintf(cap->bus_info, sizeof(cap->bus_info),
+		 "platform:%s", dev_name(dev));
+
+	return 0;
+}
+
+static int rk_vip_enum_framesizes(struct file *file, void *fh,
+				  struct v4l2_frmsizeenum *fsize)
+{
+	struct rk_vip_stream *stream = video_drvdata(file);
+	struct rk_vip_device *vip_dev = stream->vipdev;
+	struct v4l2_subdev_frame_size_enum fse = {
+		.index = fsize->index,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	struct vip_output_fmt *fmt;
+	int ret;
+
+	if (!vip_dev->sensor.sd)
+		return -EINVAL;
+
+	fmt = find_output_fmt(stream, fsize->pixel_format);
+	if (!fmt)
+		return -EINVAL;
+
+	fse.code = fmt->mbus;
+
+	ret = v4l2_subdev_call(vip_dev->sensor.sd, pad, enum_frame_size,
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
+static int rk_vip_enum_frameintervals(struct file *file, void *fh,
+				      struct v4l2_frmivalenum *fival)
+{
+	struct rk_vip_stream *stream = video_drvdata(file);
+	struct rk_vip_device *vip_dev = stream->vipdev;
+	struct v4l2_subdev_frame_interval_enum fie = {
+		.index = fival->index,
+		.width = fival->width,
+		.height = fival->height,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	struct vip_output_fmt *fmt;
+	int ret;
+
+	if (!vip_dev->sensor.sd)
+		return -EINVAL;
+
+	fmt = find_output_fmt(stream, fival->pixel_format);
+	if (!fmt)
+		return -EINVAL;
+
+	fie.code = fmt->mbus;
+
+	ret = v4l2_subdev_call(vip_dev->sensor.sd, pad, enum_frame_interval,
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
+static int rk_vip_g_input(struct file *file, void *fh, unsigned int *i)
+{
+	*i = 0;
+	return 0;
+}
+
+static int rk_vip_s_input(struct file *file, void *fh, unsigned int i)
+{
+	if (i)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int rk_vip_g_parm(struct file *file, void *priv,
+			 struct v4l2_streamparm *p)
+{
+	struct rk_vip_stream *stream = video_drvdata(file);
+	struct rk_vip_device *vip_dev = stream->vipdev;
+
+	if (!vip_dev->sensor.sd)
+		return -EINVAL;
+
+	return v4l2_g_parm_cap(video_devdata(file), vip_dev->sensor.sd, p);
+}
+
+static int rk_vip_s_parm(struct file *file, void *priv,
+			 struct v4l2_streamparm *p)
+{
+	struct rk_vip_stream *stream = video_drvdata(file);
+	struct rk_vip_device *vip_dev = stream->vipdev;
+
+	if (!vip_dev->sensor.sd)
+		return -EINVAL;
+
+	return v4l2_s_parm_cap(video_devdata(file), vip_dev->sensor.sd, p);
+}
+
+static const struct v4l2_ioctl_ops rk_vip_v4l2_ioctl_ops = {
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
+	.vidioc_g_std = rk_vip_g_std,
+	.vidioc_s_std = rk_vip_s_std,
+	.vidioc_querystd = rk_vip_querystd,
+
+	.vidioc_enum_fmt_vid_cap = rk_vip_enum_fmt_vid_cap,
+	.vidioc_try_fmt_vid_cap_mplane = rk_vip_try_fmt_vid_cap_mplane,
+	.vidioc_s_fmt_vid_cap_mplane = rk_vip_s_fmt_vid_cap_mplane,
+	.vidioc_g_fmt_vid_cap_mplane = rk_vip_g_fmt_vid_cap_mplane,
+	.vidioc_querycap = rk_vip_querycap,
+	.vidioc_enum_framesizes = rk_vip_enum_framesizes,
+	.vidioc_enum_frameintervals = rk_vip_enum_frameintervals,
+
+	.vidioc_enum_input = rk_vip_enum_input,
+	.vidioc_g_input = rk_vip_g_input,
+	.vidioc_s_input = rk_vip_s_input,
+
+	.vidioc_g_parm = rk_vip_g_parm,
+	.vidioc_s_parm = rk_vip_s_parm,
+};
+
+void rk_vip_unregister_stream_vdev(struct rk_vip_device *vip_dev)
+{
+	struct rk_vip_stream *stream = &vip_dev->stream;
+
+	media_entity_cleanup(&stream->vdev.entity);
+	video_unregister_device(&stream->vdev);
+}
+
+int rk_vip_register_stream_vdev(struct rk_vip_device *vip_dev)
+{
+	struct rk_vip_stream *stream = &vip_dev->stream;
+	struct v4l2_device *v4l2_dev = &vip_dev->v4l2_dev;
+	struct video_device *vdev = &stream->vdev;
+	int ret;
+
+	strscpy(vdev->name, VIP_VIDEODEVICE_NAME, sizeof(vdev->name));
+	mutex_init(&stream->vlock);
+
+	vdev->ioctl_ops = &rk_vip_v4l2_ioctl_ops;
+	vdev->release = video_device_release_empty;
+	vdev->fops = &rk_vip_fops;
+	vdev->minor = -1;
+	vdev->v4l2_dev = v4l2_dev;
+	vdev->lock = &stream->vlock;
+	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE |
+			    V4L2_CAP_STREAMING;
+	vdev->tvnorms = V4L2_STD_NTSC | V4L2_STD_PAL;
+	video_set_drvdata(vdev, stream);
+	vdev->vfl_dir = VFL_DIR_RX;
+	stream->pad.flags = MEDIA_PAD_FL_SINK;
+
+	rk_vip_init_vb2_queue(&stream->buf_queue, stream);
+
+	vdev->queue = &stream->buf_queue;
+	strscpy(vdev->name, KBUILD_MODNAME, sizeof(vdev->name));
+
+	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
+	if (ret < 0) {
+		v4l2_err(v4l2_dev,
+			 "video_register_device failed with error %d\n", ret);
+		return ret;
+	}
+
+	ret = media_entity_pads_init(&vdev->entity, 1, &stream->pad);
+	if (ret < 0)
+		goto unreg;
+
+	return 0;
+unreg:
+	video_unregister_device(vdev);
+	return ret;
+}
+
+static void rk_vip_vb_done(struct rk_vip_stream *stream,
+			   struct vb2_v4l2_buffer *vb_done)
+{
+	vb2_set_plane_payload(&vb_done->vb2_buf, 0,
+			      stream->pixm.plane_fmt[0].sizeimage);
+	vb_done->vb2_buf.timestamp = ktime_get_ns();
+	vb_done->sequence = stream->frame_idx;
+	vb2_buffer_done(&vb_done->vb2_buf, VB2_BUF_STATE_DONE);
+}
+
+static void rk_vip_reset_stream(struct rk_vip_device *vip_dev)
+{
+	void __iomem *base = vip_dev->base_addr;
+	u32 ctl = read_vip_reg(base, VIP_CTRL);
+
+	write_vip_reg(base, VIP_CTRL, ctl & (~VIP_CTRL_ENABLE_CAPTURE));
+	write_vip_reg(base, VIP_CTRL, ctl | VIP_CTRL_ENABLE_CAPTURE);
+}
+
+irqreturn_t rk_vip_irq_pingpong(int irq, void *ctx)
+{
+	struct device *dev = ctx;
+	struct rk_vip_device *vip_dev = dev_get_drvdata(dev);
+	struct rk_vip_stream *stream = &vip_dev->stream;
+	void __iomem *base = vip_dev->base_addr;
+	unsigned int intstat;
+
+	u32 lastline, lastpix, ctl, vip_frmst;
+
+	intstat = read_vip_reg(base, VIP_INTSTAT);
+	vip_frmst = read_vip_reg(base, VIP_FRAME_STATUS);
+	lastline = VIP_FETCH_Y_LAST_LINE(read_vip_reg(base, VIP_LAST_LINE));
+	lastpix =  VIP_FETCH_Y_LAST_LINE(read_vip_reg(base, VIP_LAST_PIX));
+	ctl = read_vip_reg(base, VIP_CTRL);
+
+	/* There are two irqs enabled:
+	 *  - PST_INF_FRAME_END: vip FIFO is ready,
+	 *    this is prior to FRAME_END
+	 *  - FRAME_END: vip has saved frame to memory,
+	 *    a frame ready
+	 */
+
+	if ((intstat & VIP_INTSTAT_PST_INF_FRAME_END)) {
+		write_vip_reg(base, VIP_INTSTAT,
+			      VIP_INTSTAT_PST_INF_FRAME_END_CLR);
+		if (stream->stopping)
+			/* To stop VIP ASAP, before FRAME_END irq */
+			write_vip_reg(base, VIP_CTRL,
+				      ctl & (~VIP_CTRL_ENABLE_CAPTURE));
+	}
+
+	if ((intstat & VIP_INTSTAT_PRE_INF_FRAME_END))
+		write_vip_reg(base, VIP_INTSTAT, VIP_INTSTAT_PRE_INF_FRAME_END);
+
+	if (intstat & (VIP_INTSTAT_LINE_ERR | VIP_INTSTAT_PIX_ERR)) {
+		v4l2_err(&vip_dev->v4l2_dev, "LINE_ERR OR PIX_ERR");
+		write_vip_reg(base, VIP_INTSTAT, VIP_INTSTAT_LINE_ERR |
+						 VIP_INTSTAT_PIX_ERR);
+		rk_vip_reset_stream(vip_dev);
+	}
+
+	if ((intstat & VIP_INTSTAT_FRAME_END)) {
+		struct vb2_v4l2_buffer *vb_done = NULL;
+
+		write_vip_reg(base, VIP_INTSTAT, VIP_INTSTAT_FRAME_END_CLR |
+						 VIP_INTSTAT_LINE_END_CLR);
+
+		if (stream->stopping) {
+			rk_vip_stream_stop(stream);
+			stream->stopping = false;
+			wake_up(&stream->wq_stopped);
+			return IRQ_HANDLED;
+		}
+
+		if (lastline != stream->pixm.height) {
+			v4l2_err(&vip_dev->v4l2_dev,
+				 "Bad frame, irq:0x%x frmst:0x%x size:%dx%d\n",
+				 intstat, vip_frmst, lastpix, lastline);
+
+			rk_vip_reset_stream(vip_dev);
+		}
+
+		if (vip_frmst & VIP_INTSTAT_F0_READY)
+			stream->frame_phase = 0;
+		else if (vip_frmst & VIP_INTSTAT_F1_READY)
+			stream->frame_phase = 1;
+		else
+			return IRQ_HANDLED;
+
+		if (stream->buffs[stream->frame_phase])
+			vb_done = &stream->buffs[stream->frame_phase]->vb;
+
+		rk_vip_assign_new_buffer_pingpong(stream);
+
+		if (vb_done)
+			rk_vip_vb_done(stream, vb_done);
+
+		stream->frame_idx++;
+	}
+
+	return IRQ_HANDLED;
+}
diff --git a/drivers/media/platform/rockchip/vip/dev.c b/drivers/media/platform/rockchip/vip/dev.c
new file mode 100644
index 000000000000..c3931e5accbd
--- /dev/null
+++ b/drivers/media/platform/rockchip/vip/dev.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Rockchip VIP Camera Interface Driver
+ *
+ * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
+ * Copyright (C) 2020 Maxime Chevallier <maxime.chevallier@bootlin.com>
+ * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
+ */
+
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
+#define RK_VIP_VERNO_LEN	10
+
+struct vip_match_data {
+	int chip_id;
+	const char * const *clks;
+	const char * const *rsts;
+	int clks_num;
+	int rsts_num;
+};
+
+static int rk_vip_create_links(struct rk_vip_device *vip_dev)
+{
+	struct v4l2_subdev *sd = vip_dev->sensor.sd;
+	int ret;
+
+	ret = media_create_pad_link(&sd->entity, 0,
+				    &vip_dev->stream.vdev.entity, 0,
+				    MEDIA_LNK_FL_ENABLED);
+	if (ret) {
+		dev_err(vip_dev->dev, "failed to create link");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int subdev_notifier_complete(struct v4l2_async_notifier *notifier)
+{
+	struct rk_vip_device *vip_dev;
+	int ret;
+
+	vip_dev = container_of(notifier, struct rk_vip_device, notifier);
+
+	mutex_lock(&vip_dev->media_dev.graph_mutex);
+
+	ret = v4l2_device_register_subdev_nodes(&vip_dev->v4l2_dev);
+	if (ret < 0)
+		goto unlock;
+
+	ret = rk_vip_create_links(vip_dev);
+	if (ret < 0)
+		goto unlock;
+
+unlock:
+	mutex_unlock(&vip_dev->media_dev.graph_mutex);
+	return ret;
+}
+
+static int subdev_notifier_bound(struct v4l2_async_notifier *notifier,
+				 struct v4l2_subdev *subdev,
+				 struct v4l2_async_connection *asd)
+{
+	struct rk_vip_device *vip_dev = container_of(notifier,
+					struct rk_vip_device, notifier);
+
+	int pad;
+
+	vip_dev->sensor.sd = subdev;
+	pad = media_entity_get_fwnode_pad(&subdev->entity, subdev->fwnode,
+					  MEDIA_PAD_FL_SOURCE);
+	if (pad < 0)
+		return pad;
+
+	vip_dev->sensor.pad = pad;
+
+	return 0;
+}
+
+static const struct v4l2_async_notifier_operations subdev_notifier_ops = {
+	.bound = subdev_notifier_bound,
+	.complete = subdev_notifier_complete,
+};
+
+static int vip_subdev_notifier(struct rk_vip_device *vip_dev)
+{
+	struct v4l2_async_notifier *ntf = &vip_dev->notifier;
+	struct device *dev = vip_dev->dev;
+	struct v4l2_async_connection *asd;
+	struct v4l2_fwnode_endpoint vep = {
+		.bus_type = V4L2_MBUS_PARALLEL,
+	};
+	struct fwnode_handle *ep;
+	int ret;
+
+	v4l2_async_nf_init(ntf, &vip_dev->v4l2_dev);
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
+	if (IS_ERR(asd)) {
+		ret = PTR_ERR(asd);
+		return ret;
+	}
+
+	ntf->ops = &subdev_notifier_ops;
+
+	fwnode_handle_put(ep);
+
+	ret = v4l2_async_nf_register(ntf);
+	return ret;
+}
+
+static int rk_vip_register_platform_subdevs(struct rk_vip_device *vip_dev)
+{
+	int ret;
+
+	ret = rk_vip_register_stream_vdev(vip_dev);
+	if (ret < 0)
+		return ret;
+
+	ret = vip_subdev_notifier(vip_dev);
+	if (ret < 0) {
+		v4l2_err(&vip_dev->v4l2_dev,
+			 "Failed to register subdev notifier(%d)\n", ret);
+		rk_vip_unregister_stream_vdev(vip_dev);
+	}
+
+	return 0;
+}
+
+static const char * const px30_vip_clks[] = {
+	"aclk",
+	"hclk",
+	"pclk",
+};
+
+static const struct vip_match_data px30_vip_match_data = {
+	.chip_id = CHIP_PX30_VIP,
+	.clks = px30_vip_clks,
+	.clks_num = ARRAY_SIZE(px30_vip_clks),
+};
+
+static const struct of_device_id rk_vip_plat_of_match[] = {
+	{
+		.compatible = "rockchip,px30-vip",
+		.data = &px30_vip_match_data,
+	},
+	{},
+};
+
+void rk_vip_soft_reset(struct rk_vip_device *vip_dev)
+{
+	reset_control_assert(vip_dev->vip_rst);
+
+	udelay(5);
+
+	reset_control_deassert(vip_dev->vip_rst);
+}
+
+static int rk_vip_get_resource(struct platform_device *pdev,
+			       struct rk_vip_device *vip_dev)
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
+	vip_dev->base_addr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(vip_dev->base_addr))
+		return PTR_ERR(vip_dev->base_addr);
+
+	return 0;
+}
+
+static int rk_vip_plat_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct device_node *node = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct v4l2_device *v4l2_dev;
+	struct rk_vip_device *vip_dev;
+	const struct vip_match_data *data;
+	int i, ret, irq;
+
+	match = of_match_node(rk_vip_plat_of_match, node);
+	if (!match)
+		return -ENODEV;
+
+	vip_dev = devm_kzalloc(dev, sizeof(*vip_dev), GFP_KERNEL);
+	if (!vip_dev)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, vip_dev);
+	vip_dev->dev = dev;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, rk_vip_irq_pingpong, 0,
+			       dev_driver_string(dev), dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "request irq failed\n");
+
+	vip_dev->irq = irq;
+	data = match->data;
+	vip_dev->chip_id = data->chip_id;
+
+	ret = rk_vip_get_resource(pdev, vip_dev);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < data->clks_num; i++)
+		vip_dev->clks[i].id = data->clks[i];
+
+	vip_dev->num_clk = data->clks_num;
+
+	ret = devm_clk_bulk_get(dev, vip_dev->num_clk, vip_dev->clks);
+	if (ret)
+		return ret;
+
+	vip_dev->vip_rst = devm_reset_control_array_get(dev, false, false);
+	if (IS_ERR(vip_dev->vip_rst))
+		return PTR_ERR(vip_dev->vip_rst);
+
+	/* Initialize the stream */
+	rk_vip_stream_init(vip_dev);
+	strscpy(vip_dev->media_dev.model, "rk_vip",
+		sizeof(vip_dev->media_dev.model));
+	vip_dev->media_dev.dev = &pdev->dev;
+	v4l2_dev = &vip_dev->v4l2_dev;
+	v4l2_dev->mdev = &vip_dev->media_dev;
+	strscpy(v4l2_dev->name, "rk_vip", sizeof(v4l2_dev->name));
+
+	ret = v4l2_device_register(vip_dev->dev, &vip_dev->v4l2_dev);
+	if (ret < 0)
+		return ret;
+
+	media_device_init(&vip_dev->media_dev);
+
+	ret = media_device_register(&vip_dev->media_dev);
+	if (ret < 0) {
+		v4l2_err(v4l2_dev, "Failed to register media device: %d\n",
+			 ret);
+		goto err_unreg_v4l2_dev;
+	}
+
+	/* create & register platform subdev (from of_node) */
+	ret = rk_vip_register_platform_subdevs(vip_dev);
+	if (ret < 0)
+		goto err_unreg_media_dev;
+
+	vip_dev->sensor.std = V4L2_STD_NTSC;
+	rk_vip_set_default_format(vip_dev);
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+
+err_unreg_media_dev:
+	media_device_unregister(&vip_dev->media_dev);
+err_unreg_v4l2_dev:
+	v4l2_device_unregister(&vip_dev->v4l2_dev);
+	return ret;
+}
+
+static int rk_vip_plat_remove(struct platform_device *pdev)
+{
+	struct rk_vip_device *vip_dev = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+
+	media_device_unregister(&vip_dev->media_dev);
+	v4l2_device_unregister(&vip_dev->v4l2_dev);
+	rk_vip_unregister_stream_vdev(vip_dev);
+
+	return 0;
+}
+
+static int __maybe_unused rk_vip_runtime_suspend(struct device *dev)
+{
+	struct rk_vip_device *vip_dev = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(vip_dev->num_clk, vip_dev->clks);
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int __maybe_unused rk_vip_runtime_resume(struct device *dev)
+{
+	struct rk_vip_device *vip_dev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret < 0)
+		return ret;
+
+	return clk_bulk_prepare_enable(vip_dev->num_clk, vip_dev->clks);
+}
+
+static const struct dev_pm_ops rk_vip_plat_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(rk_vip_runtime_suspend, rk_vip_runtime_resume, NULL)
+};
+
+static struct platform_driver rk_vip_plat_drv = {
+	.driver = {
+		   .name = VIP_DRIVER_NAME,
+		   .of_match_table = rk_vip_plat_of_match,
+		   .pm = &rk_vip_plat_pm_ops,
+	},
+	.probe = rk_vip_plat_probe,
+	.remove = rk_vip_plat_remove,
+};
+module_platform_driver(rk_vip_plat_drv);
+
+MODULE_AUTHOR("Rockchip Camera/ISP team");
+MODULE_DESCRIPTION("Rockchip VIP platform driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/media/platform/rockchip/vip/dev.h b/drivers/media/platform/rockchip/vip/dev.h
new file mode 100644
index 000000000000..eb9cd8f20ffc
--- /dev/null
+++ b/drivers/media/platform/rockchip/vip/dev.h
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Rockchip VIP Driver
+ *
+ * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
+ * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
+ */
+
+#ifndef _RK_VIP_DEV_H
+#define _RK_VIP_DEV_H
+
+#include <linux/clk.h>
+#include <linux/mutex.h>
+#include <media/media-device.h>
+#include <media/media-entity.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
+#include <media/videobuf2-v4l2.h>
+
+#define VIP_DRIVER_NAME		"rk_vip"
+#define VIP_VIDEODEVICE_NAME	"stream_vip"
+
+#define RK_VIP_MAX_BUS_CLK	8
+#define RK_VIP_MAX_SENSOR	2
+#define RK_VIP_MAX_RESET	5
+#define RK_VIP_MAX_CSI_CHANNEL	4
+
+#define RK_VIP_DEFAULT_WIDTH	640
+#define RK_VIP_DEFAULT_HEIGHT	480
+
+#define write_vip_reg(base, addr, val)  writel(val, (addr) + (base))
+#define read_vip_reg(base, addr) readl((addr) + (base))
+
+enum rk_vip_state {
+	RK_VIP_STATE_DISABLED,
+	RK_VIP_STATE_READY,
+	RK_VIP_STATE_STREAMING
+};
+
+enum rk_vip_chip_id {
+	CHIP_PX30_VIP,
+	CHIP_RK1808_VIP,
+	CHIP_RK3128_VIP,
+	CHIP_RK3288_VIP
+};
+
+enum host_type_t {
+	RK_CSI_RXHOST,
+	RK_DSI_RXHOST
+};
+
+struct rk_vip_buffer {
+	struct vb2_v4l2_buffer vb;
+	struct list_head queue;
+	union {
+		u32 buff_addr[VIDEO_MAX_PLANES];
+		void *vaddr[VIDEO_MAX_PLANES];
+	};
+};
+
+struct rk_vip_scratch_buffer {
+	void *vaddr;
+	dma_addr_t dma_addr;
+	u32 size;
+};
+
+static inline struct rk_vip_buffer *to_rk_vip_buffer(struct vb2_v4l2_buffer *vb)
+{
+	return container_of(vb, struct rk_vip_buffer, vb);
+}
+
+struct rk_vip_sensor_info {
+	struct v4l2_subdev *sd;
+	int pad;
+	struct v4l2_mbus_config mbus;
+	int lanes;
+	v4l2_std_id std;
+};
+
+struct vip_output_fmt {
+	u32 fourcc;
+	u32 mbus;
+	u32 fmt_val;
+	u8 cplanes;
+};
+
+enum vip_fmt_type {
+	VIP_FMT_TYPE_YUV = 0,
+	VIP_FMT_TYPE_RAW,
+};
+
+struct vip_input_fmt {
+	u32 mbus_code;
+	u32 dvp_fmt_val;
+	u32 csi_fmt_val;
+	enum vip_fmt_type fmt_type;
+	enum v4l2_field field;
+};
+
+struct rk_vip_stream {
+	struct rk_vip_device		*vipdev;
+	enum rk_vip_state		state;
+	bool				stopping;
+	wait_queue_head_t		wq_stopped;
+	int				frame_idx;
+	int				frame_phase;
+
+	/* lock between irq and buf_queue */
+	spinlock_t			vbq_lock;
+	struct vb2_queue		buf_queue;
+	struct list_head		buf_head;
+	struct rk_vip_scratch_buffer	scratch_buf;
+	struct rk_vip_buffer		*buffs[2];
+
+	/* vfd lock */
+	struct mutex			vlock;
+	struct video_device		vdev;
+	struct media_pad		pad;
+
+	struct vip_output_fmt		*vip_fmt_out;
+	const struct vip_input_fmt	*vip_fmt_in;
+	struct v4l2_pix_format_mplane	pixm;
+};
+
+static inline struct rk_vip_stream *to_rk_vip_stream(struct video_device *vdev)
+{
+	return container_of(vdev, struct rk_vip_stream, vdev);
+}
+
+struct rk_vip_device {
+	struct list_head		list;
+	struct device			*dev;
+	int				irq;
+	void __iomem			*base_addr;
+	void __iomem			*csi_base;
+	struct clk_bulk_data		clks[RK_VIP_MAX_BUS_CLK];
+	int				num_clk;
+	struct vb2_alloc_ctx		*alloc_ctx;
+	bool				iommu_en;
+	struct iommu_domain		*domain;
+	struct reset_control		*vip_rst;
+
+	struct v4l2_device		v4l2_dev;
+	struct media_device		media_dev;
+	struct v4l2_ctrl_handler	ctrl_handler;
+	struct v4l2_async_notifier	notifier;
+	struct v4l2_async_connection	asd;
+	struct rk_vip_sensor_info	sensor;
+
+	struct rk_vip_stream		stream;
+
+	int				chip_id;
+};
+
+void rk_vip_unregister_stream_vdev(struct rk_vip_device *dev);
+int rk_vip_register_stream_vdev(struct rk_vip_device *dev);
+void rk_vip_stream_init(struct rk_vip_device *dev);
+void rk_vip_set_default_format(struct rk_vip_device *dev);
+
+irqreturn_t rk_vip_irq_pingpong(int irq, void *ctx);
+void rk_vip_soft_reset(struct rk_vip_device *vip_dev);
+
+#endif
diff --git a/drivers/media/platform/rockchip/vip/regs.h b/drivers/media/platform/rockchip/vip/regs.h
new file mode 100644
index 000000000000..ccf10ffbbff8
--- /dev/null
+++ b/drivers/media/platform/rockchip/vip/regs.h
@@ -0,0 +1,260 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Rockchip VIP Driver
+ *
+ * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
+ * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
+ */
+
+#ifndef _RK_VIP_REGS_H
+#define _RK_VIP_REGS_H
+
+/* VIP Reg Offset */
+#define VIP_CTRL				0x00
+#define VIP_INTEN				0x04
+#define VIP_INTSTAT				0x08
+#define VIP_FOR					0x0c
+#define VIP_LINE_NUM_ADDR			0x10
+#define VIP_FRM0_ADDR_Y				0x14
+#define VIP_FRM0_ADDR_UV			0x18
+#define VIP_FRM1_ADDR_Y				0x1c
+#define VIP_FRM1_ADDR_UV			0x20
+#define VIP_VIR_LINE_WIDTH			0x24
+#define VIP_SET_SIZE				0x28
+#define VIP_SCM_ADDR_Y				0x2c
+#define VIP_SCM_ADDR_U				0x30
+#define VIP_SCM_ADDR_V				0x34
+#define VIP_WB_UP_FILTER			0x38
+#define VIP_WB_LOW_FILTER			0x3c
+#define VIP_WBC_CNT				0x40
+#define VIP_CROP				0x44
+#define VIP_SCL_CTRL				0x48
+#define VIP_SCL_DST				0x4c
+#define VIP_SCL_FCT				0x50
+#define VIP_SCL_VALID_NUM			0x54
+#define VIP_LINE_LOOP_CTR			0x58
+#define VIP_FRAME_STATUS			0x60
+#define VIP_CUR_DST				0x64
+#define VIP_LAST_LINE				0x68
+#define VIP_LAST_PIX				0x6c
+
+/* RK1808 VIP CSI Registers Offset */
+#define VIP_CSI_ID0_CTRL0			0x80
+#define VIP_CSI_ID0_CTRL1			0x84
+#define VIP_CSI_ID1_CTRL0			0x88
+#define VIP_CSI_ID1_CTRL1			0x8c
+#define VIP_CSI_ID2_CTRL0			0x90
+#define VIP_CSI_ID2_CTRL1			0x94
+#define VIP_CSI_ID3_CTRL0			0x98
+#define VIP_CSI_ID3_CTRL1			0x9c
+#define VIP_CSI_WATER_LINE			0xa0
+#define VIP_CSI_FRM0_ADDR_Y_ID0			0xa4
+#define VIP_CSI_FRM1_ADDR_Y_ID0			0xa8
+#define VIP_CSI_FRM0_ADDR_UV_ID0		0xac
+#define VIP_CSI_FRM1_ADDR_UV_ID0		0xb0
+#define VIP_CSI_FRM0_VLW_Y_ID0			0xb4
+#define VIP_CSI_FRM1_VLW_Y_ID0			0xb8
+#define VIP_CSI_FRM0_VLW_UV_ID0			0xbc
+#define VIP_CSI_FRM1_VLW_UV_ID0			0xc0
+#define VIP_CSI_FRM0_ADDR_Y_ID1			0xc4
+#define VIP_CSI_FRM1_ADDR_Y_ID1			0xc8
+#define VIP_CSI_FRM0_ADDR_UV_ID1		0xcc
+#define VIP_CSI_FRM1_ADDR_UV_ID1		0xd0
+#define VIP_CSI_FRM0_VLW_Y_ID1			0xd4
+#define VIP_CSI_FRM1_VLW_Y_ID1			0xd8
+#define VIP_CSI_FRM0_VLW_UV_ID1			0xdc
+#define VIP_CSI_FRM1_VLW_UV_ID1			0xe0
+#define VIP_CSI_FRM0_ADDR_Y_ID2			0xe4
+#define VIP_CSI_FRM1_ADDR_Y_ID2			0xe8
+#define VIP_CSI_FRM0_ADDR_UV_ID2		0xec
+#define VIP_CSI_FRM1_ADDR_UV_ID2		0xf0
+#define VIP_CSI_FRM0_VLW_Y_ID2			0xf4
+#define VIP_CSI_FRM1_VLW_Y_ID2			0xf8
+#define VIP_CSI_FRM0_VLW_UV_ID2			0xfc
+#define VIP_CSI_FRM1_VLW_UV_ID2			0x100
+#define VIP_CSI_FRM0_ADDR_Y_ID3			0x104
+#define VIP_CSI_FRM1_ADDR_Y_ID3			0x108
+#define VIP_CSI_FRM0_ADDR_UV_ID3		0x10c
+#define VIP_CSI_FRM1_ADDR_UV_ID3		0x110
+#define VIP_CSI_FRM0_VLW_Y_ID3			0x114
+#define VIP_CSI_FRM1_VLW_Y_ID3			0x118
+#define VIP_CSI_FRM0_VLW_UV_ID3			0x11c
+#define VIP_CSI_FRM1_VLW_UV_ID3			0x120
+#define VIP_CSI_INTEN				0x124
+#define VIP_CSI_INTSTAT				0x128
+#define VIP_CSI_LINE_INT_NUM_ID0_1		0x12c
+#define VIP_CSI_LINE_INT_NUM_ID2_3		0x130
+#define VIP_CSI_LINE_CNT_ID0_1			0x134
+#define VIP_CSI_LINE_CNT_ID2_3			0x138
+#define VIP_CSI_ID0_CROP_START			0x13c
+#define VIP_CSI_ID1_CROP_START			0x140
+#define VIP_CSI_ID2_CROP_START			0x144
+#define VIP_CSI_ID3_CROP_START			0x148
+
+/* The key register bit description */
+
+/* VIP_CTRL Reg */
+#define VIP_CTRL_ENABLE_CAPTURE			BIT(0)
+#define VIP_CTRL_MODE_PINGPONG			BIT(1)
+#define VIP_CTRL_MODE_LINELOOP			BIT(2)
+#define VIP_CTRL_AXI_BURST_16			(0xF << 12)
+
+/* VIP_INTEN */
+#define VIP_INTEN_FRAME_END_EN			BIT(0)
+#define VIP_INTEN_LINE_ERR_EN			BIT(2)
+#define VIP_INTEN_BUS_ERR_EN			BIT(6)
+#define VIP_INTEN_SCL_ERR_EN			BIT(7)
+#define VIP_INTEN_PST_INF_FRAME_END_EN		BIT(9)
+
+/* VIP INTSTAT */
+#define VIP_INTSTAT_CLS				0x3FF
+#define VIP_INTSTAT_FRAME_END			BIT(0)
+#define VIP_INTSTAT_LINE_END			BIT(1)
+#define VIP_INTSTAT_LINE_ERR			BIT(2)
+#define VIP_INTSTAT_PIX_ERR			BIT(3)
+#define VIP_INTSTAT_DFIFO_OF			BIT(5)
+#define VIP_INTSTAT_BUS_ERR			BIT(6)
+#define VIP_INTSTAT_PRE_INF_FRAME_END		BIT(8)
+#define VIP_INTSTAT_PST_INF_FRAME_END		BIT(9)
+#define VIP_INTSTAT_FRAME_END_CLR		BIT(0)
+#define VIP_INTSTAT_LINE_END_CLR		BIT(1)
+#define VIP_INTSTAT_LINE_ERR_CLR		BIT(2)
+#define VIP_INTSTAT_PST_INF_FRAME_END_CLR	BIT(9)
+#define VIP_INTSTAT_ERR				0xFC
+
+/* VIP_FRAME STATUS */
+#define VIP_FRAME_STAT_CLS			0x00
+/* write 0 to clear frame 0 */
+#define VIP_FRAME_FRM0_STAT_CLS			0x20
+
+/* VIP_FORMAT */
+#define VIP_FORMAT_VSY_HIGH_ACTIVE		BIT(0)
+#define VIP_FORMAT_HSY_LOW_ACTIVE		BIT(1)
+
+#define VIP_FORMAT_INPUT_MODE_YUV		(0x00 << 2)
+#define VIP_FORMAT_INPUT_MODE_PAL		(0x02 << 2)
+#define VIP_FORMAT_INPUT_MODE_NTSC		(0x03 << 2)
+#define VIP_FORMAT_INPUT_MODE_BT1120		(0x07 << 2)
+#define VIP_FORMAT_INPUT_MODE_RAW		(0x04 << 2)
+#define VIP_FORMAT_INPUT_MODE_JPEG		(0x05 << 2)
+#define VIP_FORMAT_INPUT_MODE_MIPI		(0x06 << 2)
+
+#define VIP_FORMAT_YUV_INPUT_ORDER_UYVY		(0x00 << 5)
+#define VIP_FORMAT_YUV_INPUT_ORDER_YVYU		BIT(5)
+#define VIP_FORMAT_YUV_INPUT_ORDER_VYUY		(0x10 << 5)
+#define VIP_FORMAT_YUV_INPUT_ORDER_YUYV		(0x03 << 5)
+#define VIP_FORMAT_YUV_INPUT_422		(0x00 << 7)
+#define VIP_FORMAT_YUV_INPUT_420		BIT(7)
+
+#define VIP_FORMAT_INPUT_420_ORDER_ODD		BIT(8)
+
+#define VIP_FORMAT_CCIR_INPUT_ORDER_EVEN	BIT(9)
+
+#define VIP_FORMAT_RAW_DATA_WIDTH_8		(0x00 << 11)
+#define VIP_FORMAT_RAW_DATA_WIDTH_10		BIT(11)
+#define VIP_FORMAT_RAW_DATA_WIDTH_12		(0x02 << 11)
+
+#define VIP_FORMAT_YUV_OUTPUT_422		(0x00 << 16)
+#define VIP_FORMAT_YUV_OUTPUT_420		BIT(16)
+
+#define VIP_FORMAT_OUTPUT_420_ORDER_EVEN	(0x00 << 17)
+#define VIP_FORMAT_OUTPUT_420_ORDER_ODD		BIT(17)
+
+#define VIP_FORMAT_RAWD_DATA_LITTLE_ENDIAN	(0x00 << 18)
+#define VIP_FORMAT_RAWD_DATA_BIG_ENDIAN		BIT(18)
+
+#define VIP_FORMAT_UV_STORAGE_ORDER_UVUV	(0x00 << 19)
+#define VIP_FORMAT_UV_STORAGE_ORDER_VUVU	BIT(19)
+
+#define VIP_FORMAT_BT1120_CLOCK_SINGLE_EDGES	(0x00 << 24)
+#define VIP_FORMAT_BT1120_CLOCK_DOUBLE_EDGES	BIT(24)
+#define VIP_FORMAT_BT1120_TRANSMIT_INTERFACE	(0x00 << 25)
+#define VIP_FORMAT_BT1120_TRANSMIT_PROGRESS	BIT(25)
+#define VIP_FORMAT_BT1120_YC_SWAP		BIT(26)
+
+/* VIP_SCL_CTRL */
+#define VIP_SCL_CTRL_ENABLE_SCL_DOWN		BIT(0)
+#define VIP_SCL_CTRL_ENABLE_SCL_UP		BIT(1)
+#define VIP_SCL_CTRL_ENABLE_YUV_16BIT_BYPASS	BIT(4)
+#define VIP_SCL_CTRL_ENABLE_RAW_16BIT_BYPASS	BIT(5)
+#define VIP_SCL_CTRL_ENABLE_32BIT_BYPASS	BIT(6)
+#define VIP_SCL_CTRL_DISABLE_32BIT_BYPASS	(0x00 << 6)
+
+/* VIP_INTSTAT */
+#define VIP_INTSTAT_F0_READY			BIT(0)
+#define VIP_INTSTAT_F1_READY			BIT(1)
+
+/* VIP_CROP */
+#define VIP_CROP_Y_SHIFT			16
+#define VIP_CROP_X_SHIFT			0
+
+/* VIP_CSI_ID_CTRL0 */
+#define VIP_CSI_ENABLE_CAPTURE			BIT(0)
+#define VIP_CSI_WRDDR_TYPE_RAW8			(0x0 << 1)
+#define VIP_CSI_WRDDR_TYPE_RAW10		BIT(1)
+#define VIP_CSI_WRDDR_TYPE_RAW12		(0x2 << 1)
+#define VIP_CSI_WRDDR_TYPE_RGB888		(0x3 << 1)
+#define VIP_CSI_WRDDR_TYPE_YUV422		(0x4 << 1)
+#define VIP_CSI_ENABLE_COMMAND_MODE		BIT(4)
+#define VIP_CSI_ENABLE_CROP			BIT(5)
+
+/* VIP_CSI_INTEN */
+#define VIP_CSI_FRAME0_START_INTEN(id)		(0x1 << ((id) * 2))
+#define VIP_CSI_FRAME1_START_INTEN(id)		(0x1 << ((id) * 2 + 1))
+#define VIP_CSI_FRAME0_END_INTEN(id)		(0x1 << ((id) * 2 + 8))
+#define VIP_CSI_FRAME1_END_INTEN(id)		(0x1 << ((id) * 2 + 9))
+#define VIP_CSI_DMA_Y_FIFO_OVERFLOW_INTEN	BIT(16)
+#define VIP_CSI_DMA_UV_FIFO_OVERFLOW_INTEN	BIT(17)
+#define VIP_CSI_CONFIG_FIFO_OVERFLOW_INTEN	BIT(18)
+#define VIP_CSI_BANDWIDTH_LACK_INTEN		BIT(19)
+#define VIP_CSI_RX_FIFO_OVERFLOW_INTEN		BIT(20)
+#define VIP_CSI_ALL_FRAME_START_INTEN		(0xff << 0)
+#define VIP_CSI_ALL_FRAME_END_INTEN		(0xff << 8)
+#define VIP_CSI_ALL_ERROR_INTEN			(0x1f << 16)
+
+/* VIP_CSI_INTSTAT */
+#define VIP_CSI_FRAME0_START_ID0		BIT(0)
+#define VIP_CSI_FRAME1_START_ID0		BIT(1)
+#define VIP_CSI_FRAME0_START_ID1		BIT(2)
+#define VIP_CSI_FRAME1_START_ID1		BIT(3)
+#define VIP_CSI_FRAME0_START_ID2		BIT(4)
+#define VIP_CSI_FRAME1_START_ID2		BIT(5)
+#define VIP_CSI_FRAME0_START_ID3		BIT(6)
+#define VIP_CSI_FRAME1_START_ID3		BIT(7)
+#define VIP_CSI_FRAME0_END_ID0			BIT(8)
+#define VIP_CSI_FRAME1_END_ID0			BIT(9)
+#define VIP_CSI_FRAME0_END_ID1			BIT(10)
+#define VIP_CSI_FRAME1_END_ID1			BIT(11)
+#define VIP_CSI_FRAME0_END_ID2			BIT(12)
+#define VIP_CSI_FRAME1_END_ID2			BIT(13)
+#define VIP_CSI_FRAME0_END_ID3			BIT(14)
+#define VIP_CSI_FRAME1_END_ID3			BIT(15)
+#define VIP_CSI_DMA_Y_FIFO_OVERFLOW		BIT(16)
+#define VIP_CSI_DMA_UV_FIFO_OVERFLOW		BIT(17)
+#define VIP_CSI_CONFIG_FIFO_OVERFLOW		BIT(18)
+#define VIP_CSI_BANDWIDTH_LACK			BIT(19)
+#define VIP_CSI_RX_FIFO_OVERFLOW		BIT(20)
+
+#define VIP_CSI_FIFO_OVERFLOW	(VIP_CSI_DMA_Y_FIFO_OVERFLOW |	\
+				 VIP_CSI_DMA_UV_FIFO_OVERFLOW |	\
+				 VIP_CSI_CONFIG_FIFO_OVERFLOW |	\
+				 VIP_CSI_RX_FIFO_OVERFLOW)
+
+/* CSI Host Registers Define */
+#define VIP_CSIHOST_N_LANES			0x04
+#define VIP_CSIHOST_PHY_RSTZ			0x0c
+#define VIP_CSIHOST_RESETN			0x10
+#define VIP_CSIHOST_ERR1			0x20
+#define VIP_CSIHOST_ERR2			0x24
+#define VIP_CSIHOST_MSK1			0x28
+#define VIP_CSIHOST_MSK2			0x2c
+#define VIP_CSIHOST_CONTROL			0x40
+
+#define VIP_SW_CPHY_EN(x)			((x) << 0)
+#define VIP_SW_DSI_EN(x)			((x) << 4)
+#define VIP_SW_DATATYPE_FS(x)			((x) << 8)
+#define VIP_SW_DATATYPE_FE(x)			((x) << 14)
+#define VIP_SW_DATATYPE_LS(x)			((x) << 20)
+#define VIP_SW_DATATYPE_LE(x)			((x) << 26)
+
+#endif
-- 
2.41.0


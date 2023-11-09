Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743D27E733D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345255AbjKIVDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345287AbjKIVDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:03:42 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BB4468D;
        Thu,  9 Nov 2023 13:03:40 -0800 (PST)
Received: from umang.jain (unknown [103.251.226.64])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C1C7E17E1;
        Thu,  9 Nov 2023 22:03:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699563797;
        bh=UGbt2gNpcq6Got7o/iptCN99Wfa1miF2Uco0UJXkdfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVmdpIrKpqd/BNe6KjUx3fHvHzl4RteJv+d2VkKw6tl+Cj2GVLdJ+/lXh7pq2/bQ5
         Ji2y5IfDKZKUlopqieZxGRAeAAEeXe/ZKdb6Zaae2z24V610ifJhuY8Inu9U/9jXDR
         3zw1FOQfShs8smfDHsmBZdoghJ9I8R2dOswTDV6k=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Naushir Patuck <naush@raspberrypi.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 08/15] uapi: bcm2835-isp: Add bcm2835-isp uapi header file
Date:   Thu,  9 Nov 2023 16:03:00 -0500
Message-ID: <20231109210309.638594-9-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109210309.638594-1-umang.jain@ideasonboard.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

This file defines the userland interface to the bcm2835-isp driver
that will follow in a separate commit.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 include/uapi/linux/bcm2835-isp.h   | 320 +++++++++++++++++++++++++++++
 include/uapi/linux/v4l2-controls.h |   5 +
 2 files changed, 325 insertions(+)
 create mode 100644 include/uapi/linux/bcm2835-isp.h

diff --git a/include/uapi/linux/bcm2835-isp.h b/include/uapi/linux/bcm2835-isp.h
new file mode 100644
index 000000000000..cf8c0437f159
--- /dev/null
+++ b/include/uapi/linux/bcm2835-isp.h
@@ -0,0 +1,320 @@
+/* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * bcm2835-isp.h
+ *
+ * BCM2835 ISP driver - user space header file.
+ *
+ * Copyright © 2019-2020 Raspberry Pi (Trading) Ltd.
+ *
+ * Author: Naushir Patuck (naush@raspberrypi.com)
+ *
+ */
+
+#ifndef __BCM2835_ISP_H_
+#define __BCM2835_ISP_H_
+
+#include <linux/v4l2-controls.h>
+
+#define V4L2_CID_USER_BCM2835_ISP_CC_MATRIX	\
+				(V4L2_CID_USER_BCM2835_ISP_BASE + 0x0001)
+#define V4L2_CID_USER_BCM2835_ISP_LENS_SHADING	\
+				(V4L2_CID_USER_BCM2835_ISP_BASE + 0x0002)
+#define V4L2_CID_USER_BCM2835_ISP_BLACK_LEVEL	\
+				(V4L2_CID_USER_BCM2835_ISP_BASE + 0x0003)
+#define V4L2_CID_USER_BCM2835_ISP_GEQ		\
+				(V4L2_CID_USER_BCM2835_ISP_BASE + 0x0004)
+#define V4L2_CID_USER_BCM2835_ISP_GAMMA		\
+				(V4L2_CID_USER_BCM2835_ISP_BASE + 0x0005)
+#define V4L2_CID_USER_BCM2835_ISP_DENOISE	\
+				(V4L2_CID_USER_BCM2835_ISP_BASE + 0x0006)
+#define V4L2_CID_USER_BCM2835_ISP_SHARPEN	\
+				(V4L2_CID_USER_BCM2835_ISP_BASE + 0x0007)
+#define V4L2_CID_USER_BCM2835_ISP_DPC		\
+				(V4L2_CID_USER_BCM2835_ISP_BASE + 0x0008)
+
+/*
+ * All structs below are directly mapped onto the equivalent structs in
+ * drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
+ * for convenience.
+ */
+
+/**
+ * struct bcm2835_isp_rational - Rational value type.
+ *
+ * @num:	Numerator.
+ * @den:	Denominator.
+ */
+struct bcm2835_isp_rational {
+	__s32 num;
+	__u32 den;
+};
+
+/**
+ * struct bcm2835_isp_ccm - Colour correction matrix.
+ *
+ * @ccm:	3x3 correction matrix coefficients.
+ * @offsets:	1x3 correction offsets.
+ */
+struct bcm2835_isp_ccm {
+	struct bcm2835_isp_rational ccm[3][3];
+	__s32 offsets[3];
+};
+
+/**
+ * struct bcm2835_isp_custom_ccm - Custom CCM applied with the
+ *				   V4L2_CID_USER_BCM2835_ISP_CC_MATRIX ctrl.
+ *
+ * @enabled:	Enable custom CCM.
+ * @ccm:	Custom CCM coefficients and offsets.
+ */
+struct bcm2835_isp_custom_ccm {
+	__u32 enabled;
+	struct bcm2835_isp_ccm ccm;
+};
+
+/**
+ * enum bcm2835_isp_gain_format - format of the gains in the lens shading
+ *				  tables used with the
+ *				  V4L2_CID_USER_BCM2835_ISP_LENS_SHADING ctrl.
+ *
+ * @GAIN_FORMAT_U0P8_1:		Gains are u0.8 format, starting at 1.0
+ * @GAIN_FORMAT_U1P7_0:		Gains are u1.7 format, starting at 0.0
+ * @GAIN_FORMAT_U1P7_1:		Gains are u1.7 format, starting at 1.0
+ * @GAIN_FORMAT_U2P6_0:		Gains are u2.6 format, starting at 0.0
+ * @GAIN_FORMAT_U2P6_1:		Gains are u2.6 format, starting at 1.0
+ * @GAIN_FORMAT_U3P5_0:		Gains are u3.5 format, starting at 0.0
+ * @GAIN_FORMAT_U3P5_1:		Gains are u3.5 format, starting at 1.0
+ * @GAIN_FORMAT_U4P10:		Gains are u4.10 format, starting at 0.0
+ */
+enum bcm2835_isp_gain_format {
+	GAIN_FORMAT_U0P8_1 = 0,
+	GAIN_FORMAT_U1P7_0 = 1,
+	GAIN_FORMAT_U1P7_1 = 2,
+	GAIN_FORMAT_U2P6_0 = 3,
+	GAIN_FORMAT_U2P6_1 = 4,
+	GAIN_FORMAT_U3P5_0 = 5,
+	GAIN_FORMAT_U3P5_1 = 6,
+	GAIN_FORMAT_U4P10  = 7,
+};
+
+/**
+ * struct bcm2835_isp_lens_shading - Lens shading tables supplied with the
+ *				     V4L2_CID_USER_BCM2835_ISP_LENS_SHADING
+ *				     ctrl.
+ *
+ * @enabled:		Enable lens shading.
+ * @grid_cell_size:	Size of grid cells in samples (16, 32, 64, 128 or 256).
+ * @grid_width:		Width of lens shading tables in grid cells.
+ * @grid_stride:	Row to row distance (in grid cells) between grid cells
+ *			in the same horizontal location.
+ * @grid_height:	Height of lens shading tables in grid cells.
+ * @dmabuf:		dmabuf file handle containing the table.
+ * @ref_transform:	Reference transform - unsupported, please pass zero.
+ * @corner_sampled:	Whether the gains are sampled at the corner points
+ *			of the grid cells or in the cell centres.
+ * @gain_format:	Format of the gains (see enum &bcm2835_isp_gain_format).
+ */
+struct bcm2835_isp_lens_shading {
+	__u32 enabled;
+	__u32 grid_cell_size;
+	__u32 grid_width;
+	__u32 grid_stride;
+	__u32 grid_height;
+	__s32 dmabuf;
+	__u32 ref_transform;
+	__u32 corner_sampled;
+	__u32 gain_format;
+};
+
+/**
+ * struct bcm2835_isp_black_level - Sensor black level set with the
+ *				    V4L2_CID_USER_BCM2835_ISP_BLACK_LEVEL ctrl.
+ *
+ * @enabled:		Enable black level.
+ * @black_level_r:	Black level for red channel.
+ * @black_level_g:	Black level for green channels.
+ * @black_level_b:	Black level for blue channel.
+ */
+struct bcm2835_isp_black_level {
+	__u32 enabled;
+	__u16 black_level_r;
+	__u16 black_level_g;
+	__u16 black_level_b;
+	__u8 padding[2]; /* Unused */
+};
+
+/**
+ * struct bcm2835_isp_geq - Green equalisation parameters set with the
+ *			    V4L2_CID_USER_BCM2835_ISP_GEQ ctrl.
+ *
+ * @enabled:	Enable green equalisation.
+ * @offset:	Fixed offset of the green equalisation threshold.
+ * @slope:	Slope of the green equalisation threshold.
+ */
+struct bcm2835_isp_geq {
+	__u32 enabled;
+	__u32 offset;
+	struct bcm2835_isp_rational slope;
+};
+
+#define BCM2835_NUM_GAMMA_PTS 33
+
+/**
+ * struct bcm2835_isp_gamma - Gamma parameters set with the
+ *			      V4L2_CID_USER_BCM2835_ISP_GAMMA ctrl.
+ *
+ * @enabled:	Enable gamma adjustment.
+ * @X:		X values of the points defining the gamma curve.
+ *		Values should be scaled to 16 bits.
+ * @Y:		Y values of the points defining the gamma curve.
+ *		Values should be scaled to 16 bits.
+ */
+struct bcm2835_isp_gamma {
+	__u32 enabled;
+	__u16 x[BCM2835_NUM_GAMMA_PTS];
+	__u16 y[BCM2835_NUM_GAMMA_PTS];
+};
+
+/**
+ * struct bcm2835_isp_denoise - Denoise parameters set with the
+ *				V4L2_CID_USER_BCM2835_ISP_DENOISE ctrl.
+ *
+ * @enabled:	Enable denoise.
+ * @constant:	Fixed offset of the noise threshold.
+ * @slope:	Slope of the noise threshold.
+ * @strength:	Denoise strength between 0.0 (off) and 1.0 (maximum).
+ */
+struct bcm2835_isp_denoise {
+	__u32 enabled;
+	__u32 constant;
+	struct bcm2835_isp_rational slope;
+	struct bcm2835_isp_rational strength;
+};
+
+/**
+ * struct bcm2835_isp_sharpen - Sharpen parameters set with the
+ *				V4L2_CID_USER_BCM2835_ISP_SHARPEN ctrl.
+ *
+ * @enabled:	Enable sharpening.
+ * @threshold:	Threshold at which to start sharpening pixels.
+ * @strength:	Strength with which pixel sharpening increases.
+ * @limit:	Limit to the amount of sharpening applied.
+ */
+struct bcm2835_isp_sharpen {
+	__u32 enabled;
+	struct bcm2835_isp_rational threshold;
+	struct bcm2835_isp_rational strength;
+	struct bcm2835_isp_rational limit;
+};
+
+/**
+ * enum bcm2835_isp_dpc_mode - defective pixel correction (DPC) strength.
+ *
+ * @DPC_MODE_OFF:		No DPC.
+ * @DPC_MODE_NORMAL:		Normal DPC.
+ * @DPC_MODE_STRONG:		Strong DPC.
+ */
+enum bcm2835_isp_dpc_mode {
+	DPC_MODE_OFF = 0,
+	DPC_MODE_NORMAL = 1,
+	DPC_MODE_STRONG = 2,
+};
+
+/**
+ * struct bcm2835_isp_dpc - Defective pixel correction (DPC) parameters set
+ *			    with the V4L2_CID_USER_BCM2835_ISP_DPC ctrl.
+ *
+ * @enabled:	Enable DPC.
+ * @strength:	DPC strength (see enum &bcm2835_isp_dpc_mode).
+ */
+struct bcm2835_isp_dpc {
+	__u32 enabled;
+	__u32 strength;
+};
+
+/*
+ * ISP statistics structures.
+ *
+ * The bcm2835_isp_stats structure is generated at the output of the
+ * statistics node.  Note that this does not directly map onto the statistics
+ * output of the ISP HW.  Instead, the MMAL firmware code maps the HW statistics
+ * to the bcm2835_isp_stats structure.
+ */
+#define DEFAULT_AWB_REGIONS_X 16
+#define DEFAULT_AWB_REGIONS_Y 12
+
+#define NUM_HISTOGRAMS 2
+#define NUM_HISTOGRAM_BINS 128
+#define AWB_REGIONS (DEFAULT_AWB_REGIONS_X * DEFAULT_AWB_REGIONS_Y)
+#define FLOATING_REGIONS 16
+#define AGC_REGIONS 16
+#define FOCUS_REGIONS 12
+
+/**
+ * struct bcm2835_isp_stats_hist - Histogram statistics
+ *
+ * @r_hist:	Red channel histogram.
+ * @g_hist:	Combined green channel histogram.
+ * @b_hist:	Blue channel histogram.
+ */
+struct bcm2835_isp_stats_hist {
+	__u32 r_hist[NUM_HISTOGRAM_BINS];
+	__u32 g_hist[NUM_HISTOGRAM_BINS];
+	__u32 b_hist[NUM_HISTOGRAM_BINS];
+};
+
+/**
+ * struct bcm2835_isp_stats_region - Region sums.
+ *
+ * @counted:	The number of 2x2 bayer tiles accumulated.
+ * @notcounted:	The number of 2x2 bayer tiles not accumulated.
+ * @r_sum:	Total sum of counted pixels in the red channel for a region.
+ * @g_sum:	Total sum of counted pixels in the green channel for a region.
+ * @b_sum:	Total sum of counted pixels in the blue channel for a region.
+ */
+struct bcm2835_isp_stats_region {
+	__u32 counted;
+	__u32 notcounted;
+	__u64 r_sum;
+	__u64 g_sum;
+	__u64 b_sum;
+};
+
+/**
+ * struct bcm2835_isp_stats_focus - Focus statistics.
+ *
+ * @contrast_val:	Focus measure - accumulated output of the focus filter.
+ *			In the first dimension, index [0] counts pixels below a
+ *			preset threshold, and index [1] counts pixels above the
+ *			threshold.  In the second dimension, index [0] uses the
+ *			first predefined filter, and index [1] uses the second
+ *			predefined filter.
+ * @contrast_val_num:	The number of counted pixels in the above accumulation.
+ */
+struct bcm2835_isp_stats_focus {
+	__u64 contrast_val[2][2];
+	__u32 contrast_val_num[2][2];
+};
+
+/**
+ * struct bcm2835_isp_stats - ISP statistics.
+ *
+ * @version:		Version of the bcm2835_isp_stats structure.
+ * @size:		Size of the bcm2835_isp_stats structure.
+ * @hist:		Histogram statistics for the entire image.
+ * @awb_stats:		Statistics for the regions defined for AWB calculations.
+ * @floating_stats:	Statistics for arbitrarily placed (floating) regions.
+ * @agc_stats:		Statistics for the regions defined for AGC calculations.
+ * @focus_stats:	Focus filter statistics for the focus regions.
+ */
+struct bcm2835_isp_stats {
+	__u32 version;
+	__u32 size;
+	struct bcm2835_isp_stats_hist hist[NUM_HISTOGRAMS];
+	struct bcm2835_isp_stats_region awb_stats[AWB_REGIONS];
+	struct bcm2835_isp_stats_region floating_stats[FLOATING_REGIONS];
+	struct bcm2835_isp_stats_region agc_stats[AGC_REGIONS];
+	struct bcm2835_isp_stats_focus focus_stats[FOCUS_REGIONS];
+};
+
+#endif /* __BCM2835_ISP_H_ */
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 68db66d4aae8..31d7b6fd7a2b 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -209,6 +209,11 @@ enum v4l2_colorfx {
  */
 #define V4L2_CID_USER_NPCM_BASE			(V4L2_CID_USER_BASE + 0x11b0)
 
+/* The base for the bcm2835-isp driver controls.
+ * We reserve 16 controls for this driver.
+ */
+#define V4L2_CID_USER_BCM2835_ISP_BASE		(V4L2_CID_USER_BASE + 0x11c0)
+
 /* MPEG-class control IDs */
 /* The MPEG controls are applicable to all codec controls
  * and the 'MPEG' part of the define is historical */
-- 
2.41.0


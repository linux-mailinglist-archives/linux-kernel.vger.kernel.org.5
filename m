Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D968C766E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbjG1N1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbjG1N1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:27:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F9D4487;
        Fri, 28 Jul 2023 06:26:25 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SDIkNH002452;
        Fri, 28 Jul 2023 13:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=zSez0CIPi45UvoFnsjzVakfeJM5EAWOkj90R60b4vJQ=;
 b=bTEqBaqNtFm6uC5ZWgOLKCG/6mRPn7FVIOPXldVnJLv21xKvPGehjXx92PesBJLuqkIs
 6JAoQv+TzaiPBKdS3dqRC/at+14N0vlCYb4DVNL8cicZN+t+m1tQ4hpR3bU1N21ViK6p
 9llvFVJYJDbo2Gmd7VQPv5GJdblCL7uWJOau9Ipy8KdFoiAVPhSCbZMoU59w1gRVsyKq
 yj/U8w1rzniDoq6+49ISiKEU30GO5Ox/6ZOOyCigk29VzGnRD94KDGtcC2+S2GpARHEM
 UeRnz+uAiUs17Xlcx3r8q38vOPNlSkWJYzGjIJDVYPBGvpHzt+h5jUpioCBDKn/tZUxE Pw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4e2702u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:26:06 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SDQ6pb002075
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:26:06 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 06:26:02 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <quic_dikshita@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH 16/33] iris: add helpers for media format
Date:   Fri, 28 Jul 2023 18:53:27 +0530
Message-ID: <1690550624-14642-17-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QodYnF-AvVmabDUFT3w1Ky3vMQo53th9
X-Proofpoint-ORIG-GUID: QodYnF-AvVmabDUFT3w1Ky3vMQo53th9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=989
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280124
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dikshita Agarwal <quic_dikshita@quicinc.com>

Add helpers to calculate stride, scanline, buffer size
etc. for different media formats.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 .../platform/qcom/iris/vidc/inc/msm_media_info.h   | 599 +++++++++++++++++++++
 1 file changed, 599 insertions(+)
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_media_info.h

diff --git a/drivers/media/platform/qcom/iris/vidc/inc/msm_media_info.h b/drivers/media/platform/qcom/iris/vidc/inc/msm_media_info.h
new file mode 100644
index 0000000..772b2482
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/vidc/inc/msm_media_info.h
@@ -0,0 +1,599 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __MSM_MEDIA_INFO_H__
+#define __MSM_MEDIA_INFO_H__
+
+#include "msm_vidc_internal.h"
+
+/* Width and Height should be multiple of 16 */
+#define INTERLACE_WIDTH_MAX 1920
+#define INTERLACE_HEIGHT_MAX 1920
+#define INTERLACE_MB_PER_FRAME_MAX ((1920 * 1088) / 256)
+
+#ifndef MSM_MEDIA_ALIGN
+#define MSM_MEDIA_ALIGN(__sz, __align) (((__align) & ((__align) - 1)) ?\
+	((((__sz) + (__align) - 1) / (__align)) * (__align)) :\
+	(((__sz) + (__align) - 1) & (~((__align) - 1))))
+#endif
+
+#ifndef MSM_MEDIA_ROUNDUP
+#define MSM_MEDIA_ROUNDUP(__sz, __r) (((__sz) + ((__r) - 1)) / (__r))
+#endif
+
+/*
+ * Function arguments:
+ * @v4l2_fmt
+ * @width
+ * Progressive: width
+ * Interlaced: width
+ */
+static inline unsigned int video_y_stride_bytes(unsigned int colorformat,
+						unsigned int width)
+{
+	unsigned int alignment, stride = 0;
+
+	if (!width)
+		goto invalid_input;
+
+	switch (colorformat) {
+	case MSM_VIDC_FMT_NV12:
+	case MSM_VIDC_FMT_NV21:
+	case MSM_VIDC_FMT_NV12C:
+		alignment = 128;
+		stride = MSM_MEDIA_ALIGN(width, alignment);
+		break;
+	case MSM_VIDC_FMT_TP10C:
+		alignment = 256;
+		stride = MSM_MEDIA_ALIGN(width, 192);
+		stride = MSM_MEDIA_ALIGN(stride * 4 / 3, alignment);
+		break;
+	case MSM_VIDC_FMT_P010:
+		alignment = 256;
+		stride = MSM_MEDIA_ALIGN(width * 2, alignment);
+		break;
+	default:
+		break;
+	}
+invalid_input:
+	return stride;
+}
+
+/*
+ * Function arguments:
+ * @v4l2_fmt
+ * @width
+ * Progressive: width
+ * Interlaced: width
+ */
+static inline unsigned int video_y_stride_pix(unsigned int colorformat,
+					      unsigned int width)
+{
+	unsigned int alignment, stride = 0;
+
+	if (!width)
+		goto invalid_input;
+
+	switch (colorformat) {
+	case MSM_VIDC_FMT_NV12:
+	case MSM_VIDC_FMT_NV21:
+	case MSM_VIDC_FMT_NV12C:
+	case MSM_VIDC_FMT_P010:
+		alignment = 128;
+		stride = MSM_MEDIA_ALIGN(width, alignment);
+		break;
+	case MSM_VIDC_FMT_TP10C:
+		alignment = 192;
+		stride = MSM_MEDIA_ALIGN(width, alignment);
+		break;
+	default:
+		break;
+	}
+
+invalid_input:
+	return stride;
+}
+
+/*
+ * Function arguments:
+ * @v4l2_fmt
+ * @width
+ * Progressive: width
+ * Interlaced: width
+ */
+static inline unsigned int video_uv_stride_bytes(unsigned int colorformat,
+						 unsigned int width)
+{
+	unsigned int alignment, stride = 0;
+
+	if (!width)
+		goto invalid_input;
+
+	switch (colorformat) {
+	case MSM_VIDC_FMT_NV21:
+	case MSM_VIDC_FMT_NV12:
+	case MSM_VIDC_FMT_NV12C:
+		alignment = 128;
+		stride = MSM_MEDIA_ALIGN(width, alignment);
+		break;
+	case MSM_VIDC_FMT_TP10C:
+		alignment = 256;
+		stride = MSM_MEDIA_ALIGN(width, 192);
+		stride = MSM_MEDIA_ALIGN(stride * 4 / 3, alignment);
+		break;
+	case MSM_VIDC_FMT_P010:
+		alignment = 256;
+		stride = MSM_MEDIA_ALIGN(width * 2, alignment);
+		break;
+	default:
+		break;
+	}
+invalid_input:
+	return stride;
+}
+
+/*
+ * Function arguments:
+ * @v4l2_fmt
+ * @width
+ * Progressive: width
+ * Interlaced: width
+ */
+static inline unsigned int video_uv_stride_pix(unsigned int colorformat,
+					       unsigned int width)
+{
+	unsigned int alignment, stride = 0;
+
+	if (!width)
+		goto invalid_input;
+
+	switch (colorformat) {
+	case MSM_VIDC_FMT_NV21:
+	case MSM_VIDC_FMT_NV12:
+	case MSM_VIDC_FMT_NV12C:
+	case MSM_VIDC_FMT_P010:
+		alignment = 128;
+		stride = MSM_MEDIA_ALIGN(width, alignment);
+		break;
+	case MSM_VIDC_FMT_TP10C:
+		alignment = 192;
+		stride = MSM_MEDIA_ALIGN(width, alignment);
+		break;
+	default:
+		break;
+	}
+invalid_input:
+	return stride;
+}
+
+/*
+ * Function arguments:
+ * @v4l2_fmt
+ * @height
+ * Progressive: height
+ * Interlaced: (height+1)>>1
+ */
+static inline unsigned int video_y_scanlines(unsigned int colorformat,
+					     unsigned int height)
+{
+	unsigned int alignment, sclines = 0;
+
+	if (!height)
+		goto invalid_input;
+
+	switch (colorformat) {
+	case MSM_VIDC_FMT_NV12:
+	case MSM_VIDC_FMT_NV21:
+	case MSM_VIDC_FMT_NV12C:
+	case MSM_VIDC_FMT_P010:
+		alignment = 32;
+		break;
+	case MSM_VIDC_FMT_TP10C:
+		alignment = 16;
+		break;
+	default:
+		return 0;
+	}
+	sclines = MSM_MEDIA_ALIGN(height, alignment);
+invalid_input:
+	return sclines;
+}
+
+/*
+ * Function arguments:
+ * @v4l2_fmt
+ * @height
+ * Progressive: height
+ * Interlaced: (height+1)>>1
+ */
+static inline unsigned int video_uv_scanlines(unsigned int colorformat,
+					      unsigned int height)
+{
+	unsigned int alignment, sclines = 0;
+
+	if (!height)
+		goto invalid_input;
+
+	switch (colorformat) {
+	case MSM_VIDC_FMT_NV21:
+	case MSM_VIDC_FMT_NV12:
+	case MSM_VIDC_FMT_TP10C:
+	case MSM_VIDC_FMT_P010:
+		alignment = 16;
+		break;
+	case MSM_VIDC_FMT_NV12C:
+		alignment = 32;
+		break;
+	default:
+		goto invalid_input;
+	}
+
+	sclines = MSM_MEDIA_ALIGN((height + 1) >> 1, alignment);
+
+invalid_input:
+	return sclines;
+}
+
+/*
+ * Function arguments:
+ * @v4l2_fmt
+ * @width
+ * Progressive: width
+ * Interlaced: width
+ */
+static inline unsigned int video_y_meta_stride(unsigned int colorformat,
+					       unsigned int width)
+{
+	int y_tile_width = 0, y_meta_stride = 0;
+
+	if (!width)
+		goto invalid_input;
+
+	switch (colorformat) {
+	case MSM_VIDC_FMT_NV12C:
+		y_tile_width = 32;
+		break;
+	case MSM_VIDC_FMT_TP10C:
+		y_tile_width = 48;
+		break;
+	default:
+		goto invalid_input;
+	}
+
+	y_meta_stride = MSM_MEDIA_ROUNDUP(width, y_tile_width);
+	y_meta_stride = MSM_MEDIA_ALIGN(y_meta_stride, 64);
+
+invalid_input:
+	return y_meta_stride;
+}
+
+/*
+ * Function arguments:
+ * @v4l2_fmt
+ * @height
+ * Progressive: height
+ * Interlaced: (height+1)>>1
+ */
+static inline unsigned int video_y_meta_scanlines(unsigned int colorformat,
+						  unsigned int height)
+{
+	int y_tile_height = 0, y_meta_scanlines = 0;
+
+	if (!height)
+		goto invalid_input;
+
+	switch (colorformat) {
+	case MSM_VIDC_FMT_NV12C:
+		y_tile_height = 8;
+		break;
+	case MSM_VIDC_FMT_TP10C:
+		y_tile_height = 4;
+		break;
+	default:
+		goto invalid_input;
+	}
+
+	y_meta_scanlines = MSM_MEDIA_ROUNDUP(height, y_tile_height);
+	y_meta_scanlines = MSM_MEDIA_ALIGN(y_meta_scanlines, 16);
+
+invalid_input:
+	return y_meta_scanlines;
+}
+
+/*
+ * Function arguments:
+ * @v4l2_fmt
+ * @width
+ * Progressive: width
+ * Interlaced: width
+ */
+static inline unsigned int video_uv_meta_stride(unsigned int colorformat,
+						unsigned int width)
+{
+	int uv_tile_width = 0, uv_meta_stride = 0;
+
+	if (!width)
+		goto invalid_input;
+
+	switch (colorformat) {
+	case MSM_VIDC_FMT_NV12C:
+		uv_tile_width = 16;
+		break;
+	case MSM_VIDC_FMT_TP10C:
+		uv_tile_width = 24;
+		break;
+	default:
+		goto invalid_input;
+	}
+
+	uv_meta_stride = MSM_MEDIA_ROUNDUP((width + 1) >> 1, uv_tile_width);
+	uv_meta_stride = MSM_MEDIA_ALIGN(uv_meta_stride, 64);
+
+invalid_input:
+	return uv_meta_stride;
+}
+
+/*
+ * Function arguments:
+ * @v4l2_fmt
+ * @height
+ * Progressive: height
+ * Interlaced: (height+1)>>1
+ */
+static inline unsigned int video_uv_meta_scanlines(unsigned int colorformat,
+						   unsigned int height)
+{
+	int uv_tile_height = 0, uv_meta_scanlines = 0;
+
+	if (!height)
+		goto invalid_input;
+
+	switch (colorformat) {
+	case MSM_VIDC_FMT_NV12C:
+		uv_tile_height = 8;
+		break;
+	case MSM_VIDC_FMT_TP10C:
+		uv_tile_height = 4;
+		break;
+	default:
+		goto invalid_input;
+	}
+
+	uv_meta_scanlines = MSM_MEDIA_ROUNDUP((height + 1) >> 1, uv_tile_height);
+	uv_meta_scanlines = MSM_MEDIA_ALIGN(uv_meta_scanlines, 16);
+
+invalid_input:
+	return uv_meta_scanlines;
+}
+
+static inline unsigned int video_rgb_stride_bytes(unsigned int colorformat,
+						  unsigned int width)
+{
+	unsigned int alignment = 0, stride = 0, bpp = 4;
+
+	if (!width)
+		goto invalid_input;
+
+	switch (colorformat) {
+	case MSM_VIDC_FMT_RGBA8888C:
+	case MSM_VIDC_FMT_RGBA8888:
+		alignment = 256;
+		break;
+	default:
+		goto invalid_input;
+	}
+
+	stride = MSM_MEDIA_ALIGN(width * bpp, alignment);
+
+invalid_input:
+	return stride;
+}
+
+static inline unsigned int video_rgb_stride_pix(unsigned int colorformat,
+						unsigned int width)
+{
+	unsigned int bpp = 4;
+
+	return video_rgb_stride_bytes(colorformat, width) / bpp;
+}
+
+static inline unsigned int video_rgb_scanlines(unsigned int colorformat,
+					       unsigned int height)
+{
+	unsigned int alignment = 0, scanlines = 0;
+
+	if (!height)
+		goto invalid_input;
+
+	switch (colorformat) {
+	case MSM_VIDC_FMT_RGBA8888C:
+		alignment = 16;
+		break;
+	case MSM_VIDC_FMT_RGBA8888:
+		alignment = 32;
+		break;
+	default:
+		goto invalid_input;
+	}
+
+	scanlines = MSM_MEDIA_ALIGN(height, alignment);
+
+invalid_input:
+	return scanlines;
+}
+
+static inline unsigned int video_rgb_meta_stride(unsigned int colorformat,
+						 unsigned int width)
+{
+	int rgb_tile_width = 0, rgb_meta_stride = 0;
+
+	if (!width)
+		goto invalid_input;
+
+	switch (colorformat) {
+	case MSM_VIDC_FMT_RGBA8888C:
+	case MSM_VIDC_FMT_RGBA8888:
+		rgb_tile_width = 16;
+		break;
+	default:
+		goto invalid_input;
+	}
+
+	rgb_meta_stride = MSM_MEDIA_ROUNDUP(width, rgb_tile_width);
+	rgb_meta_stride = MSM_MEDIA_ALIGN(rgb_meta_stride, 64);
+
+invalid_input:
+	return rgb_meta_stride;
+}
+
+static inline unsigned int video_rgb_meta_scanlines(unsigned int colorformat,
+						    unsigned int height)
+{
+	int rgb_tile_height = 0, rgb_meta_scanlines = 0;
+
+	if (!height)
+		goto invalid_input;
+
+	switch (colorformat) {
+	case MSM_VIDC_FMT_RGBA8888C:
+	case MSM_VIDC_FMT_RGBA8888:
+		rgb_tile_height = 4;
+		break;
+	default:
+		goto invalid_input;
+	}
+
+	rgb_meta_scanlines = MSM_MEDIA_ROUNDUP(height, rgb_tile_height);
+	rgb_meta_scanlines = MSM_MEDIA_ALIGN(rgb_meta_scanlines, 16);
+
+invalid_input:
+	return rgb_meta_scanlines;
+}
+
+static inline unsigned int video_buffer_size(unsigned int colorformat, unsigned int pix_width,
+					     unsigned int pix_height, unsigned int interlace)
+{
+	unsigned int size = 0;
+	unsigned int y_plane, uv_plane, y_stride,
+		uv_stride, y_sclines, uv_sclines;
+	unsigned int y_ubwc_plane = 0, uv_ubwc_plane = 0;
+	unsigned int y_meta_stride = 0, y_meta_scanlines = 0;
+	unsigned int uv_meta_stride = 0, uv_meta_scanlines = 0;
+	unsigned int y_meta_plane = 0, uv_meta_plane = 0;
+	unsigned int rgb_stride = 0, rgb_scanlines = 0;
+	unsigned int rgb_plane = 0, rgb_ubwc_plane = 0, rgb_meta_plane = 0;
+	unsigned int rgb_meta_stride = 0, rgb_meta_scanlines = 0;
+
+	if (!pix_width || !pix_height)
+		goto invalid_input;
+
+	y_stride = video_y_stride_bytes(colorformat, pix_width);
+	uv_stride = video_uv_stride_bytes(colorformat, pix_width);
+	y_sclines = video_y_scanlines(colorformat, pix_height);
+	uv_sclines = video_uv_scanlines(colorformat, pix_height);
+	rgb_stride = video_rgb_stride_bytes(colorformat, pix_width);
+	rgb_scanlines = video_rgb_scanlines(colorformat, pix_height);
+
+	switch (colorformat) {
+	case MSM_VIDC_FMT_NV21:
+	case MSM_VIDC_FMT_NV12:
+	case MSM_VIDC_FMT_P010:
+		y_plane = y_stride * y_sclines;
+		uv_plane = uv_stride * uv_sclines;
+		size = y_plane + uv_plane;
+		break;
+	case MSM_VIDC_FMT_NV12C:
+		y_meta_stride = video_y_meta_stride(colorformat, pix_width);
+		uv_meta_stride = video_uv_meta_stride(colorformat, pix_width);
+		if (!interlace && colorformat == MSM_VIDC_FMT_NV12C) {
+			y_ubwc_plane = MSM_MEDIA_ALIGN(y_stride * y_sclines, 4096);
+			uv_ubwc_plane = MSM_MEDIA_ALIGN(uv_stride * uv_sclines, 4096);
+			y_meta_scanlines =
+				video_y_meta_scanlines(colorformat, pix_height);
+			y_meta_plane = MSM_MEDIA_ALIGN(y_meta_stride * y_meta_scanlines, 4096);
+			uv_meta_scanlines =
+				video_uv_meta_scanlines(colorformat, pix_height);
+			uv_meta_plane = MSM_MEDIA_ALIGN(uv_meta_stride *
+				uv_meta_scanlines, 4096);
+			size = (y_ubwc_plane + uv_ubwc_plane + y_meta_plane +
+				uv_meta_plane);
+		} else {
+			if (pix_width <= INTERLACE_WIDTH_MAX &&
+			    pix_height <= INTERLACE_HEIGHT_MAX &&
+			    (pix_height * pix_width) / 256 <= INTERLACE_MB_PER_FRAME_MAX) {
+				y_sclines =
+					video_y_scanlines(colorformat, (pix_height + 1) >> 1);
+				y_ubwc_plane =
+					MSM_MEDIA_ALIGN(y_stride * y_sclines, 4096);
+				uv_sclines =
+					video_uv_scanlines(colorformat, (pix_height + 1) >> 1);
+				uv_ubwc_plane =
+					MSM_MEDIA_ALIGN(uv_stride * uv_sclines, 4096);
+				y_meta_scanlines =
+				video_y_meta_scanlines(colorformat, (pix_height + 1) >> 1);
+				y_meta_plane = MSM_MEDIA_ALIGN(y_meta_stride * y_meta_scanlines,
+							       4096);
+				uv_meta_scanlines =
+				video_uv_meta_scanlines(colorformat, (pix_height + 1) >> 1);
+				uv_meta_plane = MSM_MEDIA_ALIGN(uv_meta_stride *
+								uv_meta_scanlines, 4096);
+				size = (y_ubwc_plane + uv_ubwc_plane + y_meta_plane +
+					uv_meta_plane) * 2;
+			} else {
+				y_sclines = video_y_scanlines(colorformat, pix_height);
+				y_ubwc_plane =
+					MSM_MEDIA_ALIGN(y_stride * y_sclines, 4096);
+				uv_sclines = video_uv_scanlines(colorformat, pix_height);
+				uv_ubwc_plane =
+					MSM_MEDIA_ALIGN(uv_stride * uv_sclines, 4096);
+				y_meta_scanlines =
+					video_y_meta_scanlines(colorformat, pix_height);
+				y_meta_plane = MSM_MEDIA_ALIGN(y_meta_stride * y_meta_scanlines,
+							       4096);
+				uv_meta_scanlines =
+					video_uv_meta_scanlines(colorformat, pix_height);
+				uv_meta_plane = MSM_MEDIA_ALIGN(uv_meta_stride *
+					uv_meta_scanlines, 4096);
+				size = (y_ubwc_plane + uv_ubwc_plane + y_meta_plane +
+					uv_meta_plane);
+			}
+		}
+		break;
+	case MSM_VIDC_FMT_TP10C:
+		y_ubwc_plane = MSM_MEDIA_ALIGN(y_stride * y_sclines, 4096);
+		uv_ubwc_plane = MSM_MEDIA_ALIGN(uv_stride * uv_sclines, 4096);
+		y_meta_stride = video_y_meta_stride(colorformat, pix_width);
+		y_meta_scanlines = video_y_meta_scanlines(colorformat, pix_height);
+		y_meta_plane = MSM_MEDIA_ALIGN(y_meta_stride * y_meta_scanlines, 4096);
+		uv_meta_stride = video_uv_meta_stride(colorformat, pix_width);
+		uv_meta_scanlines = video_uv_meta_scanlines(colorformat, pix_height);
+		uv_meta_plane = MSM_MEDIA_ALIGN(uv_meta_stride *
+						uv_meta_scanlines, 4096);
+
+		size = y_ubwc_plane + uv_ubwc_plane + y_meta_plane +
+			uv_meta_plane;
+		break;
+	case MSM_VIDC_FMT_RGBA8888C:
+		rgb_ubwc_plane = MSM_MEDIA_ALIGN(rgb_stride * rgb_scanlines, 4096);
+		rgb_meta_stride = video_rgb_meta_stride(colorformat, pix_width);
+		rgb_meta_scanlines = video_rgb_meta_scanlines(colorformat, pix_height);
+		rgb_meta_plane = MSM_MEDIA_ALIGN(rgb_meta_stride * rgb_meta_scanlines, 4096);
+		size = rgb_ubwc_plane + rgb_meta_plane;
+		break;
+	case MSM_VIDC_FMT_RGBA8888:
+		rgb_plane = MSM_MEDIA_ALIGN(rgb_stride * rgb_scanlines, 4096);
+		size = rgb_plane;
+		break;
+	default:
+		break;
+	}
+
+invalid_input:
+	size = MSM_MEDIA_ALIGN(size, 4096);
+	return size;
+}
+
+#endif
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEDB766F39
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbjG1OTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbjG1OT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:19:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A493E47;
        Fri, 28 Jul 2023 07:19:26 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S9wAHF004457;
        Fri, 28 Jul 2023 13:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=vr5ZdLxJc4mgvFa8ZTz/SYlkacKXEtu/6e/SVjfMutk=;
 b=JU6R8XnGO03vhhLWT7Ez1kGK5Ryca+C+u3BWE56n9e1hF9JORT2xhFPY6zXlEgN7ITdB
 ZFUqkuecZ/HtKYecV715HqStYi/iTHtOGa37KLPjHNcMUq825mlwViOv0YzBVtqvDA5O
 F+gxPmtQTP3f9oa6eGnOEJZgxnkNTJ1cUEtdQltCwTXXuYFgREEjajF1pqK2/deRxRSs
 9SCaDVfhb9/bgou1hpWxKvbtwXUSO4Z8ChTBKOJx4TetYb5vdiQUKuVEs1MyQathSxjR
 fIEiqXzRWxarB/nHFJO0sedwrlsZVoI3T/pybz59bM2BM10NDKwuEC8nqQ1WfBvzHoj7 FA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s447kh7vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:26:58 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SDQvRl002980
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:26:57 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 06:26:54 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <quic_dikshita@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH 31/33] iris: variant: iris: implement the logic to compute bus bandwidth
Date:   Fri, 28 Jul 2023 18:53:42 +0530
Message-ID: <1690550624-14642-32-git-send-email-quic_vgarodia@quicinc.com>
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
X-Proofpoint-ORIG-GUID: G1YBRa91uQJ-nTaHwI1gLRiUTIyPh4Wj
X-Proofpoint-GUID: G1YBRa91uQJ-nTaHwI1gLRiUTIyPh4Wj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

This implements the logic to compute bus bandwidth required by encoder
or decoder for a specific usecase. It takes input as various video
usecase parameters as configured by clients.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 .../iris/variant/iris3/inc/perf_static_model.h     | 229 ++++++
 .../iris/variant/iris3/src/msm_vidc_bus_iris3.c    | 884 +++++++++++++++++++++
 2 files changed, 1113 insertions(+)
 create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/inc/perf_static_model.h
 create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_bus_iris3.c

diff --git a/drivers/media/platform/qcom/iris/variant/iris3/inc/perf_static_model.h b/drivers/media/platform/qcom/iris/variant/iris3/inc/perf_static_model.h
new file mode 100644
index 0000000..238f1af
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/variant/iris3/inc/perf_static_model.h
@@ -0,0 +1,229 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _PERF_STATIC_MODEL_H_
+#define _PERF_STATIC_MODEL_H_
+
+#include <linux/types.h>
+
+/* Reordered CODECS to match Bitrate Table rows */
+#define CODEC_H264_CAVLC                        0
+#define CODEC_H264                              1
+#define CODEC_HEVC                              2
+#define CODEC_VP9                               3
+
+#define CODEC_BSE_FrameFactor                   0
+#define CODEC_BSE_MBFactor                      1
+#define CODEC_BSE_LUC_SIZE                      2
+
+#define CODEC_GOP_IPP                           0
+#define CODEC_GOP_IbP                           1
+#define CODEC_GOP_I1B2b1P                       2
+#define CODEC_GOP_I3B4b1P                       3
+#define CODEC_GOP_PONLY                         4
+#define CODEC_GOP_BONLY                         6
+#define CODEC_GOP_IONLY                         7
+
+#define CODEC_ENCODER_GOP_Bb_ENTRY              0
+#define CODEC_ENCODER_GOP_P_ENTRY               1
+#define CODEC_ENCODER_GOP_FACTORY_ENTRY         2
+
+#define CODEC_ENTROPY_CODING_CAVLC              0
+#define CODEC_ENTROPY_CODING_CABAC              1
+
+#define CODEC_VSPVPP_MODE_1S                    1
+#define CODEC_VSPVPP_MODE_2S                    2
+
+#define COMP_SETTING_PWC                        0
+#define COMP_SETTING_AVG                        1
+#define COMP_SETTING_POWER                      2
+
+#define CODEC_BITDEPTH_8                        8
+#define CODEC_BITDEPTH_10                       10
+
+#define ENCODE_YUV                              0
+#define ENCODE_RGB                              1
+
+#define COMPLEXITY_PWC                          0
+#define COMPLEXITY_AVG                          1
+#define COMPLEXITY_POWER                        2
+
+#define MAX_LINE                                2048
+#ifndef VENUS_MAX_FILENAME_LENGTH
+#define VENUS_MAX_FILENAME_LENGTH               1024
+#endif
+
+#define CODEC_ENCODER                           1
+#define CODEC_DECODER                           2
+
+#define COMPLEXITY_THRESHOLD                    2
+
+enum chipset_generation {
+	MSM_SM8450,
+	MSM_SM8550,
+	MSM_MAX,
+};
+
+enum regression_mode {
+	/* ignores client set cr and bitrate settings */
+	REGRESSION_MODE_SANITY = 1,
+	/* cr and bitrate default mode */
+	REGRESSION_MODE_DEFAULT,
+	/* custom mode where client will set cr and bitrate values */
+	REGRESSION_MODE_CUSTOM,
+};
+
+/*
+ * If firmware provided motion_vector_complexity is >= 2 then set the
+ * complexity_setting as PWC (performance worst case)
+ * If the motion_vector_complexity is < 2 then set the complexity_setting
+ * as AVG (average case value)
+ */
+enum complexity_setting {
+	COMPLEXITY_SETTING_PWC = 0,
+	COMPLEXITY_SETTING_AVG = 1,
+	COMPLEXITY_SETTING_PWR = 2,
+};
+
+/*
+ * If firmware provided motion_vector_complexity is >= 2 then set the
+ * refframe_complexity as PWC (performance worst case)
+ * If the motion_vector_complexity is < 2 then set the refframe_complexity
+ * as AVG (average case value)
+ */
+enum refframe_complexity {
+	REFFRAME_COMPLEXITY_PWC = 4,
+	REFFRAME_COMPLEXITY_AVG = 2,
+	REFFRAME_COMPLEXITY_PWR = 1,
+};
+
+struct api_calculation_input {
+	/*2: decoder; 1: encoder */
+	u32 decoder_or_encoder;
+
+	/* enum chipset_generation */
+	u32 chipset_gen;
+
+	u32 codec;
+	u32 lcu_size;
+	u32 pipe_num;
+	u32 frame_rate;
+	u32 frame_width;
+	u32 frame_height;
+	u32 vsp_vpp_mode;
+	u32 entropy_coding_mode;
+	u32 hierachical_layer;
+
+	/* PWC, AVG/POWER */
+	u32 complexity_setting;
+
+	u32 status_llc_onoff;
+	u32 bitdepth;
+	u32 linear_opb;
+
+	/* AV1D FG */
+	u32 split_opb;
+
+	u32 linear_ipb;
+	u32 lossy_ipb;
+	u32 ipb_yuvrgb;
+	u32 encoder_multiref;
+	u32 bitrate_mbps;
+	u32 refframe_complexity;
+	u32 cr_ipb;
+	u32 cr_rpb;
+	u32 cr_dpb;
+	u32 cr_opb;
+	u32 regression_mode;
+
+	/* used in aurora for depth map decode */
+	u32 lumaonly_decode;
+};
+
+struct corner_voting {
+	u32 percent_lowbound;
+	u32 percent_highbound;
+};
+
+struct api_calculation_freq_output {
+	u32 vpp_min_freq;
+	u32 vsp_min_freq;
+	u32 tensilica_min_freq;
+	u32 hw_min_freq;
+	u32 enc_hqmode;
+	struct corner_voting usecase_corner;
+};
+
+struct api_calculation_bw_output {
+	u32 vsp_read_noc;
+	u32 vsp_write_noc;
+	u32 vsp_read_ddr;
+	u32 vsp_write_ddr;
+	u32 vsp_rd_wr_total_noc;
+	u32 vsp_rd_wr_total_ddr;
+
+	u32 collocated_rd_noc;
+	u32 collocated_wr_noc;
+	u32 collocated_rd_ddr;
+	u32 collocated_wr_ddr;
+	u32 collocated_rd_wr_total_noc;
+	u32 collocated_rd_wr_total_ddr;
+
+	u32 dpb_rd_y_noc;
+	u32 dpb_rd_crcb_noc;
+	u32 dpb_rdwr_duetooverlap_noc;
+	u32 dpb_wr_noc;
+	u32 dpb_rd_y_ddr;
+	u32 dpb_rd_crcb_ddr;
+	u32 dpb_rdwr_duetooverlap_ddr;
+	u32 dpb_wr_ddr;
+	u32 dpb_rd_wr_total_noc;
+	u32 dpb_rd_wr_total_ddr;
+
+	u32 opb_write_total_noc;
+	u32 opb_write_total_ddr;
+
+	u32 ipb_rd_total_noc;
+	u32 ipb_rd_total_ddr;
+
+	u32 bse_tlb_rd_noc;
+	u32 bse_tlb_wr_noc;
+	u32 bse_tlb_rd_ddr;
+	u32 bse_tlb_wr_ddr;
+	u32 bse_rd_wr_total_noc;
+	u32 bse_rd_wr_total_ddr;
+
+	u32 statistics_rd_noc;
+	u32 statistics_wr_noc;
+	u32 statistics_rd_ddr;
+	u32 statistics_wr_ddr;
+
+	u32 mmu_rd_noc;
+	u32 mmu_rd_ddr;
+
+	u32 noc_bw_rd;
+	u32 noc_bw_wr;
+	u32 ddr_bw_rd;
+	u32 ddr_bw_wr;
+
+	/* llc BW components for aurora */
+	u32 dpb_rd_y_llc;
+	u32 dpb_rd_crcb_llc;
+	u32 dpb_wr_llc;
+	u32 bse_tlb_rd_llc;
+	u32 bse_tlb_wr_llc;
+	u32 vsp_read_llc;
+	u32 vsp_write_llc;
+
+	u32 llc_bw_rd;
+	u32 llc_bw_wr;
+};
+
+int msm_vidc_calculate_frequency(struct api_calculation_input codec_input,
+				 struct api_calculation_freq_output *codec_output);
+int msm_vidc_calculate_bandwidth(struct api_calculation_input codec_input,
+				 struct api_calculation_bw_output *codec_output);
+
+#endif /*_PERF_STATIC_MODEL_H_ */
diff --git a/drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_bus_iris3.c b/drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_bus_iris3.c
new file mode 100644
index 0000000..92aa995
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_bus_iris3.c
@@ -0,0 +1,884 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "msm_vidc_debug.h"
+#include "perf_static_model.h"
+
+/* 100x */
+static u32 dpbopb_ubwc30_cr_table_cratio_iris3[7][12] = {
+	{237, 399, 272, 137, 225, 158, 185, 259, 203, 138, 167, 152},
+	{269, 404, 302, 202, 367, 238, 210, 299, 232, 134, 181, 149},
+	{269, 404, 302, 202, 367, 238, 210, 299, 232, 134, 181, 149},
+	{269, 404, 302, 202, 367, 238, 210, 299, 232, 134, 181, 149},
+	{237, 399, 272, 137, 225, 158, 185, 259, 203, 138, 167, 152},
+	{269, 404, 302, 202, 367, 238, 210, 299, 232, 134, 181, 149},
+	{269, 404, 302, 202, 367, 238, 210, 299, 232, 134, 181, 149},
+};
+
+/* 100x */
+static u32 rpb_ubwc30_cr_table_cratio_iris3[7][12] = {
+	{193, 294, 218, 135, 214, 155, 175, 241, 191, 139, 162, 149},
+	{285, 406, 316, 207, 373, 243, 201, 280, 221, 139, 177, 152},
+	{285, 406, 316, 207, 373, 243, 201, 280, 221, 139, 177, 152},
+	{285, 406, 316, 207, 373, 243, 201, 280, 221, 139, 177, 152},
+	{193, 294, 218, 135, 214, 155, 175, 241, 191, 139, 162, 149},
+	{285, 406, 316, 207, 373, 243, 201, 280, 221, 139, 177, 152},
+	{285, 406, 316, 207, 373, 243, 201, 280, 221, 139, 177, 152},
+};
+
+/* 100x */
+static u32 ipblossy_ubwc30_cr_table_cratio_iris3[7][12] = {
+	{215, 215, 215, 174, 174, 174, 266, 266, 266, 231, 231, 231},
+	{254, 254, 254, 219, 219, 219, 292, 292, 292, 249, 249, 249},
+	{254, 254, 254, 219, 219, 219, 292, 292, 292, 249, 249, 249},
+	{254, 254, 254, 219, 219, 219, 292, 292, 292, 249, 249, 249},
+	{215, 215, 215, 174, 174, 174, 266, 266, 266, 231, 231, 231},
+	{254, 254, 254, 219, 219, 219, 292, 292, 292, 249, 249, 249},
+	{254, 254, 254, 219, 219, 219, 292, 292, 292, 249, 249, 249},
+};
+
+/* 100x */
+static u32 ipblossless_ubwc30_cr_table_cratio_iris3[7][12] = {
+	{185, 215, 194, 147, 178, 159, 162, 181, 169, 138, 161, 146},
+	{186, 217, 195, 151, 183, 161, 164, 182, 170, 140, 168, 148},
+	{186, 217, 195, 151, 183, 161, 164, 182, 170, 140, 168, 148},
+	{186, 217, 195, 151, 183, 161, 164, 182, 170, 140, 168, 148},
+	{185, 215, 194, 147, 178, 159, 162, 181, 169, 138, 161, 146},
+	{186, 217, 195, 151, 183, 161, 164, 182, 170, 140, 168, 148},
+	{186, 217, 195, 151, 183, 161, 164, 182, 170, 140, 168, 148},
+};
+
+/* 100x */
+static u32 en_original_compression_factor_rgba_pwd_iris3 = 243;
+/* 100x */
+static u32 en_original_compression_factor_rgba_avg_iris3 = 454;
+
+/*                                H   I   J         K   L   M      N   O   P
+ *         TotalW   Total R       Frequency         Write         Read
+ * Name                           B   b   P         B   b   P      B   b   P
+ * I3B4b1P    0.5    1.875        3   4   1         1   0   1      2   2   1
+ * I1B2b1P    0.5    1.75         1   2   1         1   0   1      2   2   1
+ * IbP        0.5    1.5          0   1   1         1   0   1      2   2   1
+ * IPP        1      1            0   0   1         1   0   1      2   2   1
+ * P          1      1            0   0   1         1   0   1      2   2   1
+ * smallB     0      2            0   1   0         1   0   1      2   2   1
+ * bigB       1      2            1   0   0         1   0   1      2   2   1
+ *
+ * Total W = SUMPRODUCT(H16:J16, K16 : M16) / SUM(H16:J16)
+ * Total R = SUMPRODUCT(H16:J16, N16 : P16) / SUM(H16:J16)
+ */
+
+/* 1000x */
+static u32 iris3_en_readfactor[7] = {1000, 1500, 1750, 1875, 1000, 2000, 2000};
+/* 1000x */
+static u32 iris3_en_writefactor[7] = {1000, 500, 500, 500, 1000, 0, 1000};
+static u32 iris3_en_frame_num_parallel = 1;
+
+u32 calculate_number_lcus_iris3(u32 width, u32 height, u32 lcu_size)
+{
+	u32 mbs_width = (width % lcu_size) ?
+		(width / lcu_size + 1) : (width / lcu_size);
+	u32 mbs_height = (height % lcu_size) ?
+		(height / lcu_size + 1) : (height / lcu_size);
+
+	return mbs_width * mbs_height;
+}
+
+u32 calculate_number_ubwctiles_iris3(u32 width, u32 height, u32 tile_w, u32 tile_h)
+{
+	u32 tiles_width = (width % tile_w) ?
+		(width / tile_w + 1) : (width / tile_w);
+	u32 tiles_height = (height % tile_h) ?
+		(height / tile_h + 1) : (height / tile_h);
+
+	return tiles_width * tiles_height;
+}
+
+struct compression_factors {
+	u32 dpb_cf_y;
+	u32 dpb_cf_cbcr;
+	u32 opb_cf_ycbcr;
+	u32 dpb_cr_y;
+	u32 ipb_cr_y;
+	u32 ipb_cr;
+} compression_factor;
+
+u32 get_compression_factors(struct compression_factors *compression_factor,
+			    struct api_calculation_input codec_input)
+{
+	u8 cr_index_entry, cr_index_y, cr_index_c, cr_index_uni;
+	u32 frame_width;
+	u32 frame_height;
+
+	frame_width = codec_input.frame_width;
+	frame_height = codec_input.frame_height;
+	if (frame_width * frame_height <= 1920 * 1080)
+		cr_index_entry = 0;
+	else
+		cr_index_entry = 1;
+
+	if (codec_input.bitdepth == CODEC_BITDEPTH_8) {
+		/* NOT PWC or average and power case */
+		if (codec_input.complexity_setting != 0) {
+			cr_index_y = 0;
+			cr_index_c = 1;
+			cr_index_uni = 2;
+		} else {
+			cr_index_y = 3;
+			cr_index_c = 4;
+			cr_index_uni = 5;
+		}
+	} else {
+		/* NOT PWC or average and power case */
+		if (codec_input.complexity_setting != 0) {
+			cr_index_y = 6;
+			cr_index_c = 7;
+			cr_index_uni = 8;
+		} else {
+			cr_index_y = 9;
+			cr_index_c = 10;
+			cr_index_uni = 11;
+		}
+	}
+
+	if (codec_input.decoder_or_encoder == CODEC_DECODER) {
+		compression_factor->dpb_cf_y =
+			dpbopb_ubwc30_cr_table_cratio_iris3[cr_index_entry][cr_index_y];
+		compression_factor->dpb_cf_cbcr =
+			dpbopb_ubwc30_cr_table_cratio_iris3[cr_index_entry][cr_index_c];
+		compression_factor->opb_cf_ycbcr =
+			dpbopb_ubwc30_cr_table_cratio_iris3[cr_index_entry][cr_index_uni];
+
+		if (codec_input.regression_mode == 3 &&
+		    /* input cr numbers from interface */
+		    (codec_input.cr_dpb != 0 || codec_input.cr_opb != 0)) {
+			compression_factor->dpb_cf_y = (u32)(codec_input.cr_dpb * 100);
+			compression_factor->dpb_cf_cbcr = (u32)(codec_input.cr_dpb * 100);
+			compression_factor->opb_cf_ycbcr = (u32)(codec_input.cr_opb * 100);
+		}
+	} else { /* encoder */
+		/*
+		 * IPB CR Table Choice; static sheet (if framewidth<3840, use lossless table)
+		 * (else, use lossy table)
+		 * stick to this choice for SW purpose (no change for SW)
+		 */
+		if (frame_width < 3840) {
+			compression_factor->ipb_cr =
+				ipblossless_ubwc30_cr_table_cratio_iris3
+				[cr_index_entry][cr_index_uni];
+			compression_factor->ipb_cr_y =
+				ipblossless_ubwc30_cr_table_cratio_iris3
+				[cr_index_entry][cr_index_y];
+		} else {
+			compression_factor->ipb_cr =
+				ipblossy_ubwc30_cr_table_cratio_iris3[cr_index_entry]
+				[cr_index_uni];
+			compression_factor->ipb_cr_y =
+				ipblossy_ubwc30_cr_table_cratio_iris3[cr_index_entry]
+				[cr_index_y];
+		}
+
+		compression_factor->dpb_cf_y =
+			rpb_ubwc30_cr_table_cratio_iris3[cr_index_entry][cr_index_y];
+
+		compression_factor->dpb_cf_cbcr =
+			rpb_ubwc30_cr_table_cratio_iris3[cr_index_entry][cr_index_c];
+
+		if (codec_input.regression_mode == 3 &&
+		    /* input cr from interface */
+		    (codec_input.cr_ipb != 0 || codec_input.cr_rpb != 0)) {
+			compression_factor->dpb_cf_y = (u32)(codec_input.cr_rpb * 100);
+			compression_factor->dpb_cf_cbcr = (u32)(codec_input.cr_rpb * 100);
+			compression_factor->ipb_cr_y = (u32)(codec_input.cr_ipb * 100);
+		}
+	}
+
+	return 0;
+}
+
+static int calculate_bandwidth_decoder_iris3(struct api_calculation_input codec_input,
+					     struct api_calculation_bw_output *codec_output)
+{
+	/* common control parameters */
+	u32 frame_width;
+	u32 frame_height;
+	u32 frame_lcu_size = 16; /* initialized to h264 */
+	u32 lcu_per_frame;
+	u32 target_bitrate;
+	u32 collocated_bytes_per_lcu = 16; /* initialized to h264 */
+
+	u32 frame420_y_bw_linear_8bpp;
+	u32 frame420_y_bw_no_ubwc_tile_10bpp;
+	u32 frame420_y_bw_linear_10bpp;
+
+	u16 ubwc_tile_w;
+	u16 ubwc_tile_h;
+
+	u32 dpb_compression_factor_y;
+	u32 dpb_compression_factor_cbcr;
+
+	u32 reconstructed_write_bw_factor_rd;
+	u32 reference_y_read_bw_factor;
+	u32 reference_cbcr_read_bw_factor;
+
+	/* decoder control parameters */
+	u32 decoder_vsp_read_factor = 6;
+	u32 bins_to_bits_factor = 4;
+
+	u32 dpb_to_opb_ratios_ds = 1;
+
+	u8 llc_enabled_ref_y_rd = 1;
+	u8 llc_enable_ref_crcb_rd = 1;
+	u8 llc_enabled_bse_tlb = 1;
+	/* this is for 2pipe and 1pipe LLC */
+
+	u32 opb_compression_factor_ycbcr;
+	u32 dpb_ubwc_tile_width_pixels;
+	u32 dpb_ubwc_tile_height_pixels;
+	u32 decoder_frame_complexity_factor;
+	u32 llc_saving = 130; /* Initialized to H264 */
+
+	u32 bse_tlb_byte_per_lcu = 0;
+
+	u32 large_bw_calculation_fp = 0;
+
+	llc_enabled_ref_y_rd = (codec_input.status_llc_onoff) ? 1 : 0;
+	llc_enable_ref_crcb_rd = (codec_input.status_llc_onoff) ? 1 : 0;
+	/* H265D BSE tlb in LLC will be pored in Kailua */
+	llc_enabled_bse_tlb = (codec_input.status_llc_onoff) ? 1 : 0;
+
+	frame_width = codec_input.frame_width;
+	frame_height = codec_input.frame_height;
+	if (codec_input.codec == CODEC_H264 ||
+	    codec_input.codec == CODEC_H264_CAVLC) {
+		frame_lcu_size = 16;
+		collocated_bytes_per_lcu = 16;
+		llc_saving = 130;
+	} else if (codec_input.codec == CODEC_HEVC) {
+		if (codec_input.lcu_size == 32) {
+			frame_lcu_size = 32;
+			collocated_bytes_per_lcu = 64;
+			llc_saving = 114;
+		} else if (codec_input.lcu_size == 64) {
+			frame_lcu_size = 64;
+			collocated_bytes_per_lcu = 256;
+			llc_saving = 107;
+		}
+	} else if (codec_input.codec == CODEC_VP9) {
+		if (codec_input.lcu_size == 32) {
+			frame_lcu_size = 32;
+			collocated_bytes_per_lcu = 64;
+			llc_saving = 114;
+		} else if (codec_input.lcu_size == 64) {
+			frame_lcu_size = 64;
+			collocated_bytes_per_lcu = 256;
+			llc_saving = 107;
+		}
+	}
+
+	lcu_per_frame =
+		calculate_number_lcus_iris3(frame_width, frame_height, frame_lcu_size);
+
+	target_bitrate = (u32)(codec_input.bitrate_mbps); /* Mbps */
+
+	ubwc_tile_w = (codec_input.bitdepth == CODEC_BITDEPTH_8) ? 32 : 48;
+	ubwc_tile_h = (codec_input.bitdepth == CODEC_BITDEPTH_8) ? 8 : 4;
+
+	frame420_y_bw_linear_8bpp =
+		((calculate_number_ubwctiles_iris3(frame_width, frame_height, 32, 8) *
+		256 * codec_input.frame_rate + 999) / 1000 + 999) / 1000;
+
+	frame420_y_bw_no_ubwc_tile_10bpp =
+		((calculate_number_ubwctiles_iris3(frame_width, frame_height, 48, 4) *
+		256 * codec_input.frame_rate + 999) / 1000 + 999) / 1000;
+	frame420_y_bw_linear_10bpp = ((frame_width * frame_height *
+		codec_input.frame_rate * 2 + 999) / 1000 + 999) / 1000;
+
+	/* TODO Integrate Compression Ratio returned by FW */
+	get_compression_factors(&compression_factor, codec_input);
+	dpb_compression_factor_y = compression_factor.dpb_cf_y;
+	dpb_compression_factor_cbcr = compression_factor.dpb_cf_cbcr;
+	opb_compression_factor_ycbcr = compression_factor.opb_cf_ycbcr;
+
+	dpb_ubwc_tile_width_pixels = ubwc_tile_w;
+
+	dpb_ubwc_tile_height_pixels = ubwc_tile_h;
+
+	decoder_frame_complexity_factor =
+		(codec_input.complexity_setting == 0) ?
+		400 : ((codec_input.complexity_setting == 1) ? 266 : 100);
+
+	reconstructed_write_bw_factor_rd = (codec_input.complexity_setting == 0) ?
+		105 : 100;
+
+	reference_y_read_bw_factor = llc_saving;
+
+	reference_cbcr_read_bw_factor = llc_saving;
+
+	if (codec_input.codec == CODEC_HEVC) {
+		if (codec_input.lcu_size == 32)
+			bse_tlb_byte_per_lcu = 64;
+		else if (codec_input.lcu_size == 16)
+			bse_tlb_byte_per_lcu = 32;
+		else
+			bse_tlb_byte_per_lcu = 128;
+	} else if ((codec_input.codec == CODEC_H264) ||
+		(codec_input.codec == CODEC_H264_CAVLC)) {
+		bse_tlb_byte_per_lcu = 64;
+	} else if (codec_input.codec == CODEC_VP9) {
+		bse_tlb_byte_per_lcu = 304;
+	}
+
+	codec_output->noc_bw_rd = 0;
+	codec_output->noc_bw_wr = 0;
+	codec_output->ddr_bw_rd = 0;
+	codec_output->ddr_bw_wr = 0;
+
+	large_bw_calculation_fp = 0;
+	large_bw_calculation_fp = ((target_bitrate *
+		decoder_vsp_read_factor + 7) / 8);
+
+	codec_output->vsp_read_noc = large_bw_calculation_fp;
+
+	codec_output->vsp_read_ddr = codec_output->vsp_read_noc;
+
+	large_bw_calculation_fp = ((target_bitrate *
+		bins_to_bits_factor + 7) / 8);
+
+	codec_output->vsp_write_noc = large_bw_calculation_fp;
+	codec_output->vsp_write_ddr = codec_output->vsp_write_noc;
+
+	/* accumulation */
+	codec_output->noc_bw_rd += codec_output->vsp_read_noc;
+	codec_output->ddr_bw_rd += codec_output->vsp_read_ddr;
+	codec_output->noc_bw_wr += codec_output->vsp_write_noc;
+	codec_output->ddr_bw_wr += codec_output->vsp_write_ddr;
+
+	large_bw_calculation_fp = 0;
+	large_bw_calculation_fp = ((collocated_bytes_per_lcu *
+		lcu_per_frame * codec_input.frame_rate + 999) / 1000 + 999) / 1000;
+	codec_output->collocated_rd_noc = large_bw_calculation_fp;
+	codec_output->collocated_wr_noc = codec_output->collocated_rd_noc;
+	codec_output->collocated_rd_ddr = codec_output->collocated_rd_noc;
+	codec_output->collocated_wr_ddr = codec_output->collocated_wr_noc;
+
+	codec_output->collocated_rd_wr_total_noc =
+		(u32)(codec_output->collocated_rd_noc + codec_output->collocated_wr_noc);
+
+	codec_output->collocated_rd_wr_total_ddr =
+		codec_output->collocated_rd_wr_total_noc;
+
+	/* accumulation */
+	codec_output->noc_bw_rd += codec_output->collocated_rd_noc;
+	codec_output->noc_bw_wr += codec_output->collocated_wr_noc;
+	codec_output->ddr_bw_rd += codec_output->collocated_rd_ddr;
+	codec_output->ddr_bw_wr += codec_output->collocated_wr_ddr;
+
+	large_bw_calculation_fp = 0;
+	large_bw_calculation_fp = ((codec_input.bitdepth == CODEC_BITDEPTH_8) ?
+		frame420_y_bw_linear_8bpp :
+		frame420_y_bw_no_ubwc_tile_10bpp) * decoder_frame_complexity_factor;
+
+	large_bw_calculation_fp =
+		(large_bw_calculation_fp + dpb_compression_factor_y - 1) /
+		dpb_compression_factor_y;
+
+	codec_output->dpb_rd_y_noc = large_bw_calculation_fp;
+
+	large_bw_calculation_fp = ((codec_input.bitdepth == CODEC_BITDEPTH_8) ?
+		frame420_y_bw_linear_8bpp : frame420_y_bw_no_ubwc_tile_10bpp) *
+		decoder_frame_complexity_factor;
+
+	large_bw_calculation_fp =
+		(large_bw_calculation_fp + dpb_compression_factor_cbcr - 1) /
+		dpb_compression_factor_cbcr / 2;
+
+	codec_output->dpb_rd_crcb_noc = large_bw_calculation_fp;
+	codec_output->dpb_rdwr_duetooverlap_noc = 0;
+
+	large_bw_calculation_fp = ((codec_input.bitdepth == CODEC_BITDEPTH_8) ?
+		frame420_y_bw_linear_8bpp : frame420_y_bw_no_ubwc_tile_10bpp) *
+		reconstructed_write_bw_factor_rd;
+
+	large_bw_calculation_fp = ((codec_input.bitdepth == CODEC_BITDEPTH_8) ?
+		frame420_y_bw_linear_8bpp : frame420_y_bw_no_ubwc_tile_10bpp) *
+		reconstructed_write_bw_factor_rd;
+
+	large_bw_calculation_fp = large_bw_calculation_fp *
+		(dpb_compression_factor_y / 2 + dpb_compression_factor_cbcr);
+
+	large_bw_calculation_fp = (large_bw_calculation_fp + dpb_compression_factor_y - 1) /
+		dpb_compression_factor_y;
+
+	large_bw_calculation_fp =
+		(large_bw_calculation_fp + dpb_compression_factor_cbcr - 1) /
+		dpb_compression_factor_cbcr;
+
+	codec_output->dpb_wr_noc = large_bw_calculation_fp;
+
+	codec_output->dpb_rd_y_ddr = (llc_enabled_ref_y_rd) ?
+		((codec_output->dpb_rd_y_noc * 100 + reference_y_read_bw_factor - 1) /
+		reference_y_read_bw_factor) : codec_output->dpb_rd_y_noc;
+
+	codec_output->dpb_rd_crcb_ddr = (llc_enable_ref_crcb_rd) ?
+		((codec_output->dpb_rd_crcb_noc * 100 +
+		reference_cbcr_read_bw_factor - 1) /
+		reference_cbcr_read_bw_factor) : codec_output->dpb_rd_crcb_noc;
+
+	codec_output->dpb_rdwr_duetooverlap_ddr = 0;
+	codec_output->dpb_wr_ddr = codec_output->dpb_wr_noc;
+
+	/* accumulation */
+	codec_output->noc_bw_rd += codec_output->dpb_rd_y_noc;
+	codec_output->noc_bw_rd += codec_output->dpb_rd_crcb_noc;
+	codec_output->noc_bw_rd += codec_output->dpb_rdwr_duetooverlap_noc;
+	codec_output->noc_bw_wr += codec_output->dpb_wr_noc;
+	codec_output->ddr_bw_rd += codec_output->dpb_rd_y_ddr;
+	codec_output->ddr_bw_rd += codec_output->dpb_rd_crcb_ddr;
+	codec_output->ddr_bw_rd += codec_output->dpb_rdwr_duetooverlap_ddr;
+	codec_output->ddr_bw_wr += codec_output->dpb_wr_ddr;
+
+	if (codec_input.linear_opb || codec_input.split_opb) {
+		if (codec_input.linear_opb) {
+			if (codec_input.bitdepth == CODEC_BITDEPTH_8) {
+				large_bw_calculation_fp = ((frame420_y_bw_linear_8bpp) *
+				3 / 2 / dpb_to_opb_ratios_ds);
+
+				codec_output->opb_write_total_noc = large_bw_calculation_fp;
+			} else {
+				large_bw_calculation_fp = ((frame420_y_bw_linear_10bpp) *
+				3 / 2 / dpb_to_opb_ratios_ds);
+
+				codec_output->opb_write_total_noc = large_bw_calculation_fp;
+			}
+		} else { /* (CODEC_INPUT.split_opb) */
+			if (codec_input.bitdepth == CODEC_BITDEPTH_8) {
+				large_bw_calculation_fp =
+					(frame420_y_bw_linear_8bpp * 3 / 2 / dpb_to_opb_ratios_ds *
+					100 + opb_compression_factor_ycbcr - 1) /
+					opb_compression_factor_ycbcr;
+
+				codec_output->opb_write_total_noc = large_bw_calculation_fp;
+			} else {
+				large_bw_calculation_fp =
+					(frame420_y_bw_no_ubwc_tile_10bpp * 3 / 2 /
+					dpb_to_opb_ratios_ds * 100 +
+					opb_compression_factor_ycbcr - 1) /
+					opb_compression_factor_ycbcr;
+
+				codec_output->opb_write_total_noc = large_bw_calculation_fp;
+			}
+		}
+	} else {
+		codec_output->opb_write_total_noc = 0;
+	}
+
+	codec_output->opb_write_total_ddr = codec_output->opb_write_total_noc;
+
+	/* accumulation */
+	codec_output->noc_bw_wr += codec_output->opb_write_total_noc;
+	codec_output->ddr_bw_wr += codec_output->opb_write_total_ddr;
+
+	large_bw_calculation_fp = ((bse_tlb_byte_per_lcu * lcu_per_frame *
+		codec_input.frame_rate + 999) / 1000 + 999) / 1000;
+
+	codec_output->bse_tlb_rd_noc = large_bw_calculation_fp;
+
+	if (llc_enabled_bse_tlb)
+		codec_output->bse_tlb_rd_ddr = 0;
+	else
+		codec_output->bse_tlb_rd_ddr = codec_output->bse_tlb_rd_noc;
+
+	codec_output->bse_tlb_wr_noc = codec_output->bse_tlb_rd_noc;
+
+	if (llc_enabled_bse_tlb)
+		codec_output->bse_tlb_wr_ddr = 0;
+	else
+		codec_output->bse_tlb_wr_ddr = codec_output->bse_tlb_wr_noc;
+
+	/* accumulation */
+	codec_output->noc_bw_rd += codec_output->bse_tlb_rd_noc;
+	codec_output->ddr_bw_rd += codec_output->bse_tlb_rd_ddr;
+	codec_output->noc_bw_wr += codec_output->bse_tlb_wr_noc;
+	codec_output->ddr_bw_wr += codec_output->bse_tlb_wr_ddr;
+
+	codec_output->mmu_rd_ddr = 0;
+	codec_output->mmu_rd_noc = 0;
+	/* accumulation */
+	codec_output->noc_bw_rd += codec_output->mmu_rd_noc;
+	codec_output->ddr_bw_rd += codec_output->mmu_rd_ddr;
+
+	return 0;
+}
+
+static int calculate_bandwidth_encoder_iris3(struct api_calculation_input codec_input,
+					     struct api_calculation_bw_output *codec_output)
+{
+	/* common control parameters */
+	u32 frame_width;
+	u32 frame_height;
+	u32 frame_lcu_size;
+	u32 lcu_per_frame;
+	u32 target_bitrate;
+	u32 collocated_bytes_per_lcu;
+
+	u32 frame420_y_bw_linear_8bpp;
+	u32 frame420_y_bw_no_ubwc_tile_10bpp;
+	u32 frame420_y_bw_linear_10bpp;
+
+	u16 ubwc_tile_w;
+	u16 ubwc_tile_h;
+
+	u32 dpb_compression_factor_y;
+	u32 dpb_compression_factor_cbcr;
+
+	u32 reconstructed_write_bw_factor_rd;
+	u32 reference_y_read_bw_factor;
+	u32 reference_crcb_read_bw_factor;
+
+	/* encoder control parameters */
+	u32 en_vertical_tiles_width = 960;
+
+	u8 en_rotation_90_270 = 0;
+	/* TODO Can we use (codec_input.status_llc_onoff) for enc_llc_*? */
+	u8 en_llc_enable_ref_rd_crcb = 0;
+	u8 en_llc_enable_rec_wr_uncompleted = 0;
+	u8 en_llc_enable_ref_rd_y_overlap = 0;
+
+	u32 en_bins_to_bits_factor = 4;
+	u32 en_search_windows_size_horizontal = 96;
+
+	u32 en_tile_number;
+	u32 ipb_compression_factor_y;
+	u32 ipb_compression_factor;
+
+	u32 large_bw_calculation_fp = 0;
+
+	/* TODO Are these really needed in Encoder? */
+	u32 bse_tlb_byte_per_lcu = 0;
+	u8 llc_enabled_bse_tlb = 1;
+
+	/*H265D BSE tlb in LLC will be pored in Kailua */
+	llc_enabled_bse_tlb = (codec_input.status_llc_onoff) ? 1 : 0;
+
+	frame_width = codec_input.frame_width;
+	frame_height = codec_input.frame_height;
+	if (codec_input.codec == CODEC_H264 ||
+	    codec_input.codec == CODEC_H264_CAVLC) {
+		frame_lcu_size = 16;
+		collocated_bytes_per_lcu = 16;
+	} else if (codec_input.codec == CODEC_HEVC) {
+		frame_lcu_size = 32;
+		collocated_bytes_per_lcu = 64;
+	} else {
+		/* TODO What is the value for VP9 ? */
+		frame_lcu_size = 16;
+		collocated_bytes_per_lcu = 16; /* TODO Fixes Uninitialized compilation error. */
+	}
+
+	lcu_per_frame =
+		calculate_number_lcus_iris3(frame_width, frame_height, frame_lcu_size);
+
+	bse_tlb_byte_per_lcu = 16; /* TODO Should be in common declaration */
+
+	target_bitrate = (u32)(codec_input.bitrate_mbps); /* Mbps */
+
+	ubwc_tile_w = (codec_input.bitdepth == CODEC_BITDEPTH_8) ? 32 : 48;
+	ubwc_tile_h = (codec_input.bitdepth == CODEC_BITDEPTH_8) ? 8 : 4;
+
+	/* yuv */
+	if (codec_input.ipb_yuvrgb == 0) {
+		frame420_y_bw_linear_8bpp =
+			((calculate_number_ubwctiles_iris3(frame_width, frame_height,
+			32, 8) * 256 * codec_input.frame_rate + 999) / 1000 + 999) / 1000;
+	} else { /* RGBA */
+		frame420_y_bw_linear_8bpp =
+			((calculate_number_ubwctiles_iris3(frame_width, frame_height,
+			6, 4) * 256 * codec_input.frame_rate + 999) / 1000 + 999) / 1000;
+	}
+
+	frame420_y_bw_no_ubwc_tile_10bpp =
+		((calculate_number_ubwctiles_iris3(frame_width, frame_height, 48, 4) *
+		256 * codec_input.frame_rate + 999) / 1000 + 999) / 1000;
+
+	frame420_y_bw_linear_10bpp = ((frame_width * frame_height *
+		codec_input.frame_rate * 2 + 999) / 1000 + 999) / 1000;
+
+	/* TODO Integrate Compression Ratio returned by FW */
+	get_compression_factors(&compression_factor, codec_input);
+	dpb_compression_factor_y = compression_factor.dpb_cf_y;
+	dpb_compression_factor_cbcr = compression_factor.dpb_cf_cbcr;
+	ipb_compression_factor_y = compression_factor.ipb_cr_y;
+	ipb_compression_factor = compression_factor.ipb_cr;
+
+	en_tile_number = (frame_width % en_vertical_tiles_width) ?
+		((frame_width / en_vertical_tiles_width) + 1) :
+		(frame_width / en_vertical_tiles_width);
+
+	en_tile_number = en_tile_number * 100;
+
+	/* ceil is same as excel roundup (float, 0); */
+	reconstructed_write_bw_factor_rd = ((en_tile_number - 100) * 2 *
+		((codec_input.lcu_size + ubwc_tile_w - 1) / ubwc_tile_w) *
+		ubwc_tile_w + (frame_width - 1)) / (frame_width) + 100;
+
+	reference_y_read_bw_factor = ((en_tile_number - 100) * 2 *
+		((en_search_windows_size_horizontal + ubwc_tile_w - 1) / ubwc_tile_w) *
+		ubwc_tile_w + (frame_width - 1)) / frame_width + 100;
+
+	reference_crcb_read_bw_factor = 150;
+
+	codec_output->noc_bw_rd = 0;
+	codec_output->noc_bw_wr = 0;
+	codec_output->ddr_bw_rd = 0;
+	codec_output->ddr_bw_wr = 0;
+
+	large_bw_calculation_fp = (target_bitrate * en_bins_to_bits_factor + 7) / 8;
+	codec_output->vsp_read_noc = large_bw_calculation_fp;
+	codec_output->vsp_read_ddr = codec_output->vsp_read_noc;
+	large_bw_calculation_fp = (target_bitrate + 7) / 8;
+
+	codec_output->vsp_write_noc = codec_output->vsp_read_noc +
+		large_bw_calculation_fp;
+
+	codec_output->vsp_write_ddr = codec_output->vsp_write_noc;
+
+	/* accumulation */
+	codec_output->noc_bw_rd += codec_output->vsp_read_noc;
+	codec_output->ddr_bw_rd += codec_output->vsp_read_ddr;
+	codec_output->noc_bw_wr += codec_output->vsp_write_noc;
+	codec_output->ddr_bw_wr += codec_output->vsp_write_ddr;
+
+	large_bw_calculation_fp = ((collocated_bytes_per_lcu * lcu_per_frame *
+		codec_input.frame_rate + 999) / 1000 + 999) / 1000;
+
+	codec_output->collocated_rd_noc = large_bw_calculation_fp;
+	codec_output->collocated_wr_noc = codec_output->collocated_rd_noc;
+	codec_output->collocated_rd_ddr = codec_output->collocated_rd_noc;
+	codec_output->collocated_wr_ddr = codec_output->collocated_wr_noc;
+
+	codec_output->collocated_rd_wr_total_noc =
+		(u32)(codec_output->collocated_rd_noc + codec_output->collocated_wr_noc);
+	codec_output->collocated_rd_wr_total_ddr =
+		codec_output->collocated_rd_wr_total_noc;
+
+	/* accumulation */
+	codec_output->noc_bw_rd += codec_output->collocated_rd_noc;
+	codec_output->noc_bw_wr += codec_output->collocated_wr_noc;
+	codec_output->ddr_bw_rd += codec_output->collocated_rd_ddr;
+	codec_output->ddr_bw_wr += codec_output->collocated_wr_ddr;
+
+	large_bw_calculation_fp = 0;
+
+	large_bw_calculation_fp = ((codec_input.bitdepth == CODEC_BITDEPTH_8) ?
+		frame420_y_bw_linear_8bpp :
+		frame420_y_bw_no_ubwc_tile_10bpp) * reference_y_read_bw_factor;
+
+	large_bw_calculation_fp = (large_bw_calculation_fp *
+		iris3_en_readfactor[codec_input.hierachical_layer]);
+
+	large_bw_calculation_fp = (large_bw_calculation_fp +
+		dpb_compression_factor_y - 1) / dpb_compression_factor_y;
+
+	large_bw_calculation_fp = (large_bw_calculation_fp + 999) / 1000;
+
+	codec_output->dpb_rd_y_noc = large_bw_calculation_fp;
+
+	large_bw_calculation_fp = 0;
+
+	large_bw_calculation_fp = ((codec_input.bitdepth == CODEC_BITDEPTH_8) ?
+		frame420_y_bw_linear_8bpp :
+		frame420_y_bw_no_ubwc_tile_10bpp) * reference_crcb_read_bw_factor / 2;
+
+	large_bw_calculation_fp = large_bw_calculation_fp *
+		iris3_en_readfactor[codec_input.hierachical_layer];
+
+	large_bw_calculation_fp = (large_bw_calculation_fp +
+		dpb_compression_factor_cbcr - 1) / dpb_compression_factor_cbcr;
+
+	large_bw_calculation_fp = (large_bw_calculation_fp + 999) / 1000;
+	codec_output->dpb_rd_crcb_noc = large_bw_calculation_fp;
+
+	large_bw_calculation_fp = 0;
+
+	large_bw_calculation_fp = ((codec_input.bitdepth == CODEC_BITDEPTH_8) ?
+		frame420_y_bw_linear_8bpp : frame420_y_bw_no_ubwc_tile_10bpp) *
+		reconstructed_write_bw_factor_rd *
+		iris3_en_writefactor[codec_input.hierachical_layer] /
+		iris3_en_frame_num_parallel;
+
+	large_bw_calculation_fp = (large_bw_calculation_fp + 999) / 1000;
+
+	large_bw_calculation_fp = large_bw_calculation_fp *
+		(dpb_compression_factor_cbcr + dpb_compression_factor_y / 2);
+
+	large_bw_calculation_fp = (large_bw_calculation_fp +
+		dpb_compression_factor_y - 1) / dpb_compression_factor_y;
+
+	large_bw_calculation_fp = (large_bw_calculation_fp +
+		dpb_compression_factor_cbcr - 1) / dpb_compression_factor_cbcr;
+
+	codec_output->dpb_wr_noc = large_bw_calculation_fp;
+
+	/*
+	 * Summary:
+	 * by default (for both HFR and HSR cases) :
+	 *	-Any resolution and fps >= 120, enable layering.
+	 * (120 -> 3, 240 -> 4, 480 -> 5)
+	 *	- (once we enable layering) : 50 per cent frames are Non - reference
+	 *  frames.recon write is disable by Venus firmware
+	 *	- Customer has ability to enable / disable layering.
+	 *  Hence, recon write savings would not be there if customer
+	 *  explicitly disables layer encoding.
+	 */
+
+	/*HFR Cases use alternating rec write if not PWC*/
+	if (codec_input.frame_rate >= 120 && codec_input.complexity_setting != 0)
+		codec_output->dpb_wr_noc = codec_output->dpb_wr_noc / 2;
+
+	/* for power cases with [B1] adaptive non-ref b frame */
+	/* power caes IbP non reference b */
+	if (codec_input.hierachical_layer >= 1 &&
+	    codec_input.hierachical_layer <= 3 &&
+	    codec_input.complexity_setting != 0)
+		codec_output->dpb_wr_noc = codec_output->dpb_wr_noc / 2;
+
+	large_bw_calculation_fp = 0;
+	large_bw_calculation_fp = codec_output->dpb_wr_noc *
+		(reconstructed_write_bw_factor_rd - 100);
+
+	large_bw_calculation_fp = (large_bw_calculation_fp +
+		reconstructed_write_bw_factor_rd - 1) / reconstructed_write_bw_factor_rd;
+
+	codec_output->dpb_rdwr_duetooverlap_noc = large_bw_calculation_fp;
+
+	codec_output->dpb_rd_y_ddr = (en_llc_enable_ref_rd_y_overlap) ?
+		(codec_output->dpb_rd_y_noc * 100 + reference_y_read_bw_factor - 1) /
+		reference_y_read_bw_factor : codec_output->dpb_rd_y_noc;
+
+	codec_output->dpb_rd_crcb_ddr = (en_llc_enable_ref_rd_crcb) ?
+		(codec_output->dpb_rd_crcb_noc * 100 + reference_crcb_read_bw_factor - 1) /
+		reference_crcb_read_bw_factor : codec_output->dpb_rd_crcb_noc;
+
+	codec_output->dpb_rdwr_duetooverlap_ddr = (en_llc_enable_rec_wr_uncompleted) ?
+		0 : codec_output->dpb_rdwr_duetooverlap_noc;
+
+	codec_output->dpb_wr_ddr = (en_llc_enable_rec_wr_uncompleted) ?
+		0 : codec_output->dpb_wr_noc;
+
+	/* accumulation */
+	codec_output->noc_bw_rd += codec_output->dpb_rd_y_noc;
+	codec_output->noc_bw_rd += codec_output->dpb_rd_crcb_noc;
+	codec_output->noc_bw_rd += codec_output->dpb_rdwr_duetooverlap_noc;
+	codec_output->noc_bw_wr += codec_output->dpb_wr_noc;
+	codec_output->ddr_bw_rd += codec_output->dpb_rd_y_ddr;
+	codec_output->ddr_bw_rd += codec_output->dpb_rd_crcb_ddr;
+	codec_output->ddr_bw_rd += codec_output->dpb_rdwr_duetooverlap_ddr;
+	codec_output->ddr_bw_wr += codec_output->dpb_wr_ddr;
+
+	if (codec_input.bitdepth == CODEC_BITDEPTH_8) {
+		if (codec_input.ipb_yuvrgb == 0) { /* yuv */
+			large_bw_calculation_fp = ((frame420_y_bw_linear_8bpp) * 3 / 2);
+			codec_output->ipb_rd_total_noc = large_bw_calculation_fp;
+			if (codec_input.linear_ipb == 0) {
+				codec_output->ipb_rd_total_noc =
+					(large_bw_calculation_fp * 100 + ipb_compression_factor
+					 - 1) / ipb_compression_factor;
+			}
+		} else { /* rgb */
+			large_bw_calculation_fp = frame420_y_bw_linear_8bpp;
+			codec_output->ipb_rd_total_noc = large_bw_calculation_fp;
+			if (codec_input.linear_ipb == 0) {
+				if (codec_input.complexity_setting == 0) /* pwc */
+					codec_output->ipb_rd_total_noc =
+						(large_bw_calculation_fp * 100 +
+						en_original_compression_factor_rgba_pwd_iris3
+						- 1) /
+						en_original_compression_factor_rgba_pwd_iris3;
+				else
+					codec_output->ipb_rd_total_noc =
+					(large_bw_calculation_fp * 100 +
+					en_original_compression_factor_rgba_avg_iris3 - 1) /
+					en_original_compression_factor_rgba_avg_iris3;
+			}
+		}
+	} else {
+		if (codec_input.linear_ipb == 1) {
+			large_bw_calculation_fp = (frame420_y_bw_linear_10bpp) * 3 / 2;
+			codec_output->ipb_rd_total_noc = large_bw_calculation_fp;
+		} else {
+			large_bw_calculation_fp = (frame420_y_bw_no_ubwc_tile_10bpp *
+				300 / 2 + ipb_compression_factor - 1) / ipb_compression_factor;
+			codec_output->ipb_rd_total_noc = large_bw_calculation_fp;
+		}
+	}
+
+	if (en_rotation_90_270) {
+		if (codec_input.codec == CODEC_HEVC) {
+			if (codec_input.bitdepth == CODEC_BITDEPTH_8 &&
+			    codec_input.ipb_yuvrgb == 0)
+				codec_output->ipb_rd_total_noc =
+					codec_output->ipb_rd_total_noc * 1;
+			else
+				codec_output->ipb_rd_total_noc =
+					codec_output->ipb_rd_total_noc * 3;
+		} else {
+			codec_output->ipb_rd_total_noc = codec_output->ipb_rd_total_noc * 2;
+		}
+	}
+
+	codec_output->ipb_rd_total_ddr = codec_output->ipb_rd_total_noc;
+
+	/* accumulation */
+	codec_output->noc_bw_rd += codec_output->ipb_rd_total_noc;
+	codec_output->ddr_bw_rd += codec_output->ipb_rd_total_ddr;
+
+	codec_output->bse_tlb_rd_noc =
+		((bse_tlb_byte_per_lcu * lcu_per_frame * codec_input.frame_rate + 999)
+		/ 1000 + 999) / 1000;
+
+	if (llc_enabled_bse_tlb) /* TODO should be common declaration */
+		codec_output->bse_tlb_rd_ddr = 0;
+	else
+		codec_output->bse_tlb_rd_ddr = codec_output->bse_tlb_rd_noc;
+
+	codec_output->bse_tlb_wr_noc = codec_output->bse_tlb_rd_noc;
+
+	if (llc_enabled_bse_tlb)
+		codec_output->bse_tlb_wr_ddr = 0;
+	else
+		codec_output->bse_tlb_wr_ddr = codec_output->bse_tlb_wr_noc;
+
+	/* accumulation */
+	codec_output->noc_bw_rd += codec_output->bse_tlb_rd_noc;
+	codec_output->ddr_bw_rd += codec_output->bse_tlb_rd_ddr;
+	codec_output->noc_bw_wr += codec_output->bse_tlb_wr_noc;
+	codec_output->ddr_bw_wr += codec_output->bse_tlb_wr_ddr;
+
+	codec_output->mmu_rd_ddr = 0;
+	codec_output->mmu_rd_noc = 0;
+	/* accumulation */
+	codec_output->noc_bw_rd += codec_output->mmu_rd_noc;
+	codec_output->ddr_bw_rd += codec_output->mmu_rd_ddr;
+
+	return 0;
+}
+
+int msm_vidc_calculate_bandwidth(struct api_calculation_input codec_input,
+				 struct api_calculation_bw_output *codec_output)
+{
+	int rc = 0;
+
+	if (codec_input.decoder_or_encoder == CODEC_DECODER) {
+		rc = calculate_bandwidth_decoder_iris3(codec_input, codec_output);
+	} else if (codec_input.decoder_or_encoder == CODEC_ENCODER) {
+		rc = calculate_bandwidth_encoder_iris3(codec_input, codec_output);
+	} else {
+		d_vpr_e("%s: invalid codec %u\n", __func__, codec_input.decoder_or_encoder);
+		return -EINVAL;
+	}
+
+	return rc;
+}
-- 
2.7.4


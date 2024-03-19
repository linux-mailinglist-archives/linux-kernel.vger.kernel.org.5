Return-Path: <linux-kernel+bounces-107932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826E58803B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64661C22B37
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD63239FE4;
	Tue, 19 Mar 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kq+1+gcL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD9374FA;
	Tue, 19 Mar 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870031; cv=none; b=n0T9xexI50Np2KBq3dLxe8Qv7eKmkxDhi8mPFLQ6+g0rFeUlog0wugO/+cOMUqvSECj+W2e+14yxQs5mK8ML0xhokGDlCjbXb6Ll5AWPFemCqVjAlMP1GEZmP3d32CVO+dcUlPCHMLotOEArFaFTmrm0F6RYLdNVxHBF15wtqnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870031; c=relaxed/simple;
	bh=UCJOwiTaHGY52rKrDmLCg6FyZYK7q6i3NOUWuRHZFmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPQJAtc9xD+mtnwlw6F3DIXVUKa1PenqZSmVkclNZvDxOlgnsk73wDXNozGTrCk9Txpw+FxyFhlSkt7XUNtdnHeO+ZLqTeGXHvZWg1sQEOVOzV7RRYtUWJ39qZG2oiCXPbagsH4mUS2t+v1EQj+DOYXDiVJaHeeNz/teUBzNt7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Kq+1+gcL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JHGhoJ030124;
	Tue, 19 Mar 2024 17:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=f6a3eetHvkHmoww30BMe6VjN3bbcNN4/E5AreBlPPBA=; b=Kq
	+1+gcL1mRBj5McZkNegQWViP9D1CAP6RRmboQP2vKEQgDgHiIVlpEZw1gZzg2rq4
	M+RW2NzJ6hdPaax3Bp93f3QOlO5R5BbCWYjj8USlgQJswh66f73/sF8VK+luqEJq
	CPOkgrlLdVMg3TTBDxktfMJOMrNCOriuScXEofwUMWoYVeEpB1KKJq3alo991ZUD
	IY8WELvlla7bPM88wDGh+puE+28uzjxlKZ/jHCWg0Cy+btvlmUAnIE2XNcfpnuf+
	Etw8V0YRseXmfZVFFu70w97OAZrn0uwHo0r6j3nP2a/TgiqSOpRdmOs/aP6g4zoa
	3EFR1JpVuGFkCDGN1lrg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy94ts18f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 17:40:22 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JHeLOq021605
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 17:40:21 GMT
Received: from grosikop.eu.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 10:40:18 -0700
From: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <hverkuil-cisco@xs4all.nl>, <quic_hariramp@quicinc.com>
Subject: [PATCH v2 6/8] media: qcom: camss: Split testgen, RDI and RX for CSID 170
Date: Tue, 19 Mar 2024 19:39:33 +0200
Message-ID: <20240319173935.481-7-quic_grosikop@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319173935.481-1-quic_grosikop@quicinc.com>
References: <20240319173935.481-1-quic_grosikop@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XsK0SEMn_SXhUv_k9d1cF7LH36T-dHDZ
X-Proofpoint-ORIG-GUID: XsK0SEMn_SXhUv_k9d1cF7LH36T-dHDZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_07,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190131

From: Milen Mitkov <quic_mmitkov@quicinc.com>

Split the RAW interface (RDI), the CSID receiver (RX)
and test pattern generator (testgen), configurations
for CSID on Titan 170

Signed-off-by: Milen Mitkov <quic_mmitkov@quicinc.com>
Signed-off-by: Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>
---
 .../platform/qcom/camss/camss-csid-gen2.c     | 252 ++++++++++--------
 1 file changed, 139 insertions(+), 113 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
index eb5dabe2639a..2d8398a91fc2 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
@@ -176,150 +176,176 @@
 #define		TPG_COLOR_BOX_CFG_MODE		0
 #define		TPG_COLOR_BOX_PATTERN_SEL	2
 
-static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
+static void __csid_configure_rx(struct csid_device *csid,
+				struct csid_phy_config *phy, int vc)
 {
-	struct csid_testgen_config *tg = &csid->testgen;
-	u32 val;
-	u32 phy_sel = 0;
 	u8 lane_cnt = csid->phy.lane_cnt;
-	/* Source pads matching RDI channels on hardware. Pad 1 -> RDI0, Pad 2 -> RDI1, etc. */
-	struct v4l2_mbus_framefmt *input_format = &csid->fmt[MSM_CSID_PAD_FIRST_SRC + vc];
-	const struct csid_format_info *format = csid_get_fmt_entry(csid->res->formats->formats,
-								   csid->res->formats->nformats,
-								   input_format->code);
+	int val;
 
 	if (!lane_cnt)
 		lane_cnt = 4;
 
-	if (!tg->enabled)
-		phy_sel = csid->phy.csiphy_id;
+	val = (lane_cnt - 1) << CSI2_RX_CFG0_NUM_ACTIVE_LANES;
+	val |= phy->lane_assign << CSI2_RX_CFG0_DL0_INPUT_SEL;
+	val |= phy->csiphy_id << CSI2_RX_CFG0_PHY_NUM_SEL;
+	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG0);
 
-	if (enable) {
-		/*
-		 * DT_ID is a two bit bitfield that is concatenated with
-		 * the four least significant bits of the five bit VC
-		 * bitfield to generate an internal CID value.
-		 *
-		 * CSID_RDI_CFG0(vc)
-		 * DT_ID : 28:27
-		 * VC    : 26:22
-		 * DT    : 21:16
-		 *
-		 * CID   : VC 3:0 << 2 | DT_ID 1:0
-		 */
-		u8 dt_id = vc & 0x03;
-
-		if (tg->enabled) {
-			/* configure one DT, infinite frames */
-			val = vc << TPG_VC_CFG0_VC_NUM;
-			val |= INTELEAVING_MODE_ONE_SHOT << TPG_VC_CFG0_LINE_INTERLEAVING_MODE;
-			val |= 0 << TPG_VC_CFG0_NUM_FRAMES;
-			writel_relaxed(val, csid->base + CSID_TPG_VC_CFG0);
-
-			val = 0x740 << TPG_VC_CFG1_H_BLANKING_COUNT;
-			val |= 0x3ff << TPG_VC_CFG1_V_BLANKING_COUNT;
-			writel_relaxed(val, csid->base + CSID_TPG_VC_CFG1);
-
-			writel_relaxed(0x12345678, csid->base + CSID_TPG_LFSR_SEED);
-
-			val = (input_format->height & 0x1fff) << TPG_DT_n_CFG_0_FRAME_HEIGHT;
-			val |= (input_format->width & 0x1fff) << TPG_DT_n_CFG_0_FRAME_WIDTH;
-			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_0(0));
-
-			val = format->data_type << TPG_DT_n_CFG_1_DATA_TYPE;
-			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_1(0));
-
-			val = (tg->mode - 1) << TPG_DT_n_CFG_2_PAYLOAD_MODE;
-			val |= 0xBE << TPG_DT_n_CFG_2_USER_SPECIFIED_PAYLOAD;
-			val |= format->decode_format << TPG_DT_n_CFG_2_ENCODE_FORMAT;
-			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_2(0));
-
-			writel_relaxed(0, csid->base + CSID_TPG_COLOR_BARS_CFG);
-
-			writel_relaxed(0, csid->base + CSID_TPG_COLOR_BOX_CFG);
-		}
+	val = 1 << CSI2_RX_CFG1_PACKET_ECC_CORRECTION_EN;
+	if (vc > 3)
+		val |= 1 << CSI2_RX_CFG1_VC_MODE;
+	val |= 1 << CSI2_RX_CFG1_MISR_EN;
+	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG1);
+}
 
-		val = 1 << RDI_CFG0_BYTE_CNTR_EN;
-		val |= 1 << RDI_CFG0_FORMAT_MEASURE_EN;
-		val |= 1 << RDI_CFG0_TIMESTAMP_EN;
-		/* note: for non-RDI path, this should be format->decode_format */
-		val |= DECODE_FORMAT_PAYLOAD_ONLY << RDI_CFG0_DECODE_FORMAT;
-		val |= format->data_type << RDI_CFG0_DATA_TYPE;
-		val |= vc << RDI_CFG0_VIRTUAL_CHANNEL;
-		val |= dt_id << RDI_CFG0_DT_ID;
-		writel_relaxed(val, csid->base + CSID_RDI_CFG0(vc));
+static void __csid_ctrl_rdi(struct csid_device *csid, int enable, u8 rdi)
+{
+	int val;
 
-		/* CSID_TIMESTAMP_STB_POST_IRQ */
-		val = 2 << RDI_CFG1_TIMESTAMP_STB_SEL;
-		writel_relaxed(val, csid->base + CSID_RDI_CFG1(vc));
+	if (enable)
+		val = HALT_CMD_RESUME_AT_FRAME_BOUNDARY << RDI_CTRL_HALT_CMD;
+	else
+		val = HALT_CMD_HALT_AT_FRAME_BOUNDARY << RDI_CTRL_HALT_CMD;
+	writel_relaxed(val, csid->base + CSID_RDI_CTRL(rdi));
+}
 
-		val = 1;
-		writel_relaxed(val, csid->base + CSID_RDI_FRM_DROP_PERIOD(vc));
+static void __csid_configure_testgen(struct csid_device *csid, u8 enable, u8 vc)
+{
+	struct csid_testgen_config *tg = &csid->testgen;
+	struct v4l2_mbus_framefmt *input_format = &csid->fmt[MSM_CSID_PAD_FIRST_SRC + vc];
+	const struct csid_format_info *format = csid_get_fmt_entry(csid->res->formats->formats,
+								   csid->res->formats->nformats,
+								   input_format->code);
+	u8 lane_cnt = csid->phy.lane_cnt;
+	u32 val;
 
-		val = 0;
-		writel_relaxed(val, csid->base + CSID_RDI_FRM_DROP_PATTERN(vc));
+	if (!lane_cnt)
+		lane_cnt = 4;
 
-		val = 1;
-		writel_relaxed(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PERIOD(vc));
+	/* configure one DT, infinite frames */
+	val = vc << TPG_VC_CFG0_VC_NUM;
+	val |= INTELEAVING_MODE_ONE_SHOT << TPG_VC_CFG0_LINE_INTERLEAVING_MODE;
+	val |= 0 << TPG_VC_CFG0_NUM_FRAMES;
+	writel_relaxed(val, csid->base + CSID_TPG_VC_CFG0);
 
-		val = 0;
-		writel_relaxed(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PATTERN(vc));
+	val = 0x740 << TPG_VC_CFG1_H_BLANKING_COUNT;
+	val |= 0x3ff << TPG_VC_CFG1_V_BLANKING_COUNT;
+	writel_relaxed(val, csid->base + CSID_TPG_VC_CFG1);
 
-		val = 1;
-		writel_relaxed(val, csid->base + CSID_RDI_RPP_PIX_DROP_PERIOD(vc));
+	writel_relaxed(0x12345678, csid->base + CSID_TPG_LFSR_SEED);
 
-		val = 0;
-		writel_relaxed(val, csid->base + CSID_RDI_RPP_PIX_DROP_PATTERN(vc));
+	val = (input_format->height & 0x1fff) << TPG_DT_n_CFG_0_FRAME_HEIGHT;
+	val |= (input_format->width & 0x1fff) << TPG_DT_n_CFG_0_FRAME_WIDTH;
+	writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_0(0));
 
-		val = 1;
-		writel_relaxed(val, csid->base + CSID_RDI_RPP_LINE_DROP_PERIOD(vc));
+	val = format->data_type << TPG_DT_n_CFG_1_DATA_TYPE;
+	writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_1(0));
 
-		val = 0;
-		writel_relaxed(val, csid->base + CSID_RDI_RPP_LINE_DROP_PATTERN(vc));
+	val = (tg->mode - 1) << TPG_DT_n_CFG_2_PAYLOAD_MODE;
+	val |= 0xBE << TPG_DT_n_CFG_2_USER_SPECIFIED_PAYLOAD;
+	val |= format->decode_format << TPG_DT_n_CFG_2_ENCODE_FORMAT;
+	writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_2(0));
 
-		val = 0;
-		writel_relaxed(val, csid->base + CSID_RDI_CTRL(vc));
+	writel_relaxed(0, csid->base + CSID_TPG_COLOR_BARS_CFG);
 
-		val = readl_relaxed(csid->base + CSID_RDI_CFG0(vc));
-		val |=  1 << RDI_CFG0_ENABLE;
-		writel_relaxed(val, csid->base + CSID_RDI_CFG0(vc));
-	}
+	writel_relaxed(0, csid->base + CSID_TPG_COLOR_BOX_CFG);
 
-	if (tg->enabled) {
-		val = enable << TPG_CTRL_TEST_EN;
-		val |= 1 << TPG_CTRL_FS_PKT_EN;
-		val |= 1 << TPG_CTRL_FE_PKT_EN;
-		val |= (lane_cnt - 1) << TPG_CTRL_NUM_ACTIVE_LANES;
-		val |= 0x64 << TPG_CTRL_CYCLES_BETWEEN_PKTS;
-		val |= 0xA << TPG_CTRL_NUM_TRAIL_BYTES;
-		writel_relaxed(val, csid->base + CSID_TPG_CTRL);
-	}
+	val = enable << TPG_CTRL_TEST_EN;
+	val |= 1 << TPG_CTRL_FS_PKT_EN;
+	val |= 1 << TPG_CTRL_FE_PKT_EN;
+	val |= (lane_cnt - 1) << TPG_CTRL_NUM_ACTIVE_LANES;
+	val |= 0x64 << TPG_CTRL_CYCLES_BETWEEN_PKTS;
+	val |= 0xA << TPG_CTRL_NUM_TRAIL_BYTES;
+	writel_relaxed(val, csid->base + CSID_TPG_CTRL);
+}
 
-	val = (lane_cnt - 1) << CSI2_RX_CFG0_NUM_ACTIVE_LANES;
-	val |= csid->phy.lane_assign << CSI2_RX_CFG0_DL0_INPUT_SEL;
-	val |= phy_sel << CSI2_RX_CFG0_PHY_NUM_SEL;
-	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG0);
+static void __csid_configure_rdi_stream(struct csid_device *csid, u8 enable, u8 vc)
+{
+	struct csid_testgen_config *tg = &csid->testgen;
+	u32 val;
+	u32 phy_sel = 0;
+	/* Source pads matching RDI channels on hardware. Pad 1 -> RDI0, Pad 2 -> RDI1, etc. */
+	struct v4l2_mbus_framefmt *input_format = &csid->fmt[MSM_CSID_PAD_FIRST_SRC + vc];
+	const struct csid_format_info *format = csid_get_fmt_entry(csid->res->formats->formats,
+								   csid->res->formats->nformats,
+								   input_format->code);
 
-	val = 1 << CSI2_RX_CFG1_PACKET_ECC_CORRECTION_EN;
-	if (vc > 3)
-		val |= 1 << CSI2_RX_CFG1_VC_MODE;
-	val |= 1 << CSI2_RX_CFG1_MISR_EN;
-	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG1);
+	if (!tg->enabled)
+		phy_sel = csid->phy.csiphy_id;
 
-	if (enable)
-		val = HALT_CMD_RESUME_AT_FRAME_BOUNDARY << RDI_CTRL_HALT_CMD;
-	else
-		val = HALT_CMD_HALT_AT_FRAME_BOUNDARY << RDI_CTRL_HALT_CMD;
+	/*
+	 * DT_ID is a two bit bitfield that is concatenated with
+	 * the four least significant bits of the five bit VC
+	 * bitfield to generate an internal CID value.
+	 *
+	 * CSID_RDI_CFG0(vc)
+	 * DT_ID : 28:27
+	 * VC    : 26:22
+	 * DT    : 21:16
+	 *
+	 * CID   : VC 3:0 << 2 | DT_ID 1:0
+	 */
+	u8 dt_id = vc & 0x03;
+
+	val = 1 << RDI_CFG0_BYTE_CNTR_EN;
+	val |= 1 << RDI_CFG0_FORMAT_MEASURE_EN;
+	val |= 1 << RDI_CFG0_TIMESTAMP_EN;
+	/* note: for non-RDI path, this should be format->decode_format */
+	val |= DECODE_FORMAT_PAYLOAD_ONLY << RDI_CFG0_DECODE_FORMAT;
+	val |= format->data_type << RDI_CFG0_DATA_TYPE;
+	val |= vc << RDI_CFG0_VIRTUAL_CHANNEL;
+	val |= dt_id << RDI_CFG0_DT_ID;
+	writel_relaxed(val, csid->base + CSID_RDI_CFG0(vc));
+
+	/* CSID_TIMESTAMP_STB_POST_IRQ */
+	val = 2 << RDI_CFG1_TIMESTAMP_STB_SEL;
+	writel_relaxed(val, csid->base + CSID_RDI_CFG1(vc));
+
+	val = 1;
+	writel_relaxed(val, csid->base + CSID_RDI_FRM_DROP_PERIOD(vc));
+
+	val = 0;
+	writel_relaxed(val, csid->base + CSID_RDI_FRM_DROP_PATTERN(vc));
+
+	val = 1;
+	writel_relaxed(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PERIOD(vc));
+
+	val = 0;
+	writel_relaxed(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PATTERN(vc));
+
+	val = 1;
+	writel_relaxed(val, csid->base + CSID_RDI_RPP_PIX_DROP_PERIOD(vc));
+
+	val = 0;
+	writel_relaxed(val, csid->base + CSID_RDI_RPP_PIX_DROP_PATTERN(vc));
+
+	val = 1;
+	writel_relaxed(val, csid->base + CSID_RDI_RPP_LINE_DROP_PERIOD(vc));
+
+	val = 0;
+	writel_relaxed(val, csid->base + CSID_RDI_RPP_LINE_DROP_PATTERN(vc));
+
+	val = 0;
 	writel_relaxed(val, csid->base + CSID_RDI_CTRL(vc));
+
+	val = readl_relaxed(csid->base + CSID_RDI_CFG0(vc));
+	val |=  enable << RDI_CFG0_ENABLE;
+	writel_relaxed(val, csid->base + CSID_RDI_CFG0(vc));
 }
 
 static void csid_configure_stream(struct csid_device *csid, u8 enable)
 {
+	struct csid_testgen_config *tg = &csid->testgen;
 	u8 i;
 	/* Loop through all enabled VCs and configure stream for each */
 	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS; i++)
-		if (csid->phy.en_vc & BIT(i))
-			__csid_configure_stream(csid, enable, i);
+		if (csid->phy.en_vc & BIT(i)) {
+			if (tg->enabled)
+				__csid_configure_testgen(csid, enable, i);
+
+			__csid_configure_rdi_stream(csid, enable, i);
+			__csid_configure_rx(csid, &csid->phy, i);
+			__csid_ctrl_rdi(csid, enable, i);
+		}
 }
 
 static int csid_configure_testgen_pattern(struct csid_device *csid, s32 val)
-- 
2.17.1



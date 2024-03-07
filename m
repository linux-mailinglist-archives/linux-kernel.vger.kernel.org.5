Return-Path: <linux-kernel+bounces-96065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B70BC8756B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2821C1F218EE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2323D13B293;
	Thu,  7 Mar 2024 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fEyCQvhZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3A213AA36;
	Thu,  7 Mar 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838370; cv=none; b=oq2NCXG+oGkrIKg1b5r8LjHGcXfXX7Y6uebaJ+9Q2As5ypn4GfXQtlcKIu1c+GdnY1L3nCC0nHeA/xboYwASL0XNqFGpCbB3j6eugFMoWtyNxjtbd6jT+pOl9wmNHkFtN7TrE+BEK5bvuUAosnzdB8cy3lpfUGsd9jP47ZkUmek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838370; c=relaxed/simple;
	bh=LguhZzpJmc2AKBeuTASls661QnFobgdUb0WsToqUKus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgasqXPGSkw7Ky/Rp4bbqwOjh4kFB8Ugeud5BOCLk57JTnLwuc5PSKZ5UivCilpkxF/z93CK+Wsm4l9SZcKHjHnuDpu5a/zhSP7a3ml5z/vw20JycPGcjB9rhcBb8g4hwyPGBua8uMYwEXfsE4F84ZD/f+4imHN6DgH3cWRlKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fEyCQvhZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427IQm5c023752;
	Thu, 7 Mar 2024 19:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=RtIv9z0MOmoj5lHluiO/X/ko6/nS/jkD4AEWSes3YOs=; b=fE
	yCQvhZr3XWfexBhEbchXMr6Z78ioyPRWmJGAdYCHFrlxPeUU4CmjhTsSCuRI79af
	ZtJ5y47qKvR12wrcxCCaJyHZco/LFph+Q87U/BKy+Fc9Aty8cV8feUBMNgRql2PS
	J+JayBWT6g4rPOEq2Z+ZI+kFleyx/Wjy13uSLaIqTKsoa2jl3TWfQvsrwuqycdnG
	u0U+jSinjCDzHN+kmCNjpDzqImzXMaedycuXrHI8mIuNpvHFjlDDYWFK/sOsbSe4
	XxNVVPNsO+NxoYeu/DZulnoSV1++og6Rwb4WH5hZg+7+FuadBnxpE/5JDZrxi1d0
	6TPAyXjTrNCbEcmj/xkA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wq588hrwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 19:05:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 427J5kSG007362
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 19:05:46 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Mar 2024 11:05:45 -0800
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <devicetree@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robdclark@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <djakov@kernel.org>
Subject: [PATCH v6 5/7] arm64: dts: qcom: sdm845: Add DT nodes for the TBUs
Date: Thu, 7 Mar 2024 11:05:23 -0800
Message-ID: <20240307190525.395291-6-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307190525.395291-1-quic_c_gdjako@quicinc.com>
References: <20240307190525.395291-1-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8OREPso_o_T3bJOfrxXB6FVIj_yyTkzK
X-Proofpoint-ORIG-GUID: 8OREPso_o_T3bJOfrxXB6FVIj_yyTkzK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403070133

Add the device-tree nodes for the TBUs (translation buffer units) that
are present on the sdm845 platforms. The TBUs can be used debug the
kernel and provide additional information when a context faults occur.

Describe the all registers, clocks, interconnects and power-domain
resources that are needed for each of the TBUs.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 70 ++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2f20be99ee7e..381537f03fae 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -5085,6 +5086,75 @@ apps_smmu: iommu@15000000 {
 				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		anoc_1_tbu: tbu@150c5000 {
+			compatible = "qcom,sdm845-tbu";
+			reg = <0x0 0x150c5000 0x0 0x1000>;
+			interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0x0 0x400>;
+		};
+
+		anoc_2_tbu: tbu@150c9000 {
+			compatible = "qcom,sdm845-tbu";
+			reg = <0x0 0x150c9000 0x0 0x1000>;
+			interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0x400 0x400>;
+		};
+
+		mnoc_hf_0_tbu: tbu@150cd000 {
+			compatible = "qcom,sdm845-tbu";
+			reg = <0x0 0x150cd000 0x0 0x1000>;
+			interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mmss_noc SLAVE_MNOC_HF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
+			qcom,stream-id-range = <&apps_smmu 0x800 0x400>;
+		};
+
+		mnoc_hf_1_tbu: tbu@150d1000 {
+			compatible = "qcom,sdm845-tbu";
+			reg = <0x0 0x150d1000 0x0 0x1000>;
+			interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mmss_noc SLAVE_MNOC_HF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
+			qcom,stream-id-range = <&apps_smmu 0xc00 0x400>;
+		};
+
+		mnoc_sf_0_tbu: tbu@150d5000 {
+			compatible = "qcom,sdm845-tbu";
+			reg = <0x0 0x150d5000 0x0 0x1000>;
+			interconnects = <&mmss_noc MASTER_CAMNOC_SF QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mmss_noc SLAVE_MNOC_SF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
+			qcom,stream-id-range = <&apps_smmu 0x1000 0x400>;
+		};
+
+		compute_dsp_tbu: tbu@150d9000 {
+			compatible = "qcom,sdm845-tbu";
+			reg = <0x0 0x150d9000 0x0 0x1000>;
+			interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			qcom,stream-id-range = <&apps_smmu 0x1400 0x400>;
+		};
+
+		adsp_tbu: tbu@150dd000 {
+			compatible = "qcom,sdm845-tbu";
+			reg = <0x0 0x150dd000 0x0 0x1000>;
+			interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0x1800 0x400>;
+		};
+
+		anoc_1_pcie_tbu: tbu@150e1000 {
+			compatible = "qcom,sdm845-tbu";
+			reg = <0x0 0x150e1000 0x0 0x1000>;
+			clocks = <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+			interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0x1c00 0x400>;
+		};
+
 		lpasscc: clock-controller@17014000 {
 			compatible = "qcom,sdm845-lpasscc";
 			reg = <0 0x17014000 0 0x1f004>, <0 0x17300000 0 0x200>;


Return-Path: <linux-kernel+bounces-6401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE6E81986E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4146B1C25694
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CC71775F;
	Wed, 20 Dec 2023 06:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D5OLFjX/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D436134C9;
	Wed, 20 Dec 2023 06:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK62H9V020939;
	Wed, 20 Dec 2023 06:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=9h0dj9cr730JabEIK4xh
	4FOCZU8EWVaL3ohZs/bE0iU=; b=D5OLFjX/fEOGUDtGmAUK+BmYOGgjv4eSODK1
	EtksuMb7RkDTGlhkazW6ohzlVaZnzUBexteOIg16juYMS1DbhtKz2x7+nTzRBZns
	5SWSXjCoCEK6z9SjFZYw+8MoAwNAkotBP/al27WQUfkBtSWeUnIV6zvIrUKst8uO
	iku5fTdLkFR6hXHeW8JsXMahnZben2EDVVD2mnflUl0/wRNuWju8FqEUlL6OP1bx
	GaGwRrk1+5oeY3U6DuX4h3IuRopMldoaMe5FQ2Ww72gyamPF72xU9TnfVMdZPO3d
	hs2/IWCZGoYMyv1DDAu5wGUrP9ee69msUOgqFeOOHgx+DPzJ/A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3tmm0043-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 06:02:49 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK62niv023310
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 06:02:49 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 22:02:48 -0800
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>
CC: <devicetree@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <djakov@kernel.org>
Subject: [PATCH v3 6/9] arm64: dts: qcom: sdm845: Add DT nodes for the TBUs
Date: Tue, 19 Dec 2023 22:02:33 -0800
Message-ID: <20231220060236.18600-7-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231220060236.18600-1-quic_c_gdjako@quicinc.com>
References: <20231220060236.18600-1-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3l2NRDWSdDK9cRKMwdVAXFbRhp6aEOTf
X-Proofpoint-ORIG-GUID: 3l2NRDWSdDK9cRKMwdVAXFbRhp6aEOTf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312200038

Add the device-tree nodes for the TBUs (translation buffer units) that
are present on the sdm845 platforms. The TBUs can be used debug the
kernel and provide additional information when a context faults occur.

Describe the all registers, clocks, interconnects and power-domain
resources that are needed for each of the TBUs.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 74 ++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c2244824355a..c3dfa74d9403 100644
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
@@ -5005,6 +5006,7 @@
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x80000>;
+			ranges;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
@@ -5072,6 +5074,78 @@
 				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+
+			anoc_1_tbu: tbu@150c5000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x150c5000 0x0 0x1000>;
+				interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+				power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC>;
+				stream-id-range = <0x0 0x400>;
+			};
+
+			anoc_2_tbu: tbu@150c9000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x150c9000 0x0 0x1000>;
+				interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+				power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC>;
+				stream-id-range = <0x400 0x400>;
+			};
+
+			mnoc_hf_0_tbu: tbu@150cd000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x150cd000 0x0 0x1000>;
+				interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
+						 &mmss_noc SLAVE_MNOC_HF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
+				stream-id-range = <0x800 0x400>;
+			};
+
+			mnoc_hf_1_tbu: tbu@150d1000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x150d1000 0x0 0x1000>;
+				interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
+						 &mmss_noc SLAVE_MNOC_HF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
+				stream-id-range = <0xc00 0x400>;
+			};
+
+			mnoc_sf_0_tbu: tbu@150d5000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x150d5000 0x0 0x1000>;
+				interconnects = <&mmss_noc MASTER_CAMNOC_SF QCOM_ICC_TAG_ACTIVE_ONLY
+						 &mmss_noc SLAVE_MNOC_SF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
+				stream-id-range = <0x1000 0x400>;
+			};
+
+			compute_dsp_tbu: tbu@150d9000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x150d9000 0x0 0x1000>;
+				interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+				stream-id-range = <0x1400 0x400>;
+			};
+
+			adsp_tbu: tbu@150dd000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x150dd000 0x0 0x1000>;
+				interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+				power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC>;
+				stream-id-range = <0x1800 0x400>;
+			};
+
+			anoc_1_pcie_tbu: tbu@150e1000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x150e1000 0x0 0x1000>;
+				clocks = <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+				interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+				power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC>;
+				stream-id-range = <0x1c00 0x400>;
+			};
 		};
 
 		lpasscc: clock-controller@17014000 {


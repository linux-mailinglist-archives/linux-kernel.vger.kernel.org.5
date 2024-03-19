Return-Path: <linux-kernel+bounces-106961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8509A87F60A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D4A9B215CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30CE7BB12;
	Tue, 19 Mar 2024 03:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oS8przDC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC072F5B;
	Tue, 19 Mar 2024 03:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710818948; cv=none; b=F+NMy3H7DApw0Q9oxeMk9AJyW5pjp0ryyZGZK6TKBO6PcRQo1GF9pPntUbSSVIRYRp3eHJgY/kpAhSvVP7ylwKn+mtgHB9FwYSSSL4lcnFfr7BrGCV/6jJBbEisxxKDS6+hOguxKmcKOZ2/GTsVc5hmbykUOabsL2AbdNF6EWPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710818948; c=relaxed/simple;
	bh=Od381JPSUKH8+MmNmWOHeI2X3X/5qdlT2/DqpZ7NYcc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kV3c8zdXQFPvvsZ2fkVp9SjoaeeAoqqbTWs9b/KNC3EXHhQlJLNYfT13va+4uMZS4a0dp/GjG/dnr64bdc2Ik4LKHjdZG2wzl0khC4wMf1HCC01odKg5lV0kGkExWvugYuTDCVTjhnUsZaa0u4Dmj6rR4Wu4khIhw8vCOEwOo64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oS8przDC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J2wwp5017456;
	Tue, 19 Mar 2024 03:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=fe3ESbcgZSyVaQBbKQU/1/nK/Zh67/3lPiSBxhcDGXM=; b=oS
	8przDCtFSJAZ349r1SjBXE9yVgTCjHx19PCVTXGou9yR8g6qP1XkZDxxKbtVy0h4
	gtFBTyBm+/+6GO1CroUyxna58hSnTKv8ResJ/wHPU3XRW2l2CnmrtMWOaMXl2LFE
	R+713GrMi8podvZ3jn/Zr+RgZCFgA8XTfgLdvBkHhcKyWLxtjnQdrOTBXOYlgHob
	mi+uTqseQXRafk83wgA2tFr1US9f8fQ2MRRzEjXCliEImMIMq9DK7U5x9YojekCh
	Cl2E8reupUhVxBdw43Ax7jzH0TdqodGLaoTEp/EoEmuEe+zZ9EotrMhQofoEPcFe
	NZo0d13bppRj4G3drEWw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy2cjr1j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 03:29:00 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42J3SxVp004003
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 03:28:59 GMT
Received: from hu-lxu5-sha.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Mar 2024 20:28:54 -0700
From: Ling Xu <quic_lxu5@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <quic_lxu5@quicinc.com>, <quic_ekangupt@quicinc.com>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arm64: dts: qcom: sm8650: Add three missing fastrpc-compute-cb nodes
Date: Tue, 19 Mar 2024 08:58:16 +0530
Message-ID: <20240319032816.27070-1-quic_lxu5@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BjTA4MaFWz41SJLpLdPHaw2fpt9pZsAo
X-Proofpoint-GUID: BjTA4MaFWz41SJLpLdPHaw2fpt9pZsAo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxlogscore=585 suspectscore=0
 mlxscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403190025

Add three missing cDSP fastrpc compute-cb nodes for the SM8650 SoC.

Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
---
* v1->v2: Lowercase hex
  v1: https://lore.kernel.org/linux-arm-msm/20240314063334.31942-1-quic_lxu5@quicinc.com/
---
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index ba72d8f38420..57158e4606b1 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5084,6 +5084,38 @@
 							 <&apps_smmu 0x19c8 0x0>;
 						dma-coherent;
 					};
+
+					/* note: secure cb9 in downstream */
+
+					compute-cb@10 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <12>;
+
+						iommus = <&apps_smmu 0x196c 0x0>,
+							 <&apps_smmu 0x0c0c 0x20>,
+							 <&apps_smmu 0x19cc 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@11 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <13>;
+
+						iommus = <&apps_smmu 0x196d 0x0>,
+							 <&apps_smmu 0x0c0d 0x20>,
+							 <&apps_smmu 0x19cd 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@12 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <14>;
+
+						iommus = <&apps_smmu 0x196e 0x0>,
+							 <&apps_smmu 0x0c0e 0x20>,
+							 <&apps_smmu 0x19ce 0x0>;
+						dma-coherent;
+					};
 				};
 			};
 		};
-- 
2.17.1



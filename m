Return-Path: <linux-kernel+bounces-38382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F3983BE96
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F071F25DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621791CD31;
	Thu, 25 Jan 2024 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gqM90EgL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CE71CD1D;
	Thu, 25 Jan 2024 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178296; cv=none; b=ctT/CIgpJT02FANylbRc0ewAuRFdOj94smf9Z95exJKHvo/Lsi/LndyIuE12UACHlWXUznBHWexYzPqdMM1o6V0is3kQCdbODEt5l9fIl+PdaiO1YmvjRttVSEtzgU5Cr9fEZOQQ0OVbBkrJlyVhCIcdXvAMA6qCla75eS0U2lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178296; c=relaxed/simple;
	bh=LcqAeaC5Ypt7aSvFsln5wkpbQdiMzsvbsqVp7G94fq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfsVY6f1kA4qPDvSQyRHlpG2EKoktsRVm4ZHnPeUIN4IXxHfnOrAqpEBQrN8gxMvPwRSM33GbdMw2J71QRYQQqcU3HpcIZaBZsswPl/ZJXSftmSs6F3+GdQNI8+DYo2fTBYfjtsHd2rieRTLLcjV1wiluS0m94SaWK1yiW20e1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gqM90EgL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P9c2jD002802;
	Thu, 25 Jan 2024 10:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=MCIJRUvQ5awgE6X6TexR
	eV1uL4f4GftQ/lJ2cdBH284=; b=gqM90EgL9kg56Rp6ZSsOm3I6gDPEMroMqUen
	rOjxUUxHC82MkoRea8kRncJhUyyJ/YyNOrfBF/clI7bvY7I5IKc7H9RGLXMMqKCv
	l2dHRV8uCJELoh0+MSewqZSqgxafSaPDwXrzXOoG8N21xlB+bSkkVhw6BO70Fc1s
	S06J8sc4bu80UfnpWTf1Cf/+Bb+9qYa4h6Sza31CC1XIrWJYiYn0lUo0einqkabK
	i4ZCMpRo0Teu6UKH9kSWBZHvNcueQwiJVREPOkdi5OqDAu/B8KlBlveV0Rg4CYop
	UbioX9O9x0UrnV/0LVhTp865b2T3h1Z7ZYIxJTBCpvIoUQoOKA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vun5yg30b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 10:24:51 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PAOnUN014118
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 10:24:50 GMT
Received: from hu-lxu5-sha.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Jan 2024 02:24:45 -0800
From: Ling Xu <quic_lxu5@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <quic_kuiw@quicinc.com>, <quic_ekangupt@quicinc.com>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ling Xu
	<quic_lxu5@quicinc.com>
Subject: [PATCH 2/2] arm64: dts: qcom: sm8650: Add dma-coherent property
Date: Thu, 25 Jan 2024 15:54:13 +0530
Message-ID: <20240125102413.3016-3-quic_lxu5@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240125102413.3016-1-quic_lxu5@quicinc.com>
References: <20240125102413.3016-1-quic_lxu5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4cPmhKFStnImBHmysedTbz1PTCUTylIU
X-Proofpoint-ORIG-GUID: 4cPmhKFStnImBHmysedTbz1PTCUTylIU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_05,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=622 adultscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250070

Add dma-coherent property to fastRPC context bank nodes to pass dma
sequence test in fastrpc sanity test, ensure that data integrity is
maintained during DMA operations.

Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 2df77123a8c7..ed0d0ca34fd4 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4808,6 +4808,7 @@
 
 						iommus = <&apps_smmu 0x1003 0x80>,
 							 <&apps_smmu 0x1043 0x20>;
+						dma-coherent;
 					};
 
 					compute-cb@4 {
@@ -4816,6 +4817,7 @@
 
 						iommus = <&apps_smmu 0x1004 0x80>,
 							 <&apps_smmu 0x1044 0x20>;
+						dma-coherent;
 					};
 
 					compute-cb@5 {
@@ -4824,6 +4826,7 @@
 
 						iommus = <&apps_smmu 0x1005 0x80>,
 							 <&apps_smmu 0x1045 0x20>;
+						dma-coherent;
 					};
 
 					compute-cb@6 {
@@ -4832,6 +4835,7 @@
 
 						iommus = <&apps_smmu 0x1006 0x80>,
 							 <&apps_smmu 0x1046 0x20>;
+						dma-coherent;
 					};
 
 					compute-cb@7 {
@@ -4841,6 +4845,7 @@
 						iommus = <&apps_smmu 0x1007 0x40>,
 							 <&apps_smmu 0x1067 0x0>,
 							 <&apps_smmu 0x1087 0x0>;
+						dma-coherent;
 					};
 				};
 
@@ -4961,6 +4966,7 @@
 						iommus = <&apps_smmu 0x1961 0x0>,
 							 <&apps_smmu 0x0c01 0x20>,
 							 <&apps_smmu 0x19c1 0x0>;
+						dma-coherent;
 					};
 
 					compute-cb@2 {
@@ -4970,6 +4976,7 @@
 						iommus = <&apps_smmu 0x1962 0x0>,
 							 <&apps_smmu 0x0c02 0x20>,
 							 <&apps_smmu 0x19c2 0x0>;
+						dma-coherent;
 					};
 
 					compute-cb@3 {
@@ -4979,6 +4986,7 @@
 						iommus = <&apps_smmu 0x1963 0x0>,
 							 <&apps_smmu 0x0c03 0x20>,
 							 <&apps_smmu 0x19c3 0x0>;
+						dma-coherent;
 					};
 
 					compute-cb@4 {
@@ -4988,6 +4996,7 @@
 						iommus = <&apps_smmu 0x1964 0x0>,
 							 <&apps_smmu 0x0c04 0x20>,
 							 <&apps_smmu 0x19c4 0x0>;
+						dma-coherent;
 					};
 
 					compute-cb@5 {
@@ -4997,6 +5006,7 @@
 						iommus = <&apps_smmu 0x1965 0x0>,
 							 <&apps_smmu 0x0c05 0x20>,
 							 <&apps_smmu 0x19c5 0x0>;
+						dma-coherent;
 					};
 
 					compute-cb@6 {
@@ -5006,6 +5016,7 @@
 						iommus = <&apps_smmu 0x1966 0x0>,
 							 <&apps_smmu 0x0c06 0x20>,
 							 <&apps_smmu 0x19c6 0x0>;
+						dma-coherent;
 					};
 
 					compute-cb@7 {
@@ -5015,6 +5026,7 @@
 						iommus = <&apps_smmu 0x1967 0x0>,
 							 <&apps_smmu 0x0c07 0x20>,
 							 <&apps_smmu 0x19c7 0x0>;
+						dma-coherent;
 					};
 
 					compute-cb@8 {
@@ -5024,6 +5036,7 @@
 						iommus = <&apps_smmu 0x1968 0x0>,
 							 <&apps_smmu 0x0c08 0x20>,
 							 <&apps_smmu 0x19c8 0x0>;
+						dma-coherent;
 					};
 				};
 			};
-- 
2.17.1



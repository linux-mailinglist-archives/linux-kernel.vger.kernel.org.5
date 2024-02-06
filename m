Return-Path: <linux-kernel+bounces-54411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A622C84AEE5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CBBD28B7C4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B39C12B157;
	Tue,  6 Feb 2024 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UQHDvEw4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DB312AAE2;
	Tue,  6 Feb 2024 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203850; cv=none; b=HH5uvR11EXhAACCfjvan5klVmw5CsaeQlBdjyboZAl0s1uVNG6AIWhaHkSKLHiWI2yLzrGafvbF3XmZlJhxvwYyHuDuK/wqNCrpCCpTvAyP/Zj4tPotIX3B7xL8UjZjJQ5EOp8uxvNqkm5YrFBk7K/+jzrwvVi/lsHFKE8u5SEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203850; c=relaxed/simple;
	bh=WV7is+GZWotLOyr/LJfdqKxKuPjO3bhLxlur0mKeBeU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d61+q6+CXMnix3VQaFlrb79hSS2Yp7zuvwW9M3w5UP65OTaUyFu8nBFmP56BtEy2yvdfx5NuCjHa05E9YRUxT6CxPaR+oALb3AtiVjs8wGo49m3lwFs0VI7iVJWOwI+zTUHMMP+cbbF75BcZZYte/31Xf/IADFJ4VP53cZafK0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UQHDvEw4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4164pXZc023084;
	Tue, 6 Feb 2024 07:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=XkoTJEI1H9WS/l6Sp9i9Pr6+5+Uqu6NrC2M+bSJ0ppE=; b=UQ
	HDvEw4QZT9xxpKh+vww/Tv+HG3Iifcj6QnyX/YzKU+QlXDgkTHtDBcuYVArXjP0u
	4M+GGDdCfAVNT4M7q2Yxki/tWMh5T32LojSD7mPz98Sn07jFDkbEBv3UrbsoVHgW
	/dgBl/GTnxs5+QPhs1qPGS5jsQhsJyU25uLsnmZ3ucRxMMd1CY3IOUZw6DWlpp1y
	TVisoe3KH9s+eK3WOUiXDcXXVpTyKiZIaAbZn12RaIBvSm9RXv3FwXmvU1YfTyNG
	23pDxw10DO+sdwsY/PbdYNiBd8PYIa/eTjCOSqKMCv2hEpuzASfix8cTRcsAZRD5
	3FRc1qaPDq46XAmbPuMg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w399erset-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 07:17:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4167GBg1010380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 07:16:11 GMT
Received: from hu-uchalich-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 23:16:06 -0800
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
Subject: [PATCH v2 4/5] arm64: dts: qcom: sm8650: Add mapping to llcc Broadcast_AND region
Date: Mon, 5 Feb 2024 23:15:55 -0800
Message-ID: <c2d5292dce25d6b4d4517922766ca66e696551fe.1707202761.git.quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1707202761.git.quic_uchalich@quicinc.com>
References: <cover.1707202761.git.quic_uchalich@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uJ9AN4Gu0BILA2FE2HexwvJbAgDDOpBQ
X-Proofpoint-ORIG-GUID: uJ9AN4Gu0BILA2FE2HexwvJbAgDDOpBQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_01,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=496
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060049

Mapping Broadcast_AND region for LLCC in SM8650.

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 2df77123a8c7..daa5738b955e 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4735,12 +4735,14 @@ system-cache-controller@25000000 {
 			      <0 0x25400000 0 0x200000>,
 			      <0 0x25200000 0 0x200000>,
 			      <0 0x25600000 0 0x200000>,
-			      <0 0x25800000 0 0x200000>;
+			      <0 0x25800000 0 0x200000>,
+			      <0 0x25a00000 0 0x200000>;
 			reg-names = "llcc0_base",
 				    "llcc1_base",
 				    "llcc2_base",
 				    "llcc3_base",
-				    "llcc_broadcast_base";
+				    "llcc_broadcast_base",
+				    "llcc_broadcast_and_base";
 
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		};
-- 
2.25.1



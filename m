Return-Path: <linux-kernel+bounces-118950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC2488C1CB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2BB2E4845
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABDF76047;
	Tue, 26 Mar 2024 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ULr+3ONn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A789757F3;
	Tue, 26 Mar 2024 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455252; cv=none; b=gMetNGirUfI6i9i+BKIZYpSBIBNviXW6HkHZSuor284GsygoPp/C9wpxF8KxU91Wtx55GXbz3j482oQzW648dYsWGFT0ddk91RHGzINqwA3VLocM+UpCkNUAvQ5XuZQbh2NdTEmYDzm7ybgppQ0xm7ZpSvWoo4SW1EQlGe7EZ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455252; c=relaxed/simple;
	bh=lnS95bunV/EH9UhcF3G/sCrMeEzpcJBQkovuEjBYQDA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXj2cAMk5mdMXgUeS5rCOzoo1OoJyg8rO5gcNx1jAbHBmTdaeMEWIbQ48rKl/w4zAsSikViOBJmfv52p7UKo7um0d6bPRMLH3oLtZP3MHruk9UciYJ2Mto4dkDTyhV1bDctdp8vMxzuImpEKp2i96ryQ5mHLviJdrqdlyWvKYYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ULr+3ONn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q5o2t5028358;
	Tue, 26 Mar 2024 12:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=9CHl93Q8DRAjWAYjiISTKY13GhosV9C3yA+9XS3PrZ8=; b=UL
	r+3ONnGKIgpExC8nhxqL743YNcQXR/197z1uEza2dV1f0JpiDPDSLvh6fqXPEDbj
	gggk/B8XuuNm+4ntSFZVQYu5AxePamTitme3vUUhCkRhcm7Y4x9+4M8tGJplAOD7
	6tegn9QKMdpz3fHExpWyKb7BePa39xEz0grmwWLPgMtHedcus6LFFT/rIAMO5tzT
	v3IdPr3sm7EKyDbM/FxGIKuXqdzUgcmi9op8D2kKkFbh8aGnPNHsop2QjXZ+Lj+r
	EDf59PJ8mQY4lekdPktcYaJsEIpef0YAlS9HgqYnO/yyyrqcRlMLdjLdxkmhA3Nc
	08iwUd3UsLMAUGzpOwzA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3rj2s2hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 12:14:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QCE7oB018243
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 12:14:07 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 05:14:02 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v3 3/3] arm64: dts: qcom: ipq9574: Add icc provider ability to gcc
Date: Tue, 26 Mar 2024 17:43:12 +0530
Message-ID: <20240326121312.1702701-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326121312.1702701-1-quic_varada@quicinc.com>
References: <20240326121312.1702701-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xnYTdYJnw1Fms-THyJm5gw5muHapmykl
X-Proofpoint-ORIG-GUID: xnYTdYJnw1Fms-THyJm5gw5muHapmykl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403260085

IPQ SoCs dont involve RPM in managing NoC related clocks and
there is no NoC scaling. Linux itself handles these clocks.
However, these should not be exposed as just clocks and align
with other Qualcomm SoCs that handle these clocks from a
interconnect provider.

Hence include icc provider capability to the gcc node so that
peripherals can use the interconnect facility to enable these
clocks.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: Fix include file order
    Move to separate patch
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 7f2e5cbf3bbb..5b3e69379b1f 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/clock/qcom,apss-ipq.h>
 #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
+#include <dt-bindings/interconnect/qcom,ipq9574.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
 #include <dt-bindings/thermal/thermal.h>
@@ -306,6 +307,7 @@ gcc: clock-controller@1800000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
+			#interconnect-cells = <1>;
 		};
 
 		tcsr_mutex: hwlock@1905000 {
-- 
2.34.1



Return-Path: <linux-kernel+bounces-122558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6EA88F974
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0BD11F2F5BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F4C651B2;
	Thu, 28 Mar 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cRgQ4w19"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ED1657B0;
	Thu, 28 Mar 2024 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612881; cv=none; b=jMme6ESJDP9xJzmbGzFEaDqSeQJZI7i3Ku+ez5qqPLfQkBCBhLSBp+28l22SWF/bqzpNOnIKc79m6zIel2C0elY1R3CjR3LtEay1b2ly3c1zfM7mll3Xs6de70G2NWDGkG0E8t9pvA3qrtbcVch4bdUK+9oqy7XpBwSbp5/UGCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612881; c=relaxed/simple;
	bh=lnS95bunV/EH9UhcF3G/sCrMeEzpcJBQkovuEjBYQDA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nn7lH2oMYwx78qg5cL3sxBpRORPvQ9XADTZYfaJhYe+3xYsuHmue5zVW+AOkaMZCkUUdwMhQvuD6lmu/J17u0Om5G/RWsOuYA9kTJsZBdZpcMs7gIwtSe/Oq913IH0f45cikxWHt6VXeYlOa1vghNiE1aCHsP61SiOaQxJZZg/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cRgQ4w19; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S6qqCd028045;
	Thu, 28 Mar 2024 08:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=9CHl93Q8DRAjWAYjiISTKY13GhosV9C3yA+9XS3PrZ8=; b=cR
	gQ4w19SfWkN9xcN8GAG2T20HVd2hGpVPg9Wt/J2cnB9vOHSo9DJwHpkSQrkmbKsi
	0wqFxGhRi6M6QHXQeTtw1L4LLKlgg8tyagw0m3C4JdmQKZHfE5DSDO/uFn1qSvCs
	4XulNdi3KHzq6sBlsxpfbj69Mk34z2UezfwBIw8bBmpfKfTkRifO6C0TJjv41Af0
	QwG86st2hApH8JGTZ7lktsDlXgXZmKU5HeRxxHqbp1W6L/cj8r1aD5FE2DjH0sdK
	kNwxJZF41LfgJ1QzvpelNdU5rbJnCbLI/MiA1Cf3SgWu5ZXvj2c8UvtMGFvnt7gA
	PtI3Wst7hAMqDLFVJ8zA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x53nxg8ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 08:01:15 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S81FoF032666
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 08:01:15 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 01:01:10 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <quic_varada@quicinc.com>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v5 5/5] arm64: dts: qcom: ipq9574: Add icc provider ability to gcc
Date: Thu, 28 Mar 2024 13:29:36 +0530
Message-ID: <20240328075936.223461-6-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328075936.223461-1-quic_varada@quicinc.com>
References: <20240328075936.223461-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: 5LtL_ZPHX62bXERG3HLXtmNbS9LFN_uD
X-Proofpoint-ORIG-GUID: 5LtL_ZPHX62bXERG3HLXtmNbS9LFN_uD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_07,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280052

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



Return-Path: <linux-kernel+bounces-163425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DECA78B6ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811F41F219B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE0F7BB01;
	Tue, 30 Apr 2024 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bw5fozyq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92D1548FC;
	Tue, 30 Apr 2024 06:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459392; cv=none; b=Lu8SqYdvaVW1et780Jstt1VkRIg2/EYgS7+dKtllQovhpoID+BYm4LXszRkhjEWzK4u/Bw/8etxAOkHIv7QKutiI/InlU1LPAIlxBs8KPENchlTL6c4+5sIAj8EP/1tluwFtcNxx8VmCRuHgdvcaw78A+686pBS2HOv5TWFeY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459392; c=relaxed/simple;
	bh=T6AypkH3WpV7sX0/al8Y8+9eYsNDm9sgfT2ZqgdoI8k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhFECc9usB4chSVQIRI3c8DTqSSQXarYGl+7JekIQwxEEchR47U6OVQnfcu+N6gXx/gigekRxpKFIFa8JRLb2OsYhZLZhaxxgFirdGW4h5Db3jpQvpUFgLTcGfhDKYuBqSpRYBUTg9/DGK3Ruz8Tk+yr7P70T5vs8Mni9bWxymY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bw5fozyq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U3Hsuu015072;
	Tue, 30 Apr 2024 06:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=XQz0y87xjJzpSve+PFnGb8Dxx4cy4BCAlvoWDerKyCU=; b=bw
	5fozyqV7T0+Ihg8Fx+8PsGHvs7TNuezvT8t5UyLgLFJZ+PD6W6iqJplaLLjEEduk
	GETcjmQFm0YTMjnCETuND1mZUGXIhydZg4/R5eKHx+lcYzZHtaOE02nain2Dh503
	dmonTbZ/6ZIeNeWau7MTLpei5hlJEV44MN3IOa63piXVwyde3mqDGjEVG61JU9BU
	wG4GSsbRLYBorGfIDTV+D66cLazoDZ0YQiCIN6qxXeX/SwpJQF85HBzzCk9ZoYM1
	97DON8MJBoKjtgjN0/ld3mtRx0VOV+1I/jZ4Q+SntzgGYi2dOqc64B6CgeRb+GLf
	TrsC8MavzJRAawaAVmUw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtqkr8qt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 06:43:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U6h5BN020109
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 06:43:05 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 23:43:00 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_varada@quicinc.com>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <bryan.odonoghue@linaro.org>
Subject: [PATCH v11 6/6] arm64: dts: qcom: ipq9574: Add icc provider ability to gcc
Date: Tue, 30 Apr 2024 12:12:14 +0530
Message-ID: <20240430064214.2030013-7-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430064214.2030013-1-quic_varada@quicinc.com>
References: <20240430064214.2030013-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: hUTFBXm4d2cMlguQjPHsSW-aLL-sLWz_
X-Proofpoint-ORIG-GUID: hUTFBXm4d2cMlguQjPHsSW-aLL-sLWz_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_02,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 phishscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300047

IPQ SoCs dont involve RPM in managing NoC related clocks and
there is no NoC scaling. Linux itself handles these clocks.
However, these should not be exposed as just clocks and align
with other Qualcomm SoCs that handle these clocks from a
interconnect provider.

Hence include icc provider capability to the gcc node so that
peripherals can use the interconnect facility to enable these
clocks.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
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



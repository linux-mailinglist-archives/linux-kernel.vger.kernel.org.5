Return-Path: <linux-kernel+bounces-85216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D1B86B260
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805A91F225A0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F9315958B;
	Wed, 28 Feb 2024 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EO/ap93A"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854315B98F;
	Wed, 28 Feb 2024 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131939; cv=none; b=FxOIZZGeGI9jPRLxxk0+SLG+xloeEkH7V3G/5xT5UFuNPWo3lAc/kDsJ0POro6qo3XF7l1t9AIw/6y9BGsLGC3COzNQk2G9DqiVRajM0/YYDoraKunwZuqEOQDk3gmbNieRoaxLW9ON0KM53AgRmpQc5FppoRO0+YMRsfPYKWKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131939; c=relaxed/simple;
	bh=nJ+h5SrpoqCnr+AuOdGy/Y4dHY5yFsNqFMSxwu7NTs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kKPVJlOFUVsTW3xKK7c5cWteDN2u5qozIcdZBC9y1frl8UbeLlUG1DssKFCIxWWZ7NrtZ9PcgS+qC2aJY2lSQC53uXedrBBT1kimbWhzu6DnYSpx2EmvWzzwtg0ICeSuHjXN7sjlIr54s5XeWLSgVbjNV4h1nr6EzzxUrmm4RSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EO/ap93A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S9meOn013885;
	Wed, 28 Feb 2024 14:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=RrGzM9AFZ8vD7OC5fymtCnpLsV5VA5IhScqDINC/pmw
	=; b=EO/ap93A7E5/RcGKmK4zvIbMQVwOHWzV3Y82vCEX1uqs0K++RfFpkwH0epe
	jVOua2l7do6xMeu2m/0JH8zJILWhEMYiGABRCaNphzB3dU0GAN871xlpF+/gs0DS
	g3iv3WocrMyd4jbXvGS3A3kf8UsbzcSsKFMXIf5DAmcbHjyJBjY47lOpD1kw46mc
	xyxrE0kKSw5jbNvxlg9ybnIi3UsmwMPdQE2ZggV0c9dwwD2Yt6xCZ3jk5PwMY+Wl
	TXPvrEJgOlslZxl97Yf7RD6XL1K4R/vaTday9JVUYdX6YEH8bSdejB1wNpe2WoiC
	EMf9/Qwu+Sws1ckNMSfcOdOaXeQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj0thh0b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 14:52:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SEq5n4017328
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 14:52:05 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 06:52:01 -0800
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date: Wed, 28 Feb 2024 20:21:49 +0530
Subject: [PATCH 1/3] dt-bindings: arm: qcom,ids: Add SoC ID for IPQ5321
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240228-ipq5321-sku-support-v1-1-14e4d4715f4b@quicinc.com>
References: <20240228-ipq5321-sku-support-v1-0-14e4d4715f4b@quicinc.com>
In-Reply-To: <20240228-ipq5321-sku-support-v1-0-14e4d4715f4b@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Kathiravan
 Thirumoorthy" <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709131917; l=657;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=nJ+h5SrpoqCnr+AuOdGy/Y4dHY5yFsNqFMSxwu7NTs8=;
 b=q1Gq9xZUED5NDRidMv9qEDVxLk9yXLmLxClk4MXMIk0b6TzzG6NmwiO5kZDhFPmj5CFpjFYAU
 +eS2WFkPzm7BWjvqbjOVjfioQTI3qGz6RjhdQQzfRjP2GgGJ179ncqQ
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Zvj3VGm9kINUmve6R_6ZjUj0RLWFiGW5
X-Proofpoint-ORIG-GUID: Zvj3VGm9kINUmve6R_6ZjUj0RLWFiGW5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_07,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=741 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402280118

Add the ID for the Qualcomm IPQ5321 SoC.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index 19ac7b36f608..4563b1fb7a3b 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -271,6 +271,7 @@
 #define QCOM_ID_QCS8550			603
 #define QCOM_ID_QCM8550			604
 #define QCOM_ID_IPQ5300			624
+#define QCOM_ID_IPQ5321			650
 
 /*
  * The board type and revision information, used by Qualcomm bootloaders and

-- 
2.34.1



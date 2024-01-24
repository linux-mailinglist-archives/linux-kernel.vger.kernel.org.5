Return-Path: <linux-kernel+bounces-36311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89152839F35
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9951F28056
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1E1BE45;
	Wed, 24 Jan 2024 02:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GIF6WPtW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8229C46B8;
	Wed, 24 Jan 2024 02:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063623; cv=none; b=UHzqtmhL4mrAgXQ0Tttl2e2ZHiKPbV6vYqE7AY7xSjRtQ3SZGzz/d/tSr/h6GXSHsKOKRTmitMALXZjg2bNItXzuKBdqqDJu0fjV+F3ZRQO7KC+TEv9euGC1qATuIBvvjS2jiTTsXn0HAecI6nOtOofO8cadhAWa7Ak5QHXHhMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063623; c=relaxed/simple;
	bh=oBj4cUvOmEQkDk7mx0oiNf6rouHb04eHY2m+jPYhUzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmaZvuRUzn2ro9iTeWsnrhEBNWa/q5cPN0mL+oO/xHENcPtjb/UpDmZYoAkwULNEwrosIe+WXdy88deyF9hQSI0vKTu2mrvh8oFaUmFULJHwSMeL5n2Vs3Vwt9aEnfOv78d3RVCco+0aP8GaiFW9IjmOsxS/4s6jIJm5d12EC/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GIF6WPtW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O0JYhK006806;
	Wed, 24 Jan 2024 02:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=nqYU8qWnfg/5NERgRIwH
	iT1shcUzfnzUaH//2QLuUOw=; b=GIF6WPtWRvYe0GAdO4xxKnPaO459uOaq7x5/
	l22pfTi6pONiQXptGuqdfrtVz/SoXGdLkgwMsVn8QZR5brzdLEZXHuLMd55mYXMv
	McfZMP8KqNZW1T/88isRo9yuaYlDRp1MhfbHibca6iJUCBNuHO/f7igBvnbxWlZB
	1d/THLTousveIzqRLbDHokRCfyKNr1E7isBknzzVqbMnpxXn+w2a5DXbJM0Jg/84
	yx5FZse8LO25EO6cBiyeSBBBU+l3zyV+r2ivHXztmOganN31+XhfY9sarW+hYxjJ
	1JF6p8849AiHn9t2LqYJPG08yOEdgGdpmdv6/uBFXVu60jGxRg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmh00jdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:33:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40O2Xb3c011214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:33:37 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 18:33:32 -0800
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: pinctrl: qcom: modify the wrong compatible name
Date: Wed, 24 Jan 2024 10:33:04 +0800
Message-ID: <20240124023305.15755-2-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124023305.15755-1-quic_tengfan@quicinc.com>
References: <20240124023305.15755-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: l7U2a16MhGio4OoCJ8n5qmQbK8G88qv5
X-Proofpoint-ORIG-GUID: l7U2a16MhGio4OoCJ8n5qmQbK8G88qv5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=796
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240018

Use right compatible name "qcom,sm4450-tlmm" instead of
"qcom,sm4450-pinctrl".

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
index bb08ca5a1509..bb675c8ec220 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
@@ -17,7 +17,7 @@ allOf:
 
 properties:
   compatible:
-    const: qcom,sm4450-pinctrl
+    const: qcom,sm4450-tlmm
 
   reg:
     maxItems: 1
-- 
2.17.1



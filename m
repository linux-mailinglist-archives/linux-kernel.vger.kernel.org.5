Return-Path: <linux-kernel+bounces-42447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60089840175
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843891C21B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F22859158;
	Mon, 29 Jan 2024 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U79QQW5b"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240E857874;
	Mon, 29 Jan 2024 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520346; cv=none; b=dtfgn+BWLQfWvOyTE/40dxnD37HGvsjfAAL3pqtgNTa99ac+oTVF00XWn2eNqXPcHqWpLayrFcZzpkvQXa4diqALPin+wpgwB5pzPGTp0lV6uiAcMCp4zP7bYk97qjcEhsST+SMJayhW+MnxgQwJgty+ELsJhbdzHNBGh61vnuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520346; c=relaxed/simple;
	bh=92k2dV2ggFp6ut/4hYFtZ9DnRqdm0FJ/xgutMtGiUkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgmuVxcj0QF+koGNIq8Bc4V2Q0wzNHXgFumUJvwnE18IybYSOXdzS+UYKdSgPAxaGCyeNAQrYXtFajl63igN3ttRxjv60NcGDCxh1Gdt1Wqmt7sCaPl3NwLOQkBOwUNdyezLyWCqTpHmKr1jSjw4aT4Np3B8RkHgNJ1/Eqc0tN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U79QQW5b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T4j1VP005191;
	Mon, 29 Jan 2024 09:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=TNqxe0KrKJCpHyFC36uB
	SC36g41wW/00uXPGjWX9yMU=; b=U79QQW5bWsh0C6i3UbsQ8kU3jibwnkBPx4Xl
	OhVmVk5pt6Ka14hix4oaMKL05tmYleahSKLzryn3n1gdt958pTBmKH8QWP3dGHUZ
	GFg5Lg+edYys6WC8hT702OfVfHugoUd0+Oo3lf82/VTQsDmBmLOiQ2cgTLxE4gXW
	WRP6t+6jG1xB+TjW5eYBxkTOdGsHCNsQTyDilc0BWW0DBhVQAmXdf/tpVH44hxoL
	DOA9cKhWuogT6lOSaPRSXFY6Z8V3S4Aq5BjWMLVOghAXTJBkSEBnBIjmu/LcRmPj
	kQSEtsLSrydc6FxU4Bv7MbjTxzFqkeaRC+hr75C+dg4bEvOKuw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx3rqgm30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 09:25:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T9PdOZ028735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 09:25:39 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 01:25:33 -0800
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: update compatible name for match with driver
Date: Mon, 29 Jan 2024 17:25:11 +0800
Message-ID: <20240129092512.23602-2-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240129092512.23602-1-quic_tengfan@quicinc.com>
References: <20240129092512.23602-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MpJSBMNzx88rrOJ3-1-d-c0wxBr65AJk
X-Proofpoint-ORIG-GUID: MpJSBMNzx88rrOJ3-1-d-c0wxBr65AJk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_05,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxlogscore=853 spamscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401290066

Use compatible name "qcom,sm4450-tlmm" instead of "qcom,sm4450-pinctrl"
to match the compatible name in sm4450 pinctrl driver.

Fixes: 7bf8b78f86db ("dt-bindings: pinctrl: qcom: Add SM4450 pinctrl")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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



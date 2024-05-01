Return-Path: <linux-kernel+bounces-165037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589C68B86EE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611AD1C21DCB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EE6524C4;
	Wed,  1 May 2024 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nADJAvVC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBAA502A6;
	Wed,  1 May 2024 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714552372; cv=none; b=GRcLQKsvVd+GONPeP4sYvd/rCcsD0U8wpNsGSs/TxQocYRIgirhWB8VngIoHpt7d5vFWqUiAcHMPoywO3fmFURu0jkqShjre4FOuDP8BA8hltKFRLk3yrN54urFMgUtmbl0cvaZ8g1UV1dy53HlY++yfY8hvWzyGUweOMbHlccw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714552372; c=relaxed/simple;
	bh=trPaH2wyrIlkFi7z539a415V19+XREbMpJPBZ22K7jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WlIgO3ISS/si1ytkzq5GJXTcPl+j2Zw7OsyvU7dGx9YWZtxYVBoufJ5QuH7VL9zpWqz77J2PXVCdCBcAPFVqSMhSG/TL3VobwS2s7GerRTKhEteF8cPHrx51ppALTyVQQzGXT+AdNDtDd/GM0wedfcp83Qpz/UiEzU2OqnWyIuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nADJAvVC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4418MEoN027237;
	Wed, 1 May 2024 08:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=Fbpnjq+hrN2ZFdP92/aGghpDR97OsU6F/Bfdwd+aiYM
	=; b=nADJAvVCKsXwK/9/B+BGKAMmQrhRtsRIukSj0elSLJbP1zxp4R9pMtIUBoK
	ryPm/Ik2VoQgB9A900oTEhgz+rSWh2Bov2tcNB105/4xZaLTGA4IPCaadHS81ZkC
	bGRAhdODd20bqMTkRqmdch3+lI9mH7qvp14tKrgEqqc/qSTJGvYCKpYZTlxpm5GS
	iz54lKYt4jhuaW8GvKaCSI0Oeoc0486MtranQCmmHrIhKblOzNHsvP+P1ktCZIsi
	1FmdMDC1VfpaR1moR8Nd0eTptx6sE4R6UprKC4VkD5AMPbnrSY+VMM+6exa31Kda
	Lx7ZK8ml8RW1q99M748uVQ6samQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtvf7jycy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 08:32:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4418WWfe017894
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 1 May 2024 08:32:32 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 1 May 2024 01:32:28 -0700
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Wed, 1 May 2024 14:02:18 +0530
Subject: [PATCH v3 1/2] dt-bindings: clock: qcom: Add AHB clock for SM8150
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240501-videocc-sm8150-dt-node-v3-1-2c4bd9ef48bd@quicinc.com>
References: <20240501-videocc-sm8150-dt-node-v3-0-2c4bd9ef48bd@quicinc.com>
In-Reply-To: <20240501-videocc-sm8150-dt-node-v3-0-2c4bd9ef48bd@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Taniya
 Das" <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        "Satya Priya
 Kakitapalli" <quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _C_8vJOcoyC_5WKDmYPfwaPgLJ9iOdgP
X-Proofpoint-ORIG-GUID: _C_8vJOcoyC_5WKDmYPfwaPgLJ9iOdgP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=970 priorityscore=1501
 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405010059

SM8150 videocc needs AHB clock, so update the bindings for sm8150
to add the AHB clock.

Fixes: 35d26e9292e2 ("dt-bindings: clock: Add YAML schemas for the QCOM VIDEOCC clock bindings")
Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 .../devicetree/bindings/clock/qcom,videocc.yaml         | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
index 6999e36ace1b..68bac801adb0 100644
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
@@ -75,7 +75,6 @@ allOf:
           enum:
             - qcom,sc7180-videocc
             - qcom,sdm845-videocc
-            - qcom,sm8150-videocc
     then:
       properties:
         clocks:
@@ -101,6 +100,22 @@ allOf:
             - const: bi_tcxo
             - const: bi_tcxo_ao
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8150-videocc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: AHB
+            - description: Board XO source
+        clock-names:
+          items:
+            - const: iface
+            - const: bi_tcxo
+
   - if:
       properties:
         compatible:

-- 
2.25.1



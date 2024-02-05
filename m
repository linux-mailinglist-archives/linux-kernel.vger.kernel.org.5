Return-Path: <linux-kernel+bounces-52865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD5849D95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2941C22C5C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBECA2C6AD;
	Mon,  5 Feb 2024 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E1FUtBUd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBA02C69B;
	Mon,  5 Feb 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145068; cv=none; b=pXEx2MSveJNEX6p/TG0t5ibHM2r9ugT/fZ3wC9unI7IxV7uCQqsBD3RxoC7y8df37SKoFwATHt3nbwKzpxMDjWAz9rVnC1nwG6C9029d1cj0q9cvJPGfSnmYgLjFCGoJHhUDqPxKTKJTPO3is4Dh5SagPC1swKL+6kCqAG8Lnaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145068; c=relaxed/simple;
	bh=J8rAfTB8Dz0cD0ouGjdO5KN4NNn2oSqBrYvKTdOIgjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUNHMU4kAN+rFPDm7dlTypkIhKlyQLxmtQUqUIMq1Gar59B/G60vUfbvwzSY4ajnyABhIw64wgmJi17ELuaN704KaZVU2CEV+IOADMhMS1o622vIzT7i1hzw4V7CQkfhjCcjzNhI4mtJ+rhtdLhwWWuz3voQmYnBtZVPBwB5SA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E1FUtBUd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415BaYWg022509;
	Mon, 5 Feb 2024 14:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=oZo2YnbccVAuXSnZc+lW
	Ut35fh0qCOdd/MVID34SqTg=; b=E1FUtBUdnQGiuQbw1U3Cg3a7hLs3p7wY6gBl
	7emg446FcRBzpsD4l6ZYRUsfkinNBx6nlaggO8FaoYXo+4DVj26FrSlIEjHlJyTG
	MxbjIAY/rgxW3wCN8gMRYWSFaka33s2tlKFf1mp0xlD8Z26b00a9Uu9JGJAhQix6
	zikh6HHl1yB7QbvpXgcBAesqNVZIhSOUD583NQa4sUcHjMOU2bOYDzMm/m8dQHiD
	Qf9/4vc4FS1EOYQtEMbmrQUlZ3/qVOcvmp46QXanTH/lT3gHS9N28IDH+4r+rSUQ
	6SfmvHD2ADXjI23OSeAxsoI7w3UuPbgmZeW0zYFsZ6rCXNMmOg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2rjts9cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 14:57:37 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415Eva6G025965
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 14:57:36 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 06:57:32 -0800
From: Odelu Kukatla <quic_okukatla@quicinc.com>
To: <djakov@kernel.org>
CC: <rafael@kernel.org>, <corbet@lwn.net>, <linux-pm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_okukatla@quicinc.com>, <quic_viveka@quicinc.com>,
        <peterz@infradead.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/4] dt-bindings: interconnect: add clock property to configure QoS on SC7280
Date: Mon, 5 Feb 2024 20:26:05 +0530
Message-ID: <20240205145606.16936-4-quic_okukatla@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240205145606.16936-1-quic_okukatla@quicinc.com>
References: <20240205145606.16936-1-quic_okukatla@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LJrzI-Jz-hPeXaiooKZ8MFuluKTmADIO
X-Proofpoint-GUID: LJrzI-Jz-hPeXaiooKZ8MFuluKTmADIO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050111

Added clock property to enable clocks required for accessing
qos registers.

Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
---
 .../interconnect/qcom,sc7280-rpmh.yaml        | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
index b135597d9489..758a6e924037 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
@@ -53,10 +53,50 @@ allOf:
       required:
         - reg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre USB3 PRIM AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: RPMH CC IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-aggre1-noc
+              - qcom,sc7280-aggre2-noc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
+
 unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
     interconnect {
         compatible = "qcom,sc7280-clk-virt";
         #interconnect-cells = <2>;
@@ -69,3 +109,12 @@ examples:
         #interconnect-cells = <2>;
         qcom,bcm-voters = <&apps_bcm_voter>;
     };
+
+    interconnect@16e0000 {
+        reg = <0x016e0000 0x1c080>;
+        compatible = "qcom,sc7280-aggre1-noc";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+        clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
+    };
-- 
2.17.1



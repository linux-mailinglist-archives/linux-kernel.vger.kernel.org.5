Return-Path: <linux-kernel+bounces-135448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DB689C2E7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE7D28202C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAB312C53F;
	Mon,  8 Apr 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BEpyQ0jT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3E1129E8F;
	Mon,  8 Apr 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583034; cv=none; b=XWOpC/wSt2OOafvXKEqmGxJLdXYwVT91oykC2dXDKk+W/BC68pmwb/URBIMZ1XVrY1loxEII+hpGF4M6qlTqxHuJ1z9cNKGFX8gDNPISkVtgAVHloiv/gyj0o7zdD18a28DqWLudekGhCfei0tRMljXSOeoKc1Ohqun8//I/OE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583034; c=relaxed/simple;
	bh=U08DR0CT+VX4I/1rf8xBMPVKZb7RVIOW5ecciVZ/898=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPIUKivpcHZ9ZtpuRxvocpcKTTwsmRfgJyYgQLwTjs6Ffgu28RiMAP+7DEJ9SB2o/v3qodo9NGor9wkXy8Yi0HCfgX9wk8oc5cNUW8Swa2qsWBFt2X3dpAoqCuNG6M+V7taP0YLwgpx0xquCI1HgrqIe9YPbIb3BITc0nQxfd+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BEpyQ0jT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4386cmoi024126;
	Mon, 8 Apr 2024 13:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=on4AWLn93ibcFSQpwiEvZLq/uMGCeteTx7c8FxvaK/c=; b=BE
	pyQ0jTWf1eN6FrjQQ5qhlzhD1ngudRAdUpQbklv08z6zAi2VtVsIf1XaEq97vLrp
	+1KCtGFwYZkn10mJtnS1SmTe7ZV+CnyKKrXXiSeQZYLX6Cpx8wRKMxLEeegRgaoT
	A1wiQLGX36BACP2YvzGWm0vUJLmltqZtkV4XAguoSSJiFzpXzcpG/tI0u/DhddYX
	zrMRbhyMqXg376F25W99YsrCGK91or+IB6CrS6vOLzuZ7tP8522uGUAUxfSSd1IK
	82bptXlMGpv6Octx2vRzRoYhnA8aqsZ4psNzSPubmzumy7Wz9NKqLqPePQwxbifr
	o9aJv7NBf9UHCPP2MiWA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbg2rvme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 13:30:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438DUE5j022944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 13:30:14 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 8 Apr 2024 06:30:09 -0700
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi
	<balbi@kernel.org>, Johan Hovold <johan@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v20 5/9] dt-bindings: usb: qcom,dwc3: Add bindings for SC8280 Multiport
Date: Mon, 8 Apr 2024 18:59:21 +0530
Message-ID: <20240408132925.1880571-6-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408132925.1880571-1-quic_kriskura@quicinc.com>
References: <20240408132925.1880571-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: seoNAwo3BsuLtWC5uXg4kD7NxF58VZE3
X-Proofpoint-GUID: seoNAwo3BsuLtWC5uXg4kD7NxF58VZE3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_11,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080104

Add the compatible string for SC8280 Multiport USB controller from
Qualcomm.

There are 4 power event irq interrupts supported by this controller
(one for each port of multiport). Added all the 4 as non-optional
interrupts for SC8280XP-MP

Also each port of multiport has one DP and oen DM IRQ. Add all DP/DM
IRQ's related to 4 ports of SC8280XP Teritiary controller.

Also added ss phy irq for both SS Ports.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/usb/qcom,dwc3.yaml    | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 38a3404ec71b..f55f601c0329 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -30,6 +30,7 @@ properties:
           - qcom,sc7180-dwc3
           - qcom,sc7280-dwc3
           - qcom,sc8280xp-dwc3
+          - qcom,sc8280xp-dwc3-mp
           - qcom,sdm660-dwc3
           - qcom,sdm670-dwc3
           - qcom,sdm845-dwc3
@@ -282,6 +283,7 @@ allOf:
           contains:
             enum:
               - qcom,sc8280xp-dwc3
+              - qcom,sc8280xp-dwc3-mp
               - qcom,x1e80100-dwc3
     then:
       properties:
@@ -470,6 +472,38 @@ allOf:
             - const: dm_hs_phy_irq
             - const: ss_phy_irq
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-dwc3-mp
+    then:
+      properties:
+        interrupts:
+          minItems: 18
+          maxItems: 18
+        interrupt-names:
+          items:
+            - const: pwr_event_1
+            - const: pwr_event_2
+            - const: pwr_event_3
+            - const: pwr_event_4
+            - const: hs_phy_1
+            - const: hs_phy_2
+            - const: hs_phy_3
+            - const: hs_phy_4
+            - const: dp_hs_phy_1
+            - const: dm_hs_phy_1
+            - const: dp_hs_phy_2
+            - const: dm_hs_phy_2
+            - const: dp_hs_phy_3
+            - const: dm_hs_phy_3
+            - const: dp_hs_phy_4
+            - const: dm_hs_phy_4
+            - const: ss_phy_1
+            - const: ss_phy_2
+
 additionalProperties: false
 
 examples:
-- 
2.34.1



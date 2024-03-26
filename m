Return-Path: <linux-kernel+bounces-118798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC0488BF7F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179D21C3DE2E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72107640D;
	Tue, 26 Mar 2024 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KNmdeg9Q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1C763E5;
	Tue, 26 Mar 2024 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448981; cv=none; b=iCPwqx8owcfNIbM+s6VfxV+OlgroMDVwng6CJyPv113O0iqIqmJhWaQkZ9uyHudUdHKtAtwJgZdYZ6DT3l8KYkDsUXNKiKGRn0WxSs2jP7wYHGBbKKp5OolRC/kcL4CGhUxzvqWP5xkeevtFWnHUQPTJxzcmBniWL6uRI9dC2kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448981; c=relaxed/simple;
	bh=U08DR0CT+VX4I/1rf8xBMPVKZb7RVIOW5ecciVZ/898=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlO+wtLEwf9xiwei+pzWPcynXwdr0n/q4FMEow2bsOvMenusMfVByqOMTEOW0z6yFIQggsPbxQfMcO/0LjuCv8hEql9+W+1JI2mL91F4D6B+MgXtn7B0pyM5j5Scj/R08ZjUOm632tIpHxJBCWOJm8Gn53TEGdlezjDl1ZynneI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KNmdeg9Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q5nsoR027718;
	Tue, 26 Mar 2024 10:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=on4AWLn93ibcFSQpwiEvZLq/uMGCeteTx7c8FxvaK/c=; b=KN
	mdeg9QWNHgAUZMOLFcZRfgkvO1ZaGf4eHFoZZ9pFma+5ku0gcNFHj6eLLAyk8tIU
	y9Hl6+FHUIyU/gsfqrA2+wLVhIc7+wphtHAzzYrP7Ow3+9Ft1dGRvs+/W3yKuH15
	AQsV2sogHaTaWNIhyggiAjunolEKb2SnK4imZO6BonAyYxFOnH8LpN7xlJNnFHJ3
	YZ3+P1Ul4PLaNeXhwFwXK0OCwAIxi7claZJ8Dxij0CLL+Xn/kwjnSULnJ6++95mD
	ib4S1TyJrz1iafr50F6hDo2yDGE1qSW3tHEA98NodNTM1cw6t89GKMg+BcCPFbB9
	V8nNFS5cAaJFguqeaTRQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3rj2rrbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 10:29:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QASwip000559
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 10:28:58 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 03:28:53 -0700
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
Subject: [PATCH v17 5/9] dt-bindings: usb: qcom,dwc3: Add bindings for SC8280 Multiport
Date: Tue, 26 Mar 2024 15:58:05 +0530
Message-ID: <20240326102809.2940123-6-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326102809.2940123-1-quic_kriskura@quicinc.com>
References: <20240326102809.2940123-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: kfgAr0HldWKjHMt9U2jnKH8aI8oMzAqg
X-Proofpoint-ORIG-GUID: kfgAr0HldWKjHMt9U2jnKH8aI8oMzAqg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403260072

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



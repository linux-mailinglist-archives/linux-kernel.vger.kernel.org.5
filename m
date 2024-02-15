Return-Path: <linux-kernel+bounces-67018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561D58564DD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B6E5B2E142
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F4C132466;
	Thu, 15 Feb 2024 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o3+mvCQj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A8B131744;
	Thu, 15 Feb 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004977; cv=none; b=nlBw0syyWApLTg+kYq6lPHKgal0Wk4R1vZs8McZgXUVTXEpNJcZ3fvPt7LwC5LU9eN/IeQXzvF/IR1HIaRlpHZTul2AQR9efTRHBMMM7MDj5UGuYvNjcgJV+Dzgh6ep785ETVJsojcI2PV74pobsGPYFax3mKR3bzeDomgb6AaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004977; c=relaxed/simple;
	bh=4m6WHNHSZEAxLd5n23MxDfxQ7xAhQ33idEMY+fHGWs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P4Qq9DZrIkMr/pckk3imbOSYS2PmP0LVPLm8lxSEs6cT4ikg+GgidqnmujFUXam8nDDVs/DWa615wMKxJTId7PklUnlHn5MNTAg/3V1vB/UW+wqTpi+z+MnSyiAhARbSx6g3ZWgRtOEc39HapI2u0HrIEJ0A+0phdnH1aKKezEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o3+mvCQj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41F82baJ007873;
	Thu, 15 Feb 2024 13:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=m784UBK
	fnVP3zslH9CwdUNSAfaXgSLW3wjilU88VGAA=; b=o3+mvCQjPSJgsJc3n9X6kj9
	vvSNyCd2cxbNQ9Ok9d+7poyyM2pV/WSdOWYYU7Cm4l+2jrSbfhAfRfuYEnafbl4n
	ThzKQeRsGr3qjuRaSOV6suahwfmrBuY24j1h42Jocl5x1GWE8AgVJtW0+2rP5UHl
	A6iUhOckpyqGZW5YDash0C/7jo4BxS4eAfMOoNxiruWD+nRxuY93yP/i9pCHRDw0
	qbY9AUj346SNdbElehIqL2gsNVtE7ZmmUtEFHo4rQfip89bGcWmm8UlK3yqzH4Fl
	+2jYsa1UW1DtGlHR9aa6qADWGEcPP0gsMgivYmkz5j3B7vA1KFYi9tJqBHRcOSw=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9435sx8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 13:49:11 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41FDn8DU009960;
	Thu, 15 Feb 2024 13:49:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3w627mb928-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 13:49:08 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FDn8qS009928;
	Thu, 15 Feb 2024 13:49:08 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 41FDn8Oi009924
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 13:49:08 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id 5FE9841355; Thu, 15 Feb 2024 19:19:07 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org, broonie@kernel.org,
        robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com,
        quic_mdalam@quicinc.com
Subject: [PATCH 1/5] spi: dt-bindings: add binding doc for spi-qpic-snand
Date: Thu, 15 Feb 2024 19:18:52 +0530
Message-Id: <20240215134856.1313239-2-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ti_jmLABzhtVbA11tSudFgP-MT9nZNGV
X-Proofpoint-ORIG-GUID: Ti_jmLABzhtVbA11tSudFgP-MT9nZNGV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_12,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150111

Add device-tree binding documentation for QCOM QPIC-SNAND-NAND Flash
Interface.

Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 .../bindings/spi/qcom,spi-qpic-snand.yaml     | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
new file mode 100644
index 000000000000..fa7484ce1319
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/qcom,spi-qpic-snand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QPIC NAND controller
+
+maintainers:
+  - Md sadre Alam <quic_mdalam@quicinc.com>
+
+properties:
+  compatible:
+    enum:
+      - qcom,ipq9574-snand
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 3
+
+  clock-names:
+    minItems: 2
+    maxItems: 3
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq9574-snand
+
+    then:
+      properties:
+        dmas:
+          items:
+            - description: tx DMA channel
+            - description: rx DMA channel
+            - description: cmd DMA channel
+
+        dma-names:
+          items:
+            - const: tx
+            - const: rx
+            - const: cmd
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
+    qpic_nand: spi@79b0000 {
+        compatible = "qcom,ipq9574-snand";
+        reg = <0x1ac00000 0x800>;
+
+        clocks = <&gcc GCC_QPIC_CLK>,
+                 <&gcc GCC_QPIC_AHB_CLK>,
+                 <&gcc GCC_QPIC_IO_MACRO_CLK>;
+        clock-names = "core", "aon", "iom";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            compatible = "spi-nand";
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+            nand-ecc-engine = <&qpic_nand>;
+            nand-ecc-strength = <4>;
+            nand-ecc-step-size = <512>;
+            };
+        };
-- 
2.34.1



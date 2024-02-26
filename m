Return-Path: <linux-kernel+bounces-82053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A240D867E59
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58623287A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69EE131E2F;
	Mon, 26 Feb 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S+x7vylU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507D7130E4E;
	Mon, 26 Feb 2024 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968178; cv=none; b=q/yj/VoZYvIqD+ScZoubvYqemPyqwmcUPnPJZSLdpMKSj667eG0hkIeLOpAVBYCpsfdoFtqyWJ2e3DXSP1bpHCYZsIYA6Cfa/UCcXdgFFpv+KbxGvqGo0I2yqNirDN6yZna4xzfpJO/qdqhHzbrW2pg0ioJYgaPYJPuJLFckuvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968178; c=relaxed/simple;
	bh=OSQZOg4C5cUA/203TuHkAoX1Budypr/wre25wNXEejI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjFhR2xIgqNVg+SP896gY5PuwJQWF/X4IlLCmzB37vBsKhwFbgCvp+/l1zRcjloPs+aPFs/jPZCpWLNubDp8GgavCx+hHyXEe6JRZFYMje4L6DDIqYVxEtHV00kKe4JeQ+6BaQfW0Wg/frcIct8KNoTJ6coY2y3Ch8HWKA6WxCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S+x7vylU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QF9YDN002486;
	Mon, 26 Feb 2024 17:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=IZByAaaeVj1XjREUyDsvcmk4MOJ2bjkDHKZeq+giCnE=; b=S+
	x7vylUgVmTJ3bbjb0MZ85000MYS4OCGTntLLt2y9gKKcZKuhOSHt2OyVt8G4+RhR
	nbFWg8QSEV7FB2IeyN/5FnSLqI3CW+NFznHkYN3CUzweBo5/7V1If2CJ8vfwpiPg
	EVopgCuFOh5Bl22101WdWy4hw/MIFHESFg8hPOVlAvdoV9vlMuWrgDoYPVEtHzHY
	PZDWOcSfhSu0/xs5kSc52zevcNgItNVI0q8LAkJajztaWueZ/BD+WJXZIxJiW2aU
	vE/Q+73Wyj0wE+IEpuiaotboMH2mCRDRXy5bViKUk4jQBqtbOKNoq28cFlSCbJld
	2I5SeFHvI5f3HAY0eEyA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxn1jqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 17:22:34 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QHMX1Y001114
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 17:22:33 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 09:22:32 -0800
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <devicetree@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robdclark@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <djakov@kernel.org>
Subject: [PATCH v5 1/7] dt-bindings: iommu: Add Qualcomm TBU bindings
Date: Mon, 26 Feb 2024 09:22:12 -0800
Message-ID: <20240226172218.69486-2-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226172218.69486-1-quic_c_gdjako@quicinc.com>
References: <20240226172218.69486-1-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6UiUYkcIYO3ZK_vb1dupmEy3OEp4-Gdu
X-Proofpoint-GUID: 6UiUYkcIYO3ZK_vb1dupmEy3OEp4-Gdu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402260132

The "apps_smmu" on the Qualcomm sdm845 platform is an implementation
of the SMMU-500, that consists of a single TCU (Translation Control
Unit) and multiple TBUs (Translation Buffer Units). These TBUs have
hardware debugging features that are specific and only present on
Qualcomm hardware. Represent them as independent DT nodes. List all
the resources that are needed to operate them (such as registers,
clocks, power domains and interconnects).

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 .../devicetree/bindings/iommu/qcom,tbu.yaml   | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,tbu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/qcom,tbu.yaml b/Documentation/devicetree/bindings/iommu/qcom,tbu.yaml
new file mode 100644
index 000000000000..6841ca9af21f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/qcom,tbu.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/qcom,tbu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm TBU (Translation Buffer Unit)
+
+maintainers:
+  - Georgi Djakov <quic_c_gdjako@quicinc.com>
+
+description:
+  The Qualcomm SMMU500 implementation consists of TCU and TBU. The TBU contains
+  a Translation Lookaside Buffer (TLB) that caches page tables. TBUs provides
+  debug features to trace and trigger debug transactions. There are multiple TBU
+  instances with each client core.
+
+properties:
+  compatible:
+    const: qcom,qsmmuv500-tbu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interconnects:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  qcom,stream-id-range:
+    description: Phandle of a SMMU device and Stream ID range (address and size) that is assigned by the TBU
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle of a smmu node
+          - description: stream id base address
+          - description: stream id size
+
+required:
+  - compatible
+  - reg
+  - qcom,stream-id-range
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interconnect/qcom,sdm845.h>
+
+    tbu@150e1000 {
+        compatible = "qcom,qsmmuv500-tbu";
+        reg = <0x150e1000 0x1000>;
+        clocks = <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+        interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+                         &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+        power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC>;
+        qcom,stream-id-range = <&apps_smmu 0x1c00 0x400>;
+    };
+...


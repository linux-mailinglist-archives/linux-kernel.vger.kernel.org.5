Return-Path: <linux-kernel+bounces-62812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0106852687
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E77C1C24BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1E9612F7;
	Tue, 13 Feb 2024 00:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eyRU9uuz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF5455769;
	Tue, 13 Feb 2024 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707785706; cv=none; b=pa7SG80uk/wsnSpC8uzN4JnlOSdJ6YJ4Ze76S9+xWlurg0i3IzuOb3mRBM5b+vMakwwyYxlKBW3b53BhvywdDiN8Gkzz92uZJYko6fN1FClpXVCpr2WijPj099sl8cXpXRkxg4TuxpeUzKjqm+VN8SpGHLVUrNV3LfYc+3c2FvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707785706; c=relaxed/simple;
	bh=Q9v7m21SznsQRBxoPQiAbg8VdmmvPkGv0cpZczE0uEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyKDqSyh2piVpmc/GbSYpf/e40GtVbQ2TaHy5SgClHj6ijIh1EStS7xXtleq0FWxpz+J8LJaUWBEWYgN62AjxGVkiCg024NySf9IBhxWQUyKstKbGz3QqN5v4eN1/9O1sEBElcshgSF9uU7DJNNoqJf08SCvz6AFQAW4F7Oz07g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eyRU9uuz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D00l8M018326;
	Tue, 13 Feb 2024 00:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=VRemWOXPXiXIlDmi9y+G
	Tnchb7p3I7IDu6uqBmXbsdI=; b=eyRU9uuzNOwW+q2Qp6545HKAOXSyHsM3cAty
	mgKN5K+jv1BFaxgu15TwE3yI5kaGxu0wKv6nSeub38pu1fsL7W5u3U3Nq8igbkid
	YU1m2grdseRnTxhM0byGu+8RkshBzt2uh/Vz9eP9r645ZIm0PpMFVhs7gr3+ZyBv
	DHEUG2ssSG1PLZl9T6up86otVnScG7qkepcR+K9pA+8UqEE6GHjBnpI8JAQzz9ha
	PUm1OpaKj+mjZ7l8aPlVIT107u8CXAdidXVVNBDDLt4Ds8ZGyAFuGum5CMQ/SATy
	t+3NKBmTsk+alq+09wo9ICSh3DvWVBkFqPBRDwxWHPeLTxh0Nw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7wfy82j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 00:54:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D0sgw4031134
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 00:54:42 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 16:54:42 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v15 35/50] ASoC: dt-bindings: Add Q6USB backend
Date: Mon, 12 Feb 2024 16:54:07 -0800
Message-ID: <20240213005422.3121-36-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240213005422.3121-1-quic_wcheng@quicinc.com>
References: <20240213005422.3121-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HgIdYvISWcCrJEvHwu9B1osMThBhrxiR
X-Proofpoint-ORIG-GUID: HgIdYvISWcCrJEvHwu9B1osMThBhrxiR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_20,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=991
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130005

Add a dt-binding to describe the definition of enabling the Q6 USB backend
device for audio offloading.  The node carries information, which is passed
along to the QC USB SND class driver counterpart.  These parameters will be
utilized during QMI stream enable requests.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 .../devicetree/bindings/sound/qcom,q6usb.yaml | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6usb.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6usb.yaml b/Documentation/devicetree/bindings/sound/qcom,q6usb.yaml
new file mode 100644
index 000000000000..37161d2aa96e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6usb.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,q6usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm ASoC DPCM USB backend DAI
+
+maintainers:
+  - Wesley Cheng <quic_wcheng@quicinc.com>
+
+description:
+  The USB port is a supported AFE path on the Q6 DSP.  This ASoC DPCM
+  backend DAI will communicate the required settings to initialize the
+  XHCI host controller properly for enabling the offloaded audio stream.
+  Parameters defined under this node will carry settings, which will be
+  passed along during the QMI stream enable request and configuration of
+  the XHCI host controller.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,q6usb
+
+  iommus:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 1
+
+  qcom,usb-audio-intr-idx:
+    description:
+      Desired XHCI interrupter number to use.  Depending on the audio DSP
+      on the platform, it will operate on a specific XHCI interrupter.
+    $ref: /schemas/types.yaml#/definitions/uint16
+    maximum: 8
+
+required:
+  - compatible
+  - "#sound-dai-cells"
+  - qcom,usb-audio-intr-idx
+
+additionalProperties: false
+
+examples:
+  - |
+    dais {
+      compatible = "qcom,q6usb";
+      #sound-dai-cells = <1>;
+      iommus = <&apps_smmu 0x180f 0x0>;
+      qcom,usb-audio-intr-idx = /bits/ 16 <2>;
+    };


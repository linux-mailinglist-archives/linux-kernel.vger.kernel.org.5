Return-Path: <linux-kernel+bounces-19311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD0D826B45
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3086C1C21F64
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF9E13FE0;
	Mon,  8 Jan 2024 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HX0Aw6iX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B507134AC;
	Mon,  8 Jan 2024 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4086Tspa004308;
	Mon, 8 Jan 2024 09:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=0A4dWjeTe964GhDfrDlin8+L7fz961yrQfFOr4Gh+o4=; b=HX
	0Aw6iXyUlGeyVisLFH46Aeynbzmf/AILyIPbIkU2pjEkUDXWXCLx5/vbwWQTghXf
	hVg/28Tuwg8ip2B2XW35R807klFB5jNocRifzvzT82ZYW5APXccIfzUqiXg3z+Ld
	9PVSE+tXoRje2TS5Iz6e/bHPCXfHmxXxX8JFI/TF1OTEAUVbAFbsfeH1E56aeVYD
	LjoXkNj9+S687IT55fSN6SWYr3piQMOVPVwiUIhLt8rkX0/mXuBRP1X4gsWcYovq
	osdx6Zfwhhjyc5/NlnrruoB25X9Uq2GmGALjtmVPLhUEeEEkrKjfE0Qlz+ce1swV
	gciT/RX4pwCfxEVYrzbw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgbu2gcad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 09:59:16 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4089xDAm022554;
	Mon, 8 Jan 2024 09:59:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3veyxkkdk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 08 Jan 2024 09:59:13 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4089xChB022539;
	Mon, 8 Jan 2024 09:59:12 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-riteshk-hyd.qualcomm.com [10.147.241.247])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 4089xCjS022534;
	Mon, 08 Jan 2024 09:59:12 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2314801)
	id 398EA5013A8; Mon,  8 Jan 2024 15:29:11 +0530 (+0530)
From: Ritesh Kumar <quic_riteshk@quicinc.com>
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ritesh Kumar <quic_riteshk@quicinc.com>, neil.armstrong@linaro.org,
        quic_jesszhan@quicinc.com, sam@ravnborg.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_abhinavk@quicinc.com,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        sumit.semwal@linaro.org
Subject: [v2 1/2] dt-bindings: display: panel: Add Novatek NT36672E LCD DSI
Date: Mon,  8 Jan 2024 15:29:01 +0530
Message-Id: <20240108095902.22725-2-quic_riteshk@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240108095902.22725-1-quic_riteshk@quicinc.com>
References: <20240108095902.22725-1-quic_riteshk@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p8_jVZJPHqjPRky-0SFjoWPFTJQavOrk
X-Proofpoint-ORIG-GUID: p8_jVZJPHqjPRky-0SFjoWPFTJQavOrk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401080084
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Document Novatek NT36672E FHD+ LCD DSI panel.

Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>

---
v2: Fixed review comments from Krzysztof
      - renamed to novatek,nt36672e, since the binding is for the IC and
        not the panel.
      - moved additionalProperties after required.
---
 .../display/panel/novatek,nt36672e.yaml       | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
new file mode 100644
index 000000000000..dc4672f3d01d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt36672e.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT36672E LCD DSI Panel
+
+maintainers:
+  - Ritesh Kumar <quic_riteshk@quicinc.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: novatek,nt36672e
+
+  reg:
+    maxItems: 1
+    description: DSI virtual channel
+
+  vddi-supply: true
+  avdd-supply: true
+  avee-supply: true
+  port: true
+  reset-gpios: true
+  backlight: true
+
+required:
+  - compatible
+  - reg
+  - vddi-supply
+  - avdd-supply
+  - avee-supply
+  - reset-gpios
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel@0 {
+            compatible = "novatek,nt36672e";
+            reg = <0>;
+
+            reset-gpios = <&tlmm 44 GPIO_ACTIVE_HIGH>;
+
+            vddi-supply = <&vreg_l8c_1p8>;
+            avdd-supply = <&disp_avdd>;
+            avee-supply = <&disp_avee>;
+
+            backlight = <&pwm_backlight>;
+
+            port {
+                panel0_in: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+...
-- 
2.17.1



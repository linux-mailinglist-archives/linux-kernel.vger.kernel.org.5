Return-Path: <linux-kernel+bounces-22111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6064A829965
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4091C25926
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806F6482F9;
	Wed, 10 Jan 2024 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JP+JxNQp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFEA482C3;
	Wed, 10 Jan 2024 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8w4Ni021469;
	Wed, 10 Jan 2024 11:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=hRHDcm1NgNQJHLAKI+ADfwv6npwcK8Gn5yhvTeuzI2c=; b=JP
	+JxNQppkXcJb0vjnBYZzSiRqCCcNfFGGODztkD5MA3jg27i2RysDesw2q9TCDVJt
	eEL7vcmF8vLdZuZO2gu89ZEcoDB4NdaHaeTwR+uGOq0IcXrv24csYOactW+tve7j
	txLL07yd9rCqRwk+lZNbWaGJkna2OMah8NAyey89DvKZenbERl7OG85a6pb05s+W
	H8QhntANASaQpz/zUyU81Jw6c6n3znNJ7EC8zKKS6IOlXwVailgNTvZjeE/DLP6w
	9zwuRKjcYM7okF30CF75m33EoLHl5whY7nmN0tnuxtRkkmzwfwFly7fHacbFy99a
	cD9ZW6SkzvuuOSDHWqSA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhnbnrnxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:41:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABfQXI006293
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:41:26 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:41:15 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <linux@armlinux.org.uk>,
        <shannon.nelson@amd.com>, <anthony.l.nguyen@intel.com>,
        <jasowang@redhat.com>, <brett.creeley@amd.com>,
        <rrameshbabu@nvidia.com>, <joshua.a.hay@intel.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>, <u-kumar1@ti.com>,
        <jacob.e.keller@intel.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <ryazanov.s.a@gmail.com>, <ansuelsmth@gmail.com>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
Subject: [PATCH net-next 02/20] dt-bindings: net: qcom,ppe: Add bindings yaml file
Date: Wed, 10 Jan 2024 19:40:14 +0800
Message-ID: <20240110114033.32575-3-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240110114033.32575-1-quic_luoj@quicinc.com>
References: <20240110114033.32575-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UUVsd-12kI5rvq3Qq74who1x8RirdS8G
X-Proofpoint-GUID: UUVsd-12kI5rvq3Qq74who1x8RirdS8G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401100095

Qualcomm PPE(packet process engine) is supported on
IPQ SOC platform.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 .../devicetree/bindings/net/qcom,ppe.yaml     | 1330 +++++++++++++++++
 1 file changed, 1330 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,ppe.yaml

diff --git a/Documentation/devicetree/bindings/net/qcom,ppe.yaml b/Documentation/devicetree/bindings/net/qcom,ppe.yaml
new file mode 100644
index 000000000000..6afb2ad62707
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qcom,ppe.yaml
@@ -0,0 +1,1330 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/qcom,ppe.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Packet Process Engine Ethernet controller
+
+maintainers:
+  - Luo Jie <quic_luoj@quicinc.com>
+
+description:
+  The PPE(packet process engine) is comprised of three componets, Ethernet
+  DMA, Switch core and Port wrapper, Ethernet DMA is used to transmit and
+  receive packets between Ethernet subsytem and host. The Switch core has
+  maximum 8 ports(maximum 6 front panel ports and two FIFO interfaces),
+  among which there are GMAC/XGMACs used as external interfaces and FIFO
+  interfaces connected the EDMA/EIP, The port wrapper provides connections
+  from the GMAC/XGMACS to SGMII/QSGMII/PSGMII/USXGMII/10G-BASER etc, there
+  are maximu 3 UNIPHY(PCS) instances supported by PPE.
+
+properties:
+  compatible:
+    enum:
+      - qcom,ipq5332-ppe
+      - qcom,ipq9574-ppe
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+  clocks: true
+
+  clock-names: true
+
+  resets: true
+
+  reset-names: true
+
+  tdm-config:
+    type: object
+    additionalProperties: false
+    description: |
+      PPE TDM(time-division multiplexing) config includes buffer management
+      and port scheduler.
+
+    properties:
+      qcom,tdm-bm-config:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description:
+          The TDM buffer scheduler configs of PPE, there are multiple
+          entries supported, each entry includes valid, direction
+          (ingress or egress), port, second port valid, second port.
+
+      qcom,tdm-port-scheduler-config:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description:
+          The TDM port scheduler management configs of PPE, there
+          are multiple entries supported each entry includes ingress
+          scheduler port bitmap, ingress scheduler port, egress
+          scheduler port, second egress scheduler port valid and
+          second egress scheduler port.
+
+    required:
+      - qcom,tdm-bm-config
+      - qcom,tdm-port-scheduler-config
+
+  buffer-management-config:
+    type: object
+    additionalProperties: false
+    description: |
+      PPE buffer management config, which supports configuring group
+      buffer and per port buffer, which decides the threshold of the
+      flow control frame generated.
+
+    properties:
+      qcom,group-config:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description:
+          The PPE buffer support 4 groups, the entry includes
+          the group ID and group buffer numbers, each buffer
+          has 256 bytes.
+
+      qcom,port-config:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description:
+          The PPE buffer number is also assigned per BM port ID,
+          there are 10 BM ports supported on ipq5332, and 15 BM
+          ports supported on ipq9574. Each entry includs group
+          ID, BM port ID, dedicated buffer, the buffer numbers
+          for receiving packet after pause frame sent, the
+          threshold for pause frame, weight, restore ceil and
+          dynamic buffer or static buffer management.
+
+    required:
+      - qcom,group-config
+      - qcom,port-config
+
+  queue-management-config:
+    type: object
+    additionalProperties: false
+    description: |
+      PPE queue management config, which supports configuring group
+      and per queue buffer limitation, which decides the threshold
+      to drop the packet on the egress port.
+
+    properties:
+      qcom,group-config:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description:
+          The PPE queue management support 4 groups, the entry
+          includes the group ID, group buffer number, dedicated
+          buffer number, threshold to drop packet and restore
+          ceil.
+
+      qcom,queue-config:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description:
+          PPE has 256 unicast queues and 44 multicast queues, the
+          entry includes queue base, queue number, group ID,
+          dedicated buffer, the threshold to drop packet, weight,
+          restore ceil and dynamic or static queue management.
+
+    required:
+      - qcom,group-config
+      - qcom,queue-config
+
+  port-scheduler-resource:
+    type: object
+    additionalProperties: false
+    description: The scheduler resource available in PPE.
+    patternProperties:
+      "^port[0-7]$":
+        description: Each subnode represents the scheduler resource per port.
+        type: object
+        properties:
+          port-id:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: |
+              The PPE port ID, there are maximum 6 physical port,
+              EIP port and CPU port.
+
+          qcom,ucast-queue:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 2
+            maxItems: 2
+            description: The PPE unicast queue range.
+
+          qcom,mcast-queue:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 2
+            maxItems: 2
+            description: The PPE multicast queue range.
+
+          qcom,l0sp:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 2
+            maxItems: 2
+            description: The PPE L0 strict priority scheduler range.
+
+          qcom,l0cdrr:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 2
+            maxItems: 2
+            description: The PPE L0 promise DRR range.
+
+          qcom,l0edrr:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 2
+            maxItems: 2
+            description: The PPE L0 exceed DRR range.
+
+          qcom,l1cdrr:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 2
+            maxItems: 2
+            description: The PPE L1 promise DRR range.
+
+          qcom,l1edrr:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 2
+            maxItems: 2
+            description: The PPE L1 exceed DRR range.
+
+        required:
+          - port-id
+          - qcom,ucast-queue
+          - qcom,mcast-queue
+          - qcom,l0sp
+          - qcom,l0cdrr
+          - qcom,l0edrr
+          - qcom,l1cdrr
+          - qcom,l1edrr
+
+  port-scheduler-config:
+    type: object
+    additionalProperties: false
+    description: The scheduler resource config in PPE.
+    patternProperties:
+      "^port[0-7]$":
+        type: object
+        additionalProperties: false
+        description: Each subnode represents the scheduler config per port.
+        properties:
+          port-id:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: |
+              The PPE port ID, there are maximum 6 physical port
+              and one CPU port.
+
+          l1scheduler:
+            type: object
+            additionalProperties: false
+            description: PPE port level 1 scheduler config
+            patternProperties:
+              "^group[0-7]$":
+                type: object
+                additionalProperties: false
+                description: PPE per flow scheduler config in level 1
+                properties:
+                  qcom,flow:
+                    $ref: /schemas/types.yaml#/definitions/uint32
+                    description:
+                      The flow ID for level 1 scheduler
+
+                  qcom,flow-loop-priority:
+                    $ref: /schemas/types.yaml#/definitions/uint32
+                    description:
+                      The flow loop priority for level 1 scheduler
+
+                  qcom,scheduler-config:
+                    $ref: /schemas/types.yaml#/definitions/uint32-array
+                    minItems: 5
+                    maxItems: 5
+                    description: |
+                      The scheduler config includes flow ID, promise priority,
+                      promise DRR, exceed priority and exceed DRR.
+
+                required:
+                  - qcom,flow
+                  - qcom,scheduler-config
+
+          l0scheduler:
+            type: object
+            additionalProperties: false
+            description: PPE port level 0 scheduler config
+            patternProperties:
+              "^group[0-7]$":
+                type: object
+                additionalProperties: false
+                description: PPE per flow scheduler config in level 0
+                properties:
+                  qcom,ucast-queue:
+                    $ref: /schemas/types.yaml#/definitions/uint32
+                    description: The unicast queue base ID.
+
+                  qcom,mcast-queue:
+                    $ref: /schemas/types.yaml#/definitions/uint32
+                    description: The multicast queue base ID.
+
+                  qcom,ucast-loop-priority:
+                    $ref: /schemas/types.yaml#/definitions/uint32
+                    description: |
+                      The unicast priority number, each priority has dedicated
+                      queue.
+
+                  qcom,mcast-loop-priority:
+                    $ref: /schemas/types.yaml#/definitions/uint32
+                    description: |
+                      The multicast priority number, each priority has dedicated
+                      queue.
+
+                  qcom,drr-max-priority:
+                    $ref: /schemas/types.yaml#/definitions/uint32
+                    description:
+                      The unicast maximum priority for the configured queues
+
+                  qcom,scheduler-config:
+                    $ref: /schemas/types.yaml#/definitions/uint32-array
+                    minItems: 5
+                    maxItems: 5
+                    description:
+                      The flow ID input to level 1 scheduler, promise priority,
+                      promise DRR, exceed priority and exceed DRR.
+
+                required:
+                  - qcom,ucast-queue
+                  - qcom,mcast-queue
+                  - qcom,scheduler-config
+
+        required:
+          - port-id
+          - l0scheduler
+          - l1scheduler
+
+patternProperties:
+  "^qcom-uniphy@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+    description: uniphy configuration and clock provider
+    properties:
+      reg:
+        minItems: 2
+        items:
+          - description: The first uniphy register range
+          - description: The second uniphy register range
+          - description: The third uniphy register range
+
+      "#clock-cells":
+        const: 1
+
+      clock-output-names:
+        minItems: 4
+        maxItems: 6
+
+    required:
+      - reg
+      - "#clock-cells"
+      - clock-output-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,ipq5332-ppe
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Display common AHB clock from gcc
+            - description: Display common system clock from gcc
+            - description: Display uniphy0 AHB clock from gcc
+            - description: Display uniphy1 AHB clock from gcc
+            - description: Display uniphy0 system clock from gcc
+            - description: Display uniphy1 system clock from gcc
+            - description: Display nss clock from gcc
+            - description: Display nss noc snoc clock from gcc
+            - description: Display nss noc snoc_1 clock from gcc
+            - description: Display sleep clock from gcc
+            - description: Display PPE clock from nsscc
+            - description: Display PPE config clock from nsscc
+            - description: Display NSSNOC PPE clock from nsscc
+            - description: Display NSSNOC PPE config clock from nsscc
+            - description: Display EDMA clock from nsscc
+            - description: Display EDMA config clock from nsscc
+            - description: Display PPE IPE clock from nsscc
+            - description: Display PPE BTQ clock from nsscc
+            - description: Display port1 MAC clock from nsscc
+            - description: Display port2 MAC clock from nsscc
+            - description: Display port1 RX clock from nsscc
+            - description: Display port1 TX clock from nsscc
+            - description: Display port2 RX clock from nsscc
+            - description: Display port2 TX clock from nsscc
+            - description: Display UNIPHY port1 RX clock from nsscc
+            - description: Display UNIPHY port1 TX clock from nsscc
+            - description: Display UNIPHY port2 RX clock from nsscc
+            - description: Display UNIPHY port2 TX clock from nsscc
+        clock-names:
+          items:
+            - const: cmn_ahb
+            - const: cmn_sys
+            - const: uniphy0_ahb
+            - const: uniphy1_ahb
+            - const: uniphy0_sys
+            - const: uniphy1_sys
+            - const: gcc_nsscc
+            - const: gcc_nssnoc_snoc
+            - const: gcc_nssnoc_snoc_1
+            - const: gcc_im_sleep
+            - const: nss_ppe
+            - const: nss_ppe_cfg
+            - const: nssnoc_ppe
+            - const: nssnoc_ppe_cfg
+            - const: nss_edma
+            - const: nss_edma_cfg
+            - const: nss_ppe_ipe
+            - const: nss_ppe_btq
+            - const: port1_mac
+            - const: port2_mac
+            - const: nss_port1_rx
+            - const: nss_port1_tx
+            - const: nss_port2_rx
+            - const: nss_port2_tx
+            - const: uniphy_port1_rx
+            - const: uniphy_port1_tx
+            - const: uniphy_port2_rx
+            - const: uniphy_port2_tx
+
+        resets:
+          items:
+            - description: Reset PPE
+            - description: Reset uniphy0 software config
+            - description: Reset uniphy1 software config
+            - description: Reset uniphy0 AHB
+            - description: Reset uniphy1 AHB
+            - description: Reset uniphy0 system
+            - description: Reset uniphy1 system
+            - description: Reset uniphy0 XPCS
+            - description: Reset uniphy1 SPCS
+            - description: Reset uniphy port1 RX
+            - description: Reset uniphy port1 TX
+            - description: Reset uniphy port2 RX
+            - description: Reset uniphy port2 TX
+            - description: Reset PPE port1 RX
+            - description: Reset PPE port1 TX
+            - description: Reset PPE port2 RX
+            - description: Reset PPE port2 TX
+            - description: Reset PPE port1 MAC
+            - description: Reset PPE port2 MAC
+
+        reset-names:
+          items:
+            - const: ppe
+            - const: uniphy0_soft
+            - const: uniphy1_soft
+            - const: uniphy0_ahb
+            - const: uniphy1_ahb
+            - const: uniphy0_sys
+            - const: uniphy1_sys
+            - const: uniphy0_xpcs
+            - const: uniphy1_xpcs
+            - const: uniphy_port1_rx
+            - const: uniphy_port1_tx
+            - const: uniphy_port2_rx
+            - const: uniphy_port2_tx
+            - const: nss_port1_rx
+            - const: nss_port1_tx
+            - const: nss_port2_rx
+            - const: nss_port2_tx
+            - const: nss_port1_mac
+            - const: nss_port2_mac
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,ipq9574-ppe
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Display common AHB clock from gcc
+            - description: Display common system clock from gcc
+            - description: Display uniphy0 AHB clock from gcc
+            - description: Display uniphy1 AHB clock from gcc
+            - description: Display uniphy2 AHB clock from gcc
+            - description: Display uniphy0 system clock from gcc
+            - description: Display uniphy1 system clock from gcc
+            - description: Display uniphy2 system clock from gcc
+            - description: Display nss clock from gcc
+            - description: Display nss noc clock from gcc
+            - description: Display nss noc snoc clock from gcc
+            - description: Display nss noc snoc_1 clock from gcc
+            - description: Display PPE clock from nsscc
+            - description: Display PPE config clock from nsscc
+            - description: Display NSSNOC PPE clock from nsscc
+            - description: Display NSSNOC PPE config clock from nsscc
+            - description: Display EDMA clock from nsscc
+            - description: Display EDMA config clock from nsscc
+            - description: Display PPE IPE clock from nsscc
+            - description: Display PPE BTQ clock from nsscc
+            - description: Display port1 MAC clock from nsscc
+            - description: Display port2 MAC clock from nsscc
+            - description: Display port3 MAC clock from nsscc
+            - description: Display port4 MAC clock from nsscc
+            - description: Display port5 MAC clock from nsscc
+            - description: Display port6 MAC clock from nsscc
+            - description: Display port1 RX clock from nsscc
+            - description: Display port1 TX clock from nsscc
+            - description: Display port2 RX clock from nsscc
+            - description: Display port2 TX clock from nsscc
+            - description: Display port3 RX clock from nsscc
+            - description: Display port3 TX clock from nsscc
+            - description: Display port4 RX clock from nsscc
+            - description: Display port4 TX clock from nsscc
+            - description: Display port5 RX clock from nsscc
+            - description: Display port5 TX clock from nsscc
+            - description: Display port6 RX clock from nsscc
+            - description: Display port6 TX clock from nsscc
+            - description: Display UNIPHY port1 RX clock from nsscc
+            - description: Display UNIPHY port1 TX clock from nsscc
+            - description: Display UNIPHY port2 RX clock from nsscc
+            - description: Display UNIPHY port2 TX clock from nsscc
+            - description: Display UNIPHY port3 RX clock from nsscc
+            - description: Display UNIPHY port3 TX clock from nsscc
+            - description: Display UNIPHY port4 RX clock from nsscc
+            - description: Display UNIPHY port4 TX clock from nsscc
+            - description: Display UNIPHY port5 RX clock from nsscc
+            - description: Display UNIPHY port5 TX clock from nsscc
+            - description: Display UNIPHY port6 RX clock from nsscc
+            - description: Display UNIPHY port6 TX clock from nsscc
+            - description: Display port5 RX clock source from nsscc
+            - description: Display port5 TX clock source from nsscc
+        clock-names:
+          items:
+            - const: cmn_ahb
+            - const: cmn_sys
+            - const: uniphy0_ahb
+            - const: uniphy1_ahb
+            - const: uniphy2_ahb
+            - const: uniphy0_sys
+            - const: uniphy1_sys
+            - const: uniphy2_sys
+            - const: gcc_nsscc
+            - const: gcc_nssnoc_nsscc
+            - const: gcc_nssnoc_snoc
+            - const: gcc_nssnoc_snoc_1
+            - const: nss_ppe
+            - const: nss_ppe_cfg
+            - const: nssnoc_ppe
+            - const: nssnoc_ppe_cfg
+            - const: nss_edma
+            - const: nss_edma_cfg
+            - const: nss_ppe_ipe
+            - const: nss_ppe_btq
+            - const: port1_mac
+            - const: port2_mac
+            - const: port3_mac
+            - const: port4_mac
+            - const: port5_mac
+            - const: port6_mac
+            - const: nss_port1_rx
+            - const: nss_port1_tx
+            - const: nss_port2_rx
+            - const: nss_port2_tx
+            - const: nss_port3_rx
+            - const: nss_port3_tx
+            - const: nss_port4_rx
+            - const: nss_port4_tx
+            - const: nss_port5_rx
+            - const: nss_port5_tx
+            - const: nss_port6_rx
+            - const: nss_port6_tx
+            - const: uniphy_port1_rx
+            - const: uniphy_port1_tx
+            - const: uniphy_port2_rx
+            - const: uniphy_port2_tx
+            - const: uniphy_port3_rx
+            - const: uniphy_port3_tx
+            - const: uniphy_port4_rx
+            - const: uniphy_port4_tx
+            - const: uniphy_port5_rx
+            - const: uniphy_port5_tx
+            - const: uniphy_port6_rx
+            - const: uniphy_port6_tx
+            - const: nss_port5_rx_clk_src
+            - const: nss_port5_tx_clk_src
+
+        resets:
+          items:
+            - description: Reset PPE
+            - description: Reset uniphy0 software config
+            - description: Reset uniphy1 software config
+            - description: Reset uniphy2 software config
+            - description: Reset uniphy0 AHB
+            - description: Reset uniphy1 AHB
+            - description: Reset uniphy2 AHB
+            - description: Reset uniphy0 system
+            - description: Reset uniphy1 system
+            - description: Reset uniphy2 system
+            - description: Reset uniphy0 XPCS
+            - description: Reset uniphy1 XPCS
+            - description: Reset uniphy2 XPCS
+            - description: Assert uniphy port1
+            - description: Assert uniphy port2
+            - description: Assert uniphy port3
+            - description: Assert uniphy port4
+            - description: Reset PPE port1
+            - description: Reset PPE port2
+            - description: Reset PPE port3
+            - description: Reset PPE port4
+            - description: Reset PPE port5
+            - description: Reset PPE port6
+            - description: Reset PPE port1 MAC
+            - description: Reset PPE port2 MAC
+            - description: Reset PPE port3 MAC
+            - description: Reset PPE port4 MAC
+            - description: Reset PPE port5 MAC
+            - description: Reset PPE port6 MAC
+
+        reset-names:
+          items:
+            - const: ppe
+            - const: uniphy0_soft
+            - const: uniphy1_soft
+            - const: uniphy2_soft
+            - const: uniphy0_ahb
+            - const: uniphy1_ahb
+            - const: uniphy2_ahb
+            - const: uniphy0_sys
+            - const: uniphy1_sys
+            - const: uniphy2_sys
+            - const: uniphy0_xpcs
+            - const: uniphy1_xpcs
+            - const: uniphy2_xpcs
+            - const: uniphy0_port1_dis
+            - const: uniphy0_port2_dis
+            - const: uniphy0_port3_dis
+            - const: uniphy0_port4_dis
+            - const: nss_port1
+            - const: nss_port2
+            - const: nss_port3
+            - const: nss_port4
+            - const: nss_port5
+            - const: nss_port6
+            - const: nss_port1_mac
+            - const: nss_port2_mac
+            - const: nss_port3_mac
+            - const: nss_port4_mac
+            - const: nss_port5_mac
+            - const: nss_port6_mac
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - tdm-config
+  - buffer-management-config
+  - queue-management-config
+  - port-scheduler-resource
+  - port-scheduler-config
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
+    #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
+    #include <dt-bindings/clock/qcom,ipq9574-nsscc.h>
+    #include <dt-bindings/reset/qcom,ipq9574-nsscc.h>
+
+    soc {
+      #address-cells = <1>;
+      #size-cells = <1>;
+      qcom_ppe: qcom-ppe@3a000000 {
+              compatible = "qcom,ipq9574-ppe";
+              reg = <0x3a000000 0xb00000>;
+              #address-cells = <1>;
+              #size-cells = <1>;
+              ranges;
+              clocks = <&gcc GCC_CMN_12GPLL_AHB_CLK>,
+                       <&gcc GCC_CMN_12GPLL_SYS_CLK>,
+                       <&gcc GCC_UNIPHY0_AHB_CLK>,
+                       <&gcc GCC_UNIPHY1_AHB_CLK>,
+                       <&gcc GCC_UNIPHY2_AHB_CLK>,
+                       <&gcc GCC_UNIPHY0_SYS_CLK>,
+                       <&gcc GCC_UNIPHY1_SYS_CLK>,
+                       <&gcc GCC_UNIPHY2_SYS_CLK>,
+                       <&gcc GCC_NSSCC_CLK>,
+                       <&gcc GCC_NSSNOC_NSSCC_CLK>,
+                       <&gcc GCC_NSSNOC_SNOC_CLK>,
+                       <&gcc GCC_NSSNOC_SNOC_1_CLK>,
+                       <&nsscc NSS_CC_PPE_SWITCH_CLK>,
+                       <&nsscc NSS_CC_PPE_SWITCH_CFG_CLK>,
+                       <&nsscc NSS_CC_NSSNOC_PPE_CLK>,
+                       <&nsscc NSS_CC_NSSNOC_PPE_CFG_CLK>,
+                       <&nsscc NSS_CC_PPE_EDMA_CLK>,
+                       <&nsscc NSS_CC_PPE_EDMA_CFG_CLK>,
+                       <&nsscc NSS_CC_PPE_SWITCH_IPE_CLK>,
+                       <&nsscc NSS_CC_PPE_SWITCH_BTQ_CLK>,
+                       <&nsscc NSS_CC_PORT1_MAC_CLK>,
+                       <&nsscc NSS_CC_PORT2_MAC_CLK>,
+                       <&nsscc NSS_CC_PORT3_MAC_CLK>,
+                       <&nsscc NSS_CC_PORT4_MAC_CLK>,
+                       <&nsscc NSS_CC_PORT5_MAC_CLK>,
+                       <&nsscc NSS_CC_PORT6_MAC_CLK>,
+                       <&nsscc NSS_CC_PORT1_RX_CLK>,
+                       <&nsscc NSS_CC_PORT1_TX_CLK>,
+                       <&nsscc NSS_CC_PORT2_RX_CLK>,
+                       <&nsscc NSS_CC_PORT2_TX_CLK>,
+                       <&nsscc NSS_CC_PORT3_RX_CLK>,
+                       <&nsscc NSS_CC_PORT3_TX_CLK>,
+                       <&nsscc NSS_CC_PORT4_RX_CLK>,
+                       <&nsscc NSS_CC_PORT4_TX_CLK>,
+                       <&nsscc NSS_CC_PORT5_RX_CLK>,
+                       <&nsscc NSS_CC_PORT5_TX_CLK>,
+                       <&nsscc NSS_CC_PORT6_RX_CLK>,
+                       <&nsscc NSS_CC_PORT6_TX_CLK>,
+                       <&nsscc NSS_CC_UNIPHY_PORT1_RX_CLK>,
+                       <&nsscc NSS_CC_UNIPHY_PORT1_TX_CLK>,
+                       <&nsscc NSS_CC_UNIPHY_PORT2_RX_CLK>,
+                       <&nsscc NSS_CC_UNIPHY_PORT2_TX_CLK>,
+                       <&nsscc NSS_CC_UNIPHY_PORT3_RX_CLK>,
+                       <&nsscc NSS_CC_UNIPHY_PORT3_TX_CLK>,
+                       <&nsscc NSS_CC_UNIPHY_PORT4_RX_CLK>,
+                       <&nsscc NSS_CC_UNIPHY_PORT4_TX_CLK>,
+                       <&nsscc NSS_CC_UNIPHY_PORT5_RX_CLK>,
+                       <&nsscc NSS_CC_UNIPHY_PORT5_TX_CLK>,
+                       <&nsscc NSS_CC_UNIPHY_PORT6_RX_CLK>,
+                       <&nsscc NSS_CC_UNIPHY_PORT6_TX_CLK>,
+                       <&nsscc NSS_CC_PORT5_RX_CLK_SRC>,
+                       <&nsscc NSS_CC_PORT5_TX_CLK_SRC>;
+              clock-names = "cmn_ahb",
+                            "cmn_sys",
+                            "uniphy0_ahb",
+                            "uniphy1_ahb",
+                            "uniphy2_ahb",
+                            "uniphy0_sys",
+                            "uniphy1_sys",
+                            "uniphy2_sys",
+                            "gcc_nsscc",
+                            "gcc_nssnoc_nsscc",
+                            "gcc_nssnoc_snoc",
+                            "gcc_nssnoc_snoc_1",
+                            "nss_ppe",
+                            "nss_ppe_cfg",
+                            "nssnoc_ppe",
+                            "nssnoc_ppe_cfg",
+                            "nss_edma",
+                            "nss_edma_cfg",
+                            "nss_ppe_ipe",
+                            "nss_ppe_btq",
+                            "port1_mac",
+                            "port2_mac",
+                            "port3_mac",
+                            "port4_mac",
+                            "port5_mac",
+                            "port6_mac",
+                            "nss_port1_rx",
+                            "nss_port1_tx",
+                            "nss_port2_rx",
+                            "nss_port2_tx",
+                            "nss_port3_rx",
+                            "nss_port3_tx",
+                            "nss_port4_rx",
+                            "nss_port4_tx",
+                            "nss_port5_rx",
+                            "nss_port5_tx",
+                            "nss_port6_rx",
+                            "nss_port6_tx",
+                            "uniphy_port1_rx",
+                            "uniphy_port1_tx",
+                            "uniphy_port2_rx",
+                            "uniphy_port2_tx",
+                            "uniphy_port3_rx",
+                            "uniphy_port3_tx",
+                            "uniphy_port4_rx",
+                            "uniphy_port4_tx",
+                            "uniphy_port5_rx",
+                            "uniphy_port5_tx",
+                            "uniphy_port6_rx",
+                            "uniphy_port6_tx",
+                            "nss_port5_rx_clk_src",
+                            "nss_port5_tx_clk_src";
+              resets = <&nsscc PPE_FULL_RESET>,
+                       <&nsscc UNIPHY0_SOFT_RESET>,
+                       <&nsscc UNIPHY_PORT5_ARES>,
+                       <&nsscc UNIPHY_PORT6_ARES>,
+                       <&gcc GCC_UNIPHY0_AHB_RESET>,
+                       <&gcc GCC_UNIPHY1_AHB_RESET>,
+                       <&gcc GCC_UNIPHY2_AHB_RESET>,
+                       <&gcc GCC_UNIPHY0_SYS_RESET>,
+                       <&gcc GCC_UNIPHY1_SYS_RESET>,
+                       <&gcc GCC_UNIPHY2_SYS_RESET>,
+                       <&gcc GCC_UNIPHY0_XPCS_RESET>,
+                       <&gcc GCC_UNIPHY1_XPCS_RESET>,
+                       <&gcc GCC_UNIPHY2_XPCS_RESET>,
+                       <&nsscc UNIPHY_PORT1_ARES>,
+                       <&nsscc UNIPHY_PORT2_ARES>,
+                       <&nsscc UNIPHY_PORT3_ARES>,
+                       <&nsscc UNIPHY_PORT4_ARES>,
+                       <&nsscc NSSPORT1_RESET>,
+                       <&nsscc NSSPORT2_RESET>,
+                       <&nsscc NSSPORT3_RESET>,
+                       <&nsscc NSSPORT4_RESET>,
+                       <&nsscc NSSPORT5_RESET>,
+                       <&nsscc NSSPORT6_RESET>,
+                       <&nsscc PORT1_MAC_ARES>,
+                       <&nsscc PORT2_MAC_ARES>,
+                       <&nsscc PORT3_MAC_ARES>,
+                       <&nsscc PORT4_MAC_ARES>,
+                       <&nsscc PORT5_MAC_ARES>,
+                       <&nsscc PORT6_MAC_ARES>;
+              reset-names = "ppe",
+                            "uniphy0_soft",
+                            "uniphy1_soft",
+                            "uniphy2_soft",
+                            "uniphy0_ahb",
+                            "uniphy1_ahb",
+                            "uniphy2_ahb",
+                            "uniphy0_sys",
+                            "uniphy1_sys",
+                            "uniphy2_sys",
+                            "uniphy0_xpcs",
+                            "uniphy1_xpcs",
+                            "uniphy2_xpcs",
+                            "uniphy0_port1_dis",
+                            "uniphy0_port2_dis",
+                            "uniphy0_port3_dis",
+                            "uniphy0_port4_dis",
+                            "nss_port1",
+                            "nss_port2",
+                            "nss_port3",
+                            "nss_port4",
+                            "nss_port5",
+                            "nss_port6",
+                            "nss_port1_mac",
+                            "nss_port2_mac",
+                            "nss_port3_mac",
+                            "nss_port4_mac",
+                            "nss_port5_mac",
+                            "nss_port6_mac";
+
+              uniphys: qcom-uniphy@7a00000 {
+                      reg = <0x7a00000 0x10000>,
+                            <0x7a10000 0x10000>,
+                            <0x7a20000 0x10000>;
+                      #clock-cells = <0x1>;
+                      clock-output-names = "uniphy0_gcc_rx_clk",
+                                           "uniphy0_gcc_tx_clk",
+                                           "uniphy1_gcc_rx_clk",
+                                           "uniphy1_gcc_tx_clk",
+                                           "uniphy2_gcc_rx_clk",
+                                           "uniphy2_gcc_tx_clk";
+              };
+
+              tdm-config {
+                      qcom,tdm-bm-config = <1 0 0 0 0>,
+                                           <1 1 0 0 0>,
+                                           <1 0 5 0 0>,
+                                           <1 1 5 0 0>,
+                                           <1 0 6 0 0>,
+                                           <1 1 6 0 0>,
+                                           <1 0 1 0 0>,
+                                           <1 1 1 0 0>,
+                                           <1 0 0 0 0>,
+                                           <1 1 0 0 0>,
+                                           <1 0 5 0 0>,
+                                           <1 1 5 0 0>,
+                                           <1 0 6 0 0>,
+                                           <1 1 6 0 0>,
+                                           <1 0 7 0 0>,
+                                           <1 1 7 0 0>,
+                                           <1 0 0 0 0>,
+                                           <1 1 0 0 0>,
+                                           <1 0 1 0 0>,
+                                           <1 1 1 0 0>,
+                                           <1 0 5 0 0>,
+                                           <1 1 5 0 0>,
+                                           <1 0 6 0 0>,
+                                           <1 1 6 0 0>,
+                                           <1 0 2 0 0>,
+                                           <1 1 2 0 0>,
+                                           <1 0 0 0 0>,
+                                           <1 1 0 0 0>,
+                                           <1 0 5 0 0>,
+                                           <1 1 5 0 0>,
+                                           <1 0 6 0 0>,
+                                           <1 1 6 0 0>,
+                                           <1 0 1 0 0>,
+                                           <1 1 1 0 0>,
+                                           <1 0 3 0 0>,
+                                           <1 1 3 0 0>,
+                                           <1 0 0 0 0>,
+                                           <1 1 0 0 0>,
+                                           <1 0 5 0 0>,
+                                           <1 1 5 0 0>,
+                                           <1 0 6 0 0>,
+                                           <1 1 6 0 0>,
+                                           <1 0 7 0 0>,
+                                           <1 1 7 0 0>,
+                                           <1 0 0 0 0>,
+                                           <1 1 0 0 0>,
+                                           <1 0 1 0 0>,
+                                           <1 1 1 0 0>,
+                                           <1 0 5 0 0>,
+                                           <1 1 5 0 0>,
+                                           <1 0 6 0 0>,
+                                           <1 1 6 0 0>,
+                                           <1 0 4 0 0>,
+                                           <1 1 4 0 0>,
+                                           <1 0 0 0 0>,
+                                           <1 1 0 0 0>,
+                                           <1 0 5 0 0>,
+                                           <1 1 5 0 0>,
+                                           <1 0 6 0 0>,
+                                           <1 1 6 0 0>,
+                                           <1 0 1 0 0>,
+                                           <1 1 1 0 0>,
+                                           <1 0 0 0 0>,
+                                           <1 1 0 0 0>,
+                                           <1 0 5 0 0>,
+                                           <1 1 5 0 0>,
+                                           <1 0 6 0 0>,
+                                           <1 1 6 0 0>,
+                                           <1 0 2 0 0>,
+                                           <1 1 2 0 0>,
+                                           <1 0 0 0 0>,
+                                           <1 1 0 0 0>,
+                                           <1 0 7 0 0>,
+                                           <1 1 7 0 0>,
+                                           <1 0 5 0 0>,
+                                           <1 1 5 0 0>,
+                                           <1 0 6 0 0>,
+                                           <1 1 6 0 0>,
+                                           <1 0 1 0 0>,
+                                           <1 1 1 0 0>,
+                                           <1 0 0 0 0>,
+                                           <1 1 0 0 0>,
+                                           <1 0 5 0 0>,
+                                           <1 1 5 0 0>,
+                                           <1 0 6 0 0>,
+                                           <1 1 6 0 0>,
+                                           <1 0 3 0 0>,
+                                           <1 1 3 0 0>,
+                                           <1 0 1 0 0>,
+                                           <1 1 1 0 0>,
+                                           <1 0 0 0 0>,
+                                           <1 1 0 0 0>,
+                                           <1 0 5 0 0>,
+                                           <1 1 5 0 0>,
+                                           <1 0 6 0 0>,
+                                           <1 1 6 0 0>,
+                                           <1 0 4 0 0>,
+                                           <1 1 4 0 0>,
+                                           <1 0 7 0 0>,
+                                           <1 1 7 0 0>;
+              qcom,tdm-port-scheduler-config = <0x98 6 0 1 1>,
+                                               <0x94 5 6 1 3>,
+                                               <0x86 0 5 1 4>,
+                                               <0x8C 1 6 1 0>,
+                                               <0x1C 7 5 1 1>,
+                                               <0x98 2 6 1 0>,
+                                               <0x1C 5 7 1 1>,
+                                               <0x34 3 6 1 0>,
+                                               <0x8C 4 5 1 1>,
+                                               <0x98 2 6 1 0>,
+                                               <0x8C 5 4 1 1>,
+                                               <0xA8 0 6 1 2>,
+                                               <0x98 5 1 1 0>,
+                                               <0x98 6 5 1 2>,
+                                               <0x89 1 6 1 4>,
+                                               <0xA4 3 0 1 1>,
+                                               <0x8C 5 6 1 4>,
+                                               <0xA8 0 2 1 1>,
+                                               <0x98 6 5 1 0>,
+                                               <0xC4 4 3 1 1>,
+                                               <0x94 6 5 1 0>,
+                                               <0x1C 7 6 1 1>,
+                                               <0x98 2 5 1 0>,
+                                               <0x1C 6 7 1 1>,
+                                               <0x1C 5 6 1 0>,
+                                               <0x94 3 5 1 1>,
+                                               <0x8C 4 6 1 0>,
+                                               <0x94 1 5 1 3>,
+                                               <0x94 6 1 1 0>,
+                                               <0xD0 3 5 1 2>,
+                                               <0x98 6 0 1 1>,
+                                               <0x94 5 6 1 3>,
+                                               <0x94 1 5 1 0>,
+                                               <0x98 2 6 1 1>,
+                                               <0x8C 4 5 1 0>,
+                                               <0x1C 7 6 1 1>,
+                                               <0x8C 0 5 1 4>,
+                                               <0x89 1 6 1 2>,
+                                               <0x98 5 0 1 1>,
+                                               <0x94 6 5 1 3>,
+                                               <0x92 0 6 1 2>,
+                                               <0x98 1 5 1 0>,
+                                               <0x98 6 2 1 1>,
+                                               <0xD0 0 5 1 3>,
+                                               <0x94 6 0 1 1>,
+                                               <0x8C 5 6 1 4>,
+                                               <0x8C 1 5 1 0>,
+                                               <0x1C 6 7 1 1>,
+                                               <0x1C 5 6 1 0>,
+                                               <0xB0 2 3 1 1>,
+                                               <0xC4 4 5 1 0>,
+                                               <0x8C 6 4 1 1>,
+                                               <0xA4 3 6 1 0>,
+                                               <0x1C 5 7 1 1>,
+                                               <0x4C 0 5 1 4>,
+                                               <0x8C 6 0 1 1>,
+                                               <0x34 7 6 1 3>,
+                                               <0x94 5 0 1 1>,
+                                               <0x98 6 5 1 2>;
+              };
+
+              buffer-management-config {
+                      qcom,group-config = <0 1550>;
+                      qcom,port-config = <0 0 0 100 1146 7 8 0 1>,
+                                         <0 1 0 100 250 4 36 0 1>,
+                                         <0 2 0 100 250 4 36 0 1>,
+                                         <0 3 0 100 250 4 36 0 1>,
+                                         <0 4 0 100 250 4 36 0 1>,
+                                         <0 5 0 100 250 4 36 0 1>,
+                                         <0 6 0 100 250 4 36 0 1>,
+                                         <0 7 0 100 250 4 36 0 1>,
+                                         <0 8 0 128 250 4 36 0 1>,
+                                         <0 9 0 128 250 4 36 0 1>,
+                                         <0 10 0 128 250 4 36 0 1>,
+                                         <0 11 0 128 250 4 36 0 1>,
+                                         <0 12 0 128 250 4 36 0 1>,
+                                         <0 13 0 128 250 4 36 0 1>,
+                                         <0 14 0 40 250 4 36 0 1>;
+              };
+
+              queue-management-config {
+                      qcom,group-config = <0 2000 0 0 0>;
+                      qcom,queue-config = <0 256 0 0 400 4 36 1>,
+                                          <256 44 0 0 250 0 36 0>;
+              };
+
+              port-scheduler-resource {
+                      port0 {
+                              port-id = <0>;
+                              qcom,ucast-queue = <0 63>;
+                              qcom,mcast-queue = <256 263>;
+                              qcom,l0sp = <0 0>;
+                              qcom,l0cdrr = <0 7>;
+                              qcom,l0edrr = <0 7>;
+                              qcom,l1cdrr = <0 0>;
+                              qcom,l1edrr = <0 0>;
+                      };
+
+                      port1 {
+                              port-id = <1>;
+                              qcom,ucast-queue = <204 211>;
+                              qcom,mcast-queue = <272 275>;
+                              qcom,l0sp = <51 52>;
+                              qcom,l0cdrr = <108 115>;
+                              qcom,l0edrr = <108 115>;
+                              qcom,l1cdrr = <23 24>;
+                              qcom,l1edrr = <23 24>;
+                      };
+
+                      port2 {
+                              port-id = <2>;
+                              qcom,ucast-queue = <212 219>;
+                              qcom,mcast-queue = <276 279>;
+                              qcom,l0sp = <53 54>;
+                              qcom,l0cdrr = <116 123>;
+                              qcom,l0edrr = <116 123>;
+                              qcom,l1cdrr = <25 26>;
+                              qcom,l1edrr = <25 26>;
+                      };
+
+                      port3 {
+                              port-id = <3>;
+                              qcom,ucast-queue = <220 227>;
+                              qcom,mcast-queue = <280 283>;
+                              qcom,l0sp = <55 56>;
+                              qcom,l0cdrr = <124 131>;
+                              qcom,l0edrr = <124 131>;
+                              qcom,l1cdrr = <27 28>;
+                              qcom,l1edrr = <27 28>;
+                      };
+
+                      port4 {
+                              port-id = <4>;
+                              qcom,ucast-queue = <228 235>;
+                              qcom,mcast-queue = <284 287>;
+                              qcom,l0sp = <57 58>;
+                              qcom,l0cdrr = <132 139>;
+                              qcom,l0edrr = <132 139>;
+                              qcom,l1cdrr = <29 30>;
+                              qcom,l1edrr = <29 30>;
+                      };
+
+                      port5 {
+                              port-id = <5>;
+                              qcom,ucast-queue = <236 243>;
+                              qcom,mcast-queue = <288 291>;
+                              qcom,l0sp = <59 60>;
+                              qcom,l0cdrr = <140 147>;
+                              qcom,l0edrr = <140 147>;
+                              qcom,l1cdrr = <31 32>;
+                              qcom,l1edrr = <31 32>;
+                      };
+
+                      port6 {
+                              port-id = <6>;
+                              qcom,ucast-queue = <244 251>;
+                              qcom,mcast-queue = <292 295>;
+                              qcom,l0sp = <61 62>;
+                              qcom,l0cdrr = <148 155>;
+                              qcom,l0edrr = <148 155>;
+                              qcom,l1cdrr = <33 34>;
+                              qcom,l1edrr = <33 34>;
+                      };
+
+                      port7 {
+                              port-id = <7>;
+                              qcom,ucast-queue = <252 255>;
+                              qcom,mcast-queue = <296 299>;
+                              qcom,l0sp = <63 63>;
+                              qcom,l0cdrr = <156 159>;
+                              qcom,l0edrr = <156 159>;
+                              qcom,l1cdrr = <35 35>;
+                              qcom,l1edrr = <35 35>;
+                      };
+              };
+
+              port-scheduler-config {
+                      port0 {
+                              port-id = <0>;
+                              l1scheduler {
+                                      group0 {
+                                              qcom,flow = <0>;
+                                              qcom,scheduler-config = <0 0 0 0 0>;
+                                      };
+                              };
+
+                              l0scheduler {
+                                      group0 {
+                                              qcom,ucast-queue = <0>;
+                                              qcom,ucast-loop-priority = <8>;
+                                              qcom,mcast-queue = <256>;
+                                              qcom,scheduler-config = <0 0 0 0 0>;
+                                      };
+
+                                      group1 {
+                                              qcom,ucast-queue = <8>;
+                                              qcom,ucast-loop-priority = <8>;
+                                              qcom,mcast-queue = <257>;
+                                              qcom,scheduler-config = <0 0 0 0 0>;
+                                      };
+
+                                      group2 {
+                                              qcom,ucast-queue = <16>;
+                                              qcom,ucast-loop-priority = <8>;
+                                              qcom,mcast-queue = <258>;
+                                              qcom,scheduler-config = <0 0 0 0 0>;
+                                      };
+
+                                      group3 {
+                                              qcom,ucast-queue = <24>;
+                                              qcom,ucast-loop-priority = <8>;
+                                              qcom,mcast-queue = <259>;
+                                              qcom,scheduler-config = <0 0 0 0 0>;
+                                      };
+
+                                      group4 {
+                                              qcom,ucast-queue = <32>;
+                                              qcom,ucast-loop-priority = <8>;
+                                              qcom,mcast-queue = <260>;
+                                              qcom,scheduler-config = <0 0 0 0 0>;
+                                      };
+
+                                      group5 {
+                                              qcom,ucast-queue = <40>;
+                                              qcom,ucast-loop-priority = <8>;
+                                              qcom,mcast-queue = <261>;
+                                              qcom,scheduler-config = <0 0 0 0 0>;
+                                      };
+
+                                      group6 {
+                                              qcom,ucast-queue = <48>;
+                                              qcom,ucast-loop-priority = <8>;
+                                              qcom,mcast-queue = <262>;
+                                              qcom,scheduler-config = <0 0 0 0 0>;
+                                      };
+
+                                      group7 {
+                                              qcom,ucast-queue = <56>;
+                                              qcom,ucast-loop-priority = <8>;
+                                              qcom,mcast-queue = <263>;
+                                              qcom,scheduler-config = <0 0 0 0 0>;
+                                      };
+                              };
+                      };
+
+                      port1 {
+                              port-id = <1>;
+                              l1scheduler {
+                                      group0 {
+                                              qcom,flow = <51>;
+                                              qcom,flow-loop-priority = <2>;
+                                              qcom,scheduler-config = <1 0 23 0 23>;
+                                      };
+                              };
+
+                              l0scheduler {
+                                      group0 {
+                                              qcom,ucast-queue = <204>;
+                                              qcom,ucast-loop-priority = <8>;
+                                              qcom,drr-max-priority = <4>;
+                                              qcom,mcast-queue = <272>;
+                                              qcom,mcast-loop-priority = <4>;
+                                              qcom,scheduler-config = <51 0 108 0 108>;
+                                      };
+                              };
+                      };
+
+                      port2 {
+                              port-id = <2>;
+                              l1scheduler {
+                                      group0 {
+                                              qcom,flow = <53>;
+                                              qcom,flow-loop-priority = <2>;
+                                              qcom,scheduler-config = <2 0 25 0 25>;
+                                      };
+                              };
+
+                              l0scheduler {
+                                      group0 {
+                                              qcom,ucast-queue = <212>;
+                                              qcom,ucast-loop-priority = <8>;
+                                              qcom,drr-max-priority = <4>;
+                                              qcom,mcast-queue = <276>;
+                                              qcom,mcast-loop-priority = <4>;
+                                              qcom,scheduler-config = <53 0 116 0 116>;
+                                      };
+                              };
+                      };
+
+                      port3 {
+                              port-id = <3>;
+                              l1scheduler {
+                                      group0 {
+                                              qcom,flow = <55>;
+                                              qcom,flow-loop-priority = <2>;
+                                              qcom,scheduler-config = <3 0 27 0 27>;
+                                      };
+                              };
+
+                              l0scheduler {
+                                      group0 {
+                                              qcom,ucast-queue = <220>;
+                                              qcom,ucast-loop-priority = <8>;
+                                              qcom,drr-max-priority = <4>;
+                                              qcom,mcast-queue = <280>;
+                                              qcom,mcast-loop-priority = <4>;
+                                              qcom,scheduler-config = <55 0 124 0 124>;
+                                      };
+                              };
+                      };
+
+                      port4 {
+                              port-id = <4>;
+                              l1scheduler {
+                                      group0 {
+                                              qcom,flow = <57>;
+                                              qcom,flow-loop-priority = <2>;
+                                              qcom,scheduler-config = <4 0 29 0 29>;
+                                      };
+                              };
+
+                              l0scheduler {
+                                      group0 {
+                                              qcom,ucast-queue = <228>;
+                                              qcom,ucast-loop-priority = <8>;
+                                              qcom,drr-max-priority = <4>;
+                                              qcom,mcast-queue = <284>;
+                                              qcom,mcast-loop-priority = <4>;
+                                              qcom,scheduler-config = <57 0 132 0 132>;
+                                      };
+                              };
+                      };
+
+                      port5 {
+                              port-id = <5>;
+                              l1scheduler {
+                                      group0 {
+                                              qcom,flow = <59>;
+                                              qcom,flow-loop-priority = <2>;
+                                              qcom,scheduler-config = <5 0 31 0 31>;
+                                      };
+                              };
+
+                              l0scheduler {
+                                      group0 {
+                                              qcom,ucast-queue = <236>;
+                                              qcom,ucast-loop-priority = <8>;
+                                              qcom,drr-max-priority = <4>;
+                                              qcom,mcast-queue = <288>;
+                                              qcom,mcast-loop-priority = <4>;
+                                              qcom,scheduler-config = <59 0 140 0 140>;
+                                      };
+                              };
+                      };
+
+                      port6 {
+                              port-id = <6>;
+                              l1scheduler {
+                                      group0 {
+                                              qcom,flow = <61>;
+                                              qcom,flow-loop-priority = <2>;
+                                              qcom,scheduler-config = <6 0 33 0 33>;
+                                      };
+                              };
+
+                              l0scheduler {
+                                      group0 {
+                                              qcom,ucast-queue = <244>;
+                                              qcom,ucast-loop-priority = <8>;
+                                              qcom,drr-max-priority = <4>;
+                                              qcom,mcast-queue = <292>;
+                                              qcom,mcast-loop-priority = <4>;
+                                              qcom,scheduler-config = <61 0 148 0 148>;
+                                      };
+                              };
+                      };
+
+                      port7 {
+                              port-id = <7>;
+                              l1scheduler {
+                                      group0 {
+                                              qcom,flow = <63>;
+                                              qcom,scheduler-config = <7 0 35 0 35>;
+                                      };
+                              };
+
+                              l0scheduler {
+                                      group0 {
+                                              qcom,ucast-queue = <252>;
+                                              qcom,ucast-loop-priority = <4>;
+                                              qcom,mcast-queue = <296>;
+                                              qcom,mcast-loop-priority = <4>;
+                                              qcom,scheduler-config = <63 0 156 0 156>;
+                                      };
+                              };
+                      };
+              };
+      };
+    };
-- 
2.42.0



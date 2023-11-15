Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369F47E884D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 03:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345630AbjKKCdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 21:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344606AbjKKCd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 21:33:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED383C39;
        Fri, 10 Nov 2023 18:33:25 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AB27N9i023789;
        Sat, 11 Nov 2023 02:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=H56nZkmihSBILhUdChYQepHUTW1pnpoYQBFV8HnWCh8=;
 b=lvDpWEgtkm6ZHt9aJs4omS7TWB8y2VcjrLYUOHUeg/CBtW6yKVR/zDpO5Cd8QYvkXlco
 AnY17nyA2Bw+2cpD2JKRhkm93OKQoBp5W2Rv4V4AZ/WMNDYc3CT9LuOZG3nXATcSKnuC
 c0wjM+oU+1+iw+mt6GHpPhLNHy059arg7umUyr3yVUnpT2azEJBi/mBvSGiecQpoeaO3
 3Ek5nz9jfMwPhFaAzna6JQufnn4HLzJBAt8SYJmoCV1B8rWvcdjM3YcIYCq3yHin5LU4
 k/FY+JBhtXtufVGalqhfpaMIhA11dRttl2CV5XnGGuF8xKMwgn/FRcf22c7X9aGcRoKB 3Q== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u9f3k2j79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 02:33:12 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AB2X8hm021713;
        Sat, 11 Nov 2023 02:33:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3u5f1mjp48-1;
        Sat, 11 Nov 2023 02:33:08 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AB2X8Yi021707;
        Sat, 11 Nov 2023 02:33:08 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3AB2X8DB021699;
        Sat, 11 Nov 2023 02:33:08 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id 65B702C83; Sat, 11 Nov 2023 08:03:07 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org, robh+dt@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, quic_schintav@quicinc.com,
        quic_shijjose@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev
Subject: [PATCH v8 1/5] dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC
Date:   Sat, 11 Nov 2023 08:02:57 +0530
Message-Id: <1699669982-7691-2-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1699669982-7691-1-git-send-email-quic_msarkar@quicinc.com>
References: <1699669982-7691-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1wNfbzSPHIDaG_jP435BJOTqB7xVlEmL
X-Proofpoint-GUID: 1wNfbzSPHIDaG_jP435BJOTqB7xVlEmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_21,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxlogscore=920
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311110018
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings support for SA8775P SoC. It has DMA register
space and dma interrupt to support HDMA.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 64 +++++++++++++++++++++-
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index a223ce0..46802f7 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,sa8775p-pcie-ep
           - qcom,sdx55-pcie-ep
           - qcom,sm8450-pcie-ep
       - items:
@@ -20,6 +21,7 @@ properties:
           - const: qcom,sdx55-pcie-ep
 
   reg:
+    minItems: 6
     items:
       - description: Qualcomm-specific PARF configuration registers
       - description: DesignWare PCIe registers
@@ -27,8 +29,10 @@ properties:
       - description: Address Translation Unit (ATU) registers
       - description: Memory region used to map remote RC address space
       - description: BAR memory region
+      - description: DMA register space
 
   reg-names:
+    minItems: 6
     items:
       - const: parf
       - const: dbi
@@ -36,13 +40,14 @@ properties:
       - const: atu
       - const: addr_space
       - const: mmio
+      - const: dma
 
   clocks:
-    minItems: 7
+    minItems: 5
     maxItems: 8
 
   clock-names:
-    minItems: 7
+    minItems: 5
     maxItems: 8
 
   qcom,perst-regs:
@@ -57,14 +62,18 @@ properties:
           - description: Perst separation enable offset
 
   interrupts:
+    minItems: 2
     items:
       - description: PCIe Global interrupt
       - description: PCIe Doorbell interrupt
+      - description: DMA interrupt
 
   interrupt-names:
+    minItems: 2
     items:
       - const: global
       - const: doorbell
+      - const: dma
 
   reset-gpios:
     description: GPIO used as PERST# input signal
@@ -125,6 +134,10 @@ allOf:
               - qcom,sdx55-pcie-ep
     then:
       properties:
+        reg:
+          maxItems: 6
+        reg-names:
+          maxItems: 6
         clocks:
           items:
             - description: PCIe Auxiliary clock
@@ -143,6 +156,10 @@ allOf:
             - const: slave_q2a
             - const: sleep
             - const: ref
+        interrupts:
+          maxItems: 2
+        interrupt-names:
+          maxItems: 2
 
   - if:
       properties:
@@ -152,6 +169,10 @@ allOf:
               - qcom,sm8450-pcie-ep
     then:
       properties:
+        reg:
+          maxItems: 6
+        reg-names:
+          maxItems: 6
         clocks:
           items:
             - description: PCIe Auxiliary clock
@@ -172,6 +193,45 @@ allOf:
             - const: ref
             - const: ddrss_sf_tbu
             - const: aggre_noc_axi
+        interrupts:
+          maxItems: 2
+        interrupt-names:
+          maxItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sa8775p-pcie-ep
+    then:
+      properties:
+        reg:
+          minItems: 7
+          maxItems: 7
+        reg-names:
+          minItems: 7
+          maxItems: 7
+        clocks:
+          items:
+            - description: PCIe Auxiliary clock
+            - description: PCIe CFG AHB clock
+            - description: PCIe Master AXI clock
+            - description: PCIe Slave AXI clock
+            - description: PCIe Slave Q2A AXI clock
+        clock-names:
+          items:
+            - const: aux
+            - const: cfg
+            - const: bus_master
+            - const: bus_slave
+            - const: slave_q2a
+        interrupts:
+          minItems: 3
+          maxItems: 3
+        interrupt-names:
+          minItems: 3
+          maxItems: 3
 
 unevaluatedProperties: false
 
-- 
2.7.4


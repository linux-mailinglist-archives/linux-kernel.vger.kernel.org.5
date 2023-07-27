Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62776765445
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbjG0MoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjG0MoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:44:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AF6E4D;
        Thu, 27 Jul 2023 05:44:03 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RBpUlo016350;
        Thu, 27 Jul 2023 12:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=Kd6xX8/umdUpmhU9BoBc3hBEmZIT4/kStSA2I8ASQGE=;
 b=BY7h8BZDa1Yz1i2GcG/umHv9T31H+6aetBW39lt4DVVUC8rKSTcvn4DK/ph9ywyZZ1xB
 cnQIOmte3hwZTcWtXZBX3oJ9zKclvB+2ncGcmqx3UMeVv0FqbPYCDNbBxmLTVpRj/xA4
 H8fEN723DlEpvGtIHc8VBXw6bim8ymq3Bh5VidjqqUe63uVIH9X5gj4rqEWLhvD7rDXU
 CEHbchDsNvl8+uoi8DjogQlVxEB36ikFrFzKDbvlt+MCge+z1tBP3Ntcfuli8WZVFzXZ
 5eR6PSex5cU43OQ71hbSTtrcAaNEopbnvdt1dEj4jsDZxuIRXoQj1N8ufHL5RmQXxMX4 Ng== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s34x6jg8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 12:43:43 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36RChdOb009568;
        Thu, 27 Jul 2023 12:43:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3s086m9aq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Jul 2023 12:43:39 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36RChcbF009559;
        Thu, 27 Jul 2023 12:43:38 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36RChcVV009558;
        Thu, 27 Jul 2023 12:43:38 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 7DC6D19BD; Thu, 27 Jul 2023 18:13:37 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        mchehab@kernel.org, ulf.hansson@linaro.org,
        mathieu.poirier@linaro.org, jonathan@marek.ca,
        vladimir.zapolskiy@linaro.org, quic_tdas@quicinc.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        bhupesh.sharma@linaro.org, mani@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2] dt-bindings: qcom: Update RPMHPD entries for some SoCs
Date:   Thu, 27 Jul 2023 18:13:33 +0530
Message-Id: <1690461813-22564-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ODp0YJ8FcE3Jrw7EmWd6L7F2EDVKVwvn
X-Proofpoint-ORIG-GUID: ODp0YJ8FcE3Jrw7EmWd6L7F2EDVKVwvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=773
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270113
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the RPMHPD references with new bindings defined in rpmhpd.h
for Qualcomm SoCs SM8[2345]50.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---

Changes in v2:
 - Removed the unnecessary inclusion of header rpmpd.h.

This patch is dependent on the series that includes the new rpmhpd.h header
https://lore.kernel.org/all/1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com/

 Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml   | 4 ++--
 Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml  | 4 ++--
 Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml    | 4 ++--
 Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml   | 4 ++--
 Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml  | 4 ++--
 Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml   | 4 ++--
 Documentation/devicetree/bindings/clock/qcom,videocc.yaml         | 4 ++--
 .../devicetree/bindings/display/msm/qcom,sm8250-dpu.yaml          | 4 ++--
 .../devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml         | 8 ++++----
 .../devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml          | 4 ++--
 .../devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml         | 6 +++---
 .../devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml          | 4 ++--
 .../devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml         | 8 ++++----
 .../devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml          | 4 ++--
 .../devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml         | 8 ++++----
 Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml    | 4 ++--
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml              | 4 ++--
 Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml | 6 +++---
 18 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
index d6774db..59cc88a 100644
--- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
@@ -82,7 +82,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
     clock-controller@af00000 {
       compatible = "qcom,sm8250-dispcc";
       reg = <0x0af00000 0x10000>;
@@ -103,7 +103,7 @@ examples:
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
-      power-domains = <&rpmhpd SM8250_MMCX>;
+      power-domains = <&rpmhpd RPMHPD_MMCX>;
       required-opps = <&rpmhpd_opp_low_svs>;
     };
 ...
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
index 23505c8..d723bb1 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
@@ -51,7 +51,7 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
 
     clock-controller@abf0000 {
       compatible = "qcom,sm8350-videocc";
@@ -59,7 +59,7 @@ examples:
       clocks = <&rpmhcc RPMH_CXO_CLK>,
                <&rpmhcc RPMH_CXO_CLK_A>,
                <&sleep_clk>;
-      power-domains = <&rpmhpd SM8350_MMCX>;
+      power-domains = <&rpmhpd RPMHPD_MMCX>;
       required-opps = <&rpmhpd_opp_low_svs>;
       #clock-cells = <1>;
       #reset-cells = <1>;
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
index 87ae741..8178c35 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
@@ -64,7 +64,7 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sm8450.h>
     #include <dt-bindings/clock/qcom,rpmh.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
     clock-controller@ade0000 {
       compatible = "qcom,sm8450-camcc";
       reg = <0xade0000 0x20000>;
@@ -72,7 +72,7 @@ examples:
                <&rpmhcc RPMH_CXO_CLK>,
                <&rpmhcc RPMH_CXO_CLK_A>,
                <&sleep_clk>;
-      power-domains = <&rpmhpd SM8450_MMCX>;
+      power-domains = <&rpmhpd RPMHPD_MMCX>;
       required-opps = <&rpmhpd_opp_low_svs>;
       #clock-cells = <1>;
       #reset-cells = <1>;
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml
index 1dd1f69..2f22310 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml
@@ -76,7 +76,7 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sm8450.h>
     #include <dt-bindings/clock/qcom,rpmh.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
     clock-controller@af00000 {
       compatible = "qcom,sm8450-dispcc";
       reg = <0x0af00000 0x10000>;
@@ -91,7 +91,7 @@ examples:
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
-      power-domains = <&rpmhpd SM8450_MMCX>;
+      power-domains = <&rpmhpd RPMHPD_MMCX>;
       required-opps = <&rpmhpd_opp_low_svs>;
     };
 ...
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
index f1c6dd5..bad8f01 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
@@ -64,13 +64,13 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sm8450.h>
     #include <dt-bindings/clock/qcom,rpmh.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
     videocc: clock-controller@aaf0000 {
       compatible = "qcom,sm8450-videocc";
       reg = <0x0aaf0000 0x10000>;
       clocks = <&rpmhcc RPMH_CXO_CLK>,
                <&gcc GCC_VIDEO_AHB_CLK>;
-      power-domains = <&rpmhpd SM8450_MMCX>;
+      power-domains = <&rpmhpd RPMHPD_MMCX>;
       required-opps = <&rpmhpd_opp_low_svs>;
       #clock-cells = <1>;
       #reset-cells = <1>;
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
index ab25f7c..c129f8c 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
@@ -76,7 +76,7 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,sm8550-gcc.h>
     #include <dt-bindings/clock/qcom,rpmh.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
     clock-controller@af00000 {
       compatible = "qcom,sm8550-dispcc";
       reg = <0x0af00000 0x10000>;
@@ -99,7 +99,7 @@ examples:
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
-      power-domains = <&rpmhpd SM8550_MMCX>;
+      power-domains = <&rpmhpd RPMHPD_MMCX>;
       required-opps = <&rpmhpd_opp_low_svs>;
     };
 ...
diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
index 2b07146..6de01cf 100644
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
@@ -124,7 +124,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
     clock-controller@ab00000 {
       compatible = "qcom,sdm845-videocc";
       reg = <0x0ab00000 0x10000>;
@@ -133,7 +133,7 @@ examples:
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
-      power-domains = <&rpmhpd SM8250_MMCX>;
+      power-domains = <&rpmhpd RPMHPD_MMCX>;
       required-opps = <&rpmhpd_opp_low_svs>;
     };
 ...
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8250-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8250-dpu.yaml
index 687c8c1..acd2ed3 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8250-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8250-dpu.yaml
@@ -54,7 +54,7 @@ examples:
     #include <dt-bindings/clock/qcom,gcc-sm8250.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interconnect/qcom,sm8250.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
 
     display-controller@ae01000 {
         compatible = "qcom,sm8250-dpu";
@@ -72,7 +72,7 @@ examples:
         assigned-clock-rates = <19200000>;
 
         operating-points-v2 = <&mdp_opp_table>;
-        power-domains = <&rpmhpd SM8250_MMCX>;
+        power-domains = <&rpmhpd RPMHPD_MMCX>;
 
         interrupt-parent = <&mdss>;
         interrupts = <0>;
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml
index 368d3db..5cfb9b9 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml
@@ -76,7 +76,7 @@ examples:
     #include <dt-bindings/clock/qcom,rpmh.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interconnect/qcom,sm8250.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
 
     display-subsystem@ae00000 {
         compatible = "qcom,sm8250-mdss";
@@ -121,7 +121,7 @@ examples:
             assigned-clock-rates = <19200000>;
 
             operating-points-v2 = <&mdp_opp_table>;
-            power-domains = <&rpmhpd SM8250_MMCX>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
 
             interrupt-parent = <&mdss>;
             interrupts = <0>;
@@ -196,7 +196,7 @@ examples:
             assigned-clock-parents = <&dsi0_phy 0>, <&dsi0_phy 1>;
 
             operating-points-v2 = <&dsi_opp_table>;
-            power-domains = <&rpmhpd SM8250_MMCX>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
 
             phys = <&dsi0_phy>;
             phy-names = "dsi";
@@ -286,7 +286,7 @@ examples:
             assigned-clock-parents = <&dsi1_phy 0>, <&dsi1_phy 1>;
 
             operating-points-v2 = <&dsi_opp_table>;
-            power-domains = <&rpmhpd SM8250_MMCX>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
 
             phys = <&dsi1_phy>;
             phy-names = "dsi";
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml
index 1205003..1a4e035 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml
@@ -51,7 +51,7 @@ examples:
     #include <dt-bindings/clock/qcom,gcc-sm8350.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interconnect/qcom,sm8350.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
 
     display-controller@ae01000 {
         compatible = "qcom,sm8350-dpu";
@@ -76,7 +76,7 @@ examples:
         assigned-clock-rates = <19200000>;
 
         operating-points-v2 = <&mdp_opp_table>;
-        power-domains = <&rpmhpd SM8350_MMCX>;
+        power-domains = <&rpmhpd RPMHPD_MMCX>;
 
         interrupt-parent = <&mdss>;
         interrupts = <0>;
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml
index 79a226e..1056bed 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml
@@ -75,7 +75,7 @@ examples:
     #include <dt-bindings/clock/qcom,rpmh.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interconnect/qcom,sm8350.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
 
     display-subsystem@ae00000 {
         compatible = "qcom,sm8350-mdss";
@@ -128,7 +128,7 @@ examples:
             assigned-clock-rates = <19200000>;
 
             operating-points-v2 = <&mdp_opp_table>;
-            power-domains = <&rpmhpd SM8350_MMCX>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
 
             interrupt-parent = <&mdss>;
             interrupts = <0>;
@@ -197,7 +197,7 @@ examples:
                                  <&mdss_dsi0_phy 1>;
 
             operating-points-v2 = <&dsi_opp_table>;
-            power-domains = <&rpmhpd SM8350_MMCX>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
 
             phys = <&mdss_dsi0_phy>;
 
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml
index 0d17ece..da3fd66 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml
@@ -58,7 +58,7 @@ examples:
     #include <dt-bindings/clock/qcom,gcc-sm8450.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interconnect/qcom,sm8450.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
 
     display-controller@ae01000 {
         compatible = "qcom,sm8450-dpu";
@@ -83,7 +83,7 @@ examples:
         assigned-clock-rates = <19200000>;
 
         operating-points-v2 = <&mdp_opp_table>;
-        power-domains = <&rpmhpd SM8450_MMCX>;
+        power-domains = <&rpmhpd RPMHPD_MMCX>;
 
         interrupt-parent = <&mdss>;
         interrupts = <0>;
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
index f26eb56..6dd21af 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
@@ -68,7 +68,7 @@ examples:
     #include <dt-bindings/clock/qcom,rpmh.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interconnect/qcom,sm8450.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
 
     display-subsystem@ae00000 {
         compatible = "qcom,sm8450-mdss";
@@ -122,7 +122,7 @@ examples:
             assigned-clock-rates = <19200000>;
 
             operating-points-v2 = <&mdp_opp_table>;
-            power-domains = <&rpmhpd SM8450_MMCX>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
 
             interrupt-parent = <&mdss>;
             interrupts = <0>;
@@ -202,7 +202,7 @@ examples:
             assigned-clock-parents = <&dsi0_phy 0>, <&dsi0_phy 1>;
 
             operating-points-v2 = <&dsi_opp_table>;
-            power-domains = <&rpmhpd SM8450_MMCX>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
 
             phys = <&dsi0_phy>;
             phy-names = "dsi";
@@ -297,7 +297,7 @@ examples:
             assigned-clock-parents = <&dsi1_phy 0>, <&dsi1_phy 1>;
 
             operating-points-v2 = <&dsi_opp_table>;
-            power-domains = <&rpmhpd SM8450_MMCX>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
 
             phys = <&dsi1_phy>;
             phy-names = "dsi";
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml
index ff58a74..99908fb 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml
@@ -57,7 +57,7 @@ examples:
     #include <dt-bindings/clock/qcom,sm8550-dispcc.h>
     #include <dt-bindings/clock/qcom,sm8550-gcc.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
 
     display-controller@ae01000 {
         compatible = "qcom,sm8550-dpu";
@@ -82,7 +82,7 @@ examples:
         assigned-clock-rates = <19200000>;
 
         operating-points-v2 = <&mdp_opp_table>;
-        power-domains = <&rpmhpd SM8550_MMCX>;
+        power-domains = <&rpmhpd RPMHPD_MMCX>;
 
         interrupt-parent = <&mdss>;
         interrupts = <0>;
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml
index 887be33..a464312 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml
@@ -68,7 +68,7 @@ examples:
     #include <dt-bindings/clock/qcom,rpmh.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interconnect/qcom,sm8550-rpmh.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
 
     display-subsystem@ae00000 {
         compatible = "qcom,sm8550-mdss";
@@ -122,7 +122,7 @@ examples:
             assigned-clock-rates = <19200000>;
 
             operating-points-v2 = <&mdp_opp_table>;
-            power-domains = <&rpmhpd SM8550_MMCX>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
 
             interrupt-parent = <&mdss>;
             interrupts = <0>;
@@ -197,7 +197,7 @@ examples:
             assigned-clock-parents = <&dsi0_phy 0>, <&dsi0_phy 1>;
 
             operating-points-v2 = <&dsi_opp_table>;
-            power-domains = <&rpmhpd SM8550_MMCX>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
 
             phys = <&dsi0_phy>;
             phy-names = "dsi";
@@ -286,7 +286,7 @@ examples:
             assigned-clock-parents = <&dsi1_phy 0>, <&dsi1_phy 1>;
 
             operating-points-v2 = <&dsi_opp_table>;
-            power-domains = <&rpmhpd SM8550_MMCX>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
 
             phys = <&dsi1_phy>;
             phy-names = "dsi";
diff --git a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
index 7915dcd..f66033a 100644
--- a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
@@ -106,7 +106,7 @@ examples:
     #include <dt-bindings/clock/qcom,videocc-sm8250.h>
     #include <dt-bindings/interconnect/qcom,sm8250.h>
     #include <dt-bindings/clock/qcom,gcc-sm8250.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
 
     venus: video-codec@aa00000 {
         compatible = "qcom,sm8250-venus";
@@ -114,7 +114,7 @@ examples:
         interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
         power-domains = <&videocc MVS0C_GDSC>,
                         <&videocc MVS0_GDSC>,
-                        <&rpmhpd SM8250_MX>;
+                        <&rpmhpd RPMHPD_MX>;
         power-domain-names = "venus", "vcodec0", "mx";
 
         clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 6da28e6..80141eb 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -215,7 +215,7 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/qcom,gcc-sm8250.h>
     #include <dt-bindings/clock/qcom,rpmh.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
 
     sdhc_2: mmc@8804000 {
       compatible = "qcom,sm8250-sdhci", "qcom,sdhci-msm-v5";
@@ -232,7 +232,7 @@ examples:
       iommus = <&apps_smmu 0x4a0 0x0>;
       qcom,dll-config = <0x0007642c>;
       qcom,ddr-config = <0x80040868>;
-      power-domains = <&rpmhpd SM8250_CX>;
+      power-domains = <&rpmhpd RPMHPD_CX>;
 
       operating-points-v2 = <&sdhc2_opp_table>;
 
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
index af24f9a..9a04d19 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
@@ -139,7 +139,7 @@ examples:
     #include <dt-bindings/clock/qcom,rpmh.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/mailbox/qcom-ipcc.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
 
     remoteproc@30000000 {
         compatible = "qcom,sm8450-adsp-pas";
@@ -160,8 +160,8 @@ examples:
 
         memory-region = <&adsp_mem>;
 
-        power-domains = <&rpmhpd SM8450_LCX>,
-                        <&rpmhpd SM8450_LMX>;
+        power-domains = <&rpmhpd RPMHPD_LCX>,
+                        <&rpmhpd RPMHPD_LMX>;
         power-domain-names = "lcx", "lmx";
 
         qcom,qmp = <&aoss_qmp>;
-- 
2.7.4


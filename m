Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5D07AAC46
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjIVIMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjIVILt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:11:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30898A9;
        Fri, 22 Sep 2023 01:11:43 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M5MT1D025494;
        Fri, 22 Sep 2023 08:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=6uYlX5IYxZoYeDr9ljzkBrhqLj6FcLpxy/K98TiwgNI=;
 b=n1JBoGxzdwCz8CEMZZL7i35tQ5B//k6wq7FLwhu3lcNVQy9pXcO8adtdA/jWfvW9SQhO
 X0argvouRZzX7MJUmtXVnSKU4/3uhUREzhJMXe1t2ICKQfEh/uz+lRMzDS9D41FcKoh4
 wmdJ7ULNv9bcH7aQhaOMmwSDghj7HCl6p2l/tixG06ROL0k2eCqjFFWCvWlxRjInf4QE
 sQcfwTNZSUzJncVf6iyYvp1jlF7FeKOoCrDdkthlgI0s32aIYu3laO7TFBaBAX5HunUh
 nF9JWwaNTnPbdH+yuGJNHxJZmkKOme9BOmysfbbPqjpYTTC8pTcRlSfoEOZJ9lzJQAdM 5A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8u5n1c7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 08:11:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38M8B82j031955
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 08:11:08 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 22 Sep 2023 01:10:56 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <tglx@linutronix.de>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v4 0/6] soc: qcom: Add uart console support for SM4450
Date:   Fri, 22 Sep 2023 16:10:20 +0800
Message-ID: <20230922081026.2799-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GcvvbLXYa5CucNMiTAmDfHkJzmXQGE2u
X-Proofpoint-GUID: GcvvbLXYa5CucNMiTAmDfHkJzmXQGE2u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_06,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=635
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220067
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add base description of UART, TLMM, RPMHCC, GCC and RPMh PD
nodes which helps SM4450 boot to shell with console on boards with this
SoC.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
This patch series depends on below patch series:
"[PATCH v2 0/4] clk: qcom: Add support for GCC and RPMHCC on SM4450"
https://lore.kernel.org/linux-arm-msm/20230909123431.1725728-1-quic_ajipan@quicinc.com/
"[PATCH v4 0/2] pinctl: qcom: Add SM4450 pinctrl driver"
https://lore.kernel.org/linux-arm-msm/20230920082102.5744-1-quic_tengfan@quicinc.com/

v3 -> v4:
  - adjustment the sequence of property and property-names
  - update 0 to 0x0 for reg params
  - remove unrelated change
  - separate SoC change and board change

v2 -> v3:
  - fix dtbs_check warning
  - remove interconnect, iommu, scm and tcsr related code
  - rearrangement dt node
  - remove smmu, scm and tcsr related documentation update
  - enable CONFIG_SM_GCC_4450 in defconfig related patch

v1 -> v2:
  - setting "qcom,rpmh-rsc" compatible to the first property
  - keep order by unit address
  - move tlmm node into soc node
  - update arm,smmu.yaml
  - add enable pinctrl and interconnect defconfig patches
  - remove blank line
  - redo dtbs_check check

previous discussion here:
[1] v3: https://lore.kernel.org/linux-arm-msm/20230920082102.5744-1-quic_tengfan@quicinc.com
[2] v2: https://lore.kernel.org/linux-arm-msm/20230915021509.25773-1-quic_tengfan@quicinc.com
[3] v1: https://lore.kernel.org/linux-arm-msm/20230908065847.28382-1-quic_tengfan@quicinc.com

Ajit Pandey (1):
  arm64: dts: qcom: sm4450: Add apps_rsc and cmd_db node

Tengfei Fan (5):
  dt-bindings: interrupt-controller: qcom,pdc: document qcom,sm4450-pdc
  arm64: dts: qcom: sm4450: Add RPMH and Global clock
  arm64: dts: qcom: add uart console support for SM4450
  arm64: dts: qcom: sm4450-qrd: add QRD4450 uart support
  arm64: defconfig: enable clock controller and pinctrl

 .../interrupt-controller/qcom,pdc.yaml        |   1 +
 arch/arm64/boot/dts/qcom/sm4450-qrd.dts       |  19 +++-
 arch/arm64/boot/dts/qcom/sm4450.dtsi          | 107 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   2 +
 4 files changed, 127 insertions(+), 2 deletions(-)


base-commit: 940fcc189c51032dd0282cbee4497542c982ac59
-- 
2.17.1


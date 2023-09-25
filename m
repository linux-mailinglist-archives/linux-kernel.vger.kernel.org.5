Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5987AD08B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjIYGup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjIYGul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:50:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4254116;
        Sun, 24 Sep 2023 23:50:34 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P5PI7Q006052;
        Mon, 25 Sep 2023 06:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=9EanaLrILZopHgciFWq8LH3Z8/1L29aFYXgd26r0rcQ=;
 b=lhgobpWWXGKTOl1HxNz2iAFufAPQiBcsVllz9pNb4IfYAjfDHnFy9GizTWygqqnG/Mdr
 SKpRMIhUNKetsLVC162bPTNqj7ENTI7NZ/ZKoIWcywpPmwNS1gEo3yXrYwNl4qRHEyXc
 Q+rxN4bmmd4yknR1eKikrbzU4iMAP8Xuh/k7Gw+fJeaBzK2iZIs1dEEhLYVzYThTaB5o
 iRXGv66i1sjnwD5OEaO8FfBkfFZcCGhBj4afhRZkgkHSMVMtc2vhonFw+su0rv+IbzHP
 931A1Zx82TiK3XDCZeYlSDAml67YRiidR8tfKnYKQ88QwVcUbvHIzmmZMSaZeRndLjgi wg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9qm7u1rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 06:50:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38P6nxpJ015602
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 06:49:59 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sun, 24 Sep 2023 23:49:51 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <tglx@linutronix.de>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <u-kumar1@ti.com>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v5 0/7] soc: qcom: Add uart console support for SM4450
Date:   Mon, 25 Sep 2023 14:49:20 +0800
Message-ID: <20230925064927.26448-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _kcrEzW5oURGsRJdN0eAK89zb01EKw7b
X-Proofpoint-ORIG-GUID: _kcrEzW5oURGsRJdN0eAK89zb01EKw7b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_03,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=630
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

v4 -> v5:
  - separate reserved gpios setting from enable UART console patch

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
[1] v4: https://lore.kernel.org/linux-arm-msm/20230922081026.2799-1-quic_tengfan@quicinc.com
[2] v3: https://lore.kernel.org/linux-arm-msm/20230920082102.5744-1-quic_tengfan@quicinc.com
[3] v2: https://lore.kernel.org/linux-arm-msm/20230915021509.25773-1-quic_tengfan@quicinc.com
[4] v1: https://lore.kernel.org/linux-arm-msm/20230908065847.28382-1-quic_tengfan@quicinc.com

Ajit Pandey (1):
  arm64: dts: qcom: sm4450: Add apps_rsc and cmd_db node

Tengfei Fan (6):
  dt-bindings: interrupt-controller: qcom,pdc: document qcom,sm4450-pdc
  arm64: dts: qcom: sm4450: Add RPMH and Global clock
  arm64: dts: qcom: add uart console support for SM4450
  arm64: dts: qcom: sm4450-qrd: add QRD4450 uart support
  arm64: dts: qcom: sm4450-qrd: mark QRD4450 reserved gpios
  arm64: defconfig: enable clock controller and pinctrl

 .../interrupt-controller/qcom,pdc.yaml        |   1 +
 arch/arm64/boot/dts/qcom/sm4450-qrd.dts       |  19 +++-
 arch/arm64/boot/dts/qcom/sm4450.dtsi          | 107 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   2 +
 4 files changed, 127 insertions(+), 2 deletions(-)


base-commit: 940fcc189c51032dd0282cbee4497542c982ac59
-- 
2.17.1


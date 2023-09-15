Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C237A13A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjIOCQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 22:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIOCQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:16:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95FD1BEB;
        Thu, 14 Sep 2023 19:16:28 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F1VAFp015091;
        Fri, 15 Sep 2023 02:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ZjPVyq1MqpeBUl5lequMmDSTzopZyeP+Od7ITsvG1gc=;
 b=JwHKDU+3rZBVtJi7ROkIYDRs4Xq12q4cgYs8d8+PfL3ug6bUSZ5aGvez0ybcmp7RIoov
 6x/jXu0N2ZWIjy5o8phlkwugm/OlJbt2+y5GvGr3+n+ffYeSKn9w450NP+ujzBw9hRUR
 dlpaAZjgdogO9y9QpBrj5j3NdAlvIPIm1slEcfYgiJJVqjpeSt+VXoStPKX6utgB02/J
 KD14wkyFsEmHYDu424pAbA4Lss/JoL3bB4SI0166mCiZWEIxSNr1hktK/e+MMVpyYU62
 Mb96lKfRSxcj9saH7cVOpU7yh0zbmuemZC/bBX5EpxAHgPFp9oZgCDf3FHHoQsMyrZWg WQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4dncr2h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 02:15:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38F2Fgv1005246
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 02:15:42 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 19:15:34 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <catalin.marinas@arm.com>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v2 0/8] soc: qcom: Add uart console support for SM4450
Date:   Fri, 15 Sep 2023 10:15:00 +0800
Message-ID: <20230915021509.25773-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XdDXLfqqc3EedxKW86OfvWgPS5NuQ0TH
X-Proofpoint-ORIG-GUID: XdDXLfqqc3EedxKW86OfvWgPS5NuQ0TH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_02,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=492 mlxscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add base description of UART, TLMM, interconnect, TCSRCC
RPMHCC, GCC, RPMh PD and SMMU nodes which helps SM4450 boot to shell
with console on boards with this SoC.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
This patch series depends on below patch series:
"[PATCH v2 0/4] clk: qcom: Add support for GCC and RPMHCC on SM4450"
https://lore.kernel.org/linux-arm-msm/20230909123431.1725728-1-quic_ajipan@quicinc.com/
"[PATCH v2 0/2] pinctl: qcom: Add SM4450 pinctrl driver"
https://lore.kernel.org/linux-arm-msm/20230915015808.18296-1-quic_tengfan@quicinc.com/
"[PATCH v2 0/2] interconnect: qcom: Add SM4450 interconnect"
https://lore.kernel.org/linux-arm-msm/20230915020129.19611-1-quic_tengfan@quicinc.com/

v1 -> v2:
  - setting "qcom,rpmh-rsc" compatible to the first property
  - keep order by unit address
  - move tlmm node into soc node
  - update arm,smmu.yaml
  - add enable pinctrl and interconnect defconfig patches
  - remove blank line
  - redo dtbs_check check

previous discussion here:
[1]
https://lore.kernel.org/linux-arm-msm/20230908065847.28382-1-quic_tengfan@quicinc.com

Ajit Pandey (2):
  arm64: dts: qcom: sm4450: Add apps_rsc and cmd_db node
  arm64: dts: qcom: sm4450: Add RPMH and Global clock controller

Tengfei Fan (6):
  dt-bindings: firmware: document Qualcomm SM4450 SCM
  dt-bindings: mfd: qcom,tcsr: Add compatible for sm4450
  dt-bindings: interrupt-controller: qcom,pdc: document qcom,sm4450-pdc
  dt-bindings: arm-smmu: Add compatible for SM4450 SoC
  arm64: dts: qcom: add uart console support for SM4450
  arm64: defconfig: enable interconnect and pinctrl for SM4450

 .../bindings/firmware/qcom,scm.yaml           |   3 +
 .../interrupt-controller/qcom,pdc.yaml        |   1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml   |   3 +
 .../devicetree/bindings/mfd/qcom,tcsr.yaml    |   1 +
 arch/arm64/boot/dts/qcom/sm4450-qrd.dts       |  18 +-
 arch/arm64/boot/dts/qcom/sm4450.dtsi          | 309 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   2 +
 7 files changed, 335 insertions(+), 2 deletions(-)


base-commit: 98897dc735cf6635f0966f76eb0108354168fb15
-- 
2.17.1


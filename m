Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527917DC798
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343752AbjJaHvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbjJaHvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:51:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D83DE;
        Tue, 31 Oct 2023 00:51:02 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V6GtCo028034;
        Tue, 31 Oct 2023 07:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=K6chD/shS+2nuxb3muBTcToPEHVuKnDqJk9aUOjQttg=;
 b=LdbzxT5B7TqIuCEglJ5U+wWpSKlqjIHo0riAMzonKdv2nGwn6TXv6FOxAn+4LSBWiBBB
 hotSKSrh51ATMLUoyWa7AUusJ/1sttjlQwqSU28mqVxTPGaI85dPKF0kZr+mAlW2tFUF
 jwAE+NXhoyxYGZPE69uvN/ROO+TyFu74KG+GhQn+byiIBIS/Jj5h8i+Lb42f4bA7BtkB
 JiWD1dpUJoqquNF/y5hYoS46Wz2TsODpwZzWUN6G0KMZUj8soMvqgINEt3JCapQLCgvk
 9eovsNJbhr0gEOZ2FfHCBLINybMA7QeZtNxIcOR7axGvyzV18VgCMk8Vsi/0kGivpKx7 lA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u29fetnxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 07:50:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V7oZuR013205
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 07:50:35 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 31 Oct 2023 00:50:27 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <m.szyprowski@samsung.com>,
        <u-kumar1@ti.com>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v6 0/6] soc: qcom: Add uart console support for SM4450
Date:   Tue, 31 Oct 2023 15:49:58 +0800
Message-ID: <20231031075004.3850-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _9hEAuE4e9-GFilZ6tRnVsBR31lbOvl5
X-Proofpoint-ORIG-GUID: _9hEAuE4e9-GFilZ6tRnVsBR31lbOvl5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 mlxlogscore=582 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310060
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
"[PATCH v4 0/2] pinctl: qcom: Add SM4450 pinctrl driver"
https://lore.kernel.org/linux-arm-msm/20230920082102.5744-1-quic_tengfan@quicinc.com/

v5 -> v6:
  - remove link that depend on clock patch from cover letter
  - remove patch which already mainline

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
[1] v5: https://lore.kernel.org/linux-arm-msm/20231011031415.3360-1-quic_tengfan@quicinc.com
[2] v4: https://lore.kernel.org/linux-arm-msm/20230922081026.2799-1-quic_tengfan@quicinc.com
[3] v3: https://lore.kernel.org/linux-arm-msm/20230920082102.5744-1-quic_tengfan@quicinc.com
[4] v2: https://lore.kernel.org/linux-arm-msm/20230915021509.25773-1-quic_tengfan@quicinc.com
[4] v1: https://lore.kernel.org/linux-arm-msm/20230908065847.28382-1-quic_tengfan@quicinc.com

Ajit Pandey (1):
  arm64: dts: qcom: sm4450: Add apps_rsc and cmd_db node

Tengfei Fan (5):
  arm64: dts: qcom: sm4450: Add RPMH and Global clock
  arm64: dts: qcom: add uart console support for SM4450
  arm64: dts: qcom: sm4450-qrd: add QRD4450 uart support
  arm64: dts: qcom: sm4450-qrd: mark QRD4450 reserved gpios
  arm64: defconfig: enable clock controller and pinctrl

 arch/arm64/boot/dts/qcom/sm4450-qrd.dts |  19 ++++-
 arch/arm64/boot/dts/qcom/sm4450.dtsi    | 107 ++++++++++++++++++++++++
 arch/arm64/configs/defconfig            |   2 +
 3 files changed, 126 insertions(+), 2 deletions(-)


base-commit: c503e3eec382ac708ee7adf874add37b77c5d312
-- 
2.17.1


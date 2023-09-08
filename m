Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD25D7982E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240054AbjIHG7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjIHG7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:59:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F96510CF;
        Thu,  7 Sep 2023 23:59:34 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3886Hcks005785;
        Fri, 8 Sep 2023 06:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=0dh/W+s/vNwtSwiNENXAoa02cSlrDOw2zJYmcRo7rkE=;
 b=RoqacNWPpZs8v7Ohd/mOSh32Izx+mkMj7KIW2lDZ+2fY636rgJTvDYuwL9mtnj5ndceS
 rdqvr0/549o8ncnW2dHG1yFyvgYYT29agR1QZ0UF++ZYZpBZqDaXgrADM6IOnA/VAPgJ
 w1GxDIpzleof8LlV1ivhpiDbblFl9V7qarCGG3DeIbRd191kgKZP/uU5P1GJjaw5CVHI
 kOiLTFa8/w/RzZhOgSHxONTSanR+sW2Ede4bz8gyZOMArUjSFZ2CifCH4qrzCBMP4eWh
 T+sH01DbKwigEDLisaVSafL0dE+cguASS4qo8IGwdw6Bq8VK3R1Y4J8jpp7kflpXFt3m mA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3synyq8xbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 06:59:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3886xI6h013472
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 06:59:18 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 7 Sep 2023 23:59:10 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <lee@kernel.org>
CC:     <robimarko@gmail.com>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        <quic_bjorande@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 0/6] soc: qcom: Add uart console support for SM4450
Date:   Fri, 8 Sep 2023 14:58:41 +0800
Message-ID: <20230908065847.28382-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: riN0Ch_Ab_oeiIIUoPg5R6Yg9suvTYNF
X-Proofpoint-GUID: riN0Ch_Ab_oeiIIUoPg5R6Yg9suvTYNF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1011 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=649 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add base description of UART, TLMM, interconnect, TCSRCC
RPMHCC, GCC, RPMh PD and SMMU nodes which helps SM4450 boot to shell
with console on boards with this SoC.

This patch series depends on below patch series:
"[PATCH 0/4] clk: qcom: Add support for GCC and RPMHCC on SM4450"
https://lore.kernel.org/linux-arm-msm/20230824173410.550126-1-quic_ajipan@quicinc.com/
"[PATCH 0/3] pinctl: qcom: Add SM4450 pinctrl driver"
https://lore.kernel.org/linux-arm-msm/20230908063843.26835-1-quic_tengfan@quicinc.com/
"[PATCH 0/3] interconnect: qcom: Add SM4450 interconnect driver"
https://lore.kernel.org/linux-arm-msm/20230908064427.26999-1-quic_tengfan@quicinc.com/

Ajit Pandey (2):
  arm64: dts: qcom: sm4450: Add apps_rsc and cmd_db node
  arm64: dts: qcom: sm4450: Add RPMH and Global clock controller

Tengfei Fan (4):
  dt-bindings: firmware: document Qualcomm SM4450 SCM
  dt-bindings: mfd: qcom,tcsr: Add compatible for sm4450
  dt-bindings: interrupt-controller: qcom,pdc: document qcom,sm4450-pdc
  arm64: dts: qcom: add uart console support for SM4450

 .../bindings/firmware/qcom,scm.yaml           |   3 +
 .../interrupt-controller/qcom,pdc.yaml        |   1 +
 .../devicetree/bindings/mfd/qcom,tcsr.yaml    |   1 +
 arch/arm64/boot/dts/qcom/sm4450-qrd.dts       |  14 +-
 arch/arm64/boot/dts/qcom/sm4450.dtsi          | 310 ++++++++++++++++++
 5 files changed, 327 insertions(+), 2 deletions(-)


base-commit: a47fc304d2b678db1a5d760a7d644dac9b067752
-- 
2.17.1


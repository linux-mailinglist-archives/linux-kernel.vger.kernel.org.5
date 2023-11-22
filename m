Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C16E7F504E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjKVTN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjKVTNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:13:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99E7A9;
        Wed, 22 Nov 2023 11:13:21 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMJ0Lob004602;
        Wed, 22 Nov 2023 19:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=7CG5oCnjWDSSBAJpAL91Z7Kealbavj8SFwKnO5GlXBI=;
 b=TxmCctUmd2i0qy5mdgT56hPZs525Ofm2jggrLSBGfIu3RYQDfxdsUQ0h25+mVWU9gcbt
 Ruc/S8akfJHirPRQ1bnke4I2T+7PLdbZLD0mdDqjJZeat4lBdJgz2nE5jaa1iMHgmdqF
 Lm7Nwq+NHKSX0re9zCuEC89guazXL9KAL+uKTgRBLnJyoa6FJn9sgRrOHlcB6EIBS95Y
 8FUPlhbyigxV1AzGu9sqCPVLfL1NRaWPRw9QeyX42EgiJid0OHO/n7oumZIf4GxbbLXP
 N7ZaYcDWA752miN/U7g9tTZNp8st8BehreIy9Q+3mF4u9hgcHZftoJ8Lp7TjN6cxGvMY Tw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uh477jvrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 19:13:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AMJDFRj030752
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 19:13:15 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 Nov 2023 11:13:11 -0800
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <quic_wcheng@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH 0/6] Refine USB interrupt vectors on Qualcomm platforms
Date:   Thu, 23 Nov 2023 00:42:59 +0530
Message-ID: <20231122191259.3021-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TrW7wXycGNg_qUwLiUmOqvCyjNg1SQgZ
X-Proofpoint-GUID: TrW7wXycGNg_qUwLiUmOqvCyjNg1SQgZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_13,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=673 clxscore=1015
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220139
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm targets define the following interrupts for usb wakeup:
{dp/dm}_hs_phy_irq, hs_phy_irq, pwr_event, ss_phy_irq.

But QUSB2 Phy based targets have another interrupt which gets triggered
in response to J/K states on dp/dm pads. Its functionality is replaced
by dp/dm interrupts on Femto/m31/eusb2 phy based targets for wakeup
purposes. Exceptions are some targets like SDM845/SDM670/SM6350 where
dp/dm irq's are used although they are qusb2 phy targets.

Currently in QUSB2 Phy based DT's, te qusb2_phy interrupt is named and
used as "hs_phy_irq" when in fact it is a different interrupt (used by
HW validation folks for debug purposes and not used on any downstream
target qusb/non-qusb).

On some non-QUSB2 targets (like sm8450/sm8550), the pwr_event IRQ was
named as hs_phy_irq and actual pwr_event_irq was skipped.

This series tries to address the discrepancies in the interrupt numbering
adding the missing interrupts and correcting the existing ones.

This series has been compared with downstream counter part and hw specifics
to ensure the numbering is right. Since there is not functionality change
the code has been only compile tested.

However SC8280 is left unchanged. Its primary and secondary controllers
also have hs_phy_irq but they are not added in this series because of
one mismatch with hw specifics which needs to clarified. The control IRQ
added and the interrupts added work fine today. Only the hs_phy_irq needs
to be cleaned up which will be done later.

Krishna Kurapati (6):
  dt-bindings: usb: dwc3: Clean up hs_phy_irq in bindings
  usb: dwc3: qcom: Rename hs_phy_irq to qusb2_phy_irq
  arm64: dts: qcom: Fix hs_phy_irq for QUSB2 targets
  arm64: dts: qcom: Fix hs_phy_irq for non-QUSB2 targets
  arm64: dts: qcom: Fix hs_phy_irq for SDM670/SDM845/SM6350
  arm64: dts: qcom: Add missing interrupts for qcs404/ipq5332

 .../devicetree/bindings/usb/qcom,dwc3.yaml    | 126 ++++++++++--------
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi        |   5 +-
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi        |   2 +
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         |   8 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  15 ++-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         |  14 ++
 arch/arm64/boot/dts/qcom/msm8953.dtsi         |   7 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  19 ++-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |   7 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  16 +++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         |  20 ++-
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |   3 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |   6 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi          |  19 ++-
 arch/arm64/boot/dts/qcom/sdm670.dtsi          |   5 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  10 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi          |   9 +-
 arch/arm64/boot/dts/qcom/sm6125.dtsi          |   9 ++
 arch/arm64/boot/dts/qcom/sm6350.dtsi          |   7 +-
 arch/arm64/boot/dts/qcom/sm6375.dtsi          |   4 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  10 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |   4 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |   4 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |   4 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |   4 +-
 drivers/usb/dwc3/dwc3-qcom.c                  |  22 +--
 26 files changed, 252 insertions(+), 107 deletions(-)

-- 
2.42.0


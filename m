Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DE1802FA2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjLDKKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjLDKKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:10:08 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58549B6;
        Mon,  4 Dec 2023 02:10:14 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B46UOus028965;
        Mon, 4 Dec 2023 10:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=mgYlUpvOnHJNE7esAw8p1kohobaw/th3luuhNEWJajo=;
 b=PplJhMjL0cj3ERE25237JQ4IlJXnNYqv/H9psf/7JdCnnKZpmnKJN/uW5tVuc6h6j9vz
 oFZQxlJ1ypS46+sGC2qVIzLNyK1vkIGXaikmqdvHqj0KkjdM2WXnaqnXb1tETLkrG7WK
 dc2pyqSg3PphM6PoxtTIXBQj2vIl4zCP/tCDYlp/3sLsQm3INd5bY8CDppKJoqSJuSpB
 Jg8VMfyW66EXQ8fZnmfxu5yQLHIkKxweCyCJWwFefBq9BQ+V8+1c0zT+WmzGCkfo2r+l
 vNH4p3zHPCq1ajVYnNBOqMXkYR05AZwHNCiVOtap8GWo+OAZ1eH+8ptCDoQDKgjm/Gi2 mw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqt9q3tfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 10:10:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B4AA48i030664
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 10:10:04 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 02:09:59 -0800
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v2 0/6] Refine USB interrupt vectors on Qualcomm platforms
Date:   Mon, 4 Dec 2023 15:39:44 +0530
Message-ID: <20231204100950.28712-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dSr5QcidkuTZbwUSHv1BYDNs5u1YwY1q
X-Proofpoint-ORIG-GUID: dSr5QcidkuTZbwUSHv1BYDNs5u1YwY1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 mlxlogscore=786 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes in v2:
Removed additional compatibles added for different targets in v1.
Specified permuations of interrupts possible for QC targets and regrouped
interrupts for most of the DT's.

Rebased on top of wakeup interrupts fixes by Johan Hovold:
https://patchwork.kernel.org/project/linux-arm-msm/cover/20231120164331.8116-1-johan+linaro@kernel.org/

Link to v1: (providing patchwork link since threading was broken in v1)
https://patchwork.kernel.org/project/linux-arm-msm/cover/20231122191259.3021-1-quic_kriskura@quicinc.com/

Krishna Kurapati (6):
  dt-bindings: usb: dwc3: Clean up hs_phy_irq in bindings
  usb: dwc3: qcom: Rename hs_phy_irq to qusb2_phy_irq
  arm64: dts: qcom: Fix hs_phy_irq for QUSB2 targets
  arm64: dts: qcom: Fix hs_phy_irq for non-QUSB2 targets
  arm64: dts: qcom: Fix hs_phy_irq for SDM670/SDM845/SM6350
  arm64: dts: qcom: Add missing interrupts for qcs404/ipq5332

 .../devicetree/bindings/usb/qcom,dwc3.yaml    | 122 +++++-------------
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi        |  14 +-
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi        |  14 +-
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         |   8 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  13 ++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         |  14 ++
 arch/arm64/boot/dts/qcom/msm8953.dtsi         |   7 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  17 ++-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |   7 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  16 +++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         |   6 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |  14 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |  12 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi          |  17 ++-
 arch/arm64/boot/dts/qcom/sdm670.dtsi          |  14 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  28 ++--
 arch/arm64/boot/dts/qcom/sm6115.dtsi          |   9 +-
 arch/arm64/boot/dts/qcom/sm6125.dtsi          |   9 ++
 arch/arm64/boot/dts/qcom/sm6350.dtsi          |  13 +-
 arch/arm64/boot/dts/qcom/sm6375.dtsi          |  12 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  28 ++--
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  28 ++--
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |  28 ++--
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  12 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  12 +-
 drivers/usb/dwc3/dwc3-qcom.c                  |  22 ++--
 26 files changed, 293 insertions(+), 203 deletions(-)

-- 
2.42.0


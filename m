Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC25F7CB8E1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbjJQDLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQDLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:11:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB3595;
        Mon, 16 Oct 2023 20:11:37 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H2HeiS018193;
        Tue, 17 Oct 2023 03:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=wo666QFHwH9jbueXj1tL9j5DiN6Dpf2gV1xa51nmhl8=;
 b=Mhfer62gjdT+Q8+y8wq4T7tVJqNuKCN7SSu8AH/ocmifTpPLrg06/I47eDpdbD28KKtq
 KXw3vBlf1BqRpITPGqU6F7BMkJN3qRNa7yc+jjLfzVVUrQis6JRzpkrKg697L37DI/ZR
 MxwcZ6xyYLmM8fh8b+3P77UqiL69/+YUVgj8XQ0yQGVLiPQ+u5Y9C+36eISkiNVH/W5H
 62VOe/+dfKLIgdJFra5c0//lgQ430anbeItnItYa06h8wkBxpysrvMGVBTqa2Y2naize
 Xx9XCwlq90M3kbfbrdK2GEdhOl4A6xmLTFSg9Lf5aVy4BxSSnMpExtIG28/3wkgeXj/i yQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ts9jns3vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:11:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39H3BQWJ004277
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:11:26 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 16 Oct 2023 20:11:26 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH 00/12] usb: dwc3: qcom: Flatten dwc3 structure
Date:   Mon, 16 Oct 2023 20:11:08 -0700
Message-ID: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEz7LWUC/x2N0QqDMAxFf0XyvEBrYai/IntIa6YBqZJuKhT/f
 WGP53APt0JhFS4wNBWUDymyZQP/aCAtlGdGmYyhdW3wzj9xOlNA5Telz6bYB88huo662IM1kQp
 jVMppsSp/19XkbnO5/ifj675/fMAxdHQAAAA=
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697512286; l=2928;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=BfVs6sray0YTN4vc4g+Yvojjyk0sCDR/MLa1TmSoVr4=;
 b=QF1GXgroHtrSsBhAJ8qMEkbjIkJN7+8nx/i2Ep40qd+yf6XEb7dMmqsdX8WOu3nbHfd/m+LgFxNM
 lUCFQQx3AyLC9oZu2IU5jfDFdAQYM+XeB7oSWvjtAFkKVDOdsLWg
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: USVpYvXr35ihRY4bccwrV9r5WVoRWpzm
X-Proofpoint-ORIG-GUID: USVpYvXr35ihRY4bccwrV9r5WVoRWpzm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=732 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB IP-block found in most Qualcomm platforms is modelled in the
Linux kernel as 3 different independent device drivers, but as shown by
the already existing layering violations in the Qualcomm glue driver
they can not be operated independently.

With the current implementation, the glue driver registers the core and
has no way to know when this is done. As a result, e.g. the suspend
callbacks needs to guard against NULL pointer dereferences when trying
to peek into the struct dwc3 found in the drvdata of the child.

Missing from the upstream Qualcomm USB support is handling of role
switching, in which the glue needs to be notified upon DRD mode changes.
Several attempts has been made through the years to register callbacks
etc, but they always fall short when it comes to handling of the core's
probe deferral on resources etc.

Furhtermore, the DeviceTree binding is a direct representation of the
Linux driver model, and doesn't necessarily describe "the USB IP-block".

This series therefor attempts to flatten the driver split, and operate
the glue and core out of the same platform_device instance. And in order
to do this, the DeviceTree representation of the IP block is flattened.

As a side effect, much of the ACPI integration code is dropped.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Bjorn Andersson (12):
      dt-bindings: usb: qcom,dwc3: Add qcom,sc8180x-dwc3
      usb: dwc3: qcom: Rename dwc3 platform_device reference
      usb: dwc3: qcom: Merge resources from urs_usb device
      usb: dwc3: Expose core driver as library
      usb: dwc3: Override end of dwc3 memory resource
      usb: dwc3: qcom: Add dwc3 core reference in driver state
      usb: dwc3: qcom: Instantiate dwc3 core directly
      usb: dwc3: qcom: Inline the qscratch constants
      dt-bindings: usb: qcom,dwc3: Rename to "glue"
      dt-bindings: usb: qcom,dwc3: Introduce flattened qcom,dwc3 binding
      usb: dwc3: qcom: Flatten the Qualcomm dwc3 binding and implementation
      arm64: dts: qcom: sc8180x: flatten usb_sec node

 .../devicetree/bindings/usb/qcom,dwc3-glue.yaml    | 626 +++++++++++++++++++++
 .../devicetree/bindings/usb/qcom,dwc3.yaml         | 321 ++++-------
 .../devicetree/bindings/usb/snps,dwc3.yaml         |  14 +-
 .../arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts |   6 +-
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts        |   6 +-
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              |  34 +-
 drivers/usb/dwc3/core.c                            | 136 +++--
 drivers/usb/dwc3/core.h                            |  10 +
 drivers/usb/dwc3/dwc3-qcom.c                       | 328 ++++++-----
 9 files changed, 1057 insertions(+), 424 deletions(-)
---
base-commit: 4d0515b235dec789578d135a5db586b25c5870cb
change-id: 20231016-dwc3-refactor-931e3b08a8b9

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


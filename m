Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F51765FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjG0Wef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjG0Web (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:34:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F4130E8;
        Thu, 27 Jul 2023 15:34:04 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RM0JDw026896;
        Thu, 27 Jul 2023 22:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=bm2u8fg7PxbgqOwTMIX85s2CXs4GgAyYll4b6/ofwxo=;
 b=KzSzXbxyRjFD7MYEk+nD44AqOQQabhcIa50h7Nd8hgJndJTZPRHfRvnBip7yItnSj3cg
 fcU/02JS3dP1G62GQYlxf+DQdrtstDQJ+aaN7Tg7C6sLAET4BoOUEGv24y1pIa5X3jEk
 bC2oQV/fBOMl4D1QTLc/xk/AvOveGP6Ec+koRpqhraibvtNrNFPxBw06TPRk6nFI6Aqe
 j+oNLaWQUEcuBH2UcYOW9IrLb3k1ziY8MnAv5QVi6ZZMHw7cIH/32sUFMJ77ZV2t3DE8
 AHQjit3QBcKS0lfpmBpkVoWmsuiAsgB9sBogyOzh9Woltes+uhO602onaZ4Z877brPUV 2A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s34x6ktbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 22:33:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36RMXMbR010648
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 22:33:22 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 27 Jul 2023 15:33:16 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v10 00/11] Add multiport support for DWC3 controllers
Date:   Fri, 28 Jul 2023 04:02:56 +0530
Message-ID: <20230727223307.8096-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CC2oCIcmmiTtdkzONDc86AmzjZA7ffx-
X-Proofpoint-ORIG-GUID: CC2oCIcmmiTtdkzONDc86AmzjZA7ffx-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=846
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270205
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the DWC3 driver supports only single port controller which
requires at most two PHYs ie HS and SS PHYs. There are SoCs that has
DWC3 controller with multiple ports that can operate in host mode.
Some of the port supports both SS+HS and other port supports only HS
mode.

This change primarily refactors the Phy logic in core driver to allow
multiport support with Generic Phy's.

Changes have been tested on  QCOM SoC SA8295P which has 4 ports (2
are HS+SS capable and 2 are HS only capable).

Changes in v10:
Refactored phy init/exit/power-on/off functions in dwc3 core
Refactored dwc3-qcom irq registration and handling
Implemented wakeup for multiport irq's
Moved few macros from xhci.h to xhci-ext-caps.h
Fixed nits pointed out in v9
Fixed Co-developed by and SOB tags in patches 5 and 11

Changes in v9:
Added IRQ support for DP/DM/SS MP Irq's of SC8280
Refactored code to read port count by accessing xhci registers

Changes in v8:
Reorganised code in patch-5
Fixed nitpicks in code according to comments received on v7
Fixed indentation in DT patches
Added drive strength for pinctrl nodes in SA8295 DT

Changes in v7:
Added power event irq's for Multiport controller.
Udpated commit text for patch-9 (adding DT changes for enabling first
port of multiport controller on sa8540-ride).
Fixed check-patch warnings for driver code.
Fixed DT binding errors for changes in snps,dwc3.yaml
Reabsed code on top of usb-next

Changes in v6:
Updated comments in code after.
Updated variables names appropriately as per review comments.
Updated commit text in patch-2 and added additional info as per review
comments.
The patch header in v5 doesn't have "PATHCH v5" notation present. Corrected
it in this version.

Changes in v5:
Added DT support for first port of Teritiary USB controller on SA8540-Ride
Added support for reading port info from XHCI Extended Params registers.

Changes in RFC v4:
Added DT support for SA8295p.

Changes in RFC v3:
Incase any PHY init fails, then clear/exit the PHYs that
are already initialized.

Changes in RFC v2:
Changed dwc3_count_phys to return the number of PHY Phandles in the node.
This will be used now in dwc3_extract_num_phys to increment num_usb2_phy 
and num_usb3_phy.

Added new parameter "ss_idx" in dwc3_core_get_phy_ny_node and changed its
structure such that the first half is for HS-PHY and second half is for
SS-PHY.

In dwc3_core_get_phy, for multiport controller, only if SS-PHY phandle is
present, pass proper SS_IDX else pass -1.

Tests done on v10:
Enumeration:
/ # lsusb
Bus 003 Device 001: ID 1d6b:0002
Bus 001 Device 001: ID 1d6b:0002
Bus 001 Device 002: ID 045e:0040
Bus 004 Device 001: ID 1d6b:0003
Bus 002 Device 001: ID 1d6b:0003
Bus 001 Device 003: ID 17ef:60d1

Interrupt registration:
/ # cat /proc/interrupts  | grep dwc
184:  0 0 0 0 0 0 0 0       PDC 127 Level     qcom_dwc3 DP_HS1
185:  0 0 0 0 0 0 0 0       PDC 126 Level     qcom_dwc3 DM_HS1
186:  0 0 0 0 0 0 0 0       PDC  16 Level     qcom_dwc3 SS1
187:  0 0 0 0 0 0 0 0       PDC 129 Level     qcom_dwc3 DP_HS2
188:  0 0 0 0 0 0 0 0       PDC 128 Level     qcom_dwc3 DM_HS2
189:  0 0 0 0 0 0 0 0       PDC  17 Level     qcom_dwc3 SS2
190:  0 0 0 0 0 0 0 0       PDC 131 Level     qcom_dwc3 DP_HS3
191:  0 0 0 0 0 0 0 0       PDC 130 Level     qcom_dwc3 DM_HS3
192:  0 0 0 0 0 0 0 0       PDC 133 Level     qcom_dwc3 DP_HS4
193:  0 0 0 0 0 0 0 0       PDC 132 Level     qcom_dwc3 DM_HS4
195:  0 0 0 0 0 0 0 0       PDC  14 Level     qcom_dwc3 DP_HS
196:  0 0 0 0 0 0 0 0       PDC  15 Level     qcom_dwc3 DM_HS
197:  0 0 0 0 0 0 0 0       PDC 138 Level     qcom_dwc3 SS
198: 32 0 0 0 0 0 0 0     GICv3 835 Leel     dwc3
199:  0 0 0 0 0 0 0 0       PDC  12 Level     qcom_dwc3 DP_HS
200:  0 0 0 0 0 0 0 0       PDC  13 Level     qcom_dwc3 DM_HS
201:  0 0 0 0 0 0 0 0       PDC 136 Level     qcom_dwc3 SS

Interrupt connfiguration during suspend entry and suspend exit upon device
connect. Speed here in the following log indicates enum usb_device_speed
in dwc3-qcom.

[  151.625326] K: dwc3_qcom_enable_interrupts index: 0 speed: 0
[  151.680985] K: dwc3_qcom_enable_interrupts index: 0 speed: 2
[  151.686841] K: dwc3_qcom_enable_interrupts index: 1 speed: 2
[  151.692665] K: dwc3_qcom_enable_interrupts index: 2 speed: 0
[  151.692678] K: dwc3_qcom_enable_interrupts index: 3 speed: 0

[  151.724912] K: dwc3_qcom_disable_interrupts index: 0 speed: 2
[  151.730832] K: dwc3_qcom_disable_interrupts index: 1 speed: 2
[  151.736740] K: dwc3_qcom_disable_interrupts index: 2 speed: 0
[  151.742646] K: dwc3_qcom_disable_interrupts index: 3 speed: 0
[  152.010699] K: dwc3_qcom_disable_interrupts index: 0 speed: 0

[  152.107836] OOM killer enabled.
[  152.111070] Restarting tasks ... done.
[  152.115742] random: crng reseeded on system resumption
[  152.121298] PM: suspend exit
/ # [  152.240015] usb 1-3: new low-speed USB device number 8 using xhci-hcd

On SC7280 CRD Herobrine variant, enumeration and wakeup was tested and it
works fine:

Enumeration:
localhost ~ # lsusb
Bus 002 Device 004: ID 0bda:8153 Realtek Semiconductor Corp. USB 10/100/1000 LAN
Bus 002 Device 003: ID 05e3:0626 Genesys Logic, Inc. USB3.1 Hub
Bus 002 Device 002: ID 0bda:0411 Realtek Semiconductor Corp. 4-Port USB 3.1 Hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 024: ID 046d:c06a Logitech, Inc. USB Optical Mouse
Bus 001 Device 007: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
Bus 001 Device 002: ID 0bda:5411 Realtek Semiconductor Corp. 4-Port USB 2.1 Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

localhost ~ # dmesg | grep hub
[    3.713331] hub 1-0:1.0: USB hub found
[    3.717222] hub 1-0:1.0: 1 port detected
[    3.764330] hub 2-0:1.0: USB hub found
[    3.768216] hub 2-0:1.0: 1 port detected
[    4.159720] hub 1-1:1.0: USB hub found
[    4.165010] hub 1-1:1.0: 4 ports detected
[    4.322363] hub 2-1:1.0: USB hub found
[    4.327220] hub 2-1:1.0: 4 ports detected
[    5.504227] hub 2-1.4:1.0: USB hub found
[    5.508724] hub 2-1.4:1.0: 4 ports detected
[    7.263756] hub 1-1.4:1.0: USB hub found
[    7.268273] hub 1-1.4:1.0: 4 ports detected
[   10.030906] hub 1-1.4:1.0: USB hub found
[   10.035352] hub 1-1.4:1.0: 4 ports detected


Interrupt registration on SC7280-CRD:
localhost ~ # cat /proc/interrupts   | grep dwc
 82:   0   0   0    0    0    0    0    0     GICv3 163 Level     qcom_dwc3 HS
 211:  0   0   0    0    0    0    0    0       PDC  14 Level     qcom_dwc3 DP_HS
 212:  0   0   0    0    0    0    0    0       PDC  15 Level     qcom_dwc3 DM_HS
 213:  0   0   0    0    0    0    0    0       PDC  17 Level     qcom_dwc3 SS


Wakeup from system suspend upon mouse click:
 [ 1159.589739] K: dwc3_qcom_enable_interrupts port: 0 speed: 3
 [ 1160.025300] K: qcom_dwc3_resume_irq irq: 211
 [ 1160.149660] K: dwc3_qcom_disable_interrupts port: 0 speed: 3
 [ 1161.649610] Resume caused by IRQ 211, qcom_dwc3 DP_HS

Also DT Binding checks were done on both modified yaml files.

Links to previous versions:
Link to v9: https://lore.kernel.org/all/20230621043628.21485-1-quic_kriskura@quicinc.com/
Link to v8: https://lore.kernel.org/all/20230514054917.21318-1-quic_kriskura@quicinc.com/
Link to v7: https://lore.kernel.org/all/20230501143445.3851-1-quic_kriskura@quicinc.com/
Link to v6: https://lore.kernel.org/all/20230405125759.4201-1-quic_kriskura@quicinc.com/
Link to v5: https://lore.kernel.org/all/20230310163420.7582-1-quic_kriskura@quicinc.com/
Link to RFC v4: https://lore.kernel.org/all/20230115114146.12628-1-quic_kriskura@quicinc.com/
Link to RFC v3: https://lore.kernel.org/all/1654709787-23686-1-git-send-email-quic_harshq@quicinc.com/#r
Link to RFC v2: https://lore.kernel.org/all/1653560029-6937-1-git-send-email-quic_harshq@quicinc.com/#r

Andrew Halaney (1):
  arm64: dts: qcom: sa8540-ride: Enable first port of tertiary usb
    controller

Harsh Agarwal (1):
  usb: dwc3: core: Refactor PHY logic to support Multiport Controller

Krishna Kurapati (9):
  dt-bindings: usb: qcom,dwc3: Add bindings for SC8280 Multiport
  dt-bindings: usb: Add bindings for multiport properties on DWC3
    controller
  usb: dwc3: core: Access XHCI address space temporarily to read port
    info
  usb: dwc3: core: Skip setting event buffers for host only controllers
  usb: dwc3: qcom: Refactor IRQ handling in QCOM Glue driver
  usb: dwc3: qcom: Enable wakeup for applicable ports of multiport
  usb: dwc3: qcom: Add multiport suspend/resume support for wrapper
  arm64: dts: qcom: sc8280xp: Add multiport controller node for SC8280
  arm64: dts: qcom: sa8295p: Enable tertiary controller and its 4 USB
    ports

 .../devicetree/bindings/usb/qcom,dwc3.yaml    |  29 ++
 .../devicetree/bindings/usb/snps,dwc3.yaml    |  13 +-
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      |  53 +++
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts     |  22 ++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  77 ++++
 drivers/usb/dwc3/core.c                       | 326 ++++++++++++----
 drivers/usb/dwc3/core.h                       |  16 +-
 drivers/usb/dwc3/drd.c                        |  15 +-
 drivers/usb/dwc3/dwc3-qcom.c                  | 358 ++++++++++++------
 drivers/usb/host/xhci-ext-caps.h              |   5 +
 drivers/usb/host/xhci.h                       |   3 -
 11 files changed, 714 insertions(+), 203 deletions(-)

-- 
2.40.0


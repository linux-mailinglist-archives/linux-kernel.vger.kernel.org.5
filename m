Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F857BC8BF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 17:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344018AbjJGPsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 11:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343934AbjJGPsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 11:48:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FABB9;
        Sat,  7 Oct 2023 08:48:34 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 397Fha3T004400;
        Sat, 7 Oct 2023 15:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=G4TdZ8i8V7a+fr2OMVlmA693hl1zq8vEWjM3XQILhCY=;
 b=B8Bch5vjNXorhiNls6wdcgWJQfbiz9kSBePFV4n8myxQ6EeSoRJtRZqYq06ZIVFztxol
 4+rxwTX3o5VTidQEoAbXPKbRhmjBSmLoNp4r6MfapFWymD0vVPsvJKTkyZEZTVpXnqgJ
 fANJNhPDfi+hovABw6QjtViSGIxRc32colyu2tb/zXSoX2XVuEl6eQ0UX7OfMVytRb3G
 SvSdgLKNdS6nZOFqBmFadvkLKlLmqT1PZb4iCOgP2hwRl5RZEY4PoeVC3F4M1OWctaTM
 ThUtgFKTKPkG2NqjYHieQuX3PVfeIEUWrz9OOzlEO9KTO5KW2QMf7SBfxH0VKDveNYv/ Pw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tjxnqs139-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 Oct 2023 15:48:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 397FmL0h002535
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Oct 2023 15:48:21 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sat, 7 Oct 2023 08:48:15 -0700
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
        Johan Hovold <johan@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v13 00/10] Add multiport support for DWC3 controllers
Date:   Sat, 7 Oct 2023 21:17:56 +0530
Message-ID: <20231007154806.605-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N5LF4abYI0Z-ylJjSubp0jPpnVHHxTgO
X-Proofpoint-GUID: N5LF4abYI0Z-ylJjSubp0jPpnVHHxTgO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_12,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=742
 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310070143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v13:
This series is a subset of patches in v11 as the first 3 patches in v11
have been mereged into usb-next.
Moved dr_mode property from platform specific files to common sc8280xp DT.
Fixed function call wrapping, added comments and replaced #defines with
enum in dwc3-qcom for identifying IRQ index appropriately.
Fixed nitpicks pointed out in v11 for suspend-resume handling.
Added reported-by tag for phy refactoring patch as a compile error was
found by kernel test bot [1].
Removed reviewed-by tag of maintainer for phy refactoring patch as a minor
change of increasing phy-names array size by 2-bytes was done to fix
compilation issue mentioned in [1].

Changes in v12:
Pushed as a subset of acked but no-yet-merged patches of v11 with intent
of making rebase of other patches easy. Active reviewers from community
suggested that it would be better to push the whole series in one go as it
would give good clarity and context for all the patches in the series.
So pushed v13 for the same addressing comments received in v11.

Changes in v11:
Implemented port_count calculation by reading interrupt-names from DT.
Refactored IRQ handling in dwc3-qcom.
Moving of macros to xhci-ext-caps.h made as a separate patch.
Names of interrupts to be displayed on /proc/interrupts set to the ones
present in DT.

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

Tests done on v13:

1) MP controller enumerting devices on different ports:

/ # lsusb
Bus 001 Device 001: ID 1d6b:0002
Bus 001 Device 003: ID 03f0:0024
Bus 001 Device 002: ID 17ef:6099
Bus 002 Device 001: ID 1d6b:0003

2) Interrupt registration for 3 controllers of sa8295p-adp

/ # cat /proc/interrupts | grep phy
171: 0 0 0 0 0 0 0 0 PDC 127 Level     dp_hs_phy_1
172: 0 0 0 0 0 0 0 0 PDC 126 Level     dm_hs_phy_1
173: 0 0 0 0 0 0 0 0 PDC 129 Level     dp_hs_phy_2
174: 0 0 0 0 0 0 0 0 PDC 128 Level     dm_hs_phy_2
175: 0 0 0 0 0 0 0 0 PDC 131 Level     dp_hs_phy_3
176: 0 0 0 0 0 0 0 0 PDC 130 Level     dm_hs_phy_3
177: 0 0 0 0 0 0 0 0 PDC 133 Level     dp_hs_phy_4
178: 0 0 0 0 0 0 0 0 PDC 132 Level     dm_hs_phy_4
179: 0 0 0 0 0 0 0 0 PDC  16 Level     ss_phy_1
180: 0 0 0 0 0 0 0 0 PDC  17 Level     ss_phy_2
182: 0 0 0 0 0 0 0 0 PDC  14 Level     dp_hs_phy_irq
183: 0 0 0 0 0 0 0 0 PDC  15 Level     dm_hs_phy_irq
184: 0 0 0 0 0 0 0 0 PDC 138 Level     ss_phy_irq
190: 0 0 0 0 0 0 0 0 PDC  12 Level     dp_hs_phy_irq
191: 0 0 0 0 0 0 0 0 PDC  13 Level     dm_hs_phy_irq
192: 0 0 0 0 0 0 0 0 PDC 136 Level     ss_phy_irq

3) Wakeup was tested on all 4 ports of tertiary controller by
a) Connecting peripheral after device is suspended and checking wakeup
b) Removing peripheral after device is suspended and checking wakeup
c) Connecting keyboard and checking if button press wakes up system

4) Testing interrupt registration on single port controller SM8550-MTP

/ # cat /proc/interrupts | grep phy
146:  0 0 0 0 0 0 0 0     GICv3 162 Level     hs_phy_irq
147:  0 0 0 0 0 0 0 0       PDC  17 Level     ss_phy_irq
148:  0 0 0 0 0 0 0 0       PDC  15 Level     dm_hs_phy_irq
149:  0 0 0 0 0 0 0 0       PDC  14 Level     dp_hs_phy_irq

5) ADB enumeration and working on SM8550-MTP has been tested

[1]: https://lore.kernel.org/all/202309200156.CxQ3yaLY-lkp@intel.com/

Links to previous versions:
Link to v12: https://lore.kernel.org/all/20231004165922.25642-1-quic_kriskura@quicinc.com/
Link to v11: https://lore.kernel.org/all/20230828133033.11988-1-quic_kriskura@quicinc.com/
Link to v10: https://lore.kernel.org/all/20230727223307.8096-1-quic_kriskura@quicinc.com/
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

Krishna Kurapati (8):
  usb: dwc3: core: Access XHCI address space temporarily to read port
    info
  usb: dwc3: core: Skip setting event buffers for host only controllers
  usb: dwc3: qcom: Add helper function to request threaded IRQ
  usb: dwc3: qcom: Refactor IRQ handling in QCOM Glue driver
  usb: dwc3: qcom: Enable wakeup for applicable ports of multiport
  usb: dwc3: qcom: Add multiport suspend/resume support for wrapper
  arm64: dts: qcom: sc8280xp: Add multiport controller node for SC8280
  arm64: dts: qcom: sa8295p: Enable tertiary controller and its 4 USB
    ports

 arch/arm64/boot/dts/qcom/sa8295p-adp.dts  |  49 ++++
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts |  21 ++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi    |  84 ++++++
 drivers/usb/dwc3/core.c                   | 324 +++++++++++++++++-----
 drivers/usb/dwc3/core.h                   |  16 +-
 drivers/usb/dwc3/drd.c                    |  15 +-
 drivers/usb/dwc3/dwc3-qcom.c              | 323 ++++++++++++++-------
 7 files changed, 642 insertions(+), 190 deletions(-)

-- 
2.42.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630397CC47D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343856AbjJQNTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343827AbjJQNTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:19:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C92EA;
        Tue, 17 Oct 2023 06:19:16 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HBXcOX031228;
        Tue, 17 Oct 2023 13:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=kKxLPjNM+KBORA+YZmJMmeune3IzkgXb7Qs/O9sWzOg=;
 b=NPPrvk7jYeIjJ9975JMOEvjlS7+YgyMtAEstOEw8HpOki4zNomeMSShp+U0zKkYFhjlb
 g6qhhCcTMc3FGsKOAXnq1nuqhG/Bum0fRbkuQOq8+NasU/ms0IpEPzYZOSVSpnCRYl+a
 BDVh7wvLYoDUFILgmxtgpuyaHLQ4tv2f9YBgxwJNv+KV11Lg/yiIYCd7RJARh7JRM7J3
 4tyQVYWxx9+vDYE3JtHPRPTjkM+Qmiucv8qA+zi98gbrezSQnkLLzZ41kw3kVxk2wkTd
 9eE1Xn0xEZlvq52+05nuChZ3p3nd/j++X/BsxJzkrmgSJsb1LyL8atrJBn2lkAae9Gm7 ew== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsr7c0aj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 13:19:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HDJ5c7015707
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 13:19:05 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 17 Oct 2023 06:19:00 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <quic_wcheng@quicinc.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [RFC 0/8] Enable runtime suspend resume for QCOM devices
Date:   Tue, 17 Oct 2023 18:48:44 +0530
Message-ID: <20231017131851.8299-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t0U4ApgWPJy59GV9ImwJb7SiEc5Xfc7z
X-Proofpoint-GUID: t0U4ApgWPJy59GV9ImwJb7SiEc5Xfc7z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_02,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 bulkscore=0 adultscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently for all dwc3 devices, runtime is forbidden in kernel code.
Although it can be configured from userspace, qualcomm devices using
role switching with dr_mode "otg" would need to modify glue specific
qscratch registers without which connection done/ disconnect events
wouldn't be generated in device mode thus blocking suspend entry.
Also when in host mode, xhci and roothubs needs to be configured
to use_autosuspend accrordingly. More information regarding disconnect
event generation on QC targets is in [1].

The series introduces vendor hooks for passing on notifications
from core to glue layers. Since these hooks are to be registered
by glue to core, glue needs to have some sort of indication that
core probe hasn't been deferred or core probe hasn't failed. So
this series banks upon Bjorn's flattened device tree implementation [2]
for dwc3 core and dwc3-qcom. Since these patches ensure that we use
core layer as a library and probe is invoked in a controlled fashion
from qcom glue layer, we can register vendor hooks in this probe call.

While in host mode, usb-core notifiers have been utilised to ensure
we use_autosuspend for connected devices and roothubs.

[1]: https://lore.kernel.org/all/af60c05b-4a0f-51b8-486a-1fc601602515@quicinc.com/
[2]: https://lore.kernel.org/all/20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com/

Tests done:
1. Enumeration in device mode:
After creating symlinks to ffs.adb and writing to UDC node, ADB is up and
working in a stable way.

2. When none is written to UDC, device enters suspend.

3. When cable is removed, cable disconnect notification comes and when
qscratch registers are cleared properly, it is generating disconnect event

4. Device enters suspend upon removing cable (host and device mode)

5. In host mode, when autosuspend and wakeup are enabled from userspace
via the following commands, device enters runtime suspend:

echo enabled > /sys/bus/platform/devices/xhci-hcd.0.auto/power/wakeup
echo auto > /sys/bus/platform/devices/xhci-hcd.0.auto/power/control
echo 5000 > /sys/bus/platform/devices/xhci-hcd.0.auto/usb1/1-1/power/autosuspend_delay_ms
echo enabled > /sys/bus/platform/devices/xhci-hcd.0.auto/usb1/1-1/power/wakeup
echo auto > /sys/bus/platform/devices/xhci-hcd.0.auto/usb1/1-1/power/control

6. Upon removing cable in host mode, setmode brings back usb to device
mode (which is default setting), it enters suspend as cable is still
disconnected

7. When in host mode, if we enter runtime suspend with wakeup enabled,
clicking on buttons of headset are resuming the controller.

Issues still present:
During bootup if UDC is not written before dwc3 is suspended, then device
enters suspend and although writing to UDC is resuming the device and
setting  run stop, controller is not generating events. At this stage if
a simple plug-in/plug-out is done, everything works fine.

Krishna Kurapati (8):
  dt-bindings: usb: qcom,dwc3: Add bindings to enable runtime
  usb: dwc3: core: Register vendor hooks for dwc3-qcom
  usb: dwc3: qcom: Enable autosuspend for host mode
  clk: qcom: gcc-sm8450: Keep usb30 prim gdsc on during runtime suspend
  arm64: dts: qcom: Flatten sm8450 usb device node
  arm: dts: qcom: Add pmic glink support for sm8450-qrd
  arm: dts: qcom: Enable runtime for SM8450 QRD
  usb: dwc3: core: Skip set_mode notification if cable is disconnected

 .../devicetree/bindings/usb/qcom,dwc3.yaml    |   5 +
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts       |   3 -
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts       |  48 ++++++-
 .../dts/qcom/sm8450-sony-xperia-nagara.dtsi   |   3 -
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  44 +++----
 drivers/clk/qcom/gcc-sm8450.c                 |   1 +
 drivers/usb/dwc3/core.c                       |  19 ++-
 drivers/usb/dwc3/core.h                       |  50 ++++++-
 drivers/usb/dwc3/drd.c                        |  13 ++
 drivers/usb/dwc3/dwc3-qcom.c                  | 122 +++++++++++++++++-
 10 files changed, 271 insertions(+), 37 deletions(-)

-- 
2.42.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA1077C00F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjHNSva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjHNSvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:51:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1921722;
        Mon, 14 Aug 2023 11:51:03 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EBitj1020161;
        Mon, 14 Aug 2023 18:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=Ff23cqy0WI6THuMabAgFiq8/o6dUkjU6MfTGSZu2134=;
 b=nI4Hr3WjFFo7I+fOXU+tCdkBHydmn9SZxuOevn+iXDYVBrfcTL3KKdHExhjqIrFKZ8n3
 wwBp0TzgEjl1mtLP0OA4Y1XYU1UmgSAZshu+C2FLbY73QBQ6QUJrwjb60QLc0tZaI/LE
 tuw68DDcxjkXd0Zs60wEoGL7LIsSg65qahrZnL9ye2Ld0fRWir6Ri6vDS13qUoHFlRu8
 Z/j0XczugZlGzONR+MLZK47GNiNebhDOn7bYgEwDshjxtjaxWyAuCa+1KULXkjxxjf93
 WQ0iXS8dzLLCasW33Y+g+byOu/9yvH54oI/xTd2ZCmiJaqMyRdmys29YN40hskHRN6cm LA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3gn4pmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 18:50:49 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37EIonaG009755;
        Mon, 14 Aug 2023 18:50:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTP id 3se35mmw89-1;
        Mon, 14 Aug 2023 18:50:49 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37EIomFh009749;
        Mon, 14 Aug 2023 18:50:49 GMT
Received: from hu-devc-lv-u18-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.27])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTP id 37EIomgh009744;
        Mon, 14 Aug 2023 18:50:48 +0000
Received: by hu-devc-lv-u18-c.qualcomm.com (Postfix, from userid 464172)
        id B3A095005A3; Mon, 14 Aug 2023 11:50:48 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        rogerq@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v4 0/3] Support dwc3 runtime suspend during bus suspend
Date:   Mon, 14 Aug 2023 11:50:40 -0700
Message-Id: <20230814185043.9252-1-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vu610sPq8cQ-2Y58-xMaPvWWrn8m2yqz
X-Proofpoint-GUID: vu610sPq8cQ-2Y58-xMaPvWWrn8m2yqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=6 phishscore=0 spamscore=6
 impostorscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=6 adultscore=0
 mlxlogscore=121 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140175
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4
 - Changed the dt property name to 'snps,runtime-suspend-on-usb-suspend' as per
   the feedback received.
 - Separated the pending events handling to a different patch as it is an
   independent fix
   https://lore.kernel.org/all/b2ab8803-d4e0-bd63-7a64-bcc411e04cfe@kernel.org/
 - Moved the bus suspend checks to runtime_checks() API to make it more relevant
   to runtime ops. Also added explicit run time check in resume common function.
 - Instead of checking the link state for bus suspend, used dwc->suspended flag
   as it directly reflects the gadget suspend/resume operations.
 
Changes in v3
 - Added a dt property 'snps,allow-rtsusp-on-u3' to make this feature platform
   dependent as per the feedback from Thinh N.
 - Changed the RT idle/suspend/resume handling to device mode specific and dt
   property dependent.
 - Modified the cover letter to document how resume is handled on qcom platforms.
 
Changes in v2
 - Used pm_runtime_resume_and_get() API instead of pm_runtime_get_sync()
   as suggested by Dan.
 - Handled the return value in ether_wakeup_host to print error message.

When a USB link is idle, the host sends a bus suspend event to the device
so that the device can save power. But true power savings during bus
suspend can be seen only if we let the USB controller enter low power
mode and turn off the clocks. Vendor drivers may have their own runtime
power management framework to power up/down the controller. But since
vendor drivers' runtime suspend/resume routines depend on the dwc3 child
node we would need a framework to trigger dwc3 runtime pm ops whenever a
bus suspend is received. If the device wants to exit from bus suspend
state it can send a wakeup signal to the host by first bringing out the
controller from low power mode. This series implements the needed
framework to achieve this functionality when a bus suspend interupt is
received.

The assumption here is that the dwc3 hibernation feature is not enabled and the
platform is responsible to detect resume events to bring the controller out of
suspend. On Qualcomm platforms the resume is handled through PHY sideband signalling.


The series is organized in below fashion:
Patch 1: This includes the modification needed from function drivers to let
UDC enter low power mode.
Patch 2: This has the modification needed in the UDC driver to trigger runtime
suspend whene a bus suspend interrupt is received. This also handles resume
and remote wakeup features from power management perspective.

Elson Roy Serrao (3):
  usb: function: u_ether: Handle rx requests during suspend/resume
  dt-bindings: usb: snps,dwc3: Add runtime-suspend-on-usb-suspend
    property
  usb: dwc3: Modify runtime pm ops to handle bus suspend

 .../devicetree/bindings/usb/snps,dwc3.yaml    |  5 ++
 drivers/usb/dwc3/core.c                       | 28 ++++++++++-
 drivers/usb/dwc3/core.h                       |  3 ++
 drivers/usb/dwc3/gadget.c                     | 32 ++++++++++---
 drivers/usb/gadget/function/u_ether.c         | 47 +++++++++++++++----
 5 files changed, 97 insertions(+), 18 deletions(-)

-- 
2.17.1


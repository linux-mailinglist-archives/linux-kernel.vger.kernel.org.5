Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A977C6025
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjJKWIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjJKWH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:07:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC499E;
        Wed, 11 Oct 2023 15:07:58 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BLTEai008080;
        Wed, 11 Oct 2023 22:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ZBPoEHQb4jBcQ+ztAHxvtMsuPH/IIMkDKONPY/YNy20=;
 b=Fkng1cHBXK3dqzE2rEpr8AXdI1EvewPVxAhly3RLhWNGvhw+BKIt0jUoUuBZ/RJnQkfw
 nBvN6zYzRkW4W+sdao4dniIDZOeG0/Iwz2TDeyTwIh3eHHlo7h39FK3T2zH4izh6Xn2r
 B8DQ6uD9TS9+UYG6zTqWJE/zFd2EDaQegqxWAMPMfYJWu/2lo7Cxx89S9MErFnLCWXw+
 XGdRWlWT5NP00rAE6w5/vZa2ImQkHhTS7e1XFvkUvvFRSNmrpr9i2AFA8JNUOYlooPDO
 GA9g4AWWRBEhhflse379un5mrIS6b/ex76+7QXrzpt8vakzikR0HxdT8263gsVFbPHtR wA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnqh1j0ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 22:07:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39BM7qUP032041
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 22:07:52 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 11 Oct 2023 15:07:51 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v4] usb: host: xhci: Avoid XHCI resume delay if SSUSB device is not present
Date:   Wed, 11 Oct 2023 15:07:40 -0700
Message-ID: <20231011220740.32297-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VGFEXK_uWaY8vqtPHuWNzuqwSk8PxKrB
X-Proofpoint-ORIG-GUID: VGFEXK_uWaY8vqtPHuWNzuqwSk8PxKrB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_17,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=828
 mlxscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a 120ms delay implemented for allowing the XHCI host controller to
detect a U3 wakeup pulse.  The intention is to wait for the device to retry
the wakeup event if the USB3 PORTSC doesn't reflect the RESUME link status
by the time it is checked.  As per the USB3 specification:

  tU3WakeupRetryDelay ("Table 7-12. LTSSM State Transition Timeouts")

This would allow the XHCI resume sequence to determine if the root hub
needs to be also resumed.  However, in case there is no device connected,
or if there is only a HSUSB device connected, this delay would still affect
the overall resume timing.

Since this delay is solely for detecting U3 wake events (USB3 specific)
then ignore this delay for the disconnected case and the HSUSB connected
only case.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
Depends-on:
https://lore.kernel.org/linux-usb/20230915143108.1532163-3-mathias.nyman@linux.intel.com/

changes in v4:
- Added change log between versions

changes in v3:
- Modified logic to determine if a USB3.0 device is connected.  Using the suspended_ports
and bus_suspended bitmasks.  suspended_port is non-zero as ports are runtime suspended,
while bus_suspended is non-zero if system suspend occurs while ports are active.

changes in v2:
- Looping across portsc to determine if there is a valid USB3 connection.

 drivers/usb/host/xhci.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index e1b1b64a0723..1855cab1be56 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -805,6 +805,18 @@ static void xhci_disable_hub_port_wake(struct xhci_hcd *xhci,
 	spin_unlock_irqrestore(&xhci->lock, flags);
 }
 
+/*
+ * Utilize suspended_ports and bus_suspended to determine if USB3 device is
+ * connected.  The bus state bits are set by XHCI hub when root hub udev is
+ * suspended.  Used to determine if USB3 remote wakeup considerations need to
+ * be accounted for during XHCI resume.
+ */
+static bool xhci_usb3_dev_connected(struct xhci_hcd *xhci)
+{
+	return !!xhci->usb3_rhub.bus_state.suspended_ports ||
+		!!xhci->usb3_rhub.bus_state.bus_suspended;
+}
+
 static bool xhci_pending_portevent(struct xhci_hcd *xhci)
 {
 	struct xhci_port	**ports;
@@ -968,6 +980,7 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 	int			retval = 0;
 	bool			comp_timer_running = false;
 	bool			pending_portevent = false;
+	bool			usb3_connected = false;
 	bool			reinit_xhc = false;
 
 	if (!hcd->state)
@@ -1116,9 +1129,14 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 		 * Resume roothubs only if there are pending events.
 		 * USB 3 devices resend U3 LFPS wake after a 100ms delay if
 		 * the first wake signalling failed, give it that chance.
+		 * Avoid this check if there are no devices connected to
+		 * the SS root hub. (i.e. HS device connected or no device
+		 * connected)
 		 */
 		pending_portevent = xhci_pending_portevent(xhci);
-		if (!pending_portevent && msg.event == PM_EVENT_AUTO_RESUME) {
+		usb3_connected = xhci_usb3_dev_connected(xhci);
+		if (!pending_portevent && usb3_connected &&
+		     msg.event == PM_EVENT_AUTO_RESUME) {
 			msleep(120);
 			pending_portevent = xhci_pending_portevent(xhci);
 		}

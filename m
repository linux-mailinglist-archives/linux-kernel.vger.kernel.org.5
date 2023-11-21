Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817497F3A35
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjKUXUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjKUXUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:20:21 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ACA97;
        Tue, 21 Nov 2023 15:20:17 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALNGh4H028441;
        Tue, 21 Nov 2023 23:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=HR1ipvsa7G04GTzspcQtmQ+QQIIk/Ylg1FpxgPOHEM8=;
 b=SdVIPhr7XonlvHMvjJQGnWlmAh75SI0WSC6HBWB8Hz4iiVxL8UE/xL2+Eec0yjJr1AY3
 HwIiH68gfBbdtuNTgSSpJFI4wAJyLAB0jT0Cn/7KW13xCEFL5CJ77OeMTb4wADBzctGJ
 x4StgTnAo0oSdGIomLxSvGC0hTW8GS+U+fWLyV1aehaxQzK2u7s+NcjmMBufpeNpyP+f
 Bkpbz9cb9WIV1kbaB9nhqsfnN/jT+RCZ1viZ2XU3q2oJQ52Euq+ac++mot9xC54jPNwX
 asfMxqb/0QesPHLlr57ijz3YQAC3n6I6GpeKnDhShjIZsc7x1sCzXAU8auOkUmw0kWJq EQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugr85tgxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 23:20:15 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALNKEJa023412
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 23:20:14 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 15:20:13 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH] usb: dwc3: gadget: Handle EP0 request dequeuing properly
Date:   Tue, 21 Nov 2023 15:20:03 -0800
Message-ID: <20231121232003.20249-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ibZNR1KeItaHz7_1rrjnBra_zPJvoloq
X-Proofpoint-ORIG-GUID: ibZNR1KeItaHz7_1rrjnBra_zPJvoloq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_13,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210182
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current EP0 dequeue path will share the same as other EPs.  However, there
are some special considerations that need to be made for EP0 transfers:

  - EP0 transfers never transition into the started_list
  - EP0 only has one active request at a time

In case there is a vendor specific control message for a function over USB
FFS, then there is no guarantee on the timeline which the DATA/STATUS stage
is responded to.  While this occurs, any attempt to end transfers on
non-control EPs will end up having the DWC3_EP_DELAY_STOP flag set, and
defer issuing of the end transfer command.  If the USB FFS application
decides to timeout the control transfer, or if USB FFS AIO path exits, the
USB FFS driver will issue a call to usb_ep_dequeue() for the ep0 request.

In case of the AIO exit path, the AIO FS blocks until all pending USB
requests utilizing the AIO path is completed.  However, since the dequeue
of ep0 req does not happen properly, all non-control EPs with the
DWC3_EP_DELAY_STOP flag set will not be handled, and the AIO exit path will
be stuck waiting for the USB FFS data endpoints to receive a completion
callback.

Fix is to utilize dwc3_ep0_reset_state() in the dequeue API to ensure EP0
is brought back to the SETUP state, and ensures that any deferred end
transfer commands are handled.  This also will end any active transfers
on EP0, compared to the previous implementation which directly called
giveback only.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 858fe4c299b7..88d8d589f014 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2103,7 +2103,17 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 
 	list_for_each_entry(r, &dep->pending_list, list) {
 		if (r == req) {
-			dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			/*
+			 * Explicitly check for EP0/1 as dequeue for those
+			 * EPs need to be handled differently.  Control EP
+			 * only deals with one USB req, and giveback will
+			 * occur during dwc3_ep0_stall_and_restart().  EP0
+			 * requests are never added to started_list.
+			 */
+			if (dep->number > 1)
+				dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			else
+				dwc3_ep0_reset_state(dwc);
 			goto out;
 		}
 	}

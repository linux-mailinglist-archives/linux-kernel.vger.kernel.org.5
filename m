Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98427F4147
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjKVJL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjKVJL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:11:58 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9555E83;
        Wed, 22 Nov 2023 01:11:53 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM5bWBI029251;
        Wed, 22 Nov 2023 09:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=0LmLpncZ7ZPLn6Iin3MIZKsAE3YQeRteHqQvwpY4M0U=;
 b=H7GSmfP2I6OAMrteaxVyARiGUXzl6m+5XFHonwnnziww0plu5e40Sn7WatOM0b2yx5mh
 5TTdcD2kl/CLkC1YsD4temhUQGNQzWk9sD0vmWWsPK0BD4Stw2eB1WQ9z1zUP4rhmTti
 hTLfDRBlCNMdkXixGPIAUMFBH968NFRyQvyzVQZxBVDZxc8gtoaksll24uJmqsERWDcD
 wRU1bmA2CYM2Ggftq7YR15RLpynd8WLSC5TP5/njU42IZ2UrOp+oBeaHQnL68euFKOqz
 8aX1qmapxyHrWATz2m7XXMlOEhL16Te54QPSECrJSyyphE9UPIIZfI9UkRTUu52bvgvr og== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uh8mw8y78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 09:11:50 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AM9BoGL019426
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 09:11:50 GMT
Received: from hu-uaggarwa-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 Nov 2023 01:11:47 -0800
From:   Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        "Uttkarsh Aggarwal" <quic_uaggarwa@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [RFC] usb: dwc: ep0: Use -ESHUTDOWN in dwc3_ep0_stall_restart
Date:   Wed, 22 Nov 2023 14:41:27 +0530
Message-ID: <20231122091127.3636-1-quic_uaggarwa@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7nz0rxhFdPU3BWU14Y79CcZShWtnNe1c
X-Proofpoint-ORIG-GUID: 7nz0rxhFdPU3BWU14Y79CcZShWtnNe1c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_06,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 mlxlogscore=613
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation blocks the running operations when Plug-out and
Plug-In is performed continuously, process gets stuck in
dwc3_thread_interrupt().

Code Flow:

	CPU1

	->Gadget_start
	->dwc3_interrupt
	->dwc3_thread_interrupt
	->dwc3_process_event_buf
	->dwc3_process_event_entry
	->dwc3_endpoint_interrupt
	->dwc3_ep0_interrupt
	->dwc3_ep0_inspect_setup
	->dwc3_ep0_stall_and_restart

By this time if pending_list is not empty, it will get the next request
on the given list and calls dwc3_gadget_giveback which will unmap request
and call its complete() callback to notify upper layers that it has
completed. Currently  dwc3_gadget_giveback status is set to-ECONNRESET,
whereas it should be -ESHUTDOWN.

Cc: <stable@vger.kernel.org>
Fixes: d742220b3577 ("usb: dwc3: ep0: giveback requests on stall_and_restart")
Signed-off-by: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
---
 drivers/usb/dwc3/ep0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index b94243237293..8317fedda1c0 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -238,7 +238,7 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 		struct dwc3_request	*req;
 
 		req = next_request(&dep->pending_list);
-		dwc3_gadget_giveback(dep, req, -ECONNRESET);
+		dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
 	}
 
 	dwc->eps[0]->trb_enqueue = 0;
-- 
2.17.1


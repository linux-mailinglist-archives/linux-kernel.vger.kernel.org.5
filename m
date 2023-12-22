Return-Path: <linux-kernel+bounces-9563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D72281C793
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE28287D39
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30447FC00;
	Fri, 22 Dec 2023 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TiC7bqae"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F4FBE4;
	Fri, 22 Dec 2023 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM9ZuZc010230;
	Fri, 22 Dec 2023 09:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=UukgpImPfM56bAgawI5Cs+EiVCWsaW6onrQ11fyKQoc=; b=Ti
	C7bqaeRdpuv8QkzWEDhSoffFr/L179hO7BWF6V0jDVVI9xEkaaNihoFVcNkqcmPT
	9cxRzH7QwJ7N7xL0Rrq4MHAPUJw7WWO+hOLkAACVtR42ohM9JYeeEtIxICQrg7Uf
	OJ1s/urF2vsPIKz/LyXhUe2A6VLpogWHbmgwrWiLxfyU7bbfh8i1kf+kgMTRCbFM
	ZRrga8yB/HP2WKLg9Gr7nVZ+6ZiYgNrES4MxM5opVAyvcThUWG1Rxq2tqnUd4CB6
	jZSJuaZ6C0hpEdqyHJSQjMWxKlBPQuBg+X4v2lSuFUo4RpB/+tqlD2LA0m6U0ere
	mT7T50dVchQ8RO4ODCKw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v57xx01nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 09:48:02 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM9lW8Q021583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 09:47:32 GMT
Received: from hu-uaggarwa-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 01:47:29 -0800
From: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Uttkarsh
 Aggarwal" <quic_uaggarwa@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2] usb: dwc: ep0: Update request status in dwc3_ep0_stall_restart
Date: Fri, 22 Dec 2023 15:17:04 +0530
Message-ID: <20231222094704.20276-1-quic_uaggarwa@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fxhOu5eQ9axRHmAj1z-0os44CrmXhTqV
X-Proofpoint-ORIG-GUID: fxhOu5eQ9axRHmAj1z-0os44CrmXhTqV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 mlxlogscore=801 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312220069

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
completed. Currently dwc3_gadget_giveback status is set to -ECONNRESET,
whereas it should be -ESHUTDOWN based on condition if not dwc->connected
is true.

Cc: <stable@vger.kernel.org>
Fixes: d742220b3577 ("usb: dwc3: ep0: giveback requests on stall_and_restart")
Signed-off-by: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
---

Changes in v2:
Added dwc->connected check to set status either -ESHUTDOWN and -ECONNRESET 
in dwc3_gadget_giveback.

Link to v1:
https://lore.kernel.org/all/20231122091127.3636-1-quic_uaggarwa@quicinc.com/T/#m28b011642024788c507d8b7eee4f7c5b0709d236

 drivers/usb/dwc3/ep0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index b94243237293..816b8eea73d6 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -238,7 +238,10 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 		struct dwc3_request	*req;
 
 		req = next_request(&dep->pending_list);
-		dwc3_gadget_giveback(dep, req, -ECONNRESET);
+		if (!dwc->connected)
+			dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+		else
+			dwc3_gadget_giveback(dep, req, -ECONNRESET);
 	}
 
 	dwc->eps[0]->trb_enqueue = 0;
-- 
2.17.1



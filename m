Return-Path: <linux-kernel+bounces-21927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7758296B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15EF1C24B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925ED3FB01;
	Wed, 10 Jan 2024 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RA0XWxP/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704AC3EA9E;
	Wed, 10 Jan 2024 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8ctMN016855;
	Wed, 10 Jan 2024 09:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=Js4kw6Z7/PgHtkYTNH23saebQTFsZ2uq7LYKYHCHAV4=; b=RA
	0XWxP/ZGS7IEeihqTnztDTaR8XcfsYXzw0AhpYWZhlTwmNYEkX6j39VzCPyw3oBx
	GAY8d+ZotwSeNSLywkVXACq+wTUgDX/DCxel1B9QZZQERGxeZB1L7idChP0t/lh1
	1RHcbQGuPd9TUb5qPno0721ofmEyzOmuUkHV6nP61pvMfs3n6HCYOM3EXK3/zFGg
	U0nQbvUCqHiPmlAolLQNq/ahoS1y+xdA66ysjerC55al4847GUfb7vjPkTIdtPZ1
	tb7A+a2bdXC26bUEnDIJ11aSteQWtFhz7VO0xXffUuh4oQ/muDXBdj+ic3bw+LCI
	p0F+lLmjEH5/P3ubCquw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhkem0p4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 09:56:33 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40A9uWNk031376
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 09:56:32 GMT
Received: from hu-uaggarwa-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 01:56:29 -0800
From: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        "Uttkarsh
 Aggarwal" <quic_uaggarwa@quicinc.com>
Subject: [RFC PATCH] usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend
Date: Wed, 10 Jan 2024 15:25:32 +0530
Message-ID: <20240110095532.4776-1-quic_uaggarwa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: mbs42UuGAXrU9ZJOx4Rvp_0Hob1r80-a
X-Proofpoint-GUID: mbs42UuGAXrU9ZJOx4Rvp_0Hob1r80-a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=471 impostorscore=0 phishscore=0 bulkscore=1 suspectscore=0
 lowpriorityscore=1 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100081

In current scenario if Plug-out and Plug-In performed continuously
there could be a chance while checking for dwc->gadget_driver in
dwc3_gadget_suspend, a NULL pointer dereference may occur.

Call Stack:

	CPU1:                           CPU2:
	gadget_unbind_driver            dwc3_suspend_common
	dw3_gadget_stop                 dwc3_gadget_suspend
                                        dwc3_disconnect_gadget

CPU1 basically clears the variable and CPU2 checks the variable.
Consider CPU1 is running and right before gadget_driver is cleared
and in parallel CPU2 executes dwc3_gadget_suspend where it finds
dwc->gadget_driver which is not NULL and resumes execution and then
CPU1 completes execution. CPU2 executes dwc3_disconnect_gadget where
it checks dwc->gadget_driver is already NULL because of which the
NULL pointer deference occur.

To prevent this, moving NULL pointer check inside of spin_lock.

Signed-off-by: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 019368f8e9c4..564976b3e2b9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4709,15 +4709,13 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	unsigned long flags;
 	int ret;
 
-	if (!dwc->gadget_driver)
-		return 0;
-
 	ret = dwc3_gadget_soft_disconnect(dwc);
 	if (ret)
 		goto err;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dwc3_disconnect_gadget(dwc);
+	if (dwc->gadget_driver)
+		dwc3_disconnect_gadget(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
-- 
2.17.1



Return-Path: <linux-kernel+bounces-84688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A6886AA29
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD501C20CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AC331A82;
	Wed, 28 Feb 2024 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="psrwFdSc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A74E2DF92;
	Wed, 28 Feb 2024 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109242; cv=none; b=TjphOOAohBUFGmNcV8uDqKYd3vLcpdWen2ezl2TclRddt+8klLr7wbXoxsR9eSHF7wZQIA+WI0GybRB2JFWku+We61iHhQXHqCPfyDjvF95pKYFK4y+0noMs6PinqWZzYMIf8n86HKVL/S9bc2DUMZbXrJcIWPBRurj9E4ozLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109242; c=relaxed/simple;
	bh=aOlzv2ms+slQM3Izb/zjipw0Sn3ySfHbf+ICKPL9UTo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dif73JPuq0yZQMEYXwl4E56y3gaKY7TVK+kTwJYZBFHehOLs/f9Pc2oz6fk7fObSDdkpqX5MkRBIZ6d3XLajDwBTc8e+0LK0dvFrWA+qJYlUHFRZJkVzW8ZyvxtsDjMTvqJISWS6WTJonWEzh5pyuJj0yZMY1cuyEAz4fEEdORM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=psrwFdSc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S4KI1Q007196;
	Wed, 28 Feb 2024 08:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=SY4ByAm
	QqkjRwFRnacQzAJoXNdftSjJlDeUuGPnHpDY=; b=psrwFdSc2dFSEwZIKuspgY8
	xWcLDAs2vHB6eQXFF4uHBbQPlAxxVPRPg7llCThraphFnQlAqAayHbYftvbglpPd
	v0jtc2+lhMyPLIZNSimurh/OEqXbJeLR0hPcoclrVw1CKymIJ3fefVEajGXM1T6A
	0/vdoU1Wi/VxV/DddobVdlqtsd+kikR6fO6vGbjuTMHAzHgWjueqbuOF1Lrycg/s
	rtRI7URBCc2a2Wu0KqffE1eThsFTU/p0JSQrcT5DCtZqn5sGuVyooo4vRxzHXLkA
	ItHKn1Sq+ogIPZdwvrNSQjSNuBleRhwJf+ksECVlg6mS/FJE8VJFMbylpsnK+MA=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whtbw8rsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 08:33:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41S8XvHI004655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 08:33:57 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 00:33:55 -0800
From: Prashanth K <quic_prashk@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman
	<mathias.nyman@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Prashanth K
	<quic_prashk@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH] usb: xhci: Add error handling in  xhci_map_urb_for_dma
Date: Wed, 28 Feb 2024 14:03:43 +0530
Message-ID: <20240228083343.3101303-1-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Pj9u1zt1yPLALrxqoIal9qM1qezI6nCc
X-Proofpoint-ORIG-GUID: Pj9u1zt1yPLALrxqoIal9qM1qezI6nCc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 mlxlogscore=636 lowpriorityscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280066

Currently xhci_map_urb_for_dma() creates a temporary buffer
and copies the SG list to the new linear buffer. But if the
kzalloc_node() fails, then the following sg_pcopy_to_buffer()
can lead to crash since it tries to memcpy to NULL pointer.
So return -EAGAIN if kzalloc returns null pointer.

Cc: <stable@vger.kernel.org> # 5.11
Fixes: 2017a1e58472 ("usb: xhci: Use temporary buffer to consolidate SG")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
 drivers/usb/host/xhci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index c057c42c36f4..0597a60bec34 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1218,6 +1218,9 @@ static int xhci_map_temp_buffer(struct usb_hcd *hcd, struct urb *urb)
 	temp = kzalloc_node(buf_len, GFP_ATOMIC,
 			    dev_to_node(hcd->self.sysdev));
 
+	if (!temp)
+		return -EAGAIN;
+
 	if (usb_urb_dir_out(urb))
 		sg_pcopy_to_buffer(urb->sg, urb->num_sgs,
 				   temp, buf_len, 0);
-- 
2.25.1



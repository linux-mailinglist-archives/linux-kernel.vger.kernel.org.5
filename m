Return-Path: <linux-kernel+bounces-21932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FD78296C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECAA285F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14D73F8F9;
	Wed, 10 Jan 2024 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HBA9Xwqn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C4B3F8D2;
	Wed, 10 Jan 2024 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8e59P022347;
	Wed, 10 Jan 2024 09:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=227RG3/s9zkktxfBSvl+wRn+OQ3YUe+UnkVxb7D7O/4=; b=HB
	A9XwqnTOOnn2/kZfUAydF4vZ861zRRIw9XAwcXFdN8c59m0vjmC3G3i+VHtkGeCC
	1RIgjm3jO/IPHcRRDC7JFIW0FTn7gzFR5UsVirJ/gnCJTROyIgfhTanRAex8z0jI
	rL/MwxW778xXmC5y+tyrG6ypSDUAddYTEIasTYt7BXk4kcB6LFi1B/ylfmKapMPY
	LTynE8aReqXklH/fbp4IueGT0TQXcy7LPY6wJkZmjCInDcUsgWU86I4Ex69bxr5i
	XwXIuUzMnfXWY1441uGbckCHXxvX6Q4i2mHwLW/wp8XgBtUCbnGOyhR0kQnR6J8p
	EJrB6zJp2hd7F+FMA6Tw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh85t26rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 09:58:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40A9wX0a012035
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 09:58:34 GMT
Received: from hu-ugoswami-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 01:58:30 -0800
From: Udipto Goswami <quic_ugoswami@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern
	<stern@rowland.harvard.edu>
CC: Krishna Kurapati <quic_kriskura@quicinc.com>,
        Sergei Shtylyov
	<sergei.shtylyov@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Udipto Goswami
	<quic_ugoswami@quicinc.com>
Subject: [PATCH v5] usb: core: Prevent null pointer dereference in update_port_device_state
Date: Wed, 10 Jan 2024 15:28:14 +0530
Message-ID: <20240110095814.7626-1-quic_ugoswami@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5eHEwRHheskovyIeQv2JtkuD3PkE7HjZ
X-Proofpoint-GUID: 5eHEwRHheskovyIeQv2JtkuD3PkE7HjZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=793 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100081

Currently, the function update_port_device_state gets the usb_hub from
udev->parent by calling usb_hub_to_struct_hub.
However, in case the actconfig or the maxchild is 0, the usb_hub would
be NULL and upon further accessing to get port_dev would result in null
pointer dereference.

Fix this by introducing an if check after the usb_hub is populated.

Fixes: 83cb2604f641 ("usb: core: add sysfs entry for usb device state")
Cc: stable@vger.kernel.org
Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
---
v5: Addressed nit picks in commit and the comment.
v4: Fixed minor mistakes in the comment.
v3: Re-wrote the comment for better context.
v2: Introduced comment for the if check & CC'ed stable.

 drivers/usb/core/hub.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index ffd7c99e24a3..48409d51ea43 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2053,9 +2053,19 @@ static void update_port_device_state(struct usb_device *udev)
 
 	if (udev->parent) {
 		hub = usb_hub_to_struct_hub(udev->parent);
-		port_dev = hub->ports[udev->portnum - 1];
-		WRITE_ONCE(port_dev->state, udev->state);
-		sysfs_notify_dirent(port_dev->state_kn);
+
+		/*
+		 * The Link Layer Validation System Driver (lvstest)
+		 * has a test step to unbind the hub before running the
+		 * rest of the procedure. This triggers hub_disconnect
+		 * which will set the hub's maxchild to 0, further
+		 * resulting in usb_hub_to_struct_hub returning NULL.
+		 */
+		if (hub) {
+			port_dev = hub->ports[udev->portnum - 1];
+			WRITE_ONCE(port_dev->state, udev->state);
+			sysfs_notify_dirent(port_dev->state_kn);
+		}
 	}
 }
 
-- 
2.17.1



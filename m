Return-Path: <linux-kernel+bounces-20427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1588E827EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41161F24764
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B9B79D4;
	Tue,  9 Jan 2024 06:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BzLKO1XI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5717C2;
	Tue,  9 Jan 2024 06:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4093LIp0019957;
	Tue, 9 Jan 2024 06:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=FmGVh3W2g4mUkpYE5hHFAFoo4UsVNaeXCU8Z582FdZQ=; b=Bz
	LKO1XI5i1aSz0Y3Ngdv2pdIZlQ9++EztwQnAZgLEuQaPqM0wSEl1EobAsM1yFgEV
	t7DT66rc5GGG+Zj8vd8dDxaEcMJqDUy+NeBF0hk2Cr/wjWqwS97RmbPt87yjZ7UF
	d1xrPm/EJ9a2KAtLhIjoFv58mXE3Zb3jRlL+US2pCxNYF2G5FgqlNq73te0d/DhC
	Fr4drzodfGqeBzB9bAh8EYHPtjXMbDGbI2Mn2KCjk1BqI43WShNRlkkUtDEYZBIG
	tpA8j+EVe7b0Ie7o4/Tirtxqi7xFWT5RGWxaZ5MqUd64bccpTYT61ykrnUyLOWjt
	Lq9jf9AJUsxjSRDLj6Kg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgq2ys23f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 06:17:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4096HRkC019581
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 06:17:27 GMT
Received: from hu-ugoswami-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 22:17:24 -0800
From: Udipto Goswami <quic_ugoswami@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern
	<stern@rowland.harvard.edu>
CC: Krishna Kurapati <quic_kriskura@quicinc.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Udipto Goswami
	<quic_ugoswami@quicinc.com>
Subject: [PATCH v3] usb: core: Prevent null pointer dereference in update_port_device_state
Date: Tue, 9 Jan 2024 11:47:08 +0530
Message-ID: <20240109061708.26288-1-quic_ugoswami@quicinc.com>
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
X-Proofpoint-GUID: j7V46y80BPb3l08IrWMq5e68WHn60HEV
X-Proofpoint-ORIG-GUID: j7V46y80BPb3l08IrWMq5e68WHn60HEV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=718 clxscore=1015 priorityscore=1501 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090045

Currently,the function update_port_device_state gets the usb_hub from
udev->parent by calling usb_hub_to_struct_hub.
However, in case the actconfig or the maxchild is 0, the usb_hub would
be NULL and upon further accessing to get port_dev would result in null
pointer dereference.

Fix this by introducing an if check after the usb_hub is populated.

Fixes: 83cb2604f641 ("usb: core: add sysfs entry for usb device state")
Cc: stable@vger.kernel.org
Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
---
v3: Re-wrote the comment for better context.
v2: Introduced comment for the if check & CC'ed stable.

 drivers/usb/core/hub.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index ffd7c99e24a3..6b514546e59b 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2053,9 +2053,23 @@ static void update_port_device_state(struct usb_device *udev)
 
 	if (udev->parent) {
 		hub = usb_hub_to_struct_hub(udev->parent);
-		port_dev = hub->ports[udev->portnum - 1];
-		WRITE_ONCE(port_dev->state, udev->state);
-		sysfs_notify_dirent(port_dev->state_kn);
+
+		/*
+		 * The Link Layer Validation System Driver (lvstest)
+		 * has procedure of unbinding the hub before running
+		 * the rest of the procedure. This triggers
+		 * hub_disconnect will set the hub's maxchild to 0.
+		 * This would result usb_hub_to_struct_hub in this
+		 * function to return NULL.
+		 *
+		 * Add if check to avoid running into NULL pointer
+		 * de-reference.
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



Return-Path: <linux-kernel+bounces-19587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53661826F41
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080171F22C07
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6530A41742;
	Mon,  8 Jan 2024 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="POHozhsy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B826B4121B;
	Mon,  8 Jan 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408D5F63016636;
	Mon, 8 Jan 2024 13:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=Yj9tfHIzcfb2h/uSh/hSnE1BOhG/nWfIZRNBZOaOKwc=; b=PO
	HozhsyEi8bceubFsjNEO071nGkwSLZFl63qVaZHnM+bcYT9vZDFmYa4/PmeSUZE8
	e3egga/UuxhFCR3H1zi1d2qAN+YjwQ1uLXHgAch9ap89g0ltNX6iGYc7XPyFSjs5
	s45Tjo5ri/Cj+z7nRqSsY4/0zGEsd4VSE315gJ8b2OliuGL/CZXJ82IfRObD04bi
	64ISO3iUn/cQBdIUKN28L2IOXVhLX772mGuYGaXrMH24nFuR9KVFwECjb41ipvO/
	XAJRSk/Iv3wsTCfyV91i9WDmlAjQCWrWIAlsIh+G0ADlScDE4axXRBPJVIqj8KEK
	dGrHyk32wqodTJPSJ2Ag==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vghkvg07u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 13:07:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408D7RZa008122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 13:07:27 GMT
Received: from hu-ugoswami-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 05:07:24 -0800
From: Udipto Goswami <quic_ugoswami@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Krishna Kurapati <quic_kriskura@quicinc.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Udipto Goswami
	<quic_ugoswami@quicinc.com>
Subject: [PATCH v2] usb: core: Prevent null pointer dereference in update_port_device_state
Date: Mon, 8 Jan 2024 18:37:06 +0530
Message-ID: <20240108130706.15698-1-quic_ugoswami@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tFXC9erw_5xUX0EVfnEybc4zJbpTspHs
X-Proofpoint-GUID: tFXC9erw_5xUX0EVfnEybc4zJbpTspHs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=708 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080113

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
v2: Introduced comment for the if check & CC'ed stable.

 drivers/usb/core/hub.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index ffd7c99e24a3..d40b5500f95b 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2053,9 +2053,18 @@ static void update_port_device_state(struct usb_device *udev)
 
 	if (udev->parent) {
 		hub = usb_hub_to_struct_hub(udev->parent);
-		port_dev = hub->ports[udev->portnum - 1];
-		WRITE_ONCE(port_dev->state, udev->state);
-		sysfs_notify_dirent(port_dev->state_kn);
+
+		/*
+		 * usb_hub_to_struct_hub() if returns NULL can
+		 * potentially cause NULL pointer dereference upon further
+		 * access.
+		 * Avoid this with an if check.
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



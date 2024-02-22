Return-Path: <linux-kernel+bounces-77035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C0686004B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C194B1F242D1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E79B159573;
	Thu, 22 Feb 2024 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kdpw3quG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143F0157E90
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624889; cv=none; b=iR9s+Aks1gSRaKLxszXa7cDfc/1q4Ib2RxV9TN7v8WLkLdzAsgrHjZbLO+ynD+XGbiE2yQztrEWS7oRVtm07gjoVW4+F4LkaLdg7Ou9/4V+kM43YSO+7r5LoLebxG4MOuz/DMvzjqF71z0DYd+Zm0uWLVewLCFPbCx5UML77ie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624889; c=relaxed/simple;
	bh=9K3pWAiB/DqkeRoMCn7/BciTB9vx1+qzhkv3Yo6Rxl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ew6IoaB1F284qrldlSIBzhUgNBMibWdAQKpHtGyy+noK34MBO2bM2wy5c6ftcoG+ePRfcTmOUroMn4s+JZKpGeHFS804IIylMVWSxWcK1Q1mF3d3bLtUuZeSwhLsCzgVmALBmfEQn8Vc00XA8oGmTXR6Jqsw4EpLrUYxfmz+mxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kdpw3quG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MAF2so015686;
	Thu, 22 Feb 2024 18:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=pj2BPbAZcucSWeeG7pNO1PQzpY9Trgm52RJu+sDer8I=; b=kd
	pw3quGIAKDjPiieFrzFzrCPDmjwc3YGxrpM/d3iC2YYE8Wl4nLCsX8zfHw7ev2AC
	kQUIc1NiMMJkJKe0IPPxtuZnSFDERlXq85LXC6MzweAt/RUEN92ZYS+QY/MV9Ppf
	H+tiN3XREoh2Ljcy9BQpSvi/2gbfrUksk4YzoEAnG5AaIe7KfkIsDqVZnRgHld0V
	YKuiOjVp9a8V5FznPD1uFz5ZPslS4dKYG8uIOXXmKFbw8YahTl5+Y4fMboqi6biV
	N60fkxjBBqotG9b7eo07KwUFY3AuOl5RmjrFjOka8x6PpzdvoXttez+G7/KIW4je
	j01mn4pjKNUqDrfQlbKA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we2bx9rey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:01:16 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MI1GcG016346
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:01:16 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 10:01:14 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <mcgrof@kernel.org>, <russ.weight@linux.dev>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH vRFC 8/8] firmware: FW_OPT_UEVENT for all request_firmware family functions
Date: Thu, 22 Feb 2024 23:30:33 +0530
Message-ID: <20240222180033.23775-9-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240222180033.23775-1-quic_mojha@quicinc.com>
References: <20240222180033.23775-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z9afkXeJj85ww57MpsoRPCzbkAAiUiHa
X-Proofpoint-GUID: z9afkXeJj85ww57MpsoRPCzbkAAiUiHa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 mlxlogscore=917 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220140

Currently, FW_OPT_UEVENT is used in almost every request_firmware
family function apart from request_firmware_nowait(), however,
request_firmware_nowait() uses much lower level api which does
not assume FW_OPT_UEVENT to be a default flag.

Apply FW_OPT_UEVENT as default flag.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/base/firmware_loader/main.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 91a45767a3a7..4650fef9b713 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -985,7 +985,8 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 
 	/* Need to pin this module until return */
 	__module_get(THIS_MODULE);
-	ret = __request_firmware(firmware_p, name, device, NULL, 0, 0, opt_flags);
+	ret = __request_firmware(firmware_p, name, device, NULL, 0, 0,
+				 FW_OPT_UEVENT | opt_flags);
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -1013,8 +1014,7 @@ int
 request_firmware(const struct firmware **firmware_p, const char *name,
 		 struct device *device)
 {
-	return _request_firmware(firmware_p, name, device, NULL, 0, 0,
-				 FW_OPT_UEVENT);
+	return _request_firmware(firmware_p, name, device, NULL, 0, 0, 0);
 }
 EXPORT_SYMBOL(request_firmware);
 
@@ -1034,8 +1034,7 @@ EXPORT_SYMBOL(request_firmware);
 int request_firmware_nowarn(const struct firmware **firmware, const char *name,
 			    struct device *device)
 {
-	return _request_firmware(firmware, name, device, NULL, 0, 0,
-				 FW_OPT_UEVENT | FW_OPT_NO_WARN);
+	return _request_firmware(firmware, name, device, NULL, 0, 0, FW_OPT_NO_WARN);
 }
 EXPORT_SYMBOL_GPL(request_firmware_nowarn);
 
@@ -1054,8 +1053,7 @@ int request_firmware_direct(const struct firmware **firmware_p,
 			    const char *name, struct device *device)
 {
 	return _request_firmware(firmware_p, name, device, NULL, 0, 0,
-				 FW_OPT_UEVENT | FW_OPT_NO_WARN |
-				 FW_OPT_NOFALLBACK_SYSFS);
+				 FW_OPT_NO_WARN | FW_OPT_NOFALLBACK_SYSFS);
 }
 EXPORT_SYMBOL_GPL(request_firmware_direct);
 
@@ -1073,7 +1071,7 @@ int request_firmware_platform(const struct firmware **firmware,
 			      const char *name, struct device *device)
 {
 	return _request_firmware(firmware, name, device, NULL, 0, 0,
-				 FW_OPT_UEVENT | FW_OPT_FALLBACK_PLATFORM);
+				 FW_OPT_FALLBACK_PLATFORM);
 }
 EXPORT_SYMBOL_GPL(request_firmware_platform);
 
@@ -1124,7 +1122,7 @@ request_firmware_into_buf(const struct firmware **firmware_p, const char *name,
 		return -EOPNOTSUPP;
 
 	return _request_firmware(firmware_p, name, device, buf, size, 0,
-				 FW_OPT_UEVENT | FW_OPT_NOCACHE);
+				 FW_OPT_NOCACHE);
 }
 EXPORT_SYMBOL(request_firmware_into_buf);
 
@@ -1149,8 +1147,7 @@ request_partial_firmware_into_buf(const struct firmware **firmware_p,
 		return -EOPNOTSUPP;
 
 	return _request_firmware(firmware_p, name, device, buf, size, offset,
-				 FW_OPT_UEVENT | FW_OPT_NOCACHE |
-				 FW_OPT_PARTIAL);
+				 FW_OPT_NOCACHE | FW_OPT_PARTIAL);
 }
 EXPORT_SYMBOL(request_partial_firmware_into_buf);
 
-- 
2.43.0.254.ga26002b62827



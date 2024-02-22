Return-Path: <linux-kernel+bounces-77033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0051E860049
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C70EB2737E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE0C158D83;
	Thu, 22 Feb 2024 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DdPPT6rQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BE915699F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624881; cv=none; b=D1+up2bo/b48ONUHaPXlAayZ+YOvWW60USTrprlxeU/xqX9ZhED0isCCGoerdm02MclZLw1wp6MUkduh2NFIM04LWRp9RIal1c6sbP2FZCIt0AFr5UGmNs5F54wYnm1A2csNJbhod5PfEy7CFyRL3HHpYFK2/jEP1yURBeG5D6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624881; c=relaxed/simple;
	bh=tWz7VggF4b2XyWeoLaTQ70tO6hfLqVKhQ5mFiKg0R0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1FxyoUv9Qqk/giOVyGgsjO/skXCL1waO2apP/D8vvSURKnjYFG0UqZCy9C0RE3ZpsQllAej+3ULW3YBKLsSVK5M9Pnc9YFRjv4g2bz0Jp41kRy8UqsVkQTsOsW0fV36oNUX8iXCw6y2SMpHvWOsUo5JX6pi/f/07LPXAXpANwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DdPPT6rQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MHXhD6011436;
	Thu, 22 Feb 2024 18:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=AtZhpSI2s26BHZKaBElwa3rCsZnLo5N2e3yHac2KK3I=; b=Dd
	PPT6rQEk8O/PMg2nUdC53V4lwDEJ73tFNmVRuYrNeO8fs2qt8Vhawi1Zy8IIQsyU
	C4JUHOZGVxdWplg3cZqJOyntqKL9AbQ90czBdCPHBsujxKdjsqW6h6wbnmXm2qiZ
	eZm3d2z/y0uVf71NYdLMa4JkcLOmkFvZ9cSzDdG5GF6jdlyvB7ZqmWYmIIrAuoxZ
	9K+q+vdDlnkzkyHRlAJXK5eY4Gb6mH3P7kZy3G05dSe0LqNyyKg1ZoQr/RJCnS29
	1hmGMDt4m4566DOUm9gCNy6nRoqIT5YunNLhJxC4EzukOY3welLDj1JIOz6+P9xf
	erRZf6hwzu4wzfZ8HNGQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weasbr3yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:01:07 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MI16xD028646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:01:06 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 10:01:04 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <mcgrof@kernel.org>, <russ.weight@linux.dev>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH vRFC 4/8] treewide: rename firmware_request_cache()
Date: Thu, 22 Feb 2024 23:30:29 +0530
Message-ID: <20240222180033.23775-5-quic_mojha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 1m5y1QFg32QDE8WrknFCBBlS7oYg97Zf
X-Proofpoint-GUID: 1m5y1QFg32QDE8WrknFCBBlS7oYg97Zf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220140

Rename firmware_request_cache() to request_firmware_cache()
to be more concrete and align with the name of other request
firmware family functions.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 Documentation/driver-api/firmware/request_firmware.rst | 6 +++---
 drivers/base/firmware_loader/main.c                    | 6 +++---
 drivers/net/wireless/mediatek/mt7601u/mcu.c            | 2 +-
 include/linux/firmware.h                               | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Documentation/driver-api/firmware/request_firmware.rst
index 3d6df9922c4b..6c5b91705bb3 100644
--- a/Documentation/driver-api/firmware/request_firmware.rst
+++ b/Documentation/driver-api/firmware/request_firmware.rst
@@ -60,13 +60,13 @@ Special optimizations on reboot
 Some devices have an optimization in place to enable the firmware to be
 retained during system reboot. When such optimizations are used the driver
 author must ensure the firmware is still available on resume from suspend,
-this can be done with firmware_request_cache() instead of requesting for the
+this can be done with request_firmware_cache() instead of requesting for the
 firmware to be loaded.
 
-firmware_request_cache()
+request_firmware_cache()
 ------------------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
-   :functions: firmware_request_cache
+   :functions: request_firmware_cache
 
 request firmware API expected driver use
 ========================================
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 9411ad7968cb..2823dcd7153a 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -1034,7 +1034,7 @@ int request_firmware_platform(const struct firmware **firmware,
 EXPORT_SYMBOL_GPL(request_firmware_platform);
 
 /**
- * firmware_request_cache() - cache firmware for suspend so resume can use it
+ * request_firmware_cache() - cache firmware for suspend so resume can use it
  * @name: name of firmware file
  * @device: device for which firmware should be cached for
  *
@@ -1045,7 +1045,7 @@ EXPORT_SYMBOL_GPL(request_firmware_platform);
  * situations. This helper is not compatible with drivers which use
  * request_firmware_into_buf() or request_firmware_nowait() with no uevent set.
  **/
-int firmware_request_cache(struct device *device, const char *name)
+int request_firmware_cache(struct device *device, const char *name)
 {
 	int ret;
 
@@ -1055,7 +1055,7 @@ int firmware_request_cache(struct device *device, const char *name)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(firmware_request_cache);
+EXPORT_SYMBOL_GPL(request_firmware_cache);
 
 /**
  * request_firmware_into_buf() - load firmware into a previously allocated buffer
diff --git a/drivers/net/wireless/mediatek/mt7601u/mcu.c b/drivers/net/wireless/mediatek/mt7601u/mcu.c
index 1b5cc271a9e1..cee36dc1e9eb 100644
--- a/drivers/net/wireless/mediatek/mt7601u/mcu.c
+++ b/drivers/net/wireless/mediatek/mt7601u/mcu.c
@@ -414,7 +414,7 @@ static int mt7601u_load_firmware(struct mt7601u_dev *dev)
 					 MT_USB_DMA_CFG_TX_BULK_EN));
 
 	if (firmware_running(dev))
-		return firmware_request_cache(dev->dev, MT7601U_FIRMWARE);
+		return request_firmware_cache(dev->dev, MT7601U_FIRMWARE);
 
 	ret = request_firmware(&fw, MT7601U_FIRMWARE, dev->dev);
 	if (ret)
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 93e6a37352a8..4449837ea0c6 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -196,6 +196,6 @@ static inline void firmware_upload_unregister(struct fw_upload *fw_upload)
 
 #endif
 
-int firmware_request_cache(struct device *device, const char *name);
+int request_firmware_cache(struct device *device, const char *name);
 
 #endif
-- 
2.43.0.254.ga26002b62827



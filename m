Return-Path: <linux-kernel+bounces-94022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE7887388C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DD5284703
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441D3134CF8;
	Wed,  6 Mar 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zxi2LqBx"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8685C133414;
	Wed,  6 Mar 2024 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734133; cv=none; b=upvTmFOThbhPl8xD2A2Zp05JIeTGUQ4hFOmxlW6ieCh7EwAcCS7zowz/1gJYpTqN97/T1JVukhvosqTZ8HEmIYLHHzGj0HXuRLTbnA+X4I8LUqyPrEv95iLVi0rQAI52QYNdLCMccEyfOXDQvVUhUk4HltCYGibojUSmF3ONSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734133; c=relaxed/simple;
	bh=VS1AQhdQTxNirNpomKjqTD6WT1P/vvqx1Hx55sOh2ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIPT+Q3ZKaG9gkRt1x/4S+jPE4Je95HB8BuWTAhLuTL0RX3JjJmNfqYf1P9atJZN47Xi2r2Xu87+2VhPacWrutpdEPpJk+9LqDTp04WIC42aVtR5CLya+hS1JRwEb4JxgL6ngTacAQejNEvdCFcVr/C5mgNc+OHGcnsWv3nLDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zxi2LqBx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426E8dxb012908;
	Wed, 6 Mar 2024 14:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=f5V34d+v+9WtCrL/6crwi8C/ZZrO1PefzMKrgvPQbDI=;
 b=Zxi2LqBxiNr10bOIh3S3OHxRr269/Mq64bJcXzy8mwoIQq01O1izZktrGGAsUY21GuyU
 NKSnE7erTa5EHYsHtaP3wo97PsR90VE8Kkte8XXU67MFWYB/drRT9gEMp3U7W1dUsYiO
 ncCEczkTI9WHky86aHtPrwTwrqKfcly4UzQ5KYKFhBLmXOV4h0S8ZGlWRgb/85xjgDvh
 DLJeURQmlyncGyYP2djZCwsrzPpCuk5aXF3FSl9htCfL+gM3ieGM1VMd4bqC9dEq98FU
 sMrd3ZfnaVw170Cl+NA+2FdgfOYJPZSkl6nsKzWSH6ST41tThdq4oddaRaBf0zp2CHF8 Ng== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpsyxg080-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:08:49 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426Cmpuf025387;
	Wed, 6 Mar 2024 14:08:48 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmetyq853-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:08:48 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426E8jdl38404408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 14:08:47 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 143B458068;
	Wed,  6 Mar 2024 14:08:45 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89B7058067;
	Wed,  6 Mar 2024 14:08:44 +0000 (GMT)
Received: from jason-laptop.home.arpa (unknown [9.61.164.86])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 14:08:44 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
Subject: [PATCH v2 1/5] s390/ap: Externalize AP bus specific bitmap reading function
Date: Wed,  6 Mar 2024 09:08:39 -0500
Message-ID: <20240306140843.10782-2-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240306140843.10782-1-jjherne@linux.ibm.com>
References: <20240306140843.10782-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4Yx-_XQB6pBNpnOZwbZB8iz9kuqRX4B3
X-Proofpoint-GUID: 4Yx-_XQB6pBNpnOZwbZB8iz9kuqRX4B3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060113

Rename hex2bitmap() to ap_hex2bitmap() and export it for external
use. This function will be used by the implementation of the vfio-ap
queue_configuration sysfs attribute.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c | 13 +++----------
 drivers/s390/crypto/ap_bus.h | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index f46dd6abacd7..5d8e379eff44 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1035,15 +1035,7 @@ void ap_bus_cfg_chg(void)
 	ap_bus_force_rescan();
 }
 
-/*
- * hex2bitmap() - parse hex mask string and set bitmap.
- * Valid strings are "0x012345678" with at least one valid hex number.
- * Rest of the bitmap to the right is padded with 0. No spaces allowed
- * within the string, the leading 0x may be omitted.
- * Returns the bitmask with exactly the bits set as given by the hex
- * string (both in big endian order).
- */
-static int hex2bitmap(const char *str, unsigned long *bitmap, int bits)
+int ap_hex2bitmap(const char *str, unsigned long *bitmap, int bits)
 {
 	int i, n, b;
 
@@ -1070,6 +1062,7 @@ static int hex2bitmap(const char *str, unsigned long *bitmap, int bits)
 		return -EINVAL;
 	return 0;
 }
+EXPORT_SYMBOL(ap_hex2bitmap);
 
 /*
  * modify_bitmap() - parse bitmask argument and modify an existing
@@ -1135,7 +1128,7 @@ static int ap_parse_bitmap_str(const char *str, unsigned long *bitmap, int bits,
 		rc = modify_bitmap(str, newmap, bits);
 	} else {
 		memset(newmap, 0, size);
-		rc = hex2bitmap(str, newmap, bits);
+		rc = ap_hex2bitmap(str, newmap, bits);
 	}
 	return rc;
 }
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 98814839ef30..954f8d36c2d9 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -343,6 +343,28 @@ int ap_parse_mask_str(const char *str,
 		      unsigned long *bitmap, int bits,
 		      struct mutex *lock);
 
+/*
+ * ap_hex2bitmap() - Convert a string containing a hexadecimal number (str)
+ * into a bitmap (bitmap) with bits set that correspond to the bits represented
+ * by the hex string. Input and output data is in big endian order.
+ *
+ * str - Input hex string of format "0x1234abcd". The leading "0x" is optional.
+ * At least one digit is required. Must be large enough to hold the number of
+ * bits represented by the bits parameter.
+ *
+ * bitmap - Pointer to a bitmap. Upon successful completion of this function,
+ * this bitmap will have bits set to match the value of str. If bitmap is longer
+ * than str, then the rightmost bits of bitmap are padded with zeros. Must be
+ * large enough to hold the number of bits represented by the bits parameter.
+ *
+ * bits - Length, in bits, of the bitmap represented by str. Must be a multiple
+ * of 8.
+ *
+ * Returns: 0           on success
+ *          -EINVAL     If str format is invalid or bits is not a multiple of 8.
+ */
+int ap_hex2bitmap(const char *str, unsigned long *bitmap, int bits);
+
 /*
  * Interface to wait for the AP bus to have done one initial ap bus
  * scan and all detected APQNs have been bound to device drivers.
-- 
2.41.0



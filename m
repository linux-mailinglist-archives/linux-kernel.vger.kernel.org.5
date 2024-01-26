Return-Path: <linux-kernel+bounces-40192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 519C983DC0B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D601F28944
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2CB1CD07;
	Fri, 26 Jan 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lV+hW9D2"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2A31C2A6;
	Fri, 26 Jan 2024 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279738; cv=none; b=FtyDcvJzgBsU1wQFCnLywcl85ro1MahRxHPdbSk0Z8QoV+iPZ3BynO/CHljHBKy/RSW8G2IdcHrg9ma9RX9ROQvybW9tOoOFglh3I44EHnAXKmOf+FaKIuzcUL+2xRZbeMsPBspDkyjxqFOjgmWeXHI4g+KWjt7CH/Ho/OWtv8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279738; c=relaxed/simple;
	bh=VS1AQhdQTxNirNpomKjqTD6WT1P/vvqx1Hx55sOh2ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIzRByltL6l+WPR3xOo/QIwK634sHCIm0TZyeReS7np/IY1QHwbh4TTKZjIC5qJIw2Tgoo4sPIrTP9t3cE/sBRZoxy7SOH8mQ3MNhN/yuAnLan3jtMBZWt0H+7WgSzhVIy/i3eOPzsiRQgSekokloAA341kLl24M6NQRj3aq1zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lV+hW9D2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QEWUh0016460;
	Fri, 26 Jan 2024 14:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=f5V34d+v+9WtCrL/6crwi8C/ZZrO1PefzMKrgvPQbDI=;
 b=lV+hW9D2sT2PV1vy+tIwi1buXeF0+41mezYTYKf31qZIRars5uk8cHcHA5pdMOPPqUWm
 kHhCziMs7Dt4zK0Md452cZN+G98NZnkmRIPoYZRT35vsGSlVMXb0t9JI3TGQ4s0bnfxe
 tRRE3tswzXsJdUi8uD0Gt941G7wz8m7b5TdSgNQP53IL7YjM4XA3iKcH00b6kYEw5mGn
 1IjcbDgrVN3rmFXyWhgRCbWhHZSbYtTxadvxOd4HAfoVUPQcTsHG3WUiYJh6n+6D/TtG
 ShaUgs6CE1ZJ7ZmF3xcsiIx8ZFctKK3WpDgVwM+oac32tjgPCsFyrANT4quVqFZSzhC9 xQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vvek903e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 14:35:36 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40QDQGlY028254;
	Fri, 26 Jan 2024 14:35:35 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vru732ss7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 14:35:35 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40QEZYEG2098156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 14:35:34 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DBDC58062;
	Fri, 26 Jan 2024 14:35:34 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14E2B58056;
	Fri, 26 Jan 2024 14:35:34 +0000 (GMT)
Received: from li-4795344c-3451-11b2-a85c-ab40c30bcc43.ibm.com (unknown [9.61.37.129])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jan 2024 14:35:33 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com
Subject: [PATCH 1/3] s390/ap: Externalize AP bus specific bitmap reading function
Date: Fri, 26 Jan 2024 09:35:31 -0500
Message-ID: <20240126143533.14043-2-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240126143533.14043-1-jjherne@linux.ibm.com>
References: <20240126143533.14043-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lt6NTaDY5pmxB3G-vShctZj47sUMv0hI
X-Proofpoint-ORIG-GUID: lt6NTaDY5pmxB3G-vShctZj47sUMv0hI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260106

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



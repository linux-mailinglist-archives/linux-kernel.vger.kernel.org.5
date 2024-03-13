Return-Path: <linux-kernel+bounces-102511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DC087B31B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE811C21E59
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5099C54735;
	Wed, 13 Mar 2024 20:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uoua+Hbg"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1C20DDB;
	Wed, 13 Mar 2024 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363498; cv=none; b=GfctUdrE2MCndXJNIi4xN0KSg3eNsrInkcjmOYW9i8wVLjaPtdmDDytk0sIhb9IiqIooYNuXEfwtcXteqn40L0zBfoWGhZmut0VOmVU15VWi4YhMy1m4u4CcBtJCW5DeF3NHmFQHeM5SbolFTa1FEACmHpQGET49FeeOkJywlgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363498; c=relaxed/simple;
	bh=Dxc1Y9DEWjmEAUQcAuJqD4/uaanYXhVQFUYqIQzbI+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFCFPOU2+LCvtVdSSlxRFWcKIew1SmDoeVz+/4yzBkCh3/jDcjbsjAoxN40CZKVm1Mc8HaslKY30g10GL1J7zt6rYgQSSHRsQ6sQq6UR1F5u45mQwE3JanRH84x/f04L+H9jfOrgF/A5LwRWb1Uw8Nt//24CQCVIQtVYDeWmDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uoua+Hbg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DJsEoC006151;
	Wed, 13 Mar 2024 20:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pfYAziHimuLD6Bq9AnCRElxIv/lJzmInAejaT3HQHeA=;
 b=Uoua+HbgPEs81pvtd0Ui2j9+zjLsu7ujAx0EvowwxfRFCxz2yAlIJaO/aMcK98RuxNN0
 tVRKupJyQWwhMJrF3RL52b2J8jyKLht4m9ldzZZAR2a/FQnTCxdXvvMVAdp6+9SEYxif
 BNjVLNQYPxPXQXtCf26PJtsyd0k4lz1umJnBiQmn1uqaFpfSqnwuPWnrGZ9cZw8fOeX4
 9s3DP4x1ZAoKcG6XSbs3ytuB4zEI987axjRPl39bcl59tTXMEmkRvF/MmDVw8buwkvwG
 9bxaiDi3PJuQ6Ac2tlcfXx8PcRNI9lcT1EIzft9hHmVCIF/s3EXUrgllf24UnPvZR9ZK YA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wue9tvy48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 20:58:13 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42DKhk89015539;
	Wed, 13 Mar 2024 20:58:12 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws2g00pjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 20:58:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42DKw96K47186240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 20:58:12 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FE7758056;
	Wed, 13 Mar 2024 20:58:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AB6058060;
	Wed, 13 Mar 2024 20:58:09 +0000 (GMT)
Received: from jason-laptop.ibmuc.com (unknown [9.61.59.128])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Mar 2024 20:58:08 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
Subject: [PATCH v3 1/5] s390/ap: Externalize AP bus specific bitmap reading function
Date: Wed, 13 Mar 2024 16:58:03 -0400
Message-ID: <20240313205807.30554-2-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313205807.30554-1-jjherne@linux.ibm.com>
References: <20240313205807.30554-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ljRXpmf6wj9VnMP06ZwT3BA_d2Yb722i
X-Proofpoint-GUID: ljRXpmf6wj9VnMP06ZwT3BA_d2Yb722i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130160

Rename hex2bitmap() to ap_hex2bitmap() and export it for external
use. This function will be used by the implementation of the vfio-ap
ap_config sysfs attribute.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c | 13 +++----------
 drivers/s390/crypto/ap_bus.h | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index cce0bafd4c92..1be07197eda3 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1068,15 +1068,7 @@ void ap_bus_cfg_chg(void)
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
 
@@ -1103,6 +1095,7 @@ static int hex2bitmap(const char *str, unsigned long *bitmap, int bits)
 		return -EINVAL;
 	return 0;
 }
+EXPORT_SYMBOL(ap_hex2bitmap);
 
 /*
  * modify_bitmap() - parse bitmask argument and modify an existing
@@ -1168,7 +1161,7 @@ static int ap_parse_bitmap_str(const char *str, unsigned long *bitmap, int bits,
 		rc = modify_bitmap(str, newmap, bits);
 	} else {
 		memset(newmap, 0, size);
-		rc = hex2bitmap(str, newmap, bits);
+		rc = ap_hex2bitmap(str, newmap, bits);
 	}
 	return rc;
 }
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 59c7ed49aa02..1db9597509da 100644
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



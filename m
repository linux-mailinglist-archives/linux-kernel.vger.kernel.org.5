Return-Path: <linux-kernel+bounces-159964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 526758B36DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35871F23091
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AB9145B2B;
	Fri, 26 Apr 2024 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UnOFLeln"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4490014534D;
	Fri, 26 Apr 2024 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714133097; cv=none; b=uhTiPc79HQra6srlPN+VkgiHdymOrYr/UKCPt/bgUH8h7ceu7bucxJEjVGtWWU15GOvNLTA0gwPbCdlZLDZVMsvtZkppr+FXZfm2cczU1bvaeOFOcg6r+Dhs7kNXeYocJmsVpirOgNcwgmNLC4UrNeICrMY3uNwDdBhcCGCpQmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714133097; c=relaxed/simple;
	bh=YBR42G0rnWNZq59i3YDxVpGyifaB1mtmlbmI2avgYCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmnnZevsWQ7vRZzm75SlwjGDuKHy/XiNEKRe0SAlvcBPJaxA1QRyxDCLDYq1iylJhzLSRmgbCi1tCuZw3zYTBPNr+zYKyu05qQzb+yHD4cyNfxyDizC0YqCJntKRfXdq5kk4fwMossXiHHjg001uKCL9WCsSpobpgJBkOqFTkS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UnOFLeln; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43QBwtFn030206;
	Fri, 26 Apr 2024 12:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nWJ3bcNV7hDM41Mr8ykKMUU4LLC6VcTLRPD4a3TmQew=;
 b=UnOFLelnacEhaTayIu/d7eZOfU5frTlOVHa4gB6O9h1ctiiZ3F4NmVmx12wxHLaiEweH
 72eeQSOpd2vdMXYukWpqSjHvBQrzVqrBoGB6l7vjULPjRj4ZKOxd5dyJJTOHfrW2+ARl
 Fb3GM9lP3zb55L+J2Bzdl2OA3JXbqBmdDRVV0a7tJcVcXD/BjmbU1gWiJKRTGY6NiP+z
 V5KZ8qOZ8BPe5ie1ThFgqT5fvEmVIgrohSew8koECmYQgVe2d+Zh3Sd+0DyAKnp2NmPV
 LDRk339W1y/2x3kEJX30WDidAEROGsqJffhcFkmNIJU891kay6dHEGfQj5XoK6EB240T Mg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrbusr0ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 12:04:54 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43QBtA0Y021021;
	Fri, 26 Apr 2024 12:04:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmre0fqh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 12:04:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43QC4mM636766090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 12:04:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 565622004E;
	Fri, 26 Apr 2024 12:04:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2692420043;
	Fri, 26 Apr 2024 12:04:48 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Apr 2024 12:04:48 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [PATCH v3 2/2] s390/pgtable: add missing hardware bits for puds, pmds
Date: Fri, 26 Apr 2024 14:04:47 +0200
Message-ID: <20240426120447.34318-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426120447.34318-1-imbrenda@linux.ibm.com>
References: <20240426120447.34318-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wPnSNjBZH4wI2cGizilVFg6VFYBD3zby
X-Proofpoint-ORIG-GUID: wPnSNjBZH4wI2cGizilVFg6VFYBD3zby
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404260080

Add the table type and ACCF validity bits to _SEGMENT_ENTRY_BITS and
_SEGMENT_ENTRY_HARDWARE_BITS{,_LARGE}.

For completeness, introduce _REGION3_ENTRY_HARDWARE_BITS_LARGE and
_REGION3_ENTRY_HARDWARE_BITS, containing the hardware bits used for
large puds and normal puds.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 3da2995fd196..e2f713fae9c9 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -262,6 +262,8 @@ static inline int is_module_addr(void *addr)
 #define _REGION3_ENTRY		(_REGION_ENTRY_TYPE_R3 | _REGION_ENTRY_LENGTH)
 #define _REGION3_ENTRY_EMPTY	(_REGION_ENTRY_TYPE_R3 | _REGION_ENTRY_INVALID)
 
+#define _REGION3_ENTRY_HARDWARE_BITS_LARGE	0xffffffff8001073cUL
+#define _REGION3_ENTRY_HARDWARE_BITS		0xfffffffffffff6ffUL
 #define _REGION3_ENTRY_ORIGIN_LARGE ~0x7fffffffUL /* large page address	     */
 #define _REGION3_ENTRY_DIRTY	0x2000	/* SW region dirty bit */
 #define _REGION3_ENTRY_YOUNG	0x1000	/* SW region young bit */
@@ -278,9 +280,9 @@ static inline int is_module_addr(void *addr)
 #define _REGION_ENTRY_BITS	 0xfffffffffffff22fUL
 
 /* Bits in the segment table entry */
-#define _SEGMENT_ENTRY_BITS			0xfffffffffffffe33UL
-#define _SEGMENT_ENTRY_HARDWARE_BITS		0xfffffffffffffe30UL
-#define _SEGMENT_ENTRY_HARDWARE_BITS_LARGE	0xfffffffffff00730UL
+#define _SEGMENT_ENTRY_BITS			0xfffffffffffffe3fUL
+#define _SEGMENT_ENTRY_HARDWARE_BITS		0xfffffffffffffe3cUL
+#define _SEGMENT_ENTRY_HARDWARE_BITS_LARGE	0xfffffffffff1073cUL
 #define _SEGMENT_ENTRY_ORIGIN_LARGE ~0xfffffUL /* large page address	    */
 #define _SEGMENT_ENTRY_ORIGIN	~0x7ffUL/* page table origin		    */
 #define _SEGMENT_ENTRY_PROTECT	0x200	/* segment protection bit	    */
-- 
2.44.0



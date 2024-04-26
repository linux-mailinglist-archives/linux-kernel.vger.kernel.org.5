Return-Path: <linux-kernel+bounces-159958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B06028B36C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DCE6283BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9683145B23;
	Fri, 26 Apr 2024 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LScrga2N"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBA414532D;
	Fri, 26 Apr 2024 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714132567; cv=none; b=pr4YTyGdh+QJBuBfpZpVyZCnquW4ed1WBZCMm5qdYq0bUtP2XeiU4FrbmSKa5WM1SGRfmXSe3SgWggoGz6KzG4eUPAPzYWR6GVL0K5bVae7+HYMoac69fxG9Xx9Aa4yEO6tYILQJM4q+Nk7p1Jw66p4RkS63vdTmy5o7bPpib1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714132567; c=relaxed/simple;
	bh=3qtJDsdPjtnQI3mHDzS7yCsP1oQkkBZmYZFM5YotewE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdcnFGeeoFoBqKNyIA8KshnfSbh0hD8nVDzl5R30B2VU+qq866nTtJkukWuXXf5MPi89ihZ63+sRTrYSmMa92Lyybld8VXVSVUZqhyHT3dAAHSs80r07XdDHr2nWxX2c/dmZ/K2v+bUdDCD6tS+XyupV+nPwpfTetwqFo5Rq32E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LScrga2N; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43QBXcoj005586;
	Fri, 26 Apr 2024 11:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iR+Mct1oUSyI0/AAeOslw8PmchhhXiKP96hdegujflc=;
 b=LScrga2NwI+gBTSQWsKPdTeELlGHZnKm2/zZZZEI3HBq/mMQ9givSZl6C9Fn9jiuXO7M
 ZU45X+Z9nM2HMEHZCQDvp6bVddFUSrzDvbxV1V/EoMIuuw3ZpbSA2o4V8X5fRNsg9TaL
 KwSh0fxgAZbGzjeHowJLrbXCzZqO8BVJ4GId9HgKPiUWrXH60UxZt90Jkk260GZzOIMU
 5okn/XHtNtcyapw0NkILkLb4xG7Iv5CPni96yA4gsWEoIIWFsuqzSaVKnPn/LD+pgBJL
 wsjXlQVJsVQzZNrOdw5xpkJjN6G5WQ+Eb4s50aUrKdvhhpEfyjHbtv3TRBFU2Em4jo6o sg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrbga81mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 11:56:03 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43QASbkZ028328;
	Fri, 26 Apr 2024 11:51:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmtr2y24y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 11:51:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43QBov4A18612676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 11:50:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D5B020065;
	Fri, 26 Apr 2024 11:50:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10F722004F;
	Fri, 26 Apr 2024 11:50:57 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Apr 2024 11:50:57 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [PATCH v2 2/2] s390/pgtable: introduce _REGION3_ENTRY_HARDWARE_BITS_LARGE
Date: Fri, 26 Apr 2024 13:50:56 +0200
Message-ID: <20240426115056.31768-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426115056.31768-1-imbrenda@linux.ibm.com>
References: <20240426115056.31768-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tsoaxJXjLSIoF4OgxPrAHgMc6WqnDkhi
X-Proofpoint-ORIG-GUID: tsoaxJXjLSIoF4OgxPrAHgMc6WqnDkhi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404260079

For completeness, introduce _REGION3_ENTRY_HARDWARE_BITS_LARGE,
containing the hardware bits used for large puds.

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



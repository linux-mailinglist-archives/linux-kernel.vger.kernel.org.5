Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DD0805C00
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345246AbjLERc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjLERcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:32:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B802618D;
        Tue,  5 Dec 2023 09:33:01 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5HRGHP023959;
        Tue, 5 Dec 2023 17:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=MVbiPS6Os17Ey72kOOBZe4mf8N0Z9v7CVaiY4fv9F04=;
 b=e1vAl1McWYuGDnShw/HwQwMHU48CnTMe15Iig9/p4ALO7NHLs4+mX28zb+1OGgOFxK4m
 8tNluXFTRwofkEgyWLjSSgVxSYdhNOkVIoYDWrk1tRWX6fuH4RyGzewiRPYQS8jHGz05
 59GP2mtfp4fRSFls5jcFP+dAHafwS4DqzbzCWj1F5Als4d+Dmu2z03HI8jmZhM+dM6zS
 dPSiivR/MSrjtwzMmcDRQbLALfCEGLvBY0sbkzdwDm9ZvLxxje/2d8aa5GwPc4HPrv2C
 iX63cm2IkGrHcsnAbrWesgI4JdWHrWTrGI1D4aFL5W7BtGAUqCDVSsMfqEdYwGzPQR6F Sw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ut896r5cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 17:33:01 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5GfFXs000927;
        Tue, 5 Dec 2023 17:33:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3urewtgay6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 17:33:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B5HWqsT17105436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Dec 2023 17:32:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0E5620043;
        Tue,  5 Dec 2023 17:32:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C78B2004B;
        Tue,  5 Dec 2023 17:32:52 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  5 Dec 2023 17:32:52 +0000 (GMT)
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        kvm390-list@tuxmaker.boeblingen.de.ibm.com, hca@linux.ibm.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        nsg@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com
Subject: [PATCH v1 1/1] s390: mm: convert pgste locking functions to C
Date:   Tue,  5 Dec 2023 18:32:52 +0100
Message-ID: <20231205173252.62305-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BJkgwvXplodQTkKRLbAtdTM0yCZVkiXT
X-Proofpoint-GUID: BJkgwvXplodQTkKRLbAtdTM0yCZVkiXT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_12,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxlogscore=373 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312050139
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert pgste_get_lock() and pgste_set_unlock() to C.

There is no real reasons to keep them in assembler. Having them in C
makes them more readable and maintainable, and better instructions are
used automatically when available.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/mm/pgtable.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 3bd2ab2a9a34..6c4523aa4fdf 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -125,32 +125,23 @@ static inline pte_t ptep_flush_lazy(struct mm_struct *mm,
 
 static inline pgste_t pgste_get_lock(pte_t *ptep)
 {
-	unsigned long new = 0;
+	unsigned long value = 0;
 #ifdef CONFIG_PGSTE
-	unsigned long old;
-
-	asm(
-		"	lg	%0,%2\n"
-		"0:	lgr	%1,%0\n"
-		"	nihh	%0,0xff7f\n"	/* clear PCL bit in old */
-		"	oihh	%1,0x0080\n"	/* set PCL bit in new */
-		"	csg	%0,%1,%2\n"
-		"	jl	0b\n"
-		: "=&d" (old), "=&d" (new), "=Q" (ptep[PTRS_PER_PTE])
-		: "Q" (ptep[PTRS_PER_PTE]) : "cc", "memory");
+	unsigned long *ptr = (unsigned long *)(ptep + PTRS_PER_PTE);
+
+	do {
+		value = __atomic64_or_barrier(PGSTE_PCL_BIT, ptr);
+	} while (value & PGSTE_PCL_BIT);
+	value |= PGSTE_PCL_BIT;
 #endif
-	return __pgste(new);
+	return __pgste(value);
 }
 
 static inline void pgste_set_unlock(pte_t *ptep, pgste_t pgste)
 {
 #ifdef CONFIG_PGSTE
-	asm(
-		"	nihh	%1,0xff7f\n"	/* clear PCL bit */
-		"	stg	%1,%0\n"
-		: "=Q" (ptep[PTRS_PER_PTE])
-		: "d" (pgste_val(pgste)), "Q" (ptep[PTRS_PER_PTE])
-		: "cc", "memory");
+	barrier();
+	WRITE_ONCE(*(unsigned long *)(ptep + PTRS_PER_PTE), pgste_val(pgste) & ~PGSTE_PCL_BIT);
 #endif
 }
 
-- 
2.43.0


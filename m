Return-Path: <linux-kernel+bounces-159963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9528B36DB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3E8284218
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E20145B24;
	Fri, 26 Apr 2024 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZzyZ5UGX"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E8614534B;
	Fri, 26 Apr 2024 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714133097; cv=none; b=LSfgOqiKPQWxrnICScmWjIPSfbUKs1vVgB96fnVb3NvGc4sCwiUhV9X+b5LHT+VnV7fh2uycczyAbR5a28b6+qt/D47PFMa2vLKsqFYvtmaKdRyXXuIQiYVr+0Mf7hLJPRdG/eslKzdlnbSLm6P6pgVChBLiaZEs3Wla+/kywDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714133097; c=relaxed/simple;
	bh=pUFowI5Uew0Bfbxd/9zcBIXUhLvC5pUTztv9cOZmLvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgphI0Js2OlJwy6vhn2M6K2mJVI7ZPEeaOgPmco0X0LqXSnPLeZzzTyi1lzzGGTqV0ztaxFmcknsfgPSIlFydUi8Rh/eQCFZF2GoJPtnS3bymmzFH/bzde78h/fbfX2zeTrBwJa8BBqU0EC5Y9apuPUbyiBw8mNY/ynqc0xbrjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZzyZ5UGX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43QC2VkU017882;
	Fri, 26 Apr 2024 12:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HsCoHq+/7P37NBOty4qKIsb4+uubEDWshiCoE+9VXQ8=;
 b=ZzyZ5UGX9TWhi7Zr+DjMOWjQNxbzFu21v+LbWse/Zx8unMDJHxqi+X5dGKPRg20+PT2X
 /tmuNB/aqpklrvKpweRvwk2rzp9kOewwpipc5u1MBvTgBLQ+xKu7B1IFi14P1d4REoOs
 BKGWjdG/W/DhH09dk9C8sKDoEbz0VC5aliHoRrWVwez4swlSAj+sRQ4PMQzqTQVA3nwm
 mczAnb4Wg/xyuEmRMLV5dE06o98p1yQby5sqQpgE/5PIJp6fdKJxfykYke5hOc0bm9sp
 +nqz950KYfa+AgvqIsW33gdZdSBrsSGqRwVbzoKgSdfpWjBBycQlloGIdkgGDObO5zUi 8Q== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrbwur05r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 12:04:54 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q9HZvt023043;
	Fri, 26 Apr 2024 12:04:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xms1pfk0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 12:04:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43QC4mAI42664202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 12:04:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E34420040;
	Fri, 26 Apr 2024 12:04:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1FAC2004E;
	Fri, 26 Apr 2024 12:04:47 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Apr 2024 12:04:47 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [PATCH v3 1/2] s390/pgtable: switch read and write softbits for puds
Date: Fri, 26 Apr 2024 14:04:46 +0200
Message-ID: <20240426120447.34318-2-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: oKiIt-XjgVYJOo6NdHqL_rY1gwSTKxLR
X-Proofpoint-ORIG-GUID: oKiIt-XjgVYJOo6NdHqL_rY1gwSTKxLR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=660 suspectscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260080

There is no reason for the read and write softbits to be swapped in the
puds compared to pmds. They are different only because the softbits for
puds were introduced at the same time when the softbits for pmds were
swapped.

The current implementation is not wrong per se, since the macros are
defined correctly; only the documentation does not reflect reality.

With this patch, the read and write softbits for large pmd and large
puds will have the same layout, and will match the existing
documentation.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 60950e7a25f5..3da2995fd196 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -266,8 +266,8 @@ static inline int is_module_addr(void *addr)
 #define _REGION3_ENTRY_DIRTY	0x2000	/* SW region dirty bit */
 #define _REGION3_ENTRY_YOUNG	0x1000	/* SW region young bit */
 #define _REGION3_ENTRY_LARGE	0x0400	/* RTTE-format control, large page  */
-#define _REGION3_ENTRY_READ	0x0002	/* SW region read bit */
-#define _REGION3_ENTRY_WRITE	0x0001	/* SW region write bit */
+#define _REGION3_ENTRY_WRITE	0x0002	/* SW region write bit */
+#define _REGION3_ENTRY_READ	0x0001	/* SW region read bit */
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
 #define _REGION3_ENTRY_SOFT_DIRTY 0x4000 /* SW region soft dirty bit */
-- 
2.44.0



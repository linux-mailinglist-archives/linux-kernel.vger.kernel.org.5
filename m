Return-Path: <linux-kernel+bounces-158568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 012628B2232
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678E91F253B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83834149C56;
	Thu, 25 Apr 2024 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CvPC1bQQ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4771494DB;
	Thu, 25 Apr 2024 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050373; cv=none; b=qHtyEMS6gm3R/a0AvsSjgi0xV41WFtdXfjmhDK4zhF9QDD8c2eNqfg681xEgODm0WrQeNr6LZ7fSJbph7ZFwurIR7MlFcD04i32BZ+/af/aBk5uKLdXPukERb4wap3qTikq3CzqBivHg4GPu9GdWHOSYOOK3CSJm2AbKTrstFsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050373; c=relaxed/simple;
	bh=r5eIBaaMhae73DJWS3RNUzKHwgxGkcwRmS6S6nLmHyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIL6xIMVPgjTgBiTCh5Q3B5RXAHQpdHLI5DvtleVYx+bY6PAFOGO/92n+Gw1LvTzTC/v/jXU5lTyeoIchPGTrLq/EhjkM3K7Juz8rxQLXbo8RthCqL0gjIyhn1BAuBTKJn2cDYl9Yyj7HVBFKtfAU4rS9BWhRwhdRsVpExE/DEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CvPC1bQQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PCvs2T023569;
	Thu, 25 Apr 2024 13:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IKHd4OBHw55uxepZCbnzDOP3+YjpSZ9rZrKd2kj33ks=;
 b=CvPC1bQQkqvN5Pc19PurvhycX97HyLj7Hnxel524nMlEeRaCZ3ZGSi26qehukivdJeFi
 uGLEz2r55zfZyv/b6jWQ414L2Dzp+G30FSDdG2eiBt1BoqJZ04vjBz8/ZoMXhfYmmYbN
 9tK8BhBVYc8NsjJNYtiWgnoaYsNS7y+HUWil6En5vHVKnGs5hpBCyFAgixgS3+Mg77UG
 53pEQBmK17szz0F9pEImNo7O9uVDZ9XfCpoPoNLu0+RmS7DX8U5BitZZb+MnLagSlAg5
 1NNIGtxhh4YjQZJ8qNaJ421ijGfMZ42cNlOqYTUYt4bolVUOoPPt7X6X14R4si6a9KRs aw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqqmu80ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 13:06:10 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43PAqnep020920;
	Thu, 25 Apr 2024 13:06:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmre09ym1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 13:06:09 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43PD63Dn41353684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 13:06:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B5F22004D;
	Thu, 25 Apr 2024 13:06:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 851F02004B;
	Thu, 25 Apr 2024 13:06:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.50.16])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Apr 2024 13:06:02 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [PATCH v1 1/2] s390/pgtable: switch read and write softbits for puds
Date: Thu, 25 Apr 2024 15:05:54 +0200
Message-ID: <20240425130555.73132-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425130555.73132-1-imbrenda@linux.ibm.com>
References: <20240425130555.73132-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LAftu0HYrzyWLfydXxc_MOQomk8Tav0h
X-Proofpoint-ORIG-GUID: LAftu0HYrzyWLfydXxc_MOQomk8Tav0h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_13,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 mlxlogscore=687 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250095

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



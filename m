Return-Path: <linux-kernel+bounces-146718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A518A69D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300C81C210BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468AA129E70;
	Tue, 16 Apr 2024 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DOyuMTCa"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22E71292F9;
	Tue, 16 Apr 2024 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267751; cv=none; b=gXJSgiDqkEFqGyLHbCKGoyYvPPU2VtPWzM5biqK0vB8Ztm8aj1cGwQHB0ZbN22vugDB9/qBGNZfXCRxyNnc9DtOtLXDMRJgy1RpCv2O/xmBEmOYvtjQymohL2d5rTy3UzWp32ZxTPe9pjt54m4GYJJHlLSbRYRifRg4vDAqTVwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267751; c=relaxed/simple;
	bh=GY8azhWTTIbSChM3ls4UcusD1MBHbKtXYmQjovgHkPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMAHd0BA1lCYiL/kPrbGqob9+r3txez53+YV1bZJBKxP0oY6NcMULsvsSDyGACLd9gj6UWs6C61g3QQtq+ncQ0O8A1OX7y9Y44Udf0gFz4+vnBmT1lFqcxlpF+WRRXOupfJcLscLePeR+JcnPkA7hRIJ2kyppPCNz6TqBDO4oq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DOyuMTCa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GATYaw001101;
	Tue, 16 Apr 2024 11:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=12kte0YV4pJElifMBgdQAsbLqUzJwS7BYU0HKUwijZk=;
 b=DOyuMTCaBmptzaKIUAc0fLFr3lhpnCJRYWhpTTR3D3+F/KEX77to9LVzjRS6iRwxaw8h
 CbzAl6d9zB5oIWlTozc74Y4oGN6wra3+KvCIAOpphkBroEitf/S3srJ98dWL3OQWb3on
 A57nA2tUvoxlbn4jaVSgr9c8VXvyvau6BilcRkEBPhI/DVyf7+lRjZ3qCBnFQT1OPKAo
 W9VFNzBCakegBmgTu9ohRmvWb9c1CBtw2rLltrN6hWPfD2kupFQAQT0YU3jC3xFYFehR
 sbaQLk/UsHLTl158X48Ek7+Bvll1VKJnk9xRDzD6uhM/nQtLEwGrUpYexgBSpdhd8hAF Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhqky046n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 11:42:27 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43GBgQ1C009358;
	Tue, 16 Apr 2024 11:42:26 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhqky046k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 11:42:26 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43GBVmHZ018222;
	Tue, 16 Apr 2024 11:42:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg4ct61wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 11:42:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43GBgKf055378186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 11:42:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7A742004B;
	Tue, 16 Apr 2024 11:42:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A8892004D;
	Tue, 16 Apr 2024 11:42:20 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Apr 2024 11:42:20 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, frankja@linux.ibm.com, nrb@linux.ibm.com,
        nsg@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, david@redhat.com
Subject: [PATCH v1 2/2] s390/mm: fix clearing storage keys for huge pages
Date: Tue, 16 Apr 2024 13:42:20 +0200
Message-ID: <20240416114220.28489-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416114220.28489-1-imbrenda@linux.ibm.com>
References: <20240416114220.28489-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oQpE0fQIwnxE4EDtpAqRVi_X0CG23LZH
X-Proofpoint-ORIG-GUID: Y31KQI-gAlbdeS3w9tBDaN_iekTo93tD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404160072

The function __storage_key_init_range() expects the end address to be
the first byte outside the range to be initialized. I.e. end - start
should be the size of the area to be initialized.

The current code works because __storage_key_init_range() will still loop
over every page in the range, but it is slower than using sske_frame().

Fixes: 3afdfca69870 ("s390/mm: Clear skeys for newly mapped huge guest pmds")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index c2e8242bd15d..dc3db86e13ff 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -139,7 +139,7 @@ static void clear_huge_pte_skeys(struct mm_struct *mm, unsigned long rste)
 	}
 
 	if (!test_and_set_bit(PG_arch_1, &page->flags))
-		__storage_key_init_range(paddr, paddr + size - 1);
+		__storage_key_init_range(paddr, paddr + size);
 }
 
 void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-- 
2.44.0



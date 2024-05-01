Return-Path: <linux-kernel+bounces-165865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 253A68B92A4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565861C21326
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D3A2F2A;
	Thu,  2 May 2024 00:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cOAW+aeJ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94078367
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 00:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714608181; cv=none; b=clg/EqL80F6CXygt56XDxrcEcpB+JMjdUNyWO4gO5llOapSnmG2yxPHZ0dmUe7FDpTSF+6O6Na12z7MeIdFUU6N744ZI+7gRildI1CFH3TC8DEnDeru6EglEuLtMR+O+u4+vMJ5YJbvv2hFaq4igVMh6HwEkejnOSS1dRWOJkk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714608181; c=relaxed/simple;
	bh=MQnQdiNVTwTDDyeL4S/RcdxCDIpsfhbfXDclL6IJ44s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dW904ToCNzMLe09fowcY4AoKEVc2rKRaX/khsAbW3QnWLtX90PZ9YIKPb/nHJ6Ibk4UM45xQxuiCBu+zfbdzXlphBXM101jDPolWLyaB7i88ZRaiIO3jw0i9QiAoL4gt6vK2J/sq0aXzoCDWcaB8bUpgFKrnsb3uuWKp58rFuAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cOAW+aeJ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441NKAPw010464;
	Thu, 2 May 2024 00:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=iBNgjATm1g/dvs/mF70E3zaHDPEr1jQSRo6dBQGN4Yc=;
 b=cOAW+aeJW6MGxJkg049vVzz2Zzrb8XnTgk5GVZgHLiP74GRfVHXxw7mt9e2OxPnwPT8R
 t3+s32yTrY/ROVhL2IlZ1BJixpwJMqTOJhPM2JSztBbn2Sq16rfeuex6hKuxwpNHlsK8
 1SC4qfcynTe3dxcCdxXZOmlwnvGwixyZdzlITCGCTuholKSh1CQP6x6cAUO6j8vYpNee
 P5BU2EzhcktlZAo6gYwGm9bGcwpcMl9JbDSh/kLwk1ePIgpiMWlXygpHMp/LcAjs8GL6
 uq++DN7DScLxq5wM5tN4bqMK6X1YvKjOvm5L10vZbUZWZUPh8zN4QGvrk9zRU4+JcoWt dQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdetpj7-261
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 00:02:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 441MBS4E033172;
	Wed, 1 May 2024 23:25:12 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xrqt9vbuq-4;
	Wed, 01 May 2024 23:25:12 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm/memory-failure: send SIGBUS in the event of thp split fail
Date: Wed,  1 May 2024 17:24:58 -0600
Message-Id: <20240501232458.3919593-4-jane.chu@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240501232458.3919593-1-jane.chu@oracle.com>
References: <20240501232458.3919593-1-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405010165
X-Proofpoint-GUID: ovlQb9iG_YSm1K2_mAapQrq0LojExnvH
X-Proofpoint-ORIG-GUID: ovlQb9iG_YSm1K2_mAapQrq0LojExnvH

When handle hwpoison in a GUP longterm pin'ed thp page,
try_to_split_thp_page() will fail. And at this point, there is little else
the kernel could do except sending a SIGBUS to the user process, thus
give it a chance to recover.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 mm/memory-failure.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7fcf182abb96..67f4d24a98e7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2168,6 +2168,37 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	return rc;
 }
 
+/*
+ * The calling condition is as such: thp split failed, page might have
+ * been GUP longterm pinned, not much can be done for recovery.
+ * But a SIGBUS should be delivered with vaddr provided so that the user
+ * application has a chance to recover. Also, application processes'
+ * election for MCE early killed will be honored.
+ */
+static int kill_procs_now(struct page *p, unsigned long pfn, int flags,
+			struct page *hpage)
+{
+	struct folio *folio = page_folio(hpage);
+	LIST_HEAD(tokill);
+	int res = -EHWPOISON;
+
+	/* deal with user pages only */
+	if (PageReserved(p) || PageSlab(p) || PageTable(p) || PageOffline(p))
+		res = -EBUSY;
+	if (!(PageLRU(hpage) || PageHuge(p)))
+		res = -EBUSY;
+
+	if (res == -EHWPOISON) {
+		collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
+		kill_procs(&tokill, true, pfn, flags);
+	}
+
+	if (flags & MF_COUNT_INCREASED)
+		put_page(p);
+
+	return res;
+}
+
 /**
  * memory_failure - Handle memory failure of a page.
  * @pfn: Page Number of the corrupted page
@@ -2297,6 +2328,11 @@ int memory_failure(unsigned long pfn, int flags)
 		 */
 		SetPageHasHWPoisoned(hpage);
 		if (try_to_split_thp_page(p) < 0) {
+			if (flags & MF_ACTION_REQUIRED) {
+				pr_err("%#lx: thp split failed\n", pfn);
+				res = kill_procs_now(p, pfn, flags, hpage);
+				goto unlock_mutex;
+			}
 			res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
 			goto unlock_mutex;
 		}
-- 
2.39.3



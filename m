Return-Path: <linux-kernel+bounces-153819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B10438AD3B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5069A1F219AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F14154433;
	Mon, 22 Apr 2024 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LOBzOifv"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922B2153BC6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713809551; cv=none; b=FCJbeCKzse5XbLf/o4uPKZ4CnezUo6MvZpxF8SIcnG5a+/7eO6ImDOew2U99yf88cBvtE9BqUTzy87QeFiiybc2oX18sD+1eUCh7ffCX75DvIL9Gk2EfOCO6jIwrVXQ4SZXTxedngnVqfbLR2hE3LdAj7oZ7WxZz8WY9yE2oGcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713809551; c=relaxed/simple;
	bh=BX/CX5XLOQ7qLBjg4NryO5+WrBzTpVcRIi7GaHqSMLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTBEesdN1nv9+CGordW48w2CJt61h//ffOsSGkAT9+skWdxFkoDpIOHLTSs72SKPYuVD72gHsCB1fpjmqPKObjHU/eb1y2+dJkeHlrbkZFyMAU+1QXeH9HmCLQ6UUzAhGp2FusttRVlga+4yGrT4QoCuekVzQPK69BRjgu3EquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LOBzOifv; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MHmkbB017430;
	Mon, 22 Apr 2024 18:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=h2aJVJArUJppOuNUB8MhAiy4kIo6wvRJzEmWmrN+uiw=;
 b=LOBzOifvSAOoTq37KKqiDF2zhcN9iBBTXvRPcM4xnr5CbIZ0xBn9ZKiTlwwGhahUl3PZ
 jiljWwQBoklLhkU2sPjd32TnVNqwx+75VxvR0dAmtUON4wxGmuI5B+jyHGOHeOrEOkFa
 G9ZTobbQ+mChfY1QUdtUdq/0tiYiVQhj4ZL0a4PqM37SmPXXqfnXfhEFzhZhxogm9Gke
 tNRk5A1BxF0KdC9YaoI/Z98rTsajp5mtx9a906HKebDXEpALzOyrX/UBK4XaQ+aAAiiq
 cRazZFHcVdonbotEm+DPr72ZfpyDVsWPKILz31rN3ls8KCba+UlOPtgZG5TCGIx+TG8Q /g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4bcaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 18:12:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MGdmcF010840;
	Mon, 22 Apr 2024 18:12:17 GMT
Received: from jfwang-mac.us.oracle.com (dhcp-10-65-139-207.vpn.oracle.com [10.65.139.207])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xm456e85c-1;
	Mon, 22 Apr 2024 18:12:17 +0000
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, willy@infradead.org
Subject: [PATCH] mm: huge_memory: convert __do_huge_pmd_anonymous_page() to use folios
Date: Mon, 22 Apr 2024 11:12:16 -0700
Message-ID: <20240422181216.91938-1-jianfeng.w.wang@oracle.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_13,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220076
X-Proofpoint-GUID: NHWZ67OHThxTLmE0aMPA4vFcqYmuu8KF
X-Proofpoint-ORIG-GUID: NHWZ67OHThxTLmE0aMPA4vFcqYmuu8KF

Change __do_huge_pmd_anonymous_page() to take folio as input, as its
caller has used folio. Save one unnecessary call to compound_head().

Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
---
 mm/huge_memory.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 89f58c7603b2..83566ee738e0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -866,10 +866,9 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
 
 static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
-			struct page *page, gfp_t gfp)
+			struct folio *folio, gfp_t gfp)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct folio *folio = page_folio(page);
 	pgtable_t pgtable;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	vm_fault_t ret = 0;
@@ -890,7 +889,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		goto release;
 	}
 
-	clear_huge_page(page, vmf->address, HPAGE_PMD_NR);
+	clear_huge_page(&folio->page, vmf->address, HPAGE_PMD_NR);
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
 	 * clear_huge_page writes become visible before the set_pmd_at()
@@ -918,7 +917,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 			return ret;
 		}
 
-		entry = mk_huge_pmd(page, vma->vm_page_prot);
+		entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 		folio_add_new_anon_rmap(folio, vma, haddr);
 		folio_add_lru_vma(folio, vma);
@@ -1051,7 +1050,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 		count_vm_event(THP_FAULT_FALLBACK);
 		return VM_FAULT_FALLBACK;
 	}
-	return __do_huge_pmd_anonymous_page(vmf, &folio->page, gfp);
+	return __do_huge_pmd_anonymous_page(vmf, folio, gfp);
 }
 
 static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
-- 
2.42.1



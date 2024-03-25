Return-Path: <linux-kernel+bounces-117249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576ED88B0F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DB1B62116
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C476156991;
	Mon, 25 Mar 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ICQD+4QZ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86CE84D24
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376718; cv=none; b=HcYWfUv6X/WNTjVcK4AfDWLJbn2MKRi5QpDmQBmnAPdI6m3/FubTHjiU86vPaP0Nl1GiHl/MTtYAJC9vdyxK7Kdv8JvKr4X5OyVLsS8MYeXs2jqYQDrFoAnHxPYjrxMRYORcigoQ5y3NnADc9QAZRnkDLR93PTQ5N9v2fs7YzeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376718; c=relaxed/simple;
	bh=NOkC6fuBFDVAMCdenIh+0pTGLiSZTt1fM8G7LmfdZa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L5OIwH178x4zdxFwzsYlriyJBmiXgLOX/SnEiUxjPLjoLoBhsaKy6MXVGB1OlOJWCwd4zPOhAgG0aJQSHwmmw0Xd6opqJuBdu/gQGJTsuJhyfp0uF456ypF1vZ5esx6jmrhno+amWkpLBowuWZg9krIr18C09WzxRO8gtKGFiGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ICQD+4QZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PE0tST025924;
	Mon, 25 Mar 2024 14:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GqNwmjjGnKkyJCZ+En/YSrGZg3Tm76YRIoUTja7BmQk=;
 b=ICQD+4QZLG2QCurmkwHRefcaTdSzHoG3ri2myLhz6svRKsYAMuB2IZGW4j5qiXWWUXts
 0RpUJCyNTfe3lkNY14yyUkypQWwvuAoH4qqVjB7BcSb3gGFh1wE5lg9Lt0T6Mcmenzql
 cOF2lnV+YHHhF2joRjyNBnlZ4faAV1M9WgBc06785Bj88YjlCmZ1iQeVMhUTk2ulHXno
 lwsqjKzOfF6wbRuuV8SuEdcXgFUpQWJyTfLk73W+QKDLAQN2qZlj+4voEh+ai0TNVcTH
 yDrMNNz11Wk7nAYvH08+eoFy9h5udsi43N/N6OIKD9ICKUM5P6YMBkKTaKu0q9XOmQoO yg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x2hh6afgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 14:24:41 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42PEOeu2030098;
	Mon, 25 Mar 2024 14:24:40 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x2hh6afgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 14:24:40 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42PDKuBC003747;
	Mon, 25 Mar 2024 14:24:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2c42h4wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 14:24:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42PEOZgO50725358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 14:24:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DE6620043;
	Mon, 25 Mar 2024 14:24:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 680DF20040;
	Mon, 25 Mar 2024 14:24:32 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.53.171.174])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Mar 2024 14:24:32 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: Aneesh Kumar <aneesh.kumar@kernel.org>, Huang Ying <ying.huang@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Feng Tang <feng.tang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Donet Tom <donettom@linux.ibm.com>
Subject: [PATCH v4 1/2] mm/mempolicy: Use numa_node_id() instead of cpu_to_node()
Date: Mon, 25 Mar 2024 09:24:13 -0500
Message-Id: <6059f034f436734b472d066db69676fb3a459864.1711373653.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1711373653.git.donettom@linux.ibm.com>
References: <cover.1711373653.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eZ1kfnPOcT21x235Sc4nZQRmPuVRVe-Y
X-Proofpoint-GUID: E-M-IsOKD4XnmgEQptei3myaR1cTef3R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_09,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=861 spamscore=0
 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250079

Instead of using 'cpu_to_node()', we use 'numa_node_id()', which
is quicker. smp_processor_id is guaranteed to be stable in the
'mpol_misplaced()' function because it is called with ptl held.
lockdep_assert_held was added to ensure that.

No functional change in this patch.

Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 include/linux/mempolicy.h |  5 +++--
 mm/huge_memory.c          |  2 +-
 mm/internal.h             |  2 +-
 mm/memory.c               |  8 +++++---
 mm/mempolicy.c            | 14 ++++++++++----
 5 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 931b118336f4..1add16f21612 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -167,7 +167,8 @@ extern void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol);
 /* Check if a vma is migratable */
 extern bool vma_migratable(struct vm_area_struct *vma);
 
-int mpol_misplaced(struct folio *, struct vm_area_struct *, unsigned long);
+int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
+					unsigned long addr);
 extern void mpol_put_task_policy(struct task_struct *);
 
 static inline bool mpol_is_preferred_many(struct mempolicy *pol)
@@ -282,7 +283,7 @@ static inline int mpol_parse_str(char *str, struct mempolicy **mpol)
 #endif
 
 static inline int mpol_misplaced(struct folio *folio,
-				 struct vm_area_struct *vma,
+				 struct vm_fault *vmf,
 				 unsigned long address)
 {
 	return -1; /* no node preference */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9859aa4f7553..b40bd9f3ead5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1754,7 +1754,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	 */
 	if (node_is_toptier(nid))
 		last_cpupid = folio_last_cpupid(folio);
-	target_nid = numa_migrate_prep(folio, vma, haddr, nid, &flags);
+	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
 	if (target_nid == NUMA_NO_NODE) {
 		folio_put(folio);
 		goto out_map;
diff --git a/mm/internal.h b/mm/internal.h
index 7e486f2c502c..e0001c681c56 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1088,7 +1088,7 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
 
 void __vunmap_range_noflush(unsigned long start, unsigned long end);
 
-int numa_migrate_prep(struct folio *folio, struct vm_area_struct *vma,
+int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
 		      unsigned long addr, int page_nid, int *flags);
 
 void free_zone_device_page(struct page *page);
diff --git a/mm/memory.c b/mm/memory.c
index f2bc6dd15eb8..29e240978f45 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5033,9 +5033,11 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-int numa_migrate_prep(struct folio *folio, struct vm_area_struct *vma,
+int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
 		      unsigned long addr, int page_nid, int *flags)
 {
+	struct vm_area_struct *vma = vmf->vma;
+
 	folio_get(folio);
 
 	/* Record the current PID acceesing VMA */
@@ -5047,7 +5049,7 @@ int numa_migrate_prep(struct folio *folio, struct vm_area_struct *vma,
 		*flags |= TNF_FAULT_LOCAL;
 	}
 
-	return mpol_misplaced(folio, vma, addr);
+	return mpol_misplaced(folio, vmf, addr);
 }
 
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
@@ -5121,7 +5123,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		last_cpupid = (-1 & LAST_CPUPID_MASK);
 	else
 		last_cpupid = folio_last_cpupid(folio);
-	target_nid = numa_migrate_prep(folio, vma, vmf->address, nid, &flags);
+	target_nid = numa_migrate_prep(folio, vmf, vmf->address, nid, &flags);
 	if (target_nid == NUMA_NO_NODE) {
 		folio_put(folio);
 		goto out_map;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0fe77738d971..aa48376e2d34 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2718,7 +2718,7 @@ static void sp_free(struct sp_node *n)
  * mpol_misplaced - check whether current folio node is valid in policy
  *
  * @folio: folio to be checked
- * @vma: vm area where folio mapped
+ * @vmf: structure describing the fault
  * @addr: virtual address in @vma for shared policy lookup and interleave policy
  *
  * Lookup current policy node id for vma,addr and "compare to" folio's
@@ -2728,18 +2728,24 @@ static void sp_free(struct sp_node *n)
  * Return: NUMA_NO_NODE if the page is in a node that is valid for this
  * policy, or a suitable node ID to allocate a replacement folio from.
  */
-int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
+int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
 		   unsigned long addr)
 {
 	struct mempolicy *pol;
 	pgoff_t ilx;
 	struct zoneref *z;
 	int curnid = folio_nid(folio);
+	struct vm_area_struct *vma = vmf->vma;
 	int thiscpu = raw_smp_processor_id();
-	int thisnid = cpu_to_node(thiscpu);
+	int thisnid = numa_node_id();
 	int polnid = NUMA_NO_NODE;
 	int ret = NUMA_NO_NODE;
 
+	/*
+	 * Make sure ptl is held so that we don't preempt and we
+	 * have a stable smp processor id
+	 */
+	lockdep_assert_held(vmf->ptl);
 	pol = get_vma_policy(vma, addr, folio_order(folio), &ilx);
 	if (!(pol->flags & MPOL_F_MOF))
 		goto out;
@@ -2781,7 +2787,7 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
 		if (node_isset(curnid, pol->nodes))
 			goto out;
 		z = first_zones_zonelist(
-				node_zonelist(numa_node_id(), GFP_HIGHUSER),
+				node_zonelist(thisnid, GFP_HIGHUSER),
 				gfp_zone(GFP_HIGHUSER),
 				&pol->nodes);
 		polnid = zone_to_nid(z->zone);
-- 
2.39.3



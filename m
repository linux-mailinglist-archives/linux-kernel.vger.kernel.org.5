Return-Path: <linux-kernel+bounces-97220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637E787672B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C471C2184A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13351DDF5;
	Fri,  8 Mar 2024 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M5uhEC5u"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583481D54D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911025; cv=none; b=VO7Q778eTWcTNQG4Nuikm47mcwitfaV4eAuGDsidi+ImJLArBr3YgQQVkSQTMhmmFQIzjtF/mIWxzRHLAN43OfBQ/zu6wcqNdVtaBoGL3wQ19FMR6earhGlOgjprbmA+LMKz98GKcHbd9KG7o6pmO5N8jSpCENJwVJPgWPiXziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911025; c=relaxed/simple;
	bh=i46mWTUPmsls5AqdeU81Fh2yDrBBdW1Qnq9rKANiCmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ktQD/vfZJni8KINKesSupnIydyGQskeQ5C9alF83NuCBq28Q42KHoCZz/Jg0wZxAKfBswJOuv0bK15fKXAVVEVagwCkzsE/Ej/4qRKvCAGkiWphRkmmGo542nNwBHxkf3L8e2mZ9Du0iCyIqNx/v6Vw5QM+aM4c7BYU6qJljbb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M5uhEC5u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428F1wLv032748;
	Fri, 8 Mar 2024 15:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nlqWPtM5+DbIaChmmWJ9jy3Ip4vFxPNuZPDBM45ynrI=;
 b=M5uhEC5uly1aj+/t0SibrVysHyUB5V3MH4tcj2D/jtHacxCYj4udL/Nzns77hV1n8tXC
 b4RsevVCczfUrb69NQ91nyaUT/4U5GIOyH2YGhctwGSXvLfL+9YzXz7/SCYgukTS0P/E
 DcvedO/oCL2oQirceBAVWHerhvvKeOMYqhUjGQOpCJ70AKQ5gFQ2UzhlVU/F814JDdHH
 fv1JBl00ezSyGd/fy53/w+FbW5zRn6iGJ8nP1hcVtW5AiA3NE7wdRVZ/i5DqpXCj2x5u
 lAGKg22ZDy2aiv3Jhzx54HOv6pSDC5lxLqUcyx9+MuopudSA2XRqjKEtz2k96qDdPQGu dw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr4y788ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 15:16:34 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428F3ESG005308;
	Fri, 8 Mar 2024 15:16:34 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr4y788f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 15:16:34 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 428E1WWS006077;
	Fri, 8 Mar 2024 15:16:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmeetncjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 15:16:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 428FGTX427853246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 15:16:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35ACC2004F;
	Fri,  8 Mar 2024 15:16:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FB952004E;
	Fri,  8 Mar 2024 15:16:26 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.53.171.174])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Mar 2024 15:16:26 +0000 (GMT)
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
Subject: [PATCH v2 1/2] mm/mempolicy: Use numa_node_id() instead of cpu_to_node()
Date: Fri,  8 Mar 2024 09:15:37 -0600
Message-Id: <744646531af02cc687cde8ae788fb1779e99d02c.1709909210.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1709909210.git.donettom@linux.ibm.com>
References: <cover.1709909210.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gqq7bvBqapxNbYosgNU363AECOXd4lLJ
X-Proofpoint-ORIG-GUID: DWdelyt722JB92dQEikvrgbgtsRFaeD7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080123

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
 mm/mempolicy.c            | 12 +++++++++---
 5 files changed, 19 insertions(+), 10 deletions(-)

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
index 94c958f7ebb5..7f944e0c4571 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1752,7 +1752,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	 */
 	if (node_is_toptier(nid))
 		last_cpupid = folio_last_cpupid(folio);
-	target_nid = numa_migrate_prep(folio, vma, haddr, nid, &flags);
+	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
 	if (target_nid == NUMA_NO_NODE) {
 		folio_put(folio);
 		goto out_map;
diff --git a/mm/internal.h b/mm/internal.h
index f309a010d50f..ae175be9165e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -992,7 +992,7 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
 
 void __vunmap_range_noflush(unsigned long start, unsigned long end);
 
-int numa_migrate_prep(struct folio *folio, struct vm_area_struct *vma,
+int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
 		      unsigned long addr, int page_nid, int *flags);
 
 void free_zone_device_page(struct page *page);
diff --git a/mm/memory.c b/mm/memory.c
index 0bfc8b007c01..4e258a8564ca 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4899,9 +4899,11 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
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
@@ -4913,7 +4915,7 @@ int numa_migrate_prep(struct folio *folio, struct vm_area_struct *vma,
 		*flags |= TNF_FAULT_LOCAL;
 	}
 
-	return mpol_misplaced(folio, vma, addr);
+	return mpol_misplaced(folio, vmf, addr);
 }
 
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
@@ -4987,7 +4989,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		last_cpupid = (-1 & LAST_CPUPID_MASK);
 	else
 		last_cpupid = folio_last_cpupid(folio);
-	target_nid = numa_migrate_prep(folio, vma, vmf->address, nid, &flags);
+	target_nid = numa_migrate_prep(folio, vmf, vmf->address, nid, &flags);
 	if (target_nid == NUMA_NO_NODE) {
 		folio_put(folio);
 		goto out_map;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590ee1c89..e635d7ed501b 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2477,18 +2477,24 @@ static void sp_free(struct sp_node *n)
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
@@ -2526,7 +2532,7 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
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



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47817F9B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjK0IUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjK0IUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:20:36 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC1D13A;
        Mon, 27 Nov 2023 00:20:41 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR6eVf8012378;
        Mon, 27 Nov 2023 08:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Dt1YW0vf+McTaKErPl0iHdB6D5PuLO6sey3WZMfMbwU=;
 b=D5zhwATM5FQk8ExwcFcZauvIjWPmW6+nd+ysSkGlHlmnsa0V0mChFAHsi7LefOP/rrvw
 GRbbzdFt5iND2vEAWRygKrtG4SGrYIEACy5bAMGQv3dkd4y5dXAUAQdu4ofOV2OGhhXe
 X+mD5ziXjgsQL7H3zBycp6N0m1B0hBxHvmLmLpY+S1N/SO0sbIS63Z7suXTcs+d+TeHw
 zD7KMu34FczFmw72u5vdeCRMUf4Kaqft13XQRPdOk4YMEa4oO0QP5Ccmfz95k8FNnP88
 pyxSWFYp8UuVc1FEm776hZ2l5pMh06L1Ir+bC2oHL8/Z3dBzsGsVLB9tkvqpQ32UF36+ OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umgdm92pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 08:20:31 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AR7eNM7024018;
        Mon, 27 Nov 2023 08:20:30 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umgdm92pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 08:20:30 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR8JEqq031057;
        Mon, 27 Nov 2023 08:20:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrk74uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 08:20:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AR8KQ9a15401636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 08:20:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E29720040;
        Mon, 27 Nov 2023 08:20:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E4C52004D;
        Mon, 27 Nov 2023 08:20:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 27 Nov 2023 08:20:26 +0000 (GMT)
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/5] s390/mm: allocate vmemmap pages from self-contained memory range
Date:   Mon, 27 Nov 2023 09:20:20 +0100
Message-Id: <20231127082023.2079810-3-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127082023.2079810-1-sumanthk@linux.ibm.com>
References: <20231127082023.2079810-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KtxFm25MBaTYDqNKZZk3HQ4ChmJLvFIz
X-Proofpoint-ORIG-GUID: pv7W0zo1agcow3G2CxMLeCUdjw03EyQ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_06,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=937 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate memory map (struct pages array) from the hotplugged memory
range, rather than using system memory. The change addresses the issue
where standby memory, when configured to be much larger than online
memory, could potentially lead to ipl failure due to memory map
allocation from online memory. For example, 16MB of memory map
allocation is needed for a memory block size of 1GB and when standby
memory is configured much larger than online memory, this could lead to
ipl failure.

To address this issue, the solution involves introducing "memmap on
memory" using the vmem_altmap structure on s390.  Architectures that
want to implement it should pass the altmap to the vmemmap_populate()
function and its associated callchain. This enhancement is discussed in
the commit 4b94ffdc4163 ("x86, mm: introduce vmem_altmap to augment
vmemmap_populate()").

Provide "memmap on memory" support for s390 by passing the altmap in
vmemmap_populate() and its callchain. The allocation path is described
as follows:
* When altmap is NULL in vmemmap_populate(), memory map allocation
  occurs using the existing vmemmap_alloc_block_buf().
* When altmap is not NULL in vmemmap_populate(), memory map allocation
  still uses vmemmap_alloc_block_buf(), but this function internally
  calls altmap_alloc_block_buf().

For deallocation, the process is outlined as follows:
* When altmap is NULL in vmemmap_free(), memory map deallocation happens
  through free_pages().
* When altmap is not NULL in vmemmap_free(), memory map deallocation
  occurs via vmem_altmap_free().

While memory map allocation is primarily handled through the
self-contained memory map range, there might still be a small amount of
system memory allocation required for vmemmap pagetables. To mitigate
this impact, this feature will be limited to machines with EDAT1
support.

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 arch/s390/mm/init.c |  3 ---
 arch/s390/mm/vmem.c | 62 +++++++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 43e612bc2bcd..8d9a60ccb777 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -281,9 +281,6 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	unsigned long size_pages = PFN_DOWN(size);
 	int rc;
 
-	if (WARN_ON_ONCE(params->altmap))
-		return -EINVAL;
-
 	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
 		return -EINVAL;
 
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 186a020857cf..eb100479f7be 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -33,8 +33,12 @@ static void __ref *vmem_alloc_pages(unsigned int order)
 	return memblock_alloc(size, size);
 }
 
-static void vmem_free_pages(unsigned long addr, int order)
+static void vmem_free_pages(unsigned long addr, int order, struct vmem_altmap *altmap)
 {
+	if (altmap) {
+		vmem_altmap_free(altmap, 1 << order);
+		return;
+	}
 	/* We don't expect boot memory to be removed ever. */
 	if (!slab_is_available() ||
 	    WARN_ON_ONCE(PageReserved(virt_to_page((void *)addr))))
@@ -156,7 +160,8 @@ static bool vmemmap_unuse_sub_pmd(unsigned long start, unsigned long end)
 
 /* __ref: we'll only call vmemmap_alloc_block() via vmemmap_populate() */
 static int __ref modify_pte_table(pmd_t *pmd, unsigned long addr,
-				  unsigned long end, bool add, bool direct)
+				  unsigned long end, bool add, bool direct,
+				  struct vmem_altmap *altmap)
 {
 	unsigned long prot, pages = 0;
 	int ret = -ENOMEM;
@@ -172,11 +177,11 @@ static int __ref modify_pte_table(pmd_t *pmd, unsigned long addr,
 			if (pte_none(*pte))
 				continue;
 			if (!direct)
-				vmem_free_pages((unsigned long) pfn_to_virt(pte_pfn(*pte)), 0);
+				vmem_free_pages((unsigned long)pfn_to_virt(pte_pfn(*pte)), get_order(PAGE_SIZE), altmap);
 			pte_clear(&init_mm, addr, pte);
 		} else if (pte_none(*pte)) {
 			if (!direct) {
-				void *new_page = vmemmap_alloc_block(PAGE_SIZE, NUMA_NO_NODE);
+				void *new_page = vmemmap_alloc_block_buf(PAGE_SIZE, NUMA_NO_NODE, altmap);
 
 				if (!new_page)
 					goto out;
@@ -213,7 +218,8 @@ static void try_free_pte_table(pmd_t *pmd, unsigned long start)
 
 /* __ref: we'll only call vmemmap_alloc_block() via vmemmap_populate() */
 static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
-				  unsigned long end, bool add, bool direct)
+				  unsigned long end, bool add, bool direct,
+				  struct vmem_altmap *altmap)
 {
 	unsigned long next, prot, pages = 0;
 	int ret = -ENOMEM;
@@ -234,11 +240,11 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 				if (IS_ALIGNED(addr, PMD_SIZE) &&
 				    IS_ALIGNED(next, PMD_SIZE)) {
 					if (!direct)
-						vmem_free_pages(pmd_deref(*pmd), get_order(PMD_SIZE));
+						vmem_free_pages(pmd_deref(*pmd), get_order(PMD_SIZE), altmap);
 					pmd_clear(pmd);
 					pages++;
 				} else if (!direct && vmemmap_unuse_sub_pmd(addr, next)) {
-					vmem_free_pages(pmd_deref(*pmd), get_order(PMD_SIZE));
+					vmem_free_pages(pmd_deref(*pmd), get_order(PMD_SIZE), altmap);
 					pmd_clear(pmd);
 				}
 				continue;
@@ -261,7 +267,7 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 				 * page tables since vmemmap_populate gets
 				 * called for each section separately.
 				 */
-				new_page = vmemmap_alloc_block(PMD_SIZE, NUMA_NO_NODE);
+				new_page = vmemmap_alloc_block_buf(PMD_SIZE, NUMA_NO_NODE, altmap);
 				if (new_page) {
 					set_pmd(pmd, __pmd(__pa(new_page) | prot));
 					if (!IS_ALIGNED(addr, PMD_SIZE) ||
@@ -280,7 +286,7 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 				vmemmap_use_sub_pmd(addr, next);
 			continue;
 		}
-		ret = modify_pte_table(pmd, addr, next, add, direct);
+		ret = modify_pte_table(pmd, addr, next, add, direct, altmap);
 		if (ret)
 			goto out;
 		if (!add)
@@ -302,12 +308,12 @@ static void try_free_pmd_table(pud_t *pud, unsigned long start)
 	for (i = 0; i < PTRS_PER_PMD; i++, pmd++)
 		if (!pmd_none(*pmd))
 			return;
-	vmem_free_pages(pud_deref(*pud), CRST_ALLOC_ORDER);
+	vmem_free_pages(pud_deref(*pud), CRST_ALLOC_ORDER, NULL);
 	pud_clear(pud);
 }
 
 static int modify_pud_table(p4d_t *p4d, unsigned long addr, unsigned long end,
-			    bool add, bool direct)
+			    bool add, bool direct, struct vmem_altmap *altmap)
 {
 	unsigned long next, prot, pages = 0;
 	int ret = -ENOMEM;
@@ -347,7 +353,7 @@ static int modify_pud_table(p4d_t *p4d, unsigned long addr, unsigned long end,
 		} else if (pud_large(*pud)) {
 			continue;
 		}
-		ret = modify_pmd_table(pud, addr, next, add, direct);
+		ret = modify_pmd_table(pud, addr, next, add, direct, altmap);
 		if (ret)
 			goto out;
 		if (!add)
@@ -370,12 +376,12 @@ static void try_free_pud_table(p4d_t *p4d, unsigned long start)
 		if (!pud_none(*pud))
 			return;
 	}
-	vmem_free_pages(p4d_deref(*p4d), CRST_ALLOC_ORDER);
+	vmem_free_pages(p4d_deref(*p4d), CRST_ALLOC_ORDER, NULL);
 	p4d_clear(p4d);
 }
 
 static int modify_p4d_table(pgd_t *pgd, unsigned long addr, unsigned long end,
-			    bool add, bool direct)
+			    bool add, bool direct, struct vmem_altmap *altmap)
 {
 	unsigned long next;
 	int ret = -ENOMEM;
@@ -394,7 +400,7 @@ static int modify_p4d_table(pgd_t *pgd, unsigned long addr, unsigned long end,
 				goto out;
 			p4d_populate(&init_mm, p4d, pud);
 		}
-		ret = modify_pud_table(p4d, addr, next, add, direct);
+		ret = modify_pud_table(p4d, addr, next, add, direct, altmap);
 		if (ret)
 			goto out;
 		if (!add)
@@ -415,12 +421,12 @@ static void try_free_p4d_table(pgd_t *pgd, unsigned long start)
 		if (!p4d_none(*p4d))
 			return;
 	}
-	vmem_free_pages(pgd_deref(*pgd), CRST_ALLOC_ORDER);
+	vmem_free_pages(pgd_deref(*pgd), CRST_ALLOC_ORDER, NULL);
 	pgd_clear(pgd);
 }
 
 static int modify_pagetable(unsigned long start, unsigned long end, bool add,
-			    bool direct)
+			    bool direct, struct vmem_altmap *altmap)
 {
 	unsigned long addr, next;
 	int ret = -ENOMEM;
@@ -445,7 +451,7 @@ static int modify_pagetable(unsigned long start, unsigned long end, bool add,
 				goto out;
 			pgd_populate(&init_mm, pgd, p4d);
 		}
-		ret = modify_p4d_table(pgd, addr, next, add, direct);
+		ret = modify_p4d_table(pgd, addr, next, add, direct, altmap);
 		if (ret)
 			goto out;
 		if (!add)
@@ -458,14 +464,16 @@ static int modify_pagetable(unsigned long start, unsigned long end, bool add,
 	return ret;
 }
 
-static int add_pagetable(unsigned long start, unsigned long end, bool direct)
+static int add_pagetable(unsigned long start, unsigned long end, bool direct,
+			 struct vmem_altmap *altmap)
 {
-	return modify_pagetable(start, end, true, direct);
+	return modify_pagetable(start, end, true, direct, altmap);
 }
 
-static int remove_pagetable(unsigned long start, unsigned long end, bool direct)
+static int remove_pagetable(unsigned long start, unsigned long end, bool direct,
+			    struct vmem_altmap *altmap)
 {
-	return modify_pagetable(start, end, false, direct);
+	return modify_pagetable(start, end, false, direct, altmap);
 }
 
 /*
@@ -474,7 +482,7 @@ static int remove_pagetable(unsigned long start, unsigned long end, bool direct)
 static int vmem_add_range(unsigned long start, unsigned long size)
 {
 	start = (unsigned long)__va(start);
-	return add_pagetable(start, start + size, true);
+	return add_pagetable(start, start + size, true, NULL);
 }
 
 /*
@@ -483,7 +491,7 @@ static int vmem_add_range(unsigned long start, unsigned long size)
 static void vmem_remove_range(unsigned long start, unsigned long size)
 {
 	start = (unsigned long)__va(start);
-	remove_pagetable(start, start + size, true);
+	remove_pagetable(start, start + size, true, NULL);
 }
 
 /*
@@ -496,9 +504,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 
 	mutex_lock(&vmem_mutex);
 	/* We don't care about the node, just use NUMA_NO_NODE on allocations */
-	ret = add_pagetable(start, end, false);
+	ret = add_pagetable(start, end, false, altmap);
 	if (ret)
-		remove_pagetable(start, end, false);
+		remove_pagetable(start, end, false, altmap);
 	mutex_unlock(&vmem_mutex);
 	return ret;
 }
@@ -509,7 +517,7 @@ void vmemmap_free(unsigned long start, unsigned long end,
 		  struct vmem_altmap *altmap)
 {
 	mutex_lock(&vmem_mutex);
-	remove_pagetable(start, end, false);
+	remove_pagetable(start, end, false, altmap);
 	mutex_unlock(&vmem_mutex);
 }
 
-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19817F9B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjK0IUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjK0IUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:20:35 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEA6186;
        Mon, 27 Nov 2023 00:20:40 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR8AV4H001140;
        Mon, 27 Nov 2023 08:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rjbWOV+O1ljevTy+J9147SeQ96fWv3aAURFylmdeCzc=;
 b=oUXWfoZkf7oKrzD/Wg5OhjctwoTnmPLGpjBkOVzpX/pTUJYyNRQzqr2vT8hUFG8PIl48
 3vsRvgp+r0nyrYq1ktoqxqp/kht9Q4EsWbDmvxxlbs5jZR9zBcSATZTsYzWW5Ybgv0/x
 POQH0oTo9A0NhQGApvhkgfzelrdBBw6GgGY4zBBokoLegYqRANlhz83bajGbbIeI5hds
 0sB0JRLvdksU7RAhgxOBNYJ+ZyUtfqh+dt+IZmWyQBdHALsUTYxK659VhFXwaMlDqvdu
 LV1BDgcSMOWzoJqmW76beP4k9sqpFmzmKHmWKepPOcSVxnFC0MVHOCwZ/sVOrp0DflEy 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umgdj8pqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 08:20:31 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AR7b3RY003560;
        Mon, 27 Nov 2023 08:20:30 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umgdj8pqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 08:20:30 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR8JQph015209;
        Mon, 27 Nov 2023 08:20:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukumy7erm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 08:20:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AR8KQTL15401632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 08:20:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23B4D20043;
        Mon, 27 Nov 2023 08:20:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6FED2004B;
        Mon, 27 Nov 2023 08:20:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 27 Nov 2023 08:20:25 +0000 (GMT)
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
Subject: [PATCH v3 1/5] mm/memory_hotplug: introduce MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
Date:   Mon, 27 Nov 2023 09:20:19 +0100
Message-Id: <20231127082023.2079810-2-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127082023.2079810-1-sumanthk@linux.ibm.com>
References: <20231127082023.2079810-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zcDs7BfQzddJKfSR_RpcgK_O32Wz1kFy
X-Proofpoint-GUID: pBk2ZmKESctOTEL2Ixv74m1WWfe5AYPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_06,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=504
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Introduce  MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE memory notifiers to
prepare the transition of memory to and from a physically accessible
state. This enhancement is crucial for implementing the "memmap on
memory" feature for s390 in a subsequent patch.

Platforms such as x86 can support physical memory hotplug via ACPI. When
there is physical memory hotplug, ACPI event leads to the memory
addition with the following callchain:
acpi_memory_device_add()
  -> acpi_memory_enable_device()
     -> __add_memory()

After this, the hotplugged memory is physically accessible, and altmap
support prepared, before the "memmap on memory" initialization in
memory_block_online() is called.

On s390, memory hotplug works in a different way. The available hotplug
memory has to be defined upfront in the hypervisor, but it is made
physically accessible only when the user sets it online via sysfs,
currently in the MEM_GOING_ONLINE notifier. This is too late and "memmap
on memory" initialization is performed before calling MEM_GOING_ONLINE
notifier.

During the memory hotplug addition phase, altmap support is prepared and
during the memory onlining phase s390 requires memory to be physically
accessible and then subsequently initiate the "memmap on memory"
initialization process.

The memory provider will handle new MEM_PREPARE_ONLINE /
MEM_FINISH_OFFLINE notifications and make the memory accessible.

The mhp_flag MHP_OFFLINE_INACCESSIBLE is introduced and is relevant when
used along with MHP_MEMMAP_ON_MEMORY, because the altmap cannot be
written (e.g., poisoned) when adding memory -- before it is set online.
This allows for adding memory with an altmap that is not currently made
available by a hypervisor. When onlining that memory, the hypervisor can
be instructed to make that memory accessible via the new notifiers and
the onlining phase will not require any memory allocations, which is
helpful in low-memory situations.

All architectures ignore unknown memory notifiers.  Therefore, the
introduction of these new notifiers does not result in any functional
modifications across architectures.

Suggested-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/base/memory.c          | 21 +++++++++++++++++++--
 include/linux/memory.h         |  2 ++
 include/linux/memory_hotplug.h | 18 +++++++++++++++++-
 include/linux/memremap.h       |  1 +
 mm/memory_hotplug.c            | 30 ++++++++++++++++++++++++++++--
 mm/sparse.c                    |  3 ++-
 6 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 8a13babd826c..5c6b2af75db4 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -188,6 +188,7 @@ static int memory_block_online(struct memory_block *mem)
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
 	unsigned long nr_vmemmap_pages = 0;
+	struct memory_notify arg;
 	struct zone *zone;
 	int ret;
 
@@ -197,6 +198,14 @@ static int memory_block_online(struct memory_block *mem)
 	zone = zone_for_pfn_range(mem->online_type, mem->nid, mem->group,
 				  start_pfn, nr_pages);
 
+	arg.start_pfn = start_pfn;
+	arg.nr_pages = nr_pages;
+	mem_hotplug_begin();
+	ret = memory_notify(MEM_PREPARE_ONLINE, &arg);
+	ret = notifier_to_errno(ret);
+	if (ret)
+		goto out_notifier;
+
 	/*
 	 * Although vmemmap pages have a different lifecycle than the pages
 	 * they describe (they remain until the memory is unplugged), doing
@@ -207,9 +216,9 @@ static int memory_block_online(struct memory_block *mem)
 	if (mem->altmap)
 		nr_vmemmap_pages = mem->altmap->free;
 
-	mem_hotplug_begin();
 	if (nr_vmemmap_pages) {
-		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages, zone);
+		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages,
+						zone, mem->altmap->inaccessible);
 		if (ret)
 			goto out;
 	}
@@ -231,7 +240,11 @@ static int memory_block_online(struct memory_block *mem)
 					  nr_vmemmap_pages);
 
 	mem->zone = zone;
+	mem_hotplug_done();
+	return ret;
 out:
+	memory_notify(MEM_FINISH_OFFLINE, &arg);
+out_notifier:
 	mem_hotplug_done();
 	return ret;
 }
@@ -244,6 +257,7 @@ static int memory_block_offline(struct memory_block *mem)
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
 	unsigned long nr_vmemmap_pages = 0;
+	struct memory_notify arg;
 	int ret;
 
 	if (!mem->zone)
@@ -275,6 +289,9 @@ static int memory_block_offline(struct memory_block *mem)
 		mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
 
 	mem->zone = NULL;
+	arg.start_pfn = start_pfn;
+	arg.nr_pages = nr_pages;
+	memory_notify(MEM_FINISH_OFFLINE, &arg);
 out:
 	mem_hotplug_done();
 	return ret;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index f53cfdaaaa41..de802994a8fa 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -96,6 +96,8 @@ int set_memory_block_size_order(unsigned int order);
 #define	MEM_GOING_ONLINE	(1<<3)
 #define	MEM_CANCEL_ONLINE	(1<<4)
 #define	MEM_CANCEL_OFFLINE	(1<<5)
+#define	MEM_PREPARE_ONLINE	(1<<6)
+#define	MEM_FINISH_OFFLINE	(1<<7)
 
 struct memory_notify {
 	unsigned long start_pfn;
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 7d2076583494..ee00015575aa 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -106,6 +106,22 @@ typedef int __bitwise mhp_t;
  * implies the node id (nid).
  */
 #define MHP_NID_IS_MGID		((__force mhp_t)BIT(2))
+/*
+ * The hotplugged memory is completely inaccessible while the memory is
+ * offline. The memory provider will handle MEM_PREPARE_ONLINE /
+ * MEM_FINISH_OFFLINE notifications and make the memory accessible.
+ *
+ * This flag is only relevant when used along with MHP_MEMMAP_ON_MEMORY,
+ * because the altmap cannot be written (e.g., poisoned) when adding
+ * memory -- before it is set online.
+ *
+ * This allows for adding memory with an altmap that is not currently
+ * made available by a hypervisor. When onlining that memory, the
+ * hypervisor can be instructed to make that memory available, and
+ * the onlining phase will not require any memory allocations, which is
+ * helpful in low-memory situations.
+ */
+#define MHP_OFFLINE_INACCESSIBLE	((__force mhp_t)BIT(3))
 
 /*
  * Extended parameters for memory hotplug:
@@ -154,7 +170,7 @@ extern void adjust_present_page_count(struct page *page,
 				      long nr_pages);
 /* VM interface that may be used by firmware interface */
 extern int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
-				     struct zone *zone);
+				     struct zone *zone, bool mhp_off_inaccessible);
 extern void mhp_deinit_memmap_on_memory(unsigned long pfn, unsigned long nr_pages);
 extern int online_pages(unsigned long pfn, unsigned long nr_pages,
 			struct zone *zone, struct memory_group *group);
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 744c830f4b13..9837f3e6fb95 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -25,6 +25,7 @@ struct vmem_altmap {
 	unsigned long free;
 	unsigned long align;
 	unsigned long alloc;
+	bool inaccessible;
 };
 
 /*
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7a5fc89a8652..ac7cfc09502d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1083,8 +1083,25 @@ void adjust_present_page_count(struct page *page, struct memory_group *group,
 		group->present_kernel_pages += nr_pages;
 }
 
+static void page_init_poison_with_resched(unsigned long start_pfn, unsigned long nr_pages)
+{
+	const unsigned long end_pfn = start_pfn + nr_pages;
+	unsigned long pfn, cur_nr_pages;
+
+	/* Poison struct pages because they are now uninitialized again. */
+	for (pfn = start_pfn; pfn < end_pfn; pfn += cur_nr_pages) {
+		cond_resched();
+
+		/* Select all remaining pages up to the next section boundary */
+		cur_nr_pages =
+			min(end_pfn - pfn, SECTION_ALIGN_UP(pfn + 1) - pfn);
+		page_init_poison(pfn_to_page(pfn),
+				 sizeof(struct page) * cur_nr_pages);
+	}
+}
+
 int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
-			      struct zone *zone)
+			      struct zone *zone, bool mhp_off_inaccessible)
 {
 	unsigned long end_pfn = pfn + nr_pages;
 	int ret, i;
@@ -1092,7 +1109,14 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 	ret = kasan_add_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
 	if (ret)
 		return ret;
-
+	/*
+	 * Memory block is accessible at this stage and hence poison the struct
+	 * pages now.  If the memory block is accessible during memory hotplug
+	 * addition phase, then page poisining is already performed in
+	 * sparse_add_section().
+	 */
+	if (mhp_off_inaccessible)
+		page_init_poison_with_resched(pfn, nr_pages);
 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);
 
 	for (i = 0; i < nr_pages; i++)
@@ -1439,6 +1463,8 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
 		if (mhp_supports_memmap_on_memory(size)) {
 			mhp_altmap.free = memory_block_memmap_on_memory_pages();
+			if (mhp_flags & MHP_OFFLINE_INACCESSIBLE)
+				mhp_altmap.inaccessible = true;
 			params.altmap = kmalloc(sizeof(struct vmem_altmap), GFP_KERNEL);
 			if (!params.altmap) {
 				ret = -ENOMEM;
diff --git a/mm/sparse.c b/mm/sparse.c
index 77d91e565045..3991c717b769 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -907,7 +907,8 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	 * Poison uninitialized struct pages in order to catch invalid flags
 	 * combinations.
 	 */
-	page_init_poison(memmap, sizeof(struct page) * nr_pages);
+	if (!altmap || !altmap->inaccessible)
+		page_init_poison(memmap, sizeof(struct page) * nr_pages);
 
 	ms = __nr_to_section(section_nr);
 	set_section_nid(section_nr, nid);
-- 
2.41.0


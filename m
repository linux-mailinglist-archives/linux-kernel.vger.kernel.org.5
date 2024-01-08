Return-Path: <linux-kernel+bounces-19619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52264826FC7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0516283F5E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D0C45940;
	Mon,  8 Jan 2024 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DDo2oXU3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C3244C99;
	Mon,  8 Jan 2024 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 408CvDg5021432;
	Mon, 8 Jan 2024 13:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bd2kH0MPjjEcdpNbzubR/5CsccZFDx+FDVqG2Ty3je0=;
 b=DDo2oXU3kJgu7OfFBStyzepfeTHYUqfBPq6iB2IZarOc0ILYJ/fDJg8PZRCBWaC8q1s5
 0UEvk0W0bpWaUMeh8gXQb9eLvMoRGlNF/nYbINzqyDPmnFir+U8YZcOSqPMQeiWULOTL
 u8RidBXSYV/SMLMlenxcLx8Qd+JCUbCa1XNM0rGs9YMl2zP64kppDhf+eivvl0dOcm9G
 wItP098xpFa8PmnT+18MN2OTwAPKmRMEGzdIso41CauqqCIXXwfI8n/ooVLNqefBtWlb
 drj+GpX6pmllV9V35IesdDT7Jim3mSVW49jEmcwMTuZiNxTkmnJ9L7u6weqDNbea6kuy cA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vghgk1037-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 13:28:06 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 408Cw14b024140;
	Mon, 8 Jan 2024 13:28:06 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vghgk102j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 13:28:06 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 408Bj5wf000416;
	Mon, 8 Jan 2024 13:28:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfh6sr9x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 13:28:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 408DRwbA36307554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 13:27:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34DF52004E;
	Mon,  8 Jan 2024 13:27:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C94F020065;
	Mon,  8 Jan 2024 13:27:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jan 2024 13:27:57 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v6 1/5] mm/memory_hotplug: introduce MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
Date: Mon,  8 Jan 2024 14:27:43 +0100
Message-Id: <20240108132747.3238763-2-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240108132747.3238763-1-sumanthk@linux.ibm.com>
References: <20240108132747.3238763-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tI4u8U2hwvETcWATrsDxhqKaHAQd5INR
X-Proofpoint-ORIG-GUID: wfSI1SOJy3P0srvcTXjPVMhJqwphDREU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_04,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 spamscore=0 suspectscore=0 mlxlogscore=398 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401080115

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
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/base/memory.c          | 23 ++++++++++++++++++++++-
 include/linux/memory.h         |  9 +++++++++
 include/linux/memory_hotplug.h | 18 +++++++++++++++++-
 include/linux/memremap.h       |  1 +
 mm/memory_hotplug.c            | 17 ++++++++++++++---
 mm/sparse.c                    |  3 ++-
 6 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 8a13babd826c..b99bcc70d6e5 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -188,6 +188,7 @@ static int memory_block_online(struct memory_block *mem)
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
 	unsigned long nr_vmemmap_pages = 0;
+	struct memory_notify arg;
 	struct zone *zone;
 	int ret;
 
@@ -207,9 +208,19 @@ static int memory_block_online(struct memory_block *mem)
 	if (mem->altmap)
 		nr_vmemmap_pages = mem->altmap->free;
 
+	arg.altmap_start_pfn = start_pfn;
+	arg.altmap_nr_pages = nr_vmemmap_pages;
+	arg.start_pfn = start_pfn + nr_vmemmap_pages;
+	arg.nr_pages = nr_pages - nr_vmemmap_pages;
 	mem_hotplug_begin();
+	ret = memory_notify(MEM_PREPARE_ONLINE, &arg);
+	ret = notifier_to_errno(ret);
+	if (ret)
+		goto out_notifier;
+
 	if (nr_vmemmap_pages) {
-		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages, zone);
+		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages,
+						zone, mem->altmap->inaccessible);
 		if (ret)
 			goto out;
 	}
@@ -231,7 +242,11 @@ static int memory_block_online(struct memory_block *mem)
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
@@ -244,6 +259,7 @@ static int memory_block_offline(struct memory_block *mem)
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
 	unsigned long nr_vmemmap_pages = 0;
+	struct memory_notify arg;
 	int ret;
 
 	if (!mem->zone)
@@ -275,6 +291,11 @@ static int memory_block_offline(struct memory_block *mem)
 		mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
 
 	mem->zone = NULL;
+	arg.altmap_start_pfn = start_pfn;
+	arg.altmap_nr_pages = nr_vmemmap_pages;
+	arg.start_pfn = start_pfn + nr_vmemmap_pages;
+	arg.nr_pages = nr_pages - nr_vmemmap_pages;
+	memory_notify(MEM_FINISH_OFFLINE, &arg);
 out:
 	mem_hotplug_done();
 	return ret;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index f53cfdaaaa41..939a16bd5cea 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -96,8 +96,17 @@ int set_memory_block_size_order(unsigned int order);
 #define	MEM_GOING_ONLINE	(1<<3)
 #define	MEM_CANCEL_ONLINE	(1<<4)
 #define	MEM_CANCEL_OFFLINE	(1<<5)
+#define	MEM_PREPARE_ONLINE	(1<<6)
+#define	MEM_FINISH_OFFLINE	(1<<7)
 
 struct memory_notify {
+	/*
+	 * The altmap_start_pfn and altmap_nr_pages fields are designated for
+	 * specifying the altmap range and are exclusively intended for use in
+	 * MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers.
+	 */
+	unsigned long altmap_start_pfn;
+	unsigned long altmap_nr_pages;
 	unsigned long start_pfn;
 	unsigned long nr_pages;
 	int status_change_nid_normal;
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
index 926e1cfb10e9..b8aa42af93dc 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1084,7 +1084,7 @@ void adjust_present_page_count(struct page *page, struct memory_group *group,
 }
 
 int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
-			      struct zone *zone)
+			      struct zone *zone, bool mhp_off_inaccessible)
 {
 	unsigned long end_pfn = pfn + nr_pages;
 	int ret, i;
@@ -1093,6 +1093,15 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 	if (ret)
 		return ret;
 
+	/*
+	 * Memory block is accessible at this stage and hence poison the struct
+	 * pages now.  If the memory block is accessible during memory hotplug
+	 * addition phase, then page poisining is already performed in
+	 * sparse_add_section().
+	 */
+	if (mhp_off_inaccessible)
+		page_init_poison(pfn_to_page(pfn), sizeof(struct page) * nr_pages);
+
 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);
 
 	for (i = 0; i < nr_pages; i++)
@@ -1412,7 +1421,7 @@ static void __ref remove_memory_blocks_and_altmaps(u64 start, u64 size)
 }
 
 static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
-					    u64 start, u64 size)
+					    u64 start, u64 size, mhp_t mhp_flags)
 {
 	unsigned long memblock_size = memory_block_size_bytes();
 	u64 cur_start;
@@ -1428,6 +1437,8 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 		};
 
 		mhp_altmap.free = memory_block_memmap_on_memory_pages();
+		if (mhp_flags & MHP_OFFLINE_INACCESSIBLE)
+			mhp_altmap.inaccessible = true;
 		params.altmap = kmemdup(&mhp_altmap, sizeof(struct vmem_altmap),
 					GFP_KERNEL);
 		if (!params.altmap) {
@@ -1513,7 +1524,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	 */
 	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY) &&
 	    mhp_supports_memmap_on_memory(memory_block_size_bytes())) {
-		ret = create_altmaps_and_memory_blocks(nid, group, start, size);
+		ret = create_altmaps_and_memory_blocks(nid, group, start, size, mhp_flags);
 		if (ret)
 			goto error;
 	} else {
diff --git a/mm/sparse.c b/mm/sparse.c
index 338cf946dee8..aed0951b87fa 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -908,7 +908,8 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	 * Poison uninitialized struct pages in order to catch invalid flags
 	 * combinations.
 	 */
-	page_init_poison(memmap, sizeof(struct page) * nr_pages);
+	if (!altmap || !altmap->inaccessible)
+		page_init_poison(memmap, sizeof(struct page) * nr_pages);
 
 	ms = __nr_to_section(section_nr);
 	set_section_nid(section_nr, nid);
-- 
2.40.1



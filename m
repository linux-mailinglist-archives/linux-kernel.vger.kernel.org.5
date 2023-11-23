Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5567C7F5B02
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjKWJYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjKWJYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:24:05 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AF5D41;
        Thu, 23 Nov 2023 01:24:11 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN9MJew015055;
        Thu, 23 Nov 2023 09:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HwbCfMd9FDVn6PpCGOGhbJh/24QSajgcDKz+c2O+fJc=;
 b=DTKWH7wJ+GKrW6nB2PoOXQvtPeUg8dEfEpNuODKRz5a5fJqMzfj/Iz5aZsuyadd6TfZg
 z4M8xjYHa+Wbm7VriuZgLgkskdJqvJKQxnbpnEzYFctTRKMit24KMFRIGV2JExslsySd
 sCLbfORP7jslfw2sFInRbxAxEIptrtTdV+sLZcdIOUbJX8R0r9y2BB4pE2mHCkWjaqlf
 n3c2vZV08K+k97D4alFSjAtvaqYNTUPDpUE44c7cn/axC4AZhGdjoh8ku4wmL+KcXs1E
 ZD/KIJslqPBZEV9VNlmN31RgmtnQ9487YMMY0KsC0XvyE3qpR4X2FJyrvMfeKdZCm5wd kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj41vr1b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 09:24:00 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AN9N0Bm017396;
        Thu, 23 Nov 2023 09:24:00 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj41vr1ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 09:23:59 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN8nEja023488;
        Thu, 23 Nov 2023 09:23:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tknumx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 09:23:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AN9NuvC29229736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Nov 2023 09:23:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF6F120040;
        Thu, 23 Nov 2023 09:23:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C09F32004B;
        Thu, 23 Nov 2023 09:23:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Nov 2023 09:23:55 +0000 (GMT)
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
Subject: [PATCH v2 1/7] mm/memory_hotplug: introduce mhp_flag MHP_OFFLINE_INACCESSIBLE
Date:   Thu, 23 Nov 2023 10:23:37 +0100
Message-Id: <20231123092343.1703707-2-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123092343.1703707-1-sumanthk@linux.ibm.com>
References: <20231123092343.1703707-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1LOAtid-uln_WgoAXOcTLt5CJX2DCdKE
X-Proofpoint-GUID: 43IddKH6wX7PlbvKGysk-2j4SFo5RpMm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_07,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=447 clxscore=1015
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce MHP_OFFLINE_INACCESSIBLE mhp_flag to mark the hotplugged
memory block as inaccessible during the memory hotplug addition phase.
With support for "memmap on memory", the altmap is prepared at this
stage. Architectures like s390 anticipate that memmap should not be
accessed until memory is physically accessible and is accessible only
when it enters the memory hotplug onlining phase using the memory
notifier.  Introduce the flag to inform the memory hotplug
infrastructure that the memory remains inaccessible until the memory
hotplug onlining phase begins.

Implementation considerations:
mhp inaccessible flag is initially set in altmap. This is useful in
arch_add_memory(). When the memory block device is added, the mhp
inaccessible information is passed to memory_block. The flag is used in
subsequent patch to avoid accessing memmap during memory hotplug
addition phase.

Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/base/memory.c          |  2 ++
 include/linux/memory.h         |  1 +
 include/linux/memory_hotplug.h | 10 ++++++++++
 include/linux/memremap.h       |  1 +
 mm/memory_hotplug.c            |  3 ++-
 5 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 8a13babd826c..51915d5c3f88 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -774,6 +774,8 @@ static int add_memory_block(unsigned long block_id, unsigned long state,
 	mem->state = state;
 	mem->nid = NUMA_NO_NODE;
 	mem->altmap = altmap;
+	if (altmap)
+		mem->inaccessible = altmap->inaccessible;
 	INIT_LIST_HEAD(&mem->group_next);
 
 #ifndef CONFIG_NUMA
diff --git a/include/linux/memory.h b/include/linux/memory.h
index f53cfdaaaa41..655714d4e65a 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -67,6 +67,7 @@ struct memory_group {
 struct memory_block {
 	unsigned long start_section_nr;
 	unsigned long state;		/* serialized by the dev->lock */
+	bool inaccessible;		/* during memory addition phase */
 	int online_type;		/* for passing data to online routine */
 	int nid;			/* NID for this memory block */
 	/*
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 7d2076583494..8988cd5ad55d 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -106,6 +106,16 @@ typedef int __bitwise mhp_t;
  * implies the node id (nid).
  */
 #define MHP_NID_IS_MGID		((__force mhp_t)BIT(2))
+/*
+ * Mark the hotplugged memory block as inaccessible during the memory hotplug
+ * addition phase. With support for "memmap on memory," the altmap is prepared
+ * at this stage. Architectures like s390 anticipate that memmap should not be
+ * accessed until memory is physically accessible and is accessible only when
+ * it enters the memory hotplug onlining phase using the memory notifier.
+ * Utilize this flag to inform the memory hotplug infrastructure that the
+ * memory remains inaccessible until the memory hotplug onlining phase begins.
+ */
+#define MHP_OFFLINE_INACCESSIBLE	((__force mhp_t)BIT(3))
 
 /*
  * Extended parameters for memory hotplug:
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
index 7a5fc89a8652..1e02eba166b0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1092,7 +1092,6 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 	ret = kasan_add_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
 	if (ret)
 		return ret;
-
 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);
 
 	for (i = 0; i < nr_pages; i++)
@@ -1439,6 +1438,8 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
 		if (mhp_supports_memmap_on_memory(size)) {
 			mhp_altmap.free = memory_block_memmap_on_memory_pages();
+			if (mhp_flags & MHP_OFFLINE_INACCESSIBLE)
+				mhp_altmap.inaccessible = true;
 			params.altmap = kmalloc(sizeof(struct vmem_altmap), GFP_KERNEL);
 			if (!params.altmap) {
 				ret = -ENOMEM;
-- 
2.39.2


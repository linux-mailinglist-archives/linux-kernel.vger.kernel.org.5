Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC66A7F167A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjKTOzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbjKTOyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:54:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547C42D42;
        Mon, 20 Nov 2023 06:54:20 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKEenPb031878;
        Mon, 20 Nov 2023 14:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=pHEHZ61IzDkvkO46Xyp/tMYTkEieSxEfukYbA/B4d2Q=;
 b=MONRno6phyTdoV+TzCOKUfqlPvuV6zvh5qYmPCegPFmoQhXo/vc1in/w3RmY/iFwAe1n
 83FNrHFI/wIAmCxtMzOd6bl756ieBsdLQhV19DVQgiGvRC0FL0B+OlurmJHw13vuNiSc
 r2aYLzN4WT0mW/nmO3O59eBtEj0oUeQfCWKxBmi4CNwC8EgFSNFoLpXljoPOLiVfyxRO
 YqS2CGfQJQgd/U0hED6fLxHPpVX1io7qqFP4a7/zzYPbMV5CfYDRMS1xfDPFAm+44bhn
 BDQwxXoNdwN5mdhb6U9D+fwAn9Mv/aZNTJ1KAflOGCqTxbLrCOL7DmT3IyH5aFr9WVaF Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug89ej85n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 14:54:08 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AKEfdpO002498;
        Mon, 20 Nov 2023 14:54:07 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug89ej85a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 14:54:07 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKDQw3S008793;
        Mon, 20 Nov 2023 14:54:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93khp9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 14:54:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AKEs3Ma22413850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 14:54:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26E1F20040;
        Mon, 20 Nov 2023 14:54:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E629E20049;
        Mon, 20 Nov 2023 14:54:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Nov 2023 14:54:02 +0000 (GMT)
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] mm: use vmem_altmap code without CONFIG_ZONE_DEVICE
Date:   Mon, 20 Nov 2023 15:53:54 +0100
Message-Id: <20231120145354.308999-4-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120145354.308999-1-sumanthk@linux.ibm.com>
References: <20231120145354.308999-1-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3mrIshPRLx2NhH13KZJAfBn2xHoRpTlq
X-Proofpoint-ORIG-GUID: kmSa7hg3x680ryqobdqsYpND44qbLYC-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_14,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=710 phishscore=0
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmem_altmap_free() and vmem_altmap_offset() could be utlized without
CONFIG_ZONE_DEVICE enabled. For example,
mm/memory_hotplug.c:__add_pages() relies on that.  The altmap is no
longer restricted to ZONE_DEVICE handling, but instead depends on
CONFIG_SPARSEMEM_VMEMMAP.

When CONFIG_SPARSEMEM_VMEMMAP is disabled, these functions are defined
as inline stubs, ensuring compatibility with configurations that do not
use sparsemem vmemmap. Without it, lkp reported the following:

ld: arch/x86/mm/init_64.o: in function `remove_pagetable':
init_64.c:(.meminit.text+0xfc7): undefined reference to
`vmem_altmap_free'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311180545.VeyRXEDq-lkp@intel.com/
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 include/linux/memremap.h | 12 ------------
 include/linux/mm.h       | 26 ++++++++++++++++++++++++++
 mm/memremap.c            | 14 +-------------
 3 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 1314d9c5f05b..744c830f4b13 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -196,8 +196,6 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 		struct dev_pagemap *pgmap);
 bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
 
-unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
-void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns);
 unsigned long memremap_compat_align(void);
 #else
 static inline void *devm_memremap_pages(struct device *dev,
@@ -228,16 +226,6 @@ static inline bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn)
 	return false;
 }
 
-static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
-{
-	return 0;
-}
-
-static inline void vmem_altmap_free(struct vmem_altmap *altmap,
-		unsigned long nr_pfns)
-{
-}
-
 /* when memremap_pages() is disabled all archs can remap a single page */
 static inline unsigned long memremap_compat_align(void)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf5d0b1b16f4..f2344fd8acbe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3786,6 +3786,32 @@ void vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap);
 #endif
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
+{
+	/* number of pfns from base where pfn_to_page() is valid */
+	if (altmap)
+		return altmap->reserve + altmap->free;
+	return 0;
+}
+
+static inline void vmem_altmap_free(struct vmem_altmap *altmap,
+				    unsigned long nr_pfns)
+{
+	altmap->alloc -= nr_pfns;
+}
+#else
+static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
+{
+	return 0;
+}
+
+static inline void vmem_altmap_free(struct vmem_altmap *altmap,
+				    unsigned long nr_pfns)
+{
+}
+#endif
+
 #define VMEMMAP_RESERVE_NR	2
 #ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
diff --git a/mm/memremap.c b/mm/memremap.c
index bee85560a243..9531faa92a7c 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -7,6 +7,7 @@
 #include <linux/memremap.h>
 #include <linux/pfn_t.h>
 #include <linux/swap.h>
+#include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/swapops.h>
 #include <linux/types.h>
@@ -422,19 +423,6 @@ void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap)
 }
 EXPORT_SYMBOL_GPL(devm_memunmap_pages);
 
-unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
-{
-	/* number of pfns from base where pfn_to_page() is valid */
-	if (altmap)
-		return altmap->reserve + altmap->free;
-	return 0;
-}
-
-void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns)
-{
-	altmap->alloc -= nr_pfns;
-}
-
 /**
  * get_dev_pagemap() - take a new live reference on the dev_pagemap for @pfn
  * @pfn: page frame number to lookup page_map
-- 
2.41.0


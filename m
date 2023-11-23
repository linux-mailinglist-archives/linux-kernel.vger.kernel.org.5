Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40287F5AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjKWJYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKWJYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:24:02 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691F319E;
        Thu, 23 Nov 2023 01:24:08 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN97SOE030489;
        Thu, 23 Nov 2023 09:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HYgtCZxFyEih59yMBfurLMGboumwZXHsg8XyOU1jf9U=;
 b=Vc4+O1y+QnWgZoO0+wVbdg6ae+z4jqwMk/Ws7zP2dNJO8E/MxWGbarmZ6q41B2n3aDak
 oX8SobRQYsO4XYSOFktWOfr6Vqx7H3w0rHahmf1buRqmK7WD2HPkTmuJdpnw0wroQkrP
 O/rU08cbXksW+pNdMs6n7I7qfKLOUXqAArJemAtJTfNxxB8ivpbTLH/bCas17tYa8P3a
 hcNnQ4Pj6iCjNxRXr7GlQaEJptjmXoi6rGrsltjuoNzbUac4cDqKaGhdAZ231oU8Ex4t
 OylgpPPoQLMWfKexJyXEkJc+QJOHv1Rz+lOmfalm7Gz1Ccj9OsxZiEzC7DN84IjRj5P1 Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj3twrepv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 09:24:01 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AN98Cl1001750;
        Thu, 23 Nov 2023 09:24:01 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj3twrep2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 09:24:00 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN8nG1e021112;
        Thu, 23 Nov 2023 09:23:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8kp67bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 09:23:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AN9Nugb35979694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Nov 2023 09:23:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6387C20040;
        Thu, 23 Nov 2023 09:23:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34A712004B;
        Thu, 23 Nov 2023 09:23:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Nov 2023 09:23:56 +0000 (GMT)
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
Subject: [PATCH v2 3/7] mm/memory_hotplug: introduce MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
Date:   Thu, 23 Nov 2023 10:23:39 +0100
Message-Id: <20231123092343.1703707-4-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123092343.1703707-1-sumanthk@linux.ibm.com>
References: <20231123092343.1703707-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yp3vEj8jyuT_QEU8ZsHP0Gw5R-tAowx-
X-Proofpoint-ORIG-GUID: vfXWQ1jzYRqboH9Tkb3l5IQQkwYio78y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_07,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 mlxlogscore=473
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311230067
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

During the memory hotplug addition phase, altmap support is prepared
(but not yet accessed) and during the memory onlining phase s390
requires memory to be physically accessible and then subsequently
initiate the "memmap on memory" initialization process.

The new MEM_PREPARE_ONLINE notifier allows to work around the problem,
by providing a hook to prepare the memory and make it physically
accessible. Similarly, the MEM_FINISH_OFFLINE notifier allows to make
the memory physically inaccessible at the end of memory_block_offline().

All architectures ignore unknown memory notifiers, so this patch should
not introduce any functional changes.

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/base/memory.c  | 18 +++++++++++++++++-
 include/linux/memory.h |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index cbff43b2ef44..a06a0b869992 100644
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
@@ -207,7 +216,6 @@ static int memory_block_online(struct memory_block *mem)
 	if (mem->altmap)
 		nr_vmemmap_pages = mem->altmap->free;
 
-	mem_hotplug_begin();
 	if (nr_vmemmap_pages) {
 		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages,
 						zone, mem->inaccessible);
@@ -232,7 +240,11 @@ static int memory_block_online(struct memory_block *mem)
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
@@ -245,6 +257,7 @@ static int memory_block_offline(struct memory_block *mem)
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
 	unsigned long nr_vmemmap_pages = 0;
+	struct memory_notify arg;
 	int ret;
 
 	if (!mem->zone)
@@ -276,6 +289,9 @@ static int memory_block_offline(struct memory_block *mem)
 		mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
 
 	mem->zone = NULL;
+	arg.start_pfn = start_pfn;
+	arg.nr_pages = nr_pages;
+	memory_notify(MEM_FINISH_OFFLINE, &arg);
 out:
 	mem_hotplug_done();
 	return ret;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 655714d4e65a..76e5ab68dab7 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -97,6 +97,8 @@ int set_memory_block_size_order(unsigned int order);
 #define	MEM_GOING_ONLINE	(1<<3)
 #define	MEM_CANCEL_ONLINE	(1<<4)
 #define	MEM_CANCEL_OFFLINE	(1<<5)
+#define	MEM_PREPARE_ONLINE	(1<<6)
+#define	MEM_FINISH_OFFLINE	(1<<7)
 
 struct memory_notify {
 	unsigned long start_pfn;
-- 
2.39.2


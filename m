Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C597D9592
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjJ0Kul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJ0Kuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:50:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0D8129;
        Fri, 27 Oct 2023 03:50:36 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R9a7eC009413;
        Fri, 27 Oct 2023 10:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=MMzz4KZtclkv1V/Awd4XUFwwqUwElJJELCf6yV1ZtQo=;
 b=NJJbazSMkgtin/yS9UbDfjO/y9ZDv79e41eR9k6pxRT0k6bLyPUiMZ2DvooKSHSZCjIP
 ptaQR/xa0kKFLki0HqOd2267ZjWFH//r4/rBEwQxSgZ02A985GBMcaxW+JMnP+r/Ld8E
 KT1+wIQcFntIGwHNMhIVwuKuAH0jckEsZx9FzmrOzDJjEjgnUBSh1+zfTX5SF44qF08T
 4HsvOhTWDstwjwmU+qw5VdcefvqRMl0MHp36Z9p3UJbN1kFpujo2QTj7ckcqW1RQk6lk
 nQF0GFTJ0zD51jL58JmwZ18UzUItw+zKdbd1P44MldfBgt2WOWRVM+7rCRurHzpE+q9I Zg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyxqghu1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 10:50:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39RAoLFS028201
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 10:50:21 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 27 Oct 2023 03:50:17 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <osalvador@suse.de>, <dan.j.williams@intel.com>, <vbabka@suse.cz>,
        <mgorman@techsingularity.net>, <quic_pkondeti@quicinc.com>,
        <aneesh.kumar@linux.ibm.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH V2] mm/sparsemem: fix race in accessing memory_section->usage
Date:   Fri, 27 Oct 2023 16:19:38 +0530
Message-ID: <1698403778-20938-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QkrObHcuXb0hCmYL6aZH1_q5_zjHV2os
X-Proofpoint-ORIG-GUID: QkrObHcuXb0hCmYL6aZH1_q5_zjHV2os
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_07,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270093
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below race is observed on a PFN which falls into the device memory
region with the system memory configuration where PFN's are such that
[ZONE_NORMAL ZONE_DEVICE  ZONE_NORMAL]. Since normal zone start and
end pfn contains the device memory PFN's as well, the compaction
triggered will try on the device memory PFN's too though they end up in
NOP(because pfn_to_online_page() returns NULL for ZONE_DEVICE memory
sections). When from other core, the section mappings are being removed
for the ZONE_DEVICE region, that the PFN in question belongs to,
on which compaction is currently being operated is resulting into the
kernel crash with CONFIG_SPASEMEM_VMEMAP enabled. The crash logs can be
seen at [1].

compact_zone()			memunmap_pages
-------------			---------------
__pageblock_pfn_to_page
   ......
 (a)pfn_valid():
     valid_section()//return true
			      (b)__remove_pages()->
				  sparse_remove_section()->
				    section_deactivate():
				    [Free the array ms->usage and set
				     ms->usage = NULL]
     pfn_section_valid()
     [Access ms->usage which
     is NULL]

NOTE: From the above it can be said that the race is reduced to between
the pfn_valid()/pfn_section_valid() and the section deactivate with
SPASEMEM_VMEMAP enabled.

The commit b943f045a9af("mm/sparse: fix kernel crash with
pfn_section_valid check") tried to address the same problem by clearing
the SECTION_HAS_MEM_MAP with the expectation of valid_section() returns
false thus ms->usage is not accessed.

Fix this issue by the below steps:
a) Clear SECTION_HAS_MEM_MAP before freeing the ->usage.
b) RCU protected read side critical section will either return NULL when
SECTION_HAS_MEM_MAP is cleared or can successfully access ->usage.
c) Free the ->usage with kfree_rcu() and set ms->usage = NULL.
No attempt will be made to access ->usage after this as the
SECTION_HAS_MEM_MAP is cleared thus valid_section() return false.

Thanks to David/Pavan for their inputs on this patch.

[1] https://lore.kernel.org/linux-mm/994410bb-89aa-d987-1f50-f514903c55aa@quicinc.com/

Fixes: f46edbd1b151 ("mm/sparsemem: add helpers track active portions of a section at boot")
Cc: stable@vger.kernel.org
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
V2: Use kfree_rcu() inplace of synchronize_rcu() - David

V1: https://lore.kernel.org/linux-mm/1697202267-23600-1-git-send-email-quic_charante@quicinc.com/

 include/linux/mmzone.h | 14 +++++++++++---
 mm/sparse.c            | 17 +++++++++--------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4106fbc..19a4b1d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1770,6 +1770,7 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
 #define SUBSECTION_ALIGN_DOWN(pfn) ((pfn) & PAGE_SUBSECTION_MASK)
 
 struct mem_section_usage {
+	struct rcu_head rcu;
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
 #endif
@@ -1963,7 +1964,7 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
 {
 	int idx = subsection_map_index(pfn);
 
-	return test_bit(idx, ms->usage->subsection_map);
+	return test_bit(idx, READ_ONCE(ms->usage)->subsection_map);
 }
 #else
 static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
@@ -1987,6 +1988,7 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
 static inline int pfn_valid(unsigned long pfn)
 {
 	struct mem_section *ms;
+	int ret;
 
 	/*
 	 * Ensure the upper PAGE_SHIFT bits are clear in the
@@ -2000,13 +2002,19 @@ static inline int pfn_valid(unsigned long pfn)
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
 	ms = __pfn_to_section(pfn);
-	if (!valid_section(ms))
+	rcu_read_lock();
+	if (!valid_section(ms)) {
+		rcu_read_unlock();
 		return 0;
+	}
 	/*
 	 * Traditionally early sections always returned pfn_valid() for
 	 * the entire section-sized span.
 	 */
-	return early_section(ms) || pfn_section_valid(ms, pfn);
+	ret = early_section(ms) || pfn_section_valid(ms, pfn);
+	rcu_read_unlock();
+
+	return ret;
 }
 #endif
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 77d91e5..338cf94 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -792,6 +792,13 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		unsigned long section_nr = pfn_to_section_nr(pfn);
 
 		/*
+		 * Mark the section invalid so that valid_section()
+		 * return false. This prevents code from dereferencing
+		 * ms->usage array.
+		 */
+		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
+
+		/*
 		 * When removing an early section, the usage map is kept (as the
 		 * usage maps of other sections fall into the same page). It
 		 * will be re-used when re-adding the section - which is then no
@@ -799,16 +806,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		 * was allocated during boot.
 		 */
 		if (!PageReserved(virt_to_page(ms->usage))) {
-			kfree(ms->usage);
-			ms->usage = NULL;
+			kfree_rcu(ms->usage, rcu);
+			WRITE_ONCE(ms->usage, NULL);
 		}
 		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
-		/*
-		 * Mark the section invalid so that valid_section()
-		 * return false. This prevents code from dereferencing
-		 * ms->usage array.
-		 */
-		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
 	}
 
 	/*
-- 
2.7.4


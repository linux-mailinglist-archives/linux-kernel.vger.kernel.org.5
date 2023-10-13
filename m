Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42947C865E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjJMNFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjJMNFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:05:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF23391
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:05:40 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D5IHZf031433;
        Fri, 13 Oct 2023 13:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ZpVQjZLUjrm6AXMKPgqu2lAk/MlW4RlXdT8wWxzO4ZQ=;
 b=EXhnVIrUVQteOJYGnPhNlBAznoz7DRruEWlGD2eLItIY8Vruhq5/+RhYadlDeSPifLkM
 b6nQmtMySLvo/OMccRr3FJGNRn8Y1n7dJiLx6ebK/ixMkoLaqVR/7363o3CulCXXRf5A
 m0L7ykv0JI///gAcKeZsGl837ak8Tsyyk8tyEW+ahTk0+8T8c78us/AcXM5b2mETVZyS
 oMGY7LzpidE6ZVFqsZP//ox6+t0AK1mO1ndgD6fDSIbEtRo3bFQxPBoBAMMLy0Y53UiY
 GP2RfSnDmk1l4IGZSC7/7JvHX4Ja+UL440POgERV3jzKA62PWbFLCXyjvtfEoV+QqCis oA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt109qm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 13:05:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39DD507t012608
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 13:05:00 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 13 Oct 2023 06:04:56 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <osalvador@suse.de>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <vbabka@suse.cz>,
        <mgorman@techsingularity.net>, <aneesh.kumar@linux.ibm.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH] mm/sparsemem: fix race in accessing memory_section->usage
Date:   Fri, 13 Oct 2023 18:34:27 +0530
Message-ID: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dtJjyDBU33e-bVtY1MuaXuU5_edqm5lj
X-Proofpoint-ORIG-GUID: dtJjyDBU33e-bVtY1MuaXuU5_edqm5lj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_04,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130109
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
kernel crash with CONFIG_SPASEMEM_VMEMAP enabled.

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
c) Synchronize the rcu on the write side and free the ->usage. No
attempt will be made to access ->usage after this as the
SECTION_HAS_MEM_MAP is cleared thus valid_section() return false.

Since the section_deactivate() is a rare operation and will come in the
hot remove path, impact of synchronize_rcu() should be negligble.

Fixes: f46edbd1b151 ("mm/sparsemem: add helpers track active portions of a section at boot")
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 include/linux/mmzone.h | 11 +++++++++--
 mm/sparse.c            | 14 ++++++++------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4106fbc..c877396 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1987,6 +1987,7 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
 static inline int pfn_valid(unsigned long pfn)
 {
 	struct mem_section *ms;
+	int ret;
 
 	/*
 	 * Ensure the upper PAGE_SHIFT bits are clear in the
@@ -2000,13 +2001,19 @@ static inline int pfn_valid(unsigned long pfn)
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
index 77d91e5..ca7dbe1 100644
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
@@ -799,16 +806,11 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		 * was allocated during boot.
 		 */
 		if (!PageReserved(virt_to_page(ms->usage))) {
+			synchronize_rcu();
 			kfree(ms->usage);
 			ms->usage = NULL;
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


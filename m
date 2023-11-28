Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E5D7FC22B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346477AbjK1Pw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346381AbjK1Pwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:52:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B045010CA;
        Tue, 28 Nov 2023 07:52:52 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASFqCmn025863;
        Tue, 28 Nov 2023 15:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mAMWAmx4tTbSFhnG6X+oeskqJ2cVVuibj42I4REYo6w=;
 b=Iv1BKINlJnjhQCioZR2zg1N8UHxJUloCT/s/MTX8CSLCFyQc1zCdNXrstOAdHlXXaWFv
 yUpDrsDDw9ufWbZhOt72QqcvbbxYiF7iyXjLl6po22zKS3Op107ST/o1uGYUxZDudjI0
 mgie6ngJ3qAACu9/fuQGcF+6wiOhnfd09jeb9Ndvw5BMbkz/KgmxFHOhIZYwZMIzebzP
 KDj1zHjTJXaKCz+wv2ZHOgXucXcK45fqfAyvX9OKgo1wtrJxMnGXlB+NC0CsixnvTNFw
 IVftl62HLAKO7TTwjcjZQipedtK5C8VN7W2cRRB5kTpFEkE26cU7inZyfPClEJynIcJh iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unk7n00f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 15:52:40 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASFqegg027840;
        Tue, 28 Nov 2023 15:52:40 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unk7n00ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 15:52:40 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASDS1w4031065;
        Tue, 28 Nov 2023 15:52:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uku8t0y8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 15:52:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASFqa4L43188918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 15:52:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04A5920040;
        Tue, 28 Nov 2023 15:52:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E3422004B;
        Tue, 28 Nov 2023 15:52:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 28 Nov 2023 15:52:35 +0000 (GMT)
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
Subject: [PATCH v5 4/5] s390/mm: implement MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
Date:   Tue, 28 Nov 2023 16:52:26 +0100
Message-Id: <20231128155227.1315063-5-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231128155227.1315063-1-sumanthk@linux.ibm.com>
References: <20231128155227.1315063-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IvgOVkupz2u_q2vxVUHixm_jiZzz_VAT
X-Proofpoint-GUID: xthJt4AmJ-iVsHgqcPT9Eh_Rh0ZkO93N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_18,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280127
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MEM_PREPARE_ONLINE memory notifier makes memory block physical
accessible via sclp assign command. The notifier ensures self-contained
memory maps are accessible and hence enabling the "memmap on memory" on
s390.

MEM_FINISH_OFFLINE memory notifier shifts the memory block to an
inaccessible state via sclp unassign command.

Implementation considerations:
* When MHP_MEMMAP_ON_MEMORY is disabled, the system retains the old
  behavior. This means the memory map is allocated from default memory.
* If MACHINE_HAS_EDAT1 is unavailable, MHP_MEMMAP_ON_MEMORY is
  automatically disabled. This ensures that vmemmap pagetables do not
  consume additional memory from the default memory allocator.
* The MEM_GOING_ONLINE notifier has been modified to perform no
  operation, as MEM_PREPARE_ONLINE already executes the sclp assign
  command.
* The MEM_CANCEL_ONLINE/MEM_OFFLINE notifier now performs no operation, as
  MEM_FINISH_OFFLINE already executes the sclp unassign command.

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/s390/char/sclp_cmd.c | 41 ++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
index 355e63e44e95..7815e9bea69a 100644
--- a/drivers/s390/char/sclp_cmd.c
+++ b/drivers/s390/char/sclp_cmd.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/memory.h>
+#include <linux/memory_hotplug.h>
 #include <linux/module.h>
 #include <asm/ctlreg.h>
 #include <asm/chpid.h>
@@ -26,6 +27,7 @@
 #include <asm/sclp.h>
 #include <asm/numa.h>
 #include <asm/facility.h>
+#include <asm/page-states.h>
 
 #include "sclp.h"
 
@@ -340,13 +342,38 @@ static int sclp_mem_notifier(struct notifier_block *nb,
 		if (contains_standby_increment(start, start + size))
 			rc = -EPERM;
 		break;
-	case MEM_GOING_ONLINE:
+	case MEM_PREPARE_ONLINE:
+		/*
+		 * Access the altmap_start_pfn and altmap_nr_pages fields
+		 * within the struct memory_notify specifically when dealing
+		 * with only MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers.
+		 *
+		 * When altmap is in use, take the specified memory range
+		 * online, which includes the altmap.
+		 */
+		if (arg->altmap_nr_pages) {
+			start = PFN_PHYS(arg->altmap_start_pfn);
+			size += PFN_PHYS(arg->altmap_nr_pages);
+		}
 		rc = sclp_mem_change_state(start, size, 1);
+		if (rc || !arg->altmap_nr_pages)
+			break;
+		/*
+		 * Set CMMA state to nodat here, since the struct page memory
+		 * at the beginning of the memory block will not go through the
+		 * buddy allocator later.
+		 */
+		__arch_set_page_nodat((void *)__va(start), arg->altmap_nr_pages);
 		break;
-	case MEM_CANCEL_ONLINE:
-		sclp_mem_change_state(start, size, 0);
-		break;
-	case MEM_OFFLINE:
+	case MEM_FINISH_OFFLINE:
+		/*
+		 * When altmap is in use, take the specified memory range
+		 * offline, which includes the altmap.
+		 */
+		if (arg->altmap_nr_pages) {
+			start = PFN_PHYS(arg->altmap_start_pfn);
+			size += PFN_PHYS(arg->altmap_nr_pages);
+		}
 		sclp_mem_change_state(start, size, 0);
 		break;
 	default:
@@ -397,7 +424,9 @@ static void __init add_memory_merged(u16 rn)
 	if (!size)
 		goto skip_add;
 	for (addr = start; addr < start + size; addr += block_size)
-		add_memory(0, addr, block_size, MHP_NONE);
+		add_memory(0, addr, block_size,
+			   MACHINE_HAS_EDAT1 ?
+			   MHP_MEMMAP_ON_MEMORY | MHP_OFFLINE_INACCESSIBLE : MHP_NONE);
 skip_add:
 	first_rn = rn;
 	num = 1;
-- 
2.40.1


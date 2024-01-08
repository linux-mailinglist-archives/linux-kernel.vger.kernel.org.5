Return-Path: <linux-kernel+bounces-19617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C14826FC3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1024283F35
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE4D45C14;
	Mon,  8 Jan 2024 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T7NWUx1k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410E645BF0;
	Mon,  8 Jan 2024 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 408Cl0WU001332;
	Mon, 8 Jan 2024 13:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mAMWAmx4tTbSFhnG6X+oeskqJ2cVVuibj42I4REYo6w=;
 b=T7NWUx1kZCIMJ4BzZTm+M2/2Zx0FpHAaAjni7YrHbHX7MuQnY1DCxPGS+ZgFyg81n6qp
 /wkaGhwRtjs0i+Syn7oD8xEgYEwcC4Sq/yR0pmyD6ZOhS40DDKSzCGhtpEly5KyL96cL
 4AUvo1lboNP/wDawXTRePpfDKODDZj788zYExuUCwymeWD8igNTIJED8fgar6yF755ut
 i4T6yZiLRpMrITJs3/ZjBkQkqnZTojuPYTPDW6FmogQ7WKoAnb3My3HvTiHAvpxaoV8n
 3Emn/DdRnWTyDgFXsIt5rwNffEpRP1qkl5mbbUgjrf0uWrkK+rfsttjN8fODdvBnjHmi 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vf1qexmer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 13:28:08 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 408CP5r1024343;
	Mon, 8 Jan 2024 13:28:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vf1qexmdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 13:28:07 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 408C6kmv022799;
	Mon, 8 Jan 2024 13:28:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfhjy87yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 13:28:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 408DS2267799544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 13:28:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3C862004E;
	Mon,  8 Jan 2024 13:27:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21F3720067;
	Mon,  8 Jan 2024 13:27:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jan 2024 13:27:59 +0000 (GMT)
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
Subject: [PATCH v6 4/5] s390/mm: implement MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
Date: Mon,  8 Jan 2024 14:27:46 +0100
Message-Id: <20240108132747.3238763-5-sumanthk@linux.ibm.com>
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
X-Proofpoint-GUID: 7mkCTFBZ_igCm35Up3nk_f_xNDDv_oAk
X-Proofpoint-ORIG-GUID: Xa9P41lBTiK1qvAcU4rzOO1CifOtzvCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_04,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401080115

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



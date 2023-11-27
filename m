Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1369C7F9B92
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjK0IUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjK0IUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:20:34 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A3C13D;
        Mon, 27 Nov 2023 00:20:39 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR814s9002447;
        Mon, 27 Nov 2023 08:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=uF4hMmPu1tXjkVZJ+uKsx8mNtonIST1XxO8s9m//hfs=;
 b=TxFgPzCDOmNTBlo0mMhwodytTrlHubBzCeOjlt31bTzLdihSl4VfYF/vo30a0c2F9fNd
 PorW58FJCj+woxkc5nsGhVDhVmFIX9IiBu/FE5XgxmBjXDAO/pvLogyC0Pcr6DtqwZ1x
 xJflLHUoElor9iPYmX+2S5FN7I0hAq7b13ozdkp77Nig0CYvf0z9W1WaYWm0AvRLij49
 5dHnwGTpSO9zr4xaa5zKUx234zvJl7ZzaiI52WwGxqUXp7ksYyUAT0ukr0CBcpdYL99D
 915BubV56EYHvP59bKRSwqnAnt7q6AX+g+u5RmLiEKbSM4yRixQIoS+tHJGrZRXulKPv HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umj76ew6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 08:20:29 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AR8G0Sh017041;
        Mon, 27 Nov 2023 08:20:29 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umj76ew6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 08:20:29 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR8JKUV010951;
        Mon, 27 Nov 2023 08:20:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy1esjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 08:20:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AR8KPf039584186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 08:20:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC35520043;
        Mon, 27 Nov 2023 08:20:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EF7120040;
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
Subject: [PATCH v3 0/5] implement "memmap on memory" feature on s390
Date:   Mon, 27 Nov 2023 09:20:18 +0100
Message-Id: <20231127082023.2079810-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Tv0ls7kE_i3UAa44_HeKoUx5BaeuQuPW
X-Proofpoint-GUID: sIvF8QSusNakFDxIC41Wib62yVXgCH-P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_06,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=332 phishscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311270057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The patch series implements "memmap on memory" feature on s390.

Patch 1 introduces  MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE memory
notifiers to prepare the transition of memory to and from a physically
accessible state. New mhp_flag MHP_OFFLINE_INACCESSIBLE is introduced to
ensure altmap cannot be written when addidng memory - before it is set
online. This enhancement is crucial for implementing the "memmap on
memory" feature for s390 in a subsequent patch.

Patches 2 allocates vmemmap pages from self-contained memory range for
s390. It allocates memory map (struct pages array) from the hotplugged
memory range, rather than using system memory by passing altmap to
vmemmap functions.

Patch 3 removes unhandled memory notifier types on s390.

Patch 4 implements MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE memory
notifiers on s390. MEM_PREPARE_ONLINE memory notifier makes memory block
physical accessible via sclp assign command. The notifier ensures
self-contained memory maps are accessible and hence enabling the "memmap
on memory" on s390. MEM_FINISH_OFFLINE memory notifier shifts the memory
block to an inaccessible state via sclp unassign command

Patch 5 finally enables MHP_MEMMAP_ON_MEMORY on s390

Note:
These patches are rebased on top of three fixes:
mm: use vmem_altmap code without CONFIG_ZONE_DEVICE
mm/memory_hotplug: fix error handling in add_memory_resource()
mm/memory_hotplug: add missing mem_hotplug_lock

v3:
* added comments to MHP_OFFLINE_ACCESSIBLE as suggested by David.
* Squashed three commits related to new memory notifier.

v2:
* Fixes are integrated and hence removed from this patch series
Suggestions from David:
* Add new flag MHP_OFFLINE_INACCESSIBLE to avoid accessing memory
  during memory hotplug addition phase.
* Avoid page_init_poison() on memmap during mhp addition phase, when
  MHP_OFFLINE_INACCESSIBLE mhp_flag is passed in add_memory().
* Do not skip add_pages() in arch_add_memory(). Similarly, remove
  similar hacks in arch_remove_memory(). 
* Use MHP_PREPARE_ONLINE/MHP_FINISH_OFFLINE naming convention for
  new memory notifiers.
* Rearrange removal of unused s390 memory notifier.
* Necessary commit messages changes.

Thank you

Sumanth Korikkar (5):
  mm/memory_hotplug: introduce MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE
    notifiers
  s390/mm: allocate vmemmap pages from self-contained memory range
  s390/sclp: remove unhandled memory notifier type
  s390/mm: implement MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
  s390: enable MHP_MEMMAP_ON_MEMORY

 arch/s390/Kconfig              |  1 +
 arch/s390/mm/init.c            |  3 --
 arch/s390/mm/vmem.c            | 62 +++++++++++++++++++---------------
 drivers/base/memory.c          | 21 ++++++++++--
 drivers/s390/char/sclp_cmd.c   | 31 ++++++++++++-----
 include/linux/memory.h         |  2 ++
 include/linux/memory_hotplug.h | 18 +++++++++-
 include/linux/memremap.h       |  1 +
 mm/memory_hotplug.c            | 30 ++++++++++++++--
 mm/sparse.c                    |  3 +-
 10 files changed, 127 insertions(+), 45 deletions(-)

-- 
2.41.0


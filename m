Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2697FB8E3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344343AbjK1LEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344324AbjK1LD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:03:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3516CD41;
        Tue, 28 Nov 2023 03:04:02 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASB26b7025942;
        Tue, 28 Nov 2023 11:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=NQD5vamojNYAOy6f1K01j8XrHQ5a42dos52ZE8qgM1Y=;
 b=iJE+ri/N+4H2FjMtF0jCEMP4DcEle6s10y8KgsTFmZMm/766SWV6CthWdMU8pra/HIMK
 AQD9tTa0uzPKV9G4Ovt8kqKZFfHM488+qXrht+J3bbbs56KPew1k6fiDLmF3U2elEu3n
 4x7abuzwk2Me/TKD4610ESb5OleDMxHuNYmqW7GnjzDwS6PK//XSd1lIE6xFUn6RJs6V
 A98qV1vUHF0imBg5e4jgeZeTBHzGLLHeedswbfv8HRBLqMU00E2W14gup0ssyZDRLl9r
 clPFsjGt34yYoXKCmFxhroCytIJN6WcCTN7CEWtLWypATII4WKeWNuBx5xmekIcHZ84o Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uneyp8182-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 11:03:50 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASB2enC027143;
        Tue, 28 Nov 2023 11:03:50 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uneyp8174-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 11:03:49 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASAWIhQ027647;
        Tue, 28 Nov 2023 11:03:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukumyfc00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 11:03:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASB3iuV20185732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 11:03:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B79AA20043;
        Tue, 28 Nov 2023 11:03:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6813020040;
        Tue, 28 Nov 2023 11:03:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 28 Nov 2023 11:03:44 +0000 (GMT)
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
Subject: [PATCH v4 0/5] implement "memmap on memory" feature on s390
Date:   Tue, 28 Nov 2023 12:03:37 +0100
Message-Id: <20231128110342.102096-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Xx4GJybYKPXV9-pMcRk3RoptDOuwCCc8
X-Proofpoint-GUID: e4ABum7uHinNJhNtvd3t-tsCqrLkA53J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_10,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 mlxlogscore=194
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxscore=1 spamscore=1 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280087
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

v4:
* Introduced two new fields, altmap_start_pfn and altmap_nr_pages, in
  the memory_notify structure and document it that it is used only in 
  MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE callbacks.
* Incorporated the newly added fields into s390's
  MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifier callbacks.
* Prevent access to memblock->altmap->free in the s390 notifier callback.
* page_init_poison() could be performed similar to when adding new
  memory in sparse_add_section(). Perform it without cond_resched().

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
 drivers/base/memory.c          | 23 ++++++++++++-
 drivers/s390/char/sclp_cmd.c   | 50 ++++++++++++++++++++++-----
 include/linux/memory.h         |  9 +++++
 include/linux/memory_hotplug.h | 18 +++++++++-
 include/linux/memremap.h       |  1 +
 mm/memory_hotplug.c            | 13 ++++++-
 mm/sparse.c                    |  3 +-
 10 files changed, 140 insertions(+), 43 deletions(-)

-- 
2.41.0


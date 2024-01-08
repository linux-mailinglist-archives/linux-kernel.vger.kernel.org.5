Return-Path: <linux-kernel+bounces-19614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6035826FBA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB081C2286E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4882B44C8D;
	Mon,  8 Jan 2024 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IKbwcL/e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B24595B;
	Mon,  8 Jan 2024 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 408Cav1c030726;
	Mon, 8 Jan 2024 13:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=YZrtjlymUFc4byqHO1ZhX/gQFMaIFJDcdnbyP0K+LSI=;
 b=IKbwcL/eOoBuDHEQ5WyDwT1cYYmJcSOZgTLdbRnUJj777wJTvtiX/MWyfjTaOCddZgLQ
 tj1eMQqu6ZDHmkDWoA1mlyBg5GG9TRwJIBsL1F66jj5lVb/D0B8HkGnKJrW1iL3W9mqK
 damzBE/oVpTFoa5NVv7Hpze6MwyVZbCd87kUDGwspm0X5kZ2VO8Pf542bFiWyHH6dvyw
 vYIEFR5d4L53caymKeIZkypaqq7DLwl9yzntLriTfIBn48FFT0Vd/Qf/dtydkaYSColp
 x5n3AaUf/OWNAAJbCFdQHE6dXQedGhWHTFKL9bRS+k9othUH+IjqkRWFDSjt5oarMQ11 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vg9jjkssf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 13:28:02 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 408Cav1Y030697;
	Mon, 8 Jan 2024 13:28:01 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vg9jjksrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 13:28:01 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 408AwFvQ027026;
	Mon, 8 Jan 2024 13:28:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkw1qmj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 13:28:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 408DRvaP26673730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 13:27:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C488720063;
	Mon,  8 Jan 2024 13:27:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 634FC2004E;
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
Subject: [PATCH v6 0/5] implement "memmap on memory" feature on s390
Date: Mon,  8 Jan 2024 14:27:42 +0100
Message-Id: <20240108132747.3238763-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HWLEJXtVwxL90AxRfylw2WIkcf-hiU-U
X-Proofpoint-GUID: mfEpPjY0k2GxBpgTstDeLz0jnu_CNXe4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_04,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=579 spamscore=0 mlxscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401080115

Hi All,

This series provides "memmap on memory" support on s390 platform.
"memmap on memory" allows struct pages array to be allocated from the
hotplugged memory range instead of allocating it from main system
memory.

s390 currently preallocates struct pages array for all potentially
possible memory, which ensures memory onlining always succeeds, but with
the cost of significant memory consumption from the available system
memory during boottime. In certain extreme configuration, this could
lead to ipl failure.

"memmap on memory" ensures struct pages array are populated from self
contained hotplugged memory range instead of depleting the available
system memory  and this could eliminate ipl failure on s390 platform.

On other platforms, system might go OOM when the physically hotplugged
memory depletes the available memory before it is onlined. Hence,
"memmap on memory" feature was introduced as described in commit
a08a2ae34613 ("mm,memory_hotplug: allocate memmap from the added memory
range").

Unlike other architectures, s390 memory blocks are not physically accessible
until it is online.  To make it physically accessible two new memory
notifiers MEM_PREPARE_ONLINE / MEM_FINISH_OFFLINE are added and this
notifier lets the hypervisor inform that the memory should be made
physically accessible. This allows for "memmap on memory" initialization
during memory hotplug onlining phase, which is performed before calling
MEM_GOING_ONLINE notifier.

Patch 1 introduces  MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE memory
notifiers to prepare the transition of memory to and from a physically
accessible state. New mhp_flag MHP_OFFLINE_INACCESSIBLE is introduced to
ensure altmap cannot be written when adding memory - before it is set
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
block to an inaccessible state via sclp unassign command.

Patch 5 finally enables MHP_MEMMAP_ON_MEMORY on s390.

v6:
* Added usecase description in cover letter.
* Rebased against mm branch. Added mhp_flag parameter to
  create_altmaps_and_memory_blocks() inorder to rebase patch1.

v5:
* Added reviewed-by
* Removed  variables altmap_start, altmap_size in sclp_cmd.c
* Used PFN_PHYS macro.

Thanks for the valualble feedback.

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
 drivers/s390/char/sclp_cmd.c   | 44 +++++++++++++++++++-----
 include/linux/memory.h         |  9 +++++
 include/linux/memory_hotplug.h | 18 +++++++++-
 include/linux/memremap.h       |  1 +
 mm/memory_hotplug.c            | 17 ++++++++--
 mm/sparse.c                    |  3 +-
 10 files changed, 136 insertions(+), 45 deletions(-)

-- 
2.40.1



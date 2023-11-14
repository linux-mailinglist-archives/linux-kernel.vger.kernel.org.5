Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F13D7EB609
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjKNSDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjKNSDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:03:06 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4174111F;
        Tue, 14 Nov 2023 10:03:02 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEHaWkQ020648;
        Tue, 14 Nov 2023 18:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=b9kbxAnG1pdTsFzVrWyA16FcOHZys5jgBlDNWM5n5cU=;
 b=argcVbC/VuADRxGIwrPjUi92qOLfoUirjTPWz/2XtxkmWK79zhhlPtOIUer81fDqn3P2
 xdNvvh4yF4xZKZbGQ3tZCv7dK2nkSXEU1PNU+vCa5vHxbk1qaIuoxU1NIGxsURfPxOeo
 Qw+i6saXFs2cjC+T+GGBfaWsf2d52IuQJapGTPtLH8O6VAEhSe//Bdyu7UxVtu5fP2R9
 +YDW9pVAi/B6TIGcUEgoxxNOp8aTu+vWOSTo1K/k6HmrqfhuIYK//A1yfCmlIC1XOf9v
 5927Ify1U51S7HlIUrdOWRBuXmqcIAz6Sjc96TWk1fRLGaDgytJUt7siDWiE8JD3GBwF 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucdeg8r8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:02:50 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AEHan3b021195;
        Tue, 14 Nov 2023 18:02:49 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucdeg8r7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:02:49 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEGY3rk017575;
        Tue, 14 Nov 2023 18:02:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uanekhftm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:02:48 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AEI2jDS787092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 18:02:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 794AF2004B;
        Tue, 14 Nov 2023 18:02:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D1532004D;
        Tue, 14 Nov 2023 18:02:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Nov 2023 18:02:45 +0000 (GMT)
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
Subject: [PATCH 0/8] implement "memmap on memory" feature on s390
Date:   Tue, 14 Nov 2023 19:02:30 +0100
Message-Id: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2WT_AHfHlzioBkvzqBUMo-HtrfzDZ5Ov
X-Proofpoint-GUID: 1m10EwI2GbB1yhTCnXWcG05GeP1uqN1O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_18,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=414 malwarescore=0 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140136
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

The patch series implements "memmap on memory" feature on s390 and
provides the necessary fixes for it.

Patch 1  addresses the locking order in memory hotplug operations,
ensuring that the mem_hotplug_lock is held during critical operations
like mhp_init_memmap_on_memory() and mhp_deinit_memmap_on_memory()

Patch 2 deals with error handling in add_memory_resource() and considers
the possibility of altmap support. This ensures proper deallocation of
struct pages, aligning with the allocation strategy.

Patch 3 relocates the vmem_altmap code to sparse-vmemmap.c, enabling the
utilization of vmem_altmap_free() and vmem_altmap_offset() without the
dependency on CONFIG_ZONE_DEVICE. Note: These functions are also used in
arm64 architecture. However, ZONE_DEVICE or ARCH_HAS_ZONE_DEVICE doesnt
seems to be enabled in arm64.

Patch 4 introduces MEM_PHYS_ONLINE/OFFLINE memory notifiers. It
facilitates the emulation of dynamic ACPI event-triggered logic for
memory hotplug on platforms lacking such events. This sets the stage for
implementing the "memmap on memory" feature for s390 in subsequent
patches. All architecture/codepaths have the default cases handled in
memory notifiers. Hence, introducing new memory notifiers will have no
functional impact.

Patches 5 allocates vmemmap pages from self-contained memory range for
s390. It allocates memory map (struct pages array) from the hotplugged
memory range, rather than using system memory by passing altmap to
vmemmap functions.

Patch 6 implements MEM_PHYS_ONLINE and MEM_PHYS_OFFLINE memory notifiers
on s390. It involves making the memory block physically accessible and
then calling __add_pages()/__remove_pages() with altmap parameter.

Patch 7 removes unhandled memory notifier types. This is currently
handled in default case

Patch 8 finally enables MHP_MEMMAP_ON_MEMORY on s390

Thank you

Sumanth Korikkar (8):
  mm/memory_hotplug: fix memory hotplug locking order
  mm/memory_hotplug: fix error handling in add_memory_resource()
  mm: use vmem_altmap code without CONFIG_ZONE_DEVICE
  mm/memory_hotplug: introduce MEM_PHYS_ONLINE/OFFLINE memory notifiers
  s390/mm: allocate vmemmap pages from self-contained memory range
  s390/mm: implement MEM_PHYS_ONLINE MEM_PHYS_OFFLINE memory notifiers
  s390/sclp: remove unhandled memory notifier type
  s390: enable MHP_MEMMAP_ON_MEMORY

 arch/s390/Kconfig            |  1 +
 arch/s390/mm/init.c          | 19 ++++++++---
 arch/s390/mm/vmem.c          | 62 ++++++++++++++++++++----------------
 drivers/base/memory.c        | 28 ++++++++++++++--
 drivers/s390/char/sclp_cmd.c | 37 +++++++++++++++------
 include/linux/memory.h       |  2 ++
 include/linux/memremap.h     | 12 -------
 include/linux/mm.h           |  2 ++
 mm/memory_hotplug.c          | 15 ++++-----
 mm/memremap.c                | 14 +-------
 mm/sparse-vmemmap.c          | 13 ++++++++
 11 files changed, 129 insertions(+), 76 deletions(-)

-- 
2.41.0


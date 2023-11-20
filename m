Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773847F105B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjKTK2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjKTK2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:28:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82020BA;
        Mon, 20 Nov 2023 02:28:01 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKACF43009197;
        Mon, 20 Nov 2023 10:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Uo1wtnwccDNWWlbVDxfBne1aY1UjuhZc/WQo8sZV3KY=;
 b=rQ0zh17jeREnaIa5XxqPASiFNVN0N1mCBPy4sgj5FegwQGwsGzvoOIGNtCQAcBjdUUgA
 LY5upxgEWc/kauyW2RYPDvo1jQO9OSERJnXvnGIr8WaPLtUzm9OXUY6AJ+MdUxYhZgVY
 VJuJcXQ7k5vAhCWohUTiLtH0pGUhFvCM/tzTPyWtd2KZNDyz8k40Il8jmkLJwd8zBgGn
 si9fCo/DsROCVpVxl4/VG7t6is/H+PLPb9WbJh0bg6ZTFVwNui21208NotOR/Q166BOu
 5ZnZAp7JL8A3u6pvPRmifJ0fVydbEwXhM700MlhJjSa7pHoI035VKBCkr91X5LQAE/6G zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug5g98abn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 10:27:49 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AKALb9T002614;
        Mon, 20 Nov 2023 10:27:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug5g98ab6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 10:27:48 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKAJJtm008904;
        Mon, 20 Nov 2023 10:27:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yy8nhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 10:27:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AKARiRu46989688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 10:27:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73CF120043;
        Mon, 20 Nov 2023 10:27:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3947C2004B;
        Mon, 20 Nov 2023 10:27:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Nov 2023 10:27:44 +0000 (GMT)
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
        LKML <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v2 0/3] mm/memory_hotplug: fixes for memory hotplug altmap support
Date:   Mon, 20 Nov 2023 11:27:31 +0100
Message-Id: <20231120102734.2001576-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JsnuuIsft4kusm8B_UhVLlI3082NoJ1X
X-Proofpoint-GUID: KaDoiLzFpFH_N9VrVmPT-0BP05SnvgC7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_08,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=594 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1  adds  the missing lock  in memory hotplug operations,
ensuring that the mem_hotplug_lock is held during critical operations
like mhp_init_memmap_on_memory() and mhp_deinit_memmap_on_memory()

Patch 2 deals with error handling in add_memory_resource() and considers
the possibility of altmap support. This ensures proper deallocation of
struct pages, aligning with the allocation strategy.

Patch 3 relocates the vmem_altmap code to sparse-vmemmap.c, enabling the
utilization of vmem_altmap_free() and vmem_altmap_offset() without the
dependency on CONFIG_ZONE_DEVICE.

v2:
* cc: stable@vger.kernel.org
* made vmem_altmap_offset()/vmem_altmap_free() inline.
* added Acked-by for patch 1 and patch 2.

v1:
Changes since patch series "implement "memmap on memory" feature on
s390:
Patch 1 (Feedback from David):
* Fixed subject for memory hotplug lock.
* Added locking comments before
  memory_block_online()/memory_block_offline().
Patch 2 (Feedback from David):
* Fixed Fixes-by commit.
Patch 3 (lkp report):
* when CONFIG_SPARSEMEM_VMEMMAP is disabled, resolve
  undefined reference to `vmem_altmap_offset' error.
* Request for Reviewed-by once again due to the change in patch3.

Thank you

Sumanth Korikkar (3):
  mm/memory_hotplug: add missing mem_hotplug_lock
  mm/memory_hotplug: fix error handling in add_memory_resource()
  mm: use vmem_altmap code without CONFIG_ZONE_DEVICE

 drivers/base/memory.c    | 18 +++++++++++++++---
 include/linux/memremap.h | 12 ------------
 include/linux/mm.h       | 26 ++++++++++++++++++++++++++
 mm/memory_hotplug.c      | 15 +++++++--------
 mm/memremap.c            | 14 +-------------
 5 files changed, 49 insertions(+), 36 deletions(-)

-- 
2.41.0


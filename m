Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279C27F0CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjKTHXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjKTHXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:23:45 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8183CAA;
        Sun, 19 Nov 2023 23:23:41 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK6ZaNh026332;
        Mon, 20 Nov 2023 07:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=XXY2K4XRh/H3GltFZ7UvZpHSolyErrI5WrSWhciBmoE=;
 b=eNsG9T4DTWjZh6/Wr2vt0OL2+0kEuZNzKKEahkzKmZyUyJBrzk8EQyCqelimrHpOHSdk
 nruREysthWYwXw+45+XktZ7j8Hdiaor9bIXOh6aqB/u67X+gdi2jmD/4m75Vsw+6sDjh
 VToViTj4lKKnzgfm2BrcISZnaDQ4tJ91byrT0b/UAA5LRl0VfobAqYBMTvdFlwhyeZ73
 XKH3Q/StcR7eFWBurBc6OCqoXC2nHS8F3Gv36AV1ejmUwl23sDesBr9TJTdcKC2Sskkg
 NOxi/Lb1bCH4V1QV6//M3bjH5ow9JGBsiQhgrrQ1vAHOsWBiaRi6DERawceOJPLYG44r ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ufrd5488r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 07:23:30 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AK7B47w008132;
        Mon, 20 Nov 2023 07:23:29 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ufrd5488h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 07:23:29 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK7KVAq012325;
        Mon, 20 Nov 2023 07:23:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ufaa1q3c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 07:23:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AK7NPZT23855696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 07:23:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7781C2004E;
        Mon, 20 Nov 2023 07:23:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27D222004B;
        Mon, 20 Nov 2023 07:23:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Nov 2023 07:23:25 +0000 (GMT)
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
Subject: [PATCH 0/3] mm/memory_hotplug: fixes for memory hotplug altmap support
Date:   Mon, 20 Nov 2023 08:23:14 +0100
Message-Id: <20231120072317.3169630-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: y4E_6cc9mxaWWbLfjayca_OWq7H0T2YK
X-Proofpoint-GUID: k6Zu0eurcRnHEhVkhRFkwTY6I1Wqqddr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_04,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=759 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes since patch series "implement "memmap on memory" feature on
s390":
Feedback from David:
Patch 1:
* Fixed subject for memory hotplug lock.
* Added locking comments before
  memory_block_online()/memory_block_offline().
Patch 2:
* Fixed Fixes-by commit.

lkp report:
Patch 3:
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
 include/linux/mm.h       | 15 +++++++++++++++
 mm/memory_hotplug.c      | 15 +++++++--------
 mm/memremap.c            | 14 +-------------
 mm/sparse-vmemmap.c      | 13 +++++++++++++
 6 files changed, 51 insertions(+), 36 deletions(-)

-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6B67CDE56
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344850AbjJROJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjJROJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:09:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54B795
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:09:02 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S9Xfg652yzCrR7;
        Wed, 18 Oct 2023 22:04:59 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 18 Oct 2023 22:08:58 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next v3 00/19] mm: convert page cpupid functions to folios
Date:   Wed, 18 Oct 2023 22:07:47 +0800
Message-ID: <20231018140806.2783514-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpupid(or access time) used by numa balancing is stored in flags
or _last_cpupid(if LAST_CPUPID_NOT_IN_PAGE_FLAGS) of page, this is to
convert page cpupid to folio cpupid, a new _last_cpupid is added into
folio, which make us to use folio->_last_cpupid directly, and the
page cpupid functions are converted to folio ones.

  page_cpupid_last()		-> folio_last_cpupid()
  xchg_page_access_time()	-> folio_xchg_access_time()
  page_cpupid_xchg_last()	-> folio_xchg_last_cpupid()

v3:
- fix finish_mkwrite_fault built warning reported-by lkp
- address the wp_page_reuse() comment of Matthew, also update
  changelog of change_pte_range() and wp_page_reuse() a bit
- rebased on next-20231018

v2:
- add virtual into folio too
- re-write and split patches to make them easier to review
- rename to folio_last_cpupid/folio_xchg_last_cpupid/folio_xchg_access_time
- rebased on next-20231013

v1:
- drop inappropriate page_cpupid_reset_last conversion from RFC
- rebased on next-20231009

Kefeng Wang (19):
  mm_types: add virtual and _last_cpupid into struct folio
  mm: add folio_last_cpupid()
  mm: memory: use folio_last_cpupid() in do_numa_page()
  mm: huge_memory: use folio_last_cpupid() in do_huge_pmd_numa_page()
  mm: huge_memory: use folio_last_cpupid() in __split_huge_page_tail()
  mm: remove page_cpupid_last()
  mm: add folio_xchg_access_time()
  sched/fair: use folio_xchg_access_time() in numa_hint_fault_latency()
  mm: mprotect: use a folio in change_pte_range()
  mm: huge_memory: use a folio in change_huge_pmd()
  mm: remove xchg_page_access_time()
  mm: add folio_xchg_last_cpupid()
  sched/fair: use folio_xchg_last_cpupid() in
    should_numa_migrate_memory()
  mm: migrate: use folio_xchg_last_cpupid() in folio_migrate_flags()
  mm: huge_memory: use folio_xchg_last_cpupid() in
    __split_huge_page_tail()
  mm: make finish_mkwrite_fault() static
  mm: convert wp_page_reuse() and finish_mkwrite_fault() to take a folio
  mm: use folio_xchg_last_cpupid() in wp_page_reuse()
  mm: remove page_cpupid_xchg_last()

 include/linux/mm.h       | 30 +++++++++++++++---------------
 include/linux/mm_types.h | 22 ++++++++++++++++++----
 kernel/sched/fair.c      |  4 ++--
 mm/huge_memory.c         | 17 +++++++++--------
 mm/memory.c              | 38 ++++++++++++++++++++------------------
 mm/migrate.c             |  8 ++++----
 mm/mmzone.c              |  6 +++---
 mm/mprotect.c            | 16 +++++++++-------
 8 files changed, 80 insertions(+), 61 deletions(-)

-- 
2.27.0


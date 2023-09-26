Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5E97AE317
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjIZAxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjIZAxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:53:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852C9D9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:53:10 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rvh4Z2q8YzrSt5;
        Tue, 26 Sep 2023 08:50:54 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 08:53:07 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        Zi Yan <ziy@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next rfc 0/9] mm: convert page cpupid functions to folios
Date:   Tue, 26 Sep 2023 08:52:45 +0800
Message-ID: <20230926005254.2861577-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
page_cpupid_reset_last(), page_cpupid_xchg_last(), xchg_page_access_time(),
and page_cpupid_last() are converted to folio one.

Kefeng Wang (9):
  mm_types: add _last_cpupid into folio
  mm: mprotect: use a folio in change_pte_range()
  mm: huge_memory: use a folio in change_huge_pmd()
  mm: convert xchg_page_access_time to xchg_folio_access_time()
  mm: convert page_cpupid_last() to folio_cpupid_last()
  mm: make wp_page_reuse() and finish_mkwrite_fault() to take a folio
  mm: convert page_cpupid_xchg_last() to folio_cpupid_xchg_last()
  mm: page_alloc: use a folio in free_pages_prepare()
  mm: convert page_cpupid_reset_last() to folio_cpupid_reset_last()

 include/linux/mm.h       | 40 ++++++++++++++++++++--------------------
 include/linux/mm_types.h | 13 +++++++++----
 kernel/sched/fair.c      |  4 ++--
 mm/huge_memory.c         | 17 +++++++++--------
 mm/memory.c              | 39 +++++++++++++++++++++------------------
 mm/migrate.c             |  4 ++--
 mm/mm_init.c             |  1 -
 mm/mmzone.c              |  6 +++---
 mm/mprotect.c            | 16 +++++++++-------
 mm/page_alloc.c          | 17 +++++++++--------
 10 files changed, 84 insertions(+), 73 deletions(-)

-- 
2.27.0


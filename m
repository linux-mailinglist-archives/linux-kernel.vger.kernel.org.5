Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538E07BF349
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442320AbjJJGrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442156AbjJJGrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:47:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BDC97
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:47:07 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S4RF51xGTzVlMQ;
        Tue, 10 Oct 2023 14:43:37 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 14:47:04 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 0/7] mm: convert page cpupid functions to folios
Date:   Tue, 10 Oct 2023 14:45:37 +0800
Message-ID: <20231010064544.4162286-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
page_cpupid_xchg_last(), xchg_page_access_time() and page_cpupid_last()
are converted to folio ones.

v1:
- drop inappropriate page_cpupid_reset_last convertion from RFC
- rebased on next-20231009

Kefeng Wang (7):
  mm_types: add _last_cpupid into folio
  mm: mprotect: use a folio in change_pte_range()
  mm: huge_memory: use a folio in change_huge_pmd()
  mm: convert xchg_page_access_time to xchg_folio_access_time()
  mm: convert page_cpupid_last() to folio_cpupid_last()
  mm: make wp_page_reuse() and finish_mkwrite_fault() to take a folio
  mm: convert page_cpupid_xchg_last() to folio_cpupid_xchg_last()

 include/linux/mm.h       | 30 +++++++++++++++---------------
 include/linux/mm_types.h | 13 +++++++++----
 kernel/sched/fair.c      |  4 ++--
 mm/huge_memory.c         | 17 +++++++++--------
 mm/memory.c              | 39 +++++++++++++++++++++------------------
 mm/migrate.c             |  4 ++--
 mm/mmzone.c              |  6 +++---
 mm/mprotect.c            | 16 +++++++++-------
 8 files changed, 70 insertions(+), 59 deletions(-)

-- 
2.27.0


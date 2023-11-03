Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3239E7E043A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377766AbjKCODu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjKCODs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:03:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34209D4D;
        Fri,  3 Nov 2023 07:03:45 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SMMpG1TbrzrSJv;
        Fri,  3 Nov 2023 22:00:38 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 3 Nov 2023 22:03:42 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        <linux-s390@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfc 00/18] mm: convert to use folio mm counter
Date:   Fri, 3 Nov 2023 22:01:01 +0800
Message-ID: <20231103140119.2306578-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert mm counter page functions to folio ones.

  mm_counter()       ->	mm_counter_folio()
  mm_counter_file()  ->	mm_counter_file_folio()

Maybe it's better to rename folio mm counter function back to mm_counter()
and mm_counter_file() after all conversion?

Kefeng Wang (18):
  mm: add mm_counter_folio() and mm_counter_file_folio()
  uprobes: use mm_counter_file_folio()
  mm: userfaultfd: use mm_counter_folio()
  mm: rmap: use mm_counter_[file]_folio()
  mm: swap: introduce pfn_swap_entry_to_folio()
  mm: huge_memory: use a folio in __split_huge_pmd_locked()
  mm: huge_memory: use a folio in zap_huge_pmd()
  mm: khugepaged: use mm_counter_file_folio() in
    collapse_pte_mapped_thp()
  mm: memory: use a folio in do_set_pmd()
  mm: memory: use mm_counter_file_folio() in copy_present_pte()
  mm: memory: use mm_counter_file_folio() in wp_page_copy()
  mm: memory: use mm_counter_file_folio() in set_pte_range()
  mm: memory: use a folio in insert_page_into_pte_locked()
  mm: remove mm_counter_file()
  mm: memory: use a folio in copy_nonpresent_pte()
  mm: use a folio in zap_pte_range()
  s390: pgtable: use mm_counter_folio() in ptep_zap_swap_entry()
  mm: remove mm_counter()

 arch/s390/mm/pgtable.c  |  4 +--
 include/linux/mm.h      | 12 +++----
 include/linux/swapops.h | 13 +++++++
 kernel/events/uprobes.c |  2 +-
 mm/huge_memory.c        | 25 +++++++------
 mm/khugepaged.c         |  4 +--
 mm/memory.c             | 77 +++++++++++++++++++++++------------------
 mm/rmap.c               | 10 +++---
 mm/userfaultfd.c        |  4 +--
 9 files changed, 88 insertions(+), 63 deletions(-)

-- 
2.27.0


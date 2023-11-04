Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52127E0DAA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 04:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346083AbjKDDzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 23:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjKDDzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 23:55:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E8BD47;
        Fri,  3 Nov 2023 20:55:44 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SMkKf5Cg6zVl5J;
        Sat,  4 Nov 2023 11:55:34 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 4 Nov 2023 11:55:40 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        <linux-s390@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfc v2 00/10] mm: convert mm counter to take a folio
Date:   Sat, 4 Nov 2023 11:55:12 +0800
Message-ID: <20231104035522.2418660-1-wangkefeng.wang@huawei.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make all mm_counter() and mm_counter_file() callers to use a folio,
then convert mm counter functions to take a folio, which saves lots
of compound_head() calls.

Kefeng Wang (10):
  mm: swap: introduce pfn_swap_entry_to_folio()
  s390: pgtable: use a folio in ptep_zap_swap_entry()
  mm: huge_memory: use a folio in __split_huge_pmd_locked()
  mm: huge_memory: use a folio in zap_huge_pmd()
  mm: memory: use a folio in copy_nonpresent_pte()
  mm: memory: use a folio in zap_pte_range()
  mm: memory: use a folio in do_set_pmd()
  mm: memory: use a folio in insert_page_into_pte_locked()
  mm: convert mm_counter() to take a folio
  mm: convert mm_counter_file() to take a folio

 arch/s390/mm/pgtable.c  |  4 +-
 include/linux/mm.h      | 12 +++---
 include/linux/swapops.h | 13 +++++++
 kernel/events/uprobes.c |  2 +-
 mm/huge_memory.c        | 34 +++++++++--------
 mm/khugepaged.c         |  4 +-
 mm/memory.c             | 81 +++++++++++++++++++++++------------------
 mm/rmap.c               | 10 ++---
 mm/userfaultfd.c        |  2 +-
 9 files changed, 94 insertions(+), 68 deletions(-)

-- 
2.27.0


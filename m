Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2133E7E290E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjKFPuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjKFPuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:50:03 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3EA134;
        Mon,  6 Nov 2023 07:50:00 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SPG1Q1TyzzrTbB;
        Mon,  6 Nov 2023 23:46:50 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 6 Nov 2023 23:49:58 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        <linux-s390@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 00/10] mm: convert mm counter to take a folio 
Date:   Mon, 6 Nov 2023 23:49:40 +0800
Message-ID: <20231106154950.3399469-1-wangkefeng.wang@huawei.com>
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

v1:
- rename should_zap_page() to should_zap_folio(), per Matthew Wilcox 
- pass page to page_remove_rmap/page_try_dup_anon_rmap for
  device private page, per Matthew Wilcox

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
 mm/memory.c             | 81 ++++++++++++++++++++++++-----------------
 mm/rmap.c               | 10 ++---
 mm/userfaultfd.c        |  2 +-
 9 files changed, 96 insertions(+), 66 deletions(-)

-- 
2.27.0


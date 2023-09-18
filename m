Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0BA7A4728
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbjIRKdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241327AbjIRKdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:33:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8429121
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:32:48 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rq1JH2n8mzVkyT;
        Mon, 18 Sep 2023 18:29:51 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 18 Sep 2023 18:32:45 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/6] mm: convert numa balancing functions to use a folio
Date:   Mon, 18 Sep 2023 18:32:07 +0800
Message-ID: <20230918103213.4166210-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

The do_numa_pages only handle non-compound page, and only PMD-mapped THP
is handled in do_huge_pmd_numa_page(), but large, PTE-mapped folio will
be supported, let's convert more numa balancing functions to use/take a
folio in preparation for that, no functional change intended for now.

Kefeng Wang (6):
  sched/numa, mm: make numa migrate functions to take a folio
  mm: mempolicy: make mpol_misplaced() to take a folio
  mm: memory: make numa_migrate_prep() to take a folio
  mm: memory: use a folio in do_numa_page()
  mm: memory: add vm_normal_pmd_folio()
  mm: huge_memory: use a folio in do_huge_pmd_numa_page()

 include/linux/mempolicy.h            |  4 +--
 include/linux/mm.h                   |  2 ++
 include/linux/sched/numa_balancing.h |  4 +--
 kernel/sched/fair.c                  | 12 +++----
 mm/huge_memory.c                     | 28 ++++++++--------
 mm/internal.h                        |  2 +-
 mm/memory.c                          | 49 ++++++++++++++++------------
 mm/mempolicy.c                       | 20 ++++++------
 8 files changed, 65 insertions(+), 56 deletions(-)

-- 
2.27.0


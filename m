Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3D079E425
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239493AbjIMJwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbjIMJwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:52:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF17199D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:52:00 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rlwdg03lbzVkg7;
        Wed, 13 Sep 2023 17:49:11 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 13 Sep 2023 17:51:58 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 0/8] mm: migrate: more folio conversion and unification
Date:   Wed, 13 Sep 2023 17:51:23 +0800
Message-ID: <20230913095131.2426871-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert more migrate functions to use a folio, it is also a preparation
for large folio migration support when numa balance.

The patch 1~2	remove unexpected specific assert for PageTransHuge page.

The Patch 3~6	convert several more migration functions to use folio. 
		1) add_page_for_migration() used by move_pages
		2) migrate_misplaced_page()/numamigrate_isolate_page()
		   used by numa balance

The patch 7	remove PageHead() check to make hugetlb to migrate the
		entire hugetlb page instead of -EACCES errno return when
		passed the address of a tail page.

The patch 8	cleanup to unify and simplify code a bit in
		add_page_for_migration()

Thanks for all comments and suggestions from Matthew, Hugh, Zi, Mike, Huang.

v3:
- update changelog of patch1
- use folio_estimated_sharers and comment it in migrate_misplaced_folio()
- collect RB/ACK
- rebased on 6.6-rc1

v2:
- keep page_mapcount() check and remove specific assert for
  PageTransHuge page.
- separate patch7 to migrate the entire hugetlb page if a tail page passed,
  which unified the behavior between HUGETLB and THP when move_page().

Kefeng Wang (8):
  mm: migrate: remove PageTransHuge check in numamigrate_isolate_page()
  mm: migrate: remove THP mapcount check in numamigrate_isolate_page()
  mm: migrate: convert numamigrate_isolate_page() to
    numamigrate_isolate_folio()
  mm: migrate: convert migrate_misplaced_page() to
    migrate_misplaced_folio()
  mm: migrate: use __folio_test_movable()
  mm: migrate: use a folio in add_page_for_migration()
  mm: migrate: remove PageHead() check for HugeTLB in
    add_page_for_migration()
  mm: migrate: remove isolated variable in add_page_for_migration()

 include/linux/migrate.h |   4 +-
 mm/huge_memory.c        |   2 +-
 mm/memory.c             |   2 +-
 mm/migrate.c            | 126 ++++++++++++++++++----------------------
 4 files changed, 62 insertions(+), 72 deletions(-)

-- 
2.27.0


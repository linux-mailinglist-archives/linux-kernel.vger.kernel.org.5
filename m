Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F07D782822
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjHULpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbjHULpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:45:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FEFF2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:45:35 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RTrF20znlzLpSQ;
        Mon, 21 Aug 2023 19:42:30 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 19:45:32 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 0/8] mm: migrate: more folio conversion and unify
Date:   Mon, 21 Aug 2023 19:56:16 +0800
Message-ID: <20230821115624.158759-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch 1~2	remove unexpected specific assert for PageTransHuge page.

The Patch 3~6	convert several more migration functions to use folio. 

The patch 7	remove PageHead() check to make hugetlb to migrate the
		entire hugetlb page instead of -EACCES errno return when
		passed the address of a tail page.

The patch 8	cleanup to unify and simplify code a bit in
		add_page_for_migration()

v2:
Thanks for all comments and advise from Matthew, Hugh, Zi, Mike, Huang.
- keep page_mapcount() check and remove specific assert for
  PageTransHuge page.
- separate patch7 to migrate the entire hugetlb page if a tail page passed,
  which unified the behavior between HUGETLB and THP when move_page().

Kefeng Wang (8):
  mm: migrate: remove PageTransHuge check in numamigrate_isolate_page()
  mm: migrate: remove THP mapcount check in numamigrate_isolate_page()
  mm: migrate: convert numamigrate_isolate_page() to
    numamigrate_isolate_folio()
  mm: migrate: use a folio in migrate_misplaced_page()
  mm: migrate: use __folio_test_movable()
  mm: migrate: use a folio in add_page_for_migration()
  mm: migrate: remove PageHead() check for HugeTLB in
    add_page_for_migration()
  mm: migrate: remove isolated variable in add_page_for_migration()

 mm/migrate.c | 110 +++++++++++++++++++++++----------------------------
 1 file changed, 49 insertions(+), 61 deletions(-)

-- 
2.41.0


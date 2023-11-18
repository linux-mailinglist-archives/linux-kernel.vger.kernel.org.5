Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3917A7EFD34
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 03:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjKRCdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 21:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjKRCdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 21:33:09 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E612D5C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 18:33:05 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SXHl52VTGzNm7S;
        Sat, 18 Nov 2023 10:28:49 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 18 Nov 2023 10:33:02 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 0/5] mm: cleanup and use more folio in page fault
Date:   Sat, 18 Nov 2023 10:32:27 +0800
Message-ID: <20231118023232.1409103-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Rename page_copy_prealloc() to folio_prealloc(), which is used by
more functions, also do more folio conversion in page fault.

v3:
- drop patch6 as Small-sized THP for anon will change anon allocation
- correct do_cow_page to do_cow_fault in subject and changlog
- add RB of Vishal

v2:
- add folio_test_large check in ksm_might_need_to_copy() and
  replace page->index to folio->index, per David, Matthew
- add RB of Sidhartha

Kefeng Wang (5):
  mm: ksm: use more folio api in ksm_might_need_to_copy()
  mm: memory: use a folio in validate_page_before_insert()
  mm: memory: rename page_copy_prealloc() to folio_prealloc()
  mm: memory: use a folio in do_cow_fault()
  mm: memory: use folio_prealloc() in wp_page_copy()

 include/linux/ksm.h |  4 ++--
 mm/ksm.c            | 39 ++++++++++++++++--------------
 mm/memory.c         | 58 +++++++++++++++++++++------------------------
 3 files changed, 50 insertions(+), 51 deletions(-)

-- 
2.27.0


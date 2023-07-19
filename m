Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED864759227
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjGSJ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGSJ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:58:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4033AEC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:58:56 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R5WQt2mKTzNmS6;
        Wed, 19 Jul 2023 17:55:34 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:58:53 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>
CC:     <sidhartha.kumar@oracle.com>, <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v2 0/9] Convert several functions in page_io.c to use a folio
Date:   Wed, 19 Jul 2023 17:58:39 +0800
Message-ID: <20230719095848.3422629-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)
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

From: ZhangPeng <zhangpeng362@huawei.com>

This patch series converts several functions in page_io.c to use a
folio, which can remove several implicit calls to compound_head().

Changelog:

v2:
- remove unneeded ClearPageUptodate() and SetPageError(), suggested by
  Matthew Wilcox
- convert bio_first_page_all() to bio_first_folio_all(), suggested by
  Matthew Wilcox
- convert PageTransHuge to folio_test_pmd_mappable per Matthew Wilcox

ZhangPeng (9):
  mm/page_io: remove unneeded ClearPageUptodate()
  mm/page_io: remove unneeded SetPageError()
  mm/page_io: convert bio_first_page_all() to bio_first_folio_all()
  mm/page_io: use a folio in __end_swap_bio_read()
  mm/page_io: use a folio in sio_read_complete()
  mm/page_io: use a folio in swap_writepage_bdev_sync()
  mm/page_io: use a folio in swap_writepage_bdev_async()
  mm/page_io: convert count_swpout_vm_event() to take in a folio
  mm/page_io: convert bio_associate_blkg_from_page() to take in a folio

 Documentation/block/biovecs.rst  |  2 +-
 drivers/block/drbd/drbd_bitmap.c |  2 +-
 fs/f2fs/data.c                   |  2 +-
 include/linux/bio.h              |  4 +--
 kernel/power/swap.c              |  2 +-
 mm/page_io.c                     | 55 +++++++++++++++-----------------
 6 files changed, 32 insertions(+), 35 deletions(-)

-- 
2.25.1


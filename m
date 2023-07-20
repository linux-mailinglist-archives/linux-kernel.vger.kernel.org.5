Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8885175AF0E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjGTNCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjGTNC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:02:28 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B37626B0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:02:27 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R6CSy0jrtzLnts;
        Thu, 20 Jul 2023 20:59:46 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 21:02:14 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>
CC:     <hch@infradead.org>, <sidhartha.kumar@oracle.com>,
        <akpm@linux-foundation.org>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v3 00/10] Convert several functions in page_io.c to use a folio
Date:   Thu, 20 Jul 2023 21:01:37 +0800
Message-ID: <20230720130147.4071649-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

This patch series converts several functions in page_io.c to use a
folio, which can remove several implicit calls to compound_head().

Changelog:

v3:
- introduce bio_first_folio_all(), rather than replacing
  bio_first_page_all() per Matthew (patch 3)
- use a folio in __end_swap_bio_write() (patch 4)
- remove unneeded ifdefs per Matthew (patch 9)

v2:
- remove unneeded ClearPageUptodate() and SetPageError(), suggested by
  Matthew Wilcox
- convert bio_first_page_all() to bio_first_folio_all()
- convert PageTransHuge to folio_test_pmd_mappable per Matthew Wilcox

ZhangPeng (10):
  mm/page_io: remove unneeded ClearPageUptodate()
  mm/page_io: remove unneeded SetPageError()
  mm/page_io: introduce bio_first_folio_all()
  mm/page_io: use a folio in __end_swap_bio_write()
  mm/page_io: use a folio in __end_swap_bio_read()
  mm/page_io: use a folio in sio_read_complete()
  mm/page_io: use a folio in swap_writepage_bdev_sync()
  mm/page_io: use a folio in swap_writepage_bdev_async()
  mm/page_io: convert count_swpout_vm_event() to take in a folio
  mm/page_io: convert bio_associate_blkg_from_page() to take in a folio

 Documentation/block/biovecs.rst |  1 +
 include/linux/bio.h             |  5 +++
 mm/page_io.c                    | 63 +++++++++++++++------------------
 3 files changed, 35 insertions(+), 34 deletions(-)

-- 
2.25.1


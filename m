Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A565D80E835
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346307AbjLLJuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbjLLJuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:50:23 -0500
X-Greylist: delayed 1039 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Dec 2023 01:50:28 PST
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8017112;
        Tue, 12 Dec 2023 01:50:28 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SqD1T0SBpz1wnf7;
        Tue, 12 Dec 2023 17:33:01 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
        by mail.maildlp.com (Postfix) with ESMTPS id 03A0E1406C8;
        Tue, 12 Dec 2023 17:33:07 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Dec
 2023 17:33:06 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-mm@kvack.org>, <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <willy@infradead.org>, <akpm@linux-foundation.org>,
        <david@fromorbit.com>, <hch@infradead.org>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>, <stable@kernel.org>
Subject: [RFC PATCH] mm/filemap: avoid buffered read/write race to read inconsistent data
Date:   Tue, 12 Dec 2023 17:36:34 +0800
Message-ID: <20231212093634.2464108-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following concurrency may cause the data read to be inconsistent with
the data on disk:

             cpu1                           cpu2
------------------------------|------------------------------
                               // Buffered write 2048 from 0
                               ext4_buffered_write_iter
                                generic_perform_write
                                 copy_page_from_iter_atomic
                                 ext4_da_write_end
                                  ext4_da_do_write_end
                                   block_write_end
                                    __block_commit_write
                                     folio_mark_uptodate
// Buffered read 4096 from 0          smp_wmb()
ext4_file_read_iter                   set_bit(PG_uptodate, folio_flags)
 generic_file_read_iter            i_size_write // 2048
  filemap_read                     unlock_page(page)
   filemap_get_pages
    filemap_get_read_batch
    folio_test_uptodate(folio)
     ret = test_bit(PG_uptodate, folio_flags)
     if (ret)
      smp_rmb();
      // Ensure that the data in page 0-2048 is up-to-date.

                               // New buffered write 2048 from 2048
                               ext4_buffered_write_iter
                                generic_perform_write
                                 copy_page_from_iter_atomic
                                 ext4_da_write_end
                                  ext4_da_do_write_end
                                   block_write_end
                                    __block_commit_write
                                     folio_mark_uptodate
                                      smp_wmb()
                                      set_bit(PG_uptodate, folio_flags)
                                   i_size_write // 4096
                                   unlock_page(page)

   isize = i_size_read(inode) // 4096
   // Read the latest isize 4096, but without smp_rmb(), there may be
   // Load-Load disorder resulting in the data in the 2048-4096 range
   // in the page is not up-to-date.
   copy_page_to_iter
   // copyout 4096

In the concurrency above, we read the updated i_size, but there is no read
barrier to ensure that the data in the page is the same as the i_size at
this point, so we may copy the unsynchronized page out. Hence adding the
missing read memory barrier to fix this.

This is a Load-Load reordering issue, which only occurs on some weak
mem-ordering architectures (e.g. ARM64, ALPHA), but not on strong
mem-ordering architectures (e.g. X86). And theoretically the problem
doesn't only happen on ext4, filesystems that call filemap_read() but
don't hold inode lock (e.g. btrfs, f2fs, ubifs ...) will have this
problem, while filesystems with inode lock (e.g. xfs, nfs) won't have
this problem.

Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 mm/filemap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 71f00539ac00..6324e2ac3e74 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2607,6 +2607,9 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 			goto put_folios;
 		end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
 
+		/* Ensure that the page cache within isize is updated. */
+		smp_rmb();
+
 		/*
 		 * Once we start copying data, we don't want to be touching any
 		 * cachelines that might be contended:
-- 
2.31.1


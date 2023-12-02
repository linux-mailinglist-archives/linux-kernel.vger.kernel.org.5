Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BCC801B9E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjLBJKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjLBJKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:10:42 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7BB11C;
        Sat,  2 Dec 2023 01:10:47 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Sj3vP3VCHzShK4;
        Sat,  2 Dec 2023 17:06:25 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 2 Dec
 2023 17:10:45 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-mm@kvack.org>, <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <willy@infradead.org>, <akpm@linux-foundation.org>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH -RFC 1/2] mm: avoid data corruption when extending DIO write race with buffered read
Date:   Sat, 2 Dec 2023 17:14:31 +0800
Message-ID: <20231202091432.8349-2-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231202091432.8349-1-libaokun1@huawei.com>
References: <20231202091432.8349-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
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

When DIO write and buffered read are performed on the same file on two
CPUs, the following race may occur:

          cpu1                           cpu2
 Direct write 1024 from 4096 | Buffered read 8192 from 0
-----------------------------|----------------------------
...                           ...
 ext4_file_write_iter
  ext4_dio_write_iter
   iomap_dio_rw
   ...
                               ext4_file_read_iter
                                generic_file_read_iter
                                 filemap_read
                                  filemap_get_pages
                                   ...
                                    ext4_mpage_readpages
                                     ext4_readpage_limit(inode)
                                      i_size_read(inode) // 4096
    ext4_dio_write_end_io
     i_size_write(inode, 5120)
                                   i_size_read(inode) // 5120

1. read alloc 8192

  0                                      8192
  |-------------------|-------------------|

2. read form disk (i_size 4096)

  0   filled data   4096  filled zero    8192
  |-------------------|-------------------|

3. copyout (i_size 5120)

  0 copyout to uset buffer 5120          8192
  |------------------------|--------------|
                      |~~~~|
                   Inconsistent data

In the above race, because of the change of inode_size, the actual data
read from the disk is only 4096 bytes, but copied to the user's buffer
5120 bytes, including 1024 bytes of zero-filled tail page, which results
in the data read by the user is not consistent with the data on the disk.

To solve this problem completely, we should take the lesser of the number
of bytes actually read or the inode_size and use that as the final read
size. The problem here is that we don't know how many bytes of valid data
filemap_get_pages() reads, or how many bytes of valid data are in a page,
so we have to rely on inode_size to determine the range of valid data.

So we read the inode_size before and after filemap_get_pages(), and take
the smaller of the two as the size of the copyout to reduce the
probability of the above issue being triggered.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 mm/filemap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 71f00539ac00..47c1729afbb4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2587,7 +2587,8 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		if ((iocb->ki_flags & IOCB_WAITQ) && already_read)
 			iocb->ki_flags |= IOCB_NOWAIT;
 
-		if (unlikely(iocb->ki_pos >= i_size_read(inode)))
+		isize = i_size_read(inode);
+		if (unlikely(iocb->ki_pos >= isize))
 			break;
 
 		error = filemap_get_pages(iocb, iter->count, &fbatch, false);
@@ -2602,7 +2603,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		 * part of the page is not copied back to userspace (unless
 		 * another truncate extends the file - this is desired though).
 		 */
-		isize = i_size_read(inode);
+		isize = min_t(loff_t, isize, i_size_read(inode));
 		if (unlikely(iocb->ki_pos >= isize))
 			goto put_folios;
 		end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
-- 
2.31.1


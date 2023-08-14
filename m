Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CF077B2EC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjHNHr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjHNHrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:47:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6B4115;
        Mon, 14 Aug 2023 00:47:18 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RPRHS6d9Kz2BdD6;
        Mon, 14 Aug 2023 15:44:20 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 15:47:15 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>,
        Yikebaer Aizezi <yikebaer61@gmail.com>
Subject: [PATCH] ext4: fix slab-use-after-free in ext4_es_insert_extent()
Date:   Mon, 14 Aug 2023 15:43:51 +0800
Message-ID: <20230814074351.96741-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yikebaer reported an issue:
==================================================================
BUG: KASAN: slab-use-after-free in ext4_es_insert_extent+0xc68/0xcb0
fs/ext4/extents_status.c:894
Read of size 4 at addr ffff888112ecc1a4 by task syz-executor/8438

CPU: 1 PID: 8438 Comm: syz-executor Not tainted 6.5.0-rc5 #1
Call Trace:
 [...]
 kasan_report+0xba/0xf0 mm/kasan/report.c:588
 ext4_es_insert_extent+0xc68/0xcb0 fs/ext4/extents_status.c:894
 ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
 ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
 ext4_zero_range fs/ext4/extents.c:4622 [inline]
 ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
 [...]

Allocated by task 8438:
 [...]
 kmem_cache_zalloc include/linux/slab.h:693 [inline]
 __es_alloc_extent fs/ext4/extents_status.c:469 [inline]
 ext4_es_insert_extent+0x672/0xcb0 fs/ext4/extents_status.c:873
 ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
 ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
 ext4_zero_range fs/ext4/extents.c:4622 [inline]
 ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
 [...]

Freed by task 8438:
 [...]
 kmem_cache_free+0xec/0x490 mm/slub.c:3823
 ext4_es_try_to_merge_right fs/ext4/extents_status.c:593 [inline]
 __es_insert_extent+0x9f4/0x1440 fs/ext4/extents_status.c:802
 ext4_es_insert_extent+0x2ca/0xcb0 fs/ext4/extents_status.c:882
 ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
 ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
 ext4_zero_range fs/ext4/extents.c:4622 [inline]
 ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
 [...]
==================================================================

The flow of issue triggering is as follows:
1. remove es
      raw es               es  removed  es1
|-------------------| -> |----|.......|------|

2. insert es
  es   insert   es1      merge with es  es1     merge with es and free es1
|----|.......|------| -> |------------|------| -> |-------------------|

es merges with newes, then merges with es1, frees es1, then determines
if es1->es_len is 0 and triggers a UAF.

The code flow is as follows:
ext4_es_insert_extent
  es1 = __es_alloc_extent(true);
  es2 = __es_alloc_extent(true);
  __es_remove_extent(inode, lblk, end, NULL, es1)
    __es_insert_extent(inode, &newes, es1) ---> insert es1 to es tree
  __es_insert_extent(inode, &newes, es2)
    ext4_es_try_to_merge_right
      ext4_es_free_extent(inode, es1) --->  es1 is freed
  if (es1 && !es1->es_len)
    // Trigger UAF by determining if es1 is used.

We determine whether es1 or es2 is used immediately after calling
__es_remove_extent() or __es_insert_extent() to avoid triggering a
UAF if es1 or es2 is freed.

Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>
Closes: https://lore.kernel.org/lkml/CALcu4raD4h9coiyEBL4Bm0zjDwxC2CyPiTwsP3zFuhot6y9Beg@mail.gmail.com
Fixes: 2a69c450083d ("ext4: using nofail preallocation in ext4_es_insert_extent()")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents_status.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 9b5b8951afb4..cceac517265f 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -878,23 +878,21 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
 	if (err1 != 0)
 		goto error;
+	if (es1 && !es1->es_len)
+		__es_free_extent(es1);
 
 	err2 = __es_insert_extent(inode, &newes, es2);
 	if (err2 == -ENOMEM && !ext4_es_must_keep(&newes))
 		err2 = 0;
 	if (err2 != 0)
 		goto error;
+	if (es2 && !es2->es_len)
+		__es_free_extent(es2);
 
 	if (sbi->s_cluster_ratio > 1 && test_opt(inode->i_sb, DELALLOC) &&
 	    (status & EXTENT_STATUS_WRITTEN ||
 	     status & EXTENT_STATUS_UNWRITTEN))
 		__revise_pending(inode, lblk, len);
-
-	/* es is pre-allocated but not used, free it. */
-	if (es1 && !es1->es_len)
-		__es_free_extent(es1);
-	if (es2 && !es2->es_len)
-		__es_free_extent(es2);
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 	if (err1 || err2)
@@ -2047,19 +2045,17 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 	err1 = __es_remove_extent(inode, lblk, lblk, NULL, es1);
 	if (err1 != 0)
 		goto error;
+	if (es1 && !es1->es_len)
+		__es_free_extent(es1);
 
 	err2 = __es_insert_extent(inode, &newes, es2);
 	if (err2 != 0)
 		goto error;
+	if (es2 && !es2->es_len)
+		__es_free_extent(es2);
 
 	if (allocated)
 		__insert_pending(inode, lblk);
-
-	/* es is pre-allocated but not used, free it. */
-	if (es1 && !es1->es_len)
-		__es_free_extent(es1);
-	if (es2 && !es2->es_len)
-		__es_free_extent(es2);
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 	if (err1 || err2)
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74877F99D7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 07:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjK0G3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 01:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK0G3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 01:29:16 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F63CE;
        Sun, 26 Nov 2023 22:29:22 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Sdwdf3Q83zWhsG;
        Mon, 27 Nov 2023 14:28:38 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 Nov
 2023 14:29:18 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <djwong@kernel.org>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>, <stable@kernel.org>
Subject: [PATCH] ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS
Date:   Mon, 27 Nov 2023 14:33:13 +0800
Message-ID: <20231127063313.3734294-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For files with logical blocks close to EXT_MAX_BLOCKS, the file size
predicted in ext4_mb_normalize_request() may exceed EXT_MAX_BLOCKS.
This can cause some blocks to be preallocated that will not be used.
And after [Fixes], the following issue may be triggered:

=========================================================
 kernel BUG at fs/ext4/mballoc.c:4653!
 Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
 CPU: 1 PID: 2357 Comm: xfs_io 6.7.0-rc2-00195-g0f5cc96c367f
 Hardware name: linux,dummy-virt (DT)
 pc : ext4_mb_use_inode_pa+0x148/0x208
 lr : ext4_mb_use_inode_pa+0x98/0x208
 Call trace:
  ext4_mb_use_inode_pa+0x148/0x208
  ext4_mb_new_inode_pa+0x240/0x4a8
  ext4_mb_use_best_found+0x1d4/0x208
  ext4_mb_try_best_found+0xc8/0x110
  ext4_mb_regular_allocator+0x11c/0xf48
  ext4_mb_new_blocks+0x790/0xaa8
  ext4_ext_map_blocks+0x7cc/0xd20
  ext4_map_blocks+0x170/0x600
  ext4_iomap_begin+0x1c0/0x348
=========================================================

Here is a calculation when adjusting ac_b_ex in ext4_mb_new_inode_pa():

	ex.fe_logical = orig_goal_end - EXT4_C2B(sbi, ex.fe_len);
	if (ac->ac_o_ex.fe_logical >= ex.fe_logical)
		goto adjust_bex;

The problem is that when orig_goal_end is subtracted from ac_b_ex.fe_len
it is still greater than EXT_MAX_BLOCKS, which causes ex.fe_logical to
overflow to a very small value, which ultimately triggers a BUG_ON in
ext4_mb_new_inode_pa() because pa->pa_free < len.

The last logical block of an actual write request does not exceed
EXT_MAX_BLOCKS, so in ext4_mb_normalize_request() also avoids normalizing
the last logical block to exceed EXT_MAX_BLOCKS to avoid the above issue.

The test case in [Link] can reproduce the above issue with 64k block size.

Link: https://patchwork.kernel.org/project/fstests/list/?series=804003
Cc: stable@kernel.org # 6.4
Fixes: 93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 454d5612641e..d72b5e3c92ec 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4478,6 +4478,10 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	start = max(start, rounddown(ac->ac_o_ex.fe_logical,
 			(ext4_lblk_t)EXT4_BLOCKS_PER_GROUP(ac->ac_sb)));
 
+	/* avoid unnecessary preallocation that may trigger assertions */
+	if (start + size > EXT_MAX_BLOCKS)
+		size = EXT_MAX_BLOCKS - start;
+
 	/* don't cover already allocated blocks in selected range */
 	if (ar->pleft && start <= ar->lleft) {
 		size -= ar->lleft + 1 - start;
-- 
2.31.1


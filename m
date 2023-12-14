Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E67812859
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbjLNGnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjLNGnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:43:00 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDC2E8;
        Wed, 13 Dec 2023 22:43:06 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SrN7X385mzvS8H;
        Thu, 14 Dec 2023 14:42:16 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
        by mail.maildlp.com (Postfix) with ESMTPS id 388BB140258;
        Thu, 14 Dec 2023 14:43:04 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 14:43:03 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH] ext4: fix inconsistent between segment fstrim and full fstrim
Date:   Thu, 14 Dec 2023 14:46:35 +0800
Message-ID: <20231214064635.4128391-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There will not issue discard cmd when do segment fstrim for ext4 fs, however,
if full fstrim for the same fs will issue discard cmd.
Above issue may happens as follows:
Precondition:
1. Fstrim range [0, 15] and [16, 31];
2. Discard granularity is 16;
            Range1          Range2
      1111000000000000 0000111010101011
There's no free space length large or equal than 16 in 'Range1' or 'Range2'.
As ext4_try_to_trim_range() only search free space among range which user
specified. However, there's maximum free space length 16 in 'Range1'+ 'Range2'.
To solve above issue, we need to find the longest free space to discard.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/mballoc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d72b5e3c92ec..d195461123d8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6753,13 +6753,15 @@ static int ext4_try_to_trim_range(struct super_block *sb,
 __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
 __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 {
-	ext4_grpblk_t next, count, free_count;
+	ext4_grpblk_t next, count, free_count, last, origin_start;
 	bool set_trimmed = false;
 	void *bitmap;
 
+	last = ext4_last_grp_cluster(sb, e4b->bd_group);
 	bitmap = e4b->bd_bitmap;
-	if (start == 0 && max >= ext4_last_grp_cluster(sb, e4b->bd_group))
+	if (start == 0 && max >= last)
 		set_trimmed = true;
+	origin_start = start;
 	start = max(e4b->bd_info->bb_first_free, start);
 	count = 0;
 	free_count = 0;
@@ -6768,7 +6770,10 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 		start = mb_find_next_zero_bit(bitmap, max + 1, start);
 		if (start > max)
 			break;
-		next = mb_find_next_bit(bitmap, max + 1, start);
+
+		next = mb_find_next_bit(bitmap, last + 1, start);
+		if (origin_start == 0 && next >= last)
+			set_trimmed = true;
 
 		if ((next - start) >= minblocks) {
 			int ret = ext4_trim_extent(sb, start, next - start, e4b);
-- 
2.31.1


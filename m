Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F7B7EA0D1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjKMQCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjKMQCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:02:02 -0500
Received: from p3plwbeout26-05.prod.phx3.secureserver.net (p3plsmtp26-05-2.prod.phx3.secureserver.net [216.69.139.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E6610E0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 08:01:59 -0800 (PST)
Received: from mailex.mailcore.me ([94.136.40.141])
        by :WBEOUT: with ESMTP
        id 2ZNrrymn4PonD2ZNsrpaIQ; Mon, 13 Nov 2023 09:01:56 -0700
X-CMAE-Analysis: v=2.4 cv=buOJuGWi c=1 sm=1 tr=0 ts=65524876
 a=bheWAUFm1xGnSTQFbH9Kqg==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=BNY50KLci1gA:10 a=FXvPX3liAAAA:8 a=hSkVLCK3AAAA:8
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=1vtFuu_CsGziJmJeKaIA:9
 a=UObqyxdv-6Yh2QiB9mM_:22 a=cQPPKAXgyycSBL8etih5:22 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  2ZNrrymn4PonD
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=phoenix.fritz.box)
        by smtp11.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1r2ZNq-00059Q-8m; Mon, 13 Nov 2023 16:01:54 +0000
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     phillip.lougher@gmail.com,
        Phillip Lougher <phillip@squashfs.org.uk>,
        syzbot+604424eb051c2f696163@syzkaller.appspotmail.com
Subject: [PATCH] Squashfs: Fix variable overflow triggered by sysbot
Date:   Mon, 13 Nov 2023 16:09:01 +0000
Message-Id: <20231113160901.6444-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfKl0o8nHtPKt6/a9jhdiA+E5wEVgl0O7EQqbmndmwia9dTNVYF0A59a8mlB4tVjwMBp4iGyNoTEKOjDLT9bykFCRhrpnwqaNeoptohIFLf1fhCAIPgpa
 M/w12yNmi1Pid5wReiKmzPJGo/Bo4Ifcy6XRkilUBouJyOIkPWMkkCNt6gBTToRk1HWqHpngaSBWZcgmxJq+0Jnby3zjfsQtG2Q=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sysbot reports a slab out of bounds write in squashfs_readahead().

This is ultimately caused by a file reporting an (infeasibly) large file
size (1407374883553280 bytes) with the minimum block size of 4K.

This causes variable overflow.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Reported-by: syzbot+604424eb051c2f696163@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000b1fda20609ede0d1@google.com/
---
 fs/squashfs/file.c        | 3 ++-
 fs/squashfs/file_direct.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 8ba8c4c50770..e8df6430444b 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -544,7 +544,8 @@ static void squashfs_readahead(struct readahead_control *ractl)
 	struct squashfs_page_actor *actor;
 	unsigned int nr_pages = 0;
 	struct page **pages;
-	int i, file_end = i_size_read(inode) >> msblk->block_log;
+	int i;
+	loff_t file_end = i_size_read(inode) >> msblk->block_log;
 	unsigned int max_pages = 1UL << shift;
 
 	readahead_expand(ractl, start, (len | mask) + 1);
diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index f1ccad519e28..763a3f7a75f6 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -26,10 +26,10 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	struct inode *inode = target_page->mapping->host;
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
 
-	int file_end = (i_size_read(inode) - 1) >> PAGE_SHIFT;
+	loff_t file_end = (i_size_read(inode) - 1) >> PAGE_SHIFT;
 	int mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
-	int start_index = target_page->index & ~mask;
-	int end_index = start_index | mask;
+	loff_t start_index = target_page->index & ~mask;
+	loff_t end_index = start_index | mask;
 	int i, n, pages, bytes, res = -ENOMEM;
 	struct page **page;
 	struct squashfs_page_actor *actor;
-- 
2.35.1


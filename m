Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCA780BA02
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 10:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjLJJ2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 04:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjLJJUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 04:20:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9C4119
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 01:20:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40CFC433C7;
        Sun, 10 Dec 2023 09:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702200055;
        bh=eUCNfxU2ZBnjWJhSbW0ed8WQRjl0G3WQDgSCqx5F8l4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CsAAwj/MMr5jSOHLX75QKHpCQxJtZVXufXnZ6XxIMswho/8WFi8muJOhFEAk0mBNc
         82vlvK36Hj45Wn+lAU52WNuPlO7MFhdvSjTgjBBwFUAh22Mjr1BnZ71MHQA/NSZiVO
         NQp+nEztmeLMTbKh9DaYeM6ztfhmTRbAgmQq6nbZoH6+BWj2/L5LX6hM/FyV+gUVeM
         3B5BxJ4kJ/+MsnVvRR+sNYzJfzdJv6pgxe0kxvwqbU1LvLMXxE/kxscHdcKZOtMWVg
         CMT6YQWKIS+EPzY5xwXZyEY97SJucA/U9M40cxsnrmCIqk53e5WtASetoCsJ+B5xd4
         pLncCxPkj9n2Q==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 5/6] f2fs: introduce f2fs_invalidate_internal_cache() for cleanup
Date:   Sun, 10 Dec 2023 17:20:39 +0800
Message-Id: <20231210092040.3374741-5-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231210092040.3374741-1-chao@kernel.org>
References: <20231210092040.3374741-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just cleanup, no logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c    |  8 +++-----
 fs/f2fs/f2fs.h    |  7 +++++++
 fs/f2fs/gc.c      |  5 ++---
 fs/f2fs/segment.c | 14 ++++----------
 4 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d86419b01310..27015b7875ae 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1484,11 +1484,9 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 	old_blkaddr = dn->data_blkaddr;
 	f2fs_allocate_data_block(sbi, NULL, old_blkaddr, &dn->data_blkaddr,
 				&sum, seg_type, NULL);
-	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO) {
-		invalidate_mapping_pages(META_MAPPING(sbi),
-					old_blkaddr, old_blkaddr);
-		f2fs_invalidate_compress_page(sbi, old_blkaddr);
-	}
+	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
+		f2fs_invalidate_internal_cache(sbi, old_blkaddr);
+
 	f2fs_update_data_blkaddr(dn, dn->data_blkaddr);
 	return 0;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 50e666ebd987..65294e3b0bef 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4613,6 +4613,13 @@ static inline bool f2fs_is_readonly(struct f2fs_sb_info *sbi)
 	return f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb);
 }
 
+static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
+								block_t blkaddr)
+{
+	invalidate_mapping_pages(META_MAPPING(sbi), blkaddr, blkaddr);
+	f2fs_invalidate_compress_page(sbi, blkaddr);
+}
+
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2fbe16ad726f..405a6077bd83 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1380,9 +1380,8 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	memcpy(page_address(fio.encrypted_page),
 				page_address(mpage), PAGE_SIZE);
 	f2fs_put_page(mpage, 1);
-	invalidate_mapping_pages(META_MAPPING(fio.sbi),
-				fio.old_blkaddr, fio.old_blkaddr);
-	f2fs_invalidate_compress_page(fio.sbi, fio.old_blkaddr);
+
+	f2fs_invalidate_internal_cache(fio.sbi, fio.old_blkaddr);
 
 	set_page_dirty(fio.encrypted_page);
 	if (clear_page_dirty_for_io(fio.encrypted_page))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 007ebb107236..61da26eb61cc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2500,8 +2500,7 @@ void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
 	if (addr == NEW_ADDR || addr == COMPRESS_ADDR)
 		return;
 
-	invalidate_mapping_pages(META_MAPPING(sbi), addr, addr);
-	f2fs_invalidate_compress_page(sbi, addr);
+	f2fs_invalidate_internal_cache(sbi, addr);
 
 	/* add it into sit main buffer */
 	down_write(&sit_i->sentry_lock);
@@ -3562,11 +3561,8 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 reallocate:
 	f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
 			&fio->new_blkaddr, sum, type, fio);
-	if (GET_SEGNO(fio->sbi, fio->old_blkaddr) != NULL_SEGNO) {
-		invalidate_mapping_pages(META_MAPPING(fio->sbi),
-					fio->old_blkaddr, fio->old_blkaddr);
-		f2fs_invalidate_compress_page(fio->sbi, fio->old_blkaddr);
-	}
+	if (GET_SEGNO(fio->sbi, fio->old_blkaddr) != NULL_SEGNO)
+		f2fs_invalidate_internal_cache(fio->sbi, fio->old_blkaddr);
 
 	/* writeout dirty page into bdev */
 	f2fs_submit_page_write(fio);
@@ -3762,9 +3758,7 @@ void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		update_sit_entry(sbi, new_blkaddr, 1);
 	}
 	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO) {
-		invalidate_mapping_pages(META_MAPPING(sbi),
-					old_blkaddr, old_blkaddr);
-		f2fs_invalidate_compress_page(sbi, old_blkaddr);
+		f2fs_invalidate_internal_cache(sbi, old_blkaddr);
 		if (!from_gc)
 			update_segment_mtime(sbi, old_blkaddr, 0);
 		update_sit_entry(sbi, old_blkaddr, -1);
-- 
2.40.1


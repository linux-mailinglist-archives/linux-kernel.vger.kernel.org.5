Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEF480B9F9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 10:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjLJJU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 04:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjLJJUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 04:20:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876CF114
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 01:20:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9093C433C9;
        Sun, 10 Dec 2023 09:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702200053;
        bh=vqEZwoEd5rfiidnh92i4EHLdEHwAQGZ/XdcKXiscRKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ob1j+7BAs0/X61wciJwW/sUV+jUXQf0THBWwC3jP3ipOPJe1CkI/I/JK/aBzMHKaX
         dyifLL0VLLk7wn+QZazE6k8/3i7kZwSiWC6218uvfcyUGIx+Zg61YnwaGrvL7D6+aj
         5kaMnc8NJsDwmLan3iQNHzbMgHiTgnJzUTB3dROVLZZzS1Rlk0h/M2inR6X6r6oLh9
         q44NGfqHB08B85U1B4715rn8Che6Xa4UBsgoVwFX+lCPOBQX756T95DUHdzOVx5CAa
         6ROdXkv1oHTF2rChZxax/hz3eknBA/iSJ0RSm+nle2vkn2HMM31zHHgk57r360tofm
         Y9e8nxCeDOb5Q==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 4/6] f2fs: update blkaddr in __set_data_blkaddr() for cleanup
Date:   Sun, 10 Dec 2023 17:20:38 +0800
Message-Id: <20231210092040.3374741-4-chao@kernel.org>
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

This patch allows caller to pass blkaddr to f2fs_set_data_blkaddr()
and let __set_data_blkaddr() inside f2fs_set_data_blkaddr() to update
dn->data_blkaddr w/ last value of blkaddr.

Just cleanup, no logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 13 ++++++-------
 fs/f2fs/f2fs.h |  2 +-
 fs/f2fs/file.c | 12 ++++--------
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ae46c4841ca9..d86419b01310 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1179,10 +1179,11 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 	return 0;
 }
 
-static void __set_data_blkaddr(struct dnode_of_data *dn)
+static void __set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
 {
 	__le32 *addr = get_dnode_addr(dn->inode, dn->node_page);
 
+	dn->data_blkaddr = blkaddr;
 	addr[dn->ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
 }
 
@@ -1192,18 +1193,17 @@ static void __set_data_blkaddr(struct dnode_of_data *dn)
  *  ->node_page
  *    update block addresses in the node page
  */
-void f2fs_set_data_blkaddr(struct dnode_of_data *dn)
+void f2fs_set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
 {
 	f2fs_wait_on_page_writeback(dn->node_page, NODE, true, true);
-	__set_data_blkaddr(dn);
+	__set_data_blkaddr(dn, blkaddr);
 	if (set_page_dirty(dn->node_page))
 		dn->node_changed = true;
 }
 
 void f2fs_update_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
 {
-	dn->data_blkaddr = blkaddr;
-	f2fs_set_data_blkaddr(dn);
+	f2fs_set_data_blkaddr(dn, blkaddr);
 	f2fs_update_read_extent_cache(dn);
 }
 
@@ -1230,8 +1230,7 @@ int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
 		block_t blkaddr = f2fs_data_blkaddr(dn);
 
 		if (blkaddr == NULL_ADDR) {
-			dn->data_blkaddr = NEW_ADDR;
-			__set_data_blkaddr(dn);
+			__set_data_blkaddr(dn, NEW_ADDR);
 			count--;
 		}
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a06b8aad5117..50e666ebd987 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3822,7 +3822,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio);
 struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
 		block_t blk_addr, sector_t *sector);
 int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr);
-void f2fs_set_data_blkaddr(struct dnode_of_data *dn);
+void f2fs_set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr);
 void f2fs_update_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr);
 int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count);
 int f2fs_reserve_new_block(struct dnode_of_data *dn);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d0e7894e42d4..3c7e6bfc1265 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -582,8 +582,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		if (blkaddr == NULL_ADDR)
 			continue;
 
-		dn->data_blkaddr = NULL_ADDR;
-		f2fs_set_data_blkaddr(dn);
+		f2fs_set_data_blkaddr(dn, NULL_ADDR);
 
 		if (__is_valid_data_blkaddr(blkaddr)) {
 			if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
@@ -1478,8 +1477,7 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 		}
 
 		f2fs_invalidate_blocks(sbi, dn->data_blkaddr);
-		dn->data_blkaddr = NEW_ADDR;
-		f2fs_set_data_blkaddr(dn);
+		f2fs_set_data_blkaddr(dn, NEW_ADDR);
 	}
 
 	f2fs_update_read_extent_cache_range(dn, start, 0, index - start);
@@ -3454,8 +3452,7 @@ static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 			if (blkaddr != NEW_ADDR)
 				continue;
 
-			dn->data_blkaddr = NULL_ADDR;
-			f2fs_set_data_blkaddr(dn);
+			f2fs_set_data_blkaddr(dn, NULL_ADDR);
 		}
 
 		f2fs_i_compr_blocks_update(dn->inode, compr_blocks, false);
@@ -3621,8 +3618,7 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 				continue;
 			}
 
-			dn->data_blkaddr = NEW_ADDR;
-			f2fs_set_data_blkaddr(dn);
+			f2fs_set_data_blkaddr(dn, NEW_ADDR);
 		}
 
 		reserved = cluster_size - compr_blocks;
-- 
2.40.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D287576BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjGRIiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjGRIiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:38:00 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECF7E55
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:37:58 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b8ad356fe4so33424905ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689669478; x=1692261478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=30h3KzD2w48K2b2PswKmzqqYtrtvBjqTQadg4ahh90s=;
        b=bOJ6K71cCVm6DplYNQv9p3wn+qKHMIc4I+ZLZ7zGmYk6ebDDJ5zRgl1AyGPcHSnQwl
         3tP3Tvi/ziPemczNb/TLxLEMLmnROD5nXxxX3URdZ4TVrPEhTBBND2CJAIj4GrZk2tSX
         7TUJNPe4L4+a7ZOtlWsxyAQPAQ+L4s0EPCQPyJTnkw0aVVP/Mu1DjHvcT12LUGjZpVRa
         Cn+JC3xtwaNo7LlBJlqiQs33ciaFevALpHby8Fesj5TrTC7bye8JAbocSFp9SxqU3FUY
         RlK+tEIlniFq2+SVEyPPMw0wtlsmcG8SU2qt7giEl+DV17lPAE46mUuRvqitP35lUMtP
         /WWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689669478; x=1692261478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30h3KzD2w48K2b2PswKmzqqYtrtvBjqTQadg4ahh90s=;
        b=hXgD6oMHhbGdvpZPDDeDLNgyoi/qHkxde52PAn7oeT2IA588lRzpOpkmyv4AgeYU+6
         Qi0LzweBZTnz3Bg8nP+RC085+Njq0TAWgwq5/FRBcMyw0mLX5cTYAABqgjf7KRIEBEky
         WUlT2/bMtzc4a5aM1iITk1A10ywdvnYEZsGIjH7RrAyv53RP90KCh2i86zL4t2DgQKI6
         NeinPIjiU6kt38ABfbXokwY748xsIgx4cgbgGdXfFaaxAil3OmkqQoHNPkab2im0B7GN
         LDN5dlI8Bg/n+7kiTp0qCLIdv8EDbagFls/cq+WO3aERyoFfDZgqK9xNvAuZ2BKGfig0
         2VkQ==
X-Gm-Message-State: ABy/qLZnyry4d2aHRe3hMn4TDQMPFkFy0lqKjpct9XQsiGAVLIdz/KWV
        oU7yg36KjSxn7tpIFW5YC8s=
X-Google-Smtp-Source: APBJJlGVlccV5qjxxEhrAFezTsAhu/iOZCzOLJ5EZgBoIcb9uGek8/yf/wFF/6I5w4DqPUy4ClKAVw==
X-Received: by 2002:a17:903:32c6:b0:1bb:3a7:6af7 with SMTP id i6-20020a17090332c600b001bb03a76af7mr2031650plr.23.1689669477654;
        Tue, 18 Jul 2023 01:37:57 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id a1-20020a170902900100b001b8c689060dsm1262817plp.28.2023.07.18.01.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 01:37:57 -0700 (PDT)
From:   Chao Liu <chaoliu719@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Liu <liuchao@coolpad.com>
Subject: [PATCH] f2fs: introduce two helper functions for the largest cached extent
Date:   Tue, 18 Jul 2023 16:33:10 +0800
Message-Id: <20230718083310.367067-1-chaoliu719@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Liu <liuchao@coolpad.com>

This patch is a cleanup:
1. Merge __drop_largest_extent() since it has only one caller.
2. Introduce __notify_largest_extent_updated() and
   __drop_largest_extent() to help manage largest and largest_update
   in extent_tree.

Signed-off-by: Chao Liu <liuchao@coolpad.com>
---
 fs/f2fs/extent_cache.c | 60 +++++++++++++++++++-----------------------
 fs/f2fs/f2fs.h         |  4 +--
 2 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 0e2d49140c07f..45dfddd8c3ad0 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -19,6 +19,12 @@
 #include "node.h"
 #include <trace/events/f2fs.h>
 
+static void __drop_largest_extent(struct extent_tree *et)
+{
+	et->largest.len = 0;
+	et->largest_updated = true;
+}
+
 bool sanity_check_extent_cache(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -35,8 +41,7 @@ bool sanity_check_extent_cache(struct inode *inode)
 
 	/* Let's drop, if checkpoint got corrupted. */
 	if (is_set_ckpt_flags(sbi, CP_ERROR_FLAG)) {
-		ei->len = 0;
-		et->largest_updated = true;
+		__drop_largest_extent(et);
 		return true;
 	}
 
@@ -310,6 +315,8 @@ static void __detach_extent_node(struct f2fs_sb_info *sbi,
 
 	if (et->cached_en == en)
 		et->cached_en = NULL;
+
+	/* keep the largest as we can still use it */
 	kmem_cache_free(extent_node_slab, en);
 }
 
@@ -385,15 +392,6 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 	return count - atomic_read(&et->node_cnt);
 }
 
-static void __drop_largest_extent(struct extent_tree *et,
-					pgoff_t fofs, unsigned int len)
-{
-	if (fofs < et->largest.fofs + et->largest.len &&
-			fofs + len > et->largest.fofs) {
-		et->largest.len = 0;
-		et->largest_updated = true;
-	}
-}
 
 void f2fs_init_read_extent_tree(struct inode *inode, struct page *ipage)
 {
@@ -601,6 +599,15 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 	return en;
 }
 
+static void __notify_largest_extent_updated(struct extent_tree *et,
+					struct inode *inode)
+{
+	if (et->type == EX_READ && et->largest_updated) {
+		f2fs_mark_inode_dirty_sync(inode, true);
+		et->largest_updated = false;
+	}
+}
+
 static void __update_extent_tree_range(struct inode *inode,
 			struct extent_info *tei, enum extent_type type)
 {
@@ -612,7 +619,6 @@ static void __update_extent_tree_range(struct inode *inode,
 	struct rb_node **insert_p = NULL, *insert_parent = NULL;
 	unsigned int fofs = tei->fofs, len = tei->len;
 	unsigned int end = fofs + len;
-	bool updated = false;
 	bool leftmost = false;
 
 	if (!et)
@@ -636,11 +642,10 @@ static void __update_extent_tree_range(struct inode *inode,
 		prev = et->largest;
 		dei.len = 0;
 
-		/*
-		 * drop largest extent before lookup, in case it's already
-		 * been shrunk from extent tree
-		 */
-		__drop_largest_extent(et, fofs, len);
+		/* updates may cause largest extent cache to become invalid */
+		if (fofs < et->largest.fofs + et->largest.len &&
+		    fofs + len > et->largest.fofs)
+			__drop_largest_extent(et);
 	}
 
 	/* 1. lookup first extent node in range [fofs, fofs + len - 1] */
@@ -733,8 +738,7 @@ static void __update_extent_tree_range(struct inode *inode,
 		if (dei.len >= 1 &&
 				prev.len < F2FS_MIN_EXTENT_LEN &&
 				et->largest.len < F2FS_MIN_EXTENT_LEN) {
-			et->largest.len = 0;
-			et->largest_updated = true;
+			__drop_largest_extent(et);
 			set_inode_flag(inode, FI_NO_EXTENT);
 		}
 	}
@@ -742,10 +746,6 @@ static void __update_extent_tree_range(struct inode *inode,
 	if (is_inode_flag_set(inode, FI_NO_EXTENT))
 		__free_extent_tree(sbi, et);
 
-	if (et->largest_updated) {
-		et->largest_updated = false;
-		updated = true;
-	}
 	goto out_read_extent_cache;
 update_age_extent_cache:
 	if (!tei->last_blocks)
@@ -758,9 +758,7 @@ static void __update_extent_tree_range(struct inode *inode,
 					insert_p, insert_parent, leftmost);
 out_read_extent_cache:
 	write_unlock(&et->lock);
-
-	if (updated)
-		f2fs_mark_inode_dirty_sync(inode, true);
+	__notify_largest_extent_updated(et, inode);
 }
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -1092,7 +1090,6 @@ static void __drop_extent_tree(struct inode *inode, enum extent_type type)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
-	bool updated = false;
 
 	if (!__may_extent_tree(inode, type))
 		return;
@@ -1101,14 +1098,11 @@ static void __drop_extent_tree(struct inode *inode, enum extent_type type)
 	__free_extent_tree(sbi, et);
 	if (type == EX_READ) {
 		set_inode_flag(inode, FI_NO_EXTENT);
-		if (et->largest.len) {
-			et->largest.len = 0;
-			updated = true;
-		}
+		if (et->largest.len)
+			__drop_largest_extent(et);
 	}
 	write_unlock(&et->lock);
-	if (updated)
-		f2fs_mark_inode_dirty_sync(inode, true);
+	__notify_largest_extent_updated(et, inode);
 }
 
 void f2fs_drop_extent_tree(struct inode *inode)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d372bedb0fe4e..da02e120e5ea6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -665,7 +665,7 @@ struct extent_tree {
 
 struct extent_tree_info {
 	struct radix_tree_root extent_tree_root;/* cache extent cache entries */
-	struct mutex extent_tree_lock;	/* locking extent radix tree */
+	struct mutex extent_tree_lock;		/* locking extent radix tree */
 	struct list_head extent_list;		/* lru list for shrinker */
 	spinlock_t extent_lock;			/* locking extent lru list */
 	atomic_t total_ext_tree;		/* extent tree count */
@@ -766,7 +766,7 @@ enum {
 	FI_ACL_MODE,		/* indicate acl mode */
 	FI_NO_ALLOC,		/* should not allocate any blocks */
 	FI_FREE_NID,		/* free allocated nide */
-	FI_NO_EXTENT,		/* not to use the extent cache */
+	FI_NO_EXTENT,		/* not to use the read extent cache */
 	FI_INLINE_XATTR,	/* used for inline xattr */
 	FI_INLINE_DATA,		/* used for inline data*/
 	FI_INLINE_DENTRY,	/* used for inline dentry */
-- 
2.25.1


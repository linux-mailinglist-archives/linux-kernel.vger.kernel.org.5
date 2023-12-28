Return-Path: <linux-kernel+bounces-12708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5630E81F927
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16E31F235B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDAC10A18;
	Thu, 28 Dec 2023 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmSofWjk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D214A10A05
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 14:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D12C433C7;
	Thu, 28 Dec 2023 14:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703773934;
	bh=DMeS2vfzkUxcLbmEcA5uRENvkQrQiVn9mfOWnIMYifg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmSofWjk0tLqQQ+T/uhhNBEC6ty3d+LAw22mvhDfzpzvKQP57gUXHJYINWjxXLHfi
	 OdV50N7uOKFuJ/CeavgeraTtHuEpfQPgpU85U3wBKYkj77N3uwVUBa757YBPIB82ZJ
	 d+cj9/Tr3jkWLTgK3eliYkSwiOQQW88+4E7sU7twC75256VNtxSIAyr1toQVo8zCuD
	 eIeT/p0sylF6om9W4XI9cN+L0kZ6ZKyfLtP0ccT4Y1DTzAzJvIetU5snF8pzNQBE5J
	 ASJx60lx8Td8hIZsIWLAXg4yUekJ93KDjGCA1smBPUF2mSiMuzq5utz9n9H0Y6w6VL
	 6wbb4xsA8lZrA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 6/6] f2fs: introduce FAULT_BLKADDR_INCONSISTENCE
Date: Thu, 28 Dec 2023 22:31:52 +0800
Message-Id: <20231228143152.1543509-6-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228143152.1543509-1-chao@kernel.org>
References: <20231228143152.1543509-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will encounter below inconsistent status when FAULT_BLKADDR type
fault injection is on.

Info: checkpoint state = d6 :  nat_bits crc fsck compacted_summary orphan_inodes sudden-power-off
[ASSERT] (fsck_chk_inode_blk:1254)  --> ino: 0x1c100 has i_blocks: 000000c0, but has 191 blocks
[FIX] (fsck_chk_inode_blk:1260)  --> [0x1c100] i_blocks=0x000000c0 -> 0xbf
[FIX] (fsck_chk_inode_blk:1269)  --> [0x1c100] i_compr_blocks=0x00000026 -> 0x27
[ASSERT] (fsck_chk_inode_blk:1254)  --> ino: 0x1cadb has i_blocks: 0000002f, but has 46 blocks
[FIX] (fsck_chk_inode_blk:1260)  --> [0x1cadb] i_blocks=0x0000002f -> 0x2e
[FIX] (fsck_chk_inode_blk:1269)  --> [0x1cadb] i_compr_blocks=0x00000011 -> 0x12
[ASSERT] (fsck_chk_inode_blk:1254)  --> ino: 0x1c62c has i_blocks: 00000002, but has 1 blocks
[FIX] (fsck_chk_inode_blk:1260)  --> [0x1c62c] i_blocks=0x00000002 -> 0x1

After we inject fault into f2fs_is_valid_blkaddr() during truncation,
a) it missed to increase @nr_free or @valid_blocks
b) it can cause in blkaddr leak in truncated dnode
Which may cause inconsistent status.

This patch separates FAULT_BLKADDR_INCONSISTENCE from FAULT_BLKADDR,
so that we can:
a) use FAULT_BLKADDR_INCONSISTENCE in f2fs_truncate_data_blocks_range()
to simulate inconsistent issue independently,
b) FAULT_BLKADDR fault will not cause any inconsistent status, we can
just use it to check error path handling in kernel side.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- rename FAULT_INCONSISTENCE as Jaegeuk's suggestion.
 Documentation/ABI/testing/sysfs-fs-f2fs | 47 +++++++++++++------------
 Documentation/filesystems/f2fs.rst      | 47 +++++++++++++------------
 fs/f2fs/checkpoint.c                    | 19 +++++++---
 fs/f2fs/f2fs.h                          |  3 ++
 fs/f2fs/file.c                          |  8 +++--
 fs/f2fs/super.c                         | 37 +++++++++----------
 6 files changed, 91 insertions(+), 70 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 4f1d4e636d67..039a16ebaaaf 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -686,29 +686,30 @@ Description:	Support configuring fault injection type, should be
 		enabled with fault_injection option, fault type value
 		is shown below, it supports single or combined type.
 
-		===================      ===========
-		Type_Name                Type_Value
-		===================      ===========
-		FAULT_KMALLOC            0x000000001
-		FAULT_KVMALLOC           0x000000002
-		FAULT_PAGE_ALLOC         0x000000004
-		FAULT_PAGE_GET           0x000000008
-		FAULT_ALLOC_BIO          0x000000010 (obsolete)
-		FAULT_ALLOC_NID          0x000000020
-		FAULT_ORPHAN             0x000000040
-		FAULT_BLOCK              0x000000080
-		FAULT_DIR_DEPTH          0x000000100
-		FAULT_EVICT_INODE        0x000000200
-		FAULT_TRUNCATE           0x000000400
-		FAULT_READ_IO            0x000000800
-		FAULT_CHECKPOINT         0x000001000
-		FAULT_DISCARD            0x000002000
-		FAULT_WRITE_IO           0x000004000
-		FAULT_SLAB_ALLOC         0x000008000
-		FAULT_DQUOT_INIT         0x000010000
-		FAULT_LOCK_OP            0x000020000
-		FAULT_BLKADDR            0x000040000
-		===================      ===========
+		===========================      ===========
+		Type_Name                        Type_Value
+		===========================      ===========
+		FAULT_KMALLOC                    0x000000001
+		FAULT_KVMALLOC                   0x000000002
+		FAULT_PAGE_ALLOC                 0x000000004
+		FAULT_PAGE_GET                   0x000000008
+		FAULT_ALLOC_BIO                  0x000000010 (obsolete)
+		FAULT_ALLOC_NID                  0x000000020
+		FAULT_ORPHAN                     0x000000040
+		FAULT_BLOCK                      0x000000080
+		FAULT_DIR_DEPTH                  0x000000100
+		FAULT_EVICT_INODE                0x000000200
+		FAULT_TRUNCATE                   0x000000400
+		FAULT_READ_IO                    0x000000800
+		FAULT_CHECKPOINT                 0x000001000
+		FAULT_DISCARD                    0x000002000
+		FAULT_WRITE_IO                   0x000004000
+		FAULT_SLAB_ALLOC                 0x000008000
+		FAULT_DQUOT_INIT                 0x000010000
+		FAULT_LOCK_OP                    0x000020000
+		FAULT_BLKADDR                    0x000040000
+		FAULT_BLKADDR_INCONSISTENCE      0x000080000
+		===========================      ===========
 
 What:		/sys/fs/f2fs/<disk>/discard_io_aware_gran
 Date:		January 2023
diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index d32c6209685d..b7c5c3f6df1c 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -184,29 +184,30 @@ fault_type=%d		 Support configuring fault injection type, should be
 			 enabled with fault_injection option, fault type value
 			 is shown below, it supports single or combined type.
 
-			 ===================	  ===========
-			 Type_Name		  Type_Value
-			 ===================	  ===========
-			 FAULT_KMALLOC		  0x000000001
-			 FAULT_KVMALLOC		  0x000000002
-			 FAULT_PAGE_ALLOC	  0x000000004
-			 FAULT_PAGE_GET		  0x000000008
-			 FAULT_ALLOC_BIO	  0x000000010 (obsolete)
-			 FAULT_ALLOC_NID	  0x000000020
-			 FAULT_ORPHAN		  0x000000040
-			 FAULT_BLOCK		  0x000000080
-			 FAULT_DIR_DEPTH	  0x000000100
-			 FAULT_EVICT_INODE	  0x000000200
-			 FAULT_TRUNCATE		  0x000000400
-			 FAULT_READ_IO		  0x000000800
-			 FAULT_CHECKPOINT	  0x000001000
-			 FAULT_DISCARD		  0x000002000
-			 FAULT_WRITE_IO		  0x000004000
-			 FAULT_SLAB_ALLOC	  0x000008000
-			 FAULT_DQUOT_INIT	  0x000010000
-			 FAULT_LOCK_OP		  0x000020000
-			 FAULT_BLKADDR		  0x000040000
-			 ===================	  ===========
+			 ===========================      ===========
+			 Type_Name                        Type_Value
+			 ===========================      ===========
+			 FAULT_KMALLOC                    0x000000001
+			 FAULT_KVMALLOC                   0x000000002
+			 FAULT_PAGE_ALLOC                 0x000000004
+			 FAULT_PAGE_GET                   0x000000008
+			 FAULT_ALLOC_BIO                  0x000000010 (obsolete)
+			 FAULT_ALLOC_NID                  0x000000020
+			 FAULT_ORPHAN                     0x000000040
+			 FAULT_BLOCK                      0x000000080
+			 FAULT_DIR_DEPTH                  0x000000100
+			 FAULT_EVICT_INODE                0x000000200
+			 FAULT_TRUNCATE                   0x000000400
+			 FAULT_READ_IO                    0x000000800
+			 FAULT_CHECKPOINT                 0x000001000
+			 FAULT_DISCARD                    0x000002000
+			 FAULT_WRITE_IO                   0x000004000
+			 FAULT_SLAB_ALLOC                 0x000008000
+			 FAULT_DQUOT_INIT                 0x000010000
+			 FAULT_LOCK_OP                    0x000020000
+			 FAULT_BLKADDR                    0x000040000
+			 FAULT_BLKADDR_INCONSISTENCE      0x000080000
+			 ===========================      ===========
 mode=%s			 Control block allocation mode which supports "adaptive"
 			 and "lfs". In "lfs" mode, there should be no random
 			 writes towards main area.
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index b0597a539fc5..84546f529cf0 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -170,12 +170,9 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
 	return exist;
 }
 
-bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
+static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 					block_t blkaddr, int type)
 {
-	if (time_to_inject(sbi, FAULT_BLKADDR))
-		return false;
-
 	switch (type) {
 	case META_NAT:
 		break;
@@ -230,6 +227,20 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 	return true;
 }
 
+bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
+					block_t blkaddr, int type)
+{
+	if (time_to_inject(sbi, FAULT_BLKADDR))
+		return false;
+	return __f2fs_is_valid_blkaddr(sbi, blkaddr, type);
+}
+
+bool f2fs_is_valid_blkaddr_raw(struct f2fs_sb_info *sbi,
+					block_t blkaddr, int type)
+{
+	return __f2fs_is_valid_blkaddr(sbi, blkaddr, type);
+}
+
 /*
  * Readahead CP/NAT/SIT/SSA/POR pages
  */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ab710bb6d8b3..e0acfec0558d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -61,6 +61,7 @@ enum {
 	FAULT_DQUOT_INIT,
 	FAULT_LOCK_OP,
 	FAULT_BLKADDR,
+	FAULT_BLKADDR_INCONSISTENCE,
 	FAULT_MAX,
 };
 
@@ -3768,6 +3769,8 @@ struct page *f2fs_get_meta_page_retry(struct f2fs_sb_info *sbi, pgoff_t index);
 struct page *f2fs_get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index);
 bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 					block_t blkaddr, int type);
+bool f2fs_is_valid_blkaddr_raw(struct f2fs_sb_info *sbi,
+					block_t blkaddr, int type);
 int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 			int type, bool sync);
 void f2fs_ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9f4e21b5916c..32a7a413584b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -590,9 +590,13 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		f2fs_set_data_blkaddr(dn, NULL_ADDR);
 
 		if (__is_valid_data_blkaddr(blkaddr)) {
-			if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
-					DATA_GENERIC_ENHANCE))
+			if (time_to_inject(sbi, FAULT_BLKADDR_INCONSISTENCE))
+				continue;
+			if (!f2fs_is_valid_blkaddr_raw(sbi, blkaddr,
+						DATA_GENERIC_ENHANCE)) {
+				f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 				continue;
+			}
 			if (compressed_cluster)
 				valid_blocks++;
 		}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 206d03c82d96..87a803f36a50 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -44,24 +44,25 @@ static struct kmem_cache *f2fs_inode_cachep;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 
 const char *f2fs_fault_name[FAULT_MAX] = {
-	[FAULT_KMALLOC]		= "kmalloc",
-	[FAULT_KVMALLOC]	= "kvmalloc",
-	[FAULT_PAGE_ALLOC]	= "page alloc",
-	[FAULT_PAGE_GET]	= "page get",
-	[FAULT_ALLOC_NID]	= "alloc nid",
-	[FAULT_ORPHAN]		= "orphan",
-	[FAULT_BLOCK]		= "no more block",
-	[FAULT_DIR_DEPTH]	= "too big dir depth",
-	[FAULT_EVICT_INODE]	= "evict_inode fail",
-	[FAULT_TRUNCATE]	= "truncate fail",
-	[FAULT_READ_IO]		= "read IO error",
-	[FAULT_CHECKPOINT]	= "checkpoint error",
-	[FAULT_DISCARD]		= "discard error",
-	[FAULT_WRITE_IO]	= "write IO error",
-	[FAULT_SLAB_ALLOC]	= "slab alloc",
-	[FAULT_DQUOT_INIT]	= "dquot initialize",
-	[FAULT_LOCK_OP]		= "lock_op",
-	[FAULT_BLKADDR]		= "invalid blkaddr",
+	[FAULT_KMALLOC]			= "kmalloc",
+	[FAULT_KVMALLOC]		= "kvmalloc",
+	[FAULT_PAGE_ALLOC]		= "page alloc",
+	[FAULT_PAGE_GET]		= "page get",
+	[FAULT_ALLOC_NID]		= "alloc nid",
+	[FAULT_ORPHAN]			= "orphan",
+	[FAULT_BLOCK]			= "no more block",
+	[FAULT_DIR_DEPTH]		= "too big dir depth",
+	[FAULT_EVICT_INODE]		= "evict_inode fail",
+	[FAULT_TRUNCATE]		= "truncate fail",
+	[FAULT_READ_IO]			= "read IO error",
+	[FAULT_CHECKPOINT]		= "checkpoint error",
+	[FAULT_DISCARD]			= "discard error",
+	[FAULT_WRITE_IO]		= "write IO error",
+	[FAULT_SLAB_ALLOC]		= "slab alloc",
+	[FAULT_DQUOT_INIT]		= "dquot initialize",
+	[FAULT_LOCK_OP]			= "lock_op",
+	[FAULT_BLKADDR]			= "invalid blkaddr",
+	[FAULT_BLKADDR_INCONSISTENCE]	= "inconsistent blkaddr",
 };
 
 void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
-- 
2.40.1



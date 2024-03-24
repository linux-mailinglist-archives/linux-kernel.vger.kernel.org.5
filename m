Return-Path: <linux-kernel+bounces-113838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94285888EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71131C2B34E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA9C202BAE;
	Sun, 24 Mar 2024 23:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/Vyuwse"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5512882C;
	Sun, 24 Mar 2024 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320876; cv=none; b=XjoicycLPugOHeKeyT773Lh302FOqkPrpiULwEqfx9yo9vtMUmOX85Cm16o5wNpwLct0WvtLSuEYBQ1IgiSB1LUkMbjRY8Wz1LNonDUuGUSe5EC6rTwEXKGxfAPeA9iH8eDHTFk19lb6y1s2DHcEhHqflvEtNy0hTbHV2K2PC8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320876; c=relaxed/simple;
	bh=ipvEHZgmnpnUCmUL6D8dIsK9zHv0+EhhVDE4rN0J0r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMMvXXGYiBMUXULfoGEN/8brG0NNdtjOY/5DNw4RRE7NNrzhNeD/6vVMp9s7hNKrAmCgyHYChTxnnxKjPUTJx+BhQeki0qRR+3gMp0jnGmP6F0nGt5Na2areJR8n9bhlrY+F+kx74e33JuuTgaS3edAefxPvbrem/2Wy0hYNjMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/Vyuwse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176D2C43390;
	Sun, 24 Mar 2024 22:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320875;
	bh=ipvEHZgmnpnUCmUL6D8dIsK9zHv0+EhhVDE4rN0J0r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/VyuwseMzohsBTSiyDIQTQLoXoXZl6hrCX2oG7pfOB5lxwYmPc5mOGhxD6zezh4D
	 Eb0KQ4dX7o6pTIPiutRF9tMbT89pT7z34Vf/zp345fmitAMHoyPLNBjE1B8qGxUozz
	 v6pB/OdYU/bUzhjfsdcxIRa2hVAcxhaup7a0r3eNzSxridNUBD/0NPfGXiuGOBITbV
	 DzAJyPJjP/U2PoMfwTqDPpWU7AeVilOdsierNjOQTLJrj9jfigxxsU2WLn91eU+ZfE
	 chu/M6rGdW51TqZuEXTHKpRzVA5utysYoGeE04zl+uXVvLBZ4fiqpy01oMxHQ3a05s
	 Hbyqtx8GruChg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 440/713] quota: Properly annotate i_dquot arrays with __rcu
Date: Sun, 24 Mar 2024 18:42:46 -0400
Message-ID: <20240324224720.1345309-441-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit ccb49011bb2ebfd66164dbf68c5bff48917bb5ef ]

Dquots pointed to from i_dquot arrays in inodes are protected by
dquot_srcu. Annotate them as such and change .get_dquots callback to
return properly annotated pointer to make sparse happy.

Fixes: b9ba6f94b238 ("quota: remove dqptr_sem")
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext2/ext2.h           | 2 +-
 fs/ext2/super.c          | 2 +-
 fs/ext4/ext4.h           | 2 +-
 fs/ext4/super.c          | 2 +-
 fs/f2fs/f2fs.h           | 2 +-
 fs/f2fs/super.c          | 2 +-
 fs/jfs/jfs_incore.h      | 2 +-
 fs/jfs/super.c           | 2 +-
 fs/ocfs2/inode.h         | 2 +-
 fs/ocfs2/super.c         | 2 +-
 fs/quota/dquot.c         | 3 +--
 fs/reiserfs/reiserfs.h   | 2 +-
 fs/reiserfs/super.c      | 2 +-
 include/linux/fs.h       | 2 +-
 include/linux/shmem_fs.h | 2 +-
 mm/shmem.c               | 2 +-
 16 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 677a9ad45dcb7..f38bdd46e4f77 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -674,7 +674,7 @@ struct ext2_inode_info {
 	struct inode	vfs_inode;
 	struct list_head i_orphan;	/* unlinked but open inodes */
 #ifdef CONFIG_QUOTA
-	struct dquot *i_dquot[MAXQUOTAS];
+	struct dquot __rcu *i_dquot[MAXQUOTAS];
 #endif
 };
 
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 01f9addc8b1f6..6d8587505cea3 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -320,7 +320,7 @@ static ssize_t ext2_quota_read(struct super_block *sb, int type, char *data, siz
 static ssize_t ext2_quota_write(struct super_block *sb, int type, const char *data, size_t len, loff_t off);
 static int ext2_quota_on(struct super_block *sb, int type, int format_id,
 			 const struct path *path);
-static struct dquot **ext2_get_dquots(struct inode *inode)
+static struct dquot __rcu **ext2_get_dquots(struct inode *inode)
 {
 	return EXT2_I(inode)->i_dquot;
 }
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a5d784872303d..3205d46bc9673 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1156,7 +1156,7 @@ struct ext4_inode_info {
 	tid_t i_datasync_tid;
 
 #ifdef CONFIG_QUOTA
-	struct dquot *i_dquot[MAXQUOTAS];
+	struct dquot __rcu *i_dquot[MAXQUOTAS];
 #endif
 
 	/* Precomputed uuid+inum+igen checksum for seeding inode checksums */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c5fcf377ab1fa..3f1fa5d182e24 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1600,7 +1600,7 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
 static int ext4_quota_enable(struct super_block *sb, int type, int format_id,
 			     unsigned int flags);
 
-static struct dquot **ext4_get_dquots(struct inode *inode)
+static struct dquot __rcu **ext4_get_dquots(struct inode *inode)
 {
 	return EXT4_I(inode)->i_dquot;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9043cedfa12ba..46ad7604a8b62 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -824,7 +824,7 @@ struct f2fs_inode_info {
 	spinlock_t i_size_lock;		/* protect last_disk_size */
 
 #ifdef CONFIG_QUOTA
-	struct dquot *i_dquot[MAXQUOTAS];
+	struct dquot __rcu *i_dquot[MAXQUOTAS];
 
 	/* quota space reservation, managed internally by quota code */
 	qsize_t i_reserved_quota;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5dfbc6b4c0ac8..b0d6a643c9ef1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2776,7 +2776,7 @@ int f2fs_dquot_initialize(struct inode *inode)
 	return dquot_initialize(inode);
 }
 
-static struct dquot **f2fs_get_dquots(struct inode *inode)
+static struct dquot __rcu **f2fs_get_dquots(struct inode *inode)
 {
 	return F2FS_I(inode)->i_dquot;
 }
diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index dd4264aa9bedd..10934f9a11be3 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -92,7 +92,7 @@ struct jfs_inode_info {
 		} link;
 	} u;
 #ifdef CONFIG_QUOTA
-	struct dquot *i_dquot[MAXQUOTAS];
+	struct dquot __rcu *i_dquot[MAXQUOTAS];
 #endif
 	u32 dev;	/* will die when we get wide dev_t */
 	struct inode	vfs_inode;
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 8d8e556bd6104..ff135a43b5b7b 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -824,7 +824,7 @@ static ssize_t jfs_quota_write(struct super_block *sb, int type,
 	return len - towrite;
 }
 
-static struct dquot **jfs_get_dquots(struct inode *inode)
+static struct dquot __rcu **jfs_get_dquots(struct inode *inode)
 {
 	return JFS_IP(inode)->i_dquot;
 }
diff --git a/fs/ocfs2/inode.h b/fs/ocfs2/inode.h
index 82b28fdacc7e9..accf03d4765ed 100644
--- a/fs/ocfs2/inode.h
+++ b/fs/ocfs2/inode.h
@@ -65,7 +65,7 @@ struct ocfs2_inode_info
 	tid_t i_sync_tid;
 	tid_t i_datasync_tid;
 
-	struct dquot *i_dquot[MAXQUOTAS];
+	struct dquot __rcu *i_dquot[MAXQUOTAS];
 };
 
 /*
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 6b906424902b4..1259fe02cd53b 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -122,7 +122,7 @@ static int ocfs2_susp_quotas(struct ocfs2_super *osb, int unsuspend);
 static int ocfs2_enable_quotas(struct ocfs2_super *osb);
 static void ocfs2_disable_quotas(struct ocfs2_super *osb);
 
-static struct dquot **ocfs2_get_dquots(struct inode *inode)
+static struct dquot __rcu **ocfs2_get_dquots(struct inode *inode)
 {
 	return OCFS2_I(inode)->i_dquot;
 }
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6509aae445582..6f2fa7889daf3 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1002,8 +1002,7 @@ EXPORT_SYMBOL(dqget);
 
 static inline struct dquot __rcu **i_dquot(struct inode *inode)
 {
-	/* Force __rcu for now until filesystems are fixed */
-	return (struct dquot __rcu **)inode->i_sb->s_op->get_dquots(inode);
+	return inode->i_sb->s_op->get_dquots(inode);
 }
 
 static int dqinit_needed(struct inode *inode, int type)
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 725667880e626..b65549164590c 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -97,7 +97,7 @@ struct reiserfs_inode_info {
 	struct rw_semaphore i_xattr_sem;
 #endif
 #ifdef CONFIG_QUOTA
-	struct dquot *i_dquot[MAXQUOTAS];
+	struct dquot __rcu *i_dquot[MAXQUOTAS];
 #endif
 
 	struct inode vfs_inode;
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 67b5510beded2..7b3d5aeb2a6fe 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -802,7 +802,7 @@ static ssize_t reiserfs_quota_write(struct super_block *, int, const char *,
 static ssize_t reiserfs_quota_read(struct super_block *, int, char *, size_t,
 				   loff_t);
 
-static struct dquot **reiserfs_get_dquots(struct inode *inode)
+static struct dquot __rcu **reiserfs_get_dquots(struct inode *inode)
 {
 	return REISERFS_I(inode)->i_dquot;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98c718b0fe532..3226a1d47be11 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2084,7 +2084,7 @@ struct super_operations {
 #ifdef CONFIG_QUOTA
 	ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
 	ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
-	struct dquot **(*get_dquots)(struct inode *);
+	struct dquot __rcu **(*get_dquots)(struct inode *);
 #endif
 	long (*nr_cached_objects)(struct super_block *,
 				  struct shrink_control *);
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 2caa6b86106aa..66828dfc6e74e 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -37,7 +37,7 @@ struct shmem_inode_info {
 	unsigned int		fsflags;	/* for FS_IOC_[SG]ETFLAGS */
 	atomic_t		stop_eviction;	/* hold when working on inode */
 #ifdef CONFIG_TMPFS_QUOTA
-	struct dquot		*i_dquot[MAXQUOTAS];
+	struct dquot __rcu	*i_dquot[MAXQUOTAS];
 #endif
 	struct inode		vfs_inode;
 };
diff --git a/mm/shmem.c b/mm/shmem.c
index 0d1ce70bce380..fb2daf89e2f2a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -310,7 +310,7 @@ static void shmem_disable_quotas(struct super_block *sb)
 		dquot_quota_off(sb, type);
 }
 
-static struct dquot **shmem_get_dquots(struct inode *inode)
+static struct dquot __rcu **shmem_get_dquots(struct inode *inode)
 {
 	return SHMEM_I(inode)->i_dquot;
 }
-- 
2.43.0



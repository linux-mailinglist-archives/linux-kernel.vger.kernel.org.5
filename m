Return-Path: <linux-kernel+bounces-114290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4D888899B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF051C2824E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F5325FF52;
	Sun, 24 Mar 2024 23:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNMF+VPa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C2C1ED0C0;
	Sun, 24 Mar 2024 23:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321664; cv=none; b=ZGNhooW4KtZiih5Acw+kGlLis2QEKgg3LADbjoQJw8JTRQgPvoEzj0ahkqmxtfFr2x+4ciiKV28tzvZXW9PB73UoFl42yMOvKTZy36zwi333z6n4VjrjvvUO+mmC8cM5bS6IJB2BMh3VOoiCqhsL03pzSvpClFfxn5lvfd3zq6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321664; c=relaxed/simple;
	bh=g+W1QxAEdQ3yhQmlzC2/Q0tViIFJ0cxxiIpwni2UyaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbjSm5sDeE2TiHfnGBSJP5SsK9NgfSbX8LLv55pxYzWq1HKxjhCHa+OCd9YYEpIEfZXNdPqQBLDrChqXZzrGm2yP34iUiLk2Ff+3/r3OeAyFmQg+r9wt3ZF8HzPNJ2eC69eqwNiNJCd1MhXedpXrcdvUx/avekYX79YgOXtIGfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNMF+VPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BA0C43394;
	Sun, 24 Mar 2024 23:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321663;
	bh=g+W1QxAEdQ3yhQmlzC2/Q0tViIFJ0cxxiIpwni2UyaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iNMF+VPab1uAz1J+qQEExcHypcj/upi94L/LGgWPCRcQN6IWx4e2LEUzoUq4VHP4v
	 2K7ebZF8sjUGqxtP8DXkIDwe5gx3BOGDPgJB5jjRIeE6xUGVDy5f0MV9wfQyUthHaP
	 o3BZKerAuLpkTNKyYDsMDw/AS2v9INaC6S3Sp8o+xMTimXLf2o8ynXroKp1gx+/Wvr
	 NVHI1E2EIicNsnIILAOnZ58E39vrh6+mEGtczndS4JqfhiXuxfJAz52AfGb4EIPPSE
	 XRo4wnf2U/+dUaRt0pNfjG/og+Q7bQSVf145FUYE2HyiAHpBn0Opf9bddmJsrBAtSH
	 HLp8nn5+bKc5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 393/638] quota: Properly annotate i_dquot arrays with __rcu
Date: Sun, 24 Mar 2024 18:57:10 -0400
Message-ID: <20240324230116.1348576-394-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 7fdd685c384d6..02255185d68ef 100644
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
index aaf3e3e88cb21..5bcf5623b46cc 100644
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
index cd4ccae1e28a1..7bbf0b9bdff23 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1146,7 +1146,7 @@ struct ext4_inode_info {
 	tid_t i_datasync_tid;
 
 #ifdef CONFIG_QUOTA
-	struct dquot *i_dquot[MAXQUOTAS];
+	struct dquot __rcu *i_dquot[MAXQUOTAS];
 #endif
 
 	/* Precomputed uuid+inum+igen checksum for seeding inode checksums */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d062383ea50ef..3ea4d8f11e7bb 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1593,7 +1593,7 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
 static int ext4_quota_enable(struct super_block *sb, int type, int format_id,
 			     unsigned int flags);
 
-static struct dquot **ext4_get_dquots(struct inode *inode)
+static struct dquot __rcu **ext4_get_dquots(struct inode *inode)
 {
 	return EXT4_I(inode)->i_dquot;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6d688e42d89c5..ac924c8226e3c 100644
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
index bc303a0522155..d0a659b906656 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2756,7 +2756,7 @@ int f2fs_dquot_initialize(struct inode *inode)
 	return dquot_initialize(inode);
 }
 
-static struct dquot **f2fs_get_dquots(struct inode *inode)
+static struct dquot __rcu **f2fs_get_dquots(struct inode *inode)
 {
 	return F2FS_I(inode)->i_dquot;
 }
diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index 721def69e732e..d3c35068cb761 100644
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
index 2e2f7f6d36a09..c4f565770d316 100644
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
index c6bd7ee20f009..7a2c9b153be6e 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1008,8 +1008,7 @@ EXPORT_SYMBOL(dqget);
 
 static inline struct dquot __rcu **i_dquot(struct inode *inode)
 {
-	/* Force __rcu for now until filesystems are fixed */
-	return (struct dquot __rcu **)inode->i_sb->s_op->get_dquots(inode);
+	return inode->i_sb->s_op->get_dquots(inode);
 }
 
 static int dqinit_needed(struct inode *inode, int type)
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 7d12b8c5b2fa8..e594ad8d759e2 100644
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
index 7eaf36b3de12b..309f9d39ba724 100644
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
index 62102f8697946..ee5efad0d7801 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2079,7 +2079,7 @@ struct super_operations {
 #ifdef CONFIG_QUOTA
 	ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
 	ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
-	struct dquot **(*get_dquots)(struct inode *);
+	struct dquot __rcu **(*get_dquots)(struct inode *);
 #endif
 	long (*nr_cached_objects)(struct super_block *,
 				  struct shrink_control *);
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 6b0c626620f5c..fa99e68e5e776 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -32,7 +32,7 @@ struct shmem_inode_info {
 	struct timespec64	i_crtime;	/* file creation time */
 	unsigned int		fsflags;	/* flags for FS_IOC_[SG]ETFLAGS */
 #ifdef CONFIG_TMPFS_QUOTA
-	struct dquot		*i_dquot[MAXQUOTAS];
+	struct dquot __rcu	*i_dquot[MAXQUOTAS];
 #endif
 	struct offset_ctx	dir_offsets;	/* stable entry offsets */
 	struct inode		vfs_inode;
diff --git a/mm/shmem.c b/mm/shmem.c
index e826be732b9bb..80c2666114b3e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -311,7 +311,7 @@ static void shmem_disable_quotas(struct super_block *sb)
 		dquot_quota_off(sb, type);
 }
 
-static struct dquot **shmem_get_dquots(struct inode *inode)
+static struct dquot __rcu **shmem_get_dquots(struct inode *inode)
 {
 	return SHMEM_I(inode)->i_dquot;
 }
-- 
2.43.0



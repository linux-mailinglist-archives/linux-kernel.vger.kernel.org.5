Return-Path: <linux-kernel+bounces-23195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F6A82A8E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4276E1C22238
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0372CE56B;
	Thu, 11 Jan 2024 08:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PutPWzbt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E092E545
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00909C433C7;
	Thu, 11 Jan 2024 08:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704961079;
	bh=6/KBhRJKvbOmR2LyqIZkaOwcwJm2RpzWRnpJUkpAL8I=;
	h=From:To:Cc:Subject:Date:From;
	b=PutPWzbtL476sPg8chP7RJKKWMAj+mYS2f7POak1nJalGkex+UvOwOUwJ7wGjIPZ+
	 HTTazRqMpZIg+5qs0a1ykErqMwRq2LN6nrVK2Tfp8td8le5913ErcR4VV/9PRKUkfH
	 tVGFe2xc57o64UYKfDwR2JcJ5q7mesWmu47yfPidp0FyibB0zYcSAiV0Di/YuLjcFM
	 YcxA7mU9a/tV3N0NmMPaAkc0a+piApu9/Dd6L+iGdjca1cYMK6CHzmyVx6ULUGoY5T
	 csAU/hTvog+6EBY3zGlivZYPtEMr/4yvpYroyjy92t/9TcKbc3/QfmKGLcIcyoVoVc
	 QSH2xjPnBH97w==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Yunlei He <heyunlei@hihonor.com>
Subject: [PATCH v3] f2fs: reduce expensive checkpoint trigger frequency
Date: Thu, 11 Jan 2024 16:17:43 +0800
Message-Id: <20240111081743.2999210-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We may trigger high frequent checkpoint for below case:
1. mkdir /mnt/dir1; set dir1 encrypted
2. touch /mnt/file1; fsync /mnt/file1
3. mkdir /mnt/dir2; set dir2 encrypted
4. touch /mnt/file2; fsync /mnt/file2
..

Although, newly created dir and file are not related, due to
commit bbf156f7afa7 ("f2fs: fix lost xattrs of directories"), we will
trigger checkpoint whenever fsync() comes after a new encrypted dir
created.

In order to avoid such condition, let's record an entry including
directory's ino into global cache when we initialize encryption policy
in a checkpointed directory, and then only trigger checkpoint() when
target file's parent has non-persisted encryption policy, for the case
its parent is not checkpointed, need_do_checkpoint() has cover that
by verifying it with f2fs_is_checkpointed_node().

Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reported-by: Yunlei He <heyunlei@hihonor.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- Recently, Zhiguo Niu reported the same issue, so I repost this
patch for comments.
 fs/f2fs/f2fs.h              |  2 ++
 fs/f2fs/file.c              |  3 +++
 fs/f2fs/xattr.c             | 16 ++++++++++++++--
 include/trace/events/f2fs.h |  3 ++-
 4 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e2e0ca45f881..0094a8c85f4a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -279,6 +279,7 @@ enum {
 	APPEND_INO,		/* for append ino list */
 	UPDATE_INO,		/* for update ino list */
 	TRANS_DIR_INO,		/* for transactions dir ino list */
+	ENC_DIR_INO,		/* for encrypted dir ino list */
 	FLUSH_INO,		/* for multiple device flushing */
 	MAX_INO_ENTRY,		/* max. list */
 };
@@ -1147,6 +1148,7 @@ enum cp_reason_type {
 	CP_FASTBOOT_MODE,
 	CP_SPEC_LOG_NUM,
 	CP_RECOVER_DIR,
+	CP_ENC_DIR,
 };
 
 enum iostat_type {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8198afb5fb9c..18b33b1f0c83 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -218,6 +218,9 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
 		f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
 							TRANS_DIR_INO))
 		cp_reason = CP_RECOVER_DIR;
+	else if (f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
+							ENC_DIR_INO))
+		cp_reason = CP_ENC_DIR;
 
 	return cp_reason;
 }
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index f290fe9327c4..cbd1b88297fe 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -629,6 +629,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 			const char *name, const void *value, size_t size,
 			struct page *ipage, int flags)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_xattr_entry *here, *last;
 	void *base_addr, *last_base_addr;
 	int found, newsize;
@@ -772,8 +773,19 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
 			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
 		f2fs_set_encrypted_inode(inode);
-	if (S_ISDIR(inode->i_mode))
-		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
+
+	if (S_ISDIR(inode->i_mode)) {
+		/*
+		 * In restrict mode, fsync() always tries triggering checkpoint
+		 * for all metadata consistency, in other mode, it only triggers
+		 * checkpoint when parent's encryption metadata updates.
+		 */
+		if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
+			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
+		else if (IS_ENCRYPTED(inode) &&
+			f2fs_is_checkpointed_node(sbi, inode->i_ino))
+			f2fs_add_ino_entry(sbi, inode->i_ino, ENC_DIR_INO);
+	}
 
 same:
 	if (is_inode_flag_set(inode, FI_ACL_MODE)) {
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 7ed0fc430dc6..48f2e399e184 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -139,7 +139,8 @@ TRACE_DEFINE_ENUM(EX_BLOCK_AGE);
 		{ CP_NODE_NEED_CP,	"node needs cp" },		\
 		{ CP_FASTBOOT_MODE,	"fastboot mode" },		\
 		{ CP_SPEC_LOG_NUM,	"log type is 2" },		\
-		{ CP_RECOVER_DIR,	"dir needs recovery" })
+		{ CP_RECOVER_DIR,	"dir needs recovery" },		\
+		{ CP_ENC_DIR,		"persist encryption policy" })
 
 #define show_shutdown_mode(type)					\
 	__print_symbolic(type,						\
-- 
2.40.1



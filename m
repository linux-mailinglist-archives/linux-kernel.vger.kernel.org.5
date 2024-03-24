Return-Path: <linux-kernel+bounces-112914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E0E887FB6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36C07B21CC9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EBF6CDCE;
	Sun, 24 Mar 2024 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm3vhMkV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789DB6CDAD;
	Sun, 24 Mar 2024 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319725; cv=none; b=g0f6s5KrdHygWNVLlZZ+XcY52DsX8mHdRkM3FqfB1aNBK6ModCUx6kjVnANgQaAP9kkcWgyoT226RtVVfGMVRXB7JsUJi7OyiHAyzPI8EOQsXkJL7o7w/5+YKVj5oXrvDFWK5AvkItNaNmuJfxJcBfLSMnAZR1/O3L/cg413Y7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319725; c=relaxed/simple;
	bh=fzaSZg1cousZPFs9g2V1Go91FbBqdlg74fePrxfpCrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZeTTEKGJV+yGsh0798W6T9hbWz1loFBBjJ16N/paqsIFsZ44hnhRlUoLQgF0Ss8LDyUerDmjyPzn0KUNUEWl7svLbnTY4bJqutyhw4PPqrfYXqyvTtgTzP8t4p5sOkvPQ/+NK8TkoDGMoTVkoS1dX1+GGhkWhDKRWeCsL2P+Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lm3vhMkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6F9C433A6;
	Sun, 24 Mar 2024 22:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319725;
	bh=fzaSZg1cousZPFs9g2V1Go91FbBqdlg74fePrxfpCrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lm3vhMkVizUdZ4fbGKTV0IkEWKJ9sCCCsTc26TA2YR2k/7APhETlzzWvjA3AMNGLA
	 myYdMMrzmd6g5z8ivQJIGcN8Ozu2rpTPeX/zh6+O7kvRVm+voWScGyWllhmnsJmGET
	 qYwJDCFAEoc7BNzG4bhzs6Q76t0E3JJa/VSAHDi2qqF+O6m+3g+TOK+IDYlpc9mblM
	 U1jGXbL2RVKmtllyc1Qmobj7eIOviAmtTF/U7d/Tm9j84zSZKF7ha1glPkKZsvYsT+
	 /FI7yKmqNrgZGKm7UlV5wLcBBmdzFKW2HbwWbIhfrffbeGlf2yYnjemWaIF1OE6FTz
	 9IcJK8FG/ejEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	Amir Goldstein <amir73il@gmail.com>,
	Eric Biggers <ebiggers@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 027/715] ovl: Always reject mounting over case-insensitive directories
Date: Sun, 24 Mar 2024 18:23:26 -0400
Message-ID: <20240324223455.1342824-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@suse.de>

[ Upstream commit 2824083db76cb9d4b7910607b367e93b02912865 ]

overlayfs relies on the filesystem setting DCACHE_OP_HASH or
DCACHE_OP_COMPARE to reject mounting over case-insensitive directories.

Since commit bb9cd9106b22 ("fscrypt: Have filesystems handle their
d_ops"), we set ->d_op through a hook in ->d_lookup, which
means the root dentry won't have them, causing the mount to accidentally
succeed.

In v6.7-rc7, the following sequence will succeed to mount, but any
dentry other than the root dentry will be a "weird" dentry to ovl and
fail with EREMOTE.

  mkfs.ext4 -O casefold lower.img
  mount -O loop lower.img lower
  mount -t overlay -o lowerdir=lower,upperdir=upper,workdir=work ovl /mnt

Mounting on a subdirectory fails, as expected, because DCACHE_OP_HASH
and DCACHE_OP_COMPARE are properly set by ->lookup.

Fix by explicitly rejecting superblocks that allow case-insensitive
dentries. Yes, this will be solved when we move d_op configuration back
to ->s_d_op. Yet, we better have an explicit fix to avoid messing up
again.

While there, re-sort the entries to have more descriptive error messages
first.

Fixes: bb9cd9106b22 ("fscrypt: Have filesystems handle their d_ops")
Acked-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20240221171412.10710-2-krisman@suse.de
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/params.c | 14 +++++++++++---
 include/linux/fs.h    |  9 +++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 112b4b12f8252..36dcc530ac286 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -280,12 +280,20 @@ static int ovl_mount_dir_check(struct fs_context *fc, const struct path *path,
 {
 	struct ovl_fs_context *ctx = fc->fs_private;
 
-	if (ovl_dentry_weird(path->dentry))
-		return invalfc(fc, "filesystem on %s not supported", name);
-
 	if (!d_is_dir(path->dentry))
 		return invalfc(fc, "%s is not a directory", name);
 
+	/*
+	 * Root dentries of case-insensitive capable filesystems might
+	 * not have the dentry operations set, but still be incompatible
+	 * with overlayfs.  Check explicitly to prevent post-mount
+	 * failures.
+	 */
+	if (sb_has_encoding(path->mnt->mnt_sb))
+		return invalfc(fc, "case-insensitive capable filesystem on %s not supported", name);
+
+	if (ovl_dentry_weird(path->dentry))
+		return invalfc(fc, "filesystem on %s not supported", name);
 
 	/*
 	 * Check whether upper path is read-only here to report failures
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1fbc72c5f112c..630468c005040 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3281,6 +3281,15 @@ extern int generic_check_addressable(unsigned, u64);
 
 extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
 
+static inline bool sb_has_encoding(const struct super_block *sb)
+{
+#if IS_ENABLED(CONFIG_UNICODE)
+	return !!sb->s_encoding;
+#else
+	return false;
+#endif
+}
+
 int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		unsigned int ia_valid);
 int setattr_prepare(struct mnt_idmap *, struct dentry *, struct iattr *);
-- 
2.43.0



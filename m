Return-Path: <linux-kernel+bounces-115355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BACC7889DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCAA1B29E82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6EE1EC4D7;
	Mon, 25 Mar 2024 02:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIqyzooz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D23E1422BE;
	Sun, 24 Mar 2024 22:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320545; cv=none; b=WeiAxAz/lfF35PEBgxWbN6jeT1fsmbmJcBnYlzCGF6v9e2a7zVwLLofWp9TGP+3w2UNcXtCHIEUgj7VjQO9KSfzHUJchwmkrb/cGOp8B02E4Xur2DluwvrIYKziMV2sqtLhST1aqSBIo8uo139dYWcwJd4lK9ylf0m/mASPWGM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320545; c=relaxed/simple;
	bh=TqbdMatSwzqhA9SLehDS7UjFj034MU3eHyuNpAN4Ps8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZjY8PYFsLmm+Kd/TwrwXe8CYBcSqUEwhbrr1z1aGRq0VRer7bI96zYI88jbbryMHsjpYg24xbkL0ZoUpD+9k14LA3Zr75yS4O0rC8pabXElZ8QVRKqYJGqc+s/FE6LTRLeEORO+JwSn0tNNihQquvOVRZG3ScCBFrZ0WILZJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIqyzooz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531E9C433F1;
	Sun, 24 Mar 2024 22:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320544;
	bh=TqbdMatSwzqhA9SLehDS7UjFj034MU3eHyuNpAN4Ps8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RIqyzoozJ25rN2HeXZWkW9kxregwj9EFm2XxP2BrpmXA4/jG5P0LD370+mxgrtkqi
	 VWbCgXZNZMFGSHa9urvHXGa/MWYjkp4SRCDo6zvxkOfll/1jGTWu6kP0QqgC/1gG3o
	 BKzL7OPyzg1kXJEPNdHLofmKJJqlf4rgh+f+d05u2ebNeENUSFibwS42NKbmuh3jJ8
	 E/tWhhTEVocuh+n04X2t8WwZBJHRVLam7TGg6p5zIfmRRb511gykSk5Tj794RenFtC
	 6+eEtMCJZHNEb3/wDuoi+Ayht9elqakrgSiQT8NpccZXPKs2EWHUq18JXIaKpGHMi9
	 WI8AuRWmf6ZDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	Amir Goldstein <amir73il@gmail.com>,
	Eric Biggers <ebiggers@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 105/713] ovl: Always reject mounting over case-insensitive directories
Date: Sun, 24 Mar 2024 18:37:11 -0400
Message-ID: <20240324224720.1345309-106-sashal@kernel.org>
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
index 3fe2dde1598f9..488f920f79d28 100644
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
index 7f659c26794b5..98c718b0fe532 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3205,6 +3205,15 @@ extern int generic_check_addressable(unsigned, u64);
 
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



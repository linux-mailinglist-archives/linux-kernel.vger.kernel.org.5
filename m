Return-Path: <linux-kernel+bounces-115753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8389F889763
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A3C1C30C97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CBA2609C2;
	Mon, 25 Mar 2024 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzbtkIab"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121DC225210;
	Sun, 24 Mar 2024 23:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321942; cv=none; b=SHVfY7bY0yG1G0AvZDRuVyMxkszdYBbBM62sW0aaE0QA8uy1MOYEV7UYBdSBzb5GWcIzIFq9d8SXGIbXeKosEpn3qB06QrqhsMsxcx/4GmI2TJh15Aoa0y9AH97oYkaPjF1crEl95Qt7RNwmtO+uuJNxr2a0P47eAv7zZ5Vxenc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321942; c=relaxed/simple;
	bh=IT1oZa5OGwdXicshCtsdRQQIl/JSaxxPgyxUULrydB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Huszxyvqz3QtH62iWPTdMjQ5V61zqoBqKKSQBMYFmU5eGRlc5dCa0dTkBUaYQjCKGuzqViNkIrUltlQuUiMwkm6hITdNux/k+yC3akVSNHvGNXZ+J87mXrIyVvbuvcIhLvsogIzlLikuVMo7c1ERH/FKCr18tuhWW98qlB29SwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzbtkIab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C3BC433A6;
	Sun, 24 Mar 2024 23:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321941;
	bh=IT1oZa5OGwdXicshCtsdRQQIl/JSaxxPgyxUULrydB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WzbtkIab2ynh+yTXt+mJ3g3sPx3zHz3iUwTrU/BP6tiHkXa535xkYfR1cuk5JngVa
	 9CtaWjJ703NZneoZ4TMNehmQ7Cq9Gahep2om0wdiyYVWNHjb93VqAejm/K+So53qHg
	 tUEK5K2XHmHyo3Ai+X0xRdD5jUELxOz441SCr6Q/oeZ1PLMGcB+iCevCPuKWb7mikB
	 cJgeAwKS4KXeyF6sXdAVu4qvW/rmccKTPVO05pqO6yEdr4ej6FYUrw6SpbIX3Tl8tx
	 N5q6pNqp9khuajLvnl58KPkLBfi+MvNrKB3m1F4wJ5VK5ah7Twdkwx6J9Unp6VaFOh
	 Jv2SYy0a67xeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 013/451] nfsd: allow reaping files still under writeback
Date: Sun, 24 Mar 2024 19:04:49 -0400
Message-ID: <20240324231207.1351418-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit dcb779fcd4ed5984ad15991d574943d12a8693d1 ]

On most filesystems, there is no reason to delay reaping an nfsd_file
just because its underlying inode is still under writeback. nfsd just
relies on client activity or the local flusher threads to do writeback.

The main exception is NFS, which flushes all of its dirty data on last
close. Add a new EXPORT_OP_FLUSH_ON_CLOSE flag to allow filesystems to
signal that they do this, and only skip closing files under writeback on
such filesystems.

Also, remove a redundant NULL file pointer check in
nfsd_file_check_writeback, and clean up nfs's export op flag
definitions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
[ cel: adjusted to apply to v6.1.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/export.c          |  9 ++++++---
 fs/nfsd/filecache.c      | 12 +++++++++++-
 include/linux/exportfs.h |  1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 01596f2d0a1ed..9fe9586a51b71 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -156,7 +156,10 @@ const struct export_operations nfs_export_ops = {
 	.fh_to_dentry = nfs_fh_to_dentry,
 	.get_parent = nfs_get_parent,
 	.fetch_iversion = nfs_fetch_iversion,
-	.flags = EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
-		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS|
-		EXPORT_OP_NOATOMIC_ATTR,
+	.flags = EXPORT_OP_NOWCC		|
+		 EXPORT_OP_NOSUBTREECHK		|
+		 EXPORT_OP_CLOSE_BEFORE_UNLINK	|
+		 EXPORT_OP_REMOTE_FS		|
+		 EXPORT_OP_NOATOMIC_ATTR	|
+		 EXPORT_OP_FLUSH_ON_CLOSE,
 };
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 9b7082fdd2115..a6fa6e9802772 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -402,13 +402,23 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
 	struct file *file = nf->nf_file;
 	struct address_space *mapping;
 
-	if (!file || !(file->f_mode & FMODE_WRITE))
+	/* File not open for write? */
+	if (!(file->f_mode & FMODE_WRITE))
 		return false;
+
+	/*
+	 * Some filesystems (e.g. NFS) flush all dirty data on close.
+	 * On others, there is no need to wait for writeback.
+	 */
+	if (!(file_inode(file)->i_sb->s_export_op->flags & EXPORT_OP_FLUSH_ON_CLOSE))
+		return false;
+
 	mapping = file->f_mapping;
 	return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
 }
 
+
 static bool nfsd_file_lru_add(struct nfsd_file *nf)
 {
 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index fe848901fcc3a..218fc5c54e901 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -221,6 +221,7 @@ struct export_operations {
 #define EXPORT_OP_NOATOMIC_ATTR		(0x10) /* Filesystem cannot supply
 						  atomic attribute updates
 						*/
+#define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
 	unsigned long	flags;
 };
 
-- 
2.43.0



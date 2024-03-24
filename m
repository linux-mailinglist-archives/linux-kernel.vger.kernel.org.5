Return-Path: <linux-kernel+bounces-116009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5C588981C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AE62B29199
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BB517AF8E;
	Mon, 25 Mar 2024 03:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDnV4c3N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53C8273DB6;
	Sun, 24 Mar 2024 23:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323332; cv=none; b=KHL7Ra1mCEUe32317uUg0w7OHukA1Q29YfyL1gLxWIT9ccLFcj0aCraYAGImjeWvl/CWKYbI7d2jV2zZbxwAmvEd1kXSs6v6mETNGI4e/xqI2jJz6DlTQ3votTP8LZAazmiewEsbAfR1ywYK654fnfD6Hd3eI+2I7tlUIoSArwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323332; c=relaxed/simple;
	bh=eUZICQioZQV/iRn1btSkWf+yBXugr7Vk+ogZZoY/RBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdGm5dDcrqpcjhZAPc3LgY17ntJOKlarlMGxmsevO+WL7dZifKtIou9Pk/qDOdmU6z0N7sp5M+z8RTS6YYYj9Mr78iT3jLyQb5mCl8ewSVdfwOPs5AzMy02LWtanQqWE+ViAMa4yGEzTwA/wgKmdaP18GzsI3fuevghS6Lgc1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDnV4c3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1EEC433C7;
	Sun, 24 Mar 2024 23:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323331;
	bh=eUZICQioZQV/iRn1btSkWf+yBXugr7Vk+ogZZoY/RBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MDnV4c3N1TYaadDC5v9kzxvEZjq1K/NLksmOvG9xKek440c2KGc7DlWe1GGyWGn2b
	 Dooc89APsPuUI66RmycPTgk9V8czdAX8ExwjxHmFcdUi3NViX3EIGmsNWGX7NRGMRT
	 Gs74x8CJNsyIxEQDEVaKH7u+bGPDTC6UhFa2qwdFbLudvENUHMMHec2woEJ2eVcAEY
	 A7aSNNC0ZgV0ZbIM934EHrGM5XvIc+B9Q1/3SADKX8ncNeE/phyjoBUNZY8C2iyShg
	 ddHQ6/sil/M3WwWXut+DeY9TgM0/uCw1NjCyZVueOHW/yfCujmbCYP3I5WwcWGgW3+
	 Yq5raFLFkXSBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 032/317] f2fs: implement iomap operations
Date: Sun, 24 Mar 2024 19:30:12 -0400
Message-ID: <20240324233458.1352854-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 1517c1a7a4456f080fabc4ac9853930e4b880d14 ]

Implement 'struct iomap_ops' for f2fs, in preparation for making f2fs
use iomap for direct I/O.

Note that this may be used for other things besides direct I/O in the
future; however, for now I've only tested it for direct I/O.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: ec16b147a55b ("fs: Fix rw_hint validation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/Kconfig |  1 +
 fs/f2fs/data.c  | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h  |  1 +
 3 files changed, 58 insertions(+)

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 7eea3cfd894d1..f46a7339d6cf7 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -7,6 +7,7 @@ config F2FS_FS
 	select CRYPTO_CRC32
 	select F2FS_FS_XATTR if FS_ENCRYPTION
 	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
+	select FS_IOMAP
 	select LZ4_COMPRESS if F2FS_FS_LZ4
 	select LZ4_DECOMPRESS if F2FS_FS_LZ4
 	select LZ4HC_COMPRESS if F2FS_FS_LZ4HC
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 73a7906a49b1e..5766a9f0773b1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -21,6 +21,7 @@
 #include <linux/cleancache.h>
 #include <linux/sched/signal.h>
 #include <linux/fiemap.h>
+#include <linux/iomap.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -4242,3 +4243,58 @@ void f2fs_destroy_bio_entry_cache(void)
 {
 	kmem_cache_destroy(bio_entry_slab);
 }
+
+static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+			    unsigned int flags, struct iomap *iomap,
+			    struct iomap *srcmap)
+{
+	struct f2fs_map_blocks map = {};
+	pgoff_t next_pgofs = 0;
+	int err;
+
+	map.m_lblk = bytes_to_blks(inode, offset);
+	map.m_len = bytes_to_blks(inode, offset + length - 1) - map.m_lblk + 1;
+	map.m_next_pgofs = &next_pgofs;
+	map.m_seg_type = f2fs_rw_hint_to_seg_type(inode->i_write_hint);
+	if (flags & IOMAP_WRITE)
+		map.m_may_create = true;
+
+	err = f2fs_map_blocks(inode, &map, flags & IOMAP_WRITE,
+			      F2FS_GET_BLOCK_DIO);
+	if (err)
+		return err;
+
+	iomap->offset = blks_to_bytes(inode, map.m_lblk);
+
+	if (map.m_flags & (F2FS_MAP_MAPPED | F2FS_MAP_UNWRITTEN)) {
+		iomap->length = blks_to_bytes(inode, map.m_len);
+		if (map.m_flags & F2FS_MAP_MAPPED) {
+			iomap->type = IOMAP_MAPPED;
+			iomap->flags |= IOMAP_F_MERGED;
+		} else {
+			iomap->type = IOMAP_UNWRITTEN;
+		}
+		if (WARN_ON_ONCE(!__is_valid_data_blkaddr(map.m_pblk)))
+			return -EINVAL;
+
+		iomap->bdev = map.m_bdev;
+		iomap->addr = blks_to_bytes(inode, map.m_pblk);
+	} else {
+		iomap->length = blks_to_bytes(inode, next_pgofs) -
+				iomap->offset;
+		iomap->type = IOMAP_HOLE;
+		iomap->addr = IOMAP_NULL_ADDR;
+	}
+
+	if (map.m_flags & F2FS_MAP_NEW)
+		iomap->flags |= IOMAP_F_NEW;
+	if ((inode->i_state & I_DIRTY_DATASYNC) ||
+	    offset + length > i_size_read(inode))
+		iomap->flags |= IOMAP_F_DIRTY;
+
+	return 0;
+}
+
+const struct iomap_ops f2fs_iomap_ops = {
+	.iomap_begin	= f2fs_iomap_begin,
+};
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 835ef98643bd4..4cabc37c20b90 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3650,6 +3650,7 @@ int f2fs_init_post_read_processing(void);
 void f2fs_destroy_post_read_processing(void);
 int f2fs_init_post_read_wq(struct f2fs_sb_info *sbi);
 void f2fs_destroy_post_read_wq(struct f2fs_sb_info *sbi);
+extern const struct iomap_ops f2fs_iomap_ops;
 
 /*
  * gc.c
-- 
2.43.0



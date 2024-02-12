Return-Path: <linux-kernel+bounces-61934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 862338518A1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C48A2817E9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC0A3D0B4;
	Mon, 12 Feb 2024 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5xdMN8S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1EF3CF7C;
	Mon, 12 Feb 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753947; cv=none; b=Ll8sEDlvBoAd+htlwcFM0wKxvoSwD7HkdUPXSh05as3qpSw4n8gP8iqdqgaO3+t3UQHphwEgbIuaTtHpbN251MdWslZuULx288WaeQRv1cXSyqucqse6dSxQe6HI8i8EVUpekIn3U5kmWJLEft5Ejsu42NGUCiGB4TaDnFC914E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753947; c=relaxed/simple;
	bh=PVnetzBOH34x39uT5RM+QQRj/93uXMs1sWHwvNANQ6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gk+sp0NWqrqJxR5Osj3lv0OCnKMo0KNtyeJDgLjM7kqLWtmNusYOoUkv4KxfOhHW4GsRqW1qzW8lscXk4/X+iOlOZ6HuUYv/rHRTRKJ4QP172x9WJw3Nm/Qfy+fH1Y/jZDTKGQ1GvjKeJl1uOkkHPv/KH5u9+I41gQ4WJ63epv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5xdMN8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBDAC433F1;
	Mon, 12 Feb 2024 16:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707753947;
	bh=PVnetzBOH34x39uT5RM+QQRj/93uXMs1sWHwvNANQ6o=;
	h=From:To:Cc:Subject:Date:From;
	b=H5xdMN8SecoFM2W/G3J7KfIOpJOnULuNUcgoL/oKLg+ZvqYE8eBBWyT7L0b4BgeEA
	 r6Mg4hTrtKolVsF88U6R0kRFAYAFOIp8pZTkobZGOnTBdxWy/yVkCDJC3AoJ9g/Q+E
	 e4hyC3eaXDryq0JjXntd5Tc4YZjfAUQSP6foWOBRcK/8vj96RXPdlaomFK7fimemr8
	 emUcBjiaJeJgLwJs8dteLhJUMMfqO4QHR02erWvns5fg99wVhGblS77HQGgKCG6Z4+
	 5KIeItZ6PxyG5kjQUbwpx7kJx3SDjb3tPCATr93wm7q+0j05rJSnibgGlbnsTZtyT9
	 VvRpHhLWmYG+g==
From: Chao Yu <chao@kernel.org>
To: stable@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Sheng Yong <shengyong@oppo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.1] f2fs: add helper to check compression level
Date: Tue, 13 Feb 2024 00:05:30 +0800
Message-Id: <20240212160530.1017205-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sheng Yong <shengyong@oppo.com>

commit c571fbb5b59a3741e48014faa92c2f14bc59fe50 upstream.

This patch adds a helper function to check if compression level is
valid.

Meanwhile, this patch fixes a reported issue [1]:

The issue is easily reproducible by:

1. dd if=/dev/zero of=test.img count=100 bs=1M
2. mkfs.f2fs -f -O compression,extra_attr ./test.img
3. mount -t f2fs -o compress_algorithm=zstd:6,compress_chksum,atgc,gc_merge,lazytime ./test.img /mnt

resulting in

[   60.789982] F2FS-fs (loop0): invalid zstd compress level: 6

A bugzilla report has been submitted in
https://bugzilla.kernel.org/show_bug.cgi?id=218471

[1] https://lore.kernel.org/lkml/ZcWDOjKEnPDxZ0Or@google.com/T/

The root cause is commit 00e120b5e4b5 ("f2fs: assign default compression
level") tries to check low boundary of compress level w/ zstd_min_clevel(),
however, since commit e0c1b49f5b67 ("lib: zstd: Upgrade to latest upstream
zstd version 1.4.10"), zstd supports negative compress level, it cast type
for negative value returned from zstd_min_clevel() to unsigned int in below
check condition, result in repored issue.

	if (level < zstd_min_clevel() || ...

This patch fixes this issue by casting type for level to int before
comparison.

Fixes: 00e120b5e4b5 ("f2fs: assign default compression level")
Signed-off-by: Sheng Yong <shengyong@oppo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 27 +++++++++++++++++++++++++++
 fs/f2fs/f2fs.h     |  2 ++
 fs/f2fs/super.c    |  4 ++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 4cb58e8d699e..4e83cfa1b073 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -55,6 +55,7 @@ struct f2fs_compress_ops {
 	int (*init_decompress_ctx)(struct decompress_io_ctx *dic);
 	void (*destroy_decompress_ctx)(struct decompress_io_ctx *dic);
 	int (*decompress_pages)(struct decompress_io_ctx *dic);
+	bool (*is_level_valid)(int level);
 };
 
 static unsigned int offset_in_cluster(struct compress_ctx *cc, pgoff_t index)
@@ -322,11 +323,21 @@ static int lz4_decompress_pages(struct decompress_io_ctx *dic)
 	return 0;
 }
 
+static bool lz4_is_level_valid(int lvl)
+{
+#ifdef CONFIG_F2FS_FS_LZ4HC
+	return !lvl || (lvl >= LZ4HC_MIN_CLEVEL && lvl <= LZ4HC_MAX_CLEVEL);
+#else
+	return lvl == 0;
+#endif
+}
+
 static const struct f2fs_compress_ops f2fs_lz4_ops = {
 	.init_compress_ctx	= lz4_init_compress_ctx,
 	.destroy_compress_ctx	= lz4_destroy_compress_ctx,
 	.compress_pages		= lz4_compress_pages,
 	.decompress_pages	= lz4_decompress_pages,
+	.is_level_valid		= lz4_is_level_valid,
 };
 #endif
 
@@ -490,6 +501,11 @@ static int zstd_decompress_pages(struct decompress_io_ctx *dic)
 	return 0;
 }
 
+static bool zstd_is_level_valid(int lvl)
+{
+	return lvl >= zstd_min_clevel() && lvl <= zstd_max_clevel();
+}
+
 static const struct f2fs_compress_ops f2fs_zstd_ops = {
 	.init_compress_ctx	= zstd_init_compress_ctx,
 	.destroy_compress_ctx	= zstd_destroy_compress_ctx,
@@ -497,6 +513,7 @@ static const struct f2fs_compress_ops f2fs_zstd_ops = {
 	.init_decompress_ctx	= zstd_init_decompress_ctx,
 	.destroy_decompress_ctx	= zstd_destroy_decompress_ctx,
 	.decompress_pages	= zstd_decompress_pages,
+	.is_level_valid		= zstd_is_level_valid,
 };
 #endif
 
@@ -555,6 +572,16 @@ bool f2fs_is_compress_backend_ready(struct inode *inode)
 	return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
 }
 
+bool f2fs_is_compress_level_valid(int alg, int lvl)
+{
+	const struct f2fs_compress_ops *cops = f2fs_cops[alg];
+
+	if (cops->is_level_valid)
+		return cops->is_level_valid(lvl);
+
+	return lvl == 0;
+}
+
 static mempool_t *compress_page_pool;
 static int num_compress_pages = 512;
 module_param(num_compress_pages, uint, 0444);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5c76ba764b71..e5a9498b89c0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4219,6 +4219,7 @@ bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
 int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock);
 void f2fs_compress_write_end_io(struct bio *bio, struct page *page);
 bool f2fs_is_compress_backend_ready(struct inode *inode);
+bool f2fs_is_compress_level_valid(int alg, int lvl);
 int f2fs_init_compress_mempool(void);
 void f2fs_destroy_compress_mempool(void);
 void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task);
@@ -4283,6 +4284,7 @@ static inline bool f2fs_is_compress_backend_ready(struct inode *inode)
 	/* not support compression */
 	return false;
 }
+static inline bool f2fs_is_compress_level_valid(int alg, int lvl) { return false; }
 static inline struct page *f2fs_compress_control_page(struct page *page)
 {
 	WARN_ON_ONCE(1);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3805162dcef2..0c0d0671febe 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -628,7 +628,7 @@ static int f2fs_set_lz4hc_level(struct f2fs_sb_info *sbi, const char *str)
 	if (kstrtouint(str + 1, 10, &level))
 		return -EINVAL;
 
-	if (level < LZ4HC_MIN_CLEVEL || level > LZ4HC_MAX_CLEVEL) {
+	if (!f2fs_is_compress_level_valid(COMPRESS_LZ4, level)) {
 		f2fs_info(sbi, "invalid lz4hc compress level: %d", level);
 		return -EINVAL;
 	}
@@ -666,7 +666,7 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 	if (kstrtouint(str + 1, 10, &level))
 		return -EINVAL;
 
-	if (level < zstd_min_clevel() || level > zstd_max_clevel()) {
+	if (!f2fs_is_compress_level_valid(COMPRESS_ZSTD, level)) {
 		f2fs_info(sbi, "invalid zstd compress level: %d", level);
 		return -EINVAL;
 	}
-- 
2.40.1


